Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FAFEC3ABCB
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 16:52:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13CE180C83;
	Mon, 12 May 2025 18:52:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="YF/hIOms";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="E+59ADgT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5A69826AA; Mon, 12 May 2025 18:52:02 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6C6680584
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 18:52:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Zx5HN433Tz9sT5;
 Mon, 12 May 2025 18:52:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1747068720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=m+8CVpSWIQnPfOqKuhzmTPXIM72v2enAayPD9nl27sA=;
 b=YF/hIOms4LuaffTyBMdDV31qHwfrfwfXHjFIWbVqIBjUa+CjoBFCFk301ZBagLvrMM5CsU
 4Lah50Hm7JFlux5OFUii+AGHZkaQvxqF8WRqh73kBSwxvF1DsVUTxY9jFIljd3cMNsEJK/
 gKQ2ij9blifuPSDKxj+PQ4rXrtzryFxFMZgl4qret4zq4F7hCGbq1DI+a8FviDpbohy7ot
 vuYJzFjPcRYINky/0/u9u3bYeZzuWQHFO8E332sXn3Zw2BVbwFmE5SBv1i6r1JLE08Rn/k
 m6iapt9KaKaYe337VOn6w1JfWnv0qwuemkpU7Qhfg4vTRfw/Yl19LgQuZOw9DQ==
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1747068718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=m+8CVpSWIQnPfOqKuhzmTPXIM72v2enAayPD9nl27sA=;
 b=E+59ADgTUl39dwWRseI5M3zRU+2atmsD3XXb+ACQ0LHIra41OWo2OK0Gt9s6p7qApRACgn
 iXlYHZ344y1f2GdRL8f/JHjqt1byXw1nZ+bn639LrH60z7WKNgzqqb5QGJzvuu2efmI6sJ
 defmlPudfjoj92OnYjjDJS30I3KXSaYfiIy/ssX2JVpvPj321F4ZKW+Llr8N8Dc3TFFTCV
 jP+fgjuruX45LpGSZO5EJ6L7cJDJ6NZaoSXLpTFVDjSwd8P90F20hGVzXPQUoMhOIzRca9
 w+u0tWGOfZg/T3wUyDnsZbnDadSLEJmHvtXFnKGAkgv3SzZjnLTHM2h17dDirQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] clk: stm32mp13: Fix typo in STM32MP13 RCC driver
Date: Mon, 12 May 2025 18:51:33 +0200
Message-ID: <20250512165147.148396-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: m9jsh3btqs7qjm1mnapqwocrhcdyuy4m
X-MBO-RS-ID: 46dafc6f1f57a18f22b
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Fix basic typo, missing t in security . No functional change .

Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 drivers/clk/stm32/clk-stm32mp13.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/stm32/clk-stm32mp13.c b/drivers/clk/stm32/clk-stm32mp13.c
index 362dba10252..11dc40383a4 100644
--- a/drivers/clk/stm32/clk-stm32mp13.c
+++ b/drivers/clk/stm32/clk-stm32mp13.c
@@ -497,7 +497,7 @@ static const struct stm32_div_cfg stm32mp13_dividers[LAST_DIV] = {
 	DIV_CFG(DIV_ETH2PTP, RCC_ETH12CKSELR, 12, 4, 0, NULL),
 };
 
-struct clk_stm32_securiy {
+struct clk_stm32_security {
 	u16	offset;
 	u8	bit_idx;
 };
@@ -566,7 +566,7 @@ enum securit_clk {
 		.bit_idx	= _bit_idx, \
 	}
 
-static const struct clk_stm32_securiy stm32mp13_security[] = {
+static const struct clk_stm32_security stm32mp13_security[] = {
 	SECF(SECF_LPTIM2, RCC_APB3SECSR, RCC_APB3SECSR_LPTIM2SECF),
 	SECF(SECF_LPTIM3, RCC_APB3SECSR, RCC_APB3SECSR_LPTIM3SECF),
 	SECF(SECF_VREF, RCC_APB3SECSR, RCC_APB3SECSR_VREFSECF),
@@ -776,7 +776,7 @@ static int stm32mp13_check_security(void __iomem *base,
 	int secured = 0;
 
 	if (sec_id != SECF_NONE) {
-		const struct clk_stm32_securiy *secf;
+		const struct clk_stm32_security *secf;
 
 		secf = &stm32mp13_security[sec_id];
 		secured = !!(readl(base + secf->offset) & BIT(secf->bit_idx));
-- 
2.47.2

