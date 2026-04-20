Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B3CF588C1
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 12:54:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCD6484399;
	Mon, 20 Apr 2026 14:54:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="UpIdc1Bx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D5EE84312; Mon, 20 Apr 2026 13:37:03 +0200 (CEST)
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch
 [45.157.188.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21A5483E16
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 13:36:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fzk3Z5tZLz1BmM;
 Mon, 20 Apr 2026 13:36:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1776685017;
 bh=ABLTuTBF2D9ZidAsQVVgSuxfrLeOdnfMDSQEaf4pHYs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=UpIdc1Bxz0vkQzXdck9bLsscdd810ofda1ZLj6cfTWX7ZY6QlfAL3vC3eksczmbuy
 ORgoWx9i3EhQK34W7iy5mXIDClmHOHW8igOlnqqLZmp19jkUcts9SzTWfGonq+LnFz
 g6jqKX++TE5SNkInI27Tji+riCtX+7pYP5nRg1rXueZUsEATmlgmJ/dizd4d0Zga4C
 AVLW80r0MKCTbvq6XIHx3+DpH+pC6mWuw4pv5hxjq9qGeWw0/5EjG6mE/GTrnMjxIV
 tF3+/kr+j6oM3cEHWP34dLPBoiAiH77lrrGyl3KBr2WKMAFOXcA3iT9g4f5/KD89Ij
 TNbSkT9vKp0vw==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4fzk3Q2sGMzWJp; Mon, 20 Apr 2026 13:36:50 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 20 Apr 2026 13:36:10 +0200
Subject: [PATCH 4/6] simplify NET_LEGACY || NET_LWIP condition with NET
 condition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-net-kconfig-v1-4-9900002d8e72@cherry.de>
References: <20260420-net-kconfig-v1-0-9900002d8e72@cherry.de>
In-Reply-To: <20260420-net-kconfig-v1-0-9900002d8e72@cherry.de>
To: u-boot@lists.denx.de, uboot-stm32@st-md-mailman.stormreply.com, 
 Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Udit Kumar <u-kumar1@ti.com>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Adam Ford <aford173@gmail.com>, 
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>, 
 Matteo Lisi <matteo.lisi@engicam.com>, Tim Harvey <tharvey@gateworks.com>, 
 Mingkai Hu <mingkai.hu@nxp.com>, Pramod Kumar <pramod.kumar_1@nxp.com>, 
 Gilles Talis <gilles.talis@gmail.com>, Le Jin <le.jin@siemens.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, 
 Kongyang Liu <seashell11234455@gmail.com>, Stefan Roese <sr@denx.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, 
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marex@denx.de>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Yao Zi <me@ziyao.cc>, Fabio Estevam <festevam@gmail.com>, 
 Alice Guo <alice.guo@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Maarten Brock <Maarten.Brock@sttls.nl>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Matthias Brugger <mbrugger@suse.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Heiko Schocher <hs@nabladev.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Brian Sune <briansune@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Anshul Dalal <anshuld@ti.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ye Li <ye.li@nxp.com>, 
 Andreas Dannenberg <dannenberg@ti.com>, Chintan Vankar <c-vankar@ti.com>, 
 Martin Schwan <m.schwan@phytec.de>, Benjamin Hahn <B.Hahn@phytec.de>, 
 David Lechner <dlechner@baylibre.com>, 
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>, 
 Dmitrii Merkurev <dimorinny@google.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Robert Marko <robert.marko@sartura.hr>, Beiyan Yun <root@infi.wang>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 George Chan <gchan9527@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Benjamin ROBIN <dev@benjarobin.fr>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>, 
 Sean Edmond <seanedmond@microsoft.com>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 Shantur Rathore <i@shantur.com>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, 
 Adriano Cordova <adrianox@gmail.com>, 
 Sky Huang <SkyLake.Huang@mediatek.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
X-Mailman-Approved-At: Mon, 20 Apr 2026 14:54:20 +0200
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

From: Quentin Schulz <quentin.schulz@cherry.de>

Since the move to make NET a menuconfig and NO_NET a synonym of NET=n,
when NET is enabled, NET_LEGACY || NET_LWIP is necessarily true, so
let's simplify the various checks across the codebase.

SPL_NET_LWIP doesn't exist but SPL_NET_LEGACY is an alias for SPL_NET so
the proper symbol is still defined in SPL whenever needed.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 Makefile                                                  |  2 +-
 board/engicam/imx8mp/icore_mx8mp.c                        |  2 +-
 board/polyhex/imx8mp_debix_model_a/imx8mp_debix_model_a.c |  2 +-
 board/ti/am335x/board.c                                   |  2 +-
 board/xilinx/common/board.c                               |  3 +--
 cmd/Kconfig                                               |  4 ++--
 cmd/bdinfo.c                                              |  7 +++----
 common/Kconfig                                            |  2 +-
 common/board_r.c                                          |  4 ++--
 doc/usage/cmd/bdinfo.rst                                  |  7 +++----
 drivers/net/Kconfig                                       |  2 +-
 drivers/net/phy/Kconfig                                   |  2 +-
 drivers/usb/gadget/Kconfig                                |  2 +-
 env/flags.c                                               | 10 +++++-----
 include/env_callback.h                                    |  2 +-
 include/env_flags.h                                       |  6 +++---
 include/net-common.h                                      |  2 +-
 lib/efi_loader/Kconfig                                    |  4 ++--
 net/Makefile                                              |  2 +-
 test/cmd/bdinfo.c                                         |  6 +++---
 test/py/tests/test_efi_loader.py                          |  2 +-
 test/py/tests/test_fpga.py                                |  4 ++--
 test/py/tests/test_net.py                                 |  2 +-
 23 files changed, 39 insertions(+), 42 deletions(-)

diff --git a/Makefile b/Makefile
index 285a9e2beed..32d82c0697a 100644
--- a/Makefile
+++ b/Makefile
@@ -1081,7 +1081,7 @@ libs-$(CONFIG_OF_EMBED) += dts/
 libs-y += env/
 libs-y += lib/
 libs-y += fs/
-libs-$(filter y,$(CONFIG_NET_LEGACY) $(CONFIG_NET_LWIP)) += net/
+libs-$(CONFIG_NET) += net/
 libs-y += disk/
 libs-y += drivers/
 libs-$(CONFIG_SYS_FSL_DDR) += drivers/ddr/fsl/
diff --git a/board/engicam/imx8mp/icore_mx8mp.c b/board/engicam/imx8mp/icore_mx8mp.c
index f01da961235..547cfa3a35f 100644
--- a/board/engicam/imx8mp/icore_mx8mp.c
+++ b/board/engicam/imx8mp/icore_mx8mp.c
@@ -30,7 +30,7 @@ static void setup_fec(void)
 	setbits_le32(&gpr->gpr[1], BIT(22));
 }
 
-#if CONFIG_IS_ENABLED(NET_LEGACY) || CONFIG_IS_ENABLED(NET_LWIP)
+#if CONFIG_IS_ENABLED(NET)
 int board_phy_config(struct phy_device *phydev)
 {
 	if (phydev->drv->config)
diff --git a/board/polyhex/imx8mp_debix_model_a/imx8mp_debix_model_a.c b/board/polyhex/imx8mp_debix_model_a/imx8mp_debix_model_a.c
index cff9383bad4..23d24140ca7 100644
--- a/board/polyhex/imx8mp_debix_model_a/imx8mp_debix_model_a.c
+++ b/board/polyhex/imx8mp_debix_model_a/imx8mp_debix_model_a.c
@@ -26,7 +26,7 @@ static void setup_fec(void)
 	setbits_le32(&gpr->gpr[1], BIT(22));
 }
 
-#if CONFIG_IS_ENABLED(NET_LEGACY) || CONFIG_IS_ENABLED(NET_LWIP)
+#if CONFIG_IS_ENABLED(NET)
 int board_phy_config(struct phy_device *phydev)
 {
 	if (phydev->drv->config)
diff --git a/board/ti/am335x/board.c b/board/ti/am335x/board.c
index 4b7aa5c8586..b5f69a45a7c 100644
--- a/board/ti/am335x/board.c
+++ b/board/ti/am335x/board.c
@@ -911,7 +911,7 @@ int board_late_init(void)
 #endif
 
 /* CPSW plat */
-#if (CONFIG_IS_ENABLED(NET_LEGACY) || CONFIG_IS_ENABLED(NET_LWIP)) && \
+#if CONFIG_IS_ENABLED(NET) && \
     !CONFIG_IS_ENABLED(OF_CONTROL)
 struct cpsw_slave_data slave_data[] = {
 	{
diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index b21a1361137..89562ef77fc 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -508,8 +508,7 @@ int board_late_init_xilinx(void)
 				ret |= env_set_by_index("uuid", id, uuid);
 			}
 
-			if (!(CONFIG_IS_ENABLED(NET_LEGACY) ||
-			      CONFIG_IS_ENABLED(NET_LWIP)))
+			if (!CONFIG_IS_ENABLED(NET))
 				continue;
 
 			for (i = 0; i < EEPROM_HDR_NO_OF_MAC_ADDR; i++) {
diff --git a/cmd/Kconfig b/cmd/Kconfig
index f19a656146a..64f70b22e26 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1946,7 +1946,7 @@ config CMD_XXD
 
 endmenu
 
-if NET_LEGACY || NET_LWIP
+if NET
 
 menuconfig CMD_NET
 	bool "Network commands"
@@ -2329,7 +2329,7 @@ config CMD_PXE
 
 endif  # if CMD_NET
 
-endif # NET_LEGACY || NET_LWIP
+endif # NET
 
 menu "Misc commands"
 
diff --git a/cmd/bdinfo.c b/cmd/bdinfo.c
index 39e7bec3885..ddf77303735 100644
--- a/cmd/bdinfo.c
+++ b/cmd/bdinfo.c
@@ -152,7 +152,7 @@ static int bdinfo_print_all(struct bd_info *bd)
 	bdinfo_print_num_l("relocaddr", gd->relocaddr);
 	bdinfo_print_num_l("reloc off", gd->reloc_off);
 	printf("%-12s= %u-bit\n", "Build", (uint)sizeof(void *) * 8);
-	if (IS_ENABLED(CONFIG_NET_LEGACY) || IS_ENABLED(CONFIG_NET_LWIP))
+	if (IS_ENABLED(CONFIG_NET))
 		print_eth();
 	bdinfo_print_num_l("fdt_blob", (ulong)map_to_sysmem(gd->fdt_blob));
 	if (IS_ENABLED(CONFIG_VIDEO))
@@ -194,8 +194,7 @@ int do_bdinfo(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		case 'a':
 			return bdinfo_print_all(bd);
 		case 'e':
-			if (!IS_ENABLED(CONFIG_NET_LEGACY) &&
-			    !IS_ENABLED(CONFIG_NET_LWIP))
+			if (!IS_ENABLED(CONFIG_NET))
 				return CMD_RET_USAGE;
 			print_eth();
 			return CMD_RET_SUCCESS;
@@ -221,7 +220,7 @@ U_BOOT_CMD(
 	"  - print all Board Info structure"
 #if CONFIG_IS_ENABLED(GETOPT)
 	"\n"
-#if IS_ENABLED(CONFIG_NET_LEGACY) || IS_ENABLED(CONFIG_NET_LWIP)
+#if IS_ENABLED(CONFIG_NET)
 	"bdinfo -e\n"
 	"  - print Board Info related to network\n"
 #endif
diff --git a/common/Kconfig b/common/Kconfig
index 3c3af0e3647..8e8c733aa29 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -425,7 +425,7 @@ config LOGF_FUNC_PAD
 
 config LOG_SYSLOG
 	bool "Log output to syslog server"
-	depends on NET_LEGACY || NET_LWIP
+	depends on NET
 	help
 	  Enables a log driver which broadcasts log records via UDP port 514
 	  to syslog servers.
diff --git a/common/board_r.c b/common/board_r.c
index 37e6f51c7a7..45942910829 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -495,7 +495,7 @@ static int initr_boot_led_on(void)
 	return 0;
 }
 
-#if CONFIG_IS_ENABLED(NET_LEGACY) || CONFIG_IS_ENABLED(NET_LWIP)
+#if CONFIG_IS_ENABLED(NET)
 static int initr_net(void)
 {
 	puts("Net:   ");
@@ -756,7 +756,7 @@ static void initcall_run_r(void)
 #if CONFIG_IS_ENABLED(PCI_ENDPOINT)
 	INITCALL(pci_ep_init);
 #endif
-#if CONFIG_IS_ENABLED(NET_LEGACY) || CONFIG_IS_ENABLED(NET_LWIP)
+#if CONFIG_IS_ENABLED(NET)
 	WATCHDOG_RESET();
 	INITCALL(initr_net);
 #endif
diff --git a/doc/usage/cmd/bdinfo.rst b/doc/usage/cmd/bdinfo.rst
index 09db9101bd1..6226d14bd66 100644
--- a/doc/usage/cmd/bdinfo.rst
+++ b/doc/usage/cmd/bdinfo.rst
@@ -124,12 +124,12 @@ Build
 current eth
     name of the active network device
 
-    Only shown if CONFIG_NET_LEGACY=y or CONFIG_NET_LWIP=y.
+    Only shown if CONFIG_NET=y.
 
 IP addr
     network address, value of the environment variable *ipaddr*
 
-    Only shown if CONFIG_NET_LEGACY=y or CONFIG_NET_LWIP=y.
+    Only shown if CONFIG_NET=y.
 
 fdt_blob
     address of U-Boot's own device tree, NULL if none
@@ -173,5 +173,4 @@ The bdinfo command is available if CONFIG_CMD_BDI=y.
 
 The options to bdinfo are only available if CONFIG_GETOPT=y.
 
-The ``-e`` option is additionally only available if CONFIG_NET_LEGACY=y or
-CONFIG_NET_LWIP=y.
+The ``-e`` option is additionally only available if CONFIG_NET=y.
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index f0288387aed..666618681df 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -339,7 +339,7 @@ config ESSEDMA
 
 config ETH_SANDBOX
 	depends on SANDBOX
-	depends on NET_LEGACY || NET_LWIP
+	depends on NET
 	default y
 	bool "Sandbox: Mocked Ethernet driver"
 	help
diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 93f32aea595..0025c895f12 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -7,7 +7,7 @@ config MV88E6352_SWITCH
 
 menuconfig PHYLIB
 	bool "Ethernet PHY (physical media interface) support"
-	depends on NET_LEGACY || NET_LWIP
+	depends on NET
 	help
 	  Enable Ethernet PHY (physical media interface) support.
 
diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index d4ffc24c063..18582962249 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -232,7 +232,7 @@ endif # USB_GADGET_DOWNLOAD
 
 config USB_ETHER
 	bool "USB Ethernet Gadget"
-	depends on NET_LEGACY || NET_LWIP
+	depends on NET
 	default y if ARCH_SUNXI && USB_MUSB_GADGET
 	help
 	  Creates an Ethernet network device through a USB peripheral
diff --git a/env/flags.c b/env/flags.c
index 45eb9820d9f..f1966bc91b4 100644
--- a/env/flags.c
+++ b/env/flags.c
@@ -22,7 +22,7 @@
 #include <env_internal.h>
 #endif
 
-#if CONFIG_IS_ENABLED(NET_LEGACY) || CONFIG_IS_ENABLED(NET_LWIP)
+#if CONFIG_IS_ENABLED(NET)
 #define ENV_FLAGS_NET_VARTYPE_REPS "im"
 #else
 #define ENV_FLAGS_NET_VARTYPE_REPS ""
@@ -57,7 +57,7 @@ static const char * const env_flags_vartype_names[] = {
 	"decimal",
 	"hexadecimal",
 	"boolean",
-#if CONFIG_IS_ENABLED(NET_LEGACY) || CONFIG_IS_ENABLED(NET_LWIP)
+#if CONFIG_IS_ENABLED(NET)
 	"IP address",
 	"MAC address",
 #endif
@@ -211,7 +211,7 @@ static void skip_num(int hex, const char *value, const char **end,
 		*end = value;
 }
 
-#if CONFIG_IS_ENABLED(NET_LEGACY) || CONFIG_IS_ENABLED(NET_LWIP)
+#if CONFIG_IS_ENABLED(NET)
 int eth_validate_ethaddr_str(const char *addr)
 {
 	const char *end;
@@ -244,7 +244,7 @@ static int _env_flags_validate_type(const char *value,
 	enum env_flags_vartype type)
 {
 	const char *end;
-#if CONFIG_IS_ENABLED(NET_LEGACY) || CONFIG_IS_ENABLED(NET_LWIP)
+#if CONFIG_IS_ENABLED(NET)
 	const char *cur;
 	int i;
 #endif
@@ -273,7 +273,7 @@ static int _env_flags_validate_type(const char *value,
 		if (value[1] != '\0')
 			return -1;
 		break;
-#if CONFIG_IS_ENABLED(NET_LEGACY) || CONFIG_IS_ENABLED(NET_LWIP)
+#if CONFIG_IS_ENABLED(NET)
 	case env_flags_vartype_ipaddr:
 		cur = value;
 		for (i = 0; i < 4; i++) {
diff --git a/include/env_callback.h b/include/env_callback.h
index f7bb23df569..1181ab4a157 100644
--- a/include/env_callback.h
+++ b/include/env_callback.h
@@ -32,7 +32,7 @@
 #define DNS_CALLBACK
 #endif
 
-#if CONFIG_IS_ENABLED(NET_LEGACY) || CONFIG_IS_ENABLED(NET_LWIP)
+#if CONFIG_IS_ENABLED(NET)
 #define NET_CALLBACKS \
 	"bootfile:bootfile," \
 	"ipaddr:ipaddr," \
diff --git a/include/env_flags.h b/include/env_flags.h
index 85721a89cfb..123fdbcb0ba 100644
--- a/include/env_flags.h
+++ b/include/env_flags.h
@@ -14,7 +14,7 @@ enum env_flags_vartype {
 	env_flags_vartype_decimal,
 	env_flags_vartype_hex,
 	env_flags_vartype_bool,
-#if CONFIG_IS_ENABLED(NET_LEGACY) || CONFIG_IS_ENABLED(NET_LWIP)
+#if CONFIG_IS_ENABLED(NET)
 	env_flags_vartype_ipaddr,
 	env_flags_vartype_macaddr,
 #endif
@@ -41,7 +41,7 @@ enum env_flags_varaccess {
 #define CFG_ENV_FLAGS_LIST_STATIC ""
 #endif
 
-#if CONFIG_IS_ENABLED(NET_LEGACY) || CONFIG_IS_ENABLED(NET_LWIP)
+#if CONFIG_IS_ENABLED(NET)
 #ifdef CONFIG_REGEX
 #define ETHADDR_WILDCARD "\\d*"
 #else
@@ -123,7 +123,7 @@ enum env_flags_varaccess env_flags_parse_varaccess(const char *flags);
  */
 enum env_flags_varaccess env_flags_parse_varaccess_from_binflags(int binflags);
 
-#if CONFIG_IS_ENABLED(NET_LEGACY) || CONFIG_IS_ENABLED(NET_LWIP)
+#if CONFIG_IS_ENABLED(NET)
 /*
  * Check if a string has the format of an Ethernet MAC address
  */
diff --git a/include/net-common.h b/include/net-common.h
index 0cbdf344664..69b6316c1ec 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -235,7 +235,7 @@ int eth_rx(void);			/* Check for received packets */
  */
 void reset_phy(void);
 
-#if CONFIG_IS_ENABLED(NET_LEGACY) || CONFIG_IS_ENABLED(NET_LWIP)
+#if CONFIG_IS_ENABLED(NET)
 /**
  * eth_set_enable_bootdevs() - Enable or disable binding of Ethernet bootdevs
  *
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 495a85fa869..3279fc88354 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -517,7 +517,7 @@ config EFI_RISCV_BOOT_PROTOCOL
 config EFI_IP4_CONFIG2_PROTOCOL
 	bool "EFI_IP4_CONFIG2_PROTOCOL support"
 	default y if ARCH_QEMU || SANDBOX
-	depends on NET_LEGACY || NET_LWIP
+	depends on NET
 	help
 	  Provides an implementation of the EFI_IP4_CONFIG2_PROTOCOL, this
 	  protocol can be used to set and get the current ip address and
@@ -599,7 +599,7 @@ config EFI_BOOTMGR
 
 config EFI_HTTP_BOOT
 	bool "EFI HTTP Boot support"
-	depends on NET_LEGACY || NET_LWIP
+	depends on NET
 	select CMD_NET
 	select CMD_DHCP
 	select CMD_DNS
diff --git a/net/Makefile b/net/Makefile
index a9323ceb40b..ceac6de6377 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -37,7 +37,7 @@ CFLAGS_eth_common.o += -Wno-format-extra-args
 
 endif
 
-ifeq ($(filter y,$(CONFIG_NET_LEGACY) $(CONFIG_NET_LWIP)),y)
+ifeq ($(CONFIG_NET),y)
 obj-$(CONFIG_DM_DSA)   += dsa-uclass.o
 obj-$(CONFIG_$(PHASE_)DM_ETH) += eth-uclass.o
 obj-$(CONFIG_$(PHASE_)BOOTDEV_ETH) += eth_bootdev.o
diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index 3233a0a6a51..7f4f1868c6a 100644
--- a/test/cmd/bdinfo.c
+++ b/test/cmd/bdinfo.c
@@ -172,7 +172,7 @@ static int bdinfo_test_all(struct unit_test_state *uts)
 	ut_assertok(test_num_l(uts, "reloc off", gd->reloc_off));
 	ut_assert_nextline("%-12s= %u-bit", "Build", (uint)sizeof(void *) * 8);
 
-	if (IS_ENABLED(CONFIG_NET_LEGACY) || IS_ENABLED(CONFIG_NET_LWIP))
+	if (IS_ENABLED(CONFIG_NET))
 		ut_assertok(test_eth(uts));
 
 	/*
@@ -314,7 +314,7 @@ static int bdinfo_test_help(struct unit_test_state *uts)
 			ut_assert_nextlinen("bdinfo -a");
 		ut_assert_nextlinen("  - print all Board Info structure");
 		if (CONFIG_IS_ENABLED(GETOPT)) {
-			if (IS_ENABLED(CONFIG_NET_LEGACY) || IS_ENABLED(CONFIG_NET_LWIP)) {
+			if (IS_ENABLED(CONFIG_NET)) {
 				ut_assert_nextlinen("bdinfo -e");
 				ut_assert_nextlinen("  - print Board Info related to network");
 			}
@@ -348,7 +348,7 @@ static int bdinfo_test_eth(struct unit_test_state *uts)
 	ut_assertok(run_commandf("bdinfo -e"));
 	if (!CONFIG_IS_ENABLED(GETOPT))
 		ut_assertok(bdinfo_test_all(uts));
-	else if (IS_ENABLED(CONFIG_NET_LEGACY) || IS_ENABLED(CONFIG_NET_LWIP))
+	else if (IS_ENABLED(CONFIG_NET))
 		ut_assertok(test_eth(uts));
 	ut_assert_console_end();
 
diff --git a/test/py/tests/test_efi_loader.py b/test/py/tests/test_efi_loader.py
index fc45209a581..91f151d09cd 100644
--- a/test/py/tests/test_efi_loader.py
+++ b/test/py/tests/test_efi_loader.py
@@ -98,7 +98,7 @@ def test_efi_setup_dhcp(ubman):
     global net_set_up
     net_set_up = True
 
-@pytest.mark.buildconfigspec('net_legacy', 'net_lwip')
+@pytest.mark.buildconfigspec('net')
 def test_efi_setup_static(ubman):
     """Set up the network using a static IP configuration.
 
diff --git a/test/py/tests/test_fpga.py b/test/py/tests/test_fpga.py
index 0ab47c0bde5..74cd42b910e 100644
--- a/test/py/tests/test_fpga.py
+++ b/test/py/tests/test_fpga.py
@@ -506,7 +506,7 @@ def test_fpga_loadfs(ubman):
 @pytest.mark.buildconfigspec('cmd_fpga_load_secure')
 @pytest.mark.buildconfigspec('cmd_net')
 @pytest.mark.buildconfigspec('cmd_dhcp')
-@pytest.mark.buildconfigspec('net_legacy', 'net_lwip')
+@pytest.mark.buildconfigspec('net')
 def test_fpga_secure_bit_auth(ubman):
 
     test_net.test_net_dhcp(ubman)
@@ -534,7 +534,7 @@ def test_fpga_secure_bit_auth(ubman):
 @pytest.mark.buildconfigspec('cmd_fpga_load_secure')
 @pytest.mark.buildconfigspec('cmd_net')
 @pytest.mark.buildconfigspec('cmd_dhcp')
-@pytest.mark.buildconfigspec('net_legacy', 'net_lwip')
+@pytest.mark.buildconfigspec('net')
 def test_fpga_secure_bit_img_auth_kup(ubman):
 
     test_net.test_net_dhcp(ubman)
diff --git a/test/py/tests/test_net.py b/test/py/tests/test_net.py
index 4f899530060..27cdd73fd49 100644
--- a/test/py/tests/test_net.py
+++ b/test/py/tests/test_net.py
@@ -201,7 +201,7 @@ def test_net_dhcp6(ubman):
     global net6_set_up
     net6_set_up = True
 
-@pytest.mark.buildconfigspec('net_legacy', 'net_lwip')
+@pytest.mark.buildconfigspec('net')
 def test_net_setup_static(ubman):
     """Set up a static IP configuration.
 

-- 
2.53.0

