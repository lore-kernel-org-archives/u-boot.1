Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD539C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 09:17:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C34D885B4;
	Thu, 18 Apr 2024 11:17:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="c8thPEgU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6B64885B9; Thu, 18 Apr 2024 11:17:32 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4C87885AD
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 11:17:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a55323f2ef9so65605566b.1
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 02:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1713431850; x=1714036650; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=higpHFo2MmQ9aVbjiRHDLJx8c6sS+7pUn8UrdJc/Iqg=;
 b=c8thPEgURapE0zqB8oz3MnFJTKCd1iUN+1Pf/+60D+s9MnBz+LNxZ14ZiFn9raPwO2
 Co+FMXFOaicPrB1kGmGBpyiOjCa0tE1d7qOtqwzcBh8Mlt8MYCEjmzeKIE5lpSspYmVK
 Ssuzf4W1BZqVSW4AevqZPRzcgNiSQMxPC0w8T8+PM1gvtFZWI//muBctmL/xRzBQWKQI
 9gNtYcUmmkFqsG20TbuBLge11V6bj8bQhYj48VsGmR4rgGQD44bnvYJ4L7K586c8i9kG
 kLij6hq4z48VM1jtoGfMVWmLBdDGKD6/RiYcDL3WpUHXNElka8JTCe1EL2vx/YUK8GFC
 Y3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713431850; x=1714036650;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=higpHFo2MmQ9aVbjiRHDLJx8c6sS+7pUn8UrdJc/Iqg=;
 b=qzf66Dbw3oqJG/kDNjE1V0gccJRoeq298qTN3Yt6aXE0JNVLCETAvbX5PcWews/G8c
 DiFke7NXF7pyLNwCMzqHmw147vaO8nGf/HIJcthyrwDu85gaVsTu+m+OBV8yev90gp5p
 COQn7TWtRxcgEl7uEoo5kpXFVvR49Bn8VuOLWStbH0yMl9Zc3oeZRj9vg2y4OM2cOljv
 8NkVfrhmlZYEdpa7LBayVKykuvpot5IQfpBRDQ9iQU8n2Aa8rLTs3iGkD86QuFa+JR3u
 WlWvHGCcd/fRyXjS9WGoeJs6GjtkbTAYPVDuaa2UJWFbRpI9wafEcPLB0tS/YIuznjxZ
 TV2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUF2awfBh3Zl5I7iv8hEqLEcRH+N37VzRBbP8Seynqqicy8VZRl1g+tm6vNPg48/Aoe3rQNipcKIP9wSFYYDWmZrZne8A==
X-Gm-Message-State: AOJu0YwRXRSN/rhJJ/SL2l4+vwLbBqmzQKOaOLZyKOOY5DKV4vGaUReH
 zVjEMyjdaXwDwAgoWgdDN/JL6kUQ4nGXq55xkC+cFE6rsrmN4obecIn0JYHNnvhia7CcVNkaVdl
 6
X-Google-Smtp-Source: AGHT+IEwz0XeoXdo/HJgdsDnnweg3LyAEvNWSHkCqD8YQ+LXudMn0IkvOz1VPl3PiVzTmzjR+wNtgQ==
X-Received: by 2002:a17:906:1dc8:b0:a52:55f5:aba5 with SMTP id
 v8-20020a1709061dc800b00a5255f5aba5mr1297097ejh.2.1713431850328; 
 Thu, 18 Apr 2024 02:17:30 -0700 (PDT)
Received: from fedora.. (cpe-188-129-45-161.dynamic.amis.hr. [188.129.45.161])
 by smtp.googlemail.com with ESMTPSA id
 bw19-20020a170906c1d300b00a5238156017sm634370ejb.88.2024.04.18.02.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 02:17:29 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: trini@konsulko.com, caleb.connolly@linaro.org, sumit.garg@linaro.org,
 sjg@chromium.org, u-boot@lists.denx.de
Cc: j.beck@linefinity.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH] arm: mach-ipq40xx: dont select SMEM by default
Date: Thu, 18 Apr 2024 11:17:00 +0200
Message-ID: <20240418091727.18551-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.44.0
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

IPQ40xx SoC-s dont have proper SMEM support like more modern Qualcomm
SoC-s so there is no point in selecting the required drivers.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 arch/arm/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 23ee25269a..922c28cca9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -762,10 +762,8 @@ config ARCH_IPQ40XX
 	select DM_SERIAL
 	select DM_RESET
 	select GPIO_EXTRA_HEADER
-	select MSM_SMEM
 	select PINCTRL
 	select CLK
-	select SMEM
 	select OF_CONTROL
 	select CLK_QCOM_IPQ4019
 	select PINCTRL_QCOM_IPQ4019
-- 
2.44.0

