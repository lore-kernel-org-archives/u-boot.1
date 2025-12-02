Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4DA2CFD2F6
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 08:16:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4485D83E45;
	Tue,  2 Dec 2025 09:16:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="LiuG4OkV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD2C083E21; Tue,  2 Dec 2025 09:16:14 +0100 (CET)
Received: from mx-relay75-hz1.antispameurope.com
 (mx-relay75-hz1.antispameurope.com [94.100.132.238])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC58C83E28
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 09:16:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=042460c183=max.merchel@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate75-hz1.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6,
 headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out03-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=RShDpxbiwMs0SbJFikxb+1a+mcY2skWnEKvZ+tPq2uQ=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1764663372;
 b=dODgv2A4ejp34rjZRsAm3aj8i2m4z4Z1/KYETJp4D6/SFNCUE3GYO7h+qk67AXiKGW4YtSxW
 Z4aA7kVyB3xikiKBYDorcmO9LhyILeJbbDowcBcb86KM0p73D41rcbvvg7zYmUreb9izgKE6ugF
 HWVDD36UASfHGLl0moL1OI9QpliU4hy+nvGCggNDFgYw6XJ9mOGA0+/Gf9zy2MCn4wugaMbL17G
 wfTwyTnXTJup0MZbAJBYbEK91wyuInDugg5RqrehtfqQ32btOJ6FwP5GImVWBBfUsI3F99q5zh0
 rzJr8AUYx8nsZ1koSqfixXaRdMGXSrXaz1isy/9rnmKwA==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1764663372;
 b=WfCVL6I9I53eiNHI/TUinU/ZUs/MiZdwMv+0u8Kz4n5a1frCRUAxj9/o6RS6U3FRgA3JbzYT
 ktmXO1wC7WkuzKUu5m0SWiF6jzSAtZfnZ0lQjQ8mfEuusy1b6vb/409v8yloflIbE0Wk4LquQbQ
 B5IwJbOqK85xh387npbnWMofxSBzp1LTp2DSuMvjYMhpaDytOkADphA2sIxxppuC540miQaEWzM
 GJ8DfoZqrmn+BYkAWqiv2M9qRT0lxk2jaFbrOQTwUNtFbGGiS3JqkdrvBZNkZ1aEHHg6Z9az9yY
 lsco8mLXhb7u4T7e6dQ/zRBHztXgEENnmnGG+24uxtIQQ==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay75-hz1.antispameurope.com; Tue, 02 Dec 2025 09:16:11 +0100
Received: from merchelm-W2.tq-net.de
 (host-82-135-125-110.customer.m-online.net [82.135.125.110])
 (Authenticated sender: max.merchel@ew.tq-group.com)
 by hmail-p-smtp01-out03-hz1.hornetsecurity.com (Postfix) with ESMTPSA id
 29576CC0E96; Tue,  2 Dec 2025 09:15:56 +0100 (CET)
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, Quentin Schulz <quentin.schulz@cherry.de>,
 Max Merchel <Max.Merchel@ew.tq-group.com>
Subject: [PATCH v2 1/2] net: phy: micrel_ksz90x1: disable asymmetric pause for
 KSZ9031 and KSZ9021
Date: Tue,  2 Dec 2025 09:13:42 +0100
Message-ID: <20251202081352.302025-2-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251202081352.302025-1-Max.Merchel@ew.tq-group.com>
References: <20251202081352.302025-1-Max.Merchel@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender: max.merchel@ew.tq-group.com
X-cloud-security-recipient: u-boot@lists.denx.de
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: max.merchel@ew.tq-group.com
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on
 mx-relay75-hz1.antispameurope.com with 4dLD9m4Y9vz2tV5S
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: 8751c42e2f54f8f9baa9675ce31b91e7
X-cloud-security: scantime:1.859
DKIM-Signature: a=rsa-sha256;
 bh=RShDpxbiwMs0SbJFikxb+1a+mcY2skWnEKvZ+tPq2uQ=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1764663371; v=1;
 b=LiuG4OkVhL81rhwiMiLrU3vanjAYxtKIT83FCELqidZgoBVPLJ9NwPqZa/1x8GxsmXzr0w1u
 IG6gY3NPnxs7a6uELFlrmJjqFzuyRQ+4m6TXlT+kXXwpq/tXH9joh+yLg0FP4OUgXFon0ZdO9Pi
 MYX8hlcYUoHeqL12uvUb+z8IV3OYekoQB+eqL/xbch4NdbIw7AYN2Car7v2m/bTF+7fto+jOn+D
 GrejTQm3ZWzz4kGVv1sqlrqOIfcO3x2/17sq+aWkYNu3OjbR3JZSyP7JLUj3FbcfHT+NNKP9wFX
 +eqivaFhfxm6Y1K7KSKyPdHG/LiPHOiU7m/VzcmM5isKA==
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
 drivers/net/phy/micrel_ksz90x1.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/net/phy/micrel_ksz90x1.c b/drivers/net/phy/micrel_ksz90x1.c
index a02dbe900b8..a669a5789b9 100644
--- a/drivers/net/phy/micrel_ksz90x1.c
+++ b/drivers/net/phy/micrel_ksz90x1.c
@@ -217,6 +217,31 @@ static int ksz9031_center_flp_timing(struct phy_device *phydev)
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
+	/* We force setting the Pause capability as the core will force the
+	 * Asymmetric Pause capability to 1 otherwise.
+	 */
+	features |= ADVERTISE_PAUSE_CAP;
+
+	/* update feature support and forward to advertised features */
+	phydev->supported = features;
+	phydev->advertising = phydev->supported;
+}
+
 /*
  * KSZ9021
  */
@@ -260,6 +285,8 @@ static int ksz9021_config(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
+	ksz90x1_workaround_asymmetric_pause(phydev);
+
 	if (env_get("disable_giga"))
 		features &= ~(SUPPORTED_1000baseT_Half |
 		SUPPORTED_1000baseT_Full);
@@ -345,6 +372,8 @@ static int ksz9031_config(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
+	ksz90x1_workaround_asymmetric_pause(phydev);
+
 	/* add an option to disable the gigabit feature of this PHY */
 	if (env_get("disable_giga")) {
 		unsigned features;
-- 
2.43.0

