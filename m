Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B14E83836
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 21:26:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3EB083E85;
	Mon, 16 Feb 2026 22:25:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C94F083CB9; Mon, 16 Feb 2026 22:24:34 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5BB783B8A
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 22:24:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1vs64m-000000002qL-3v7M; Mon, 16 Feb 2026 21:24:17 +0000
Date: Mon, 16 Feb 2026 21:24:13 +0000
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
Subject: [RFC PATCH 18/20] boot: bootmeth: openwrt: support MTD and UBI
 bootdevs
Message-ID: <3c7d569e09075992921c6d627c91934665a637d1.1771275704.git.daniel@makrotopia.org>
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

Extend bootmeth_openwrt's boot() to handle all three storage backends:

- Block devices: detected via bflow->blk, uses image_loader_init_blk()
  (existing path, refactored into openwrt_boot_blk() helper)
- UBI volumes: detected by checking the bootdev driver name
  ("ubi_bootdev"), uses image_loader_init_ubi() with the volume name
  from bflow->bootmeth_priv
- MTD partitions: fallback for non-block bootflows with a priv string,
  uses image_loader_init_mtd() with the partition name

The check() function does not need changes: bootflow_iter_check_blk()
already accepts non-network bootdevs including UCLASS_MTD parents.

The rest of boot() remains identical across backends — bootm_init(),
optional bootconf config selection, bootm_run(), cleanup on error.
Each backend path is guarded by IS_ENABLED(CONFIG_BOOTDEV_*) to
avoid link errors when not configured.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 boot/bootmeth_openwrt.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/boot/bootmeth_openwrt.c b/boot/bootmeth_openwrt.c
index 82f39c17d7f..e1f47b58f61 100644
--- a/boot/bootmeth_openwrt.c
+++ b/boot/bootmeth_openwrt.c
@@ -73,21 +73,38 @@ static int openwrt_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 	return 0;
 }
 
-static int openwrt_boot(struct udevice *dev, struct bootflow *bflow)
+static int openwrt_boot_blk(struct bootflow *bflow,
+			    struct image_loader *ldr)
 {
 	struct blk_desc *desc = dev_get_uclass_plat(bflow->blk);
 	const char *ifname = blk_get_devtype(bflow->blk);
+	char dev_part_str[32];
+
+	snprintf(dev_part_str, sizeof(dev_part_str), "%d:%d",
+		 desc->devnum, bflow->part);
+
+	return image_loader_init_blk(ldr, ifname, dev_part_str);
+}
+
+static int openwrt_boot(struct udevice *dev, struct bootflow *bflow)
+{
 	struct image_loader ldr = {};
 	struct bootm_info bmi;
-	char dev_part_str[32];
 	char addr_img[64];
 	const char *conf;
 	int ret;
 
-	snprintf(dev_part_str, sizeof(dev_part_str), "%d:%d",
-		 desc->devnum, bflow->part);
-
-	ret = image_loader_init_blk(&ldr, ifname, dev_part_str);
+	if (bflow->blk) {
+		ret = openwrt_boot_blk(bflow, &ldr);
+	} else if (IS_ENABLED(CONFIG_BOOTDEV_UBI) &&
+		   !strcmp(bflow->dev->driver->name, "ubi_bootdev")) {
+		ret = image_loader_init_ubi(&ldr, bflow->bootmeth_priv);
+	} else if (IS_ENABLED(CONFIG_BOOTDEV_MTD) &&
+		   bflow->bootmeth_priv) {
+		ret = image_loader_init_mtd(&ldr, bflow->bootmeth_priv);
+	} else {
+		return log_msg_ret("typ", -ENODEV);
+	}
 	if (ret)
 		return log_msg_ret("ldr", ret);
 
-- 
2.53.0
