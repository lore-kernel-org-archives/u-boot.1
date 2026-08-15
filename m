Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6274DC5AD5A
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 03:42:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 23E9D60DE8;
	Sat, 15 Aug 2026 03:42:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qvgpujWtFF6H; Sat, 15 Aug 2026 03:42:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0135960DD8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786765336;
	bh=oKwd+Iyx4rMeSTrD4QipHl0HVWzoAi8gQKBQ6DMcK4g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UZi/+1LQf5k03DmvgkiiQV6A5FQTuK8Fpc7DK+3m2fpOxUjGjA9Q21P2WPB644n8x
	 WbUanlsheDgnaKh37T1fIc/9bBDOQdf/LnBGAonb5pp2qHH52tXMcJAUic5OaPjKut
	 tQrGJffW9aJLktlvVEmh75aIIWhU0IxNsULNzKE9o2y8o3py6ajF9KUzI05bYcmLRP
	 OaAvN+9XYzYF39xzTkVjgkKeI/YQ0A1wl4YCMdeA3WJXNLjXs10cXaJ4+H0GlaEjql
	 T7dBdRV752HnJ5at2KKB6naL1n5ccRYFuqVT6+b6mvnT6QOSfB7R/RmjBgQt/BXBsH
	 ojNhb/a8Ur3Vw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0135960DD8;
	Sat, 15 Aug 2026 03:42:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 188AE361
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 03:42:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 07C828134C
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 03:42:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jK4bq2oD4n-0 for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 03:42:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0E4BA8134A
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0E4BA8134A
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=pigmoral.tech
 header.i=junhui.liu@pigmoral.tech header.a=rsa-sha256 header.s=zmail
 header.b=rxcr3UCb
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0E4BA8134A
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 03:42:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786765306; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=b+Q351Gz2S5vc4PwiqeR1puI7YiR2q6rA36pbYnGygmjgaS/LifAthI+mEb6YVdNe5WzDbLfNHtTp0bTmSu1XuCkwc041FqPkViR52jhgnMV2AIVwB+k7xXvnZgIqdOtL19Nh2nMdvjVjNW0ayyXWpu07mgONaOoo5O5rBz8Ov4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786765306;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=oKwd+Iyx4rMeSTrD4QipHl0HVWzoAi8gQKBQ6DMcK4g=; 
 b=i+0EyVtzFVfkubX/q7X+CrGEb+VztGTv5SWIPWsdJxJZSyxNWtT4OWBXOdAZes0UK/nuXTgQoPEflTuPV8Tr81HqZWxYARA1j9+xyBKuuiiMsgLB6KWECkntt5LL1ewG6gRzbtUrmw3esKYFSdkXlhrQdTzBiC7pe9BnD0XvuxI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786765305; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=oKwd+Iyx4rMeSTrD4QipHl0HVWzoAi8gQKBQ6DMcK4g=;
 b=rxcr3UCboX4mWKgqeIpiIawzGgbk9iSAOMfBn/HfWMDI2V4ZCHLdaLfPwsWkZUxX
 lF2ajLj/c65ejbR8RWyFfev86Mh7Rqu9P6oon4EDk6zA7s2N2Fmm5gvAgk4M+WpZ+TX
 QsPRTh5d/sDuSbqUzLn+t7ldHcahyo56M3b1xbH4=
Received: by mx.zohomail.com with SMTPS id 1786765303393514.1950850065575;
 Fri, 14 Aug 2026 20:41:43 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Sat, 15 Aug 2026 11:40:23 +0800
Subject: [PATCH v2 3/4] i2c: k1: enable both functional and bus clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260815-k1-i2c-fix-v2-3-7d2a48607233@pigmoral.tech>
References: <20260815-k1-i2c-fix-v2-0-7d2a48607233@pigmoral.tech>
In-Reply-To: <20260815-k1-i2c-fix-v2-0-7d2a48607233@pigmoral.tech>
To: Heiko Schocher <hs@nabladev.com>, u-boot-spacemit@groups.io, 
 u-boot@lists.u-boot-project.org
Cc: Huan Zhou <pericycle.cc@gmail.com>, 
 Guodong Xu <guodong.xu@oss.qualcomm.com>, Tom Rini <trini@konsulko.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Raymond Mao <raymond.mao@riscstar.com>, Lukasz Majewski <lukma@denx.de>, 
 Yixun Lan <dlan@kernel.org>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1773;
 i=junhui.liu@pigmoral.tech; h=from:subject:message-id;
 bh=EdM8q38kOAztmfCtSxc25H4ZCMIwztSFOgXA6MLHBGk=;
 b=owGbwMvMwCWWvDb1VEXc8j+Mp9WSGLLq79+cx7ympfZXZuGrGH6fJD29/2tuzjkpu3ElU+X83
 58iW/597ChlYRDjYpAVU2Th8hf/Z63D8+2IQOt9mDmsTCBDGLg4BWAizJ6MDG9iDE4p8iQs/FNT
 5SC07O7lpWHHLkvWzf7h1xfhIWjy+i7D/5RXh5qOPRf7pxnzP/OXx6aje1k2pOn5+K+RTD6Turu
 ylR8A
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

The K1 I2C controller requires both its functional clock and APB bus
clock to operate. The device tree provides them as "func" and "bus", but
the driver currently acquires and enables only the first clock.

Acquire both clocks by name and enable them during probe. Use explicit
named lookups instead of the bulk clock API to align with the K1 Linux
driver and keep the roles of the two clocks clear if functional clock
rate configuration is needed later.

Fixes: 271546fb8e54 ("i2c: k1: add I2C driver support")
Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 drivers/i2c/k1_i2c.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/k1_i2c.c b/drivers/i2c/k1_i2c.c
index 2c7a1e0d3775..e2e4f9e53447 100644
--- a/drivers/i2c/k1_i2c.c
+++ b/drivers/i2c/k1_i2c.c
@@ -51,7 +51,6 @@ struct k1_i2c {
 struct k1_i2c_priv {
 	int id;
 	void __iomem *base;
-	struct clk clk;
 };
 
 /*
@@ -465,6 +464,7 @@ static int k1_i2c_probe(struct udevice *bus)
 {
 	struct k1_i2c_priv *priv = dev_get_priv(bus);
 	struct reset_ctl reset;
+	struct clk clk;
 	u32 speed;
 	int ret;
 
@@ -487,15 +487,21 @@ static int k1_i2c_probe(struct udevice *bus)
 		return ret;
 	}
 
-	ret = clk_get_by_index(bus, 0, &priv->clk);
+	ret = clk_get_by_name(bus, "func", &clk);
 	if (ret)
 		return ret;
 
-	ret = clk_enable(&priv->clk);
-	if (ret && ret != -ENOSYS && ret != -EOPNOTSUPP) {
-		debug("%s: failed to enable clock\n", __func__);
+	ret = clk_enable(&clk);
+	if (ret)
+		return ret;
+
+	ret = clk_get_by_name(bus, "bus", &clk);
+	if (ret)
+		return ret;
+
+	ret = clk_enable(&clk);
+	if (ret)
 		return ret;
-	}
 
 	priv->base = (void *)devfdt_get_addr_ptr(bus);
 

-- 
2.55.0

