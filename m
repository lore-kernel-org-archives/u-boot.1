Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B285CCF9E0
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 16:48:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B400B83984;
	Mon, 27 Oct 2025 17:47:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="DS9+ukyx";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="alpC+r4m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BDBA83984; Mon, 27 Oct 2025 17:47:18 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76ED383923
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 17:47:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cwKDN2DqMz9syB;
 Mon, 27 Oct 2025 17:47:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761583636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=119fRS4/DoNHuU4W1CRwgl5Qo0Wgb7NrwGehwNvbbEc=;
 b=DS9+ukyx4qsBGdsKcsNHX4o7qDX9BPHINSsLVXhhau1zP+eNen2jxowvDFBak6x8HP9ehd
 aQWbBeMqA5WWMVg1XZSMb1907Aq7WubO20PmBMPJF06P3/DaL6yqKpzHG5YUrZaJ4U2WHP
 154VqFPERQR4BMitRDKX4RzMW4iF6SrpU/2OVvNPZ04ibooDFk8TR40I8yS6LLOZq8N/DO
 ZPgT28iBE8krWfnai4XjACAb835ohJgvvSZ+mobH7ynq0jo3WFr9OJ54QOs5Xc7dskj39o
 FpiE856hoUeQ+kNqKTmvP1RGrNT/dS8Q5JNI80okyvyCgvfaWEfh5cQV1RqqIQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=alpC+r4m;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761583634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=119fRS4/DoNHuU4W1CRwgl5Qo0Wgb7NrwGehwNvbbEc=;
 b=alpC+r4miofQ8W3FbyQ4muHn9/YSoDuIDwTnqIDNInGCOYxNwXqavob5dWxCQOo7DcOgV1
 13UEsffuasX8c7LyZVXsT3fILgQlPflm/BB+sjYhjVersNzwjFhFsmzpJEf3LhzifAkqyQ
 Qv0ebqY33gbEctGDR8fAVClnouJ4vwBA8Anq+8mlHmr3l6cUFnOLzYe8UP4NexpewaNA8S
 MwC6cpMMSml/IprEcE9Lby0MN6miOLhVQ9jrgjLh3VN08YF9w6iYgQlciD5IhHrcITFN6h
 ToRccrK3q0nI3Yp165f2Mma/JT+wRWVQLi3pyEju6+uPqlQvetBHt8HJPckHxQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/12] net: rswitch: Parametrize GWDCBAC, FWPBFCSDC,
 CABPIRM register offsets
Date: Mon, 27 Oct 2025 17:45:40 +0100
Message-ID: <20251027164643.12443-10-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251027164643.12443-1-marek.vasut+renesas@mailbox.org>
References: <20251027164643.12443-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 892ad9dd13f4a313661
X-MBO-RS-META: rhjpikjf3tup83dqjejmbt5dqc59z994
X-Rspamd-Queue-Id: 4cwKDN2DqMz9syB
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

The GWDCBAC0, GWDCBAC1, FWPBFCSDC, CABPIRM register offsets changed
between R-Car S4 and R-Car X5H. Parametrize their offsets in preparation
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
 drivers/net/rswitch.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/net/rswitch.c b/drivers/net/rswitch.c
index f31fd4ef738..f0350d42b7a 100644
--- a/drivers/net/rswitch.c
+++ b/drivers/net/rswitch.c
@@ -106,8 +106,8 @@
 				 FWPC0_MACHLA | FWPC0_MACHMA | FWPC0_VLANSA)
 
 #define FWPBFC(i)		(FWPBFCR + (i) * 0x10)
-#define FWPBFCSDC(gwcaidx, ethaidx, ethaincr)		\
-	(FWPBFCSDCR + (ethaidx) * (ethaincr) + (gwcaidx) * 0x04)
+#define FWPBFCSDC(regoff, gwcaidx, ethaidx, ethaincr)		\
+	(FWPBFCSDCR + (regoff) + (ethaidx) * (ethaincr) + (gwcaidx) * 0x04)
 
 /* ETHA */
 #define EATASRIRM_TASRIOG	BIT(0)
@@ -278,6 +278,9 @@ struct rswitch_drv_data {
 	u32			etha_offset;
 	u32			gwca_offset;
 	u8			etha_incr;
+	u8			gwdcbac_offset;
+	u8			fwpbfcsdc_offset;
+	u8			cabpirm_offset;
 	int			ports;
 };
 
@@ -660,9 +663,11 @@ static int rswitch_bpool_init(struct rswitch_port_priv *priv)
 	struct rswitch_drv_data *drv_data = priv->drv_data;
 	u32 pval;
 
-	writel(CABPIRM_BPIOG, priv->addr + drv_data->coma_offset + CABPIRM);
+	writel(CABPIRM_BPIOG, priv->addr + drv_data->coma_offset +
+	       CABPIRM + drv_data->cabpirm_offset);
 
-	return readl_poll_sleep_timeout(priv->addr + drv_data->coma_offset + CABPIRM,
+	return readl_poll_sleep_timeout(priv->addr + drv_data->coma_offset +
+					CABPIRM + drv_data->cabpirm_offset,
 					pval, pval & CABPIRM_BPR,
 					RSWITCH_SLEEP_US, RSWITCH_TIMEOUT_US);
 }
@@ -678,7 +683,8 @@ static void rswitch_mfwd_init(struct rswitch_port_priv *priv)
 	writel(FWPC0_DEFAULT, priv->addr + FWPC0(gwca->index));
 
 	writel(RSWITCH_RX_CHAIN_INDEX,
-	       priv->addr + FWPBFCSDC(gwca_index, etha_index,
+	       priv->addr + FWPBFCSDC(priv->drv_data->fwpbfcsdc_offset,
+				      gwca_index, etha_index,
 				      priv->drv_data->etha_incr));
 
 	writel(BIT(gwca->index),
@@ -751,8 +757,10 @@ static int rswitch_gwca_init(struct rswitch_port_priv *priv)
 	/* Setting flow */
 	writel(GWVCC_VEM_SC_TAG, gwca->addr + GWVCC);
 	writel(0, gwca->addr + GWTTFC);
-	writel(upper_32_bits((uintptr_t)priv->bat_desc) & GWDCBAC0_DCBAUP, gwca->addr + GWDCBAC0);
-	writel(lower_32_bits((uintptr_t)priv->bat_desc), gwca->addr + GWDCBAC1);
+	writel(upper_32_bits((uintptr_t)priv->bat_desc) & GWDCBAC0_DCBAUP,
+	       gwca->addr + GWDCBAC0 + priv->drv_data->gwdcbac_offset);
+	writel(lower_32_bits((uintptr_t)priv->bat_desc),
+	       gwca->addr + GWDCBAC1 + priv->drv_data->gwdcbac_offset);
 	writel(GWDCC_DQT | GWDCC_BALR, gwca->addr + GWDCC(RSWITCH_TX_CHAIN_INDEX));
 	writel(GWDCC_BALR, gwca->addr + GWDCC(RSWITCH_RX_CHAIN_INDEX));
 
@@ -1193,6 +1201,9 @@ static const struct rswitch_drv_data r8a779f0_drv_data = {
 	.etha_offset	= 0xa000,
 	.gwca_offset	= 0x10000,
 	.etha_incr	= 0x10,
+	.gwdcbac_offset	= 0x0,
+	.fwpbfcsdc_offset = 0x0,
+	.cabpirm_offset	= 0x0,
 };
 
 static const struct udevice_id rswitch_ids[] = {
-- 
2.51.0

