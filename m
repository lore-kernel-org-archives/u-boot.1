Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85806D5E38C
	for <u-boot@archiver.kernel.org>; Sun, 10 Nov 2024 00:57:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF20F8933F;
	Sun, 10 Nov 2024 01:56:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="H6zhAu39";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11A168933F; Sun, 10 Nov 2024 01:56:44 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A24E788D7E
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 01:56:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f1ff=SF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1731200196; bh=pUQBFuENAiRELvqs5LCI3LVBO4WvkTjNDKugOJKOcFA=;
 b=H6zhAu39Gyxbd0s+jrvijSODqozyo9zDulnuhfsi8eBrJ0WB6Go6+iSAASGvTg7zz2cVe7Dab
 6c2zxfGoLaMbSmLHvOb2a1lNCPRXUCctPF3RyypwZMMOv4CLbDDwARaY5LqqRDFWeXrEewTfCS2
 mjygb2l+P2JXcWvhtFTyJ3YgH6Jz/ZJhItR+IthNWc4J2ji1/c0SSUTM2TQwYHcP3Oq2N+zZBXO
 vK6fbtsYGyMnIqXVUUeztnAY9Yue8MO6HrLn0eC+/2HOsNCsw8nFoe1KpDOlI6+1u+9FqBnEwOM
 wWx3+yhcVTYUA+hJzO4HLcFWcxtdsa/s91qTr9uTpl2w==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 2/3] rockchip: rk3588: Implement checkboard() to print SoC
 variant
Date: Sun, 10 Nov 2024 00:56:16 +0000
Message-ID: <20241110005622.1515100-3-jonas@kwiboo.se>
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
 149.28.215.223
X-ForwardEmail-ID: 673004c31e684d476418c04f
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

  SoC:   RK3582
  SoC:   RK3588
  SoC:   RK3588J
  SoC:   RK3588S
  SoC:   RK3588S2

when U-Boot proper is running.

  U-Boot 2025.01-rc1 (Nov 10 2024 - 00:31:29 +0000)

  Model: Generic RK3588S/RK3588
  SoC:   RK3588S2
  DRAM:  8 GiB

Information about the SoC model and variant is read from OTP.

Also update rk3588s-u-boot.dtsi to include OTP in U-Boot pre-reloc phase,
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
- Drop generic-rk3588_defconfig change
---
 arch/arm/dts/rk3588s-u-boot.dtsi       |  4 ++
 arch/arm/mach-rockchip/rk3588/rk3588.c | 52 ++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

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
index e2dac2a5b806..c1dce3ee3703 100644
--- a/arch/arm/mach-rockchip/rk3588/rk3588.c
+++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
@@ -4,6 +4,10 @@
  * Copyright (c) 2022 Edgeble AI Technologies Pvt. Ltd.
  */
 
+#define LOG_CATEGORY LOGC_ARCH
+
+#include <dm.h>
+#include <misc.h>
 #include <spl.h>
 #include <asm/armv8/mmu.h>
 #include <asm/arch-rockchip/bootrom.h>
@@ -178,3 +182,51 @@ int arch_cpu_init(void)
 	return 0;
 }
 #endif
+
+#define RK3588_OTP_CPU_CODE_OFFSET		0x02
+#define RK3588_OTP_SPECIFICATION_OFFSET		0x06
+
+int checkboard(void)
+{
+	u8 cpu_code[2], specification, package;
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
+	/* cpu-code: SoC model, e.g. 0x35 0x82 or 0x35 0x88 */
+	ret = misc_read(dev, RK3588_OTP_CPU_CODE_OFFSET, cpu_code, 2);
+	if (ret < 0) {
+		log_debug("Could not read cpu-code, ret=%d\n", ret);
+		return 0;
+	}
+
+	/* specification: SoC variant, e.g. 0xA for RK3588J and 0x13 for RK3588S */
+	ret = misc_read(dev, RK3588_OTP_SPECIFICATION_OFFSET, &specification, 1);
+	if (ret < 0) {
+		log_debug("Could not read specification, ret=%d\n", ret);
+		return 0;
+	}
+	/* package: likely SoC variant revision, 0x2 for RK3588S2 */
+	package = specification >> 5;
+	specification &= 0x1f;
+
+	/* for RK3588J i.e. '@' + 0xA = 'J' */
+	suffix[0] = specification > 1 ? '@' + specification : '\0';
+	/* for RK3588S2 i.e. '0' + 0x2 = '2' */
+	suffix[1] = package > 1 ? '0' + package : '\0';
+	suffix[2] = '\0';
+
+	printf("SoC:   RK%02x%02x%s\n", cpu_code[0], cpu_code[1], suffix);
+
+	return 0;
+}
-- 
2.46.2

