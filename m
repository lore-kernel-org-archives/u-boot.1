Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC10E7F14E
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 13:34:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2463686DB9;
	Wed, 27 Sep 2023 15:34:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tq-group.com header.i=@tq-group.com header.b="N4HOlGHi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20B2386E00; Wed, 27 Sep 2023 15:34:12 +0200 (CEST)
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9AF586D62
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 15:34:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=matthias.schiffer@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
 t=1695821649; x=1727357649;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jRTVvKZtvxe68/QqSVqYWFv/nbBDH1p9EW83ByxDgEg=;
 b=N4HOlGHiojYurW57X2RBR684fJXP+eGiDxx/B/QK5LYHJ3B2AZWNjf7Q
 J9/p+vtIRzD7fK55WP7j3sJKPqMCSeYUxxaTR1eIV9bdfekR8h9izq5F5
 MavjhZO/zWgTkHliepD8jaIqM8wrofImHr6gHVmQXLn9m4iXj1HrcaXqv
 y1A2uLZkCACFQICX18i0VFfZZVrAR4t8SAp/5TKsCYP5bSSlZnpkdCxJu
 fHvduUVTdvwPeWgKJ8Kli+CgeOEUHDgQWZNh4GlERsdtxigsBnViFhLzp
 scA8S2CmcKK2FTTX3LMx0JFnXKRMGQlBDtFLg03w6RkRk2tVwf+Td4Jwg g==;
X-IronPort-AV: E=Sophos;i="6.03,181,1694728800"; d="scan'208";a="33178729"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
 by mx1.tq-group.com with ESMTP; 27 Sep 2023 15:34:04 +0200
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.20])
 by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 17FBF280084;
 Wed, 27 Sep 2023 15:34:04 +0200 (CEST)
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Simon Glass <sjg@chromium.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de, u-boot@ew.tq-group.com,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 2/5] core: return FDT_ADDR_T_NONE from
 devfdt_get_addr_[size_]name() on errors
Date: Wed, 27 Sep 2023 15:33:31 +0200
Message-Id: <fd0412ad51224c3afdf0a08870afa46127a42396.1695817360.git.matthias.schiffer@ew.tq-group.com>
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

Checking for the error cast to fdt_addr_t is rather awkward - IS_ERR()
can be used, but it's not really made to be used on fdt_addr_t, which
may not even be the same size as a native pointer.

Most places in U-Boot only check for FDT_ADDR_T_NONE; let's adjust the
error return to match the expectation.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/core/fdtaddr.c | 4 ++--
 include/dm/fdtaddr.h   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/core/fdtaddr.c b/drivers/core/fdtaddr.c
index 546db675aaf..426bb762754 100644
--- a/drivers/core/fdtaddr.c
+++ b/drivers/core/fdtaddr.c
@@ -145,7 +145,7 @@ fdt_addr_t devfdt_get_addr_name(const struct udevice *dev, const char *name)
 	index = fdt_stringlist_search(gd->fdt_blob, dev_of_offset(dev),
 				      "reg-names", name);
 	if (index < 0)
-		return index;
+		return FDT_ADDR_T_NONE;
 
 	return devfdt_get_addr_index(dev, index);
 #else
@@ -162,7 +162,7 @@ fdt_addr_t devfdt_get_addr_size_name(const struct udevice *dev,
 	index = fdt_stringlist_search(gd->fdt_blob, dev_of_offset(dev),
 				      "reg-names", name);
 	if (index < 0)
-		return index;
+		return FDT_ADDR_T_NONE;
 
 	return devfdt_get_addr_size_index(dev, index, size);
 #else
diff --git a/include/dm/fdtaddr.h b/include/dm/fdtaddr.h
index ca788dccb39..d3ad77faebf 100644
--- a/include/dm/fdtaddr.h
+++ b/include/dm/fdtaddr.h
@@ -142,7 +142,7 @@ void *devfdt_get_addr_size_index_ptr(const struct udevice *dev, int index,
  *	  'reg-names' property providing named-based identification. @name
  *	  indicates the value to search for in 'reg-names'.
  *
- * Return: addr
+ * Return: Address, or FDT_ADDR_T_NONE if there is no such property
  */
 fdt_addr_t devfdt_get_addr_name(const struct udevice *dev, const char *name);
 
@@ -159,7 +159,7 @@ fdt_addr_t devfdt_get_addr_name(const struct udevice *dev, const char *name);
  * @size: Pointer to size variable - this function returns the size
  *        specified in the 'reg' property here
  *
- * Return: addr
+ * Return: Address, or FDT_ADDR_T_NONE if there is no such property
  */
 fdt_addr_t devfdt_get_addr_size_name(const struct udevice *dev,
 				     const char *name, fdt_size_t *size);
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

