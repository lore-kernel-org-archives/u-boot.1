Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C9CC3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 09:46:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A511487E30;
	Thu, 25 Jul 2024 11:46:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="UrPhDgPt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B5D186E85; Thu, 25 Jul 2024 11:46:32 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E78D86DBD
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 11:46:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=fa7d=OZ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1721900783; bh=fvZdeuRPEvZJFd3DeSauCQfGKehdyJV9pCm8WJVYzXQ=;
 b=UrPhDgPtDL7cdg9L6LdP7WKsNCKoEPfOTASXGSFg0GGZvwVaFJMXe63Rd/ecTYt86pRcJ2H9N
 xujuS0onKkO/J3lqX+1s0jBznbAomH25YqalF4T6/Jd5pjvNrMktEulb/W2xmlCZuZWfg3juian
 N+JgXpzpcH7gkk5aZkqFuudNEJlp3j7MLJMC/PgdOzI7YxbFAKeDw6pQFKUUNuM4XlAmf00f7tc
 JrmCG5NmjxSi3yn+TdcSoRR5uwniSXyMxeT08Xwn8xaRMcp/21Td/5KzBKStiMJpyS6uAfAuHmD
 RFX90ofzFNN5+jOt0hp7Zo4phAqIvm5vSb3fAGf+YXOw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de, Jonas
 Karlman <jonas@kwiboo.se>
Subject: [PATCH 2/2] rockchip: Use files from dts/upstream
Date: Thu, 25 Jul 2024 09:46:04 +0000
Message-ID: <20240725094609.3113632-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725094609.3113632-1-jonas@kwiboo.se>
References: <20240725094609.3113632-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66a21eeefa07ff5ac5ecd3ee
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

Most Rockchip aarch64 targets have now migrated to use OF_UPSTREAM,
however a few of the old dtsi and dt-bindings files still remain.

Remove remaining common dtsi and header files that can be included
directly from dts/upstream to prevent possible issues when future tags
from devicetree-binding is merged. No changes is expected with this.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rockchip-pinconf.dtsi           | 344 -------------------
 include/dt-bindings/clock/rockchip,rk808.h   |  11 -
 include/dt-bindings/soc/rockchip,boot-mode.h |  16 -
 include/dt-bindings/soc/rockchip,vop2.h      |  18 -
 4 files changed, 389 deletions(-)
 delete mode 100644 arch/arm/dts/rockchip-pinconf.dtsi
 delete mode 100644 include/dt-bindings/clock/rockchip,rk808.h
 delete mode 100644 include/dt-bindings/soc/rockchip,boot-mode.h
 delete mode 100644 include/dt-bindings/soc/rockchip,vop2.h

diff --git a/arch/arm/dts/rockchip-pinconf.dtsi b/arch/arm/dts/rockchip-pinconf.dtsi
deleted file mode 100644
index 5c645437b507..000000000000
--- a/arch/arm/dts/rockchip-pinconf.dtsi
+++ /dev/null
@@ -1,344 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (c) 2021 Rockchip Electronics Co., Ltd.
- */
-
-&pinctrl {
-	/omit-if-no-ref/
-	pcfg_pull_up: pcfg-pull-up {
-		bias-pull-up;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_down: pcfg-pull-down {
-		bias-pull-down;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_none: pcfg-pull-none {
-		bias-disable;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_none_drv_level_0: pcfg-pull-none-drv-level-0 {
-		bias-disable;
-		drive-strength = <0>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_none_drv_level_1: pcfg-pull-none-drv-level-1 {
-		bias-disable;
-		drive-strength = <1>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_none_drv_level_2: pcfg-pull-none-drv-level-2 {
-		bias-disable;
-		drive-strength = <2>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_none_drv_level_3: pcfg-pull-none-drv-level-3 {
-		bias-disable;
-		drive-strength = <3>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_none_drv_level_4: pcfg-pull-none-drv-level-4 {
-		bias-disable;
-		drive-strength = <4>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_none_drv_level_5: pcfg-pull-none-drv-level-5 {
-		bias-disable;
-		drive-strength = <5>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_none_drv_level_6: pcfg-pull-none-drv-level-6 {
-		bias-disable;
-		drive-strength = <6>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_none_drv_level_7: pcfg-pull-none-drv-level-7 {
-		bias-disable;
-		drive-strength = <7>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_none_drv_level_8: pcfg-pull-none-drv-level-8 {
-		bias-disable;
-		drive-strength = <8>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_none_drv_level_9: pcfg-pull-none-drv-level-9 {
-		bias-disable;
-		drive-strength = <9>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_none_drv_level_10: pcfg-pull-none-drv-level-10 {
-		bias-disable;
-		drive-strength = <10>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_none_drv_level_11: pcfg-pull-none-drv-level-11 {
-		bias-disable;
-		drive-strength = <11>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_none_drv_level_12: pcfg-pull-none-drv-level-12 {
-		bias-disable;
-		drive-strength = <12>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_none_drv_level_13: pcfg-pull-none-drv-level-13 {
-		bias-disable;
-		drive-strength = <13>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_none_drv_level_14: pcfg-pull-none-drv-level-14 {
-		bias-disable;
-		drive-strength = <14>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_none_drv_level_15: pcfg-pull-none-drv-level-15 {
-		bias-disable;
-		drive-strength = <15>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_up_drv_level_0: pcfg-pull-up-drv-level-0 {
-		bias-pull-up;
-		drive-strength = <0>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_up_drv_level_1: pcfg-pull-up-drv-level-1 {
-		bias-pull-up;
-		drive-strength = <1>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_up_drv_level_2: pcfg-pull-up-drv-level-2 {
-		bias-pull-up;
-		drive-strength = <2>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_up_drv_level_3: pcfg-pull-up-drv-level-3 {
-		bias-pull-up;
-		drive-strength = <3>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_up_drv_level_4: pcfg-pull-up-drv-level-4 {
-		bias-pull-up;
-		drive-strength = <4>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_up_drv_level_5: pcfg-pull-up-drv-level-5 {
-		bias-pull-up;
-		drive-strength = <5>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_up_drv_level_6: pcfg-pull-up-drv-level-6 {
-		bias-pull-up;
-		drive-strength = <6>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_up_drv_level_7: pcfg-pull-up-drv-level-7 {
-		bias-pull-up;
-		drive-strength = <7>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_up_drv_level_8: pcfg-pull-up-drv-level-8 {
-		bias-pull-up;
-		drive-strength = <8>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_up_drv_level_9: pcfg-pull-up-drv-level-9 {
-		bias-pull-up;
-		drive-strength = <9>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_up_drv_level_10: pcfg-pull-up-drv-level-10 {
-		bias-pull-up;
-		drive-strength = <10>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_up_drv_level_11: pcfg-pull-up-drv-level-11 {
-		bias-pull-up;
-		drive-strength = <11>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_up_drv_level_12: pcfg-pull-up-drv-level-12 {
-		bias-pull-up;
-		drive-strength = <12>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_up_drv_level_13: pcfg-pull-up-drv-level-13 {
-		bias-pull-up;
-		drive-strength = <13>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_up_drv_level_14: pcfg-pull-up-drv-level-14 {
-		bias-pull-up;
-		drive-strength = <14>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_up_drv_level_15: pcfg-pull-up-drv-level-15 {
-		bias-pull-up;
-		drive-strength = <15>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_down_drv_level_0: pcfg-pull-down-drv-level-0 {
-		bias-pull-down;
-		drive-strength = <0>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_down_drv_level_1: pcfg-pull-down-drv-level-1 {
-		bias-pull-down;
-		drive-strength = <1>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_down_drv_level_2: pcfg-pull-down-drv-level-2 {
-		bias-pull-down;
-		drive-strength = <2>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_down_drv_level_3: pcfg-pull-down-drv-level-3 {
-		bias-pull-down;
-		drive-strength = <3>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_down_drv_level_4: pcfg-pull-down-drv-level-4 {
-		bias-pull-down;
-		drive-strength = <4>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_down_drv_level_5: pcfg-pull-down-drv-level-5 {
-		bias-pull-down;
-		drive-strength = <5>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_down_drv_level_6: pcfg-pull-down-drv-level-6 {
-		bias-pull-down;
-		drive-strength = <6>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_down_drv_level_7: pcfg-pull-down-drv-level-7 {
-		bias-pull-down;
-		drive-strength = <7>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_down_drv_level_8: pcfg-pull-down-drv-level-8 {
-		bias-pull-down;
-		drive-strength = <8>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_down_drv_level_9: pcfg-pull-down-drv-level-9 {
-		bias-pull-down;
-		drive-strength = <9>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_down_drv_level_10: pcfg-pull-down-drv-level-10 {
-		bias-pull-down;
-		drive-strength = <10>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_down_drv_level_11: pcfg-pull-down-drv-level-11 {
-		bias-pull-down;
-		drive-strength = <11>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_down_drv_level_12: pcfg-pull-down-drv-level-12 {
-		bias-pull-down;
-		drive-strength = <12>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_down_drv_level_13: pcfg-pull-down-drv-level-13 {
-		bias-pull-down;
-		drive-strength = <13>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_down_drv_level_14: pcfg-pull-down-drv-level-14 {
-		bias-pull-down;
-		drive-strength = <14>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_down_drv_level_15: pcfg-pull-down-drv-level-15 {
-		bias-pull-down;
-		drive-strength = <15>;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_up_smt: pcfg-pull-up-smt {
-		bias-pull-up;
-		input-schmitt-enable;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_down_smt: pcfg-pull-down-smt {
-		bias-pull-down;
-		input-schmitt-enable;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_none_smt: pcfg-pull-none-smt {
-		bias-disable;
-		input-schmitt-enable;
-	};
-
-	/omit-if-no-ref/
-	pcfg_pull_none_drv_level_0_smt: pcfg-pull-none-drv-level-0-smt {
-		bias-disable;
-		drive-strength = <0>;
-		input-schmitt-enable;
-	};
-
-	/omit-if-no-ref/
-	pcfg_output_high: pcfg-output-high {
-		output-high;
-	};
-
-	/omit-if-no-ref/
-	pcfg_output_low: pcfg-output-low {
-		output-low;
-	};
-};
diff --git a/include/dt-bindings/clock/rockchip,rk808.h b/include/dt-bindings/clock/rockchip,rk808.h
deleted file mode 100644
index 1a873432f965..000000000000
--- a/include/dt-bindings/clock/rockchip,rk808.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/*
- * This header provides constants clk index RK808 pmic clkout
- */
-#ifndef _CLK_ROCKCHIP_RK808
-#define _CLK_ROCKCHIP_RK808
-
-/* CLOCKOUT index */
-#define RK808_CLKOUT0		0
-#define RK808_CLKOUT1		1
-
-#endif
diff --git a/include/dt-bindings/soc/rockchip,boot-mode.h b/include/dt-bindings/soc/rockchip,boot-mode.h
deleted file mode 100644
index 4b0914c0989d..000000000000
--- a/include/dt-bindings/soc/rockchip,boot-mode.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ROCKCHIP_BOOT_MODE_H
-#define __ROCKCHIP_BOOT_MODE_H
-
-/*high 24 bits is tag, low 8 bits is type*/
-#define REBOOT_FLAG		0x5242C300
-/* normal boot */
-#define BOOT_NORMAL		(REBOOT_FLAG + 0)
-/* enter bootloader rockusb mode */
-#define BOOT_BL_DOWNLOAD	(REBOOT_FLAG + 1)
-/* enter recovery */
-#define BOOT_RECOVERY		(REBOOT_FLAG + 3)
- /* enter fastboot mode */
-#define BOOT_FASTBOOT		(REBOOT_FLAG + 9)
-
-#endif
diff --git a/include/dt-bindings/soc/rockchip,vop2.h b/include/dt-bindings/soc/rockchip,vop2.h
deleted file mode 100644
index 668f199df9f0..000000000000
--- a/include/dt-bindings/soc/rockchip,vop2.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
-
-#ifndef __DT_BINDINGS_ROCKCHIP_VOP2_H
-#define __DT_BINDINGS_ROCKCHIP_VOP2_H
-
-#define ROCKCHIP_VOP2_EP_RGB0	1
-#define ROCKCHIP_VOP2_EP_HDMI0	2
-#define ROCKCHIP_VOP2_EP_EDP0	3
-#define ROCKCHIP_VOP2_EP_MIPI0	4
-#define ROCKCHIP_VOP2_EP_LVDS0	5
-#define ROCKCHIP_VOP2_EP_MIPI1	6
-#define ROCKCHIP_VOP2_EP_LVDS1	7
-#define ROCKCHIP_VOP2_EP_HDMI1	8
-#define ROCKCHIP_VOP2_EP_EDP1	9
-#define ROCKCHIP_VOP2_EP_DP0	10
-#define ROCKCHIP_VOP2_EP_DP1	11
-
-#endif /* __DT_BINDINGS_ROCKCHIP_VOP2_H */
-- 
2.45.2

