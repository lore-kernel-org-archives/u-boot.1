Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3605E7718A
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 00:50:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42BE18036E;
	Fri, 20 Dec 2024 01:50:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="OsW9dTPy";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="lfp2F+4E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98AE28033A; Fri, 20 Dec 2024 01:50:32 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07B8F80326
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 01:50:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4YDpjx5wrhz9sX2;
 Fri, 20 Dec 2024 01:50:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734655829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WT+UZ5js+D4FZ1gBmA2iXliE/aIFRX8Gp/Q4nWPLTOI=;
 b=OsW9dTPyOe1mdQBrdY/IVqm7jMYx8TM4wWTinohG251RSjWUbjoBTVlUQ6esOxgYelHZ31
 UM3nVHNgIUTDJnQV64fRRYz+R3aNNo/UKS8ogmZp12zRkhnHgsG3zNp0lY3S3H9i58J9a1
 jcyUFmvQrIBCnehCwCAprMKowBi7yULLLfZ9zBwVMqHMJWSbja8yOHAVPyAVtc2kRFAjmz
 Y9eDlal+qfbrQ5mpFbeg+ePdcCae54y46w8uFbP75zOtvdZlnK9caQ3Lsh0eBVmNDaaP7n
 mONAr8YBz8yahbd3jTFysT04y1uE4NyPVwBeDcnOLGEQI/R9EaRSddeAtpye7g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734655828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WT+UZ5js+D4FZ1gBmA2iXliE/aIFRX8Gp/Q4nWPLTOI=;
 b=lfp2F+4EqTlxmmEaFtO6I95L58LMZhrIyeVMKuI5xm7QoNTjEi56rdSN7gTYW+g2yPojHN
 arMC7lnmv/I9FJ2BulPC7dQrpcrQUfM5s3S8wqJNcQAni2IOfiLKXAD4e+LfynXDF/jY9F
 VNSlgiA4riyioyMbhXHlN5hWKecS9+tLW7DYS6A8UXl4noBJl6k8ZDqx2AvPNxmvaHtckA
 lH6ObdsQeLDAThpWY2G7vQELqkhKgYepPi+vgItoDwZ2r4RH0h2ZwFJQSKbkOMHpObN69Q
 25IU19OE14mBl4JCxBwgz0aG/WcGlHICvORQqhGQso1pmLGhTic3QJQcJHSbjw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] net: rswitch: Implement C22 to C45 access
Date: Fri, 20 Dec 2024 01:48:42 +0100
Message-ID: <20241220005007.169383-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241220005007.169383-1-marek.vasut+renesas@mailbox.org>
References: <20241220005007.169383-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: wog4sqmz38r71h3qa94sm8uoh4mzh785
X-MBO-RS-ID: c71f4b7418672629443
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

Add support for mapping C22 register access to C45-only PHYs.
This is mainly useful for 'mii info' command, which performs
C22 only access to determine PHY ID and link state and does
not work well with this driver so far.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/net/rswitch.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/rswitch.c b/drivers/net/rswitch.c
index df0c3864b59..06be8b64882 100644
--- a/drivers/net/rswitch.c
+++ b/drivers/net/rswitch.c
@@ -469,6 +469,8 @@ static int rswitch_mii_read_c45(struct mii_dev *miidev, int phyad, int devad, in
 	/* Access PHY register */
 	if (devad != MDIO_DEVAD_NONE)	/* Definitelly C45 */
 		val = rswitch_mii_access_c45(etha, true, phyad, devad, regad, 0);
+	else if (etha->phydev->is_c45)	/* C22 access to C45 PHY */
+		val = rswitch_mii_access_c45(etha, true, phyad, 1, regad, 0);
 	else
 		val = rswitch_mii_access_c22(etha, true, phyad, regad, 0);
 
@@ -500,6 +502,8 @@ int rswitch_mii_write_c45(struct mii_dev *miidev, int phyad, int devad, int rega
 	/* Access PHY register */
 	if (devad != MDIO_DEVAD_NONE)	/* Definitelly C45 */
 		rswitch_mii_access_c45(etha, false, phyad, devad, regad, data);
+	else if (etha->phydev->is_c45)	/* C22 access to C45 PHY */
+		rswitch_mii_access_c45(etha, false, phyad, 1, regad, data);
 	else
 		rswitch_mii_access_c22(etha, false, phyad, regad, data);
 
-- 
2.45.2

