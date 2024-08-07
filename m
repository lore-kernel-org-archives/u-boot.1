Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E47C49EA1
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 01:59:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AB2B88B42;
	Wed,  7 Aug 2024 03:59:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="H6iF7O7p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D817E88B42; Wed,  7 Aug 2024 03:59:00 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FBD888B2B
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 03:58:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 005CD3F429
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 01:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1722995925;
 bh=hKezOdfmp5jVBsz72DuiNRrCsH0WHibZ4cGZlQtFDXo=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=H6iF7O7pX/PllRTjw3/FdPMsMiG/HXyEBoKnN4ao7TUMQakUQRJmMlHr8z7Y3C1E1
 +oCDHqHBYzUUijs6DWbsR1ocH892FZ1r29btNT1E2pJ6aQT7w7iJcXThHzuqjtSlQt
 Eu6cTADOzsHoA0e/efvR1OHycVq+jSUFuHbf9a1SqOggLxbusYl0DJ1W7CbQFDHax7
 f1ik/nR1kAwKmVu6aBaRlcowuEDgBzI3uWhCPrZ2X3tjYbIL5zY8nNd2CgeeW8OIVl
 O2eRdIamNty7deglxr6SjatMfW8xegp77iMEjrwE2tIX7/SOdos08WzWPbXKxCQClq
 lS+9aFe+g61Ew==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-428207daff2so8573135e9.0
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 18:58:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722995924; x=1723600724;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hKezOdfmp5jVBsz72DuiNRrCsH0WHibZ4cGZlQtFDXo=;
 b=HRHfaRd9IiKAU5cfRt3sYcyda6Q6VInAX718dcIp8QhH9EfwQ/DFkpBWYUXMHqz3Hs
 9r5zZ0Mlr4dVp+zX1Hy0GhT7TQXXbwA9+IKH7JeriT5wkEPcVMmA1xJapAShMCIEYhCo
 8v31pl0LnJdBDACOgmkV8yXPaNIR19L5ikG+KAEutPfRIZxyQkhPagplqEgcRNKGIYTd
 luZKFBrKzFH+90qYrvCw3ZdnrDuwcTNoiKT4nL6NY+sj/MEOS1uZQSDMY1i8XfVpbWOY
 K7Xc3jpl9IB0XObD9xUrdodjp8S0pZlYspR781TH8wTrHEa4D7zAsfHRs0paK85MJFmX
 titQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWteF0nw2JM2SU9QYXQqcxJrbFT31IsP4qPEeS8KbZhJIs+8ViJH+eMejenvSoa29IBXETBhGo24Z+24qTUi0UMTc49ng==
X-Gm-Message-State: AOJu0YzKK7Qrh+QbgGCau7uXL+pI8nBnQ5WZmGsmDBCzfugfxc3rq74T
 +3OjY2WhOQCxoJmKXPdIGLTUjAurM6KAlz+5XyYhDAZmXZOraV8dUy8xVHedaYiR52CybW6BzOk
 /PDMU87XyIGSR97syIqSfAEpoApyb1ZJs7AUrUjfb6yQxj1oNjms2gI6uvVklSax7X44=
X-Received: by 2002:a05:600c:1988:b0:426:689b:65b7 with SMTP id
 5b1f17b1804b1-428e6b7f294mr100337805e9.25.1722995924539; 
 Tue, 06 Aug 2024 18:58:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBxd112ReaqCEYNyQl8pyim/mwYTDXs2X43ONYAWWbb5bwzBJdg+TV/AfnHdNOxq1yMJIHag==
X-Received: by 2002:a05:600c:1988:b0:426:689b:65b7 with SMTP id
 5b1f17b1804b1-428e6b7f294mr100337715e9.25.1722995924016; 
 Tue, 06 Aug 2024 18:58:44 -0700 (PDT)
Received: from localhost.localdomain ([2a02:3031:2e0:52b3:22a6:b8b1:7d3b:dbe7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4290580c546sm5435395e9.40.2024.08.06.18.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 18:58:43 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Tony Dinh <mibodhi@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] ata: sata_rescan must scan for block devices
Date: Wed,  7 Aug 2024 03:58:36 +0200
Message-ID: <20240807015836.350488-1-heinrich.schuchardt@canonical.com>
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
+	uclass_foreach_dev(dev, uc) {
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

