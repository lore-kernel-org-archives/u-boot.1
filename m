Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8DB4CA5FF0
	for <u-boot@archiver.kernel.org>; Sun,  4 Oct 2026 22:13:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EFA8B80D74;
	Sun,  4 Oct 2026 22:13:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G8FrNfawfzIn; Sun,  4 Oct 2026 22:13:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9ED8C80DA4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791152001;
	b=kmYTVZ4Ds62kxd5u0ZBX9AMlBhpg2rioh3UXbI3jutUDyvnksKW2ICou00Nf2fiDGMsT
	 9m/RAV6MCsHsvNgV0fB/kbAqeBhcPHb68hMCvoMqupa7r8B0wxY693UY2mJJuiyq2yCaC
	 f9KpHD57lF45nVXVYBdM+pVDQDb67n2ix3pO/mC9uBzcd184ZIFNinOpyuSk2jawpdAFV
	 RAk1sI5uIJIt47CziV697G35+vL1AjU1axmiawEUFSmH+SHELT5Tt3aABBoLAHxdvtNiL
	 1d8j99uHi/zNj9CkiT023+g+EIOxBwKkzV4r+kgzZBQnBBLXXVJutwvNxbbYl7IGmOA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791152001;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=wnP2BNL8MtPyJz8qAYrqioqo9kUhGOW4Txr1CVvaMtU=;
	b=C9sFUmNslJq3PDYvtfox7G8tHyrztwQ3TNY1GiDzgQEg4nVdp7rf+w8HgdTQ4c1Gzm7D
	 VS3+VFPQp71/O8OnPweMeGJs+PjQWStpXpB5JMeIA9nq4WKG3QCBGramHHMdl3R4fXtS9
	 LuozVXvUSUNisIqwytkdJ6rJ+T8iSy7CJ8zBPS61jmVx9BL6BnP0nyAlB9LsP6nCW7bB9
	 HQzVvUuWhz/UTxt6mdi6gzo5VwzyuMihFHgSfLjicHJOiRmP2ckegLUYdycbiXfcPtuf2
	 goweKWJNCKS+7ks/of+/a7XspDDxHmR5hcFIsdVdmAS+A70KCJEqoCwA63lmQeeXRGg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791152001;
	bh=wnP2BNL8MtPyJz8qAYrqioqo9kUhGOW4Txr1CVvaMtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gX4NLMhJ3h0iJ0WmtTF8KJKs5p3TUoVor4KRtsOF5utQGUk9fsfHCbPkU3fL+bMZi
	 v2rsC2Qc/SZOOqYXINgokB5v8lOMVNz6qgM0jWoOod+5TVHm0DXCOHD0uLdV2cGTq1
	 S7n2x+c3NuQyrW8pnIvNBX4ye31zSL9aHKZgoT2jOvB8foWKNHNqUqrVie/S8Qa0dP
	 nHNow/VBy0EECNNwJAC96y1eFE2/ZDxSMc/W7ZuFFw/vBJxZ/NsGQzXiOHih8ideI8
	 E/6MQQ6rJyZn6AgaAh1k8BIWJRXfhV0+Rn5UeyaoKifDc/xUADanowhZeydylKBlLz
	 zr1r6AHCXqXFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9ED8C80DA4;
	Sun,  4 Oct 2026 22:13:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 49A5B435
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 22:13:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 146D240004
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 22:13:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tYqkwlRr2bLa for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 22:13:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 37C164007E
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791151996;
 b=VQKAIRs0sj5i+R4zQvS7yI+2nwVAfQMludrCGJGAQunhVW7wJc4Qf2y7gghtwOd6R/ec
 IehTOED+LcfROuxEIyCa7aF9h9uXrH+Aqz3qCpEX+GtvQ8NBSiQ7XjjYcV08LMBXtVkI3
 hd+K9IE8JSgctkkpMfbs5JFBWBpK3pqIeMittVIn99DUFyp7G4uHGWY/kZCnNmNPPt5Pe
 1q1hTek5riGzcLCiBi77tmU+tPvnJxEvww+Hyu2HU+K9yE/APtwZ0pOuCbb2o0yYzkS5k
 CX7vbxs5MOY7k8U1jxw/J+1T8gJRY/xeFxvf64D/Y31UpLdcPHdRGoch2yavI0lgC5w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791151996;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=wnP2BNL8MtPyJz8qAYrqioqo9kUhGOW4Txr1CVvaMtU=;
 b=gcj/5ob8EsBr3aNi1PddQRRLc2gOlyj7hOuJRVXLTaYt1Cex41PHmF4prG9RqMOs9SNA
 dQ/KbOekbIi7+t1oElGW22JBq31IjLp9BUTWGZ0cD8FOFCw5MEpgobL5bQAeC7/+5ftGs
 vAvjJjcKgVGAU9hqgthjFs/e+WJLv5pYk/th2DbpYI31ZYta1jg/qBU4j2cRCBYCiMrQK
 UTXKfwL+NuuoT7xBxSr9aa+B0GW47VwA1ROkPwV4tyxnotW3VORfVXtqqTvVbYItuX/US
 AYt4dWWQKg1RIKXyig1cz84tbd8AG2M5ZcnjA1Fou095CyT3mGj5Y0lYNLW9B8I8QXA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kwiboo.se; 
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=SDnzywUU; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=8573=h3=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=SDnzywUU
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 37C164007E
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 22:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791151995; bh=wnP2BNL8MtPyJz8qAYrqioqo9kUhGOW4Txr1CVvaMtU=;
 b=SDnzywUUGUcfmLvvW9g/Yw4bflHaNULgYrbtFWgd423MP0LNHw6FArAlNA0o9kYmCDFObd15+
 ic1YeO6aIkGGUb+vCJDruXkiH/XkORE/YOTLgpvkVEvr1ZEX5h4xqgOwOkrtmTnBF5zbKGKS4SE
 Tq4+RXmJwu7AS87yAyGdE/JR6541WYaF2AtmErGHkNyTVITQDLvXUlTR89fgh2t1kThA6cVqGxu
 AfzLR88Y5Ru0AFjj3WQdCVDea5marnuCGlXzBFuTr6ztgYS3vSF4vyk4FkLTFt3T5tlrhzPBGuM
 GxM+Ir99aR7i/Y3Pvx3kOVIdwQINIpF5rDojodDBf3og==
X-Forward-Email-ID: 6ac2cf79ab896cf9f2e4282d
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.18.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 2/2] net: dwc_eth_qos_rockchip: Do not keep reset controls
 asserted
Date: Sun,  4 Oct 2026 22:13:05 +0000
Message-ID: <20261004221306.67476-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261004221306.67476-1-jonas@kwiboo.se>
References: <20261004221306.67476-1-jonas@kwiboo.se>
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

Communication with Ethernet PHYs over MDIO does not work when reset
controls are held in asserted state. This prevents i.e. the mdio/mii
commands from working, unless the network stack is in running state.

Change to only assert the reset controls for a short period when the
network stack is starting to allow for the mdio/mii commands to work.

With reset controls held asserted (before):

  => mdio read 1
  PHY at address 1:
  1 - 0x0

  => mii info
  PHY 0x00: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
  [...]
  PHY 0x1F: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX

With reset controls not helt asserted (after):

  => mdio read 1
  PHY at address 1:
  1 - 0x7989

  => mii info
  PHY 0x00: OUI = 0x0732, Model = 0x11, Rev = 0x06,  10baseT, HDX
  PHY 0x01: OUI = 0x0732, Model = 0x11, Rev = 0x06,  10baseT, HDX

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/net/dwc_eth_qos_rockchip.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/net/dwc_eth_qos_rockchip.c b/drivers/net/dwc_eth_qos_rockchip.c
index 04bc6006bc3c..78623ed78fb0 100644
--- a/drivers/net/dwc_eth_qos_rockchip.c
+++ b/drivers/net/dwc_eth_qos_rockchip.c
@@ -747,8 +747,6 @@ static int eqos_probe_resources_rk(struct udevice *dev)
 	if (ret && ret != -ENOENT && ret != -ENOTSUPP)
 		goto err_free;
 
-	reset_assert_bulk(&data->resets);
-
 	ret = clk_get_by_name(dev, "stmmaceth", &eqos->clk_master_bus);
 	if (ret) {
 		dev_dbg(dev, "clk_get_by_name(stmmaceth) failed: %d", ret);
@@ -803,18 +801,17 @@ static int eqos_remove_resources_rk(struct udevice *dev)
 	return 0;
 }
 
-static int eqos_stop_resets_rk(struct udevice *dev)
+static int eqos_start_resets_rk(struct udevice *dev)
 {
 	struct eth_pdata *pdata = dev_get_plat(dev);
 	struct rockchip_platform_data *data = pdata->priv_pdata;
+	int ret;
 
-	return reset_assert_bulk(&data->resets);
-}
+	ret = reset_assert_bulk(&data->resets);
+	if (ret)
+		return ret;
 
-static int eqos_start_resets_rk(struct udevice *dev)
-{
-	struct eth_pdata *pdata = dev_get_plat(dev);
-	struct rockchip_platform_data *data = pdata->priv_pdata;
+	udelay(10);
 
 	return reset_deassert_bulk(&data->resets);
 }
@@ -891,7 +888,7 @@ static struct eqos_ops eqos_rockchip_ops = {
 	.eqos_flush_buffer = eqos_flush_buffer_generic,
 	.eqos_probe_resources = eqos_probe_resources_rk,
 	.eqos_remove_resources = eqos_remove_resources_rk,
-	.eqos_stop_resets = eqos_stop_resets_rk,
+	.eqos_stop_resets = eqos_null_ops,
 	.eqos_start_resets = eqos_start_resets_rk,
 	.eqos_stop_clks = eqos_stop_clks_rk,
 	.eqos_start_clks = eqos_start_clks_rk,
-- 
2.55.0

