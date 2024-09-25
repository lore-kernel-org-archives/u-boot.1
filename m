Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6448C7882B
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 13:02:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6948088D97;
	Wed, 25 Sep 2024 14:58:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E03E0LQm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E767D88D90; Wed, 25 Sep 2024 14:58:27 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEC7B88363
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 14:58:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a8a7cdfdd80so928642566b.0
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 05:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727269102; x=1727873902; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d00WcisEnw15cX/0RKtXUhN6bJgj1ZG6VjQC0Qeqdu8=;
 b=E03E0LQmND3XNIHLX8aIEoGpT4ehtxjdYTGMTbqCHHjThA6ThZFpsV/qLJpmLG1fFG
 y/YlKAhhCsORMvgD4JhaO3GcvxFMA5l8ewiRyXBlq3W6zDYzWFuwpJBOMyiUc235KHSK
 lc1e8/QdIKPtIBxmr7SXUpjZ88aC/VZrY3WjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727269102; x=1727873902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d00WcisEnw15cX/0RKtXUhN6bJgj1ZG6VjQC0Qeqdu8=;
 b=cP4abGlcp/J7cKAu113tnVqumo5i1Jg+jxXUsnEXT3uQz1J5C+KltiGJjH/9Dgjzds
 00nnCP5yWAWJGq2bhvWPAdCM38PgGsNTRZ6fNTCBh7nUVqjehY2lvowbAmZrQonvGuQG
 FurAv3JAo9Mrjz1qvz5T4B2Tgoi+viYopPwjfFDnREbSNSioSJl9JuVMcLFYJDpWVJDZ
 FC+SP2IXNq/PsWv1w3kWaKNQpWkUYRcqVBHXch3992B/M96E9uH4H7QxRvOZU0LMFjXi
 AWlQsVWpo7pC8wZM8biVlk5sFtsnT4bwEowXAiLC8IXSOTedAB+TYA+7CNgSCFhAQ7FX
 +zOw==
X-Gm-Message-State: AOJu0YykTFJiiQ83/Nqr/urfcTMMkpiJJASEtlnMJXZACTsrFvIwXabF
 9U4UUmSqTrdg1ChqGEzqxcE2rrHp7C43z6gBs1b0lZs+URMl3r3TbidRSvIykKfiFwItVZPVrPp
 wSA==
X-Google-Smtp-Source: AGHT+IHcu222+gpKTrk9CegMgswZoUTNFQao1lnIv+MEjOtlLkL6IFtfI1DQWHWhezo3DYUwFuapjQ==
X-Received: by 2002:a17:907:eac:b0:a8d:29b7:ecea with SMTP id
 a640c23a62f3a-a93a0667b22mr225713266b.61.1727269102069; 
 Wed, 25 Sep 2024 05:58:22 -0700 (PDT)
Received: from chromium.org ([82.132.187.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93930f7889sm209209766b.179.2024.09.25.05.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 05:58:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH 18/19] arm: qemu_arm64_tpl: Enable the relocating loader
Date: Wed, 25 Sep 2024 14:55:44 +0200
Message-ID: <20240925125622.197915-19-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925125622.197915-1-sjg@chromium.org>
References: <20240925125622.197915-1-sjg@chromium.org>
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

Move SPL to start in the RAM region, using the relocating loader to copy
it there and run from there.

Add a simple test to make sure this works as expected.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/dts/qemu-arm64.dts      |  1 -
 board/emulation/qemu-arm/xpl.c   | 15 +++++++++++++++
 configs/qemu_arm64_tpl_defconfig |  3 ++-
 test/py/tests/test_reloc.py      | 21 +++++++++++++++++++++
 4 files changed, 38 insertions(+), 2 deletions(-)
 create mode 100644 test/py/tests/test_reloc.py

diff --git a/arch/arm/dts/qemu-arm64.dts b/arch/arm/dts/qemu-arm64.dts
index de943642e76..098992f5da8 100644
--- a/arch/arm/dts/qemu-arm64.dts
+++ b/arch/arm/dts/qemu-arm64.dts
@@ -15,7 +15,6 @@
 
 		u-boot-spl {
 			symbols-base = <0>;
-			offset = <CONFIG_SPL_TEXT_BASE>;
 		};
 
 		u-boot {
diff --git a/board/emulation/qemu-arm/xpl.c b/board/emulation/qemu-arm/xpl.c
index ec59e0ff327..aa002ebcc90 100644
--- a/board/emulation/qemu-arm/xpl.c
+++ b/board/emulation/qemu-arm/xpl.c
@@ -20,12 +20,27 @@ static int binman_load_image(struct spl_image_info *img,
 {
 	ulong base = spl_get_image_pos();
 	ulong size = spl_get_image_size();
+	ulong spl_load_addr;
+	int ret;
 
 	log_debug("Booting from address %lx size %lx\n", base, size);
 	img->name = spl_phase_name(spl_next_phase());
 	img->load_addr = base;
 	img->entry_point = base;
 
+	if (CONFIG_IS_ENABLED(RELOC_LOADER)) {
+		img->size = size;
+		spl_set_fdt_size(img, 0);
+		ret = spl_reloc_prepare(img, &spl_load_addr);
+		if (ret)
+			return log_msg_ret("rel", ret);
+		log_debug("Loading to %lx\n", spl_load_addr);
+		memcpy(map_sysmem(spl_load_addr, size),
+		       map_sysmem(base, size), size);
+		img->load_addr = CONFIG_SPL_TEXT_BASE;
+		img->entry_point = CONFIG_SPL_TEXT_BASE;
+	}
+
 	return 0;
 }
 SPL_LOAD_IMAGE_METHOD("binman", 0, BOOT_DEVICE_BOARD, binman_load_image);
diff --git a/configs/qemu_arm64_tpl_defconfig b/configs/qemu_arm64_tpl_defconfig
index f09e357e5cc..5f506d2b553 100644
--- a/configs/qemu_arm64_tpl_defconfig
+++ b/configs/qemu_arm64_tpl_defconfig
@@ -9,7 +9,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x40200000
 CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DEFAULT_DEVICE_TREE="qemu-arm64"
-CONFIG_SPL_TEXT_BASE=0x6000
+CONFIG_SPL_TEXT_BASE=0x40100000
 CONFIG_TARGET_QEMU_ARM_64BIT_TPL=y
 CONFIG_SPL_BSS_MAX_SIZE=0x10000
 CONFIG_DEBUG_UART_BASE=0x9000000
@@ -35,6 +35,7 @@ CONFIG_USE_PREBOOT=y
 CONFIG_PCI_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x10000
 # CONFIG_SPL_SEPARATE_BSS is not set
+CONFIG_TPL_RELOC_LOADER=y
 CONFIG_CMD_SMBIOS=y
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_BOOTEFI_SELFTEST=y
diff --git a/test/py/tests/test_reloc.py b/test/py/tests/test_reloc.py
new file mode 100644
index 00000000000..82913194fba
--- /dev/null
+++ b/test/py/tests/test_reloc.py
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2024 Google LLC
+# Written by Simon Glass <sjg@chromium.org>
+
+import pytest
+
+@pytest.mark.buildconfigspec('target_qemu_arm_64bit_tpl')
+def test_reloc_loader(u_boot_console):
+    try:
+        cons = u_boot_console
+        # x = cons.restart_uboot()
+        output = cons.get_spawn_output().replace('\r', '')
+        assert 'spl_reloc TPL->SPL' in output
+        assert 'Loading to 40100200' in output
+
+        # Sanity check that it is picking up the correct environment
+        board_name = cons.run_command('print board_name')
+        assert board_name == 'board_name="qemu-arm64_tpl"'
+    finally:
+        # Restart afterward to get the normal U-Boot back
+        u_boot_console.restart_uboot()
-- 
2.43.0

