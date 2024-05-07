Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C962C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 15:18:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8556288746;
	Tue,  7 May 2024 17:18:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="F0gTzuJ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3865B8879E; Tue,  7 May 2024 17:18:11 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF27288746
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 17:18:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1715095086; x=1717687086;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jxoCmFMvCgHIWtHlSQRdIKCc5OGDHa0wvf766vgdRK0=;
 b=F0gTzuJ0kf5MP8Rd0aXvZBn5rVSHVMWbm6xV1noQfilWTvR6JyqcceK1VWpzenzs
 W2UxwTWZZ7B3kEbJM1KvtSngAFDChE0bMY5XmPNAd4lVERj9Kla6Sdayzymlu0Sc
 Ki2V+bG5bKk4m2g6soGGjHiczacllLQu9aWlz0Neyfc=;
X-AuditID: ac14000a-fadff7000000290d-9d-663a462e542a
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 67.49.10509.E264A366;
 Tue,  7 May 2024 17:18:06 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 7 May 2024
 17:18:05 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <nm@ti.com>, <bb@ti.com>, <y.moog@phytec.de>,
 <t.remmet@phytec.de>, <d.schultz@phytec.de>, <festevam@gmail.com>,
 <mkorpershoek@baylibre.com>, <joao.goncalves@toradex.com>, <n-jain1@ti.com>,
 <michael@amarulasolutions.com>, <d-gole@ti.com>, <sjg@chromium.org>,
 <clamor95@gmail.com>, <m-chawdhry@ti.com>, <afd@ti.com>, <jma@phytec.com>
Subject: [PATCH 1/5] board: phytec: Make AM6 SoM detection depend on I2C
Date: Tue, 7 May 2024 17:17:53 +0200
Message-ID: <20240507151757.1202825-2-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240507151757.1202825-1-w.egorov@phytec.de>
References: <20240507151757.1202825-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsWyRpKBR1fPzSrN4OZ+QYv3pyayW8x9c4DV
 4kB/L6NFy1oPi4dX/S2edTYxW1y+f5PV4tKDVItTja0sFi+OzWW36P//nMnizY+zTBbftmxj
 tJg6aTO7xdu9newW3e/UHQQ81n68z+rx/kYru8fshossHjtn3WX3eHVgFbvH2Ts7GD36u1tY
 Pf5cfMfqcfzGdiaPTa88AriiuGxSUnMyy1KL9O0SuDLO7v/EXDCDo2LWywVsDYw32LoYOTkk
 BEwknvbOZexi5OIQEljCJHHsyBYo5xGjxKHjxxhBqtgE1CXubPjGCmKLCJhJLFp7ng2kiFng
 HZPE+sNTwEYJC3hINHz8AtbAIqAisfjYHDCbV8BSonfFVSaIdfISMy99ZwexOQWsJKaseANW
 IwRU8/z4Z2aIekGJkzOfsIDYzED1zVtnM0PYEhIHX7xghqiXl3hxaTkLzMxp514zQ9ihEkc2
 rWaawCg0C8moWUhGzUIyagEj8ypGodzM5OzUosxsvYKMypLUZL2U1E2MoLgUYeDawdg3x+MQ
 IxMH4yFGCQ5mJRHeo+3maUK8KYmVValF+fFFpTmpxYcYpTlYlMR5V3cEpwoJpCeWpGanphak
 FsFkmTg4pRoYN/zlNbh6ZOOdEpu7Tz4sfT+TXf1cLoNzVLLSVKtMvulSX/KzAv3+2n1sNk76
 0PlwX/sKv5PtEeGOBfuu/l++pp//4eyJ8t2PduYk2N3e8eB4ffhR78DbpaHTvos8VwtZkefW
 J10x99/tULGXx3f+j3+kpB03dbsIZ27lh+Qd601DahV2zn0mrcRSnJFoqMVcVJwIAGNPCiq5
 AgAA
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

