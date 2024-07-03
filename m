Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B87C2BD09
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 13:48:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84B0188850;
	Wed,  3 Jul 2024 15:46:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="UOJF/yog";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBF79887C7; Wed,  3 Jul 2024 07:42:54 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE68688784
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 07:42:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1719985372; x=1722577372;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ATpiPswaz3CS1mtfFPOsDlv2Qy+h2JJtT2rAryelqpY=;
 b=UOJF/yogC94f8DEbkSU1hxkbWZ2Ic/OrMGifadvMurpZU1QMJUHzaH1eqoaJ9Byw
 0DcdUZDYDswSKDL7dougUYru1O2vO4TEsWH8RBfUy6pVhtvFmSj8AlDq/21AHeGn
 awriqu+6p/y981icY6jnY5fKaRsa7J/KuRtsQVB6GBg=;
X-AuditID: ac14000a-03251700000021bc-87-6684e4dc9edb
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 5D.7D.08636.CD4E4866;
 Wed,  3 Jul 2024 07:42:52 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 3 Jul 2024
 07:42:50 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, <trini@konsulko.com>, 
 <m.othacehe@gmail.com>, <joe.hershberger@ni.com>, <w.egorov@phytec.de>,
 <t.remmet@phytec.de>
CC: <d-gole@ti.com>, <festevam@gmail.com>, <mkorpershoek@baylibre.com>,
 <sjg@chromium.org>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 9/9] board: phytec: phycore_am64x: Use k3_mmc.env logic
Date: Tue, 2 Jul 2024 22:42:02 -0700
Message-ID: <20240703054202.2812540-10-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240703054202.2812540-1-d.schultz@phytec.de>
References: <20240703054202.2812540-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsWyRpKBR/fOk5Y0gwP95hYtaz0sHl71t/i0
 8zGrxYyb09gsXhyby27xbcs2RoupkzazW7zd28lu0f1O3YHT4/2NVnaP2Q0XWTx2zrrL7vHq
 wCp2j7N3djB69He3sHpcP7OdyeP4je1MARxRXDYpqTmZZalF+nYJXBldK++xFhzlqDjTldrA
 uJO9i5GTQ0LAROJFYxeQzcUhJLCESaL7eSMbhHOPUWLC77tgVWwCWhJ3tsxlBkmICKxjlJh7
 ZRMTiMMs0MQoMbHlMhNIlbCAu8SpZ7+YQWwWARWJnU+vs4DYvALWEivXHWeB2CcvMfPSd7Cp
 nEDxyb+fA9VzAK2zklj4xxyiXFDi5MwnYOXMQOXNW2czQ9gSEgdfvACzhQQUJGZvm8wIM3La
 udfMEHaoxNYv25kmMArNQjJqFpJRs5CMWsDIvIpRKDczOTu1KDNbryCjsiQ1WS8ldRMjKH5E
 GLh2MPbN8TjEyMTBeIhRgoNZSYRX6n1zmhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe1R3BqUIC
 6YklqdmpqQWpRTBZJg5OqQZGy0rFypcbVkTdCP2231zj2uc2dpeYvayqwpUpyy4nM4Zvdu/a
 s34ax53SIo6PpzufT37Nt9ehQcfdvN9G6dFGB5GLp/VyjhU+mzxNNP/KkmelF1vl49fzNlmU
 7b/4atWsl7+Ta97k+k7bPUPb6e+NbazvXu2yaqqXvCF487D5PSF/R4kw0Q9vlFiKMxINtZiL
 ihMBsVg9hY0CAAA=
X-Mailman-Approved-At: Wed, 03 Jul 2024 15:46:48 +0200
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

Use our common environment file to implement MMC boot.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 board/phytec/phycore_am64x/phycore_am64x.env | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/board/phytec/phycore_am64x/phycore_am64x.env b/board/phytec/phycore_am64x/phycore_am64x.env
index e24a958f51d..18f0fa5b4c3 100644
--- a/board/phytec/phycore_am64x/phycore_am64x.env
+++ b/board/phytec/phycore_am64x/phycore_am64x.env
@@ -1,3 +1,5 @@
+#include <env/phytec/k3_mmc.env>
+
 fdtaddr=0x88000000
 loadaddr=0x82000000
 scriptaddr=0x80000000
@@ -12,13 +14,3 @@ mmcroot=2
 mmcpart=1
 console=ttyS2,115200n8
 earlycon=ns16550a,mmio32,0x02800000
-mmcargs=setenv bootargs console=${console} earlycon=${earlycon}
-	root=/dev/mmcblk${mmcdev}p${mmcroot} rootwait rw
-loadimage=load mmc ${mmcdev}:${mmcpart} ${loadaddr} Image
-loadfdt=load mmc ${mmcdev}:${mmcpart} ${fdtaddr} ${fdtfile}
-mmcboot=run mmcargs;
-	mmc dev ${mmcdev};
-	mmc rescan;
-	run loadimage;
-	run loadfdt;
-	booti ${loadaddr} - ${fdtaddr}
-- 
2.25.1

