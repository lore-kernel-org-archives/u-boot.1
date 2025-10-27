Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 424DFCCF9EB
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 16:47:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E319E83971;
	Mon, 27 Oct 2025 17:47:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="U0NnGtoo";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ud6VJF1S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B644A83968; Mon, 27 Oct 2025 17:47:11 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C56BD838FA
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 17:47:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cwKDF3QYhz9sDT;
 Mon, 27 Oct 2025 17:47:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761583629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/MxgCvnFjSX6FEiJgRR3t1VK7IraiBLQUiQ5LQRIYZ4=;
 b=U0NnGtooVPCOP1gVvjAJPX721ZtP06H2qJUkcTdCV93mDzgqZ5cU+lz1Bu+3TBmdzY5hbD
 NwYFk9Lg4esyvr6JXqNd1wOBhBEwLc3zND7LVcl07bTq6niyk+VkUeMEYTxoGXR8+DyHLC
 fN87iDjym89vyhNmHyd/0qphKDu3pewTlfSDeFg7JZe3VluwgQoOktm+NukXF69MFqr1iW
 W6riY46ofn7XII4EVSgkYWYIWflhmkcHHC+NhntSlgR2APDbr2e77i4bXhh3MA1Z1GYKKS
 LpjBuC0ubAwUovCoztVJeloIjBzDs3Y5Eb3ASPt0jaxq2O17TtjR8gnlRv9tUA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=ud6VJF1S;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761583627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/MxgCvnFjSX6FEiJgRR3t1VK7IraiBLQUiQ5LQRIYZ4=;
 b=ud6VJF1ScJADzNVBvsTPPD4r6CEYp0pkEuHj2yeNQgvSblEbk/21hjrxk3vSJJ5T3NLJ+5
 GfvLY1MJQehDhWF9c2YCOWQeq5CiB1Y2h5ddoWLQPdhnLb7PXA00t1IxV0ugTJWZ8HU3Md
 qQsCTAAXXRf/Yow69Xxna/TIHJfO9oILjquq1Ui1pdWAxwn54uSfR15xuajbYtM8h5aB6H
 79B6t1cjorvgsdFEmVXTarYSEgovRVtHuZq54p6M2VVTLnS1aNlpVhKcFbyzfQbEvmnrsu
 M5Jf5rglzLqQ8hIkXrWwNQjjVqf+32BP56SWlDQW++ZosTnprh/pxdMA5Q2I+w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 07/12] net: rswitch: Parametrize port count
Date: Mon, 27 Oct 2025 17:45:37 +0100
Message-ID: <20251027164643.12443-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251027164643.12443-1-marek.vasut+renesas@mailbox.org>
References: <20251027164643.12443-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 304d3ade23acf30962d
X-MBO-RS-META: ii1s1dj8wyej17fp8bpofqc4ziw34qcq
X-Rspamd-Queue-Id: 4cwKDF3QYhz9sDT
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

The total port counts differ across variants of this IP in
R-Car S4 and R-Car X5H. Parametrize port count in preparation
for R-Car X5H addition into this driver. No functional change.

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
 drivers/net/rswitch.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/rswitch.c b/drivers/net/rswitch.c
index c568b0bedd6..419293091f6 100644
--- a/drivers/net/rswitch.c
+++ b/drivers/net/rswitch.c
@@ -27,8 +27,8 @@
 #define RSWITCH_SLEEP_US	1000
 #define RSWITCH_TIMEOUT_US	1000000
 
-#define GWCA_TO_HW_INDEX(i)	((i) + 3)
-#define HW_INDEX_TO_GWCA(i)	((i) - 3)
+#define GWCA_TO_HW_INDEX(i, pt)	((i) + (pt))
+#define HW_INDEX_TO_GWCA(i, pt)	((i) - (pt))
 
 #define RSWITCH_MAX_CTAG_PCP	7
 
@@ -282,6 +282,7 @@ struct rswitch_drv_data {
 	u32			coma_offset;
 	u32			etha_offset;
 	u32			gwca_offset;
+	int			ports;
 };
 
 static inline void rswitch_flush_dcache(u32 addr, u32 len)
@@ -674,13 +675,14 @@ static void rswitch_mfwd_init(struct rswitch_port_priv *priv)
 {
 	struct rswitch_etha *etha = &priv->etha;
 	struct rswitch_gwca *gwca = &priv->gwca;
+	int gwca_index = HW_INDEX_TO_GWCA(gwca->index, priv->drv_data->ports);
 	int etha_index = etha->serdes.index;
 
 	writel(FWPC0_DEFAULT, priv->addr + FWPC0(etha_index));
 	writel(FWPC0_DEFAULT, priv->addr + FWPC0(gwca->index));
 
 	writel(RSWITCH_RX_CHAIN_INDEX,
-	       priv->addr + FWPBFCSDC(HW_INDEX_TO_GWCA(gwca->index), etha_index));
+	       priv->addr + FWPBFCSDC(gwca_index, etha_index));
 
 	writel(BIT(gwca->index),
 	       priv->addr + FWPBFC(etha_index));
@@ -1041,7 +1043,7 @@ static int rswitch_port_probe(struct udevice *dev)
 
 	gwca->index = 1;
 	gwca->addr = priv->addr + priv->drv_data->gwca_offset + gwca->index * RSWITCH_GWCA_SIZE;
-	gwca->index = GWCA_TO_HW_INDEX(gwca->index);
+	gwca->index = GWCA_TO_HW_INDEX(gwca->index, priv->drv_data->ports);
 
 	/* Toggle the reset so we can access the PHYs */
 	ret = rswitch_reset(priv);
@@ -1189,6 +1191,7 @@ static int rswitch_bind(struct udevice *parent)
 }
 
 static const struct rswitch_drv_data r8a779f0_drv_data = {
+	.ports		= 3,
 	.coma_offset	= 0x9000,
 	.etha_offset	= 0xa000,
 	.gwca_offset	= 0x10000,
-- 
2.51.0

