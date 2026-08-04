Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46914C55182
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 00:27:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2086F80C53;
	Tue,  4 Aug 2026 00:27:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TQEdg_kp7_es; Tue,  4 Aug 2026 00:27:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E663280C36
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785803222;
	bh=0BGRrOp1wJdocCJi0LM6v4A7zNeI5o0cxBvT9qVuymo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AS9GfqszJxUdMY5A4aSbq883uZYYQGqoRFeBej3ESBHmxO+Aw97w3F5Y1YZ4Nh3Dv
	 lKldB3or0EvrFGZcRj7GQ00tQ/C918fLnPOcbGSxir1zzMD/ip0ZhoUQVS5DZr7PN5
	 fy9b16JgYLXK6+rUFiGMzggcIKMUhGjPuswkHUH+F/tkKHfChG5xB+q7ARpHKQXrVf
	 Jg2Ny3Jw/lGnvCQtMZ+uztX3bbRF+oSg8mIovegYDamPoxZ8Hh9yUxLUw+t1ph+kY5
	 z7nNvFqE4q8qy2dGpHop4oVYZD+bxlD7WCA0uj2cCiEDpwRsm7zuuKNgQfTk3UFOgm
	 quoZRjP1Y6o7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E663280C36;
	Tue,  4 Aug 2026 00:27:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DDEE92DE
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:26:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C42B8400CB
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:26:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BdPnmU4oLbT0 for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 00:26:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=eb25=f5=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C656F400A5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C656F400A5
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C656F400A5
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:26:58 +0000 (UTC)
X-Forward-Email-ID: 6a7131cc3f1ab8deaeb03df1
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
Subject: [PATCH 3/4] clk: rockchip: rk3576: Always init clocks in SPL build
Date: Tue,  4 Aug 2026 00:26:41 +0000
Message-ID: <20260804002643.2308515-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260804002643.2308515-1-jonas@kwiboo.se>
References: <20260804002643.2308515-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785803217; bh=0BGRrOp1wJdocCJi0LM6v4A7zNeI5o0cxBvT9qVuymo=;
 b=uU9CNZ8/0FvJ6o1jnDWThfPUgcTYtb5cLRkCefhDWqu2/nVYMyj8wbQxXKwMngCkzboeZ/u+o
 3cvVqdo/6/q9lcGTO/G+VNELSUJzRIf8JmADKvNi19HaxSCcZ+mywcyWtVPUX1tQsOTKL5EJsVQ
 /bxqLLojaOKSNQgCnFtHw0yeHqRlf/140Nkg3BBIsQwi1fEkvib5TDPbUOCQpBEfQyZ4931W7lf
 LwLB0sMzJ92teYCRgX82DsTrspuS5MggdrcXcYBAdSjAp2CA9qXrOn3VCk2xYZRVVHqfx3L6Uam
 uZA3Fs7WYrF8OU4GUFubUjwx8FwJiGKc3ykJiCvh+p9w==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=uU9CNZ8/
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

The ore PLLs are only initialized in SPL on RK3576.

Ensure clock driver is always probed after bind for SPL builds to
initialize core PLLs and clocks in SPL phase on RK3576.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/clk/rockchip/clk_rk3576.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/rockchip/clk_rk3576.c b/drivers/clk/rockchip/clk_rk3576.c
index 75b705ffba2f..1988f0472dec 100644
--- a/drivers/clk/rockchip/clk_rk3576.c
+++ b/drivers/clk/rockchip/clk_rk3576.c
@@ -2526,6 +2526,10 @@ static int rk3576_clk_bind(struct udevice *dev)
 	struct udevice *sys_child;
 	struct sysreset_reg *priv;
 
+	/* Ensure clocks are initialized after bind in SPL build */
+	if (IS_ENABLED(CONFIG_SPL_BUILD))
+		dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
+
 	/* The reset driver does not have a device node, so bind it here */
 	ret = device_bind_driver(dev, "rockchip_sysreset", "sysreset",
 				 &sys_child);
-- 
2.54.0

