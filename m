Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98736C71136
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 14:00:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6399282D34;
	Fri, 13 Jun 2025 15:59:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JqT5M5/G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 295E482D09; Fri, 13 Jun 2025 15:22:00 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C6A682C30
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 15:21:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-adeaa4f3d07so380095366b.0
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 06:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749820917; x=1750425717;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=p20718Yh+r9wG8e/QcHc3xm+eqVWy7Jx07Ut1Nw6g2w=;
 b=JqT5M5/G9ceNlamTsq07UtJMvGXpuTxPH+3reQOs32FVItUjxQ9bXvP6QQKcfKnG1/
 o+hAN789u+4XXQZEHeWCX4gstHLA7IdJh6r0YxM8TyDRODDONQqK36aJ19BPUyC5h6+Z
 G8UlFsBjhm0Y0K7Stp0c3A6ZpoeBv7nIt2cGz10x1o0Rnjert7UwmKhEuI2sX6WyEaOW
 LcAE24HK2KGa80xC/GrL1Gyl6LjPq74JBJw+wttN4dPM8U28kbFMzdcWN3YzIypoR6yS
 hg15FbDZRh6Dw6WmhvWgQe4yE+2eklet0HYALecA3MYojw7luAuaK4RbzPltQs22EVxg
 Y2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749820917; x=1750425717;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p20718Yh+r9wG8e/QcHc3xm+eqVWy7Jx07Ut1Nw6g2w=;
 b=DIv9ZJiSzqIgVs/cMKReTnydhiE3/iZ8+JC44uvZAndGMPXQKXP4Hfs8m8qI+kQ/ln
 Fkd9i/62mzYBJAJ7FNtX6sbakw9Q3MrgsUsZQY6vgbuMwFsNLyWFN1AI4pGVOt9DtRtK
 AAhb6nqignnp+RZ0i5Wm16FAnZVpwd8bXhHigHud0UD+lORDOeHh0xZXx4dF/hItBTsP
 RJm4YtM3/ODSymZWi+Celb5d2V2Xq4jnycyq3mGBuykN2kSFYbGi4mpBD073nTb02McJ
 LFMXdQ/hDI0wIjZfGhG0G1BcZgUhT2fLVfYQIem6r7Sj2dWu86cjm+cPe357oeN/OByr
 t97Q==
X-Gm-Message-State: AOJu0YxB53bWS4ZWmj09NkULryjWLtN6qLLSYBNspplbEyBqyBz6T2YN
 MN5ZcyruRvO+UHM4Pe6zETaKvrq8/jEyl8A2mpOamkX5ZYWFuiDLwizNUC87r6bBkzWE807P3xT
 HDUZ4
X-Gm-Gg: ASbGncuPtJ/81yW4jy8QRfaYbLlSdw1OCrOxZ00TRxtN8P3Ig4gK4Qfcq+reYoczfJV
 OzPdA9YNl7Qj57c1HEOgniRxediEYF7z0zz5WO/8Guqb24wq7Ks++rxwm2lBSq6V/4jzm5djLJD
 SQ/MazSlEKywVt9QU/yZXwJuW+zYg+7uwwyJorkvNLfZMOxR0SPr5E65yrTAnRmKg1PFl7DbKrl
 J7vMWAwfpbZ5TG4wEyaso3qduiwjFpR1mLIn9VG1WLJXISmAm1v1yhMAT7sq1YeVX1IB8WyqZMA
 BM7VV8z56z6lMqIbmeWl/MwBBi8gYf3qcizGXuFIgnyViBQfVlZfyaSry2Q=
X-Google-Smtp-Source: AGHT+IHM7RBroqlRfNwdTjwsqREWdNs89kaLpbz2u+4bxL4ysl2rOwNhSVljJHiy4lxjDpA93ibM5g==
X-Received: by 2002:a17:907:9488:b0:ad8:a41a:3cd2 with SMTP id
 a640c23a62f3a-adec55f9b02mr326845166b.16.1749820917480; 
 Fri, 13 Jun 2025 06:21:57 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83c4:9fe4:a128:a20c:8b84])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-adec88ff425sm126479366b.87.2025.06.13.06.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 06:21:57 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Fri, 13 Jun 2025 15:19:23 +0200
Subject: [PATCH v2 03/22] ram: k3-ddrss: Add support for DDR in
 self-refresh
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-3-3d233aaea355@baylibre.com>
References: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-0-3d233aaea355@baylibre.com>
In-Reply-To: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-0-3d233aaea355@baylibre.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Robert Nelson <robertcnelson@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, Kevin Hilman <khilman@baylibre.com>, 
 Vishal Mahaveer <vishalm@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Dhruva Gole <d-gole@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8104; i=msp@baylibre.com;
 h=from:subject:message-id; bh=jL2CvfYMW3YcgRZLXqZ91JpWiSewGsWYJW8tww8D0ag=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhgwf1eYppzmF9XiNyiZZ3fCa8fGVxvU0ZhXW80qLvv+e4
 F3CdfhRRykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAEzknQnDf0eWnoOLb6gYGpyf
 93i3wVzl1zLnNi/asNJHZhf/gXPNzhqMDN+W/2G229ze8+OL/6EpFr6+2gG7It8KVqxR8jpSn/t
 9BwcA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Fri, 13 Jun 2025 15:59:32 +0200
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

In IO+DDR the DDR is kept in self-refresh while the SoC cores are
powered off completely. During boot the normal initialization routine of
DDR is slightly different to exit self-refresh and keep the DDR contents.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/ram/k3-ddrss/k3-ddrss.c | 165 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 165 insertions(+)

diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
index ff87faf6a22419e54d3639817ad2b884a97a3911..d7ae6e9ef24d5aebdb61656e6ca797b1799ca0f6 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
@@ -57,6 +57,16 @@
 #define DDRSS_V2A_INT_SET_REG_ECC2BERR_EN	BIT(4)
 #define DDRSS_V2A_INT_SET_REG_ECCM1BERR_EN	BIT(5)
 
+#define K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL			0x430080d0
+#define K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD		BIT(31)
+#define K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RETENTION_MASK	GENMASK(3, 0)
+
+#define K3_WKUP_CTRL_MMR_CANUART_WAKE_STAT1			0x430c
+#define K3_WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE	BIT(0)
+
+#define K3_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT		0x4318
+#define K3_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT_MW		0x555555
+
 #define SINGLE_DDR_SUBSYSTEM	0x1
 #define MULTI_DDR_SUBSYSTEM	0x2
 
@@ -189,6 +199,32 @@ struct reginitdata {
 #define DENALI_CTL_0_DRAM_CLASS_DDR4		0xA
 #define DENALI_CTL_0_DRAM_CLASS_LPDDR4		0xB
 
+#define K3_DDRSS_CFG_DENALI_CTL_20				0x0050
+#define K3_DDRSS_CFG_DENALI_CTL_20_PHY_INDEP_TRAIN_MODE		BIT(24)
+#define K3_DDRSS_CFG_DENALI_CTL_21				0x0054
+#define K3_DDRSS_CFG_DENALI_CTL_21_PHY_INDEP_INIT_MODE		BIT(8)
+#define K3_DDRSS_CFG_DENALI_CTL_106				0x01a8
+#define K3_DDRSS_CFG_DENALI_CTL_106_PWRUP_SREFRESH_EXIT		BIT(16)
+#define K3_DDRSS_CFG_DENALI_CTL_160				0x0280
+#define K3_DDRSS_CFG_DENALI_CTL_160_LP_CMD_MASK			GENMASK(14, 8)
+#define K3_DDRSS_CFG_DENALI_CTL_160_LP_CMD_ENTRY		BIT(9)
+#define K3_DDRSS_CFG_DENALI_CTL_169				0x02a4
+#define K3_DDRSS_CFG_DENALI_CTL_169_LP_AUTO_EXIT_EN_MASK	GENMASK(27, 24)
+#define K3_DDRSS_CFG_DENALI_CTL_169_LP_AUTO_ENTRY_EN_MASK	GENMASK(19, 16)
+#define K3_DDRSS_CFG_DENALI_CTL_169_LP_STATE_MASK		GENMASK(14, 8)
+#define K3_DDRSS_CFG_DENALI_CTL_169_LP_STATE_SHIFT		8
+#define K3_DDRSS_CFG_DENALI_CTL_345				0x0564
+#define K3_DDRSS_CFG_DENALI_CTL_345_INT_STATUS_LOWPOWER_SHIFT	16
+#define K3_DDRSS_CFG_DENALI_CTL_353				0x0584
+#define K3_DDRSS_CFG_DENALI_CTL_353_INT_ACK_LOWPOWER_SHIFT	16
+#define K3_DDRSS_CFG_DENALI_PI_6				0x2018
+#define K3_DDRSS_CFG_DENALI_PI_6_PI_DFI_PHYMSTR_STATE_SEL_R	BIT(8)
+#define K3_DDRSS_CFG_DENALI_PI_146				0x2248
+#define K3_DDRSS_CFG_DENALI_PI_150				0x2258
+#define K3_DDRSS_CFG_DENALI_PI_150_PI_DRAM_INIT_EN		BIT(8)
+#define K3_DDRSS_CFG_DENALI_PHY_1820				0x5C70
+#define K3_DDRSS_CFG_DENALI_PHY_1820_SET_DFI_INPUT_2_SHIFT	16
+
 #define TH_OFFSET_FROM_REG(REG, SHIFT, offset) do {\
 	char *i, *pstr = xstr(REG); offset = 0;\
 	for (i = &pstr[SHIFT]; *i != '\0'; ++i) {\
@@ -775,10 +811,125 @@ static void k3_ddrss_lpddr4_ecc_init(struct k3_ddrss_desc *ddrss)
 	writel(val, base + DDRSS_ECC_CTRL_REG);
 }
 
+static void k3_ddrss_reg_update_bits(void __iomem *addr, u32 offset, u32 mask, u32 set)
+{
+	u32 val = readl(addr + offset);
+
+	val &= ~mask;
+	val |= set;
+	writel(val, addr + offset);
+}
+
+static void k3_ddrss_self_refresh_exit(struct k3_ddrss_desc *ddrss)
+{
+	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
+				 K3_DDRSS_CFG_DENALI_CTL_169,
+				 K3_DDRSS_CFG_DENALI_CTL_169_LP_AUTO_EXIT_EN_MASK |
+				 K3_DDRSS_CFG_DENALI_CTL_169_LP_AUTO_ENTRY_EN_MASK,
+				 0x0);
+	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
+				 K3_DDRSS_CFG_DENALI_PHY_1820,
+				 0,
+				 BIT(2) << K3_DDRSS_CFG_DENALI_PHY_1820_SET_DFI_INPUT_2_SHIFT);
+	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
+				 K3_DDRSS_CFG_DENALI_CTL_106,
+				 0,
+				 K3_DDRSS_CFG_DENALI_CTL_106_PWRUP_SREFRESH_EXIT);
+	writel(0, ddrss->ddrss_ctl_cfg + K3_DDRSS_CFG_DENALI_PI_146);
+	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
+				 K3_DDRSS_CFG_DENALI_PI_150,
+				 K3_DDRSS_CFG_DENALI_PI_150_PI_DRAM_INIT_EN,
+				 0x0);
+	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
+				 K3_DDRSS_CFG_DENALI_PI_6,
+				 0,
+				 K3_DDRSS_CFG_DENALI_PI_6_PI_DFI_PHYMSTR_STATE_SEL_R);
+	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
+				 K3_DDRSS_CFG_DENALI_CTL_21,
+				 K3_DDRSS_CFG_DENALI_CTL_21_PHY_INDEP_INIT_MODE,
+				 0);
+	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
+				 K3_DDRSS_CFG_DENALI_CTL_20,
+				 0,
+				 K3_DDRSS_CFG_DENALI_CTL_20_PHY_INDEP_TRAIN_MODE);
+}
+
+static void k3_ddrss_lpm_resume(struct k3_ddrss_desc *ddrss)
+{
+	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
+				 K3_DDRSS_CFG_DENALI_CTL_160,
+				 K3_DDRSS_CFG_DENALI_CTL_160_LP_CMD_MASK,
+				 K3_DDRSS_CFG_DENALI_CTL_160_LP_CMD_ENTRY);
+	while (!(readl(ddrss->ddrss_ctl_cfg + K3_DDRSS_CFG_DENALI_CTL_345) &
+		 (1 << K3_DDRSS_CFG_DENALI_CTL_345_INT_STATUS_LOWPOWER_SHIFT)))
+		;
+
+	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
+				 K3_DDRSS_CFG_DENALI_CTL_353,
+				 0,
+				 1 << K3_DDRSS_CFG_DENALI_CTL_353_INT_ACK_LOWPOWER_SHIFT);
+	while ((readl(ddrss->ddrss_ctl_cfg + K3_DDRSS_CFG_DENALI_CTL_169) &
+		K3_DDRSS_CFG_DENALI_CTL_169_LP_STATE_MASK) !=
+	       0x40 << K3_DDRSS_CFG_DENALI_CTL_169_LP_STATE_SHIFT)
+		;
+}
+
+static void k3_ddrss_deassert_retention(struct k3_ddrss_desc *ddrss)
+{
+	k3_ddrss_reg_update_bits((void *)K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL,
+				 0x0,
+				 K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD |
+				 K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RETENTION_MASK,
+				 0);
+	k3_ddrss_reg_update_bits((void *)K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL,
+				 0x0,
+				 K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD,
+				 K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD);
+
+	while (true) {
+		u32 val;
+
+		val = readl((void *)K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL);
+		if (val & K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD)
+			break;
+	}
+
+	k3_ddrss_reg_update_bits((void *)K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL,
+				 0x0,
+				 K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD,
+				 0);
+}
+
+static bool k3_ddrss_wkup_conf_canuart_wakeup_active(struct k3_ddrss_desc *ddrss)
+{
+	u32 active;
+
+	active = readl(ddrss->ddrss_ctrl_mmr + K3_WKUP_CTRL_MMR_CANUART_WAKE_STAT1);
+
+	return !!(active & K3_WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE);
+}
+
+static bool k3_ddrss_wkup_conf_canuart_magic_word_set(struct k3_ddrss_desc *ddrss)
+{
+	u32 magic_word;
+
+	magic_word = readl(ddrss->ddrss_ctrl_mmr + K3_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT);
+
+	return magic_word == K3_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT_MW;
+}
+
+static bool k3_ddrss_wkup_conf_boot_is_resume(struct k3_ddrss_desc *ddrss)
+{
+	return IS_ENABLED(CONFIG_K3_IODDR) &&
+		k3_ddrss_wkup_conf_canuart_wakeup_active(ddrss) &&
+		k3_ddrss_wkup_conf_canuart_magic_word_set(ddrss);
+}
+
 static int k3_ddrss_probe(struct udevice *dev)
 {
 	int ret;
 	struct k3_ddrss_desc *ddrss = dev_get_priv(dev);
+	bool is_lpm_resume;
 
 	debug("%s(dev=%p)\n", __func__, dev);
 
@@ -786,6 +937,11 @@ static int k3_ddrss_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
+	is_lpm_resume = k3_ddrss_wkup_conf_boot_is_resume(ddrss);
+
+	if (is_lpm_resume)
+		dev_info(dev, "Detected IO+DDR resume\n");
+
 	ddrss->dev = dev;
 	ret = k3_ddrss_power_on(ddrss);
 	if (ret)
@@ -801,12 +957,21 @@ static int k3_ddrss_probe(struct udevice *dev)
 	k3_lpddr4_init(ddrss);
 	k3_lpddr4_hardware_reg_init(ddrss);
 
+	if (is_lpm_resume)
+		k3_ddrss_self_refresh_exit(ddrss);
+
 	ret = k3_ddrss_init_freq(ddrss);
 	if (ret)
 		return ret;
 
+	if (is_lpm_resume)
+		k3_ddrss_deassert_retention(ddrss);
+
 	k3_lpddr4_start(ddrss);
 
+	if (is_lpm_resume)
+		k3_ddrss_lpm_resume(ddrss);
+
 	if (IS_ENABLED(CONFIG_K3_INLINE_ECC)) {
 		if (!ddrss->ddrss_ss_cfg) {
 			printf("%s: ss_cfg is required if ecc is enabled but not provided.",

-- 
2.49.0

