Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63ADFE668BB
	for <u-boot@archiver.kernel.org>; Sat, 20 Dec 2025 23:44:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6EE983935;
	Sun, 21 Dec 2025 00:43:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mHEmLZqC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68152803F5; Sat, 20 Dec 2025 17:48:16 +0100 (CET)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1EB280050
 for <u-boot@lists.denx.de>; Sat, 20 Dec 2025 17:48:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7b6dd81e2d4so2913486b3a.0
 for <u-boot@lists.denx.de>; Sat, 20 Dec 2025 08:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766249291; x=1766854091; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2Zl0i5A1RWRecgeLvL7zLaMhSAddCUhcwLGQbqIIVzo=;
 b=mHEmLZqCHlCur+75P/J4Tej5b/eSShYM7WHWkx8Bk+iFJ60l9x14iTRHYq1VRWLxol
 qfYaQqu35USCvev4gWZ4xfyVZIp6zlPbMmyT1ukBiBvaHvIhdNB2v039hmZu0xoN8Nnc
 4VaMQIOgJO9p3ZR0vw0g3ymetrnE5zqFSI2QLVfA9+2LCJYbauVFgHMK+L7+Fw4IuF2h
 ge5/elxcCfBZ1F0Mte7ltNi06REygDJQCVESWITJ2xlKulmf5Ip8I2/chHDLqKRgH5mK
 5M7qhYd/MAgxZRJq0kliP8qtgiOnPUlsp4VNLbguGscojI+W+opL/1keS3GgJpwu1jme
 lneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766249291; x=1766854091;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Zl0i5A1RWRecgeLvL7zLaMhSAddCUhcwLGQbqIIVzo=;
 b=sC5GWNabcGjK+caoXnHLIPFbZ/vlLnIDoT9Z6wZjNdMmOwcGA1eoHgY5dyiC6i5ifM
 h39MOayXsxSjgUBsSlp84F1xwiAxZp4V1fy6QwUhEg8bkrctaxXLI09qY8SUHth/Jsy6
 u5kZI2lcc26mDeO8P5hdTmK6CeR3TjvTLM8vybiyPXNZRA5f5r4H+4j5SMvGQZgHyWb1
 IoLGf4uN0UzF/D3GHGHRgfhe/HGZeDWUFW2RgkOilfETWwloB7vlP1eoL/H/DHuYRNmk
 kqU/ZeXKuCyGEGzhEr9zhs+KDB+Lc+hSIAa3L037/EoQ5XrAey+7VuoPITZ1Ix4KxWu0
 Hrig==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/YE3KWFcLMG4WeRvGW6iXm5L49nWQre7ESrRvG25oF9TSfTGN861vVwyoGT3uk0w3DhYa6uw=@lists.denx.de
X-Gm-Message-State: AOJu0Ywn9+uGKzY3lqALbup3Aed5lVJ/+byl6x5am04MASmbWhPcVRke
 nCMSfSybFeCnBcuapgNtDtSkS/7voBWMWpQY0rUx5XB41hestig6M+CvB7BuzQ==
X-Gm-Gg: AY/fxX5BfXXZvbhIvpxYHm0Iq9dcQG7mrbmI7Sa90BSH5t2VVev/fDiJZpYdCsXC2kt
 AJj6PSRun4wrmQU/nFUU5Qd9o647WBQlWHuI0+xysJzs5cnYUxebI16cO+inpEPs4/r6dG6iUsE
 azcXAKqFCC89OMvEfAcrGeHVZHtpvjIklGAcDYpkHoTBoFBJdcQYhmDIEwNeAEn4nXIlMaMz4ZK
 AXI6lm4KpUhYhiY1yXerGknMDpK+cqMclInFo9WERqqlbTm84nWuHHD2/zvXUNIitiYs2gMeoQC
 f28jgmefg1qORdnrWm6kbrVT6oprIavL7LXZW5tENUdtB6FS0G7diJcOHFJyHLpf5Yhg2BnLQIA
 x8PEWs+JgehYUzZImu7ROeYNFogvaDI6LRlzG+NxAHts/XAoPXIhEYrYp3O46PJIt9TMVrHdaCR
 QpdgNE2wpxZVrziPB1v3R5dO8=
X-Google-Smtp-Source: AGHT+IF+IcbZQiw1V2g7Pc6TLO9cae7kRo/8dTVFbNbWmx9A3Vb35X4wCMbqoAaXrYhKMfHaB6I6Bw==
X-Received: by 2002:a05:6a00:e12:b0:7f6:2b06:7134 with SMTP id
 d2e1a72fcca58-7ff66175a58mr5902843b3a.32.1766249291002; 
 Sat, 20 Dec 2025 08:48:11 -0800 (PST)
Received: from google.com ([2402:7500:499:de94:15e:4c73:9b28:3ab7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e588a30sm5669977b3a.55.2025.12.20.08.48.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Dec 2025 08:48:10 -0800 (PST)
Date: Sun, 21 Dec 2025 00:48:07 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: alison.wang@nxp.com, angelo@kernel-space.org, jserv@ccns.ncku.edu.tw,
 eleanor15x@gmail.com, u-boot@lists.denx.de
Subject: Re: [PATCH 3/3] board: Add QEMU m68k virt board support
Message-ID: <aUbTR-3HyU9-CONS@google.com>
References: <20251218185252.957388-1-visitorckw@gmail.com>
 <20251218185252.957388-4-visitorckw@gmail.com>
 <20251218190415.GN303283@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218190415.GN303283@bill-the-cat>
X-Mailman-Approved-At: Sun, 21 Dec 2025 00:43:30 +0100
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

Hi Tom,

On Thu, Dec 18, 2025 at 01:04:15PM -0600, Tom Rini wrote:
> On Thu, Dec 18, 2025 at 06:52:52PM +0000, Kuan-Wei Chiu wrote:
> 
> > Add support for the QEMU 'virt' machine on the m68k architecture. This
> > board emulates a generic machine based on the Motorola 68040 CPU
> > equipped with Goldfish virtual peripherals.
> > 
> > Introduce the necessary board configuration and initialization
> > infrastructure. The implementation includes logic to parse the QEMU
> > bootinfo interface, enabling dynamic detection of system RAM size to
> > adapt to the virtual machine's configuration.
> > 
> > Enable the Goldfish TTY driver to provide a serial console, which
> > facilitates interaction when running QEMU with the -nographic option.
> > Additionally, include comprehensive documentation covering build
> > instructions and usage examples to guide users in deploying U-Boot
> > within the virtualization environment.
> > 
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> [snip]
> > diff --git a/board/emulation/qemu-m68k/MAINTAINERS b/board/emulation/qemu-m68k/MAINTAINERS
> > new file mode 100644
> > index 00000000000..c2f4cc40a56
> > --- /dev/null
> > +++ b/board/emulation/qemu-m68k/MAINTAINERS
> > @@ -0,0 +1,10 @@
> > +QEMU M68K VIRT BOARD
> > +M:  Kuan-Wei Chiu <visitorckw@gmail.com>
> > +S:  Maintained
> > +F:  board/emulation/qemu-m68k/
> > +F:  board/emulation/common/
> > +F:  include/configs/qemu-m68k.h
> > +F:  configs/qemu-m68k_defconfig
> > +F:  arch/m68k/cpu/m68040/
> > +F:  arch/m68k/include/asm/bootinfo.h
> > +F:  doc/board/emulation/qemu-m68k.rst
> 
> There was Kconfig spacing issues here as well, but also MAINTAINERS
> files are usually tab not spaces. But if get_maintainer.pl is fine, OK.

Will convert them to tabs in v2.

> 
> > diff --git a/configs/qemu-m68k_defconfig b/configs/qemu-m68k_defconfig
> > new file mode 100644
> > index 00000000000..765ed9b7424
> > --- /dev/null
> > +++ b/configs/qemu-m68k_defconfig
> > @@ -0,0 +1,17 @@
> > +CONFIG_M68K=y
> > +CONFIG_TARGET_QEMU_M68K=y
> > +CONFIG_TEXT_BASE=0x00000000
> > +CONFIG_SYS_LOAD_ADDR=0x00000000
> > +CONFIG_SYS_MONITOR_LEN=262144
> > +CONFIG_SYS_BOOTM_LEN=0x1000000
> > +CONFIG_SYS_MALLOC_LEN=0x20000
> > +# CONFIG_DISPLAY_BOARDINFO is not set
> > +CONFIG_BAUDRATE=115200
> > +
> > +# CONFIG_OF_CONTROL is not set
> 
> This wasn't made with "make savedefconfig" and needs to be, please
> generate it that way.

Will rectify that in v2.

> 
> > diff --git a/doc/board/emulation/qemu-m68k.rst b/doc/board/emulation/qemu-m68k.rst
> > new file mode 100644
> > index 00000000000..19898e17cfc
> > --- /dev/null
> > +++ b/doc/board/emulation/qemu-m68k.rst
> > @@ -0,0 +1,38 @@
> > +.. SPDX-License-Identifier: GPL-2.0+
> > +.. Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
> 
> Docs are good, thank you. But it needs to update the index.rst file too
> to be included and also not trigger CI failure when building docs.

Sorry for missing that. I will fix it in v2 and ensure the docs build
successfully before respinning.

Regards,
Kuan-Wei
