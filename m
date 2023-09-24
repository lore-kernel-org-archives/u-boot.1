Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA25CE7A8A
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 19:26:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DB8586B7E;
	Sun, 24 Sep 2023 21:26:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SICa/JbS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 598C486B09; Sun, 24 Sep 2023 21:26:07 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDCBA86B29
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 21:25:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-79f989480e0so149029939f.3
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 12:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695583555; x=1696188355; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WdWWHbgI1K/uRzUjUMvRq4JGqVeNMIw2RJbvFszR1Xk=;
 b=SICa/JbS5UjwFie0Yw3yOX8YwQAOkH/Dh7RJrEt8OefTXsq/DZGv4WEX/GhhA6SQwR
 DFYHjdC57+uB/NKBb4ceL4XZDXuLKVyZHPO+o0acnSPPgz5bP4dFqY9eE49ctluOPeix
 GyQA0mL+9PkAOUygoLgklT1kbkiHO6vRlSUSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695583555; x=1696188355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WdWWHbgI1K/uRzUjUMvRq4JGqVeNMIw2RJbvFszR1Xk=;
 b=dZrdG1D7hvTsLAZlq8jQn7uBNk7E3DFDum3eoz7Es/IrpNgO24ffkIsHS3wIa2umnc
 +ZcnsNH8lReoY7r7ImEqdi6ceZzsKrZ3tAlMNfYweSRbwuTuA0YmDoLxnEL9X/Ro4f2L
 ziYZ80FqjAM7OcnSwG+Ej6Kb77XZLEGosytCEha8UGBytXi3BeJwmDobIvXDJ5j4rcVa
 qjDFZcj48tYFf8Wqhr/xB3YUgYywG5vfDaOh0fbEMxULl2TyiJ1B5wKbJzDExUaTgBEm
 2l6FFPMR5ioooNDlU9c5lzKox8R+ir8wsmvq+Yp80w3IO9lLeRv3nAK2cTaoOAXmLJ8M
 Wnfw==
X-Gm-Message-State: AOJu0Yw3PvyXYdWvEyTfytKaEJMEqnb/KwyDOcFlKlr2hbDnqeOQTxyv
 W5i5g+a6RsjE1aRH5bhgFiZAVCsdwwgPjPVlQqk=
X-Google-Smtp-Source: AGHT+IF2HbAzv2oJq2XZZKqQrD08Ia632yNP20cMb3h7QUIB8Yi836rGgXocUoIYMW4xczT5GQKMkw==
X-Received: by 2002:a05:6e02:1c82:b0:351:2104:64f6 with SMTP id
 w2-20020a056e021c8200b00351210464f6mr7648742ill.1.1695583555533; 
 Sun, 24 Sep 2023 12:25:55 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 do25-20020a0566384c9900b0043a11ec6517sm2321702jab.171.2023.09.24.12.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 12:25:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Bin Meng <bmeng@tinylab.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Nikhil M Jain <n-jain1@ti.com>, Ovidiu Panait <ovpanait@gmail.com>,
 Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v3 07/38] spl: Drop the switch() statement for OS selection
Date: Sun, 24 Sep 2023 13:24:52 -0600
Message-ID: <20230924192536.1812799-8-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230924192536.1812799-1-sjg@chromium.org>
References: <20230924192536.1812799-1-sjg@chromium.org>
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
index 117a6c7952eb..e270edb7aade 100644
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

