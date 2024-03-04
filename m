Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E882C48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 09:01:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAB9587DE9;
	Mon,  4 Mar 2024 10:01:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hQu9scQr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEFD9879F6; Mon,  4 Mar 2024 10:01:20 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D709083414
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 10:01:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-412e66b801fso1968785e9.3
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 01:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709542877; x=1710147677; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ucPxrOriUcUlH5E7vxRKM1rV9RP2tSvTjk1JzoV6q+o=;
 b=hQu9scQrBTi9/YmIfUiE46lu8vCtmmx3ZVhUKRHktMKNRdNeTBiDD/ekm4P+/tcCE0
 jnqWLKAnfrTh59oVfgM9IUj2T7XiYlfPZPDfk9z12e4vixZgWlV9HLzdEhVd0weMan/9
 Ty2gZqDOT60SyIXdbGxEE/yQrgEQmYWrRYgKyL8D+z80/FQ6mexuD8K1jXv1RnzdLL16
 FB+xYge5/t5BFYcRK44Ofyp1Q3BMB9qSxSZJ6SAEk8kHqxnYYCFikP1a1aoMChhvVKf5
 L431WxJiInuZBPJQL+Jcr1vK8+Y+5Dl4Vzk9M4ABiOrBezPzL9xqWgqxuxYPx3rrBbRA
 sAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709542877; x=1710147677;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ucPxrOriUcUlH5E7vxRKM1rV9RP2tSvTjk1JzoV6q+o=;
 b=LJmkKEyKZqPyrsIVkAmQm4vlKnv91ZQQs6YIGoLdv9HcBYTUTTu477fdGYm/D2fgX/
 3WZZynOW7FBAVlcOK3sLIKhRrSOlaPvZmFe2nX+vQS1E/fy9BqYj+Rqz0AQpHClgikHj
 Ry2oHHigRCrz2hWoQc2L6++09qoa87TNshj56DUEomAZ1MaAuWJhvX0b0gtbMbx3E5Wz
 gLLgXxIcxFTln3wdVOgd2CXO2WJn2xy/z/pZ28r1jqIy9k4EM5P285HqpzAzO3LiP7Zk
 DHsoFWt4xLXJQ1ZkasXL2IAD+I3/ZTbVqQ0yFfCVzcV3i4ucnz48FOYSa8lW7WgCfBWo
 D2dQ==
X-Gm-Message-State: AOJu0Yx/mDoUFAiKiaTBMHa3I9r6HSQ4BiOVxiSuZUsOPcMeVkZ009dJ
 E9rrrkARJQEO9km1jaikRvDbxguyUCSd4Ndf2xLhv25HK+SNDB9TW+Nto4HQQr4AKMdPcj+xzcT
 wRsA=
X-Google-Smtp-Source: AGHT+IFN5Bl2KdXLsbGqWVi6dDxDnNrqO4prRCHQvosA/1Ey5wMbg5d1I2lgFJa4rh5UG5iwrkDx5A==
X-Received: by 2002:a05:600c:3509:b0:412:ddd3:8372 with SMTP id
 h9-20020a05600c350900b00412ddd38372mr2210655wmq.38.1709542877163; 
 Mon, 04 Mar 2024 01:01:17 -0800 (PST)
Received: from hades.. (ppp046103107123.access.hol.gr. [46.103.107.123])
 by smtp.gmail.com with ESMTPSA id
 t11-20020a05600c198b00b00412c8117a34sm10281167wmq.47.2024.03.04.01.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 01:01:16 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	trini@konsulko.com,
	cfsworks@gmail.com
Cc: caleb.connolly@linaro.org, sumit.garg@linaro.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Michal Simek <michal.simek@amd.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>, Bin Meng <bmeng@tinylab.org>
Subject: [PATCH 0/6] Clean up arm linker scripts
Date: Mon,  4 Mar 2024 11:01:05 +0200
Message-Id: <20240304090113.1410575-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The arm linker scripts had a mix of symbols and C defined variables in an
effort to emit relative references instead of absolute ones e.g [0]. A
linker bug prevented us from doing so [1] -- fixed since 2016.
This has led to confusion over the years, ending up with mixed section
definitions. Some sections are defined with overlays and different
definitions between v7 and v8 architectures.
For example __efi_runtime_rel_start/end is defined as a linker symbol for
armv8 and a C variable in armv7.

Linker scripts nowadays can emit relative references, as long as the symbol
definition is contained within the section definition. So let's switch most
of the C defined variables and clean up the arm sections.c file.
There's still a few symbols remaining -- __secure_start/end,
__secure_stack_start/end and __end which can be cleaned up
in a followup series.

The resulting binary (tested in QEMU v7/v8) had no size differences apart from
the emited sections and object types of those variables. I've also added prints
throughout the U-Boot init sequence. The offsets and delta for 'end - start'
section sizes is unchanged.

For example on QEMU v8:
$~ ./scripts/bloat-o-meter u-boot u-boot.new
add/remove: 0/0 grow/shrink: 0/0 up/down: 0/0 (0)
Function                                     old     new   delta
Total: Before=798861, After=798861, chg +0.00%

$~ readelf -sW u-boot | grep bss_s
    12: 00000000001029b8     0 SECTION LOCAL  DEFAULT   12 .bss_start
  8088: 0000000000000018     0 NOTYPE  GLOBAL DEFAULT    1 _bss_start_ofs
  8376: 00000000001029b8     0 OBJECT  GLOBAL DEFAULT   12 __bss_start
$~ readelf -sW u-boot.new | grep bss_s
  8085: 0000000000000018     0 NOTYPE  GLOBAL DEFAULT    1 _bss_start_ofs
  8373: 00000000001029b8     0 NOTYPE  GLOBAL DEFAULT   12 __bss_start

For QEMU v7 the differences are a bit bigger but only affect the variables
placed in the .bss section because that was defined as an OVERLAY in the
existing linker script.
For example:
$~ nm u-boot | grep tftp_prev_block
000ca0dc ? tftp_prev_block
$~ nm u-boot.new | grep tftp_prev_block
000e0a5c b tftp_prev_block -----> The symbol is now placed into .bss

It's worth noting that since the efi regions are affected by the change, booting
with EFI is preferable while testing. Booting the kernel only should be enough
since the efi stub and the kernel proper do request boottime and runtime
services respectively.
Something along the lines of
> virtio scan && load virtio 0 $kernel_addr_r Image && bootefi $kernel_addr_r
will work for QEMU aarch64.

Tested platforms:
- QEMU aarch64
- Xilinx kv260 kria starter kit & zynq
- QEMU armv7
- STM32MP157C-DK2

[0] commit 3ebd1cbc49f0 ("arm: make __bss_start and __bss_end__ compiler-generated")
[1] binutils commit 6b3b0ab89663 ("Make linker assigned symbol dynamic only for shared object")

Ilias Apalodimas (6):
  arm: baltos: remove custom linker script
  arm: clean up v7 and v8 linker scripts for bss_start/end
  arm: fix __efi_runtime_rel_start/end definitions
  arm: clean up v7 and v8 linker scripts for __rel_dyn_start/end
  arm: fix __efi_runtime_start/end definitions
  arm: move image_copy_start/end to linker symbols

 arch/arm/cpu/armv8/u-boot-spl.lds        |  14 +--
 arch/arm/cpu/armv8/u-boot.lds            |  45 ++------
 arch/arm/cpu/u-boot.lds                  |  74 +++----------
 arch/arm/lib/sections.c                  |  10 --
 arch/arm/mach-rockchip/u-boot-tpl-v8.lds |  22 +---
 arch/arm/mach-zynq/u-boot.lds            |  72 +++----------
 board/vscom/baltos/u-boot.lds            | 128 -----------------------
 include/asm-generic/sections.h           |   3 +
 lib/efi_loader/efi_runtime.c             |   1 +
 9 files changed, 50 insertions(+), 319 deletions(-)
 delete mode 100644 board/vscom/baltos/u-boot.lds

--

Changes since RFC:
- Rebase on top of -next and get rid of the dragonboard linker script changes.
  Caleb removed that file completely
- Rewrite some commit messages to include the binutils bug details (thanks Sam)

2.37.2

