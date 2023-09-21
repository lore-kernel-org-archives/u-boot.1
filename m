Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2397CD4938
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:58:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3782286D0C;
	Thu, 21 Sep 2023 03:58:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WvdU9abs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C19486D90; Thu, 21 Sep 2023 03:57:59 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19A5A86C68
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:57:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-77ac14ff51bso20257539f.3
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695261470; x=1695866270; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4zoLuQcXyoYCk6ByOF8q9m2fNbeMpze570xVRdNuBbU=;
 b=WvdU9abs/9i2+MUsDaeGbk/158g2zBjIlg+hu8l6pxM6ytds3jQDe0T7UKGi1eR3oR
 64/0hljkz9A3GU5gJKQseNVlVUG4JP8Iqlf2XKvonxvCGDxdGd3Cbwerz/r9x/3dYS/F
 +nuj6abU9gaeNt+Zwi8yPA39jjNzK/0TjT/bA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695261470; x=1695866270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4zoLuQcXyoYCk6ByOF8q9m2fNbeMpze570xVRdNuBbU=;
 b=YNPn3r6zD7CPZnFtNcDgw9eXClvnpFyeXc2ZFai9migXfclWiB4Cm8lCsClRw2PEa3
 IPpxfdXym2YL+m/kMponmDj949jQBve7xAXgH5p1yih2j1tpS3iOuXhvyyFmJb4QplMv
 Rodg2aMa9H3rJa4FQmYQdHf0ZkrdhFUZ1XqrGoDTN4nMm4nAXMpY/MayrmKja35l++XO
 miFaa7BbXncYVeEwa5JJ1WzMu6aEkOD7eTa2qVykNSi7uDsBk+Dl1yb56d5m0zTvppq0
 /DP/CRc3AysDbl+/VOftatTWJYE9iish9Ym+p5wyiUSZRh2XjMBaWDGEkZvGHOKV6ZdV
 zvSw==
X-Gm-Message-State: AOJu0Yzxu8fX+YXJ5vEWBNZr3GweR0xkVZ8ftzHx0vmb/jdIjoJdlt3i
 lIMacryXLV+pBEJiXirGwrHoBDgDsGPE4J62enA=
X-Google-Smtp-Source: AGHT+IF3Lv4ZTh2MqvXMBzL16Cj9fmPielQIPlhWxt7EqlD/XhM4xpLBP3qShUrbCoPPSyILOurIOA==
X-Received: by 2002:a92:3005:0:b0:34d:e998:fb4f with SMTP id
 x5-20020a923005000000b0034de998fb4fmr4031840ile.10.1695261470661; 
 Wed, 20 Sep 2023 18:57:50 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 y4-20020a02c004000000b00437c3a7b49dsm85317jai.156.2023.09.20.18.57.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 18:57:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Nikhil M Jain <n-jain1@ti.com>, Ovidiu Panait <ovpanait@gmail.com>,
 Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 08/32] spl: Drop the switch() statement for OS selection
Date: Wed, 20 Sep 2023 19:56:57 -0600
Message-ID: <20230921015730.1511373-9-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230921015730.1511373-1-sjg@chromium.org>
References: <20230921015730.1511373-1-sjg@chromium.org>
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

(no changes since v1)

 common/spl/spl.c | 32 ++++++++++----------------------
 include/spl.h    |  9 +++++++++
 2 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 703f45cd8044..8511c66d7394 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -748,7 +748,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 		BOOT_DEVICE_NONE,
 	};
 	struct spl_image_info spl_image;
-	int ret;
+	int ret, os;
 
 	debug(">>" SPL_TPL_PROMPT "board_init_r()\n");
 
@@ -841,39 +841,27 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
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
 		if (IS_ENABLED(CONFIG_SPL_OS_BOOT))
 			spl_fixup_fdt((void *)SPL_PAYLOAD_ARGS_ADDR);
 		spl_board_prepare_for_linux();
 		jump_to_image_linux(&spl_image);
-#endif
-	default:
+	} else {
 		debug("Unsupported OS image.. Jumping nevertheless..\n");
 	}
 #if CONFIG_VAL(SYS_MALLOC_F_LEN) && !defined(CONFIG_SPL_SYS_MALLOC_SIZE)
diff --git a/include/spl.h b/include/spl.h
index d16cea3ea50b..60b55b75195b 100644
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
2.42.0.515.g380fc7ccd1-goog

