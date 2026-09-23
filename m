Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B6AC982FA
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 09:35:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CBCE060752;
	Wed, 23 Sep 2026 09:35:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0CMmnASq3y5X; Wed, 23 Sep 2026 09:35:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B8645607DD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790156113;
	b=hB5K5HsZIhrmP06ZZOM3PS8n4xtIrProSf/iTkNCQZd8QRSlLewaZRQufzSm+5ul1n+G
	 THSb0AWU+BkH9R0TCJpEwi6uV+xCGdQBGqMe9ABqSu/LnD4SgrT+vUeBlM1yR4GWmuVDW
	 g7tpx8MjuNvq3Pv7+E1pE9O5BGs7llsVmlYYNlkyaSk+cNx3INA8dPxIzVP6LirE+/uEt
	 z7KwE9wDskiV3lWei0tS2PZsrtnKQqL9arFWtegu+jB+7Uyr3KoB3KRyGzDVa6d5f6HDs
	 BFiaIWJM/8SRJ135aX7CeuV4nvjHy/QUPQ7RuQHpLPjcagQo4yADO16RNjzdqsWUITg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790156113;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7x35Ic33Aq4gkFACjIzfADU9VYTPmYUU9RwTTXMZvEQ=;
	b=H4VBpH0Z/h44mTx/D7FlN16GxyAYG3ZOGUN20F+m8lb8Hdw9sUmvlh8ZBBrlAE+5G9ey
	 qckA7KXe62x/XY7EFgBWqVMLmEOzWwJtfRoPiNZpJNGNlVBpN6yYbIty3o+p4tkXvgY79
	 BDE0ZROnXG6FHS6F3/qkCOTENUTydINZ7oaqtJ1PgJNOLciAD51oyydzVYlfEnTV5Y+1c
	 l2GRUCRArLSIYxZ+YtVzx+wHAbNQRJrY9TS5/MnY3ciwrnMA2StDvkJFEquvtTWhFuZ4w
	 Cby2bKd3Ng8qk7+6iukanz/AH1FzyfD9k+XR0Z1nVqGzjvu7N2xY8tlIbEgzt+gQS9Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="A+/oJHva";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790156113;
	bh=7x35Ic33Aq4gkFACjIzfADU9VYTPmYUU9RwTTXMZvEQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MYdl6N8E4WG3uVU/4OrLdQ5SNXV+CEIvqJH0U75JrLH8AMkrC5w72/74tXpUD3vYt
	 8VkZQvSA8zi7z2xVyXlkPh5R4i27K4wlY3+Tjch0XcBW3Q+HcrpocyjeG2ZPo8mT1x
	 gI6K8jiKatYm8fhHm1LE9MNm4G2CYQ5oPqt49giZ5QpwYJrwYxuVrhpO34wtrFwKTE
	 jd5FtmpwTMjxfWOnGbenHtGQeVtZMVl9rL60VZ0XSRuDQDLlySty3yJxnVcXoyXvS+
	 PTLZRPXoWinFVeddA1MjUDsBEgdN7CkgcMets34Aqn9QlExkve8kCCHsK+XdYmcws/
	 xhNaqSG3exquQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B8645607DD;
	Wed, 23 Sep 2026 09:35:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 64E3CD1
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 09:35:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 47FD7606B6
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 09:35:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F5pxs0yOMTbL for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 09:35:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4299E607ED
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790156110;
 b=f8+L8+9B1s5GeFHVt0pS2QBfln5OwqXvrmVxQghM6kmzveS6KF4zLKOS7HlB19e2LdUm
 C2JGYokO6BjsM2Q4tbzgj32l0f0wl3E01IIUEnecCZei+S15rYaqVdCrCOwhP8xGLOG3z
 dOu26gsre3wLh5GOLu2MbvWAjSWoS0pXWjkf2m3mba5jm3GZb/DdwCuTrlerc/LfyCiOV
 DwNa+FE165BTcyd7AO+i54Gae/0xOvW4jVsvMhJ00rD43+82m3NrlEzGB7917+i3HLvL4
 6ynJaGe9I4YO/p/pIJSQvelSxERaybNnT3oAQdq5YsSZM7OgE64+/MbdUltkth7ed4g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790156110;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=7x35Ic33Aq4gkFACjIzfADU9VYTPmYUU9RwTTXMZvEQ=;
 b=C8/ndYNLrj5hMEyQKJVCUvgKBLlW1MrTRgJNcYp50CmILpcblbOyR4Saw9VfXjLH2vDX
 4h8w8Fu1GH/V5GJKJBQGep+wL1sbIjzmwwEtILvbbqlwODFXW2fMRM5iHuhHgbOuO9Q2V
 cyPTZMcaaHfeaL4/3f8GrdPdRW9x7KJS/ouSAoVT6Gt7DuaEphlzgykTqlmJixQRS/Bw5
 4NWIrX3OpWyNQ0CioVEStu5HzpvfTjx8HzrOHpSyyu8PMibh8RLtetDGd+dkqzV7Q28rF
 2cb7mSoVnqdNX1ujLJhPNCJp3ETv2wYNmEN4iBO+wNj/MR4fmSPnPBBcWKl7OiBJ9fA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="A+/oJHva"; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=A+/oJHva
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4299E607ED
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 09:35:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AAF04601F0;
 Wed, 23 Sep 2026 09:35:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77141F00893;
 Wed, 23 Sep 2026 09:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790156108;
 bh=7x35Ic33Aq4gkFACjIzfADU9VYTPmYUU9RwTTXMZvEQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=A+/oJHvaoA3JSLQ+9jvY2PnrMhQI2wAa2MY+iZw8v8UTOBjolqJlkiyaLhTee1CWW
 zmS2zxIe0VOQ7uO6uC7AhHWKyZbqofmQ0fROrT+uinl7O8BSFYBmlPj3p5+CLJeA+8
 hhMTxDAzSwqgkPJoEJwxSF06fF0WmqgfdyT440B79xkKgDrw4U2QJAljDxZ9DcZ+8w
 +UIKbhr8Ab3PD8miSTvcDJfpByTWgzEPZer0u55f88qrMiZngZ7BnsDBy4vVlrMAGN
 xOW4px7AjoaNqmvHWSCNYmDAYpd97fhA1yjpYIpPxW5B31+XFPo6GMJj5B51/ievIj
 8GJXCHe82aF4g==
From: Yixun Lan <dlan@kernel.org>
Date: Wed, 23 Sep 2026 09:34:26 +0000
Subject: [PATCH v2 3/8] clk: spacemit: ccu_pll: add plla type clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-01-k3-clock-reset-support-v2-3-6ec0abb1c7b5@kernel.org>
References: <20260923-01-k3-clock-reset-support-v2-0-6ec0abb1c7b5@kernel.org>
In-Reply-To: <20260923-01-k3-clock-reset-support-v2-0-6ec0abb1c7b5@kernel.org>
To: u-boot@lists.u-boot-project.org
Cc: spacemit@lists.linux.dev, u-boot-spacemit@groups.io, 
 Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Guodong Xu <guodong.xu@oss.qualcomm.com>, Peng Fan <peng.fan@nxp.com>, 
 Torsten Duwe <duwe@suse.de>, Ryan Chen <ryan_chen@aspeedtech.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Alexey Charkov <alchark@flipper.net>, 
 Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7457; i=dlan@kernel.org;
 h=from:subject:message-id; bh=JP7DEjP7awEWWLjW9vIGisEhSJhFiA0Totop8y8QqeQ=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqs50thcHCTqfg2LvtjAXCIGeUo2g35vmsHqOLq
 Y9VasnkLLOJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCarOdLRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+3mSRAAnpNtz8VW8NGgQM2jvu8xdfCj7C36dSJfECasSpdkd85NQWhj7IFov
 9TZFL1+Tf2S6M4hdVPRgIVWjqesw0zsmidwRCDCaQOgnbIqFOACrAhkXVTAi8jjzBCK3OBoZ6e2
 iISdVm02fXLEw0Hkf+Gy/RCHQe4SSe4AZJdVLxwVcUFSvkebRq3XY8Kgxt4y2As1/gQIPttrDFW
 p+rG/oF/rQuxQwCNTA3ubJGhkOmPeCIdxsDluhiZg8DQs9wvXqEZfOhV9oJ8ug4qUfiJICp9huw
 /tmBI9blB5Tmy4TUw3kHvqeIybUIpi3UowAa5DwLE9CdGuunMFxbggQrQPTOHJS5kXs4z1r8Ark
 vBg0M/IQKpuzq4MW9J3BtzDyBhTyK3G9mVXOLhLji1biT9g39orZNj9S/rohDclDigP+U72h/RF
 byhSfaa4I1W5rD8/CcWGyR2XladaqDcx2LlOm95NK1TeN2yL0DSB+GnwUkl2xUXG7x68nqvRgoh
 1csJWZb7Fbs7ti4ALsx9P2463pc9KXeRt4o8xSvitPyiYNdFiDgS1fUyYgWVjem2NxUpqagF/Il
 mvkKGtjcJBpXMZCCb5mwP6wNsQWNYPMkMY5wMM2AtypxMRNyQUpHamTN1oB6YF40GSCxajW4oJv
 JLDMxnRoEJU//D4c39y6Rv5O8yYXgw=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
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

Based on upstream Linux:
  3a086236c600 ("clk: spacemit: ccu_pll: add plla type clock")

Introduce a new clock PLLA for SpacemiT's K3 SoC which has a different
register layout comparing to previous PPL type. And, It is configured
by swcr1, swcr3 and swcr2 BIT[15:8].

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 drivers/clk/spacemit/clk_common.h |   1 +
 drivers/clk/spacemit/clk_pll.c    | 124 +++++++++++++++++++++++++++++++++++++-
 drivers/clk/spacemit/clk_pll.h    |  43 +++++++++++--
 3 files changed, 163 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/spacemit/clk_common.h b/drivers/clk/spacemit/clk_common.h
index ea5ebf57784..60702414f2b 100644
--- a/drivers/clk/spacemit/clk_common.h
+++ b/drivers/clk/spacemit/clk_common.h
@@ -36,6 +36,7 @@ struct ccu_common {
 		/* For PLL */
 		struct {
 			u32 reg_swcr1;
+			u32 reg_swcr2;
 			u32 reg_swcr3;
 		};
 	};
diff --git a/drivers/clk/spacemit/clk_pll.c b/drivers/clk/spacemit/clk_pll.c
index 56da70af58a..36de37c3a25 100644
--- a/drivers/clk/spacemit/clk_pll.c
+++ b/drivers/clk/spacemit/clk_pll.c
@@ -13,7 +13,8 @@
 
 #include "clk_pll.h"
 
-#define UBOOT_DM_SPACEMIT_CLK_PLL "spacemit_clk_pll"
+#define UBOOT_DM_SPACEMIT_CLK_PLL	"spacemit_clk_pll"
+#define UBOOT_DM_SPACEMIT_CLK_PLLA	"spacemit_clk_plla"
 
 #define PLL_TIMEOUT_US		3000
 #define PLL_DELAY_US		5
@@ -21,6 +22,9 @@
 #define PLL_SWCR3_EN		((u32)BIT(31))
 #define PLL_SWCR3_MASK		GENMASK(30, 0)
 
+#define PLLA_SWCR2_EN		((u32)BIT(16))
+#define PLLA_SWCR2_MASK		GENMASK(15, 8)
+
 static const struct ccu_pll_rate_tbl *ccu_pll_lookup_best_rate(struct ccu_pll *pll,
 							       unsigned long rate)
 {
@@ -155,3 +159,121 @@ U_BOOT_DRIVER(spacemit_clk_pll) = {
 	.ops	= &spacemit_clk_pll_ops,
 	.flags	= DM_FLAG_PRE_RELOC,
 };
+
+static const struct ccu_pll_rate_tbl *ccu_plla_lookup_matched_entry(struct ccu_pll *pll)
+{
+	struct ccu_pll_config *config = &pll->config;
+	const struct ccu_pll_rate_tbl *entry;
+	u32 i, swcr1, swcr2, swcr3;
+
+	swcr1 = ccu_read(&pll->common, swcr1);
+	swcr2 = ccu_read(&pll->common, swcr2);
+	swcr2 &= PLLA_SWCR2_MASK;
+	swcr3 = ccu_read(&pll->common, swcr3);
+
+	for (i = 0; i < config->tbl_num; i++) {
+		entry = &config->rate_tbl[i];
+
+		if (swcr1 == entry->swcr1 &&
+		    swcr2 == entry->swcr2 &&
+		    swcr3 == entry->swcr3)
+			return entry;
+	}
+
+	return NULL;
+}
+
+static void ccu_plla_update_param(struct ccu_pll *pll, const struct ccu_pll_rate_tbl *entry)
+{
+	struct ccu_common *common = &pll->common;
+
+	regmap_write(common->regmap, common->reg_swcr1, entry->swcr1);
+	regmap_write(common->regmap, common->reg_swcr3, entry->swcr3);
+	ccu_update(common, swcr2, PLLA_SWCR2_MASK, entry->swcr2);
+}
+
+static int ccu_plla_enable(struct clk *clk)
+{
+	struct ccu_pll *pll = clk_to_ccu_pll(clk);
+	struct ccu_common *common = &pll->common;
+	unsigned int tmp;
+
+	ccu_update(common, swcr2, PLLA_SWCR2_EN, PLLA_SWCR2_EN);
+
+	/* check lock status */
+	return regmap_read_poll_timeout(common->lock_regmap,
+					pll->config.reg_lock,
+					tmp,
+					tmp & pll->config.mask_lock,
+					PLL_DELAY_US, PLL_TIMEOUT_US);
+}
+
+static int ccu_plla_disable(struct clk *clk)
+{
+	struct ccu_common *common = clk_to_ccu_common(clk);
+
+	ccu_update(common, swcr2, PLLA_SWCR2_EN, 0);
+
+	return 0;
+}
+
+/*
+ * PLLAs must be gated before changing rate, which is ensured by
+ * flag CLK_SET_RATE_GATE.
+ */
+static unsigned long ccu_plla_set_rate(struct clk *clk, unsigned long rate)
+{
+	struct ccu_pll *pll = clk_to_ccu_pll(clk);
+	const struct ccu_pll_rate_tbl *entry;
+
+	entry = ccu_pll_lookup_best_rate(pll, rate);
+	ccu_plla_update_param(pll, entry);
+
+	return 0;
+}
+
+static unsigned long ccu_plla_recalc_rate(struct clk *clk)
+{
+	struct ccu_pll *pll = clk_to_ccu_pll(clk);
+	const struct ccu_pll_rate_tbl *entry;
+
+	entry = ccu_plla_lookup_matched_entry(pll);
+
+	WARN_ON_ONCE(!entry);
+
+	return entry ? entry->rate : 0;
+}
+
+static const struct clk_ops spacemit_clk_plla_ops = {
+	.enable = ccu_plla_enable,
+	.disable = ccu_plla_disable,
+	.set_rate = ccu_plla_set_rate,
+	.get_rate = ccu_plla_recalc_rate,
+};
+
+int spacemit_plla_init(struct ccu_common *common)
+{
+	struct clk *clk = &common->clk;
+	struct ccu_pll *pll = clk_to_ccu_pll(clk);
+	int ret;
+
+	ret = clk_register(clk, UBOOT_DM_SPACEMIT_CLK_PLLA,
+			   common->name, common->parents[0]);
+	if (ret)
+		return ret;
+
+	if (ccu_plla_lookup_matched_entry(pll))
+		return 0;
+
+	ccu_plla_disable(clk);
+	ccu_plla_update_param(pll, &pll->config.rate_tbl[0]);
+
+	return 0;
+}
+
+U_BOOT_DRIVER(spacemit_clk_plla) = {
+	.name	= UBOOT_DM_SPACEMIT_CLK_PLLA,
+	.id	= UCLASS_CLK,
+	.ops	= &spacemit_clk_plla_ops,
+	.flags	= DM_FLAG_PRE_RELOC,
+};
diff --git a/drivers/clk/spacemit/clk_pll.h b/drivers/clk/spacemit/clk_pll.h
index 3987cc1141b..0de027dc7a6 100644
--- a/drivers/clk/spacemit/clk_pll.h
+++ b/drivers/clk/spacemit/clk_pll.h
@@ -20,14 +20,28 @@
  * configuration.
  *
  * @rate:	PLL rate
- * @swcr1:	Register value of PLLX_SW1_CTRL (PLLx_SWCR1).
- * @swcr3:	Register value of the PLLx_SW3_CTRL's lowest 31 bits of
- *		PLLx_SW3_CTRL (PLLx_SWCR3). This highest bit is for enabling
- *		the PLL and not contained in this field.
+ * @swcr1:	Value of register PLLx_SW1_CTRL.
+ * @swcr2:	Value of register PLLAx_SW2_CTRL (PLLA only).
+ * @swcr3:	Value of register PLLx_SW3_CTRL.
+ *
+ * Regular PLL type
+ *  | Enable | swcr3 | PLLx_SW3_CTRL - BIT[31]    |
+ *  -----------------------------------------------
+ *  | Config | swcr1 | PLLx_SW1_CTRL - BIT[31:0]  |
+ *  |        | swcr2 | Not used                   |
+ *  |        | swcr3 | PLLx_SW3_CTRL - BIT[30:0]  |
+ *
+ * Special PLL type A
+ *  | Enable | swcr2 | PLLAx_SW2_CTRL - BIT[16]   |
+ *  -----------------------------------------------
+ *  | Config | swcr1 | PLLAx_SW1_CTRL - BIT[31:0] |
+ *  |        | swcr2 | PLLAx_SW2_CTRL - BIT[15:8] |
+ *  |        | swcr3 | PLLAx_SW3_CTRL - BIT[31:0] |
  */
 struct ccu_pll_rate_tbl {
 	unsigned long rate;
 	u32 swcr1;
+	u32 swcr2;
 	u32 swcr3;
 };
 
@@ -38,6 +52,14 @@ struct ccu_pll_rate_tbl {
 		.swcr3	= _swcr3,		\
 	}
 
+#define CCU_PLLA_RATE(_rate, _swcr1, _swcr2, _swcr3)	\
+	{						\
+		.rate	= _rate,			\
+		.swcr1	= _swcr1,			\
+		.swcr2	= _swcr2,			\
+		.swcr3	= _swcr3,			\
+	}
+
 struct ccu_pll_config {
 	const struct ccu_pll_rate_tbl *rate_tbl;
 	u32 tbl_num;
@@ -69,6 +91,18 @@ static struct ccu_pll _var = {							\
 	}									\
 }
 
+#define CCU_PLLA_DEFINE(_id, _var, _name, _parent, _table, _reg_swcr1,		\
+			_reg_swcr2, _reg_swcr3, _reg_lock, _mask_lock, _flags)	\
+static struct ccu_pll _var = {							\
+	.config	= CCU_PLL_CONFIG(_table, _reg_lock, _mask_lock),		\
+	.common = {								\
+		.reg_swcr1	= _reg_swcr1,					\
+		.reg_swcr2	= _reg_swcr2,					\
+		.reg_swcr3	= _reg_swcr3,					\
+		CCU_COMMON(_id, _name, _parent, spacemit_plla_init, _flags)	\
+	}									\
+}
+
 static inline struct ccu_pll *clk_to_ccu_pll(struct clk *clk)
 {
 	struct ccu_common *common = clk_to_ccu_common(clk);
@@ -77,5 +111,6 @@ static inline struct ccu_pll *clk_to_ccu_pll(struct clk *clk)
 }
 
 int spacemit_pll_init(struct ccu_common *common);
+int spacemit_plla_init(struct ccu_common *common);
 
 #endif /* _CLK_PLL_H_ */

-- 
2.55.0

