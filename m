Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D1AC3ABC3
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 17:22:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2720C829CD;
	Mon, 12 May 2025 19:22:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="DnI7LuXs";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="QOEsUC9p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C44780C83; Mon, 12 May 2025 19:22:24 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4125B82A56
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 19:22:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Zx5yP6h1Hz9smH;
 Mon, 12 May 2025 19:22:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1747070542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wlQeXKprmnnpWWXsbmVTnZIw+/Hde1MGFbCAtnDBLh8=;
 b=DnI7LuXsx30Wx0vR4JOTto/nBhemQLxb+MjFRi2+/2U/Wkdw/OR2kH/f44e5cjEc4m/oS9
 zuD16xsARV6mjCPDG4gs7wGUuL/Cx7KsIa1igBY7u6Iw3WQpE9cHgGR87fBr+UWHryxc9n
 6FqPiN6n8n+b2p+mePuaiSFGwNv6K377U7BnT0cBUP6aU0zbGO8o5oq1zpqe5+TLR0Cy5o
 TRH5hbo6jOQDM8Wu6wDixpnxu9TnTBQrQusWnJZU9UMP+noizkQtIV2l9oTR20nccQGWoi
 4+RmGE8pzcKKn/dzQZf5Z6Z5up9x5pvPy9uywIhGaVBKksDxhk9D13EDp7+BjA==
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1747070540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wlQeXKprmnnpWWXsbmVTnZIw+/Hde1MGFbCAtnDBLh8=;
 b=QOEsUC9prl9igi3lWua7lUBxjFUP6nf8lYDW2kgaNlQ99kVFrgn8DvbktV4woGDwhjduGX
 za694O4YGa3CQMbm0t/Aw/frOgN/IYkRzM+oqXAT1BrGV6BqB9+60erjpi7mQKRRsSxhKP
 xhbjXgMz+kJYw4Do17+4ts2LQLNttuY919e9dflzk4jUsnMCiS7IPQMSrLWXTzLdIxWhZu
 wu+XDxvhzZ1h5r4cC1zoqJtSzUfygOGS82MrnLRgjvjnv58nJw92kUIioT3B35Qo8AAXg/
 CdPFO4xZkyQuuczqfDV32+p5Ob/twwGxhHqz54qJoUneZjDPUmWOgPjKw85H/Q==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Cheick Traore <cheick.traore@foss.st.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Gatien Chevallier <gatien.chevallier@foss.st.com>,
 Lionel Debieve <lionel.debieve@foss.st.com>,
 Pascal Zimmermann <pzimmermann@dh-electronics.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 04/10] ARM: stm32: Add STM32MP13xx PMIC initialization for
 DDR3 DRAM type
Date: Mon, 12 May 2025 19:21:31 +0200
Message-ID: <20250512172149.150214-5-marek.vasut@mailbox.org>
In-Reply-To: <20250512172149.150214-1-marek.vasut@mailbox.org>
References: <20250512172149.150214-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ee551b5348d262a5161
X-MBO-RS-META: swqn8niaunyarxayx3iotuteoggjj6jm
X-Rspamd-Queue-Id: 4Zx5yP6h1Hz9smH
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

The STM32MP13xx PMIC initialization for DDR3 DRAM type is similar
to the STM32MP15xx PMIC initialization, except the VTT rail is not
enabled. Fill in the STM32MP13xx support.

Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: Cheick Traore <cheick.traore@foss.st.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: Gatien Chevallier <gatien.chevallier@foss.st.com>
Cc: Lionel Debieve <lionel.debieve@foss.st.com>
Cc: Pascal Zimmermann <pzimmermann@dh-electronics.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 board/st/common/stpmic1.c | 51 ++++++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/board/st/common/stpmic1.c b/board/st/common/stpmic1.c
index 45c2bb5bcea..b46f89dacb9 100644
--- a/board/st/common/stpmic1.c
+++ b/board/st/common/stpmic1.c
@@ -14,8 +14,19 @@
 #include <power/pmic.h>
 #include <power/stpmic1.h>
 
+static bool is_stm32mp13xx(void)
+{
+	if (!IS_ENABLED(CONFIG_STM32MP13X))
+		return false;
+
+	return of_machine_is_compatible("st,stm32mp131") ||
+	       of_machine_is_compatible("st,stm32mp133") ||
+	       of_machine_is_compatible("st,stm32mp135");
+}
+
 int board_ddr_power_init(enum ddr_type ddr_type)
 {
+	bool is_mp13 = is_stm32mp13xx();
 	struct udevice *dev;
 	bool buck3_at_1800000v = false;
 	int ret;
@@ -30,18 +41,21 @@ int board_ddr_power_init(enum ddr_type ddr_type)
 	switch (ddr_type) {
 	case STM32MP_DDR3:
 		/* VTT = Set LDO3 to sync mode */
-		ret = pmic_reg_read(dev, STPMIC1_LDOX_MAIN_CR(STPMIC1_LDO3));
-		if (ret < 0)
-			return ret;
-
-		ret &= ~STPMIC1_LDO3_MODE;
-		ret &= ~STPMIC1_LDO12356_VOUT_MASK;
-		ret |= STPMIC1_LDO_VOUT(STPMIC1_LDO3_DDR_SEL);
-
-		ret = pmic_reg_write(dev, STPMIC1_LDOX_MAIN_CR(STPMIC1_LDO3),
-				     ret);
-		if (ret < 0)
-			return ret;
+		if (!is_mp13) {
+			/* Enable VTT only on STM32MP15xx */
+			ret = pmic_reg_read(dev, STPMIC1_LDOX_MAIN_CR(STPMIC1_LDO3));
+			if (ret < 0)
+				return ret;
+
+			ret &= ~STPMIC1_LDO3_MODE;
+			ret &= ~STPMIC1_LDO12356_VOUT_MASK;
+			ret |= STPMIC1_LDO_VOUT(STPMIC1_LDO3_DDR_SEL);
+
+			ret = pmic_reg_write(dev, STPMIC1_LDOX_MAIN_CR(STPMIC1_LDO3),
+					     ret);
+			if (ret < 0)
+				return ret;
+		}
 
 		/* VDD_DDR = Set BUCK2 to 1.35V */
 		ret = pmic_clrsetbits(dev,
@@ -69,11 +83,14 @@ int board_ddr_power_init(enum ddr_type ddr_type)
 		mdelay(STPMIC1_DEFAULT_START_UP_DELAY_MS);
 
 		/* Enable VTT = LDO3 */
-		ret = pmic_clrsetbits(dev,
-				      STPMIC1_LDOX_MAIN_CR(STPMIC1_LDO3),
-				      STPMIC1_LDO_ENA, STPMIC1_LDO_ENA);
-		if (ret < 0)
-			return ret;
+		if (!is_mp13) {
+			/* Enable VTT only on STM32MP15xx */
+			ret = pmic_clrsetbits(dev,
+					      STPMIC1_LDOX_MAIN_CR(STPMIC1_LDO3),
+					      STPMIC1_LDO_ENA, STPMIC1_LDO_ENA);
+			if (ret < 0)
+				return ret;
+		}
 
 		mdelay(STPMIC1_DEFAULT_START_UP_DELAY_MS);
 
-- 
2.47.2

