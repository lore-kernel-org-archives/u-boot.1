Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E9BC02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 01:30:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B29448069D;
	Thu, 16 Jan 2025 02:28:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lH72SjZR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B73688069D; Thu, 16 Jan 2025 02:28:27 +0100 (CET)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 914CE807B3
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 02:28:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3ce8c9a656dso3066035ab.3
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 17:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736990903; x=1737595703; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RW5LeObkM3ySP/L4X9C+MOydjVfskfOkC5P7l4Nfve8=;
 b=lH72SjZRUkM3uvEFnVDbTV9DJJJu6I5dY8vYfIAb8tzVbu2/6phErjkbfg642cXP1K
 7yvnBNRyyxxhrr8N1VoDNioHcaT49S2rQG5neliE/DHemW9QB3Xmip/2ZM/1cvm4SnNK
 2PDUfIERgV4frb122vbd++MhUjOHVhvkwPM4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736990903; x=1737595703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RW5LeObkM3ySP/L4X9C+MOydjVfskfOkC5P7l4Nfve8=;
 b=uBA8QQh9cWum6z9MI3z33snJAMNn0zy5NwSmmWBVSrSBNyCGPwK4pDXlcxI4tdgtW4
 +rAtloIteJSkyaAVvvY6amArFa4mhyZCuFSDjbSQdLTRnkpfdxmXqNItO+U8Bt3os3Z/
 UsQEyYD9HBdJ+WPMp4U66cY6X5xwYz2oLaRzSktw3eeIsKHMlMXWLrRL0q02FF4ZfDhX
 ryFQ/pX/XIQcy9bmoIelNkVOiJ83FkBQDEE4iGvO0hLhOe2Wvmgx0/OBYVYaEzZmCx2/
 gvU6zAtXi+p1wapwPpuO1/nVPC0H1g2XZ9itk99ZAbvDdwNTut3AE3I+5oFYBj72ujQv
 1Eew==
X-Gm-Message-State: AOJu0Yy82CaypEmPGSptPt1NTHib7GYJiH67AsmJNNGoMqJna+nuBdin
 fZDw7hHGI+jIfmWU4I2UUf+SYfecG3Y0sLtEMXhfOIQu/ERp8cZAiIHQXnZQOn06XYwR/LQNgb0
 =
X-Gm-Gg: ASbGncsxKf6fOJymm3jVZiRR5HA64vmq/6gRBpR1W0PsiPnFQY5XR6f857QN8ErqHJ5
 pHk907vbVG1TlPwS4ntIlwBB499wvDQyX403jXsKs5HaoWHBa6XjAvI05/FVMnGBTjHwHrAMElr
 J0Qo48MwxiRQVU518m/IClju/fCrX14LCG97xc8YGU4jDmxnaoi9a/I0iRiXmMbFu5CGStiqUDt
 PaQS9F4Gh+RXvUNY9dVr1z3UZNgxdbyA1zslXlKXXh+a8EHUC7OYYPUKLnAcsTOZzyvP+n/DtIT
 T3Ieod1qQAFr6ITibA==
X-Google-Smtp-Source: AGHT+IFoMeAuviOF/Cb5kLe59Cc1dB/BH77WwF2c6F747cTsM1DPxI1lTeKldXhb8URLklHpJuffKw==
X-Received: by 2002:a05:6e02:1525:b0:3ce:78bf:3c0e with SMTP id
 e9e14a558f8ab-3ce78bf3de3mr108950395ab.1.1736990903303; 
 Wed, 15 Jan 2025 17:28:23 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3ce4add8570sm42587725ab.32.2025.01.15.17.28.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 17:28:21 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 17/22] spl: Add a type for the jumper function
Date: Wed, 15 Jan 2025 18:27:18 -0700
Message-Id: <20250116012723.2820301-18-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250116012723.2820301-1-sjg@chromium.org>
References: <20250116012723.2820301-1-sjg@chromium.org>
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

This function will be used by the relocating jumper too, so add a
typedef to the header file to avoid mismatches.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/spl/spl.c | 3 +--
 include/spl.h    | 3 +++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index ad31a2f8b6c..09e6dc26f5e 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -671,8 +671,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 		BOOT_DEVICE_NONE,
 		BOOT_DEVICE_NONE,
 	};
-	typedef void __noreturn (*jump_to_image_t)(struct spl_image_info *);
-	jump_to_image_t jump_to_image = &jump_to_image_no_args;
+	spl_jump_to_image_t jump_to_image = &jump_to_image_no_args;
 	struct spl_image_info spl_image;
 	int ret, os;
 
diff --git a/include/spl.h b/include/spl.h
index 781e5a2d638..488adbeb1bc 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -292,6 +292,9 @@ struct spl_image_info {
 #endif
 };
 
+/* function to jump to an image from SPL */
+typedef void __noreturn (*spl_jump_to_image_t)(struct spl_image_info *);
+
 static inline void *spl_image_fdt_addr(struct spl_image_info *info)
 {
 #if CONFIG_IS_ENABLED(LOAD_FIT) || CONFIG_IS_ENABLED(LOAD_FIT_FULL)
-- 
2.34.1

