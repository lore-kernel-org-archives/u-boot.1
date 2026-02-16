Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B17E83836
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 21:25:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D46A783E88;
	Mon, 16 Feb 2026 22:24:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC0DB83DC9; Mon, 16 Feb 2026 22:23:54 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E108F83B8A
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 22:23:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1vs648-000000002nn-1S0W; Mon, 16 Feb 2026 21:23:36 +0000
Date: Mon, 16 Feb 2026 21:23:32 +0000
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
Subject: [RFC PATCH 15/20] boot: bootmeth: openwrt: implement boot via bootm
 storage path
Message-ID: <92b77e44c1fb34f0433fb75f8404f357ed28b03e.1771275704.git.daniel@makrotopia.org>
References: <cover.1771275704.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Implement openwrt_boot() to boot a discovered OpenWrt FIT image:

1. Get the block interface name via blk_get_devtype() and construct
   the dev_part_str (e.g. "0:3") from the block descriptor and
   bootflow partition number
2. Initialise an image_loader for block devices via
   image_loader_init_blk(), with alloc_ptr set to image_load_addr
3. Optionally read the 'bootconf' env variable and pass it as
   '#config' in bmi.addr_img for FIT configuration selection
4. Call bootm_run() which runs the full bootm state machine:
   START -> FINDOS -> FINDOTHER -> LOADOS -> OS_PREP -> OS_GO

The image_loader handles on-demand reading of the FIT metadata and
sub-images (kernel, FDT) directly from the raw partition. The
existing cleanup call in bootm_run_states() releases the loader just
before OS_GO. If bootm_run() returns (boot failure), cleanup is
called explicitly.

This completes the core block-device boot path for bootmeth_openwrt.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 boot/bootmeth_openwrt.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/boot/bootmeth_openwrt.c b/boot/bootmeth_openwrt.c
index 08c3f98957a..82f39c17d7f 100644
--- a/boot/bootmeth_openwrt.c
+++ b/boot/bootmeth_openwrt.c
@@ -13,6 +13,8 @@
 #include <bootm.h>
 #include <bootmeth.h>
 #include <dm.h>
+#include <env.h>
+#include <image.h>
 #include <image-loader.h>
 #include <malloc.h>
 #include <mapmem.h>
@@ -73,7 +75,40 @@ static int openwrt_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 
 static int openwrt_boot(struct udevice *dev, struct bootflow *bflow)
 {
-	return log_msg_ret("nyi", -ENOSYS);
+	struct blk_desc *desc = dev_get_uclass_plat(bflow->blk);
+	const char *ifname = blk_get_devtype(bflow->blk);
+	struct image_loader ldr = {};
+	struct bootm_info bmi;
+	char dev_part_str[32];
+	char addr_img[64];
+	const char *conf;
+	int ret;
+
+	snprintf(dev_part_str, sizeof(dev_part_str), "%d:%d",
+		 desc->devnum, bflow->part);
+
+	ret = image_loader_init_blk(&ldr, ifname, dev_part_str);
+	if (ret)
+		return log_msg_ret("ldr", ret);
+
+	ldr.alloc_ptr = image_load_addr;
+
+	bootm_init(&bmi);
+	bmi.loader = &ldr;
+
+	/* FIT config selection via #conf suffix */
+	conf = env_get("bootconf");
+	if (conf) {
+		snprintf(addr_img, sizeof(addr_img), "#%s", conf);
+		bmi.addr_img = addr_img;
+	}
+
+	ret = bootm_run(&bmi);
+
+	/* Clean up if bootm_run() returned (i.e. boot failed) */
+	image_loader_cleanup(&ldr);
+
+	return log_msg_ret("run", ret);
 }
 
 static int openwrt_bootmeth_bind(struct udevice *dev)
-- 
2.53.0
