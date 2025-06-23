Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 902F6C7115B
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 12:24:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA55D82E27;
	Mon, 23 Jun 2025 14:23:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LAYunerW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F8D082D34; Mon, 23 Jun 2025 14:10:34 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6337C82977
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 14:10:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-60702d77c60so7899764a12.3
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 05:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750680631; x=1751285431;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pulhhl7OugvpNAdgxmF/iG+wqsuIDXDEzyTU/soJGW0=;
 b=LAYunerWOBUFTul0Bvlphr1ZYwYqsUNfjgQbIH/sES2p/Ti5w/63XWKbrO1VUwNOp8
 Y1ZHuUQEtf5GLAiF40ZbUqsjKESAZFLtynlrqRiOSH6kvS0nuDeHmTo7om9IAP4oMSLN
 Cwh21ch/gkMs/YNxFSNJde2TIcRYFCX6cStwxGre8pLF1mdD0RAcEELg0a0RLoPa3UQD
 hZ1pds4iT9gkIXa12LscRG36rTgmUCXkhj0BJ52IHQ40Xb/KN9A3p4YnI8CKwLJmyJxx
 4c+MZvjuP8KcSgpVIxzA+XG15mpHnn7iRofdFcul5FHKNN5/7BS1xESYUd6HIFeVChg9
 Afvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750680631; x=1751285431;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pulhhl7OugvpNAdgxmF/iG+wqsuIDXDEzyTU/soJGW0=;
 b=DcfH8Q/A6ZZKVpSeXHp588H6ait8nlIbhKZkFkj8OGWuqR7N0HqjKxUxylHrNnz7M9
 lav5gk7HF8W92lKnprzFVX40cNzLQKq9m6JgbgQLvSysimod1TdCSHg57FYRML0VEpcc
 AiTpD5uPrYdiZwaHYoa4J93MY6Hbo2a2bhUE+fxxUVAsM/sOc6ZLyVbI6OIXNNytvnzc
 XZtZIxhAPU1eCIVSRqQ+Zw/jxWlordDUBY/s5MRAp9LTmUmWEnEMS5pGSM5JU7STFL3m
 TxXdZShGQRvBYvG4NdySVkmxsfS/A12qdjX4mC8o4vSGsFDUYR3HiyEGfq/JAEe2tZTr
 ++dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9FM7zBr7SL17sTClIcHnOhe1bsCLbExnnw+DFKePEG54QdE1CIJoRaWmCSL0YyVHuTD1DlrI=@lists.denx.de
X-Gm-Message-State: AOJu0YwJKh5A+f1HCkwgbiGsSzgoquW6jfnkpX6NXxBNzPyVmXmDaJBA
 f+mjTtvCvcEjaipQcG/xcvFvMlv/9AK+UBBJ/9SbRfA8wGtONK9q+MCgq13XjiKc4Bc=
X-Gm-Gg: ASbGncvaEg0n+mjshf3ST3qBR9diR0+Gl0shxjnBRYhVgk6KA73/V9EwLmKoyat1Bfg
 xNIl4AB2gK5ADzAQ847nViR1y3xp0J1Y8Saw8cR1QsXF6PH987SqYJNk1lZMyf/wniOBEz5Mkie
 zol9rZaJ314axcdpOPDspmkMSiuF+Mec8M1fJQpUdidRQqDEG8v2uD8gvhX+S1qDs/bLsFGTjo7
 3X+t0ta4Zk+39ZbgUNPiWCzRigUZSBUjzjyNQxRjw7I3EhL8RushnrVABmS5/YglnZMhuPCPDMz
 dKH/uO5jHWxHW4+vYR0Gn8vey84W72nRZaIZ/oN8Dxbx0dTCVJ81KuuKBkg=
X-Google-Smtp-Source: AGHT+IFv+zPAH9W5jhv7yaxMmtaQMj30+Nq1IGHwqfeTeS3Yp+dOlW7PBCUYjpoMxpuYxLYd0Uk6Xg==
X-Received: by 2002:a17:907:ec81:b0:ade:4038:3256 with SMTP id
 a640c23a62f3a-ae057b00da3mr1206160366b.39.1750680630670; 
 Mon, 23 Jun 2025 05:10:30 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83c4:9fe4:a128:a20c:8b84])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-ae054206fc5sm696031666b.153.2025.06.23.05.10.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 05:10:30 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Mon, 23 Jun 2025 14:08:26 +0200
Subject: [PATCH v3 03/22] ram: k3-ddrss: Add support for DDR in
 self-refresh
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-3-a4da322c16af@baylibre.com>
References: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-0-a4da322c16af@baylibre.com>
In-Reply-To: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-0-a4da322c16af@baylibre.com>
To: Sumit Garg <sumit.garg@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>, 
 Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Sebin Francis <sebin.francis@ti.com>, Dhruva Gole <d-gole@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, u-boot@lists.denx.de, 
 Kevin Hilman <khilman@baylibre.com>, Vishal Mahaveer <vishalm@ti.com>, 
 Kendall Willis <k-willis@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8495; i=msp@baylibre.com;
 h=from:subject:message-id; bh=9kOdsqzOlLd14kplzeZP1yONlhRQ4N5IES3zvG6X0Q0=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhoxI57NTL0pVPtjupTRd4ACP8DrZ3XoNC31Mp9r8yczR3
 cFy8adgRykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAExkmwLD/0qxh8sEtifUysjN
 63G1OLTwOk9I/+nWbMFtSdM+TDafIMnwP6Gc31r2dEGAdVdYU4jGW4XqCQJOenJtC1tWOLIa6yd
 yAAA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 23 Jun 2025 14:23:35 +0200
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
 drivers/ram/k3-ddrss/k3-ddrss.c | 177 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 177 insertions(+)

diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
index 6590d57ad84f3c4dc5c72c6c5889038c463b0469..874614140c6d4a785fcca6eda4a8736e1183e193 100644
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
@@ -775,10 +811,137 @@ static void k3_ddrss_lpddr4_ecc_init(struct k3_ddrss_desc *ddrss)
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
+	int ret;
+	unsigned long timeout_start;
+
+	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
+				 K3_DDRSS_CFG_DENALI_CTL_160,
+				 K3_DDRSS_CFG_DENALI_CTL_160_LP_CMD_MASK,
+				 K3_DDRSS_CFG_DENALI_CTL_160_LP_CMD_ENTRY);
+	ret = wait_for_bit_32(ddrss->ddrss_ctl_cfg + K3_DDRSS_CFG_DENALI_CTL_345,
+			      (1 << K3_DDRSS_CFG_DENALI_CTL_345_INT_STATUS_LOWPOWER_SHIFT),
+			      true, 5000, false);
+	if (ret)
+		panic("Failed waiting for low power command %d\n", ret);
+
+	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
+				 K3_DDRSS_CFG_DENALI_CTL_353,
+				 0,
+				 1 << K3_DDRSS_CFG_DENALI_CTL_353_INT_ACK_LOWPOWER_SHIFT);
+
+	timeout_start = get_timer(0);
+	while (1) {
+		if (get_timer(timeout_start) > 5000)
+			panic("Failed waiting for low power state\n");
+
+		if ((readl(ddrss->ddrss_ctl_cfg + K3_DDRSS_CFG_DENALI_CTL_169) &
+		     K3_DDRSS_CFG_DENALI_CTL_169_LP_STATE_MASK) ==
+		    0x40 << K3_DDRSS_CFG_DENALI_CTL_169_LP_STATE_SHIFT)
+			break;
+	}
+}
+
+static void k3_ddrss_deassert_retention(struct k3_ddrss_desc *ddrss)
+{
+	int ret;
+
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
+	ret = wait_for_bit_32((void *)K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL,
+			      K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD,
+			      true, 5000, false);
+	if (ret)
+		panic("Failed waiting for latching of retention %d\n", ret);
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
 
@@ -786,6 +949,11 @@ static int k3_ddrss_probe(struct udevice *dev)
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
@@ -801,12 +969,21 @@ static int k3_ddrss_probe(struct udevice *dev)
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

