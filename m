Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B63C3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 13:26:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F389888EF;
	Sat, 13 Jul 2024 15:21:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="VGda/2eN";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="w7UAURgu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FF29888E8; Sat, 13 Jul 2024 15:21:44 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 439D4888C8
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 15:21:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WLpyZ0sy0z9sZF;
 Sat, 13 Jul 2024 15:21:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qgz6i1HBSdinO4YrJ48ClNPuh1RdPCNYh8R0fSIgBVE=;
 b=VGda/2eNiwgB7hH9kfu2eZKf6DJFxTxinw2qvH3oyD4XW1VzFJvUufrGssjHtaPTZfsI5P
 kZ1ej35CZbj8qzBy1kkW4Z6+1+epe0MfbsK3FQaKAeeAIT5Bihk1Un8bnzeCoZkHit6z+e
 nGoBTdLFBRq+LiexZLSm7bKH3JAr7pDvN9kp21n0B1YRoC9nCfQgbxz4TQCDq6J9JF8rJe
 lOOlZSZ8JOUoL8wB46jg74tE2mFXciTLSXvTrCJKCe4Ivotyld7yLtjDl8dly/eQDlSDBC
 rMQNuQjedSDCInOtoQWn+70YYE6Hi4HaE8n1Sf788wee5T3u0A7+pkUQBCRTEA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qgz6i1HBSdinO4YrJ48ClNPuh1RdPCNYh8R0fSIgBVE=;
 b=w7UAURguLSB532uHOniPLDr10aiRKEz2LaMRow0DR7eh/PNkXnGbwaMgteeP07IiKK8UYl
 ihTxT3G1CckVSWYGtN/MW1CMpRWX93D2B6AAd/ItKDnV//kSslXkfFhW42+u6AVX4uB1Ds
 mv4WDoIucEL7oPmOLCYQkddMQWbAWCJpfjOqMmy4vmYA7MxJw+6bOjb7ZzQ1PTbaE29SkP
 YzDSe7dIyn2zqn1bzNs0Z8oduoKAhllpI3fZ+bhOGiyA2yrnhjHQyg3p8icYvPwWjh08LO
 lr0itV5tKoQNm1Y+fZsydB/BrvqfeHTqg26PZuBiNUd0ScZaa+RLjIcKoZofxQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 33/45] microblaze: Remove duplicate newlines
Date: Sat, 13 Jul 2024 15:19:24 +0200
Message-ID: <20240713132021.57650-33-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
References: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 3d30b71c5e6e9b0d5dd
X-MBO-RS-META: 5zy15kbhbaxwpo4z9aqn5nf39hmwrsm3
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
 arch/microblaze/include/asm/bitops.h      | 2 --
 arch/microblaze/include/asm/posix_types.h | 2 --
 arch/microblaze/include/asm/ptrace.h      | 4 ----
 arch/microblaze/include/asm/system.h      | 1 -
 4 files changed, 9 deletions(-)

diff --git a/arch/microblaze/include/asm/bitops.h b/arch/microblaze/include/asm/bitops.h
index 2cab2ac62b9..9ea217cd854 100644
--- a/arch/microblaze/include/asm/bitops.h
+++ b/arch/microblaze/include/asm/bitops.h
@@ -32,7 +32,6 @@ static inline unsigned long ffz(unsigned long word)
 	return result;
 }
 
-
 static inline void set_bit(int nr, volatile void *addr)
 {
 	int	* a = (int *) addr;
@@ -257,7 +256,6 @@ found_middle:
 #define hweight16(x) generic_hweight16(x)
 #define hweight8(x) generic_hweight8(x)
 
-
 static inline int ext2_set_bit(int nr, volatile void *addr)
 {
 	int		mask, retval;
diff --git a/arch/microblaze/include/asm/posix_types.h b/arch/microblaze/include/asm/posix_types.h
index ccc6235c8d9..f4795f8d317 100644
--- a/arch/microblaze/include/asm/posix_types.h
+++ b/arch/microblaze/include/asm/posix_types.h
@@ -47,7 +47,6 @@ typedef unsigned int	__kernel_gid32_t;
 typedef unsigned short	__kernel_old_uid_t;
 typedef unsigned short	__kernel_old_gid_t;
 
-
 typedef struct {
 #if defined(__KERNEL__) || defined(__USE_ALL)
 	int	val[2];
@@ -56,7 +55,6 @@ typedef struct {
 #endif /* !defined(__KERNEL__) && !defined(__USE_ALL) */
 } __kernel_fsid_t;
 
-
 #if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
 
 #undef	__FD_SET
diff --git a/arch/microblaze/include/asm/ptrace.h b/arch/microblaze/include/asm/ptrace.h
index b796d4faf6b..ff861d10bb4 100644
--- a/arch/microblaze/include/asm/ptrace.h
+++ b/arch/microblaze/include/asm/ptrace.h
@@ -16,7 +16,6 @@
 #ifndef __MICROBLAZE_PTRACE_H__
 #define __MICROBLAZE_PTRACE_H__
 
-
 /* Microblaze general purpose registers with special meanings.  */
 #define GPR_ZERO	0	/* constant zero */
 #define GPR_ASM		18	/* reserved for assembler */
@@ -54,7 +53,6 @@
 #define SR_DIR		21
 #define SR_ASID		23
 
-
 #ifndef __ASSEMBLY__
 
 typedef unsigned long microblaze_reg_t;
@@ -74,7 +72,6 @@ struct pt_regs
 	microblaze_reg_t single_step;	/* 1 if in single step mode */
 };
 
-
 #define instruction_pointer(regs)	((regs)->pc)
 #define user_mode(regs)			(!(regs)->kernel_mode)
 
@@ -87,7 +84,6 @@ struct pt_regs
 
 #endif /* !__ASSEMBLY__ */
 
-
 /* The number of bytes used to store each register.  */
 #define _PT_REG_SIZE	4
 
diff --git a/arch/microblaze/include/asm/system.h b/arch/microblaze/include/asm/system.h
index 050a8b40763..4e31206436d 100644
--- a/arch/microblaze/include/asm/system.h
+++ b/arch/microblaze/include/asm/system.h
@@ -40,7 +40,6 @@ extern void *switch_thread (struct thread_struct *last,
 	}								\
 } while (0)
 
-
 /* Enable/disable interrupts.  */
 #define __sti() \
 {								\
-- 
2.43.0

