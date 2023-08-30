Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434C0C83F15
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 18:06:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C0AD86562;
	Wed, 30 Aug 2023 20:05:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SzwQdw1j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6883186562; Wed, 30 Aug 2023 20:05:57 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B71DA86555
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:05:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-79241bb5807so2842639f.0
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 11:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693418744; x=1694023544; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YR2FIc3Z9vhXBGBA/EviNNLCi16/RrLEJbCIv162gXQ=;
 b=SzwQdw1j31ZCJH8+NU74tG0foHoy0o87yhwT1Ti8TjlVCdU8Dt6TISepzTYnLdpL04
 ff4B1wPMzq80IiP8nTtpW7CZp4ZwPcDGp9pR4wUCIZZnbwPN/5TV9YxzNADqZFNSm6yh
 xhZ+JVIi2dB2eM9jvq5mNhaR6PbNb2mGXeZe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693418744; x=1694023544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YR2FIc3Z9vhXBGBA/EviNNLCi16/RrLEJbCIv162gXQ=;
 b=kWjqCc/joG5R1FWj7widDAMjhtE1nFPupV9t+Idhqb79wIuZEtyugnpGOtX1X5oO4u
 W2UGEpaFRUtNeuST1t5vOWz5th48lgceIcHjLpIkBw1VJXlYaHID+2nYi+avPcE9p7Rq
 wyPOXIyuL4WHAGfN3RzwiADrMxuh4iw1TqbRN+RBESsojvjE+PEmQ91LzimgK4IDkgVu
 rcQ8tEzn8upkSlKdNF+FsNdidcgCJxUZNVb0hYb0hCl0JrlGps/6SholhmDx1u9oAoZw
 qzfMnoZlHbSITl5pyakk8eW/9JfVFbJS2YAwyMn30yHrh2XKPSXWBvHFWvLyH8mbvEYm
 skOA==
X-Gm-Message-State: AOJu0YzDvGLhkyRxndwPdTAGl2Zv9KWvj0ZyWo6vkSqjd46BXgRj77kP
 WdsVQ91/YLkCiJcQZR9d77QemNdhtbL0C0zhbSs=
X-Google-Smtp-Source: AGHT+IGmDRcGTKXyaDLuK6YhTfyUdFmc8wTmmfXHnwtILm2ijEFb0cuggDLcG4mMxUfJ9za5dfZSKg==
X-Received: by 2002:a05:6602:1b10:b0:794:e0fa:84b1 with SMTP id
 dk16-20020a0566021b1000b00794e0fa84b1mr3314872iob.19.1693418744320; 
 Wed, 30 Aug 2023 11:05:44 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
 by smtp.gmail.com with ESMTPSA id
 dk54-20020a0566384bf600b0042bbd3e49b9sm4002224jab.24.2023.08.30.11.05.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 11:05:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nikhil M Jain <n-jain1@ti.com>, Ovidiu Panait <ovpanait@gmail.com>,
 Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 08/32] spl: Drop the switch() statement for OS selection
Date: Wed, 30 Aug 2023 12:04:39 -0600
Message-ID: <20230830180524.315916-9-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230830180524.315916-1-sjg@chromium.org>
References: <20230830180524.315916-1-sjg@chromium.org>
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

This code is pretty ugly, with many #ifdefs

There are quite a lot of IH_OS_U_BOOT values so the compiler struggles
to create a jump table here. Also, most of the options are normally
disabled.

Change it to an else...if construct instead. Add an accessor for the
spl_image field behind an #ifdef to avoid needing #ifdef in the C code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/spl/spl.c | 36 ++++++++++--------------------------
 include/spl.h    |  9 +++++++++
 2 files changed, 19 insertions(+), 26 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 2da5bc0c4f5..f0a90c280da 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -748,7 +748,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 		BOOT_DEVICE_NONE,
 	};
 	struct spl_image_info spl_image;
-	int ret;
+	int ret, os;
 
 	debug(">>" SPL_TPL_PROMPT "board_init_r()\n");
 
@@ -848,32 +848,21 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 			       ret);
 	}
 
-	switch (spl_image.os) {
-	case IH_OS_U_BOOT:
+	os = spl_image.os;
+	if (os == IH_OS_U_BOOT) {
 		debug("Jumping to %s...\n", spl_phase_name(spl_next_phase()));
-		break;
-#if CONFIG_IS_ENABLED(ATF)
-	case IH_OS_ARM_TRUSTED_FIRMWARE:
+	} else if (CONFIG_IS_ENABLED(ATF) && os == IH_OS_ARM_TRUSTED_FIRMWARE) {
 		debug("Jumping to U-Boot via ARM Trusted Firmware\n");
-		spl_fixup_fdt(spl_image.fdt_addr);
+		spl_fixup_fdt(spl_image_fdt_addr(&spl_image));
 		spl_invoke_atf(&spl_image);
-		break;
-#endif
-#if CONFIG_IS_ENABLED(OPTEE_IMAGE)
-	case IH_OS_TEE:
+	} else if (CONFIG_IS_ENABLED(OPTEE_IMAGE) && os == IH_OS_TEE) {
 		debug("Jumping to U-Boot via OP-TEE\n");
-		spl_board_prepare_for_optee(spl_image.fdt_addr);
+		spl_board_prepare_for_optee(spl_image_fdt_addr(&spl_image));
 		jump_to_image_optee(&spl_image);
-		break;
-#endif
-#if CONFIG_IS_ENABLED(OPENSBI)
-	case IH_OS_OPENSBI:
+	} else if (CONFIG_IS_ENABLED(OPENSBI) && os == IH_OS_OPENSBI) {
 		debug("Jumping to U-Boot via RISC-V OpenSBI\n");
 		spl_invoke_opensbi(&spl_image);
-		break;
-#endif
-#if CONFIG_IS_ENABLED(OS_BOOT)
-	case IH_OS_LINUX:
+	} else if (CONFIG_IS_ENABLED(OS_BOOT) && os == IH_OS_LINUX) {
 		debug("Jumping to Linux\n");
 		if (IS_ENABLED(CONFIG_SPL_SYS_ARGS_ADDR)) {
 			ulong addr;
@@ -882,14 +871,9 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 					      CONFIG_SPL_SYS_ARGS_ADDR);
 			spl_fixup_fdt(map_sysmem(addr, 0));
 		}
-	}
-
-#if defined(CONFIG_SPL_SYS_ARGS_ADDR)
-#endif
 		spl_board_prepare_for_linux();
 		jump_to_image_linux(&spl_image);
-#endif
-	default:
+	} else {
 		debug("Unsupported OS image.. Jumping nevertheless..\n");
 	}
 #if CONFIG_VAL(SYS_MALLOC_F_LEN) && !defined(CONFIG_SPL_SYS_MALLOC_SIZE)
diff --git a/include/spl.h b/include/spl.h
index d16cea3ea50..60b55b75195 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -263,6 +263,15 @@ struct spl_image_info {
 #endif
 };
 
+static inline void *spl_image_fdt_addr(struct spl_image_info *info)
+{
+#if CONFIG_IS_ENABLED(LOAD_FIT) || CONFIG_IS_ENABLED(LOAD_FIT_FULL)
+	return info->fdt_addr;
+#else
+	return 0;
+#endif
+}
+
 /**
  * Information required to load data from a device
  *
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

