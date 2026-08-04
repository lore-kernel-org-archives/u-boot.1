Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE65C55182
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 00:27:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3395A80C50;
	Tue,  4 Aug 2026 00:27:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RbNnV1aZv8B6; Tue,  4 Aug 2026 00:27:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 64DFD80C69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785803224;
	bh=+hbJQSXEurmekrlfj5FxlcqEClRRD9m1s11uSLCpnXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=03J1b7QFISA+xEmIle1IndToMO2bHzUiTaydDYxLO+QXWjxvXvvlfhz9EmxboT4I2
	 GLo9t1QzJ0Uh65RWP2kYVFaKkPDXckrMp9gHIR9AnjHKxp1ubtndOoDy30CP7lD8bQ
	 bMGz7b0etZWeulm4zyJfTx9zQycTgR62vAL7boJYJozGl4KysLP/NV4OiYKQy8cdhl
	 iY5VSl+vo+dLFfzmugVHn9kkLcgRBTV280wOMKFxOcE1pu14nQ6zFSeMYWAhL5V/T+
	 N8hkmh6DCEBxBAqM7mGDfRCBBTzLt6Sw3syij+xiXiF47TFhGpzcV5MpjXpyKi0pJR
	 PSqWJ6YTGkvnw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 64DFD80C69;
	Tue,  4 Aug 2026 00:27:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 43028194
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:27:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 29966400A5
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:27:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fov6Eb4Sjc-s for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 00:26:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=eb25=f5=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0F2ED400B4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0F2ED400B4
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0F2ED400B4
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:26:58 +0000 (UTC)
X-Forward-Email-ID: 6a7131ca3f1ab8deaeb03dd3
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.13.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: Alexey Charkov <alchark@flipper.net>, u-boot@lists.u-boot-project.org,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 2/4] clk: rockchip: rk3588: Always init clocks in SPL build
Date: Tue,  4 Aug 2026 00:26:40 +0000
Message-ID: <20260804002643.2308515-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260804002643.2308515-1-jonas@kwiboo.se>
References: <20260804002643.2308515-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785803217; bh=+hbJQSXEurmekrlfj5FxlcqEClRRD9m1s11uSLCpnXo=;
 b=PH6DwnIFpv5Pj6pzErhy7eZRHYnExgZxUhILflobBpmUxXzWdasAKwdt9eTuS9otoHNJaVCSc
 j43mNBlbSS5rYN/sLvT3ZJFdeNystAEQeB6NNlMVn+DxqIzrG+IiC9hjmdja8VALLdrvclpI7az
 8dFPPZrhTedOIm4LIhyWOBhUBmOTu8EGt/jo5bt59R+w+Kzhf2blyXjnMLmBKPkDJagwikWP4US
 9nBf8H3NTNm6dUz8bUbb8NJWRhk829H2d/7kFAuhdgxFf3Ty/sIuHV4Xjez1s3cdVxGGf1GOyD1
 1kBnD7hdiRjLqxATIlbjnKR+i6X0f7XGQE2MkT5Qxz2A==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=PH6DwnIF
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The CPU PLLs and SPLL are only initialized in SPL on RK3588.

Ensure clock driver is always probed after bind for SPL builds to
initialize core PLLs and clocks in SPL phase on RK3588.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/clk/rockchip/clk_rk3588.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
index 5236c3fa985e..5313457aec92 100644
--- a/drivers/clk/rockchip/clk_rk3588.c
+++ b/drivers/clk/rockchip/clk_rk3588.c
@@ -2004,6 +2004,10 @@ static int rk3588_clk_bind(struct udevice *dev)
 	struct udevice *sys_child;
 	struct sysreset_reg *priv;
 
+	/* Ensure clocks are initialized after bind in SPL build */
+	if (IS_ENABLED(CONFIG_SPL_BUILD))
+		dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
+
 	/* The reset driver does not have a device node, so bind it here */
 	ret = device_bind_driver(dev, "rockchip_sysreset", "sysreset",
 				 &sys_child);
@@ -2133,6 +2137,15 @@ static int rk3588_scru_clk_probe(struct udevice *dev)
 	return 0;
 }
 
+static int rk3588_scru_clk_bind(struct udevice *dev)
+{
+	/* Ensure clocks are initialized after bind in SPL build */
+	if (IS_ENABLED(CONFIG_SPL_BUILD))
+		dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
+
+	return 0;
+}
+
 static const struct clk_ops rk3588_scru_clk_ops = {
 	.get_rate = rk3588_scru_clk_get_rate,
 	.set_rate = rk3588_scru_clk_set_rate,
@@ -2142,6 +2155,7 @@ U_BOOT_DRIVER(rockchip_rk3588_scru) = {
 	.name	= "rockchip_rk3588_scru",
 	.id	= UCLASS_CLK,
 	.ops	= &rk3588_scru_clk_ops,
+	.bind	= rk3588_scru_clk_bind,
 	.probe	= rk3588_scru_clk_probe,
 };
 
-- 
2.54.0

