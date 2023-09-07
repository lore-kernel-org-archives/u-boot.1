Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC0EEC8742
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 17:10:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CDEF86AC6;
	Thu,  7 Sep 2023 19:09:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="ipMAK68e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF28F869C3; Thu,  7 Sep 2023 18:23:52 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE498833F5
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 18:23:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=76143956a4=gatien.chevallier@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 387D6MRg016966; Thu, 7 Sep 2023 18:23:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=
 selector1; bh=T8573c3HBH92ibmJ2izs7LETxnDG3vPNIRKGvKErz9g=; b=ip
 MAK68eWp8z/f9Eze4/1DJ6LC4zMEX37vsXzQLvavSlPrXdRp8vbJ4E9y4+t6ovAp
 YdqBsMWWHK897vIyx1VXDqGijNhf/blyAmt8fi7lZGIkcGfzJ2Y0So57FQeyhplN
 kV7w7q28a0tdKjpK+JwE2GJPVhHKF3uO5Ba2PcuQyhw/MQ8lL/acim3CfG8u8WFY
 P/5TuqnYYxMcmJZlYokKWzLvj93a3pn6kqeQ9ZKfKztGpe3KBRbkXwNfqqXyDFum
 ++EkKGChMlNrk7Wcvim5seDa9Bg/0ji0XvgSDCdRCZlZjdhJ8yHp576Z74xBTvT1
 hcWjoSa6po1fdcbWhLYA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sutffq2bq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 Sep 2023 18:23:46 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 75F5F100056;
 Thu,  7 Sep 2023 18:23:46 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6AC9D21161D;
 Thu,  7 Sep 2023 18:23:46 +0200 (CEST)
Received: from localhost (10.201.20.32) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 7 Sep
 2023 18:23:46 +0200
From: Gatien Chevallier <gatien.chevallier@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 <uboot-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 5/7] rng: stm32: add error concealment sequence
Date: Thu, 7 Sep 2023 18:21:58 +0200
Message-ID: <20230907162200.205602-5-gatien.chevallier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230907162200.205602-1-gatien.chevallier@foss.st.com>
References: <20230907162200.205602-1-gatien.chevallier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.20.32]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_08,2023-09-05_01,2023-05-22_02
X-Mailman-Approved-At: Thu, 07 Sep 2023 19:09:23 +0200
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

Seed errors can occur when using the hardware RNG. Implement the
sequences to handle them. This avoids irrecoverable RNG state.

Try to conceal seed errors when possible. If, despite the error
concealing tries, a seed error is still present, then return an error.

A clock error does not compromise the hardware block and data can
still be read from RNG_DR. Just warn that the RNG clock is too slow
and clear RNG_SR.

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
 drivers/rng/stm32_rng.c | 163 ++++++++++++++++++++++++++++++++++------
 1 file changed, 140 insertions(+), 23 deletions(-)

diff --git a/drivers/rng/stm32_rng.c b/drivers/rng/stm32_rng.c
index f943acd7d2..b1a790b217 100644
--- a/drivers/rng/stm32_rng.c
+++ b/drivers/rng/stm32_rng.c
@@ -32,6 +32,8 @@
 
 #define RNG_DR		0x08
 
+#define RNG_NB_RECOVER_TRIES	3
+
 /*
  * struct stm32_rng_data - RNG compat data
  *
@@ -52,45 +54,160 @@ struct stm32_rng_plat {
 	bool ced;
 };
 
+/*
+ * Extracts from the STM32 RNG specification when RNG supports CONDRST.
+ *
+ * When a noise source (or seed) error occurs, the RNG stops generating
+ * random numbers and sets to “1” both SEIS and SECS bits to indicate
+ * that a seed error occurred. (...)
+ *
+ * 1. Software reset by writing CONDRST at 1 and at 0 (see bitfield
+ * description for details). This step is needed only if SECS is set.
+ * Indeed, when SEIS is set and SECS is cleared it means RNG performed
+ * the reset automatically (auto-reset).
+ * 2. If SECS was set in step 1 (no auto-reset) wait for CONDRST
+ * to be cleared in the RNG_CR register, then confirm that SEIS is
+ * cleared in the RNG_SR register. Otherwise just clear SEIS bit in
+ * the RNG_SR register.
+ * 3. If SECS was set in step 1 (no auto-reset) wait for SECS to be
+ * cleared by RNG. The random number generation is now back to normal.
+ */
+static int stm32_rng_conceal_seed_error_cond_reset(struct stm32_rng_plat *pdata)
+{
+	u32 sr = readl_relaxed(pdata->base + RNG_SR);
+	u32 cr = readl_relaxed(pdata->base + RNG_CR);
+	int err;
+
+	if (sr & RNG_SR_SECS) {
+		/* Conceal by resetting the subsystem (step 1.) */
+		writel_relaxed(cr | RNG_CR_CONDRST, pdata->base + RNG_CR);
+		writel_relaxed(cr & ~RNG_CR_CONDRST, pdata->base + RNG_CR);
+	} else {
+		/* RNG auto-reset (step 2.) */
+		writel_relaxed(sr & ~RNG_SR_SEIS, pdata->base + RNG_SR);
+		return 0;
+	}
+
+	err = readl_relaxed_poll_timeout(pdata->base + RNG_SR, sr, !(sr & RNG_CR_CONDRST), 100000);
+	if (err) {
+		log_err("%s: timeout %x\n", __func__, sr);
+		return err;
+	}
+
+	/* Check SEIS is cleared (step 2.) */
+	if (readl_relaxed(pdata->base + RNG_SR) & RNG_SR_SEIS)
+		return -EINVAL;
+
+	err = readl_relaxed_poll_timeout(pdata->base + RNG_SR, sr, !(sr & RNG_SR_SECS), 100000);
+	if (err) {
+		log_err("%s: timeout %x\n", __func__, sr);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * Extracts from the STM32 RNG specification, when CONDRST is not supported
+ *
+ * When a noise source (or seed) error occurs, the RNG stops generating
+ * random numbers and sets to “1” both SEIS and SECS bits to indicate
+ * that a seed error occurred. (...)
+ *
+ * The following sequence shall be used to fully recover from a seed
+ * error after the RNG initialization:
+ * 1. Clear the SEIS bit by writing it to “0”.
+ * 2. Read out 12 words from the RNG_DR register, and discard each of
+ * them in order to clean the pipeline.
+ * 3. Confirm that SEIS is still cleared. Random number generation is
+ * back to normal.
+ */
+static int stm32_rng_conceal_seed_error_sw_reset(struct stm32_rng_plat *pdata)
+{
+	uint i = 0;
+	u32 sr = readl_relaxed(pdata->base + RNG_SR);
+
+	writel_relaxed(sr & ~RNG_SR_SEIS, pdata->base + RNG_SR);
+
+	for (i = 12; i != 0; i--)
+		(void)readl_relaxed(pdata->base + RNG_DR);
+
+	if (readl_relaxed(pdata->base + RNG_SR) & RNG_SR_SEIS)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int stm32_rng_conceal_seed_error(struct stm32_rng_plat *pdata)
+{
+	log_debug("Concealing RNG seed error\n");
+
+	if (pdata->data->has_cond_reset)
+		return stm32_rng_conceal_seed_error_cond_reset(pdata);
+	else
+		return stm32_rng_conceal_seed_error_sw_reset(pdata);
+};
+
 static int stm32_rng_read(struct udevice *dev, void *data, size_t len)
 {
-	int retval, i;
-	u32 sr, count, reg;
+	int retval;
+	u32 sr, reg;
 	size_t increment;
 	struct stm32_rng_plat *pdata = dev_get_plat(dev);
+	uint tries = 0;
 
 	while (len > 0) {
 		retval = readl_poll_timeout(pdata->base + RNG_SR, sr,
-					    sr & RNG_SR_DRDY, 10000);
-		if (retval)
+					    sr, 10000);
+		if (retval) {
+			log_err("%s: Timeout RNG no data",  __func__);
 			return retval;
+		}
 
-		if (sr & (RNG_SR_SEIS | RNG_SR_SECS)) {
-			/* As per SoC TRM */
-			clrbits_le32(pdata->base + RNG_SR, RNG_SR_SEIS);
-			for (i = 0; i < 12; i++)
-				readl(pdata->base + RNG_DR);
-			if (readl(pdata->base + RNG_SR) & RNG_SR_SEIS) {
-				log_err("RNG Noise");
-				return -EIO;
+		if (sr != RNG_SR_DRDY) {
+			if (sr & RNG_SR_SEIS) {
+				retval = stm32_rng_conceal_seed_error(pdata);
+				tries++;
+				if (retval || tries > RNG_NB_RECOVER_TRIES) {
+					log_err("%s: Couldn't recover from seed error",  __func__);
+					return -ENOTRECOVERABLE;
+				}
+
+				/* Start again */
+				continue;
+			}
+
+			if (sr & RNG_SR_CEIS) {
+				log_info("RNG clock too slow");
+				writel_relaxed(0, pdata->base + RNG_SR);
 			}
-			/* start again */
-			continue;
 		}
 
 		/*
 		 * Once the DRDY bit is set, the RNG_DR register can
-		 * be read four consecutive times.
+		 * be read up to four consecutive times.
 		 */
-		count = 4;
-		while (len && count) {
-			reg = readl(pdata->base + RNG_DR);
-			memcpy(data, &reg, min(len, sizeof(u32)));
-			increment = min(len, sizeof(u32));
-			data += increment;
-			len -= increment;
-			count--;
+		reg = readl(pdata->base + RNG_DR);
+		/* Late seed error case: DR being 0 is an error status */
+		if (!reg) {
+			retval = stm32_rng_conceal_seed_error(pdata);
+			tries++;
+
+			if (retval || tries > RNG_NB_RECOVER_TRIES) {
+				log_err("%s: Couldn't recover from seed error",  __func__);
+				return -ENOTRECOVERABLE;
+			}
+
+			/* Start again */
+			continue;
 		}
+
+		increment = min(len, sizeof(u32));
+		memcpy(data, &reg, increment);
+		data += increment;
+		len -= increment;
+
+		tries = 0;
 	}
 
 	return 0;
-- 
2.25.1

