Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2EF4CCF9EB
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 16:46:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 587C083700;
	Mon, 27 Oct 2025 17:46:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="dPlrgapD";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="w7cm8awy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FFE68384E; Mon, 27 Oct 2025 17:46:56 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27033836F0
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 17:46:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cwKCx3sspz9srX;
 Mon, 27 Oct 2025 17:46:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761583613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=dFy7aCea05XoSEJVUv6920GGvOdMxqxYYPoNx7sIm6U=;
 b=dPlrgapDTT55hM1zsXPcasDecLD/JvJhktmqoEoAT+ADsb5vX5bP4MqpXriTLvUgPjZQYr
 Y32iKQaIpLJqyo9+6DhaTq/7fDR6EOOvdIm1SI5ZQYufvQ0gu1r62SMTyyuPeBTOXDlT1C
 GITPx4zS1hEXvyLvsUaG16cU85pVmnQW6Xfm8NSL3B6Q02vPRpp0qpqAOshVEcm8jw0LGV
 wicdd9n0yZECn99vMo4Ja8WnN7XQFhDoY1EW6IMcydIBev9aHUJOnL0AP+acsNwyCPVWaR
 2sp76Fm/6jhSh5Lzwhe2mdLy4inhO80BR3wPD1Gp1C2bGEv0ZaXBwk2XIk1buQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=w7cm8awy;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761583611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=dFy7aCea05XoSEJVUv6920GGvOdMxqxYYPoNx7sIm6U=;
 b=w7cm8awyNTrYFk8GEunXDQtzWo0Oe76xrfnrxgIN/LfbOhZ+idsvnC0gvPjTtfzZosVvIK
 Kihc0zoIRkq4xj6AH1S3/ce2MR2KQffqiFp0Tre49FxAjpFUaUJc4oT0FqUqkcbhiZtQXk
 6tEV2vtGv7J+b1ru3md/kooJcOUATzzg9sNpC0lmT0FbVkgaWxLhMDq5IourloFDruvi5X
 rYVvVAJmf3zQx0hdNUDoPA75xkA0KcwUWlj6KTc4uz5VJYtSRD4LLY7qRie7lN9lbEd0Et
 Pd3PSiREXnoXHl4hTYmS0852spf2dVSbsgrATLWTzu/AubmUkCMLgj5ysxCnUg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 01/12] net: rswitch: Switch indent from spaces to tabs
Date: Mon, 27 Oct 2025 17:45:31 +0100
Message-ID: <20251027164643.12443-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 923a89f5c58e21041e4
X-MBO-RS-META: ahbmhbk8tfprdkuzse8sycxgmsetjf1j
X-Rspamd-Queue-Id: 4cwKCx3sspz9srX
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

Fix indent from multiple spaces to tabs, to be consistent with
coding style and the rest of the driver. No functional change.

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
 drivers/net/rswitch.c | 48 +++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/net/rswitch.c b/drivers/net/rswitch.c
index f27587ac8bd..5f8e95d4d64 100644
--- a/drivers/net/rswitch.c
+++ b/drivers/net/rswitch.c
@@ -220,43 +220,43 @@ struct rswitch_gwca {
 #define RSWITCH_NUM_RX_DESC		8
 
 enum RX_DS_CC_BIT {
-	RX_DS   = 0x0fff, /* Data size */
-	RX_TR   = 0x1000, /* Truncation indication */
-	RX_EI   = 0x2000, /* Error indication */
-	RX_PS   = 0xc000, /* Padding selection */
+	RX_DS	= 0x0fff, /* Data size */
+	RX_TR	= 0x1000, /* Truncation indication */
+	RX_EI	= 0x2000, /* Error indication */
+	RX_PS	= 0xc000, /* Padding selection */
 };
 
 enum DIE_DT {
 	/* Frame data */
-	DT_FSINGLE      = 0x80,
-	DT_FSTART       = 0x90,
-	DT_FMID         = 0xa0,
-	DT_FEND         = 0xb8,
+	DT_FSINGLE	= 0x80,
+	DT_FSTART	= 0x90,
+	DT_FMID		= 0xa0,
+	DT_FEND		= 0xb8,
 
 	/* Chain control */
-	DT_LEMPTY       = 0xc0,
-	DT_EEMPTY       = 0xd0,
-	DT_LINKFIX      = 0x00,
-	DT_LINK         = 0xe0,
-	DT_EOS          = 0xf0,
+	DT_LEMPTY	= 0xc0,
+	DT_EEMPTY	= 0xd0,
+	DT_LINKFIX	= 0x00,
+	DT_LINK		= 0xe0,
+	DT_EOS		= 0xf0,
 	/* HW/SW arbitration */
-	DT_FEMPTY       = 0x40,
-	DT_FEMPTY_IS    = 0x10,
-	DT_FEMPTY_IC    = 0x20,
-	DT_FEMPTY_ND    = 0x38,
+	DT_FEMPTY	= 0x40,
+	DT_FEMPTY_IS	= 0x10,
+	DT_FEMPTY_IC	= 0x20,
+	DT_FEMPTY_ND	= 0x38,
 	DT_FEMPTY_START = 0x50,
-	DT_FEMPTY_MID   = 0x60,
-	DT_FEMPTY_END   = 0x70,
+	DT_FEMPTY_MID	= 0x60,
+	DT_FEMPTY_END	= 0x70,
 
-	DT_MASK         = 0xf0,
-	DIE             = 0x08, /* Descriptor Interrupt Enable */
+	DT_MASK		= 0xf0,
+	DIE		= 0x08, /* Descriptor Interrupt Enable */
 };
 
 struct rswitch_desc {
 	__le16 info_ds; /* Descriptor size */
-	u8 die_dt;      /* Descriptor interrupt enable and type */
-	__u8  dptrh;    /* Descriptor pointer MSB */
-	__le32 dptrl;   /* Descriptor pointer LSW */
+	u8 die_dt;	/* Descriptor interrupt enable and type */
+	__u8 dptrh;	/* Descriptor pointer MSB */
+	__le32 dptrl;	/* Descriptor pointer LSW */
 } __packed;
 
 struct rswitch_rxdesc {
-- 
2.51.0

