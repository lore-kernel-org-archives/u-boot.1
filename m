Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF21C47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 14:53:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9354887D99;
	Tue, 23 Jan 2024 15:50:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBF6F87D58; Tue, 23 Jan 2024 15:50:23 +0100 (CET)
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::190c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5279187D6F
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 15:50:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [10.7.10.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TK93x4yvSzMqW4j;
 Tue, 23 Jan 2024 15:50:05 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4TK93w3mjKzVwk; Tue, 23 Jan 2024 15:50:04 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
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
Cc: heiko@sntech.de, Quentin Schulz <foss+uboot@0leil.net>,
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [PATCH 13/18] rockchip: rk3588: fix non-working SD controller if
 booting from other media
Date: Tue, 23 Jan 2024 15:49:21 +0100
Message-ID: <20240123-jaguar-v1-13-1eec1c34953c@theobroma-systems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123-jaguar-v1-0-1eec1c34953c@theobroma-systems.com>
References: <20240123-jaguar-v1-0-1eec1c34953c@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit
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

Rockchip SoCs have some jtag/sdmmc autoswitching that simply doesn't
work really well.[00] The Linux kernel disables it for all SoCs[01], so
U-Boot needs to do the same in order to fix issues related to SD card on
RK3588. This autoswitching is enabled (by default) via the force_jtag
bitfield in SYS_GRF_SOC_CON6 in the TRM part1.

For some reason, when booting from SD card, the BootROM does mux the
SDMMC controller in the proper configuration for the RK3588-Jaguar. But
when we don't boot from SD card, U-Boot needs to set it up correctly to
allow accessing SD cards in that configuration.

Therefore, let's disable the JTAG mode for the SDMMC pins so that the SD
controller can be used either as a fallback mechanism to find U-Boot
proper when the boot medium used to load TPL/SPL cannot find U-Boot
proper, or to be used in U-Boot CLI.

Note that soc_con[0] is reserved. But considering that it's way more
user-friendly to access soc_con1 from the TRM with soc_con[1] than
soc_con[0], and that soc_con0 would actually be located at 4 bytes
before soc_con1, let's just make soc_con0 part of the soc_con array.

[00] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c9b75d51c940c25587a2ad72ec7ec60490abfb6c
[01] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/soc/rockchip/grf.c

Cc: Quentin Schulz <foss+uboot@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 arch/arm/include/asm/arch-rockchip/grf_rk3588.h | 24 ++++++++++++++++++++++++
 arch/arm/mach-rockchip/rk3588/rk3588.c          |  7 +++++++
 2 files changed, 31 insertions(+)

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
diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
index 38e95a6e2b2..c5eeda9d751 100644
--- a/arch/arm/mach-rockchip/rk3588/rk3588.c
+++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
@@ -11,6 +11,7 @@
 #include <asm/arch-rockchip/bootrom.h>
 #include <asm/arch-rockchip/hardware.h>
 #include <asm/arch-rockchip/ioc_rk3588.h>
+#include <asm/arch-rockchip/grf_rk3588.h>
 
 #define FIREWALL_DDR_BASE		0xfe030000
 #define FW_DDR_MST5_REG			0x54
@@ -35,6 +36,8 @@
 #define BUS_IOC_GPIO2D_IOMUX_SEL_H	0x5c
 #define BUS_IOC_GPIO3A_IOMUX_SEL_L	0x60
 
+#define SYS_GRF_FORCE_JTAG		BIT(14)
+
 /**
  * Boot-device identifiers used by the BROM on RK3588 when device is booted
  * from SPI flash. IOMUX used for SPI flash affect the value used by the BROM
@@ -134,6 +137,7 @@ void rockchip_stimer_init(void)
 int arch_cpu_init(void)
 {
 #ifdef CONFIG_SPL_BUILD
+	static struct rk3588_sysgrf * const sys_grf = (void *)SYS_GRF_BASE;
 	int secure_reg;
 
 	/* Set the SDMMC eMMC crypto_ns FSPI access secure area */
@@ -168,6 +172,9 @@ int arch_cpu_init(void)
 	secure_reg = readl(FIREWALL_SYSMEM_BASE + FW_SYSM_MST27_REG);
 	secure_reg &= 0xffff0000;
 	writel(secure_reg, FIREWALL_SYSMEM_BASE + FW_SYSM_MST27_REG);
+
+	/* Disable JTAG exposed on SDMMC */
+	rk_clrreg(&sys_grf->soc_con[6], SYS_GRF_FORCE_JTAG);
 #endif
 
 	return 0;

-- 
2.43.0

