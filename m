Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 185E1C3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:44:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E70578886C;
	Sat, 20 Jul 2024 14:43:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Pm2NdRrg";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Phu8Jppx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0556388860; Sat, 20 Jul 2024 14:43:39 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CFF388418
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:43:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WR5nN5fSHz9sd6;
 Sat, 20 Jul 2024 14:43:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GDZmdIv/DjipL93kLyPEELTel0lpXCrtpIvrIDEOdhg=;
 b=Pm2NdRrgvK0LG+yBnW6NNeZ0YsR257IrjNMLJxO5PhEruUN96qYPZserIwpUiXmOOo3PxQ
 hCgokWsG+EUAQ6EMGtKWn33JgXE9jEfa+sQ8SHM7Wz46n6DtTH9Yi9ON3gKIokqyKmxmDh
 LD78jN9rup8tzFssSa7m4ecZmyijGCrwpVhLjMLxtmD9Rn1oss6RzmCjvQjYNDQKJN/LmO
 5MQSkDbwWoU+r3vfGF24zSPBm59LzYF4DbsXZUBBrT0CzzXKNWcPL5BmbC7cxzch2xEPAB
 MHazrJWaROTyEQxe/0zazJkGuIEFKNWzirhCdHB+ntIwPC4rjFujJpzdbTLjvw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GDZmdIv/DjipL93kLyPEELTel0lpXCrtpIvrIDEOdhg=;
 b=Phu8JppxC89Xbz9r289DECqyxwJ1jW3XcQ6dOuA0FwqNLvsvRopqf+AKVuMFyfNvamNz3L
 ydPmYJQHxL4dptBGoo4TH3sPBAmqighofl65yUgGEJbT9H0kO18xFajC/j25UFNB3b2V/y
 ZKrxxTSvvo09ka8Ziyswq2JJcjP3y7yqxg91U1hHM4GqLL9aBVSwNvRPllRHdBvvHDN2e+
 dAS4rch82OUvsBePtOk3HnzPIK1/2r3VwesmzHE453Oisae9or0GPO6iG89cC3SJQDA/sW
 Sk+Cmfk8+xyo0BcYj7Q81IRYoDZa26ycuMPqR2IuaufuAyxUMHEEJlWxAG3BNA==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 05/40] drivers: clk: Remove duplicate newlines
Date: Sat, 20 Jul 2024 14:40:30 +0200
Message-ID: <20240720124239.7553-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
References: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: dd888e934533d46ea40
X-MBO-RS-META: wgj5fidnnapuqwbxz8nhmmuin3mwmhc5
X-Rspamd-Queue-Id: 4WR5nN5fSHz9sd6
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/clk/clk-uclass.c          | 1 -
 drivers/clk/clk_zynqmp.c          | 1 -
 drivers/clk/imx/clk-imxrt1170.c   | 3 ---
 drivers/clk/imx/clk-pll14xx.c     | 1 -
 drivers/clk/qcom/clock-qcom.c     | 1 -
 drivers/clk/qcom/clock-qcs404.c   | 1 -
 drivers/clk/rockchip/clk_rk3328.c | 1 -
 7 files changed, 9 deletions(-)

diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index 4c832f1a530..c48a62ba099 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -130,7 +130,6 @@ static int clk_get_by_indexed_prop(struct udevice *dev, const char *prop_name,
 		return log_ret(ret);
 	}
 
-
 	return clk_get_by_index_tail(ret, dev_ofnode(dev), &args, "clocks",
 				     index, clk);
 }
diff --git a/drivers/clk/clk_zynqmp.c b/drivers/clk/clk_zynqmp.c
index 59999266148..97f3b999d7c 100644
--- a/drivers/clk/clk_zynqmp.c
+++ b/drivers/clk/clk_zynqmp.c
@@ -109,7 +109,6 @@ static const resource_size_t zynqmp_crl_apb_clkc_base = 0xff5e0020;
 #define PLLCTRL_PRE_SRC_SHFT	20
 #define PLLCTRL_PRE_SRC_MASK	(0x7 << PLLCTRL_PRE_SRC_SHFT)
 
-
 #define NUM_MIO_PINS	77
 
 enum zynqmp_clk {
diff --git a/drivers/clk/imx/clk-imxrt1170.c b/drivers/clk/imx/clk-imxrt1170.c
index 20b9dc31500..88a294f4165 100644
--- a/drivers/clk/imx/clk-imxrt1170.c
+++ b/drivers/clk/imx/clk-imxrt1170.c
@@ -113,8 +113,6 @@ static int imxrt1170_clk_probe(struct udevice *dev)
 	/* Anatop clocks */
 	base = (void *)ofnode_get_addr(ofnode_by_compatible(ofnode_null(), "fsl,imxrt-anatop"));
 
-
-
 	clk_dm(IMXRT1170_CLK_RCOSC_48M,
 	       imx_clk_fixed_factor("rcosc48M", "rcosc16M", 3, 1));
 	clk_dm(IMXRT1170_CLK_RCOSC_400M,
@@ -122,7 +120,6 @@ static int imxrt1170_clk_probe(struct udevice *dev)
 	clk_dm(IMXRT1170_CLK_RCOSC_48M_DIV2,
 	       imx_clk_fixed_factor("rcosc48M_div2",  "rcosc48M", 1, 2));
 
-
 	clk_dm(IMXRT1170_CLK_PLL_ARM,
 	       imx_clk_pllv3(IMX_PLLV3_SYS, "pll_arm", "osc",
 			     base + 0x200, 0xff));
diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
index 3911e033905..7ec78dc3a80 100644
--- a/drivers/clk/imx/clk-pll14xx.c
+++ b/drivers/clk/imx/clk-pll14xx.c
@@ -248,7 +248,6 @@ static ulong clk_pll1416x_set_rate(struct clk *clk, unsigned long drate)
 	tmp |= BYPASS_MASK;
 	writel(tmp, pll->base);
 
-
 	div_val = (rate->mdiv << MDIV_SHIFT) | (rate->pdiv << PDIV_SHIFT) |
 		(rate->sdiv << SDIV_SHIFT);
 	writel(div_val, pll->base + 0x4);
diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
index 3a9cf2a231f..79c7606a225 100644
--- a/drivers/clk/qcom/clock-qcom.c
+++ b/drivers/clk/qcom/clock-qcom.c
@@ -376,7 +376,6 @@ static int qcom_power_set(struct power_domain *pwr, bool on)
 					 !(value & GDSC_PWR_ON_MASK),
 					 GDSC_STATUS_POLL_TIMEOUT_US);
 
-
 	if (ret == -ETIMEDOUT)
 		printf("WARNING: GDSC %lu is stuck during power on/off\n",
 		       pwr->id);
diff --git a/drivers/clk/qcom/clock-qcs404.c b/drivers/clk/qcom/clock-qcs404.c
index 70a1f648e58..8b11de03a7d 100644
--- a/drivers/clk/qcom/clock-qcs404.c
+++ b/drivers/clk/qcom/clock-qcs404.c
@@ -67,7 +67,6 @@
 #define EMAC_PTP_CMD_RCGR		(0x4e014)
 #define EMAC_CMD_RCGR			(0x4e01c)
 
-
 /* GPLL0 clock control registers */
 #define GPLL0_STATUS_ACTIVE BIT(31)
 
diff --git a/drivers/clk/rockchip/clk_rk3328.c b/drivers/clk/rockchip/clk_rk3328.c
index a4f6dd5a0f5..9137dbe69ce 100644
--- a/drivers/clk/rockchip/clk_rk3328.c
+++ b/drivers/clk/rockchip/clk_rk3328.c
@@ -334,7 +334,6 @@ void rk3328_configure_cpu(struct rk3328_cru *cru,
 		     aclkm_div << ACLKM_CORE_DIV_SHIFT);
 }
 
-
 static ulong rk3328_i2c_get_clk(struct rk3328_cru *cru, ulong clk_id)
 {
 	u32 div, con;
-- 
2.43.0

