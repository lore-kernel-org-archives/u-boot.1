Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCE6606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 12:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mZa/q2We;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=M7KUDssV
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 92B8560A5B;
	Thu, 26 Nov 2026 12:24:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LIpukSg0vpeN; Thu, 26 Nov 2026 12:24:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A396860A48
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795695885;
	b=XDu2NN50s/rrGFhZ4bDhTIucyTlmw7XrZkb7saPVnX6x0uhMZd0qky4iWHe63ptxquev
	 VUbKM/vM5PUifvACPiflN4N12fdwnLo8orHODLghtbfUACnqfHXFM7ePelny575hH405j
	 X4aqVaVEaSbTnXYVGK3M5fQMHp+Vbf++kZhFPikZVILfBWYvpBeSbRWWS8xWHOoBR8c0F
	 FNLeANF3A5WapmBwcbvHw29wWINoU6p+2A1oVY78s+xUJc1iwu95MR1OPTvXzL2XLUFxV
	 lVdymqmTkuXdeq4Lb5gvjJ2yF6D/DOiY9lIPwydF+J6rF/JYgF6MaDGP6F79g5tXkQw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795695885;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mukpTYLmlp48Q9XHEy6OwgF9edzt7jjn1fYu2LW40is=;
	b=RgMgHsVWAPg9Aivlcc8269LLI4DUOXEu7KB7fXOO3epunMkrN15uxm867T2pLsPQy6P5
	 bF86xWEP8HS5dWnzS8Wm03qqTvcGBy3R9HMJEmAVAcNM9NUQpXAZpSVXItsO7j9IaftIQ
	 eNj1QRo12HUrxk2AeZ024H/XiX5aV13+ZgKipg+Nbf9PmsZ1I0010RKmqZ2Oeej/Is1EZ
	 y+AG8KybSpRGyzYXoPkpRMIR8h9RHkorKLfiRV1rWFFAOk1o7uAKOHZl/y9vmVZNqJWgq
	 p6h9iXAH1K2iUEoiykb6vnItKKYm1kldbcyMlYqBwYCGfPg1gD2oVmEqWZbwXneCqsQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795695885;
	bh=mukpTYLmlp48Q9XHEy6OwgF9edzt7jjn1fYu2LW40is=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mZa/q2WekpHRkSpxMRERPZVha9luV45OEnA6xYU4CPIvPgx4RhhRoQymkHJCBw3Wk
	 lZkl7P1QjYiT6bIIc32GdlOwGaxq6fvJhmHUdeL/RoxoPbEoWk5cZW9Wo+gzDLWGb4
	 3ct+eTw+6d6wrvx973Mc9bocBDY5VUNA3Ds+LNac6R6rhqI6haGvBGqqMP8m6nWl95
	 e3KbSduPGKryK9qQLbf7LkyixP+Zb+cbgqwUed7odNyV+5gU6/YppbSeNydKOxRvPZ
	 M5S+hpMC51IzUqqdd3u9fjrLyGiPstBeCsyBs12zqAwB7Ky874FaRextuzIwDjVXve
	 b8L/8HH1bqymg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A396860A48;
	Thu, 26 Nov 2026 12:24:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CC3D2371
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:24:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B169B81101
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:24:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xt7Gfcfb6fXS for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 12:24:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B434881116
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=nora.schiffer@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=M7KUDssV
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B434881116
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=mukpTYLmlp48Q9XHEy6OwgF9edzt7jjn1fYu2LW40is=; b=M7KUDssV4cjKryz8uAsYw0r3uZ
 Y5RK48A55TA4kh9Bh+92ZGEgicC9WRSBSlgLWDht2rXx1JZC4qN2pvrrt1yX72XdZqvFEnXdan8ZF
 wVwQiuoWd7KAcBcYfZD6e7vfEBYlbWr62keGRY5JD4bbAfCPj6goJGp8UY+S+jkwuDwOo4b0uCWOB
 t5mSTexVUK9oeLqbl1mk1UdomGRF6tg+PmuA2Xs7goHm/eALgScsTWGatEs9bbOSMEl9HgYIEX2E4
 DONEvZ3mAe7P/GO6GTAVDPhj068XtEGk+Wygnobal0gWes3zUkujibeXNiHcyScePxcGlcOqH0gYK
 5WobU6XQ==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xWYWf-000IB9-0t; Thu, 26 Nov 2026 13:24:33 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy08.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xWYWe-0003gJ-0M; Thu, 26 Nov 2026 13:24:32 +0100
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.u-boot-project.org,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH v3 2/7] regulator: anatop: add support for anatop-enable-bit
Date: Thu, 26 Nov 2026 13:23:54 +0100
Message-ID: <d2b13ad33afb19f47c9f25d039b0915d26172d6a.1795694935.git.nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <cover.1795694935.git.nora.schiffer@ew.tq-group.com>
References: <cover.1795694935.git.nora.schiffer@ew.tq-group.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28194/Wed Nov 25 07:26:59 2026)
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

