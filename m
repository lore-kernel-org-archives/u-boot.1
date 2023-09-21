Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B58E7070E
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 10:39:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B913C86A38;
	Thu, 21 Sep 2023 12:39:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="N8Vkpeb8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9ECE486A9F; Thu, 21 Sep 2023 12:39:34 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3DCF86530
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 12:39:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id EC8763F6CE; 
 Thu, 21 Sep 2023 10:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1695292772;
 bh=6FU2+NB/HLf79vFa4g5B/CJdEgdz/3G/c8JjgVCYw30=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=N8Vkpeb8LwVgEXafElrr6H8wyYrn0L2jpXLP3FWpDKCoW4z90Xff1oqhF5ogF6fXr
 AqMxZ3nbucEbw/qqfLgSpIYIojQXSp7ELMa/bp+X3yOhcDmKYe4Smixa2XhQz9sgOX
 TtRVmjqu4K/mqaY/ho+LwIz+pIIPZ2tBnXZaIWKH8IVYs0p2H8lI4FvNxgthnchABE
 fY0rYtLWhakV7Aey3PIcBXwrnASVHZGPbgI7qQKOP1beNA70MuQ4EtAAeubG0Zw2lK
 iG1pOgWguUKuyHC3lbbZ41iLY16hJ2NYXu2sguCw3tpdpI/bRWRPIjafRK+Hn1oxVI
 7XcY0HpvxHCkA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] cmd/exception: test RISC-V 16 bit aligned instruction
Date: Thu, 21 Sep 2023 12:39:29 +0200
Message-Id: <20230921103929.86836-1-heinrich.schuchardt@canonical.com>
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

A 16 bit aligned instruction should generated an exception if the C
extension is not available.

Provide an 'extension ialign16' command for testing exception handling.

For testing build qemu-riscv64_defconfig with CONFIG_RISCV_ISA_C=n
and run with

    qemu-system-riscv64 -M virt -bios u-boot -nographic -cpu rv64,c=false

    => exception ialign16
    Unhandled exception: Instruction address misaligned
    EPC: 0000000087719138 RA: 0000000087719218 TVAL: 000000008771913e
    EPC: 0000000080020138 RA: 0000000080020218 reloc adjusted

    Code: 0113 0101 8067 0000 0113 ff01 3423 0011 (006f 0060)

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/riscv/exception.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/cmd/riscv/exception.c b/cmd/riscv/exception.c
index db8d8af048..f38f454a0b 100644
--- a/cmd/riscv/exception.c
+++ b/cmd/riscv/exception.c
@@ -24,6 +24,19 @@ static int do_ebreak(struct cmd_tbl *cmdtp, int flag, int argc,
 	return CMD_RET_FAILURE;
 }
 
+static int do_ialign16(struct cmd_tbl *cmdtp, int flag, int argc,
+		       char *const argv[])
+{
+	asm volatile (
+		/* jump skipping 2 bytes */
+		".long 0x0060006f\n"
+		".long 0x006f0000\n"
+		".long 0x00000060\n"
+	);
+	printf("The system supports 16 bit aligned instructions.\n");
+	return CMD_RET_SUCCESS;
+}
+
 static int do_unaligned(struct cmd_tbl *cmdtp, int flag, int argc,
 			char *const argv[])
 {
@@ -48,6 +61,8 @@ static struct cmd_tbl cmd_sub[] = {
 			 "", ""),
 	U_BOOT_CMD_MKENT(ebreak, CONFIG_SYS_MAXARGS, 1, do_ebreak,
 			 "", ""),
+	U_BOOT_CMD_MKENT(ialign16, CONFIG_SYS_MAXARGS, 1, do_ialign16,
+			 "", ""),
 	U_BOOT_CMD_MKENT(unaligned, CONFIG_SYS_MAXARGS, 1, do_unaligned,
 			 "", ""),
 	U_BOOT_CMD_MKENT(undefined, CONFIG_SYS_MAXARGS, 1, do_undefined,
@@ -59,6 +74,7 @@ static char exception_help_text[] =
 	"  The following exceptions are available:\n"
 	"  compressed - compressed instruction\n"
 	"  ebreak     - breakpoint\n"
+	"  ialign16   - 16 bit aligned instruction\n"
 	"  undefined  - illegal instruction\n"
 	"  unaligned  - load address misaligned\n"
 	;
-- 
2.40.1

