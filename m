Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B9DC25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 07:55:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A367887FDD;
	Wed, 22 May 2024 09:55:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="j41pD5Od";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 150538846E; Wed, 22 May 2024 09:55:16 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C0218812B
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 09:55:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1716364514; x=1718956514;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8ChICFxrOF848ZiPu742APSAkgHWHctWTGjbrHhpMPY=;
 b=j41pD5OdThYEu3TMUlTc0QFrzWn2H9F47VbFNG2NJwz4IKQ34iqWeKyIpN8Zphie
 e3Vt07DXPsh3vyt/ue3fwndc+oEqt8PPSXRG03NzGOMHZ9Xu5XMqY3slBEICnNqv
 0Nrt/SDwMBI1/7hSVFYazrAWfLDkMTVpOy5SyAQtdZ4=;
X-AuditID: ac14000a-03251700000021bc-ae-664da4e18f88
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id E4.F0.08636.1E4AD466;
 Wed, 22 May 2024 09:55:13 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 22 May
 2024 09:55:13 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <nm@ti.com>, <trini@konsulko.com>, <clamor95@gmail.com>,
 <d.schultz@phytec.de>, <bb@ti.com>, <jma@phytec.com>,
 <mkorpershoek@baylibre.com>, <d-gole@ti.com>, <m-chawdhry@ti.com>,
 <n-jain1@ti.com>, <afd@ti.com>, <joao.goncalves@toradex.com>,
 <michael@amarulasolutions.com>, <festevam@gmail.com>, <sjg@chromium.org>
Subject: [PATCH v2 1/5] board: phytec: Make AM6 SoM detection depend on I2C
Date: Wed, 22 May 2024 09:55:01 +0200
Message-ID: <20240522075505.3339347-2-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240522075505.3339347-1-w.egorov@phytec.de>
References: <20240522075505.3339347-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsWyRpKBR/fhEt80g2drzS3en5rIbjH3zQFW
 iwP9vYwWLWs9LB5e9bd41tnEbHH5/k1Wi0sPUi1ONbayWLw4Npfdov//cyaLNz/OMll827KN
 0WLqpM3sFm/3drJbdL9TdxDwWPvxPqvH+xut7B6zGy6yeOycdZfd49WBVeweZ+/sYPTo725h
 9fhz8R2rx/Eb25k8Nr3yCOCK4rJJSc3JLEst0rdL4MqYuHYzW8FejorV116xNTD+YOti5OSQ
 EDCR6P7Wzt7FyMUhJLCESWLCkktsEM5jRonnN06DVbEJqEvc2fCNFcQWETCTWLT2PFgRs8AR
 JonHp/YxdjFycAgLeEs0vlMHqWERUJVo2LuXGcTmFbCUePT4IjPENnmJmZe+s4PYnAJWEjO2
 rGEBsYWAak5fngBVLyhxcuYTsDgzUH3z1tnMELaExMEXL5gh6uUlXlxazgIzc9q511DzQyW2
 ftnONIFRaBaSUbOQjJqFZNQCRuZVjEK5mcnZqUWZ2XoFGZUlqcl6KambGEFRKcLAtYOxb47H
 IUYmDsZDjBIczEoivJu2eKYJ8aYkVlalFuXHF5XmpBYfYpTmYFES513dEZwqJJCeWJKanZpa
 kFoEk2Xi4JRqYFTasPxqYi2nwUY3nd5O2QP7BZUu3BCUma5z8o7VlnvF2ruml5mv8J9c4iLv
 s62d4czDY3//WNptmCG3xawuiS33/E4zvl9f5i7zFj4v3lOm+zje/fHsbdsUJ+5fcsxOW6HO
 s8XpMu+iazsc+u838irrKG/YOXfmZJP8Z3f9kw1mcx0Tl1ygrKrEUpyRaKjFXFScCACGNxsn
 uAIAAA==
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

SoM detection is using I2C driver model functions.
Let's depend on I2C.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
Tested-by: John Ma <jma@phytec.com>
---
 board/phytec/common/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/phytec/common/Kconfig b/board/phytec/common/Kconfig
index 1077f0f4b61..56c8290f641 100644
--- a/board/phytec/common/Kconfig
+++ b/board/phytec/common/Kconfig
@@ -16,6 +16,7 @@ config PHYTEC_AM62_SOM_DETECTION
 	bool "Support SoM detection for AM62x PHYTEC platforms"
 	depends on (TARGET_PHYCORE_AM62X_A53 || TARGET_PHYCORE_AM62X_R5) && \
 		   PHYTEC_SOM_DETECTION
+	depends on SPL_I2C && DM_I2C
 	default y
 	help
 	   Support of I2C EEPROM based SoM detection. Supported
@@ -25,6 +26,7 @@ config PHYTEC_AM64_SOM_DETECTION
 	bool "Support SoM detection for AM64x PHYTEC platforms"
 	depends on (TARGET_PHYCORE_AM64X_A53 || TARGET_PHYCORE_AM64X_R5) && \
 		   PHYTEC_SOM_DETECTION
+	depends on SPL_I2C && DM_I2C
 	default y
 	help
 	   Support of I2C EEPROM based SoM detection. Supported
-- 
2.34.1

