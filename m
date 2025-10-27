Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7525CCCF9EB
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 16:47:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BA2F8393E;
	Mon, 27 Oct 2025 17:47:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="q4+wF1t4";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="WsHShGSh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8606583937; Mon, 27 Oct 2025 17:47:01 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 967F4838FA
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 17:46:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cwKD32jynz9sDT;
 Mon, 27 Oct 2025 17:46:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761583619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ffrzxyYSzWpbE29VUo93/5QJGLs1qDi7qRl4wckTU4=;
 b=q4+wF1t4SNefYidXTzE93Ha5IOeqgVjSc9eYZQOWEZD7TR7VMWvwIj2PQ0qfI3Mc4DBSgi
 J+jD7+aLi7ODkbAgBYbcu4bdmAEnbfcvfB89FNL4l2m/jhMx1qbSrEShv0mkxgOAW2i0MH
 h1C/nsIYF4fH1ihII7NGoF+PStV2isSmfsx1tWTxZcp47t0vFbZay+aNAu6NhJpaKIwwEx
 Wm/WeCP97ZzBHusguN4AHPHgWCGv5NFkD6CQ4Z6zC3aauhsrnpFMKhMRm3wwKo/1UykFPh
 E7RvkBKUCvfBUVKgfR5Eo0xtubq5A9WNPOpuw6juVVhMJGaPhHlYedNPTCttYg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=WsHShGSh;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761583617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ffrzxyYSzWpbE29VUo93/5QJGLs1qDi7qRl4wckTU4=;
 b=WsHShGShwqoPtoZSgOOcjhmsntNVVGm+SNFIX+wyLM/dsWPPdhoA+ZZZfqNiUdTYTQz+Bb
 /aylZh6A6/GbzrXU5S7RjcRZIdmOAAA0JliIOZ/zuXXcv/db/7dcuFv89iA2m034jd1xnt
 gTZhnkA0khwqmA9bsfY8twdAmcUrZgjyCkiTuLyS2DuWtjG/GRPMDWbjNva8hxslvQJaAe
 2WOK+nKpFVOTP5mayfivUIvaYz35FZQ6fSOOGFz1xv++vymnwq7lAli5Js5kIAoyGQ1Vh4
 tANjlI5W0n4qLakwEfgNyz06FQCZKrBrP/pvZg1N4sug8j12XlTWE35nVY9/iA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/12] net: rswitch: Initialize RX DMA descriptor .die_dt
 field to DT_FEMPTY
Date: Mon, 27 Oct 2025 17:45:33 +0100
Message-ID: <20251027164643.12443-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251027164643.12443-1-marek.vasut+renesas@mailbox.org>
References: <20251027164643.12443-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: iontqam4aamsbziubh8k9j7xyahptkes
X-MBO-RS-ID: deb2e07ebf723d7c7ae
X-Rspamd-Queue-Id: 4cwKD32jynz9sDT
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

Empty RX DMA descriptor must contain .die_dt field set to DT_FEMPTY,
because hardware DMA overwrites this field to non-DT_FEMPTY when data
are received, and the .recv callback tests the content of RX descriptor
.die_dt field to determine whether hardware did receive any data and
updated the .die_dt field, and based on that information, receives a
packet or not. Fix the incorrect RX DMA descriptor initialization to
assure the .recv callback always works correctly.

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
 drivers/net/rswitch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/rswitch.c b/drivers/net/rswitch.c
index 3f9052e0a89..f787aa4180d 100644
--- a/drivers/net/rswitch.c
+++ b/drivers/net/rswitch.c
@@ -601,7 +601,7 @@ static void rswitch_rx_desc_init(struct rswitch_port_priv *priv)
 	priv->rx_desc_index = 0;
 
 	for (i = 0; i < RSWITCH_NUM_RX_DESC; i++) {
-		priv->rx_desc[i].data.die_dt = DT_EEMPTY;
+		priv->rx_desc[i].data.die_dt = DT_FEMPTY;
 		priv->rx_desc[i].data.info_ds = PKTSIZE_ALIGN;
 		packet_addr = (uintptr_t)priv->rx_desc[i].packet;
 		priv->rx_desc[i].data.dptrl = lower_32_bits(packet_addr);
-- 
2.51.0

