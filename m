Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF39C83F04
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 15:25:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D3BA82EA9;
	Wed,  2 Jul 2025 17:25:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89A9780E9A; Wed,  2 Jul 2025 17:25:45 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 8832582103
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 17:25:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1DD322D9;
 Wed,  2 Jul 2025 08:25:27 -0700 (PDT)
Received: from e130802.cambridge.arm.com (e130802.arm.com [10.1.38.90])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 012EC3F6A8;
 Wed,  2 Jul 2025 08:25:40 -0700 (PDT)
From: abdellatif.elkhlifi@arm.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, abdellatif.elkhlifi@arm.com,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>, Simon Glass <sjg@chromium.org>,
 Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH 01/25] arm_ffa: Add NULL pointer check to the uclass driver
 operations
Date: Wed,  2 Jul 2025 16:25:04 +0100
Message-Id: <20250702152528.1180414-2-abdellatif.elkhlifi@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250702152528.1180414-1-abdellatif.elkhlifi@arm.com>
References: <20250702152528.1180414-1-abdellatif.elkhlifi@arm.com>
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

The device driver can miss defining an operations structure.
So, ffa_get_ops() can return NULL.
This commit adds checks for ops in the uclass driver operations
and an error is returned when ops is NULL.

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/firmware/arm-ffa/arm-ffa-uclass.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm-ffa/arm-ffa-uclass.c b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
index 96c64964bb7..f8d231204db 100644
--- a/drivers/firmware/arm-ffa/arm-ffa-uclass.c
+++ b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ * Copyright 2022-2023, 2025 Arm Limited and/or its affiliates <open-source-office@arm.com>
  *
  * Authors:
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
@@ -954,6 +954,9 @@ int ffa_partition_info_get(struct udevice *dev, const char *uuid_str,
 {
 	struct ffa_bus_ops *ops = ffa_get_ops(dev);
 
+	if (!ops)
+		return -EINVAL;
+
 	if (!ops->partition_info_get)
 		return -ENOSYS;
 
@@ -979,6 +982,9 @@ int ffa_sync_send_receive(struct udevice *dev, u16 dst_part_id,
 {
 	struct ffa_bus_ops *ops = ffa_get_ops(dev);
 
+	if (!ops)
+		return -EINVAL;
+
 	if (!ops->sync_send_receive)
 		return -ENOSYS;
 
@@ -1000,6 +1006,9 @@ int ffa_rxtx_unmap(struct udevice *dev)
 {
 	struct ffa_bus_ops *ops = ffa_get_ops(dev);
 
+	if (!ops)
+		return -EINVAL;
+
 	if (!ops->rxtx_unmap)
 		return -ENOSYS;
 
-- 
2.25.1

