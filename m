Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09402C25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 11:42:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 188F188302;
	Thu, 16 May 2024 13:41:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="Ixs9yp+/";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="PLPuXsSk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90EDF8833B; Thu, 16 May 2024 13:41:03 +0200 (CEST)
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com
 [103.168.172.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3A7088345
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 13:40:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfout.nyi.internal (Postfix) with ESMTP id E22CC1380232;
 Thu, 16 May 2024 07:40:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Thu, 16 May 2024 07:40:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715859654;
 x=1715946054; bh=zj7fvgzxpWwacYUzu718y0rI4eswXoXeJQZInBlR8ro=; b=
 Ixs9yp+/eEEjIB9wUWpHDQGV3XEtuJ2y97/liQYyB10wpwEmq7XzsrpZlPc6Vnca
 02mMvjDsRr5lX6aUhQ3+YaRh6irBG1kGnU+YfD0eUptZuHkeG3iJfvvktfKHFWpm
 xGwLY9k6wnQiArsGIgd9XWkGSAiRkhlnjEWw7Jw10qp4YxmPaNdItc8xxgMxSJwo
 OK/Jc+XCwtIygyWJMBqD8ENSnrdLHdEgzlSXB8jXdoJSvEmxTPw/v6LajDBU6n2U
 YRMVIdZLWvBUz2V3lR+ZsyAjLkbjKuVs1pSVAXXlsvkK01XV6HCPTmMuWSHhii0V
 j8pQ7OzYPse0gyhfcRAKNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715859654; x=
 1715946054; bh=zj7fvgzxpWwacYUzu718y0rI4eswXoXeJQZInBlR8ro=; b=P
 LPuXsSkd9XdC8/6SXOIJFD676Def5atSjMCx7ORDo8CNNsmK3Zl7+AJ7uDIrXYA4
 Ab4Y9GpwljkVN/zcYSTLg47FmdWNIhYcfe+y6w+9zRuc6Nppa01DU1joDtQxMWTq
 Vaq2f/+ZvonYzPRuQhDNvvVQ1uADMvn06P1Gu6WzseBSfrEmEzWansl5IGI3avDH
 8DS88ljBfrwIlgq1NcUKiR/sAwMUody/8H4N0G8VGZvGEjkkRYR8CB1yX4sHovgm
 UWjZRKkDawsd36CeaIwK8/YozuyeyOk45vSPTV1M1Wdb5WnyyCT10ZlNOWpYp+My
 cuamcN0ccWHHJm2Xew+aw==
X-ME-Sender: <xms:xvBFZpQZfzqs2gO8Uu3LUmZBc1sDWiEUSaHasV2jtCNZkEUznQ8aOQ>
 <xme:xvBFZiz4fk0t3So-wVL_6nc0lQh1AxZxZ0QY1zVU4fVdBB56yOjBA59lh4mzT0dpR
 6YUkatET967dgDDWTE>
X-ME-Received: <xmr:xvBFZu2K9_nESLlC49SLwk5RGiztKy5ztczfLq0E8IGOxWYhUsn568Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehuddggeduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:xvBFZhCBlrLdgVYDxSt39Cu6ZQZTShezB49vXAR1H3vCb3qgARoMkQ>
 <xmx:xvBFZigYDVn0SmEC-fxFfqNmL-wOkEqJNQIgcIbZS_OBRV7qzpZbuw>
 <xmx:xvBFZlrVDSQYC1S6GCG7PUWcerEtXOF3FR2ANycazKo6FcBjshbqFA>
 <xmx:xvBFZthEKPVVTlHDeHbXRRH0nhcp5-JaZjZT8br3d0nRXYeFu-CUZg>
 <xmx:xvBFZnYECjlQClU9PZlqFeESa3zoMw-5ACeTpNqQoqqpJJd_kU7HANEK>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 May 2024 07:40:53 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 16 May 2024 12:40:29 +0100
Subject: [PATCH v2 09/12] clk: boston: Allow to get regmap from parent device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240516-boston-v2-9-77938800d1dd@flygoat.com>
References: <20240516-boston-v2-0-77938800d1dd@flygoat.com>
In-Reply-To: <20240516-boston-v2-0-77938800d1dd@flygoat.com>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Paul Burton <paulburton@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2236;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=3ZDqOlngL1dqLSLyCHlyIAGidSValtf0OXJJWqIFJTQ=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjTXDzt+rr0bwbU4PdORzS/C4xprZ62Iy8u7PLJm6XWyX
 +O65nd2lLIwiHEwyIopsoQIKPVtaLy44PqDrD8wc1iZQIYwcHEKwEQYfjEybH5tVGNxofvk4ysM
 ziuefZ5X6RXN5yP/6mLzrFwDf9d/xYwMr7t3p11hCUn5tbw1JbB+8/1nkroJe+pqFiXe/uNxS6C
 HDQA=
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
---
 drivers/clk/clk_boston.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/clk_boston.c b/drivers/clk/clk_boston.c
index 030ff7cc58ec..1985bb0ec334 100644
--- a/drivers/clk/clk_boston.c
+++ b/drivers/clk/clk_boston.c
@@ -12,6 +12,7 @@
 #include <linux/printk.h>
 
 struct clk_boston {
+	struct udevice *syscon;
 	struct regmap *regmap;
 };
 
@@ -58,23 +59,33 @@ const struct clk_ops clk_boston_ops = {
 	.get_rate = clk_boston_get_rate,
 };
 
-static int clk_boston_of_to_plat(struct udevice *dev)
+static int clk_boston_probe(struct udevice *dev)
 {
 	struct clk_boston *state = dev_get_plat(dev);
-	struct udevice *syscon;
-	int err;
 
-	err = uclass_get_device_by_phandle(UCLASS_SYSCON, dev,
-					   "regmap", &syscon);
-	if (err) {
-		pr_err("unable to find syscon device\n");
-		return err;
+	state->regmap = syscon_get_regmap(state->syscon);
+	if (IS_ERR(state->regmap)) {
+		pr_err("unable to find regmap\n");
+		return PTR_ERR(state->regmap);
 	}
 
-	state->regmap = syscon_get_regmap(syscon);
-	if (!state->regmap) {
-		pr_err("unable to find regmap\n");
-		return -ENODEV;
+	return 0;
+}
+
+static int clk_boston_of_to_plat(struct udevice *dev)
+{
+	struct clk_boston *state = dev_get_plat(dev);
+	int err;
+
+	if (dev->parent && device_get_uclass_id(dev->parent) == UCLASS_SYSCON) {
+		state->syscon = dev->parent;
+	} else {
+		err = uclass_get_device_by_phandle(UCLASS_SYSCON, dev,
+						   "regmap", &state->syscon);
+		if (err) {
+			pr_err("unable to find syscon device\n");
+			return err;
+		}
 	}
 
 	return 0;
@@ -92,6 +103,8 @@ U_BOOT_DRIVER(clk_boston) = {
 	.id = UCLASS_CLK,
 	.of_match = clk_boston_match,
 	.of_to_plat = clk_boston_of_to_plat,
+	.probe = clk_boston_probe,
 	.plat_auto	= sizeof(struct clk_boston),
 	.ops = &clk_boston_ops,
+	.flags = DM_FLAG_PRE_RELOC,
 };

-- 
2.34.1

