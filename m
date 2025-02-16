Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68E1C02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 21:18:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 287F680F12;
	Sun, 16 Feb 2025 22:18:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AAV0tfNC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1891A8056A; Sun, 16 Feb 2025 22:18:18 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA976807E1
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 22:18:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+j.ne.posteo.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id E0A3BA40FE0;
 Sun, 16 Feb 2025 21:16:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93D87C4CEE8;
 Sun, 16 Feb 2025 21:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739740694;
 bh=SvMtTE4ynVrC14TVG38XzM72d3EYLqG49x02bh9DesQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=AAV0tfNCvzbPxAM0UZpmURIbRPOej/z2pd41QgLhbM6eygL4WU4ukdJouyHY8fj7N
 MGqAt4MBLTtSlCYNz6esanp1Vn87e/2f5p7sndkrii2Q+GQ1q7VnXTxnT6D9MI6JYJ
 LxhegPK7YyCwsdi1vAe9plLlCgCYMcBN2OxBGjFHuL8/eumAnpm3LXxYGuWXB5gUKJ
 kLA69ckxygx+9n97p4xTiLV3IuUkQbbNC4Ywd0j40J/zaohbFoimBormUvmoSYC447
 ItmDmhtCTi/38o1/Fx/M+t+Sf7gcJ3lMzX4CEV60DB/lSXYeaSQRiRUb5HcHmjx6m6
 WYDQju0sBLedw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 898CDC021A4;
 Sun, 16 Feb 2025 21:18:14 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?=
 <devnull+j.ne.posteo.net@kernel.org>
Date: Sun, 16 Feb 2025 22:18:12 +0100
Subject: [PATCH 1/2] net: tsec: Reorder tsec_recv and tsec_free_pkt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250216-tsec-v1-1-9a704bedd048@posteo.net>
References: <20250216-tsec-v1-0-9a704bedd048@posteo.net>
In-Reply-To: <20250216-tsec-v1-0-9a704bedd048@posteo.net>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739740693; l=1953;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=szYONqyfUAJuQI7dqr75ja6FeiIGRqC49oCs5jo+LwU=;
 b=6QU+sC0Uc9laoridJYZlRujepMcRXpJal0p8g5lHjVSKauWQlacWvqIhH6/D0upy3avzFy/Yc
 PlnblnAjq4GDPszwctnt7BOVbHrPdr/MiVGjSj8uBBmFT/Q0PCqfUac
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
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
Reply-To: j.ne@posteo.net
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: "J. Neuschäfer" <j.ne@posteo.net>

This is necessary for the following patch. No functional change.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
 drivers/net/tsec.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/net/tsec.c b/drivers/net/tsec.c
index 6481ee24a6010099cbabb5a213641c63706176a2..b27fc322db55b7b845f8d629348cb34d79de3cc2 100644
--- a/drivers/net/tsec.c
+++ b/drivers/net/tsec.c
@@ -278,6 +278,24 @@ static int tsec_send(struct udevice *dev, void *packet, int length)
 	return result;
 }
 
+static int tsec_free_pkt(struct udevice *dev, uchar *packet, int length)
+{
+	struct tsec_private *priv = (struct tsec_private *)dev_get_priv(dev);
+	u16 status;
+
+	out_be16(&priv->rxbd[priv->rx_idx].length, 0);
+
+	status = RXBD_EMPTY;
+	/* Set the wrap bit if this is the last element in the list */
+	if ((priv->rx_idx + 1) == PKTBUFSRX)
+		status |= RXBD_WRAP;
+	out_be16(&priv->rxbd[priv->rx_idx].status, status);
+
+	priv->rx_idx = (priv->rx_idx + 1) % PKTBUFSRX;
+
+	return 0;
+}
+
 static int tsec_recv(struct udevice *dev, int flags, uchar **packetp)
 {
 	struct tsec_private *priv = (struct tsec_private *)dev_get_priv(dev);
@@ -307,24 +325,6 @@ static int tsec_recv(struct udevice *dev, int flags, uchar **packetp)
 	return ret;
 }
 
-static int tsec_free_pkt(struct udevice *dev, uchar *packet, int length)
-{
-	struct tsec_private *priv = (struct tsec_private *)dev_get_priv(dev);
-	u16 status;
-
-	out_be16(&priv->rxbd[priv->rx_idx].length, 0);
-
-	status = RXBD_EMPTY;
-	/* Set the wrap bit if this is the last element in the list */
-	if ((priv->rx_idx + 1) == PKTBUFSRX)
-		status |= RXBD_WRAP;
-	out_be16(&priv->rxbd[priv->rx_idx].status, status);
-
-	priv->rx_idx = (priv->rx_idx + 1) % PKTBUFSRX;
-
-	return 0;
-}
-
 static void tsec_halt(struct udevice *dev)
 {
 	struct tsec_private *priv;

-- 
2.48.0.rc1.219.gb6b6757d772


