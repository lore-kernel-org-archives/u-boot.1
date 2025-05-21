Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D25D7C2D0CD
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 12:36:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8664882F10;
	Wed, 21 May 2025 14:36:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="rbeFEK4C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D051482E2D; Wed, 21 May 2025 14:29:11 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36B8982ED0
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 14:29:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7236647066=antonio.borneo@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LAtt2m027728;
 Wed, 21 May 2025 14:29:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 ls8dx3XqZjziXW6N70aAJw18VFM1Q/6VdCHNig5QGd8=; b=rbeFEK4C9iRAm7lP
 xGCVqWCy7tX4B/t4xUtwfBU+qwGSq0ufEbYoOQp+CkJe6H/WGQEOo39JP91ONtnw
 0CeFQ/JfA6m6HSSXOu8k4GGMhO2tID9ba/AsvdvoOJ4oyWgdnjakz1hUrkxp1Ja6
 mKtX7KKTVmZuHIzvM8OHfw4BtoaCnqS7wWX2qI8WlQVdkjwvRID5+Jscaui2NQdV
 W4dzcBCEWuitzC/TGWaZhAj/PyauGeO57atwgk1d2TTei8DW9VR73bnLsscOMQ8f
 8ILLQlUrfZjNof73JCt8G0i4p3RQeukYMZ30/FgUsMgBufwY0qaploiFrCLkfMke
 w607jA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46rwfqkvuy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 May 2025 14:29:03 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 093114004D;
 Wed, 21 May 2025 14:28:25 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5CF42BDF165;
 Wed, 21 May 2025 14:28:12 +0200 (CEST)
Received: from localhost (10.252.16.84) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 14:28:11 +0200
From: Antonio Borneo <antonio.borneo@foss.st.com>
To: <u-boot@lists.denx.de>, Stefan Roese <sr@denx.de>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
CC: Antonio Borneo <antonio.borneo@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, Lionel Debieve
 <lionel.debieve@foss.st.com>, =?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=
 <clement.legoffic@foss.st.com>
Subject: [PATCH 3/4] watchdog: stm32mp: check the watchdog status
Date: Wed, 21 May 2025 14:27:54 +0200
Message-ID: <20250521122755.265760-4-antonio.borneo@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521122755.265760-1-antonio.borneo@foss.st.com>
References: <20250521122755.265760-1-antonio.borneo@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.16.84]
X-ClientProxiedBy: SAFCAS1NODE1.st.com (10.75.90.11) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_04,2025-05-20_03,2025-03-28_01
X-Mailman-Approved-At: Wed, 21 May 2025 14:36:09 +0200
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

From: Clément Le Goffic <clement.legoffic@foss.st.com>

Add a mean to check the IWDG status based on the peripheral version.
This is done by either checking the status bit ONF either by updating
the reload register with the same value and check if the reload succeed.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 drivers/watchdog/stm32mp_wdt.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/watchdog/stm32mp_wdt.c b/drivers/watchdog/stm32mp_wdt.c
index 97ab8cfe7ab..0712524b4a8 100644
--- a/drivers/watchdog/stm32mp_wdt.c
+++ b/drivers/watchdog/stm32mp_wdt.c
@@ -21,11 +21,13 @@
 #define IWDG_PR		0x04	/* Prescaler Register */
 #define IWDG_RLR	0x08	/* ReLoad Register */
 #define IWDG_SR		0x0C	/* Status Register */
+#define IWDG_VERR	0x3F4	/* Version Register */
 
 /* IWDG_KR register bit mask */
 #define KR_KEY_RELOAD	0xAAAA	/* Reload counter enable */
 #define KR_KEY_ENABLE	0xCCCC	/* Peripheral enable */
 #define KR_KEY_EWA	0x5555	/* Write access enable */
+#define KR_KEY_DWA	0x0000	/* Write access disable*/
 
 /* IWDG_PR register bit values */
 #define PR_256		0x06	/* Prescaler set to 256 */
@@ -36,10 +38,17 @@
 /* IWDG_SR register bit values */
 #define SR_PVU		BIT(0)	/* Watchdog prescaler value update */
 #define SR_RVU		BIT(1)	/* Watchdog counter reload value update */
+#define SR_ONF		BIT(8)	/* Watchdog enable status bit */
+
+/* IWDG Compatibility */
+#define ONF_MIN_VER	0x31
+
+#define TIMEOUT_US	10000
 
 struct stm32mp_wdt_priv {
 	fdt_addr_t base;		/* registers addr in physical memory */
 	unsigned long wdt_clk_rate;	/* Watchdog dedicated clock rate */
+	unsigned int hw_version;	/* Peripheral version */
 };
 
 static int stm32mp_wdt_reset(struct udevice *dev)
@@ -90,6 +99,7 @@ static int stm32mp_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 static int stm32mp_wdt_probe(struct udevice *dev)
 {
 	struct stm32mp_wdt_priv *priv = dev_get_priv(dev);
+	u32 rlr, sr;
 	struct clk clk;
 	int ret;
 
@@ -115,6 +125,29 @@ static int stm32mp_wdt_probe(struct udevice *dev)
 
 	priv->wdt_clk_rate = clk_get_rate(&clk);
 
+	priv->hw_version = readl(priv->base + IWDG_VERR);
+
+	if (priv->hw_version >= ONF_MIN_VER) {
+		if (readl(priv->base + IWDG_SR) & SR_ONF)
+			wdt_set_force_autostart(dev);
+	} else {
+		/*
+		 * Workaround for old versions without IWDG_SR_ONF bit:
+		 * - write in IWDG_RLR_OFFSET
+		 * - wait for sync
+		 * - if sync succeeds, then iwdg is running
+		 */
+		writel(KR_KEY_EWA, priv->base + IWDG_KR);
+		rlr = readl(priv->base + IWDG_RLR);
+		writel(rlr, priv->base + IWDG_RLR);
+		ret = readl_poll_timeout(priv->base + IWDG_SR, sr, sr & SR_RVU,
+					 TIMEOUT_US);
+		if (!ret)
+			wdt_set_force_autostart(dev);
+
+		writel(KR_KEY_DWA, priv->base + IWDG_KR);
+	}
+
 	dev_dbg(dev, "IWDG init done\n");
 
 	return 0;
-- 
2.34.1

