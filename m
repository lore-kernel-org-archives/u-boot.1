Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5241BCAC5AE
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 15:32:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BEDD83849;
	Fri, 26 Sep 2025 17:31:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k7Wzeu1O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B90E88383E; Fri, 26 Sep 2025 17:31:41 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98E8583826
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 17:31:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7abc631ae5cso606314a34.1
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 08:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758900698; x=1759505498; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hO080N8Bx1RnHQTxDPBo0WAeL9Xl/OrrRwlRFxFDeWA=;
 b=k7Wzeu1Obri7AxLM+U5kmi+anEgW8TVvykYPsjA7dpcfgczPULRQKlyIT5ZNwpPEVt
 p2v2e8TVTHTcxJgL8tCWFxWDmIzNX5Tr+LT/mnIwGM3RmVnvLwXgfkTRJaBBjzaZ9Wh9
 DSuO3xylY9TqenaYzR4tQhzy69klJhAUvv6F4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758900698; x=1759505498;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hO080N8Bx1RnHQTxDPBo0WAeL9Xl/OrrRwlRFxFDeWA=;
 b=YsewgsT1k4IUrfGMI7gaO5+c8zoXdVPKvUCTawnFQSLtEyE7xmISrNCIVKkmXzXylW
 6fXia7p93n+ApGDSiosMkg/IE2zqQin8bro23b+qg0V1G+t5bitzJYW3jP/zGapRN+aZ
 /x736EFw5hDnBL5VIwGapBbS2KLL5mkisNwBPNS9Ng0EVYf3hIXBE1uTsS574yWD+SLV
 WBYZ+viaX7yYLqRcjwuV4aKFKFjB6iTo4NnHQ0AHRM864S9bq9zgpk13bVIs70yFKV3b
 0NySGYT7wIniT0YfVlAIf1GGfCxG1+GZgNkakZOGf0DbEHyxL/je8V2BJADttTIO2kkh
 RiVw==
X-Gm-Message-State: AOJu0YyGfgiHkKkOBtLqQfjUi3HoVR0c2z1ApgqUetdaHhtnYUgMxRWT
 XdNYRByOslE/FkcIcMidunEg/wyxjaFDFNCx+lAX81y+2cVCZ2m8i7V/Vgu4Zg4GzF5EbRZZyvW
 OVW0Cfr8=
X-Gm-Gg: ASbGncv1Au+R+CV33fOrdqdWJs1hCWfDXRJOFe0lq1FfBnjig/mFqB4dZfPN6fudtsa
 ZXrWaB+gn0icbdGP3OG3dYtaARaFBqhDiyEr2bT8eKKEk4pdSBRvIt8gV5gqZZt2Oy3/V7sX6/P
 XdHpqX/QvNr46B9wDniDQD1V0y+m0aJUTieDg6ohbfwOCur+6Kc3SPTrHj249EyR3kDB40SkwjH
 y9mTzGOy4MzXUbvibRKvc7c+K5Znw2p5w+KFrLK26wq6jmgCijDeHpc/lxOqiuNuPr08kKl2RW/
 omP/tafaQdyiRdiXKnEd+zCfQxCC1EzGvexaUJ5W+7Yvv3S8w06VthbIoriIqeBtNrIQI+1BQhM
 TruM0C3OdGtRSQJEh1Z838l7WGT60jtX0uIZx21kJ5jNWR9BwPhhxKDsLFmU=
X-Google-Smtp-Source: AGHT+IEpz9Kzpcmn86B77kvWzDxy9T9mjxvx92bctIonaAwT4UKIivumkDxtxA3XwI0l3so3D80BnA==
X-Received: by 2002:a05:6830:210f:b0:757:d075:2fca with SMTP id
 46e09a7af769-7a04d5ad9e1mr4121839a34.31.1758900698338; 
 Fri, 26 Sep 2025 08:31:38 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-56a69a1b7a6sm1968334173.45.2025.09.26.08.31.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 08:31:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Eugen Hristev <eugen.hristev@linaro.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH] nand: atmel: Rework ATMEL_EBI and DM_NAND_ATMEL interaction
Date: Fri, 26 Sep 2025 09:31:36 -0600
Message-ID: <20250926153136.3680867-1-trini@konsulko.com>
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

The way that the NAND driver under DM_NAND_ATMEL is probed is by the
dummy memory driver controlled by ATMEL_EBI. Rather than require that
for NAND to work both be enabled, make NAND select ATMEL_EBI and do not
prompt for ATMEL_EBI as it only triggers the probe for NAND.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Eugen Hristev <eugen.hristev@linaro.org>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
---
 drivers/memory/Kconfig       | 2 +-
 drivers/mtd/nand/raw/Kconfig | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index eaee739c6aab..591d9d9c6569 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -14,7 +14,7 @@ config MEMORY
 	  For now this uclass has no methods yet.
 
 config ATMEL_EBI
-	bool "Support for Atmel EBI"
+	bool
 	help
 	  Driver for Atmel EBI controller. This is a dummy
 	  driver. Doesn't provide an access to EBI controller. Select
diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index aa4bb2a0595c..f083113486ed 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -50,6 +50,7 @@ config SYS_NAND_NO_SUBPAGE_WRITE
 config DM_NAND_ATMEL
 	bool "Support Atmel NAND controller with DM support"
 	depends on ARCH_AT91
+	select ATMEL_EBI
 	select SYS_NAND_SELF_INIT
 	imply SYS_NAND_USE_FLASH_BBT
 	help
-- 
2.43.0

