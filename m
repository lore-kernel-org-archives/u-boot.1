Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAEB5D16816
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 11:32:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E06384166;
	Fri,  9 Jan 2026 12:32:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QI6M2vup";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AB71842DB; Fri,  9 Jan 2026 12:32:51 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4EF983CB1
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 12:32:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-34c3cb504efso3324582a91.2
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 03:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767958367; x=1768563167; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UHXiR/Sni6BykKngxvWGqT/uMwh9NZW2XigiJsgTPuo=;
 b=QI6M2vupO26RJLvlVtlvIkfJg9FDEscycmRhANFXhZSsCgysWpyddhjrV/iMoFdScQ
 4cP9nL+YmVanRzFSIPEzHTtn1ZlZwHw85kl9yKtIZ8Mc+kpuqEktuCOm/UWZ9S25hmmB
 l5pDoVA5nvdWSCNjs3lTIbiTIIGKJmIhDxZlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767958367; x=1768563167;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UHXiR/Sni6BykKngxvWGqT/uMwh9NZW2XigiJsgTPuo=;
 b=J1WGwRG0rH0zMPu5h2L4UmbzQKjW0DMnzZ38dWuelQ2PyCIuFVH4nXusRWZ+tQIma8
 imc2BSsLBGO2d2VDclPEmEwbrdQvCTvZxY5eaRocGEaJ3ieJSGn/vDHVWZeH175vHHcq
 +O2tMBdRBds6IbYFb2TVVbUdFWCmrEV3JFAU187Gh+StDizhJPDvZ5qv7/N5XZ0We7WL
 K8Dflkw4gfSpgKpXYTBmtfv8xerMsbDLQgvq3VOi9GXE8V3bm5lowOa4z4cCUv36+hZL
 luCCdJKi9bgBHfl84Y3DJgEwzopxtduUtJZi+SSHLlgkYPq3U5/AoV1R5aNxz4PHtbfr
 sRNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSTgp2dO3c/swIRKFjGTx4KkHr4Qk9ldRjqcl+mVPnEX2ovT1n0z3KbuhP+fJINkYidPjghOQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+wpkYHfIbnyZ+SIpLe6nxl5E4N7/CXQ23pm9cMU2i1ep1RKrn
 rSLj+EdRUS1/N03tHNxG0kmbOBTkd/5XI3F8yOOo2OfqtDdqCB28DOIafbewHqWkaaXsECTaYCk
 Ltyk9MuBnEnDhAmjsJv+yQDGvFm1AmmpjJzxM/m6l
X-Gm-Gg: AY/fxX7o7/KqFmiA+Nzb/lWyBKoo8sYiK17VSy0x5PrmTFxR+W/Ro5/MKkIjGkYvPXm
 Aig7l2l9Bf5SgSXMKazGk79xTEg+5z3FtTe7rAWcY8nySoQOu+vaGeJsc39u/BtRYubIeslm0fq
 N0xurp2y9ghXp7OC1YGwkbhpietzXdH6b6Hot/4W6LXAw10DseEKmH5TrhXul5efXkzaVx39NtQ
 W8o9wZn/zbXxbG0UW6Z4qX7+Rt62cgdx8cE4NgtEo0eECEecRxFngI/vQMr/vOVk0zXiw==
X-Google-Smtp-Source: AGHT+IE7hJJk3ZioIbtmcShQlDAZdY1mjq/hsQ7qOP203z0fjaUh2NtfLhq+0VfRhaVAIG495aTOix5It0CMXhuph5k=
X-Received: by 2002:a17:90b:6c7:b0:335:2eef:4ca8 with SMTP id
 98e67ed59e1d1-34f68d3b4a4mr8634750a91.33.1767958367066; Fri, 09 Jan 2026
 03:32:47 -0800 (PST)
MIME-Version: 1.0
References: <20260107201838.3448806-1-visitorckw@gmail.com>
 <20260107201838.3448806-7-visitorckw@gmail.com>
In-Reply-To: <20260107201838.3448806-7-visitorckw@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 9 Jan 2026 04:31:54 -0700
X-Gm-Features: AQt7F2oldZuMsAI_QVn8-ZMiteM2BuzQYEvqNs9Wwx-0pVZO9Jqt34dsTGU24Zs
Message-ID: <CAFLszTjBdYw9Jz4UQkdk5DrtUK+sEQbxTT_Y9dyGW7Ly=bmXhw@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] board: Add QEMU m68k virt board support
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: alison.wang@nxp.com, angelo@kernel-space.org, trini@konsulko.com, 
 me@ziyao.cc, daniel@0x0f.com, heinrich.schuchardt@canonical.com, 
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, u-boot@lists.denx.de
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

On Wed, 7 Jan 2026 at 13:19, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
>
> Add support for the QEMU 'virt' machine on the m68k architecture. This
> board emulates a generic machine based on the Motorola 68040 CPU
> equipped with Goldfish virtual peripherals.
>
> Introduce the necessary board configuration and initialization
> infrastructure. The implementation includes logic to parse the QEMU
> bootinfo interface, enabling dynamic detection of system RAM size to
> adapt to the virtual machine's configuration.
>
> Enable the Goldfish TTY driver for serial console output. Additionally,
> enable Goldfish RTC and timer drivers to support real-time clock
> functionality and nanosecond-resolution delays. Include comprehensive
> documentation covering build instructions and usage examples.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> Tested-by: Daniel Palmer <daniel@0x0f.com>
> ---
> Changes in v6:
> - Move bootinfo parsing logic to a helper function called in
>   board_early_init_f.
> - Remove hardcoded MMIO address macros; use values parsed from
>   bootinfo.
> - Use the new sysreset driver via U_BOOT_DRVINFO.
> - Use SZ_16M macro for default RAM size.
> - Update header include order to match coding style.
> - Fix blank line formatting in checkboard().
>
>  arch/m68k/Kconfig                     |   9 ++
>  board/emulation/qemu-m68k/Kconfig     |  12 +++
>  board/emulation/qemu-m68k/MAINTAINERS |   8 ++
>  board/emulation/qemu-m68k/Makefile    |   5 ++
>  board/emulation/qemu-m68k/qemu-m68k.c | 117 ++++++++++++++++++++++++++
>  configs/qemu-m68k_defconfig           |  20 +++++
>  doc/board/emulation/index.rst         |   1 +
>  doc/board/emulation/qemu-m68k.rst     |  39 +++++++++
>  include/configs/qemu-m68k.h           |  18 ++++
>  9 files changed, 229 insertions(+)
>  create mode 100644 board/emulation/qemu-m68k/Kconfig
>  create mode 100644 board/emulation/qemu-m68k/MAINTAINERS
>  create mode 100644 board/emulation/qemu-m68k/Makefile
>  create mode 100644 board/emulation/qemu-m68k/qemu-m68k.c
>  create mode 100644 configs/qemu-m68k_defconfig
>  create mode 100644 doc/board/emulation/qemu-m68k.rst
>  create mode 100644 include/configs/qemu-m68k.h
>

Reviewed-by: Simon Glass <simon.glass@canonical.com>
