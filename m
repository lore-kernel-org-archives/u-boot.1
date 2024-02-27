Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C7C1C5478C
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 15:40:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B27387F9B;
	Tue, 27 Feb 2024 16:40:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3D2287FAA; Tue, 27 Feb 2024 16:40:17 +0100 (CET)
Received: from 16.mo581.mail-out.ovh.net (16.mo581.mail-out.ovh.net
 [46.105.72.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0034287DE9
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 16:40:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sebastien.szymanski@armadeus.com
Received: from director9.ghost.mail-out.ovh.net (unknown [10.108.9.163])
 by mo581.mail-out.ovh.net (Postfix) with ESMTP id 4TkhWc2GBXz19pX
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 15:40:12 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-snnsd (unknown [10.110.113.248])
 by director9.ghost.mail-out.ovh.net (Postfix) with ESMTPS id CC4441FE67;
 Tue, 27 Feb 2024 15:40:11 +0000 (UTC)
Received: from armadeus.com ([37.59.142.95])
 by ghost-submission-6684bf9d7b-snnsd with ESMTPSA
 id k/0BLVsC3mVV3AAAJ0sS3Q
 (envelope-from <sebastien.szymanski@armadeus.com>);
 Tue, 27 Feb 2024 15:40:11 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G0015a83a7b5-80c2-4656-ab25-1ec390085e5a,
 6291C1F48E860526C1A48BF1F3918837323A844E)
 smtp.auth=sebastien.szymanski@armadeus.com
X-OVh-ClientIp: 92.148.253.243
From: =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>
To: u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>
Subject: [PATCH 1/2] opos6uldev: make the LCD work again
Date: Tue, 27 Feb 2024 16:40:01 +0100
Message-ID: <20240227154002.30257-1-sebastien.szymanski@armadeus.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 170010889292934123
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrgeehgdehgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomhepuforsggrshhtihgvnhcuufiihihmrghnshhkihcuoehsvggsrghsthhivghnrdhsiiihmhgrnhhskhhisegrrhhmrgguvghushdrtghomheqnecuggftrfgrthhtvghrnhepffeufffgveeiffelteelgfetjeffueffuefhffeikefhkefghfejjeeufeduteegnecukfhppeduvdejrddtrddtrddupdelvddrudegkedrvdehfedrvdegfedpfeejrdehledrudegvddrleehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehsvggsrghsthhivghnrdhsiiihmhgrnhhskhhisegrrhhmrgguvghushdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnhigrdguvgdpoffvtefjohhsthepmhhoheekuddpmhhouggvpehsmhhtphhouhht
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

Commit 5d7a95f49999 ("imx6ul/imx6ull: synchronise device trees with
linux") removed the display timings from the board device tree whereas
they are still needed by the mxsfb driver.
Add the timings back (the correct ones) in the
imx6ul-opos6uldev-u-boot.dtsi file and remove them from the
opos6uldev.env file.

Update the opos6uldev_defconfig file so that the LCD turns on at boot.

Fixes: 5d7a95f49999 ("imx6ul/imx6ull: synchronise device trees with linux")
Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
---
 arch/arm/dts/imx6ul-opos6uldev-u-boot.dtsi | 28 +++++++++++++++++-----
 board/armadeus/opos6uldev/opos6uldev.env   |  1 -
 configs/opos6uldev_defconfig               |  3 ---
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/arch/arm/dts/imx6ul-opos6uldev-u-boot.dtsi b/arch/arm/dts/imx6ul-opos6uldev-u-boot.dtsi
index aa88964f210d..3b52d6bbd9b9 100644
--- a/arch/arm/dts/imx6ul-opos6uldev-u-boot.dtsi
+++ b/arch/arm/dts/imx6ul-opos6uldev-u-boot.dtsi
@@ -7,12 +7,6 @@
 
 #include "imx6ul-opos6ul-u-boot.dtsi"
 
-/ {
-	aliases {
-		display0 = &lcdif;
-	};
-};
-
 &aips1 {
 	bootph-pre-ram;
 
@@ -22,7 +16,29 @@
 };
 
 &lcdif {
+	display = <&display0>;
 	bootph-some-ram;
+
+	display0: display0 {
+		bits-per-pixel = <18>;
+		bus-width = <18>;
+
+		display-timings {
+			timing0 {
+				clock-frequency = <33300000>;
+				hactive = <800>;
+				vactive = <480>;
+				hback-porch = <36>;
+				hfront-porch = <210>;
+				vback-porch = <13>;
+				vfront-porch = <22>;
+				hsync-len = <10>;
+				vsync-len = <10>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+		};
+	};
 };
 
 &pinctrl_uart1 {
diff --git a/board/armadeus/opos6uldev/opos6uldev.env b/board/armadeus/opos6uldev/opos6uldev.env
index f90029787104..2e7b65968d1d 100644
--- a/board/armadeus/opos6uldev/opos6uldev.env
+++ b/board/armadeus/opos6uldev/opos6uldev.env
@@ -24,7 +24,6 @@ mmcrootfstype=ext4 rootwait
 kernelimg=opos6ul-linux.bin
 splashpos=0,0
 splashimage=CONFIG_SYS_LOAD_ADDR
-videomode=video=ctfb:x:800,y:480,depth:18,pclk:33033,le:96,ri:96,up:20,lo:21,hs:64,vs:4,sync:0,vmode:0
 check_env=if test -n ${flash_env_version};
 	then env default env_version;
 	else env set flash_env_version ${env_version}; env save;
diff --git a/configs/opos6uldev_defconfig b/configs/opos6uldev_defconfig
index e1884df9dd23..7d21a6fe93c5 100644
--- a/configs/opos6uldev_defconfig
+++ b/configs/opos6uldev_defconfig
@@ -115,13 +115,10 @@ CONFIG_CI_UDC=y
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_VIDEO=y
 CONFIG_VIDEO_LOGO=y
-# CONFIG_VIDEO_BPP8 is not set
-# CONFIG_VIDEO_BPP32 is not set
 CONFIG_SYS_WHITE_ON_BLACK=y
 CONFIG_VIDEO_MXS=y
 CONFIG_SPLASH_SCREEN=y
 CONFIG_SPLASH_SCREEN_ALIGN=y
-CONFIG_SPLASH_SOURCE=y
 CONFIG_BMP_16BPP=y
 CONFIG_BMP_24BPP=y
 CONFIG_BMP_32BPP=y
-- 
2.43.0

