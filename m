Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA30C27C79
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 12:06:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A139E8834D;
	Thu, 20 Jun 2024 14:06:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="l+Sbe1el";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6154388378; Thu, 20 Jun 2024 14:06:07 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73FC687EBD
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 14:06:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1718885165; x=1721477165;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9mLOxA9tjJMp/TG163/E8BBZIOQMpR1J+I8dHlbZJ84=;
 b=l+Sbe1elUSt/xmG3ruCcAMbEvNqsdDmYWE6r1+X2e8RV3qDJyWjYYIeyotnxwMGg
 i5LDQQsQy5LMpPErUOoEMs2soWxB+Lcgyyfw4rybMVIrzkkZJ0XQRAPUAY8GZ7oz
 RuosE1tFO3CnxQICV8o53lfN8PAWKKYSg5Zfx4YGwVk=;
X-AuditID: ac14000a-03e52700000021bc-45-66741b2dabb5
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 80.45.08636.D2B14766;
 Thu, 20 Jun 2024 14:06:05 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 20 Jun
 2024 14:06:04 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <d.schultz@phytec.de>
Subject: [PATCH] doc: board: phytec: phycore-am6: Describe UART based boot
Date: Thu, 20 Jun 2024 14:05:54 +0200
Message-ID: <20240620120554.2640307-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLLMWRmVeSWpSXmKPExsWyRpKBR1dXuiTN4OxufoupkzazW7zd28lu
 0f1O3YHZ49WBVeweZ+/sYPTo725hDWCO4rJJSc3JLEst0rdL4Mq40bqZuaBbpOJU/w32BsYD
 Al2MnBwSAiYS539MYu9i5OIQEljCJNF/6j0rhPOYUaL9xDNmkCo2AXWJOxu+sYLYIgJmEovW
 nmcDsZkF9CXmXlgJZgsLeEl0bFwEVs8ioCrx6lsHWD2vgKXE1iVtzBDb5CVmXvrODhEXlDg5
 8wkLxBx5ieats5khbAmJgy9egNlCQPEXl5azwPROO/caak6oxJFNq5kmMArMQjJqFpJRs5CM
 WsDIvIpRKDczOTu1KDNbryCjsiQ1WS8ldRMjKEhFGLh2MPbN8TjEyMTBeIhRgoNZSYT3eVdR
 mhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe1R3BqUIC6YklqdmpqQWpRTBZJg5OqQbGyPked4T/
 /0ueeeOv17s8nV/nt5nPlJj33OWIe2nj9t6zOgvkJecrdv3SZBLtubVISMB/Vexl06lVixVe
 rQ91tFgqOvud7KZC9QVpGjfXvz6yqaqCu2bO8QuMTJ2nExaYa2hyCIfzqzbPeN9ac3qXSJDH
 l3UTNvqfanw1MfOE8cq37ZdPbllxWYmlOCPRUIu5qDgRAOt1xotAAgAA
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

Describe how to boot via UART.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
For next
---
 doc/board/phytec/phycore-am62x.rst | 17 +++++++++++++++++
 doc/board/phytec/phycore-am64x.rst | 19 +++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/doc/board/phytec/phycore-am62x.rst b/doc/board/phytec/phycore-am62x.rst
index a615d01474e..5f02a9db5f8 100644
--- a/doc/board/phytec/phycore-am62x.rst
+++ b/doc/board/phytec/phycore-am62x.rst
@@ -118,6 +118,23 @@ tiboot3.bin, tispl.bin and u-boot.img are stored on the uSD card.
   fatload mmc 1 ${loadaddr} u-boot.img
   mtd write ospi.u-boot ${loadaddr} 0 ${filesize}
 
+UART based boot
+---------------
+
+To boot the board via UART, set the switches to UART mode and connect to the
+micro USB port labeled as "Debug UART". After power-on the build artifacts
+needs to be uploaded one by one with a tool like sz.
+
+Example bash script sequence for running on a Linux host PC feeding all boot
+artifacts needed to the device. Assuming the host uses /dev/ttyUSB0 as
+the main domain serial port:
+
+.. prompt:: bash $
+
+  stty -F /dev/ttyUSB0 115200
+  sb --xmodem tiboot3.bin > /dev/ttyUSB0 < /dev/ttyUSB0
+  sb --ymodem tispl.bin > /dev/ttyUSB0 < /dev/ttyUSB0
+  sb --ymodem u-boot.img > /dev/ttyUSB0 < /dev/ttyUSB0
 
 Boot Modes
 ----------
diff --git a/doc/board/phytec/phycore-am64x.rst b/doc/board/phytec/phycore-am64x.rst
index 189da179534..e7f8656e1bf 100644
--- a/doc/board/phytec/phycore-am64x.rst
+++ b/doc/board/phytec/phycore-am64x.rst
@@ -119,6 +119,25 @@ tiboot3.bin, tispl.bin and u-boot.img are stored on the uSD card.
   fatload mmc 1 ${loadaddr} u-boot.img
   mtd write ospi.u-boot ${loadaddr} 0 ${filesize}
 
+UART based boot
+---------------
+
+To boot the board via UART, set the switches to UART mode and connect to the
+micro USB port labeled as "Debug UART". After power-on the build artifacts
+needs to be uploaded one by one with a tool like sz.
+
+Example bash script sequence for running on a Linux host PC feeding all boot
+artifacts needed to the device. Assuming the host uses /dev/ttyUSB0 as
+the main domain serial port:
+
+.. prompt:: bash $
+
+  stty -F /dev/ttyUSB0 115200
+  sb --xmodem tiboot3.bin > /dev/ttyUSB0 < /dev/ttyUSB0
+  # Resend tiboot3.bin a 2nd time due to ErrataID:i2331
+  sb --xmodem tiboot3.bin > /dev/ttyUSB0 < /dev/ttyUSB0
+  sb --ymodem tispl.bin > /dev/ttyUSB0 < /dev/ttyUSB0
+  sb --ymodem u-boot.img > /dev/ttyUSB0 < /dev/ttyUSB0
 
 Boot Modes
 ----------
-- 
2.34.1

