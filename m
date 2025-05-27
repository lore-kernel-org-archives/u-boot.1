Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E04C54F30
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 13:31:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BB638387E;
	Tue, 27 May 2025 15:30:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="GX6NQjEG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79E2C838A2; Tue, 27 May 2025 15:30:15 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 665E683818
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 15:30:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=724286f330=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RCXVoo023431;
 Tue, 27 May 2025 15:30:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 2KIz3BqLqpNEL/4kpZHdRguKtK/TpbZ3vBb7YUPdjfw=; b=GX6NQjEGaq69qcCa
 F6H+PCoOXD2RFIU6Z0wYm1WHxRx3B1zZQdrv+jwOvtUYbfEk7fQQrdr1F03bSuZ4
 6ogxBNU+vcCsvZIkKM/V8AKkRkR0oGdaveRgieNE88K5z2u2Xn00DB+ONV/qWh30
 v+rs1AqLxIW9Y1U4DoNA6rtz9GiC+nq9sa2HzHAVDN/ZrvjY0q+Ps2Pm/YumvOmk
 LRaziLdGtFEZgS7KV8aG9akW4q3+77Cgg/yj5iFYwpEU3j3n8/eL+Zuk+e03poqH
 LspYAV0LVZKnQZFx/j6qxURrgkNDHmCqEE1WNhDcFe9V/f6sQWwN5iTSX9b57HxV
 XR0XuA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46u3hk4j1k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 May 2025 15:30:06 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id DD93940055;
 Tue, 27 May 2025 15:29:12 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DFA78AEC73D;
 Tue, 27 May 2025 15:28:07 +0200 (CEST)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 15:28:07 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Gabriel Fernandez
 <gabriel.fernandez@foss.st.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 10/13] clk: stm32: fix clock counter
Date: Tue, 27 May 2025 15:27:52 +0200
Message-ID: <20250527132755.2169508-11-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250527132755.2169508-1-patrice.chotard@foss.st.com>
References: <20250527132755.2169508-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_06,2025-05-27_01,2025-03-28_01
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

(no changes since v1)

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

