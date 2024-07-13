Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA01C3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 13:27:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3FDF888FB;
	Sat, 13 Jul 2024 15:21:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Y5le1DXT";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="E1SExfFb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF6BA888FC; Sat, 13 Jul 2024 15:21:47 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5871888D7
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 15:21:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WLpyd5Lnyz9sZv;
 Sat, 13 Jul 2024 15:21:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gx2zxYnvnTr1vWIcGJzIc2DgkIpJU9wz0Pg4F1FrEoo=;
 b=Y5le1DXTH8K2UJtV6CU3dwDSkQ5W3dTyHQnBnkdHi9oShG8eypPG3as2ndCs39/mr1s2BH
 wQTww86hzvaV/s5ftxVBzX9woK+tEFBQ3SkYLOxczd2xg9WX3T3bkd6c6nwsGpSZmsszYq
 kzookqlWb5RXxtOLO0hQiGu+vZlPmuxrIPIsZFPfp2TA5Gn2j3dsURDDvEoZ216yPOEsbl
 /Rl1yLtz1z+pP5zQt8WCRuUBo35wcKlX9spuxL85wVz/V5jDQxnK4P3xP/AF4RKaVIKupD
 zt1MuCckStlWxRj7vkaeqe19+lTXimVCxWAy/flDhzhnFPFKVz/Fk/M4t5Qr+w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gx2zxYnvnTr1vWIcGJzIc2DgkIpJU9wz0Pg4F1FrEoo=;
 b=E1SExfFbEg4BmCizi7O9UomTrdnYeMlkDnmn9xuuJ9LIKa3E6rrR2e4Bz2mH5usnCxbi5a
 sYhOo1zNrJyGIaWjS7asI9156pW13QoLAESIP6tK5C14e3vuAUQTImegP0L6Q4epll6iyw
 47k/YKE2/iOzZllGVt6UjRM3hIrdgx33irr/i9u7K6UPHA+FDvHpG8Sxmcw5GctBThjqwN
 h2QpfbbzMrUUooUW5V64B/ZEPDBg+FVsBxCSlkBnkzdH6X8rquoUO8Wh625ikAxucyZ2hs
 WOGcSfDtKTz8ylgdUlqglU7jlikyKz24HtJSrRydUq4XdzgbE4mqDmw9Icgm3w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 36/45] nios2: Remove duplicate newlines
Date: Sat, 13 Jul 2024 15:19:27 +0200
Message-ID: <20240713132021.57650-36-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
References: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 1e9c81dfc9ebd524990
X-MBO-RS-META: mokg7jh3uaw1mgtqafgh531ysdz51zxh
X-Rspamd-Queue-Id: 4WLpyd5Lnyz9sZv
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/nios2/cpu/interrupts.c            | 2 --
 arch/nios2/include/asm/bitops/atomic.h | 1 -
 arch/nios2/include/asm/ptrace.h        | 1 -
 arch/nios2/lib/libgcc.c                | 6 ------
 4 files changed, 10 deletions(-)

diff --git a/arch/nios2/cpu/interrupts.c b/arch/nios2/cpu/interrupts.c
index 27093c4faa3..c98d40a49b5 100644
--- a/arch/nios2/cpu/interrupts.c
+++ b/arch/nios2/cpu/interrupts.c
@@ -98,7 +98,6 @@ void irq_install_handler(int irq, interrupt_handler_t *hdlr, void *arg)
 	if (flag) enable_interrupts();
 }
 
-
 int interrupt_init(void)
 {
 	int i;
@@ -114,7 +113,6 @@ int interrupt_init(void)
 	return (0);
 }
 
-
 /*************************************************************************/
 #if defined(CONFIG_CMD_IRQ)
 int do_irqinfo(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
diff --git a/arch/nios2/include/asm/bitops/atomic.h b/arch/nios2/include/asm/bitops/atomic.h
index c8946465e63..0130fd47d39 100644
--- a/arch/nios2/include/asm/bitops/atomic.h
+++ b/arch/nios2/include/asm/bitops/atomic.h
@@ -31,7 +31,6 @@ extern raw_spinlock_t __atomic_hash[ATOMIC_HASH_SIZE] __lock_aligned;
 	local_irq_restore(f);				\
 } while(0)
 
-
 #else
 #  define _atomic_spin_lock_irqsave(l,f) do { local_irq_save(f); } while (0)
 #  define _atomic_spin_unlock_irqrestore(l,f) do { local_irq_restore(f); } while (0)
diff --git a/arch/nios2/include/asm/ptrace.h b/arch/nios2/include/asm/ptrace.h
index 317d8ae09b4..b1feb338886 100644
--- a/arch/nios2/include/asm/ptrace.h
+++ b/arch/nios2/include/asm/ptrace.h
@@ -12,5 +12,4 @@ struct pt_regs {
 	unsigned status;
 };
 
-
 #endif /* __ASM_NIOS2_PTRACE_H_ */
diff --git a/arch/nios2/lib/libgcc.c b/arch/nios2/lib/libgcc.c
index a45b3e82efc..30b846179c0 100644
--- a/arch/nios2/lib/libgcc.c
+++ b/arch/nios2/lib/libgcc.c
@@ -16,7 +16,6 @@ typedef unsigned long long DSItype;
 
 #include "longlong.h"
 
-
 typedef int word_type;
 typedef long Wtype;
 typedef long long DWtype;
@@ -46,7 +45,6 @@ const UQItype __clz_tab[256] =
   8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
 };
 
-
 DWtype
 __ashldi3 (DWtype u, word_type b)
 {
@@ -388,7 +386,6 @@ __negdi2 (DWtype u)
   return w.ll;
 }
 
-
 DWtype
 __muldi3 (DWtype u, DWtype v)
 {
@@ -440,7 +437,6 @@ __ucmpdi2 (DWtype a, DWtype b)
   return 1;
 }
 
-
 UDWtype
 __udivdi3 (UDWtype n, UDWtype d)
 {
@@ -507,14 +503,12 @@ __divsi3 (SItype a, SItype b)
   return res;
 }
 
-
 SItype
 __udivsi3 (SItype a, SItype b)
 {
   return udivmodsi4 (a, b, 0);
 }
 
-
 SItype
 __modsi3 (SItype a, SItype b)
 {
-- 
2.43.0

