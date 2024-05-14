Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA37C25B75
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 13:07:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFF2D88307;
	Tue, 14 May 2024 15:07:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EX9+Vhdh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9701088308; Tue, 14 May 2024 15:07:29 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB26380245
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 15:07:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-420104e5390so29657285e9.1
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 06:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715692047; x=1716296847; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=qVuGn+9AyCNBI6zZCYZbRDe/G28MVZVjlPcYyMNh+M8=;
 b=EX9+VhdhVxtccO58KEmcYOtfa2BqW8ewQrfSxr7N8LA1+fxy495JFqq5GTiZnxuyKe
 NAgTsgA+jZHw9v08KsDe3sdrFwpOHoHAjmb15m3csZ6ZYS0JGuQqHHQVf5l6dZjTYO12
 AEaCQHIaJHD08HEH/QbHv3hrmIK65x7gRV0MAVMvsubNKrd7I2OeOZzR/15m6Z8wOuvM
 3cahtacD96ifQFJNiLpUCska0WEBM61Tg6/2euF1Tj6w67oK8MbSxoBNIyB7AQPRuhLv
 DLtGTd2roDQCHmaGiFqVHTlryUYiYCxSEBWe7rk5eU6Ca9QR4c5rTNFI/R8Wpyppahot
 29ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715692047; x=1716296847;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qVuGn+9AyCNBI6zZCYZbRDe/G28MVZVjlPcYyMNh+M8=;
 b=iA5eEqZUpmY9gBf6YAVnop9YskS7YZ03ZwfbimKWec5K5COpKj8rDHvWwvCqbtce7z
 8kMsqVtxDpkoeT5XJeTlfzRah05q5LRQTyPhfZAHCZ9niHLjgBDGSN3dTqfFhjIat8ey
 sSGpPTW9x2iqMdSYlAQf8eoU9lRn2StWbpzl9bM8FHtkI/xJKkDAhNmxd6fuENoYu/14
 6kcr1ZaFJuJAkVM1DF4xjErOeUrs1w0BoiZZrxblSQ0mSKm+CQLlhqyf2tGSiaZKVlrG
 0EWm4Y8p9Cpj6iLiRgkJjLTYF3Hc2hQEHD+MpCZy8fVnazh68rM1jsF2ML7Gw2S/dl3M
 w9Eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2KXvdWhHq/HoNKcMmeXi2m/kh0kkygSPpwTNma9i1LtuWz9QAGBNhMOixzY2VZ/oIQkmABZXfyaknWsDOsXoBiga/Fw==
X-Gm-Message-State: AOJu0Yxn4JIrGrEQjPDpefKn5FcOMJmgo3EJ6b3b4hzsigMsYUScaLlP
 gMjG0DeNrXsUlP1ekCUtt7qaMrv8hYcUk8LSYGWqrDZShbT8vk6V
X-Google-Smtp-Source: AGHT+IG/eqC9DQdPbKEj7QvmtjwqHkI+ehNDOtcKkxfVClFPpO2z9mBuqrrm09seNZUO3R3ECj+kwQ==
X-Received: by 2002:a1c:4c14:0:b0:415:540e:74e3 with SMTP id
 5b1f17b1804b1-41fead6503fmr118166225e9.40.1715692046807; 
 Tue, 14 May 2024 06:07:26 -0700 (PDT)
Received: from morpheus.home.roving-it.com ([149.14.240.163])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-41fccbe8f74sm195437905e9.8.2024.05.14.06.07.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 May 2024 06:07:26 -0700 (PDT)
From: Peter Robinson <pbrobinson@gmail.com>
To: Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: [PATCH] Revert "arm: dts: bcm283x: Add minimal smbios information"
Date: Tue, 14 May 2024 14:07:19 +0100
Message-ID: <20240514130724.1474507-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.45.0
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

This reverts commit 33041972727e84d3f95e26c83322521f61827584.

With the ability to generate this SMBIOS details autmotically the
small amount of details that this patch provided are generated
automatically so this is now obsolete so we can just drop it.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 arch/arm/dts/bcm283x-u-boot.dtsi | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/arch/arm/dts/bcm283x-u-boot.dtsi b/arch/arm/dts/bcm283x-u-boot.dtsi
index 8c17c6f6a52..ec0f93dd850 100644
--- a/arch/arm/dts/bcm283x-u-boot.dtsi
+++ b/arch/arm/dts/bcm283x-u-boot.dtsi
@@ -6,25 +6,6 @@
  * (C) Copyright 2016 Fabian Vogt <fvogt@suse.com>
  */
 
-/ {
-	smbios {
-		compatible = "u-boot,sysinfo-smbios";
-		smbios {
-			system {
-				manufacturer = "raspberrypi";
-				product = "rpi";
-			};
-			baseboard {
-				manufacturer = "raspberrypi";
-				product = "rpi";
-			};
-			chassis {
-				manufacturer = "raspberrypi";
-			};
-		};
-	};
-};
-
 &uart0 {
 	skip-init;
 	bootph-all;
-- 
2.45.0

