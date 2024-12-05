Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF4FE7716C
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 09:41:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 930E38934C;
	Thu,  5 Dec 2024 10:41:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="E3LM/HfX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 644938919B; Thu,  5 Dec 2024 10:41:48 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59D9589440
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 10:41:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ee51c5f000so531036a91.0
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 01:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1733391703; x=1733996503;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=45wZkAlo0LDBzG9YP3v1FQ6jAG7RdgIFAGvr6tJhO7c=;
 b=E3LM/HfXtmFGDEW/oWZmFrWoNRx3c+j7t04tmJ1SqqtDvXXW8GJXMBUmGZdqf+Ty6Y
 rEQ+2ddKtv4iXs+HVAtodYgVsCoDjh0nqfVNJejQGskACuV+cfOlIod8RHctx0Ea+mVs
 AW1KYMs5RKEn/0mWJSau2fbF7e65AXVC80ceg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733391703; x=1733996503;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=45wZkAlo0LDBzG9YP3v1FQ6jAG7RdgIFAGvr6tJhO7c=;
 b=Helzz47U7hc3rojakCfrk91CJF8teIabDPd9LUCe/j9SE1LDqEve0OenU7suNTDymv
 rt7RFs7HjdUe61fEHVEQ7Mkn5JFbPU5IIoieo2KLPYdMrX2YWFaAnu77YyjXy4cmRBDN
 kIqu85zfKyE+j+rYcuuyUPOVtlPm9ws2DOCnZxeTdEaOqu2Of0r+V4ak558Wb0psMPzt
 wmX13LYudXYC4jiC4Yr+cI2jl1GVc7I/VsxuW1YpukqcGUTVcpTJeHS0X4XCi+1j3cYP
 DoZsW5FyfhCkTHjyTXzBStw14wZ1ohlL+AK/v6IF2L/jWTUlhB97lxxJ6jHsAuTz6lAq
 9P/A==
X-Gm-Message-State: AOJu0YyAHuHlCMQ/N3WJAsSVdD5MxwpYdaHdaQbD1flsX/tzp+rq5AYI
 peKPfjFlXSNtDWmVyVk2RsaKvHSQcEhHfr2FH4BFH9+ta3LRywGw6/seMARTaVE94qT+I1/nmRE
 1N9kqstM00NhEmRY2fJKurkYUw3SX2tGaJxyQOeu4P0fJSHVV
X-Gm-Gg: ASbGnctVtN1xg7rPODsE/44/15CHXKMAqs4VTjzyAwUVXSSI456p+0jM9Fh4TPMldeq
 hTRMHIO1bSTwPct/1RanUhmsQ2hZYRjDhBlFVmt/4TtRW8AaAEfsv6Hn90pseP3a0sFw=
X-Google-Smtp-Source: AGHT+IHeu/IIJ/6rcTmkksMFERSveWjETE5DjCe8pgLyeidftpB9Zjq2ZngkLjfGURZ63QrsYzPxPWOs9/RaL4550Lw=
X-Received: by 2002:a17:90b:17c9:b0:2ee:6e22:bfd0 with SMTP id
 98e67ed59e1d1-2ef1ce997f8mr9548675a91.21.1733391702753; Thu, 05 Dec 2024
 01:41:42 -0800 (PST)
MIME-Version: 1.0
References: <20241205092315.25060-1-dinesh.maniyam@intel.com>
 <20241205092315.25060-15-dinesh.maniyam@intel.com>
 <BL1PR11MB53660F0C5BE89BE5CEE5FBA982302@BL1PR11MB5366.namprd11.prod.outlook.com>
In-Reply-To: <BL1PR11MB53660F0C5BE89BE5CEE5FBA982302@BL1PR11MB5366.namprd11.prod.outlook.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 5 Dec 2024 10:41:17 +0100
Message-ID: <CAOf5uwk102CGq243krXHOjLkSFwPq7RPH8wdWk5Arg5SEaGFtg@mail.gmail.com>
Subject: Re: [resend v2 14/19] configs: nand2_defconfig: Enable configs for
 nand boot
To: "Maniyam, Dinesh" <dinesh.maniyam@intel.com>
Cc: U-Boot-Denx <u-boot@lists.denx.de>, Marek <marex@denx.de>, 
 Simon <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Johan Jonker <jbx6244@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, 
 Alexander Dahl <ada@thorsis.com>, William Zhang <william.zhang@broadcom.com>, 
 Igor Prusov <ivprusov@salutedevices.com>, "Meng,
 Tingting" <tingting.meng@intel.com>, 
 "Chee, Tien Fong" <tien.fong.chee@intel.com>, "Hea,
 Kok Kiang" <kok.kiang.hea@intel.com>, 
 "Ng, Boon Khai" <boon.khai.ng@intel.com>, 
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>, 
 "Zamri, Muhammad Hazim Izzat" <muhammad.hazim.izzat.zamri@intel.com>, 
 "Lim, Jit Loon" <jit.loon.lim@intel.com>, "Tang,
 Sieu Mun" <sieu.mun.tang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi

Il gio 5 dic 2024, 10:36 Maniyam, Dinesh <dinesh.maniyam@intel.com> ha
scritto:

>
>
> > -----Original Message-----
> > From: Maniyam, Dinesh <dinesh.maniyam@intel.com>
> > Sent: Thursday, 5 December 2024 5:23 pm
> > To: u-boot@lists.denx.de
> > Cc: Marek <marex@denx.de>; Simon <simon.k.r.goldschmidt@gmail.com>; Tom
> > Rini <trini@konsulko.com>; Dario Binacchi
> > <dario.binacchi@amarulasolutions.com>; Michael Trimarchi
> > <michael@amarulasolutions.com>; Johan Jonker <jbx6244@gmail.com>; Michal
> > Simek <michal.simek@amd.com>; Arseniy Krasnov
> > <avkrasnov@salutedevices.com>; Alexander Dahl <ada@thorsis.com>; William
> > Zhang <william.zhang@broadcom.com>; Igor Prusov
> > <ivprusov@salutedevices.com>; Meng, Tingting <tingting.meng@intel.com>;
> > Chee, Tien Fong <tien.fong.chee@intel.com>; Hea, Kok Kiang
> > <kok.kiang.hea@intel.com>; Maniyam, Dinesh <dinesh.maniyam@intel.com>;
> > Ng, Boon Khai <boon.khai.ng@intel.com>; Yuslaimi, Alif Zakuan
> > <alif.zakuan.yuslaimi@intel.com>; Zamri, Muhammad Hazim Izzat
> > <muhammad.hazim.izzat.zamri@intel.com>; Lim, Jit Loon
> > <jit.loon.lim@intel.com>; Tang, Sieu Mun <sieu.mun.tang@intel.com>
> > Subject: [resend v2 14/19] configs: nand2_defconfig: Enable configs for
> nand boot
> >
> > From: Dinesh Maniyam <dinesh.maniyam@intel.com>
> >
> > Enable configs for nand boot.
> >
> > Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
> >
> > ---
> > v2:
> > - remove the "this patch is to" commit phrases
> > - using #include mechanism to keep track of the variant
> > - add maintainer
> > ---
> > ---
> >  board/intel/agilex5-socdk/MAINTAINERS   |  2 ++
> >  configs/socfpga_agilex5_nand2_defconfig | 33 +++++++++++++++++++++++++
> >  2 files changed, 35 insertions(+)
> >  create mode 100644 configs/socfpga_agilex5_nand2_defconfig
> >
> > diff --git a/board/intel/agilex5-socdk/MAINTAINERS b/board/intel/agilex5-
> > socdk/MAINTAINERS
> > index b696f788c8..30d8815d20 100644
> > --- a/board/intel/agilex5-socdk/MAINTAINERS
> > +++ b/board/intel/agilex5-socdk/MAINTAINERS
> > @@ -2,7 +2,9 @@ SOCFPGA BOARD
> >  M:   Tien Fong Chee <tien.fong.chee@intel.com>
> >  M:   Teik Heng Chong <teik.heng.chong@intel.com>
> >  M:   Jit Loon Lim <jit.loon.lim@intel.com>
> > +M:   Dinesh Maniyam <dinesh.maniyam@intel.com>
> >  S:   Maintained
> >  F:   board/intel/agilex5-socdk/
> >  F:   include/configs/socfpga_agilex5_socdk.h
> >  F:   configs/socfpga_agilex5_defconfig
> > +F:   configs/socfpga_agilex5_nand2_defconfig
> > diff --git a/configs/socfpga_agilex5_nand2_defconfig
> > b/configs/socfpga_agilex5_nand2_defconfig
> > new file mode 100644
> > index 0000000000..3bfe6270fd
> > --- /dev/null
> > +++ b/configs/socfpga_agilex5_nand2_defconfig
> > @@ -0,0 +1,33 @@
> > +#include <configs/socfpga_agilex5_defconfig>
> > +
> > +CONFIG_ARM=y
> > +CONFIG_ARCH_SOCFPGA=y
> > +CONFIG_DEFAULT_DEVICE_TREE="socfpga_agilex5_socdk"
> > +CONFIG_OF_UPSTREAM=y
> > +CONFIG_BOOTARGS="earlycon panic=-1 root=${nandroot} rw rootwait
> > rootfstype=ubifs ubi.mtd=1"
> > +CONFIG_TARGET_SOCFPGA_AGILEX5_NAND2=y
> > +CONFIG_PHY_CADENCE_COMBOPHY=n
> > +CONFIG_SPL_PHY_CADENCE_COMBOPHY=n
> > +# CONFIG_MMC_DW is not set
> > +CONFIG_SPL_MTD=y
> > +CONFIG_CMD_NAND_TRIMFFS=y
> > +CONFIG_CMD_NAND_LOCK_UNLOCK=y
> > +CONFIG_SPL_MTD_SUPPORT=y
> > +CONFIG_MTDIDS_DEFAULT="nand0=10b80000.nand.0"
> > +CONFIG_MTDPARTS_DEFAULT="mtdparts=10b80000.nand.0:2m(u-boot),-
> > (root)"
> > +CONFIG_CMD_UBIFS=y
> > +CONFIG_MTD_UBI=y
> > +CONFIG_MTD_UBI_WL_THRESHOLD=4096
> > +CONFIG_MTD_UBI_BEB_LIMIT=20
> > +CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
> > +CONFIG_SYS_NAND_U_BOOT_OFFS=0x0
> > +CONFIG_SYS_NAND_U_BOOT_OFFS_REDUND=0x100000
> > +CONFIG_UBI_SILENCE_MSG=y
> > +CONFIG_MTD_RAW_NAND=y
> > +CONFIG_NAND_CADENCE=y
> > +CONFIG_SPL_NAND_SUPPORT=y
> > +CONFIG_SPL_NAND_FRAMEWORK=y
> > +CONFIG_SPL_NAND_CADENCE=y
> > +CONFIG_SYS_NAND_ONFI_DETECTION=y
> > +CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
> > +CONFIG_SYS_NAND_PAGE_SIZE=0x800
> > --
> > 2.19.0
>
> Hi Michael,
>
> Please guide me through the process to run the CI in github.
>

I will do it for you and send some instructions today.

Sorry for delay. I was busy ;)

Michael

>
> Thanks.
>
