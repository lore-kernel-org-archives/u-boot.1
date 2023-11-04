Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2497C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 07:00:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC67B87114;
	Sat,  4 Nov 2023 08:00:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="YMzHV4XA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DDFC8711B; Sat,  4 Nov 2023 08:00:21 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EB62870FC
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 08:00:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (unknown [159.148.28.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id E33E33FB9D; 
 Sat,  4 Nov 2023 07:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1699081210;
 bh=DPK0oMHm1WXA4O0dLKMUBxFPW6kSky9Mi4EdE2oXgqI=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=YMzHV4XAsLgNY6ywjdBRXBmAAhZ9m/k3mAmCYS3iVQVVaHQQpdzjLXFmWJ8gCygwM
 J2a8c6874xv3LT2xBFNdc/aynzSwYijHn3ngbKTmnmE/bIuuKs9tK2TvoXdGnj8sgR
 gck8MrvF8Nq7495ArjTq/ASrVdRLRtR3WJAEibJdcfADNCzUMvVH86rQyMFlICSvkM
 hWLFTrWdeDpWI97CYOwfl+Sc7IknabS/yubQ6KL/PucEjciF45KTXdC7ZQCzkuDUu6
 yuNDzadUCsJOAr/pYFcf97Zew4AkVsVwozkV2EgzuTyxEk9ethcJ+0BdannzlRnn46
 ufnCaGXQpzliw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] rng: fix ARMv8.5 RNDR driver
Date: Sat,  4 Nov 2023 09:00:07 +0200
Message-Id: <20231104070007.30099-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

In different parts of our code we assume that the first RNG device is the
one to be used. Therefore it is preferable to detect the availability of
the RNDR register already in the bind method.

For signaling the non-existence of a device the driver model requires using
ENOENT (and not ENODEV).

Fixes: 31565bb0aa2d ("driver: rng: Add DM_RNG interface for ARMv8.5 RNDR registers")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/rng/arm_rndr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rng/arm_rndr.c b/drivers/rng/arm_rndr.c
index 55989743ea..4512330e68 100644
--- a/drivers/rng/arm_rndr.c
+++ b/drivers/rng/arm_rndr.c
@@ -62,10 +62,10 @@ static const struct dm_rng_ops arm_rndr_ops = {
 	.read = arm_rndr_read,
 };
 
-static int arm_rndr_probe(struct udevice *dev)
+static int arm_rndr_bind(struct udevice *dev)
 {
 	if (!cpu_has_rndr())
-		return -ENODEV;
+		return -ENOENT;
 
 	return 0;
 }
@@ -74,7 +74,7 @@ U_BOOT_DRIVER(arm_rndr) = {
 	.name = DRIVER_NAME,
 	.id = UCLASS_RNG,
 	.ops = &arm_rndr_ops,
-	.probe = arm_rndr_probe,
+	.bind = arm_rndr_bind,
 };
 
 U_BOOT_DRVINFO(cpu_arm_rndr) = {
-- 
2.40.1

