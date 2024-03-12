Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8656EC54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 23:37:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3737B87F65;
	Wed, 13 Mar 2024 00:37:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="oM9GVYuS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1C6687F5E; Wed, 13 Mar 2024 00:37:12 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F244687F16
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 00:37:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=03ce=KT=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1710286611; bh=gvO/oryGH8GCMQbhE1RRmKwBFwEtwOxoPqu0xHVKLAs=;
 b=oM9GVYuSQkH6qT/ekyYgH2cyeNeNzqGD+ubJFhJxY+i6dgE8ieD+YNLoUFnPrQ4Wyobo+RlnU
 p3s9EOOJrtwv/cchrV/qdLq86buyh6BkhjuQVRuZ8yc0kxQoblThrOYQICq9I1IlclfiBfYmlOQ
 fNMIs0d/e6bhqcCeYoRpuHZvPNO+EgEkv5hc4zmoM2T7Y8C4YLeQxbPXbpijaqCBE9BmXuPl6Wk
 DuXlHInMeZevpPcneXO26J2FpleiApt+SdIqAnK9BZTPZ5y5+rz56KMUPss/Wl66OWRcASAYFUT
 da3fCRWdHK6krrX0AQwHDWpKQYi7kawkQ9Gekie5JWNQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Levin Du <djw@t-chip.com.cn>, Suniel Mahesh <sunil@amarulasolutions.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jagan Teki <jagan@amarulasolutions.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
Subject: [PATCH v2 01/12] board: rockchip: rk3399: Add device tree files to
 MAINTAINERS
Date: Tue, 12 Mar 2024 23:36:11 +0000
Message-ID: <20240312233636.1428749-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240312233636.1428749-1-jonas@kwiboo.se>
References: <20240312233636.1428749-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65f0e711e6c04c5b305935fa
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

Update MAINTAINERS files for RK3399 boards to include related device
tree files. Also correct a few filenames.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2:
- Use glob pattern where appropriate
---
 board/firefly/roc-pc-rk3399/MAINTAINERS       |  1 +
 board/pine64/pinebook-pro-rk3399/MAINTAINERS  |  5 ++-
 board/pine64/pinephone-pro-rk3399/MAINTAINERS |  5 ++-
 board/pine64/rockpro64_rk3399/MAINTAINERS     |  2 +-
 board/rockchip/evb_rk3399/MAINTAINERS         | 35 ++++++++++---------
 board/vamrs/rock960_rk3399/MAINTAINERS        |  2 ++
 6 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/board/firefly/roc-pc-rk3399/MAINTAINERS b/board/firefly/roc-pc-rk3399/MAINTAINERS
index 68a5b757d1df..2c0de4432fa8 100644
--- a/board/firefly/roc-pc-rk3399/MAINTAINERS
+++ b/board/firefly/roc-pc-rk3399/MAINTAINERS
@@ -6,3 +6,4 @@ F:	board/firefly/roc-pc-rk3399
 F:	include/configs/roc-pc-rk3399.h
 F:	configs/roc-pc-rk3399_defconfig
 F:	configs/roc-pc-mezzanine-rk3399_defconfig
+F:	arch/arm/dts/rk3399-roc-pc*
diff --git a/board/pine64/pinebook-pro-rk3399/MAINTAINERS b/board/pine64/pinebook-pro-rk3399/MAINTAINERS
index 7300ca1b1b81..287ed4346050 100644
--- a/board/pine64/pinebook-pro-rk3399/MAINTAINERS
+++ b/board/pine64/pinebook-pro-rk3399/MAINTAINERS
@@ -2,7 +2,6 @@ PINEBOOK_PRO
 M:	Peter Robinson <pbrobinson@gmail.com>
 S:	Maintained
 F:	board/pine64/pinebook-pro-rk3399/
-F:	include/configs/rk3399-pinebook-pro.h
-F:	arch/arm/dts/rk3399-pinebook-pro.dts
-F:	arch/arm/dts/rk3399-pinebook-pro-u-boot.dtsi
+F:	include/configs/pinebook-pro-rk3399.h
+F:	arch/arm/dts/rk3399-pinebook-pro*
 F:	configs/pinebook-pro-rk3399_defconfig
diff --git a/board/pine64/pinephone-pro-rk3399/MAINTAINERS b/board/pine64/pinephone-pro-rk3399/MAINTAINERS
index bc2dcdd8d423..959566a877ec 100644
--- a/board/pine64/pinephone-pro-rk3399/MAINTAINERS
+++ b/board/pine64/pinephone-pro-rk3399/MAINTAINERS
@@ -2,7 +2,6 @@ PINEPHONE_PRO
 M:	Peter Robinson <pbrobinson@gmail.com>
 S:	Maintained
 F:	board/pine64/pinephone-pro-rk3399/
-F:	include/configs/rk3399-pinephone-pro.h
-F:	arch/arm/dts/rk3399-pinephone-pro.dts
-F:	arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
+F:	include/configs/pinephone-pro-rk3399.h
+F:	arch/arm/dts/rk3399-pinephone-pro*
 F:	configs/pinephone-pro-rk3399_defconfig
diff --git a/board/pine64/rockpro64_rk3399/MAINTAINERS b/board/pine64/rockpro64_rk3399/MAINTAINERS
index 220ee21f230f..d9e11f4bab34 100644
--- a/board/pine64/rockpro64_rk3399/MAINTAINERS
+++ b/board/pine64/rockpro64_rk3399/MAINTAINERS
@@ -3,5 +3,5 @@ M:	Jagan Teki <jagan@amarulasolutions.com>
 S:	Maintained
 F:	board/pine64/rockpro64_rk3399
 F:	include/configs/rockpro64_rk3399.h
-F:	arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
+F:	arch/arm/dts/rk3399-rockpro64*
 F:	configs/rockpro64-rk3399_defconfig
diff --git a/board/rockchip/evb_rk3399/MAINTAINERS b/board/rockchip/evb_rk3399/MAINTAINERS
index acdb840f2093..f45f81623a3a 100644
--- a/board/rockchip/evb_rk3399/MAINTAINERS
+++ b/board/rockchip/evb_rk3399/MAINTAINERS
@@ -4,48 +4,53 @@ S:      Maintained
 F:      board/rockchip/evb_rk3399
 F:      include/configs/evb_rk3399.h
 F:      configs/evb-rk3399_defconfig
+F:      arch/arm/dts/rk3399-evb*
 F:      configs/firefly-rk3399_defconfig
+F:      arch/arm/dts/rk3399-firefly*
 
 EAIDK-610
 M:      Andy Yan <andy.yan@rock-chips.com>
 S:      Maintained
 F:	configs/eaidk-610-rk3399_defconfig
-F:	arch/arm/dts/rk3399-eaidk-610-u-boot.dtsi
+F:	arch/arm/dts/rk3399-eaidk-610*
 
 KHADAS-EDGE
 M:	Nick Xie <nick@khadas.com>
 S:	Maintained
 F:	configs/khadas-edge-rk3399_defconfig
+F:	arch/arm/dts/rk3399-khadas-edge.dts
+F:	arch/arm/dts/rk3399-khadas-edge.dtsi
 F:	arch/arm/dts/rk3399-khadas-edge-u-boot.dtsi
 
 KHADAS-EDGE-CAPTAIN
 M:	Nick Xie <nick@khadas.com>
 S:	Maintained
 F:	configs/khadas-edge-captain-rk3399_defconfig
-F:	arch/arm/dts/rk3399-khadas-edge-captain-u-boot.dtsi
+F:	arch/arm/dts/rk3399-khadas-edge-captain*
 
 KHADAS-EDGE-V
 M:	Nick Xie <nick@khadas.com>
 S:	Maintained
 F:	configs/khadas-edge-v-rk3399_defconfig
-F:	arch/arm/dts/rk3399-khadas-edge-v-u-boot.dtsi
+F:	arch/arm/dts/rk3399-khadas-edge-v*
 
 LEEZ-P710
 M:	Andy Yan <andy.yan@rock-chips.com>
 S:      Maintained
-F:	arch/arm/dts/rk3399-leez-p710-u-boot.dtsi
+F:	arch/arm/dts/rk3399-leez-p710*
 F:	configs/leez-rk3399_defconfig
 
 NANOPC-T4
 M:	Jagan Teki <jagan@amarulasolutions.com>
 S:	Maintained
 F:	configs/nanopc-t4-rk3399_defconfig
-F:	arch/arm/dts/rk3399-nanopc-t4-u-boot.dtsi
+F:	arch/arm/dts/rk3399-nanopc-t4*
 
 NANOPI-M4
 M:	Jagan Teki <jagan@amarulasolutions.com>
 S:	Maintained
 F:	configs/nanopi-m4-rk3399_defconfig
+F:	arch/arm/dts/rk3399-nanopi-m4.dts
 F:	arch/arm/dts/rk3399-nanopi-m4-u-boot.dtsi
 
 NANOPI-M4-2GB
@@ -53,55 +58,53 @@ M:	Jagan Teki <jagan@amarulasolutions.com>
 M:	Deepak Das <deepakdas.linux@gmail.com>
 S:	Maintained
 F:	configs/nanopi-m4-2gb-rk3399_defconfig
-F:	arch/arm/dts/rk3399-nanopi-m4-2gb-u-boot.dtsi
+F:	arch/arm/dts/rk3399-nanopi-m4-2gb*
 
 NANOPI-M4B
 M:	Alexandre Vicenzi <linux@alxd.me>
 S:	Maintained
 F:	configs/nanopi-m4b-rk3399_defconfig
-F:	arch/arm/dts/rk3399-nanopi-m4b-u-boot.dtsi
+F:	arch/arm/dts/rk3399-nanopi-m4b*
 
 NANOPI-NEO4
 M:	Jagan Teki <jagan@amarulasolutions.com>
 S:	Maintained
 F:	configs/nanopi-neo4-rk3399_defconfig
-F:	arch/arm/dts/rk3399-nanopi-neo4-u-boot.dtsi
+F:	arch/arm/dts/rk3399-nanopi-neo4*
 
 NANOPI-R4S
 M:	Xiaobo Tian <peterwillcn@gmail.com>
 S:	Maintained
 F:	configs/nanopi-r4s-rk3399_defconfig
-F:	arch/arm/dts/rk3399-nanopi-r4s-u-boot.dtsi
+F:	arch/arm/dts/rk3399-nanopi-r4s*
 
 ORANGEPI-RK3399
 M:	Jagan Teki <jagan@amarulasolutions.com>
 S:	Maintained
 F:	configs/orangepi-rk3399_defconfig
-F:	arch/arm/dts/rk3399-u-boot.dtsi
-F:	arch/arm/dts/rk3399-orangepi-u-boot.dtsi
+F:	arch/arm/dts/rk3399-orangepi*
 
 ROCK-4C+
 M:	FUKAUMI Naoki <naoki@radxa.com>
 S:	Maintained
 F:	configs/rock-4c-plus-rk3399_defconfig
-F:	arch/arm/dts/rk3399-rock-4c-plus.dts
+F:	arch/arm/dts/rk3399-rock-4c-plus*
 
 ROCK-4SE
 M:	Christopher Obbard <chris.obbard@collabora.com>
 S:	Maintained
 F:	configs/rock-4se-rk3399_defconfig
-F:	arch/arm/dts/rk3399-rock-4se-u-boot.dtsi
+F:	arch/arm/dts/rk3399-rock-4se*
 
 ROCK-PI-4
 M:	Jagan Teki <jagan@amarulasolutions.com>
 S:	Maintained
 F:	configs/rock-pi-4-rk3399_defconfig
-F:	arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
 F:	configs/rock-pi-4c-rk3399_defconfig
-F:	arch/arm/dts/rk3399-rock-pi-4c-u-boot.dtsi
+F:	arch/arm/dts/rk3399-rock-pi-4*
 
 ROCK-PI-N10
 M:	Jagan Teki <jagan@amarulasolutions.com>
 S:	Maintained
 F:	configs/rock-pi-n10-rk3399pro_defconfig
-F:	arch/arm/dts/rk3399pro-rock-pi-n10-u-boot.dtsi
+F:	arch/arm/dts/rk3399pro-rock-pi-n10*
diff --git a/board/vamrs/rock960_rk3399/MAINTAINERS b/board/vamrs/rock960_rk3399/MAINTAINERS
index 8821672a3abb..f2121b191450 100644
--- a/board/vamrs/rock960_rk3399/MAINTAINERS
+++ b/board/vamrs/rock960_rk3399/MAINTAINERS
@@ -4,8 +4,10 @@ S:      Maintained
 F:      board/vamrs/rock960_rk3399/
 F:      include/configs/rock960_rk3399.h
 F:      configs/rock960-rk3399_defconfig
+F:      arch/arm/dts/rk3399-rock960*
 
 FICUS EE
 M:      Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 S:      Maintained
 F:	configs/ficus-rk3399_defconfig
+F:	arch/arm/dts/rk3399-ficus*
-- 
2.43.2

