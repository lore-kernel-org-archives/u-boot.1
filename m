Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB623C02198
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 12:57:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D18380C8F;
	Wed, 12 Feb 2025 13:56:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="swYEhA9c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87D60807C0; Wed, 12 Feb 2025 10:18:36 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02DAA80C6F
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 10:18:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51C9IU5N409525
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Feb 2025 03:18:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739351910;
 bh=119FzvUs96ksdCo/9xgCP56n4fxYGwctx/kWPsQzPpY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=swYEhA9cykk3A6hzJO7SNlz6k+e6TGgoxmhHpsRlTyfdNDNxIOz5BD2wQJZCpFacQ
 awS8cRdYUrVfueoVtiSjZ9Osl9wjfj36zcgtkVJHI0GNfUbJDeor2FC140NKq1i8Vh
 3rTvlG7Y3PjeSFW8OmC1beADvyrwZL1aYLALjbbY=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51C9IUmX083768
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 12 Feb 2025 03:18:30 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Feb 2025 03:18:30 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Feb 2025 03:18:29 -0600
Received: from moteen-ubuntu-desk.dhcp.ti.com (moteen-ubuntu-desk.dhcp.ti.com
 [172.24.227.18])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51C9ILKS067685;
 Wed, 12 Feb 2025 03:18:27 -0600
From: Moteen Shah <m-shah@ti.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <m-chawdhry@ti.com>,
 <n-francis@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <a-chavda@ti.com>, <m-shah@ti.com>
Subject: [RFC PATCH 2/2 v1] drivers: core: lists.c: Bind drivers using bootph*
 property in subnodes
Date: Wed, 12 Feb 2025 14:48:20 +0530
Message-ID: <20250212091820.213895-3-m-shah@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212091820.213895-1-m-shah@ti.com>
References: <20250212091820.213895-1-m-shah@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Wed, 12 Feb 2025 13:56:52 +0100
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

Add a function to scan through all the subnodes of a given node
recusively for bootph* property. If found, propagate it to all
of its parent node up the hierarchy so as to bind the respective
drivers of the nodes in the pre-relocation stage. 

The current model skips the node if there is no bootph* found in
it, even if the property is present in one of the subnodes. The 
issue is tracked in [0].

Signed-off-by: Moteen Shah <m-shah@ti.com>

References: 
[0] https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/21

---
 drivers/core/lists.c | 88 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 86 insertions(+), 2 deletions(-)

diff --git a/drivers/core/lists.c b/drivers/core/lists.c
index c7be504b6fc..5be556ea951 100644
--- a/drivers/core/lists.c
+++ b/drivers/core/lists.c
@@ -17,6 +17,7 @@
 #include <dm/platdata.h>
 #include <dm/uclass.h>
 #include <dm/util.h>
+#include <fdt_support.h>
 #include <fdtdec.h>
 #include <linux/compiler.h>
 
@@ -196,6 +197,80 @@ static int driver_check_compatible(const struct udevice_id *of_match,
 	return -ENOENT;
 }
 
+/**
+ * scan_and_prop_bootph() - Check if a driver matches a compatible string
+ *
+ * @param of_node:	Parent node for child traversal
+ * @param fdt:	Blob to use
+ */
+static int scan_and_prop_bootph(ofnode node, void *fdt)
+{
+	static int bootph_index = -1;
+	static const char * const bootph_props[] = {
+		"bootph-all",
+		"bootph-some-ram",
+		"bootph-pre-ram",
+		"bootph-pre-sram",
+	};
+	int offset;
+	int ret = -ENOENT;
+	ofnode subnode;
+
+	/* Note the index where bootph-* was found and return success */
+	for (int i = 0; i < ARRAY_SIZE(bootph_props); i++) {
+		if (ofnode_read_bool(node, bootph_props[i])) {
+			bootph_index = i;
+			return 0;
+		}
+	}
+
+	ofnode_for_each_subnode(subnode, node) {
+		if (!ofnode_valid(subnode))
+			continue;
+
+		ret = scan_and_prop_bootph(subnode, fdt);
+		if (ret != -ENOENT && ret)
+			return ret;
+
+		/*
+		 * Break the search if bootph-* is found in any of the subnodes.
+		 * Breaking the loop early helps in avoiding unnecessary traversal
+		 * of the sibling node given that bootph-* has been found in previous
+		 * sibling node.
+		 */
+		if (!ret)
+			break;
+	}
+
+	/* If no bootph-* found then return no such entry */
+	if (ret)
+		return -ENOENT;
+
+	if (bootph_index != -1) {
+		offset = ofnode_to_offset(node);
+		if (offset < 0) {
+			log_err("Failed to get offset %d\n", offset);
+			return -EINVAL;
+		}
+
+		ret = fdt_increase_size(fdt, 32);
+		if (ret) {
+			log_err("Cannot increase FDT size!\n");
+			return ret;
+		}
+
+		ret = fdt_setprop_empty(fdt, offset, bootph_props[bootph_index]);
+		if (ret) {
+			log_err("Failed to add bootph prop to node:%s ret=%d\n",
+				ofnode_get_name(node), ret);
+			return ret;
+		}
+		bootph_index = -1;
+	}
+
+	return ret;
+}
+
 int lists_bind_fdt(struct udevice *parent, ofnode node, struct udevice **devp,
 		   struct driver *drv, bool pre_reloc_only)
 {
@@ -205,6 +280,7 @@ int lists_bind_fdt(struct udevice *parent, ofnode node, struct udevice **devp,
 	struct driver *entry;
 	struct udevice *dev;
 	bool found = false;
+	void *fdt = (void *)gd->fdt_blob;
 	const char *name, *compat_list, *compat;
 	int compat_length, i;
 	int result = 0;
@@ -256,8 +332,16 @@ int lists_bind_fdt(struct udevice *parent, ofnode node, struct udevice **devp,
 		if (pre_reloc_only) {
 			if (!ofnode_pre_reloc(node) &&
 			    !(entry->flags & DM_FLAG_PRE_RELOC)) {
-				log_debug("Skipping device pre-relocation\n");
-				return 0;
+				if (IS_ENABLED(CONFIG_BIND_FROM_CHILD_BOOTPH)) {
+					ret = scan_and_prop_bootph(node, fdt);
+					if (ret) {
+						log_debug("Skipping device pre-relocation\n");
+						return 0;
+					}
+				} else {
+					log_debug("Skipping device pre-relocation\n");
+					return 0;
+				}
 			}
 		}
 
-- 
2.34.1

