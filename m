Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37241C369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 16:26:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36D9F82F7C;
	Wed, 16 Apr 2025 18:26:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="W7BKLsAb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E05C382F6F; Wed, 16 Apr 2025 18:26:08 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAF2682F54
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 18:26:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 8D19425D27;
 Wed, 16 Apr 2025 18:26:06 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MtAy3Wt4_fyL; Wed, 16 Apr 2025 18:26:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1744820765; bh=3/nym5x5VnsEiLKtMOL8EcNUtfqShyb74hpgTtydZIw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=W7BKLsAbiviw5sZKzmc38yMFJN887sUY4UOcmsq3gJgHkZAvVVRvbdEBhSddNZtoO
 PqTHYdYRFvnguLIvHk6c8Wlo4qLaFPv+RxR4TTSBo2+ZinMg7QmU5dhI0LyKR4mx7s
 x/6Hp88QmimFEo9WKLtEQOFcsNgnXMjKzzHwP6Y6ldYHr+QGy5I2/TwFyV3yrzQfYP
 NzADv45v2qRV+weaPbsRb5b0g3nKtdRMc5XX+/bg27DHGrv6UfmgZo1KURkO2ARX6s
 52ZUJ6+4q9a34+F69DvrAHu1LqnUOqiYAIYaDf0Wg9Q2UE2o712zlbD1Z/vBmQxs26
 Q0vgOa1VA69Hg==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Simon Glass <sjg@chromium.org>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, E Shattow <e@freeshell.de>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Sumit Garg <sumit.garg@kernel.org>, Bin Meng <bmeng.cn@gmail.com>
Cc: u-boot@lists.denx.de,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH v2 3/3] riscv: Provide __image_copy_{start_end} symbols in
 linkerscript
Date: Wed, 16 Apr 2025 16:25:33 +0000
Message-ID: <20250416162533.1396-4-ziyao@disroot.org>
In-Reply-To: <20250416162533.1396-1-ziyao@disroot.org>
References: <20250416162533.1396-1-ziyao@disroot.org>
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

Binman looks for __image_copy_start to determine the base address of an
entry if elf-base-sym isn't specified, which is missing in RISC-V port.
This causes binman skips RISC-V SPL entries without filling addresses
into its .binman_sym_table section.

This patch defines __image_copy_start in linkerscript of both SPL and
proper U-Boot to ensure binman_sym functions correctly with the default
binman.dtsi. The paired symbol, __image_copy_end, is introduced as well
for completeness.

Signed-off-by: Yao Zi <ziyao@disroot.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 arch/riscv/cpu/u-boot-spl.lds | 2 ++
 arch/riscv/cpu/u-boot.lds     | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/arch/riscv/cpu/u-boot-spl.lds b/arch/riscv/cpu/u-boot-spl.lds
index 907094620bd..0717833df55 100644
--- a/arch/riscv/cpu/u-boot-spl.lds
+++ b/arch/riscv/cpu/u-boot-spl.lds
@@ -16,6 +16,7 @@ ENTRY(_start)
 SECTIONS
 {
 	. = ALIGN(4);
+	__image_copy_start = ADDR(.text);
 	.text : {
 		arch/riscv/cpu/start.o	(.text)
 		*(.text*)
@@ -46,6 +47,7 @@ SECTIONS
 
 	_end = .;
 	_image_binary_end = .;
+	__image_copy_end = .;
 
 	.bss : {
 		__bss_start = .;
diff --git a/arch/riscv/cpu/u-boot.lds b/arch/riscv/cpu/u-boot.lds
index 2ffe6ba3c8f..b11ea8b56d2 100644
--- a/arch/riscv/cpu/u-boot.lds
+++ b/arch/riscv/cpu/u-boot.lds
@@ -10,6 +10,7 @@ ENTRY(_start)
 SECTIONS
 {
 	. = ALIGN(4);
+	__image_copy_start = ADDR(.text);
 	.text : {
 		arch/riscv/cpu/start.o	(.text)
 	}
@@ -57,6 +58,8 @@ SECTIONS
 		__efi_runtime_rel_stop = .;
 	}
 
+	__image_copy_end = .;
+
 	/DISCARD/ : { *(.rela.plt*) }
 	.rela.dyn : {
 		__rel_dyn_start = .;
-- 
2.49.0

