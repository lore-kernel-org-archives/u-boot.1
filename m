Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 003DECD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 15:42:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CBB084D5A;
	Fri,  8 May 2026 17:42:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 757A184D64; Fri,  8 May 2026 17:42:42 +0200 (CEST)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DC6684D2F
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 17:42:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=duwe@lst.de
Received: by verein.lst.de (Postfix, from userid 2005)
 id 1E16368BFE; Fri,  8 May 2026 17:42:39 +0200 (CEST)
To: Simon Glass <sjg@chromium.org>
Cc: Peter Robinson <pbrobinson@gmail.com>, Matthias Brugger <mbrugger@suse.com>,
    Bin Meng <bmeng.cn@gmail.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
    Tom Rini <trini@konsulko.com>, Andrea della Porta <andrea.porta@suse.com>,
    Neil Armstrong <neil.armstrong@linaro.org>, "Jan Čermák" <sairon@sairon.cz>,
    u-boot@lists.denx.de
Subject: [PATCH 1/3] core: Skip parent device nodes without a DT reference
 when looking for dma-ranges
In-Reply-To: <20260508154108.336B968BEB@verein.lst.de>
References: <20260508154108.336B968BEB@verein.lst.de>
Message-Id: <20260508154239.1E16368BFE@verein.lst.de>
Date: Fri,  8 May 2026 17:42:39 +0200 (CEST)
From: duwe@lst.de (Torsten Duwe)
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

From: Torsten Duwe <duwe@suse.de>

If a device node got created dynamically, there is no guarantee that the
parent node has an associated device tree node which could specify dma
constraints. Especially PCI(e) enumeration adds intermediate "bus nodes",
also dynamically.

Try harder to find the correct configuration by walking up the tree until
a DT association is found.

Suggested-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Torsten Duwe <duwe@suse.de>

---
 drivers/core/device.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/core/device.c b/drivers/core/device.c
index 779f371b9d5..9de64dbb3c5 100644
--- a/drivers/core/device.c
+++ b/drivers/core/device.c
@@ -459,7 +459,19 @@ static int device_get_dma_constraints(struct udevice *dev)
 	u64 size = 0;
 	int ret;
 
-	if (!CONFIG_IS_ENABLED(DM_DMA) || !parent || !dev_has_ofnode(parent))
+	if (!CONFIG_IS_ENABLED(DM_DMA) || !parent)
+		return 0;
+
+	/* Look for the first node in the parent chain */
+	while (parent) {
+		if (dev_has_ofnode(parent))
+			break;
+
+		parent = dev_get_parent(parent);
+	}
+
+	/* No parents have a node, bail out */
+	if (!parent)
 		return 0;
 
 	/*
-- 
2.54.0

