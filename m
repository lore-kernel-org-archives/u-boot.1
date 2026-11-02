Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C145B606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 13:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pIL9cISO
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 82FBE80E42;
	Mon,  2 Nov 2026 13:10:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YK0VcfA-eSdq; Mon,  2 Nov 2026 13:10:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7626E80E30
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793625034;
	b=cJplpYr8Yvl9QuxSUjNVGxyT+ZxAsGeAaQx7BHmPWwjKBb9CguuLEM5jjFkWcxfWx+HX
	 /KtLB6xSzB8WLEQR794pD1+TyzTYWv1ZDONzpwlSlWSlW6CZbKVYNRvcIUKEfOvJmTyos
	 asb51us7GuMY0DgvNHb+9KHTprFO61cjnRcPgvC0Fal/B2vYdwo5IrXvWtNIYRXGb/4wl
	 vDBAT3TCiqbVV7W22szhp39KWJD5TYPYG48tWz3mkU5/CNJnVg/eVCiSVST/Y1fSFEP2N
	 oSzH/unBcfUDS3X+/S/7q8bq/B09YTGNWurkTeMRCi+UtN1sh4hy+LR5WGronL0cIVg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793625034;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-ID:X-B4-Tracking:X-Change-ID:To:CC:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=y2km/T7yav/WpDzpAMHLqlR5ryOQD4FeIXB2Q+qW8X8=;
	b=WBybD6SZJod8RmV1Cc8Hc+3AfcMZLHftBDYnzkDbO1sNHm8EtkcSdL4TwiXSmG5Rf5Zh
	 8jC7M/R4fGS8oilnJEP+5ivtTbkP1cGDqI2jkqRP3VASRIGzwj8UrgnF7+ucHXO096QL5
	 jcw8IMSdGr1AaqOpWrn/7AcTN8pk5WRn/AzpJrESacEGQUxkTWsVh7TX8z7FOD2lNF5Sk
	 gJLD/qzu/ZMQB9BymOQhTaYKkCRcP+2Tt9K/dk1g0q7k7zLzQXWYoHQ/4Tt5AtsR4v7pX
	 WpaooFtzhiHA9Aunb3nzd7/9rqWZiQpBJQd1IxWFT4q0wlrPQw2qrMw0DWaGfhnZJ5g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793625034;
	bh=y2km/T7yav/WpDzpAMHLqlR5ryOQD4FeIXB2Q+qW8X8=;
	h=From:Date:Subject:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pIL9cISOGcp9oCQ+/buSoa9YMyc5c6Dz1Q6E/0hjmX/eTyzi8jgGtnh0TTEUQyAFB
	 vicrIXz2xRzN92VePOmikENhnqopQ0zehFIZt/Q0qCRz+jZBqaKhvbDvN2yxiEjhUV
	 OQIF/pGdWW9IHQlwTqphb+MdgHfKQvkzitj/j45G0lT8s8W6F9WT9sBb1hOTCTWCsL
	 ct0o8HJXZZZJKWCv+JSvbGH5OXklk11Ka+/6t47jofJxazZWooevOjsaOVa/7yKSMA
	 cBq99twQMm5xMakYUc+6J09xLocHagjrBC/sYA1M7wzgzYyzY02huTSlslfLsGtCaF
	 tbSUGmY46/9vQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7626E80E30;
	Mon,  2 Nov 2026 13:10:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 88FC8323
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 07:52:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7A7D460661
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 07:52:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xs3mFrWhJ5om for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 07:52:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B88116065F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793605963;
 b=WyFHAff9vJ1DFIPLhEYsTRaLj7+bWm8s95/Ud4GQTvdO4rOHz/PL9rUw7t2S1R7iDTkZ
 K/F4lL3AREQHMC4hkLTMJKDSZGZPcIc8/6EmLWYVWGnUCjCeOkrcaUirju7RDt18ZkHVi
 ZvDwCmeAE2TjAisH5B1a20MUrW8iuI+G8hXWFBywyJniEzCbB0cmUHO2yOEh0VSfv/skB
 AAjmKf2uLRtMnrjeB0Q556QHr5UxmT7fwspr5HYNblvwbVuqU4oh/Pw7K2olKN2y0v+Gz
 Rt3aBlZSQHLhwIUw2rLKAUN3qqSEOwG0OiEy2mEkd1mJdWl1Zw07i/MjaUuDVhwU6kg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793605963;
 h=X-Greylist:Received-SPF:Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
 X-B4-Tracking:X-Change-ID:To:CC:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=y2km/T7yav/WpDzpAMHLqlR5ryOQD4FeIXB2Q+qW8X8=;
 b=LPu/C0O8ZZc09W51MPU94cEDEW0Fr+dH/6V+LRqCsIkiKAyVGbdpKkSMoYUsaC4ebfph
 p3Bq+1N96zO0x22oH/kN0V7NKAZJMt9k56VJzVJGNTL3pZkucAZWNKetRPt1pDx09dIJG
 Rp8ddUrdxeQXF2/jg/FBPxMW6Afg8HnV7ldrZ+SsW2sJspUmatPRzEy6+kF064teUNm5I
 f6o2HmknX+knZzPGvzoucgZRBVp+Fto9ZQRAgmDGiZ4y/vj6AP6Kftci9//HJCg1JZkqC
 K4z0QBkP8tc1mZB1ghjx7K9joxEn5uDP9NE3F10vqIQFnvqmjhLK+7lXrNnwc1cVfTA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=aspeedtech.com;
 arc=none smtp.remote-ip=211.20.114.72
X-Greylist: delayed 304 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 02 Nov 2026 07:52:42 UTC
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=aspeedtech.com
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=211.20.114.72;
 helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com;
 receiver=<UNKNOWN> 
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B88116065F
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 07:52:42 +0000 (UTC)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 2 Nov
 2026 15:47:35 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 2 Nov 2026 15:47:35 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Mon, 2 Nov 2026 15:47:26 +0800
Subject: [PATCH] clk: ast2700: fix the gate clock enable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261102-upstream_soc_clk_enable-v1-1-3b769d629121@aspeedtech.com>
X-B4-Tracking: v=1; b=H4sIAA1A6GoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQwMj3dKC4pKi1MTc+OL85PjknOz41LzEpJxUXfNE00SzZENLk7TEVCW
 g7oKi1LTMCrDJ0bG1tQACrwdwaQAAAA==
X-Change-ID: 20261102-upstream_soc_clk_enable-7a5a6c194fae
To: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, <u-boot@lists.u-boot-project.org>
CC: Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Tom Rini
 <trini@konsulko.com>, Lukasz Majewski <lukma@nabladev.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793605655; l=9597;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=WKlJ4iSt41SRbl9H5vNGML08PiCoZ8Cf1DEMiD8B1Vc=;
 b=sQ/PPrHpsNKI5zrauLWZ5DFu6uzwX+gp/1I0Jmzox4zm/L7YtsacVyjXNrpkGVIc9btM3/h1J
 2v+/EsRB7sjB+d9O3G0TnWQhVZi7DaVVWGT2MqWPB73T1UhKTgDMEh2
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=
X-Mailman-Approved-At: Mon, 02 Nov 2026 13:10:33 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The SoC0/SoC1 clock enable callbacks use the clock ID as the bit in the
clock stop register. The IDs from dt-bindings/clock/aspeed,ast2700-scu.h
are sequential numbers, not bit positions, so most gates are never
opened and other IDs clear an unrelated gate. For example, the MAC
clocks stay stopped and the MACs do not work in U-Boot.

Map each clock ID to the offset and bit of its gate in a struct
ast2700_clk_info table, as the Linux clk-ast2700 driver does. An
unknown clock ID or a clock that is not a gate returns an error.

Fixes: 0758fddb3729 ("clk: ast2700: add clock driver support")
Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
The AST2700 SoC0/SoC1 clock enable callbacks use the clock ID as the bit
in the clock stop register, so most gates are never opened. Map each
clock ID to its gate offset and bit, as the Linux clk-ast2700 driver does.

Tested on the AST2700 EVB: the MAC0/MAC1 clocks are opened and eth0/eth1
work at 1G (dhcp and tftp) in U-Boot.
---
 drivers/clk/aspeed/clk_ast2700.c | 180 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 170 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/aspeed/clk_ast2700.c b/drivers/clk/aspeed/clk_ast2700.c
index ca76abef48f..2ca97c6e487 100644
--- a/drivers/clk/aspeed/clk_ast2700.c
+++ b/drivers/clk/aspeed/clk_ast2700.c
@@ -15,6 +15,10 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+#define SCU0_CLK_STOP_CLR	0x244
+#define SCU1_CLK_STOP_CLR	0x244
+#define SCU1_CLK_STOP2_CLR	0x264
+
 /**
  * RGMII clock source tree
  * HPLL -->|\
@@ -39,6 +43,52 @@ struct ast2700_clk_priv {
 	ast2700_clk_init_fn init;
 };
 
+/**
+ * enum ast2700_clk_type - type of a clock in the clock info tables
+ * @AST2700_CLK_GATE: gate, enabled by writing 1 to its bit in a clock stop
+ *		      clear register
+ */
+enum ast2700_clk_type {
+	AST2700_CLK_GATE,
+};
+
+/**
+ * struct ast2700_clk_gate_data - gate of a clock
+ * @reg: offset of the clock stop clear register in the SCU
+ * @bit: bit of the gate in @reg
+ */
+struct ast2700_clk_gate_data {
+	u32 reg;
+	u8 bit;
+};
+
+/**
+ * struct ast2700_clk_info - description of a clock
+ * @id: clock ID from dt-bindings/clock/aspeed,ast2700-scu.h
+ * @type: type of the clock, one of &enum ast2700_clk_type
+ * @data: type specific data
+ * @data.gate: gate data, for %AST2700_CLK_GATE
+ */
+struct ast2700_clk_info {
+	u32 id;
+	u32 type;
+	union {
+		struct ast2700_clk_gate_data gate;
+	} data;
+};
+
+#define GATE_CLK(_id, _reg, _bit)		\
+	{					\
+		.id = _id,			\
+		.type = AST2700_CLK_GATE,	\
+		.data = {			\
+			.gate = {		\
+				.reg = _reg,	\
+				.bit = _bit,	\
+			},			\
+		},				\
+	}
+
 static u32 ast2700_soc1_get_pll_rate(struct ast2700_scu1 *scu, int pll_idx)
 {
 	union ast2700_pll_reg pll_reg;
@@ -291,18 +341,83 @@ static ulong ast2700_soc1_clk_get_rate(struct clk *clk)
 	return rate;
 }
 
+static const struct ast2700_clk_info ast2700_soc1_clk_info[] = {
+	GATE_CLK(SCU1_CLK_GATE_LCLK0, SCU1_CLK_STOP_CLR, 0),
+	GATE_CLK(SCU1_CLK_GATE_LCLK1, SCU1_CLK_STOP_CLR, 1),
+	GATE_CLK(SCU1_CLK_GATE_ESPI0CLK, SCU1_CLK_STOP_CLR, 2),
+	GATE_CLK(SCU1_CLK_GATE_ESPI1CLK, SCU1_CLK_STOP_CLR, 3),
+	GATE_CLK(SCU1_CLK_GATE_SDCLK, SCU1_CLK_STOP_CLR, 4),
+	GATE_CLK(SCU1_CLK_GATE_IPEREFCLK, SCU1_CLK_STOP_CLR, 5),
+	GATE_CLK(SCU1_CLK_GATE_REFCLK, SCU1_CLK_STOP_CLR, 6),
+	GATE_CLK(SCU1_CLK_GATE_LPCHCLK, SCU1_CLK_STOP_CLR, 7),
+	GATE_CLK(SCU1_CLK_GATE_MAC0CLK, SCU1_CLK_STOP_CLR, 8),
+	GATE_CLK(SCU1_CLK_GATE_MAC1CLK, SCU1_CLK_STOP_CLR, 9),
+	GATE_CLK(SCU1_CLK_GATE_MAC2CLK, SCU1_CLK_STOP_CLR, 10),
+	GATE_CLK(SCU1_CLK_GATE_UART0CLK, SCU1_CLK_STOP_CLR, 11),
+	GATE_CLK(SCU1_CLK_GATE_UART1CLK, SCU1_CLK_STOP_CLR, 12),
+	GATE_CLK(SCU1_CLK_GATE_UART2CLK, SCU1_CLK_STOP_CLR, 13),
+	GATE_CLK(SCU1_CLK_GATE_UART3CLK, SCU1_CLK_STOP_CLR, 14),
+	GATE_CLK(SCU1_CLK_GATE_I2CCLK, SCU1_CLK_STOP_CLR, 15),
+	GATE_CLK(SCU1_CLK_GATE_I3C0CLK, SCU1_CLK_STOP_CLR, 16),
+	GATE_CLK(SCU1_CLK_GATE_I3C1CLK, SCU1_CLK_STOP_CLR, 17),
+	GATE_CLK(SCU1_CLK_GATE_I3C2CLK, SCU1_CLK_STOP_CLR, 18),
+	GATE_CLK(SCU1_CLK_GATE_I3C3CLK, SCU1_CLK_STOP_CLR, 19),
+	GATE_CLK(SCU1_CLK_GATE_I3C4CLK, SCU1_CLK_STOP_CLR, 20),
+	GATE_CLK(SCU1_CLK_GATE_I3C5CLK, SCU1_CLK_STOP_CLR, 21),
+	GATE_CLK(SCU1_CLK_GATE_I3C6CLK, SCU1_CLK_STOP_CLR, 22),
+	GATE_CLK(SCU1_CLK_GATE_I3C7CLK, SCU1_CLK_STOP_CLR, 23),
+	GATE_CLK(SCU1_CLK_GATE_I3C8CLK, SCU1_CLK_STOP_CLR, 24),
+	GATE_CLK(SCU1_CLK_GATE_I3C9CLK, SCU1_CLK_STOP_CLR, 25),
+	GATE_CLK(SCU1_CLK_GATE_I3C10CLK, SCU1_CLK_STOP_CLR, 26),
+	GATE_CLK(SCU1_CLK_GATE_I3C11CLK, SCU1_CLK_STOP_CLR, 27),
+	GATE_CLK(SCU1_CLK_GATE_I3C12CLK, SCU1_CLK_STOP_CLR, 28),
+	GATE_CLK(SCU1_CLK_GATE_I3C13CLK, SCU1_CLK_STOP_CLR, 29),
+	GATE_CLK(SCU1_CLK_GATE_I3C14CLK, SCU1_CLK_STOP_CLR, 30),
+	GATE_CLK(SCU1_CLK_GATE_I3C15CLK, SCU1_CLK_STOP_CLR, 31),
+	GATE_CLK(SCU1_CLK_GATE_UART5CLK, SCU1_CLK_STOP2_CLR, 0),
+	GATE_CLK(SCU1_CLK_GATE_UART6CLK, SCU1_CLK_STOP2_CLR, 1),
+	GATE_CLK(SCU1_CLK_GATE_UART7CLK, SCU1_CLK_STOP2_CLR, 2),
+	GATE_CLK(SCU1_CLK_GATE_UART8CLK, SCU1_CLK_STOP2_CLR, 3),
+	GATE_CLK(SCU1_CLK_GATE_UART9CLK, SCU1_CLK_STOP2_CLR, 4),
+	GATE_CLK(SCU1_CLK_GATE_UART10CLK, SCU1_CLK_STOP2_CLR, 5),
+	GATE_CLK(SCU1_CLK_GATE_UART11CLK, SCU1_CLK_STOP2_CLR, 6),
+	GATE_CLK(SCU1_CLK_GATE_UART12CLK, SCU1_CLK_STOP2_CLR, 7),
+	GATE_CLK(SCU1_CLK_GATE_FSICLK, SCU1_CLK_STOP2_CLR, 8),
+	GATE_CLK(SCU1_CLK_GATE_LTPIPHYCLK, SCU1_CLK_STOP2_CLR, 9),
+	GATE_CLK(SCU1_CLK_GATE_LTPICLK, SCU1_CLK_STOP2_CLR, 10),
+	GATE_CLK(SCU1_CLK_GATE_VGALCLK, SCU1_CLK_STOP2_CLR, 11),
+	GATE_CLK(SCU1_CLK_GATE_UHCICLK, SCU1_CLK_STOP2_CLR, 12),
+	GATE_CLK(SCU1_CLK_GATE_CANCLK, SCU1_CLK_STOP2_CLR, 13),
+	GATE_CLK(SCU1_CLK_GATE_PCICLK, SCU1_CLK_STOP2_CLR, 14),
+	GATE_CLK(SCU1_CLK_GATE_SLICLK, SCU1_CLK_STOP2_CLR, 15),
+	GATE_CLK(SCU1_CLK_GATE_E2MCLK, SCU1_CLK_STOP2_CLR, 16),
+	GATE_CLK(SCU1_CLK_GATE_PORTCUSB2CLK, SCU1_CLK_STOP2_CLR, 17),
+	GATE_CLK(SCU1_CLK_GATE_PORTDUSB2CLK, SCU1_CLK_STOP2_CLR, 18),
+	GATE_CLK(SCU1_CLK_GATE_LTPI1TXCLK, SCU1_CLK_STOP2_CLR, 19),
+};
+
 static int ast2700_soc1_clk_enable(struct clk *clk)
 {
 	struct ast2700_clk_priv *priv = dev_get_priv(clk->dev);
-	struct ast2700_scu1 *scu = (struct ast2700_scu1 *)priv->reg;
-	u32 clkgate_bit;
+	const struct ast2700_clk_info *info = NULL;
+	int i;
 
-	if (clk->id >= 32)
-		clkgate_bit = BIT(clk->id - 32);
-	else
-		clkgate_bit = BIT(clk->id);
+	for (i = 0; i < ARRAY_SIZE(ast2700_soc1_clk_info); i++) {
+		if (ast2700_soc1_clk_info[i].id == clk->id) {
+			info = &ast2700_soc1_clk_info[i];
+			break;
+		}
+	}
+
+	if (!info) {
+		pr_err("scu1: unknown clock ID %lu\n", clk->id);
+		return -ENOENT;
+	}
+
+	if (info->type != AST2700_CLK_GATE)
+		return -EINVAL;
 
-	writel(clkgate_bit, &scu->clkgate_clr1);
+	writel(BIT(info->data.gate.bit), priv->reg + info->data.gate.reg);
 
 	return 0;
 }
@@ -711,13 +826,58 @@ static ulong ast2700_soc0_clk_get_rate(struct clk *clk)
 	return rate;
 }
 
+static const struct ast2700_clk_info ast2700_soc0_clk_info[] = {
+	GATE_CLK(SCU0_CLK_GATE_MCLK, SCU0_CLK_STOP_CLR, 0),
+	GATE_CLK(SCU0_CLK_GATE_ECLK, SCU0_CLK_STOP_CLR, 1),
+	GATE_CLK(SCU0_CLK_GATE_2DCLK, SCU0_CLK_STOP_CLR, 2),
+	GATE_CLK(SCU0_CLK_GATE_VCLK, SCU0_CLK_STOP_CLR, 3),
+	GATE_CLK(SCU0_CLK_GATE_BCLK, SCU0_CLK_STOP_CLR, 4),
+	GATE_CLK(SCU0_CLK_GATE_VGA0CLK, SCU0_CLK_STOP_CLR, 5),
+	GATE_CLK(SCU0_CLK_GATE_REFCLK, SCU0_CLK_STOP_CLR, 6),
+	GATE_CLK(SCU0_CLK_GATE_PORTBUSB2CLK, SCU0_CLK_STOP_CLR, 7),
+	GATE_CLK(SCU0_CLK_GATE_UHCICLK, SCU0_CLK_STOP_CLR, 9),
+	GATE_CLK(SCU0_CLK_GATE_VGA1CLK, SCU0_CLK_STOP_CLR, 10),
+	GATE_CLK(SCU0_CLK_GATE_DDRPHYCLK, SCU0_CLK_STOP_CLR, 11),
+	GATE_CLK(SCU0_CLK_GATE_E2M0CLK, SCU0_CLK_STOP_CLR, 12),
+	GATE_CLK(SCU0_CLK_GATE_HACCLK, SCU0_CLK_STOP_CLR, 13),
+	GATE_CLK(SCU0_CLK_GATE_PORTAUSB2CLK, SCU0_CLK_STOP_CLR, 14),
+	GATE_CLK(SCU0_CLK_GATE_UART4CLK, SCU0_CLK_STOP_CLR, 15),
+	GATE_CLK(SCU0_CLK_GATE_SLICLK, SCU0_CLK_STOP_CLR, 16),
+	GATE_CLK(SCU0_CLK_GATE_DACCLK, SCU0_CLK_STOP_CLR, 17),
+	GATE_CLK(SCU0_CLK_GATE_DP, SCU0_CLK_STOP_CLR, 18),
+	GATE_CLK(SCU0_CLK_GATE_E2M1CLK, SCU0_CLK_STOP_CLR, 19),
+	GATE_CLK(SCU0_CLK_GATE_CRT0CLK, SCU0_CLK_STOP_CLR, 20),
+	GATE_CLK(SCU0_CLK_GATE_CRT1CLK, SCU0_CLK_STOP_CLR, 21),
+	GATE_CLK(SCU0_CLK_GATE_ECDSACLK, SCU0_CLK_STOP_CLR, 23),
+	GATE_CLK(SCU0_CLK_GATE_RSACLK, SCU0_CLK_STOP_CLR, 24),
+	GATE_CLK(SCU0_CLK_GATE_RVAS0CLK, SCU0_CLK_STOP_CLR, 25),
+	GATE_CLK(SCU0_CLK_GATE_UFSCLK, SCU0_CLK_STOP_CLR, 26),
+	GATE_CLK(SCU0_CLK_GATE_EMMCCLK, SCU0_CLK_STOP_CLR, 27),
+	GATE_CLK(SCU0_CLK_GATE_RVAS1CLK, SCU0_CLK_STOP_CLR, 28),
+};
+
 static int ast2700_soc0_clk_enable(struct clk *clk)
 {
 	struct ast2700_clk_priv *priv = dev_get_priv(clk->dev);
-	struct ast2700_scu0 *scu = (struct ast2700_scu0 *)priv->reg;
-	u32 clkgate_bit = BIT(clk->id);
+	const struct ast2700_clk_info *info = NULL;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ast2700_soc0_clk_info); i++) {
+		if (ast2700_soc0_clk_info[i].id == clk->id) {
+			info = &ast2700_soc0_clk_info[i];
+			break;
+		}
+	}
+
+	if (!info) {
+		pr_err("scu0: unknown clock ID %lu\n", clk->id);
+		return -ENOENT;
+	}
+
+	if (info->type != AST2700_CLK_GATE)
+		return -EINVAL;
 
-	writel(clkgate_bit, &scu->clkgate_clr);
+	writel(BIT(info->data.gate.bit), priv->reg + info->data.gate.reg);
 
 	return 0;
 }

---
base-commit: 3401e006432abcbf7d73d7210f10df157f990ed3
change-id: 20261102-upstream_soc_clk_enable-7a5a6c194fae

Best regards,
-- 
Ryan Chen <ryan_chen@aspeedtech.com>

