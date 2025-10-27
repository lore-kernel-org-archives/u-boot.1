Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9267CCF9EB
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 16:48:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 309538397A;
	Mon, 27 Oct 2025 17:47:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="C1eK1rCR";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="KYAxSYLo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA8E08397A; Mon, 27 Oct 2025 17:47:13 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C99DB838FA
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 17:47:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cwKDH4Yjhz9sW6;
 Mon, 27 Oct 2025 17:47:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761583631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iYDiOjm6Onqf1nblAUbMgOZFsQELqTs3E059rFvuqpI=;
 b=C1eK1rCR+KNarg9RdOsNxOQPoz97C3lwOveGV/Rw7BZwkg5o0bsKgzfwLhKf+3We81uFZ1
 3WSJFa0LgVurOxViCapOvGdAZzkm9b+KRt0b6vAQY9+WZYDwx4hLPg+qL5u1lRoTACwarg
 fGKsbQYwPw6iTlaDAl46tZdiaRqDcqL3ySTVwoN+RzjBH+PSWGf56ObUblgdHXHFiJTFkQ
 yx6y0OAKUIH6AzQtYBk97GFk4EzU/b7tTunmbG2rCXemUxEsFdt+xfU2pTrfcLRJW2KNZs
 qt+MNjTPADyHQW/AVWleVvizBT6eNQMGoLwMTNFazFMLeZiuxdvYVSPmXG/Mkg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=KYAxSYLo;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761583629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iYDiOjm6Onqf1nblAUbMgOZFsQELqTs3E059rFvuqpI=;
 b=KYAxSYLooJOBnuEHjx14altFkEB3VtR2y83oLLDedXQQM3fR2eZ5RH5MaB6HDAFxlgM2jq
 yskzVoKG1NWyekoZZbNW1d0XWV60zefiBCZrfgM4B5ocQhfn0fcAF5A3Y2w1E8W4pclqY9
 aUdFqEBQqSgxk+vjz1uX28xCf3/FE7IDKboDUEspHKdlQ0WmFH/r/7QtyK/tiwyFAl1N06
 RCTZGAAXOFzEiq8z4I3Jl5IfnSkeeSZhrx3mH7BETK3N3wDt38xNTZm7UyXq7Fj50sffRq
 EYMb4aokEufRAj7kYJ7vSYXAfvXl3NNlcNHz1lOWZbET2dl/SLAv1MFECgIBNA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/12] net: rswitch: Parametrize forwarding engine CSD
 register offset
Date: Mon, 27 Oct 2025 17:45:38 +0100
Message-ID: <20251027164643.12443-8-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251027164643.12443-1-marek.vasut+renesas@mailbox.org>
References: <20251027164643.12443-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: o8n4f4njxgy1d6szzfpnm5pnxme5qpew
X-MBO-RS-ID: 80b995993a8dccc1600
X-Rspamd-Queue-Id: 4cwKDH4Yjhz9sW6
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

The forwarding engine CSD register offset changed between the
R-Car S4 and R-Car X5H. Parametrize this offset in preparation
for R-Car X5H addition into this driver. Clean up the macro
parameter names and make them more obvious. No functional change.

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
 drivers/net/rswitch.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/rswitch.c b/drivers/net/rswitch.c
index 419293091f6..096e1c99220 100644
--- a/drivers/net/rswitch.c
+++ b/drivers/net/rswitch.c
@@ -111,8 +111,9 @@
 				 FWPC0_IPDSA | FWPC0_IPHLA | FWPC0_MACSDA | \
 				 FWPC0_MACHLA | FWPC0_MACHMA | FWPC0_VLANSA)
 
-#define FWPBFC(i)	(FWPBFCR + (i) * 0x10)
-#define FWPBFCSDC(j, i)	(FWPBFCSDCR + (i) * 0x10 + (j) * 0x04)
+#define FWPBFC(i)		(FWPBFCR + (i) * 0x10)
+#define FWPBFCSDC(gwcaidx, ethaidx, ethaincr)		\
+	(FWPBFCSDCR + (ethaidx) * (ethaincr) + (gwcaidx) * 0x04)
 
 /* ETHA */
 #define EATASRIRM_TASRIOG	BIT(0)
@@ -282,6 +283,7 @@ struct rswitch_drv_data {
 	u32			coma_offset;
 	u32			etha_offset;
 	u32			gwca_offset;
+	u8			etha_incr;
 	int			ports;
 };
 
@@ -682,7 +684,8 @@ static void rswitch_mfwd_init(struct rswitch_port_priv *priv)
 	writel(FWPC0_DEFAULT, priv->addr + FWPC0(gwca->index));
 
 	writel(RSWITCH_RX_CHAIN_INDEX,
-	       priv->addr + FWPBFCSDC(gwca_index, etha_index));
+	       priv->addr + FWPBFCSDC(gwca_index, etha_index,
+				      priv->drv_data->etha_incr));
 
 	writel(BIT(gwca->index),
 	       priv->addr + FWPBFC(etha_index));
@@ -1195,6 +1198,7 @@ static const struct rswitch_drv_data r8a779f0_drv_data = {
 	.coma_offset	= 0x9000,
 	.etha_offset	= 0xa000,
 	.gwca_offset	= 0x10000,
+	.etha_incr	= 0x10,
 };
 
 static const struct udevice_id rswitch_ids[] = {
-- 
2.51.0

