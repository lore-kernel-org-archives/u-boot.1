Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6945CD2FED9
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 21:31:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC9E4841B9;
	Tue, 27 Jan 2026 22:31:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="D5yS3KW8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC85D841B9; Tue, 27 Jan 2026 22:31:55 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2894884172
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 22:31:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7d1890f7cefso407643a34.3
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 13:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769549512; x=1770154312; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KKjenea7byMM6+G3aH31eu6PZ4OzxF+xRJ1wsCJtR04=;
 b=D5yS3KW8qFEOTBOu2TcbgfTtzjv/m0T/2ApERJRrlDsVMRR7TTCqxoHFrF4G7LBGjz
 45gLFwywBOa3g+OoUomI69W0eBqzuxsUQKuO3VfD9JgOb8f9CsxTRosoGvW4hcmGTPWe
 bmr50/NtSwZcnC6rV26vw3hxFbv1BvXYVyKho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769549512; x=1770154312;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KKjenea7byMM6+G3aH31eu6PZ4OzxF+xRJ1wsCJtR04=;
 b=rTxTetGHnCOZrZRNDYUsH70nOfVEiWsMLpRP2kCpyV6TQtfbdB/ujix0LmhoVdBpyu
 rwmVretPLIBmjdc5Woyv+VtCsVDr9oBh2xTPdzAgKNOaMxYdr/SB1KJb+Yl0jpzpHJlb
 aQeK/otA8ihbG8d23kGzVcSck0BjYvSPwTlencWjEMjT4EchzlRoCq1/QjOv5jep1QBv
 ty3cOUnP89auVtgnFGI6H4OR6sQclytkSA/b1XjnjY2U5RBQXuyNU/5q40sLGj5laz9D
 04T/Ja3U7Ffvl47dUSDXX1uyLyMzk0vIO8z/ha+lifSWetrk58GAqq7FF7B5u86eUZP1
 BIWg==
X-Gm-Message-State: AOJu0YxP7j0ow7nxvWlbYr8MrtPnTOdQjlrJ6pphztIVyvVZfGA3amSR
 cobHKX7t2LZsczG/7m3MTiFsusQPb++dXfUbd6cLn4w8+27292SEQopWMdJzxL5hwUIP1t4S5O0
 knQ8NKpk=
X-Gm-Gg: AZuq6aL/a7/h9PvCEjqniHDcOclsdXJDDqRx+XZl+saEgz05nBhJPtZEdOJuo+W2BT0
 S9QQn2YD+na1PjtnQoQ8slOdCF0iV5h/l6lTvt/ieQ8GBW0QarZ0g4vZXRLUohfRX8YP5fU7DPY
 oGlcgSGTqXThhkB7jur7xO/u1Y0VQ6s4FFUYCc8yD/NsbhgPBkQGO5AaGjg6CT24IPyBcXrSDvR
 Hs9NPb/3XmwQZzASnSINdXrh55mL5BwZS/AXIcsuVT13gC8WeUefRUnB7W6HFJb+khSn9RTGMyc
 UUIhLNVz1KyLwvF6uB1AgmTxhOsF+qveAGQ61sUx5fy5dkRcoIr7Yt5nMs90bOc4G2LXnTkSxZ2
 n6V6DouBKTAWGavsN0LR7t87tDmiu88Kv1mFdgns8n+Ewx3y5bQWI2n1ZBwFuJu0RtRGgZhI7u4
 XJlR8cUKE1FOt/tbRXYpAU+jyTdQyyavAZonhvpv1mdRfnqBYA5yf6cxlfqU3sjM7RN19SGjMGG
 KvxEp7+ct+nR+xH9qKbJO8PUrJIYk50VeoXRJIRqaiUs/jpkYvY
X-Received: by 2002:a05:6830:6ad3:b0:7c5:2dbf:4a7d with SMTP id
 46e09a7af769-7d185122468mr1723472a34.31.1769549511792; 
 Tue, 27 Jan 2026 13:31:51 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d18c829923sm550688a34.30.2026.01.27.13.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 13:31:51 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>,
 Adam Ford <aford173@gmail.com>
Subject: [PATCH] arm: Remove rel.dyn from SPL linker scripts
Date: Tue, 27 Jan 2026 15:31:49 -0600
Message-ID: <20260127213149.1338179-1-trini@konsulko.com>
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

As of v2026.01, no platforms contain any rel.dyn sections in their xPL
phase images. Their inclusion in linker scripts initially was an
oversight as part of taking the full U-Boot linker scripts and modifying
them down. Then in commit 8b0ebe054bb3 ("arm: Update linker scripts to
ensure appended device tree is aligned") these sections were used to
force correct alignment for the device tree. This however, lead to a
different problem.

That problem is that when we do not have a separate BSS section in SPL
we instead would overlay the BSS with the rel.dyn section, in the common
linker script case. This in turn lead to creating an incorrectly sized
BSS "pad" file sometimes (depending on arbitrary changes within the rest
of the binary itself). This in turn lead to the dtb being in the wrong
location in the binary and not found at run time.

This commit fixes a few things:
- Remove the rel.dyn section from all ARM SPL linker scripts.
- In turn, this moves the dtb alignment statement in to another section.
- For ast2600 which uses CONFIG_POSITION_INDEPENDENT we need to keep the
  symbols however.

Tested-by: Fabio Estevam <festevam@gmail.com>
Reported-by: Fabio Estevam <festevam@gmail.com>
Co-developed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
I sent this off-list to Fabio first to confirm it finally fixed things.

Cc: "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>
Cc: Adam Ford <aford173@gmail.com>
---
 arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds      |  8 --------
 arch/arm/cpu/u-boot-spl.lds                    | 13 ++-----------
 arch/arm/mach-aspeed/ast2600/u-boot-spl.lds    | 16 +++++++---------
 board/davinci/da8xxevm/u-boot-spl-da850evm.lds |  9 ++-------
 4 files changed, 11 insertions(+), 35 deletions(-)

diff --git a/arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds b/arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds
index b4adae272eba..ac166d1d8526 100644
--- a/arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds
+++ b/arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds
@@ -33,14 +33,6 @@ SECTIONS
 		*(.data*)
 	}
 
-	. = ALIGN(4);
-
-	.rel.dyn : {
-		__rel_dyn_start = .;
-		*(.rel*)
-		__rel_dyn_end = .;
-	}
-
 	.bss : {
 		. = ALIGN(4);
 		__bss_start = .;
diff --git a/arch/arm/cpu/u-boot-spl.lds b/arch/arm/cpu/u-boot-spl.lds
index d780a5060774..c578c3ebf821 100644
--- a/arch/arm/cpu/u-boot-spl.lds
+++ b/arch/arm/cpu/u-boot-spl.lds
@@ -41,23 +41,14 @@ SECTIONS
 		__binman_sym_start = .;
 		KEEP(*(SORT(.binman_sym*)));
 		__binman_sym_end = .;
-	}
-
-	. = ALIGN(4);
-
-	__image_copy_end = .;
-
-	.rel.dyn : {
-		__rel_dyn_start = .;
-		*(.rel*)
-		__rel_dyn_end = .;
 		. = ALIGN(8);
 	}
 
+	__image_copy_end = .;
 	_image_binary_end = .;
 	_end = .;
 
-	.bss __rel_dyn_start (OVERLAY) : {
+	.bss : {
 		__bss_start = .;
 		*(.bss*)
 		 . = ALIGN(8);
diff --git a/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds b/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds
index c9664a6ce566..303ace2f61ca 100644
--- a/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds
+++ b/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds
@@ -49,19 +49,17 @@ SECTIONS
 		__binman_sym_start = .;
 		KEEP(*(SORT(.binman_sym*)));
 		__binman_sym_end = .;
+		. = ALIGN(8);
 	} > .nor
 
-	. = ALIGN(4);
+	/*
+	 * These platforms enable CONFIG_POSITION_INDEPENDENT and so need
+	 * these names. The always however hold the same value.
+	 */
+	__rel_dyn_start = .;
+	__rel_dyn_end = .;
 
 	__image_copy_end = .;
-
-	.rel.dyn : {
-		__rel_dyn_start = .;
-		*(.rel*)
-		__rel_dyn_end = .;
-		. = ALIGN(8);
-	} > .nor
-
 	_end = .;
 	_image_binary_end = .;
 
diff --git a/board/davinci/da8xxevm/u-boot-spl-da850evm.lds b/board/davinci/da8xxevm/u-boot-spl-da850evm.lds
index d1a82e118af1..c369c14a2558 100644
--- a/board/davinci/da8xxevm/u-boot-spl-da850evm.lds
+++ b/board/davinci/da8xxevm/u-boot-spl-da850evm.lds
@@ -36,13 +36,8 @@ SECTIONS
 	.data : { *(SORT_BY_ALIGNMENT(.data*)) } >.sram
 
 	. = ALIGN(4);
-	__u_boot_list : { KEEP(*(SORT(__u_boot_list*))); } >.sram
-
-	. = ALIGN(4);
-	.rel.dyn : {
-		__rel_dyn_start = .;
-		*(.rel*)
-		__rel_dyn_end = .;
+	__u_boot_list : {
+		KEEP(*(SORT(__u_boot_list*)));
 		. = ALIGN(8);
 	} >.sram
 
-- 
2.43.0

