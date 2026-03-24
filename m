Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE2AE9A75C
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 10:09:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D979E80077;
	Tue, 24 Mar 2026 11:09:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=philipmolloy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=philipmolloy.com header.i=@philipmolloy.com header.b="gz1w66ey";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 994A480517; Tue, 24 Mar 2026 11:09:54 +0100 (CET)
Received: from mail-244119.protonmail.ch (mail-244119.protonmail.ch
 [109.224.244.119])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B134980050
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 11:09:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=philipmolloy.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philip@philipmolloy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=philipmolloy.com;
 s=protonmail; t=1774346989; x=1774606189;
 bh=6kw6XS/34Ke79Ih93aiy1Ej9NGcHNKL+D4YOVFA/6Tg=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=gz1w66eydfjtqUawBt30alLhxL2ry6v5yHIrz8UzrxzMsy3vNdR+UmrEoIV9FXjZv
 tD45vLGIaELFOpSzx1O16xMFFHiQHgbxHg/E00yj0bbzZYWEEa2GD6ymmY8vNchDuT
 /Ktr0+bISq7WDkAfqSprJfeoSbv+TUg0sIB/pdd0P81+vFxXdBZp8eO/OtKz6iXR1C
 eMz0MC7pfPzHusHeT8nh+3VHd8HYCkq7cKBcgq9dFW66NCT7Hwf88kosWGZ9+D3x/E
 vWC/Q0knxJjgXXtZCnsz2EkfJHhKOfmMmfw8bjezs8k4LtCs4scW3xWRlQHwFbMU33
 2zvB9NY4jQ3zQ==
Date: Tue, 24 Mar 2026 10:09:44 +0000
To: u-boot@lists.denx.de
From: Philip Molloy <philip@philipmolloy.com>
Cc: linux@analog.com, Philip Molloy <philip.molloy@analog.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Caleb Ethridge <caleb.ethridge@analog.com>, E Shattow <e@freeshell.de>,
 Greg Malysa <malysagreg@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@riscstar.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, Yao Zi <me@ziyao.cc>
Subject: [PATCH] arm: mach-sc5xx: Align header paths with SYS_SOC convention
Message-ID: <20260324100921.1783280-1-philip@philipmolloy.com>
Feedback-ID: 9117015:user:proton
X-Pm-Message-ID: ba3df7b01e494da03fd49dfaac97d4bd1d757c7b
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

From: Philip Molloy <philip.molloy@analog.com>

Define CONFIG_SYS_SOC in the mach-sc5xx Kconfig. Follow the standard
U-Boot include path convention by moving the SC5xx SoC headers from
arch/arm/include/asm/arch-adi/sc5xx/ to the conventional
arch/arm/include/asm/arch-sc5xx/ location. Update includes from
<asm/arch-adi/sc5xx/*.h> to <asm/arch/*.h> across mach-sc5xx and board
files.

Signed-off-by: Philip Molloy <philip.molloy@analog.com>
---

 MAINTAINERS                                                 | 2 +-
 arch/arm/include/asm/{arch-adi/sc5xx =3D> arch-sc5xx}/sc5xx.h | 0
 arch/arm/include/asm/{arch-adi/sc5xx =3D> arch-sc5xx}/soc.h   | 0
 arch/arm/include/asm/{arch-adi/sc5xx =3D> arch-sc5xx}/spl.h   | 0
 arch/arm/mach-sc5xx/Kconfig                                 | 3 +++
 arch/arm/mach-sc5xx/init/clkinit.c                          | 2 +-
 arch/arm/mach-sc5xx/init/dmcinit.c                          | 2 +-
 arch/arm/mach-sc5xx/sc57x-spl.c                             | 2 +-
 arch/arm/mach-sc5xx/sc57x.c                                 | 4 ++--
 arch/arm/mach-sc5xx/sc58x-spl.c                             | 2 +-
 arch/arm/mach-sc5xx/sc58x.c                                 | 4 ++--
 arch/arm/mach-sc5xx/sc59x-spl.c                             | 2 +-
 arch/arm/mach-sc5xx/sc59x.c                                 | 4 ++--
 arch/arm/mach-sc5xx/sc59x_64-spl.c                          | 2 +-
 arch/arm/mach-sc5xx/sc59x_64.c                              | 4 ++--
 arch/arm/mach-sc5xx/soc.c                                   | 4 ++--
 arch/arm/mach-sc5xx/spl.c                                   | 4 ++--
 board/adi/carriers/somcrr_common.c                          | 2 +-
 board/adi/common-sc594-som/sc594-som.c                      | 4 ++--
 board/adi/common-sc598-som/sc598-som.c                      | 4 ++--
 board/adi/sc573-ezkit/sc573-ezkit.c                         | 4 ++--
 board/adi/sc584-ezkit/sc584-ezkit.c                         | 4 ++--
 board/adi/sc589-ezkit/sc589-ezkit.c                         | 4 ++--
 board/adi/sc589-mini/sc589-mini.c                           | 4 ++--
 drivers/net/dwc_eth_qos_adi.c                               | 2 +-
 25 files changed, 36 insertions(+), 33 deletions(-)
 rename arch/arm/include/asm/{arch-adi/sc5xx =3D> arch-sc5xx}/sc5xx.h (100%=
)
 rename arch/arm/include/asm/{arch-adi/sc5xx =3D> arch-sc5xx}/soc.h (100%)
 rename arch/arm/include/asm/{arch-adi/sc5xx =3D> arch-sc5xx}/spl.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index d4b527560aa..d65abd78d76 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -633,7 +633,7 @@ L:=09linux@analog.com
 S:=09Supported
 T:=09git https://github.com/analogdevicesinc/u-boot
 F:=09arch/arm/dts/sc5*
-F:=09arch/arm/include/asm/arch-adi/
+F:=09arch/arm/include/asm/arch-sc5xx/
 F:=09arch/arm/mach-sc5xx/
 F:=09board/adi/
 F:=09configs/sc5*
diff --git a/arch/arm/include/asm/arch-adi/sc5xx/sc5xx.h b/arch/arm/include=
/asm/arch-sc5xx/sc5xx.h
similarity index 100%
rename from arch/arm/include/asm/arch-adi/sc5xx/sc5xx.h
rename to arch/arm/include/asm/arch-sc5xx/sc5xx.h
diff --git a/arch/arm/include/asm/arch-adi/sc5xx/soc.h b/arch/arm/include/a=
sm/arch-sc5xx/soc.h
similarity index 100%
rename from arch/arm/include/asm/arch-adi/sc5xx/soc.h
rename to arch/arm/include/asm/arch-sc5xx/soc.h
diff --git a/arch/arm/include/asm/arch-adi/sc5xx/spl.h b/arch/arm/include/a=
sm/arch-sc5xx/spl.h
similarity index 100%
rename from arch/arm/include/asm/arch-adi/sc5xx/spl.h
rename to arch/arm/include/asm/arch-sc5xx/spl.h
diff --git a/arch/arm/mach-sc5xx/Kconfig b/arch/arm/mach-sc5xx/Kconfig
index 1486656b36b..59aac2859b1 100644
--- a/arch/arm/mach-sc5xx/Kconfig
+++ b/arch/arm/mach-sc5xx/Kconfig
@@ -13,6 +13,9 @@ if ARCH_SC5XX
 config SYS_VENDOR
 =09default "adi"
=20
+config SYS_SOC
+=09default "sc5xx"
+
 choice
 =09prompt "SC5xx SoC Select"
 =09help
diff --git a/arch/arm/mach-sc5xx/init/clkinit.c b/arch/arm/mach-sc5xx/init/=
clkinit.c
index 3dcba33bd1b..f9c83c6efac 100644
--- a/arch/arm/mach-sc5xx/init/clkinit.c
+++ b/arch/arm/mach-sc5xx/init/clkinit.c
@@ -6,7 +6,7 @@
  *
  */
=20
-#include <asm/arch-adi/sc5xx/sc5xx.h>
+#include <asm/arch/sc5xx.h>
 #include <asm/io.h>
 #include <linux/types.h>
 #include "clkinit.h"
diff --git a/arch/arm/mach-sc5xx/init/dmcinit.c b/arch/arm/mach-sc5xx/init/=
dmcinit.c
index 2bf2cc53a9f..12052613feb 100644
--- a/arch/arm/mach-sc5xx/init/dmcinit.c
+++ b/arch/arm/mach-sc5xx/init/dmcinit.c
@@ -7,7 +7,7 @@
  */
=20
 #include <asm/io.h>
-#include <asm/arch-adi/sc5xx/sc5xx.h>
+#include <asm/arch/sc5xx.h>
 #include <linux/types.h>
 #include "clkinit.h"
 #include "dmcinit.h"
diff --git a/arch/arm/mach-sc5xx/sc57x-spl.c b/arch/arm/mach-sc5xx/sc57x-sp=
l.c
index 28380b89b48..6084493cf4f 100644
--- a/arch/arm/mach-sc5xx/sc57x-spl.c
+++ b/arch/arm/mach-sc5xx/sc57x-spl.c
@@ -3,7 +3,7 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
=20
-#include <asm/arch-adi/sc5xx/spl.h>
+#include <asm/arch/spl.h>
=20
 // Table 45-16 in SC573 HRM
 const struct adi_boot_args adi_rom_boot_args[] =3D {
diff --git a/arch/arm/mach-sc5xx/sc57x.c b/arch/arm/mach-sc5xx/sc57x.c
index 02b04cd1b2f..7e58e92b188 100644
--- a/arch/arm/mach-sc5xx/sc57x.c
+++ b/arch/arm/mach-sc5xx/sc57x.c
@@ -7,8 +7,8 @@
  */
=20
 #include <asm/io.h>
-#include <asm/arch-adi/sc5xx/sc5xx.h>
-#include <asm/arch-adi/sc5xx/spl.h>
+#include <asm/arch/sc5xx.h>
+#include <asm/arch/spl.h>
=20
 #define REG_SPU0_SECUREC0 0x3108B980
 #define REG_PADS0_PCFG0 0x31004404
diff --git a/arch/arm/mach-sc5xx/sc58x-spl.c b/arch/arm/mach-sc5xx/sc58x-sp=
l.c
index ae809f09e55..2582e38ce12 100644
--- a/arch/arm/mach-sc5xx/sc58x-spl.c
+++ b/arch/arm/mach-sc5xx/sc58x-spl.c
@@ -3,7 +3,7 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
=20
-#include <asm/arch-adi/sc5xx/spl.h>
+#include <asm/arch/spl.h>
=20
 // Table 53-13 in SC58x HRM
 const struct adi_boot_args adi_rom_boot_args[] =3D {
diff --git a/arch/arm/mach-sc5xx/sc58x.c b/arch/arm/mach-sc5xx/sc58x.c
index c981cafd986..dc11df683a8 100644
--- a/arch/arm/mach-sc5xx/sc58x.c
+++ b/arch/arm/mach-sc5xx/sc58x.c
@@ -7,8 +7,8 @@
  */
=20
 #include <asm/io.h>
-#include <asm/arch-adi/sc5xx/sc5xx.h>
-#include <asm/arch-adi/sc5xx/spl.h>
+#include <asm/arch/sc5xx.h>
+#include <asm/arch/spl.h>
=20
 #define REG_SPU0_SECUREC0 0x3108C980
 #define REG_PADS0_PCFG0 0x31004404
diff --git a/arch/arm/mach-sc5xx/sc59x-spl.c b/arch/arm/mach-sc5xx/sc59x-sp=
l.c
index c8fc25fe7c4..883bdb3c772 100644
--- a/arch/arm/mach-sc5xx/sc59x-spl.c
+++ b/arch/arm/mach-sc5xx/sc59x-spl.c
@@ -3,7 +3,7 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
=20
-#include <asm/arch-adi/sc5xx/spl.h>
+#include <asm/arch/spl.h>
=20
 // Table 45-14 in sc594 HRM
 const struct adi_boot_args adi_rom_boot_args[] =3D {
diff --git a/arch/arm/mach-sc5xx/sc59x.c b/arch/arm/mach-sc5xx/sc59x.c
index 675f8c7d69a..286f6d52eef 100644
--- a/arch/arm/mach-sc5xx/sc59x.c
+++ b/arch/arm/mach-sc5xx/sc59x.c
@@ -7,8 +7,8 @@
  */
=20
 #include <asm/io.h>
-#include <asm/arch-adi/sc5xx/sc5xx.h>
-#include <asm/arch-adi/sc5xx/spl.h>
+#include <asm/arch/sc5xx.h>
+#include <asm/arch/spl.h>
=20
 #define REG_SPU0_SECUREC0 0x3108B980
 #define REG_PADS0_PCFG0 0x31004604
diff --git a/arch/arm/mach-sc5xx/sc59x_64-spl.c b/arch/arm/mach-sc5xx/sc59x=
_64-spl.c
index 3992538133d..500824b5bb9 100644
--- a/arch/arm/mach-sc5xx/sc59x_64-spl.c
+++ b/arch/arm/mach-sc5xx/sc59x_64-spl.c
@@ -3,7 +3,7 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
=20
-#include <asm/arch-adi/sc5xx/spl.h>
+#include <asm/arch/spl.h>
=20
 // Table 47-14 in SC598 hardware reference manual
 const struct adi_boot_args adi_rom_boot_args[] =3D {
diff --git a/arch/arm/mach-sc5xx/sc59x_64.c b/arch/arm/mach-sc5xx/sc59x_64.=
c
index a8402075d0a..b9694a48e87 100644
--- a/arch/arm/mach-sc5xx/sc59x_64.c
+++ b/arch/arm/mach-sc5xx/sc59x_64.c
@@ -8,8 +8,8 @@
=20
 #include <asm/io.h>
 #include <asm/armv8/mmu.h>
-#include <asm/arch-adi/sc5xx/sc5xx.h>
-#include <asm/arch-adi/sc5xx/spl.h>
+#include <asm/arch/sc5xx.h>
+#include <asm/arch/spl.h>
=20
 #define REG_TSGENWR0_CNTCR 0x310AE000
 #define REG_PADS0_PCFG0 0x31004604
diff --git a/arch/arm/mach-sc5xx/soc.c b/arch/arm/mach-sc5xx/soc.c
index cf8ff0dc3af..09978a5cf44 100644
--- a/arch/arm/mach-sc5xx/soc.c
+++ b/arch/arm/mach-sc5xx/soc.c
@@ -6,8 +6,8 @@
  *
  */
=20
-#include <asm/arch-adi/sc5xx/sc5xx.h>
-#include <asm/arch-adi/sc5xx/soc.h>
+#include <asm/arch/sc5xx.h>
+#include <asm/arch/soc.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <cpu_func.h>
diff --git a/arch/arm/mach-sc5xx/spl.c b/arch/arm/mach-sc5xx/spl.c
index c529829420d..94e4a08fa32 100644
--- a/arch/arm/mach-sc5xx/spl.c
+++ b/arch/arm/mach-sc5xx/spl.c
@@ -7,8 +7,8 @@
  */
=20
 #include <spl.h>
-#include <asm/arch-adi/sc5xx/sc5xx.h>
-#include <asm/arch-adi/sc5xx/spl.h>
+#include <asm/arch/sc5xx.h>
+#include <asm/arch/spl.h>
 #include "init/clkinit.h"
 #include "init/dmcinit.h"
=20
diff --git a/board/adi/carriers/somcrr_common.c b/board/adi/carriers/somcrr=
_common.c
index 34ae48f31d2..7bd890d6e70 100644
--- a/board/adi/carriers/somcrr_common.c
+++ b/board/adi/carriers/somcrr_common.c
@@ -3,7 +3,7 @@
  * (C) Copyright 2025 - Analog Devices, Inc.
  */
=20
-#include <asm/arch-adi/sc5xx/sc5xx.h>
+#include <asm/arch/sc5xx.h>
 #include <linux/delay.h>
=20
 #include "somcrr.h"
diff --git a/board/adi/common-sc594-som/sc594-som.c b/board/adi/common-sc59=
4-som/sc594-som.c
index aab729fc761..37817c4b062 100644
--- a/board/adi/common-sc594-som/sc594-som.c
+++ b/board/adi/common-sc594-som/sc594-som.c
@@ -6,8 +6,8 @@
 #include <config.h>
 #include <phy.h>
 #include <asm/u-boot.h>
-#include <asm/arch-adi/sc5xx/sc5xx.h>
-#include <asm/arch-adi/sc5xx/soc.h>
+#include <asm/arch/sc5xx.h>
+#include <asm/arch/soc.h>
=20
 #include "../carriers/somcrr.h"
=20
diff --git a/board/adi/common-sc598-som/sc598-som.c b/board/adi/common-sc59=
8-som/sc598-som.c
index 96b73520e66..0e1ee828956 100644
--- a/board/adi/common-sc598-som/sc598-som.c
+++ b/board/adi/common-sc598-som/sc598-som.c
@@ -6,8 +6,8 @@
 #include <config.h>
 #include <phy.h>
 #include <asm/u-boot.h>
-#include <asm/arch-adi/sc5xx/sc5xx.h>
-#include <asm/arch-adi/sc5xx/soc.h>
+#include <asm/arch/sc5xx.h>
+#include <asm/arch/soc.h>
 #include <asm/armv8/mmu.h>
=20
 #include "../carriers/somcrr.h"
diff --git a/board/adi/sc573-ezkit/sc573-ezkit.c b/board/adi/sc573-ezkit/sc=
573-ezkit.c
index 288c2670761..464142b27a5 100644
--- a/board/adi/sc573-ezkit/sc573-ezkit.c
+++ b/board/adi/sc573-ezkit/sc573-ezkit.c
@@ -5,8 +5,8 @@
=20
 #include <phy.h>
 #include <asm/u-boot.h>
-#include <asm/arch-adi/sc5xx/sc5xx.h>
-#include <asm/arch-adi/sc5xx/soc.h>
+#include <asm/arch/sc5xx.h>
+#include <asm/arch/soc.h>
=20
 int board_phy_config(struct phy_device *phydev)
 {
diff --git a/board/adi/sc584-ezkit/sc584-ezkit.c b/board/adi/sc584-ezkit/sc=
584-ezkit.c
index 288c2670761..464142b27a5 100644
--- a/board/adi/sc584-ezkit/sc584-ezkit.c
+++ b/board/adi/sc584-ezkit/sc584-ezkit.c
@@ -5,8 +5,8 @@
=20
 #include <phy.h>
 #include <asm/u-boot.h>
-#include <asm/arch-adi/sc5xx/sc5xx.h>
-#include <asm/arch-adi/sc5xx/soc.h>
+#include <asm/arch/sc5xx.h>
+#include <asm/arch/soc.h>
=20
 int board_phy_config(struct phy_device *phydev)
 {
diff --git a/board/adi/sc589-ezkit/sc589-ezkit.c b/board/adi/sc589-ezkit/sc=
589-ezkit.c
index 288c2670761..464142b27a5 100644
--- a/board/adi/sc589-ezkit/sc589-ezkit.c
+++ b/board/adi/sc589-ezkit/sc589-ezkit.c
@@ -5,8 +5,8 @@
=20
 #include <phy.h>
 #include <asm/u-boot.h>
-#include <asm/arch-adi/sc5xx/sc5xx.h>
-#include <asm/arch-adi/sc5xx/soc.h>
+#include <asm/arch/sc5xx.h>
+#include <asm/arch/soc.h>
=20
 int board_phy_config(struct phy_device *phydev)
 {
diff --git a/board/adi/sc589-mini/sc589-mini.c b/board/adi/sc589-mini/sc589=
-mini.c
index 288c2670761..464142b27a5 100644
--- a/board/adi/sc589-mini/sc589-mini.c
+++ b/board/adi/sc589-mini/sc589-mini.c
@@ -5,8 +5,8 @@
=20
 #include <phy.h>
 #include <asm/u-boot.h>
-#include <asm/arch-adi/sc5xx/sc5xx.h>
-#include <asm/arch-adi/sc5xx/soc.h>
+#include <asm/arch/sc5xx.h>
+#include <asm/arch/soc.h>
=20
 int board_phy_config(struct phy_device *phydev)
 {
diff --git a/drivers/net/dwc_eth_qos_adi.c b/drivers/net/dwc_eth_qos_adi.c
index b578225eaad..37db8525b48 100644
--- a/drivers/net/dwc_eth_qos_adi.c
+++ b/drivers/net/dwc_eth_qos_adi.c
@@ -15,7 +15,7 @@
 #include <reset.h>
 #include <linux/io.h>
=20
-#include <asm/arch-adi/sc5xx/sc5xx.h>
+#include <asm/arch/sc5xx.h>
=20
 #include "dwc_eth_qos.h"
=20
--=20
2.53.0

base-commit: eb95914b9f5886b7ca0eaa2dbcd8a66bb8e5f81a
branch: adsp-sys-soc

