Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046CDE706F0
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 08:42:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AB6C8648F;
	Thu, 21 Sep 2023 10:42:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="KvrO/Bk7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01F2A86844; Thu, 21 Sep 2023 10:42:56 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F03DF86410
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 10:42:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 521E23FB4B; 
 Thu, 21 Sep 2023 08:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1695285773;
 bh=ZSGmPY3jaeuXmEQ1SPIEHibF76pND7f3R1IVV2MqX6c=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=KvrO/Bk7qnd54LEK2SeQXbnLyeB7X0PHk4MQoI4FVdqfMnP+c6S+lBwMXpjKCkYHG
 naZrd7LmXF3DOoHm5Q9ZMcii65S0EKUH6HG3WAgY8s6Pkd5kR/sOTWqI8JkmwKhU4a
 +7G2VrvkimM8QIbKA/ivx3fir/PvTIfgi8gkUIPTCA5r2jqSUfX7ixhknpmxhI0yEd
 3pLska+xO3C4BWpbzBaq/bktfK7DQdry5eMkWQPBrSid7sqQZ/YPzD3KXUrMZmvmVQ
 jIdemjLTfL223tXkHV63C78whFFCFELOH5+Ji6zjE/lTUoLs4pzXTQqCE5UkdWHclU
 usfpi2E5JF1Zw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] cmd/exception: support RISC-V compressed instruction
Date: Thu, 21 Sep 2023 10:42:18 +0200
Message-Id: <20230921084218.57260-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

Eliminating the C extension on application processors is under
discussion.

Support emitting a compressed instruction. This will lead to an
illegal instruction exception if the C extension is not implemented.

For testing build qemu-riscv64_defconfig with CONFIG_RISCV_ISA_C=n
and run with

    qemu-system-riscv64 -M virt -bios u-boot -nographic -cpu rv64,c=false

    => exception compressed
    Unhandled exception: Illegal instruction
    EPC: 0000000087731708 RA: 000000008773fe44 TVAL: 0000000000004501
    EPC: 000000008001b708 RA: 0000000080029e44 reloc adjusted

    Code: 0b93 0000 0493 0000 0993 0000 f06f ccdf (4501)

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/riscv/exception.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/cmd/riscv/exception.c b/cmd/riscv/exception.c
index 7a08061d12..db8d8af048 100644
--- a/cmd/riscv/exception.c
+++ b/cmd/riscv/exception.c
@@ -8,6 +8,15 @@
 #include <common.h>
 #include <command.h>
 
+static int do_compressed(struct cmd_tbl *cmdtp, int flag, int argc,
+			 char *const argv[])
+{
+	/* c.li a0, 0; c.li a0, 0 */
+	asm volatile (".long 0x45014501\n");
+	printf("The system supports compressed instructions.\n");
+	return CMD_RET_SUCCESS;
+}
+
 static int do_ebreak(struct cmd_tbl *cmdtp, int flag, int argc,
 			char *const argv[])
 {
@@ -35,6 +44,8 @@ static int do_undefined(struct cmd_tbl *cmdtp, int flag, int argc,
 }
 
 static struct cmd_tbl cmd_sub[] = {
+	U_BOOT_CMD_MKENT(compressed, CONFIG_SYS_MAXARGS, 1, do_compressed,
+			 "", ""),
 	U_BOOT_CMD_MKENT(ebreak, CONFIG_SYS_MAXARGS, 1, do_ebreak,
 			 "", ""),
 	U_BOOT_CMD_MKENT(unaligned, CONFIG_SYS_MAXARGS, 1, do_unaligned,
@@ -46,9 +57,10 @@ static struct cmd_tbl cmd_sub[] = {
 static char exception_help_text[] =
 	"<ex>\n"
 	"  The following exceptions are available:\n"
-	"  ebreak    - breakpoint\n"
-	"  undefined - illegal instruction\n"
-	"  unaligned - load address misaligned\n"
+	"  compressed - compressed instruction\n"
+	"  ebreak     - breakpoint\n"
+	"  undefined  - illegal instruction\n"
+	"  unaligned  - load address misaligned\n"
 	;
 
 #include <exception.h>
-- 
2.40.1

