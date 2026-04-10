Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21CDFF364DC
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 11:05:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 590C4841CD;
	Fri, 10 Apr 2026 13:04:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="kSnOQD64";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0863584106; Fri, 10 Apr 2026 13:04:45 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C105884199
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 13:04:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43d43e09de5so1017905f8f.1
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 04:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775819078; x=1776423878;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YIQqYGJyDi8KAoevzX3u7kL/iFz9ctO6qA4P1mcqGWY=;
 b=kSnOQD64nJYzlRgcJKO/2v8noz8iOt93pmYFfskeK7Kde/e2/5nxIslGCO/hrOXT1x
 v0DQkGtsRU/kj9v8tTKb43Sg8hV7roNSqwvP8hiPCUyOF5Ua5stn2+NmamUSYgpF06mF
 Zgwbxa/2hr7NJWoGUD7dm47cJYivKv28zaWqbT0wLKE+UcJZO3APxYw7iRijhr1G1Q+j
 PnXV2nk5GSJ/pqBrJrKKXX2GJPBpiecb2nlscaQBStVEUiIxQ0HcRQ0p93XAVnxiEz9c
 4O3edrY1ELMLA4akTof8Qtu308JecIaQ3hXZQxBjyYJtpnJxKzTZoejVq2jntmVaPvhl
 NldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775819078; x=1776423878;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YIQqYGJyDi8KAoevzX3u7kL/iFz9ctO6qA4P1mcqGWY=;
 b=Q7wVvKKYJHBOR2ST/OyqBQB8fo/8/AjNG8J7CvtoszeTkheoPQWIpBIjTT2VNWt1t6
 E9rAHF6T9A/pjFbGhduEJSqI9nIFQVD4grUmXaM4FY305zSEaWIyAKtYGtWnpbrKrOth
 NbdzOrsVbasX5fxzMM4CTuGaSrasgDHJyGrE5deH518rzi3F/qOwHL+wuu+QZsJIIeZ1
 Wavqp9r1/+6kwFX45LYNy7KdQeF8YYt4rDDV4PV+lYUvjFtt+J87DiU5ftYXZozs1mN8
 CzB87NYBujvpf4BAfvC9mfVicGEq+LphzecgWagGpnLnGleNbnzl/6ExDBPqW/vr8DAH
 seFg==
X-Gm-Message-State: AOJu0YxQqJg4R1S5gblGEBCpeLq/ZJA+a54uri93zfSSAJ00II8ff1lU
 zEINwhoxyCoip+Zj4FFjZjqHBNYcUVf6NCDrY1tweS9iYta6ZKV/xkkBRe04SWZh02WbrtJGuOf
 6Z1UA
X-Gm-Gg: AeBDiet3AwaVvVfMfL0HNVj8gg1lXxmFccpBWdvACCy64EYujjsVWP+FGtpQt0lxIhB
 jKRByVK5wRZKstgIq6qc7VflqqfEVOkJdT4TzTud7sTBvCcaBdWYUe1EOI7/lLMePIxEFTcSLak
 MwftdBUwywWXw0fjlfTEr5DNn1vb4VhZOT5D9/zvRRSZ0uK91Afy0H2aSxz3E18HUXemo/mcvKT
 3DCpGF+K8mRy8l/7GpItwKO9Wyqhz/c7fSrGLBXyJ7N7ocREbsymnzK5XTTV3A1AS/1UQxb7l+E
 gIRQhKUlB12ywtub4bFbDMyHPgKaCUPQ7hJNz/obD4r2nAZxGRsmxO/OaMKPYpTd616yr2w9BrY
 AaraVVBVWU5dFTlJfKZxy71uzDePXLVpmRwtQz7YBMq/rUyGxIJDEa5rn0zY9pbg9tPg8iC/q4S
 eFuSaYHI0xOYQMbpapij2y
X-Received: by 2002:a05:6000:1447:b0:43d:1bf6:30f2 with SMTP id
 ffacd0b85a97d-43d6428d948mr4080856f8f.20.1775819077841; 
 Fri, 10 Apr 2026 04:04:37 -0700 (PDT)
Received: from localhost ([2001:4091:a246:8598:4c79:7b44:ca74:c5de])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63dec090sm6797095f8f.12.2026.04.10.04.04.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 04:04:37 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Fri, 10 Apr 2026 13:04:06 +0200
Subject: [PATCH 4/4] net: cpsw: Support new cpsw-switch DT bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-topic-cpsw-switch-v2026-07-next-v1-4-c914724b13e4@baylibre.com>
References: <20260410-topic-cpsw-switch-v2026-07-next-v1-0-c914724b13e4@baylibre.com>
In-Reply-To: <20260410-topic-cpsw-switch-v2026-07-next-v1-0-c914724b13e4@baylibre.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6318; i=msp@baylibre.com;
 h=from:subject:message-id; bh=sC3LWihHEDj9ddzcYcUMy8y13zKnmjUYHGMG24BggXc=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhswbN61DDs+OXxosvfTIz0eecossHPS/ddiWqb10lS2Xf
 uXxRuxmRykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAEzkiBcjw4fvzpd5ph2dXrf0
 614zVZ1l589+LrOt0bykKTu3u+PCgVeMDPdcsvtuxjddy7jNeeGCmeXZShfeNakBmj7mSh35d+y
 mMgIA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

Upstream devicetrees use a newer DT binding using cpsw-switch
compatibles. The bindings are a bit different, so two functions are
introduced to capture the differences, cpsw_eth_of_to_plat_switch() and
cpsw_eth_of_to_plat_legacy().

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 drivers/net/ti/cpsw.c | 148 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 115 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ti/cpsw.c b/drivers/net/ti/cpsw.c
index b1fb009822e9586886e5487e4fbeee115eec9a59..7a7cb83bd9847bc79ed21b2786ef6fe869e3fc0d 100644
--- a/drivers/net/ti/cpsw.c
+++ b/drivers/net/ti/cpsw.c
@@ -33,6 +33,7 @@
 #define PKT_MAX			(1500 + 14 + 4 + 4)
 #define CLEAR_BIT		1
 #define GIGABITEN		BIT(7)
+#define GMII_EN			BIT(5)
 #define FULLDUPLEXEN		BIT(0)
 #define MIIEN			BIT(15)
 #define CTL_EXT_EN		BIT(18)
@@ -1133,33 +1134,13 @@ static void cpsw_eth_of_parse_slave(struct cpsw_platform_data *data,
 							"max-speed", 0);
 }
 
-static int cpsw_eth_of_to_plat(struct udevice *dev)
+static int cpsw_eth_of_to_plat_legacy(struct udevice *dev,
+				      struct cpsw_platform_data *data)
 {
-	struct eth_pdata *pdata = dev_get_plat(dev);
-	struct cpsw_platform_data *data;
-	struct gpio_desc *mode_gpios;
 	int slave_index = 0;
-	int num_mode_gpios;
 	ofnode subnode;
 	int ret;
 
-	data = calloc(1, sizeof(struct cpsw_platform_data));
-	if (!data)
-		return -ENOMEM;
-
-	pdata->priv_pdata = data;
-	pdata->iobase = dev_read_addr(dev);
-	data->version = CPSW_CTRL_VERSION_2;
-	data->bd_ram_ofs = CPSW_BD_OFFSET;
-	data->ale_reg_ofs = CPSW_ALE_OFFSET;
-	data->cpdma_reg_ofs = CPSW_CPDMA_OFFSET;
-	data->mdio_div = CPSW_MDIO_DIV;
-	data->host_port_reg_ofs = CPSW_HOST_PORT_OFFSET,
-
-	pdata->phy_interface = -1;
-
-	data->cpsw_base = pdata->iobase;
-
 	ret = dev_read_s32(dev, "cpdma_channels", &data->channels);
 	if (ret) {
 		printf("error: cpdma_channels not found in dt\n");
@@ -1192,17 +1173,6 @@ static int cpsw_eth_of_to_plat(struct udevice *dev)
 		return ret;
 	}
 
-	num_mode_gpios = gpio_get_list_count(dev, "mode-gpios");
-	if (num_mode_gpios > 0) {
-		mode_gpios = malloc(sizeof(struct gpio_desc) *
-				    num_mode_gpios);
-		gpio_request_list_by_name(dev, "mode-gpios", mode_gpios,
-					  num_mode_gpios, GPIOD_IS_OUT);
-		free(mode_gpios);
-	}
-
-	data->active_slave = dev_read_u32_default(dev, "active_slave", 0);
-
 	ofnode_for_each_subnode(subnode, dev_ofnode(dev)) {
 		const char *name;
 
@@ -1236,6 +1206,115 @@ static int cpsw_eth_of_to_plat(struct udevice *dev)
 		}
 	}
 
+	return 0;
+}
+
+static int cpsw_eth_of_to_plat_switch(struct udevice *dev,
+				      struct cpsw_platform_data *data)
+{
+	ofnode eth_ports_node, subnode;
+	int ret;
+
+	data->channels = 8;
+	data->ale_entries = 1024;
+	data->mac_control = GMII_EN;
+
+	eth_ports_node = ofnode_find_subnode(dev_ofnode(dev), "ethernet-ports");
+	data->slaves = ofnode_get_child_count(eth_ports_node);
+	if (!data->slaves) {
+		pr_err("cpsw: No ethernet-ports defined\n");
+		return -EINVAL;
+	}
+
+	data->slave_data = malloc(sizeof(struct cpsw_slave_data) * data->slaves);
+	if (!data->slave_data)
+		return -ENOMEM;
+
+	ofnode_for_each_subnode(subnode, eth_ports_node) {
+		struct ofnode_phandle_args args;
+		u32 port_id;
+
+		ret = ofnode_read_u32(subnode, "reg", &port_id);
+		if (ret || !port_id || port_id > data->slaves) {
+			pr_err("cpsw: invalid or missing reg in port node\n");
+			return -EINVAL;
+		}
+
+		cpsw_eth_of_parse_slave(data, port_id - 1, subnode);
+
+		if (!data->gmii_sel) {
+			ret = ofnode_parse_phandle_with_args(subnode, "phys", "#phy-cells",
+							     0, 0, &args);
+			if (!ret)
+				data->gmii_sel = ofnode_get_addr(args.node);
+		}
+	}
+
+	if (!data->gmii_sel) {
+		pr_err("No port specified phys correctly\n");
+		return -ENOENT;
+	}
+
+	ofnode_for_each_subnode(subnode, dev_ofnode(dev)) {
+		const char *name = ofnode_get_name(subnode);
+
+		if (strncmp(name, "mdio", 4))
+			continue;
+
+		data->mdio_base = ofnode_get_addr(subnode);
+		if (data->mdio_base == FDT_ADDR_T_NONE) {
+			pr_err("Not able to get MDIO address space\n");
+			return -ENOENT;
+		}
+	}
+
+	return 0;
+}
+
+static int cpsw_eth_of_to_plat(struct udevice *dev)
+{
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct cpsw_platform_data *data;
+	struct gpio_desc *mode_gpios;
+	int num_mode_gpios;
+	int ret;
+	bool switch_dt_bindings =
+		ofnode_valid(ofnode_find_subnode(dev_ofnode(dev), "ethernet-ports"));
+
+	data = calloc(1, sizeof(struct cpsw_platform_data));
+	if (!data)
+		return -ENOMEM;
+
+	pdata->priv_pdata = data;
+	pdata->iobase = dev_read_addr(dev);
+	data->version = CPSW_CTRL_VERSION_2;
+	data->bd_ram_ofs = CPSW_BD_OFFSET;
+	data->ale_reg_ofs = CPSW_ALE_OFFSET;
+	data->cpdma_reg_ofs = CPSW_CPDMA_OFFSET;
+	data->mdio_div = CPSW_MDIO_DIV;
+	data->host_port_reg_ofs = CPSW_HOST_PORT_OFFSET;
+
+	pdata->phy_interface = -1;
+
+	data->cpsw_base = pdata->iobase;
+
+	num_mode_gpios = gpio_get_list_count(dev, "mode-gpios");
+	if (num_mode_gpios > 0) {
+		mode_gpios = malloc(sizeof(struct gpio_desc) * num_mode_gpios);
+		gpio_request_list_by_name(dev, "mode-gpios", mode_gpios,
+					  num_mode_gpios, GPIOD_IS_OUT);
+		free(mode_gpios);
+	}
+
+	data->active_slave = dev_read_u32_default(dev, "active_slave", 0);
+
+	if (switch_dt_bindings)
+		ret = cpsw_eth_of_to_plat_switch(dev, data);
+	else
+		ret = cpsw_eth_of_to_plat_legacy(dev, data);
+	if (ret)
+		return ret;
+
 	data->slave_data[0].slave_reg_ofs = CPSW_SLAVE0_OFFSET;
 	data->slave_data[0].sliver_reg_ofs = CPSW_SLIVER0_OFFSET;
 
@@ -1270,6 +1349,9 @@ static const struct udevice_id cpsw_eth_ids[] = {
 	{ .compatible = "ti,am335x-cpsw",		.data = (ulong)&cpsw_data_am3352 },
 	{ .compatible = "ti,am4372-cpsw",		.data = (ulong)&cpsw_data_am3352 },
 	{ .compatible = "ti,dra7-cpsw",			.data = (ulong)&cpsw_data_dra7xx },
+	{ .compatible = "ti,am335x-cpsw-switch",	.data = (ulong)&cpsw_data_am3352 },
+	{ .compatible = "ti,am4372-cpsw-switch",	.data = (ulong)&cpsw_data_am3352 },
+	{ .compatible = "ti,dra7-cpsw-switch",		.data = (ulong)&cpsw_data_dra7xx },
 	{ }
 };
 #endif

-- 
2.53.0

