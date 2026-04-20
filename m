Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABDB3F588C5
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 12:54:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CEA384383;
	Mon, 20 Apr 2026 14:54:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="JSUUqbqK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D85E784314; Mon, 20 Apr 2026 13:36:53 +0200 (CEST)
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::bc09])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C00CA83E16
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 13:36:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fzk3R3cChz1C3v;
 Mon, 20 Apr 2026 13:36:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1776685009;
 bh=sMhlt6JOPSP6rQAmuvvk6YnnTwj4XeAR93xEmHCzgbQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=JSUUqbqKlAjLt0VBKPOWblqvm1FsLrzkiXgBCbR8/F1AcrA0DvuyoxYez2bma+cKa
 uDPXD6DYMr5X8rK/bIkQG7D6mQjY8+XYN+VLSU3s2853NC6aYF7DuB8Tao9D1CHHZ6
 PYTDmGnjuzx/VteIi6OgWOjMSUO4/2SgCbX73NXgKK1DseLO2vu+Hf6u3oirBt2hnh
 4t2ARN91McAm/nC6Cpq6CvHgg+diFRBFAMDr14iYaIbHkXGtkdKW/neaPETXsVbinA
 4A3yuXeB9urL0t5KczxhRlDvf/B2gUJIVUIyPhmYdT3zMnnWfe4D+JYq5/IZ0y1VYz
 KIt2FbDJ0pBog==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4fzk3H1ZdLzVpn; Mon, 20 Apr 2026 13:36:43 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 20 Apr 2026 13:36:09 +0200
Subject: [PATCH 3/6] net: make NET a menuconfig (and downgrade NO_NET to a
 simple config)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-net-kconfig-v1-3-9900002d8e72@cherry.de>
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

This will allow a bunch of simplifications across the code base.
Disabling NET is the equivalent of today's NO_NET choice. This means
that if NET is enabled, either the legacy or lwIP stack is necessarily
selected, which allows us to simplify if NET_LEGACY || NET_LWIP into
if NET in a later commit.

Config fragments - or defconfigs including other defconfigs - setting
the network stack (NET_LEGACY or NET_LWIP) must also set NET (or unset
NO_NET) if the config they apply to - or the included defconfigs -
unsets NET (or selects NO_NET) as otherwise the NET_LEGACY and NET_LWIP
symbols are unreachable. This is the case for the two defconfig modified
in this commit.

NO_NET is now a convenience symbol which hides NET entirely to avoid
modifying many defconfigs. If one selected NO_NET to disable the
networking stack in the past, this will still work for now. Technically,
we should be using the "transitional" Kconfig attribute but that is only
available since Kconfig from Linux kernel v6.18 and we're on 6.1 right
now.

Note that this moves CONFIG_SYS_RX_ETH_BUFFER from under the Network
menu back into the main menu as it seems like it needs to be defined
even when there's no need for NET support at all and menuconfig option
doesn't work the same way as a menu.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---

I'd say we should have everything net-related depends on NET as well,
so that disabling networking support with NET=n is also disabling
anything related (e.g. Ethernet controller and PHY drivers, USB
Ethernet, USB gadget CDC/RNDIS, network CLI commands, etc.).
---
 configs/am62px_evm_r5_ethboot_defconfig |  2 +-
 configs/j722s_evm_r5_ethboot_defconfig  |  2 +-
 net/Kconfig                             | 23 ++++++++++++-----------
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/configs/am62px_evm_r5_ethboot_defconfig b/configs/am62px_evm_r5_ethboot_defconfig
index 8baec9d43ff..df49324b25a 100644
--- a/configs/am62px_evm_r5_ethboot_defconfig
+++ b/configs/am62px_evm_r5_ethboot_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_K3=y
 CONFIG_SOC_K3_AM62P5=y
 CONFIG_TARGET_AM62P5_R5_EVM=y
 CONFIG_DEFAULT_DEVICE_TREE="k3-am62p5-r5-sk"
-CONFIG_NET_LEGACY=y
+# CONFIG_NO_NET is not set
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_DMA=y
 CONFIG_SPL_ENV_SUPPORT=y
diff --git a/configs/j722s_evm_r5_ethboot_defconfig b/configs/j722s_evm_r5_ethboot_defconfig
index e4682edb455..cc71f913d3c 100644
--- a/configs/j722s_evm_r5_ethboot_defconfig
+++ b/configs/j722s_evm_r5_ethboot_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_K3=y
 CONFIG_SOC_K3_J722S=y
 CONFIG_TARGET_J722S_R5_EVM=y
 CONFIG_DEFAULT_DEVICE_TREE="k3-j722s-r5-evm"
-CONFIG_NET_LEGACY=y
+# CONFIG_NO_NET is not set
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_DMA=y
diff --git a/net/Kconfig b/net/Kconfig
index 89d949b5f2c..e712a0dd2ac 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -2,17 +2,22 @@
 # Network configuration
 #
 
-menu "Networking"
+config NO_NET
+	bool "Disable networking"
+	help
+	  Transitional variable. Equivalent to setting NET=n.
+
+menuconfig NET
+	bool "Networking"
+	depends on !NO_NET
+	default y
+
+if NET
 
 choice
 	prompt "Networking stack"
 	default NET_LEGACY
 
-config NO_NET
-	bool "No networking support"
-	help
-	  Do not include networking support
-
 config NET_LEGACY
 	bool "Legacy U-Boot networking stack"
 	select NETDEVICES
@@ -231,8 +236,6 @@ endif   # if NET_LEGACY
 
 source "net/lwip/Kconfig"
 
-if NET_LEGACY || NET_LWIP
-
 config BOOTDEV_ETH
 	bool "Enable bootdev for ethernet"
 	depends on BOOTSTD
@@ -276,7 +279,7 @@ config TFTP_BLOCKSIZE
 	  almost-MTU block sizes.
 	  You can also activate CONFIG_IP_DEFRAG to set a larger block.
 
-endif   # if NET_LEGACY || NET_LWIP
+endif   # if NET
 
 config SYS_RX_ETH_BUFFER
         int "Number of receive packet buffers"
@@ -286,5 +289,3 @@ config SYS_RX_ETH_BUFFER
           controllers it is recommended to set this value to 8 or even higher,
           since all buffers can be full shortly after enabling the interface on
           high Ethernet traffic.
-
-endmenu

-- 
2.53.0

