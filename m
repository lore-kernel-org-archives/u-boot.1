Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B81ACA0FED
	for <u-boot@archiver.kernel.org>; Sat,  6 Sep 2025 23:01:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F16E838F3;
	Sun,  7 Sep 2025 01:01:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="bKam2Z7Q";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ZaroFwlr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B1F383906; Sun,  7 Sep 2025 01:01:08 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D978083327
 for <u-boot@lists.denx.de>; Sun,  7 Sep 2025 01:01:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cK7xF523Yz9tHG;
 Sun,  7 Sep 2025 01:01:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757199665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=857PyeXzVJgb77JCYFQR/KGQlA514khANTKEQ/5is7o=;
 b=bKam2Z7QvrCFj8ayfWdXg5AyvokYasUmQ1AVcVGiNNRgBPR8vCcaahB6gUrJaoGpq7mO9C
 Ou3IJQVYh5mGNnfzEq/21LKgSWiTmdVTxGcBsgH67maosJfBNUADUBUi8+QYNFSdDLIhFh
 f8nyRDz9AkBIbLCQ1LkVJWLhhZI6ZMR8r9AJh0+itxyo9dsZ67ENMtOqaWYMS+DJWEjpuc
 FBrC+DkjBjFzOvh9fvtd1KzYCkHtgzKmodEOgTT9Kr2FD7Kramwjiof7qDidv8QnFdPB5s
 m9GQnx1eJcEyeS7e2/NpuI+L6i3EhMPV3YnpotuMPeHo5omHG67VCtuVSK2xPw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=ZaroFwlr;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757199663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=857PyeXzVJgb77JCYFQR/KGQlA514khANTKEQ/5is7o=;
 b=ZaroFwlrKa4VjgfhtI8vcQ96Yu+xfmYQPqOY1ICs4weNkXpU0FZ4ug26uk+866XbBUfejX
 xk56XX824QgMUxeBopCOL7J6Xis+q46uQsCYonUsK3VDxdA0TwSW47v9amAFQirsEXvRIH
 a3KT9S0iDf3n+Z0sILPazm3DPKmYu5x7pPFAuxxQWGFz3Pv12Ytk+SSzJwBKBzvRXQ3she
 QUPOHl1T94zniG2mnqXZ4KEhjHHhXMXeCORjZIDzPcJjN6ZEdZnzXRsfUkI3929HCwUSb4
 fPE6Y/XaDgP9QQiIifvIKpUUkgWB2czOvfQc9GRQYhXpnBlJrzJCHAp1QGha6Q==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Roger Quadros <rogerq@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] phy: Reset init count on phy exit failure
Date: Sun,  7 Sep 2025 01:00:44 +0200
Message-ID: <20250906230052.582621-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 55c60d2124ffc46f775
X-MBO-RS-META: 44idi9tr4sxf84344d39zbzy8r6auo51
X-Rspamd-Queue-Id: 4cK7xF523Yz9tHG
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

In case the PHY exit callback reports failure, reset init_count to 0 anyway,
so the next attempt at PHY initialization might try to reinitialize the PHY
and restore it to normal operation.

Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/phy/phy-uclass.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/phy-uclass.c b/drivers/phy/phy-uclass.c
index 714be123856..f8d4fb3b41b 100644
--- a/drivers/phy/phy-uclass.c
+++ b/drivers/phy/phy-uclass.c
@@ -274,7 +274,7 @@ int generic_phy_exit(struct phy *phy)
 {
 	struct phy_counts *counts;
 	struct phy_ops const *ops;
-	int ret;
+	int ret = 0;
 
 	if (!generic_phy_valid(phy))
 		return 0;
@@ -292,12 +292,11 @@ int generic_phy_exit(struct phy *phy)
 		if (ret) {
 			dev_err(phy->dev, "PHY: Failed to exit %s: %d.\n",
 				phy->dev->name, ret);
-			return ret;
 		}
 	}
 	counts->init_count = 0;
 
-	return 0;
+	return ret;
 }
 
 int generic_phy_power_on(struct phy *phy)
-- 
2.50.1

