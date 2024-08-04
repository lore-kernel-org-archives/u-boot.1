Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B00C3DA7F
	for <u-boot@archiver.kernel.org>; Sun,  4 Aug 2024 15:06:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 223BC88852;
	Sun,  4 Aug 2024 17:06:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="gWGsnbzu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B74C088785; Sun,  4 Aug 2024 17:06:13 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8043887B4
 for <u-boot@lists.denx.de>; Sun,  4 Aug 2024 17:06:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=32c7=PE=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1722783967; bh=KdQyTykUekTGuKcgn07sNW8p6o365ytGFLEFK92XFBM=;
 b=gWGsnbzuEvBboIWNdKQK2NcqQRcp5kVBx3Ofp0LeyRPZdVpA3lvkxwGZNx1vRq4bgrz9wkXrr
 TSjP467F5ulf4MhjXuK1/sD1WJufdiXSFcYgOlFT740I6I45gUECV0AfUkfIyUJ64BZxe1/MZq1
 D/pyiiY4JHfIema14qn074GuiZB9RSF27DDnqt17vP+gHIQzUdZU/NhSSihGTy0pAYB1JobLWpJ
 y+lErvcxgUNb/sME/OvPopZduVVwKf7DnKqHDPeZbb1XMVJ8h6eikIWAu1GteugbTDiKHKGh2oJ
 flU0mCJqrPsKJb1NKwu5X2GPS5a/3Wt7A8XbLc+78DsA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 1/3] dm: core: fdtaddr: Avoid multiple calls to
 fdt_parent_offset()
Date: Sun,  4 Aug 2024 15:05:49 +0000
Message-ID: <20240804150556.3519995-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240804150556.3519995-1-jonas@kwiboo.se>
References: <20240804150556.3519995-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66af98dbb04314fb234e2f97
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

Use of fdt_parent_offset() is very expensive as detailed by the function
documentation:

  NOTE: This function is expensive, as it must scan the device tree
  structure from the start to nodeoffset, *twice*.

Re-use the returned value from a single call instead of having to make
multiple calls for same nodeoffset.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/core/fdtaddr.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/core/fdtaddr.c b/drivers/core/fdtaddr.c
index 9e59968df016..2aa58b006f1a 100644
--- a/drivers/core/fdtaddr.c
+++ b/drivers/core/fdtaddr.c
@@ -19,11 +19,10 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-fdt_addr_t devfdt_get_addr_index(const struct udevice *dev, int index)
+#if CONFIG_IS_ENABLED(OF_REAL) || CONFIG_IS_ENABLED(OF_CONTROL)
+fdt_addr_t devfdt_get_addr_index_parent(const struct udevice *dev, int index,
+					int offset, int parent)
 {
-#if CONFIG_IS_ENABLED(OF_REAL)
-	int offset = dev_of_offset(dev);
-	int parent = fdt_parent_offset(gd->fdt_blob, offset);
 	fdt_addr_t addr;
 
 	if (CONFIG_IS_ENABLED(OF_TRANSLATE)) {
@@ -89,6 +88,15 @@ fdt_addr_t devfdt_get_addr_index(const struct udevice *dev, int index)
 #endif
 
 	return addr;
+}
+#endif
+
+fdt_addr_t devfdt_get_addr_index(const struct udevice *dev, int index)
+{
+#if CONFIG_IS_ENABLED(OF_REAL)
+	int offset = dev_of_offset(dev);
+	int parent = fdt_parent_offset(gd->fdt_blob, offset);
+	return devfdt_get_addr_index_parent(dev, index, offset, parent);
 #else
 	return FDT_ADDR_T_NONE;
 #endif
@@ -113,14 +121,16 @@ fdt_addr_t devfdt_get_addr_size_index(const struct udevice *dev, int index,
 	 * next call to the exisiting dev_get_xxx function which handles
 	 * all config options.
 	 */
-	fdtdec_get_addr_size_auto_noparent(gd->fdt_blob, dev_of_offset(dev),
-					   "reg", index, size, false);
+	int offset = dev_of_offset(dev);
+	int parent = fdt_parent_offset(gd->fdt_blob, offset);
+	fdtdec_get_addr_size_auto_parent(gd->fdt_blob, parent, offset,
+					 "reg", index, size, false);
 
 	/*
 	 * Get the base address via the existing function which handles
 	 * all Kconfig cases
 	 */
-	return devfdt_get_addr_index(dev, index);
+	return devfdt_get_addr_index_parent(dev, index, offset, parent);
 #else
 	return FDT_ADDR_T_NONE;
 #endif
-- 
2.45.2

