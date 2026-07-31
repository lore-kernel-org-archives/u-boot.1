Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76C6C55173
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 19:25:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A41D40FC0;
	Fri, 31 Jul 2026 19:25:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CdtErpv4r-EX; Fri, 31 Jul 2026 19:25:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2AD1C40F89
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785525917;
	bh=1hHWfQeY6PIsL27S+MLk+YEXOKZPsSYX/q2oqPF8Kg0=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Jz3q9nfYIbVOvVht2yGpzXXQoz/XxURwfLqM1kB0IHLoUm22C7TO2KPpJvbnj0Xs6
	 kNs4oSMgR962wkWUagEqQPvLoUh9XY+IWdpDwQ/mH6y0LMS9iqxXm6WSQIN8nwTqgO
	 rA8IO2QGg2RxHfvriKVglgI/+5mqVY5o+PcjoLTtBotEss18x3M9KNJzNfFlLb+LTa
	 bov1a5OWlAQ6yGsAbzZBCKLZosoy/wUNutmWU4vCsf+chxtnHAoh3ReF3CbvJW/q+g
	 NYpOSF8T/UbB5W7qczzdY+K6H6f0dzPG92zBhJUWOBAmdLbTPHuQbifUu0XBVxx9g1
	 xgoqQPIbXOFPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2AD1C40F89;
	Fri, 31 Jul 2026 19:25:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 609F227C
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 19:25:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5E27F80C71
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 19:25:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HNUGmiBY3m5F for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 19:25:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::29; helo=mail-oa1-x29.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D6C6180C70
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D6C6180C70
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D6C6180C70
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 19:25:14 +0000 (UTC)
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-44cf70de986so575608fac.0
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 12:25:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785525913; x=1786130713;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1hHWfQeY6PIsL27S+MLk+YEXOKZPsSYX/q2oqPF8Kg0=;
 b=o68b/H2DllZu9Zk+CRWr6kWFk3xhrTjMfPpttv+zh1YYGUGMsKqkxO5I8/UYoe5k7m
 2pH/5NaJ6KdJNTpLdkzKARQet32tZeldR9xbseFyzsV9FyooDJ7TKWI5W4eTiZ7mZsyB
 m8CZYqvHNo5D0oK2vgZP3SA1UKJd9zhwP84enhBy1XQEsPL1nihMc5XTt0qne4k4snxF
 T5pXIzMjBqhb3hIS1oZEm9B8jQUXSdlIIgySV59Ww0w1Gs0T+Iea1D+mW4Yk0OSHRPZm
 V49OQp7U5f3pBIhkbZJhnOvmZvGN+1Dnc2HW0pf2FGAkeOo3ZWPokycYU7VwNlMeSyjw
 oZJA==
X-Gm-Message-State: AOJu0YyF/uuLma6rK8BNyHnu2oX988sGbY3qkRHsUr1v0pWvOq30hvQh
 6sXKxT6tTxtdam5pox5tzhBonNw1tDAJ52ACF79DCBW7scZtqp0s0F4nS2+q8AjX2Xw=
X-Gm-Gg: AR+sD11WgP1SjG0BeCfPxmaA2kiuMZ5MVbC0cmLNhkx8mdFNM9QkpgoBPIHTmVqATQ/
 ajho//dtR/F+YMTQTU73K5Or6arDWPNW5y+J9cKuzn8s0md5HUY77VJKTFRBEKXTyQ8YmTp0+/7
 crqaH09H37G1jAepwRuLNOAhfgcRalKCqBZRuohGnQ/fvlDcHfJ+8TKtq/UhtM2TMetQ2UmmTh7
 AQH0V91OShO8hH73P1cf/aTefRjxMU/dt26keiKYkEa6WRKKVijAnuEsgPAcHxPvsq+m3s2TmVY
 SagsPQqrkeMtOBY8aUCSG2TPCQm6oAvN3nsLbdOkS9i7y6LnLDCzwc+iqX24ZDI1xiAz0JevKpj
 U/HjtKrF1DH9xQqBILZ0c7xHbU8dR3ZctrF2SHo0+cuQ3oYzzuEkV+xGkcXNdkYN6FU6uynptVh
 NA5b6cn/2qYQBHJjA2L/ExEOt95+1IHz7alaMDKX3Oj5PnbrxEcuGuaVYdHaOj/jv3Xg==
X-Received: by 2002:a05:6809:24c:10b0:497:df42:1dff with SMTP id
 5614622812f47-4af5dfd1063mr1948771b6e.1.1785525913390; 
 Fri, 31 Jul 2026 12:25:13 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:fa40:746f:401a:3b75])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4af58f25e00sm1318037b6e.14.2026.07.31.12.25.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 12:25:12 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 31 Jul 2026 14:25:02 -0500
Subject: [PATCH] clk: mediatek: mt8189: add missing qualifiers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-mtk-clk-mt8189-fix-missing-qualifiers-v1-1-92f3f0e44817@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNQQ6CMBBFr0Jm7SRtjdp6FeMC6hRHoGoHCAnh7
 o66+nnJz3srCBUmgXO1QqGZhZ9Zwe4qiPc6t4R8UwZn3NGc9haHscPYd7re+oCJFxxYhHOL76n
 uOTEVQW/CwSSXmmQDqOtVSJ+/zuX6Z5maB8XxK4dt+wC5G5aliQAAAA==
X-Change-ID: 20260731-mtk-clk-mt8189-fix-missing-qualifiers-80950f2fbf19
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1302; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=EKKjceCWiKfd+Xjkematt5KAmgl4LeUkda775wl5Z2w=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqbPaPqJDOzZGFSLRV8CpG3jtd85Vsxc7qTjMv8
 ACX+ZpTPYmJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCamz2jxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AyXYIAJZCmKevCaHfmObxx2G2OXfjS+PJBlzSHbvCIIc
 zU7StYYfjFHC4S57fWROZpHPkP2bDnxmUGSfD26ru1FiyNWkDf+WdO8Bgsd3lIr4GT7kF9qmajE
 8f3R1gzCRed9RkWBEiaUGVPrs5K/2amMrk58dh/3yqW6j+2BOQ1xbx33w2SHUyzppUhI23H5jmx
 HMUdUf1OGGmh5sub2SoiB+4Tc3VzP0czuYAt3wcKakqYxNqNIy2zL4QdR3aBgpjA6j+SDXeJeCk
 cm8TqLh0gCXzXfzjiAI5zLy9/5qLkuWQ8NRRPlnXE1xWJolnKXivA0bPeFKUZ02jOtuJYW9yToM
 Wl1Y=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785525913; x=1786130713;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1hHWfQeY6PIsL27S+MLk+YEXOKZPsSYX/q2oqPF8Kg0=;
 b=djBi6AqBvimgGrbUXdmCRgZkIMHBKHMOpOx9VhrF9OFvL1krKA2e0YqiTj3tLBaJza
 NPY4kZGxbgMcGWewfmlav2nHWQWTPhgKBVnDwGjfPE4uFjjyEFS32ylhjLtROs55vAap
 uDM06vWWDPkeKAyPk0iYx7K0FVP+pQ/H3rSVGbQ2qva5Z1Ls4Sz/sBbEke/ZEQU/5t38
 xuEhShu/to6pjCI93XMYGxYk0HUoLVaBZ9on4bRGVHpvZ1FfSDZyy+KxmlPRq2EdfMB/
 V7XK7sBgUKwc84JToKf3i2lLMP9jDaWkeDSrCc3fqe/DNEo4xy4qGkNrpXdWITl2RkHp
 HT7Q==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=djBi6AqB
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

Add a missing const and a missing static qualifier to a couple of
lookup tables.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8189.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8189.c b/drivers/clk/mediatek/clk-mt8189.c
index 15e040569e7..3724dffcc3a 100644
--- a/drivers/clk/mediatek/clk-mt8189.c
+++ b/drivers/clk/mediatek/clk-mt8189.c
@@ -291,7 +291,7 @@ enum {
 	CLK_PAD_AUD_ADC_EXT,
 };
 
-static ulong ext_clock_rates[] = {
+static const ulong ext_clock_rates[] = {
 	[CLK_PAD_CLK32K] = 32000,
 	[CLK_PAD_CLK26M] = 26 * MHZ,
 	[CLK_PAD_ULPOSC] = 260 * MHZ,
@@ -1124,7 +1124,7 @@ static const struct mtk_parent ecc_parents[] = {
 			      _mux_clr_ofs, _shift, _width, _gate,		\
 			      _upd_ofs, _upd, CLK_MUX_SETCLR_UPD)
 
-const struct mtk_composite top_muxes[] = {
+static const struct mtk_composite top_muxes[] = {
 	/* CLK_CFG_0 */
 	MUX_CLR_SET_UPD(CLK_TOP_AXI_SEL, axi_parents, CLK_CFG_0, CLK_CFG_0_SET,
 			CLK_CFG_0_CLR, 0, 3, CLK_CFG_UPDATE, TOP_MUX_AXI_SHIFT),

---
base-commit: 11dfa5a8d20610ad7ca015a25cdcdf0bb35ff05b
change-id: 20260731-mtk-clk-mt8189-fix-missing-qualifiers-80950f2fbf19

Best regards,
--  
David Lechner <dlechner@baylibre.com>

