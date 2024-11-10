Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 827B0D5E38C
	for <u-boot@archiver.kernel.org>; Sun, 10 Nov 2024 00:56:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5777A89336;
	Sun, 10 Nov 2024 01:56:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="yKL3WA4S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF3828932C; Sun, 10 Nov 2024 01:56:42 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ECF4892ED
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 01:56:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f1ff=SF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1731200194; bh=bKZmv9tAU0OkUmsgJ+OoLNDvZSqNh8MXzfyb+6dJBjg=;
 b=yKL3WA4SfRxIS8z5BT3jMSBuidrqVr50VJ+LD1dRsOITwXIrHf2QVYOgP767Q3rPosHQDTbb1
 qZuGtcAc+WwoRQTbxjunWE48xoQxaOsAQJbgowx26mnZ4iE5yiojy3JXGKcqxi9wQPwB6oo2Uy3
 r5CZlF9h2O5UHIpBoXIW/DeRlFYmlKv5pCPOAoQb27h+NSaGZlCPaow1eEMid+ezf870Xjsww8P
 MI7c/pdC47POgN0uS+SzlDmvvhEfqknu7GRnIS/SzytCW/2RQ7S8wTmskZ1o2ypRDjEQs7ZCZBz
 A90/Rq+DfAI3Mg7v1YWbeqBYTxoPTzTUzepqvCNePySg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 1/3] rockchip: rk356x: Implement checkboard() to print SoC
 variant
Date: Sun, 10 Nov 2024 00:56:15 +0000
Message-ID: <20241110005622.1515100-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241110005622.1515100-1-jonas@kwiboo.se>
References: <20241110005622.1515100-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 673004c01e684d476418c026
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

Implement checkboard() to print current SoC model used by a board,
e.g. one of:

  SoC:   RK3566
  SoC:   RK3566T
  SoC:   RK3568
  SoC:   RK3568B2
  SoC:   RK3568J

when U-Boot proper is running.

  U-Boot 2025.01-rc1 (Nov 10 2024 - 00:39:37 +0000)

  Model: Generic RK3566/RK3568
  SoC:   RK3568J
  DRAM:  8 GiB (effective 7.7 GiB)

Information about the SoC model and variant is read from OTP.

Also update rk356x-u-boot.dtsi to include OTP in U-Boot pre-reloc phase,
where checkboard() is called.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v3:
- Fix build issue with MISC=n or ROCKCHIP_OTP=n
- Remove use of cpu-version
- Use log_debug() instead of debug()
v2:
- Update commit message
- Update code comments
- Drop generic-rk3568_defconfig change
---
 arch/arm/dts/rk356x-u-boot.dtsi        |  4 ++
 arch/arm/mach-rockchip/rk3568/rk3568.c | 61 ++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/arch/arm/dts/rk356x-u-boot.dtsi b/arch/arm/dts/rk356x-u-boot.dtsi
index 0a0943b462a9..24a976cf7e21 100644
--- a/arch/arm/dts/rk356x-u-boot.dtsi
+++ b/arch/arm/dts/rk356x-u-boot.dtsi
@@ -87,6 +87,10 @@
 	bootph-all;
 };
 
+&otp {
+	bootph-some-ram;
+};
+
 &pcfg_pull_none {
 	bootph-all;
 };
diff --git a/arch/arm/mach-rockchip/rk3568/rk3568.c b/arch/arm/mach-rockchip/rk3568/rk3568.c
index c9a32287e924..c2b96902d2dd 100644
--- a/arch/arm/mach-rockchip/rk3568/rk3568.c
+++ b/arch/arm/mach-rockchip/rk3568/rk3568.c
@@ -3,7 +3,10 @@
  * (C) Copyright 2021 Rockchip Electronics Co., Ltd
  */
 
+#define LOG_CATEGORY LOGC_ARCH
+
 #include <dm.h>
+#include <misc.h>
 #include <asm/armv8/mmu.h>
 #include <asm/arch-rockchip/bootrom.h>
 #include <asm/arch-rockchip/grf_rk3568.h>
@@ -139,3 +142,61 @@ int arch_cpu_init(void)
 #endif
 	return 0;
 }
+
+#define RK3568_OTP_CPU_CODE_OFFSET		0x02
+#define RK3568_OTP_SPECIFICATION_OFFSET		0x07
+#define RK3568_OTP_PERFORMANCE_OFFSET		0x22
+
+int checkboard(void)
+{
+	u8 cpu_code[2], specification, package, performance;
+	struct udevice *dev;
+	char suffix[3];
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
+	/* cpu-code: SoC model, e.g. 0x35 0x66 or 0x35 0x68 */
+	ret = misc_read(dev, RK3568_OTP_CPU_CODE_OFFSET, cpu_code, 2);
+	if (ret < 0) {
+		log_debug("Could not read cpu-code, ret=%d\n", ret);
+		return 0;
+	}
+
+	/* specification: SoC variant, e.g. 0x2 for RK3568B2 and 0xA for RK3568J */
+	ret = misc_read(dev, RK3568_OTP_SPECIFICATION_OFFSET, &specification, 1);
+	if (ret < 0) {
+		log_debug("Could not read specification, ret=%d\n", ret);
+		return 0;
+	}
+	/* package: likely SoC variant revision, 0x2 for RK3568B2 */
+	package = specification >> 5;
+	specification &= 0x1f;
+
+	/* performance: used to identify RK3566T SoC variant */
+	ret = misc_read(dev, RK3568_OTP_PERFORMANCE_OFFSET, &performance, 1);
+	if (ret < 0) {
+		log_debug("Could not read performance, ret=%d\n", ret);
+		return 0;
+	}
+	if (performance & 0x0f)
+		specification = 0x14; /* T-variant */
+
+	/* for RK3568J i.e. '@' + 0xA = 'J' */
+	suffix[0] = specification > 1 ? '@' + specification : '\0';
+	/* for RK3568B2 i.e. '0' + 0x2 = '2' */
+	suffix[1] = package > 1 ? '0' + package : '\0';
+	suffix[2] = '\0';
+
+	printf("SoC:   RK%02x%02x%s\n", cpu_code[0], cpu_code[1], suffix);
+
+	return 0;
+}
-- 
2.46.2

