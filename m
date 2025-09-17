Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A983CAC598
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 09:10:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96FB0834D4;
	Wed, 17 Sep 2025 11:09:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="dTyy1sHt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="78C9Ok0h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 298AA83510; Wed, 17 Sep 2025 11:09:58 +0200 (CEST)
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AF6D8349B
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 11:09:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=b.spranger@linutronix.de
From: Benedikt Spranger <b.spranger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1758100195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=dT840Bmq6x/hbQBpxit4dr1XPaPD53+O3LN7vrRjf04=;
 b=dTyy1sHtt5MNNqV544QeXF30cCahkiaXEpRaI27CYMxfe8RnHyKdLKRIeVWcDgAdbEX179
 01Db4OLpJn/7LIGD5HPrj+q2RFTuPOEwxStGgE9PCrsV2cmio2VgxfWLed07l/WUQvVN3N
 ZYSL8Z30PhB1xUPguCZvN8+xJKzJIeamqexNxlzIpL6zOEKveWz46HdJvANI+qzKHpY2Ur
 amuqbYD9X+axbq7hySNWdWtXC0gRFOVSQC4hA33tjbVpnH5G/mgGYidssGoCRiE9v4Ph3R
 +N+YkWuEWM83ii24DPY8Dn1I+rWn00EufEQrupI69LLGbqUh36GRnQt9wadUhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1758100195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=dT840Bmq6x/hbQBpxit4dr1XPaPD53+O3LN7vrRjf04=;
 b=78C9Ok0hPqgKdSIGunw8RYKgf0YXHU9FB/yredaQcEnd2woj62eknteeIfAW7GqhxnY5VS
 m6tgIBDTicOIuZCg==
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, John Ogness <john.ogness@linutronix.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [RESEND PATCH] drivers/mtd/ubispl/ubispl.c: limit copy size
Date: Wed, 17 Sep 2025 11:14:17 +0200
Message-ID: <20250917091417.545-1-b.spranger@linutronix.de>
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

The fastmap VID header is embedded in struct ubi_scan_info. During fastmap
scan, the header is copied into struct ubi_scan_info, if valid. The former
code mixed up the amount of copied bytes and copied more bytes than
nessesary. This had no side effect, since the affected struct members are
uninitialized at that point and overwritten later.

Limit the copied bytes to the VID header size.

Signed-off-by: Benedikt Spranger <b.spranger@linutronix.de>
Reported-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/mtd/ubispl/ubispl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/ubispl/ubispl.c b/drivers/mtd/ubispl/ubispl.c
index 9face5fae15..0143caa051d 100644
--- a/drivers/mtd/ubispl/ubispl.c
+++ b/drivers/mtd/ubispl/ubispl.c
@@ -779,7 +779,7 @@ static int ubi_scan_fastmap(struct ubi_scan_info *ubi,
 		 * that already so we merily copy it over.
 		 */
 		if (pnum == fm_anchor)
-			memcpy(vh, ubi->blockinfo + pnum, sizeof(*fm));
+			memcpy(vh, ubi->blockinfo + pnum, sizeof(*vh));
 
 		if (i == 0) {
 			if (be32_to_cpu(vh->vol_id) != UBI_FM_SB_VOLUME_ID) {
-- 
2.51.0

