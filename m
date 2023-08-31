Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C49CA0FE1
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 23:07:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 214138675B;
	Fri,  1 Sep 2023 01:07:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.b="Nu986KHY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF858865B0; Fri,  1 Sep 2023 01:07:16 +0200 (CEST)
Received: from s.wrqvtbkv.outbound-mail.sendgrid.net
 (s.wrqvtbkv.outbound-mail.sendgrid.net [149.72.123.24])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0730586682
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 01:07:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounces+31435339-7456-u-boot=lists.denx.de@em2124.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=from:subject:in-reply-to:references:mime-version:to:cc:
 content-transfer-encoding:content-type:cc:content-type:from:subject:to;
 s=s1; bh=vmvsNIuZzjbKCtKLRRO6pEcMhipphSsTBhHaZjDKjdA=;
 b=Nu986KHYu0ZGnV3d7XHEKoy1zDtvOhgvibCFjDJGORlT+evovDoTL9ffxQOFwWw08O5Y
 ca2GV2JkcEknG2A77KNFMzatEN3HqzjTQgILrWPpjwP12EAOex+zP7BCQYhY2UPHQbrmUv
 pNDIRsBFbQzdzKu3l6RBwWIcY4u5bZh/X+/6MVyiM+Lye1S87VuR/G5Nb42KqIffycEO7r
 Q9vRTEfKRg49+pBDo3zTntYekHzq3b7IdenG70l3lWzsnrQMbaWN/c+5wofPMxa0SsFXPn
 D6Zu0ipAdmycPjSAYRW7hBzNp10X631oi1gThFiC8qKdL2gKdctvkHAV7B5sDqrg==
Received: by filterdrecv-7765c6879f-749hs with SMTP id
 filterdrecv-7765c6879f-749hs-1-64F11D1F-22
 2023-08-31 23:07:11.491575756 +0000 UTC m=+1843969.100614513
Received: from bionic.localdomain (unknown) by geopod-ismtpd-4 (SG) with ESMTP
 id jXxX3WbyQTSGnalSY1snlQ Thu, 31 Aug 2023 23:07:11.255 +0000 (UTC)
From: Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 3/3] phy: Refactor generic_{setup, shutdown}_phy() to reduce
 complexity
Date: Thu, 31 Aug 2023 23:07:11 +0000 (UTC)
Message-ID: <20230831230705.1040105-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230831230705.1040105-1-jonas@kwiboo.se>
References: <20230831230705.1040105-1-jonas@kwiboo.se>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h0RA1YVzqEf=2FlgwjJ?=
 =?us-ascii?Q?VT=2FfMb+H4COhfKVOkNZ5fAMervWHOJMLul52dgt?=
 =?us-ascii?Q?A7fD1VHeqjdrhjPJAL30A5XSqpL3J+48SFY48Pu?=
 =?us-ascii?Q?eqUGYn7En9V7Fci=2FQB2abZa1uBze9UlvE2kMIVc?=
 =?us-ascii?Q?OTi6QqitoqDVoLA8jNYEj3YuvXE8fxW9XO352H?=
To: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
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

Refactor generic_{setup,shutdown}_phy() to reduce complexity and
indentation. This have no intended functional change.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2:
- Split code refactor into own patch

 drivers/phy/phy-uclass.c | 41 ++++++++++++++++------------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/drivers/phy/phy-uclass.c b/drivers/phy/phy-uclass.c
index 343c23cead0c..190108e04c7f 100644
--- a/drivers/phy/phy-uclass.c
+++ b/drivers/phy/phy-uclass.c
@@ -510,44 +510,35 @@ int generic_phy_power_off_bulk(struct phy_bulk *bulk)
 
 int generic_setup_phy(struct udevice *dev, struct phy *phy, int index)
 {
-	int ret = 0;
-
-	if (!phy)
-		return 0;
+	int ret;
 
 	ret = generic_phy_get_by_index(dev, index, phy);
-	if (ret) {
-		if (ret == -ENOENT)
-			return 0;
-	} else {
-		ret = generic_phy_init(phy);
-		if (ret)
-			return ret;
+	if (ret)
+		return ret == -ENOENT ? 0 : ret;
 
-		ret = generic_phy_power_on(phy);
-		if (ret)
-			generic_phy_exit(phy);
-	}
+	ret = generic_phy_init(phy);
+	if (ret)
+		return ret;
+
+	ret = generic_phy_power_on(phy);
+	if (ret)
+		generic_phy_exit(phy);
 
 	return ret;
 }
 
 int generic_shutdown_phy(struct phy *phy)
 {
-	int ret = 0;
+	int ret;
 
-	if (!phy)
+	if (!generic_phy_valid(phy))
 		return 0;
 
-	if (generic_phy_valid(phy)) {
-		ret = generic_phy_power_off(phy);
-		if (ret)
-			return ret;
-
-		ret = generic_phy_exit(phy);
-	}
+	ret = generic_phy_power_off(phy);
+	if (ret)
+		return ret;
 
-	return ret;
+	return generic_phy_exit(phy);
 }
 
 UCLASS_DRIVER(phy) = {
-- 
2.42.0

