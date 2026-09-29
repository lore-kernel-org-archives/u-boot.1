Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE22AC9832A
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 04:17:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D8FD60607;
	Tue, 29 Sep 2026 04:17:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vdiE4OwhaU6M; Tue, 29 Sep 2026 04:17:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4FBB26070C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790655468;
	b=g+sfd50EsnKziloFMBJQucgTsdHhd3bITpGK07qHwKuXUeGypGbLuizhJdmRdDF35um7
	 8QqsGHRNnpDAtawX4qUjp1ZcnEms63efcZR4RwaLnXeuPbkryV9imvYV2vzOCQ8FqqVdx
	 dYCpPHbP6JLixvCTH3rhJSrDti/sXu3JobAEnn2DUGU96O5+k8rq2AazKzrHBnBJR4sOJ
	 pg2HRZF9M3bP6PRTlA2iS1rJ5zTdh+BCeOwdsjb3ZlnPKTNJyqdyADF0pFO6h1HTfQc/P
	 s+Hbwlvl32Dp880JBIv0CTMvKAdwPKdulebf0FDvhafeKwzCjNLlemOEprsQR9cl+Yw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790655468;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=3ZU78T9J4oqUept9P9bFbiFGx7m5/OvM6kulJNai73Y=;
	b=TwdymxewSQ0IcYuRzEz0RpePqIIrmclAlL8y2Z8QaYVJ+RY3NBj2SvAQSgmZ6+iupKY5
	 Cc74ljxsSt4OPUi8tGDz76ixzUyXT9GKeMKu3lwmNDgFCsVLF3s1FLsBcaS7Is4ieylxM
	 Gf16bX39fZNuxBNLBMoZxEO62RwobbfE5TQD9MMNcg0GOy/EO2TiRFJjE91YnAqyRR2Su
	 dblamagJlS0oyqzi5zVTlxYUKfJDePa+kbPF/oqIPBPPVlsBpj+4vk0Pb74fK3EfNlVWK
	 KO15ulCdyBHh5OAH/8j536Cy8C196i7CDmG9QIZcpS24yhunL7xjm1GO16JbJ7g4rRg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790655468;
	bh=3ZU78T9J4oqUept9P9bFbiFGx7m5/OvM6kulJNai73Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XR4Th0339hE8S6BM45mYIYROoj8lWQHAlLzGOn5quBDQxvDJqO0kYMieKzhZLEHyh
	 X1V+bByv4RkZy1mdSv2lq9WlurqruqzqgmdCXKGvnTXdaoIl+w6yqgPBBu1XGVbjLz
	 0skS+zxqlQ8zPw0U70oWu4l+BJrV6V4vVt8HcrSaHaVOaUaD3GqXaLI9m10SknIdg6
	 5ltmO5tTIFCH29KdEPwRlnjvXRXGzqKUemOjLAQLen3+qFc/cV8JiPnfT2xxLB9b0X
	 93p8nv07yyu3qQRU3VEdlsfSgLwEBLhn4x3HWHxG9FJy5/k1ZNNIuAvhe1NVgKTi8E
	 sD0VR/Kmdjn2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4FBB26070C;
	Tue, 29 Sep 2026 04:17:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 92A923D8
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 04:17:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 805CF40581
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 04:17:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cTSzeJDeFn6x for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 04:17:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B4852404C8
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790655465;
 b=ec7c1CxtFBmUURvxUThe6OfwMnrHYvqGETPq45xLe1rbp10tVLauqUCJYtA2xyA3X046
 ILipKF+wI50vYRSFwQzBPeFIj3mDJhosUydsOo0djhZsLkLuRqUk0yMrzxzenpXBGzS4E
 cPyVBj4/VP5VVKRZGISzECDGeeol7kBfnOJ1/w6Ig6N8TQCenH7Qf9TrIcguAzlsVsvcH
 xfdf1Gebmkv2zK/wO+IesYcnjVYuVqJ4+Zv7cXy0f7q2Djq59OlMjABscwmU7h7Q0tFNR
 wtXXRYO/URLrtBTkv53FU90lKVnPdXlMYEOXfN/HOV3m5C7bfqKUvJpWarPySZh6F3w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790655465;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=3ZU78T9J4oqUept9P9bFbiFGx7m5/OvM6kulJNai73Y=;
 b=bcxCjCDcPG4F5o8ma+vBXzujXX6Vwm08n1C7ZHen74zmvJOHAO9C3JsoCUQ9Sg3NwpK+
 b/WlWI/f14us3xUujU9U9xAZ0n5fjuU9JByxXKRn1+T7LszRUXpVhNrEv7xCHjVei0Qfg
 zZiAsKWJFgiKj6G+f8RCWL98v2/lpNZo3TCkmMNw7vFIXIEABoEvYeNj/JZWAwO7zV3OV
 dBxFivZD4q2H+l69wgLG1Y0RUIGmGtsduQ3UVzxz7SPy+68MqtsJvp9mZ+l+VPg0H9BHv
 fgLP/+SjvMNCy/cwNAhLLgwVTJva/IWdwvOMp4qcBw50fRO9+CbbKXrULnWoo8RecuA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=nabladev.com; 
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=V+Y+8KzT; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=V+Y+8KzT
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B4852404C8
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 04:17:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8F674105391; Tue, 29 Sep 2026 06:17:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1790655457; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=3ZU78T9J4oqUept9P9bFbiFGx7m5/OvM6kulJNai73Y=;
 b=V+Y+8KzTRN1DTVncIihI2oWHtKMP8LxKpB4tVWpDbGgoZ8GTFUIXIJfOZighsgmn9arqz/
 m+BtZv1oxaAv+Cmp/oG3ipCbb7gaPQw+tfK6YGuILmxcxDaS/2cbJNFWgtsDkMBoP183Q+
 zM9E3HCZ/feUEtBymoGoFRDRcGFA6CtCOZx8hxHYZjSx4+vI/16CTrVIXf5kLRgdUsiYN4
 J9KBek8KU/P+ZoWnHEMpW3SP8nofvOLEBVXqRPFKDES/xd7vcTMeEvlT5N0kYBQqiGYGFQ
 qzE3QP9CU4RKcl4DwJHiDsH2a1cuuMool9i8LNvgIsEayIH8DxPpi4z7YBd+rg==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Stefano Babic <sbabic@nabladev.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Raffaele RECALCATI <raffaele.recalcati@bticino.it>,
 Jagan Teki <jagan@amarulasolutions.com>, Heiko Schocher <hs@nabladev.com>,
 Utkarsh Gupta <utkarsh.gupta@nxp.com>, Gaurav Jain <gaurav.jain@nxp.com>,
 Stefan Bigler <stefan.bigler@securiton.ch>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>
Subject: [PATCH v2 1/2] crypto: fsl: run the CAAM RNG self test on affected
 i.MX6 chips
Date: Tue, 29 Sep 2026 06:17:16 +0200
Message-ID: <20260929041723.1383361-2-hs@nabladev.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929041723.1383361-1-hs@nabladev.com>
References: <20260929041723.1383361-1-hs@nabladev.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The boot ROM of a few i.MX6 revisions runs the RNG self test incorrectly.
It leaves a HAB event behind on every boot:

    STS = HAB_WARNING (0x69)   RSN = HAB_ENG_FAIL (0x30)
    CTX = HAB_CTX_ENTRY (0xE1) ENG = HAB_ENG_CAAM (0x1D)

NXP recommends to run a rng self test before any RNG related
crypto implementations are done.

Affected are i.MX6Solo, i.MX6DL and i.MX6SX revision 1.4, i.MX6Q
revision 1.6 and i.MX6QP revision 1.1, and no other revision of those
chips. Both chip and revision are read at runtime and have to match.

Run this test on affected chips and stop if test fails.

Turning the option on by default grows the SPL, which puts imx6dl_mamoj
over its size limit, so switch it off in that board's defconfig.

Part of the code is taken from u-boot-imx NXP tree, from the commit
linked below, and adapted to mainline.

Link: https://github.com/nxp-imx/uboot-imx/commit/541284a3c55f90446ca179b26500f93ed201eb96
Signed-off-by: Utkarsh Gupta <utkarsh.gupta@nxp.com>
Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
Signed-off-by: Stefan Bigler <stefan.bigler@securiton.ch>
Signed-off-by: Heiko Schocher <hs@nabladev.com>
---
Rework against NXP base:
- adapt the chip detection
- checkpatch cleanup
- Kconfig symbol renamed and set a default

It may be worth discussing whether triggering a panic() and bringing the entire
system to a halt is appropriate in this case.

Changes in v2:
- Dropped Gaurav Jain <gaurav.jain@nxp.com> from Cc. The address bounced
  on v1 with "550 5.4.1 Recipient address rejected: Access denied". His
  Signed-off-by stays, it records where the code comes from.
- Disabled the option in imx6dl_mamoj_defconfig. Enabling it by default
  grew that board's SPL past its size limit, 241 bytes over in CI.
  Enabling LTO is no option, as it is already enabled.
- Added the MX6DL_MAMOJ board maintainers to Cc.
  Simone CIANNI <simone.cianni@bticino.it> is left out, that address bounces
  the same way with "550 5.4.1 Recipient address rejected: Access denied".

 arch/arm/include/asm/arch-imx/cpu.h |   2 +
 configs/imx6dl_mamoj_defconfig      |   1 +
 drivers/crypto/fsl/Kconfig          |  22 ++++
 drivers/crypto/fsl/Makefile         |   1 +
 drivers/crypto/fsl/jr.c             |   3 +
 drivers/crypto/fsl/jr.h             |   1 +
 drivers/crypto/fsl/rng_self_test.c  | 157 ++++++++++++++++++++++++++++
 7 files changed, 187 insertions(+)
 create mode 100644 drivers/crypto/fsl/rng_self_test.c

diff --git a/arch/arm/include/asm/arch-imx/cpu.h b/arch/arm/include/asm/arch-imx/cpu.h
index bbc4b421a02..f2225df9519 100644
--- a/arch/arm/include/asm/arch-imx/cpu.h
+++ b/arch/arm/include/asm/arch-imx/cpu.h
@@ -95,7 +95,9 @@
 #define CHIP_REV_1_1            0x11
 #define CHIP_REV_1_2            0x12
 #define CHIP_REV_1_3            0x13
+#define CHIP_REV_1_4            0x14
 #define CHIP_REV_1_5            0x15
+#define CHIP_REV_1_6            0x16
 #define CHIP_REV_2_0            0x20
 #define CHIP_REV_2_1            0x21
 #define CHIP_REV_2_2            0x22
diff --git a/configs/imx6dl_mamoj_defconfig b/configs/imx6dl_mamoj_defconfig
index 2d47118831f..bebd9a6bac0 100644
--- a/configs/imx6dl_mamoj_defconfig
+++ b/configs/imx6dl_mamoj_defconfig
@@ -41,6 +41,7 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_MMC_DEVICE_INDEX=2
 CONFIG_BOUNCE_BUFFER=y
+# CONFIG_FSL_CAAM_RNG_SELF_TEST is not set
 CONFIG_DFU_MMC=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x12000000
diff --git a/drivers/crypto/fsl/Kconfig b/drivers/crypto/fsl/Kconfig
index 244a9bd905d..41de402c530 100644
--- a/drivers/crypto/fsl/Kconfig
+++ b/drivers/crypto/fsl/Kconfig
@@ -100,4 +100,26 @@ config FSL_DCP_RNG
 	  and a Pseudo-Random Number Generator (PRNG) to achieve a true
 	  randomness and cryptographic strength.
 
+config FSL_CAAM_RNG_SELF_TEST
+	bool "Run the CAAM RNG self test on affected i.MX6 chips"
+	depends on FSL_CAAM
+	default y if MX6S || MX6DL || MX6Q || MX6QDL || MX6SX
+	help
+	  The boot ROM of a few i.MX6 revisions runs the RNG self test
+	  incorrectly and leaves a HAB warning behind, which reads
+
+	    STS = HAB_WARNING (0x69)   RSN = HAB_ENG_FAIL (0x30)
+	    CTX = HAB_CTX_ENTRY (0xE1) ENG = HAB_ENG_CAAM (0x1D)
+
+	  The warning itself is harmless and this option does not make it
+	  go away. What it does is run the self test correctly, before
+	  anything else uses the RNG, so that a genuinely broken RNG is
+	  found rather than assumed to be the known warning. The board is
+	  stopped if the test fails.
+
+	  Affected are i.MX6Solo, i.MX6DL and i.MX6SX revision 1.4, i.MX6Q
+	  revision 1.6 and i.MX6QP revision 1.1, and no other revision of
+	  those chips. Chip and revision are read at runtime, so a build
+	  covering several of them behaves correctly on each.
+
 endif
diff --git a/drivers/crypto/fsl/Makefile b/drivers/crypto/fsl/Makefile
index 965c4938c8c..14b53db7844 100644
--- a/drivers/crypto/fsl/Makefile
+++ b/drivers/crypto/fsl/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_RSA_FREESCALE_EXP) += fsl_rsa.o
 obj-$(CONFIG_$(PHASE_)FSL_CAAM_RNG) += rng.o
 obj-$(CONFIG_FSL_DCP_RNG) += dcp_rng.o
 obj-$(CONFIG_FSL_MFGPROT) += fsl_mfgprot.o
+obj-$(CONFIG_FSL_CAAM_RNG_SELF_TEST) += rng_self_test.o
diff --git a/drivers/crypto/fsl/jr.c b/drivers/crypto/fsl/jr.c
index 07d336c074a..3a5032bcaf6 100644
--- a/drivers/crypto/fsl/jr.c
+++ b/drivers/crypto/fsl/jr.c
@@ -804,6 +804,9 @@ init:
 	pamu_enable();
 #endif
 
+	if (IS_ENABLED(CONFIG_FSL_CAAM_RNG_SELF_TEST))
+		rng_self_test();
+
 	if (get_rng_vid(caam->sec) >= 4) {
 		if (rng_init(sec_idx, caam->sec) < 0) {
 			printf("SEC%u:  RNG instantiation failed\n", sec_idx);
diff --git a/drivers/crypto/fsl/jr.h b/drivers/crypto/fsl/jr.h
index b136cd8d05a..d8bd0797331 100644
--- a/drivers/crypto/fsl/jr.h
+++ b/drivers/crypto/fsl/jr.h
@@ -132,4 +132,5 @@ struct caam_regs {
 void caam_jr_strstatus(u32 status);
 int run_descriptor_jr(uint32_t *desc);
 
+void rng_self_test(void);
 #endif
diff --git a/drivers/crypto/fsl/rng_self_test.c b/drivers/crypto/fsl/rng_self_test.c
new file mode 100644
index 00000000000..7dabdc26551
--- /dev/null
+++ b/drivers/crypto/fsl/rng_self_test.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * CAAM RNG self test for the i.MX6 chips whose boot ROM gets it wrong
+ *
+ * Copyright 2018, 2021 NXP
+ * Copyright (C) 2026 Stefan Bigler, Securiton AG
+ * Copyright (C) 2026 Heiko Schocher, Nabla Software Engineering <hs@nabladev.com>
+ */
+
+#include <cpu_func.h>
+#include <log.h>
+#include <malloc.h>
+#include <memalign.h>
+#include <vsprintf.h>
+#include <asm/arch/sys_proto.h>
+#include <linux/kernel.h>
+#include "jr.h"
+
+/* Number of words in the descriptor below */
+#define RNG_DSC_SIZE		0x36
+
+/* Size of the known answer the descriptor produces */
+#define RNG_KAT_SIZE		32
+
+/*
+ * Descriptor of the self test, taken from the NXP tree. The word five
+ * from the end holds the address the result is written to and is filled
+ * in before the descriptor is submitted.
+ */
+#define RNG_DSC_RESULT_IDX	(RNG_DSC_SIZE - 5)
+
+static const u32 rng_dsc[RNG_DSC_SIZE] = {
+	0xb0800036, 0x04800010, 0x3c85a15b, 0x50a9d0b1,
+	0x71a09fee, 0x2eecf20b, 0x02800020, 0xb267292e,
+	0x85bf712d, 0xe85ff43a, 0xa716b7fb, 0xc40bb528,
+	0x27b6f564, 0x8821cb5d, 0x9b5f6c26, 0x12a00020,
+	0x0a20de17, 0x6529357e, 0x316277ab, 0x2846254e,
+	0x34d23ba5, 0x6f5e9c32, 0x7abdc1bb, 0x0197a385,
+	0x82500405, 0xa2000001, 0x10880004, 0x00000005,
+	0x12820004, 0x00000020, 0x82500001, 0xa2000001,
+	0x10880004, 0x40000045, 0x02800020, 0x8f389cc7,
+	0xe7f7cbb0, 0x6bf2073d, 0xfc380b6d, 0xb22e9d1a,
+	0xee64fcb7, 0xa2b48d49, 0xdf9bc3a4, 0x82500009,
+	0xa2000001, 0x10880004, 0x00000005, 0x82500001,
+	0x60340020, 0xFFFFFFFF, 0xa2000001, 0x10880004,
+	0x00000005, 0x8250000d
+};
+
+static const u8 rng_result[RNG_KAT_SIZE] = {
+	0x3a, 0xfe, 0x2c, 0x87, 0xcc, 0xb6, 0x44, 0x49,
+	0x19, 0x16, 0x9a, 0x74, 0xa1, 0x31, 0x8b, 0xef,
+	0xf4, 0x86, 0x0b, 0xb9, 0x5e, 0xee, 0xae, 0x91,
+	0x92, 0xf4, 0xa9, 0x8f, 0xb0, 0x37, 0x18, 0xa4
+};
+
+/**
+ * rng_self_test_jobdesc() - build the self test descriptor
+ *
+ * @desc:	descriptor to fill in, RNG_DSC_SIZE words
+ * @result:	where the CAAM is to deposit the generated data
+ */
+static void rng_self_test_jobdesc(u32 *desc, u8 *result)
+{
+	uint i;
+
+	for (i = 0; i < RNG_DSC_SIZE; i++)
+		desc[i] = rng_dsc[i];
+
+	desc[RNG_DSC_RESULT_IDX] = (uintptr_t)result;
+}
+
+/**
+ * rng_test() - run the self test once and compare against the known answer
+ *
+ * A failure means the RNG cannot be trusted, so the board is stopped
+ * rather than left to carry on with keys derived from it.
+ */
+static void rng_test(void)
+{
+	u8 *result;
+	u32 *desc;
+	uint size;
+	int ret, i;
+
+	result = memalign(ARCH_DMA_MINALIGN, RNG_KAT_SIZE);
+	if (!result) {
+		puts("RNG:   not enough memory for the result\n");
+		return;
+	}
+
+	desc = memalign(ARCH_DMA_MINALIGN, sizeof(u32) * RNG_DSC_SIZE);
+	if (!desc) {
+		puts("RNG:   not enough memory for the descriptor\n");
+		free(result);
+		return;
+	}
+
+	rng_self_test_jobdesc(desc, result);
+
+	size = roundup(sizeof(u32) * RNG_DSC_SIZE, ARCH_DMA_MINALIGN);
+	flush_dcache_range((ulong)desc, (ulong)desc + size);
+	size = roundup(RNG_KAT_SIZE, ARCH_DMA_MINALIGN);
+	flush_dcache_range((ulong)result, (ulong)result + size);
+
+	ret = run_descriptor_jr(desc);
+	if (ret) {
+		printf("RNG:   self test descriptor failed: %d\n", ret);
+		goto err;
+	}
+
+	invalidate_dcache_range((ulong)result, (ulong)result + size);
+
+	for (i = 0; i < RNG_KAT_SIZE; i++)
+		debug("%02x", result[i]);
+	debug("\n");
+
+	if (memcmp(result, rng_result, RNG_KAT_SIZE))
+		goto err;
+
+	free(desc);
+	free(result);
+	puts("RNG:   self test passed\n");
+
+	return;
+
+err:
+	free(desc);
+	free(result);
+	panic("RNG:   self test failed\n");
+}
+
+/**
+ * rng_self_test_needed() - is this chip one of the affected ones?
+ *
+ * Chip and revision both have to match one of the pairs that NXP names
+ * as impacted, and no other revision of those chips is on that list.
+ */
+static bool rng_self_test_needed(void)
+{
+	if (is_cpu_type(MXC_CPU_MX6QP))
+		return soc_rev() == CHIP_REV_1_1;
+
+	if (is_cpu_type(MXC_CPU_MX6Q))
+		return soc_rev() == CHIP_REV_1_6;
+
+	if (is_cpu_type(MXC_CPU_MX6SOLO) || is_cpu_type(MXC_CPU_MX6DL) ||
+	    is_cpu_type(MXC_CPU_MX6SX))
+		return soc_rev() == CHIP_REV_1_4;
+
+	return false;
+}
+
+void rng_self_test(void)
+{
+	if (rng_self_test_needed())
+		rng_test();
+}
-- 
2.55.0

