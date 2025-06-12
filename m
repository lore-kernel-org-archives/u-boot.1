Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C32EC71136
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 18:11:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 951AE82B97;
	Thu, 12 Jun 2025 20:11:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FYk85u3b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9107C82BD9; Thu, 12 Jun 2025 20:11:33 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EE4382B70
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 20:11:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-60634f82c77so395153eaf.1
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 11:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749751890; x=1750356690; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=L4jlP83tVXRZ9nkPcWOFzYr/ChrQVvi7PVIp5Gn1+U8=;
 b=FYk85u3bL0I0Wo0mI9zSaqUprCychyTXGdTsKF1Dso1G48YTtt6A8Mn8HMXpgegRZV
 rdxQEDhDJzabmMhJzASsjGufSxbWIWPqpOmS4S2dGXFModTTTjHIEvajKdNNfZ2AAUi8
 XGOUiA2fDghx+ff5WYrJFnzS8CaptXPJq0kAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749751890; x=1750356690;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L4jlP83tVXRZ9nkPcWOFzYr/ChrQVvi7PVIp5Gn1+U8=;
 b=rZi3+87HP5s/klXfBKxZBzASXfgbWS4GAw87g//Jb9yax0oktZitikCOkbGI/Y0ELm
 J9/DKnQExae2RL3BKxLnLW4hb7GvSINQCsjO2C0CHwzTZDY4QMhs/rrFaJfoIaZ3WI3j
 aI5YddxAw+zwoq5megdIToD8Qc/ntLCnHI5/pQFtK31AzzUVSeuNKlYf5SRtL1lUhrLZ
 OHH/I2I12RlBfakT01K77hehvdS1QcXZ9t01/+lln75SGKcs/sH5UEBXg9sLfrPWgUnM
 c2OfhyggXMLalj8aizwI2tv038G7K7iTJhWvh6iGYhQkJHiLtB19t9wOpgmeDIhqlKRI
 FkUA==
X-Gm-Message-State: AOJu0YwCbiB5tBKYyFjoEme4mFAccoJthcpEJ5rivC9YIQj+CBS5D12e
 TCMwhFTGBZOZZS7JQaL40i3IlyNAStSqFQ/vaDiRszmVGoAUKuFENfSaK31AZESCZQa8Cv7oUZd
 b/C4wkDA=
X-Gm-Gg: ASbGncvpnVxJI2GcVDTjrKWPNjAgFqd3iVXYuC2F7OuLqpIavJKt3vSGCXCvMywDSOZ
 sSzYoVps5ALuIMpnxkLIv44tlueHx3ATSnri4sppp4KP2P/RU1ymAJje8XGKhP9nSIcPtTWAluG
 4IAhvaaoIO1vYBs+wlYf6AyUs2YRXc61Y6Jz3pXZtCtrvVHZpqeiBnHFvF8WMClG2rns1d6d2Lu
 iOlLuUTfqK7+Pw2hFcjofQFc+shkeL287U874irj00ujyM4ObJ1C3JAUFHbsDX0oTKP5mM3DoOc
 VqnRQ85iC+f+0nT0JsyuUiUhrnoyYn4aLCYOgLD1kwMOqu4Xy1Hkz6Wj2unGY9EVW1T9XSHAT+x
 i5ZdBGm/E+qO30geXPShiaYRigw==
X-Google-Smtp-Source: AGHT+IH6Swl9ldsvehA77mfGAYCP5BRUq9FObNmDjF9W0GJ2b5wkyWDmus6AYsRRu4u+UuX43oPtUw==
X-Received: by 2002:a05:6808:318e:b0:406:7118:de09 with SMTP id
 5614622812f47-40a71d9e5f8mr268994b6e.10.1749751889947; 
 Thu, 12 Jun 2025 11:11:29 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-610fd51bfcfsm234668eaf.38.2025.06.12.11.11.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 11:11:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>
Subject: [PATCH] arm: zynqmp: Remove local copy of
 'dt-bindings/clock/xlnx-zynqmp-clk.h'
Date: Thu, 12 Jun 2025 12:11:28 -0600
Message-ID: <20250612181128.340232-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

As part of the recent cleanup of dt-bindigns header files we did not
remove our copy of dt-bindings/clock/xlnx-zynqmp-clk.h at the time. This
is because the difference between ours and current upstream is that
current upstream has a #warning to not use it and to instead use
xlnx-zynqmp-clk.h. So we change zynqmp-clk-ccf.dtsi to use the other
and upstream-only file and then delete our dt-bindings file.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Michal Simek <michal.simek@amd.com>
---
 arch/arm/dts/zynqmp-clk-ccf.dtsi            |   2 +-
 include/dt-bindings/clock/xlnx-zynqmp-clk.h | 126 --------------------
 2 files changed, 1 insertion(+), 127 deletions(-)
 delete mode 100644 include/dt-bindings/clock/xlnx-zynqmp-clk.h

diff --git a/arch/arm/dts/zynqmp-clk-ccf.dtsi b/arch/arm/dts/zynqmp-clk-ccf.dtsi
index 385fed8a852a..52e122fc7c9e 100644
--- a/arch/arm/dts/zynqmp-clk-ccf.dtsi
+++ b/arch/arm/dts/zynqmp-clk-ccf.dtsi
@@ -8,7 +8,7 @@
  * Michal Simek <michal.simek@amd.com>
  */
 
-#include <dt-bindings/clock/xlnx-zynqmp-clk.h>
+#include "xlnx-zynqmp-clk.h"
 / {
 	pss_ref_clk: pss-ref-clk {
 		bootph-all;
diff --git a/include/dt-bindings/clock/xlnx-zynqmp-clk.h b/include/dt-bindings/clock/xlnx-zynqmp-clk.h
deleted file mode 100644
index cdc4c0b9a374..000000000000
--- a/include/dt-bindings/clock/xlnx-zynqmp-clk.h
+++ /dev/null
@@ -1,126 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Xilinx Zynq MPSoC Firmware layer
- *
- *  Copyright (C) 2014-2018 Xilinx, Inc.
- *
- */
-
-#ifndef _DT_BINDINGS_CLK_ZYNQMP_H
-#define _DT_BINDINGS_CLK_ZYNQMP_H
-
-#define IOPLL			0
-#define RPLL			1
-#define APLL			2
-#define DPLL			3
-#define VPLL			4
-#define IOPLL_TO_FPD		5
-#define RPLL_TO_FPD		6
-#define APLL_TO_LPD		7
-#define DPLL_TO_LPD		8
-#define VPLL_TO_LPD		9
-#define ACPU			10
-#define ACPU_HALF		11
-#define DBF_FPD			12
-#define DBF_LPD			13
-#define DBG_TRACE		14
-#define DBG_TSTMP		15
-#define DP_VIDEO_REF		16
-#define DP_AUDIO_REF		17
-#define DP_STC_REF		18
-#define GDMA_REF		19
-#define DPDMA_REF		20
-#define DDR_REF			21
-#define SATA_REF		22
-#define PCIE_REF		23
-#define GPU_REF			24
-#define GPU_PP0_REF		25
-#define GPU_PP1_REF		26
-#define TOPSW_MAIN		27
-#define TOPSW_LSBUS		28
-#define GTGREF0_REF		29
-#define LPD_SWITCH		30
-#define LPD_LSBUS		31
-#define USB0_BUS_REF		32
-#define USB1_BUS_REF		33
-#define USB3_DUAL_REF		34
-#define USB0			35
-#define USB1			36
-#define CPU_R5			37
-#define CPU_R5_CORE		38
-#define CSU_SPB			39
-#define CSU_PLL			40
-#define PCAP			41
-#define IOU_SWITCH		42
-#define GEM_TSU_REF		43
-#define GEM_TSU			44
-#define GEM0_TX			45
-#define GEM1_TX			46
-#define GEM2_TX			47
-#define GEM3_TX			48
-#define GEM0_RX			49
-#define GEM1_RX			50
-#define GEM2_RX			51
-#define GEM3_RX			52
-#define QSPI_REF		53
-#define SDIO0_REF		54
-#define SDIO1_REF		55
-#define UART0_REF		56
-#define UART1_REF		57
-#define SPI0_REF		58
-#define SPI1_REF		59
-#define NAND_REF		60
-#define I2C0_REF		61
-#define I2C1_REF		62
-#define CAN0_REF		63
-#define CAN1_REF		64
-#define CAN0			65
-#define CAN1			66
-#define DLL_REF			67
-#define ADMA_REF		68
-#define TIMESTAMP_REF		69
-#define AMS_REF			70
-#define PL0_REF			71
-#define PL1_REF			72
-#define PL2_REF			73
-#define PL3_REF			74
-#define WDT			75
-#define IOPLL_INT		76
-#define IOPLL_PRE_SRC		77
-#define IOPLL_HALF		78
-#define IOPLL_INT_MUX		79
-#define IOPLL_POST_SRC		80
-#define RPLL_INT		81
-#define RPLL_PRE_SRC		82
-#define RPLL_HALF		83
-#define RPLL_INT_MUX		84
-#define RPLL_POST_SRC		85
-#define APLL_INT		86
-#define APLL_PRE_SRC		87
-#define APLL_HALF		88
-#define APLL_INT_MUX		89
-#define APLL_POST_SRC		90
-#define DPLL_INT		91
-#define DPLL_PRE_SRC		92
-#define DPLL_HALF		93
-#define DPLL_INT_MUX		94
-#define DPLL_POST_SRC		95
-#define VPLL_INT		96
-#define VPLL_PRE_SRC		97
-#define VPLL_HALF		98
-#define VPLL_INT_MUX		99
-#define VPLL_POST_SRC		100
-#define CAN0_MIO		101
-#define CAN1_MIO		102
-#define ACPU_FULL		103
-#define GEM0_REF		104
-#define GEM1_REF		105
-#define GEM2_REF		106
-#define GEM3_REF		107
-#define GEM0_REF_UNG		108
-#define GEM1_REF_UNG		109
-#define GEM2_REF_UNG		110
-#define GEM3_REF_UNG		111
-#define LPD_WDT			112
-
-#endif
-- 
2.43.0

