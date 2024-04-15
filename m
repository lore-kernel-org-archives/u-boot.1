Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08029C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 10:50:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25EDE87F01;
	Mon, 15 Apr 2024 12:50:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="i6b6gsXx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F7D987E9B; Mon, 15 Apr 2024 12:50:33 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4947E87D40
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 12:50:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a46a7208eedso428989266b.0
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 03:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1713178231; x=1713783031; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XUAWOv+gifPqS5ZPeXnuBFYz/0uvZP7ewsl1uk+aK5M=;
 b=i6b6gsXxJgxJ062FGM4/xTHCX80skLUuJiDPwsqeXbHebYWLa58dquFvpERfb52k5r
 9XVemDaTC1d4dJS3pVNxfgRAMi82ay+22IO9z2nt3dtI2qrSTIZOThBj2EWLbPG/rUUc
 Jx9Meg+it2PGTF+uU2dnUGo4atIumwO0VgJ+UFR/9mBskBunRIYa1Isob9cxh2zZVTXN
 TDoWhXalVsbVAh1w07v10ARZDKsM4AW/w8iPEqxFgjRsIxwOdrzjZLtP9IOcdivpAgCP
 0sFaX0GBSId9aFEv8yYjjLvKi/gg1gJ7CxGjWkjGKMu6yPL/6z7FC5NxWn3vlqKkuVGk
 RrqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713178231; x=1713783031;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XUAWOv+gifPqS5ZPeXnuBFYz/0uvZP7ewsl1uk+aK5M=;
 b=npdIlSmWBlGTZ3TQxYPAAl0yJ6TiHyMGA2MTj4592JbpUau8iBO3BzyODhFMgqMbmG
 k0fsjbLMaAE++VJ7JjjfT9MZpcJf3Q6wRp2o0tX0oddau4fP2r3T7XoxpvYIxtHvkHVb
 eZdqKiGdRkRhTnrHl/EY0pI/NXR25XZvu96VziOOGTzw4Fs/UVtGgaCyQbB0X4Kz/utH
 7IFxe1XojYF8d8FNlyk633UC/Gi9/Ua/b8EAq84B+Y0d0z/uXcblEtMU22bBycaJ2Gnk
 Of3u59+NLJJFJ6gygiGMPCR3LPb36+75E4wAuqg1n2gMi5SS2P/lWTnh6AXup8eldaoj
 E7dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLtcc0F6we/deDYM+tIqfmGZzFvfG4Wv0YoIv/2Cjiuc3g94taDDRnZOc9t/t31/b6/d04N/5Ox14wVRJ8Dw3PwSC2GA==
X-Gm-Message-State: AOJu0YzfFCJ2ujYMHXz9rEf9mL21e39DaiWEyl4vJotA10awejoxHKj5
 oTh4IDO2C8sl8vcWlCIkBKNKpLW0+4j5qkDLi0qUbm44JLZhkZ5ZOFv/zK2y4Ak=
X-Google-Smtp-Source: AGHT+IGZlqrIvDnfuZXMtOpph6W9sgsTHRUS4cqElMQkzl4yXD3nmQ09Gybb/uGmupYvl279Rhv7mg==
X-Received: by 2002:a17:907:368b:b0:a55:33a5:9124 with SMTP id
 bi11-20020a170907368b00b00a5533a59124mr361411ejc.11.1713178230555; 
 Mon, 15 Apr 2024 03:50:30 -0700 (PDT)
Received: from fedora.. (cpe-188-129-44-155.dynamic.amis.hr. [188.129.44.155])
 by smtp.googlemail.com with ESMTPSA id
 ox2-20020a170907100200b00a522bef9f06sm4745378ejb.181.2024.04.15.03.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 03:50:29 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: trini@konsulko.com, caleb.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@linaro.org, sjg@chromium.org, bmeng.cn@gmail.com,
 marek.vasut+renesas@mailbox.org, u-boot@lists.denx.de
Cc: Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 1/3] serial: allow selecting MSM debug UART with ARCH_IPQ40XX
Date: Mon, 15 Apr 2024 12:49:25 +0200
Message-ID: <20240415105028.432404-1-robert.marko@sartura.hr>
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

Currently, DEBUG_UART_MSM depends on ARCH_SNAPDRAGON only, but IPQ40XX
devices also use the same UART HW so they can also use the debug UART.

So, allow selecting DEBUG_UART_MSM when using ARCH_IPQ40XX as well.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 8b19e2684e..1fe4607598 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -321,7 +321,7 @@ config DEBUG_UART_S5P
 
 config DEBUG_UART_MSM
 	bool "Qualcomm QUP UART debug"
-	depends on ARCH_SNAPDRAGON
+	depends on ARCH_SNAPDRAGON || ARCH_IPQ40XX
 	help
 	  Select this to enable a debug UART using the serial_msm driver. You
 	  will need to provide parameters to make this work. The driver will
-- 
2.44.0

