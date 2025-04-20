Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 795D2C369C2
	for <u-boot@archiver.kernel.org>; Sun, 20 Apr 2025 16:36:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DF5A82045;
	Sun, 20 Apr 2025 18:36:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="gMAfvOBi";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xA1gzN8e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EF4A82047; Sun, 20 Apr 2025 18:36:12 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57DEE82027
 for <u-boot@lists.denx.de>; Sun, 20 Apr 2025 18:36:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ZgYzF0Px6z9st3;
 Sun, 20 Apr 2025 18:36:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1745166969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=okisl/IyoJliR5TQPIqFEiKV07O50GG6OQSJPBr14hs=;
 b=gMAfvOBib4OZKCGFeN8ubZoudQQxKkNK0/VZUStPZsdc1rOYiH+yeeMXF2IR5RV0pp8+Ef
 dxkQYlcoQrFIyJdKDwU8GY51qsSVdRaqNPOVIrM92iHLE/0515ZeSj1d36Rracq/U5FtOT
 zgQb3uratIS2mbzCKtFsIHJKTfntnhtBnHBbBn4rQsQ1Dv2KIGDyi3ddpxrbimFVC4qqRN
 h+5UUOpCGip9cOwNRs8HxTl4z19t3V+6vFu7FZRQVcSeDm2ve3UBxCB2YpnBbZSSExEzR4
 DI3iVUkDCky8IwbgKJcoqWHVGMHatduWByN7khz1IPwPqsczWED0w0kW9DLojw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1745166967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=okisl/IyoJliR5TQPIqFEiKV07O50GG6OQSJPBr14hs=;
 b=xA1gzN8eMTx4LyKgrPu4hodPQl9UZ+nNMlRDY9L5MOL2nt4LMWOSL8j0qrx2GC+GFHxLld
 0JXqFhukDVFSneusFXW2StycoA+gkf/Z777e33mm1NXZ9U7xpufWOZUZRNYkzn8ZfuQlxj
 i4z4m462I92iHLTGLQaOIio1+xmS2DJOS5DBQqFddjXcN5ZxFBpyJS60I+4r0OKguYhCOK
 yzK/RPEqlRrZwt+MrZfriGrS+z7LWs+9svzc65Ma6F5N6x6JkBSa7Toh7JkrbqPGfLUemE
 VpES1+01iNF4PnA5f6KFH3snwjY/Ju9ZhGOmUUU6GLZCZ5Zgw9rO4aeP2yxlaw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] net: ravb: Fix RX error handling
Date: Sun, 20 Apr 2025 18:35:33 +0200
Message-ID: <20250420163553.158866-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 491zsdn5g68zo1zfi3uh44at558361ha
X-MBO-RS-ID: f7af557eded809ab538
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

Correctly handle RX errors in ravb_recv() by returning 0 instead
of -EAGAIN on RX error.

In case the RAVB driver detects an RX error in ravb_recv(), it must
not return the -EAGAIN, but instead must return 0. Both error codes
are handled in eth-uclass.c eth_rx() and -EAGAIN is rewritten to 0
at the end of eth_rx(), but negative return code from the .recv()
callback does not trigger .free_pkt() callback, which would clean
up and re-enqueue the descriptor which holds the currently received
corrupted packet. The .free_pkt() must be called for this descriptor,
otherwise the follow up received data become corrupted too, even if
those packets are correctly received. Returning 0 from the .recv()
callback assures the corrupted packet is not processed by the network
stack, but is skipped instead.

For TFTP loading, an RX error produces the timeout "T" output and
resumes the TFTP loading operation shortly afterward, without any
data corruption.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: Always assign **packet pointer and always invalid the cache over it,
    even in case of an error. Avoid passing NULL packet pointer to the
    .free_pkt() callback.
---
 drivers/net/ravb.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
index 539fd37ee59..e1ce1d8957b 100644
--- a/drivers/net/ravb.c
+++ b/drivers/net/ravb.c
@@ -181,7 +181,7 @@ static int ravb_recv(struct udevice *dev, int flags, uchar **packetp)
 {
 	struct ravb_priv *eth = dev_get_priv(dev);
 	struct ravb_rxdesc *desc = &eth->rx_desc[eth->rx_desc_idx];
-	int len;
+	int len = 0;
 	u8 *packet;
 
 	/* Check if the rx descriptor is ready */
@@ -190,12 +190,11 @@ static int ravb_recv(struct udevice *dev, int flags, uchar **packetp)
 		return -EAGAIN;
 
 	/* Check for errors */
-	if (desc->data.ctrl & RAVB_RX_DESC_MSC_RX_ERR_MASK) {
+	if (desc->data.ctrl & RAVB_RX_DESC_MSC_RX_ERR_MASK)
 		desc->data.ctrl &= ~RAVB_RX_DESC_MSC_MASK;
-		return -EAGAIN;
-	}
+	else
+		len = desc->data.ctrl & RAVB_DESC_DS_MASK;
 
-	len = desc->data.ctrl & RAVB_DESC_DS_MASK;
 	packet = (u8 *)(uintptr_t)desc->data.dptr;
 	ravb_invalidate_dcache((uintptr_t)packet, len);
 
-- 
2.47.2

