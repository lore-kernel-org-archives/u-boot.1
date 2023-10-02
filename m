Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9EF0E784BE
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 15:22:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D22A871AA;
	Mon,  2 Oct 2023 17:22:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="C+/5NZd8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F31A871C3; Mon,  2 Oct 2023 17:22:02 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91AC0871A3
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 17:21:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=detlev.casanova@collabora.com
Received: from arisu.mtl.collabora.ca (mtl.collabora.ca [66.171.169.34])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: detlev)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 937916607314;
 Mon,  2 Oct 2023 16:21:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1696260119;
 bh=zXSbhOUpxgkFw2bYhkna50QNgylt7Rdhd0Dz7NYlrik=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=C+/5NZd8kWayQOEhLspaH8nyrNf81dq/E4vwCAePLLb8b/UjXOXC+/zT0TCNP88Vi
 NR+yJkLB2VLCZ75NAXjgYpVi6ppUDqV2caFCXtuZ6kETVSk3l2JU2gwej6dZzBuOUw
 bQ7aU8z8HKhAjhzwLfd9LIxJqJ6YUErst37baO1rjTn7I69FX9BJNWVZhl9KU0BleV
 F+65QR/xLeSfL3rUztpgDyKwixQp/xMZPnBJxIPRTMkmS5hXA9qD8EoOzn68LQ3OjP
 u8KADU/smX8Z37yRiylnNg+w7s7Ra/LEFMknaqyAtlSxNHBom8DKIaABnPhbIJEyMm
 +eUxNWXXCBxOg==
From: Detlev Casanova <detlev.casanova@collabora.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Tam Nguyen <tam.nguyen.xa@renesas.com>,
 Simon Glass <sjg@chromium.org>,
 Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v5 5/6] sysinfo: rcar3: Use int instead of char for revision
Date: Mon,  2 Oct 2023 11:20:09 -0400
Message-ID: <20231002152142.76516-6-detlev.casanova@collabora.com>
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

To be used with the sysinfo command, revision values must be considered
as integers, not chars as some boards will implement BOARD_REVISION_*
and might use numbers greater than 9.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 drivers/sysinfo/rcar3.c | 73 ++++++++++++++++++++++-------------------
 1 file changed, 39 insertions(+), 34 deletions(-)

diff --git a/drivers/sysinfo/rcar3.c b/drivers/sysinfo/rcar3.c
index 7b127986da7..633e80bc19b 100644
--- a/drivers/sysinfo/rcar3.c
+++ b/drivers/sysinfo/rcar3.c
@@ -68,8 +68,9 @@ static void sysinfo_rcar_parse(struct sysinfo_rcar_priv *priv)
 	bool salvator_xs = false;
 	bool ebisu_4d = false;
 	bool condor_i = false;
-	char rev_major = '?';
-	char rev_minor = '?';
+	char rev[4] = "?.?";
+	u8 rev_major = 0;
+	u8 rev_minor = 0;
 
 	switch (board_id) {
 	case BOARD_SALVATOR_XS:
@@ -77,81 +78,85 @@ static void sysinfo_rcar_parse(struct sysinfo_rcar_priv *priv)
 		fallthrough;
 	case BOARD_SALVATOR_X:
 		if (!(board_rev & ~1)) { /* Only rev 0 and 1 is valid */
-			rev_major = '1';
-			rev_minor = '0' + (board_rev & BIT(0));
+			rev_major = 1;
+			rev_minor = board_rev & BIT(0);
+			snprintf(rev, sizeof(rev), "%u.%u", rev_major, rev_minor);
 		}
 		snprintf(priv->boardmodel, sizeof(priv->boardmodel),
-			 "Renesas Salvator-X%s board rev %c.%c",
-			 salvator_xs ? "S" : "", rev_major, rev_minor);
+			 "Renesas Salvator-X%s board rev %s",
+			 salvator_xs ? "S" : "", rev);
+
 		return;
 	case BOARD_STARTER_KIT:
 		if (!(board_rev & ~1)) { /* Only rev 0 and 1 is valid */
-			rev_major = (board_rev & BIT(0)) ? '3' : '1';
-			rev_minor = '0';
+			rev_major = (board_rev & BIT(0)) ? 3 : 1;
+			rev_minor = 0;
+			snprintf(rev, sizeof(rev), "%u.%u", rev_major, rev_minor);
 		}
 		snprintf(priv->boardmodel, sizeof(priv->boardmodel),
-			 "Renesas Starter Kit board rev %c.%c",
-			 rev_major, rev_minor);
+			 "Renesas Starter Kit board rev %s", rev);
 		return;
 	case BOARD_STARTER_KIT_PRE:
 		if (!(board_rev & ~3)) { /* Only rev 0..3 is valid */
-			rev_major = (board_rev & BIT(1)) ? '2' : '1';
-			rev_minor = (board_rev == 3) ? '1' : '0';
+			rev_major = (board_rev & BIT(1)) ? 2 : 1;
+			rev_minor = (board_rev == 3) ? 1 : 0;
+			snprintf(rev, sizeof(rev), "%u.%u", rev_major, rev_minor);
 		}
 		snprintf(priv->boardmodel, sizeof(priv->boardmodel),
-			 "Renesas Starter Kit Premier board rev %c.%c",
-			 rev_major, rev_minor);
+			 "Renesas Starter Kit Premier board rev %s", rev);
 		return;
 	case BOARD_EAGLE:
 		if (!board_rev) { /* Only rev 0 is valid */
-			rev_major = '1';
-			rev_minor = '0';
+			rev_major = 1;
+			rev_minor = 0;
+			snprintf(rev, sizeof(rev), "%u.%u", rev_major, rev_minor);
 		}
 		snprintf(priv->boardmodel, sizeof(priv->boardmodel),
-			 "Renesas Eagle board rev %c.%c",
-			 rev_major, rev_minor);
+			 "Renesas Eagle board rev %s", rev);
 		return;
 	case BOARD_EBISU_4D:
 		ebisu_4d = true;
 		fallthrough;
 	case BOARD_EBISU:
 		if (!board_rev) { /* Only rev 0 is valid */
-			rev_major = '1';
-			rev_minor = '0';
+			rev_major = 1;
+			rev_minor = 0;
+			snprintf(rev, sizeof(rev), "%u.%u", rev_major, rev_minor);
 		}
 		snprintf(priv->boardmodel, sizeof(priv->boardmodel),
-			 "Renesas Ebisu%s board rev %c.%c",
-			 ebisu_4d ? "-4D" : "", rev_major, rev_minor);
+			 "Renesas Ebisu%s board rev %s",
+			 ebisu_4d ? "-4D" : "", rev);
 		return;
 	case BOARD_DRAAK:
 		if (!board_rev) { /* Only rev 0 is valid */
-			rev_major = '1';
-			rev_minor = '0';
+			rev_major = 1;
+			rev_minor = 0;
+			snprintf(rev, sizeof(rev), "%u.%u", rev_major, rev_minor);
 		}
 		snprintf(priv->boardmodel, sizeof(priv->boardmodel),
-			 "Renesas Draak board rev %c.%c",
-			 rev_major, rev_minor);
+			 "Renesas Draak board rev %s", rev);
 		return;
 	case BOARD_KRIEK:
 		if (!board_rev) { /* Only rev 0 is valid */
-			rev_major = '1';
-			rev_minor = '0';
+			rev_major = 1;
+			rev_minor = 0;
+			snprintf(rev, sizeof(rev), "%u.%u", rev_major, rev_minor);
 		}
 		snprintf(priv->boardmodel, sizeof(priv->boardmodel),
-			 "Renesas Kriek board rev %c.%c",
-			 rev_major, rev_minor);
+			 "Renesas Kriek board rev %s", rev);
 		return;
 	case BOARD_CONDOR_I:
 		condor_i = true;
 		fallthrough;
 	case BOARD_CONDOR:
 		if (!board_rev) { /* Only rev 0 is valid */
-			rev_major = '1';
-			rev_minor = '0';
+			rev_major = 1;
+			rev_minor = 0;
+			snprintf(rev, sizeof(rev), "%u.%u", rev_major, rev_minor);
 		}
 		snprintf(priv->boardmodel, sizeof(priv->boardmodel),
-			"Renesas Condor%s board rev %c.%c",
-			condor_i ? "-I" : "", rev_major, rev_minor);
+			 "Renesas Condor%s board rev %s",
+			 condor_i ? "-I" : "", rev);
 		return;
 	default:
 		snprintf(priv->boardmodel, sizeof(priv->boardmodel),
-- 
2.41.0

