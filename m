Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3102CC5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 12:05:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E79D887F63;
	Mon, 11 Mar 2024 13:03:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A556487F3F; Mon, 11 Mar 2024 13:03:16 +0100 (CET)
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch
 [83.166.143.173])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A28287ED6
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 13:02:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Ttb4y0Zy8zpkw;
 Mon, 11 Mar 2024 13:02:58 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Ttb4x1KTGz3k; Mon, 11 Mar 2024 13:02:57 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 11 Mar 2024 13:01:55 +0100
Subject: [PATCH v4 12/20] rockchip: rk3588: add constants for some register
 address spaces
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240311-jaguar-v4-12-d2ca1af68ed3@theobroma-systems.com>
References: <20240311-jaguar-v4-0-d2ca1af68ed3@theobroma-systems.com>
In-Reply-To: <20240311-jaguar-v4-0-d2ca1af68ed3@theobroma-systems.com>
To: Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, 
 Otavio Salvador <otavio@ossystems.com.br>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Anatolij Gustschin <agust@denx.de>
Cc: Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Quentin Schulz <foss+uboot@0leil.net>
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

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

It's one thing to have the register mapped via a well-defined struct but
it's another to be able to make use of it. For that to happen, one needs
to cast the physical address memory of the beginning of the register
address space with the struct. Since this cannot change, let's hardcode
it in the include files so that users do not need to duplicate this line
of code in their own implementation.

Cc: Quentin Schulz <foss+uboot@0leil.net>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 arch/arm/include/asm/arch-rockchip/cru_rk3588.h | 2 ++
 arch/arm/include/asm/arch-rockchip/ioc_rk3588.h | 6 ++++++
 arch/arm/mach-rockchip/rk3588/rk3588.c          | 4 ----
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
index 7f4a9085392..a4507e5fdd7 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
@@ -63,6 +63,8 @@ struct rk3588_pll {
 	unsigned int reserved0[3];
 };
 
+#define CRU_BASE	0xfd7c0000
+
 struct rk3588_cru {
 	struct rk3588_pll pll[18];
 	unsigned int reserved0[16];/* Address Offset: 0x0240 */
diff --git a/arch/arm/include/asm/arch-rockchip/ioc_rk3588.h b/arch/arm/include/asm/arch-rockchip/ioc_rk3588.h
index 5a656f850c7..7ad98466c39 100644
--- a/arch/arm/include/asm/arch-rockchip/ioc_rk3588.h
+++ b/arch/arm/include/asm/arch-rockchip/ioc_rk3588.h
@@ -5,6 +5,8 @@
 #ifndef _ASM_ARCH_IOC_RK3588_H
 #define _ASM_ARCH_IOC_RK3588_H
 
+#define BUS_IOC_BASE	0xfd5f8000
+
 struct rk3588_bus_ioc {
 	unsigned int reserved0000[3];      /* Address Offset: 0x0000 */
 	unsigned int gpio0b_iomux_sel_h;   /* Address Offset: 0x000C */
@@ -48,6 +50,8 @@ struct rk3588_bus_ioc {
 
 check_member(rk3588_bus_ioc, gpio4d_iomux_sel_h, 0x009C);
 
+#define PMU1_IOC_BASE	0xfd5f0000
+
 struct rk3588_pmu1_ioc {
 	unsigned int gpio0a_iomux_sel_l;   /* Address Offset: 0x0000 */
 	unsigned int gpio0a_iomux_sel_h;   /* Address Offset: 0x0004 */
@@ -70,6 +74,8 @@ struct rk3588_pmu1_ioc {
 
 check_member(rk3588_pmu1_ioc, xin_con, 0x0040);
 
+#define PMU2_IOC_BASE	0xfd5f4000
+
 struct rk3588_pmu2_ioc {
 	unsigned int gpio0b_iomux_sel_h;  /* Address Offset: 0x0000 */
 	unsigned int gpio0c_iomux_sel_l;  /* Address Offset: 0x0004 */
diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
index d18c4e4b411..7a190e6aa18 100644
--- a/arch/arm/mach-rockchip/rk3588/rk3588.c
+++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
@@ -26,10 +26,6 @@
 #define FW_SYSM_MST26_REG		0xa8
 #define FW_SYSM_MST27_REG		0xac
 
-#define PMU1_IOC_BASE			0xfd5f0000
-#define PMU2_IOC_BASE			0xfd5f4000
-
-#define BUS_IOC_BASE			0xfd5f8000
 #define BUS_IOC_GPIO2A_IOMUX_SEL_L	0x40
 #define BUS_IOC_GPIO2B_IOMUX_SEL_L	0x48
 #define BUS_IOC_GPIO2D_IOMUX_SEL_L	0x58

-- 
2.44.0

