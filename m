Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26DEBCD3447
	for <u-boot@archiver.kernel.org>; Sun, 10 May 2026 00:07:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B5A884A72;
	Sun, 10 May 2026 02:07:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="OyMCuZW4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37F3284A72; Sun, 10 May 2026 02:07:31 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC80684A6F
 for <u-boot@lists.denx.de>; Sun, 10 May 2026 02:07:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=guodong@riscstar.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2b45cb89f7eso20896445ad.0
 for <u-boot@lists.denx.de>; Sat, 09 May 2026 17:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1778371647; x=1778976447;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dX5aXeYYAjMtlJ2+Zaj/hmF29JQ3enOPS/l3QXcn+D4=;
 b=OyMCuZW408Wcju28jPnxiNOA71PGsc4bPPs2L45fKNFXJGOdgLAMI4F9WWzigBFv6m
 ccxM/CuU4zaIMGfKi0MVTtIwFn3Xp9dW5OXTgN2+FoO3U2MsYNjxXeRTB2+93VPrkfX7
 fdHbdoP1jx+2Nuz52y6lN6d1zgxLaH6dkYPlmRTKHygcPcmgX7GzMZ1vSDotddxzgOgo
 EI+EQBHsza2Qj/+C+3ewdhjkZbmD0N+Fm/al7IZOJPLS4cg5w2VqcQ8x8pGmM26SbEws
 +NuzvNn0k+S5Rew9f0KsYPDgt6JsFStgwA+l9Uw6DVkFCC3gyWd+GwyTEXdTXMq00ZH/
 vTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778371647; x=1778976447;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dX5aXeYYAjMtlJ2+Zaj/hmF29JQ3enOPS/l3QXcn+D4=;
 b=N6DjfaNDWVMx6r16CH3piCIf4CJWRfG6SwTWfcVvBy0QodxHUOoiKMW1pFfME+bt+6
 CRFiyrZc4+7CtKXXHSHlt7RPmLpvL/MlKNv58qNGEwUIS2QOtdkJjAlj1qj8dk0Rckjy
 Rsxj2H+aX7+jFo5b4YG26xW96jNgCowKXB9+vvr9ZFGDMzoHtL5nDcks0v26inbZdm8Q
 JshxAfhAINVqrW71WuSqCdNZIkXeKbzq76ESmoOu3JWLDMlWJAsXGcsrbmbcZLA3NHTu
 FMNJKlLPXmKhNXbx3ojOXuUb789WbO0uxfQfgs+3wAGu5olRNk6Yx2g2hzIYqGopHVpB
 G9Uw==
X-Gm-Message-State: AOJu0YxkK3uJ8Fs8HtWNgnqtKfHlVTQ9jXEg4GYK5DbFk549MnKoKsch
 Y5upRO0kPcVpbrf5MjhXd6oL0ZIhfLkCTldfDdLx4QOTDAySQz4tKec24jMNiLwr8dY=
X-Gm-Gg: Acq92OE0eL9KqpA+INi9P7L43NjqhvlVBx6D6QKV3FYL06AZ41x8eViQdlBXl9iI7s5
 kXDQNqUfXAOm4iGzCQ9be7H6GUPd3QpLtO391In/CAeeg+BdEstW+tN2+wi/7bIFoWXxeMaXLsN
 bFQ30a0QU3cWvZ5wxAycOPnspuJKJYXipLd0u72F/gut1pq/DP4nmOg5Z4fFBQq7eqaKDS7Nrrf
 clofYKH6Ywp7N2eT4JVXjGTeNTwcesuOr0kgWd0pDVCJ2MF/pO1jVusGYMTYs3yPbvB8iHp4+iT
 Z+h00E8Iz9qUIkO27/Gh81ZwGf4E2t0E/MxEv/NGblG37kssizvapPJr6clVT+urWREaJPoEEiH
 inguKiioskCbOBt7I+W+SvxJmTpmr9uuCcyKP3rcv49uFy3OoRfbjdGR3uz6p2uwnWyFaot4Tw/
 HkALzihJTiokqwGsWETmJwJzVWkh2zlmxfHwBOlkcfRJg=
X-Received: by 2002:a17:903:40c5:b0:2ae:6259:5aff with SMTP id
 d9443c01a7336-2ba78b30d7amr189673745ad.6.1778371647415; 
 Sat, 09 May 2026 17:07:27 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::30f3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1d3fee3sm57010625ad.18.2026.05.09.17.07.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 17:07:27 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Sun, 10 May 2026 08:06:27 -0400
Subject: [PATCH 5/8] dts: k1: switch BPI-F3 build to upstream DT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-b4-k1-clk-reset-upstream-dts-v1-5-db0b0503ee44@riscstar.com>
References: <20260510-b4-k1-clk-reset-upstream-dts-v1-0-db0b0503ee44@riscstar.com>
In-Reply-To: <20260510-b4-k1-clk-reset-upstream-dts-v1-0-db0b0503ee44@riscstar.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Yao Zi <me@ziyao.cc>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Peter Korsgaard <peter@korsgaard.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Finley Xiao <finley.xiao@rock-chips.com>, Rick Chen <rick@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>, u-boot-spacemit@groups.io, 
 Vincent Legoll <legoll@online.fr>, Guodong Xu <guodong@riscstar.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.15.1
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

Adopt the kernel device tree directly from
dts/upstream/src/riscv/spacemit/k1-bananapi-f3.dts instead of carrying
a forked copy under arch/riscv/dts/.

Carry U-Boot-only deltas in k1-bananapi-f3-u-boot.dtsi, in particular
extra parent clocks on &syscon_mpmu and &syscon_apbc. The kernel CCF
registers these parents programmatically inside the syscon driver,
but U-Boot's per-syscon probes look them up by clk_get_by_index() for
inter-controller ordering, so they must appear in DT.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
 arch/riscv/dts/Makefile                   |  1 -
 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi | 30 ++++++++++++++++++++++++++++++
 configs/bananapi-f3_defconfig             |  3 ++-
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
index 8e591cb7aa9..71c5c13d221 100644
--- a/arch/riscv/dts/Makefile
+++ b/arch/riscv/dts/Makefile
@@ -2,7 +2,6 @@
 
 dtb-$(CONFIG_TARGET_ANDES_AE350) += ae350_32.dtb ae350_64.dtb
 dtb-$(CONFIG_TARGET_ANDES_VOYAGER) += qilai-voyager.dtb
-dtb-$(CONFIG_TARGET_BANANAPI_F3) += k1-bananapi-f3.dtb
 dtb-$(CONFIG_TARGET_K230_CANMV) += k230-canmv.dtb
 dtb-$(CONFIG_TARGET_MICROCHIP_ICICLE) += mpfs-icicle-kit.dtb
 dtb-$(CONFIG_TARGET_MILKV_DUO) += cv1800b-milkv-duo.dtb
diff --git a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
new file mode 100644
index 00000000000..9e1925eb68e
--- /dev/null
+++ b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2026 RISCstar Ltd.
+ */
+
+#include <dt-bindings/clock/spacemit,k1-syscon.h>
+#include "binman.dtsi"
+
+/ {
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x00000000 0x00000000 0x80000000>;
+	};
+};
+
+&syscon_mpmu {
+	clocks = <&osc_32k>, <&vctcxo_1m>, <&vctcxo_3m>, <&vctcxo_24m>,
+		 <&pll CLK_PLL1_D4>;
+	clock-names = "osc", "vctcxo_1m", "vctcxo_3m", "vctcxo_24m",
+		      "pll1_d4";
+};
+
+&syscon_apbc {
+	clocks = <&osc_32k>, <&vctcxo_1m>, <&vctcxo_3m>, <&vctcxo_24m>,
+		 <&pll CLK_PLL1_D4>,
+		 <&syscon_mpmu CLK_PLL1_31P5>,
+		 <&syscon_apmu CLK_PMUA_ACLK>;
+	clock-names = "osc", "vctcxo_1m", "vctcxo_3m", "vctcxo_24m",
+		      "pll1_d4", "pll1_d78_31p5", "pmua_aclk";
+};
diff --git a/configs/bananapi-f3_defconfig b/configs/bananapi-f3_defconfig
index 9f9424adc9f..b9a2ee19f53 100644
--- a/configs/bananapi-f3_defconfig
+++ b/configs/bananapi-f3_defconfig
@@ -3,7 +3,7 @@ CONFIG_SYS_MALLOC_LEN=0x1000000
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x1000000
-CONFIG_DEFAULT_DEVICE_TREE="k1-bananapi-f3"
+CONFIG_DEFAULT_DEVICE_TREE="spacemit/k1-bananapi-f3"
 CONFIG_SYS_BOOTM_LEN=0xa000000
 CONFIG_SYS_LOAD_ADDR=0x200000
 CONFIG_TARGET_BANANAPI_F3=y
@@ -16,6 +16,7 @@ CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=276
 # CONFIG_BOARD_INIT is not set
 CONFIG_HUSH_PARSER=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_CLK_SPACEMIT=y
 CONFIG_CLK_SPACEMIT_K1=y

-- 
2.43.0

