Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC8DCAC5B8
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 15:32:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B991B83826;
	Fri, 26 Sep 2025 17:31:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cK+pcnUH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 213C48382A; Fri, 26 Sep 2025 17:31:40 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 003D783816
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 17:31:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-4248a13fbe9so12273165ab.1
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 08:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758900696; x=1759505496; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=rJO8sYbKlL94Z0GopRvNcb3nYq5esQgPxqYvvBtENJ0=;
 b=cK+pcnUH+rdRjs7nevVSUmOmT/ZPvzGc7oZniNvOdLTdzhuWmSyhAjS/g928Ag+Vgw
 6sPOpDb8LwNj6ESJtTJiWkIHpyyNxYZwGqji4C72522S6wU9PCkX2dqVrHnT2C6H6++a
 6QolbgNf1Yq3dG2NfaurmQ8hbZpVCx/a9hroA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758900696; x=1759505496;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rJO8sYbKlL94Z0GopRvNcb3nYq5esQgPxqYvvBtENJ0=;
 b=XR58SkdKcWGjXnMST2Hjtwg3eUM6BJgUcxdwRIRtpoh2XaN6heSIMrM0XVXOScwcll
 ooed+9dNhZ8zZpIVnaWx1CLVzWKOEZ+KWRtWoPLLDr2X1vgHwwatjP9dkhsRQRODjqAM
 qwahqn2KFt2jXnF4C8KqN4dk94pBeWwbpCU1rU24Bl/HzjPBSNxv+QVwTzriJyA/FKyK
 yZrOxnvY0l2Imy1tXjIiUHJSNVcirZ1ZNAPqEz65tXPjeC6PrD9KIfWOPbyvaaQ8961Y
 7J0wuQi/A8H88sfzUqMpdg/piGbEJ2NAzBBi4th7T0P3PCVNnuY/xPUXBlTa6NQ86Tq+
 WL6A==
X-Gm-Message-State: AOJu0YxWJkWa70hBbfq1MzdLiq/QGRI8AqHNOOUW0INO28j15Z8XJJrg
 Bbc380BCZSf2RLOfcV7Oy4qyiPRNpyqKWVLEo9fDTXnV/dYcJfsFTuR/59regoIjGPI5u6VvlGI
 w+DE3A9I=
X-Gm-Gg: ASbGncvZWjNEQIxmzUSY1f3F55OUEd+PC/nOJUxSNMViWbPzxfEPJ6IpDCRp9yDXob7
 eUuPVCWHr2kXskPvPGOVmofsgl1Y7IWk9PHj0KHMW8dlUplZH/Acps8bGWyyYaP9PMNnYsa2uA5
 O0iYQviiqIBf87qdHJWDT6Q9rSwVtu5Mx5Jk0I3EGf7qdjgP974lbamtk0uQT1rdlTedecL3VJ8
 ulsxzCLytg1xFprAH9GcjEnEg4XF8cEcT3Gij5Vmz1Ymg3EJDqedgAxzFNd9sWslrRco7/BTHTJ
 gG6ehd1jNP3KZFOQ7F5P84h6FmsqTJZblRNv4JkCAggERlOegP2IXgtLp0+cVyzXhz5uRNnmZ6i
 tPWEtQ9uJjn/ayhaiGf0TTggAwSsW+oChmKffI7SfIPfuBNEWar33Bz/3tVW6OLV11Eb+F1Eixo
 jcnmbv
X-Google-Smtp-Source: AGHT+IEJ+q6b5127bWn9Nz9y4AxCChCRROdJtXNaJSakKtQQjrv3Jcjmvnb59geod+D3LKliGBOl0g==
X-Received: by 2002:a05:6e02:194a:b0:428:306a:175d with SMTP id
 e9e14a558f8ab-428306a1868mr12417185ab.28.1758900696260; 
 Fri, 26 Sep 2025 08:31:36 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-56a69a1b7d5sm1979237173.49.2025.09.26.08.31.35
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 08:31:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] led: Mark LED_STATUS as depending on LED being disabled
Date: Fri, 26 Sep 2025 09:31:34 -0600
Message-ID: <20250926153134.3680852-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

The LED_STATUS functionality is part of the legacy LED framework. This
cannot be enabled at the same time as the new LED API is. Make the text
prompt be clear this is legacy and add a dependency on LED being
disabled.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/led/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/led/Kconfig b/drivers/led/Kconfig
index c98cbf92fabe..a37ec633fb6b 100644
--- a/drivers/led/Kconfig
+++ b/drivers/led/Kconfig
@@ -137,7 +137,8 @@ config SPL_LED_GPIO
 	  See the help of LED_GPIO for details.
 
 config LED_STATUS
-	bool "Enable status LED API"
+	bool "Enable legacy status LED API"
+	depends on !LED
 	help
 	  Allows common u-boot commands to use a board's leds to
 	  provide status for activities like booting and downloading files.
-- 
2.43.0

