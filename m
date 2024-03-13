Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C61D7C54E66
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 16:23:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17CEE87150;
	Wed, 13 Mar 2024 17:23:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eKg8dTLr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8B0287DE3; Wed, 13 Mar 2024 17:23:32 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D54D8272A
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 17:23:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-513ccc70a6dso52271e87.1
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 09:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710347009; x=1710951809; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EGvvRUOTdiYBiVm2CeEexIzK8Q4c7Dn6jfI4eI4byVA=;
 b=eKg8dTLr97iv8NdKN6rt3+bhGR2q6KGArNjmjkhucH7ffsogyP2psCgURdr8N5J0zJ
 uGfZbW5xvzRclRV381K4lFxMeqToMFuxmICbXPDX0fgRPWdEYk0ePd8r9t1R1+tzaVBY
 T3qgepyP7WkodSSjBx3ZvG8/PWJRByijjvKaQdSlMx3DvrqNhzf5NdjAOfeQInpJIcX/
 SXO0c3CW2/iGj+9Bk4DEdGMG+yF/8SwEk+jppb6YrH7iVqMsTg0AoAinX2mKuYvWoR3a
 Q+clUtsmmUsZ7DoaHcUNvIrjYhAgj5qVjuEmDRgizN4EiPHZ/xb/hbRQhSpmNeUcp2XP
 rc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710347009; x=1710951809;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EGvvRUOTdiYBiVm2CeEexIzK8Q4c7Dn6jfI4eI4byVA=;
 b=exK9qpd+vSkMVKcCSuwDXC6e2zRX3tYzt322hjkuL1pGIjy9akITeDLMYOiJvq/qev
 JlE1yGX/LT+eEMNEvweEhN3TKpu3wHHkeCihBMtmfI6VJo8qeWG44rapfYNSqtKFUaIq
 3KTDlMJEbRd9U18TAn8GHIlb+vWmcFk85uuzb55UDD0RGWGMoHoclR3Oaes/T8b7wGm0
 FxEv0x1qh4g8jzs92a+1g+UkemKVrfkEwvfz1OCKpGM5TNrjjXIT5peEFB8Hk4Srv9i4
 uRrWVsN5MqF8c1AX48t+a812N0KNY5RvdRzhkQKDaFWFoSL/webKiL9ZlzrbAo3FsCR9
 RIZQ==
X-Gm-Message-State: AOJu0Yw/D2ChHDdu85CqD1H0TMu1Rhbsct71XA/P7T84Fm+XzRYnHBny
 iJbTT7m0zIRR1cjWZOZbEdFXEPdHAbni8zjXZzl6kY9QsXqq3Z35oCUolV/rtijXxGu+YYpT6fr
 d
X-Google-Smtp-Source: AGHT+IHxiSbJwqVnzLCJwwwpW5iBqMjdplL3Mw61jzsBhNZ8HMdbQ4KmZzb56RWmJSsOYNi23F5QGw==
X-Received: by 2002:a05:6512:1385:b0:513:a766:4672 with SMTP id
 fc5-20020a056512138500b00513a7664672mr8907820lfb.4.1710347009504; 
 Wed, 13 Mar 2024 09:23:29 -0700 (PDT)
Received: from hades.. (ppp046103107123.access.hol.gr. [46.103.107.123])
 by smtp.gmail.com with ESMTPSA id
 bh21-20020a170906a0d500b00a44efa48c24sm4998860ejb.117.2024.03.13.09.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 09:23:28 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	trini@konsulko.com,
	cfsworks@gmail.com
Cc: caleb.connolly@linaro.org, sumit.garg@linaro.org,
 richard.henderson@linaro.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Michal Simek <michal.simek@amd.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Edwards <CFSworks@gmail.com>,
 Shiji Yang <yangshiji66@outlook.com>, Bin Meng <bmeng@tinylab.org>
Subject: [PATCH v3 0/7] Clean up arm linker scripts
Date: Wed, 13 Mar 2024 18:23:14 +0200
Message-Id: <20240313162324.2117909-1-ilias.apalodimas@linaro.org>
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

For both QEMU v7/v8 bloat-o-meter shows now size difference
$~ ./scripts/bloat-o-meter u-boot u-boot.new
add/remove: 0/0 grow/shrink: 0/0 up/down: 0/0 (0)
Function                                     old     new   delta
Total: Before=798861, After=798861, chg +0.00%

The symbols seem largely unchanged apart from a difference in .bss
as well as the emited sections and object types of the affected variables.

On the output below the first value is from -next and the second comes from
-next + this patchset. The .bss_start/end sections have disappeared from
the newer binaries.

# For example on QEMU v8:
efi_runtime_start
  7945: 0000000000000178     0 OBJECT  GLOBAL DEFAULT    2 __efi_runtime_start
  7942: 0000000000000178     0 NOTYPE  GLOBAL DEFAULT    2 __efi_runtime_start
efi_runtime_stop
  9050: 0000000000000d38     0 OBJECT  GLOBAL DEFAULT    2 __efi_runtime_stop
  9047: 0000000000000d38     0 NOTYPE  GLOBAL DEFAULT    2 __efi_runtime_stop
__efi_runtime_rel_start
  7172: 00000000000dc2f0     0 OBJECT  GLOBAL DEFAULT   10 __efi_runtime_rel_start
  7169: 00000000000dc2f0     0 NOTYPE  GLOBAL DEFAULT   10 __efi_runtime_rel_start
__efi_runtime_rel_stop
  7954: 00000000000dc4a0     0 OBJECT  GLOBAL DEFAULT   10 __efi_runtime_rel_stop
  7951: 00000000000dc4a0     0 NOTYPE  GLOBAL DEFAULT   10 __efi_runtime_rel_stop
__rel_dyn_start
  7030: 00000000000dc4a0     0 OBJECT  GLOBAL DEFAULT   11 __rel_dyn_start
  7027: 00000000000dc4a0     0 NOTYPE  GLOBAL DEFAULT   11 __rel_dyn_start
__rel_dyn_end
  8959: 0000000000102b10     0 OBJECT  GLOBAL DEFAULT   12 __rel_dyn_end
  8956: 0000000000102b10     0 NOTYPE  GLOBAL DEFAULT   11 __rel_dyn_end
image_copy_start
  9051: 0000000000000000     0 OBJECT  GLOBAL DEFAULT    1 __image_copy_start
  9048: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT    1 __image_copy_start
image_copy_end
  7467: 00000000000dc4a0     0 OBJECT  GLOBAL DEFAULT   11 __image_copy_end
  7464: 00000000000dc4a0     0 NOTYPE  GLOBAL DEFAULT   11 __image_copy_end
bss_start
    12: 0000000000102b10     0 SECTION LOCAL  DEFAULT   12 .bss_start
  8087: 0000000000000018     0 NOTYPE  GLOBAL DEFAULT    1 _bss_start_ofs
  8375: 0000000000102b10     0 OBJECT  GLOBAL DEFAULT   12 __bss_start
  8084: 0000000000000018     0 NOTYPE  GLOBAL DEFAULT    1 _bss_start_ofs
  8372: 0000000000102b10     0 NOTYPE  GLOBAL DEFAULT   12 __bss_start
bss_end
    14: 000000000010bc30     0 SECTION LOCAL  DEFAULT   14 .bss_end
  7683: 000000000010bc30     0 OBJECT  GLOBAL DEFAULT   14 __bss_end
  8479: 0000000000000020     0 NOTYPE  GLOBAL DEFAULT    1 _bss_end_ofs
  7680: 000000000010bbb0     0 NOTYPE  GLOBAL DEFAULT   12 __bss_end
  8476: 0000000000000020     0 NOTYPE  GLOBAL DEFAULT    1 _bss_end_ofs

# For QEMU v7:
efi_runtime_start
 10703: 000003bc     0 OBJECT  GLOBAL DEFAULT    2 __efi_runtime_start
 10699: 000003c0     0 NOTYPE  GLOBAL DEFAULT    2 __efi_runtime_start
efi_runtime_stop
 11796: 000012ec     0 OBJECT  GLOBAL DEFAULT    2 __efi_runtime_stop
 11792: 000012ec     0 NOTYPE  GLOBAL DEFAULT    2 __efi_runtime_stop
__efi_runtime_rel_start
  9937: 000c40dc     0 OBJECT  GLOBAL DEFAULT    8 __efi_runtime_rel_start
  9935: 000c40dc     0 NOTYPE  GLOBAL DEFAULT    9 __efi_runtime_rel_start
__efi_runtime_rel_stop
 10712: 000c41dc     0 OBJECT  GLOBAL DEFAULT   10 __efi_runtime_rel_stop
 10708: 000c41dc     0 NOTYPE  GLOBAL DEFAULT    9 __efi_runtime_rel_stop
__rel_dyn_start
  9791: 000c41dc     0 OBJECT  GLOBAL DEFAULT   10 __rel_dyn_start
  9789: 000c41dc     0 NOTYPE  GLOBAL DEFAULT   10 __rel_dyn_start
__rel_dyn_end
 11708: 000da5f4     0 OBJECT  GLOBAL DEFAULT   10 __rel_dyn_end
 11704: 000da5f4     0 NOTYPE  GLOBAL DEFAULT   10 __rel_dyn_end
image_copy_start
   448: 0000177c     0 NOTYPE  LOCAL  DEFAULT    3 _image_copy_start_ofs
 11797: 00000000     0 OBJECT  GLOBAL DEFAULT    1 __image_copy_start
   445: 0000177c     0 NOTYPE  LOCAL  DEFAULT    3 _image_copy_start_ofs
 11793: 00000000     0 NOTYPE  GLOBAL DEFAULT    1 __image_copy_start
image_copy_end
   450: 00001780     0 NOTYPE  LOCAL  DEFAULT    3 _image_copy_end_ofs
 10225: 000c41dc     0 OBJECT  GLOBAL DEFAULT   10 __image_copy_end
   447: 00001780     0 NOTYPE  LOCAL  DEFAULT    3 _image_copy_end_ofs
 10222: 000c41dc     0 NOTYPE  GLOBAL DEFAULT   10 __image_copy_end
bss_start
    11: 000c41dc     0 SECTION LOCAL  DEFAULT   11 .bss_start
 11124: 000c41dc     0 OBJECT  GLOBAL DEFAULT   11 __bss_start
 11120: 000c41dc     0 NOTYPE  GLOBAL DEFAULT   11 __bss_start
bss_end
    13: 000cbbf8     0 SECTION LOCAL  DEFAULT   13 .bss_end
 10442: 000cbbf8     0 OBJECT  GLOBAL DEFAULT   13 __bss_end
 10439: 000cbbf8     0 NOTYPE  GLOBAL DEFAULT   11 __bss_end

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

Changes since v2:
- Preserve the .bss alignment since it's needed by some C runtime setup code.
  The sdram .bss region for armv8 SPL is defined by a Kconfig option, so instead
  of aligning it explicitly assert if the Kconfig symbol is not 8b aligned
- Align image_copy_end on patch #6. Richard I kept you r-b since that change was
  minimal, but some code assume the dtb will be appended which requires alignment.
  Please yell if you see something wrong
- Added comments based on Richards review on why bss_start - bss_end needs
  to be divided by 4/8 (for armv7/8 respectively)
Changes since v1:
- bring back overlays for armv7 rel.dyn and bss sections and add a comment
  explaining why we overlay those
- Remove redundant alignment from sections (new patch #7)
- Added r-b tags from Sam
Changes since RFC:
- Rebase on top of -next and get rid of the dragonboard linker script changes.
  Caleb removed that file completely
- Rewrite some commit messages to include the binutils bug details (thanks Sam)

Ilias Apalodimas (7):
  arm: baltos: remove custom linker script
  arm: clean up v7 and v8 linker scripts for bss_start/end
  arm: fix __efi_runtime_rel_start/end definitions
  arm: clean up v7 and v8 linker scripts for __rel_dyn_start/end
  arm: fix __efi_runtime_start/end definitions
  arm: move image_copy_start/end to linker symbols
  arm: remove redundant section alignments

 arch/arm/cpu/armv8/u-boot-spl.lds           |  29 ++---
 arch/arm/cpu/armv8/u-boot.lds               |  43 ++-----
 arch/arm/cpu/u-boot-spl.lds                 |   2 +-
 arch/arm/cpu/u-boot.lds                     |  72 +++--------
 arch/arm/lib/sections.c                     |  10 --
 arch/arm/mach-aspeed/ast2600/u-boot-spl.lds |   2 +-
 arch/arm/mach-rockchip/u-boot-tpl-v8.lds    |  23 ++--
 arch/arm/mach-zynq/u-boot-spl.lds           |   2 +-
 arch/arm/mach-zynq/u-boot.lds               |  67 +++-------
 board/vscom/baltos/u-boot.lds               | 128 --------------------
 include/asm-generic/sections.h              |   3 +
 lib/efi_loader/efi_runtime.c                |   1 +
 12 files changed, 72 insertions(+), 310 deletions(-)
 delete mode 100644 board/vscom/baltos/u-boot.lds

--
2.37.2

