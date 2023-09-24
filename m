Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDAC1CE7A8C
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 19:26:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7CF986B88;
	Sun, 24 Sep 2023 21:26:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZuPCGydR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8131B86B09; Sun, 24 Sep 2023 21:26:07 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E952686B26
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 21:25:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3513dcd38ebso1701915ab.1
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 12:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695583554; x=1696188354; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XR97DPedoFptkO2rXaf6B+4khvNmxK7T4QxDydmDbzU=;
 b=ZuPCGydRJj9n8nxgxDlDGDXo5fZaQPebT/vkcITKFr6eICKsR2U8J77QCQfaFkTUaz
 xvSgzI4LKV/Mofw6LlTFHVV0vNl70lRHElFHM9WCXyvObR6egDxjU+xxnQf7IEmoRKYz
 VfNrVnV2pMzsxdb27ZwrHmLJqjnk5ZZEGRKVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695583554; x=1696188354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XR97DPedoFptkO2rXaf6B+4khvNmxK7T4QxDydmDbzU=;
 b=iOAER4wnBTgCl/C+xLJscNuDiwaOJnmQkrv9e3RXEU5S6tefxP74K1ztAdXR8TI++j
 XYf1tUxLE+QA3nUJKGeDSSDb23O6lvnw/2kGro18Qk5OS5LW4cjY9fFNtVd6gxpKrrEI
 d04lElUigu7H4RaH7Fy0CjrD1L7OlaxQxoGSzMWW3eNYqBsaFKuw32lnxFRHV+BDGmP5
 YGlkSc5v/9FhKfqLNigNqBTGarBjmmnc4vr9O2HZrNR8lAmrWrf9Bl+zJoA/zGMMuVkk
 VOTDBJeG5iVPmx0LnS2XNg6e3DPqwUJRI/UqXnPkwYZZ2cZu4AN4YT6PP4BwqdWWrfBZ
 zAPA==
X-Gm-Message-State: AOJu0YxbVKrk7BS4DRGnwi3TViyJgSOwyN/wKPsJuaSUC3WUorXKiTlh
 6VvDrGlixycCNub/vSe2IPBDsxLELgFUjdF0ViY=
X-Google-Smtp-Source: AGHT+IGaFjWur4ls+lT/QQbPGvxeKbinLFm005+fsu+AyvELyCk+z8px0jhUXdK/dDRuCCKPR6pnqg==
X-Received: by 2002:a05:6e02:1a46:b0:34c:c0ad:69e0 with SMTP id
 u6-20020a056e021a4600b0034cc0ad69e0mr7206315ilv.1.1695583554598; 
 Sun, 24 Sep 2023 12:25:54 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 do25-20020a0566384c9900b0043a11ec6517sm2321702jab.171.2023.09.24.12.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 12:25:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng@tinylab.org>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>, Nikhil M Jain <n-jain1@ti.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH v3 06/38] spl: Avoid #ifdef with CONFIG_SPL_PAYLOAD_ARGS_ADDR
Date: Sun, 24 Sep 2023 13:24:51 -0600
Message-ID: <20230924192536.1812799-7-sjg@chromium.org>
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

Move the condition to the header file to improve readability.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Change the approach to use the header file

 common/spl/spl.c           | 10 ++++------
 include/system-constants.h |  7 +++++++
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 68e58c930c28..117a6c7952eb 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -810,9 +810,8 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 	}
 
 	memset(&spl_image, '\0', sizeof(spl_image));
-#ifdef CONFIG_SPL_PAYLOAD_ARGS_ADDR
-	spl_image.arg = (void *)CONFIG_SPL_PAYLOAD_ARGS_ADDR;
-#endif
+	if (IS_ENABLED(CONFIG_SPL_OS_BOOT))
+		spl_image.arg = (void *)SPL_PAYLOAD_ARGS_ADDR;
 	spl_image.boot_device = BOOT_DEVICE_NONE;
 	board_boot_order(spl_boot_list);
 
@@ -869,9 +868,8 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 #if CONFIG_IS_ENABLED(OS_BOOT)
 	case IH_OS_LINUX:
 		debug("Jumping to Linux\n");
-#if defined(CONFIG_SPL_PAYLOAD_ARGS_ADDR)
-		spl_fixup_fdt((void *)CONFIG_SPL_PAYLOAD_ARGS_ADDR);
-#endif
+		if (IS_ENABLED(CONFIG_SPL_OS_BOOT))
+			spl_fixup_fdt((void *)SPL_PAYLOAD_ARGS_ADDR);
 		spl_board_prepare_for_linux();
 		jump_to_image_linux(&spl_image);
 #endif
diff --git a/include/system-constants.h b/include/system-constants.h
index dca6a86b01f5..59371568d1e7 100644
--- a/include/system-constants.h
+++ b/include/system-constants.h
@@ -34,4 +34,11 @@
 #define SPL_SYS_MALLOC_SIZE	\
 	IF_ENABLED_INT(CONFIG_SPL_SYS_MALLOC, CONFIG_SPL_SYS_MALLOC_SIZE)
 
+/* deal with an optional value */
+#ifdef CONFIG_SPL_OS_BOOT
+#define SPL_PAYLOAD_ARGS_ADDR	CONFIG_SPL_PAYLOAD_ARGS_ADDR
+#else
+#define SPL_PAYLOAD_ARGS_ADDR	0
+#endif
+
 #endif
-- 
2.42.0.515.g380fc7ccd1-goog

