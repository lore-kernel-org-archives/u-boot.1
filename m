Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD48E83836
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 21:26:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77AE783F00;
	Mon, 16 Feb 2026 22:25:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F19DA83E8E; Mon, 16 Feb 2026 22:24:49 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 050A083CB9
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 22:24:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1vs653-000000002rV-1Gh8; Mon, 16 Feb 2026 21:24:33 +0000
Date: Mon, 16 Feb 2026 21:24:29 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Daniel Golle <daniel@makrotopia.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 =?utf-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 David Lechner <dlechner@baylibre.com>,
 Osama Abdelkader <osama.abdelkader@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, u-boot@lists.denx.de
Cc: John Crispin <john@phrozen.org>, Paul Spooren <mail@aparcar.org>
Subject: [RFC PATCH 20/20] boot: bootmeth: openwrt: add slot configuration
 from environment
Message-ID: <db31f5b213b57b802c5db7309941b5fab94dec2c.1771275704.git.daniel@makrotopia.org>
References: <cover.1771275704.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1771275704.git.daniel@makrotopia.org>
X-Mailman-Approved-At: Mon, 16 Feb 2026 22:25:02 +0100
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

Add configurable multi-slot boot with slot names and boot order
defined via environment variables. This enables production/recovery
dual-boot (or any number of named slots).

New environment variables:

- openwrt_slot_<name>=<location> -- defines a named slot. <name> is
  an arbitrary label (e.g. "production", "recovery"). <location> is
  a GPT partition label, MTD partition name, or UBI volume name.

- openwrt_boot_order=<name1> <name2> ... -- space-separated list of
  slot names that are eligible for booting. Only partitions/volumes
  whose name matches a configured slot's location are probed.

Without openwrt_boot_order, all partitions/volumes are probed
(backward-compatible with the Milestone 1/2 behavior). When set,
only partitions matching a defined slot pass the filter.

The matched slot name is stored in bflow->os_name for later use by
boot-loop avoidance (Milestone 4) and boot menu display.

The MTD and UBI bootdevs now delegate to bootmeth_read_bootflow()
instead of setting BOOTFLOWST_READY directly, so that slot filtering
is applied uniformly across all storage backends.

Example configuration:

  openwrt_slot_production=firmware
  openwrt_slot_recovery=recovery
  openwrt_boot_order=production recovery

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 boot/bootmeth_openwrt.c | 130 ++++++++++++++++++++++++++++++++--------
 1 file changed, 104 insertions(+), 26 deletions(-)

diff --git a/boot/bootmeth_openwrt.c b/boot/bootmeth_openwrt.c
index d448697fe08..6e90a203ed6 100644
--- a/boot/bootmeth_openwrt.c
+++ b/boot/bootmeth_openwrt.c
@@ -24,6 +24,63 @@
 #include <linux/libfdt.h>
 #include <linux/sizes.h>
 
+/**
+ * openwrt_match_slot() - check if a partition name matches a configured slot
+ * @part_name: GPT label, MTD partition name, or UBI volume name
+ * @slot_namep: set to strdup'd slot name on match (caller must free)
+ *
+ * When ``openwrt_boot_order`` is set in the environment, only partitions
+ * whose name matches one of the ``openwrt_slot_<name>`` locations are
+ * accepted. Without ``openwrt_boot_order``, all partitions pass.
+ *
+ * Return: 0 if accepted, -ENOENT if filtered out
+ */
+static int openwrt_match_slot(const char *part_name, char **slot_namep)
+{
+	const char *order, *p;
+
+	*slot_namep = NULL;
+
+	order = env_get("openwrt_boot_order");
+	if (!order)
+		return 0;
+
+	if (!part_name)
+		return -ENOENT;
+
+	p = order;
+	while (*p) {
+		char name[64], var[80];
+		const char *location, *end;
+		int len;
+
+		while (*p == ' ')
+			p++;
+		if (!*p)
+			break;
+
+		end = p;
+		while (*end && *end != ' ')
+			end++;
+
+		len = end - p;
+		if (len >= sizeof(name))
+			len = sizeof(name) - 1;
+		memcpy(name, p, len);
+		name[len] = '\0';
+		p = end;
+
+		snprintf(var, sizeof(var), "openwrt_slot_%s", name);
+		location = env_get(var);
+		if (location && !strcmp(part_name, location)) {
+			*slot_namep = strdup(name);
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
+
 static int openwrt_check(struct udevice *dev, struct bootflow_iter *iter)
 {
 	if (bootflow_iter_check_blk(iter))
@@ -34,40 +91,61 @@ static int openwrt_check(struct udevice *dev, struct bootflow_iter *iter)
 
 static int openwrt_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 {
-	struct blk_desc *desc = dev_get_uclass_plat(bflow->blk);
 	const char *part_name = NULL;
-	struct disk_partition info;
-	void *buf;
+	char *slot_name = NULL;
 	int ret;
 
-	/* Get partition geometry */
-	ret = part_get_info(desc, bflow->part, &info);
-	if (ret)
-		return log_msg_ret("part", ret);
-
-	part_name = (const char *)info.name;
-
-	/* Read first block to probe for an FDT/FIT header */
-	buf = memalign(SZ_1K, desc->blksz);
-	if (!buf)
-		return log_msg_ret("mem", -ENOMEM);
+	if (bflow->blk) {
+		struct blk_desc *desc = dev_get_uclass_plat(bflow->blk);
+		struct disk_partition info;
+		void *buf;
+
+		ret = part_get_info(desc, bflow->part, &info);
+		if (ret)
+			return log_msg_ret("part", ret);
+
+		part_name = (const char *)info.name;
+
+		/* Check slot filter before expensive I/O */
+		ret = openwrt_match_slot(part_name, &slot_name);
+		if (ret)
+			return -ENOENT;
+
+		/* Read first block to probe for an FDT/FIT header */
+		buf = memalign(SZ_1K, desc->blksz);
+		if (!buf) {
+			free(slot_name);
+			return log_msg_ret("mem", -ENOMEM);
+		}
+
+		ret = blk_read(bflow->blk, info.start, 1, buf);
+		if (ret != 1) {
+			free(buf);
+			free(slot_name);
+			return log_msg_ret("rd", -EIO);
+		}
+
+		if (fdt_check_header(buf)) {
+			free(buf);
+			free(slot_name);
+			return -ENOENT;
+		}
 
-	ret = blk_read(bflow->blk, info.start, 1, buf);
-	if (ret != 1) {
 		free(buf);
-		return log_msg_ret("rd", -EIO);
-	}
 
-	/* Must start with a valid FDT header */
-	if (fdt_check_header(buf)) {
-		free(buf);
-		return -ENOENT;
-	}
+		/* Show the GPT partition label as Filename */
+		bflow->fname = strdup(part_name);
+	} else {
+		/* MTD or UBI — partition/volume name in bootmeth_priv */
+		part_name = bflow->bootmeth_priv;
 
-	free(buf);
+		ret = openwrt_match_slot(part_name, &slot_name);
+		if (ret)
+			return -ENOENT;
+	}
 
-	/* Show the GPT partition label as Filename */
-	bflow->fname = strdup(part_name);
+	if (slot_name)
+		bflow->os_name = slot_name;
 
 	bflow->state = BOOTFLOWST_READY;
 
-- 
2.53.0
