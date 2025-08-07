Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37EAC87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 16:49:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 356A884659;
	Thu,  7 Aug 2025 18:49:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="FN1iuE8T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5947284660; Thu,  7 Aug 2025 18:49:41 +0200 (CEST)
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk
 [78.40.148.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E8F0845EC
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 18:49:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=codethink.co.uk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=srv_ts003@codethink.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EGN/S7QoL4fVrTZs360CD8nr/Wzh5x8tZrAFAe6BRbs=; b=FN1iuE8TLdiKGairfFgc3loooS
 fvJOT5LuHscrcfahhHcLVTvKNtnwQ6vRBtGPZLNSDj4MTfMRQEFVM+rFgOzQQe+1AdmO1BgSlZpNj
 no/nzj79idPZ+nsRFf8A+HzsOK8ZNZsM0SQwrgy293g/JiMmQlTx//8SQYjQGCihOfJbph9hvBc5F
 VINsvkbaX/VyCaxAn/doc9GluvvKgbFy8m3V/uJplICgulNZ5Hxe1Vkr/jMxj7k+qTHTXCJogfki3
 5i7BEGxHSiRsAi7KWRFO1O7pVRCahNQKJd8mcvDaSfxJnbkAVSeAQyEETvJSQkATnmVgs9qyH7ZUL
 idMgCzBQ==;
Received: from [167.98.27.226] (helo=rainbowdash)
 by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1uk3o6-00HCkx-Te; Thu, 07 Aug 2025 17:49:34 +0100
Received: from ben by rainbowdash with local (Exim 4.98.2)
 (envelope-from <ben@rainbowdash>) id 1uk3o6-00000000AYU-2vnl;
 Thu, 07 Aug 2025 17:49:34 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: rick@andestech.com,
	ycliang@andestech.com,
	u-boot@lists.denx.de
Cc: Sam Grove <sgrove@mips.com>, Chao-ying Fu <cfu@mips.com>,
 Mukunda Aprameya <maprameya@mips.com>, Umesh Kalappa <ukalappa@mips.com>,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>,
 Mallikarjuna Gouda <mgouda@mips.com>,
 Vaibhav Chauthmal <vchauthmal@mips.com>,
 Swapnil Agrawal <sagrawal@mips.com>, felix.chong@codethink.co.uk,
 Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] arch/riscv/lib: update memmove and memcpy for big-endian
Date: Thu,  7 Aug 2025 17:49:33 +0100
Message-Id: <20250807164933.40564-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
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

Change the shift patterns for the unaligned memory move and copy code
to deal with big-endian by definign macros to change the shfit left and
right to go the opposite way.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/riscv/lib/memcpy.S  | 12 ++++++++++--
 arch/riscv/lib/memmove.S | 12 ++++++++++--
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/lib/memcpy.S b/arch/riscv/lib/memcpy.S
index 9884077c933..e5479bbe84e 100644
--- a/arch/riscv/lib/memcpy.S
+++ b/arch/riscv/lib/memcpy.S
@@ -125,6 +125,14 @@ WEAK(memcpy)
 .copy_end:
 	ret
 
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+#define M_SLL sll
+#define M_SRL srl
+#else
+#define M_SLL srl
+#define M_SRL sll
+#endif
+
 .Lmisaligned_word_copy:
 	/*
 	 * Misaligned word-wise copy.
@@ -144,10 +152,10 @@ WEAK(memcpy)
 	addi	t0, t0, -(SZREG-1)
 	/* At least one iteration will be executed here, no check */
 1:
-	srl	a4, a5, t3
+	M_SRL	a4, a5, t3
 	REG_L	a5, SZREG(a1)
 	addi	a1, a1, SZREG
-	sll	a2, a5, t4
+	M_SLL	a2, a5, t4
 	or	a2, a2, a4
 	REG_S	a2, 0(a0)
 	addi	a0, a0, SZREG
diff --git a/arch/riscv/lib/memmove.S b/arch/riscv/lib/memmove.S
index fbe6701dbe4..b2c1c736713 100644
--- a/arch/riscv/lib/memmove.S
+++ b/arch/riscv/lib/memmove.S
@@ -91,6 +91,14 @@ WEAK(memmove)
 	mv	a0, t0
 	ret
 
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+#define M_SLL sll
+#define M_SRL srl
+#else
+#define M_SLL srl
+#define M_SRL sll
+#endif
+
 .Lmisaligned_word_copy:
 	/*
 	 * Misaligned word-wise copy.
@@ -110,10 +118,10 @@ WEAK(memmove)
 	addi	t0, t0, SZREG-1
 	/* At least one iteration will be executed here, no check */
 1:
-	sll	a4, a5, t4
+	M_SLL	a4, a5, t4
 	addi	a1, a1, -SZREG
 	REG_L	a5, 0(a1)
-	srl	a2, a5, t3
+	M_SRL	a2, a5, t3
 	or	a2, a2, a4
 	addi	a0, a0, -SZREG
 	REG_S	a2, 0(a0)
-- 
2.37.2.352.g3c44437643

