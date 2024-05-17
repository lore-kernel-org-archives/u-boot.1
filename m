Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39426C04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 18:16:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50E0288576;
	Fri, 17 May 2024 20:15:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="RfeIjSrr";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="hhHIjf/L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0727D88579; Fri, 17 May 2024 20:15:12 +0200 (CEST)
Received: from fhigh7-smtp.messagingengine.com
 (fhigh7-smtp.messagingengine.com [103.168.172.158])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1760688566
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 20:15:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 4AFAA11401C5;
 Fri, 17 May 2024 14:15:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Fri, 17 May 2024 14:15:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715969709;
 x=1716056109; bh=9ZWy1NTh/HyJc7gcZUQfWn6HYq1/QeutHC6wL3/DYMg=; b=
 RfeIjSrrg0tyztllIy8NKNqcKzUaf7G/4RkKINOONONqk8q/LoMsgU9fkuU5XNQ9
 5qexYebj5Att/HY4tu/9YP5j5+ji0A+otQ9ujkoqB/3aOpkYUAY0DR0qJHhmnGdc
 eoGMtF1Mq3LZBSMg37WZt6Tn00XEpmSwzt/RhzwLAwXsi6sQr15FduPOnI1nJSfB
 e9TtDzC+O3s+pLFE8ePeQeroBtG6J8HLvGNCdRmNC8Fnux5eWUm2YqQhHVEZGvLJ
 HiPsla36cKrYWtzB/qM085E93VyzlJgxSXwjExKJH5mvRJSKcG3WWsikdJDt7Vjn
 OFCS0SEX2iHZr04aTzdkJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715969709; x=
 1716056109; bh=9ZWy1NTh/HyJc7gcZUQfWn6HYq1/QeutHC6wL3/DYMg=; b=h
 hHIjf/LHGy3nseJtCHiJveFekHkMSyhepSNWiK+mFnGGfX+OPGMKqYy8QfMn0gHp
 2Orjzzubbe9cK8SjTDyI3Goe7DPbln5P6doRkzPUE36h3OGokRLkRDfTQHWpsiH+
 mteu8eFYGrMaOJOoXboNZxHy4WwGNejJuGJaJaOHBuqOamOKsadkclHaGWovTedm
 VqQWHQlNtPSU/dGN8jOPwZwVAnYKD/OQ9qwwEkM0xfVyU0p//nOK3TwkQANeQISk
 uPwmtvXT0zypnnytjWoXo34s4z7NCdaeO8z3s0JNMZuAtAFyoG0yZ/YRLfdDztXL
 GzHuBFqDInPpgJLAazp6w==
X-ME-Sender: <xms:rZ5HZhsA5f2tmhfLDivfiDxs0WnEZIv7USmUxpUMll_piAd4DL063w>
 <xme:rZ5HZqdpc6Mzs3OMFN6Wjv8oSFKpqecCvNry5oBi7TE3Ngw9z1VeZGcxvEnXBf-tu
 iL_mC8uvqU5xnRVAkY>
X-ME-Received: <xmr:rZ5HZkxeZHgG1y-CU2qfJI-4Z0bNki2C53MS-TNDR3sIfU3etC-uO7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehgedgvdelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:rZ5HZoPaZ4oI-HyTiO9yrfODESWIBGsOWiKENxQjDsHT5xOq__Ey9g>
 <xmx:rZ5HZh-AkYMSgzNhKQ7iHQF4qCyFtyj2d6whQZc5TiTwJaZgLVNvGA>
 <xmx:rZ5HZoUDij3IiqKViHEO_fvkipU49h8WZidFMIvtoZcc7gLWvJ3BzA>
 <xmx:rZ5HZiePJjoVgBK2qJUACH5hbQELCs94f_Pdm9KT5ggrK-eIKjzQMA>
 <xmx:rZ5HZoUB7GolO2qTG8izHyWqq0rWjgRshNu0SLf0cuGNiAaJ_Gj7-d8D>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 14:15:07 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 17 May 2024 19:14:57 +0100
Subject: [PATCH v3 09/12] clk: boston: Allow to get regmap from parent device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240517-boston-v3-9-1ea7d23f4a1d@flygoat.com>
References: <20240517-boston-v3-0-1ea7d23f4a1d@flygoat.com>
In-Reply-To: <20240517-boston-v3-0-1ea7d23f4a1d@flygoat.com>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Paul Burton <paulburton@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1788;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=0R/cUnDETAkdLS9IhN/57OJjLl/GYxZjffQt9HNqivk=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjT3ebMXma3cd5wpQtFua2raHndryzc/+GdPjWaM2iol7
 Oslqn+7o5SFQYyDQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACZyTJiR4cX8+oPfjJgf2WtO
 F3UUSFGsXd+Uuy5tWeib7Afa798bajAy/NlzuOvIhpak4rTQ3aYvhC8uuNa5c4/dzZ3C1+of5Tu
 48wIA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

In upstream devicetree, clk_boston is a child of syscon node
and there is no "regmap" property for clk_boston node.

Try to check parent device first to look for syscon.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
v2: Move syscon_get_regmap to probe
v3: Move syscon detection code to probe to ensure
    parent is probbed before syscon_get_regmap.
---
 drivers/clk/clk_boston.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/clk_boston.c b/drivers/clk/clk_boston.c
index 030ff7cc58ec..71e030f463e1 100644
--- a/drivers/clk/clk_boston.c
+++ b/drivers/clk/clk_boston.c
@@ -58,17 +58,21 @@ const struct clk_ops clk_boston_ops = {
 	.get_rate = clk_boston_get_rate,
 };
 
-static int clk_boston_of_to_plat(struct udevice *dev)
+static int clk_boston_probe(struct udevice *dev)
 {
 	struct clk_boston *state = dev_get_plat(dev);
 	struct udevice *syscon;
 	int err;
 
-	err = uclass_get_device_by_phandle(UCLASS_SYSCON, dev,
-					   "regmap", &syscon);
-	if (err) {
-		pr_err("unable to find syscon device\n");
-		return err;
+	if (dev->parent && device_get_uclass_id(dev->parent) == UCLASS_SYSCON) {
+		syscon = dev->parent;
+	} else {
+		err = uclass_get_device_by_phandle(UCLASS_SYSCON, dev,
+						   "regmap", &syscon);
+		if (err) {
+			pr_err("unable to find syscon device\n");
+			return err;
+		}
 	}
 
 	state->regmap = syscon_get_regmap(syscon);
@@ -91,7 +95,8 @@ U_BOOT_DRIVER(clk_boston) = {
 	.name = "boston_clock",
 	.id = UCLASS_CLK,
 	.of_match = clk_boston_match,
-	.of_to_plat = clk_boston_of_to_plat,
+	.probe = clk_boston_probe,
 	.plat_auto	= sizeof(struct clk_boston),
 	.ops = &clk_boston_ops,
+	.flags = DM_FLAG_PRE_RELOC,
 };

-- 
2.34.1

