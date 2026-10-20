Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68467606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 05:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=G41SJTl7
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2663A6083A;
	Tue, 20 Oct 2026 05:49:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VetTBp-7q3ME; Tue, 20 Oct 2026 05:49:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3F3436084A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792475352;
	b=CP3cGqxfT3HJTYcNi2X/mR4HnXB2oHdHxOQnWSlIVAalAsPiUj/JD6r45FgMonQ7eRtb
	 DgIch63OQCz2OfvpXac6p48xRg+2u6VlHsVdGtsddt85u1kSxLKALl1KrqvyIt67n61Im
	 ixvtZiObvzx2UzXCkXE+V0/enPemLuCKIPZg8KiDxeoMR+vhsf+Nhqb1Zaa1SYWsEruf0
	 c7nV5IVgGL0twTNm4BZyE7UN1i6tHnBzOpOv64loGFLVM16CwH+PIyYW+mV8q1MrNfI9r
	 XDeTnrkCbQkcRVu3qi7CSTgIypyrg0zRwLvCIrxKva3wfT0bQmnh7ncFf90TdNTBEog==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792475352;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Virus-Scanned:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=3RNkMvRHUR8zIDhXyG+OC0y/IP83nRzk51AlUe+vymw=;
	b=l9d3RBiGnRVf20YTKSpquC6PL0OOslQpVoL/WEEpOVHGU31Lr3tVToJ5zRv6xo2Gor4K
	 FrpKfHyEgOSme0NF6G3FlAjG7Fy0jkX2I4UWMsCwioPQzBIqLYcR3z4ngD7L6jitfF5AM
	 swqKNSmx5yaDml6cSmC0qkQ1jgs/6oQuGvvpaELPHLoubspdOvc29qpWsxgZ7SJ2S8Wbp
	 9nn6G6vAsONpGCGapRusOORl9VDaNGq7Mldic+owjk/DSvBa0q1IQU1K3fCn2a1QBnxlu
	 jXOxabRwaRQ07HIBZAzpXHVZxaxaYkLCHNCI9WNq0hj/5y21AqnuN73WYZGlazHeOeA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792475352;
	bh=3RNkMvRHUR8zIDhXyG+OC0y/IP83nRzk51AlUe+vymw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G41SJTl7NhuJ5XB6U80uQJuPBszEeVykzPo2t0/bI1dzUBpf0/YUG0jXL2skFw9F/
	 P3F1DPSGF3/uWoqstU/5di2Pp6Z0OmfRudKRPfqrPRjqoWxVdx9je7F668VHLdCChT
	 ixrs5PrPck5LI0/eywCC7GedjsddUGhBTqYsufuIW6Q8DLtsj5yzY2gMwcc5pCp06N
	 kwmrV0KXWTPjQqJUysvZl2qUZhgJIso+A+4xH7gVSj2I0UnNcLpkEoAmV8cOf57f8e
	 b1RRSDsD0caIol9FgHbCPCyKONjQke3JXuaAvUCILu7zgO0qZCwDqmxf3XJ+K5ahfV
	 ZpgWCbEpUII8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F3436084A;
	Tue, 20 Oct 2026 05:49:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 54D8F1DE
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 05:44:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 42FE7810A2
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 05:44:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P1oIU7TeiQVo for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 05:44:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9602E81045
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=92.121.34.13
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792475081;
 b=KgjTEg+0GUp96ItVI6ND/UlD+F0NLo2QddBxBtewbpNnIoxPna20FE1LIoMvQO9Q4YTy
 YXJUUOSCcgkI53AcJkEM5HyDDXJsa2pGWUBhMk7jeXBtLoevsz7MJN9XVaCwoK0rsA0iz
 LtgddGuvzx5JX4mL1OAxNw9ONAHdTY2OG+YIlZo9XykYOztjDwJJiXFEIIEl95lOSIb1w
 HC8uj5asyNmw9uD3Xq2RJ+dKsYWiLdvTE37S84CHF106MEb9adQn7pipqx1+VInl283RZ
 4fXqM1Zd2Vw8eVNCYoX6ae9ma2V66GIk+5DGbADQ+88kcwbZLogjly2qhoyFADHBUlA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792475081;
 h=Received-SPF:Received:Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Virus-Scanned;
 bh=3RNkMvRHUR8zIDhXyG+OC0y/IP83nRzk51AlUe+vymw=;
 b=Xg1L7LELA8ka4TxZiXiv6hzggiWh+9rQbZPUkDsi2Rdop6bqChpCR3NFAEaE8Jw3UEum
 3aFdAz1IMJmN61V/YZ6UDxCb6lCFwnn23nG6gmhXtXrxKgIYo9r3Nn7EChEUAIUU33WI6
 ONFSx7XwsqN9mo3AWrtY7VRYQvTm4UyuWQik1UmVD65w06mcmAqRYZ/jHN1nNEz0oFNuf
 3uS7hhTP17xZqq1RdajTSIc5MrRSRQKvpkBb/bZR1bscLyNliMTStrMWXZSR0DQGgxNd4
 wlK4L0I7j1qjFgBjz1gIox+DauImwjYlmi8W4Y7mSeY/N8RszKfskmLmMdfp1nvtNGQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=nxp.com;
 arc=none smtp.remote-ip=92.121.34.13
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=92.121.34.13;
 helo=inva020.nxp.com; envelope-from=qijian.guo@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9602E81045
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 05:44:39 +0000 (UTC)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DFE4D1A0080;
 Tue, 20 Oct 2026 07:34:41 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 89A951A007F;
 Tue, 20 Oct 2026 07:34:41 +0200 (CEST)
Received: from lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com
 (lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com [10.52.9.99])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 7C618180006C;
 Tue, 20 Oct 2026 13:34:39 +0800 (+08)
From: Joseph Guo <qijian.guo@nxp.com>
Date: Tue, 20 Oct 2026 12:25:11 +0900
Subject: [PATCH v2 4/4] imx: Add FRDM-IMX95-PRO initial support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-frdm-imx95-pro-v2-4-09b188f16738@nxp.com>
References: <20261020-frdm-imx95-pro-v2-0-09b188f16738@nxp.com>
In-Reply-To: <20261020-frdm-imx95-pro-v2-0-09b188f16738@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Johan Jonker <jbx6244@gmail.com>, Primoz Fiser <primoz.fiser@norik.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, Lei Xu <lei.xu@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Simona Toaca <simona.toaca@nxp.com>, 
 Joseph Guo <qijian.guo@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792474473; l=12195;
 i=qijian.guo@nxp.com; s=20250519; h=from:subject:message-id;
 bh=hGfOBNmqFtpuGYof+v9P3fSc+sxsi5SRCoY23oocqBs=;
 b=BouRwKXpsxzLW6+ApNKovZS98svC85E94kJf8VdHKhsyo94BMf75n7wUg0aCBt/Wq/7YYunlB
 3VrJ7ZS0Lv7CxyrjlYaqulDmLK3fUQcZSOu76i6kxeFPTf4VV1Qe4ew
X-Developer-Key: i=qijian.guo@nxp.com; a=ed25519;
 pk=VRjOOFhVecTRwBzK4mt/k3JBnHoYfuXKCm9FM+hHQhs=
X-Virus-Scanned: ClamAV using ClamSMTP
X-Mailman-Approved-At: Tue, 20 Oct 2026 05:49:05 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-21.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add boot support and peripherals like eMMC/SD, UART, I2C, GPIO, ENETC0/1
and PCIE0/1 for iMX95 19x19 FRDM PRO board.
Updated imx95_frdm doc to include build instruction for FRDM-IMX95-PRO.

To avoid duplicate defconfig, imx95_frdm.config is added and can be shared
between imx95_15x15_frdm_defconfig and imx95_19x19_frdm_pro_defconfig.

Signed-off-by: Joseph Guo <qijian.guo@nxp.com>
---
Note: boot phase properties upstream have been sent [1]. These properties
can be removed in imx95-19x19-frdm-pro-uboot.dtsi after upstream changed.

[1] https://lore.kernel.org/all/sashiko-outbox-167770@kernel.org/
---
Changes in v2:
- Refactor duplicate configs in imx95_frdm.config
---
 arch/arm/dts/imx95-19x19-frdm-pro-u-boot.dtsi      |  65 ++++++++++
 arch/arm/mach-imx/imx9/Kconfig                     |   8 ++
 board/nxp/imx95_frdm/Kconfig                       |   2 +-
 board/nxp/imx95_frdm/MAINTAINERS                   |   1 +
 configs/imx95_15x15_frdm_defconfig                 | 141 +--------------------
 configs/imx95_19x19_frdm_pro_defconfig             |  12 ++
 ...mx95_15x15_frdm_defconfig => imx95_frdm.config} |   3 -
 doc/board/nxp/imx95_frdm.rst                       |  29 ++++-
 include/configs/imx95_frdm.h                       |   4 +
 9 files changed, 120 insertions(+), 145 deletions(-)

diff --git a/arch/arm/dts/imx95-19x19-frdm-pro-u-boot.dtsi b/arch/arm/dts/imx95-19x19-frdm-pro-u-boot.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..f1fcd3630102e002a715af2d2798d75726041b96
--- /dev/null
+++ b/arch/arm/dts/imx95-19x19-frdm-pro-u-boot.dtsi
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 NXP
+ */
+
+#include "imx95-u-boot.dtsi"
+
+/ {
+	aliases {
+		pci0 = &netc_bus0;
+		pci1 = &netc_bus1;
+	};
+};
+
+&lpuart1 {
+	bootph-pre-ram;
+};
+
+&reg_usdhc2_vmmc {
+	bootph-pre-ram;
+};
+
+&usdhc1 {
+	bootph-pre-ram;
+};
+
+&usdhc2 {
+	bootph-pre-ram;
+};
+
+&pinctrl_uart1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1_100mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1_200mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_100mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_200mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_gpio {
+	bootph-pre-ram;
+};
+
+&pinctrl_reg_usdhc2_vmmc {
+	bootph-pre-ram;
+};
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index d66d4193906f8bf4b84494f1e64428efda3acd75..1630695e1cd27293eac18a605dc736230e78e329 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -192,6 +192,14 @@ config TARGET_IMX95_15X15_FRDM
 	imply BOOTSTD_BOOTCOMMAND
 	imply OF_UPSTREAM
 
+config TARGET_IMX95_19X19_FRDM_PRO
+	bool "imx95_19x19_frdm_pro"
+	select OF_BOARD_FIXUP
+	select IMX95
+	imply BOOTSTD_FULL
+	imply BOOTSTD_BOOTCOMMAND
+	imply OF_UPSTREAM
+
 config TARGET_IMX943_EVK
 	bool "imx943_evk"
 	select OF_BOARD_FIXUP
diff --git a/board/nxp/imx95_frdm/Kconfig b/board/nxp/imx95_frdm/Kconfig
index 0da9a56adadec661792c38b1258e4eb914af5aa5..c0d85f421fd83710826bafa0b249346ede821f80 100644
--- a/board/nxp/imx95_frdm/Kconfig
+++ b/board/nxp/imx95_frdm/Kconfig
@@ -1,4 +1,4 @@
-if TARGET_IMX95_15X15_FRDM
+if TARGET_IMX95_15X15_FRDM || TARGET_IMX95_19X19_FRDM_PRO
 
 config SYS_BOARD
 	default "imx95_frdm"
diff --git a/board/nxp/imx95_frdm/MAINTAINERS b/board/nxp/imx95_frdm/MAINTAINERS
index 33870f054e7452ed3af36f19236163d451c93665..b51b1e0dd6c54241b635e7ee1c6d9312e469fc4c 100644
--- a/board/nxp/imx95_frdm/MAINTAINERS
+++ b/board/nxp/imx95_frdm/MAINTAINERS
@@ -4,3 +4,4 @@ S:	Maintained
 F:	board/nxp/imx95_frdm/
 F:	include/configs/imx95_frdm.h
 F:	configs/imx95_15x15_frdm_defconfig
+F:	configs/imx95_19x19_frdm_pro_defconfig
\ No newline at end of file
diff --git a/configs/imx95_15x15_frdm_defconfig b/configs/imx95_15x15_frdm_defconfig
index 803db9adff7c49a52879421cfb516ebb92b9bc9a..716f65d72d9981c513ffab9cb9ee5a948682ca23 100644
--- a/configs/imx95_15x15_frdm_defconfig
+++ b/configs/imx95_15x15_frdm_defconfig
@@ -1,143 +1,4 @@
-CONFIG_ARM=y
-CONFIG_ARCH_IMX9=y
-CONFIG_TEXT_BASE=0x90200000
-CONFIG_SYS_MALLOC_LEN=0x2000000
-CONFIG_SYS_MALLOC_F_LEN=0x10000
-CONFIG_SPL_GPIO=y
-CONFIG_SPL_LIBCOMMON_SUPPORT=y
-CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_ENV_SOURCE_FILE="imx95_frdm"
-CONFIG_NR_DRAM_BANKS=3
-CONFIG_ENV_SIZE=0x4000
-CONFIG_ENV_OFFSET=0x700000
-CONFIG_DM_GPIO=y
+#include <configs/imx95_frdm.config>
 CONFIG_DEFAULT_DEVICE_TREE="freescale/imx95-15x15-frdm"
 CONFIG_TARGET_IMX95_15X15_FRDM=y
-CONFIG_OF_LIBFDT_OVERLAY=y
-CONFIG_SYS_MONITOR_LEN=524288
-CONFIG_SPL_MMC=y
-CONFIG_SPL_SERIAL=y
-CONFIG_SPL_DRIVERS_MISC=y
-CONFIG_SPL_TEXT_BASE=0x20480000
-CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x204d6000
-CONFIG_SPL_BSS_MAX_SIZE=0x2000
-CONFIG_SYS_LOAD_ADDR=0x90400000
-# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SPL=y
-CONFIG_SPL_RECOVER_DATA_SECTION=y
-CONFIG_PCI=y
-CONFIG_SYS_MEMTEST_START=0x90000000
-CONFIG_SYS_MEMTEST_END=0xA0000000
-CONFIG_REMAKE_ELF=y
-CONFIG_FIT=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_BOOTCOMMAND="bootflow scan -l; run bsp_bootcmd"
 CONFIG_DEFAULT_FDT_FILE="imx95-15x15-frdm.dtb"
-CONFIG_SYS_CBSIZE=2048
-CONFIG_SYS_PBSIZE=2074
-# CONFIG_BOARD_INIT is not set
-CONFIG_BOARD_LATE_INIT=y
-CONFIG_PCI_INIT_R=y
-CONFIG_SPL_MAX_SIZE=0x20000
-CONFIG_SPL_BOARD_INIT=y
-CONFIG_SPL_LOAD_IMX_CONTAINER=y
-CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x93200000
-CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
-CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
-CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1040
-CONFIG_SPL_I2C=y
-CONFIG_SPL_DM_MAILBOX=y
-CONFIG_SPL_POWER=y
-CONFIG_SPL_WATCHDOG=y
-CONFIG_SYS_PROMPT="u-boot=> "
-CONFIG_CMD_ERASEENV=y
-CONFIG_CMD_NVEDIT_EFI=y
-CONFIG_CRC32_VERIFY=y
-CONFIG_CMD_MEMTEST=y
-CONFIG_CMD_CLK=y
-CONFIG_CMD_DFU=y
-CONFIG_CMD_FUSE=y
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_GPT=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_PCI=y
-CONFIG_CMD_POWEROFF=y
-CONFIG_CMD_REMOTEPROC=y
-CONFIG_CMD_SNTP=y
-CONFIG_CMD_CACHE=y
-CONFIG_CMD_EFIDEBUG=y
-CONFIG_CMD_RTC=y
-CONFIG_CMD_TIME=y
-CONFIG_CMD_GETTIME=y
-CONFIG_CMD_TIMER=y
-CONFIG_CMD_REGULATOR=y
-CONFIG_CMD_HASH=y
-CONFIG_CMD_EXT4_WRITE=y
-CONFIG_OF_CONTROL=y
-CONFIG_SPL_OF_CONTROL=y
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_NOWHERE=y
-CONFIG_ENV_IS_IN_MMC=y
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_ENV_MMC_DEVICE_INDEX=1
-CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
-CONFIG_USE_ETHPRIME=y
-CONFIG_ETHPRIME="eth0"
-CONFIG_NET_RANDOM_ETHADDR=y
-CONFIG_SPL_DM=y
-CONFIG_SPL_OF_TRANSLATE=y
-CONFIG_SPL_CLK=y
-CONFIG_SPL_CLK_CCF=y
-CONFIG_CLK_SCMI=y
-CONFIG_SPL_CLK_SCMI=y
-CONFIG_CLK_IMX95_BLKCTRL=y
-CONFIG_DFU_MMC=y
-CONFIG_DFU_RAM=y
-CONFIG_SPL_FIRMWARE=y
-# CONFIG_SCMI_AGENT_SMCCC is not set
-CONFIG_IMX_SM_CPU=y
-CONFIG_IMX_SM_LMM=y
-CONFIG_IMX_RGPIO2P=y
-CONFIG_DM_PCA953X=y
-CONFIG_ADP5585_GPIO=y
-CONFIG_DM_I2C=y
-CONFIG_SYS_I2C_IMX_LPI2C=y
-CONFIG_IMX_MU_MBOX=y
-CONFIG_SUPPORT_EMMC_BOOT=y
-CONFIG_MMC_IO_VOLTAGE=y
-CONFIG_MMC_UHS_SUPPORT=y
-CONFIG_MMC_HS400_ES_SUPPORT=y
-CONFIG_MMC_HS400_SUPPORT=y
-CONFIG_FSL_USDHC=y
-CONFIG_MTD=y
-CONFIG_DM_MDIO=y
-CONFIG_MII=y
-CONFIG_FSL_ENETC=y
-CONFIG_PHYLIB=y
-CONFIG_PHY_AQUANTIA=y
-CONFIG_PHY_MOTORCOMM=y
-CONFIG_PCIE_ECAM_GENERIC=y
-CONFIG_PCIE_DW_IMX=y
-CONFIG_PHY=y
-CONFIG_PINCTRL=y
-CONFIG_SPL_PINCTRL=y
-CONFIG_PINCTRL_IMX_SCMI=y
-CONFIG_POWER_DOMAIN=y
-CONFIG_SCMI_POWER_DOMAIN=y
-CONFIG_REMOTEPROC_IMX=y
-CONFIG_SPL_DM_REGULATOR=y
-CONFIG_DM_REGULATOR_FIXED=y
-CONFIG_SPL_DM_REGULATOR_FIXED=y
-CONFIG_DM_REGULATOR_GPIO=y
-CONFIG_DM_RTC=y
-CONFIG_DM_SERIAL=y
-CONFIG_FSL_LPUART=y
-CONFIG_ULP_WATCHDOG=y
-CONFIG_WDT=y
-CONFIG_LZO=y
-CONFIG_BZIP2=y
diff --git a/configs/imx95_19x19_frdm_pro_defconfig b/configs/imx95_19x19_frdm_pro_defconfig
new file mode 100644
index 0000000000000000000000000000000000000000..2f03f5f06381bb01ecb5caec405774b05a3f113b
--- /dev/null
+++ b/configs/imx95_19x19_frdm_pro_defconfig
@@ -0,0 +1,12 @@
+#include <configs/imx95_frdm.config>
+CONFIG_SF_DEFAULT_SPEED=40000000
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx95-19x19-frdm-pro"
+CONFIG_TARGET_IMX95_19X19_FRDM_PRO=y
+CONFIG_DEFAULT_FDT_FILE="imx95-19x19-frdm-pro.dtb"
+CONFIG_SYS_RX_ETH_BUFFER=8
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_NXP_FSPI=y
diff --git a/configs/imx95_15x15_frdm_defconfig b/configs/imx95_frdm.config
similarity index 96%
copy from configs/imx95_15x15_frdm_defconfig
copy to configs/imx95_frdm.config
index 803db9adff7c49a52879421cfb516ebb92b9bc9a..62459f75c1a3e5fa06944b7d30e481fca614dec5 100644
--- a/configs/imx95_15x15_frdm_defconfig
+++ b/configs/imx95_frdm.config
@@ -11,8 +11,6 @@ CONFIG_NR_DRAM_BANKS=3
 CONFIG_ENV_SIZE=0x4000
 CONFIG_ENV_OFFSET=0x700000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="freescale/imx95-15x15-frdm"
-CONFIG_TARGET_IMX95_15X15_FRDM=y
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
@@ -34,7 +32,6 @@ CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOOTCOMMAND="bootflow scan -l; run bsp_bootcmd"
-CONFIG_DEFAULT_FDT_FILE="imx95-15x15-frdm.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
 # CONFIG_BOARD_INIT is not set
diff --git a/doc/board/nxp/imx95_frdm.rst b/doc/board/nxp/imx95_frdm.rst
index 85ef9022e76fc0d8f2a5524128309939f22f4715..a0a5422bf8a7ba574f38dc19898f19f4dc4a6f8a 100644
--- a/doc/board/nxp/imx95_frdm.rst
+++ b/doc/board/nxp/imx95_frdm.rst
@@ -3,7 +3,7 @@
 imx95_frdm
 =======================
 
-U-Boot for the NXP i.MX95 15x15 FRDM board
+U-Boot for the NXP i.MX95 15x15 FRDM board & i.MX95 19x19 FRDM PRO board
 
 Quick Start
 -----------
@@ -73,6 +73,13 @@ i.MX95 B0 silicon version on 15x15 LPDDR4X FRDM Board
    $ make board=mx95lp4x-15 oei=ddr DEBUG=1 r=B0 all
    $ cp build/mx95lp4x-15/ddr/oei-m33-ddr.bin $(srctree)
 
+i.MX95 B0 silicon version on 19x19 LPDDR5 FRDM PRO Board
+
+.. code-block:: bash
+
+   $ make board=mx95lp5-19 oei=ddr DEBUG=1 r=B0 all
+   $ cp build/mx95lp5-19/ddr/oei-m33-ddr.bin $(srctree)
+
 Get and Build System Manager Image
 --------------------------------------
 
@@ -88,9 +95,21 @@ branch: master
    $ export TOOLS=$PWD
    $ git clone -b master https://github.com/nxp-imx/imx-sm.git
    $ cd imx-sm
+
+i.MX95 B0 silicon version on 15x15 LPDDR4X FRDM Board
+
+.. code-block:: bash
+
    $ make config=mx95evk all
    $ cp build/mx95evk/m33_image.bin $(srctree)
 
+i.MX95 B0 silicon version on 19x19 LPDDR5 FRDM PRO Board
+
+.. code-block:: bash
+
+   $ make config=other/mx95frdm-pro all
+   $ cp build/other/mx95frdm-pro/m33_image.bin $(srctree)
+
 Get and Build the ARM Trusted Firmware
 --------------------------------------
 
@@ -119,6 +138,14 @@ i.MX95 B0 silicon version on 15x15 LPDDR4X FRDM Board
    $ make imx95_15x15_frdm_defconfig
    $ make
 
+i.MX95 B0 silicon version on 19x19 LPDDR5 FRDM PRO Board
+
+.. code-block:: bash
+
+   $ export CROSS_COMPILE=aarch64-poky-linux-
+   $ make imx95_19x19_frdm_pro_defconfig
+   $ make
+
 Copy imx-boot-imx95.bin to the MicroSD card:
 
 .. code-block:: bash
diff --git a/include/configs/imx95_frdm.h b/include/configs/imx95_frdm.h
index e64294a2bb15a025351b9bc9f2c8a0ee0a7e9224..78a28d7a5a137070c29ac25a0b219599866f6923 100644
--- a/include/configs/imx95_frdm.h
+++ b/include/configs/imx95_frdm.h
@@ -18,7 +18,11 @@
 
 #define PHYS_SDRAM_SIZE			0x70000000 /* 2GB - 256MB DDR */
 
+#ifdef CONFIG_TARGET_IMX95_19X19_FRDM_PRO
+#define PHYS_SDRAM_2_SIZE		0x380000000UL /* 14GB (Totally 16GB) */
+#else
 #define PHYS_SDRAM_2_SIZE		0x180000000 /* 6GB (Totally 8GB) */
+#endif
 
 #define CFG_SYS_SECURE_SDRAM_BASE   0x8A000000 /* Secure DDR region for A55 */
 #define CFG_SYS_SECURE_SDRAM_SIZE   0x04000000

-- 
2.34.1

