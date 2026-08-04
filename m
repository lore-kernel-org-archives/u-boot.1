Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13557C55822
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 21:44:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 98FA080893;
	Tue,  4 Aug 2026 21:44:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PG9PtWCPlRq5; Tue,  4 Aug 2026 21:44:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F0893808C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785879897;
	bh=jz0U2fJrzT543eAbA9j+GhmqXmlmGviMlzhOvvDwwW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0WgITr7Wx5KQF/u9AD016fDNTL1NtW7l/YjmwcuSCx9MCD12q3ycZCzoUQWPyS7dQ
	 S1qrvDq1Yo/NPhxDrDgu3NpX3/unDyd2ShS5Z/HiJZJdyQZp8gE8jOJhX929bBOWi9
	 LX//tQGeFX85duTYA0BaJsn8Cdu7nHNx9m59X+4/+vpkKVxmcsMSlZ7RasEqLwth2M
	 ZCf4yrAOX9SG8NujhLOmTgeagpXvfpcQguhzrShkitaHK+O+L1nzG7fRPpj8FObwsq
	 OTj2aTr9+kGqZXvz7JgQJ1g/dNb0D+RdCr5iS2UQ0w2ssYTSRKf6zRMT4T1nnvUimf
	 IAcN5xZJDGwaw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0893808C5;
	Tue,  4 Aug 2026 21:44:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 523EC2FA
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:44:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 476A4405D0
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:44:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9rUPR6DW072b for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 21:44:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=1695=f6=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D7E7E40571
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D7E7E40571
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D7E7E40571
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:44:53 +0000 (UTC)
X-Forward-Email-ID: 6a725d5296269bde083044c2
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.13.5
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Klaus Goger <klaus.goger@cherry.de>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: u-boot@lists.u-boot-project.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 01/10] rockchip: rk3588: Rename CRU_BASE to RK3588_CRU_BASE
Date: Tue,  4 Aug 2026 21:44:30 +0000
Message-ID: <20260804214442.2592597-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260804214442.2592597-1-jonas@kwiboo.se>
References: <20260804214442.2592597-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785879893; bh=jz0U2fJrzT543eAbA9j+GhmqXmlmGviMlzhOvvDwwW0=;
 b=LFCh5TyNlNu62abeWpKDLVGPjUluolTKybqBsZDvGwW8E8xmFjxHtK1Yc7Tst3HUuVXpllTRP
 aw9n+neS0svVvNPvwyu2FXT2UtX+CB8IpGT/AgAK2ilxZFHv16HFKooc42z/HrT0VN/fK3y4Nhz
 5eSHTmzuXiYWEvm8sH8KvejFmEiokPnqStCwj13pgKtMHLE1xjnRU5PUF8KhsJnC9RqyoIBDCSo
 7P+RF6ezGM6gxPWDiUHf4rFcx96lIWXZYir318uPXfu1gawaJ5jGy3kl3npUF6d/ix7yb3NFg4F
 5Rl0JnlDg+36Za6NaCATh6lTUf7kB28HH2dAI6VOTHaQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=LFCh5TyN
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

RK3588 is using a generic CRU_BASE name for its SoC specific CRU base
address constant.

Add a RK3588 SoC prefix to the CRU_BASE constant, similar to how other
RK35xx CRU base address constants are named, to more easily distinguish
what SoC specific CRU base address the constant refers to.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/include/asm/arch-rockchip/cru_rk3588.h       | 2 +-
 board/theobroma-systems/jaguar_rk3588/jaguar_rk3588.c | 2 +-
 board/theobroma-systems/tiger_rk3588/tiger_rk3588.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
index 85cc17840436..2723a0a36fb4 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
@@ -63,7 +63,7 @@ struct rk3588_pll {
 	unsigned int reserved0[3];
 };
 
-#define CRU_BASE	0xfd7c0000
+#define RK3588_CRU_BASE			0xfd7c0000
 
 struct rk3588_cru {
 	struct rk3588_pll pll[18];
diff --git a/board/theobroma-systems/jaguar_rk3588/jaguar_rk3588.c b/board/theobroma-systems/jaguar_rk3588/jaguar_rk3588.c
index 5177aa9d6e80..840504c3f564 100644
--- a/board/theobroma-systems/jaguar_rk3588/jaguar_rk3588.c
+++ b/board/theobroma-systems/jaguar_rk3588/jaguar_rk3588.c
@@ -31,7 +31,7 @@ void setup_eth0refclko(void)
 {
 	/* Configure and enable ETH0_REFCLKO_25MHz */
 	static struct rk3588_bus_ioc * const bus_ioc = (void *)BUS_IOC_BASE;
-	static struct rk3588_cru * const cru = (void *)CRU_BASE;
+	static struct rk3588_cru * const cru = (void *)RK3588_CRU_BASE;
 
 	/* 1. Pinmux */
 	rk_clrsetreg(&bus_ioc->gpio2c_iomux_sel_l, GPIO2C3_SEL_MASK, GPIO2C3_ETH0_REFCLKO_25M);
diff --git a/board/theobroma-systems/tiger_rk3588/tiger_rk3588.c b/board/theobroma-systems/tiger_rk3588/tiger_rk3588.c
index a6d44f10db32..55f298adfc55 100644
--- a/board/theobroma-systems/tiger_rk3588/tiger_rk3588.c
+++ b/board/theobroma-systems/tiger_rk3588/tiger_rk3588.c
@@ -31,7 +31,7 @@ void setup_eth0refclko(void)
 {
 	/* Configure and enable ETH0_REFCLKO_25MHz */
 	static struct rk3588_bus_ioc * const bus_ioc = (void *)BUS_IOC_BASE;
-	static struct rk3588_cru * const cru = (void *)CRU_BASE;
+	static struct rk3588_cru * const cru = (void *)RK3588_CRU_BASE;
 
 	/* 1. Pinmux */
 	rk_clrsetreg(&bus_ioc->gpio2c_iomux_sel_l, GPIO2C3_SEL_MASK, GPIO2C3_ETH0_REFCLKO_25M);
-- 
2.54.0

