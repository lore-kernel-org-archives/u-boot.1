Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA484C5478C
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 16:13:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1869888015;
	Tue, 27 Feb 2024 17:10:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="g3Spqroa";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="S8vpra97";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5750888053; Tue, 27 Feb 2024 17:10:28 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 818BE8803D
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 17:10:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4TkjBS2tyqz9sHC;
 Tue, 27 Feb 2024 17:10:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709050224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rGzIfnGBFAkBn9AWYxhSm/zHaLwNkJu2jbw+dW4Thrc=;
 b=g3SpqroaMDIwT7ueEW8xOyF6bam7CSi5FKVxEmOQJqDsIVQMN7OMj35PUcOtxcXgzRsnS9
 GrpQwvXsCY58YvxQdfO/Dnwc0P2GXTQ/3kzfvhocdYkzS0ko4eO8TmYgZvkzhNiMLNuHuT
 3zaAmqcc89zpZ1N1n7s1r2KToRAvMBYqhJfP4JZ6oJhhnCSASdIhBiMOWNsAxAlv1RF8a/
 O16QzNXasFti97EKmGn4jmzIp7F3yCMDmUrdaHsoxOJY5jIvCIH/9mcPtcOp7HsvfdTQr7
 tQUC+tJXbk7tg6WVYVEVb4/iO7m8j3232JePGpoqetkuL1AFSCMWZH/X/6I8ZQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709050222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rGzIfnGBFAkBn9AWYxhSm/zHaLwNkJu2jbw+dW4Thrc=;
 b=S8vpra97xaW/k7SzPgHAcDG/g+REZPjGNJ3dAvlnGW6HJc/47ONXZX89YeHRfMnwldum/X
 ONUsj5C9vF7zyP07cJ/JvvlBOV7/fyUGee87ue3t2HIXD1Ffm6mKgZqCKlGsvXztDlPDYw
 sCTnDKSHxPYgQAB3FyU0M6kN+UYXc1A/PndGt8qx+K0REgYscTgTcO23b/5JHueRmdYkQ4
 RwzURQJDV8alzS6Q4Er3y86kqWWOVp3zY6Xys8e9BmbeEeljDDUlce+Lct092dPE14SGdM
 sN7+8Fg5xob6rugoXXcU9rEcgoGYMBhIX2bEYnro+pgVMAQ8NsqSENXngByVEw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 18/19] mmc: renesas-sdhi: Rename rmobile_is_gen3_mmc0() to
 rcar_is_gen3_mmc0()
Date: Tue, 27 Feb 2024 17:05:58 +0100
Message-ID: <20240227160912.412181-19-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240227160912.412181-1-marek.vasut+renesas@mailbox.org>
References: <20240227160912.412181-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 29a3c00502ea3b5c6db
X-MBO-RS-META: 86y3d4db6zg3tcp3uubmngqgoy5e5bqk
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

Rename rmobile_is_gen3_mmc0() to rcar_is_gen3_mmc0() because
this particular function is specific to Renesas R-Car Gen3.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>
---
 drivers/mmc/renesas-sdhi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/renesas-sdhi.c b/drivers/mmc/renesas-sdhi.c
index 82237ef3dbd..20b1e9277eb 100644
--- a/drivers/mmc/renesas-sdhi.c
+++ b/drivers/mmc/renesas-sdhi.c
@@ -92,7 +92,7 @@ static const u8 r8a77990_calib_table[2][CALIB_TABLE_MAX] = {
 	 11, 12, 13, 15, 16, 17, 17, 18, 18, 19, 20, 22, 24, 25, 26, 26 }
 };
 
-static int rmobile_is_gen3_mmc0(struct tmio_sd_priv *priv)
+static int rcar_is_gen3_mmc0(struct tmio_sd_priv *priv)
 {
 	/* On R-Car Gen3, MMC0 is at 0xee140000 */
 	return (uintptr_t)(priv->regbase) == 0xee140000;
@@ -913,7 +913,7 @@ static void renesas_sdhi_filter_caps(struct udevice *dev)
 		priv->adjust_hs400_offset = 3;
 		priv->hs400_bad_tap = BIT(1) | BIT(3) | BIT(5) | BIT(7);
 		priv->adjust_hs400_calib_table =
-			r8a7796_rev13_calib_table[!rmobile_is_gen3_mmc0(priv)];
+			r8a7796_rev13_calib_table[!rcar_is_gen3_mmc0(priv)];
 	}
 
 	/* M3W+ bad taps */
@@ -926,7 +926,7 @@ static void renesas_sdhi_filter_caps(struct udevice *dev)
 		priv->adjust_hs400_enable = true;
 		priv->adjust_hs400_offset = 3;
 		priv->adjust_hs400_calib_table =
-			r8a77965_calib_table[!rmobile_is_gen3_mmc0(priv)];
+			r8a77965_calib_table[!rcar_is_gen3_mmc0(priv)];
 	}
 
 	/* E3 can use HS400 with manual adjustment */
@@ -934,7 +934,7 @@ static void renesas_sdhi_filter_caps(struct udevice *dev)
 		priv->adjust_hs400_enable = true;
 		priv->adjust_hs400_offset = 3;
 		priv->adjust_hs400_calib_table =
-			r8a77990_calib_table[!rmobile_is_gen3_mmc0(priv)];
+			r8a77990_calib_table[!rcar_is_gen3_mmc0(priv)];
 	}
 
 	/* H3 ES1.x, ES2.0 and M3W ES1.[0123] uses 4 tuning taps */
-- 
2.43.0

