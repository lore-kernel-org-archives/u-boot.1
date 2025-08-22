Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45CC6CA0EED
	for <u-boot@archiver.kernel.org>; Fri, 22 Aug 2025 18:34:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA9ED829E7;
	Fri, 22 Aug 2025 20:34:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=grimler.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=grimler.se header.i=@grimler.se header.b="cZULEULw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3897C82E34; Fri, 22 Aug 2025 20:34:37 +0200 (CEST)
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com
 [95.215.58.181])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10D8882103
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 20:34:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=grimler.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=henrik@grimler.se
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
 t=1755887674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s258ZGVJ5WbFOJtNupcqyVuTKG3AkbcA9Bjld4uu+/c=;
 b=cZULEULwiOQ7ofIoc6rPLQ4ni32Oi06XNoFUDb0EHAyy+KKCQo1A5JojQxsQmTFQuHaezD
 wk0+tVUqVLHxWRFp4jreBMpWyrGlB6zSbvrFFrVlnpYMOGWbDUG+7AyEyVtSgACbaA/9zJ
 NW3FXA1pNjarBuMxEh4zYUKbjV/2jgA=
From: Henrik Grimler <henrik@grimler.se>
Date: Fri, 22 Aug 2025 20:33:23 +0200
Subject: [PATCH 01/11] power: pmic: s2mps11: look for both
 {voltage-,}regulators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-b4-exynos-power-v1-1-9e2f2f740029@grimler.se>
References: <20250822-b4-exynos-power-v1-0-9e2f2f740029@grimler.se>
In-Reply-To: <20250822-b4-exynos-power-v1-0-9e2f2f740029@grimler.se>
To: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: David Virag <virag.david003@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 ~postmarketos/upstreaming@lists.sr.ht, u-boot@lists.denx.de, 
 Henrik Grimler <henrik@grimler.se>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1316; i=henrik@grimler.se;
 h=from:subject:message-id; bh=T7eTBH5t4ICsuRMQxgSipktU8pryARCzhhz0fHrWzYg=;
 b=owEBbQGS/pANAwAKAbAHbkkLcWFrAcsmYgBoqLgSbIb/neOuJO3+aOdTT1d+kVEPEJ64xPbgZ
 BTMwNRH7eKJATMEAAEKAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCaKi4EgAKCRCwB25JC3Fh
 a/9kB/0eHAiJNr1MuvoaTjm+DilPGoipp4Kuu6nFOb5RrFyTCoKFFSYYG4cTuuzE7lFUCSw5k1k
 gutazM8x0SlWTcg64BpAZBxO93UxbHq9JxEJFcoLDFzk6uZpp1EBXnmbgbIvQFUQkv9Rm1eKfbE
 IjOvXwnKPetxU9uqXZY/4zO2BcWBeg4QVPvWrhxTnGaWL+VRcASw8vBkxdtofbOj73U5HmQtC7+
 zccpyUTTk/idWYUgfgRiMcpYkBrYSQ10YvKlpMNWD5QHqiGcEXWrn7T7Vt+w3SGAvKwBeASb2uO
 RtiQr8o8vkYm/qVG6xrcN9ULByuOJ0MDlRe1rSG5HiDXvyXb
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

Linux's DTSes uses regulators { }; while u-boot's DTSes uses
voltage-regulators { };.  Look for regulators, and fallback to
voltage-regulators if not found, so that both type of DTSes can be
used with the driver.

Signed-off-by: Henrik Grimler <henrik@grimler.se>
---
 drivers/power/pmic/s2mps11.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/power/pmic/s2mps11.c b/drivers/power/pmic/s2mps11.c
index 17780017035bc2f8c6b672976eb4d25e484307b7..3aa8cad0827f68f1d35505a09d629787250b0378 100644
--- a/drivers/power/pmic/s2mps11.c
+++ b/drivers/power/pmic/s2mps11.c
@@ -52,11 +52,14 @@ static int s2mps11_probe(struct udevice *dev)
 	ofnode regulators_node;
 	int children;
 
-	regulators_node = dev_read_subnode(dev, "voltage-regulators");
+	regulators_node = dev_read_subnode(dev, "regulators");
 	if (!ofnode_valid(regulators_node)) {
-		debug("%s: %s regulators subnode not found!\n", __func__,
-		      dev->name);
-		return -ENXIO;
+		regulators_node = dev_read_subnode(dev, "voltage-regulators");
+		if (!ofnode_valid(regulators_node)) {
+			debug("%s: %s regulators subnode not found!\n", __func__,
+			      dev->name);
+			return -ENXIO;
+		}
 	}
 
 	debug("%s: '%s' - found regulators subnode\n", __func__, dev->name);

-- 
2.50.1

