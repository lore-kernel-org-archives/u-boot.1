Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71458E6780C
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 20:38:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E82E88901D;
	Sat,  2 Nov 2024 21:38:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="cTpEF4UC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F543890D5; Sat,  2 Nov 2024 21:38:09 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44EFE8901D
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 21:38:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4e10=R6=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1730579879; bh=+1ri03nnFOHLJbormyXbiWBkh71znmnN0kqnU9NKBns=;
 b=cTpEF4UCdsNEm6yMkapLCWSlSSBdw/ryijgXAr4G7VKE6N84pJn09StGLneQGScY1+uIt+Xow
 UdOSZ2jeKl7BsiNJjhMF5s8mMHt1A0tIg6TNTvdvtVWVsJrKy1dsEdtUOq8NJuxPzv9INe0IgMu
 6IN6vjsn6fYvfnWV0/duu08CjYgCcuGvCCv+GFLLjTvfijUZJrgda+fbc70Pwd5RqrpDqmKbH94
 3Wyl/hlC9RmOp9p5tS0TQ3rtW2kOfOfRkCBaQG3y4d3m+jqOcl/ID9RJBb/R0KmzAaZfL0SrgJt
 kr8Oc8NDbj+Sv6GT2W4QK9hBzsVbfeOiW5N9g/GQH2/w==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Dragan Simic <dsimic@manjaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 1/3] rockchip: rk356x: Implement checkboard() to print SoC
 variant
Date: Sat,  2 Nov 2024 20:37:39 +0000
Message-ID: <20241102203746.3631481-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241102203746.3631481-1-jonas@kwiboo.se>
References: <20241102203746.3631481-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 67268da5922720f2eae90215
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

  SoC:   RK3566 v1
  SoC:   RK3566 v2
  SoC:   RK3566T v2
  SoC:   RK3568 v2
  SoC:   RK3568B2 v2
  SoC:   RK3568J v2

when U-Boot proper is running.

  U-Boot 2025.01-rc1 (Nov 02 2024 - 20:21:06 +0000)

  Model: Generic RK3566/RK3568
  SoC:   RK3568J v2
  DRAM:  8 GiB (effective 7.7 GiB)

Information about the SoC model, variant and version is read from OTP.

Also update rk356x-u-boot.dtsi to include OTP in U-Boot pre-reloc phase,
where checkboard() is called.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2:
- Update commit message
- Update code comments
- Drop generic-rk3568_defconfig change
---
 arch/arm/dts/rk356x-u-boot.dtsi        |  4 ++
 arch/arm/mach-rockchip/rk3568/rk3568.c | 67 ++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

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
index c9a32287e924..afa277ea5c61 100644
--- a/arch/arm/mach-rockchip/rk3568/rk3568.c
+++ b/arch/arm/mach-rockchip/rk3568/rk3568.c
@@ -4,6 +4,7 @@
  */
 
 #include <dm.h>
+#include <misc.h>
 #include <asm/armv8/mmu.h>
 #include <asm/arch-rockchip/bootrom.h>
 #include <asm/arch-rockchip/grf_rk3568.h>
@@ -139,3 +140,69 @@ int arch_cpu_init(void)
 #endif
 	return 0;
 }
+
+#define RK3568_OTP_CPU_CODE_OFFSET		0x02
+#define RK3568_OTP_SPECIFICATION_OFFSET		0x07
+#define RK3568_OTP_CPU_VERSION_OFFSET		0x08
+#define RK3568_OTP_PERFORMANCE_OFFSET		0x22
+
+int checkboard(void)
+{
+	u8 cpu_code[2], specification, package, cpu_version, performance;
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
+	/* cpu-code: SoC model, e.g. 0x35 0x66 or 0x35 0x68 */
+	ret = misc_read(dev, RK3568_OTP_CPU_CODE_OFFSET, cpu_code, 2);
+	if (ret < 0) {
+		debug("%s: could not read cpu-code, ret=%d\n", __func__, ret);
+		return 0;
+	}
+
+	/* specification: SoC variant, e.g. 0x2 for RK3568B2 and 0xA for RK3568J */
+	ret = misc_read(dev, RK3568_OTP_SPECIFICATION_OFFSET, &specification, 1);
+	if (ret < 0) {
+		debug("%s: could not read specification, ret=%d\n", __func__, ret);
+		return 0;
+	}
+	/* package: likely SoC variant revision, 0x2 for RK3568B2 */
+	package = specification >> 5;
+	specification &= 0x1f;
+
+	/* cpu-version: chip version, e.g. second letter of lot number */
+	ret = misc_read(dev, RK3568_OTP_CPU_VERSION_OFFSET, &cpu_version, 1);
+	if (ret < 0) {
+		debug("%s: could not read cpu-version, ret=%d\n", __func__, ret);
+		return 0;
+	}
+	cpu_version >>= 3;
+	cpu_version &= 0x7;
+
+	/* performance: used to identify RK3566T SoC variant */
+	ret = misc_read(dev, RK3568_OTP_PERFORMANCE_OFFSET, &performance, 1);
+	if (ret < 0) {
+		debug("%s: could not read performance, ret=%d\n", __func__, ret);
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
+	printf("SoC:   RK%02x%02x%s v%u\n",
+	       cpu_code[0], cpu_code[1], suffix, cpu_version);
+
+	return 0;
+}
-- 
2.46.2

