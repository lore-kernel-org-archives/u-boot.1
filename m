Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F2F1CA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 11:16:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0DF8860640;
	Mon, 12 Oct 2026 11:16:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oBNKW4B89A9t; Mon, 12 Oct 2026 11:16:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 420D760613
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791803787;
	b=Oo/5bOJ6vUxZxjw1UvjkzyFlXives6PBneACDW/KvYeab7BjsnbIj6DX9BRn4jI2FgZH
	 nhzOjxitDDF4XCuG0UiGvZ/PVuaGW7QTbJmHMj5t9Gv8eu9izz03Tps0MSFvV7DLRBM4Z
	 f+dBcVqPZuVmf5dChGGqZlzrvG4PJ1CoQToWgffYMxx3iNQjixmSoV8kFulD9a86ZZkwA
	 FNtMyVuPcVUAvVkvFu2yQENcwYaO0ym+2XgN/sO1gCcGgFHIgFi48j1s4vpehtbaFC68l
	 Md3iqBhyiszxJdn1HO1HMl+GK+HGt+ruSVnMYz7+JMTYifIh6QKBzFS6l8klF4rUTAg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791803787;
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
	bh=jeaHo78i2iOBy19sPIqoG7TcB4OXTWy0t4kKECKaHWI=;
	b=MrL44ROHP30Ja/ZceAjSPw+BENzJf7SKWe4rYTx24QZKUrdTdxFlNAz8X0sGLmqpsf5G
	 BceKrXV3vd8IuvXviKRjb78BNA8aZVkfpbF1paJ0iB8JdbnuUaSECUnu6hmCNj82OwTG+
	 i3UgMGCaAo0M++6FM2Y2HJX/wTrrTF+d3l9hMtE3IDGUUej594Pcc4Qd9GTq15H+1zqnt
	 5+M2ZZrGfmpUUYeqRZhApDXpzUa4Zwwti0vip8qm2GOQwQ8v80TV708+9P7xgpN/c4m5t
	 AYNDvM8UqLdHtL4Y7ZCcVhqua8APZqRyBzd6obCvGpfcRU8tSa582hLWS1dihzQc4IA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791803787;
	bh=jeaHo78i2iOBy19sPIqoG7TcB4OXTWy0t4kKECKaHWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oTnTFfSDG7aeE+EeMQNdCQqfUMbksXHReIq/EL/+cIxy5qVNuJn1rjTw+2VnX762i
	 1THI+Gup8/9aNtvqRXUYcMEBTnR8Wb84/G6UlT+XLiP/TwXeLp/seadJlRTID8S3aD
	 jFDtrV30jIV0TcNY5DOR242JAafjM24LZPiKF3YykZ2ZVAO3xCQRS1SkCykHo/q8xN
	 IX74yS/JFGkEwqtuQemMFi1BQu41kw4vuCmVLEND9v5eQpVHo+bQgZVyd8OTxeNNXh
	 2naw8xPMup46OAfl41mZgtV+bg0obn1PIN2Wbw0UGVbcnvO6lQcCu20RT8wt4w2uvI
	 fKGzovvJzgOVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 420D760613;
	Mon, 12 Oct 2026 11:16:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 108ABA58
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 11:16:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0E24480CDC
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 11:16:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R1mKyo7iRrL9 for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 11:16:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A536B80CBD
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791803782;
 b=kqvK1eZn3+T5CSuhjfYsBx7qwlMt91ZntTOfO94KNlJ3//9gH3amuDYqVL6OujbYG5t9
 86LIsEAApBTQg4mgvWNa842E5jAEUEWMugLlyC+wBCUWAgIGSsNUuWgk71ePutCjcHkpT
 KigaDjsH9w6/MJiTr2yXh4DCpL0y6dXRIiDrTbpLz6FK/8mnoGBv3BZE6qrmG2sfmQ2Kx
 THPdigbCRfxpnjOfGMa4Afc0oVWcpReS30oq7zQFqkPC51uX1COCqRF3521zTd8q/bm3/
 q0/8x3HSsrGSXZLei0JTSMj0yi+i0KakH1z4OVMjFDeLMekveyhnTrZJCsex+eC9K7g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791803782;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=jeaHo78i2iOBy19sPIqoG7TcB4OXTWy0t4kKECKaHWI=;
 b=Z6T0WGyqlg998F8BdW89dAteI24jUOXhqnaGXugYf449Yhb6Ni24QxAbnplbV4HYhuu2
 3UODK01+1ttK3u80ROoyIyi2W0gkY4saIXWg3vZV66dohiumjZor7Wpr++g5efxwTZAHn
 4KvhYofmFMGuICC3B/GCimR2Ok0587vQFfk56N0FcDUlobtBSb0aZIXihIHO1kRkxRM5E
 K1BWw5sAk2a2HHunvh/v1ahjuuoBxBvnmto+JVv1SpDVCRsysDif7SMwAWruxex1n0diN
 62jPj4WoFlaD+DDTPGme2YNccpUvDgBlDiD1tRfASqfmiMvxefdHJapx8gP7luJu8KQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=u8WFkumr; 
 arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=2ecf=ic=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=u8WFkumr
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A536B80CBD
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 11:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791803780; bh=jeaHo78i2iOBy19sPIqoG7TcB4OXTWy0t4kKECKaHWI=;
 b=u8WFkumrmzJCzzHQUDgjUUEGOstFm9etRsWTm3lcN1P6J3VCZA7sgQEmp4DaYRA+rmpof6/n0
 1N67RmhQDCr8+p8IvgKlnVNE+IKo1uHysX+McjLm6c+9IfTFO83k3lbI4orh3YuPOlqvROlgYDp
 /zycrXTU86JWdblUAp3+m2PK5FEoZFaWVAJGy6RsnBzliFNZfSAyP2HGlfcMxlqP7YDeh/dvVly
 y5joGbSBl7EAVRYJaK2Ca7D+0N2RcDTwdGPS4dk35TdquOy7sfDltgYikYV0z7x8Nu8W2qbzEZY
 5TkhASebCatr8c6E7v3FHlPgwhUWo88Vl11l60iAK/UQ==
X-Forward-Email-ID: 6accc183003f837f7de8eed8
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.18.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 4/4] clk: rockchip: rk3528: Always initialize clocks in SPL
Date: Mon, 12 Oct 2026 11:15:49 +0000
Message-ID: <20261012111552.1173161-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012111552.1173161-1-jonas@kwiboo.se>
References: <20261012111552.1173161-1-jonas@kwiboo.se>
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

The RK3528 clock driver configures the CPU PLLs, clock matrix rates
and default PWM rates when probed in SPL. However, the driver is only
probed on demand, so this configuration is skipped when no SPL consumer
requests a clock, e.g. when booting from RAM/USB.

Prior to the commit c6bba31dbdd4 ("rockchip: spl-boot-order: Defer probe
of boot device") all boot devices where typically probed, with a side
effect that clock driver likely also where probed, prior to the
boot_from_devices() call.

Flag the clock driver to be probed after bind in SPL to help ensure a
deterministic probe and clock configuration behavior prior to booting
from devices.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: Update commit message
---
 drivers/clk/rockchip/clk_rk3528.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/rockchip/clk_rk3528.c b/drivers/clk/rockchip/clk_rk3528.c
index 83e302dbc3c4..976ef0e0a919 100644
--- a/drivers/clk/rockchip/clk_rk3528.c
+++ b/drivers/clk/rockchip/clk_rk3528.c
@@ -1715,6 +1715,10 @@ static int rk3528_clk_bind(struct udevice *dev)
 	struct sysreset_reg *priv;
 	int ret;
 
+	/* Ensure clocks are initialized after bind in SPL build */
+	if (IS_ENABLED(CONFIG_SPL_BUILD))
+		dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
+
 	/* The reset driver does not have a device node, so bind it here */
 	ret = device_bind_driver(dev, "rockchip_sysreset", "sysreset",
 				 &sys_child);
-- 
2.55.0

