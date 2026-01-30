Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A22E6BF35
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 18:36:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 763E984543;
	Fri, 30 Jan 2026 19:36:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VvIGy5mo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29B2284558; Fri, 30 Jan 2026 19:36:41 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE86884535
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 19:36:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-45f126d47b8so1645999b6e.2
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 10:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769798197; x=1770402997; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ABLmUmfD9fm7dUFDSJ3BUm+DQS7OcFUyjeAwnl/ir/s=;
 b=VvIGy5mo2muXdBMwJO0HFkmpwaApBYIE+Nv6zTHmnKcrnHk4yo9zfLMsPmW/y1HWXy
 Uik+ye+YQi/l8TyWlzg4TcJBfqnlXMQgXWtSxW50Nrb66SadTdofIZgrHsR45FzM2S9D
 Mpi+ioX39f095iRuGKUbNjcVnKnrJMiQAILhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769798197; x=1770402997;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ABLmUmfD9fm7dUFDSJ3BUm+DQS7OcFUyjeAwnl/ir/s=;
 b=tFZLSlfQPf2tIDxHm9GsSW1o1K0Vclet1UUVSxyXiO3Q0RU/2Ynh9hpuUt3xGYp+f0
 qmsg4isGXtvl2GSlIJr1usBN9OoQ23rrI23sjrYV+CvV+LiKRekmbWxbmtJJtcoXRd+C
 kpijnwEgvAr+YxtTkNjWnNTfarOhooBpJ4NG9+UaskRibZNiArD7Cj7YwiCx0DxwhuJj
 Pv8vD9vzM6RtjuLeiVEPE9iY+ey8FW1z2iSMmvc63Wa0tA75coIpeFS/xSlwz1YwUGFh
 61x9+SRfOLBZB+dL/9LrSFS5VNQ2yt6HpbreyirT7LnFJxQrTAaYqzBYbSzcsHhJ4mIx
 tsRQ==
X-Gm-Message-State: AOJu0YzjTVR6C+VlRNWPQTierntPtMAYANTNTHNFIPKMQZbWBBYsDzhI
 jevZCG0EV2B7GmhXsT5CsqfkH8VwOQdZtINxaJF89D8cJ2EF0kkSeVTXcvJAxR7/FTdcBje++5f
 tWTBS/ec=
X-Gm-Gg: AZuq6aK8FrTgBjuRDF2t1GNZZzx7YXS0I2chijSIn5HtnL8v2ee4hgbkkr9WY6ilcYp
 IBz+xPYoVgoUkOCYn0FieStJF5rWa7cztLYghQsumrDGMb9BJNNnnyIUNgCtcuqkqLjPfXs4QPH
 1fU/TvhG+K+mYIQtK9ND8ngR9zxTsUws+/7IB4aAlxg9y6SD/ZP8IIdWfeWVDDgT7TGqihlPrgq
 xX6la5d66kbPgwdLR6ikC8s2bqM//GhgKimOb3e9ZxCWJHcDpZ2p5+V5XIiQVZlVR6kh/oSAOqi
 TRXFhPSOg3SffLdGyy5wQ/EITEn4WZe412WyTX7M6jS6PX+PBZUXH9HZKUnKxtWXv8NY7VYlf/9
 86nhMSOBhGai+THx+yz8dzJyG4vcUey19umNj4HxNtTXIGcMLUw9FDOOQZoDDWlYhnMN/jg7qVR
 O4tjF8pITgD9kn7MF8MHu/PFcWJFT99D4OE/9JQx8lAqQL2Y7dLdxg2iy/kmwQS3S6Fq1y9YdeP
 rwhajbowXDx+VeS1bwS7lsNO4RezurZOjjelGVP4Q==
X-Received: by 2002:a05:6808:c117:b0:44f:e912:eaa3 with SMTP id
 5614622812f47-45f34d0cfe1mr1835278b6e.32.1769798197550; 
 Fri, 30 Jan 2026 10:36:37 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4095756e77fsm5936397fac.19.2026.01.30.10.36.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 10:36:36 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Brian Sune <briansune@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH] spl: Ensure final section before BSS is non-empty
Date: Fri, 30 Jan 2026 12:36:35 -0600
Message-ID: <20260130183635.2612933-1-trini@konsulko.com>
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

As part of ensuring that we make a binary image to append our device
tree to and that it will have an 8 byte alignment, one problem was
overlooked. That problem is what happens when we have a section that
only contains ALIGN statements and linker references, but nothing else.
What happens in this case is that we will have a section in the
resulting ELF that has is of the NOBITS type. This in turn means that
when we use objcopy to turn the ELF in to a binary for further
processing, it won't copy anything. This then becomes a problem when we
do not have a separate BSS and instead append a "padding" file to act as
the BSS, and then append our device tree to that. The solution here is
to ensure that the final section in our SPL image is something that will
always exist with contents, in this case __u_boot_list.

Fixes: 5ffc1dcc26d3 ("arm: Remove rel.dyn from SPL linker scripts")
Fixes: f150843499b3 ("riscv: Update linker scripts to ensure appended device tree is aligned")
Reported-by: Brian Sune <briansune@gmail.com>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Ilias, if there's anyone else you can get to look at this which
understands linker scripts better please do. I think I finally see *how*
things go wrong in some cases but I'm less confident in my explanation
above. Thanks.

Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/arm/cpu/armv8/u-boot-spl.lds           | 12 ++++++------
 arch/arm/cpu/u-boot-spl.lds                 | 10 +++++-----
 arch/arm/mach-aspeed/ast2600/u-boot-spl.lds | 10 +++++-----
 arch/riscv/cpu/u-boot-spl.lds               | 11 +++++------
 4 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/arch/arm/cpu/armv8/u-boot-spl.lds b/arch/arm/cpu/armv8/u-boot-spl.lds
index b732133ce76d..29252d870f91 100644
--- a/arch/arm/cpu/armv8/u-boot-spl.lds
+++ b/arch/arm/cpu/armv8/u-boot-spl.lds
@@ -49,12 +49,6 @@ SECTIONS
 	} >.sram
 #endif
 
-	__u_boot_list : {
-		. = ALIGN(8);
-		KEEP(*(SORT(__u_boot_list*)));
-		. = ALIGN(8);
-	} >.sram
-
 	.binman_sym_table : {
 		. = ALIGN(8);
 		__binman_sym_start = .;
@@ -63,6 +57,12 @@ SECTIONS
 		. = ALIGN(8);
 	} > .sram
 
+	__u_boot_list : {
+		. = ALIGN(8);
+		KEEP(*(SORT(__u_boot_list*)));
+		. = ALIGN(8);
+	} >.sram
+
 	__image_copy_end = .;
 	_end = .;
 	_image_binary_end = .;
diff --git a/arch/arm/cpu/u-boot-spl.lds b/arch/arm/cpu/u-boot-spl.lds
index c578c3ebf821..5f807323f856 100644
--- a/arch/arm/cpu/u-boot-spl.lds
+++ b/arch/arm/cpu/u-boot-spl.lds
@@ -31,16 +31,16 @@ SECTIONS
 		*(.data*)
 	}
 
-	. = ALIGN(4);
-	__u_boot_list : {
-		KEEP(*(SORT(__u_boot_list*)));
-	}
-
 	. = ALIGN(4);
 	.binman_sym_table : {
 		__binman_sym_start = .;
 		KEEP(*(SORT(.binman_sym*)));
 		__binman_sym_end = .;
+	}
+
+	. = ALIGN(4);
+	__u_boot_list : {
+		KEEP(*(SORT(__u_boot_list*)));
 		. = ALIGN(8);
 	}
 
diff --git a/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds b/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds
index 303ace2f61ca..260a0a79dd0a 100644
--- a/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds
+++ b/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds
@@ -39,16 +39,16 @@ SECTIONS
 		*(.data*)
 	} > .nor
 
-	. = ALIGN(4);
-	__u_boot_list : {
-		KEEP(*(SORT(__u_boot_list*)));
-	} > .nor
-
 	. = ALIGN(4);
 	.binman_sym_table : {
 		__binman_sym_start = .;
 		KEEP(*(SORT(.binman_sym*)));
 		__binman_sym_end = .;
+	} > .nor
+
+	. = ALIGN(4);
+	__u_boot_list : {
+		KEEP(*(SORT(__u_boot_list*)));
 		. = ALIGN(8);
 	} > .nor
 
diff --git a/arch/riscv/cpu/u-boot-spl.lds b/arch/riscv/cpu/u-boot-spl.lds
index 35de28db8f3a..5a65e6653f25 100644
--- a/arch/riscv/cpu/u-boot-spl.lds
+++ b/arch/riscv/cpu/u-boot-spl.lds
@@ -31,18 +31,17 @@ SECTIONS
 	.data : {
 		*(.data*)
 	} > .spl_mem
-	. = ALIGN(4);
-
-	__u_boot_list : {
-		KEEP(*(SORT(__u_boot_list*)));
-	} > .spl_mem
 
 	. = ALIGN(4);
-
 	.binman_sym_table : {
 		__binman_sym_start = .;
 		KEEP(*(SORT(.binman_sym*)));
 		__binman_sym_end = .;
+	} > .spl_mem
+
+	. = ALIGN(4);
+	__u_boot_list : {
+		KEEP(*(SORT(__u_boot_list*)));
 		. = ALIGN(8);
 	} > .spl_mem
 
-- 
2.43.0

