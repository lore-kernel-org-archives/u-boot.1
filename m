Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF70DC7115B
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 08:08:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FE0D81F66;
	Mon, 23 Jun 2025 10:08:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sOd2uOEd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A94A80548; Mon, 23 Jun 2025 10:08:46 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D46682D21
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 10:08:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-451dbe494d6so44819045e9.1
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 01:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750666124; x=1751270924; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+3K9n7vI7ppHxwELcQVmoSrjRIdZr78n/1C+bQ7ZSfk=;
 b=sOd2uOEdeBXHlFcE99W3KxaG1SSnHz4VM5dYzZiLF2PAW3uokFoV0wKCpnkiGgKq7R
 BBrkjPyAblsh4+NGdrb3ABc+/j2FQGeG9eumZjjCRoCeisogCB+cV+AoFICTMhDDUZDh
 a5FiSHadIF1MmF4OWoP0OHdTGeJyOry6bXRX/ATB0w93Y4RD4bBYdSBKbSoAeVGK+/+B
 V0bxKygigt/VvJGR/CvzWbNtPtbZPwXbP5F/THYEeCISedfGbUa68u0du3b8fqwSIqml
 o1Sl+DLzlwqP1LhXZKsKLCgXrW+d63TbqUFZoYrJreXV3zHdrPcNlyTv2pNKT8RKx0QH
 SENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750666124; x=1751270924;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+3K9n7vI7ppHxwELcQVmoSrjRIdZr78n/1C+bQ7ZSfk=;
 b=j9hB/R9EJQ5bPvzdSE9Qtzbj9/JVovR9AiHr0fXH4c3nURybCJqGL7Ytskcu8f4YEb
 KO5JZjGPbjTntz3Id/ZO7z7jo2AZ/ieAq+daIHN6Vk/zcXQnhURVOGax0tU4LnbHzvgM
 AL920WgLOAJc+2HGuDg1B07o8Al/s9YIcVX0DKWzK3Rdw5Wg+e5RyXy2d9Vo2vd5NMlc
 TT8AEMmJLGIveVunvjMyaSK8Td7hCNt1TxKtOatA64yS0egnYlxmHguDUmv2id7dMHW2
 ZDZdZg56pJAZhlb9EITy1EHeCZFMETs2C3lNijKjo0v8gxZ0Oezgatgp173fXFgjaO6L
 5KcQ==
X-Gm-Message-State: AOJu0YwnSnwIyfXYg8ECaFNr2oQ5ZQKHySE+LEl/bzBKEpmqw2UMI8zc
 ujW7Y5lGOP5/QG5IgkAtKA7NbdEkBcP7UqIh15dkIa3gG+bmD7BXaPkOKNOmrE2CvhxNpV1r00N
 N1mA/Fl4=
X-Gm-Gg: ASbGncvywbrtnZd+MgYqAoGzF0zRJJFVt36Frd3rCVRikuFMMuijxlKdZ7Yye9+jaRk
 AXvVGmBBJu/7k1IkoAObo2wEvWt/pbx3d1dJiuJIFED8C3aL37Dk6Rh9Ks41LTX6fekoZLxZk3a
 zTO/7OoHFs2TnskDNIx0eHRyv/44YZZ9XGDNSTZv49iF/sDdgVw6GbG+Fe8lCShHOT02oCaHUbz
 44o5dC1LdEFkVekIqHc6p6sfYCZHGLFz8l2F9WGqWBW1OHO4IjGe53UpRf5WNNyMxe2sUdlvzh8
 0mlne5WuibVCgPjMFBYzmzde0VaBNOUOWC158gbKj5G3nnjpKDy6Y99jSqrnlOavDTcaOE6pnhA
 4o01sIQ==
X-Google-Smtp-Source: AGHT+IFItqLKSnJ+zXQGnBNLZZjHTnlJA0THtFHkgwAdBQA+TtAXjDexopOWVi19yhIFumoH8JVemw==
X-Received: by 2002:a05:600c:3b84:b0:441:b698:3431 with SMTP id
 5b1f17b1804b1-453659ec191mr93294795e9.28.1750666123616; 
 Mon, 23 Jun 2025 01:08:43 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d117c6a7sm8939563f8f.51.2025.06.23.01.08.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 01:08:43 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Tony Dinh <mibodhi@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm: kirkwood: fix freeze on boot
Date: Mon, 23 Jun 2025 10:08:16 +0200
Message-ID: <20250623080823.2163074-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
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

Commit 6fe50e395080 ("arm: asm/system.h: mrc and mcr need .arm if
__thumb2__ is not set") is not a proper fix for the LTO link error
mentioned in its description. It causes 32-bit arm instructions to be
mixed with thumb instructions, which the Kirkwood SoCs do not support.
For example, board_init_r() is mostly generated in Thumb-1 mode as
expected since the build flags contain -mthumb -mthumb-interwork. The
MCR instruction corresponding to writefr_extra_feature_reg() is also
correcly emitted as a 32-bit ARM instruction (it cannot be encoded in
Thumb-1 anyways). The problem is, the compiler inlines the MCR without
generating the BX or BLX instruction which are needed to transition
between the ARM and the Thumb-1 states. From the objdump output:

006186a0 <board_init_r>:
board_init_r():
/home/jerome/work/u-boot/common/board_r.c:799
  6186a0:       b5f0            push    {r4, r5, r6, r7, lr}
  6186a2:       b0ab            sub     sp, #172        @ 0xac
get_gd():
/home/jerome/work/u-boot/./arch/arm/include/asm/global_data.h:127
  6186a4:       464a            mov     r2, r9
...
/home/jerome/work/u-boot/arch/arm/mach-kirkwood/cpu.c:242
  619aae:       9b15            ldr     r3, [sp, #84]   @ 0x54
writefr_extra_feature_reg():
/home/jerome/work/u-boot/./arch/arm/include/asm/arch/cpu.h:100
  619ab0:       ee2f3f11        mcr     15, 1, r3, cr15, cr1, {0}
                ^^^^^^^^
                32-bit ARM instruction

Further investigation is needed to understand how to fix the issue so
that the code size is minimal for all boards. In the mean time, this
fix disables LTO for the two problematic files (common/board_f.c and
common/board_r.c). This makes the Kirkwood-based boards bootable again.
The binary size is increased by 1048 bytes which is perfectly
acceptable.

Fixes: 6fe50e395080 ("arm: asm/system.h: mrc and mcr need .arm if __thumb2__ is not set")
Reported-by: Tony Dinh <mibodhi@gmail.com>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

 common/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/common/Makefile b/common/Makefile
index 35991562a12..f0b7eadf7d2 100644
--- a/common/Makefile
+++ b/common/Makefile
@@ -19,6 +19,8 @@ obj-y += version.o
 # # boards
 obj-y += board_f.o
 obj-y += board_r.o
+CFLAGS_REMOVE_board_f.o := $(LTO_CFLAGS)
+CFLAGS_REMOVE_board_r.o := $(LTO_CFLAGS)
 obj-$(CONFIG_DISPLAY_BOARDINFO) += board_info.o
 obj-$(CONFIG_DISPLAY_BOARDINFO_LATE) += board_info.o
 
-- 
2.43.0

base-commit: 1be8d14c85bdb4623262259d3fc61c32aca97660
branch: kirkwood-fix
