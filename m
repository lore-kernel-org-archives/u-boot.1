Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B375CCF9EB
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 16:48:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F239583937;
	Mon, 27 Oct 2025 17:47:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="GcTIjUuY";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pzOLeD8A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AECE8398D; Mon, 27 Oct 2025 17:47:21 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B24583923
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 17:47:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cwKDQ6CXkz9t6h;
 Mon, 27 Oct 2025 17:47:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761583638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gqEYgqC2zmYYu40YuVWQkLGZlzY8Fr12TYNGsU0+6kw=;
 b=GcTIjUuYkJqPZ9eoGV+x+B5SzH01Cnv0RmEBY8GuBrhB0+WSTQtJAApj6RCKKjusSIxXrE
 dWo32KLmVYS59IUX6N0T0Ae2SBtdRbTpqyMe5uaSgu/MR4i45NuHuCDRgtTFmvFAxfcegT
 mQsOZz4bNchA0lluXGojtoWhw+Gdv+DUE9PwZ/wuXao10y8VwFMdGNr1YXTh6MhMu601GJ
 kkgmNCl1Ce4siSfwBrX0RldS9QwuD4hnD58TfkRKcoH8ZR5m40kU45Rug+YDdREJ9DvXKY
 GSzUlMI90vD7gqg3rzdPClLIZ0jdKq0KmzPfdDvkTWk1oRWjIUUd22ESRFcM1Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761583636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gqEYgqC2zmYYu40YuVWQkLGZlzY8Fr12TYNGsU0+6kw=;
 b=pzOLeD8AFYsjvEEWjkmu3FoPNql5kaRrMtjCqq9xlEnHfFWkf0tKHu6JsBH9GK/WKcxSEi
 EnIeIlIH8dlQzuPL23jWUBaQWYQufmXUD0qO1Y9bnKZ7iRu1JqjOiRlR+X8Fi6ZUDPk3qi
 qAtox6LFopnDx+J5AfRzsVI0OjXC+onqHMvY6CjnKCa4cuknkO20oK6tQ58y/ROlb6XV2O
 b4T0wNXOsDj4bw2oDphAbDeFTavZ8VWuzsFfB1yvkwL/nn/mfLifntmqd4jfSusFc0k8sR
 T0BRXHVRiMvB7d+WlLaSCpInab46/ZfIsitZPL+q85PLzDXttI8rTJzruN6ImQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 11/12] net: rswitch: Parametrize MPIC_MDC_CLK_SET clock setting
Date: Mon, 27 Oct 2025 17:45:41 +0100
Message-ID: <20251027164643.12443-11-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251027164643.12443-1-marek.vasut+renesas@mailbox.org>
References: <20251027164643.12443-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 4m8rcox5henxicikprr3fkc8cf5whwyd
X-MBO-RS-ID: 2b50db3a24e9d7d45c1
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

The MPIC_MDC_CLK clock setting value differs between R-Car S4
and R-Car X5H. Parametrize the value in preparation for R-Car
X5H addition into this driver. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/net/rswitch.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/rswitch.c b/drivers/net/rswitch.c
index f0350d42b7a..54ecb95344f 100644
--- a/drivers/net/rswitch.c
+++ b/drivers/net/rswitch.c
@@ -127,7 +127,6 @@
 
 #define MPIC_PSMCS_MASK		(0x7f << 16)
 #define MPIC_PSMHT_MASK		(0x06 << 24)
-#define MPIC_MDC_CLK_SET	(0x06050000)
 
 #define MPSM_MFF_C45		BIT(2)
 #define MPSM_MFF_C22		0x0
@@ -277,6 +276,7 @@ struct rswitch_drv_data {
 	u32			coma_offset;
 	u32			etha_offset;
 	u32			gwca_offset;
+	u32			mpid_mdc_clk;
 	u8			etha_incr;
 	u8			gwdcbac_offset;
 	u8			fwpbfcsdc_offset;
@@ -469,7 +469,7 @@ static int rswitch_mii_read_c45(struct mii_dev *miidev, int phyad, int devad, in
 	/* Enable Station Management clock */
 	clrsetbits_le32(etha_mii->addr + MPIC,
 			MPIC_PSMCS_MASK | MPIC_PSMHT_MASK,
-			MPIC_MDC_CLK_SET);
+			priv->drv_data->mpid_mdc_clk);
 
 	/* Access PHY register */
 	if (devad != MDIO_DEVAD_NONE)	/* Definitelly C45 */
@@ -503,7 +503,7 @@ int rswitch_mii_write_c45(struct mii_dev *miidev, int phyad, int devad, int rega
 	/* Enable Station Management clock */
 	clrsetbits_le32(etha_mii->addr + MPIC,
 			MPIC_PSMCS_MASK | MPIC_PSMHT_MASK,
-			MPIC_MDC_CLK_SET);
+			priv->drv_data->mpid_mdc_clk);
 
 	/* Access PHY register */
 	if (devad != MDIO_DEVAD_NONE)	/* Definitelly C45 */
@@ -1200,6 +1200,7 @@ static const struct rswitch_drv_data r8a779f0_drv_data = {
 	.coma_offset	= 0x9000,
 	.etha_offset	= 0xa000,
 	.gwca_offset	= 0x10000,
+	.mpid_mdc_clk	= 0x06050000,
 	.etha_incr	= 0x10,
 	.gwdcbac_offset	= 0x0,
 	.fwpbfcsdc_offset = 0x0,
-- 
2.51.0

