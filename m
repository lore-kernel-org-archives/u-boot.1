Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06FABCA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 15:05:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3115A40589;
	Mon, 12 Oct 2026 15:05:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uo-WisVEKRxQ; Mon, 12 Oct 2026 15:05:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3F7854058A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791817556;
	b=Zmu7cVKYTn4KFxYMwYMdeRPXr36lL5Oux5wuZLWa9Ip2Q0t8GtZY+/2Mx9ghzuTU/jJF
	 60oMw9b2ag+3sKQmztyeZxPzSOWoMcH2P7oNi9rWQrhtKxU8aNoS17Fsw4yyYoFPp7rpe
	 437VxCnsV7/7tlrwbpUhpvbGz7/JoRRegKDtDEn93ja+hJh0CgQtJHqmK50owCXiXgZRj
	 ChDTJqONOsFr8tXhY9PjLjWvYyXgYT2N6IXvTp3EMNE/jfFSEEzQwCLwa+XGjxTFhl/1H
	 A1vKVgWw82XjoBFHGgx5vKTutPKSYgUw3dEAt8XwVyJk59+/qbb9GMeOpNxi+UMHOeA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791817556;
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
	bh=lal2psl7ALGOm/f85sN87EhzIFC1kaWTaMsPZ75zflU=;
	b=Bx+8qZ8MdC9BtSzNJ8bNA86AjgKm401FdNKsE3o0ROxCZOuftxMiWT0UPiiGpqgJymTv
	 BIq/RJ/ZKbHL/zMcHWXyWUOiWw5COmLNwtm9p25uYSwK8IvgPLwcPsOUI2rA9vBr9WViC
	 eg0kjhCd23kDd+w9sg5RGvv6kHC9uZCTKHVZ5iTjjZ2peeInXYHdmK2o+a4pWZzIKId9K
	 ZApLBL2p0K2tlJlpgMWbT9LGgVN8mi5fJgiqOyAxZQvtlAT+9D1JAdqthpxF3OrMHKjcn
	 BZK7MXZ0u18XR+QKb/48LdexFs3QQCUH9/sQpjuEJSWU6RupV7jPO3NZtP5LCOPu43w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791817556;
	bh=lal2psl7ALGOm/f85sN87EhzIFC1kaWTaMsPZ75zflU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KteS0JGF2JVjW7LhU4oHWfGVBot2pFaWT3W/E208b5wyHvzUwOjcQkdBmoMQJeMhM
	 rUZGNk7IJe9n3UAByyAg+VpZljPYGqHM4h1MXJHdFOY0PMPdzRAeCI0qr+Vm8+Mf/G
	 a0TCoumkpWvyvF2WTOc967sqUbx6Il4lR3IGm6mEGwxeujHXqHKQ3JAnipQ2hJu96d
	 lgtu+PlKgh5ParQ1X9yYpV8pSpzVoYQ2Q9t2ei4hYjQIGibms4ERJNNRRRtpnp5tT7
	 aS8v1O5iq+oyvzxO45AkZaRar+/bdZZMiSGKdKkixeKSAMZ5uP2+zD4evXtl1Vu223
	 cEGJo0VmOlh9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F7854058A;
	Mon, 12 Oct 2026 15:05:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B876194
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:05:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 39358605ED
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:05:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4vpdM61MJG1Y for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 15:05:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8BBE26064C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791817554;
 b=AbA9x6aNqw2A4nI0QDnRQk43Yjn6UxSQA5gztQclw7WnCP2Qelf885jWXoI1EZ4E5jax
 Js/TpwbNjkSuc8ajoPXx6Xk/GwTAfM0Xw9sELVSasXe87UcKTBE2tr6f7yZUBMjSMyzB4
 bijrJ4U+8v/Pk1CXx675HMp2BC64r7bJY+n46eug7RBXXJ6U7PKEeTUvMUyiSPPTrO6TN
 Jim5qfvmLYCuv9Jsa7cv2q/vl3GCMPM/fVFI+unxeYH6esydqZ4IclAwEqMpa2vXbM+ug
 j0M/oXIhr1nwRrpHvfgAZbZdmHSA/Cv0SWIsyHKvzR+bf7R5rmh++iz21ONJjcN+IUg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791817554;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=lal2psl7ALGOm/f85sN87EhzIFC1kaWTaMsPZ75zflU=;
 b=j0Zn/mIIoCguPAQpatDI7EJjEsqEotepkXKH0sPJKegTDuUkKy+uKEdWh+1eagU7Bkbx
 VK4pP6ZeHtEaMlYViQH0rSei7gxTWE71FzBRiBBS3EpecSXLkkApRUCdR+Qc6uwmn4gz9
 itCQ+4dtgP6tvJZefhEkT6WwpByfFoOSJqxQGFN8H8z4T3Y7qGT1Sr/e/HY2H6n1Lxn1/
 8p2szaZvnkC/2ozSgxU1U1Qn5F/m+sr+aCOX+DIJKXEHe7AZ8tec9bN0YpPmodxPWlJkv
 vS0YJ0jFgoGbDmNim8JuLjRAw8M3E/HKqXhmcTGZMlR6B3ruTuuXLCd3X/XnrCU1YaQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=hSuSvu7e; 
 arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=d90e=id=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=hSuSvu7e
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8BBE26064C
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791817552; bh=lal2psl7ALGOm/f85sN87EhzIFC1kaWTaMsPZ75zflU=;
 b=hSuSvu7e/i759cMcMWN2OdpSikZFsKJcdkz2GnUCBLWZ57PEZSPzocDb3N3o8Njjg9Bc1ZOVW
 4rOM96mSBSLE67fi8orNdC3WLX4PNKYD541vlwfhPeSDytpyytA6JEp9rujFbvm52R43AeeQPEr
 XQn9yh0ETBSndkTYeOg8+UvwPMdQLfGD0sIoE+RrrE8kaLIdbu9gAI9yCEVaO3R3yPC5kccB9/n
 FqFcwH6WaLe11eVmrzOZFJg5CGe3lY+UQ7tL3Luhn2UOnFX3j3s8alvcTNCgN3VapLdheBwTIFx
 P8DDoeMfeMxnYn6E06yv2YQ+z4rvlPc4wMQtvJZ9cO8A==
X-Forward-Email-ID: 6accf74d8ac7302d53a2c8c8
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.18.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 1/8] net: gmac_rockchip: Remove unnecessary clk_set_defaults()
 call
Date: Mon, 12 Oct 2026 15:05:31 +0000
Message-ID: <20261012150542.1182209-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012150542.1182209-1-jonas@kwiboo.se>
References: <20261012150542.1182209-1-jonas@kwiboo.se>
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

The device model device_probe() helper calls clk_set_defaults() before
invoking the driver specific probe() ops.

The call to clk_set_defaults() in gmac_rockchip_probe() re-apply same
assigned clocks. Remove the call and rely on DM core to apply assigned
clocks.

Fixes: b07911840025 ("net: gmac_rockchip: add support for px30")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/net/gmac_rockchip.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/gmac_rockchip.c b/drivers/net/gmac_rockchip.c
index 2b6080dd9ee0..6396e65d9ddd 100644
--- a/drivers/net/gmac_rockchip.c
+++ b/drivers/net/gmac_rockchip.c
@@ -596,10 +596,6 @@ static int gmac_rockchip_probe(struct udevice *dev)
 	ulong rate;
 	int ret;
 
-	ret = clk_set_defaults(dev, CLK_DEFAULTS_PRE);
-	if (ret)
-		debug("%s clk_set_defaults failed %d\n", __func__, ret);
-
 	ret = clk_get_by_index(dev, 0, &clk);
 	if (ret)
 		return ret;
-- 
2.55.0

