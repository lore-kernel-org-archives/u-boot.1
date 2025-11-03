Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A253CCFA03
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 22:52:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DBFC82A9E;
	Mon,  3 Nov 2025 23:52:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KVtl9KYk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1CB2836D1; Mon,  3 Nov 2025 23:52:28 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD8638144A
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 23:52:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7c69f515220so641986a34.1
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 14:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762210345; x=1762815145; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vde3eiwbAaqMAtT0e1rvuhoOS6bwHDp0qEAgbiBdr6k=;
 b=KVtl9KYkUnaQ8Bcdgruy21sOuibiQO9pVTZVz6RYL3bcd7tEQ9mrOMucAjzteiw7vZ
 KlY/4W5zBkDxICvtq6vBqdd4vsVRvmi4vanzdgb5+zSKVwnsJVwmnNUsfkdvOY5TGc9c
 L/gOSAGg4hN4M/xbxdJmAzbUgCTDMnZzpQqR2mhyVn0gjsvflK4i1MHcf4YfeFEIOu3M
 nNsWf754Rm/M+7QKSBzwJDzHpUAvL4l6bKjOWd0vH0Ou+ts/WPd0GFP6jNzRfAqkgfa8
 RqCs37yEw6VSlGvthOiDU903Wj5pvLtkivS9UqcFivGxJ0V2VB7gF89QRjQ7cYTx51tq
 DbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762210345; x=1762815145;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vde3eiwbAaqMAtT0e1rvuhoOS6bwHDp0qEAgbiBdr6k=;
 b=vSckNy/FdUerpwDLhn6rBL2bNUfFwOa8MJkm+vmZUQllTv7BTf7NUnnOTbGXqZILbd
 HcQ4o4ZKgMi+ymVvNqG5pTb3THhMxTebMXg0xz33xok5AVBIVQFjgLmh0WTLjPMOG/rU
 dqlGtyRBpYK/nlsYbsVbGXW3pvcTM9+LMkBQ8UhDDE6RkJqWYNgKYFB5Z0r+oXRbASYY
 2ojZHXHpifrnWRrMJrgbz3hYr5fg36EEjSfK/5PDm6yg/zHZ/uh/KUmTjHGZ1xd5xJ/C
 F4nsCEGUexWYp1ZuD3LWXaboaSjdpMEvioUWih0we5OrIXSJVymWrH3y/n/YX0KHvPXE
 bdmA==
X-Gm-Message-State: AOJu0YxfoxEGjQlEmPlYc82fxa80lEhHQogkKyOjMaLNJqLefGuQtWoQ
 PJGRrkpPMsVw79+2AMBa7fQmFxPS3Ic0YjuCRWfcg7CVbKaGlVamESOesFW37zRsEMtsMvPprUb
 vGJMu73N33HwEjbV9QjL87anhobTbpKM=
X-Gm-Gg: ASbGncujM1o0exmCOB09oo56gdhha1BE9XVpAINjrjXjdvbnJ8CINgZVbvL0z7s9zET
 3a46TEQeeHfHa3C/Y6FGF87PMrqHajbAgrK4vwmtabJK82oGjiWUP8YFda0Ie8bTS4GxZINFKnq
 UXkWnThs3Gcx3DDpr/9Sbh5WqqgyCLB8IlgsmlJD3QVzV1EdUanVqZShcbt1X8tu5nxWwX6jyl5
 rjElbTidPFFG0SR731pBohRYhbNcjCGRY5vPbb7yxrfHExOtVvLrhFpaEemiQ==
X-Google-Smtp-Source: AGHT+IGIjJS2HrnDmjrYULJhbK+YFABvoSguuZh/8uaAFbACV2pL7QPP9Z2n0Hb1WiO4IopG8Fg5q6NPqq2cBnSAAjI=
X-Received: by 2002:a05:6830:916:b0:756:a322:311 with SMTP id
 46e09a7af769-7c6967098c2mr8107410a34.10.1762210345344; Mon, 03 Nov 2025
 14:52:25 -0800 (PST)
MIME-Version: 1.0
References: <20251103222840.458-1-briansune@gmail.com>
 <20251103223346.GU6688@bill-the-cat>
In-Reply-To: <20251103223346.GU6688@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 4 Nov 2025 06:52:14 +0800
X-Gm-Features: AWmQ_blzPXbTogXg1214yyMurrUY7rpCWiQOpzMFjVUXIcXzkIdhf1RbioWFT6Y
Message-ID: <CAN7C2SB7qeXQB5=VHZ_DaE-ov4S7OX2hSyYNhb4SWv8-k+J_9A@mail.gmail.com>
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

> This won't work with separate object directories. Please give things a

I am not too getting this, why? The checking stage is not enough to
block the below script execute?

> spin with "make O=/tmp/somedir". It also looks like it's going to impact
> every board, and either fail or add some build time? Make sure both say
> "sandbox" and "qemu_arm" both build at least, if not a full CI run.

For build time -> There could be 4 line of code to check.
For sandbox:

```
make clean && make mrproper
  CLEAN   cmd
  CLEAN   dts/../arch/sandbox/dts
  CLEAN   dts
  CLEAN   lib/efi_loader
  CLEAN   lib/efi_selftest
  CLEAN   lib
  CLEAN   tools
  CLEAN   tools/generated
  CLEAN   include/autoconf.mk include/autoconf.mk.dep
include/bmp_logo.h include/bmp_logo_data.h include/config.h
include/generated/env.in include/generated/env.txt
drivers/video/u_boot_logo.S u-boot-nodtb.bin u-boot.lds u-boot.bin
u-boot.sym u-boot-dtb.bin u-boot.srec u-boot u-boot.map u-boot.cfg
u-boot.dtb.out u-boot.dtb System.map keep-syms-lto.c
lib/efi_loader/helloworld_efi.S Test03 Test113 Test01 Test12 Test111
Test102 Test11 Test103 Test02 Test112 Test101
capsule_in.capsule5.efi-capsule capsule_in.capsule3.efi-capsule
capsule_in.capsule8.efi-capsule capsule.capsule3.efi-capsule
capsule.capsule10.efi-capsule capsule.capsule9.efi-capsule
capsule.capsule6.efi-capsule capsule.capsule1.efi-capsule
capsule_in.capsule9.efi-capsule capsule_in.capsule10.efi-capsule
capsule.capsule5.efi-capsule capsule.capsule2.efi-capsule
capsule_in.capsule2.efi-capsule capsule.capsule4.efi-capsule
capsule.capsule11.efi-capsule capsule.capsule7.efi-capsule
capsule_in.capsule7.efi-capsule capsule_in.capsule4.efi-capsule
capsule.capsule8.efi-capsule capsule_in.capsule11.efi-capsule
capsule_in.capsule6.efi-capsule capsule_in.capsule1.efi-capsule
capsule1.map capsule8.map capsule5.map capsule7.map capsule4.map
capsule6.map capsule10.map capsule3.map capsule9.map capsule2.map
capsule11.map
  CLEAN   scripts/basic
  CLEAN   scripts/dtc/pylibfdt
  CLEAN   scripts/dtc
  CLEAN   scripts/kconfig
  CLEAN   scripts
  CLEAN   include/config include/generated
  CLEAN   .config .config.old drivers/video/fonts/cantoraone_regular.S
drivers/video/fonts/nimbus_sans_l_regular.S
```

For qemu_arm:

```
make clean && make mrproper
  CLEAN   dts/../arch/arm/dts
  CLEAN   dts
  CLEAN   env
  CLEAN   lib/efi_loader
  CLEAN   lib/efi_selftest
  CLEAN   tools
  CLEAN   tools/generated
  CLEAN   include/autoconf.mk include/autoconf.mk.dep
include/bmp_logo.h include/bmp_logo_data.h include/config.h
include/generated/env.in include/generated/env.txt
drivers/video/u_boot_logo.S u-boot-nodtb.bin u-boot.lds u-boot.map
u-boot.srec u-boot.cfg u-boot.bin u-boot u-boot.sym System.map
lib/efi_loader/helloworld_efi.S
  CLEAN   scripts/basic
  CLEAN   scripts/dtc
  CLEAN   scripts/kconfig
  CLEAN   include/config include/generated
  CLEAN   .config .config.old
```

I am not too sure full CL run?

Brian
