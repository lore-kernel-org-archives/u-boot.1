Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D19BC369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 21:12:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 533E082006;
	Tue, 22 Apr 2025 23:12:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ygFPbdZ7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C91B28003E; Tue, 22 Apr 2025 23:12:34 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75A55817C4
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 23:12:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=e320=XJ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1745356351; bh=jFhR6bklT6Delz3Ar3qrss5Da4d4wJXcUprPbaEcyGo=;
 b=ygFPbdZ7nFBnvRoMQWaexY5S4hUYF5ab7LEHyz25xQpObdNgyH2ENvka8ylzSBDYA5xrNP0Od
 dXqgRBxrRjF6GRgCMunKT4fcCEI+qSEu9YrMDQvgI0FO4uy00dxGyOMTqgO7y/56ggG5pPZa60g
 DIq2GQ5o8ZuZoIamhZL54Z/kpSCodvceW3cyLR4tMCAHI+aO3ovx/P9wLoKXh1O7lsJfyjAPhWw
 4ZomP3fL3ExdXZxHAyXjrGRETtPHTW56EHoRYNR9D5vy1CqnC2UajFZq/nglIga3LACoFhzTBeX
 Sfl3i34sHqDPne9F6j/bT14OnY0wjBks19niGxZw/q2g==
X-Forward-Email-ID: 6808063e305f69a6701c59aa
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 2/4] rockchip: rk3576: Implement checkboard() to print SoC
 variant
Date: Tue, 22 Apr 2025 21:12:07 +0000
Message-ID: <20250422211216.3727559-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250422211216.3727559-1-jonas@kwiboo.se>
References: <20250422211216.3727559-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Implement checkboard() to print current SoC model used by a board when
U-Boot proper is running.

  U-Boot 2025.04 (Apr 22 2025 - 20:43:17 +0000)

  Model: Generic RK3576
  SoC:   RK3576
  DRAM:  8 GiB

Information about the SoC model and variant is read from OTP.

Also update rk3576-u-boot.dtsi to include OTP in U-Boot pre-reloc phase,
where checkboard() is called.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3576-u-boot.dtsi        |  4 +++
 arch/arm/mach-rockchip/rk3576/rk3576.c | 48 ++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/arch/arm/dts/rk3576-u-boot.dtsi b/arch/arm/dts/rk3576-u-boot.dtsi
index 928960862597..c623bf544688 100644
--- a/arch/arm/dts/rk3576-u-boot.dtsi
+++ b/arch/arm/dts/rk3576-u-boot.dtsi
@@ -56,6 +56,10 @@
 	bootph-all;
 };
 
+&otp {
+	bootph-some-ram;
+};
+
 &pcfg_pull_none {
 	bootph-all;
 };
diff --git a/arch/arm/mach-rockchip/rk3576/rk3576.c b/arch/arm/mach-rockchip/rk3576/rk3576.c
index ba5c94b4b3dd..2b1318f9532f 100644
--- a/arch/arm/mach-rockchip/rk3576/rk3576.c
+++ b/arch/arm/mach-rockchip/rk3576/rk3576.c
@@ -3,6 +3,10 @@
  * Copyright (c) 2024 Rockchip Electronics Co., Ltd
  */
 
+#define LOG_CATEGORY LOGC_ARCH
+
+#include <dm.h>
+#include <misc.h>
 #include <asm/armv8/mmu.h>
 #include <asm/arch-rockchip/bootrom.h>
 #include <asm/arch-rockchip/hardware.h>
@@ -153,3 +157,47 @@ int arch_cpu_init(void)
 
 	return 0;
 }
+
+#define RK3576_OTP_CPU_CODE_OFFSET		0x02
+#define RK3576_OTP_SPECIFICATION_OFFSET		0x08
+
+int checkboard(void)
+{
+	u8 cpu_code[2], specification;
+	struct udevice *dev;
+	char suffix[2];
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_ROCKCHIP_OTP) || !CONFIG_IS_ENABLED(MISC))
+		return 0;
+
+	ret = uclass_get_device_by_driver(UCLASS_MISC,
+					  DM_DRIVER_GET(rockchip_otp), &dev);
+	if (ret) {
+		log_debug("Could not find otp device, ret=%d\n", ret);
+		return 0;
+	}
+
+	/* cpu-code: SoC model, e.g. 0x35 0x76 */
+	ret = misc_read(dev, RK3576_OTP_CPU_CODE_OFFSET, cpu_code, 2);
+	if (ret < 0) {
+		log_debug("Could not read cpu-code, ret=%d\n", ret);
+		return 0;
+	}
+
+	/* specification: SoC variant, e.g. 0xA for RK3576J */
+	ret = misc_read(dev, RK3576_OTP_SPECIFICATION_OFFSET, &specification, 1);
+	if (ret < 0) {
+		log_debug("Could not read specification, ret=%d\n", ret);
+		return 0;
+	}
+	specification &= 0x1f;
+
+	/* for RK3576J i.e. '@' + 0xA = 'J' */
+	suffix[0] = specification > 1 ? '@' + specification : '\0';
+	suffix[1] = '\0';
+
+	printf("SoC:   RK%02x%02x%s\n", cpu_code[0], cpu_code[1], suffix);
+
+	return 0;
+}
-- 
2.49.0

