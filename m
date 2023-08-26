Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D89C83F16
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 09:07:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEF7D86B3A;
	Sat, 26 Aug 2023 11:07:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA32886B37; Sat, 26 Aug 2023 11:07:05 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 1C4D186B19
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 11:07:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 906E11FB;
 Sat, 26 Aug 2023 02:07:42 -0700 (PDT)
Received: from a076522.blr.arm.com (a076522.blr.arm.com [10.162.46.7])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B2A73F740;
 Sat, 26 Aug 2023 02:07:00 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [RFC PATCH 1/5] dt: Provide a way to remove non-compliant nodes and
 properties
Date: Sat, 26 Aug 2023 14:36:29 +0530
Message-Id: <20230826090633.239342-2-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230826090633.239342-1-sughosh.ganu@linaro.org>
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
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

Add a function which is registered to spy for a EVT_FT_FIXUP event,
and removes the non upstreamed nodes and properties from the
devicetree before it gets passed to the OS.

This allows removing entire nodes, or specific properties under nodes
from the devicetree. The required nodes and properties can be
registered for removal through the DT_NON_COMPLIANT_PURGE and
DT_NON_COMPLIANT_PURGE_LIST macros.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 include/dt-structs.h | 11 +++++++
 lib/Makefile         |  1 +
 lib/dt_purge.c       | 73 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+)
 create mode 100644 lib/dt_purge.c

diff --git a/include/dt-structs.h b/include/dt-structs.h
index fa1622cb1d..f535c60471 100644
--- a/include/dt-structs.h
+++ b/include/dt-structs.h
@@ -57,3 +57,14 @@ struct phandle_2_arg {
 #endif
 
 #endif
+
+struct dt_non_compliant_purge {
+	const char *node_path;
+	const char *prop;
+};
+
+#define DT_NON_COMPLIANT_PURGE(__name)	\
+	ll_entry_declare(struct dt_non_compliant_purge, __name, dt_purge)
+
+#define DT_NON_COMPLIANT_PURGE_LIST(__name)	\
+	ll_entry_declare_list(struct dt_non_compliant_purge, __name, dt_purge)
diff --git a/lib/Makefile b/lib/Makefile
index 8d8ccc8bbc..82a906daa0 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -37,6 +37,7 @@ endif
 obj-y += crc8.o
 obj-y += crc16.o
 obj-y += crc16-ccitt.o
+obj-y += dt_purge.o
 obj-$(CONFIG_ERRNO_STR) += errno_str.o
 obj-$(CONFIG_FIT) += fdtdec_common.o
 obj-$(CONFIG_TEST_FDTDEC) += fdtdec_test.o
diff --git a/lib/dt_purge.c b/lib/dt_purge.c
new file mode 100644
index 0000000000..f893ba9796
--- /dev/null
+++ b/lib/dt_purge.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#include <dt-structs.h>
+#include <event.h>
+#include <linker_lists.h>
+
+#include <linux/libfdt.h>
+
+/**
+ * dt_non_compliant_purge() -	Remove non-upstreamed nodes and properties
+ *				from the DT
+ * @ctx: Context for event
+ * @event: Event to process
+ *
+ * Iterate through an array of DT nodes and properties, and remove them
+ * from the device-tree before the DT gets handed over to the kernel.
+ * These are nodes and properties which do not have upstream bindings
+ * and need to be purged before being handed over to the kernel.
+ *
+ * If both the node and property are specified, delete the property. If
+ * only the node is specified, delete the entire node, including it's
+ * subnodes, if any.
+ *
+ * Return: 0 if OK, -ve on error
+ */
+static int dt_non_compliant_purge(void *ctx, struct event *event)
+{
+	int nodeoff = 0;
+	int err = 0;
+	void *fdt;
+	const struct event_ft_fixup *fixup = &event->data.ft_fixup;
+	struct dt_non_compliant_purge *purge_entry;
+	struct dt_non_compliant_purge *purge_start =
+		ll_entry_start(struct dt_non_compliant_purge, dt_purge);
+	int nentries = ll_entry_count(struct dt_non_compliant_purge, dt_purge);
+
+	if (fixup->images)
+		return 0;
+
+	fdt = fixup->tree.fdt;
+	for (purge_entry = purge_start; purge_entry != purge_start + nentries;
+	     purge_entry++) {
+		nodeoff = fdt_path_offset(fdt, purge_entry->node_path);
+		if (nodeoff < 0) {
+			log_debug("Error (%d) getting node offset for %s\n",
+				  nodeoff, purge_entry->node_path);
+			continue;
+		}
+
+		if (purge_entry->prop) {
+			err = fdt_delprop(fdt, nodeoff, purge_entry->prop);
+			if (err < 0 && err != -FDT_ERR_NOTFOUND) {
+				log_debug("Error (%d) deleting %s\n",
+					  err, purge_entry->prop);
+				goto out;
+			}
+		} else {
+			err = fdt_del_node(fdt, nodeoff);
+			if (err) {
+				log_debug("Error (%d) trying to delete node %s\n",
+					  err, purge_entry->node_path);
+				goto out;
+			}
+		}
+	}
+
+out:
+	return err;
+}
+EVENT_SPY(EVT_FT_FIXUP, dt_non_compliant_purge);
-- 
2.34.1

