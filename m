Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77AE5CC6B38
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 22:42:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4CB2240956;
	Thu, 15 Oct 2026 22:42:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id poTM5SKRXXR5; Thu, 15 Oct 2026 22:42:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 456C540958
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792104172;
	b=lLppguNVzZWTQfagb/c/LHReOwGKg22e+M1g7ebXXvKeLvMENiikC/fUb9WXn3JdVxPQ
	 EbbT9vmsT/LuqhnXVIacFQ/LuytUVmdQATaBPUFBJDMPUFQg2Nw4WVM+boFjApXH2GHzy
	 +RcDdmeQ1UDJrgUXbq2SzvLET9RalZZF9a9dWZfHme27cxtrWNJthUyY50Sstn+yczDkl
	 EKf5w3BzDzalgmoBIvF6Qvy0Xm2isJU95D+1KpoIrKnazR9fvr2UGeJleyg7dC7inKuHJ
	 SI3B2RpNi4snWC2JeL3IhbKSAJl8+jffdVRbOS2FEElWhhk6lP3cEAPuNfMZsSL/1dg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792104172;
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
	bh=EscGTG+2ut9QKh0Zcqh7p91t+nG47cqj1PWiq5lEvzQ=;
	b=a9t5pvHsqWYHtQz13qu5jqqoyh8BS4oRWfCXaoV6cFIZ9M1xlH64bOeWj2c+xYliuVz8
	 STxrjmPRuUR82y1xdsuImZLaLHUh6d/11u9QJ963XHQ7dHACTkHYtTpXnZXP+iLzNDfW6
	 3XXo52SvrMzgav9ZWsio2QB8Uj8xvyRY3Y4JIWzjSdCnpPDa+8QnpA/7MpcpibcLWskr0
	 hdFNj46btTSUZlECy93wDNSMQjNTJyid31sHk24EGrb2S52cmi0+T3MGTfxJcixeOhMfI
	 l0in8Ogh6R0CTiVEM8j/2ZVC3N5HlWD7A/GVcSewpfljW8+YrfqHlHIMiZMRZN1XTsQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792104172;
	bh=EscGTG+2ut9QKh0Zcqh7p91t+nG47cqj1PWiq5lEvzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LOgIYLl/xMODtm0/k/z1mr7L/MhfToPxGdPVFntVf1+eCW2HVA6e0Lc33MM6JkXHC
	 2ZGaReAMtslxMPUZZz7Kb8CFCbMtDjme/ypfAu4Sj1gZkiJ6bSCwCLwc68Td7vy1Bu
	 BfN8hKy5VyCWuFo4ZZrv7dBqpRwpEfFaT65Kw6A7FzhcQIavs8eYBhDJ+mvWuouZbB
	 7lSeKNbp9f74b56icQpY0gnK64jg+y2ilQr282FVCaivtIEe38VS5X45po8fnPb7Ks
	 YVyBf7lFBQVlMaSzdU9Cp0hsRnM7N+IQV2RqNTi4Vu0FeudVoJEWhLrSPAma6kVBpC
	 yfb4yZ38bnt8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 456C540958;
	Thu, 15 Oct 2026 22:42:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A35D1E9
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 22:42:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1F29E60AFD
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 22:42:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5HEKN3ptwNM2 for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 22:42:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5071160ACC
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792104168;
 b=hen5Pd+XtPc6HQ9NfUpF9ehO+1e0VeVlBo8j1JVVjhY8h1nt+Svi2PF0h1USFimvyDaY
 ouuiz6gibalEwnLBE48roZ9VbdDcQIlnE5NEEUygO9Lsvf0Gur9voHpma868P7osGVmJO
 TZ7bTWPm4gdwsliTz1pZPAnhs4ptHqHxz2ciVjHrMTI3p1TYl26WADo+zq3Gj41D6NfTt
 lsycdPizfT+Z1M1XYs4ESdWiaq+krk22SO4/DJNplc0ZygKcREV9YK1FQWSqiwYnZpdMp
 5UlVGHq1AYLI8By9f5FlOZHBgKi6lHsDaOU4wfYDcGK3nBT/JwYB3a60byMlhCUVYzA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792104168;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=EscGTG+2ut9QKh0Zcqh7p91t+nG47cqj1PWiq5lEvzQ=;
 b=OrRcZJeHR/FVSBad3VaEi8okJbCm2GkeCC+2jZ3eYNS1Gt+u2In29Y35eoSN+oUZLtrt
 aly6BGpCdfSbinbaEgbqh7JFzKXorw4PRtzPWu0dMEdJtWchBwiGEiPvXUKiIm4ORXKT8
 jMcUBKhco3WBoIhOKHDxb/wyNKYCaf4VyrnkYr3wcaXRHwowotEPdWd3/0K1Gou3VFcIV
 W63ShD7sKmjL/jc+b9khD4isaHufOlrj2VaY3tvglJAtYRdw5fQEZYZQ0I/Gqo/k/IN7l
 Ix+Rj6zyl8C6Q6k/ehaUFmIBzoSbL8moywBcv1JCMx+Gu3LQ/i2lwD6SDA5WtjJnq9A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=K0tIyAFD; 
 arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=cddb=ig=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=K0tIyAFD
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5071160ACC
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 22:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1792104167; bh=EscGTG+2ut9QKh0Zcqh7p91t+nG47cqj1PWiq5lEvzQ=;
 b=K0tIyAFDtrI9GM+k45zKPxq2k7DFr2R7jtoSIuu4Ck95JNvmezyE9WIwPUHMEw0UJMEarIE4G
 Le4CsSSfRf/hD6c1ZHnbdkUsZNLyzn+bCYUvbwaCXTIL8+siRpwImyLmJ4KgXZkIaCg3AdBzNbb
 YdVMGfodI1eUmtOJh22REqJj7g6CuGlENS2S4LW0xa1/KAARiVf//X2CbeqCiQ2bLq4GbEXCC3O
 /AB02aGyUYceLA9wd9oEk7hSA8TMcPF8wqVhdeTTMrtyjb6q5icdjiq7dGC2wxG7Aa6ttkQq8fO
 cCtDW8hvaqnMuzPY9bzOiAd4Y3Oj6xr71cfJgdPXn1Hg==
X-Forward-Email-ID: 6ad156e532553382725eabad
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.18.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3 5/5] clk: rockchip: rk3528: Always initialize clocks in SPL
Date: Thu, 15 Oct 2026 22:42:19 +0000
Message-ID: <20261015224222.1582607-6-jonas@kwiboo.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015224222.1582607-1-jonas@kwiboo.se>
References: <20261015224222.1582607-1-jonas@kwiboo.se>
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
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
v3: Collect r-b tag
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

