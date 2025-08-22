Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 309AECA0EED
	for <u-boot@archiver.kernel.org>; Fri, 22 Aug 2025 18:35:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE57482E34;
	Fri, 22 Aug 2025 20:34:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=grimler.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=grimler.se header.i=@grimler.se header.b="gb/Z+Ass";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C24B182103; Fri, 22 Aug 2025 20:34:39 +0200 (CEST)
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com
 [IPv6:2001:41d0:203:375::b0])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD41E82BA7
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 20:34:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=grimler.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=henrik@grimler.se
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
 t=1755887676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fnY8WORIsenzbR0mzl6+j7wXpzGfnDqPNtSka2h9hm4=;
 b=gb/Z+AssUCHeWjqMQDuFdJleK+t3SmNWW/4aziscM4D2AJ3s1Cuv+MvKzdtiO6e05uatEQ
 QcveqkJtH8r3yms8VqNPBq6Ses59QRHTbov1Wm6qzYo1Qt/0IaEUbKjNwxsJ0/VzLP+ktx
 Hxo7X1zD+53r+CB3Efs1KpT5PIS/to8=
From: Henrik Grimler <henrik@grimler.se>
Date: Fri, 22 Aug 2025 20:33:25 +0200
Subject: [PATCH 03/11] power: pmic: s2mps11: remove check for
 voltage-regulators node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-b4-exynos-power-v1-3-9e2f2f740029@grimler.se>
References: <20250822-b4-exynos-power-v1-0-9e2f2f740029@grimler.se>
In-Reply-To: <20250822-b4-exynos-power-v1-0-9e2f2f740029@grimler.se>
To: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: David Virag <virag.david003@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 ~postmarketos/upstreaming@lists.sr.ht, u-boot@lists.denx.de, 
 Henrik Grimler <henrik@grimler.se>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1133; i=henrik@grimler.se;
 h=from:subject:message-id; bh=UjIIPUC7otVYbEgucbucP3YBAWyYFW4r4QACWSaot3Q=;
 b=owEBbQGS/pANAwAKAbAHbkkLcWFrAcsmYgBoqLgaEHFaZ0j1L78S9ywsnBcaWcuH9ByMC7sjS
 V+RMxdpnUCJATMEAAEKAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCaKi4GgAKCRCwB25JC3Fh
 a2x+CADKc8KxU/L2/KUtcZ3jEXYMn2m/gAIssc6nN5k//JizxqvfM0rFM65xYpjyqaAo4H14Aue
 arVZyM93NwXKU2BEu7xgVNV6bDDeVA0A4vsQAAOtqDcgTELJCuoa3+yKscmFaFHe65wTi4SIbvf
 xmcOGNlSbdfl0fwrs4lksZNpIvZtZHl5Vw21Et72iTkB29ePe6WEtBnlwXCjLpkNUawTkw+JZ1M
 j/WN9DdPKevmTQuKF3in9iVsMoG/RrbaS0bEnkl7FXL4KvFIEh88Su28VBxYiMUZX1jF0XZpxpd
 ylUP3EHEFMskVkSCaAnqcgINx94SAKrVD5vC6mJBKTiMkgxm
X-Developer-Key: i=henrik@grimler.se; a=openpgp;
 fpr=2C7F29AE97891F6419A9E2CDB0076E490B71616B
X-Migadu-Flow: FLOW_OUT
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

All devicetrees that use s2mps11 driver have been converted to use
regulators { };, so we can safely drop the voltage-regulators fallback
check.

Signed-off-by: Henrik Grimler <henrik@grimler.se>
---
 drivers/power/pmic/s2mps11.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/power/pmic/s2mps11.c b/drivers/power/pmic/s2mps11.c
index 3aa8cad0827f68f1d35505a09d629787250b0378..6e81957903012d0f33fbea44c70db4b583993a99 100644
--- a/drivers/power/pmic/s2mps11.c
+++ b/drivers/power/pmic/s2mps11.c
@@ -54,12 +54,9 @@ static int s2mps11_probe(struct udevice *dev)
 
 	regulators_node = dev_read_subnode(dev, "regulators");
 	if (!ofnode_valid(regulators_node)) {
-		regulators_node = dev_read_subnode(dev, "voltage-regulators");
-		if (!ofnode_valid(regulators_node)) {
-			debug("%s: %s regulators subnode not found!\n", __func__,
-			      dev->name);
-			return -ENXIO;
-		}
+		debug("%s: %s regulators subnode not found!\n", __func__,
+		      dev->name);
+		return -ENXIO;
 	}
 
 	debug("%s: '%s' - found regulators subnode\n", __func__, dev->name);

-- 
2.50.1

