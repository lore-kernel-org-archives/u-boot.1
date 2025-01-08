Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B848E77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 15:48:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0AEF80608;
	Wed,  8 Jan 2025 16:48:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="AiMVq8vN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 963FB8036B; Wed,  8 Jan 2025 13:00:32 +0100 (CET)
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::bc])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DAD880040
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 13:00:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexeymin@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1736337627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2bvLrFskS9ai7Xe6I5jOdOLqMh+WuebVu7AKKFnbCwU=;
 b=AiMVq8vN5oC5Pez8dHvoqFygs6RyhIyKLeLa/nnChMP/t/dO48uh8ZsKeQ0JbCukrD6kNy
 PAvR0ZUEksDWODf4OPxD753z+HpSniy1KvVAuNxdGEE1fguLNrYMJkc0imZwpY2J0DzNlc
 ZcT4nTLTGYfAvNujITQDUbGznvHl5/IQEZ6cazpClc6N7fdfdnPFbNvUzr8JFBtzrFm6R4
 KLdXiZPmhuWENkpYW06Ajw7EV2MdRy3W7UbihFUl1r8DmZ/T4RiGpdHCy/GJQdXgdjxJ7M
 o8sqToYWojB5hreufSYYn/3+UB6IvEerNMnq0wYS0WdTl7erI+OcRe2NdG7YlA==
From: Alexey Minnekhanov <alexeymin@postmarketos.org>
To: u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Alexey Minnekhanov <alexeymin@postmarketos.org>
Subject: [PATCH 2/4] clk/qcom: Treat different GDSCs didderently
Date: Wed,  8 Jan 2025 14:59:09 +0300
Message-ID: <20250108115911.4163437-2-alexeymin@postmarketos.org>
In-Reply-To: <20250108115911.4163437-1-alexeymin@postmarketos.org>
References: <20250108115911.4163437-1-alexeymin@postmarketos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Wed, 08 Jan 2025 16:48:26 +0100
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

Apparently not all GDSCs are the same. In Linux driver, depending on which
GDSC flags are set, different status register is checked when powering it
on/off. And on top of that, different bit inside that register is tested.

Port missing parts from Linux driver to U-Boot:
 - add GDSC flags;
 - adjust logic when checking GDSC status to match one in Linux driver.

This fixes e.g. SDM660's USB_30_GDSC to be forever stuck during power on,
since unlike SDM845 one it doesn't have POLL_CFG_GDSCR flag.

Even though only POLL_CFG_GDSCR is the important one here, add all flags
from Linux driver, to make it easier to compare which flags are needed
for which GDSC, making porting process easier.

Signed-off-by: Alexey Minnekhanov <alexeymin@postmarketos.org>
---
 drivers/clk/qcom/clock-qcom.c | 45 ++++++++++++++++++++++++-----------
 drivers/clk/qcom/clock-qcom.h | 16 ++++++++++++-
 2 files changed, 46 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
index 1cfc430c14a5..bf9249b55af3 100644
--- a/drivers/clk/qcom/clock-qcom.c
+++ b/drivers/clk/qcom/clock-qcom.c
@@ -461,7 +461,7 @@ static int qcom_power_set(struct power_domain *pwr, bool on)
 	struct msm_clk_data *data = (struct msm_clk_data *)dev_get_driver_data(pwr->dev);
 	void __iomem *base = dev_get_priv(pwr->dev);
 	const struct qcom_power_map *map;
-	u32 value;
+	u32 value, status_reg;
 	int ret;
 
 	if (pwr->id >= data->num_power_domains)
@@ -481,19 +481,36 @@ static int qcom_power_set(struct power_domain *pwr, bool on)
 
 	writel(value, base + map->reg);
 
-	if (on)
-		ret = readl_poll_timeout(base + map->reg + CFG_GDSCR_OFFSET,
-					 value,
-					 (value & GDSC_POWER_UP_COMPLETE) ||
-					 (value & GDSC_PWR_ON_MASK),
-					 GDSC_STATUS_POLL_TIMEOUT_US);
-
-	else
-		ret = readl_poll_timeout(base + map->reg + CFG_GDSCR_OFFSET,
-					 value,
-					 (value & GDSC_POWER_DOWN_COMPLETE) ||
-					 !(value & GDSC_PWR_ON_MASK),
-					 GDSC_STATUS_POLL_TIMEOUT_US);
+	/* depending on the type of gdsc the status register is different */
+	/* and we need to check different status bit */
+	if (map->flags & POLL_CFG_GDSCR) {
+		status_reg = map->reg + CFG_GDSCR_OFFSET;
+
+		if (on)
+			ret = readl_poll_timeout(base + status_reg,
+						 value,
+						 (value & GDSC_POWER_UP_COMPLETE),
+						 GDSC_STATUS_POLL_TIMEOUT_US);
+		else
+			ret = readl_poll_timeout(base + status_reg,
+						 value,
+						 (value & GDSC_POWER_DOWN_COMPLETE),
+						 GDSC_STATUS_POLL_TIMEOUT_US);
+	} else {
+		status_reg = map->reg;
+
+		if (on)
+			ret = readl_poll_timeout(base + status_reg,
+						 value,
+						 (value & GDSC_PWR_ON_MASK),
+						 GDSC_STATUS_POLL_TIMEOUT_US);
+
+		else
+			ret = readl_poll_timeout(base + status_reg,
+						 value,
+						 !(value & GDSC_PWR_ON_MASK),
+						 GDSC_STATUS_POLL_TIMEOUT_US);
+	}
 
 	if (ret == -ETIMEDOUT)
 		printf("WARNING: GDSC %lu is stuck during power o%s\n",
diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
index 78d9b1d81ece..84965b2555c7 100644
--- a/drivers/clk/qcom/clock-qcom.h
+++ b/drivers/clk/qcom/clock-qcom.h
@@ -63,8 +63,22 @@ struct qcom_reset_map {
 	u8 bit;
 };
 
+enum qcom_gdsc_flags {
+	VOTABLE = BIT(0),
+	CLAMP_IO = BIT(1),
+	HW_CTRL = BIT(2),
+	SW_RESET = BIT(3),
+	AON_RESET = BIT(4),
+	POLL_CFG_GDSCR = BIT(5),
+	ALWAYS_ON = BIT(6),
+	RETAIN_FF_ENABLE = BIT(7),
+	NO_RET_PERIPH = BIT(8),
+	HW_CTRL_TRIGGER = BIT(9),
+};
+
 struct qcom_power_map {
-	unsigned int reg;
+	unsigned int reg; /* GDSCR */
+	unsigned int flags;
 };
 
 struct clk;
-- 
2.45.2

