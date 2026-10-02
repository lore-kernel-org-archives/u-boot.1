Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9084FCA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 01:04:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC12540BF7;
	Fri,  2 Oct 2026 01:04:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WloAGSDkID6P; Fri,  2 Oct 2026 01:04:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org F217D40B2E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790903043;
	b=fc0tBKxtEt4zDSa0DASgZZUE2Uv/2t+RxuY7c2R0iVm8Wioskmqia/5VyDFpTf3/0WEu
	 +RYCbcPT68JVqCg11/0WNRZpNS2Bp15WLxP0xP19m4bWs09yu2VZK3pJetR2y89zHVPEO
	 r7qMnpP0nlKOpocOw8Azn6msrUd8G/TvgFHB+DUpXMMu6tqi0AxmiJ9FqSsxk+Vwm6+w+
	 O7BPy8IOWKn0fJjZJ68PSxXv/4ySxG0D+3GgvatyFCT+7wsJVrrhskC9Rr4J1ikio6CdG
	 Co/TrxGiIda7yos+077BWvuKjwFI/90ge/aM+6Gy7UDyT2JY+oKymz3ZCClslY1i+pA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790903043;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QYrQ9KZgDkOMb50RalmXurg+flvXofHx0UIkxHI3944=;
	b=LuYD+M8IWemiQ/jTzUUAvQR0ccAUqqfKN6rc9b/j+jTj4GOKj59eczyq1hpeMCU0WQ00
	 ymVa7T1gS82hsRzs+xLIDTVA2OFIIHPIIy4URxmJCU1dFCXwp2JNt76vaLF9RR7eraeps
	 rehZs0jyux8I3nmLrOMZdhEEjJHHegLMkyvdvhBkIgdEBhomoTP0pL6/vwujmXwqEB0lo
	 jq+E7BducxYFeO4tNvbsHzPDD2CyYQl03oDs08CDcHu2FaqZnuykTJq++RN6Ur7FBFSo8
	 OVr8FmW53WjXMau3u0KRJkXomw6P20Wf+lQ2w9wGop8OJtRkiJkHNZxp+VhWr4c8o1w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790903043;
	bh=QYrQ9KZgDkOMb50RalmXurg+flvXofHx0UIkxHI3944=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F72wlmDEAR0RNpBjhrG8RPnGOzITv4EE30SbODiXx05L2o1lxs/Hlsvz9oAnlfPUI
	 0aNUCQdZ4kdBqp/HmXhjtLBYtzjlprTsIdOzykKepJuXknrVUJQmskkcmc8INTIRTO
	 VY1vOA8RyoC26MLghd4KiYAMUQ1CLFie4ummc6c4XvBEZ8UM60NNwBgrQU0qAbx2tC
	 gNWlhDDB47ZXzx25uT/h5CqesYExn0dWNx47i0Zr/kp8Ur6L9s8VAFiX3eLhxu3z85
	 InlZEKklCHmHCPdMmIWpQWlsWiRBA6dlueZ0nKtfHHG3TCtDzTYKnNh2N2xklkJ0pf
	 YvXeR4gJSRFVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F217D40B2E;
	Fri,  2 Oct 2026 01:04:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6E8B932A
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 01:04:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6035060B74
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 01:04:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dWwiWHCyZnVo for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 01:04:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 840ED60670
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790903040;
 b=lHzFucjDO885dwDtFiY6KJtjEVtUuS0kkOUuV7k6ftt/jArt2WvEhuJHyfe0FYt7c1z7
 ZZV2uWDMYq5phvs4O+RiEnbtSG3lDvND7LM4MWK2sP/4enuA6r+0228yzoVrHqkhAa6aK
 cyAW19rlPXbMFrdbHGpequ2sId2KYZw3lpzFooKerCLVtt6oEU2QqRxUYFJKEcvhxvdEO
 Cp9d1mqbxQrVy8H0K/8NUWRjdUsvboc8QtdaUDHyUQ87RGdQZ/4OegGNlf4IhjTRJObmC
 f3Rqe+a24RVfBFTo1m9xPgIW4mugbazH0n8NnlQffW3GRJgavTFXlv+AMjsFB+HnHuQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790903040;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=QYrQ9KZgDkOMb50RalmXurg+flvXofHx0UIkxHI3944=;
 b=MkdCHaJe30m+Vajccgsb7P4WjkFI/zQw3tnVRMhBanuqs3E5Zfs5RNWCJtx9O4Sy7rZA
 Keg9cZeRidHok4l17m6vQ/3lntqqC4Azt1x9F0wahOttMnkn5eq9/ba4AjVjyaoc7g1Er
 Lzx5dJuXHCpc7fU4BYiz6GE+w8CIaoLbeHBy6950QAfbQSlRTqwIZRVTmNYqDU9CxqY25
 k/ojb8IoieSEuK6Xh0C7d3VyhRa7Q60VjCOtdVwGix++g6tvvgUbiKKQwG2VjfqJ0WJqr
 dOup/k1VcxSmOvGQOyxTqvNFYTEbopxEhbSMpqMhjn0DTtaBnvs/4mIhBIVjbNy3IhQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=aTbKADA4; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=aTbKADA4
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 840ED60670
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 01:03:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D5B2F43C54;
 Fri,  2 Oct 2026 01:03:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29FC1F000FF;
 Fri,  2 Oct 2026 01:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790903038;
 bh=QYrQ9KZgDkOMb50RalmXurg+flvXofHx0UIkxHI3944=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=aTbKADA4Dvb9PUFK6dw+G5lXzSVvL5NbnMc958P2mjhX9jbKSYCLOWwXUq9s7hG2H
 X8s2BC0Ml+5XnkT7nits90+fGCu5VVFfZiLQ3Fh7u7aYo3kUHk1Oht1ShtyzOMiH/m
 9hSLvU1M4P2V7omJpGsFWiXqgbHQl9idsKqGgOPAPiotT8zG8S5+aCan/TTMP+myrC
 Gd068aPp1sazJnW1+YplMlXofHNy2EWZTBTdpO6buSC2AQDrELEOdjw6X8/TUl71p+
 +mByCXVNUF4/feWtLFdrUSggtjYDeqAvsJz/jrh/8y7cUk4zCzBTCMbUCUC1A4rki4
 q00pVJ4PmbboA==
From: Yixun Lan <dlan@kernel.org>
Date: Fri, 02 Oct 2026 01:03:11 +0000
Subject: [PATCH v2 1/4] board: spacemit: add SpacemiT K3 Pico-ITX
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-00-basic-spacemit-k3-v2-1-fd6779a0317c@kernel.org>
References: <20261002-00-basic-spacemit-k3-v2-0-fd6779a0317c@kernel.org>
In-Reply-To: <20261002-00-basic-spacemit-k3-v2-0-fd6779a0317c@kernel.org>
To: u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Hiago De Franco <hfranco@baylibre.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4689; i=dlan@kernel.org;
 h=from:subject:message-id; bh=8DvxkYK75fnB5sctItbIZW2vlbX/JJeEGs58mJR3eS0=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqvwLtZjlQRTStL229X8me8GF+YvzjTLk9CIR3r
 wCEwD8Itr+JAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCar8C7RsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+1p7A/+P9PjM1i0loggtjZEsq2JfmwOrQCQf1pKqr3mEItq6lie9SepnqCNM
 FeJBzkH4r95SYXzWig4w2HrIrZH8wKgxxjHJf4p/+jhvKLFZQV5gsu0xXlJF1FElToAWmGzHPP4
 tCzf98NyYeHsH1NzgmYRnOmMq9sdjhuka4OByOD3RLFrifAD6nCekl2CJcDc4LzFJ+2eE8XEv9I
 cQ8HzK1OF6XUJX2XlXfnFNQSpmxrjNSLb1FyOuFKn7Up5oh3x1SpGnaSnCUILk2O6wCgAb+hoK1
 KMYGyBf9k/b2A9aniMOCtF6oeYihFHOFpIn8rgRWAV7JDqv8rHm/2aQ0CDRPimb6MhXCPVAleU7
 Yg6iDWD3yB+t7EUfYw4lJrWa2ZU0vogBXe84XOTGdwsRwTui/d8MQVCP2MZqkbG8diweaki1eQj
 yBaAiD/+83ybGKlqXjm4s1UubPJAdWEx3O7ibiWC34IuoBSFEIRVBiw6CogcrshsXamsCfHDgdz
 YQlAjzYTb15pEoGgQMs7Dc9UVMObEaOb+DS6f46ttt3BrhW0h/RuK6Gfb+2edVVBjZ4VtMiTnMO
 q3P+w7AZ43MDT1jH0GMedV7+m+XlAOfuB0vf1nmD42RX/s6oAJgiz1fEnaHmHTSXfdOZswTZg7X
 PRPPinMSF7hcMatGUtDTC546/b2hlg=
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
 include/configs/k3.h          | 13 +++++++++++++
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
2.56.0

