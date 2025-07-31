Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2651C87FD2
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 21:51:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A50BD83984;
	Thu, 31 Jul 2025 23:50:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=agorria.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=agorria.com header.i=@agorria.com header.b="L3GTRZeR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48E708349B; Thu, 31 Jul 2025 21:37:15 +0200 (CEST)
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org
 [IPv6:2001:67c:2050:103:465::111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B6A983937
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 21:37:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=agorria.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ion@agorria.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4btK951XThz9xwV;
 Thu, 31 Jul 2025 21:37:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agorria.com; s=MBO0001;
 t=1753990633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1gEer0W+UIkbGkSHl+Q+yPVRg4sUO6MgM3BQN60qBf0=;
 b=L3GTRZeRz7hcmpDRPiCuzhNCQDO0ObvN7+YIaDumtqA7T6sGvH8Fy02q1AYi/zCF94ml7o
 okqW2uHZPeIuPKm5ykeL5c+rCn4w/+DC/rFz5QbvCMerHNeGig8SKOTl9ITHzuV6BwzL5w
 KrE1rp192LAxhdTxQso8F90UcghXdvKe2QQg69OqBVSxll2kzMSjPeTjkQE0rBS9+Wn6S0
 lzJiCyJcpS185J/mPe2cXwXiPdhwKWkz2JRrbDScf8H9SJVu8ixQmNMBfJ5V39e8xn1ErT
 tne6TJzBCB/eqC30Ywd4YLkLPJWmKeYLr3Yq2jqgj/NsgsN+xqQiC45xzynYKA==
From: Ion Agorria <ion@agorria.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Ion Agorria <ion@agorria.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/5] video: tegra: parametrize PCLK and DE polarity
Date: Thu, 31 Jul 2025 21:36:52 +0200
Message-ID: <20250731193656.286806-2-ion@agorria.com>
In-Reply-To: <20250731193656.286806-1-ion@agorria.com>
References: <20250731193656.286806-1-ion@agorria.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 31 Jul 2025 23:50:52 +0200
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

From: Svyatoslav Ryhel <clamor95@gmail.com>

Configure pixel clock and data enable polarity according to panel flags.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/include/asm/arch-tegra/dc.h |  3 +++
 drivers/video/tegra/dc.c             | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm/include/asm/arch-tegra/dc.h b/arch/arm/include/asm/arch-tegra/dc.h
index ab12cc9c7d0..22f8f977cc6 100644
--- a/arch/arm/include/asm/arch-tegra/dc.h
+++ b/arch/arm/include/asm/arch-tegra/dc.h
@@ -448,6 +448,9 @@ enum win_color_depth_id {
 #define LVS_OUTPUT_POLARITY_LOW		BIT(28)
 #define LSC0_OUTPUT_POLARITY_LOW	BIT(24)
 
+/* DC_COM_PIN_OUTPUT_POLARITY3 0x309 */
+#define LSPI_OUTPUT_POLARITY_LOW	BIT(8)
+
 /* DC_COM_PIN_OUTPUT_SELECT6 0x31a */
 #define LDC_OUTPUT_SELECT_V_PULSE1	BIT(14) /* 100b */
 
diff --git a/drivers/video/tegra/dc.c b/drivers/video/tegra/dc.c
index f0e3d2c993f..ced49718834 100644
--- a/drivers/video/tegra/dc.c
+++ b/drivers/video/tegra/dc.c
@@ -238,8 +238,24 @@ static void rgb_enable(struct tegra_lcd_priv *priv)
 	else
 		value &= ~LVS_OUTPUT_POLARITY_LOW;
 
+	/* configure pixel data signal polarity */
+	if (dt->flags & DISPLAY_FLAGS_PIXDATA_POSEDGE)
+		value &= ~LSC0_OUTPUT_POLARITY_LOW;
+	else
+		value |= LSC0_OUTPUT_POLARITY_LOW;
+
 	writel(value, &com->pin_output_polarity[1]);
 
+	/* configure data enable signal polarity */
+	value = readl(&com->pin_output_polarity[3]);
+
+	if (dt->flags & DISPLAY_FLAGS_DE_LOW)
+		value |= LSPI_OUTPUT_POLARITY_LOW;
+	else
+		value &= ~LSPI_OUTPUT_POLARITY_LOW;
+
+	writel(value, &com->pin_output_polarity[3]);
+
 	for (i = 0; i < PIN_OUTPUT_SEL_COUNT; i++)
 		writel(rgb_sel_tab[i], &com->pin_output_sel[i]);
 }
-- 
2.50.0

