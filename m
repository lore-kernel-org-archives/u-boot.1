Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F0EE83837
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 21:26:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3744C83EE2;
	Mon, 16 Feb 2026 22:25:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46FED83D5D; Mon, 16 Feb 2026 22:24:43 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66D7283B8A
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 22:24:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1vs64u-000000002qu-23IR; Mon, 16 Feb 2026 21:24:24 +0000
Date: Mon, 16 Feb 2026 21:24:20 +0000
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
Subject: [RFC PATCH 19/20] boot: bootmeth: openwrt: add openwrt_boot_script
 hook for bootconf
Message-ID: <7f98de4d33c063072fff8e20af5a31a41cab7130.1771275704.git.daniel@makrotopia.org>
References: <cover.1771275704.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Some boards need to probe hardware at boot time to determine the
correct FIT configuration. For example, the BPi-R3 checks whether
SPI-NAND or SPI-NOR is present and selects the matching FIT config
overlay accordingly.

Add an optional script hook: if the environment variable
openwrt_boot_script is set, its content is executed as a U-Boot
command string right before bootconf is read. This lets board
configurations assemble the correct bootconf value dynamically:

  setenv openwrt_boot_script 'if nand info; then
    setenv bootconf $bootconf_base#$bootconf_emmc#$bootconf_nand;
  else
    setenv bootconf $bootconf_base#$bootconf_emmc#$bootconf_nor;
  fi'

The hook runs once per boot attempt, after the image loader is set up
but before bootm_run() is called.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 boot/bootmeth_openwrt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/boot/bootmeth_openwrt.c b/boot/bootmeth_openwrt.c
index e1f47b58f61..d448697fe08 100644
--- a/boot/bootmeth_openwrt.c
+++ b/boot/bootmeth_openwrt.c
@@ -12,6 +12,7 @@
 #include <bootflow.h>
 #include <bootm.h>
 #include <bootmeth.h>
+#include <command.h>
 #include <dm.h>
 #include <env.h>
 #include <image.h>
@@ -113,6 +114,17 @@ static int openwrt_boot(struct udevice *dev, struct bootflow *bflow)
 	bootm_init(&bmi);
 	bmi.loader = &ldr;
 
+	/*
+	 * Optional script hook: run the command in openwrt_boot_script
+	 * before reading bootconf. Boards use this to probe hardware
+	 * and assemble the correct FIT configuration string, e.g.:
+	 *
+	 *   setenv openwrt_boot_script 'if nand info; then ...'
+	 */
+	conf = env_get("openwrt_boot_script");
+	if (conf)
+		run_command(conf, 0);
+
 	/* FIT config selection via #conf suffix */
 	conf = env_get("bootconf");
 	if (conf) {
-- 
2.53.0
