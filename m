Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A50CCA5FE3
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 00:35:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B5A7740DFA;
	Sat,  3 Oct 2026 00:35:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qBmF0UwmM2Ms; Sat,  3 Oct 2026 00:35:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D3B0940D01
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790987731;
	b=cQdW/x3LT8HZVjpqa/9biDTtC+ozWdq8OWrsuH7l8WP59l6IVYyh0FV/VFdSAZb//8nM
	 MxZmAx9KK5ibJl90liEt05getFvJDoxglcZv/ZCkOFEECbtYoPVYyHNSc8tRmJMitYZK5
	 MWrtEqPngo+k797K/r703i/gYtyl5LQfXlt8zO09XCQT0eT7l90vaFFg70hMRueSwz4cq
	 0R3t8RQpolxgrHCRuWu+4nMaEZF1GyWp832NlCfQuJ1keIhCkKqKRt5k4VguV/IbT+9/i
	 qhqxVgWQqhNOS+V9exa18HADygbiWL8JVVNC3fAiOmaDOcVaTgFTVSlW3bmG28Suglg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790987731;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=aJylcobbkuYbjGnFXU+soRfkyOl8xItyfGnS1j9CLzw=;
	b=Z9IaFGFEEyM9rnp0NDt47b8bgmwRjF60GlBE9EQaczbKZKxAqsiECX50yTCFqEok26TG
	 CEoBy2u8KbeIm+Ekr1iOtonnsGwsMsVO8aWRsmVtIqw68MIHIVscqZaf5/B1HN/yQtaKB
	 9imQ96hTQH5bajqVNaiLuzZMmSSt0PVGBiLgNcHSiVtP4boA2nZMKf8ypmQLnZ14Axlt1
	 JR+/I70KALRduqi4B0teJfiVZ2ftsRz3KPq3LLp4dkl7U8dLKpeObQDYR6CNoc9IqcXlG
	 io28xr5QaGnDGygAWcK03vSmEc0pN6CPCdyT2eGfbmsttDoddnAvWvSrVo6nqQEkZ2A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790987731;
	bh=aJylcobbkuYbjGnFXU+soRfkyOl8xItyfGnS1j9CLzw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hZ0hGxteGcFBJq905GCa8OjaPDrqqlYEGfvj2aUxptlpIyphCxN/nJzTPcYbmolKf
	 6rzv/cGN2m0KyHwAqjNiwriLJcd1mnRCjpseXpOOq8w1EfGt7Ni9plIEy6fcYZGEB0
	 hC1UV7KSBKz8PIIc3BBVtQ4UNXrxGbgdnVTKeCdPaycYX6Jut2opOE6+L+SgLdhkJg
	 UQNZo9WKkn4cTZ7wNcErzW88EDqbt3HrEiRb/xOpt8slkJVUUUKaA0GVpTL2OKpFRl
	 HaxGJmGemJmmQjWxuhuHG4LsY7SkvYMmUlt8Yp8Jc97zPYXC+vp46t2DbOH6lLfuxW
	 z7z1FwC9Xzi6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D3B0940D01;
	Sat,  3 Oct 2026 00:35:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B4AAC2E0
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 00:35:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A667260653
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 00:35:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 827-SP6NKSVq for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 00:35:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CF57D60650
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790987726;
 b=mxG42/hnkVNoObSwlY03PspBZXjs3f92plahekXCOiGUnvsa6e/uQ00GbxvgLRFaeYI2
 YOogTVnbx6vKw4zOj3oiOtgl6/gn4/sU3owt4aE62UEPpuTR2/KCpeh895rtXARLz1ITX
 cQTc6YGSTmzKUUWF/QDA45JAAX+CrOj/t5SOpNKqxjBE0YaDEBTgchvL6n/UlqAPi3tHh
 hPna+4bWizBqrTwwutcUxmui+lAGwBcbXxJDoRSrql5QH6ObzvJ3qjXl0kS3COn19N+TD
 BiYwX2qwc6mfvzbbRi67ctKWlYL4RSKu0OqNwIGMCCJwfgQmV83w9UmYtiqW1k/UGWA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790987726;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=aJylcobbkuYbjGnFXU+soRfkyOl8xItyfGnS1j9CLzw=;
 b=FLrvDrHxlaECJjRJNBdXdkWE9ZvFoRe/Pum6AQiXdUva1oKhWb4v/UOFOtdGpDHZq1z7
 uJqN9mW7muHjbU4f6erHaNgvjjT+itBAY3r+JMf4ElXbifJVrLbqdaFARhH0iiJ5JsPc5
 IYxlefVpamXpGA/ldHE2x6KjESF1/HGa+RTsoD9BbiQvY+sgmNU33waQ60fcYfUQL5S/9
 srxomXLtl2j2bQt0YzL5PoeparG6C7WjU4tcao2ig94HBXyyfGuFgVtCq3713sro4g0Ed
 CaNRS5g1LuZAY6x2a0q9MpigiVFKKCuA1gEzcRxruQ4cBaQunJJUYNh+pkEL+dyIHOw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="kffHW/3Z"; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=kffHW/3Z
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CF57D60650
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 00:35:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B834143B7F;
 Sat,  3 Oct 2026 00:35:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B933E1F000FF;
 Sat,  3 Oct 2026 00:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790987723;
 bh=aJylcobbkuYbjGnFXU+soRfkyOl8xItyfGnS1j9CLzw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=kffHW/3Z//6doOnYgmctE7KtwHZjoqTHk7GATVQB7jY1uDf4IyLlMVShRiVfiX9k9
 I/uB6is4Xq76GJ/P71zbnhyFJVI5Gj+exrrv5e6M8nIh60aGCgOCTP3teO79LWxRnZ
 eoyv6FxsBtMVJxEQFHfuxI6/lLEunkB3koVE1rGfHVFNPo2bi9kYEM2RRNu7z30GH7
 uvBdqXwL1JgFb1zXajtjXbdMmJCPuxLiNO0ZQ3xeljwUUonKl6DpH0LlaFbHodRRBC
 xvHemV2dmmq6hA0fUxr+sgNGCWUWjyMiIKV/oke6cKWf+M3od2saMKh3aFbM1XJXA7
 qo/bUIqTldHVA==
From: Yixun Lan <dlan@kernel.org>
Date: Sat, 03 Oct 2026 00:34:39 +0000
Subject: [PATCH v3 1/4] board: spacemit: add SpacemiT K3 Pico-ITX
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-00-basic-spacemit-k3-v3-1-dea68cd1bd7d@kernel.org>
References: <20261003-00-basic-spacemit-k3-v3-0-dea68cd1bd7d@kernel.org>
In-Reply-To: <20261003-00-basic-spacemit-k3-v3-0-dea68cd1bd7d@kernel.org>
To: u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Hiago De Franco <hfranco@baylibre.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4740; i=dlan@kernel.org;
 h=from:subject:message-id; bh=pcvdE2Xv1Pa3iDyV3LytLBAa3P4NF0gwjqLxU1J4eGo=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqwE26x4/NohzE13DKdJHg4DUNx0vy5YG+gu4Wd
 m9fVCRQcxuJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCasBNuhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+0Ctg/9FGnKC73riEbSCIZCxvuXZlZKWStuWH6rQndkZpCzW6CXI1kJHLjlM
 k6ZKS71knDgDPqbdxk8Y6zn+8yjLPvuQqnJc5omHQ11VCNJUNixrNk/kHknjmcyZ4aSaz94DdKE
 73uhQFr8AYQhnqKIok2Ibk48y0HhufyzZegauGPhIrsubSCCrTSE5zoG66htnR46K5bwKPe77gb
 sVJmv3BEvXOHaYMAQ7k+lt+BYtSt8bIJavUEN1Mk2AEkjUwRAzI7U0sXEBFjUOQyBAhGvNE55zI
 jZY/5c/PqOAkAn0hnamkjlQYQgHeJH0ShezGr38zciDZnifzpxRrl0uQ+QKaG0y1nZ71HSv77pq
 4wGBMwS/WF7rxtXXwIBuTD7MU06sJ7BZN8AlpzvgO6yD6kux1ngzILvhkSUvFxZ4HhPheetAlZW
 upz2drr/ML4v9BFQkMMjHqduSG33SdWZTqZaSelH5LbKGSUGSh0tJiHbzFn5vA1Q8q3suZ4Ogjd
 lT9lMOkiDnopxQ8pi8O+vPd+YV++4bO6e1jEc2/LGaW9yl+arkGeWbXtKVtc5WbbpYXjJCISLHA
 q+SUP/qPCnPsGDEn4oJwG+w00An4KIndQf1xccAIFNKpytHm6DzzmNJQFCdRoMSd3P2/aYjFC10
 YvOAdEtC+AJ+aYSeyXuqQCbTIcfOmQ=
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
 arch/riscv/cpu/k3/dram.c      | 21 +++++++++++++++++++++
 board/spacemit/k3/Kconfig     | 30 ++++++++++++++++++++++++++++++
 board/spacemit/k3/MAINTAINERS |  8 ++++++++
 include/configs/spacemit-k3.h | 13 +++++++++++++
 7 files changed, 100 insertions(+)

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
index 00000000000..e20d35dc1bf
--- /dev/null
+++ b/arch/riscv/cpu/k3/dram.c
@@ -0,0 +1,21 @@
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
diff --git a/board/spacemit/k3/Kconfig b/board/spacemit/k3/Kconfig
new file mode 100644
index 00000000000..1a63c73b6bb
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
+	default "spacemit-k3"
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
diff --git a/include/configs/spacemit-k3.h b/include/configs/spacemit-k3.h
new file mode 100644
index 00000000000..9dd545e2a3b
--- /dev/null
+++ b/include/configs/spacemit-k3.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
+ */
+
+#ifndef __SPACEMIT_K3_H
+#define __SPACEMIT_K3_H
+
+#define CFG_SYS_NS16550_IER	0x40
+
+#define RISCV_SMODE_TIMER_FREQ	24000000
+
+#endif /* __SPACEMIT_K3_H */

-- 
2.56.0

