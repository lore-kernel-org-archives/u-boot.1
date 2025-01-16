Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CAFC02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 13:11:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42BDE80214;
	Thu, 16 Jan 2025 14:11:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="hMeHZcUj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEA4180283; Thu, 16 Jan 2025 14:11:47 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02F7C801B0
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 14:11:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ddrokosov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 3EA4310000C;
 Thu, 16 Jan 2025 16:11:42 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 3EA4310000C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1737033102;
 bh=Thqc2XjSURQQNvLzocDSiIj9T+rvm/BgwbR3EjS/UX8=;
 h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
 b=hMeHZcUjt7HTB6TNgZ0CEZ0Z2oUGYKKvZ8GAANp6q7Dt5fA8Z1ImDdFUhdd0stlBt
 wFjMm4rAmm4wT9z8dO3Fb8Zk6uaGzk+iM5ZZgZsEYSp9YYpIMlGpBRPKOWSidzk1LX
 OQQdzHAMc48rNi2kn6Eqw0pyV0bkXoz1oqcIbBjYhwFUQ2jejVMcQlo1eDLSJi4O4d
 8yPjDqb7DI9m8/3JlvDzRkKhePTYt1+IRfXMoUanwuqq8WSjDff1R4HXqnkpCO05Cp
 9E1505YKybQWlbOZ0nLux+IKBrFJ2lrquuxnsUip5uMnZRMJ6FEijxv29CutYrDolD
 sti2A0hRFMZnA==
Received: from smtp.sberdevices.ru (p-i-exch-a-m1.sberdevices.ru
 [172.24.196.116])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu, 16 Jan 2025 16:11:42 +0300 (MSK)
Date: Thu, 16 Jan 2025 16:11:40 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
CC: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Tim Harvey
 <tharvey@gateworks.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Sam Protsenko <semen.protsenko@linaro.org>,
 Devarsh Thakkar <devarsht@ti.com>, <u-boot@lists.denx.de>,
 <kernel@salutedevices.com>, <rockosov@gmail.com>
Subject: Re: [PATCH 3/3] common: fdt: hand over original fdt bootargs into
 board chosen handler
Message-ID: <yfy4lf54tndnnr4cfttfqngaklv5sg3ttwpycwu2on33vvjg2z@2ptnm3mjusfv>
References: <20241220-board_fdt_chosen_bootargs_improvements-v1-0-f6a7181787c5@salutedevices.com>
 <20241220-board_fdt_chosen_bootargs_improvements-v1-3-f6a7181787c5@salutedevices.com>
 <2d821f40-b52a-44f0-8dc1-5d9ec2992993@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2d821f40-b52a-44f0-8dc1-5d9ec2992993@cherry.de>
User-Agent: NeoMutt/20241212
X-Originating-IP: [172.28.162.51]
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 190375 [Jan 16 2025]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 49 0.3.49
 28b3b64a43732373258a371bd1554adb2caa23cb, {Track_E25351},
 {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;
 smtp.sberdevices.ru:7.1.1,5.0.1; 127.0.0.199:7.1.2;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2025/01/16 10:48:00 #27040539
X-KSMG-AntiVirus-Status: Clean, skipped
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

Hello Quentin,

On Tue, Jan 14, 2025 at 12:16:35PM +0100, Quentin Schulz wrote:
> Hi Dmitry,
> 
> On 12/19/24 10:42 PM, Dmitry Rokosov wrote:
> > Sometimes, it is necessary to provide an additional bootargs string to
> > the kernel command line.
> > 
> > We have a real scenario where one U-Boot blob needs to boot several
> > kernel images: the vendor-patched kernel image and the latest upstream
> > kernel image. The Amlogic (Meson architecture) tty driver has different
> > tty suffixes in these kernels: the vendor uses 'ttySx', while the
> > upstream implementation uses 'ttyAMLx'. The initial console setup is
> > provided to the kernel using the kernel command line (bootargs). For the
> > vendor kernel, we should use 'console=ttyS0,115200', while for the
> > upstream kernel, it must be 'console=ttyAML0,115200'. This means we have
> > to use different command line strings depending on the kernel version.
> > 
> 
> Can't you have both in bootargs to handle both versions of the kernel with
> the same bootargs?
> 

In this case, modifying the kernel source code is necessary, which falls
outside the scope of this review.

> > To resolve this issue, we cannot use the CMDLINE_EXTEND kernel
> > configuration because it is considered legacy and is not supported for
> > the arm64 architecture. CMDLINE_EXTEND is outdated primarily because we
> > can provide additional command line strings through the
> > 'chosen/bootargs' FDT node. However, U-Boot uses this node to inject the
> > U-Boot bootargs environment variable content, which results in U-Boot
> > silently overriding all data in the 'chosen/bootargs' node. While we do
> > have the board_fdt_chosen_bootargs() board hook to address such issues,
> > this function lacks any FDT context, such as the original value of the
> > 'chosen/bootargs' node.
> > 
> > This patch introduces a read-only (RO) fdt_property argument to
> > board_fdt_chosen_bootargs() to share the original 'chosen/bootargs' data
> > with the board code. Consequently, the board developer can decide how to
> > handle this information for their board setup: whether to drop it or
> > merge it with the bootargs environment.
> > 
> > Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> > ---
> >   boot/fdt_support.c    | 5 +++--
> >   include/fdt_support.h | 4 +++-
> >   2 files changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> > index 2c39b2dd14b7c447bc4c7c8fad64e22cb00e88e0..49efeec3681f7c97341ccdce596bcaa4e1f037eb 100644
> > --- a/boot/fdt_support.c
> > +++ b/boot/fdt_support.c
> > @@ -321,7 +321,7 @@ int fdt_kaslrseed(void *fdt, bool overwrite)
> >    * board_fdt_chosen_bootargs - boards may override this function to use
> >    *                             alternative kernel command line arguments
> >    */
> > -__weak const char *board_fdt_chosen_bootargs(void)
> > +__weak const char *board_fdt_chosen_bootargs(const struct fdt_property *fdt_ba)
> >   {
> >   	return env_get("bootargs");
> >   }
> > @@ -364,7 +364,8 @@ int fdt_chosen(void *fdt)
> >   		}
> >   	}
> > -	str = board_fdt_chosen_bootargs();
> > +	str = board_fdt_chosen_bootargs(fdt_get_property(fdt, nodeoffset,
> > +							 "bootargs", NULL));
> >   	if (str) {
> >   		err = fdt_setprop(fdt, nodeoffset, "bootargs", str,
> > diff --git a/include/fdt_support.h b/include/fdt_support.h
> > index f481881ce640797e0f6204d599f008d0e5dc2bf7..7731feba5f068f82c8ee25f18a9f0e57729e2bd8 100644
> > --- a/include/fdt_support.h
> > +++ b/include/fdt_support.h
> > @@ -231,12 +231,14 @@ int board_rng_seed(struct abuf *buf);
> >   /**
> >    * board_fdt_chosen_bootargs() - arbitrarily amend fdt kernel command line
> >    *
> > + * @fdt_ba: FDT chosen/bootargs from the kernel image if available
> > + *
> 
> Missing leading /
> 
> /chosen/bootargs
> 
> +property
> to highlight what this path refers to.
> 

Agree with that, but looks like patch series is already applied...
Sorry..

> Makes sense to me otherwise!
> 
> With those changes,
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Thanks!
> Quentin

-- 
Thank you,
Dmitry
