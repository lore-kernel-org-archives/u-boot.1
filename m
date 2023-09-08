Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0410EE7FF5
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 13:37:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0542786A33;
	Fri,  8 Sep 2023 15:37:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C61986A21; Fri,  8 Sep 2023 15:37:20 +0200 (CEST)
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk
 [188.40.203.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CB9486A1D
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 15:37:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=codethink.co.uk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ben@codethink.co.uk
Received: from [134.238.52.102] (helo=rainbowdash)
 by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1qebfg-004zph-Of; Fri, 08 Sep 2023 14:37:16 +0100
Received: from ben by rainbowdash with local (Exim 4.96)
 (envelope-from <ben@rainbowdash>) id 1qebff-000RDO-0m;
 Fri, 08 Sep 2023 14:37:15 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: u-boot@lists.denx.de
Cc: palmer@dabbelt.com,
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 2/2] sifive: ccache: add clear LIM area
Date: Fri,  8 Sep 2023 14:37:07 +0100
Message-Id: <20230908133707.104592-2-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908133707.104592-1-ben.dooks@codethink.co.uk>
References: <20230908133707.104592-1-ben.dooks@codethink.co.uk>
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

Add option to clear the LIM area on startup, just in case this
is the cause of some of the data-errors on startup.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
[ben.dooks@codethink.co.uk: changed from sifive.com address]
---
 drivers/cache/Kconfig               |  8 ++++++
 drivers/cache/cache-sifive-ccache.c | 40 +++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/cache/Kconfig b/drivers/cache/Kconfig
index abe7de9abf..9d5cbaedea 100644
--- a/drivers/cache/Kconfig
+++ b/drivers/cache/Kconfig
@@ -46,6 +46,14 @@ config SIFIVE_CCACHE
 	  This driver is for SiFive Composable L2/L3 cache. It enables cache
 	  ways of composable cache.
 
+config SIFIVE_CCACHE_LIMZERO
+	bool "Zero LIM (loosely integrated memory) on startup"
+	depends on SIFIVE_CCACHE
+	help
+	  Select this option to clear the LIM (cache memory) block before
+	  enabling the cache. This will increase the init time but may
+	  help with some of the errors being seen on OS startup.
+
 config SIFIVE_PL2CACHE
 	bool "SiFive per-core L2 cache"
 	select CACHE
diff --git a/drivers/cache/cache-sifive-ccache.c b/drivers/cache/cache-sifive-ccache.c
index 178bdcc82d..a84b5c9d04 100644
--- a/drivers/cache/cache-sifive-ccache.c
+++ b/drivers/cache/cache-sifive-ccache.c
@@ -8,6 +8,7 @@
 #include <dm.h>
 #include <asm/io.h>
 #include <dm/device.h>
+#include <dm/device_compat.h>
 #include <linux/bitfield.h>
 
 #define SIFIVE_CCACHE_CONFIG		0x000
@@ -43,6 +44,43 @@ static int sifive_ccache_get_info(struct udevice *dev, struct cache_info *info)
 	return 0;
 }
 
+#ifdef CONFIG_SIFIVE_CCACHE_LIMZERO
+static int sifive_clear_lim(struct udevice *dev)
+{
+
+	fdt_addr_t base, size;
+	ofnode mem_node;
+	u32 handle = 0;
+	int ret;
+
+	ret = ofnode_read_u32(dev_ofnode(dev), "memory-region", &handle);
+	if (ret) {
+		dev_err(dev, "no memory-region for lim\n");
+		return -EINVAL;
+	}
+
+	mem_node = ofnode_get_by_phandle(handle);
+	if (!ofnode_valid(mem_node)) {
+		dev_err(dev, "invalid memory region for lim\n");
+		return -EINVAL;
+	}
+
+	base = ofnode_get_addr_size_index(mem_node, 0, &size);
+
+	/* note, we assume this is called so early none of the ways of
+	 * the cache have been enabled, so just clear the entire cache
+	 * memory
+	 */
+
+	dev_info(dev, "clearing l3lim %llx..%llx\n", base, base+size);
+	memset((void *)base, 0x0, size);
+
+	return 0;
+}
+#else
+static inline int sifive_clear_lim(struct udevice *dev) { return 0; }
+#endif
+
 static const struct cache_ops sifive_ccache_ops = {
 	.enable = sifive_ccache_enable,
 	.get_info = sifive_ccache_get_info,
@@ -63,6 +101,8 @@ static int sifive_ccache_probe(struct udevice *dev)
 	(void)readl(base + 0x148);
 	(void)readl(base + 0x168);
 
+	sifive_clear_lim(dev);
+
 	return 0;
 }
 
-- 
2.40.1

