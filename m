Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B8CC25B76
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 00:12:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89C73882F0;
	Thu,  6 Jun 2024 02:12:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HQvTVL74";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8976C88354; Thu,  6 Jun 2024 02:12:32 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC909882E8
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 02:12:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-62a145e0bb2so3617527b3.0
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 17:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717632747; x=1718237547; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JMZXEXbPuQ60x4hpGe8Auorfmgkhd0OVnWn92J1H1HY=;
 b=HQvTVL740J1c5P4ilFTWPF8jp3tPb39twU/rYOQ6DxX5wsxYL9vyY7uEIZTCgexRjE
 uIrBs8EbASvxKUb1iLXvDEOPi0le+sgvb/g4jCUIKJG2X28N5T/3TFqp/uQdK0n8XcMS
 pMUbG1inFiejLImoCQ1Bz9oARHaP7iGATe1AtYyVT/4PjB/04OPsrArv6HbL81OysIg2
 esE+K6EpPy/pl5xAyVhVsDSWQlJdmVM83fAuKLp2R8D36VuxXBAz6RMG8jgk7NIXe3Nw
 cWbiDxKS9RU6IrMk2UMB/qKnxkBVtZJqVTnxIhFLmgEE+mxCNZTfZCN0U2nW1zeuLXiM
 WRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717632747; x=1718237547;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JMZXEXbPuQ60x4hpGe8Auorfmgkhd0OVnWn92J1H1HY=;
 b=TO1Nz2HEASOuxKwyR/3fwiWGtPzhmwV33nYZqwbhGlSHL5A0iQSqKua3hsyQX0jCIQ
 eHEW4wNFcmQcZyLgWAcsKOqn4vBP10ggeglni+kws6e6ZC2XjFJaCB1o0KJH2xllBqWT
 4umPlbk17oOuW8XX/O2FvYXVta8CtS96AXj3336jt+3QWKfx+xh7jW4FKu/s0zwMRbxU
 XlKO6IDKzYEzEtyKGnN1bl7xvRDuK7MLXUGmLul1iifw0pgVaOlrUjZjt4PQJSX4ANC5
 O4jI2/ZkA/URhUcf7qlmscJOgX6aVHxPJpEAkzZG8gJHu6LfyfUV34y86uT62jHlyk/2
 uf0w==
X-Gm-Message-State: AOJu0Yy+PSrd7NslkQ3cCWPB3AKKgu3SSEDGK/ntqFqDWDso0U40r9rR
 akvOdIwZY/d1oyLOppavtpYGzMjxjr3I9snFW+MSSLsvUMdKi9tMOHq0Ew==
X-Google-Smtp-Source: AGHT+IHtFVhNX/GxyilNaBZfizDiMAM8ZYKDq7ed3B9iCKCJeXNoBnmKwIjWaZQdFDRLI/LEL2oJBw==
X-Received: by 2002:a0d:e0c7:0:b0:62c:c660:72af with SMTP id
 00721157ae682-62cc6607301mr15277867b3.24.1717632747302; 
 Wed, 05 Jun 2024 17:12:27 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-62ccace66b0sm601667b3.35.2024.06.05.17.12.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 17:12:26 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>,
	Stefan Roese <sr@denx.de>
Cc: Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>,
 =?UTF-8?q?Marek=20Beh=C3=83=C2=BAn?= <kabel@kernel.org>
Subject: [PATCH] arm: mvebu: env_sf_get_env_addr() missing check for
 CONFIG_ENV_IS_IN_SPI_FLASH
Date: Wed,  5 Jun 2024 17:12:01 -0700
Message-Id: <20240606001202.11799-1-mibodhi@gmail.com>
X-Mailer: git-send-email 2.39.2
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

The CONFIG_ENV_OFFSET is undefined if boot device is UART
(CONFIG_MVEBU_SPL_BOOT_DEVICE_UART), or envs are not stored on flash
(CONFIG_ENV_IS_NOWHERE). Check for CONFIG_ENV_IS_IN_SPI_FLASH as the first
condition to determine whether env_sf_get_env_addr() should be provided.

Signed-off-by: Tony Dinh <mibodhi@gmail.com>
---

 arch/arm/mach-mvebu/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/cpu.c b/arch/arm/mach-mvebu/cpu.c
index 7c62a5dbb6..6dd729ae6e 100644
--- a/arch/arm/mach-mvebu/cpu.c
+++ b/arch/arm/mach-mvebu/cpu.c
@@ -36,7 +36,7 @@ static const struct mbus_win windows[] = {
 };
 
 /* SPI0 CS0 Flash of size MBUS_SPI_SIZE is mapped to address MBUS_SPI_BASE */
-#if CONFIG_ENV_SPI_BUS == 0 && CONFIG_ENV_SPI_CS == 0 && \
+#if defined(CONFIG_ENV_IS_IN_SPI_FLASH) && CONFIG_ENV_SPI_BUS == 0 && CONFIG_ENV_SPI_CS == 0 && \
     CONFIG_ENV_OFFSET + CONFIG_ENV_SIZE <= MBUS_SPI_SIZE
 void *env_sf_get_env_addr(void)
 {
-- 
2.39.2

