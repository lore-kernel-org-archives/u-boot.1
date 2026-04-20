Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD53F588C2
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 12:54:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B93284370;
	Mon, 20 Apr 2026 14:54:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="XGYICb7Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E7A784314; Mon, 20 Apr 2026 13:36:40 +0200 (CEST)
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch
 [84.16.66.169])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A486783E16
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 13:36:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fzk392Nhwz1BrZ;
 Mon, 20 Apr 2026 13:36:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1776684995;
 bh=XOaq3V2QtWqfkDQYc5Xbo6GALEmFHcPFK3Z8CmBBtNo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=XGYICb7QMVw+jzOK8bJaLT9sRyBg7GCxL5LJmz2/QiHBdUv2iy1pXEnMogpZQFmfg
 YQK5+t2yQuw7ayi2VL4JfHm/R2wNtEZ7bsC7aQBx379vkGPk0yy3YS9RD37gUbujIP
 4sdn4Lg/pz16PElLPKNmTfCgqQ0kyyHfOKdmH6V9I1OpPgVHP/cVPRYMOPto+RI0Cr
 v5mjqp0IXeDKcdKbxfYJ6TcYk7TngAAiv7wA/VcFWS5uCNSw0qDqzGDSa0HOSnL+Ys
 fq2WymRVyX/8pGCpjEpuVMZKE84V82Ff5wqVAZifLhtEnmyB3YCH1WQmCNjJcARZa8
 YusPBIxWjCPHw==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4fzk310VDczVHb; Mon, 20 Apr 2026 13:36:28 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 20 Apr 2026 13:36:07 +0200
Subject: [PATCH 1/6] move networking menu in net/Kconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-net-kconfig-v1-1-9900002d8e72@cherry.de>
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

In the main Kconfig, there are only two more menus, General Setup and
Expert, in addition to the net menu. Since the part in the main Kconfig
is mostly about selecting the network stack (legacy or lwIP), and that
we already have a net/Kconfig, let's move those to net/Kconfig to have
everything in the same place.

No intended change in behavior.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 Kconfig     | 34 ----------------------------------
 net/Kconfig | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/Kconfig b/Kconfig
index 7f00e76ba78..1fa31a4f5a8 100644
--- a/Kconfig
+++ b/Kconfig
@@ -791,42 +791,8 @@ source "dts/Kconfig"
 
 source "env/Kconfig"
 
-menu "Networking"
-
-choice
-	prompt "Networking stack"
-	default NET
-
-config NO_NET
-	bool "No networking support"
-	help
-	  Do not include networking support
-
-config NET
-	bool "Legacy U-Boot networking stack"
-	select NETDEVICES
-	help
-	  Include networking support with U-Boot's internal implementation of
-	  the TCP/IP protocol stack.
-
-config NET_LWIP
-	bool "Use lwIP for networking stack"
-	select NETDEVICES
-	help
-	  Include networking support based on the lwIP (lightweight IP)
-	  TCP/IP stack (https://nongnu.org/lwip). This is a replacement for
-	  the default U-Boot network stack and applications located in net/
-	  and enabled via CONFIG_NET as well as other pieces of code that
-	  depend on CONFIG_NET (such as cmd/net.c enabled via CONFIG_CMD_NET).
-	  Therefore the two symbols CONFIG_NET and CONFIG_NET_LWIP are mutually
-	  exclusive.
-
-endchoice
-
 source "net/Kconfig"
 
-endmenu
-
 source "drivers/Kconfig"
 
 source "fs/Kconfig"
diff --git a/net/Kconfig b/net/Kconfig
index e45ceb25106..249c27c115d 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -2,6 +2,38 @@
 # Network configuration
 #
 
+menu "Networking"
+
+choice
+	prompt "Networking stack"
+	default NET
+
+config NO_NET
+	bool "No networking support"
+	help
+	  Do not include networking support
+
+config NET
+	bool "Legacy U-Boot networking stack"
+	select NETDEVICES
+	help
+	  Include networking support with U-Boot's internal implementation of
+	  the TCP/IP protocol stack.
+
+config NET_LWIP
+	bool "Use lwIP for networking stack"
+	select NETDEVICES
+	help
+	  Include networking support based on the lwIP (lightweight IP)
+	  TCP/IP stack (https://nongnu.org/lwip). This is a replacement for
+	  the default U-Boot network stack and applications located in net/
+	  and enabled via CONFIG_NET as well as other pieces of code that
+	  depend on CONFIG_NET (such as cmd/net.c enabled via CONFIG_CMD_NET).
+	  Therefore the two symbols CONFIG_NET and CONFIG_NET_LWIP are mutually
+	  exclusive.
+
+endchoice
+
 if NET
 
 config ARP_TIMEOUT
@@ -254,3 +286,5 @@ config SYS_RX_ETH_BUFFER
           controllers it is recommended to set this value to 8 or even higher,
           since all buffers can be full shortly after enabling the interface on
           high Ethernet traffic.
+
+endmenu

-- 
2.53.0

