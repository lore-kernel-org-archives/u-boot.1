Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E717E784BD
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 15:23:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 792C0871A3;
	Mon,  2 Oct 2023 17:22:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="iwnC3Sts";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73749871CA; Mon,  2 Oct 2023 17:22:02 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E30787166
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 17:22:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=detlev.casanova@collabora.com
Received: from arisu.mtl.collabora.ca (mtl.collabora.ca [66.171.169.34])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: detlev)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 7E7FF6607318;
 Mon,  2 Oct 2023 16:21:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1696260120;
 bh=QyHZHwvDP9K83XLblyhWJsu58mT0ptFONTlOIi2CI60=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iwnC3StsUoZQ9zlv9g9DoWPY5A1FO02Kj8v576GNjMkjLjTJzlEVYE4anO9NLUed7
 dLQapl8KAK0lR9kUQ0J51zq1MHWneJSQawL1E5st5/dgt1Na/cEnpr5GAJ72YU054R
 jr9M5iBcGklE61uoMDVoB9zGOymLE+/m5CB/4luSeKjEnf68WmLhoSKI88viZlD8uZ
 hk2/6LWxaA+Lgen7O+RXn+LRpm/6IMgnuL2JizoXYZbO+Y/pQGY9RoK2ow70NjYFVO
 e+N3dC5JTG+DFIB2re6otpbaYGFCcTazFzn+S4R7Zutc4njWZSsp1Tx80w0bACkNtA
 HPLSn+K7XtFQQ==
From: Detlev Casanova <detlev.casanova@collabora.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Tam Nguyen <tam.nguyen.xa@renesas.com>,
 Simon Glass <sjg@chromium.org>,
 Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v5 6/6] sysinfo: rcar3: Implement BOARD_ID and BOARD_REV_*
Date: Mon,  2 Oct 2023 11:20:10 -0400
Message-ID: <20231002152142.76516-7-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231002152142.76516-1-detlev.casanova@collabora.com>
References: <20231002152142.76516-1-detlev.casanova@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Expose that information to the sysinfo command to let scripts make
decisions based on the board id and revision.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 drivers/sysinfo/rcar3.c | 89 +++++++++++++++++++++++++++++------------
 1 file changed, 63 insertions(+), 26 deletions(-)

diff --git a/drivers/sysinfo/rcar3.c b/drivers/sysinfo/rcar3.c
index 633e80bc19b..a554323506a 100644
--- a/drivers/sysinfo/rcar3.c
+++ b/drivers/sysinfo/rcar3.c
@@ -32,6 +32,10 @@
  */
 struct sysinfo_rcar_priv {
 	char	boardmodel[64];
+	u8	id;
+	u8	rev_major;
+	u8	rev_minor;
+	bool	has_rev;
 	u8	val;
 };
 
@@ -56,9 +60,33 @@ static int sysinfo_rcar_get_str(struct udevice *dev, int id, size_t size, char *
 	};
 }
 
+static int sysinfo_rcar_get_int(struct udevice *dev, int id, int *val)
+{
+	struct sysinfo_rcar_priv *priv = dev_get_priv(dev);
+
+	switch (id) {
+	case SYSINFO_ID_BOARD_ID:
+		*val = priv->id;
+		return 0;
+	case SYSINFO_ID_BOARD_REV_MAJOR:
+		if (!priv->has_rev)
+			return -EINVAL;
+		*val = priv->rev_major;
+		return 0;
+	case SYSINFO_ID_BOARD_REV_MINOR:
+		if (!priv->has_rev)
+			return -EINVAL;
+		*val = priv->rev_minor;
+		return 0;
+	default:
+		return -EINVAL;
+	};
+}
+
 static const struct sysinfo_ops sysinfo_rcar_ops = {
 	.detect = sysinfo_rcar_detect,
 	.get_str = sysinfo_rcar_get_str,
+	.get_int = sysinfo_rcar_get_int,
 };
 
 static void sysinfo_rcar_parse(struct sysinfo_rcar_priv *priv)
@@ -69,8 +97,9 @@ static void sysinfo_rcar_parse(struct sysinfo_rcar_priv *priv)
 	bool ebisu_4d = false;
 	bool condor_i = false;
 	char rev[4] = "?.?";
-	u8 rev_major = 0;
-	u8 rev_minor = 0;
+
+	priv->id = board_id;
+	priv->has_rev = false;
 
 	switch (board_id) {
 	case BOARD_SALVATOR_XS:
@@ -78,9 +107,10 @@ static void sysinfo_rcar_parse(struct sysinfo_rcar_priv *priv)
 		fallthrough;
 	case BOARD_SALVATOR_X:
 		if (!(board_rev & ~1)) { /* Only rev 0 and 1 is valid */
-			rev_major = 1;
-			rev_minor = board_rev & BIT(0);
-			snprintf(rev, sizeof(rev), "%u.%u", rev_major, rev_minor);
+			priv->rev_major = 1;
+			priv->rev_minor = board_rev & BIT(0);
+			priv->has_rev = true;
+			snprintf(rev, sizeof(rev), "%u.%u", priv->rev_major, priv->rev_minor);
 		}
 		snprintf(priv->boardmodel, sizeof(priv->boardmodel),
 			 "Renesas Salvator-X%s board rev %s",
@@ -89,27 +119,30 @@ static void sysinfo_rcar_parse(struct sysinfo_rcar_priv *priv)
 		return;
 	case BOARD_STARTER_KIT:
 		if (!(board_rev & ~1)) { /* Only rev 0 and 1 is valid */
-			rev_major = (board_rev & BIT(0)) ? 3 : 1;
-			rev_minor = 0;
-			snprintf(rev, sizeof(rev), "%u.%u", rev_major, rev_minor);
+			priv->rev_major = (board_rev & BIT(0)) ? 3 : 1;
+			priv->rev_minor = 0;
+			snprintf(rev, sizeof(rev), "%u.%u", priv->rev_major, priv->rev_minor);
+			priv->has_rev = true;
 		}
 		snprintf(priv->boardmodel, sizeof(priv->boardmodel),
 			 "Renesas Starter Kit board rev %s", rev);
 		return;
 	case BOARD_STARTER_KIT_PRE:
 		if (!(board_rev & ~3)) { /* Only rev 0..3 is valid */
-			rev_major = (board_rev & BIT(1)) ? 2 : 1;
-			rev_minor = (board_rev == 3) ? 1 : 0;
-			snprintf(rev, sizeof(rev), "%u.%u", rev_major, rev_minor);
+			priv->rev_major = (board_rev & BIT(1)) ? 2 : 1;
+			priv->rev_minor = (board_rev == 3) ? 1 : 0;
+			snprintf(rev, sizeof(rev), "%u.%u", priv->rev_major, priv->rev_minor);
+			priv->has_rev = true;
 		}
 		snprintf(priv->boardmodel, sizeof(priv->boardmodel),
 			 "Renesas Starter Kit Premier board rev %s", rev);
 		return;
 	case BOARD_EAGLE:
 		if (!board_rev) { /* Only rev 0 is valid */
-			rev_major = 1;
-			rev_minor = 0;
-			snprintf(rev, sizeof(rev), "%u.%u", rev_major, rev_minor);
+			priv->rev_major = 1;
+			priv->rev_minor = 0;
+			snprintf(rev, sizeof(rev), "%u.%u", priv->rev_major, priv->rev_minor);
+			priv->has_rev = true;
 		}
 		snprintf(priv->boardmodel, sizeof(priv->boardmodel),
 			 "Renesas Eagle board rev %s", rev);
@@ -119,9 +152,10 @@ static void sysinfo_rcar_parse(struct sysinfo_rcar_priv *priv)
 		fallthrough;
 	case BOARD_EBISU:
 		if (!board_rev) { /* Only rev 0 is valid */
-			rev_major = 1;
-			rev_minor = 0;
-			snprintf(rev, sizeof(rev), "%u.%u", rev_major, rev_minor);
+			priv->rev_major = 1;
+			priv->rev_minor = 0;
+			snprintf(rev, sizeof(rev), "%u.%u", priv->rev_major, priv->rev_minor);
+			priv->has_rev = true;
 		}
 		snprintf(priv->boardmodel, sizeof(priv->boardmodel),
 			 "Renesas Ebisu%s board rev %s",
@@ -129,18 +163,20 @@ static void sysinfo_rcar_parse(struct sysinfo_rcar_priv *priv)
 		return;
 	case BOARD_DRAAK:
 		if (!board_rev) { /* Only rev 0 is valid */
-			rev_major = 1;
-			rev_minor = 0;
-			snprintf(rev, sizeof(rev), "%u.%u", rev_major, rev_minor);
+			priv->rev_major = 1;
+			priv->rev_minor = 0;
+			snprintf(rev, sizeof(rev), "%u.%u", priv->rev_major, priv->rev_minor);
+			priv->has_rev = true;
 		}
 		snprintf(priv->boardmodel, sizeof(priv->boardmodel),
 			 "Renesas Draak board rev %s", rev);
 		return;
 	case BOARD_KRIEK:
 		if (!board_rev) { /* Only rev 0 is valid */
-			rev_major = 1;
-			rev_minor = 0;
-			snprintf(rev, sizeof(rev), "%u.%u", rev_major, rev_minor);
+			priv->rev_major = 1;
+			priv->rev_minor = 0;
+			snprintf(rev, sizeof(rev), "%u.%u", priv->rev_major, priv->rev_minor);
+			priv->has_rev = true;
 		}
 		snprintf(priv->boardmodel, sizeof(priv->boardmodel),
 			 "Renesas Kriek board rev %s", rev);
@@ -150,9 +186,10 @@ static void sysinfo_rcar_parse(struct sysinfo_rcar_priv *priv)
 		fallthrough;
 	case BOARD_CONDOR:
 		if (!board_rev) { /* Only rev 0 is valid */
-			rev_major = 1;
-			rev_minor = 0;
-			snprintf(rev, sizeof(rev), "%u.%u", rev_major, rev_minor);
+			priv->rev_major = 1;
+			priv->rev_minor = 0;
+			snprintf(rev, sizeof(rev), "%u.%u", priv->rev_major, priv->rev_minor);
+			priv->has_rev = true;
 		}
 		snprintf(priv->boardmodel, sizeof(priv->boardmodel),
 			 "Renesas Condor%s board rev %s",
-- 
2.41.0

