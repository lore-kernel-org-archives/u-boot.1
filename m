Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A837606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 22:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nWvH8TwT;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ItmSGfrr
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 56B1780C4E;
	Fri, 23 Oct 2026 22:18:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JAwqOYOHrEQY; Fri, 23 Oct 2026 22:18:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5053780A5A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792793922;
	b=YtX1fp45+vKmQM3Q7596xOagvEgOHHHHB89OGsFvvUPLWGbhGnPTj7B+er6AIPRRUR4/
	 jtORzDXgYQxZ0TlypFY0ni4gnTZclNUQq+6n2igZmomuFF8HEWemMpkkQOFGQNqdoHNO9
	 wo/TIxJ/mdU7d5QlmdDI7PRSuDBy7QeDDPAXbfwOsJb930QlHdq1n+pKlDVrNhufP6c7+
	 FTKC9wkBGBayUXVS3Z2kBxx9rnskVvaNO1HdV8gvshFTpX2EsImRVdOLwnI3b/dhIqRHD
	 ult7k0X91G/5UtDBL5XVLJA44B5NNL/bXp5w5F1DP82rDVPXppHNK8woShrig0/V7Hw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792793922;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=FxkA8V3XJFLCAhTgoR+Zj59zgjMkwzFPd5VppRu7CMU=;
	b=UD1Dqeo8kfBHOxLuaC1VSCDDWNvlRoie3xPXv6pmPx0LZi3bQN7rbgN0zoP1Ve5GgxQL
	 8hKusaePR7OyEnJinr4onBwWnii/Nv/GZt4Xg/lIsX1Fjg1BsuTpD3vdpNaT/+aTVGOu4
	 mWvbkL0MTcO6/Njhu4d5Jseq1Gd95dcUTeYZH9Z4L4dZcjknqe+ChWBPCdEGBUViodWmz
	 mwqswSES6u2hDtD33Hce2jnRUIXkT+vzy3K4w8BP6hvbR5A2LLwm1tNH5U/HxkdkMnm07
	 tu4HRK0MX4VqcemOtEfWbp8ArxrQEsb4espJfrBkk2WIatQsiczzExMrkaFS8vWY+Jw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ItmSGfrr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792793922;
	bh=FxkA8V3XJFLCAhTgoR+Zj59zgjMkwzFPd5VppRu7CMU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nWvH8TwT2ZN9JdSmnoREA52alMKDrnSxEzLvXai+2nn2g6dsrf2FTqS59DljyBK8Z
	 ee/SNsDvvCnN7LC3MGM0TBfjbzMKMsotbIPOn3e+DmZeeWBtph7d3MyGdztMD5A9WX
	 G2ufcFOWBpPrAKpqRvWOelODzhL/CWcekT7v8+ivr1USoW6FTHfFHOd11hDzY9vZYh
	 qVqDoddEVtpIpYlISwRIyLvCLiGw9FAJ2kwHGe607iPaJZrB/udY2eTEybEZ1V1dNp
	 KG+cUA+SaikgkZSJduAqsR+EfUteL88S79jZc82X9UBqPaIJPa1uP7VOfDBnOWRXGG
	 02BeQnql94I7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5053780A5A;
	Fri, 23 Oct 2026 22:18:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B832A3D9
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 22:18:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AA7868168F
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 22:18:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eYh01FqYSl5E for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 22:18:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A3BC28168D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792793918;
 b=aLAezqTlJfu62BSFyY6vDTz8j0fZJ8c+IYn9en9+gdvzuZEnocMeV5H4gDm6YN3Y+lhw
 85Dwiujf7IDMircSlikvhkE/y8RQcKLoxSvZbt9wSt4gMNmFSFR2D5vIdVzfUeWaqLLtR
 jXoi7ybLj/0hzeitCJvSw5KSP3HjxGTVD7i6kud4gihygIWJZvAM5+LwXES4Mau2m7h3A
 z7HXkMpb35w2TURqB0Kwu0PvWsVoCndjcrFKHQ/CUu8sJN/eChmBxVimbxH83V/AzAwpL
 1utE4J+S3XFYPWc5Sr8KCT29paHgNMvQ+SlfRJy3i9ug9gCGYi+jTtLyS19/qCbfWQg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792793918;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=FxkA8V3XJFLCAhTgoR+Zj59zgjMkwzFPd5VppRu7CMU=;
 b=MbialQkpGO1Sv811SvrbiJA+uhUduYDPwKsjZNOwpa8UF4e/ZcbWqIsPSOgKHdDeHRSR
 K9BSEBuYQPsT3WN/yatvXHH+vssETUV2C6JNvJG/q1t/zW66gOgAnWtwmhTeFYSESZjyQ
 qv/mHC4fEZ83IDzGETJIP9I269FXTLnrq20FSOYaE7oPBZm0MwBN7YnA5xSjthfCv/So9
 0NDfZJOs9xMA4MJT6Q8KWGUlFrDW2a+slLoOtKy9iAvzqBS3ihnLpIdg8TClGJvvO2quT
 wmentFG1ltWrxL4KA15t1tIoPz83fOHxGKQYcWKxr4xFb3/g8GhEBP0Q4Z81QK5XE0w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ItmSGfrr; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ItmSGfrr
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A3BC28168D
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 22:18:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 48134601DE;
 Fri, 23 Oct 2026 22:18:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4558C1F01825;
 Fri, 23 Oct 2026 22:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792793917;
 bh=FxkA8V3XJFLCAhTgoR+Zj59zgjMkwzFPd5VppRu7CMU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ItmSGfrrX6goXdUJzG/NZvHPdG0/k8AfAPIjHCBvuUWTefSrqjH5W+dfgpP9pONtx
 44q2p7s9jQMe3oGWxXb/TyCNfpQwmW6k3gzIRZxai4d5AwMvGeD3V4xq+OuHJWqXEd
 hhdC5iaKhwJbQPCDv11oejBmvQWL6LxUux/hh9F/L1hBdJo1pCdjyzK+DsMo1rh6rK
 O3nw2KBziOCk+6k6PPgCCuFDW6GX5R9v5LkrjVAt2/bhPyLOENvg3bKdnrQeLdmiEb
 CVqTlDAQAlnFA8xQg05zSk9KKdnXqT1vcN0O8yHFtnMohHfa9QptrbuY0CPzymXJXK
 zk6Keup2gcBnA==
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 24 Oct 2026 00:18:29 +0200
Subject: [PATCH v8 2/8] power: regulator: Add AB8500 AUX3 support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-ux500-external-sdcard-v8-2-badcdf6db2ea@kernel.org>
References: <20261024-ux500-external-sdcard-v8-0-badcdf6db2ea@kernel.org>
In-Reply-To: <20261024-ux500-external-sdcard-v8-0-badcdf6db2ea@kernel.org>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add regulator support for LDO AUX3 on AB8500 and AB8505 PMICs.
AUX3 supplies the removable SD card on the upstream Ux500 Samsung
device trees.

Support the AB8505-specific 3.05 V selector override and clear it after
programming an ordinary voltage. Treat both normal and low-power modes
as enabled and select the supported voltage closest to a requested
target. AB8500 cut 2.0 or later is assumed.

Imply the regulator core for ARCH_U8500 so the driver can instantiate
from the upstream device trees.

Acked-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 MAINTAINERS                      |   1 +
 arch/arm/Kconfig                 |   2 +
 drivers/power/pmic/ab8500.c      |   1 +
 drivers/power/regulator/Kconfig  |   7 ++
 drivers/power/regulator/Makefile |   1 +
 drivers/power/regulator/ab8500.c | 171 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 183 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dbf523e21107..6851c5151dbd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -777,6 +777,7 @@ F:	drivers/gpio/nmk_gpio.c
 F:	drivers/pinctrl/pinctrl-nomadik.c
 F:	drivers/phy/phy-ab8500-usb.c
 F:	drivers/power/pmic/ab8500.c
+F:	drivers/power/regulator/ab8500.c
 F:	drivers/timer/nomadik-mtu-timer.c
 F:	drivers/usb/musb-new/ux500.c
 F:	drivers/video/mcde_simple.c
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 8997a82f4f04..00f3cd9ec4db 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1306,6 +1306,7 @@ config ARCH_U8500
 	imply ARM_PL180_MMCI
 	imply CLK
 	imply DM_PMIC
+	imply DM_REGULATOR
 	imply DM_RTC
 	imply NOMADIK_GPIO
 	imply NOMADIK_MTU_TIMER
@@ -1314,6 +1315,7 @@ config ARCH_U8500
 	imply PHY
 	imply PL01X_SERIAL
 	imply PMIC_AB8500
+	imply REGULATOR_AB8500
 	imply RTC_PL031
 	imply SYS_THUMB_BUILD
 	imply SYSRESET_SYSCON
diff --git a/drivers/power/pmic/ab8500.c b/drivers/power/pmic/ab8500.c
index 9ba096711e14..b9fae7000b78 100644
--- a/drivers/power/pmic/ab8500.c
+++ b/drivers/power/pmic/ab8500.c
@@ -253,6 +253,7 @@ static int ab8500_probe(struct udevice *dev)
 
 static const struct udevice_id ab8500_ids[] = {
 	{ .compatible = "stericsson,ab8500" },
+	{ .compatible = "stericsson,ab8505" },
 	{ }
 };
 
diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
index 428689702c87..dbd24415cb5a 100644
--- a/drivers/power/regulator/Kconfig
+++ b/drivers/power/regulator/Kconfig
@@ -16,6 +16,13 @@ config DM_REGULATOR
 	  for this purpose if PMIC I/O driver is implemented or dm_scan_fdt_dev()
 	  otherwise. Detailed information can be found in the header file.
 
+config REGULATOR_AB8500
+	bool "ST-Ericsson AB8500/AB8505 regulator support"
+	depends on DM_REGULATOR && PMIC_AB8500
+	help
+	  Enable LDO AUX3 regulator support for AB8500 and AB8505 PMICs.
+	  This supply is used to power removable SD cards on Ux500 boards.
+
 config SPL_DM_REGULATOR
 	bool "Enable regulators for SPL"
 	depends on DM_REGULATOR && SPL_POWER
diff --git a/drivers/power/regulator/Makefile b/drivers/power/regulator/Makefile
index e17937f4c26f..bfe3349e3e5d 100644
--- a/drivers/power/regulator/Makefile
+++ b/drivers/power/regulator/Makefile
@@ -5,6 +5,7 @@
 #
 
 obj-$(CONFIG_$(PHASE_)DM_REGULATOR) += regulator-uclass.o
+obj-$(CONFIG_REGULATOR_AB8500) += ab8500.o
 obj-$(CONFIG_REGULATOR_ACT8846) += act8846.o
 obj-$(CONFIG_REGULATOR_AS3722)	+= as3722_regulator.o
 obj-$(CONFIG_$(PHASE_)REGULATOR_AXP) += axp_regulator.o
diff --git a/drivers/power/regulator/ab8500.c b/drivers/power/regulator/ab8500.c
new file mode 100644
index 000000000000..4cd15c5fcf86
--- /dev/null
+++ b/drivers/power/regulator/ab8500.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* ST-Ericsson AB8500/AB8505 LDO AUX3 regulator */
+
+#include <dm.h>
+#include <dm/lists.h>
+#include <linux/errno.h>
+#include <power/ab8500.h>
+#include <power/pmic.h>
+#include <power/regulator.h>
+
+#define AB8500_VAUX3_REGU		AB8500_REGU_CTRL2(0x0a)
+#define AB8500_VAUX3_REGU_EN_MASK	GENMASK(1, 0)
+#define AB8500_VAUX3_REGU_EN		BIT(0)
+
+#define AB8500_VAUX3_SEL	AB8500_REGU_CTRL2(0x21)
+#define AB8500_VAUX3_SEL_MASK	GENMASK(2, 0)
+
+#define AB8505_VAUX3_SEL3	AB8500_REGU_CTRL2(0x01)
+
+#define AB8505_VAUX3_SEL3_MASK	BIT(4)
+#define AB8505_VAUX3_SEL3_UV	3050000
+
+static const int ab8500_vaux3_voltages[] = {
+	1200000, 1500000, 1800000, 2100000,
+	2500000, 2750000, 2790000, 2910000,
+};
+
+static struct udevice *ab8500_regulator_pmic(struct udevice *dev)
+{
+	return dev->parent->parent;
+}
+
+static int ab8500_regulator_get_value(struct udevice *dev)
+{
+	struct udevice *pmic = ab8500_regulator_pmic(dev);
+	int ret;
+
+	if (device_is_compatible(pmic, "stericsson,ab8505")) {
+		ret = pmic_reg_read(pmic, AB8505_VAUX3_SEL3);
+		if (ret < 0)
+			return ret;
+		if (ret & AB8505_VAUX3_SEL3_MASK)
+			return AB8505_VAUX3_SEL3_UV;
+	}
+
+	ret = pmic_reg_read(pmic, AB8500_VAUX3_SEL);
+	if (ret < 0)
+		return ret;
+	ret &= AB8500_VAUX3_SEL_MASK;
+
+	return ab8500_vaux3_voltages[ret];
+}
+
+static int ab8500_regulator_set_value(struct udevice *dev, int uV)
+{
+	struct udevice *pmic = ab8500_regulator_pmic(dev);
+	bool is_ab8505 = device_is_compatible(pmic, "stericsson,ab8505");
+	int ret;
+	int i;
+
+	if (uV == AB8505_VAUX3_SEL3_UV) {
+		if (!is_ab8505)
+			return -EINVAL;
+
+		return pmic_clrsetbits(pmic, AB8505_VAUX3_SEL3,
+				       AB8505_VAUX3_SEL3_MASK,
+				       AB8505_VAUX3_SEL3_MASK);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(ab8500_vaux3_voltages); i++) {
+		if (ab8500_vaux3_voltages[i] != uV)
+			continue;
+
+		ret = pmic_clrsetbits(pmic, AB8500_VAUX3_SEL,
+				      AB8500_VAUX3_SEL_MASK, i);
+		if (ret || !is_ab8505)
+			return ret;
+
+		return pmic_clrsetbits(pmic, AB8505_VAUX3_SEL3,
+				       AB8505_VAUX3_SEL3_MASK, 0);
+	}
+
+	return -EINVAL;
+}
+
+static int ab8500_regulator_set_value_clamp(struct udevice *dev, int min_uV,
+					    int target_uV, int max_uV)
+{
+	struct udevice *pmic = ab8500_regulator_pmic(dev);
+	int best_uV = -EINVAL;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ab8500_vaux3_voltages); i++) {
+		int uV = ab8500_vaux3_voltages[i];
+
+		if (uV < min_uV || uV > max_uV)
+			continue;
+		if (best_uV < 0 || abs(uV - target_uV) <
+				   abs(best_uV - target_uV))
+			best_uV = uV;
+	}
+
+	if (device_is_compatible(pmic, "stericsson,ab8505") &&
+	    min_uV <= AB8505_VAUX3_SEL3_UV &&
+	    max_uV >= AB8505_VAUX3_SEL3_UV &&
+	    (best_uV < 0 || abs(AB8505_VAUX3_SEL3_UV - target_uV) <
+	     abs(best_uV - target_uV)))
+		best_uV = AB8505_VAUX3_SEL3_UV;
+
+	if (best_uV < 0)
+		return best_uV;
+
+	return ab8500_regulator_set_value(dev, best_uV);
+}
+
+static int ab8500_regulator_get_enable(struct udevice *dev)
+{
+	int ret;
+
+	ret = pmic_reg_read(ab8500_regulator_pmic(dev), AB8500_VAUX3_REGU);
+	if (ret < 0)
+		return ret;
+
+	return !!(ret & AB8500_VAUX3_REGU_EN_MASK);
+}
+
+static int ab8500_regulator_set_enable(struct udevice *dev, bool enable)
+{
+	return pmic_clrsetbits(ab8500_regulator_pmic(dev), AB8500_VAUX3_REGU,
+			       AB8500_VAUX3_REGU_EN_MASK,
+			       enable ? AB8500_VAUX3_REGU_EN : 0);
+}
+
+static const struct dm_regulator_ops ab8500_regulator_ops = {
+	.get_value = ab8500_regulator_get_value,
+	.set_value = ab8500_regulator_set_value,
+	.set_value_clamp = ab8500_regulator_set_value_clamp,
+	.get_enable = ab8500_regulator_get_enable,
+	.set_enable = ab8500_regulator_set_enable,
+};
+
+U_BOOT_DRIVER(ab8500_ldo_aux3) = {
+	.name = "ab8500_ldo_aux3",
+	.id = UCLASS_REGULATOR,
+	.ops = &ab8500_regulator_ops,
+};
+
+static int ab8500_regulators_bind(struct udevice *dev)
+{
+	ofnode node;
+
+	node = dev_read_subnode(dev, "ab8500_ldo_aux3");
+	if (!ofnode_valid(node))
+		return -ENODEV;
+
+	return device_bind_driver_to_node(dev, "ab8500_ldo_aux3",
+					  ofnode_get_name(node), node, NULL);
+}
+
+static const struct udevice_id ab8500_regulator_ids[] = {
+	{ .compatible = "stericsson,ab8500-regulator" },
+	{ .compatible = "stericsson,ab8505-regulator" },
+	{ }
+};
+
+U_BOOT_DRIVER(ab8500_regulators) = {
+	.name = "ab8500_regulators",
+	.id = UCLASS_NOP,
+	.of_match = ab8500_regulator_ids,
+	.bind = ab8500_regulators_bind,
+};

-- 
2.56.0

