Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E81ECCFA03
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 23:40:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC0998144A;
	Tue,  4 Nov 2025 00:40:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e+FKBFCR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 533C582A9E; Tue,  4 Nov 2025 00:40:39 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DC118004F
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 00:40:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7c681a8aecdso3062628a34.1
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 15:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762213236; x=1762818036; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z0NQRKEXm4eCutOI5UptEkfLRQATLPpdYjYzglyR4M8=;
 b=e+FKBFCRh12KV+Gcb+5tu8KE1k9NUaHRUd9zX5j9aIHSx3I5GqCoVhrwvlLVHJjujx
 Wx2ItmT8pl7g4yL3xL2xeO6ogDfHEZVSACC3Os1ZQRnpZ9nNm1YbfDCuNF2fW1xFlVbu
 UPyn002LwRrU/Q3xGBHgU7G6B2GyyYW87aWVcZrbv6XXKuw/zU7ZsARAmezi6d1PVS3r
 WimX6UiVLiZg3VVCXXdxc4Oz1qQuli4+kAX/b4GRubNbliK767fK4r+c5p+LBpCu/94O
 oFzPb4/zTKWpS1ElhBRNQpmF9zB1lEOEN1rapdetjzHLxSZwMn8XSL7sI+ZbUncbE/Ag
 WHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762213236; x=1762818036;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z0NQRKEXm4eCutOI5UptEkfLRQATLPpdYjYzglyR4M8=;
 b=V/0nJs8dlBTP50PIsL1Xm4KxkD+ucvuMND3tldeskk9dxOQ8CBlERo96+3Gwb/NhYP
 RygxK4Yk34aXGmxzQLH7J++xqT8/Qz3c3hzCEU0MVytfMdKutMzMmKehGGQXfaWbKtKP
 MwB3OLLOm0zIxOUIXjT73TAx4OXmoHFT2eLQNePfVVIJgS0lUBLrBSjhzFL1uKUNQLfo
 /GJ1wgaZKs08vaHP1m5pBl+VMoOn+5oHK903xXUfr1D/alesNBtJc9N8C5h/CwLYUbsl
 RByTbmRaMchVXV2zhzBN/BB+KSCK2bo9C7Cd8cBBcyG71JE1sXSZxc5TDRAuZR79uqjk
 ksXg==
X-Gm-Message-State: AOJu0YwqE/h8cUn1/s4KUzNxiwtSytHikL1bQoZDsOCcJ5hCNhHN3Ff4
 j7Es3D3Mmd/oJHz6UaQdgbpH2793+Vbx8v76Atc1BuGRYBJ44RWYnYx/eCGFGozulqGLJZ/Eyfp
 72e+cYIPUOggYoKPdCHbihZeDx22EGK4njFsdbJs=
X-Gm-Gg: ASbGncvfIH/9p8kV0Ut3C3XPRVSNMvbxp3f7hLmx8Plxn9BEVRra/7cxCccZR1nEy+i
 OOkRXWCYuyaP0FnDZ85YnXCZe1vMEctWX+Re/QyXz1OZ0C8nLag0pJtZ7M8TWJDsAiBMOlrWYmr
 N8zX9SE3db8MXaep1qGJN+nNYnq98h4OhQajMfNND9I7W54/hvjUgWIpqvbSEXna/Oetqi2QM6N
 S7aWy8QKyPK8iIQEsRiCOJG4n6ZFpoxlIuVxqIE2GUc9IBupFUev0KUvowQXZyEuZI/2s46WgG3
 Ta3Bsig=
X-Google-Smtp-Source: AGHT+IFTgYAL1tpI+iQU+ip4OXcL6TSQNvxYTIemF71v9yUBLwn3QUastlFnKw3HZcVQgARB/HYj3I2kaWy7pmK4Bhc=
X-Received: by 2002:a05:6830:d86:b0:790:710f:60e3 with SMTP id
 46e09a7af769-7c69674c0c1mr7780916a34.23.1762213235706; Mon, 03 Nov 2025
 15:40:35 -0800 (PST)
MIME-Version: 1.0
References: <20251103222840.458-1-briansune@gmail.com>
 <20251103223346.GU6688@bill-the-cat>
 <CAN7C2SB7qeXQB5=VHZ_DaE-ov4S7OX2hSyYNhb4SWv8-k+J_9A@mail.gmail.com>
 <20251103230540.GV6688@bill-the-cat>
 <CAN7C2SCCMKfjnfB2FnH1svrSJ1dN_chtUVmsTcaP6-8_zSiEzQ@mail.gmail.com>
 <20251103232345.GW6688@bill-the-cat>
In-Reply-To: <20251103232345.GW6688@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 4 Nov 2025 07:40:24 +0800
X-Gm-Features: AWmQ_bn2Gh4gz8OAUQSWUDPbiuD5NVfNpU8NGnNhVnGX3PgFxKv9Kv9yQez0REU
Message-ID: <CAN7C2SA8njY3rFz71-cOakdOit0K27zPrQeto6fuMFQz4BQWjQ@mail.gmail.com>
Subject: Re: [PATCH v3] Add make feature support for SoCFPGA Handoff
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

> You need to do some builds with "make O=/tmp/somedir". But also, I'm
> trying to make sure we avoid race conditions and that we don't try this
> logic until after the step where we know we have configured the system.

Yes this part i had agreed.

HANDOFF_PATH parameter.

```
make prepare HANDOFF_PATH=/media/sf_shared/loader/hps_isw_handoff/ddr3_5128x4_hps_0
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
[INFO] Using manually assigned handoff path:
/media/sf_shared/loader/hps_isw_handoff/ddr3_5128x4_hps_0
Generating file: board/altera/cyclone5-socdk/qts/sdram_config.h...
Generating file: board/altera/cyclone5-socdk/qts/pinmux_config.h...
Generating file: board/altera/cyclone5-socdk/qts/pll_config.h
Reading file: /media/sf_shared/loader/hps_isw_handoff/ddr3_5128x4_hps_0/ddr3_5128x4_hps_0.hiof...
Generating file: board/altera/cyclone5-socdk/qts/iocsr_config.h...
[DONE] SoCFPGA QTS handoff conversion complete.
```

export method

```
export HANDOFF_PATH=/media/sf_shared/loader/hps_isw_handoff/ddr3_5128x4_hps_0

 make prepare
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
[INFO] Using manually assigned handoff path:
/media/sf_shared/loader/hps_isw_handoff/ddr3_5128x4_hps_0
Generating file: board/altera/cyclone5-socdk/qts/sdram_config.h...
Generating file: board/altera/cyclone5-socdk/qts/pinmux_config.h...
Generating file: board/altera/cyclone5-socdk/qts/pll_config.h
Reading file: /media/sf_shared/loader/hps_isw_handoff/ddr3_5128x4_hps_0/ddr3_5128x4_hps_0.hiof...
Generating file: board/altera/cyclone5-socdk/qts/iocsr_config.h...
[DONE] SoCFPGA QTS handoff conversion complete.
```

I think for moving to that location it leave for another patch.
I had spent time and effort already on Makefile.

I repatch this version and if there are any trouble please explain a bit to fix.

Brian
