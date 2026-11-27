Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D47606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 18:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mmwAbTyp;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dSHICuP8
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3860940D65;
	Fri, 27 Nov 2026 18:29:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YgqqMzlmNOgK; Fri, 27 Nov 2026 18:29:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F0A1240D76
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795804171;
	b=RebC9OnrxYvWGXVtX4pMSjyQkVpj46An5xdnR+XY4AzV6HD7oO/KwIttFgotHzg8VkQk
	 ypPw+CN6TV14qXcLxBB9JLfaL7iA1xDdBir+0VInEpHQWjqrE8kFIZsnTGB925EE9VQFn
	 /1qv6vFXq3muMbA+K3qFvMm7KnqB4R4BHtbwh/b+ULqQk+XvdTSppof/ZQxTY8fA5WyrG
	 MvsbVYhUyb8qOJh8HZloVfXKLE2C5oB3npTtuDswORicgYpFZuBsK9X1oV48aXrmpUPrK
	 g0Vaufh4HeESPow7LdP3ftxcpDutg+2Hk0UpnvEErwsIMwNAClDKs3M5maPzuZwgguw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795804171;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=SodvxaDSX0ne4FOZFnDuhODuoV/gVcBiQOmQ4fQL4xE=;
	b=h1Hbji6n9TK6OQWT0FgKARPIu1uzuRp+DJ0PefmWPkLhKNaYHxIMtVrX6/PFiR5RqGpW
	 79Ax5+39gctA6PHlMxRysxeybwrGB4AVt160vqBw1wI1U3ZVhf9jLz4Tf5sXR1mkqEObu
	 8Ruz8tv/mcZs/uJzuB1pe9gagi3gdenuEIIK4fhb0LRh7Z4wfzwh6R0MIfAwP9x2GXqiI
	 EmY4YwrDDuFRvIw7fLV9eWwlGXLDRi6wmSS6abnIUn8LFAsKmOfIxZOQj1VtVEIvj5GgY
	 LA9n7URT6iyVATnUJXPpsCn36nZKATxQXF2NL6LWbtvmWQlUypNUkHbqRlyq0f0O1OQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dSHICuP8;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795804171;
	bh=SodvxaDSX0ne4FOZFnDuhODuoV/gVcBiQOmQ4fQL4xE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mmwAbTypfIMFpVIusrVrHSmUsgb7fkHeAbqu+9WwRHnV7tFOn/UM32xzu+RLJouHc
	 psaFvyN8olXOSN3jc0fSY8Tfoi+iJS+4+dudW5kme152FjbvZr6i0h+65Tzoxc4Ov1
	 vxi71/NqgrCBh+lUiWTSkqSq6LDYTcQIZsDdtzEspv2Bbg2z31zZ4jj/RHoE6HCnMv
	 5hmXkAS7YloXHzT8rlWzhfqufhgP4i25aTvNUgpi7bz6iORIwhCWLIiNm3Zyh5LZMi
	 LUOcAt0ACUEkgD/9Vf0QC2K3aGVGqSwrcFbvL02BUuxUCz2NNnj0RY4sWzs+L9++hm
	 WGhUQCYSo7ndA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F0A1240D76;
	Fri, 27 Nov 2026 18:29:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2BF7B373
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:29:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1417D40AD9
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:29:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j7XRP9uFptvW for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 18:29:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 79ACB40CA6
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::435"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=dSHICuP8
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 79ACB40CA6
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:29:14 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-4a2f4ca0dcfso4821580f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795804152; x=1796408952;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SodvxaDSX0ne4FOZFnDuhODuoV/gVcBiQOmQ4fQL4xE=;
 b=dSHICuP8Mq2oEYGlK8T6zRYO7QkuMJQhiCXSfuL1ojXcOzyLMyQ/xxAIAnCEryz0T8
 y7BgaIa6trMSkOKQuhRD1CNGB9sHtHcKQPU/squF8iFRbdRHmb8eR3+gxL24G3jNTawU
 VsurPVAz4aDvly07X7HA60Vipg9ruZQ2INZqa4576wj2mpmUDSh7tdTahNrJDB2PMgCv
 Xg76aNnEIAb1xZ22M6IWXJGddwq5rcZErQjvN/+9vWnInUvGZPqVY4DyZRWZfa5v272o
 lfsZQl6mZRTKs/MezjBoGyrbBLEIXzP1sB52lD9NpCnfaur4/U9HTMyO0zlM/s4q2spU
 0MWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795804152; x=1796408952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SodvxaDSX0ne4FOZFnDuhODuoV/gVcBiQOmQ4fQL4xE=;
 b=rbIZVCALdRrajLaZmCKNlpd+HYoKZdb7XCTomlbyMXLVGUNSUw8GoY3mJrz2fQJe7p
 5Rylbu4rYGbNgBwZOxhcAleNoal8ZA8RyErxHFiXZQu/3npJbeu728hzLwde2lQjvFQb
 24NAYwNVew0eXecQjknZZWnhsfgZfzFyBij3x+maXmcgwhEgU5nffe4gYah5uOxMFz4A
 mIkNPePbhl4xb50iTiTuZ+DK+AaPqguesnWhOzQ8jH8ONdm1VUqchN6J6ZNOy2MvJSSk
 x/v/LHvjMmJHwsY8XT46dVSAFkPTTNMOArEj0M6suaZ/ow+0rEjdhl00lgwGsdbgfqYq
 JsEg==
X-Forwarded-Encrypted: i=1;
 AL+hErFSH2TnUp+CczueuDo5+BzWdB/+wWEB8xnBeXJW3cAcEswO4lE43GW0c4FLfTyS4jZ9CfP24NA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9kxwCvXh4nH0E+3YwWt6oyGs0VJ5d6VV2Zd2I1+5/kgXCWVzWn
 nq3m9fXBZwZwWBB2ezs7v5/vEzv2MH721xsJRjsRoMp384/hB6KnIW9z
X-Gm-Gg: AZFdTZcxQcDZktKQGz78DiJAtu0V1pR0dCaVRujuunZttdMcBIj83zsV/8K6Sc+7JbE
 NK+X/CIsyBP4rlBB+bJzo0xLZT7nTXDf+Yc7MEW9pnYfJn2XHY+aJCdyUj1/5v7ey1rjhUF5yx1
 ZCNl5fajkR0WWfBN9J2yw9sbRYoadrHHK5e8Af33BT/eo7nHBXVUdv+yn7PSRXnhfbL/egAYDxl
 hdTQuzH7cP7E256O2gOSD4ctl8HVd+1d1AlERuQ1x3+GkKF/4lnJvfoIzMTVuI5W0Iejlktvv5n
 XbeKcAiFJJQ//3KFZd/bp05VU2sCE5FCYgQDKWij+DSxJ3UkXSLfd4I7u6IIXpYHIN4cdOYSN7u
 DoEqBr0eS+IDUucS5xRm6XHxStmQMigmFlK0Tq5iYGUomRyFRJXEMt2k0P4hQKVwVIXW+1WRxX/
 68HDqBwD4QOCD+GC7b4UnRYElIrBjZxg5TEUdmpMXUQP1ojA+6wpTOul6o7ije2JxYPDeyOLfhU
 KseKaf4Lb8BfFs3rBc3DCegwBMb4ZmTdJOJ3U5XFlKVsojWOpizYwGR7dQPnESAhNtxZvJbbgxq
 pZgq0B+P5cU7Sz6/swhff913pr32NNlnNwg=
X-Received: by 2002:a5d:6f1b:0:b0:4b9:15d1:46c9 with SMTP id
 ffacd0b85a97d-4b915d146fbmr20222415f8f.5.1795804152190; 
 Fri, 27 Nov 2026 10:29:12 -0800 (PST)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d1bsm50584856f8f.8.2026.11.27.10.29.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 10:29:11 -0800 (PST)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Fabio Estevam <festevam@gmail.com>
Cc: Lukasz Majewski <lukma@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, mehmet.fide@screeningeagle.com
Subject: [PATCH 5/8] usb: ehci-vf: enable the PHY clock through the clock
 driver
Date: Fri, 27 Nov 2026 19:29:02 +0100
Message-ID: <20261127182905.2836449-6-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261127182905.2836449-1-mehmet.fide@gmail.com>
References: <20261127182905.2836449-1-mehmet.fide@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

The driver powers PLL3 or PLL7 up and enables its USB output by hand,
through the anatop registers. That is the clock the PHY node names in
its clocks property, VF610_CLK_USBPHY0 or VF610_CLK_USBPHY1, and the
clock driver handles it now.

Get the clock of the PHY and enable it instead, and drop the anatop
lookup, which only served that. The driver depends on the clock driver
now.

Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
 drivers/usb/host/Kconfig   |  2 +-
 drivers/usb/host/ehci-vf.c | 53 +++++++-------------------------------
 2 files changed, 10 insertions(+), 45 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 6bbed9cb513..e92c989288d 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -246,7 +246,7 @@ config USB_EHCI_OMAP
 
 config USB_EHCI_VF
 	bool "Support for Vybrid on-chip EHCI USB controller"
-	depends on ARCH_VF610
+	depends on ARCH_VF610 && CLK_VF610
 	default y
 	help
 	  Enables support for the on-chip EHCI controller on Vybrid SoCs.
diff --git a/drivers/usb/host/ehci-vf.c b/drivers/usb/host/ehci-vf.c
index f7809a98c88..fa36e3e2af4 100644
--- a/drivers/usb/host/ehci-vf.c
+++ b/drivers/usb/host/ehci-vf.c
@@ -6,13 +6,13 @@
  * Based on ehci-mx6 driver
  */
 
+#include <clk.h>
 #include <dm.h>
 #include <errno.h>
 #include <log.h>
 #include <usb.h>
 #include <asm-generic/gpio.h>
 #include <asm/arch/clock.h>
-#include <asm/arch/crm_regs.h>
 #include <asm/arch/imx-regs.h>
 #include <asm/io.h>
 #include <asm/mach-imx/iomux-v3.h>
@@ -27,8 +27,6 @@
 
 #include "ehci.h"
 
-#define ANADIG_PLL_CTRL_EN_USB_CLKS		(1 << 6)
-
 #define UCTRL_OVER_CUR_POL	(1 << 8) /* OTG Polarity of Overcurrent */
 #define UCTRL_OVER_CUR_DIS	(1 << 7) /* Disable OTG Overcurrent Detection */
 
@@ -42,11 +40,11 @@ struct ehci_vf_priv_data {
 	struct gpio_desc cdet_gpio;
 	enum usb_init_type init_type;
 	enum usb_dr_mode dr_mode;
-	struct anadig_reg __iomem *anatop_addr;
 	void __iomem *phy_addr;
 	void __iomem *misc_addr;
 	struct udevice *dev;
 	struct udevice *vbus_supply;
+	struct clk phy_clk;
 	u32 portnr;
 };
 
@@ -55,31 +53,6 @@ static void usb_internal_phy_clock_gate(struct ehci_vf_priv_data *priv)
 	clrbits_le32(priv->phy_addr + USBPHY_CTRL, USBPHY_CTRL_CLKGATE);
 }
 
-static void usb_power_config(struct ehci_vf_priv_data *priv)
-{
-	struct anadig_reg __iomem *anadig = priv->anatop_addr;
-	void __iomem *pll_ctrl;
-
-	switch (priv->portnr) {
-	case 0:
-		pll_ctrl = &anadig->pll3_ctrl;
-		clrbits_le32(pll_ctrl, ANADIG_PLL3_CTRL_BYPASS);
-		setbits_le32(pll_ctrl, ANADIG_PLL3_CTRL_ENABLE
-			 | ANADIG_PLL3_CTRL_POWERDOWN
-			 | ANADIG_PLL_CTRL_EN_USB_CLKS);
-		break;
-	case 1:
-		pll_ctrl = &anadig->pll7_ctrl;
-		clrbits_le32(pll_ctrl, ANADIG_PLL7_CTRL_BYPASS);
-		setbits_le32(pll_ctrl, ANADIG_PLL7_CTRL_ENABLE
-			 | ANADIG_PLL7_CTRL_POWERDOWN
-			 | ANADIG_PLL_CTRL_EN_USB_CLKS);
-		break;
-	default:
-		return;
-	}
-}
-
 static void usb_phy_enable(struct ehci_vf_priv_data *priv)
 {
 	void __iomem *phy_reg = priv->phy_addr;
@@ -134,7 +107,10 @@ static int ehci_vf_common_init(struct ehci_vf_priv_data *priv)
 	if (ret)
 		return ret;
 
-	usb_power_config(priv);
+	ret = clk_enable(&priv->phy_clk);
+	if (ret)
+		return ret;
+
 	usb_oc_config(priv);
 	usb_internal_phy_clock_gate(priv);
 	usb_phy_enable(priv);
@@ -145,8 +121,7 @@ static int ehci_vf_common_init(struct ehci_vf_priv_data *priv)
 static int vf_parse_dt_addrs(struct udevice *dev)
 {
 	struct ehci_vf_priv_data *priv = dev_get_priv(dev);
-	struct ofnode_phandle_args phy, misc, clk;
-	ofnode anatop_node;
+	struct ofnode_phandle_args phy, misc;
 	fdt_addr_t addr;
 	int ret;
 
@@ -159,16 +134,11 @@ static int vf_parse_dt_addrs(struct udevice *dev)
 	if (ret)
 		return ret;
 
-	anatop_node = ofnode_parse_phandle(phy.node, "fsl,anatop", 0);
-	if (!ofnode_valid(anatop_node))
-		return -EINVAL;
-
-	ret = ofnode_parse_phandle_with_args(phy.node, "clocks", "#clock-cells",
-					     0, 0, &clk);
+	ret = clk_get_by_index_nodev(phy.node, 0, &priv->phy_clk);
 	if (ret)
 		return ret;
 
-	switch (clk.args[0]) {
+	switch (priv->phy_clk.id) {
 	case VF610_CLK_USBPHY0:
 		priv->portnr = 0;
 		break;
@@ -189,11 +159,6 @@ static int vf_parse_dt_addrs(struct udevice *dev)
 		return -EINVAL;
 	priv->misc_addr = (void __iomem *)addr;
 
-	addr = ofnode_get_addr(anatop_node);
-	if (addr == FDT_ADDR_T_NONE)
-		return -EINVAL;
-	priv->anatop_addr = (struct anadig_reg __iomem *)addr;
-
 	return 0;
 }
 
-- 
2.56.0

