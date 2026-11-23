Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64812606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 10:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nLYKkjW+;
	dkim=pass (2048-bit key, unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=ZatYL7Q5;
	dkim=pass (1024-bit key, unprotected) header.d=forwardemail.net header.i=@forwardemail.net header.a=rsa-sha256 header.s=default header.b=JlmbmOaG
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A9A460729;
	Mon, 23 Nov 2026 10:32:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jUNs4w6Neybs; Mon, 23 Nov 2026 10:32:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 953466071C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795429951;
	b=qoPhwAuQjyJA9aqswIoW94Viv+qLLQ6qgToEK/KiiIVwIYljGD9OgdWFhLeBfubwsKe3
	 QOO0iE+chLm0Zdrim95Sm1rIS8DnDTVcoDAqXCX6RDwr8UlExxPPTFT/NkDS3bDLWe5k6
	 CvH0fLMP6VwgA+t9Rm7Rhh+uC1b80NS+Y+2HU3qG7fkPQ3hx+f0F3VJ4MRyLZyZBRvIqd
	 fJg3m7W8XJ6eZ1TUWy+qEiEhehKBnNPdBIQTULB+iEeUUqSkFgGPBYswYOZKMkxpkD+db
	 IbjptbcKOroCeGLsL+DpBeRh1jjaSHV4tDoInwWccrS2yLlcyIjsZNLLfJdMYHvMZKA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795429951;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:CFBL-Feedback-ID:CFBL-Address:
	 X-Forward-Email-ID:X-Forward-Email-Sender:X-Forward-Email-Version:
	 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
	 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=CKLFAOn9Vd4cdKXHRk+6w8BX4a+VnXkDInqZoAGxHVU=;
	b=S1FZr/Cqlw8NaS5DYZ2Ve4IUVxZFwrpAdyQ1S5N1GPga+6juCUNZFeh4yYqFi9DVqznV
	 raBOcAvXBtgxMCzcnOhpgWljPiqoLbnve0P9vTQtv4BClYXRfhR/+oEjvD/WQ9Ikihy+f
	 gUfZuyNm1sCxTNjHy2tiaIC1nrGspXqr6baGhl7yAkKoWRI6bfuRuyrlMxox4n68h4KWJ
	 SSmbtp3AIMA1HVZYQHUkuNha1LuQDSLMENgTb+wnxKsDJ97b4+LQh0swW8adUISudV+6Q
	 kzKM2wABQT9634qBXc8Uic4txgBgC621ek5i/eYVNmY+HZ5l0DyqbhLIy9to0KNYFkA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795429951;
	bh=CKLFAOn9Vd4cdKXHRk+6w8BX4a+VnXkDInqZoAGxHVU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nLYKkjW+EZpqqjUhPjrrN1ERbVPU3kA3LHlrhTgL04wewzpXB+GbgmfX5Hw8ntFZO
	 b8QUyG7H/LdUbnPAZn0+6YzGtZlvC+ShrWpaf+yEe+NdorJY3smH+xyBDq/LeZ+PIw
	 GBtSqP1yJ8hm8rr/JHPwGNqm4+xxZCf3ki17Oab4cIhdRtS3GMMzxeeyfCUcnOnDl/
	 B9+Fb1KKsAmyDWyjhi+3OuOl1ZQxynAgcTQqlwS7aRcUXfRFv3b7ajEr9WaPChvwjr
	 fkWB9y9Uu37C8FBxOR1J/Q3zUTxKsKRCBXL/Msmm7DYAAKbO69dm3hUVr1u3DhjP/A
	 F+VLbKz1hF3Ag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 953466071C;
	Mon, 23 Nov 2026 10:32:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 73BAC22B
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:32:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 65A1240098
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:32:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WZeretG3oT7y for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 10:32:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4419840082
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=ac5f=jm=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=ZatYL7Q5; 
 dkim=pass (1024-bit key,
 unprotected) header.d=forwardemail.net header.i=@forwardemail.net
 header.a=rsa-sha256 header.s=default header.b=JlmbmOaG
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4419840082
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From: CFBL-Address: CFBL-Feedback-ID; q=dns/txt; s=fe-e1b5cab7be;
 t=1795429946; bh=CKLFAOn9Vd4cdKXHRk+6w8BX4a+VnXkDInqZoAGxHVU=;
 b=ZatYL7Q5+fpc7V2erP9D4hdnqA7UGuppxOfQOcIKqez9FmmkZU5HVHH3MKdNCKc+P4/SbLRVz
 NCcwGog1udhM5WlzNYHo6Xe4E7XsDpo5Pabwo/ATLy1aJYZzRLYsMnV5x9tTQXXk2o6jDE6dYHN
 ltg17VeO3+wpdu0f+p8qrZV/c8FUj2f3FROPcLMwaGro1fpn/YFldy+UN+8LfVeIQ861MHfHWwM
 h3au9Nfw4azur85TGiCmAGtf9dm+4SJFeEOWZdOpV4rAs26LKEZ+lKnvxBBwtGzIpZg90SRFrU4
 UFynE0b5zYCuyfEqt4O8oTBSEkzKbBCrI9P0l6YxgOKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=forwardemail.net;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From: CFBL-Address: CFBL-Feedback-ID; q=dns/txt; s=default;
 t=1795429946; bh=CKLFAOn9Vd4cdKXHRk+6w8BX4a+VnXkDInqZoAGxHVU=;
 b=JlmbmOaGXSC8hyBncsEbADYSvOw5CjmTNV+nR9WaYBF8GJm63VOQTi5KnODAXaCSc/XcblYYb
 61A55gTwdy73qEM6Xlpf2zsTxFRKucN+3XXyDwDf/6kM3GX6GcTpmrd/5dcMfNuOWa/5is2ILqc
 6qsmBveaT0vm9aWTkiNJKVo=
CFBL-Feedback-ID: 6b04163812d7855e0be652ca:f0b809062f1967ce7995afac282f0b4c
CFBL-Address: abuse@forwardemail.net; report=arf
X-Forward-Email-ID: 6b04163812d7855e0be652ca
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.19.37
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>, Ye Zhang <ye.zhang@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH] pinctrl: rockchip: Fix RK3506 pinctrl support
Date: Mon, 23 Nov 2026 10:32:19 +0000
Message-ID: <20261123103219.1389120-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.56.1
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The RK3506 pinctrl driver depends on a rockchip,ioc1 property not
documented in upstream dt-bindings to work, i.e. it expects the pinctrl
node to look something like following:

  pinctrl {
	rockchip,pmu = <&gpio0_ioc>;
	rockchip,ioc1 = <&gpio1_ioc>;
	rockchip,grf = <&gpio234_ioc>;

	gpio0 { };
	gpio1 { };
	gpio2 { };
  };

However, the devicetree being upstreamed to Linux for RK3506 uses
rockchip,grf phandle props in gpio0 and gpio1 controller nodes.

Change the driver to work with dt-bindings documented nodes and
properties, i.e. something like:

  pinctrl {
	rockchip,grf = <&gpio234_ioc>;

	gpio0 {
		rockchip,grf = <&gpio0_ioc>;
	};
	gpio1 {
		rockchip,grf = <&gpio1_ioc>;
	};
	gpio2 { };
  };

There are no in-tree devicetree or boards for RK3506, so this have no
expected behavior change.

Fixes: 6225eeff57ae ("pinctrl: rockchip: Add support for RK3506")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
This is based on the Linux patch [1] for SoC devicetree [2].
[1] https://patch.msgid.link/20261120201540.672016-1-jonas@kwiboo.se/
[2] https://patch.msgid.link/20261122060114.773624-3-jonas@kwiboo.se/
---
 drivers/pinctrl/rockchip/pinctrl-rk3506.c     | 46 +++++++++---------
 .../pinctrl/rockchip/pinctrl-rockchip-core.c  | 47 +++++++++++++++----
 drivers/pinctrl/rockchip/pinctrl-rockchip.h   |  2 +-
 3 files changed, 61 insertions(+), 34 deletions(-)

diff --git a/drivers/pinctrl/rockchip/pinctrl-rk3506.c b/drivers/pinctrl/rockchip/pinctrl-rk3506.c
index 969acb66f157..81f9fa7242d3 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rk3506.c
+++ b/drivers/pinctrl/rockchip/pinctrl-rk3506.c
@@ -20,14 +20,12 @@ static int rk3506_set_mux(struct rockchip_pin_bank *bank, int pin, int mux)
 	u8 bit;
 	u32 data, rmask;
 
-	if (bank->iomux[iomux_num].type & IOMUX_SOURCE_PMU)
-		regmap = priv->regmap_pmu;
+	if (bank->regmap_ioc)
+		regmap = bank->regmap_ioc;
 	else
 		regmap = priv->regmap_base;
 
-	if (bank->bank_num == 1)
-		regmap = priv->regmap_ioc1;
-	else if (bank->bank_num == 4)
+	if (bank->bank_num == 4)
 		return 0;
 
 	reg = bank->iomux[iomux_num].offset;
@@ -62,9 +60,13 @@ static int rk3506_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
 	struct rockchip_pinctrl_priv *priv = bank->priv;
 	int ret = 0;
 
+	if (bank->regmap_ioc)
+		*regmap = bank->regmap_ioc;
+	else
+		*regmap = priv->regmap_base;
+
 	switch (bank->bank_num) {
 	case 0:
-		*regmap = priv->regmap_pmu;
 		if (pin_num > 24) {
 			ret = -EINVAL;
 		} else if (pin_num < 24) {
@@ -78,7 +80,6 @@ static int rk3506_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
 		break;
 
 	case 1:
-		*regmap = priv->regmap_ioc1;
 		if (pin_num < 28)
 			*reg = RK3506_DRV_GPIO1_OFFSET;
 		else
@@ -86,7 +87,6 @@ static int rk3506_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
 		break;
 
 	case 2:
-		*regmap = priv->regmap_base;
 		if (pin_num < 17)
 			*reg = RK3506_DRV_GPIO2_OFFSET;
 		else
@@ -94,7 +94,6 @@ static int rk3506_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
 		break;
 
 	case 3:
-		*regmap = priv->regmap_base;
 		if (pin_num < 15)
 			*reg = RK3506_DRV_GPIO3_OFFSET;
 		else
@@ -102,7 +101,6 @@ static int rk3506_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
 		break;
 
 	case 4:
-		*regmap = priv->regmap_base;
 		if (pin_num < 8 || pin_num > 11) {
 			ret = -EINVAL;
 		} else {
@@ -175,9 +173,13 @@ static int rk3506_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
 	struct rockchip_pinctrl_priv *priv = bank->priv;
 	int ret = 0;
 
+	if (bank->regmap_ioc)
+		*regmap = bank->regmap_ioc;
+	else
+		*regmap = priv->regmap_base;
+
 	switch (bank->bank_num) {
 	case 0:
-		*regmap = priv->regmap_pmu;
 		if (pin_num > 24) {
 			ret = -EINVAL;
 		} else if (pin_num < 24) {
@@ -191,7 +193,6 @@ static int rk3506_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
 		break;
 
 	case 1:
-		*regmap = priv->regmap_ioc1;
 		if (pin_num < 28)
 			*reg = RK3506_PULL_GPIO1_OFFSET;
 		else
@@ -199,7 +200,6 @@ static int rk3506_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
 		break;
 
 	case 2:
-		*regmap = priv->regmap_base;
 		if (pin_num < 17)
 			*reg = RK3506_PULL_GPIO2_OFFSET;
 		else
@@ -207,7 +207,6 @@ static int rk3506_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
 		break;
 
 	case 3:
-		*regmap = priv->regmap_base;
 		if (pin_num < 15)
 			*reg = RK3506_PULL_GPIO3_OFFSET;
 		else
@@ -215,7 +214,6 @@ static int rk3506_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
 		break;
 
 	case 4:
-		*regmap = priv->regmap_base;
 		if (pin_num < 8 || pin_num > 11) {
 			ret = -EINVAL;
 		} else {
@@ -293,9 +291,13 @@ static int rk3506_calc_schmitt_reg_and_bit(struct rockchip_pin_bank *bank,
 	struct rockchip_pinctrl_priv *priv = bank->priv;
 	int ret = 0;
 
+	if (bank->regmap_ioc)
+		*regmap = bank->regmap_ioc;
+	else
+		*regmap = priv->regmap_base;
+
 	switch (bank->bank_num) {
 	case 0:
-		*regmap = priv->regmap_pmu;
 		if (pin_num > 24) {
 			ret = -EINVAL;
 		} else if (pin_num < 24) {
@@ -309,7 +311,6 @@ static int rk3506_calc_schmitt_reg_and_bit(struct rockchip_pin_bank *bank,
 		break;
 
 	case 1:
-		*regmap = priv->regmap_ioc1;
 		if (pin_num < 28)
 			*reg = RK3506_SMT_GPIO1_OFFSET;
 		else
@@ -317,7 +318,6 @@ static int rk3506_calc_schmitt_reg_and_bit(struct rockchip_pin_bank *bank,
 		break;
 
 	case 2:
-		*regmap = priv->regmap_base;
 		if (pin_num < 17)
 			*reg = RK3506_SMT_GPIO2_OFFSET;
 		else
@@ -325,7 +325,6 @@ static int rk3506_calc_schmitt_reg_and_bit(struct rockchip_pin_bank *bank,
 		break;
 
 	case 3:
-		*regmap = priv->regmap_base;
 		if (pin_num < 15)
 			*reg = RK3506_SMT_GPIO3_OFFSET;
 		else
@@ -333,7 +332,6 @@ static int rk3506_calc_schmitt_reg_and_bit(struct rockchip_pin_bank *bank,
 		break;
 
 	case 4:
-		*regmap = priv->regmap_base;
 		if (pin_num < 8 || pin_num > 11) {
 			ret = -EINVAL;
 		} else {
@@ -399,10 +397,10 @@ static struct rockchip_mux_recalced_data rk3506_mux_recalced_data[] = {
 
 static struct rockchip_pin_bank rk3506_pin_banks[] = {
 	PIN_BANK_IOMUX_FLAGS_OFFSET(0, 32, "gpio0",
-				    IOMUX_WIDTH_4BIT | IOMUX_SOURCE_PMU,
-				    IOMUX_WIDTH_4BIT | IOMUX_SOURCE_PMU,
-				    IOMUX_WIDTH_4BIT | IOMUX_SOURCE_PMU,
-				    IOMUX_8WIDTH_2BIT | IOMUX_SOURCE_PMU,
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_WIDTH_4BIT,
+				    IOMUX_8WIDTH_2BIT,
 				    0x0, 0x8, 0x10, 0x830),
 	PIN_BANK_IOMUX_FLAGS_OFFSET(1, 32, "gpio1",
 				    IOMUX_WIDTH_4BIT,
diff --git a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
index 957dcb520591..cd03a2a957c2 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
+++ b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
@@ -139,6 +139,10 @@ static int rockchip_get_mux(struct rockchip_pin_bank *bank, int pin)
 	else
 		regmap = priv->regmap_base;
 
+	/* Banks with their own IOC block use its regmap for the iomux */
+	if (bank->regmap_ioc)
+		regmap = bank->regmap_ioc;
+
 	/* get basic quadrupel of mux registers and the correct reg inside */
 	mux_type = bank->iomux[iomux_num].type;
 	reg = bank->iomux[iomux_num].offset;
@@ -642,6 +646,7 @@ int rockchip_pinctrl_probe(struct udevice *dev)
 {
 	struct rockchip_pinctrl_priv *priv = dev_get_priv(dev);
 	struct rockchip_pin_ctrl *ctrl;
+	struct udevice *child;
 
 	priv->regmap_base =
 			syscon_regmap_lookup_by_phandle(dev, "rockchip,grf");
@@ -659,15 +664,6 @@ int rockchip_pinctrl_probe(struct udevice *dev)
 		}
 	}
 
-	if (dev_read_bool(dev, "rockchip,ioc1")) {
-		priv->regmap_ioc1 =
-			syscon_regmap_lookup_by_phandle(dev, "rockchip,ioc1");
-		if (IS_ERR(priv->regmap_ioc1)) {
-			debug("unable to find rockchip,ioc1 regmap\n");
-			return PTR_ERR(priv->regmap_ioc1);
-		}
-	}
-
 	ctrl = rockchip_pinctrl_get_soc_data(dev);
 	if (!ctrl) {
 		debug("driver data not available\n");
@@ -675,5 +671,38 @@ int rockchip_pinctrl_probe(struct udevice *dev)
 	}
 
 	priv->ctrl = ctrl;
+
+	if (!IS_ENABLED(CONFIG_ROCKCHIP_RK3506))
+		return 0;
+
+	device_foreach_child(child, dev) {
+		struct rockchip_pin_bank *bank = NULL;
+		struct regmap *regmap;
+		int i, id;
+
+		if (device_get_uclass_id(child) != UCLASS_GPIO)
+			continue;
+		if (dev_read_alias_seq(child, &id))
+			continue;
+
+		regmap = syscon_regmap_lookup_by_phandle(child, "rockchip,grf");
+		if (IS_ERR(regmap)) {
+			if (PTR_ERR(regmap) == -EINVAL)
+				continue;
+			return PTR_ERR(regmap);
+		}
+
+		for (i = 0; i < ctrl->nr_banks; i++) {
+			if (ctrl->pin_banks[i].bank_num == id) {
+				bank = &ctrl->pin_banks[i];
+				break;
+			}
+		}
+		if (!bank)
+			continue;
+
+		bank->regmap_ioc = regmap;
+	}
+
 	return 0;
 }
diff --git a/drivers/pinctrl/rockchip/pinctrl-rockchip.h b/drivers/pinctrl/rockchip/pinctrl-rockchip.h
index 568e6024b78c..e8bd252105c5 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rockchip.h
+++ b/drivers/pinctrl/rockchip/pinctrl-rockchip.h
@@ -283,6 +283,7 @@ struct rockchip_pin_bank {
 	enum rockchip_pin_pull_type	pull_type[4];
 	u32				recalced_mask;
 	u32				route_mask;
+	struct regmap			*regmap_ioc;
 };
 
 #define PIN_BANK(id, pins, label)			\
@@ -528,7 +529,6 @@ struct rockchip_pinctrl_priv {
 	struct rockchip_pin_ctrl	*ctrl;
 	struct regmap			*regmap_base;
 	struct regmap			*regmap_pmu;
-	struct regmap			*regmap_ioc1;
 };
 
 extern const struct pinctrl_ops rockchip_pinctrl_ops;
-- 
2.56.1

