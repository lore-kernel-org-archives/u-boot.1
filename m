Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBDDAC54798
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 14:12:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FBB187613;
	Fri, 23 Feb 2024 15:10:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=steffen.cc header.i=@steffen.cc header.b="wX05hU6a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB7A187B41; Fri, 23 Feb 2024 15:08:33 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82DEE87BC3
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 15:06:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lists@steffen.cc
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ThBdh2Mp1z9scK;
 Fri, 23 Feb 2024 15:06:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001; 
 t=1708697208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OjDHmNkmbJu2hqtel9/Q8lSpsSAEf1dVMt+3jFajZvY=;
 b=wX05hU6azfDeYf9DCwm4RzG6jbQimZ332A0KhG/dI32NQM9Byo5omB3OZcpXzkuukPuTqP
 Umb9yGgIb9KfZrTfG26GUPaePoiQGSZuMN+/3aG5fX1+yJ7PLxGJrj7TuF6CqxSWg2eVV/
 Lfc8rJ+vcpH++2/rENzXR5RgiH07TLLUcd8ts/EoDHX8PZ+HDAs+OeX+NcH5js4BUVTrAg
 1BkT0Zd5oJrFQPRDYiUdF6g3V6NfC+5fymTqoPeQLTTWqcfha9Zfmf8I6M/BhKn+sLhEvj
 J/gKmg/vYg8atWsX3Na86d5gbZAVnM7EtSRIpCydXxzJO6Juq+XKVbPV/sp2Ww==
From: Steffen Dirkwinkel <lists@steffen.cc>
To: u-boot@lists.denx.de
Cc: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Johan Jonker <jbx6244@gmail.com>,
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/5] mmc: zynq-sdhci: refactor tapdelay settings
Date: Fri, 23 Feb 2024 15:06:10 +0100
Message-Id: <20240223140613.1240570-2-lists@steffen.cc>
In-Reply-To: <20240223140613.1240570-1-lists@steffen.cc>
References: <20240223140613.1240570-1-lists@steffen.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4ThBdh2Mp1z9scK
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

From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

Previously we were setting in tapdelay for SD1 every time even if SD0 was
requested.
The SD tapdelay settings are shifted by 16 bits between SD0 and SD1.
We can use that to make our tapdelay setup simpler. This is also how it
currently works in arm-trusted-firmware.

Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
---

 drivers/mmc/zynq_sdhci.c | 65 +++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 37 deletions(-)

diff --git a/drivers/mmc/zynq_sdhci.c b/drivers/mmc/zynq_sdhci.c
index 935540d1719..d4845245b2a 100644
--- a/drivers/mmc/zynq_sdhci.c
+++ b/drivers/mmc/zynq_sdhci.c
@@ -42,14 +42,11 @@
 #define SD_OTAP_DLY			0xFF180318
 #define SD0_DLL_RST			BIT(2)
 #define SD1_DLL_RST			BIT(18)
+#define SD1_TAP_OFFSET			16
 #define SD0_ITAPCHGWIN			BIT(9)
-#define SD1_ITAPCHGWIN			BIT(25)
 #define SD0_ITAPDLYENA			BIT(8)
-#define SD1_ITAPDLYENA			BIT(24)
 #define SD0_ITAPDLYSEL_MASK		GENMASK(7, 0)
-#define SD1_ITAPDLYSEL_MASK		GENMASK(23, 16)
 #define SD0_OTAPDLYSEL_MASK		GENMASK(5, 0)
-#define SD1_OTAPDLYSEL_MASK		GENMASK(21, 16)
 
 #define MIN_PHY_CLK_HZ			50000000
 
@@ -275,44 +272,32 @@ static int arasan_sdhci_config_dll(struct sdhci_host *host, unsigned int clock,
 static inline int arasan_zynqmp_set_in_tapdelay(u32 node_id, u32 itap_delay)
 {
 	int ret;
+	u32 shift;
 
-	if (IS_ENABLED(CONFIG_SPL_BUILD) || current_el() == 3) {
-		if (node_id == NODE_SD_0) {
-			ret = zynqmp_mmio_write(SD_ITAP_DLY, SD0_ITAPCHGWIN,
-						SD0_ITAPCHGWIN);
-			if (ret)
-				return ret;
-
-			ret = zynqmp_mmio_write(SD_ITAP_DLY, SD0_ITAPDLYENA,
-						SD0_ITAPDLYENA);
-			if (ret)
-				return ret;
-
-			ret = zynqmp_mmio_write(SD_ITAP_DLY, SD0_ITAPDLYSEL_MASK,
-						itap_delay);
-			if (ret)
-				return ret;
+	if (node_id == NODE_SD_0)
+		shift = 0;
+	else if (node_id == NODE_SD_1)
+		shift = SD1_TAP_OFFSET;
+	else
+		return -EINVAL;
 
-			ret = zynqmp_mmio_write(SD_ITAP_DLY, SD0_ITAPCHGWIN, 0);
-			if (ret)
-				return ret;
-		}
-		ret = zynqmp_mmio_write(SD_ITAP_DLY, SD1_ITAPCHGWIN,
-					SD1_ITAPCHGWIN);
+	if (IS_ENABLED(CONFIG_SPL_BUILD) || current_el() == 3) {
+		ret = zynqmp_mmio_write(SD_ITAP_DLY, SD0_ITAPCHGWIN << shift,
+					SD0_ITAPCHGWIN << shift);
 		if (ret)
 			return ret;
 
-		ret = zynqmp_mmio_write(SD_ITAP_DLY, SD1_ITAPDLYENA,
-					SD1_ITAPDLYENA);
+		ret = zynqmp_mmio_write(SD_ITAP_DLY, SD0_ITAPDLYENA << shift,
+					SD0_ITAPDLYENA << shift);
 		if (ret)
 			return ret;
 
-		ret = zynqmp_mmio_write(SD_ITAP_DLY, SD1_ITAPDLYSEL_MASK,
-					(itap_delay << 16));
+		ret = zynqmp_mmio_write(SD_ITAP_DLY, SD0_ITAPDLYSEL_MASK << shift,
+					itap_delay << shift);
 		if (ret)
 			return ret;
 
-		ret = zynqmp_mmio_write(SD_ITAP_DLY, SD1_ITAPCHGWIN, 0);
+		ret = zynqmp_mmio_write(SD_ITAP_DLY, SD0_ITAPCHGWIN << shift, 0);
 		if (ret)
 			return ret;
 	} else {
@@ -326,14 +311,20 @@ static inline int arasan_zynqmp_set_in_tapdelay(u32 node_id, u32 itap_delay)
 
 static inline int arasan_zynqmp_set_out_tapdelay(u32 node_id, u32 otap_delay)
 {
+	u32 shift;
+
+	if (node_id == NODE_SD_0)
+		shift = 0;
+	else if (node_id == NODE_SD_1)
+		shift = SD1_TAP_OFFSET;
+	else
+		return -EINVAL;
+
 	if (IS_ENABLED(CONFIG_SPL_BUILD) || current_el() == 3) {
-		if (node_id == NODE_SD_0)
-			return zynqmp_mmio_write(SD_OTAP_DLY,
-						 SD0_OTAPDLYSEL_MASK,
-						 otap_delay);
+		return zynqmp_mmio_write(SD_OTAP_DLY,
+						SD0_OTAPDLYSEL_MASK << shift,
+						otap_delay << shift);
 
-		return zynqmp_mmio_write(SD_OTAP_DLY, SD1_OTAPDLYSEL_MASK,
-					 (otap_delay << 16));
 	} else {
 		return xilinx_pm_request(PM_IOCTL, node_id,
 					 IOCTL_SET_SD_TAPDELAY,
-- 
2.39.2

