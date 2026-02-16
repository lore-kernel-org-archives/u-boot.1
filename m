Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08912E83836
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 21:25:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97ECE83DEB;
	Mon, 16 Feb 2026 22:24:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67DA483DEA; Mon, 16 Feb 2026 22:23:49 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CD5983E85
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 22:23:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1vs641-000000002nK-1FKT; Mon, 16 Feb 2026 21:23:29 +0000
Date: Mon, 16 Feb 2026 21:23:25 +0000
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
Subject: [RFC PATCH 14/20] boot: bootmeth: openwrt: implement read_bootflow
 for block devices
Message-ID: <1bca052ba4cd629981ee4c7522263379a0e40ac5.1771275704.git.daniel@makrotopia.org>
References: <cover.1771275704.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1771275704.git.daniel@makrotopia.org>
X-Mailman-Approved-At: Mon, 16 Feb 2026 22:24:15 +0100
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

Implement openwrt_read_bootflow() to discover OpenWrt FIT images on
raw block device partitions.

For each partition bootstd offers, read the first block and check for
a valid FDT header via fdt_check_header(). If the header is valid the
partition likely contains a FIT image and the bootflow is marked
BOOTFLOWST_READY.

Full FIT validation, configuration resolution, and sub-image loading
are all deferred to boot() which uses image_loader — keeping the scan
path fast and avoiding large reads for embedded-data FIT images that
can be many megabytes.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 boot/bootmeth_openwrt.c | 43 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/boot/bootmeth_openwrt.c b/boot/bootmeth_openwrt.c
index 02bf543031b..08c3f98957a 100644
--- a/boot/bootmeth_openwrt.c
+++ b/boot/bootmeth_openwrt.c
@@ -16,6 +16,10 @@
 #include <image-loader.h>
 #include <malloc.h>
 #include <mapmem.h>
+#include <memalign.h>
+#include <part.h>
+#include <linux/libfdt.h>
+#include <linux/sizes.h>
 
 static int openwrt_check(struct udevice *dev, struct bootflow_iter *iter)
 {
@@ -27,7 +31,44 @@ static int openwrt_check(struct udevice *dev, struct bootflow_iter *iter)
 
 static int openwrt_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 {
-	return log_msg_ret("nyi", -ENOENT);
+	struct blk_desc *desc = dev_get_uclass_plat(bflow->blk);
+	const char *part_name = NULL;
+	struct disk_partition info;
+	void *buf;
+	int ret;
+
+	/* Get partition geometry */
+	ret = part_get_info(desc, bflow->part, &info);
+	if (ret)
+		return log_msg_ret("part", ret);
+
+	part_name = (const char *)info.name;
+
+	/* Read first block to probe for an FDT/FIT header */
+	buf = memalign(SZ_1K, desc->blksz);
+	if (!buf)
+		return log_msg_ret("mem", -ENOMEM);
+
+	ret = blk_read(bflow->blk, info.start, 1, buf);
+	if (ret != 1) {
+		free(buf);
+		return log_msg_ret("rd", -EIO);
+	}
+
+	/* Must start with a valid FDT header */
+	if (fdt_check_header(buf)) {
+		free(buf);
+		return -ENOENT;
+	}
+
+	free(buf);
+
+	/* Show the GPT partition label as Filename */
+	bflow->fname = strdup(part_name);
+
+	bflow->state = BOOTFLOWST_READY;
+
+	return 0;
 }
 
 static int openwrt_boot(struct udevice *dev, struct bootflow *bflow)
-- 
2.53.0
