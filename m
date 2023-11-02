Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F0EFC4167D
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 18:51:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AAD686FAC;
	Thu,  2 Nov 2023 19:51:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L7WXmxDJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91B33876D6; Thu,  2 Nov 2023 19:51:39 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4B3486FAC
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 19:51:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5a7afd45199so15936187b3.0
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 11:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698951093; x=1699555893; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0mfzVp4NMJWGEsZQFFf/r6p2ud8+tWO7p7e80uGWmF4=;
 b=L7WXmxDJbVQxG77w/Pbs3PbSszkPoUgs3lEHeALcwMcuMOct+x8diksyORHIirs+6G
 R8Tj33jr2aOQ4snS3MbSmH31W79RRTVEJCWP81CTvL/ZqEWK6WAHNIW3KPoMsYBk6E+N
 zpq+8Swsli8HO5MVOONmYFOugHCHG60EbC7EZDvwYoCKv5Y+4u1HqklaeDaQZGU1qPfI
 SQlj4VpAfq8/ITYH2iJ5o2HrkOMiS8zUCBXZ0xNkYHjVGVvMPtHV6eDIp6awXF4JikQq
 nhuo2KgYVRsrkkIMObRMwCT4D33rbRkRaZ73clBQ3Abo9YIi/SfH5/fagk6jCyI/F9bf
 lvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698951093; x=1699555893;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0mfzVp4NMJWGEsZQFFf/r6p2ud8+tWO7p7e80uGWmF4=;
 b=TzgUbfHe4Ce05tT4I6J8L0DDoG5dq/ErC8tZdHBl85ntJeudFX6CFayiQwIPb3eveM
 g8bOXSioItjXMpQdx6qB+zUTAZr8PjqFyRS5jau5/GWPNAgGyYvrP/pBF6WHMqsKkr+k
 EXWe0lbUW6sNGVNpGJN9H5Ibdfvm5dDofkNjR5ytXMDUgcdqBGLIi9vhFa5aNsMc11yB
 t0LRDHh9/aws9wLQ5w1KZkH3PkhdVCdyRILxH4OdCL3XiyMDRSLHapmUZtD2So21N79H
 T/+rcjK49Q45ddNrdWYYsdj4ErsBzB2ysT3m7FhOA3HzOt2PVgnHjp9OO5BJO2oBo95x
 4wnw==
X-Gm-Message-State: AOJu0YyTyxn5fyoclQ6RAYRI5VVdlKrQ8V5hR01GPvhQNcCXgETw2fYV
 JMzWhF3Q91ol7e4B4DgP61s=
X-Google-Smtp-Source: AGHT+IESS2kOk0ec80eOSvehzgQSasgpgAVa4xbX01xRIbxuqb6ZyxaIDV5GLVHhVM5ogAB1YuVVCA==
X-Received: by 2002:a25:324f:0:b0:d9a:bddd:f714 with SMTP id
 y76-20020a25324f000000b00d9abdddf714mr18099235yby.9.1698951093185; 
 Thu, 02 Nov 2023 11:51:33 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 w142-20020a25c794000000b00da0c49a588asm60446ybe.8.2023.11.02.11.51.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 11:51:32 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Stefan Roese <sr@denx.de>,
 Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH v2] bootstd: Skip over bad device during bootflows scanning
Date: Thu,  2 Nov 2023 11:51:15 -0700
Message-Id: <20231102185116.21708-1-mibodhi@gmail.com>
X-Mailer: git-send-email 2.39.2
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

During bootstd scanning for bootdevs, if bootdev_hunt_drv() encounters
a device not found error (e.g. ENOENT), let it return a successful status
so that bootstd will continue scanning the next devices, not stopping
prematurely.

Background:

During scanning for bootflows, it's possible for bootstd to encounter a
faulty device controller. Also when the same u-boot is used for another
variant of the same board, some device controller such as SATA might
not exist.

I've found this issue while converting the Marvell Sheevaplug board to
use bootstd. This board has 2 variants, the original Sheevaplug has MMC and
USB only, but the later variant comes with USB, MMC, and eSATA ports. We
have been using the same u-boot (starting with CONFIG_IDE and later with DM
CONFIG_SATA) for both variants. This worked well with the old
envs-scripting booting scheme.

Signed-off-by: Tony Dinh <mibodhi@gmail.com>
---

Changes in v2:
- Restore bootdev_next_prio() to the original.
- Add a check in bootdev_hunt_drv(). If its descendant bootdev hunt driver
function returns -ENOENT, set the hunt status to successful (this is the
case where the device does not exist, or a bad device controller).
- Update bootdev_hunter_func() docs to indicate that a return
status -ENOENT is not an error, just a "device not found" status.
- Set status of sata_rescan() to -ENOENT when the SATA device is not found.

 boot/bootdev-uclass.c | 2 +-
 drivers/ata/sata.c    | 2 +-
 include/bootdev.h     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index 44ae98a926..4926a50da8 100644
--- a/boot/bootdev-uclass.c
+++ b/boot/bootdev-uclass.c
@@ -784,7 +784,7 @@ static int bootdev_hunt_drv(struct bootdev_hunter *info, uint seq, bool show)
 		if (info->hunt) {
 			ret = info->hunt(info, show);
 			log_debug("  - hunt result %d\n", ret);
-			if (ret)
+			if (ret && ret != -ENOENT)
 				return ret;
 		}
 		std->hunters_used |= BIT(seq);
diff --git a/drivers/ata/sata.c b/drivers/ata/sata.c
index dcb5fcf476..64fc078bad 100644
--- a/drivers/ata/sata.c
+++ b/drivers/ata/sata.c
@@ -65,7 +65,7 @@ int sata_rescan(bool verbose)
 	ret = uclass_find_first_device(UCLASS_AHCI, &dev);
 	if (ret || !dev) {
 		printf("Cannot find SATA device (err=%d)\n", ret);
-		return -ENOSYS;
+		return -ENOENT;
 	}
 
 	ret = device_remove(dev, DM_REMOVE_NORMAL);
diff --git a/include/bootdev.h b/include/bootdev.h
index b079a91b5b..35fa25aff1 100644
--- a/include/bootdev.h
+++ b/include/bootdev.h
@@ -65,7 +65,7 @@ struct bootdev_hunter;
  *
  * @info: Info structure describing this hunter
  * @show: true to show information from the hunter
- * Returns: 0 if OK, -ve on error
+ * Returns: 0 if OK, -ENOENT on device not found, otherwise -ve on error
  */
 typedef int (*bootdev_hunter_func)(struct bootdev_hunter *info, bool show);
 
-- 
2.39.2

