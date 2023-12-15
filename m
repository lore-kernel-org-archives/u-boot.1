Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B7CC4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 04:20:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34A2B87B46;
	Fri, 15 Dec 2023 05:19:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DTnZsLCL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6FB887AEC; Fri, 15 Dec 2023 05:19:34 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E2EE87AE6
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 05:19:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6d9d84019c5so266814a34.3
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 20:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702613971; x=1703218771; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k2lOOuEzycbKJc6a2CuFfwtNI0BFTM35wRHtzHB1oQw=;
 b=DTnZsLCLzuY8NYgIxJVGyK8DLCOrVuB68M7W3ApRZ7oNkzTb5zwhcfh9TXjUJ4pBBm
 N8WXvWlgt0ryyWj0MXqDX3PdimFwogEQ3ZSk5i3nLjeTGQm+nsC+u2CkH45Lac6Q60aH
 UVHPxDZeY/q8bDAgFGXHFNVSsWQwKR0vRkh/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702613971; x=1703218771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k2lOOuEzycbKJc6a2CuFfwtNI0BFTM35wRHtzHB1oQw=;
 b=lNG0GAGbOK/dI0y0h3rU1RGgqZLNE96MeDy3O9dzX2End9OBEOUoI4/DimgRPYkyIq
 iW4iFkQRg3RT/WYWTGAFRigUU4o84GXxDGBNBAB7h6FL8isQwVVuvu8u4+PbfkdtDIeh
 qIX9Ys46W7Ow/ZJLt3UUdVuSS/bAHLLbDF8ObCAa0Q5vuW66+FHzMhGN0QHETG6iyzbl
 A7oXR8b4KeVcClL8KknkYs2/u803ROUOp1QtYIWuk1Uk//Aep2dS7T+LCguaO3c1qokn
 l4DXf0l4OfR+xpLBojAxuo9TDAuWz4CaqdwCb4TPyrj56HlM1oZKoyW/9X8S1d2AltiB
 jGdA==
X-Gm-Message-State: AOJu0YydwpJuLHv2na93E9hZBFbT0CKfLvE8yF92C1a+D11EGWCCEaMg
 C7DCvUMqc6SGbwYhaDU+Y0NEYzp/Q4uOW8VS1+4plQ==
X-Google-Smtp-Source: AGHT+IEi+xvjypGnO4N4auqr2b+qjXK9cknhOXXxFPwq+7d8+4JzMftIY7lLXMn6q1ZIuLZGYZkH+w==
X-Received: by 2002:a05:6808:ec7:b0:3b8:b063:825f with SMTP id
 q7-20020a0568080ec700b003b8b063825fmr12576894oiv.97.1702613970777; 
 Thu, 14 Dec 2023 20:19:30 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 be15-20020a056808218f00b003b898ffd8fcsm3601492oib.50.2023.12.14.20.19.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 20:19:30 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Angelo Dureghello <angelo@kernel-space.org>, Bin Meng <bmeng.cn@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Huan Wang <alison.wang@nxp.com>, Leo <ycliang@andestech.com>,
 Marek Vasut <marex@denx.de>, Max Filippov <jcmvbkbc@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Rick Chen <rick@andestech.com>,
 Sean Anderson <sean.anderson@seco.com>, Thomas Chou <thomas@wytron.com.tw>,
 Yu Chien Peter Lin <peterlin@andestech.com>, uboot-snps-arc@synopsys.com
Subject: [PATCH v2 04/16] treewide: Make arch-specific bootm code depend on
 BOOTM
Date: Thu, 14 Dec 2023 21:19:02 -0700
Message-ID: <20231215041919.2197788-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231215041919.2197788-1-sjg@chromium.org>
References: <20231215041919.2197788-1-sjg@chromium.org>
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

Allow these functions to be compiled in when CONFIG_BOOTM is enabled,
even if CONFIG_CMD_BOOTM is not.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arc/lib/Makefile        | 2 +-
 arch/arm/lib/Makefile        | 2 +-
 arch/m68k/lib/Makefile       | 2 +-
 arch/microblaze/lib/Makefile | 2 +-
 arch/mips/lib/Makefile       | 2 +-
 arch/nios2/lib/Makefile      | 2 +-
 arch/powerpc/lib/Makefile    | 2 +-
 arch/riscv/lib/Makefile      | 2 +-
 arch/sandbox/lib/Makefile    | 2 +-
 arch/sh/lib/Makefile         | 2 +-
 arch/x86/lib/Makefile        | 2 +-
 arch/xtensa/lib/Makefile     | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arc/lib/Makefile b/arch/arc/lib/Makefile
index 0eb44bcf33d0..bde1c3d8af3a 100644
--- a/arch/arc/lib/Makefile
+++ b/arch/arc/lib/Makefile
@@ -12,6 +12,6 @@ obj-y += reset.o
 obj-y += ints_low.o
 obj-y += init_helpers.o
 
-obj-$(CONFIG_CMD_BOOTM) += bootm.o
+obj-$(CONFIG_BOOTM) += bootm.o
 
 lib-$(CONFIG_USE_PRIVATE_LIBGCC) += _millicodethunk.o libgcc2.o
diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index b1bcd3746625..b20a467f684c 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -31,7 +31,7 @@ endif
 obj-$(CONFIG_CPU_V7M) += cmd_boot.o
 obj-$(CONFIG_OF_LIBFDT) += bootm-fdt.o
 obj-$(CONFIG_CMD_BOOTI) += bootm.o image.o
-obj-$(CONFIG_CMD_BOOTM) += bootm.o
+obj-$(CONFIG_BOOTM) += bootm.o
 obj-$(CONFIG_CMD_BOOTZ) += bootm.o zimage.o
 else
 obj-$(CONFIG_$(SPL_TPL_)FRAMEWORK) += spl.o
diff --git a/arch/m68k/lib/Makefile b/arch/m68k/lib/Makefile
index 6e1fd938f526..5ccd9545cb5c 100644
--- a/arch/m68k/lib/Makefile
+++ b/arch/m68k/lib/Makefile
@@ -8,7 +8,7 @@
 lib-$(CONFIG_USE_PRIVATE_LIBGCC) += lshrdi3.o muldi3.o ashldi3.o ashrdi3.o
 
 obj-y	+= bdinfo.o
-obj-$(CONFIG_CMD_BOOTM) += bootm.o
+obj-$(CONFIG_BOOTM) += bootm.o
 obj-y	+= cache.o
 obj-y	+= interrupts.o
 obj-y	+= time.o
diff --git a/arch/microblaze/lib/Makefile b/arch/microblaze/lib/Makefile
index dfd8135f4f25..2f234825f804 100644
--- a/arch/microblaze/lib/Makefile
+++ b/arch/microblaze/lib/Makefile
@@ -3,6 +3,6 @@
 # (C) Copyright 2003-2006
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-obj-$(CONFIG_CMD_BOOTM) += bootm.o
+obj-$(CONFIG_BOOTM) += bootm.o
 obj-$(CONFIG_CMD_BDI) += bdinfo.o
 obj-y	+= muldi3.o
diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
index 9ee1fcb5c702..f8e162c53b58 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -10,7 +10,7 @@ obj-y	+= reloc.o
 obj-y	+= stack.o
 obj-y	+= traps.o
 
-obj-$(CONFIG_CMD_BOOTM) += bootm.o
+obj-$(CONFIG_BOOTM) += bootm.o
 obj-$(CONFIG_CMD_GO) += boot.o
 obj-$(CONFIG_SPL_BUILD) += spl.o
 
diff --git a/arch/nios2/lib/Makefile b/arch/nios2/lib/Makefile
index a9f3c7100e72..68a5ca007d55 100644
--- a/arch/nios2/lib/Makefile
+++ b/arch/nios2/lib/Makefile
@@ -4,5 +4,5 @@
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
 obj-y	+= cache.o
-obj-$(CONFIG_CMD_BOOTM) += bootm.o
+obj-$(CONFIG_BOOTM) += bootm.o
 obj-y	+= libgcc.o
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index bb819dcbb6cc..dcce9834927d 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -34,7 +34,7 @@ obj-y	+= ticks.o
 endif
 obj-y	+= reloc.o
 
-obj-$(CONFIG_CMD_BOOTM) += bootm.o
+obj-$(CONFIG_BOOTM) += bootm.o
 obj-y	+= cache.o
 obj-y	+= extable.o
 obj-y	+= interrupts.o
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index 9a05b662fd63..0b2c88db6bad 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -6,7 +6,7 @@
 # Copyright (C) 2017 Andes Technology Corporation
 # Rick Chen, Andes Technology Corporation <rick@andestech.com>
 
-obj-$(CONFIG_CMD_BOOTM) += bootm.o
+obj-$(CONFIG_BOOTM) += bootm.o
 obj-$(CONFIG_CMD_BOOTI) += bootm.o image.o
 obj-$(CONFIG_CMD_GO) += boot.o
 obj-y	+= cache.o
diff --git a/arch/sandbox/lib/Makefile b/arch/sandbox/lib/Makefile
index a2bc5a7ee60f..c4924b23c832 100644
--- a/arch/sandbox/lib/Makefile
+++ b/arch/sandbox/lib/Makefile
@@ -7,5 +7,5 @@
 
 obj-y	+= fdt_fixup.o interrupts.o sections.o
 obj-$(CONFIG_PCI)	+= pci_io.o
-obj-$(CONFIG_CMD_BOOTM) += bootm.o
+obj-$(CONFIG_BOOTM) += bootm.o
 obj-$(CONFIG_CMD_BOOTZ) += bootm.o
diff --git a/arch/sh/lib/Makefile b/arch/sh/lib/Makefile
index e7520a328d54..8c3c30293a3c 100644
--- a/arch/sh/lib/Makefile
+++ b/arch/sh/lib/Makefile
@@ -6,7 +6,7 @@
 extra-y	+= start.o
 
 obj-y	+= board.o
-obj-$(CONFIG_CMD_BOOTM) += bootm.o
+obj-$(CONFIG_BOOTM) += bootm.o
 obj-y	+= time.o
 obj-$(CONFIG_CMD_SH_ZIMAGEBOOT) += zimageboot.o
 
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 8fc35e1b51ea..94aa335ede4c 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -16,7 +16,7 @@ obj-$(CONFIG_X86_32BIT_INIT) += string.o
 endif
 
 ifndef CONFIG_SPL_BUILD
-obj-$(CONFIG_CMD_BOOTM) += bootm.o
+obj-$(CONFIG_BOOTM) += bootm.o
 endif
 obj-y	+= cmd_boot.o
 obj-$(CONFIG_$(SPL_)COREBOOT_SYSINFO)	+= coreboot/
diff --git a/arch/xtensa/lib/Makefile b/arch/xtensa/lib/Makefile
index ad4fe32cb699..bb9157f30f0f 100644
--- a/arch/xtensa/lib/Makefile
+++ b/arch/xtensa/lib/Makefile
@@ -3,6 +3,6 @@
 # (C) Copyright 2007 - 2013 Tensilica Inc.
 # (C) Copyright 2014 - 2016 Cadence Design Systems Inc.
 
-obj-$(CONFIG_CMD_BOOTM) += bootm.o
+obj-$(CONFIG_BOOTM) += bootm.o
 
 obj-y	+= cache.o misc.o relocate.o time.o
-- 
2.43.0.472.g3155946c3a-goog

