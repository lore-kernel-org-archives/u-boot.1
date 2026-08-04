Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0573FC55182
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 00:26:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B11F980BE8;
	Tue,  4 Aug 2026 00:26:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ksiaktcYAEGC; Tue,  4 Aug 2026 00:26:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3A52280BE0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785803216;
	bh=1Wb/qpen6k5cmavBEA02bNTynAdhYLpjAAZqUI1AC7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Pi0BLwe3aMeCsGwoe6ZJeNesUwJ3oQ5zCe6KsgvYgN25nfCKYTxBybthiBBOd7LE6
	 0ALhcE0JXkULBSIm2Mi6BOA7cv/aD59ew42181P4L4TN2GEXUx0h7bU15WQ003i991
	 cIVK1ntYVUvRsTgFWFa2Xsnv9Ez2+2utXNQatXuNoByGhTTq3iihEzqU72cAwTvg0f
	 81TD1kQ2i97HxVjmKdbVFQ3+wfE6t0qkUSjak97/ndyGSi2Vm52BuJrHNbAHm5bO2e
	 ktEWV/Jexs08XZEFcYKRJdwOxbCMpLmS7vnGIvTwCPApe3QHZZQgREGdFHxHQdarBr
	 4S+JnvA1yaJmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3A52280BE0;
	Tue,  4 Aug 2026 00:26:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9CE0C198
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:26:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 82655400B4
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:26:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zb2rvItgkEz5 for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 00:26:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=eb25=f5=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C8FF0400A5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C8FF0400A5
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C8FF0400A5
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:26:51 +0000 (UTC)
X-Forward-Email-ID: 6a7131c93f1ab8deaeb03dab
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
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
Subject: [PATCH 1/4] clk: rockchip: rk3568: Always init clocks in SPL build
Date: Tue,  4 Aug 2026 00:26:39 +0000
Message-ID: <20260804002643.2308515-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260804002643.2308515-1-jonas@kwiboo.se>
References: <20260804002643.2308515-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785803210; bh=1Wb/qpen6k5cmavBEA02bNTynAdhYLpjAAZqUI1AC7c=;
 b=Elx2bbcxocsMwCB2H3Z24+cUEG/KZsnaBh+z5UKCfBYWGUw+WHrAiCLu5kIEcR6PpW9M9DsDN
 WT1p878ooSPhRdoJ35yDIKkoXllS9t2IK2kff/nEDOdru1iN5VSEe1dTEFbiFVuQ+qfcljX97Py
 NTs1LBfqeNi0itwPHYId1mefM0HEYK+6BdzSq4httflF55fmIyKy9G46dm0LD/wRDpCb9CcdbIU
 vOemAw8kzXlbG+ChrIJxL1UolbgOZiauM5+I7Sn1tsAigCp8mxdX5mVentoIoLhh+JSeL/FyWXm
 x3+naTAeo/CvXFVXmbhNZf0N/Iu+S/Dv7fQLIY3t/xdQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=Elx2bbcx
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

The ACLK_BUS clock is initialized to 150 MHz in SPL on RK3568.

Ensure clock driver is always probed after bind for SPL builds to
initialize core PLLs and clocks in SPL phase on RK3568.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/clk/rockchip/clk_rk3568.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
index 9f3e9322161e..5a05f1b4de00 100644
--- a/drivers/clk/rockchip/clk_rk3568.c
+++ b/drivers/clk/rockchip/clk_rk3568.c
@@ -2934,6 +2934,10 @@ static int rk3568_clk_bind(struct udevice *dev)
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

