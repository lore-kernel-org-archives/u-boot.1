Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AEC7C9830B
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 12:47:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 21EE480A86;
	Wed, 23 Sep 2026 12:47:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P9HGDrtzXKWx; Wed, 23 Sep 2026 12:47:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4970080A84
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790167646;
	b=IMmccKs4iRPxNxDWlQp2qTvBONLEmtb5OaOgiIh/B6ebfDfYU65xctSPQrPgvAlghd/e
	 ZK487F4rkCuBSntSbnevN6hrt/4s4dxKy6MYXZD5cj1AAbTRXA5TM+Rezd6uz/FuYcPpy
	 q4mcqYa5z90K2Z6AAO8Qse2eoDsAEZYr38j2jQre8Z16SyewgnIzqTXJt9zGBjVmLEE7L
	 4TInoGTAMm7IcodFtYJG4pYExkH3HlUyCkvdM0X6kc0ovY2/MmaZhWNbxw1UeWbPJVXrr
	 texx2rhP/Pk/nM6To5ZxPnivjZUJZRJU9y9GC+SGfChVWaG6lePDt5g2ICkvnG917EQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790167646;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9CBfrGcZAn+R0bkz4lUTcFcSs+vTHjjcwS9jkB6+G8k=;
	b=kfdyPqFC4ct3zqVbBL5IGWUykmNigsueC5gEZJzIouGVZWtNkwt1o/U0b9GrvnZCavH/
	 ONbfWjXcfW1QmAdJi0BXnuU8U+NCRcK+pmioRythGWQYcFhSyk2u9/oOgUkb8kQvlv/3p
	 5UrwWBjEn3qMYGVij+9uUGoZcu0EfCpoRnf2Vs2A4oG2c5oIfUZ/ALhzuevVQWKcoWsdj
	 eQXLpSsiUbAuPli7UDEBjkFkXNXEb63DVNrvkM2PUH6zeHAyVhiwUpZF03bVEryKsxHUF
	 ivNcw+yOqmc9XhtM/nKIfMGSUtL/qXI7ccjdziJEWvqzCMslWqlzE5JRCUl5jTrrtdg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PHm4Mt5O;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790167646;
	bh=9CBfrGcZAn+R0bkz4lUTcFcSs+vTHjjcwS9jkB6+G8k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MnNEzru1X7dcZG1hnQuEUSRV2MbwHcW+VPd9mc2KwuSbYe0kHGr54iIzJXDkvfeMk
	 OQoQyzADYN6yL5+YL46To5eIfqgRdwmUHqvdgZXCohDOI2lDUSWLbYwjqJ0vqou/ow
	 lSDqHu+c+4WBKwodoI0xxN0/3eY5sQuUnoI8bF+mpIh8Xt9OQlssCLDEHZSFciVoCd
	 6AGv+2qJ4KaIpyGBhsbI2EWWhekvfGHBW7HZ0wyCQdfN/m/FJZ2TaJEBKBbH6IVD1F
	 MBv3jaev/pHAQkxmtPbmySkoe3mtKtcKB04w3aPu4iqKitieAEKdQOhBrb3i5LtDeB
	 0UcaXJWfmk2Qg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4970080A84;
	Wed, 23 Sep 2026 12:47:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 357D628C
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 12:47:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 229B880A84
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 12:47:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A29WAsLSop29 for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 12:47:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0AA9880A7A
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790167643;
 b=UYsltStJXRiIkAk2fGUIZELaPaIfORJSEYGMgwu2PXqt7ij6NSVV7spdUPZo97Vgq6ad
 05y8YlRPWGDVo/3oDWhErjC6FWUdtA2jRXdTo0cthmC+EPX9WnknjrZr9wYnVOan5vJqD
 VJnZ8HFqy++uhWyixBDdzGfNpwHuRKc5kB2uiktHOpfLWdZLKPNc87niNsr9n811oEhGy
 VHQ3dX/tQ6IepnGYgzmFsx6q2melqhFbS7AgfYKNhK3GknXNLLmwJaogIW/p7FYOlkt/g
 BoWc5BB0SWrLulZ8u9omOoeWMIzTwlYgSPztay6wTzt/59ITbmRb9Mr1ona5iccDBAw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790167643;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=9CBfrGcZAn+R0bkz4lUTcFcSs+vTHjjcwS9jkB6+G8k=;
 b=IFGIvEZlRpX8LUyiWGf1LsDbwEHzWAVPmZJtQxwUvOMw9X8kruHOCUDB1zSA0X2+Ax3K
 iVXrYd1Z7pj2vi4ghLkVKswnbMq7yDSAXanuOAiAP17Lj/8R/YuBwxY6AWy3PqyvAgBcx
 SmbN1KEEJqJI4Ou/XbX9KefLXfhiEoyCCnFC25CudsMljnh6O9pr37gDQFXlFYZ27jwZW
 rja9QSefEsO1pPz1r4CQoshIUATvsq/SzW7kPd6aSBzqUgxfmkQyFzVA2elgPahYNOoVf
 FvYgWZ1EPODaX0ZWtsrB3eqGjfRlzUyvxCax9QY4V/BgXEGmVAAmeQ9QD4Tsu5pR/Cg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=PHm4Mt5O; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=PHm4Mt5O
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0AA9880A7A
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 12:47:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 95A7C601FB;
 Wed, 23 Sep 2026 12:47:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151E71F000FF;
 Wed, 23 Sep 2026 12:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790167641;
 bh=9CBfrGcZAn+R0bkz4lUTcFcSs+vTHjjcwS9jkB6+G8k=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=PHm4Mt5O9FYcqVI/lClcbbOGcopaMQdxriveHbnIVjgToqo8vRin4k8cz4srXnXhq
 DDcgMFCqLXTXsfpZZro5WRrkrSSnZY25BfQ3P9uYgC4bJUwiAcmLwnxiEqvWaUYYas
 IS2g887Dq+9Uyub1jHRNenpxjKz7z+fx/B7BTZE9kfIR0LIVVgvF+Z5Pf9KeZCHPdX
 +sYbfWHi///+HoUi9IfeNm6b1bm7OWXvDHUixJWFSr934jYjg2umqR6Brnfl+f4BRz
 jtufSR3zChUMT9DhV3i7JHooxsBubOQbncI8+ekRk2SgCVU7r99Z29EZV2+MrIca8F
 HXRB5fH0PSp5w==
From: Yixun Lan <dlan@kernel.org>
Date: Wed, 23 Sep 2026 12:46:45 +0000
Subject: [PATCH 1/4] board: spacemit: add SpacemiT K3 Pico-ITX
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-00-basic-spacemit-k3-v1-1-fa1015f2cd1b@kernel.org>
References: <20260923-00-basic-spacemit-k3-v1-0-fa1015f2cd1b@kernel.org>
In-Reply-To: <20260923-00-basic-spacemit-k3-v1-0-fa1015f2cd1b@kernel.org>
To: u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Hiago De Franco <hfranco@baylibre.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5570; i=dlan@kernel.org;
 h=from:subject:message-id; bh=/d4LNTkvVdLHXjufBoJGBVQ677fWPVaEEE3xSHVe9co=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqs8pDr+8U03kg9OQeEMaOu16hNwPvRPHa68aoI
 t6gvHaBBIGJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCarPKQxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+0thg//ebZqH5a2KLY+u0gy8m1wbYhytdEeg3nArHy6Vjz5pjd9eBQPknAsD
 4kFNwzCC55R/rAcmsW8i5fWBpxmw21uDuoS1gbjHZibL5KbmKHr4SsmP4Ocpvmj8QjoJ+wxBtZc
 zuB2GuG5REI9PbaqzasbwWcOKcg6kBzC5hOdhQPSZO+0cc5UtdKsgWcPzFgQZPO91Hwuo/9wAiy
 Nedzk5Yxy/gMh5DDMa8qgyIkO8mNnvLHRFhPkJaFNW7im47qhM7FyIQVBmbpfzcFFL2IaKrKArc
 NRTNFPS12cfcGzhLmPKSQT/t2/eYn3U6QlCGfoGTXWUYRx0Sp5wxAYK6i2nyT7/wwrSzgc4e+2d
 eJi2NiCwfjc6XcIJ+Fmx2joGV6ZSCD4LbT/OZo+UJMfTK1CzwMLSuOU/i4JNnjipcpqlw287zKM
 DpluLvgE9RnNGCmMdu1lrtrpvGdDLeYIEsOfrSxRiIy1J4R4lB+n6WHlHvjE3X+6bRtYvRGTN7i
 9M822qE5GpoJoVx9b9vtf1bmH2JguJGQRDnGyWEuct1Rr14pJX9talOUKC0TZbt1rn4KvdwivH5
 uz3IIPSyDfOyxBDoqK0IOceGYUp4jmqTKdnu13VPEZx2NYrxeRX1d7crMub0P5gZjRVe7zlQBMH
 tWgJB+ZitTKxkbCEFhf83xKv9MIdF8=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
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

Add initial support for K3 Pico-ITX board, in this version, the DRAM
information is parsed from DTS "/memory" node. And with UART enabled,
the U-Boot serial console works fine now.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 arch/riscv/Kconfig            |  5 +++++
 arch/riscv/cpu/k3/Kconfig     | 18 ++++++++++++++++++
 arch/riscv/cpu/k3/Makefile    |  5 +++++
 arch/riscv/cpu/k3/dram.c      | 29 +++++++++++++++++++++++++++++
 board/spacemit/k3/Kconfig     | 30 ++++++++++++++++++++++++++++++
 board/spacemit/k3/MAINTAINERS |  8 ++++++++
 board/spacemit/k3/Makefile    |  5 +++++
 board/spacemit/k3/board.c     |  4 ++++
 include/configs/k3.h          | 13 +++++++++++++
 9 files changed, 117 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c1b2890f1f3..386241efd4a 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -53,6 +53,9 @@ config TARGET_SIPEED_MAIX
 config TARGET_SPACEMIT_K1
 	bool "Support Spacemit K1 SoC"
 
+config TARGET_SPACEMIT_K3
+	bool "Support SpacemiT K3 SoC"
+
 config TARGET_STARFIVE_VISIONFIVE2
 	bool "Support StarFive VisionFive2 Board"
 	select BOARD_LATE_INIT
@@ -124,6 +127,7 @@ source "board/sophgo/milkv_duo/Kconfig"
 source "board/sophgo/milkv_duo_256m/Kconfig"
 source "board/sophgo/licheerv_nano/Kconfig"
 source "board/spacemit/k1/Kconfig"
+source "board/spacemit/k3/Kconfig"
 source "board/starfive/visionfive2/Kconfig"
 source "board/thead/th1520_lpi4a/Kconfig"
 source "board/xilinx/mbv/Kconfig"
@@ -138,6 +142,7 @@ source "arch/riscv/cpu/mpfs/Kconfig"
 source "arch/riscv/cpu/generic/Kconfig"
 source "arch/riscv/cpu/jh7110/Kconfig"
 source "arch/riscv/cpu/k1/Kconfig"
+source "arch/riscv/cpu/k3/Kconfig"
 source "arch/riscv/cpu/k230/Kconfig"
 source "arch/riscv/cpu/th1520/Kconfig"
 
diff --git a/arch/riscv/cpu/k3/Kconfig b/arch/riscv/cpu/k3/Kconfig
new file mode 100644
index 00000000000..5474ac11243
--- /dev/null
+++ b/arch/riscv/cpu/k3/Kconfig
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
+
+if TARGET_SPACEMIT_K3
+
+config SPACEMIT_K3
+	bool
+	select BINMAN
+	select ARCH_EARLY_INIT_R
+	select SYS_CACHE_SHIFT_6
+	imply CPU
+	imply CPU_RISCV
+	imply RISCV_TIMER if RISCV_SMODE
+	imply CMD_CPU
+	imply OF_UPSTREAM
+
+endif
diff --git a/arch/riscv/cpu/k3/Makefile b/arch/riscv/cpu/k3/Makefile
new file mode 100644
index 00000000000..fba4e4b0a3f
--- /dev/null
+++ b/arch/riscv/cpu/k3/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
+
+obj-y += dram.o
diff --git a/arch/riscv/cpu/k3/dram.c b/arch/riscv/cpu/k3/dram.c
new file mode 100644
index 00000000000..203d72a5da1
--- /dev/null
+++ b/arch/riscv/cpu/k3/dram.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
+ */
+
+#include <fdtdec.h>
+#include <init.h>
+#include <linux/sizes.h>
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int dram_init(void)
+{
+	return fdtdec_setup_mem_size_base();
+}
+
+int dram_init_banksize(void)
+{
+	return fdtdec_setup_memory_banksize();
+}
+
+phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
+{
+	if (gd->ram_size > SZ_2G)
+		return gd->ram_base + SZ_2G;
+
+	return gd->ram_base + gd->ram_size;
+}
diff --git a/board/spacemit/k3/Kconfig b/board/spacemit/k3/Kconfig
new file mode 100644
index 00000000000..b0e423d829c
--- /dev/null
+++ b/board/spacemit/k3/Kconfig
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
+
+if TARGET_SPACEMIT_K3
+
+config SYS_BOARD
+	default "k3"
+
+config SYS_VENDOR
+	default "spacemit"
+
+config SYS_CPU
+	default "k3"
+
+config SYS_CONFIG_NAME
+	default "k3"
+
+config TEXT_BASE
+	default 0x102000000
+
+config SPL_OPENSBI_LOAD_ADDR
+	hex
+	default 0x100000000
+
+config BOARD_SPECIFIC_OPTIONS
+	def_bool y
+	select SPACEMIT_K3
+
+endif
diff --git a/board/spacemit/k3/MAINTAINERS b/board/spacemit/k3/MAINTAINERS
new file mode 100644
index 00000000000..34cf1ed4453
--- /dev/null
+++ b/board/spacemit/k3/MAINTAINERS
@@ -0,0 +1,8 @@
+SPACEMIT K3
+M:	Yixun Lan <dlan@kernel.org>
+S:	Maintained
+F:	arch/riscv/cpu/k3/
+F:	board/spacemit/k3/
+F:	configs/spacemit_k3_defconfig
+F:	include/configs/k3.h
+F:	arch/riscv/dts/k3-u-boot.dtsi
diff --git a/board/spacemit/k3/Makefile b/board/spacemit/k3/Makefile
new file mode 100644
index 00000000000..bd5343be789
--- /dev/null
+++ b/board/spacemit/k3/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
+
+obj-y := board.o
diff --git a/board/spacemit/k3/board.c b/board/spacemit/k3/board.c
new file mode 100644
index 00000000000..29994e49ce8
--- /dev/null
+++ b/board/spacemit/k3/board.c
@@ -0,0 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
+ */
diff --git a/include/configs/k3.h b/include/configs/k3.h
new file mode 100644
index 00000000000..83e4945d2b3
--- /dev/null
+++ b/include/configs/k3.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#define CFG_SYS_NS16550_IER	0x40
+
+#define RISCV_SMODE_TIMER_FREQ	24000000
+
+#endif /* __CONFIG_H */

-- 
2.55.0

