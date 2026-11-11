Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC37606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 10:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BxwsTodT;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=V0EVl9/l
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E420381259;
	Wed, 11 Nov 2026 10:13:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PtosoBX5ntqy; Wed, 11 Nov 2026 10:13:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E7DA2811DA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794392014;
	b=e0ScjaP567WNwiuqnEtCRoDDrPO426PDLa3DGJeRcApQ2B7OqgsVAwMN11V5kImV9q5f
	 PWgo1u9/H7bYx4orp2ceZ9dReI+xoffrhcc0Tq0sEd1iUfpn7L37V6DFKkoYmnZ2IhNQG
	 835NR4s3BWvBFXnBsP0hBfvTyQyq4q/fHsEhvG4jfjIoUwvUQHZR1GMoE2t7qeDZyfP/I
	 o5QLSxxWwmDMaeFiHMhYG+7F0fGk+6gaZqstn3R9qploTM0dQW/s7H5MCa2xD8Tzl+ZlY
	 vM6XOHUbpoPiLqIiEId7DIfXvZ3nn9TZI2Jcpza2Z7qp90pqw0IUnNwsmTXiOWIaaiQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794392014;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mukpTYLmlp48Q9XHEy6OwgF9edzt7jjn1fYu2LW40is=;
	b=kvaWfNfK1CDAJD0ZMoLzjLo8XV8GtnHCfKvTraX1ThmQM4q+ygMGU2hqGpNqGu5mP4mU
	 lNb8TmZIlLghLAdWgvsOI/Z9BFj1CogO4D+pDa/rz9lP9rWmVDSsIWTMStwiXQKhdY2HK
	 GJbRC2W9KpGfTSkLIAe8XY3Y2JKGKiYJDd4PcaRoBVqEBklVm/gAHm3iZRRrnWthDeB3t
	 2FIN25EvgxMW5fjTGUvkWr6YcwzxqwoNXG6vGofXA9q2L+Z2UtVl7W4kDv9FeoDicVj81
	 4XLvxW4WrLA6ih04I9FX+HATRF6k5psFExmCdI2aJ5pbz78/HOf/r+G/DBlm0voApiw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=ew.tq-group.com;
	dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b="V0EVl9/l";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794392014;
	bh=mukpTYLmlp48Q9XHEy6OwgF9edzt7jjn1fYu2LW40is=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BxwsTodT8qW+8NCDGhCnRG021bhXwmg+R7nCFd2QJSuwFRjZrfhng85EO1O/0LUkh
	 gtTflquaRggNC9bF558NR/dmJGydY4V0inrd/poPk673WDmM+zYlvqFCqKx3rLJgrf
	 4b+8a82EN0E3XUYPO7T/XpkbYmr8LKTVaA3jOSFCXKQjiHV8ejYPTG8stL5HVB7SEQ
	 t5iCb5O6Dct010aT2bSQzeXi49bhArDD+sQKT5ClsIozaUd85SHmm8DDSJt08W49nO
	 gi89iwLzmlKJZkDOz6stWh728LqI+XWVeH/SknciZ1Fjb0iutouziZeRIeKy71rO7P
	 l7oa1E2bJy5Tg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E7DA2811DA;
	Wed, 11 Nov 2026 10:13:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 48BAA17CB
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:13:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 368A781206
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:13:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id znlROKBouGDX for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 10:13:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9CFF2811D4
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=nora.schiffer@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=V0EVl9/l
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9CFF2811D4
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=mukpTYLmlp48Q9XHEy6OwgF9edzt7jjn1fYu2LW40is=; b=V0EVl9/lZ0drw8xeFJ1/rLcHDZ
 xp4RyRvofVVF7dHn6YRbQkbojYwnC+BhoT7nS/blJ2tf6eNwXw7Es51nJd/E9yea7d6MQRIyivanZ
 E5Wg0BTDEpfm6hFrBcR24ul/7NPizLohj4jUHJGWEIVcKFLzQ72xLq4/T9nw14Tt2D1e+slip6Ush
 bN25IT/ovLWWtFrDRULOqFXQCnkg3FDrxlXEYM2yQIEZ7PEmnoK21lJHBm+qll4A2vVsdj6rnp13T
 jmo3H5FPl+rTLf4SWmjeuM/nnRce7yC7murwuJJLc74RyoW3mMEGWNjf4NulsVp2CMUTnruB5+nXA
 468JAdfQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xR5KV-0004wc-2a; Wed, 11 Nov 2026 11:13:23 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy05.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xR5KW-000Lq2-05; Wed, 11 Nov 2026 11:13:23 +0100
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.u-boot-project.org,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH v2 2/7] regulator: anatop: add support for anatop-enable-bit
Date: Wed, 11 Nov 2026 11:12:53 +0100
Message-ID: <083f9932c9960dccc1115f5c547633e98c1e9c8c.1794391398.git.nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794391398.git.nora.schiffer@ew.tq-group.com>
References: <cover.1794391398.git.nora.schiffer@ew.tq-group.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28180/Wed Nov 11 07:24:27 2026)
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Some variants of the anatop like the one found on the i.MX7D need to be
enabled. Add support for the anatop-enable-bit property that is used for
this purpose.

Instances without this property are considered to be always enabled, and
attempting to disable them will fail.

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
---
 drivers/power/regulator/anatop_regulator.c | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/power/regulator/anatop_regulator.c b/drivers/power/regulator/anatop_regulator.c
index 68a320bd0f8..a64b35b7363 100644
--- a/drivers/power/regulator/anatop_regulator.c
+++ b/drivers/power/regulator/anatop_regulator.c
@@ -42,6 +42,7 @@ struct anatop_regulator {
 	u32 delay_reg;
 	u32 delay_bit_shift;
 	u32 delay_bit_width;
+	u32 enable_mask;
 };
 
 static u32 anatop_get_bits(struct udevice *dev, u32 addr, int bit_shift,
@@ -154,9 +155,42 @@ static int anatop_set_voltage(struct udevice *dev, int uV)
 	return ret;
 }
 
+static int anatop_set_enable(struct udevice *dev, bool enable)
+{
+	const struct anatop_regulator *anatop_reg = dev_get_plat(dev);
+
+	dev_dbg(dev, "enable = %d\n", enable);
+
+	if (!anatop_reg->enable_mask)
+		return enable ? 0 : -ENOSYS;
+	return regmap_update_bits(anatop_reg->regmap, anatop_reg->control_reg,
+				  anatop_reg->enable_mask,
+				  enable ? anatop_reg->enable_mask : 0);
+}
+
+static int anatop_get_enable(struct udevice *dev)
+{
+	const struct anatop_regulator *anatop_reg = dev_get_plat(dev);
+	u32 val;
+	int err;
+
+	if (!anatop_reg->enable_mask)
+		return 1;
+
+	err = regmap_read(anatop_reg->regmap, anatop_reg->control_reg, &val);
+	if (err) {
+		dev_dbg(dev, "cannot read reg (%d)\n", err);
+		return err;
+	}
+
+	return !!(val & anatop_reg->enable_mask);
+}
+
 static const struct dm_regulator_ops anatop_regulator_ops = {
 	.set_value = anatop_set_voltage,
 	.get_value = anatop_get_voltage,
+	.get_enable = anatop_get_enable,
+	.set_enable = anatop_set_enable,
 };
 
 static int anatop_regulator_probe(struct udevice *dev)
@@ -229,6 +263,12 @@ static int anatop_regulator_probe(struct udevice *dev)
 	dev_read_u32(dev, "anatop-delay-bit-shift",
 		     &anatop_reg->delay_bit_shift);
 
+	ret = dev_read_u32(dev,
+			   "anatop-enable-bit",
+			   &val);
+	if (!ret)
+		anatop_reg->enable_mask = BIT(val);
+
 	syscon = dev_get_parent(dev);
 	if (!syscon) {
 		dev_dbg(dev, "unable to find syscon device\n");
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

