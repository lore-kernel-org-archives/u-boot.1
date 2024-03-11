Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2034DC5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 12:04:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FA1588018;
	Mon, 11 Mar 2024 13:03:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A7E687F63; Mon, 11 Mar 2024 13:03:13 +0100 (CET)
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::8fa9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B93487F63
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 13:02:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Ttb4x1RVPzttC;
 Mon, 11 Mar 2024 13:02:57 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Ttb4w2Xrtz1sg; Mon, 11 Mar 2024 13:02:56 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 11 Mar 2024 13:01:54 +0100
Subject: [PATCH v4 11/20] rockchip: rk3588: disable force_jtag by default
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240311-jaguar-v4-11-d2ca1af68ed3@theobroma-systems.com>
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

Rockchip SoCs can automatically switch between jtag and sdmmc based on
the following rules:
- all the SDMMC pins including SDMMC_DET set as SDMMC function in GRF,
- force_jtag bit in GRF is 1,
- SDMMC_DET is low (no card detected),

Note that the BootROM may mux all SDMMC pins in their SDMMC function or
not, depending on the boot medium that were tried.

Because SDMMC_DET pin is not guaranteed to be used as an SD card card
detect pin, it could be low at boot or even switch at runtime, which
would enable the jtag function and render the SD card unusable.

This is the case for RK3588 Jaguar for example which has an SD card
connector without an SD card card detect signal and has SDMMC_DET
connected to ground.

Because enabling JTAG at runtime could be a security issue and also to
make sure that we have a consistent behavior on all boards by default,
let's disable this force_jtag feature.

However, let's make it easy to reenable it for debugging purposes by
hiding it behind a Kconfig symbol.

Note that soc_con[0] is reserved. But considering that it's way more
user-friendly to access soc_con1 from the TRM with soc_con[1] than
soc_con[0], and that soc_con0 would actually be located at 4 bytes
before soc_con1, let's just make soc_con0 part of the soc_con array.

Cc: Quentin Schulz <foss+uboot@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 arch/arm/include/asm/arch-rockchip/grf_rk3588.h | 24 ++++++++++++++++++++++++
 arch/arm/mach-rockchip/Kconfig                  | 24 ++++++++++++++++++++++++
 arch/arm/mach-rockchip/rk3588/rk3588.c          | 11 +++++++++++
 3 files changed, 59 insertions(+)

diff --git a/arch/arm/include/asm/arch-rockchip/grf_rk3588.h b/arch/arm/include/asm/arch-rockchip/grf_rk3588.h
index e0694068bb1..f0ecff97f0b 100644
--- a/arch/arm/include/asm/arch-rockchip/grf_rk3588.h
+++ b/arch/arm/include/asm/arch-rockchip/grf_rk3588.h
@@ -32,4 +32,28 @@ struct rk3588_pmu1grf {
 
 check_member(rk3588_pmu1grf, sd_detect_cnt, 0x03b0);
 
+#define SYS_GRF_BASE	0xfd58c000
+
+struct rk3588_sysgrf {
+	unsigned int wdt_con0;
+	unsigned int reserved0[(0x0010 - 0x0000) / 4 - 1];
+	unsigned int uart_con[2];
+	unsigned int reserved1[(0x00c0 - 0x0014) / 4 - 1];
+	unsigned int gic_con0;
+	unsigned int reserved2[(0x0200 - 0x00c0) / 4 - 1];
+	unsigned int memcfg_con[32];
+	unsigned int reserved3[(0x0300 - 0x027c) / 4 - 1];
+	/* soc_con0 is reserved */
+	unsigned int soc_con[14];
+	unsigned int reserved4[(0x0380 - 0x0334) / 4 - 1];
+	unsigned int soc_status[4];
+	unsigned int reserved5[(0x0500 - 0x038c) / 4 - 1];
+	unsigned int otp_key08;
+	unsigned int otp_key0d;
+	unsigned int otp_key0e;
+	unsigned int reserved6[(0x0600 - 0x0508) / 4 - 1];
+	unsigned int chip_id;
+};
+
+check_member(rk3588_sysgrf, chip_id, 0x0600);
 #endif /*__SOC_ROCKCHIP_RK3588_GRF_H__ */
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 1bc7ee90427..343361a5327 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -501,6 +501,30 @@ config SPL_ROCKCHIP_EARLYRETURN_TO_BROM
 	  This enables support code in the BOOT0 hook for the SPL stage
 	  to allow multiple entries.
 
+config ROCKCHIP_DISABLE_FORCE_JTAG
+	bool "Disable force_jtag feature"
+	default y
+	depends on SPL
+	help
+	  Rockchip SoCs can automatically switch between jtag and sdmmc based
+	  on the following rules:
+	  - all the SDMMC pins including SDMMC_DET set as SDMMC function in
+	    GRF,
+	  - force_jtag bit in GRF is 1,
+	  - SDMMC_DET is low (no card detected),
+
+	  Some HW design may not route the SD card card detect to SDMMC_DET
+	  pin, thus breaking the SD card support in some cases because JTAG
+	  would be auto-enabled by mistake.
+
+	  Also, enabling JTAG at runtime may be an undesired feature, e.g.
+	  because it could be a security vulnerability.
+
+	  This disables force_jtag feature, which you may want for debugging
+	  purposes.
+
+	  If unsure, say Y.
+
 config TPL_ROCKCHIP_EARLYRETURN_TO_BROM
         bool "TPL requires early-return (for RK3188-style BROM) to BROM"
 	depends on TPL && ENABLE_ARM_SOC_BOOT0_HOOK
diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
index 38e95a6e2b2..d18c4e4b411 100644
--- a/arch/arm/mach-rockchip/rk3588/rk3588.c
+++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
@@ -9,6 +9,7 @@
 #include <asm/armv8/mmu.h>
 #include <asm/io.h>
 #include <asm/arch-rockchip/bootrom.h>
+#include <asm/arch-rockchip/grf_rk3588.h>
 #include <asm/arch-rockchip/hardware.h>
 #include <asm/arch-rockchip/ioc_rk3588.h>
 
@@ -35,6 +36,8 @@
 #define BUS_IOC_GPIO2D_IOMUX_SEL_H	0x5c
 #define BUS_IOC_GPIO3A_IOMUX_SEL_L	0x60
 
+#define SYS_GRF_FORCE_JTAG		BIT(14)
+
 /**
  * Boot-device identifiers used by the BROM on RK3588 when device is booted
  * from SPI flash. IOMUX used for SPI flash affect the value used by the BROM
@@ -134,6 +137,9 @@ void rockchip_stimer_init(void)
 int arch_cpu_init(void)
 {
 #ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_ROCKCHIP_DISABLE_FORCE_JTAG
+	static struct rk3588_sysgrf * const sys_grf = (void *)SYS_GRF_BASE;
+#endif
 	int secure_reg;
 
 	/* Set the SDMMC eMMC crypto_ns FSPI access secure area */
@@ -168,6 +174,11 @@ int arch_cpu_init(void)
 	secure_reg = readl(FIREWALL_SYSMEM_BASE + FW_SYSM_MST27_REG);
 	secure_reg &= 0xffff0000;
 	writel(secure_reg, FIREWALL_SYSMEM_BASE + FW_SYSM_MST27_REG);
+
+#ifdef CONFIG_ROCKCHIP_DISABLE_FORCE_JTAG
+	/* Disable JTAG exposed on SDMMC */
+	rk_clrreg(&sys_grf->soc_con[6], SYS_GRF_FORCE_JTAG);
+#endif
 #endif
 
 	return 0;

-- 
2.44.0

