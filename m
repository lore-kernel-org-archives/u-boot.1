Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA3C3C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 12:50:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B554879E2;
	Fri, 12 Jan 2024 13:50:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Cg0cGZc2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F7A387937; Fri, 12 Jan 2024 13:50:12 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6F88879C5
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 13:50:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id B59FCCE23B7;
 Fri, 12 Jan 2024 12:50:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1454EC433F1;
 Fri, 12 Jan 2024 12:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705063804;
 bh=QKjQXZoajPcYNUch3wz/ynB2tiEy4wpfOOEMVwCRIok=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Cg0cGZc20xHRhHlQ50VqXhGb120Xq1erDz1Q0RpLJJucj2jERaroHuKFqBCroJDjD
 F9FvDWxD6vc2y/amPw1ewZrJQcIubyIH3f39s9lawnlXVb3b271dqLaeNZRi4cu9l5
 DbYVx2CVp19R5MY000UXX6fMzSYXY8qkncs2SmNJ0ISIRCFk1pmqnsC5j/iYk/XkWg
 FYXMZzW1jeOHTjdGNt1FYi3r4ch068+NWWdSpdZDUwdGGN+K97DOSk6DrwdTSisjo8
 IKXEqBFtvSBkVbu2v53Jrrpl1tnIZ9FbXrihXpkt/cerhM1zUcVkqUl0F6Exo8G+Ht
 Axhcn5PwFBd3A==
From: Roger Quadros <rogerq@kernel.org>
To: nm@ti.com,
	robertcnelson@gmail.com,
	trini@konsulko.com,
	marex@denx.de
Cc: n-francis@ti.com, praneeth@ti.com, s-vadapalli@ti.com,
 r-gunasekaran@ti.com, srk@ti.com, vigneshr@ti.com, u-boot@lists.denx.de,
 Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 2/5] usb: cdns3: avoid error messages if phys don't exist
Date: Fri, 12 Jan 2024 14:49:48 +0200
Message-Id: <20240112124951.238098-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240112124951.238098-1-rogerq@kernel.org>
References: <20240112124951.238098-1-rogerq@kernel.org>
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

The phys property is optional so don't complain
if it doesn't exist in device tree.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/usb/cdns3/core.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index 644a9791b9..12a741c6ea 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -333,20 +333,28 @@ static int cdns3_probe(struct cdns3 *cdns)
 	mutex_init(&cdns->mutex);
 
 	ret = generic_phy_get_by_name(dev, "cdns3,usb2-phy", &cdns->usb2_phy);
-	if (ret)
-		dev_warn(dev, "Unable to get USB2 phy (ret %d)\n", ret);
-
-	ret = generic_phy_init(&cdns->usb2_phy);
-	if (ret)
+	if (!ret) {
+		ret = generic_phy_init(&cdns->usb2_phy);
+		if (ret) {
+			dev_err(dev, "USB2 PHY init failed: %d\n", ret);
+			return ret;
+		}
+	} else if (ret != -ENOENT && ret != -ENODATA) {
+		dev_err(dev, "Couldn't get USB2 PHY:  %d\n", ret);
 		return ret;
+	}
 
 	ret = generic_phy_get_by_name(dev, "cdns3,usb3-phy", &cdns->usb3_phy);
-	if (ret)
-		dev_warn(dev, "Unable to get USB3 phy (ret %d)\n", ret);
-
-	ret = generic_phy_init(&cdns->usb3_phy);
-	if (ret)
+	if (!ret) {
+		ret = generic_phy_init(&cdns->usb3_phy);
+		if (ret) {
+			dev_err(dev, "USB3 PHY init failed: %d\n", ret);
+			return ret;
+		}
+	} else if (ret != -ENOENT && ret != -ENODATA) {
+		dev_err(dev, "Couldn't get USB3 PHY:  %d\n", ret);
 		return ret;
+	}
 
 	ret = generic_phy_power_on(&cdns->usb2_phy);
 	if (ret)
-- 
2.34.1

