Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F0FCC4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 12:37:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35C668848B;
	Wed, 17 Apr 2024 14:37:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PKidouOc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E657788440; Wed, 17 Apr 2024 10:39:41 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A47CC88414
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 10:39:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eichest@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-570c9f49a67so93081a12.1
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 01:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713343179; x=1713947979; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ymZEi9ALxxF1VhBANw99OdfCip3ui8QlPEVqpps1OjQ=;
 b=PKidouOcn/eogMXGo3pOfUTLhlplHIjA863UZnVPipzGOUW7CQJgbVU08QO9M296hh
 qjGxxSB7YRg3McEEnx0jtXTeKwU3uHli0r1WdvuXp8ylg5kQB5/6ZiZcoNnY5jdnaT0f
 MnV3fNbvhatH/QO6924dRZq8hzIWCL1zxsNmRfIhGiE0znQ61o43PBIRWnmnD01yuzmz
 X9SBKpmxb5W+L9e46JNOolENPR0//URxfZUO7DH6aD7FMyj1d/C26E3bLZfIr743tZ8I
 HpJpSLNesZJ/U6nGVjFFawFtJ2AyKpiUaiCgXkZKZtfqqZkysGaA0uStcDJWBdHEwXOO
 /EJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713343179; x=1713947979;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ymZEi9ALxxF1VhBANw99OdfCip3ui8QlPEVqpps1OjQ=;
 b=siOcH8FY8V/F/1y+Ykq2Xi4ZLcUKBL2KILLEnVp6fabWvSMI3q2fHdr0mDnwOkDgtC
 x7oypgqLduNBdRsVWgttnA8G967areMdXynlMRiD1Wwep0zCH01QvqOrv9cPjmeqXcec
 zas9r3Wzv32ZwFCUQVhkOopsIfuYXLsmJx7O9ia7KAzp4GZfoeEqgb/4Cc901xZ8OSoP
 1gJNtQAlLwO0+b+oN65+xh7/CxkUGwJiJsQ7W0BEi17NbnVrR34jg8MMApwLxhFEL4G8
 Ea4UxR3cLUCHzkG6ssyn8sAlfQFPafO6xZ54eluZx/qINfeQcg4yeAN8MDjk0m/fH1pM
 XcvA==
X-Gm-Message-State: AOJu0YxzKoMAkbia+IJEwQno/CgbH9ym9Bps/Y71oaPWjuz3DEbXn5Vv
 MFNXBMZGLx6JTbgUbg6K32nK74qjOBh8a0W4PGUhSUCucNO+NtEm
X-Google-Smtp-Source: AGHT+IHAQQmCCPhcFrxdN117fw1kjA5A1y42+TV8XmOGX4oD6zksLepxQGkAoGpWb52YkUteUxaXcQ==
X-Received: by 2002:a50:9515:0:b0:568:8e22:4eff with SMTP id
 u21-20020a509515000000b005688e224effmr9495142eda.37.1713343178814; 
 Wed, 17 Apr 2024 01:39:38 -0700 (PDT)
Received: from eichest-laptop.corp.toradex.com (31-10-206-125.static.upc.ch.
 [31.10.206.125]) by smtp.gmail.com with ESMTPSA id
 eo3-20020a056402530300b0056e45c05ec0sm7039381edb.77.2024.04.17.01.39.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Apr 2024 01:39:38 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: marcel.ziswiler@toradex.com, trini@konsulko.com, nm@ti.com,
 francesco.dolcini@toradex.com, rogerq@kernel.org,
 stefan.eichenberger@toradex.com, andrejs.cainikovs@toradex.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v1] arm: dts: verdin-am62: use gpio-hog for sleep moci
Date: Wed, 17 Apr 2024 10:39:21 +0200
Message-Id: <20240417083921.13367-1-eichest@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 17 Apr 2024 14:36:56 +0200
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

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

In Linux, we allow sleep moci to be turned off when the carrier board
supports it and the system is in suspend. In U-Boot, however, we want
the sleep moci to be always on. So we use a gpio hog and disable the
regulator. This change is necessary because we switched to upstream
device tree files with commit c07bba7a2c7e ("verdin-am62: move verdin
am62 to OF_UPSTREAM"). A recent upstream patch removes the gpio hog from
the Linux device tree, so we need to add it to the u-boot dtsi. The
following patch will remove the gpio hog from the Linux device tree:
https://lore.kernel.org/linux-devicetree/20240301084901.16656-1-eichest@gmail.com/
The U-Boot patch can be applied without it and will not break the build.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi b/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi
index 7fe7ae4154..9ecb305274 100644
--- a/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi
@@ -91,6 +91,14 @@
 
 &main_gpio0 {
 	bootph-all;
+
+	ctrl-sleep-moci-hog {
+		bootph-all;
+		gpio-hog;
+		gpios = <31 GPIO_ACTIVE_HIGH>;
+		line-name = "CTRL_SLEEP_MOCI#";
+		output-high;
+	};
 };
 
 /* On-module I2C - PMIC_I2C */
@@ -165,10 +173,6 @@
 	status = "disabled";
 };
 
-&verdin_ctrl_sleep_moci {
-	bootph-all;
-};
-
 /* Verdin UART_2 */
 &wkup_uart0 {
 	bootph-all;
-- 
2.40.1

