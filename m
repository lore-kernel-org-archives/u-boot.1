Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAEFBC52D71
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 18:56:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BAF487E96;
	Thu,  8 Aug 2024 20:56:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="nWE6/O9k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0B3687919; Thu,  8 Aug 2024 20:56:41 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 343F788AFF
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 20:56:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3C9353FD39
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 18:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1723143398;
 bh=C9IBVBSqrUjbugUi5RztPTAl3JYcOHkPinspN83Wcso=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=nWE6/O9kWw5/hnQrPjZToMS5M64IanR6raRmafwtBTxAPCCbkBvzGvnx0/Nzh49H3
 ms7UTfl/oCty2CIQVG+GJn1tw/R7e+FT2ieF3o+O7hRnqKEAz6kdlcu5+drSmnon70
 W4jV5Xm9RallGH169T4kcn0sI3MtauGSivWXBln+rtT/2jrTHkH1ier2weGOFa0u+B
 8fsCLHszzcRT/lV7/UoWY51hy/2lDpPad8UzSdpAsWYM93tFf4tm+w9Lg/3hrh/LTd
 8ujdO+9GpXcR1411TiR+M8qi2x2Ku8XAXzWdMKxI0QmoUF3U21QVLK4g54gFFxrRds
 Jvopjy5qDchBw==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-428e48612acso15207895e9.3
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 11:56:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723143398; x=1723748198;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C9IBVBSqrUjbugUi5RztPTAl3JYcOHkPinspN83Wcso=;
 b=bGI+TaDv8FURBrIgwR7f2UGa1Gw1zVBGV7+mD7JXUCHs9TosLsQeXZ4wIb3u/jLTla
 B93+oGQ26WJm26KohaZCmK1CIYAqxB33Hwl+dg/gbx5+WTubvpPw+kc4Jz38zJHxtpfc
 F5qx+evJrCTQo1EppG5B5UFLViAgRPp/MNs9Vd6IAY62n2ym3OGCm/7PTDJ8ehFIZ+wA
 p/I61LojXkJgQfimt/FF+7BiSd70Ef39TCLV1WqErXQhUWkRPk+N4RqBqnmFGId6jLyz
 PsqXRMfr+CZk9fpk8CzikXYAPINqisMpIDWxYsOWb8XeJBVy0qSQdF9evwuhQKzdUzBO
 gSqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWB/qribL55fLHfG/Xm52u5TOcZbMxNiUejxRZ7MsH3m5P9SJt/SqW3MbqbP3N7GS1dYd19pMT+29HYyxPl4WDJ5H6mUw==
X-Gm-Message-State: AOJu0YxscF8CspHYbG9dyaEHNvN9JtdpsLUsbwHimlf/NIxyZJIIFyZs
 b3TuWhhBA3+92Hbv3aQuiiMm+JK9Ed4O52EgNZFaGj2/BXYTCS821QqJtB70kx6ca2jC6/4KBH3
 UhIvr567ijJbn1vPYvTEs1Ei4PY5AMeeZgXD+Lbw/BghNeZ2rhbkp/2CvKF7lZcn8exY=
X-Received: by 2002:a05:600c:c87:b0:426:6ee7:d594 with SMTP id
 5b1f17b1804b1-4290aedf220mr32693515e9.7.1723143397652; 
 Thu, 08 Aug 2024 11:56:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPvBk4NRBwTxCFcwVSWgVcVl/OaXd5DOeF0P4zIYzcv+J8F43a8HMZyPEjqsSS6t//VV1EtQ==
X-Received: by 2002:a05:600c:c87:b0:426:6ee7:d594 with SMTP id
 5b1f17b1804b1-4290aedf220mr32693285e9.7.1723143397133; 
 Thu, 08 Aug 2024 11:56:37 -0700 (PDT)
Received: from localhost.localdomain ([2a02:3035:ee0:a15:4f42:44a6:1da1:b45a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36d27156c5esm2804599f8f.13.2024.08.08.11.56.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 11:56:36 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Tony Dinh <mibodhi@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] ata: sata_rescan must scan for block devices
Date: Thu,  8 Aug 2024 20:56:27 +0200
Message-ID: <20240808185627.769049-1-heinrich.schuchardt@canonical.com>
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
v2:
	Scanning for device on an unprobed SATA controller leads
	to an illegal memory access.
	Use uclass_foreach_dev_probe() instead of uclass_foreach_dev().
---
 drivers/ata/sata.c | 46 ++++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/ata/sata.c b/drivers/ata/sata.c
index 84437d3d346..2139ae9903e 100644
--- a/drivers/ata/sata.c
+++ b/drivers/ata/sata.c
@@ -49,38 +49,40 @@ int sata_scan(struct udevice *dev)
 
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
+		if (ret) {
+			if (verbose)
+				printf("unable to unbind devices (%dE)\n", ret);
+			return log_msg_ret("unb", ret);
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
+		if (ret)
+			return ret;
 	}
 
-	return ret;
+	return 0;
 }
 
 static unsigned long sata_bread(struct udevice *dev, lbaint_t start,
-- 
2.45.2

