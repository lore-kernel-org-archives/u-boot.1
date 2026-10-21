Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30BF606A31A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 12:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=G+gaVFZY
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 60DC660888;
	Wed, 21 Oct 2026 12:45:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iqxDGliNAtvr; Wed, 21 Oct 2026 12:45:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0FA7260865
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792586748;
	b=pB50Ki1110hANVG6I3+O5VunSlG8SyodXYr8FCxrlUflIhp2HL+WiKcoRVVAdEUCojzR
	 49EdoMjfSNjIkDR+TCt63u2eUfX2XlU653XSxGT5knCHYYu1lIr93hixGgANVnd1sWFMk
	 uTXqhcFbGUKY0rby3vRCPocGn8tKYoYuU/wDu4kZQ1a+M8fxe6RrXNlWBfYuvshEmwPwV
	 B7gJ9UhCKd1Io2I0iWygRQ8AH0Drzmjf8Pu0wl+GEBj5oQQJr9VFwtC09Mreyw3Iv/Hxe
	 gqlykU5pER+k6iuuiFd6olxAl9dVLI773rSQAzF1shmuUSckBoQroUrcQgLR8n2Vn2A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792586748;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-ID:References:In-Reply-To:To:CC:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=a5imePXiFeNAqyWJIdfZ7BrrPMRNqxByhYvpH3JkOMA=;
	b=Jrd9v7zGAA1eUSYx00PVySzFWIG7izK9Xr8GzxAApwpKbdhG2N8emV6/qnBDnmi1OEkR
	 mtd4bb/9l++OUggKMhC1GhZTpTnIkvRJ4/EDbgCHj/Q1cj4eDCPFQIWdaYd5HqybgXnJ1
	 SccMc0eRBm/NHm6F0diRLbkwqevQbAD5Ept1Nnd3WEntprpYaPJLfghv5V3o/1/224OdZ
	 LvwSIPwNdRun/mexo6SJpDeKd0dElFVOHmSXgudy+G2cHaajwgld9vtl0kP/nw0LSLbjn
	 Bj5fKigjzZAWoZvPwMh5JOpWFOhNk3c3GfItphubAMTeuycxvOYnGR+zrwuoA83txAQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792586748;
	bh=a5imePXiFeNAqyWJIdfZ7BrrPMRNqxByhYvpH3JkOMA=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G+gaVFZYkdpU93zCKG8jdr5TNJr5mcL4JbwPWn3vmzRe1G4SBrJdPmzJY4mwsqa+3
	 4LMFpX65X465AhvpQTtQILBuM+2jN/TuqyADH0KPOCSKcPQ8VXYkJDQvy0vN54XoZt
	 5//hqIp+9Ce4G0iYdBnk9salQNi+RSUUh5jcjXSwqwA2CfyVdLZwpUOcgHuSyBKJom
	 kh3uyvim+usVhkEXv2x0B99ICBGe/rn12ivjx93VoV8QRGQ5XIfb5P8kocoX7syJhZ
	 xyIkfm7CxmCz+ykIgga4dLvKtdeVBQezY/t7I5zwsKvc+QWHiNxEBw3iH9QdsR5pyS
	 JxDghJ+8PgCPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0FA7260865;
	Wed, 21 Oct 2026 12:45:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 17D83930
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:39:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 09BFC405B3
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:39:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G36pWjrzoBUo for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 06:39:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 72FEB4060C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792564760;
 b=XDF5dWffh0PrTVXxhuFn8sZRQSJFaV/q6GrJJCxqlAJHNF7VTFY0mSi1p1rNy15iwHcs
 11GKlFO6lIQuWYSSPrtf2cUy2W35N8tgUhOtn/yeXzAXi2PD5GU7Rn+IT/MFcfIARJ2UW
 iEymsUpTw32qVPV9sejQyKlKKF0aR9CIB1DostOselP9/EnqAWYT1+oRh5dY9/MpCIgCE
 KAl/as02SjPAkjwZPSmNRqv35PmE6+uJ8oDA74xdI2Bt0NJ1Gs976UYv13ixysdkhlrMb
 DtXwGNNDtviWlcfxjiGPN0VtitWfwnhvELGoF9UrXS7UiaWTxe9xw3OUn6J8U9nSy5A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792564760;
 h=Received-SPF:Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-ID:References:
 In-Reply-To:To:CC:X-Mailer:X-Developer-Signature:X-Developer-Key;
 bh=a5imePXiFeNAqyWJIdfZ7BrrPMRNqxByhYvpH3JkOMA=;
 b=iyuft5KzSPrLW4lTr38oa7VxQOYMewepv8Q7mb8xk2At1Pl9yYgJrErkLaVETmXWh4Ox
 i634IyMBi65H+kUvGM38gVwk0h4myYz1p9PePdL8C9Mq9h4wU33UiRhMyaJF5C16IVaHn
 GoDWvCBSyeivT93+SxNvTlH36xwdhW24tMVinw+Ymc13hHbE5uMQTlHcKH8K3dQmadnzx
 8XhGKq/Ntqf1sqMJdh7sz1u3OaOtgH+b+TdkRT2fkwBR33IHft7TwW6y1cT/bqHF+figL
 GDBs//YfgVurdSjO+Xz2X6Y5ckyoWJCq6IGwyc4kfN5RkYNV6suMh6B4i3Wr+F0uAkg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=aspeedtech.com;
 arc=none smtp.remote-ip=211.20.114.72
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=211.20.114.72;
 helo=twmbx01.aspeedtech.com; envelope-from=jacky_chou@aspeedtech.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=aspeedtech.com
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 72FEB4060C
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:39:19 +0000 (UTC)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 21 Oct
 2026 14:34:10 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 21 Oct 2026 14:34:10 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Wed, 21 Oct 2026 14:34:05 +0800
Subject: [PATCH 2/6] net: ftgmac100: Add RGMII delay support for AST2700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261021-ftgmac-rgmii-delay-v1-2-fce405523118@aspeedtech.com>
References: <20261021-ftgmac-rgmii-delay-v1-0-fce405523118@aspeedtech.com>
In-Reply-To: <20261021-ftgmac-rgmii-delay-v1-0-fce405523118@aspeedtech.com>
To: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 <u-boot@lists.u-boot-project.org>
CC: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini
 <trini@konsulko.com>, Ryan Chen <ryan_chen@aspeedtech.com>, Chia-Wei Wang
 <chiawei_wang@aspeedtech.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 David Lechner <dlechner@baylibre.com>, Julien Stephan
 <jstephan@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, Peter Robinson
 <pbrobinson@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Jacky Chou" <jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792564449; l=5301;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=/B6UaW9Z9JEmAPBM6ytRA4AOY2Y3JWUIx56vdWjcvLQ=;
 b=fpNSXhdkwEkq33oo8XHBhO8DepA2OtGnhEMjMqqoANVdVAZIz19w6d5unGSOIYJ0Ul2JV0k+x
 hqVjd+gdjHHDpRe3GCHPdtLhRz2nyEcNYLM7GeZYTkui2Wshs6FaK0C
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=
X-Mailman-Approved-At: Wed, 21 Oct 2026 12:45:42 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Introduce RGMII delay configuration for AST2700, mirroring the AST2600
support added in the previous commit. The delay unit and the "disabled
delay" offset are read from SCU registers instead of being fixed
constants, since they can differ between TX and RX. MAC2 only supports
SGMII, so it has no RGMII delay to configure.

While at it, use dev_get_driver_data(dev) == FTGMAC100_MODEL_ASPEED_AST2700
instead of the priv->is_ast2700 flag, since the flag was redundant with
the model already available via the driver's compatible match data.
This lets the two branches in ftgmac100_of_to_plat() that set up the
same rxdes0_edorr_mask/txdes0_edotr_mask be merged.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ftgmac100.c | 78 +++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ftgmac100.h | 16 ++++++++++
 2 files changed, 94 insertions(+)

diff --git a/drivers/net/ftgmac100.c b/drivers/net/ftgmac100.c
index 4b3386be3d5..5e74f976999 100644
--- a/drivers/net/ftgmac100.c
+++ b/drivers/net/ftgmac100.c
@@ -701,6 +701,82 @@ static int ftgmac100_set_ast2600_rgmii_delay(struct udevice *dev)
 				   tx_delay_index | rx_delay_index);
 }
 
+static int ftgmac100_set_ast2700_rgmii_delay(struct udevice *dev)
+{
+	struct ftgmac100_data *priv = dev_get_priv(dev);
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	u32 rgmii_delay_tx_unit, rgmii_delay_rx_unit;
+	u32 rgmii_delay_tx_dis, rgmii_delay_rx_dis;
+	u32 tx_delay_index, rx_delay_index;
+	u32 reg_unit, reg_val;
+	struct regmap *scu;
+	int dly_mask;
+	int mac_id;
+
+	scu = syscon_regmap_lookup_by_phandle(dev, "aspeed,scu");
+	if (IS_ERR(scu))
+		return PTR_ERR(scu);
+
+	switch (pdata->iobase) {
+	case AST2700_MAC0_BASE_ADDR:
+		mac_id = 0;
+		regmap_read(scu, AST2700_MAC0_DLY_UNIT, &reg_unit);
+		regmap_read(scu, AST2700_MAC0_DLY_VAL, &reg_val);
+		break;
+	case AST2700_MAC1_BASE_ADDR:
+		mac_id = 1;
+		regmap_read(scu, AST2700_MAC1_DLY_UNIT, &reg_unit);
+		regmap_read(scu, AST2700_MAC1_DLY_VAL, &reg_val);
+		break;
+	case AST2700_MAC2_BASE_ADDR:
+		/* MAC2 only supports SGMII, no RGMII delay to configure */
+		return 0;
+	default:
+		dev_err(dev, "Invalid mac base address\n");
+		return -EINVAL;
+	}
+
+	rgmii_delay_tx_unit = AST2700_MAC_TX_DLY_UNIT(reg_unit);
+	rgmii_delay_rx_unit = AST2700_MAC_RX_DLY_UNIT(reg_unit);
+	rgmii_delay_tx_dis = AST2700_MAC_TX_DLY_DIS(reg_val);
+	rgmii_delay_rx_dis = AST2700_MAC_RX_DLY_DIS(reg_val);
+
+	tx_delay_index = DIV_ROUND_CLOSEST(priv->rgmii_tx_delay,
+					   rgmii_delay_tx_unit);
+	tx_delay_index += rgmii_delay_tx_dis;
+	if (tx_delay_index >= 32) {
+		dev_err(dev, "The %u ps of TX delay is out of range\n",
+			priv->rgmii_tx_delay);
+		return -EINVAL;
+	}
+
+	rx_delay_index = DIV_ROUND_CLOSEST(priv->rgmii_rx_delay,
+					   rgmii_delay_rx_unit);
+	rx_delay_index += rgmii_delay_rx_dis;
+	if (rx_delay_index >= 32) {
+		dev_err(dev, "The %u ps of RX delay is out of range\n",
+			priv->rgmii_rx_delay);
+		return -EINVAL;
+	}
+
+	if (mac_id == 0) {
+		dly_mask = ASPEED_MAC0_2_TX_DLY | ASPEED_MAC0_2_RX_DLY;
+		tx_delay_index = FIELD_PREP(ASPEED_MAC0_2_TX_DLY,
+					    tx_delay_index);
+		rx_delay_index = FIELD_PREP(ASPEED_MAC0_2_RX_DLY,
+					    rx_delay_index);
+	} else {
+		dly_mask = ASPEED_MAC1_3_TX_DLY | ASPEED_MAC1_3_RX_DLY;
+		tx_delay_index = FIELD_PREP(ASPEED_MAC1_3_TX_DLY,
+					    tx_delay_index);
+		rx_delay_index = FIELD_PREP(ASPEED_MAC1_3_RX_DLY,
+					    rx_delay_index);
+	}
+
+	return regmap_update_bits(scu, AST2700_MAC01_CLK_DLY, dly_mask,
+				   tx_delay_index | rx_delay_index);
+}
+
 static int ftgmac100_set_internal_delay(struct udevice *dev)
 {
 	struct ftgmac100_data *priv = dev_get_priv(dev);
@@ -715,6 +791,8 @@ static int ftgmac100_set_internal_delay(struct udevice *dev)
 
 	if (data == FTGMAC100_MODEL_ASPEED_AST2600)
 		return ftgmac100_set_ast2600_rgmii_delay(dev);
+	else if (data == FTGMAC100_MODEL_ASPEED_AST2700)
+		return ftgmac100_set_ast2700_rgmii_delay(dev);
 
 	return 0;
 }
diff --git a/drivers/net/ftgmac100.h b/drivers/net/ftgmac100.h
index 6e00282e2a1..9b9c1e826ac 100644
--- a/drivers/net/ftgmac100.h
+++ b/drivers/net/ftgmac100.h
@@ -13,6 +13,7 @@
 #define __FTGMAC100_H
 
 /* The registers offset table of ftgmac100 */
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 struct ftgmac100 {
 	unsigned int	isr;		/* 0x00 */
@@ -270,4 +271,19 @@ struct ftgmac100_rxdes {
 #define AST2600_MAC2_BASE_ADDR		0x1e670000
 #define AST2600_MAC3_BASE_ADDR		0x1e690000
 
+/* Aspeed SCU RGMII delay settings, AST2700 */
+#define AST2700_MAC0_DLY_UNIT		0x190
+#define AST2700_MAC0_DLY_VAL		0x194
+#define AST2700_MAC1_DLY_UNIT		0x198
+#define AST2700_MAC1_DLY_VAL		0x19c
+#define AST2700_MAC_TX_DLY_UNIT(x)	FIELD_GET(GENMASK(15, 0), (x))
+#define AST2700_MAC_RX_DLY_UNIT(x)	FIELD_GET(GENMASK(31, 16), (x))
+#define AST2700_MAC_TX_DLY_DIS(x)	FIELD_GET(GENMASK(7, 0), (x))
+#define AST2700_MAC_RX_DLY_DIS(x)	FIELD_GET(GENMASK(23, 16), (x))
+#define AST2700_MAC01_CLK_DLY		0x390
+
+#define AST2700_MAC0_BASE_ADDR		0x14050000
+#define AST2700_MAC1_BASE_ADDR		0x14060000
+#define AST2700_MAC2_BASE_ADDR		0x14070000
+
 #endif /* __FTGMAC100_H */

-- 
2.34.1

