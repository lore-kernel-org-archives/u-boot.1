Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58316C5DF67
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 01:48:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7C4634085B;
	Fri, 14 Aug 2026 01:48:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LHP5W_fOMLKj; Fri, 14 Aug 2026 01:48:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 142FB40820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786672099;
	bh=Rl/GdTzoPLzyE/w9xkQuuhGTySlAIr6D8IsQLfcsW0k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LUlVjUws5l5EoRz3AxOro6I5jOgFOhianSLSmHTN0Pj56mtm01a2TKdJiVLrWgFaU
	 maQ3YMlXUz3ez2fh5QezLWhe2zfSesHJSbk7PKVBscyVgRV8VFs+W+S5oLap9BDErw
	 DZQps5uYknP3+moeSy6H3NdCf5g0CQyXJLCI1erWAdJXQ6nLwMZaXkA2Mk0csdXxp2
	 xZZGodZal+sPi8XYAH5KGjpfdyw4VolXek/havK4kImT3bttFkoPhZzK1d1SaTCFfj
	 DO5Ntap10aODdIHNfljqrZJYMmBbY2sB93Sqvyz+8kpmjZV3+5Ob5aJkjWiGKvhutw
	 bqsyTep1eTF8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 142FB40820;
	Fri, 14 Aug 2026 01:48:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1EC58139D
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 01:48:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 07E8160633
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 01:48:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XQT8sXux5kwq for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 01:48:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0FEF560621
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0FEF560621
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=pigmoral.tech
 header.i=junhui.liu@pigmoral.tech header.a=rsa-sha256 header.s=zmail
 header.b=lv4TCB7r
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0FEF560621
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 01:48:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786672064; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=RUvFI3PUANT/YswT8d50Cx287TiYflLSPSKu9S3xl90yf/I2PPjfUG3OO72sjn/cIZkCstcJgXmurW7HWqXhY5ckaJ7qWGh68rT9Z+9OcXnK/wIRVG+HPFBJNa028Tj1JKK1O2klhmec15TitcP59s03Sp6KwgayuGM5c31PQGg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786672064;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Rl/GdTzoPLzyE/w9xkQuuhGTySlAIr6D8IsQLfcsW0k=; 
 b=EdALz7EiOADI0S/3RQNzGD+Nw98t7iqDe7mVZmIaBEZlOUVG0M6QU7lmYzyiXfw2t/SO6LBi+mefEgoP44lh/W8TDNOKstJbhcBpwwcXGOLXW4wUZ9hnyv4uUziYBXWMpQ34rZNqsWisFqKcZ2BoTLWDBpKEq/VY5lmtGEQpk1k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786672064; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=Rl/GdTzoPLzyE/w9xkQuuhGTySlAIr6D8IsQLfcsW0k=;
 b=lv4TCB7rUf4rMPpEkG8ugUCZv0JwP6c/HBHyoN2ff5r4h1qsGH6cv4rh4pFsdwLe
 LhlYCOEK69ELECcz/P+ZGZSsftxQzSRzOwIN1FM3eV5qsTX8HnFeQvlGMjdeoG2Q55z
 uFgrAJ8C7/RtutyEo8TmAkuyeQtCeOLiNYjFm/1w=
Received: by mx.zohomail.com with SMTPS id 1786672063215465.8143850541039;
 Thu, 13 Aug 2026 18:47:43 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Fri, 14 Aug 2026 09:46:56 +0800
Subject: [PATCH 1/2] i2c: k1: fix wrong bus speed setting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-k1-i2c-fix-v1-1-f2e19cbe0af6@pigmoral.tech>
References: <20260814-k1-i2c-fix-v1-0-f2e19cbe0af6@pigmoral.tech>
In-Reply-To: <20260814-k1-i2c-fix-v1-0-f2e19cbe0af6@pigmoral.tech>
To: Guodong Xu <guodong@riscstar.com>, Heiko Schocher <hs@nabladev.com>, 
 u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org
Cc: Huan Zhou <pericycle.cc@gmail.com>, 
 Guodong Xu <guodong.xu@riscstar.com>, Tom Rini <trini@konsulko.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Lukasz Majewski <lukma@denx.de>, 
 Yixun Lan <dlan@kernel.org>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1529;
 i=junhui.liu@pigmoral.tech; h=from:subject:message-id;
 bh=amnRcq8YJ796b0qEnUCktKci/Rm3J83hiJfajoKnWj8=;
 b=owGbwMvMwCWWvDb1VEXc8j+Mp9WSGLLqiletPbIwoGrOgxsCSpq7Px/47fT5HmudUx3HYc1DL
 dvT3j2b3lHKwiDGxSArpsjC5S/+z1qH59sRgdb7MHNYmUCGMHBxCsBE5D8z/JU/IXT3RVLs2tJz
 vuIvr95bJ9vK7VmVvTPgwjFZ7R0qS2QZGbYf2bT3TqZEtgD/xvI7CbO/qG48nrPx+Lfvjl9tvRM
 3TOYHAA==
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=openpgp;
 fpr=15B30CC69C4BF0CC3C08F85A2A90CDC122DF37BF
X-ZohoMailClient: External
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

The controller bus mode should be selected according to the requested
I2C bus speed. However, the driver currently passes the functional clock
rate to k1_i2c_set_bus_speed(), so the selected mode does not reflect
the requested bus speed.

Fix this by reading the clock-frequency property from the Device Tree,
defaulting to standard speed, and drop the unused clk_rate field.

Fixes: 271546fb8e54 ("i2c: k1: add I2C driver support")
Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 drivers/i2c/k1_i2c.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/k1_i2c.c b/drivers/i2c/k1_i2c.c
index a08ff15803d0..2c7a1e0d3775 100644
--- a/drivers/i2c/k1_i2c.c
+++ b/drivers/i2c/k1_i2c.c
@@ -52,7 +52,6 @@ struct k1_i2c_priv {
 	int id;
 	void __iomem *base;
 	struct clk clk;
-	u32 clk_rate;
 };
 
 /*
@@ -466,6 +465,7 @@ static int k1_i2c_probe(struct udevice *bus)
 {
 	struct k1_i2c_priv *priv = dev_get_priv(bus);
 	struct reset_ctl reset;
+	u32 speed;
 	int ret;
 
 	priv->id = dev_seq(bus);
@@ -496,10 +496,13 @@ static int k1_i2c_probe(struct udevice *bus)
 		debug("%s: failed to enable clock\n", __func__);
 		return ret;
 	}
-	priv->clk_rate = clk_get_rate(&priv->clk);
 
 	priv->base = (void *)devfdt_get_addr_ptr(bus);
-	k1_i2c_set_bus_speed(bus, priv->clk_rate);
+
+	speed = dev_read_u32_default(bus, "clock-frequency",
+				     I2C_SPEED_STANDARD_RATE);
+	k1_i2c_set_bus_speed(bus, speed);
+
 	return 0;
 }
 

-- 
2.55.0

