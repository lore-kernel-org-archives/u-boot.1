Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 801DFC55182
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 00:27:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5520E80C16;
	Tue,  4 Aug 2026 00:27:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VS6qFql6-LjH; Tue,  4 Aug 2026 00:26:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5511D80BE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785803219;
	bh=GDKmLAxydCuM/XENSI2vbLurLllFPngSndVvs1/d5f8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e1O5jq341Gz0IGkAM5nzkUy+kWbG/3y1a9UYJo0thsh6OZZtCMwsVJPlCJ+TgkzcV
	 Zdj5PxlTBFZ/qIQ2hyFHE6gB8tUqZsJ/4T/8952OexSb4eXQZq+DpKOKEchbNIyG6N
	 5h28CyD/teqwJHQiuO1G5o0gS856oPBReme4UPQyHQTlZoi4hzb77q41zI074bTs97
	 smryfEtL5t45E418639AruFoAMDxM/uEs701UbiYMGYJ8oe2NqrSzlslly/OuPOOIu
	 nyhh+0qoevnNOpxUfqtZLsmiZ8YvaNKbWekaRbPPvNii1NX2K4Qbv4KrtchNGeHg+I
	 0cxNwE7rj3QmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5511D80BE5;
	Tue,  4 Aug 2026 00:26:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B5E2282
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:26:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1D55B400CB
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:26:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 83J3QQ7XsXNm for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 00:26:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=eb25=f5=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org F201C400A5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F201C400A5
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F201C400A5
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:26:55 +0000 (UTC)
X-Forward-Email-ID: 6a7131ce3f1ab8deaeb03e31
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
Subject: [PATCH 4/4] clk: rockchip: rk3528: Always init clocks in SPL build
Date: Tue,  4 Aug 2026 00:26:42 +0000
Message-ID: <20260804002643.2308515-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260804002643.2308515-1-jonas@kwiboo.se>
References: <20260804002643.2308515-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785803214; bh=GDKmLAxydCuM/XENSI2vbLurLllFPngSndVvs1/d5f8=;
 b=fXOs01Dlpgtq5z+TlUOaCXjKlLCxD8usXgXKmavPmK4/KxPqt1lKvADSPkLX0g49N1/nSw34a
 Sss7qslYni4xgaMscUV8Wttn6FbWSkls2AgzhZrVxF1hrgj7xi5JK9jFLAAS0K3LkHCwaVBqJXe
 Mss8g3DG57pR6e17e+jVKle4p/XsfCAc3QdO2niz4JbzrxSL7IcJzfXNSZD/NgjuoguX8K8IhLg
 O/LfBd3SMegCgJIFYBnNkcfSbuyt0WJmr/rdfaqv4tA66ApoMeGpk289HeAmp2kb5GYE63uDeAM
 ahjfg/204oVfJsXffix1LlY3zd1GryiuoF1PcTvtHJbA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=fXOs01Dl
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

The core PLLs and clocks are only initialized in SPL on RK3528.

Ensure clock driver is always probed after bind for SPL builds to
initialize core PLLs and clocks in SPL phase on RK3528.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
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
2.54.0

