Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E483C072A2
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 18:36:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 664BD86A0A;
	Wed, 15 Nov 2023 19:36:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F3C6870D2; Wed, 15 Nov 2023 19:36:44 +0100 (CET)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A99F865A8
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 19:36:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=csgroup.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christophe.leroy@csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4SVsMF6s7Tz9t5L;
 Wed, 15 Nov 2023 19:36:41 +0100 (CET)
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 23WnEdwEXD14; Wed, 15 Nov 2023 19:36:41 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4SVsMF5sYKz9t2s;
 Wed, 15 Nov 2023 19:36:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C138B8B788;
 Wed, 15 Nov 2023 19:36:41 +0100 (CET)
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id F0r3ilBmbacN; Wed, 15 Nov 2023 19:36:41 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.111])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D59258B77E;
 Wed, 15 Nov 2023 19:36:40 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Tom Rini <trini@konsulko.com>,
	Joel Peshkin <joel.peshkin@broadcom.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	u-boot@lists.denx.de
Subject: [PATCH] Fix stack-protector for powerpc
Date: Wed, 15 Nov 2023 19:36:36 +0100
Message-ID: <cfd28ccf2ae6db320afd8d4542c57db0c12fca42.1700045185.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
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

On powerpc, stack protector expects a function called
__stack_chk_fail_local() instead of __stack_chk_fail()

And some versions of GCC for powerpc default to TLS canary
instead of global canary, so always force GCC to use global
canary with -mstack-protector-guard=global

Cc: Joel Peshkin <joel.peshkin@broadcom.com>
Fixes: 4e9bce12432 ("Add support for stack-protector")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 Makefile           | 1 +
 common/stackprot.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/Makefile b/Makefile
index ac65605a26..bddccc94e6 100644
--- a/Makefile
+++ b/Makefile
@@ -741,6 +741,7 @@ endif
 
 ifeq ($(CONFIG_STACKPROTECTOR),y)
 KBUILD_CFLAGS += $(call cc-option,-fstack-protector-strong)
+KBUILD_CFLAGS += $(call cc-option,-mstack-protector-guard=global)
 CFLAGS_EFI += $(call cc-option,-fno-stack-protector)
 else
 KBUILD_CFLAGS += $(call cc-option,-fno-stack-protector)
diff --git a/common/stackprot.c b/common/stackprot.c
index d5b7061665..6495951a77 100644
--- a/common/stackprot.c
+++ b/common/stackprot.c
@@ -18,3 +18,8 @@ void __stack_chk_fail(void)
 	panic("Stack smashing detected in function:\n%p relocated from %p",
 	      ra, ra - gd->reloc_off);
 }
+
+void __stack_chk_fail_local(void)
+{
+	__stack_chk_fail();
+}
-- 
2.41.0

