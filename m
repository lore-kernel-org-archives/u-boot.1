Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB2DC7115B
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 19:10:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43BF081FEE;
	Mon, 23 Jun 2025 21:10:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ixhl+2HE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD7C18210D; Mon, 23 Jun 2025 21:10:16 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8618B8006D
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 21:10:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-605f7d3215cso2197914eaf.0
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 12:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750705813; x=1751310613; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9xOqaA2wZedSBQNHxvEHXAhgNM3ybUiOeBa1Y/SXhiY=;
 b=ixhl+2HEcz7lOHV6keke4WfORJ3kCNvt8gsoMTDhJOPFhX8Oms5BJHe1ouRJmqrEr1
 pEwvo0cnRCxf2cCt6mGRfyGc4YKaqdz3JV3lmHqhL+bZfTXARuCRrcdV1tXUMpPUEHHA
 yE7+IPPfUGr2C96slhG52saKHMHHOjjcstUrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750705813; x=1751310613;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9xOqaA2wZedSBQNHxvEHXAhgNM3ybUiOeBa1Y/SXhiY=;
 b=bETZCvpt0zXv1JWd3UqJv8qlUkmbQftD10yhm78PRr9Lk8cwjtyQmJbrlCBlYLDnJf
 Xtg6oiX0aW1/MgYwXv1saIRqhWb08JqJp+Y9KBIQfRwxWQckweLUusIqLYkw/dYtNW2e
 aF1/6iEEUv+NIYJqT0MeySovbJML9IgBwtLGsOqYW3Ge6jfpfg6XgMg/UwLG9t3kzL7c
 cbGqS4NhBbtXdbmlvENrdsVqmnOAQFfK+L72sdPOdLKWzlaI80H2S2EA4WYdyLgMHYQ+
 e7DP91QM45MCtaYPDbfPQcWcrCymkRYfPbeQzYojNTI4mvGMtP88Q9Piu7svCfr2X7BQ
 Q5oQ==
X-Gm-Message-State: AOJu0YySeYK+2QajL5N0rSmYT9a1kjXe8R7rn8oUBHFOwEaziqNemvh0
 TDnLuZqkjaw6jhaomU+r4KNyc28RAQiWRu9pOjD7PA7GobbG7va8woGfdThCToWP+QzC3JIfgVu
 7dVW2nHM=
X-Gm-Gg: ASbGnctIJqXHvF4zXRDq0+gHA1OQl1JaK/9H4UYWVINCqCOzm3J52Cw1hCSKiM9lVr9
 ZjXcl9JmC1e4UYComKugOiBr71ZcEruKlrxH/aS/NKd5NLisUW0KyIVImDEIO11sJAMR97eQrC2
 KcFb0yGyXOb01llaz4DMErAsmkPZ5mmNAGmzXpD2ObPg395Sx6IBl7FIBTFgG2g4FJnn2R/d2gx
 xtOH+kqb9FVU7hNK/i3CQ3j9kVw52FFZiO4JWWlHoefrkfedrMs+JHskvVrKtwjfSyRVdlcZTA6
 prllXe+6WT924MuN1iNw+FyEGddbuQZv5z8+14bPRSnI4pikwB7R8kVWQpIXzAdDj3elmaotfb5
 jCiWtwp9D79994E8K5AKkudm7TCYdRXvzeTX/
X-Google-Smtp-Source: AGHT+IEgs5P0bwZsaBwyXZgdShlOt1VHreNeFOPgVwVOwFx3YrzCdVQIg1n2WdlsDAoKxBy0bWvRJQ==
X-Received: by 2002:a05:6820:2784:b0:611:6789:6cda with SMTP id
 006d021491bc7-61167896d1dmr7264298eaf.5.1750705813171; 
 Mon, 23 Jun 2025 12:10:13 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73a90b1383fsm1536216a34.16.2025.06.23.12.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 12:10:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH v2] arm: kirkwood: fix freeze on boot
Date: Mon, 23 Jun 2025 13:10:11 -0600
Message-ID: <20250623191011.4036434-1-trini@konsulko.com>
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

From: Jerome Forissier <jerome.forissier@linaro.org>

Commit 6fe50e395080 ("arm: asm/system.h: mrc and mcr need .arm if
__thumb2__ is not set") is not a proper fix for the LTO link error
mentioned in its description. It causes 32-bit arm instructions to be
mixed with thumb instructions, which the Kirkwood SoCs do not support.
For example, board_init_r() is mostly generated in Thumb-1 mode as
expected since the build flags contain -mthumb -mthumb-interwork. The
MCR instruction corresponding to writefr_extra_feature_reg() is also
correcly emitted as a 32-bit ARM instruction (it cannot be encoded in
Thumb-1 anyways). The problem is, the compiler inlines the MCR without
generating the BX or BLX instruction which are needed to transition
between the ARM and the Thumb-1 states. From the objdump output:

006186a0 <board_init_r>:
board_init_r():
/home/jerome/work/u-boot/common/board_r.c:799
  6186a0:       b5f0            push    {r4, r5, r6, r7, lr}
  6186a2:       b0ab            sub     sp, #172        @ 0xac
get_gd():
/home/jerome/work/u-boot/./arch/arm/include/asm/global_data.h:127
  6186a4:       464a            mov     r2, r9
...
/home/jerome/work/u-boot/arch/arm/mach-kirkwood/cpu.c:242
  619aae:       9b15            ldr     r3, [sp, #84]   @ 0x54
writefr_extra_feature_reg():
/home/jerome/work/u-boot/./arch/arm/include/asm/arch/cpu.h:100
  619ab0:       ee2f3f11        mcr     15, 1, r3, cr15, cr1, {0}
                ^^^^^^^^
                32-bit ARM instruction

Further investigation is needed to understand how to fix the issue so
that the code size is minimal for all boards. In the mean time, this
fix disables LTO for the two problematic files (common/board_f.c and
common/board_r.c). This makes the Kirkwood-based boards bootable again.
The binary size is increased by 1048 bytes which is perfectly
acceptable.

Fixes: 6fe50e395080 ("arm: asm/system.h: mrc and mcr need .arm if __thumb2__ is not set")
Reported-by: Tony Dinh <mibodhi@gmail.com>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- Guard the change with 'ifdef CONFIG_$(PHASE_)SYS_THUMB_BUILD'
---
 common/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/common/Makefile b/common/Makefile
index 35991562a12b..e589f3072621 100644
--- a/common/Makefile
+++ b/common/Makefile
@@ -19,6 +19,10 @@ obj-y += version.o
 # # boards
 obj-y += board_f.o
 obj-y += board_r.o
+ifdef CONFIG_$(PHASE_)SYS_THUMB_BUILD
+CFLAGS_REMOVE_board_f.o := $(LTO_CFLAGS)
+CFLAGS_REMOVE_board_r.o := $(LTO_CFLAGS)
+endif
 obj-$(CONFIG_DISPLAY_BOARDINFO) += board_info.o
 obj-$(CONFIG_DISPLAY_BOARDINFO_LATE) += board_info.o
 
-- 
2.43.0

