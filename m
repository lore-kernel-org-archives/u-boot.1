Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5096BCCF9F8
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 22:33:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3CF1838A5;
	Mon,  3 Nov 2025 23:33:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eAwh5bBv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EABD3838CE; Mon,  3 Nov 2025 23:33:14 +0100 (CET)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com
 [209.85.210.46])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA5038144A
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 23:33:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-f46.google.com with SMTP id
 46e09a7af769-7c29466eabaso1300925a34.0
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 14:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762209186; x=1762813986; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=al58R8FyPwiPRYcaTuIMlThOPXAeHdhyb6sOn3pN7sI=;
 b=eAwh5bBvAeFwCGe0qn57V60YpZQdzHdMDLCvDQGpFiySlF9Bwkma3jr/PhN+wlr6fJ
 Jy4eP9QdK3II8AZhx0SDMGFqYeIIiDAzjePCEQHYQFSVHd5gy+zpMOVZC83vmj8sTFhX
 p5m96VJPqjQ4NmUvvytio97nhLBzsL9tg6YznP/AW8OjFDnQRHATaFxERpIlvc+bpZge
 +/RnuRn6aUuQf3Z96Ye7jrEsUJ7NFHT1bTcnXarFYs0e9mxnQc3n3ZDiKUpwPdgAAPu0
 PDTcOgXphmp4F9scP47mf1ryQi0LUN7ekvCajVETGlD0aAHBUoTbcogC4pjHmEUekBua
 8z2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762209186; x=1762813986;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=al58R8FyPwiPRYcaTuIMlThOPXAeHdhyb6sOn3pN7sI=;
 b=dfDRhARFI4S0+F9oqrGiKvPQhLABmd1F3fbsVWno+SyeYrsvE9Ixy51u57eTgE3YXq
 u+OEl5emXnfdbmRSMZM40pgXbKwL1zY8VqCqMTDnBbQ9QmlYQUJiRwiVFTRl9YFMCNWC
 SHtuh5Kx0kb6awmhexh5P3iyxXBJBK4lwVSFI1es4rS6vGllOAD+dqVPrPsRpRU2yKU+
 1gCZPGkOdMG5rY3o3e0fRVHk4AScaJdSxbXEfZVMogKDs9oaKhc6/czdpTZe2RcGDb8w
 wtnrTr79rF/WQDvcoN6MyvyBIV8OQ//M/x6da0Qtamq7oiI0UtCtnYSCVKLGPWCF2Y+5
 kaRg==
X-Gm-Message-State: AOJu0YzyWyO9CnOooESOmqN2hLyyAfyKlIXb60EbK3jQkTU6/P1Ulh3A
 bxYx5pQbMGYpqESDneNZqIDko/gcICjDBckF6YNApzRxlQCR7URvRVP0lPRsOj4fPYFl+NScBjS
 tuhJFQ1Zp2QyRSG1CaxM/tNFx0cVEixR1aETrKNQ=
X-Gm-Gg: ASbGncsX8ZbXezWz8nMS2TMwVSHmrq1qFrAgtFvveJB2axaYybgIwSZ4yLFq8QVSwNc
 Ozg0dMPhKcLYwAWj3eFq0DZAFaDO0H6b1itflRYOuaEBbXFI27suz6oTp0CVYVzXhYsD5mHe1n1
 z7ADZKAGvtzYhvRXrJcPbaSHTGB5r8kUJbTyWarnwu78kgfBBvm00gNYQFTwaRrVmoYHS0P5vCL
 xVBmHlyZz26qh622na4EOvtSHwgVjXAyoCrwfFHrDgszJhPU9OEM+tSNJE44Q==
X-Google-Smtp-Source: AGHT+IE1OliyARMVl1300av04aQhdAoNANU125xVZTkQM8uRrfrWVAskWuQaBppuATTfVJ7pRE6IG07mku5tzfnzosA=
X-Received: by 2002:a05:6830:6388:b0:747:323a:67b9 with SMTP id
 46e09a7af769-7c6967e1f15mr7313258a34.32.1762209186160; Mon, 03 Nov 2025
 14:33:06 -0800 (PST)
MIME-Version: 1.0
References: <20251101035252.261-1-briansune@gmail.com>
 <20251103153657.GO6688@bill-the-cat>
 <CAN7C2SB0b_YjcJ+LyVUJwi5DjdjR5Ssi=yQwuCvSvBh3XVj+dA@mail.gmail.com>
 <20251103200959.GR6688@bill-the-cat>
 <CAN7C2SCY1Q2_YcJWVMs0Zv+ymcuXLXEhrkX2JGcJviOaKDf0sQ@mail.gmail.com>
 <20251103204237.GS6688@bill-the-cat>
 <CAN7C2SACKPnE07-dtwc437f8xr38936h3RWvP1R5Ha_v1KfCng@mail.gmail.com>
 <20251103221712.GT6688@bill-the-cat>
In-Reply-To: <20251103221712.GT6688@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 4 Nov 2025 06:32:54 +0800
X-Gm-Features: AWmQ_bn-4P8J4uD0wNCkkRJBYVJIJ8Qi-LaRPwaUuuz_wM9vy3oTXSeKr5NA4ME
Message-ID: <CAN7C2SAGzmP+ff8LNJcs=1z3cS2kpzHOpEfq8JB6DNF29_Nkbg@mail.gmail.com>
Subject: Re: [PATCH v2] Add make feature support for SoCFPGA Handoff
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

> Well, I think so long as you can do "make xxx_defconfig" (and a separate
> objdir not source tree), then "make" sees deps and re-runs as needed,
> yes, this should be workable. Thanks.

Fresh UBOOT

```
make socfpga_cyclone5_defconfig
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/kconfig/conf.o
  YACC    scripts/kconfig/zconf.tab.c
  LEX     scripts/kconfig/zconf.lex.c
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/conf
#
# configuration written to .config
#
```

When the board/xxx/ only got qts

```
make prepare
scripts/kconfig/conf  --syncconfig Kconfig
  UPD     include/config.h
  CFG     u-boot.cfg
  GEN     include/autoconf.mk
  GEN     include/autoconf.mk.dep
  CFG     spl/u-boot.cfg
  GEN     spl/include/autoconf.mk
  UPD     include/config/uboot.release
  UPD     include/generated/version_autogenerated.h
  UPD     include/generated/timestamp_autogenerated.h
  UPD     include/generated/dt.h
  ENVC    include/generated/env.txt
  ENVP    include/generated/env.in
  ENVT    include/generated/environment.h
  HOSTCC  scripts/dtc/dtc.o
  HOSTCC  scripts/dtc/flattree.o
  HOSTCC  scripts/dtc/fstree.o
  HOSTCC  scripts/dtc/data.o
  HOSTCC  scripts/dtc/livetree.o
  HOSTCC  scripts/dtc/treesource.o
  HOSTCC  scripts/dtc/srcpos.o
  HOSTCC  scripts/dtc/checks.o
  HOSTCC  scripts/dtc/util.o
  LEX     scripts/dtc/dtc-lexer.lex.c
  YACC    scripts/dtc/dtc-parser.tab.h
  HOSTCC  scripts/dtc/dtc-lexer.lex.o
  YACC    scripts/dtc/dtc-parser.tab.c
  HOSTCC  scripts/dtc/dtc-parser.tab.o
  HOSTLD  scripts/dtc/dtc
  CC      lib/asm-offsets.s
  UPD     include/generated/generic-asm-offsets.h
  CC      arch/arm/lib/asm-offsets.s
  UPD     include/generated/asm-offsets.h
```

When the board/xxx/handoff is place next to qts

```
make prepare
  UPD     include/generated/timestamp_autogenerated.h
[INFO] Handoff folder found: board/altera/cyclone5-socdk/hps_isw_handoff
[INFO] Handoff subfolder found under board/altera/cyclone5-socdk/hps_isw_handoff
[INFO] Found hiof file:
board/altera/cyclone5-socdk/hps_isw_handoff/ddr3_5128x4_hps_0/ddr3_5128x4_hps_0.hiof
[INFO] Using handoff folder: ddr3_5128x4_hps_0
[INFO] Running BSP generator...
Generating file: board/altera/cyclone5-socdk/qts/sdram_config.h...
Generating file: board/altera/cyclone5-socdk/qts/pinmux_config.h...
Generating file: board/altera/cyclone5-socdk/qts/pll_config.h
Reading file: board/altera/cyclone5-socdk/hps_isw_handoff/ddr3_5128x4_hps_0/ddr3_5128x4_hps_0.hiof...
Generating file: board/altera/cyclone5-socdk/qts/iocsr_config.h...
[DONE] SoCFPGA QTS handoff conversion complete.
```

or simply

```
make -j 8
  UPD     include/generated/timestamp_autogenerated.h
  UPD     include/config/uboot.release
[INFO] Handoff folder found: board/altera/cyclone5-socdk/hps_isw_handoff
[INFO] Handoff subfolder found under board/altera/cyclone5-socdk/hps_isw_handoff
[INFO] Found hiof file:
board/altera/cyclone5-socdk/hps_isw_handoff/ddr3_5128x4_hps_0/ddr3_5128x4_hps_0.hiof
[INFO] Using handoff folder: ddr3_5128x4_hps_0
[INFO] Running BSP generator...
Generating file: board/altera/cyclone5-socdk/qts/sdram_config.h...
Generating file: board/altera/cyclone5-socdk/qts/pinmux_config.h...
Generating file: board/altera/cyclone5-socdk/qts/pll_config.h
  UPD     include/generated/version_autogenerated.h
Reading file: board/altera/cyclone5-socdk/hps_isw_handoff/ddr3_5128x4_hps_0/ddr3_5128x4_hps_0.hiof...
Generating file: board/altera/cyclone5-socdk/qts/iocsr_config.h...
[DONE] SoCFPGA QTS handoff conversion complete.
  LDS     u-boot.lds
  AR      tools/built-in.a
  HOSTCC  tools/gen_eth_addr
  HOSTCC  tools/gen_ethaddr_crc.o
  HOSTCC  tools/img2srec
  WRAP    tools/generated/lib/crc8.c
  HOSTCC  tools/mkenvimage.o
  HOSTCC  tools/os_support.o
  WRAP    tools/generated/lib/crc32.c
  HOSTCC  tools/atmelimage.o
```

Any additional requests?

Brian
