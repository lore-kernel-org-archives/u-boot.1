Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F11C2D29DE9
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 08:20:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C833D836C8;
	Tue, 13 Jan 2026 09:20:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="E0J5vGcF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7720808AF; Tue, 13 Jan 2026 09:20:40 +0100 (CET)
Received: from mx-relay49-hz3.antispameurope.com
 (mx-relay49-hz3.antispameurope.com [94.100.134.238])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B43FB83015
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 09:20:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=04663608a3=max.merchel@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate49-hz3.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6,
 headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out01-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=Dhe/S4NKCrlI/0CVGhnO9lclgW3+jshOPxbTYRvvzuk=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1768292438;
 b=la27FbkV3yAqmqwi/18CYRZ4mgUI5ptHYLlVaqXQyxSjfs5ZqjdgUHXjhat5ie/W8s6w9HDo
 yYH5Z13LGnrMdr066RbMue/rjsXXGck2XoiCrwtvcoD863ILoECKlvVcgAkeydS9gUCuj31+kD7
 FWNZoByl+G/ewamMq/Z5p8h+jWhUEQ15rRHEVHGVczveXqFWBK77yaX3bkd4UPHU6ZO+U1qCVft
 S3e2R8/11HTveM/HxdBsqq9iRYSmQUOjUTQ9xCpLhg8SM6odn69CNCEWydIA+0dvCtRHLiDJfu5
 pJfe4JW+p24OTh/vOBHc/e5eVKnLk0LNi5jDG4Wi5oW3A==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1768292438;
 b=CLEQVf+CCgCa5BWWU3/mm6iH99wxhOjc/JntpVlk1lH880BCV4kFeUR/cJAtCid2Kt4lIIvM
 zMidZ2GZRH9CKhEgkCrjVhmPSGY0kvUnzUcO/TjCTzK4R/x9I28C1evam87rQ/7YwzmtwncSeQr
 4o0t6C3w11HMjk/b5tb/dEs+IoYCOeYW4EJBQuP/V6LCexE08uyUxLzX2nSsW01r64GFCTpt4Jm
 ptb5OMBhPZ+6hxduLq5TSFlRUSwzGKdDkaD46F35vICfwaXvqr6FiUbyZEARYRJBOLPuY9g6mJt
 EibY1loPmsY+iW0eib8R6VLsQz8R6yFRmW/8Cs1kc0PzQ==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay49-hz3.antispameurope.com; Tue, 13 Jan 2026 09:20:37 +0100
Received: from merchelm-W2.tq-net.de
 (host-82-135-125-110.customer.m-online.net [82.135.125.110])
 (Authenticated sender: max.merchel@ew.tq-group.com)
 by smtp-out01-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 923A7A4125C;
 Tue, 13 Jan 2026 09:20:19 +0100 (CET)
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome@forissier.org>, Tom Rini <trini@konsulko.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, Quentin Schulz <quentin.schulz@cherry.de>,
 Max Merchel <Max.Merchel@ew.tq-group.com>
Subject: [RESEND PATCH v2 1/2] net: phy: micrel_ksz90x1: disable asymmetric
 pause for KSZ9031 and KSZ9021
Date: Tue, 13 Jan 2026 09:16:37 +0100
Message-ID: <20260113081726.502484-2-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113081726.502484-1-Max.Merchel@ew.tq-group.com>
References: <20260113081726.502484-1-Max.Merchel@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender: max.merchel@ew.tq-group.com
X-cloud-security-recipient: u-boot@lists.denx.de
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: max.merchel@ew.tq-group.com
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on
 mx-relay49-hz3.antispameurope.com with 4dr2HS0zDBz3ybCn
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: 78026e732b679159119d029a77ce5b9e
X-cloud-security: scantime:2.180
DKIM-Signature: a=rsa-sha256;
 bh=Dhe/S4NKCrlI/0CVGhnO9lclgW3+jshOPxbTYRvvzuk=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1768292437; v=1;
 b=E0J5vGcFD0+cvbE5GbukaH3Rl9J4UrzRX/4sIWGYnwszrdDZKlm/+I8mOyhGu81lsDbUdc75
 /6xTjNWAN+z51e9brPI6oZWz+WMxkiCyI0mruEYLCvs56g+sjK73MlDEFTK2jZCDXO4+RZw5oow
 LnaR874oX8v3nl2Bk8mXYKoA5Gj91vJeC9NUsEzkxPonEg2Npl6C0OMk6U+ob4jWQpXAKc71vMX
 ubVAxGDEnrhwAja+yNmVXmVUoSUFG8GSviIwGrMtUg7UHJxDv65ciwUJmlieegzswKWlDTrrQ1N
 644fF1wQbVaBOBIktmzzb2bdnhL4Cj7bHF9orheLxuPNg==
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

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

Disable the support due to chip errata and call genphy_config_aneg
instead of genphy_config. For a complete describtion look at the
KSZ9031 errata sheets: DS80000691D or DS80000692D.

Micrel KSZ9021 has no errata, but has the same issue with Asymmetric Pause.
This patch apply the same workaround as the one for KSZ9031.

This follows linux implementation in commits
3aed3e2a143c ("net: phy: micrel: add Asym Pause workaround")
407d8098cb1a ("net: phy: micrel: add Asym Pause workaround for KSZ9021")

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 drivers/net/phy/micrel_ksz90x1.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/phy/micrel_ksz90x1.c b/drivers/net/phy/micrel_ksz90x1.c
index a02dbe900b8..3066c2ed73f 100644
--- a/drivers/net/phy/micrel_ksz90x1.c
+++ b/drivers/net/phy/micrel_ksz90x1.c
@@ -217,6 +217,26 @@ static int ksz9031_center_flp_timing(struct phy_device *phydev)
 	return ret;
 }
 
+static void ksz90x1_workaround_asymmetric_pause(struct phy_device *phydev)
+{
+	u32 features = phydev->drv->features;
+
+	/* Silicon Errata Sheet (DS80000691D or DS80000692D):
+	 * Whenever the device's Asymmetric Pause capability is set to 1,
+	 * link-up may fail after a link-up to link-down transition.
+	 *
+	 * The Errata Sheet is for ksz9031, but ksz9021 has the same issue
+	 *
+	 * Workaround:
+	 * Do not enable the Asymmetric Pause capability bit.
+	 */
+	features &= ~ADVERTISE_PAUSE_ASYM;
+
+	/* update feature support and forward to advertised features */
+	phydev->supported = features;
+	phydev->advertising = phydev->supported;
+}
+
 /*
  * KSZ9021
  */
@@ -260,6 +280,8 @@ static int ksz9021_config(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
+	ksz90x1_workaround_asymmetric_pause(phydev);
+
 	if (env_get("disable_giga"))
 		features &= ~(SUPPORTED_1000baseT_Half |
 		SUPPORTED_1000baseT_Full);
@@ -345,6 +367,8 @@ static int ksz9031_config(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
+	ksz90x1_workaround_asymmetric_pause(phydev);
+
 	/* add an option to disable the gigabit feature of this PHY */
 	if (env_get("disable_giga")) {
 		unsigned features;
-- 
2.43.0

