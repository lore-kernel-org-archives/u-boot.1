Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4A2E67814
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 22:20:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEE8D892DA;
	Sat,  2 Nov 2024 23:20:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Axzpar4l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5716F892DC; Sat,  2 Nov 2024 23:20:38 +0100 (CET)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A8F8892DA
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 23:20:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-71e7086c231so2590811b3a.0
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 15:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730586031; x=1731190831; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UqcGr2HQBaHTpFA41xPMR3mQ5RKUGrYCbqTQW9Ba9TA=;
 b=Axzpar4ltsGjsIVYqn/1bWPCVNkxvw2r/MiPj201Nv0VkXH932a9ADjvcm+72j0KXD
 1/lKh4BMBDKe6Vr1/pHrfUnrpkQ/HW02x1ofT7uXAGnQ8nQQcMnfvmC+yrDOkSMtSW7u
 wcQJOdUynxk5YTtjxryEi7SteT3x0YOdDASw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730586031; x=1731190831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UqcGr2HQBaHTpFA41xPMR3mQ5RKUGrYCbqTQW9Ba9TA=;
 b=IL0uW/Aj9i6RcCkYPd8AB1A+SSBeowkCkaj5GKO896rUWCI/Wxu6nMuuECPzTnU5MZ
 71yAfoZ4yqKsPp3F1el9IafZ2TZYrDh1+F2gd5PhwQrwLNRhHk5nlsqC3uMIORV61X+7
 qbV6Wwy5cLLUMiuFlkJOE8nSixs73AU1/5cj7xR9RIb9ZbOOrOltPMS6r4J8X+wS9Pst
 cLx3XVKkcdWHp/mT/1chONzm+64yGR3ZLsijHoThqYtESsY46Umj7T0PTkWXPB8rByLH
 bmu90/2RqqH/y/gl+bQ1NNdDHlYUhC12L1V4C+MG5IIsfU4EZbqhIgpm6lqWdiOAWAfR
 jk2g==
X-Gm-Message-State: AOJu0Yz0xI4LnMDlebp4s0Uc9dRia8avzPi9Skgruv8W+SL5g41yUqZG
 F4V2lpkcJnbULuFuZ/czpgwtBg00gybTvNTP3hmCTyIdC0wh8wlym/EN69RacWW11lF+v1CLwfl
 K9w==
X-Google-Smtp-Source: AGHT+IE5L3nL2kn99Qm/hMf+nj6lQP+AcdlXqV8fdjWpD6OtsV/tACcKF1+vCe1Q7zYRNHoE/mr5Ow==
X-Received: by 2002:a05:6a00:1785:b0:71e:58be:3604 with SMTP id
 d2e1a72fcca58-72062f4e605mr40781639b3a.4.1730586031121; 
 Sat, 02 Nov 2024 15:20:31 -0700 (PDT)
Received: from chromium.org ([205.220.129.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm4386286a12.59.2024.11.02.15.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 15:20:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 04/25] pinephone: Drop status-LED code and use LED
Date: Sat,  2 Nov 2024 16:17:02 -0600
Message-ID: <20241102221737.547938-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241102221737.547938-1-sjg@chromium.org>
References: <20241102221737.547938-1-sjg@chromium.org>
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

Drop the STATUS_LED options and enable LED and LED_BOOT instead, since
this is the new way to access the LED functionality.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Combine removal and enable patches

Changes in v2:
- Add a patch to enable LED and LED_BOOT for these boards

 configs/pinephone_defconfig | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/configs/pinephone_defconfig b/configs/pinephone_defconfig
index 9d39204a439..272fce1c1a4 100644
--- a/configs/pinephone_defconfig
+++ b/configs/pinephone_defconfig
@@ -11,8 +11,5 @@ CONFIG_MMC_SUNXI_SLOT_EXTRA=2
 CONFIG_PINEPHONE_DT_SELECTION=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_OF_LIST="sun50i-a64-pinephone-1.1 sun50i-a64-pinephone-1.2"
-CONFIG_LED_STATUS=y
-CONFIG_LED_STATUS_GPIO=y
-CONFIG_LED_STATUS0=y
-CONFIG_LED_STATUS_BIT=114
-CONFIG_LED_STATUS_STATE=2
+CONFIG_LED=y
+CONFIG_LED_BOOT=y
-- 
2.43.0

