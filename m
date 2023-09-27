Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA12E810DA
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 13:34:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCC8986D38;
	Wed, 27 Sep 2023 15:34:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tq-group.com header.i=@tq-group.com header.b="Llq6H8w5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6168486DE6; Wed, 27 Sep 2023 15:34:10 +0200 (CEST)
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E30286D20
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 15:34:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=matthias.schiffer@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
 t=1695821644; x=1727357644;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=eJN9JPtPDtEKygu2S0xcJ0FCKUhkwsMKzo2KqhgpxXk=;
 b=Llq6H8w5mwXcGKM/EMwi0/hSMsPJQX5f7mgjSzQA3HyI/NVwxm1ut1Mo
 cdz+Qvy8RTcX7Z5fIf9l+QLh74UJMRTvBIa8iFjcaydqjmHcHScvxhkfj
 Yv74jfU8ILOHdJPlvJxR8n02rJBMIjuLgcqVUK439pO852mCfzLuuiCFr
 p3pMn7GNbb3K3VYxiIPbLw1sSCjFhzNdnKoPSfsAT4umiMJRhFELHWS5k
 7eZbHRM3Gkl6A73R6LZDYHTfuLupaIwolVQBmD2Xsh31EtvFWV6BUJBq5
 r7lKpUMgzWqlUlhoEuFL6b28/RxrvkpB67TPzksiTVmtf/oo54ZRhKt/+ g==;
X-IronPort-AV: E=Sophos;i="6.03,181,1694728800"; d="scan'208";a="33178728"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
 by mx1.tq-group.com with ESMTP; 27 Sep 2023 15:34:04 +0200
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.20])
 by vtuxmail01.tq-net.de (Postfix) with ESMTPA id E24BC280075;
 Wed, 27 Sep 2023 15:34:03 +0200 (CEST)
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Simon Glass <sjg@chromium.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de, u-boot@ew.tq-group.com,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 1/5] core: fix doc comments of dev_read_addr*() and related
 functions
Date: Wed, 27 Sep 2023 15:33:30 +0200
Message-Id: <78309a6288060d9883de9f1406a2d81c4ca3904f.1695817360.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

- The dev_read_addr_name*() family of functions has no "index" argument,
  doc comments should refer to "name"
- Specify the error return for several devfdt_get_addr*() functions

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 include/dm/fdtaddr.h | 12 ++++++------
 include/dm/read.h    |  6 +++---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/dm/fdtaddr.h b/include/dm/fdtaddr.h
index dcdc19137cc..ca788dccb39 100644
--- a/include/dm/fdtaddr.h
+++ b/include/dm/fdtaddr.h
@@ -19,7 +19,7 @@ struct udevice;
  *
  * @dev: Pointer to a device
  *
- * Return: addr
+ * Return: Address, or FDT_ADDR_T_NONE if there is no such property
  */
 fdt_addr_t devfdt_get_addr(const struct udevice *dev);
 
@@ -59,7 +59,7 @@ void *devfdt_remap_addr_index(const struct udevice *dev, int index);
  * devfdt_remap_addr_name() - Get the reg property of a device, indexed by
  *                            name, as a memory-mapped I/O pointer
  * @name: the 'reg' property can hold a list of <addr, size> pairs, with the
- *	  'reg-names' property providing named-based identification. @index
+ *	  'reg-names' property providing named-based identification. @name
  *	  indicates the value to search for in 'reg-names'.
  *
  * @dev: Pointer to a device
@@ -87,7 +87,7 @@ void *devfdt_map_physmem(const struct udevice *dev, unsigned long size);
  * @index: the 'reg' property can hold a list of <addr, size> pairs
  *	   and @index is used to select which one is required
  *
- * Return: addr
+ * Return: Address, or FDT_ADDR_T_NONE if there is no such property
  */
 fdt_addr_t devfdt_get_addr_index(const struct udevice *dev, int index);
 
@@ -114,7 +114,7 @@ void *devfdt_get_addr_index_ptr(const struct udevice *dev, int index);
  * @size: Pointer to size variable - this function returns the size
  *        specified in the 'reg' property here
  *
- * Return: addr
+ * Return: Address, or FDT_ADDR_T_NONE if there is no such property
  */
 fdt_addr_t devfdt_get_addr_size_index(const struct udevice *dev, int index,
 				      fdt_size_t *size);
@@ -139,7 +139,7 @@ void *devfdt_get_addr_size_index_ptr(const struct udevice *dev, int index,
  *
  * @dev: Pointer to a device
  * @name: the 'reg' property can hold a list of <addr, size> pairs, with the
- *	  'reg-names' property providing named-based identification. @index
+ *	  'reg-names' property providing named-based identification. @name
  *	  indicates the value to search for in 'reg-names'.
  *
  * Return: addr
@@ -154,7 +154,7 @@ fdt_addr_t devfdt_get_addr_name(const struct udevice *dev, const char *name);
  *
  * @dev: Pointer to a device
  * @name: the 'reg' property can hold a list of <addr, size> pairs, with the
- *	  'reg-names' property providing named-based identification. @index
+ *	  'reg-names' property providing named-based identification. @name
  *	  indicates the value to search for in 'reg-names'.
  * @size: Pointer to size variable - this function returns the size
  *        specified in the 'reg' property here
diff --git a/include/dm/read.h b/include/dm/read.h
index c2615f72f40..da7732a170f 100644
--- a/include/dm/read.h
+++ b/include/dm/read.h
@@ -277,7 +277,7 @@ void *dev_remap_addr_index(const struct udevice *dev, int index);
  *
  * @dev: Device to read from
  * @name: the 'reg' property can hold a list of <addr, size> pairs, with the
- *	  'reg-names' property providing named-based identification. @index
+ *	  'reg-names' property providing named-based identification. @name
  *	  indicates the value to search for in 'reg-names'.
  *
  * Return: address or FDT_ADDR_T_NONE if not found
@@ -289,7 +289,7 @@ fdt_addr_t dev_read_addr_name(const struct udevice *dev, const char *name);
  *
  * @dev: Device to read from
  * @name: the 'reg' property can hold a list of <addr, size> pairs, with the
- *	  'reg-names' property providing named-based identification. @index
+ *	  'reg-names' property providing named-based identification. @name
  *	  indicates the value to search for in 'reg-names'.
  *  @size: place to put size value (on success)
  *
@@ -304,7 +304,7 @@ fdt_addr_t dev_read_addr_size_name(const struct udevice *dev, const char *name,
  *
  * @dev: Device to read from
  * @name: the 'reg' property can hold a list of <addr, size> pairs, with the
- *	  'reg-names' property providing named-based identification. @index
+ *	  'reg-names' property providing named-based identification. @name
  *	  indicates the value to search for in 'reg-names'.
  *
  * Return: pointer or NULL if not found
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

