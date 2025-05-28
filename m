Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2287BC5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 13:06:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C3C683A15;
	Wed, 28 May 2025 15:06:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13226839C1; Wed, 28 May 2025 15:06:39 +0200 (CEST)
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::bc0c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C33BC839D5
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 15:06:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4b6qWw2tRqzpDc;
 Wed, 28 May 2025 15:06:36 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4b6qWv70LPz5yj; Wed, 28 May 2025 15:06:35 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 28 May 2025 15:06:18 +0200
Subject: [PATCH 1/2] dm: core: use u32 instead of int for dev_read_u32_default
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250528-dev_read_x32_default-v1-1-6ab1734dd7a2@cherry.de>
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

dev_read_u32_default is for getting a u32 from a Device Tree property
and allows to take a default value if that property is missing.

Considering it calls ofnode_read_u32_default which takes a u32 and
returns a u32, it should do the same instead of using an int, especially
considering that int size is typically architecture-specific, as opposed
to u32.

This incidentally matches all other dev_read_*_default functions (except
dev_read_s32_default which will be tackled in the next commit).

Fixes: 47a0fd3bad38 ("dm: core: Implement live tree 'read' functions")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 drivers/core/read.c | 4 ++--
 include/dm/read.h   | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/core/read.c b/drivers/core/read.c
index 55c19f335ae12b8d9f83d1cb2a10e2ffc13cf935..981204bffe4c26641ea8b387f00f4efc641d6e47 100644
--- a/drivers/core/read.c
+++ b/drivers/core/read.c
@@ -38,8 +38,8 @@ int dev_read_u32(const struct udevice *dev, const char *propname, u32 *outp)
 	return ofnode_read_u32(dev_ofnode(dev), propname, outp);
 }
 
-int dev_read_u32_default(const struct udevice *dev, const char *propname,
-			 int def)
+u32 dev_read_u32_default(const struct udevice *dev, const char *propname,
+			 u32 def)
 {
 	return ofnode_read_u32_default(dev_ofnode(dev), propname, def);
 }
diff --git a/include/dm/read.h b/include/dm/read.h
index 894bc698bb49209c03e7cf74628a2600ea1be675..87017f076216492af5bb8da3a984ed1e074428cc 100644
--- a/include/dm/read.h
+++ b/include/dm/read.h
@@ -90,8 +90,8 @@ int dev_read_u32(const struct udevice *dev, const char *propname, u32 *outp);
  * @def:	default value to return if the property has no value
  * Return: property value, or @def if not found
  */
-int dev_read_u32_default(const struct udevice *dev, const char *propname,
-			 int def);
+u32 dev_read_u32_default(const struct udevice *dev, const char *propname,
+			 u32 def);
 
 /**
  * dev_read_u32_index() - read an indexed 32-bit integer from a device's DT
@@ -896,7 +896,7 @@ static inline int dev_read_u32(const struct udevice *dev,
 }
 
 static inline int dev_read_u32_default(const struct udevice *dev,
-				       const char *propname, int def)
+				       const char *propname, u32 def)
 {
 	return ofnode_read_u32_default(dev_ofnode(dev), propname, def);
 }

-- 
2.49.0

