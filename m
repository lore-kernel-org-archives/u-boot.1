Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C4AAC5B543
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 14:30:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC7F18091A;
	Thu,  5 Jun 2025 16:30:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="QPG5bJJB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98B9081FEE; Thu,  5 Jun 2025 16:30:17 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CEC480050
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 16:30:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 4840E25BB6;
 Thu,  5 Jun 2025 16:30:15 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OOoiP4Hp9lwV; Thu,  5 Jun 2025 16:30:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1749133814; bh=OUlfHbpMMf9h2s4u27JwUSmr/YUsFWnl/zxFXPeNi6g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=QPG5bJJBZe/rRX/OvBg04oOukm3uAFBjb2LpQEsiqdR4eYhfjS35K66OHxdxotifE
 SZGfdRRKtwJpEwPqMlt05JrpZdSURCMAQxnH7HXZovjZWTfWFNxLK89vh4VIOPHyLe
 ZdJzdMSbs65EkhnegkEQlmxkFESXUMHAjV7KGFiHA51pwQCu3X34lU1CabC9BMxq1g
 9sJhRQ5pLBF0rDL4GN+qovJqKXqGWVBLAm+iEoqaJnHaQNPnYQgjiE3cdef/zpw/Vq
 Y/4XYDeUpM61GWdfPlcrxQOWk6rcNtrtt5L30RU49uHrMnXmhKTWpeneuudTWoUIi3
 93SU8e8wcgGqQ==
Date: Thu, 5 Jun 2025 14:29:52 +0000
From: Yao Zi <ziyao@disroot.org>
To: =?utf-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Rick Chen <rick@andestech.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRD?= =?utf-8?Q?H=5D_bootm?=
 =?utf-8?Q?=3A?= Pass SMP core ID and DTB address for ELF-formatted kernels
Message-ID: <aEGp4KEprzOSyOF8@pie.lan>
References: <ME0P300MB13096732AF44AC5409B9D0D49F96A@ME0P300MB1309.AUSP300.PROD.OUTLOOK.COM>
 <CAFLszTgpYgVfrf4P189tcNM7xOvoiVjMu_sP1nrP+FGfAYHYSw@mail.gmail.com>
 <28BD711D-9449-46DA-AD38-8142B0CAF7AB@gmx.de>
 <20250523222926.GZ100073@bill-the-cat>
 <fbe649de-dc78-4ef3-8204-95020ff2cf45@gmx.de>
 <SY3PPF5E5ED63A94E67F10470722CA5B3529F66A@SY3PPF5E5ED63A9.AUSP300.PROD.OUTLOOK.COM>
 <20250529154923.GL100073@bill-the-cat>
 <ME0P300MB13099B02B4C316E4784D23529F6FA@ME0P300MB1309.AUSP300.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ME0P300MB13099B02B4C316E4784D23529F6FA@ME0P300MB1309.AUSP300.PROD.OUTLOOK.COM>
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

On Thu, Jun 05, 2025 at 08:04:28AM +0000, 牛 志宏 wrote:
> Yes, this is a new OS currently being developed with plans to support Linux compatibility.
> Registers a0 and a1 pass the boot core ID and DTB address respectively, following a de facto standard shared by both the SBI (RISC-V Supervisor Binary Interface) specification and the Linux implementation.
> My rationale is: if U-Boot supports the combination of kernel + ELF loading, why shouldn't we implement this capability as well?

Do you mean passing arguments according to the convention of Linux even
when booting ELF stuff?

TBH, it should be easy to turn your ELF into an Linux-style Image...

> 
> ________________________________
> 发件人: Tom Rini
> 已发送: 2025 年 5 月 29 日 星期四 23:49
> 收件人: 牛 志宏
> 抄送: Heinrich Schuchardt; Simon Glass; u-boot@lists.denx.de; Leo Yu-Chi Liang; Rick Chen
> 主题: Re: 回复: [PATCH] bootm: Pass SMP core ID and DTB address for ELF-formatted kernels
> 
> On Thu, May 29, 2025 at 09:33:56AM +0000, 牛 志宏 wrote:
> > hi team,
> >
> > The ITS file looks something like the following, and the kernel is not a standard Linux kernel:
> > ```
> > /dts-v1/;
> >
> > / {
> >     ...
> >     images {
> >         kernel {
> >             type = "kernel";
> >             arch = "riscv";
> >             os = "elf";
> >             ...
> >         };
> >
> >         fdt {
> >             type = "flat_dt";
> >             arch = "riscv";
> >             ...
> >         };
> >     };
> >     ...
> > };
> > ```
> >
> > To handle this scenario, we need to:
> >
> >   1.
> > Access the values of the `type`, os, and arch fields stored in bootm_headers->image_info to determine the current context.
> >   2.
> > Access the boot_hart and ft_addr stored in the gd variable to update argc and argv.
> >
> > Not sure whether accessing the bootm_headers and gd variables in lib/elf.c is allowed or safe.
> So this is why I was asking if there's some more generalized
> specification we can reference. Is the OS you're using something
> pre-existing and so we need to do what it already expect from some other
> loader? Or is it something you're also creating and if so, why not
> follow the linux kernel convention for compatibility?
> 
> --
> Tom

Regards,
Yao Zi
