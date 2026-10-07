Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56BC4CA5FFF
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 05:41:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1BF7380ED6;
	Wed,  7 Oct 2026 05:41:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bNLMB9LK5iJ2; Wed,  7 Oct 2026 05:41:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 36D0B80EF9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791351685;
	b=g9TbS0H2u2W0/7s2YAlExWgg3zs8qcaFjPysm3V3AtrQzdWPlM4YCs+Mv6n4vUsyL0pn
	 PjazKXasZmu6SqwNmGStDjIBkyTST6vNPA0E6YRCU/nqpPxESmrw1zB9PUqqr5mN28xgP
	 RtaMM6Az0oapdnPH8tkiEhQLnsjOyETQEV40w+uA/8qZrMzSgtDMqTgscC5kaFkPqFD7U
	 Lx7JoXUT4jfAfYvhVK8bl+X+1jVOeinMjMx25BfOk8MV405A41g4hphdeNDy+ZLfIvSfe
	 DTkk2A4rmldr9AbEL8l8GvUMy1qrUbhY/wUIR+vH/4eU59D/GR7FCHJzq3pzLpqx/Bw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791351685;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=c0lS6v15zkbRJHc95rjBqzbhuP+A8UzljHy6eOoNmxw=;
	b=IY9DX4SXOeYtrLgahnzTxcca8t3EjT9ZHJ9GxJ7BvcPlkRULW/BehY35ymM4YtJZJlRU
	 hyjBoQ9WguwHfbzjUp9x2nAPXolH6phxocsx9t64VLwIsuOBKr92G5QxaWSAEiuLJ5/m9
	 GW/8afVb4to8xNY9z0eNLmG3ZA4soNVBK3bdqrvKkpeVRRxrb6r7GGwXq0kOOj9ZDcZcX
	 Q7jxKm7NtGk33Hgp91o4NQjYKTrFf/2J2iDsBnHBF4oI8rQg9CwghTCs0GV2sp73UvaEB
	 YT6IF/vz56mY8TiGWCQpKYK/YmdVCUUK4i9+4CVdjHxKtOOAPX0djjwvhmUw+CtZgMA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791351685;
	bh=c0lS6v15zkbRJHc95rjBqzbhuP+A8UzljHy6eOoNmxw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K+rwXisZ7h/uxfiGNjatL7KJ0hilHoqqwI1SWu6mEXx87y7OnGVMwtKYkkNwvG1d7
	 tAIpXUiAFEdtzAmD4iqInoGn9AZxV64jUlWelKseggCmvb9kdwtIgmffmPIfN/qqF5
	 AUBckjVeiHCxnem1NGp/07evEaxGNX0eaULdYbiaMRzuLIp8N5gxt3yDP4NSmCGi5d
	 rjfkoVF5+hcyjPGqgCXUK62IocjDKgIUPvI0tgSv1dDDnXKM2Ll+AZzHkXwg8f+gY9
	 F1jNevkRuQqPfhSX4AvVNpIaJn1e/CWpgd6yMB9tWOIXGdIMePNUhIg1Rlg5MM/hvj
	 Rv1sTnskh8Rjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36D0B80EF9;
	Wed,  7 Oct 2026 05:41:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 175C534E
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 05:12:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 090B04070E
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 05:12:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mzUlDI0AXQ6z for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 05:12:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 339874070C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791349922;
 b=WIRsgrSir2SiGSMEYliSxutPUNuvCtRjBZ70mUM+fiFbgtmVghMR1tu1Jwvi9mcGN2dq
 hPOOqqI+KEkayzkB/hp/2VmDJOA43Aq4B9oblmEA07+gDv0RsXuoWYe1hcHm3YgJV7UTz
 NWR4vNxV5aCic9vQxjWMIyOhXCZmbMUX/sDnSRh0uVaXH11o86k0PkuXJe2g7gKTg/4ap
 6ko7f7I87LiUT5XYUtHYlRF97oERrzOjUfpjwlMwrzqH8gxJ4DvHxwE+fQf7hGvXuJykS
 RYBqh3wDoXe8poUlG0gueQvkgVzklc6Wu321lXA3b/EQKzFFhFY8qHJS/rS3end9wTg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791349922;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=c0lS6v15zkbRJHc95rjBqzbhuP+A8UzljHy6eOoNmxw=;
 b=HsjcqQbQzqUetvM9beTE/Nr1KVr1wKUX2LZZzTKn6Ueh9NZNoyDrE/OID1Ke8gf4vlrq
 Wm1752lQFpFwRe4c3K0AgfRq/1IJGGhLrHqgEhlbYwzvsF8jISh/plnCqM2qLaflttYpK
 LmItschVic3TAnSRJu4hjQUG/CHSYrbTybB/jM0JZ8Wn2cynHpTq1EE4fCnK6tVEBlhjY
 XhouOngv2F4AmCxUfwwjF/bQBbQrD12eJjXERD+mXBuA/h2re4zNEO06Obw8vLlDa7NOS
 OSzk0+gWgdjator5anuPN58zG1iH103sF74v1+eoPllOJKL3um8CJM9JocpMskI7YrQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=lpfdAuzS; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=lpfdAuzS
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 339874070C
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 05:12:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C3B8A4358A;
 Wed,  7 Oct 2026 05:12:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983E81F0089B;
 Wed,  7 Oct 2026 05:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791349920;
 bh=c0lS6v15zkbRJHc95rjBqzbhuP+A8UzljHy6eOoNmxw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=lpfdAuzSfun2EQYxlJnW7/S66GIwVSneU33xFyCjhSC0IHHR3llZI6syATxXD9OA2
 qRzeOeBRQ7i8IJxAYPvnNOESEEk6VzKcI9GmqiY/244n0eL1UCGttI/NPojMEEB0XO
 z5DqzYlOMspu0UYfbjzdZv0V+TYe52W+hjj8XEM/uLtdhkuLQDDAL/SbhfPqKdDVE4
 MwBA5Bn2Cso7oIbPrH6pKi8sYfG7XoQot8qha0K16i+9r5LK4QGlOYIxdkMoguGSNA
 0jVLvFK4ykzCy+Wdgr3CrOqsoZN16lulsXTD9Op7bgNlfH8tXwcm/1me0nDIxnORMY
 67ifVpm+V1UgQ==
From: Yixun Lan <dlan@kernel.org>
Date: Wed, 07 Oct 2026 05:11:31 +0000
Subject: [PATCH v4 1/4] board: spacemit: add SpacemiT K3 Pico-ITX
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-00-basic-spacemit-k3-v4-1-c44d09937088@kernel.org>
References: <20261007-00-basic-spacemit-k3-v4-0-c44d09937088@kernel.org>
In-Reply-To: <20261007-00-basic-spacemit-k3-v4-0-c44d09937088@kernel.org>
To: u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Hiago De Franco <hfranco@baylibre.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, E Shattow <e@freeshell.de>, 
 Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4781; i=dlan@kernel.org;
 h=from:subject:message-id; bh=Zkla4MfQR1a6M2JGNJtNZkCt6ORZkmTAYkp2dvgad3o=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqxdSOAxPreK9m/J4k4VpDAPiqzwIjn7I66LsyJ
 Dq6sfKLPoWJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCasXUjhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+0U/Q/+PUE0GuspHXMCJrnR+WLefilM1QdPPihUI3W2DBcsn0l67yr2V8qvn
 UtAPnCKVZxwCdDu0AeX0J79Qqk166h+HOKdj79vLOGVe0CmWdgAK9aWeyoYKXQgoS5/q1ifWq5i
 QLpeAxV9KgXNy8S1YSoI6k6HB97beUlRPMY93bvG6Pv54IOAbGaL6NV9/rjpvNIIMGc8vx48fLL
 7qwPyDgiIBoA00bWAUT2GVYAkSGVvGh3R/PSmakLgXqF5lI7aKyVDyMU8LfYgqlIySwXNbOnh/H
 WMy+8czHq0hHsyGgBdHSg9W9XrFVOjgmuZq9g2L/YFSfpGEiCBEgjEEGFhi/sxUoWhRcWCh1ZHb
 P1uJ0L6xEHlGT5/maNeep3DceMKdZuX5UplflB2+u80bXKd88oZPrEXonLqaaOkEXeryc8RLqwN
 wUzK4OtKkiDApmn6BAFEbNuyRbmvKgqiKimVm71ok6YbxtHfo6pwhRE+HSfao9PdYd/PQSWvj0a
 S7hTIRH6SZeSGvRFVu1/kGp66iP9bF0dcDKCqzupK95lJ7pC0Ou0C2J7rt3e5tj2h2vuTsh29xp
 OvTdAwH63+7b4Znfx48xQHRthUrdwwHqWq3oGDAQvzWz2qlce5TEhwm0Dfqt97WcgRoqRo3RHD+
 GEyDi5HDRcPgCeVXYIGXslW4LpKa9o=
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

Reviewed-by: E Shattow <e@freeshell.de>
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

