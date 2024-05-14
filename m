Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D84C04FFE
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 05:51:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40F7388229;
	Tue, 14 May 2024 07:51:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="NJkcVfU0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 070D288280; Tue, 14 May 2024 07:51:53 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0039987AD2
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 07:51:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (unknown [149.11.192.251])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 03F5D41D92; 
 Tue, 14 May 2024 05:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1715665908;
 bh=CIEcQYbPOJRqWKYLSW2wKDYVFmgHp2uosNgcCIjKVzA=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=NJkcVfU0rRH+HIhuaesRPOFXw0H664wYPGzAgQi7hO6mCxyKQmfyjxGgNdK3dUuXU
 DH6m+fSPuTqBM8X4hEmI5U7CAdktFfYoo34RSAS0mKENgw1oL8Va9bOQzjIjKHQbx7
 C2+t6bfjLQkKv8zfaz3EB3gyRBq+qaf1rtkJ6rl/x4SvvXKO3ZPL6mfD9wRXEqxrdG
 CdQDqqmCvXk/LlpsJq4tn0quBuYvVPfadb6Hq4B4pEh8VT8LqFmuiifI9s3VGfbjsr
 jESpVtt57/ibcDUiUSVHwkIFGWuxdIxE5lJXmkwPqKtk+0Xg8fRLZ9BTI7HXdjx1Vp
 Zkv9N94ZCPc9w==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] riscv: simplify backtrace report
Date: Tue, 14 May 2024 07:51:42 +0200
Message-ID: <20240514055142.26178-1-heinrich.schuchardt@canonical.com>
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

* We already have a header 'backtrace', there is no need to repeat the
  word backtrace on every line.
* Add a blank line before the backtrace section of the crash report for
  improved readability.
* If U-Boot is compiled without backtrace, there is no need to write a
  message at all.
* Avoid #ifdef. We prefer functions to always be compiled and let
  the linker remove them if not needed.
* Foresee 3 digits for the backtrace index.

For testing the 'exception' command can be used.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/riscv/lib/interrupts.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/lib/interrupts.c b/arch/riscv/lib/interrupts.c
index 7350e2ced85..f9a1428a486 100644
--- a/arch/riscv/lib/interrupts.c
+++ b/arch/riscv/lib/interrupts.c
@@ -60,21 +60,20 @@ static void show_regs(struct pt_regs *regs)
 #endif
 }
 
-#if defined(CONFIG_FRAMEPOINTER) || defined(CONFIG_SPL_FRAMEPOINTER)
-static void show_backtrace(struct pt_regs *regs)
+static void __maybe_unused show_backtrace(struct pt_regs *regs)
 {
 	uintptr_t *fp = (uintptr_t *)regs->s0;
 	unsigned count = 0;
 	ulong ra;
 
-	printf("backtrace:\n");
+	printf("\nbacktrace:\n");
 
 	/* there are a few entry points where the s0 register is
 	 * set to gd, so to avoid changing those, just abort if
 	 * the value is the same */
 	while (fp != NULL && fp != (uintptr_t *)gd) {
 		ra = fp[-1];
-		printf("backtrace %2d: FP: " REG_FMT " RA: " REG_FMT,
+		printf("%3d: FP: " REG_FMT " RA: " REG_FMT,
 		       count, (ulong)fp, ra);
 
 		if (gd && gd->flags & GD_FLG_RELOC)
@@ -87,12 +86,6 @@ static void show_backtrace(struct pt_regs *regs)
 		count++;
 	}
 }
-#else
-static void show_backtrace(struct pt_regs *regs)
-{
-	printf("No backtrace support enabled\n");
-}
-#endif
 
 /**
  * instr_len() - get instruction length
@@ -165,7 +158,8 @@ static void _exit_trap(ulong code, ulong epc, ulong tval, struct pt_regs *regs)
 		       epc - gd->reloc_off, regs->ra - gd->reloc_off);
 
 	show_regs(regs);
-	show_backtrace(regs);
+	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
+		show_backtrace(regs);
 	show_code(epc);
 	show_efi_loaded_images(epc);
 	panic("\n");
-- 
2.43.0

