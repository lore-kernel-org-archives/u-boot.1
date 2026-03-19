Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F701075275
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 08:38:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C18C83FF5;
	Thu, 19 Mar 2026 09:38:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E7E684006; Thu, 19 Mar 2026 09:37:59 +0100 (CET)
Received: from Atcsqr.andestech.com (exmail.andestech.com [60.248.187.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA6D583FEC
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 09:37:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTP id 62J8bIe9017662;
 Thu, 19 Mar 2026 16:37:18 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Mar
 2026 16:37:18 +0800
From: Leo Yu-Chi Liang <ycliang@andestech.com>
To: <u-boot@lists.denx.de>
CC: <pbonzini@redhat.com>, <trini@konsulko.com>, <rick@andestech.com>,
 <ycliang@andestech.com>, <jerome.forissier@arm.com>,
 <xypron.glpk@gmx.de>, <ilias.apalodimas@linaro.org>,
 <kory.maincent@bootlin.com>,
 <eric.schikschneit@novatechautomation.com>, <sputnik@on-the-web.ch>,
 <michal.simek@amd.com>, <cnoize@andestech.com>, <qemu-devel@nongnu.org>
Subject: [PATCH 5/6] net: ftmac100: Add noncached memory support for DMA
 descriptors
Date: Thu, 19 Mar 2026 16:37:12 +0800
Message-ID: <20260319083713.3456894-3-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319083713.3456894-1-ycliang@andestech.com>
References: <20260319083713.3456894-1-ycliang@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 62J8bIe9017662
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

Change TX and RX DMA descriptors from inline arrays embedded in
struct ftmac100_data to dynamically allocated pointers. When
CONFIG_SYS_NONCACHED_MEMORY is enabled, allocate descriptors from
the noncached memory region using noncached_alloc(); otherwise
fall back to memalign().

Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 drivers/net/ftmac100.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ftmac100.c b/drivers/net/ftmac100.c
index fa0b3dbb6d1..f7f7db56130 100644
--- a/drivers/net/ftmac100.c
+++ b/drivers/net/ftmac100.c
@@ -30,8 +30,8 @@ DECLARE_GLOBAL_DATA_PTR;
 #define FTMAC100_MDIO_TIMEOUT_USEC     10000
 
 struct ftmac100_data {
-	struct ftmac100_txdes txdes[1];
-	struct ftmac100_rxdes rxdes[PKTBUFSRX];
+	struct ftmac100_txdes *txdes;
+	struct ftmac100_rxdes *rxdes;
 	int rx_index;
 	const char *name;
 	struct ftmac100 *ftmac100;
@@ -403,12 +403,35 @@ static int ftmac100_mdio_init(struct udevice *dev)
 	return 0;
 }
 
+static void *ftmac100_alloc_descs(unsigned int num, unsigned int size)
+{
+#ifdef CONFIG_SYS_NONCACHED_MEMORY
+	return (void *)noncached_alloc(num * size,
+				       ARCH_DMA_MINALIGN);
+#else
+	return memalign(ARCH_DMA_MINALIGN, num * size);
+#endif
+}
+
 static int ftmac100_probe(struct udevice *dev)
 {
 	struct ftmac100_data *priv = dev_get_priv(dev);
 	priv->name = dev->name;
 	int ret = 0;
 
+	priv->txdes = ftmac100_alloc_descs(1, sizeof(struct ftmac100_txdes));
+	if (!priv->txdes) {
+		dev_err(dev, "Failed to allocate tx descriptors\n");
+		return -ENOMEM;
+	}
+
+	priv->rxdes = ftmac100_alloc_descs(PKTBUFSRX,
+					   sizeof(struct ftmac100_rxdes));
+	if (!priv->rxdes) {
+		dev_err(dev, "Failed to allocate rx descriptors\n");
+		return -ENOMEM;
+	}
+
 	ret = ftmac100_mdio_init(dev);
 	if (ret) {
 		dev_err(dev, "Failed to initialize mdiobus: %d\n", ret);
-- 
2.34.1

