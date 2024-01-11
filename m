Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02019C47258
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 17:04:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F25587756;
	Thu, 11 Jan 2024 18:04:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="z693jCDk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64C6787620; Thu, 11 Jan 2024 18:04:32 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 302088785F
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 18:04:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 0AF272233D;
 Thu, 11 Jan 2024 18:04:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1704992668;
 bh=26dNqidS44cOEu6eiTxI2OG+ORa682V5ds7fS1RUy0Q=; h=From:To:Subject;
 b=z693jCDkp19qEL71HnCF4vVEjzWi6uN0vDn5ABdvAqs+2O8uNClnpiPPbBwL4Tbuy
 6FLoKhs35SVFyWmXS3kEXM7peWXn35jlQHvb0dB6YjLay9yW7x3S6VlzCeV/fB9f7t
 sTmj0JIaIMls1ceck4S/EMLWpwV0kIEowYmn8yDIrtF+nguc6+9yI2TBpdMZTxyFQr
 DUw4GBS94fjnn63WO1SCeRDzQfzvCN+/mWw1UFswnRnrYvDRgZefCc7GaY9yKJzqH7
 pFGjH0jneZNaPQ1QtWPum8+Z9UfdzIUYbBh4SvfCXGqGEA5nUNggGEN4bymwFwhZGN
 I12NA5ql0G7fA==
Date: Thu, 11 Jan 2024 18:04:18 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Francis Laniel <francis.laniel@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v13 00/24] Modernize U-Boot shell
Message-ID: <20240111170418.GA7220@francesco-nb>
References: <20231222210244.91830-1-francis.laniel@amarulasolutions.com>
 <170379713946.899302.2054678070497875668.b4-ty@konsulko.com>
 <5740853.DvuYhMxLoT@pwmachine>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5740853.DvuYhMxLoT@pwmachine>
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Tom, Francis

On Fri, Dec 29, 2023 at 07:55:37PM +0100, Francis Laniel wrote:
> Le jeudi 28 décembre 2023, 21:58:59 CET Tom Rini a écrit :
> > On Fri, 22 Dec 2023 22:02:20 +0100, Francis Laniel wrote:
> > > During 2021 summer, Sean Anderson wrote a contribution to add a new shell,
> > > based on LIL, to U-Boot [1, 2].
> > > While one of the goals of this contribution was to address the fact actual
> > > U-Boot shell, which is based on Busybox hush, is old there was a
> > > discussion
> > > about adding a new shell versus updating the actual one [3, 4].
> > > 
> > > So, in this series, with Harald Seiler, we updated the actual U-Boot shell
> > > to reflect what is currently in Busybox source code.
> > > Basically, this contribution is about taking a snapshot of Busybox
> > > shell/hush.c file (as it exists in commit 37460f5da) and adapt it to suit
> > > U-Boot needs.
> > > 
> > > [...]
> > 
> > Applied to u-boot/next, thanks!
> 
> Thank you for the merge!
> If there is any problem, do not hesitate to mail me and I will take care of 
> it!

This change, specifically setting the modern hush shell as default, is
breaking our boot script, just noticed since the current U-Boot master
has a regression for us.

We still need to figure out the exact details, here [1] you can find the
boot script (that has some placeholder that is replaced during build).

and the error is something like:

```
## Executing script at 90280000
Loading DeviceTree: k3-am625-verdin-nonwifi-dev.dtb
69025 bytes read in 11 ms (6 MiB/s)
82 bytes read in 9 ms (8.8 KiB/s)
Working FDT set to 90200000
syntax error at 'done'HUSH died!
resetting ...
```

that I _assume_ comes from this line

    env set set_apply_overlays 'env set apply_overlays "for overlay_file in \\${fdt_overlays}; do echo Applying Overlay: \\${overlay_file} && ${load_cmd} \\${loadaddr} \\${overlays_prefix}\\${overlay_file} && fdt apply \\${loadaddr}; env set overlay_file; done; true"'

[1] https://git.toradex.com/cgit/meta-toradex-bsp-common.git/tree/recipes-bsp/u-boot/u-boot-distro-boot/boot.cmd.in

Francesco

