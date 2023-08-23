Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6AFFEE49A5
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 00:18:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F10686407;
	Wed, 23 Aug 2023 02:18:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="E9jFZKUz";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="R8xkiI09";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E11AB864C2; Wed, 23 Aug 2023 02:18:45 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D95586403
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 02:18:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RVmz71G8lz9snC;
 Wed, 23 Aug 2023 02:18:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692749923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=UIeUYW9xmn8Qw/dc8d1IGdcAyi3kUpMiBaQYDOykUpI=;
 b=E9jFZKUz8qhJgGYG7GC9LbdR7cw/SwvKZrTbBA3XZeoKtru9h7UEP9EPHlZ2LdXSI1Xzr9
 OSVV0UM7zhuI1PFfMWIsUJr7VHwP+0nM7mWwsn4Hovu3rbJQleuz6O0cNh0eSfhH3yhplG
 cINCYWUdH3WAco3mct4SqG3QIZBvhNQClzy3+n0T0kMkRSpNz7SygV4eDQIkhhLZAcDzDu
 od901ZZ5q8ATLqncJruiW9VzEhIKgVeDZUeF2O6TOmH/phNXy2W8u0yNgFE/fSCbIMWg3H
 /AgqCIqvlQbFfh9JnUUgkr72SeSORwlwfuyyBD6x3OFZlyenfMvSZI2cZeS6IQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692749920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=UIeUYW9xmn8Qw/dc8d1IGdcAyi3kUpMiBaQYDOykUpI=;
 b=R8xkiI09mg76uX834Z4sjdQK7uBzS9aj7rLsZ1gP+x37k1ql06h5+r30vEbfrct6kGXWR1
 04fdLDWuuXUd9lFp9a1UVFOUtV9og3MgU2XDcwiFk4WGHX77KVhvx7ePr0K27el3pwA1yL
 JYeybN9eCIwCsLUYUq1es8vJdvo15WhgGmXY6vOlmFpAmNYRAbUp1LCpzXLxRwuZjvN5nM
 kRjh8M1ZQ330L7m9a88RwQln/vHDhuwuAHpsoKrNIJXZjoPXfcKOcDU7NWdyiRD8KrIEI5
 NwVUEOP7itfpcednc5uB2FKC+wk8vEafmNhFfMvQuxlI4embyteI9RVs405LMQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 1/5] drivers/mtd/nvmxip: Trigger post bind as probe on
 driver level
Date: Wed, 23 Aug 2023 02:18:17 +0200
Message-Id: <20230823001821.266578-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: fbad74f9dc128cff762
X-MBO-RS-META: wg1d4e7zgtrwnwatwpd1diaedo5fg53y
X-Rspamd-Queue-Id: 4RVmz71G8lz9snC
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

Perform all the block device creation only once, after the driver itself
successfully bound. Do not do this in uclass post bind, as this might be
triggered multiple times. For example the ut_dm_host test triggers this
and triggers a memory leak that way, since there are now multiple block
devices created using the blk_create_devicef() .

To retain the old probe-on-boot behavior, set DM_FLAG_PROBE_AFTER_BIND
flag in uclass post_bind callback, so the driver model would probe the
driver at the right time.

Rename the function as well, to match similar functions in
other block-related subsystems, like the mmc one.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Simon Glass <sjg@chromium.org>
---
V2: New patch
---
 drivers/mtd/nvmxip/nvmxip-uclass.c | 18 +++++++-----------
 drivers/mtd/nvmxip/nvmxip_qspi.c   |  1 +
 include/nvmxip.h                   | 12 ++++++++++++
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/nvmxip/nvmxip-uclass.c b/drivers/mtd/nvmxip/nvmxip-uclass.c
index 6d8eb177b50..36eb056c213 100644
--- a/drivers/mtd/nvmxip/nvmxip-uclass.c
+++ b/drivers/mtd/nvmxip/nvmxip-uclass.c
@@ -22,17 +22,7 @@
 
 #define DEFAULT_LBA_SZ BIT(DEFAULT_LBA_SHIFT)
 
-/**
- * nvmxip_post_bind() - post binding treatments
- * @dev:	the NVMXIP device
- *
- * Create and probe a child block device.
- *
- * Return:
- *
- * 0 on success. Otherwise, failure
- */
-static int nvmxip_post_bind(struct udevice *udev)
+int nvmxip_probe(struct udevice *udev)
 {
 	int ret;
 	struct udevice *bdev = NULL;
@@ -67,6 +57,12 @@ static int nvmxip_post_bind(struct udevice *udev)
 	return 0;
 }
 
+static int nvmxip_post_bind(struct udevice *udev)
+{
+	dev_or_flags(udev, DM_FLAG_PROBE_AFTER_BIND);
+	return 0;
+}
+
 UCLASS_DRIVER(nvmxip) = {
 	.name	   = "nvmxip",
 	.id	   = UCLASS_NVMXIP,
diff --git a/drivers/mtd/nvmxip/nvmxip_qspi.c b/drivers/mtd/nvmxip/nvmxip_qspi.c
index 7221fd1cb46..1bf0d311fe3 100644
--- a/drivers/mtd/nvmxip/nvmxip_qspi.c
+++ b/drivers/mtd/nvmxip/nvmxip_qspi.c
@@ -66,5 +66,6 @@ U_BOOT_DRIVER(nvmxip_qspi) = {
 	.id = UCLASS_NVMXIP,
 	.of_match = nvmxip_qspi_ids,
 	.of_to_plat = nvmxip_qspi_of_to_plat,
+	.probe = nvmxip_probe,
 	.plat_auto = sizeof(struct nvmxip_plat),
 };
diff --git a/include/nvmxip.h b/include/nvmxip.h
index f4ef37725d2..726fffeb3e8 100644
--- a/include/nvmxip.h
+++ b/include/nvmxip.h
@@ -29,4 +29,16 @@ struct nvmxip_plat {
 	lbaint_t lba;
 };
 
+/**
+ * nvmxip_bind() - post binding treatments
+ * @dev:	the NVMXIP device
+ *
+ * Create and probe a child block device.
+ *
+ * Return:
+ *
+ * 0 on success. Otherwise, failure
+ */
+int nvmxip_probe(struct udevice *udev);
+
 #endif /* __DRIVER_NVMXIP_H__ */
-- 
2.40.1

