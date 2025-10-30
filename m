Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54976CCF9F0
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 13:02:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D615783955;
	Thu, 30 Oct 2025 14:00:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="baMQJtN7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6AF7800B1; Thu, 30 Oct 2025 11:01:33 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E70083893
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 11:01:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4770c34ca8eso7304165e9.0
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 03:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761818491; x=1762423291;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ocJZ70WqqK4JO4jKWMPlO41Qh8YDYLn0Tk7UFQmy2mM=;
 b=baMQJtN7Us4oh21f6yIPTJxYFUQWz1RdRE9lHhbEQSusPdC5XWvLWMm2iA0n4R8R1U
 AlNA3C8oPvwtl+LxPq6t4plshgyKwSmSkKfuJU7tzG1bdpBvSJ2pcg5gWM0lwK8SloxW
 1IIley4im0MAyp2ZR7fO7KFgOWWte8RWoIlp5M45ToXeY2X4okS55adsIVrXcSranEnT
 /U1iLGuOo67K5K64a6REWeCEeSYNAPRRFMrtdWzHt4wA+S66LYCwyFCo5wzfy7PKyjJ0
 nbXYPwHKep4ssyB8gPf0ovAlQtguP9oDhqyq9beZ3IJ7GBu4gPbIIstfHDSjhKGKo1ya
 6Gaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761818491; x=1762423291;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ocJZ70WqqK4JO4jKWMPlO41Qh8YDYLn0Tk7UFQmy2mM=;
 b=UDNfPbc//YnAyjkcxdDlc54Wa5M9VCFz68SeEb9ZCXsZQ0tzlslTfWgRJ+MsA09ebr
 Vl3f7FilaP5eRqRsfMUInU7cJ8RewCBcQAIcl3o3i3c2mX7mqNj6EeAhJW2/OQlLnswG
 Strc622HfHqzYvzS1vUaY5A2LM6ioRZhEjuwM5dCDp1PMmGMBc3KhaY4R8l3x0VsIYTR
 bQy3Vr9fL/4DOqhQ+BZ9Gxr2D59AY14tVlvMnPfWxnNSDHoueK9q+x4Ku22aGD7VzGIj
 FpGR6Ywgk0c/bIKupcteXhQtISZ+tdtvM3ytFRrnnVBstSd4y3qCjPY+DfbgJYSQHcuJ
 kArQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN69y/fASbD2K0RN+Qp3vOrFm7q451ACXzEpCo3J7kHumhAKLL4uPcNqt8r/0ZZ9pcJpLV1Vo=@lists.denx.de
X-Gm-Message-State: AOJu0YyBXiVvNlo/yGjG4svaMuQNDnMlS8YvTyt2c8id2FHWlO/RJTJD
 RAa1HySYdstyTZMRXQuWY2vddF7WNDJY48srEgoKwqIhmLT1H5aW9oSvDdx6ot9fmsA=
X-Gm-Gg: ASbGncswtU6qazNYrbESTXfYlHQNJOamAJnCm/hdhzfhqsFyaCoTB+fV9o9NwcjIc7m
 IGhbO8a7ZIUxR/FoBd8d/16P3Y+un7q9XXZZT3unZbxysM1Sn4jNGZm3fS5qhnmIgAHynz3BguR
 UDdIAJKc66SwHrPBWvyNL7k7Wi5EuDkhIEWAS+nnNoy0Od0ignxwG/hBA/pcN/S7I4d+oFKA4dn
 JmaJBADIu2TqNYJ9PSmDcxT37Rv8sKB0dMIZXGY+TLr6IifMmD7EnJASxRrRqj8pZbA2hN9I34Z
 CO0WFBV6eRjNllMJIAeIlgQ+lvPpSC6KsTyjJ+97yJ2BppxUbFtk9f3bxmXttfWrAGWHfpinyXl
 EihK7aeGX4cyniKifHuZ8Fmehl+5lG0VLGF6w1yWzx7Lzi8UInqa+R4fT+QaDVNQc2+STINoha1
 0Rxlu/oKPC
X-Google-Smtp-Source: AGHT+IEp/6YgYaNhXsSUtEihCBNieyP4ecZZQZHcd0Vk3slJ4J4kfjHa+PhCNeZIizw0ONb9yCJVUg==
X-Received: by 2002:a05:600c:34cd:b0:46e:5b74:4858 with SMTP id
 5b1f17b1804b1-4771e34a909mr62230035e9.13.1761818490578; 
 Thu, 30 Oct 2025 03:01:30 -0700 (PDT)
Received: from localhost ([2001:4090:a245:8496:49da:2c07:5e9a:7fb9])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4771832e857sm67377985e9.0.2025.10.30.03.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 03:01:29 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 30 Oct 2025 10:59:21 +0100
Subject: [PATCH v4 03/13] ram: k3-ddrss: Add support for DDR in
 self-refresh
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-topic-am62-ioddr-v2025-04-rc1-v4-3-4cef18af0226@baylibre.com>
References: <20251030-topic-am62-ioddr-v2025-04-rc1-v4-0-4cef18af0226@baylibre.com>
In-Reply-To: <20251030-topic-am62-ioddr-v2025-04-rc1-v4-0-4cef18af0226@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
Cc: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>, 
 Moteen Shah <m-shah@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
 Nathan Morrisson <nmorrisson@phytec.com>, 
 Garrett Giordano <ggiordano@phytec.com>, Judith Mendez <jm@ti.com>, 
 Aparna Patra <a-patra@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
 Chintan Vankar <c-vankar@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Prasanth Babu Mantena <p-mantena@ti.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Beleswar Padhi <b-padhi@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, E Shattow <e@freeshell.de>, 
 Devarsh Thakkar <devarsht@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8702; i=msp@baylibre.com;
 h=from:subject:message-id; bh=XfqWeWosDsKCX+aRzfSKHZ3kMge6R+c/yD3c+88ZCsk=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkxmc0H/F7WP2q7vK7vA4Ri9uyb9u1ZEVqxXmerr9R8vl
 Ql1p53uKGVhEONikBVTZOlMDE37L7/zWPKiZZth5rAygQxh4OIUgIkIGTL8d1/nee+sz+QN/Qt1
 72d+7/99ZUZKA3dF9CNh8XOXDjvOm8/w32OS7+/f+85Z7NhVr9PGwhLksl2lXeLw8pVW83eaPtu
 xhB8A
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Thu, 30 Oct 2025 14:00:47 +0100
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

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 drivers/ram/k3-ddrss/k3-ddrss.c | 177 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 177 insertions(+)

diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
index 5144470b931384534e78fbfcea5e66b7083c9f07..5aca55129326ab4f369ae6e4f2c048df6e971eff 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
@@ -57,6 +57,16 @@
 #define DDRSS_V2A_INT_SET_REG_ECC2BERR_EN	BIT(4)
 #define DDRSS_V2A_INT_SET_REG_ECCM1BERR_EN	BIT(5)
 
+#define K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL			0x430080d0
+#define K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD		BIT(31)
+#define K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RETENTION_MASK	GENMASK(3, 0)
+
+#define K3_WKUP_CTRL_MMR_CANUART_WAKE_STAT1			0x4301830c
+#define K3_WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE	BIT(0)
+
+#define K3_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT		0x43018318
+#define K3_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT_MW		0x555555
+
 #define SINGLE_DDR_SUBSYSTEM	0x1
 #define MULTI_DDR_SUBSYSTEM	0x2
 #define MAX_MULTI_DDR 4
@@ -211,6 +221,32 @@ struct reginitdata {
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
@@ -864,6 +900,132 @@ static void k3_ddrss_lpddr4_ecc_init(struct k3_ddrss_desc *ddrss)
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
+	active = readl((void *)K3_WKUP_CTRL_MMR_CANUART_WAKE_STAT1);
+
+	return !!(active & K3_WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE);
+}
+
+static bool k3_ddrss_wkup_conf_canuart_magic_word_set(struct k3_ddrss_desc *ddrss)
+{
+	u32 magic_word;
+
+	magic_word = readl((void *)K3_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT);
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
 	u64 end, bank0, bank1, bank0_size;
@@ -873,6 +1035,7 @@ static int k3_ddrss_probe(struct udevice *dev)
 	__maybe_unused u32 inst;
 	__maybe_unused struct k3_ddrss_ecc_region *range = ddrss->ecc_ranges;
 	__maybe_unused struct k3_msmc *msmc_parent = NULL;
+	bool is_lpm_resume;
 
 	debug("%s(dev=%p)\n", __func__, dev);
 
@@ -880,6 +1043,11 @@ static int k3_ddrss_probe(struct udevice *dev)
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
@@ -895,12 +1063,21 @@ static int k3_ddrss_probe(struct udevice *dev)
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
2.51.0

