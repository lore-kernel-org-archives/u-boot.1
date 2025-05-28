Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0319EC5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 13:07:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61AEA839F2;
	Wed, 28 May 2025 15:06:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 969AA83A27; Wed, 28 May 2025 15:06:40 +0200 (CEST)
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::190e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B889839EC
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 15:06:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4b6qWw62lJzpQN;
 Wed, 28 May 2025 15:06:36 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4b6qWw2nYGz5Zy; Wed, 28 May 2025 15:06:36 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 28 May 2025 15:06:19 +0200
Subject: [PATCH 2/2] dm: core: use s32 instead of int for dev_read_s32_default
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250528-dev_read_x32_default-v1-2-6ab1734dd7a2@cherry.de>
References: <20250528-dev_read_x32_default-v1-0-6ab1734dd7a2@cherry.de>
In-Reply-To: <20250528-dev_read_x32_default-v1-0-6ab1734dd7a2@cherry.de>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

dev_read_s32_default is for getting an s32 from a Device Tree property
and allows to take a default value if that property is missing.

Considering it calls ofnode_read_u32_default which takes a u32 and
returns a u32, it should do the same instead of using an int, especially
considering that int size is typically architecture-specific, as opposed
to s32/u32.

s32 and u32 being the same size, dev_read_s32* functions calling
ofnode_read_u32_default shouldn't be an issue (at the type level at
least) as the information will be stored appropriately in 4B regardless
of the sign.

This incidentally matches all other dev_read_*_default functions.

Fixes: a1b17e4f4c82 ("dm: core: Add a function to read into a unsigned int")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 drivers/core/read.c | 4 ++--
 include/dm/read.h   | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/core/read.c b/drivers/core/read.c
index 981204bffe4c26641ea8b387f00f4efc641d6e47..c0d7a969db2c9e45cd3b112e9c5712baa4acfea1 100644
--- a/drivers/core/read.c
+++ b/drivers/core/read.c
@@ -62,8 +62,8 @@ int dev_read_s32(const struct udevice *dev, const char *propname, s32 *outp)
 	return ofnode_read_u32(dev_ofnode(dev), propname, (u32 *)outp);
 }
 
-int dev_read_s32_default(const struct udevice *dev, const char *propname,
-			 int def)
+s32 dev_read_s32_default(const struct udevice *dev, const char *propname,
+			 s32 def)
 {
 	return ofnode_read_u32_default(dev_ofnode(dev), propname, def);
 }
diff --git a/include/dm/read.h b/include/dm/read.h
index 87017f076216492af5bb8da3a984ed1e074428cc..12dcde6645c72a96512225ff8db4760a79eee43a 100644
--- a/include/dm/read.h
+++ b/include/dm/read.h
@@ -137,8 +137,8 @@ int dev_read_s32(const struct udevice *dev, const char *propname, s32 *outp);
  * @def:	default value to return if the property has no value
  * Return: property value, or @def if not found
  */
-int dev_read_s32_default(const struct udevice *dev, const char *propname,
-			 int def);
+s32 dev_read_s32_default(const struct udevice *dev, const char *propname,
+			 s32 def);
 
 /**
  * dev_read_u32u() - read a 32-bit integer from a device's DT property
@@ -921,8 +921,8 @@ static inline int dev_read_s32(const struct udevice *dev,
 	return ofnode_read_s32(dev_ofnode(dev), propname, outp);
 }
 
-static inline int dev_read_s32_default(const struct udevice *dev,
-				       const char *propname, int def)
+static inline s32 dev_read_s32_default(const struct udevice *dev,
+				       const char *propname, s32 def)
 {
 	return ofnode_read_s32_default(dev_ofnode(dev), propname, def);
 }

-- 
2.49.0

