Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A01C52D7F
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 07:10:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48F03889BD;
	Wed, 14 Aug 2024 09:10:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="LzJImYLq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC8228899D; Wed, 14 Aug 2024 09:10:51 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EE65889B4
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 09:10:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7CA944596A
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 07:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1723619447;
 bh=RZ4QawCH4MyAh+3rPTID2nJgXq+JC1xJ+WhJskUUAH8=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=LzJImYLqjfcyEjZH/V3O+2TL4LjNO4DfwrSytcGvV+22NJdF9UidNUQOFRqV91uvK
 UXvtwjMD2bS+ghs8YtU56d1CFWlptlY+zBNs59to98zBtonGICvAaDQ9sERavJDTuR
 GoYI5K056Wqk3rEboGbBP09qjEC2CWojdkdnY3cdSLIjfArDyIvJcvHNms4CYkN5S6
 CXUhraBxNn92egc8Dle0epOhPP5WDxCJpBgiVcnzFRBkQIn8IJInr6ReH8LjdrxNg8
 Df6ZAU17kPcdgK37U45PyNGt1u9hXID/wYyM0CW8vYOZ3puE9vnVT6nv/qyGQR0d/J
 d6DB3D0uD1SjA==
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-52eff10441fso6883258e87.3
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 00:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723619444; x=1724224244;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RZ4QawCH4MyAh+3rPTID2nJgXq+JC1xJ+WhJskUUAH8=;
 b=SAvZ35q1c8D6D2aAnW/F4A4o/lQkpZK54nf8MmwUjyCGM/6+T+d6whpTir7ZdhPc9r
 r4IlLx0sCVxgp/w1t05JrBfpaX0xKuMn+TJYUqjqj59MOfOKQ0N4lPXn/x6LaJlvygwN
 r7VfM4Eg4WZWDx2lh7sgoHrd6rMnRtjpa6w//6v0dKORmn84Rx/sF1jJ4cjYenGmhUqa
 om8P8f1y4YzRqEbVbSTOG7zSIraNlb3PsPd3wwCiapfecgPxiyftMGbkwyn8gKUj5X0a
 VbcMFZX6EpfreG4o2Dj35vMoTfg/JnS8XAeI2usV5IdnDaWDqBV2mCXnYDPRnTahWiIg
 jJ/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDOfqURypUgKHj7nOkNkfg29POZbZSVxakipp6FQZQ2j9gc/WMGzCZsIfss2B6M7IRDhmX3XC0jKov7AVuH47ZODd79g==
X-Gm-Message-State: AOJu0YwRO7/2km3/Wdf4sdhSR9bZ6nccQ/P1VPK/rKzwP2K1kVVeG6xX
 QDF7KlE4pRJ9x6r/ILWzYFOL+Ljv4NSYrqRhNZJU4UuYdoH0Icv7Re3vg1QM311vvdjI91qLr0q
 SmY/MSGplLmfQV8e7Ttt33cYehxPjzmMQjM+Zyt3+8IP4jKxc8EvBZnLBe6hKcEq5Zc7knnvjP9
 4=
X-Received: by 2002:a2e:e19:0:b0:2ef:2c27:6680 with SMTP id
 38308e7fff4ca-2f3aa1bcd6emr9222501fa.12.1723619443882; 
 Wed, 14 Aug 2024 00:10:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYSvUiO45rdDga0gjbLcr7DJmBGmA0X6tBdJ8S4BMXz+gVb+5NFkrR4OGQqrCztnq5aFQBlw==
X-Received: by 2002:a2e:e19:0:b0:2ef:2c27:6680 with SMTP id
 38308e7fff4ca-2f3aa1bcd6emr9222341fa.12.1723619443315; 
 Wed, 14 Aug 2024 00:10:43 -0700 (PDT)
Received: from localhost.localdomain
 (ip-178-202-041-098.um47.pools.vodafone-ip.de. [178.202.41.98])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ded582f1sm10977475e9.41.2024.08.14.00.10.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 00:10:42 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Tony Dinh <mibodhi@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 1/1] ata: sata_rescan must scan for block devices
Date: Wed, 14 Aug 2024 09:10:37 +0200
Message-ID: <20240814071037.34446-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

A system may have multiple SATA controller. Removing the controller with
the lowest sequence number before probing all SATA controllers makes no
sense.

In sata_rescan we remove all block devices which are children of SATA
controllers. We also have to remove the bootdev devices as they will be
created when scanning for block devices.

After probing all SATA controllers we must scan for block devices otherwise
we end up without any SATA block device.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v3:
	continue unbinding and scanning if one device fails
	write a message if scanning fails
	add device name to error message
v2:
	Scanning for device on an unprobed SATA controller leads
	to an illegal memory access.
	Use uclass_foreach_dev_probe() instead of uclass_foreach_dev().
---
 drivers/ata/sata.c | 48 +++++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/drivers/ata/sata.c b/drivers/ata/sata.c
index 84437d3d346..89cd516f3d6 100644
--- a/drivers/ata/sata.c
+++ b/drivers/ata/sata.c
@@ -9,9 +9,12 @@
  *		Dave Liu <daveliu@freescale.com>
  */
 
+#define LOG_CATEGORY UCLASS_AHCI
+
 #include <ahci.h>
 #include <blk.h>
 #include <dm.h>
+#include <log.h>
 #include <part.h>
 #include <sata.h>
 #include <dm/device-internal.h>
@@ -49,38 +52,39 @@ int sata_scan(struct udevice *dev)
 
 int sata_rescan(bool verbose)
 {
+	struct uclass *uc;
+	struct udevice *dev; /* SATA controller */
 	int ret;
-	struct udevice *dev;
 
 	if (verbose)
-		printf("Removing devices on SATA bus...\n");
-
-	blk_unbind_all(UCLASS_AHCI);
-
-	ret = uclass_find_first_device(UCLASS_AHCI, &dev);
-	if (ret || !dev) {
-		printf("Cannot find SATA device (err=%d)\n", ret);
-		return -ENOENT;
-	}
-
-	ret = device_remove(dev, DM_REMOVE_NORMAL);
-	if (ret) {
-		printf("Cannot remove SATA device '%s' (err=%d)\n", dev->name, ret);
-		return -ENOSYS;
+		printf("scanning bus for devices...\n");
+
+	ret = uclass_get(UCLASS_AHCI, &uc);
+	if (ret)
+		return ret;
+
+	/* Remove all children of SATA devices (blk and bootdev) */
+	uclass_foreach_dev(dev, uc) {
+		log_debug("unbind %s\n", dev->name);
+		ret = device_chld_remove(dev, NULL, DM_REMOVE_NORMAL);
+		if (!ret)
+			ret = device_chld_unbind(dev, NULL);
+		if (ret && verbose) {
+			log_err("Unbinding from %s failed (%dE)\n",
+				dev->name, ret);
+		}
 	}
 
 	if (verbose)
 		printf("Rescanning SATA bus for devices...\n");
 
-	ret = uclass_probe_all(UCLASS_AHCI);
-
-	if (ret == -ENODEV) {
-		if (verbose)
-			printf("No SATA block device found\n");
-		return 0;
+	uclass_foreach_dev_probe(UCLASS_AHCI, dev) {
+		ret = sata_scan(dev);
+		if (ret && verbose)
+			log_err("Scanning %s failed (%dE)\n", dev->name, ret);
 	}
 
-	return ret;
+	return 0;
 }
 
 static unsigned long sata_bread(struct udevice *dev, lbaint_t start,
-- 
2.45.2

