Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72990E810DA
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 13:34:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B32086DDE;
	Wed, 27 Sep 2023 15:34:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tq-group.com header.i=@tq-group.com header.b="f9rTHpfn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A427786D62; Wed, 27 Sep 2023 15:34:12 +0200 (CEST)
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 115C286DC3
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 15:34:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=matthias.schiffer@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
 t=1695821650; x=1727357650;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=StF6t4tPR28VggVSrxQmqRwo+kuQa/eAiFO0BrsMfak=;
 b=f9rTHpfnmfbauaPITHQYQUULKXq2uOz53mT74jssjxwtg6gOreD6DTu7
 bR28qKaXtrKnHoHa94ECGMQXPh8+nGmD08uq2d2Hlwvh2SaU7Ba5jbDGZ
 uJrhQni2i/doW/s4g0zMDlaWfXJBYM2SZXNeZ60TtWX/vQ+czAidV9fLo
 6BzD562TLjxCohTyLDiyL42iGZwHFxDgucqK+gr9zM08/0pMh3+AlTb+5
 LDLId/bXFViEbsCkGIhkD1udSgL11xch5Si3o/td+Y0Tulfuk767UCm8N
 Ko3PjIUMvrxjFNiSUMqRbx6SYWdiZuzOPhes+a+Tz+DpNJqv6d5xZ2J+F Q==;
X-IronPort-AV: E=Sophos;i="6.03,181,1694728800"; d="scan'208";a="33178730"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
 by mx1.tq-group.com with ESMTP; 27 Sep 2023 15:34:04 +0200
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.20])
 by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 40E1B280085;
 Wed, 27 Sep 2023 15:34:04 +0200 (CEST)
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Simon Glass <sjg@chromium.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de, u-boot@ew.tq-group.com,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 3/5] core: introduce dev_read_addr_name[_size]_ptr() functions
Date: Wed, 27 Sep 2023 15:33:32 +0200
Message-Id: <4ccdb1eaf4094120c496eaccba30cd2473a7b0fa.1695817360.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <78309a6288060d9883de9f1406a2d81c4ca3904f.1695817360.git.matthias.schiffer@ew.tq-group.com>
References: <78309a6288060d9883de9f1406a2d81c4ca3904f.1695817360.git.matthias.schiffer@ew.tq-group.com>
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

Same as dev_read_addr_name[_size](), but returns a pointer, cast
through map_sysmem().

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/core/fdtaddr.c | 21 +++++++++++++++++++++
 drivers/core/read.c    | 21 +++++++++++++++++++++
 include/dm/fdtaddr.h   | 31 +++++++++++++++++++++++++++++++
 include/dm/read.h      | 41 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 114 insertions(+)

diff --git a/drivers/core/fdtaddr.c b/drivers/core/fdtaddr.c
index 426bb762754..560b0b634a2 100644
--- a/drivers/core/fdtaddr.c
+++ b/drivers/core/fdtaddr.c
@@ -153,6 +153,16 @@ fdt_addr_t devfdt_get_addr_name(const struct udevice *dev, const char *name)
 #endif
 }
 
+void *devfdt_get_addr_name_ptr(const struct udevice *dev, const char *name)
+{
+	fdt_addr_t addr = devfdt_get_addr_name(dev, name);
+
+	if (addr == FDT_ADDR_T_NONE)
+		return NULL;
+
+	return map_sysmem(addr, 0);
+}
+
 fdt_addr_t devfdt_get_addr_size_name(const struct udevice *dev,
 				     const char *name, fdt_size_t *size)
 {
@@ -170,6 +180,17 @@ fdt_addr_t devfdt_get_addr_size_name(const struct udevice *dev,
 #endif
 }
 
+void *devfdt_get_addr_size_name_ptr(const struct udevice *dev,
+				    const char *name, fdt_size_t *size)
+{
+	fdt_addr_t addr = devfdt_get_addr_size_name(dev, name, size);
+
+	if (addr == FDT_ADDR_T_NONE)
+		return NULL;
+
+	return map_sysmem(addr, 0);
+}
+
 fdt_addr_t devfdt_get_addr(const struct udevice *dev)
 {
 	return devfdt_get_addr_index(dev, 0);
diff --git a/drivers/core/read.c b/drivers/core/read.c
index 49066b59cda..0908321c846 100644
--- a/drivers/core/read.c
+++ b/drivers/core/read.c
@@ -181,6 +181,16 @@ fdt_addr_t dev_read_addr_name(const struct udevice *dev, const char *name)
 		return dev_read_addr_index(dev, index);
 }
 
+void *dev_read_addr_name_ptr(const struct udevice *dev, const char *name)
+{
+	fdt_addr_t addr = dev_read_addr_name(dev, name);
+
+	if (addr == FDT_ADDR_T_NONE)
+		return NULL;
+
+	return map_sysmem(addr, 0);
+}
+
 fdt_addr_t dev_read_addr_size_name(const struct udevice *dev, const char *name,
 				   fdt_size_t *size)
 {
@@ -192,6 +202,17 @@ fdt_addr_t dev_read_addr_size_name(const struct udevice *dev, const char *name,
 		return dev_read_addr_size_index(dev, index, size);
 }
 
+void *dev_read_addr_size_name_ptr(const struct udevice *dev, const char *name,
+				  fdt_size_t *size)
+{
+	fdt_addr_t addr = dev_read_addr_size_name(dev, name, size);
+
+	if (addr == FDT_ADDR_T_NONE)
+		return NULL;
+
+	return map_sysmem(addr, 0);
+}
+
 void *dev_remap_addr_name(const struct udevice *dev, const char *name)
 {
 	fdt_addr_t addr = dev_read_addr_name(dev, name);
diff --git a/include/dm/fdtaddr.h b/include/dm/fdtaddr.h
index d3ad77faebf..750ca0076ed 100644
--- a/include/dm/fdtaddr.h
+++ b/include/dm/fdtaddr.h
@@ -146,6 +146,19 @@ void *devfdt_get_addr_size_index_ptr(const struct udevice *dev, int index,
  */
 fdt_addr_t devfdt_get_addr_name(const struct udevice *dev, const char *name);
 
+/**
+ * devfdt_get_addr_name_ptr() - Get the reg property of a device as a pointer,
+ *                              indexed by name
+ *
+ * @dev: Pointer to a device
+ * @name: the 'reg' property can hold a list of <addr, size> pairs, with the
+ *	  'reg-names' property providing named-based identification. @name
+ *	  indicates the value to search for in 'reg-names'.
+ *
+ * Return: Pointer to addr, or NULL if there is no such property
+ */
+void *devfdt_get_addr_name_ptr(const struct udevice *dev, const char *name);
+
 /**
  * devfdt_get_addr_size_name() - Get the reg property and its size for a device,
  *				 indexed by name
@@ -164,6 +177,24 @@ fdt_addr_t devfdt_get_addr_name(const struct udevice *dev, const char *name);
 fdt_addr_t devfdt_get_addr_size_name(const struct udevice *dev,
 				     const char *name, fdt_size_t *size);
 
+/**
+ * devfdt_get_addr_size_name_ptr() - Get the reg property for a device as a
+ *                                   pointer, indexed by name
+ *
+ * Returns the address and size specified in the 'reg' property of a device.
+ *
+ * @dev: Pointer to a device
+ * @name: the 'reg' property can hold a list of <addr, size> pairs, with the
+ *	  'reg-names' property providing named-based identification. @name
+ *	  indicates the value to search for in 'reg-names'.
+ * @size: Pointer to size variable - this function returns the size
+ *        specified in the 'reg' property here
+ *
+ * Return: Pointer to addr, or NULL if there is no such property
+ */
+void *devfdt_get_addr_size_name_ptr(const struct udevice *dev,
+				    const char *name, fdt_size_t *size);
+
 /**
  * devfdt_get_addr_pci() - Read an address and handle PCI address translation
  *
diff --git a/include/dm/read.h b/include/dm/read.h
index da7732a170f..c936645e0a8 100644
--- a/include/dm/read.h
+++ b/include/dm/read.h
@@ -284,6 +284,19 @@ void *dev_remap_addr_index(const struct udevice *dev, int index);
  */
 fdt_addr_t dev_read_addr_name(const struct udevice *dev, const char *name);
 
+/**
+ * dev_read_addr_name_ptr() - Get the reg property of a device as a pointer,
+ *                            indexed by name
+ *
+ * @dev: Device to read from
+ * @name: the 'reg' property can hold a list of <addr, size> pairs, with the
+ *	  'reg-names' property providing named-based identification. @name
+ *	  indicates the value to search for in 'reg-names'.
+ *
+ * Return: pointer or NULL if not found
+ */
+void *dev_read_addr_name_ptr(const struct udevice *dev, const char *name);
+
 /**
  * dev_read_addr_size_name() - Get the reg property of a device, indexed by name
  *
@@ -298,6 +311,21 @@ fdt_addr_t dev_read_addr_name(const struct udevice *dev, const char *name);
 fdt_addr_t dev_read_addr_size_name(const struct udevice *dev, const char *name,
 				   fdt_size_t *size);
 
+/**
+ * dev_read_addr_size_name_ptr() - Get the reg property of a device as a pointer,
+ *                                 indexed by name
+ *
+ * @dev: Device to read from
+ * @name: the 'reg' property can hold a list of <addr, size> pairs, with the
+ *	  'reg-names' property providing named-based identification. @name
+ *	  indicates the value to search for in 'reg-names'.
+ *  @size: place to put size value (on success)
+ *
+ * Return: pointer or NULL if not found
+ */
+void *dev_read_addr_size_name_ptr(const struct udevice *dev, const char *name,
+				  fdt_size_t *size);
+
 /**
  * dev_remap_addr_name() - Get the reg property of a device, indexed by name,
  *                         as a memory-mapped I/O pointer
@@ -979,6 +1007,12 @@ static inline fdt_addr_t dev_read_addr_name(const struct udevice *dev,
 	return devfdt_get_addr_name(dev, name);
 }
 
+static inline void *dev_read_addr_name_ptr(const struct udevice *dev,
+					   const char *name)
+{
+	return devfdt_get_addr_name_ptr(dev, name);
+}
+
 static inline fdt_addr_t dev_read_addr_size_name(const struct udevice *dev,
 						 const char *name,
 						 fdt_size_t *size)
@@ -986,6 +1020,13 @@ static inline fdt_addr_t dev_read_addr_size_name(const struct udevice *dev,
 	return devfdt_get_addr_size_name(dev, name, size);
 }
 
+static inline void *dev_read_addr_size_name_ptr(const struct udevice *dev,
+						const char *name,
+						fdt_size_t *size)
+{
+	return devfdt_get_addr_size_name_ptr(dev, name, size);
+}
+
 static inline fdt_addr_t dev_read_addr(const struct udevice *dev)
 {
 	return devfdt_get_addr(dev);
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

