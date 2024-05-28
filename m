Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C9CC25B7C
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 13:35:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95F8E884FA;
	Tue, 28 May 2024 15:35:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="aiXCW/w0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB046883A0; Tue, 28 May 2024 15:35:28 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0D728841F
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 15:35:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=T.Remmet@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1716903326; x=1719495326;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VPtuipvuphyhkGrMO4LRh8iXLed6cbLXmgYbzvcIcU4=;
 b=aiXCW/w0v98+rx4EQCrrb6qzTjDYzja9WRoeNPWGmlJjzhJ9m8ghWiTkmG/ehdWA
 N2gnM9gCTKe8LqwZBXOeubGdQdfmDIzCFwhmymJwRyFCEdhDEbqgk+XkADfjkkPc
 xxcHKd6XA9+dy0r0yadv8c1cRl2tnPYXdqYQCVHYx8Q=;
X-AuditID: ac14000a-03e52700000021bc-26-6655dd9e202e
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id C2.E8.08636.E9DD5566;
 Tue, 28 May 2024 15:35:26 +0200 (CEST)
Received: from llp-tremmet2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 28 May
 2024 15:35:26 +0200
From: Teresa Remmet <t.remmet@phytec.de>
To: <u-boot@lists.denx.de>
CC: Yannic Moog <y.moog@phytec.de>, Fabio Estevam <festevam@gmail.com>, Tom
 Rini <trini@konsulko.com>, Benjamin Hahn <B.Hahn@phytec.de>, Yashwanth
 Varakala <y.varakala@phytec.de>, Wadim Egorov <w.egorov@phytec.de>,
 <upstream@lists.phytec.de>
Subject: [PATCH 1/4] board: phytec: phycore-imx8mp: spl: Fix syle issue
Date: Tue, 28 May 2024 15:35:12 +0200
Message-ID: <20240528133515.307315-2-t.remmet@phytec.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528133515.307315-1-t.remmet@phytec.de>
References: <20240528133515.307315-1-t.remmet@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsWyRpKBR3fe3dA0gwedmhYPr/pbTJ20md3i
 7d5Odovud+oOLB47Z91l93h1YBW7x9k7Oxg9+rtbWANYorhsUlJzMstSi/TtErgyXnxUKJjF
 WrF59lumBsZVLF2MnBwSAiYSy1o/AdlcHEICS5gkjsw5xASSEBJ4yihxcoUViM0moCHxdMVp
 sLiIgJTEy86NzCANzALfGSXmLOxnB0kIC7hLnOtcyApiswioSpxfupINxOYVsJBY0vKcDWKb
 vMT+g2eZQWxOAUuJFZP6oJZZSFzcv4cZol5Q4uTMJ2DXMQPVN2+dzQxhS0gcfPGCGaJeXmLX
 pZOMMDOnnXvNDGGHShzZtJppAqPQLCSjZiEZNQvJqAWMzKsYhXIzk7NTizKz9QoyKktSk/VS
 UjcxgoJchIFrB2PfHI9DjEwcjIcYJTiYlUR4z0wKTRPiTUmsrEotyo8vKs1JLT7EKM3BoiTO
 u7ojOFVIID2xJDU7NbUgtQgmy8TBKdXAyHDGvbvp1vGO/U4bJgu4dNko+Mya9G3uHiuRmcob
 JZate/r6kGLfq6jTk2LelSlpS3ZbfX/me1787/T5/3/GmMfOmausmv64NsavWmvyUpaZ86O4
 N3+VeOz7tFE/eTnnfcXesI0N+ddWGrpWaFSumMEueVxY2cTobv2L26HJi1vS2yaJrjvRpMRS
 nJFoqMVcVJwIAHhwj+NgAgAA
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

Use tabs instead of spaces.

Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
---
 board/phytec/phycore_imx8mp/spl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/phytec/phycore_imx8mp/spl.c b/board/phytec/phycore_imx8mp/spl.c
index df158024654e..492ce3b7ca6e 100644
--- a/board/phytec/phycore_imx8mp/spl.c
+++ b/board/phytec/phycore_imx8mp/spl.c
@@ -25,8 +25,8 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-#define EEPROM_ADDR             0x51
-#define EEPROM_ADDR_FALLBACK    0x59
+#define EEPROM_ADDR		0x51
+#define EEPROM_ADDR_FALLBACK	0x59
 
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {
-- 
2.34.1

