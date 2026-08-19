Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 543DEC5DF86
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 09:37:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3163860684;
	Wed, 19 Aug 2026 09:37:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ikjfWRzYpCnO; Wed, 19 Aug 2026 09:37:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787132237;
	bh=sqqpaMnpa0Gv+Ah5QondB7qE3L0544b6aP74skDjfm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AMhirli5HqrUwnYqiGhdb4PxcFIYQ6PTqnC+nbsBYh1bSVWuiQf9bnwDKbs9HKFXE
	 gUbuodVMpvbFE6VmzoRMQS0GDMxFq1YmEjRHEb+WFlpa0Lk26X2gtijnur2FJQAc4B
	 spcAjSTWgfsI17AfcJOwR2fU6pzmAy87FOARnJdPKK7VM+S5/3IBTc3ACxynDMahC+
	 Ilg0ndo4+rC6o0NTUgx2b2kwUeXLixpuEXvqekDM0k8cAnNBL3o7k9jH3Aki+bKwjt
	 GiRJ0TUOhUIUC6ZtJAzLBRvl7rfWNmxbIofuRAimH2yQ3LrgcOkOeSzM97YCUxTLdM
	 qk5haZCVIJ9Kw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C90876068B;
	Wed, 19 Aug 2026 09:37:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 07DDE39E
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 09:37:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EE27E4056C
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 09:37:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rH24GnJuDthH for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 09:37:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=DS+iI+h1
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D057140582
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 09:37:11 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-476a130c138so846142f8f.0
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 02:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787132230; x=1787737030;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sqqpaMnpa0Gv+Ah5QondB7qE3L0544b6aP74skDjfm4=;
 b=DS+iI+h1GVlI/q7ymBOi9eAbVl612Sppbo2SThjrdFkrR+agFVUfmIiXkuVgnkyZuY
 2WVBuEciVYbGikBRkvvbqivbycNWL3362N12/Ipj6hTSrfsa00palGX5w5oeAQfpS2cl
 8gu/vkrRK4Fk9yVc0YrsKnSISfShVM26pFn2X2zGUS6B7n3C9gi4bv2Qm7+I9ZiPciKw
 YQe+ZqGhaqkXvAu3gj5N9EE2t6qqiXmzRm4CKQbA/5hxJ4N0q9k+yI1FWFErKcp74uQC
 oiBlXGWwrqq3HTQi/YwShNSyAaYfDUE41EIwvGhDi8PZLp7ju+xxQf9wwWNhQto+WB5h
 qiAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787132230; x=1787737030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sqqpaMnpa0Gv+Ah5QondB7qE3L0544b6aP74skDjfm4=;
 b=i70zFBJ2s8GzMj1zHZuUJugylCRo4JuHnJmoS1qVBTHLHYHbbri4qXvX6Qofa8BoJr
 BO69p48BDAzqLtvApPb/qicVKdrqLOUGW3l422vNuJj7MZx7O3z7YX9CVGksZ9hv89nA
 GQ72McGh7SMtjxq/JZBrrJU9DSJxryir5F6eVNe+oktVWfA9v2t6bjv9vQeypfto0BOA
 G6rCXhcrFvelcolZjkbUpHPs3XZ/7KNmDnbFXTOo1xogOljj0G93d3S/FwdxqwOFuj2s
 V19uaWqjA1ACc0YysV2YaqYNAxd5qN7LpTEXjWLNLpPr9Mx3SPF/7C18EcmFcM3Z9EPU
 rzHg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpcJ7n/SQz32fgXhQGjGKEcgN/PBWYvpOe9vZGLRzDbS4xp8K2POQNY73f+9NMoudj/JRKyX0M=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yyf134GIxVR6wEfXAedEbEtbtlevHvBJTgeAd8Vm86Z8o8O+vGd
 1gYKRiZ2+DLef5RR7+3khUZ2pgqfxRzE/ok4kpsUEVmFsHBmUdAHlY5p
X-Gm-Gg: AR+sD137vQ3O7K3hZmfJ28fQDMb+isEsgVJXx1CZpQ1cNsN/thpqUTbdKaC85kHYx8M
 Mqd/CDhtKieHcw3aX8wsDlliaMlbvfaUu8csmywD70ca97Wwj70fZep7pMekgF/IgnPDpYFg3MF
 2K1qH0B5+bd6iqub8oF7EXOq8yOFBN9vzFafOaGJ2f3Ws0gi2aCanotUN75QoABRHBGB2jgaMTx
 9lpXOuA8AXAInuFH4lyf/uRiEQFkYFSvKP4otY9+rKcSfZyNqM5ik53/hSM7BaRGGZSInGy3RTX
 I0GneywaljruW9fsZgHDxu2TDflfR8U/rKKtxUZWv0hdcDvSHgMi2DfoF9NNkMgUrcbG2HRUhhO
 2xppNAFBFcBtIMcg9LiYYCqcMtLdXKuX4fToGvRhlFFnBtuMo1149gvayuIYbgQh7lfQ9dx/zZE
 pDsHXiEVndI011g1VbZZgbw1odx4Y4VqnCYZV3T1my4rN5CF19EDlhk7R50WZt31HwMA==
X-Received: by 2002:a05:600c:468c:b0:499:48bb:417e with SMTP id
 5b1f17b1804b1-499aa14a72dmr49684045e9.2.1787132229187; 
 Wed, 19 Aug 2026 02:37:09 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aca21c63sm37939945e9.0.2026.08.19.02.37.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 02:37:08 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH 3/3] usb: ehci-vf: take the register bases from the device tree
Date: Wed, 19 Aug 2026 11:37:05 +0200
Message-ID: <20260819093705.4143509-4-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260819093705.4143509-1-mehmet.fide@gmail.com>
References: <20260819093705.4143509-1-mehmet.fide@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

The driver keeps its own tables of PHY and controller base addresses and
indexes them with a port number, and it reaches the anatop block through
a hardcoded address. The device tree describes all three: the controller
points at its PHY and its usbmisc block, and the PHY points at the
anatop it uses.

Read them from there, as ehci-mx6 does, and drop the tables. The port
number stays for the one thing the device tree does not express, the
choice between PLL3 and PLL7, and it now comes from the alias of the PHY
node instead of the sequence number of the controller.

Note that the usbmisc node already starts at the non-core registers, so
the driver no longer adds an offset of its own to reach them.

Tested on a Colibri VF50 V1.2A on an Iris carrier, U-Boot 2026.07 from
NAND: "usb start" brings the host controller up and enumerates the root
hub, and the port that needs PLL7 is the one that works, so the port
number taken from the PHY alias is the right one.

Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
 drivers/usb/host/ehci-vf.c | 142 +++++++++++++++++++++----------------
 1 file changed, 80 insertions(+), 62 deletions(-)

diff --git a/drivers/usb/host/ehci-vf.c b/drivers/usb/host/ehci-vf.c
index e5f9ec0fdbb..fb305569a15 100644
--- a/drivers/usb/host/ehci-vf.c
+++ b/drivers/usb/host/ehci-vf.c
@@ -26,8 +26,6 @@
 
 #include "ehci.h"
 
-#define USB_NC_REG_OFFSET				0x00000800
-
 #define ANADIG_PLL_CTRL_EN_USB_CLKS		(1 << 6)
 
 #define UCTRL_OVER_CUR_POL	(1 << 8) /* OTG Polarity of Overcurrent */
@@ -39,28 +37,33 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-static const unsigned phy_bases[] = {
-	USB_PHY0_BASE_ADDR,
-	USB_PHY1_BASE_ADDR,
+/* Possible port types (dual role mode) */
+enum dr_mode {
+	DR_MODE_NONE = 0,
+	DR_MODE_HOST,		/* supports host operation */
+	DR_MODE_DEVICE,		/* supports device operation */
+	DR_MODE_OTG,		/* supports both */
 };
 
-static const unsigned nc_reg_bases[] = {
-	USBC0_BASE_ADDR,
-	USBC1_BASE_ADDR,
+struct ehci_vf_priv_data {
+	struct ehci_ctrl ctrl;
+	struct usb_ehci *ehci;
+	struct gpio_desc cdet_gpio;
+	enum usb_init_type init_type;
+	enum dr_mode dr_mode;
+	struct anadig_reg __iomem *anatop_addr;
+	void __iomem *phy_addr;
+	void __iomem *misc_addr;
+	int portnr;
 };
 
-static void usb_internal_phy_clock_gate(int index)
+static void usb_internal_phy_clock_gate(void __iomem *phy_reg)
 {
-	void __iomem *phy_reg;
-
-	phy_reg = (void __iomem *)phy_bases[index];
 	clrbits_le32(phy_reg + USBPHY_CTRL, USBPHY_CTRL_CLKGATE);
 }
 
-static void usb_power_config(int index)
+static void usb_power_config(struct anadig_reg __iomem *anadig, int index)
 {
-	struct anadig_reg __iomem *anadig =
-		(struct anadig_reg __iomem *)ANADIG_BASE_ADDR;
 	void __iomem *pll_ctrl;
 
 	switch (index) {
@@ -83,13 +86,11 @@ static void usb_power_config(int index)
 	}
 }
 
-static void usb_phy_enable(int index, struct usb_ehci *ehci)
+static void usb_phy_enable(void __iomem *phy_reg, struct usb_ehci *ehci)
 {
-	void __iomem *phy_reg;
 	void __iomem *phy_ctrl;
 	void __iomem *usb_cmd;
 
-	phy_reg = (void __iomem *)phy_bases[index];
 	phy_ctrl = (void __iomem *)(phy_reg + USBPHY_CTRL);
 	usb_cmd = (void __iomem *)&ehci->usbcmd;
 
@@ -118,12 +119,8 @@ static void usb_phy_enable(int index, struct usb_ehci *ehci)
 		 USBPHY_CTRL_ENUTMILEVEL3);
 }
 
-static void usb_oc_config(int index)
+static void usb_oc_config(void __iomem *ctrl)
 {
-	void __iomem *ctrl;
-
-	ctrl = (void __iomem *)(nc_reg_bases[index] + USB_NC_REG_OFFSET);
-
 	setbits_le32(ctrl, UCTRL_OVER_CUR_POL);
 	setbits_le32(ctrl, UCTRL_OVER_CUR_DIS);
 }
@@ -133,39 +130,72 @@ int __weak board_ehci_hcd_init(int port)
 	return 0;
 }
 
-int ehci_vf_common_init(struct usb_ehci *ehci, int index)
+static int ehci_vf_common_init(struct ehci_vf_priv_data *priv)
 {
 	int ret;
 
 	/* Do board specific initialisation */
-	ret = board_ehci_hcd_init(index);
+	ret = board_ehci_hcd_init(priv->portnr);
 	if (ret)
 		return ret;
 
-	usb_power_config(index);
-	usb_oc_config(index);
-	usb_internal_phy_clock_gate(index);
-	usb_phy_enable(index, ehci);
+	usb_power_config(priv->anatop_addr, priv->portnr);
+	usb_oc_config(priv->misc_addr);
+	usb_internal_phy_clock_gate(priv->phy_addr);
+	usb_phy_enable(priv->phy_addr, priv->ehci);
 
 	return 0;
 }
 
-/* Possible port types (dual role mode) */
-enum dr_mode {
-	DR_MODE_NONE = 0,
-	DR_MODE_HOST,		/* supports host operation */
-	DR_MODE_DEVICE,		/* supports device operation */
-	DR_MODE_OTG,		/* supports both */
-};
+static int vf_parse_dt_addrs(struct udevice *dev)
+{
+	struct ehci_vf_priv_data *priv = dev_get_priv(dev);
+	const void *blob = gd->fdt_blob;
+	int offset = dev_of_offset(dev);
+	int phy_off, misc_off, anatop_off;
+	int ret, devnump;
+	fdt_addr_t addr;
+
+	phy_off = fdtdec_lookup_phandle(blob, offset, "fsl,usbphy");
+	if (phy_off < 0)
+		return -EINVAL;
 
-struct ehci_vf_priv_data {
-	struct ehci_ctrl ctrl;
-	struct usb_ehci *ehci;
-	struct gpio_desc cdet_gpio;
-	enum usb_init_type init_type;
-	enum dr_mode dr_mode;
-	u32 portnr;
-};
+	misc_off = fdtdec_lookup_phandle(blob, offset, "fsl,usbmisc");
+	if (misc_off < 0)
+		return -EINVAL;
+
+	/* Resolve ANATOP offset through USB PHY node */
+	anatop_off = fdtdec_lookup_phandle(blob, phy_off, "fsl,anatop");
+	if (anatop_off < 0)
+		return -EINVAL;
+
+	/*
+	 * The PHYs are the only USB nodes the device tree gives an alias, and
+	 * their numbering is the port numbering the PLL selection needs.
+	 */
+	ret = fdtdec_get_alias_seq(blob, dev->uclass->uc_drv->name, phy_off,
+				   &devnump);
+	if (ret < 0)
+		return ret;
+	priv->portnr = devnump;
+
+	addr = fdtdec_get_addr(blob, phy_off, "reg");
+	if (addr == FDT_ADDR_T_NONE)
+		return -EINVAL;
+	priv->phy_addr = (void __iomem *)addr;
+
+	addr = fdtdec_get_addr(blob, misc_off, "reg");
+	if (addr == FDT_ADDR_T_NONE)
+		return -EINVAL;
+	priv->misc_addr = (void __iomem *)addr;
+
+	addr = fdtdec_get_addr(blob, anatop_off, "reg");
+	if (addr == FDT_ADDR_T_NONE)
+		return -EINVAL;
+	priv->anatop_addr = (struct anadig_reg __iomem *)addr;
+
+	return 0;
+}
 
 static int vf_usb_of_to_plat(struct udevice *dev)
 {
@@ -173,23 +203,11 @@ static int vf_usb_of_to_plat(struct udevice *dev)
 	const void *dt_blob = gd->fdt_blob;
 	int node = dev_of_offset(dev);
 	const char *mode;
-	fdt_addr_t phy_addr;
-	ofnode phy_node;
-	int i;
-
-	phy_node = ofnode_parse_phandle(dev_ofnode(dev), "fsl,usbphy", 0);
-	if (!ofnode_valid(phy_node))
-		return -EINVAL;
-
-	phy_addr = ofnode_get_addr(phy_node);
-	for (i = 0; i < ARRAY_SIZE(phy_bases); i++) {
-		if (phy_addr == phy_bases[i])
-			break;
-	}
-	if (i == ARRAY_SIZE(phy_bases))
-		return -EINVAL;
+	int ret;
 
-	priv->portnr = i;
+	ret = vf_parse_dt_addrs(dev);
+	if (ret)
+		return ret;
 
 	priv->ehci = dev_read_addr_ptr(dev);
 	mode = fdt_getprop(dt_blob, node, "dr_mode", NULL);
@@ -241,7 +259,7 @@ static int vf_init_after_reset(struct ehci_ctrl *dev)
 	struct usb_ehci *ehci = priv->ehci;
 	int ret;
 
-	ret = ehci_vf_common_init(priv->ehci, priv->portnr);
+	ret = ehci_vf_common_init(priv);
 	if (ret)
 		return ret;
 
@@ -270,7 +288,7 @@ static int ehci_usb_probe(struct udevice *dev)
 	struct ehci_hcor *hcor;
 	int ret;
 
-	ret = ehci_vf_common_init(ehci, priv->portnr);
+	ret = ehci_vf_common_init(priv);
 	if (ret)
 		return ret;
 
-- 
2.54.0

