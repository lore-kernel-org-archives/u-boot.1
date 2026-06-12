Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12EA2CD98C7
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 02:00:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45BC9848E2;
	Fri, 12 Jun 2026 03:59:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="AnuT0xr/";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="LKmqcr47";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBBD98484C; Fri, 12 Jun 2026 03:59:41 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C743084908
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 03:59:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gc2kz3vgcz9v5P;
 Fri, 12 Jun 2026 03:59:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781229579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=gZr1qpS/zMrM+VD8WHm+v7vnXL49eWIJ/Lxe7/+oYTM=;
 b=AnuT0xr/sHJH0X5smQpGy4JNs9vZS6UypV4gD/iKZXoyzc9Sppl4hE45rSA4SHUtcHXXYz
 baS8GIosfizNYU2Z0SFhlPUZld+4jp4zS2RVUzkmy9zdO2nn3XTEBijXn/nCqPX2It4nky
 twQDgFHhWx6D/NytOku1l4Z4Tu1iCFttitSvQPtis5qGjKbNzAtbm1N5/vPuDLfwPljPnR
 ueS3IXTBrMVnV+vpiP/3JZtPenE2T37WVeEcjxkKLgOWc3JDQoHTOFdj7mzdA0hZqZXCZe
 36y4a0uMJcRv+qRbLYGULRgrB3shj4w4KoTFJlDg7Qbdj3RaBpVmTbBtYbTZdw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=LKmqcr47;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781229577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=gZr1qpS/zMrM+VD8WHm+v7vnXL49eWIJ/Lxe7/+oYTM=;
 b=LKmqcr47DDcvhsO6kNQl/ouhdAFs4cRGIj8yjAvtanGWrLlDlQM9LCKLvdw5qk8UzK4uT0
 msa7oV2KdgB46AbyaiR2KTVVrooPtDUIs5x1CNoGzjxXTFWUsSCy1ko/PL4do1MWKl09Hn
 4WdnMi8hRmYcvJwnSrq54VZzF89Zu72WdQefXfCiBsaZwf/ArGYo/7hGT+nSafC27wWGdq
 uSbFRO5LeOGutU/h4Z0pz5woZgzqfN62rKmumF2hUUMevwej6ogkYEFkXx+UNsqj4GXsMi
 7eEG9InnqTNYeOctR2fB9PbARrv6dsNl4buvKbnkkidPieQoDhy1YzV596+F3w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] cros_ec: Convert dm_cros_ec_get_ops into an inline function
 and constify dm_cros_ec_ops
Date: Fri, 12 Jun 2026 03:59:06 +0200
Message-ID: <20260612015932.283341-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: jc8ykmcc5ttq3y4juqgsnhrbgxprw83r
X-MBO-RS-ID: f8c7654ff49b361ba18
X-Rspamd-Queue-Id: 4gc2kz3vgcz9v5P
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

Convert dm_cros_ec_get_ops into an inline function to improve compiler
code coverage, and constify struct dm_cros_ec_ops in a few places.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/misc/cros_ec.c | 9 ++++-----
 include/cros_ec.h      | 7 +++++--
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/cros_ec.c b/drivers/misc/cros_ec.c
index c3e647edfac..e163224b8e3 100644
--- a/drivers/misc/cros_ec.c
+++ b/drivers/misc/cros_ec.c
@@ -258,7 +258,7 @@ static int send_command_proto3(struct cros_ec_dev *cdev,
 			       const void *dout, int dout_len,
 			       uint8_t **dinp, int din_len)
 {
-	struct dm_cros_ec_ops *ops;
+	const struct dm_cros_ec_ops *ops;
 	int out_bytes, in_bytes;
 	int rv;
 
@@ -287,7 +287,7 @@ static int send_command(struct cros_ec_dev *dev, uint cmd, int cmd_version,
 			const void *dout, int dout_len,
 			uint8_t **dinp, int din_len)
 {
-	struct dm_cros_ec_ops *ops;
+	const struct dm_cros_ec_ops *ops;
 	int ret = -1;
 
 	/* Handle protocol version 3 support */
@@ -756,9 +756,8 @@ int cros_ec_flash_protect(struct udevice *dev, uint32_t set_mask,
 static int cros_ec_check_version(struct udevice *dev)
 {
 	struct cros_ec_dev *cdev = dev_get_uclass_priv(dev);
+	const struct dm_cros_ec_ops *ops;
 	struct ec_params_hello req;
-
-	struct dm_cros_ec_ops *ops;
 	int ret;
 
 	ops = dm_cros_ec_get_ops(dev);
@@ -1638,7 +1637,7 @@ int cros_ec_vstore_write(struct udevice *dev, int slot, const uint8_t *data,
 
 int cros_ec_get_switches(struct udevice *dev)
 {
-	struct dm_cros_ec_ops *ops;
+	const struct dm_cros_ec_ops *ops;
 	int ret;
 
 	ops = dm_cros_ec_get_ops(dev);
diff --git a/include/cros_ec.h b/include/cros_ec.h
index 4ef34815e35..6e5153ceb6a 100644
--- a/include/cros_ec.h
+++ b/include/cros_ec.h
@@ -12,6 +12,7 @@
 #include <ec_commands.h>
 #include <cros_ec_message.h>
 #include <asm/gpio.h>
+#include <dm/device.h>
 #include <dm/of_extra.h>
 
 /*
@@ -316,8 +317,10 @@ struct dm_cros_ec_ops {
 	int (*get_switches)(struct udevice *dev);
 };
 
-#define dm_cros_ec_get_ops(dev) \
-		((struct dm_cros_ec_ops *)(dev)->driver->ops)
+static inline const struct dm_cros_ec_ops *dm_cros_ec_get_ops(struct udevice *dev)
+{
+	return (const struct dm_cros_ec_ops *)(dev->driver->ops);
+}
 
 int cros_ec_register(struct udevice *dev);
 
-- 
2.53.0

