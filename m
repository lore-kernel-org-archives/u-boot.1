Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0D2C25B7A
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 11:47:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75F1588542;
	Fri, 24 May 2024 13:47:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E432F88676; Fri, 24 May 2024 13:47:01 +0200 (CEST)
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::bc08])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11B24884B9
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 13:46:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Vm3DK4MBszk72;
 Fri, 24 May 2024 13:46:57 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Vm3DK0pbLzFBy; Fri, 24 May 2024 13:46:57 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 24 May 2024 13:46:36 +0200
Subject: [PATCH 2/3] migrate Theobroma Systems mail addresses to CHERRY
 Embedded Solutions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-tsd-to-cherry-v1-2-3002bed55f19@cherry.de>
References: <20240524-tsd-to-cherry-v1-0-3002bed55f19@cherry.de>
In-Reply-To: <20240524-tsd-to-cherry-v1-0-3002bed55f19@cherry.de>
To: Tom Rini <trini@konsulko.com>, Heiko Stuebner <heiko.stuebner@cherry.de>, 
 Klaus Goger <klaus.goger@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>, 
 Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
X-Mailer: b4 0.13.0
X-Infomaniak-Routing: alpha
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

See
https://embedded.cherry.de/theobroma-systems-is-now-officially-part-of-cherry-se/

While the mail addresses on the theobroma-systems.com domain should be
redirect to cherry.de, let's anticipate IT hiccups and avoid important
mails not reaching us by swapping the domain name wherever appropriate
for the newer one.

Christoph Mueller isn't working at ~Theobroma~ CHERRY Embedded Solutions
anymore, but I don't know his new mail address so mails destined to him
will keep bouncing.

Cc: Heiko Stuebner <heiko.stuebner@cherry.de> <heiko.stuebner@theobroma-systems.com>
Cc: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
Cc: Klaus Goger <klaus.goger@cherry.de>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 .mailmap                                          | 4 ++++
 board/hardkernel/odroid_go2/MAINTAINERS           | 2 +-
 board/theobroma-systems/jaguar_rk3588/MAINTAINERS | 4 ++--
 board/theobroma-systems/lion_rk3368/MAINTAINERS   | 4 ++--
 board/theobroma-systems/puma_rk3399/MAINTAINERS   | 4 ++--
 board/theobroma-systems/ringneck_px30/MAINTAINERS | 4 ++--
 6 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/.mailmap b/.mailmap
index e530949a308..952e1dac4b2 100644
--- a/.mailmap
+++ b/.mailmap
@@ -42,6 +42,7 @@ Eugen Hristev <eugen.hristev@collabora.com> <eugen.hristev@microchip.com>
 Fabio Estevam <fabio.estevam@nxp.com>
 Harini Katakam <harini.katakam@amd.com> <harini.katakam@xilinx.com>
 Harsha <harsha.harsha@amd.com> <harsha.harsha@xilinx.com>
+Heiko Stuebner <heiko.stuebner@cherry.de> <heiko.stuebner@theobroma-systems.com>
 Heinrich Schuchardt <xypron.glpk@gmx.de> <heinrich.schuchardt@canonical.com>
 Heinrich Schuchardt <xypron.glpk@gmx.de> xypron.glpk@gmx.de <xypron.glpk@gmx.de>
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com> <ibai.erkiaga-elorza@xilinx.com>
@@ -53,12 +54,14 @@ Jagan Teki <jaganna@gmail.com>
 Jagan Teki <jaganna@xilinx.com>
 Jagan Teki <jagannadh.teki@gmail.com>
 Jagan Teki <jagannadha.sutradharudu-teki@xilinx.com>
+Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de> <jakob.unterwurzacher@theobroma-systems.com>
 Jay Buddhabhatti <jay.buddhabhatti@amd.com> <jay.buddhabhatti@xilinx.com>
 Jernej Skrabec <jernej.skrabec@gmail.com> <jernej.skrabec@siol.net>
 John Linn <john.linn@amd.com> <john.linn@xilinx.com>
 Jyotheeswar Reddy Mutthareddyvari <jyotheeswar.reddy.mutthareddyvari@amd.com> <jyothee@xilinx.com>
 Jyotheeswar Reddy Mutthareddyvari <jyotheeswar.reddy.mutthareddyvari@amd.com> <jyotheeswar.reddy.mutthareddyvari@xilinx.com>
 Kalyani Akula <kalyani.akula@amd.com> <kalyani.akula@xilinx.com>
+Klaus Goger <klaus.goger@cherry.de> <klaus.goger@theobroma-systems.com>
 Masahisa Kojima <kojima.masahisa@socionext.com> <masahisa.kojima@linaro.org>
 Love Kumar <love.kumar@amd.com> <love.kumar@xilinx.com>
 Lukasz Majewski <lukma@denx.de>
@@ -92,6 +95,7 @@ Philipp Tomsich <philipp.tomsich@vrull.eu> <philipp.tomsich@theobroma-systems.co
 Piyush Mehta <piyush.mehta@amd.com> <piyush.mehta@xilinx.com>
 Prabhakar Kushwaha <prabhakar@freescale.com>
 Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@amd.com> <punnaiah.choudary.kalluri@xilinx.com>
+Quentin Schulz <quentin.schulz@cherry.de> <quentin.schulz@theobroma-systems.com>
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com> <radhey.shyam.pandey@xilinx.com>
 Rajeshwari Shinde <rajeshwari.s@samsung.com>
 Raju Kumar Pothuraju <rajukumar.pothuraju@amd.com> <raju.kumar-pothuraju@xilinx.com>
diff --git a/board/hardkernel/odroid_go2/MAINTAINERS b/board/hardkernel/odroid_go2/MAINTAINERS
index 4d4c6e8fef6..9e83bc9452c 100644
--- a/board/hardkernel/odroid_go2/MAINTAINERS
+++ b/board/hardkernel/odroid_go2/MAINTAINERS
@@ -1,5 +1,5 @@
 GO2
-M:      Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
+M:      Heiko Stuebner <heiko.stuebner@cherry.de>
 S:      Maintained
 F:      board/hardkernel/odroid_go2/
 F:      include/configs/odroid_go2.h
diff --git a/board/theobroma-systems/jaguar_rk3588/MAINTAINERS b/board/theobroma-systems/jaguar_rk3588/MAINTAINERS
index 28fae4b479f..d14edadefe2 100644
--- a/board/theobroma-systems/jaguar_rk3588/MAINTAINERS
+++ b/board/theobroma-systems/jaguar_rk3588/MAINTAINERS
@@ -1,6 +1,6 @@
 JAGUAR-RK3588 (SBC-RK3588-AMR Single Board Computer)
-M:	Klaus Goger <klaus.goger@theobroma-systems.com>
-M:	Quentin Schulz <quentin.schulz@theobroma-systems.com>
+M:	Klaus Goger <klaus.goger@cherry.de>
+M:	Quentin Schulz <quentin.schulz@cherry.de>
 M:	Heiko Stuebner <heiko.stuebner@cherry.de>
 S:	Maintained
 F:	board/theobroma-systems/jaguar_rk3588
diff --git a/board/theobroma-systems/lion_rk3368/MAINTAINERS b/board/theobroma-systems/lion_rk3368/MAINTAINERS
index a5b4cb31b4a..ed35fee6468 100644
--- a/board/theobroma-systems/lion_rk3368/MAINTAINERS
+++ b/board/theobroma-systems/lion_rk3368/MAINTAINERS
@@ -1,6 +1,6 @@
 LION-RK3368 (RK3368-uQ7 system-on-module)
-M:	Quentin Schulz <quentin.schulz@theobroma-systems.com>
-M:	Klaus Goger <klaus.goger@theobroma-systems.com>
+M:	Quentin Schulz <quentin.schulz@cherry.de>
+M:	Klaus Goger <klaus.goger@cherry.de>
 S:	Maintained
 F:	board/theobroma-systems/lion_rk3368
 F:	include/configs/lion_rk3368.h
diff --git a/board/theobroma-systems/puma_rk3399/MAINTAINERS b/board/theobroma-systems/puma_rk3399/MAINTAINERS
index 7e84a5be262..2b409f16963 100644
--- a/board/theobroma-systems/puma_rk3399/MAINTAINERS
+++ b/board/theobroma-systems/puma_rk3399/MAINTAINERS
@@ -1,6 +1,6 @@
 PUMA-RK3399
-M:	Quentin Schulz <quentin.schulz@theobroma-systems.com>
-M:	Klaus Goger <klaus.goger@theobroma-systems.com>
+M:	Quentin Schulz <quentin.schulz@cherry.de>
+M:	Klaus Goger <klaus.goger@cherry.de>
 S:	Maintained
 F:	board/theobroma-systems/puma_rk3399
 F:	board/theobroma-systems/common
diff --git a/board/theobroma-systems/ringneck_px30/MAINTAINERS b/board/theobroma-systems/ringneck_px30/MAINTAINERS
index 97baf334d02..bf4bc452823 100644
--- a/board/theobroma-systems/ringneck_px30/MAINTAINERS
+++ b/board/theobroma-systems/ringneck_px30/MAINTAINERS
@@ -1,6 +1,6 @@
 RINGNECK-PX30
-M:	Quentin Schulz <quentin.schulz@theobroma-systems.com>
-M:	Klaus Goger <klaus.goger@theobroma-systems.com>
+M:	Quentin Schulz <quentin.schulz@cherry.de>
+M:	Klaus Goger <klaus.goger@cherry.de>
 S:	Maintained
 F:	board/theobroma-systems/ringneck_px30
 F:	board/theobroma-systems/common

-- 
2.45.1

