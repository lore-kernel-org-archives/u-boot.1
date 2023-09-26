Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D95E7E63C
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 14:16:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69D9486DE6;
	Tue, 26 Sep 2023 16:15:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Cak3c+W3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 769C286DD8; Tue, 26 Sep 2023 16:15:42 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E78F86DE1
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 16:15:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3512c09355fso18019315ab.0
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695737731; x=1696342531; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WdWWHbgI1K/uRzUjUMvRq4JGqVeNMIw2RJbvFszR1Xk=;
 b=Cak3c+W37aAsqWkjGZO6H15jXS7anUMY4lJ3RL1vppqBSqhzdA3SVw0scZywSJ3m4o
 GprCJ69h1C2Wrj/h7Ahybz6fUg9qPRGLvHTWuGIpeWI/Dp7pmo9RoZBaTlaJI/uyYQGD
 ycVt6eLCF2K+nlU/no/Gf0qvdulHSMQ/pdrGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695737731; x=1696342531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WdWWHbgI1K/uRzUjUMvRq4JGqVeNMIw2RJbvFszR1Xk=;
 b=hEFWi0q6yvqsdLdfbGJz236PuCyVXnaK3nAkXAReMAuqMYo3Q7q51mgm+A2hutWr3S
 fGP6SowQAyRznAwxzA8pZ6/VK1yuAyM6xNzkFQ8Si7/F+BGprVz8l/c8Xhb9uIcrIuVJ
 MDBhKyRyQ8lmxdJkk/hgjsM0hxKItPwWk0E+AlKgjRNyF495nEnu/2991vEvQBx0ZYag
 LmuL+ktD+9AqUQgveDue9LBREgqYLxEQEcPoCTcWmHNMWJmAd5HX2q/v2tIM1FIlf6Vl
 Twxv33gVp7TKKBU2/PH3SvxYQqYEiAMyXLpg21PwJINXXwyZnhMN1icjAEfHb68uOJw3
 Xlzw==
X-Gm-Message-State: AOJu0YyXw3m00fKgP1vcb0Cvx8EKiD+G9vwyrTwI6kymBnVtZ1Fbk1MX
 LLl/SBkHWDSfrYhrcQqpEFcMQB+Fml/Ei9+BUH8=
X-Google-Smtp-Source: AGHT+IEYyLMD1yeF+dPTehpcBAaO3eyRWDNjSUwtgIlx6a9ZEVfqbkKwUuMVlVTIAerPDF9zMhok6g==
X-Received: by 2002:a05:6e02:1b89:b0:350:f352:4853 with SMTP id
 h9-20020a056e021b8900b00350f3524853mr11939861ili.25.1695737731066; 
 Tue, 26 Sep 2023 07:15:31 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 dp1-20020a0566381c8100b0043193e32c78sm3256764jab.152.2023.09.26.07.15.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 07:15:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 08/44] spl: Drop the switch() statement for OS selection
Date: Tue, 26 Sep 2023 08:14:22 -0600
Message-ID: <20230926141514.2101787-9-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230926141514.2101787-1-sjg@chromium.org>
References: <20230926141514.2101787-1-sjg@chromium.org>
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

