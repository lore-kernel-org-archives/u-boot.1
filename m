Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B90DC021A4
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 03:25:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C21180EEB;
	Sat, 15 Feb 2025 04:24:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="StULeati";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36B6080756; Sat, 15 Feb 2025 04:24:00 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E32A680F98
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 04:23:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3d191bfeafbso9434165ab.0
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 19:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739589836; x=1740194636; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8GzaVmKdfzzhZ8iUwjYgGKHH2/TDM4J5jzU32Rpk4Gg=;
 b=StULeatiOBTDFFrWpmd/8crgwn4m50PWmGM0KPpms1YXCAqnHtQDaXv721pEjHGegY
 4K3FcwtU4GSpLVJZQsMEl3B6P7BCJX+RU7ssYV4xG8bM/gPsqMQC0kDnVnDUbHazHQqk
 kJVvPWoaMpdb6S9X/CM4by58UzG+qWNlgh6kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739589836; x=1740194636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8GzaVmKdfzzhZ8iUwjYgGKHH2/TDM4J5jzU32Rpk4Gg=;
 b=P/kGoQV0vuyFg4nL1gT9E5CXfPpurb9EctrI6fMObndT1r6rsrhwuCBYeTZBVbfwTu
 CI7tXnl/ou4wvfS8wXYJhEoJ3rVhMzb3UFP9yJ6Enoh76wJeBvFd5fMQ6Zf3iqwqwRtV
 2RyqVaOISSoy2U2BbCVBIVotHFNRSDEyOJT2KROcEKp408ZaX5lqXxkmaVx39HPAiJjv
 H5vlJorP4a47LUBcvDVx2Hxd+rFs9JTO26nuC3cdLLy6FLI85XO2UWbGunIqMXtun8B1
 f7L7OSBrzynuzz5S9JSfKALYTiSPeX+WwLYobtxWw+miTUS9VEbRE13Cc1+ckmRvwbBe
 gu8g==
X-Gm-Message-State: AOJu0Yx+s/33BgWBib0UZgZnxJfWeH6lT78VbJO6mucMGE+iCF/ojb0h
 4Lt5adQPD5c3xP0ILJ2UR2ZiMwxq92YR9UNfA3h0qXTpPSmGxgo8DSmgmWwUtQW0KCS2KM2PnD0
 =
X-Gm-Gg: ASbGncueJU/qmtLSAzu0GHZr9H4XEmn6pWSh56yfbH7caXBwi2+7DTTSQgP1SbY+P5k
 qZeZZqKJnKle4OVMNqGAZ3AsTNI2NULmKPaSa6VPhgDVj0Po0Z/L2JhEDKg5RnlG5XTudIh6qJp
 vdamDnofCwrCLITMUTJtSbJ4yf9RBhjklKWHJnlXJxjf2JXJRYxElJn5P7NMKy6ofCTRkBTD4n7
 I3/Db3W2fh3rlBQMm6gudKQGMNjhfjZFbmn2bM/GRlmnnkH5agO6KF5Jz9KNX81X8Gq2JI1CTiK
 vjeuTTB7nWRdNvlVwxuDCn+784lmsAhFGOxeIqRoceBnIM70HU1K
X-Google-Smtp-Source: AGHT+IF7hq7kiod/xa36ECzuWi3hsOhqepr+62ZKgYolj23gkkOFzV6ASUL6OGf/6Mf1Ngy8wnUnPg==
X-Received: by 2002:a05:6602:14cf:b0:84a:5201:570b with SMTP id
 ca18e2360f4ac-85579fd91d9mr172395439f.0.1739589835712; 
 Fri, 14 Feb 2025 19:23:55 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed2819d0f5sm1087697173.67.2025.02.14.19.23.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 19:23:53 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Albert Aribaud <albert.u.boot@aribaud.net>,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v4 17/29] efi: arm: Implement access to global_data for EFI
Date: Fri, 14 Feb 2025 20:22:38 -0700
Message-ID: <20250215032254.4121030-18-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215032254.4121030-1-sjg@chromium.org>
References: <20250215032254.4121030-1-sjg@chromium.org>
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

The EFI app likes to use a simple variable for global data. Implement
this for ARM (for use only with 64-bit ARM at present).

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v2)

Changes in v2:
- Mention '64-bit ARM' here, rather than just 'ARM'

 arch/arm/include/asm/global_data.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/global_data.h b/arch/arm/include/asm/global_data.h
index 6e4471662a3..8d51111f095 100644
--- a/arch/arm/include/asm/global_data.h
+++ b/arch/arm/include/asm/global_data.h
@@ -115,7 +115,13 @@ struct arch_global_data {
 
 #include <asm-generic/global_data.h>
 
-#if defined(__clang__) || defined(LTO_ENABLE)
+#ifdef CONFIG_EFI_APP
+
+#define DECLARE_GLOBAL_DATA_PTR   extern struct global_data *global_data_ptr
+
+#define gd global_data_ptr
+
+#elif defined(__clang__) || defined(LTO_ENABLE)
 
 #define DECLARE_GLOBAL_DATA_PTR
 #define gd	get_gd()
@@ -144,7 +150,11 @@ static inline gd_t *get_gd(void)
 
 static inline void set_gd(volatile gd_t *gd_ptr)
 {
-#ifdef CONFIG_ARM64
+#ifdef CONFIG_EFI_APP
+	extern struct global_data *global_data_ptr;
+
+	global_data_ptr = (void *)gd_ptr;
+#elif defined CONFIG_ARM64
 	__asm__ volatile("ldr x18, %0\n" : : "m"(gd_ptr));
 #elif __ARM_ARCH >= 7
 	__asm__ volatile("ldr r9, %0\n" : : "m"(gd_ptr));
-- 
2.43.0

