Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99899C2D0CD
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 13:43:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ECBA82F14;
	Wed, 21 May 2025 15:43:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="MiBroRLg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D4BE82F5A; Wed, 21 May 2025 15:43:27 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C0178091A
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 15:43:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=723653ac2b=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LAttM1027728;
 Wed, 21 May 2025 15:43:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 8Of/9RRTcHr/PP5t5blPyIX4dwRkgEOi1NKQIQfAufQ=; b=MiBroRLg8H1axQj9
 +j2cX2TU9wuv7hjLZjnTmNRhLu9CW3m2TGLyhOj9z3QKDU0MSLczk1tMleqhlhQx
 wl21bThLdeYTP1XTE11J1UR06eynnnjfNLg3cYYSuOfJvNpt3oghLpY/pDqt228h
 eR+4fZbWXSO4FjN9Oz430364fge9zVrEgMSyLLblul+yfbNhbSrNqghicEKYA/q7
 GWrsCgRravzPqmb3Q9RTHJFwPSA4/PfCmj5GgWpDMdpAVE6c2A1WXXNhj4QJpacU
 Zhz/jU9fU7CqHS70Pn0C9l+p8JhXsH9AZKufUSlmAuKttyVMdD6ZOkgcwmckBL9B
 XyHKMA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46rwfqm9am-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 May 2025 15:43:21 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D1AB640050;
 Wed, 21 May 2025 15:42:30 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C15BDB2CB75;
 Wed, 21 May 2025 15:41:38 +0200 (CEST)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 15:41:38 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Gabriel Fernandez
 <gabriel.fernandez@foss.st.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 10/13] clk: stm32: fix clock counter
Date: Wed, 21 May 2025 15:41:14 +0200
Message-ID: <20250521134117.2828335-11-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250521134117.2828335-1-patrice.chotard@foss.st.com>
References: <20250521134117.2828335-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_04,2025-05-20_03,2025-03-28_01
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

From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

In RCC the ops of the CCF registered CLK device can be called directly,
this patch avoid recursive call of clk_ function done by CCF clock
framework which update the clock information, for example
clk_enable is called 2 times, clkp->enable_count is increased 2 times.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Sean Anderson <seanga2@gmail.com>
---

 drivers/clk/stm32/clk-stm32-core.c | 68 ++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/stm32/clk-stm32-core.c b/drivers/clk/stm32/clk-stm32-core.c
index df3b35b1003..a0ae89d0912 100644
--- a/drivers/clk/stm32/clk-stm32-core.c
+++ b/drivers/clk/stm32/clk-stm32-core.c
@@ -70,11 +70,71 @@ ulong clk_stm32_get_rate_by_name(const char *name)
 	return 0;
 }
 
+static const struct clk_ops *clk_dev_ops(struct udevice *dev)
+{
+	return (const struct clk_ops *)dev->driver->ops;
+}
+
+static int stm32_clk_endisable(struct clk *clk, bool enable)
+{
+	const struct clk_ops *ops;
+	struct clk *c = NULL;
+
+	if (!clk->id || clk_get_by_id(clk->id, &c))
+		return -ENOENT;
+
+	ops = clk_dev_ops(c->dev);
+	if (!ops->enable || !ops->disable)
+		return 0;
+
+	return enable ? ops->enable(c) : ops->disable(c);
+}
+
+static int stm32_clk_enable(struct clk *clk)
+{
+	return stm32_clk_endisable(clk, true);
+}
+
+static int stm32_clk_disable(struct clk *clk)
+{
+	return stm32_clk_endisable(clk, false);
+}
+
+static ulong stm32_clk_get_rate(struct clk *clk)
+{
+	const struct clk_ops *ops;
+	struct clk *c = NULL;
+
+	if (!clk->id || clk_get_by_id(clk->id, &c))
+		return -ENOENT;
+
+	ops = clk_dev_ops(c->dev);
+	if (!ops->get_rate)
+		return -ENOSYS;
+
+	return ops->get_rate(c);
+}
+
+static ulong stm32_clk_set_rate(struct clk *clk, unsigned long clk_rate)
+{
+	const struct clk_ops *ops;
+	struct clk *c = NULL;
+
+	if (!clk->id || clk_get_by_id(clk->id, &c))
+		return -ENOENT;
+
+	ops = clk_dev_ops(c->dev);
+	if (!ops->set_rate)
+		return -ENOSYS;
+
+	return ops->set_rate(c, clk_rate);
+}
+
 const struct clk_ops stm32_clk_ops = {
-	.enable = ccf_clk_enable,
-	.disable = ccf_clk_disable,
-	.get_rate = ccf_clk_get_rate,
-	.set_rate = ccf_clk_set_rate,
+	.enable = stm32_clk_enable,
+	.disable = stm32_clk_disable,
+	.get_rate = stm32_clk_get_rate,
+	.set_rate = stm32_clk_set_rate,
 };
 
 #define RCC_MP_ENCLRR_OFFSET	4
-- 
2.25.1

