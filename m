Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50CCCC5DF85
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 07:15:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BF97080C98;
	Thu, 20 Aug 2026 07:15:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GUfqd-_KTpCG; Thu, 20 Aug 2026 07:15:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787210126;
	bh=0cbfUUV5/q+n0fEe244sOrp8aro+Nky7lUmIZI2gjyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CERAyH7T53rrSiC1X2Ox3IRFM+8h/g7oosc1Y0loiKfO2zogP/3SKJNT3Cr6Rl3QS
	 tiCfmWhTe3iOp/E13EP5LuE2whrHDL7LiDmbyqBUqrkXgjsVP84Q/4W30moPjwqAx4
	 p84wWmUon/Gmqhi3343UG9+wQeh7seFMCqHj9VlKn7W1BXBc2l7Lfu5d56e2KG6nuV
	 6EHGJp8c3Ew+Cte78kkfHFZlvVbRN4LCNJos8UmdHKyz1mwIG1w4JtCglhMXUeIcVo
	 MkHod6pCK/ZEOqF0EsyOB6ZLPEAiCuaBPsPb2dvg0S8Z2sFhrnbaMeySlVcc4GjkcD
	 gxlwxt5kUoXow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9A29080C32;
	Thu, 20 Aug 2026 07:15:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 22DB22FD
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 07:15:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 12FEA80C50
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 07:15:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XTnevJUjDYFR for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 07:15:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=KaMaUQcW
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 778A580C36
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 07:15:18 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4996f1ee4a4so16112165e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 00:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787210116; x=1787814916;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0cbfUUV5/q+n0fEe244sOrp8aro+Nky7lUmIZI2gjyQ=;
 b=KaMaUQcWigLrXcz/Podz1l/yTzmHIDsOFi7CnYMbEf6l7ot1CXLf/ePEmW0kxIp+QK
 7t4bOVZ99EQw56Baj5QdhJNjB9hqTQPoTY66XPJauUUk3kBmbFjYYzpH7aa9LAncAQrx
 0Rd3OajkW/950ZI6DrxC/M24OhHcycHa6uq8cD7sSqECiCvCXS/83II++XIO6YbSSigk
 hTUOFZSQHKJwmCjSRs2H543YsvRZjwZu+1liTTIfPCc4JTMUw0mVtRAlhFwlZQsNfUj+
 q+iNYwLnkGJM5B1YO7QgMzzOAp8zSy+VPOjVudXkBFJFACg2nLQjF29wrq+8zDAZz8HC
 bbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787210116; x=1787814916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0cbfUUV5/q+n0fEe244sOrp8aro+Nky7lUmIZI2gjyQ=;
 b=V+GrZFd9MLlNAqqnqpMnpp+F1fphx81tg5UhKNOr6HAnMouX/FOE8yNzwY+IR+/5XY
 fcKs4Rn4E7C+0s3IrpJgzi06ZoHBXO66vA6lpjtaFh2Mpl4UgC+hOXYqzUAS1FYFhAE4
 IgKlb6CxrgNnH4kKjDJqTUdp82LEqVBNAGp2ksagZOX9xozazPINPSm205dLCWUHVZ2g
 1dcQBpDbVtXlQJVUfJD/SBItC8hCYBepNBaq0ORCud3R1O04vL+j/vBB4Fa0mPtsbLp8
 hloGA2hIwdJM1KiMSO3xbtTGA3s/p+nd+iaaHH8nqMZes61gb0ylvE3oP9PVbWjAeb0t
 aD/Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoihhbFVQpVTm3ln1bWmlpsl1DtSO1vS5uilebf96YFbYHlWHPqGldp3CcfLlBMWDMerXkmL30=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxCy9+ZMJrr0RtxKuIW5mOyPrHb2uiHusm7k0Su03uPZqHa+FWs
 IOCdmPQoDxhIDMW5fH50XvxAwiiWAsUI6dPm0IU70QYqkGN84iavfpxd8/bfGg==
X-Gm-Gg: AR+sD116tkHxDCrlrRSS6R2vklOsdq33BHUfpR6Xzp4BNq1wn/VjNAPxYy6ONZQ2D2J
 rDhJGv49mZgE2Idz3r7+lbU/u718UBbqkm7UEr8nYLQRev0pf1lRTqhk6Nw8PyvnLs9oSMMJ/9H
 /7fjQj5yb7dwWP0KBDn2gn7sD9HdoLF9UIOh9o6Vno16RMYlWZ//A+6I66SKrjt/smum3NZEThC
 1oI5Ok1acH7VmhPI81qXWkQzroCpWjdNpmZtfxLwY9S97dnvfsfXtp61Qx0xusj/HlLkQywH4Kb
 vKQxOh7GG1d5WYLFx9ZvpQpgXywmJ24DspxYx3DACVt4Lwb2w47F74Xz0uhwFz4KJ23eah7guzr
 0yvon8i/7bJjDWONqGoJQxo97YVYo4qPHLUUq+JQOeuqJFNKSA9Ve/bW2fBLoo6GnFIl1uFtd3G
 T7hx8Gv2V45aPg89HbFRXKmbZwuqGlCLe7J+egT6okg+5ojea4BxJUXE1jjQfNl9pWkg==
X-Received: by 2002:a05:600c:4ec9:b0:495:6e68:5df2 with SMTP id
 5b1f17b1804b1-499aa1e33femr160414165e9.12.1787210116190; 
 Thu, 20 Aug 2026 00:15:16 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa0d6721sm158151475e9.11.2026.08.20.00.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 00:15:15 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH v2 4/4] usb: ehci-vf: take the register bases from the device
 tree
Date: Thu, 20 Aug 2026 09:15:11 +0200
Message-ID: <20260820071511.1036506-5-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820071511.1036506-1-mehmet.fide@gmail.com>
References: <20260820071511.1036506-1-mehmet.fide@gmail.com>
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

Read them from there and drop the tables. The port number stays for the
one thing the device tree does not express, the choice between PLL3 and
PLL7, and it now comes from the alias of the PHY node instead of the
sequence number of the controller.

Note that the usbmisc node already starts at the non-core registers, so
the driver no longer adds an offset of its own to reach them.

The previous version of this patch did the same through fdtdec, because
that is what ehci-mx6 does in mx6_parse_dt_addrs(); this one uses the
livetree calls instead, as asked in review.

Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
 drivers/usb/host/ehci-vf.c | 140 ++++++++++++++++++++-----------------
 1 file changed, 77 insertions(+), 63 deletions(-)

diff --git a/drivers/usb/host/ehci-vf.c b/drivers/usb/host/ehci-vf.c
index e5f9ec0fdbb..6c9866bfa5f 100644
--- a/drivers/usb/host/ehci-vf.c
+++ b/drivers/usb/host/ehci-vf.c
@@ -22,12 +22,9 @@
 #include <linux/delay.h>
 #include <usb/ehci-ci.h>
 #include <linux/libfdt.h>
-#include <fdtdec.h>
 
 #include "ehci.h"
 
-#define USB_NC_REG_OFFSET				0x00000800
-
 #define ANADIG_PLL_CTRL_EN_USB_CLKS		(1 << 6)
 
 #define UCTRL_OVER_CUR_POL	(1 << 8) /* OTG Polarity of Overcurrent */
@@ -39,28 +36,33 @@
 
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
@@ -83,13 +85,11 @@ static void usb_power_config(int index)
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
 
@@ -118,12 +118,8 @@ static void usb_phy_enable(int index, struct usb_ehci *ehci)
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
@@ -133,63 +129,81 @@ int __weak board_ehci_hcd_init(int port)
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
-
-struct ehci_vf_priv_data {
-	struct ehci_ctrl ctrl;
-	struct usb_ehci *ehci;
-	struct gpio_desc cdet_gpio;
-	enum usb_init_type init_type;
-	enum dr_mode dr_mode;
-	u32 portnr;
-};
-
-static int vf_usb_of_to_plat(struct udevice *dev)
+static int vf_parse_dt_addrs(struct udevice *dev)
 {
 	struct ehci_vf_priv_data *priv = dev_get_priv(dev);
-	const void *dt_blob = gd->fdt_blob;
-	int node = dev_of_offset(dev);
-	const char *mode;
-	fdt_addr_t phy_addr;
-	ofnode phy_node;
-	int i;
+	ofnode phy_node, misc_node, anatop_node;
+	fdt_addr_t addr;
+	int ret;
 
 	phy_node = ofnode_parse_phandle(dev_ofnode(dev), "fsl,usbphy", 0);
 	if (!ofnode_valid(phy_node))
 		return -EINVAL;
 
-	phy_addr = ofnode_get_addr(phy_node);
-	for (i = 0; i < ARRAY_SIZE(phy_bases); i++) {
-		if (phy_addr == phy_bases[i])
-			break;
-	}
-	if (i == ARRAY_SIZE(phy_bases))
+	misc_node = ofnode_parse_phandle(dev_ofnode(dev), "fsl,usbmisc", 0);
+	if (!ofnode_valid(misc_node))
+		return -EINVAL;
+
+	/* the anatop the PHY uses holds the PLL that feeds this port */
+	anatop_node = ofnode_parse_phandle(phy_node, "fsl,anatop", 0);
+	if (!ofnode_valid(anatop_node))
+		return -EINVAL;
+
+	/*
+	 * The PHYs are the only USB nodes the device tree gives an alias, and
+	 * their numbering is the port numbering the PLL selection needs.
+	 */
+	ret = ofnode_get_alias_seq(phy_node, dev->uclass->uc_drv->name,
+				   &priv->portnr);
+	if (ret)
+		return ret;
+
+	addr = ofnode_get_addr(phy_node);
+	if (addr == FDT_ADDR_T_NONE)
+		return -EINVAL;
+	priv->phy_addr = (void __iomem *)addr;
+
+	addr = ofnode_get_addr(misc_node);
+	if (addr == FDT_ADDR_T_NONE)
 		return -EINVAL;
+	priv->misc_addr = (void __iomem *)addr;
 
-	priv->portnr = i;
+	addr = ofnode_get_addr(anatop_node);
+	if (addr == FDT_ADDR_T_NONE)
+		return -EINVAL;
+	priv->anatop_addr = (struct anadig_reg __iomem *)addr;
+
+	return 0;
+}
+
+static int vf_usb_of_to_plat(struct udevice *dev)
+{
+	struct ehci_vf_priv_data *priv = dev_get_priv(dev);
+	const void *dt_blob = gd->fdt_blob;
+	int node = dev_of_offset(dev);
+	const char *mode;
+	int ret;
+
+	ret = vf_parse_dt_addrs(dev);
+	if (ret)
+		return ret;
 
 	priv->ehci = dev_read_addr_ptr(dev);
 	mode = fdt_getprop(dt_blob, node, "dr_mode", NULL);
@@ -241,7 +255,7 @@ static int vf_init_after_reset(struct ehci_ctrl *dev)
 	struct usb_ehci *ehci = priv->ehci;
 	int ret;
 
-	ret = ehci_vf_common_init(priv->ehci, priv->portnr);
+	ret = ehci_vf_common_init(priv);
 	if (ret)
 		return ret;
 
@@ -270,7 +284,7 @@ static int ehci_usb_probe(struct udevice *dev)
 	struct ehci_hcor *hcor;
 	int ret;
 
-	ret = ehci_vf_common_init(ehci, priv->portnr);
+	ret = ehci_vf_common_init(priv);
 	if (ret)
 		return ret;
 
-- 
2.54.0

