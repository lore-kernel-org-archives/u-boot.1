Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A89B2C48260
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 14:05:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FD7487559;
	Thu, 25 Jan 2024 15:05:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WQEtnEEb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93672876FF; Thu, 25 Jan 2024 15:05:39 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7461787447
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 15:05:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d751bc0c15so41334635ad.2
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 06:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706191536; x=1706796336; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JJRrfJa0Or+UJAFVxi6i/FIkYVEA7m44U3O+kQ18FQI=;
 b=WQEtnEEb6lBDQjIJhyxJvbR/Sw2LKLZ3PJ4RKrUqE3E/w7t7WevyesV/xDpGKWzIMl
 wQr4IPsRHXN4gFduOsxeFpy/KSvL2a8T3LYiIzuP3udQK05MX4+3+UyNHgbrlT/df/Sx
 ppUqwWbgBrLCoxMfhaidwh8r4zfKedWZfe+957njTiezW9nNxTU9uGtvNBpOD/nOL2BT
 ttLbYzHsYSJtM6f+e7pXIjFioHDqcLRPGCEDnSAg82XdytzCPoHUDX9T8j3xg+Snxjsf
 xWZ+BrO9PuwSGBu9PWvaqRT9diuiwTDhyLeXCxq+jeCP97E/JQ77NqiN2UHB2kvdu3lw
 Xehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706191536; x=1706796336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JJRrfJa0Or+UJAFVxi6i/FIkYVEA7m44U3O+kQ18FQI=;
 b=PZyQBbbOQnMrR1lxjIlnM0BEATcMtGBdi3JKj4i7Ajkt0N3lUaWLHmy5Nz6voo2owi
 bFUP2VwWUDi1G5v+e3lOLCEZmSsreWoX4NsDv4KM2pT5d69sU33yOkpKkzwzb/FpLhmG
 8YtdPSVoX+cPI9l8jEgURW0fQuhJE8SsPmLus/AFj335bb3vbQwSIqsT1x8L5mUNIxzP
 bsK0E2Q0pmJ33yG6rNIia1GrKHURGTaiQwJEdvSvfr+bP3gq+I7hUluybNQorkaz9isd
 7Ea8boBS19prPwoBC9TlPKu5AdLkhDqoT7Max2LRYcWLQMNmeIxUSe4Rwx15pL5p5EIb
 E28w==
X-Gm-Message-State: AOJu0YxyBCSput7TCdoKIbgrQGEjuO8thRBG/9PsTHYRzIFbteo4RFlb
 ThZ7eehEBQFvq/MTDDXnoo7qtxGXNxekTsnIU4Zb6LyAnfNQ2sAL
X-Google-Smtp-Source: AGHT+IFaUtKiV8Hn4YoeOYNikMqYqFfJVzOc0tAmnxgUg21kW8GWsNVoQfOQ+Fjb3B5l26kMD8W8Dw==
X-Received: by 2002:a17:902:724b:b0:1d7:9290:8e32 with SMTP id
 c11-20020a170902724b00b001d792908e32mr1066849pll.86.1706191535155; 
 Thu, 25 Jan 2024 06:05:35 -0800 (PST)
Received: from ownia.localdomain ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 p18-20020a170902ead200b001d705836d0dsm11925699pld.200.2024.01.25.06.05.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 06:05:34 -0800 (PST)
From: Weizhao Ouyang <o451686892@gmail.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Etienne Carriere <etienne.carriere@linaro.org>,
 Weizhao Ouyang <o451686892@gmail.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, u-boot@lists.denx.de
Subject: [PATCH 1/3] firmware: psci: Fix bind_smccc_features psci check
Date: Thu, 25 Jan 2024 14:05:00 +0000
Message-Id: <20240125140502.22400-2-o451686892@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240125140502.22400-1-o451686892@gmail.com>
References: <20240125140502.22400-1-o451686892@gmail.com>
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

According to PSCI specification DEN0022F, PSCI_FEATURES is used to check
whether the SMCCC is implemented by discovering SMCCC_VERSION.

Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
---
 drivers/firmware/psci.c   | 2 +-
 include/linux/arm-smccc.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index c6b9efab41..894be8128d 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -135,7 +135,7 @@ static int bind_smccc_features(struct udevice *dev, int psci_method)
 	    PSCI_VERSION_MAJOR(psci_0_2_get_version()) == 0)
 		return 0;
 
-	if (request_psci_features(ARM_SMCCC_ARCH_FEATURES) ==
+	if (request_psci_features(ARM_SMCCC_VERSION) ==
 	    PSCI_RET_NOT_SUPPORTED)
 		return 0;
 
diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index f44e9e8f93..453017eb5f 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -55,6 +55,7 @@
 #define ARM_SMCCC_QUIRK_NONE		0
 #define ARM_SMCCC_QUIRK_QCOM_A6		1 /* Save/restore register a6 */
 
+#define ARM_SMCCC_VERSION		0x80000000
 #define ARM_SMCCC_ARCH_FEATURES		0x80000001
 
 #define ARM_SMCCC_RET_NOT_SUPPORTED	((unsigned long)-1)
-- 
2.39.2

