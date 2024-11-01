Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466EDE6F061
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 14:20:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78EC38924F;
	Fri,  1 Nov 2024 15:20:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54FDB891E2; Fri,  1 Nov 2024 15:20:36 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 5DE0C891E2
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 15:20:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BE5E1BC0;
 Fri,  1 Nov 2024 07:21:03 -0700 (PDT)
Received: from e130802.cambridge.arm.com (e130802.arm.com [10.1.26.20])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D5C43F528;
 Fri,  1 Nov 2024 07:20:32 -0700 (PDT)
From: abdellatif.elkhlifi@arm.com
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Subject: [PATCH 1/8] arm_ffa: Add NULL pointer check to the driver operations
Date: Fri,  1 Nov 2024 14:20:10 +0000
Message-Id: <20241101142017.79311-2-abdellatif.elkhlifi@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241101142017.79311-1-abdellatif.elkhlifi@arm.com>
References: <20241101142017.79311-1-abdellatif.elkhlifi@arm.com>
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

From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>

Add NULL pointer check for ops

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
---
 drivers/firmware/arm-ffa/arm-ffa-uclass.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/arm-ffa/arm-ffa-uclass.c b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
index 96c64964bb7..5ec7654ed1c 100644
--- a/drivers/firmware/arm-ffa/arm-ffa-uclass.c
+++ b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ * Copyright 2022-2024 Arm Limited and/or its affiliates <open-source-office@arm.com>
  *
  * Authors:
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
@@ -954,7 +954,7 @@ int ffa_partition_info_get(struct udevice *dev, const char *uuid_str,
 {
 	struct ffa_bus_ops *ops = ffa_get_ops(dev);
 
-	if (!ops->partition_info_get)
+	if (!ops || !ops->partition_info_get)
 		return -ENOSYS;
 
 	return ops->partition_info_get(dev, uuid_str, sp_count, sp_descs);
@@ -979,7 +979,7 @@ int ffa_sync_send_receive(struct udevice *dev, u16 dst_part_id,
 {
 	struct ffa_bus_ops *ops = ffa_get_ops(dev);
 
-	if (!ops->sync_send_receive)
+	if (!ops || !ops->sync_send_receive)
 		return -ENOSYS;
 
 	return ops->sync_send_receive(dev, dst_part_id, msg, is_smc64);
@@ -1000,7 +1000,7 @@ int ffa_rxtx_unmap(struct udevice *dev)
 {
 	struct ffa_bus_ops *ops = ffa_get_ops(dev);
 
-	if (!ops->rxtx_unmap)
+	if (!ops || !ops->rxtx_unmap)
 		return -ENOSYS;
 
 	return ops->rxtx_unmap(dev);
-- 
2.25.1

