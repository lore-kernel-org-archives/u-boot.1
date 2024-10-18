Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5151ED374BF
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 16:35:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF31988E33;
	Fri, 18 Oct 2024 18:34:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="lakn2rVE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A28C288E33; Fri, 18 Oct 2024 18:34:55 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 573AB88DF8
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 18:34:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=9e6c=RP=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1729269281; bh=0UeqtiCYWTmGxo73lRQ6tEe6rzKlYK3AEGW0vZjc1eo=;
 b=lakn2rVEE5PhW7j6dXE3rLAXXbibmYMt6IayTCmLtl3EpjkTEk0ajneeI1UyQgd5w782cCv0z
 iilgCK3a/ApO+LIYxOB9xbZDMPr3xmi3db95aRdzb+2lsP5eE4watMxnmB7SvkoRjJLNn2wB+68
 sJZZuggd9st2vPiMII8U/b09h2s4WsDSCDINOAGM0gPppIK5KDzWLm9gKNuOkKvG/VN2zN5o2k1
 xcCgEnl2RZEqbSXrFj8gpM3RipMFoDLXGwXN261WReQOVJnpOwFW0Bij3sHMClfE0gP+yAPPtXO
 DgUTUXeeTiDvQPig0V7snhfpZoiB7pV4vCXjL3NopS6g==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Dragan Simic <dsimic@manjaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Subject: [PATCH 2/2] rockchip: rk3588: Implement checkboard() to print SoC
 variant
Date: Fri, 18 Oct 2024 16:34:18 +0000
Message-ID: <20241018163423.1562287-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241018163423.1562287-1-jonas@kwiboo.se>
References: <20241018163423.1562287-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 67128e1f3b4db30540b6b5f5
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

Implement checkboard() to print current SoC model, e.g. one of:

  SoC:   RK3582 v1
  SoC:   RK3588 v0
  SoC:   RK3588 v1
  SoC:   RK3588S v0
  SoC:   RK3588S v1
  SoC:   RK3588S2 v1

when U-Boot proper is started.

Information about what SoC model, variant and version is read from OTP.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3588s-u-boot.dtsi       |  4 ++
 arch/arm/mach-rockchip/rk3588/rk3588.c | 56 ++++++++++++++++++++++++++
 configs/generic-rk3588_defconfig       |  2 +-
 3 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
index 09d8b311cec5..8880d162b11c 100644
--- a/arch/arm/dts/rk3588s-u-boot.dtsi
+++ b/arch/arm/dts/rk3588s-u-boot.dtsi
@@ -69,6 +69,10 @@
 	bootph-all;
 };
 
+&otp {
+	bootph-some-ram;
+};
+
 &pcfg_pull_down {
 	bootph-all;
 };
diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
index e2dac2a5b806..6317fabd5de3 100644
--- a/arch/arm/mach-rockchip/rk3588/rk3588.c
+++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
@@ -4,6 +4,8 @@
  * Copyright (c) 2022 Edgeble AI Technologies Pvt. Ltd.
  */
 
+#include <dm.h>
+#include <misc.h>
 #include <spl.h>
 #include <asm/armv8/mmu.h>
 #include <asm/arch-rockchip/bootrom.h>
@@ -178,3 +180,57 @@ int arch_cpu_init(void)
 	return 0;
 }
 #endif
+
+#define RK3588_OTP_CPU_CODE_OFFSET		0x02
+#define RK3588_OTP_SPECIFICATION_OFFSET		0x06
+#define RK3588_OTP_CPU_VERSION_OFFSET		0x1c
+
+int checkboard(void)
+{
+	u8 cpu_code[2], specification, package, cpu_version;
+	struct udevice *dev;
+	char suffix[3];
+	int ret;
+
+	ret = uclass_get_device_by_driver(UCLASS_MISC,
+					  DM_DRIVER_GET(rockchip_otp), &dev);
+	if (ret) {
+		debug("%s: could not find otp device, ret=%d\n", __func__, ret);
+		return 0;
+	}
+
+	/* cpu-code: SoC model, 0x35 0x82 or 0x35 0x88 */
+	ret = misc_read(dev, RK3588_OTP_CPU_CODE_OFFSET, cpu_code, 2);
+	if (ret < 0) {
+		debug("%s: could not read cpu-code, ret=%d\n", __func__, ret);
+		return 0;
+	}
+
+	/* specification: SoC variant, 0x2 for RK3588S and RK3588S2 */
+	ret = misc_read(dev, RK3588_OTP_SPECIFICATION_OFFSET, &specification, 1);
+	if (ret < 0) {
+		debug("%s: could not read specification, ret=%d\n", __func__, ret);
+		return 0;
+	}
+	/* package: likely SoC variant revision, 0x2 for RK3588S2 */
+	package = specification >> 5;
+	specification &= 0x1f;
+
+	/* cpu-version: chip version, e.g. second letter of lot number */
+	ret = misc_read(dev, RK3588_OTP_CPU_VERSION_OFFSET, &cpu_version, 1);
+	if (ret < 0) {
+		debug("%s: could not read cpu-version, ret=%d\n", __func__, ret);
+		return 0;
+	}
+	cpu_version >>= 3;
+	cpu_version &= 0x7;
+
+	suffix[0] = specification > 1 ? '@' + specification : 0;
+	suffix[1] = package > 1 ? '0' + package : 0;
+	suffix[2] = 0;
+
+	printf("SoC:   RK%02x%02x%s v%u\n",
+	       cpu_code[0], cpu_code[1], suffix, cpu_version);
+
+	return 0;
+}
diff --git a/configs/generic-rk3588_defconfig b/configs/generic-rk3588_defconfig
index ebe883ed5972..51e31dce3a96 100644
--- a/configs/generic-rk3588_defconfig
+++ b/configs/generic-rk3588_defconfig
@@ -18,13 +18,13 @@ CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-generic.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
-CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
+CONFIG_CMD_MISC=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_ROCKUSB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
-- 
2.46.2

