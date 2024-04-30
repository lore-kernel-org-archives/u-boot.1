Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29CC5C19F4F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 16:37:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BDE388953;
	Tue, 30 Apr 2024 18:37:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=rivoreo.one
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B3DF88953; Tue, 30 Apr 2024 18:37:04 +0200 (CEST)
Received: from tianjin2.rivoreo.one (unknown [60.25.139.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AAFB885A4
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 18:37:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=rivoreo.one
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=whr@rivoreo.one
Received: from [10.1.105.1] (localhost [127.0.0.1])
 by tianjin2.rivoreo.one (Postfix) with ESMTP id 54620722B0;
 Wed,  1 May 2024 00:36:52 +0800 (CST)
Received: from 10.1.107.31 (SquirrelMail authenticated user whr)
 by _ with HTTP; Wed, 1 May 2024 00:36:52 +0800
Message-ID: <4626833c19d0c0c2c30946582411814c.squirrel@_>
Date: Wed, 1 May 2024 00:36:52 +0800
Subject: [PATCH v2] sandbox: make function 'do_undefined' properly compiles
 for PowerPC
From: "WHR" <whr@rivoreo.one>
To: u-boot@lists.denx.de
Cc: "Heinrich Schuchardt" <xypron.glpk@gmx.de>,
 "Simon Glass" <sjg@chromium.org>, "Tom Rini" <trini@konsulko.com>
User-Agent: SquirrelMail/1.4.23 [SVN]
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20240501003652_45648"
X-Priority: 3 (Normal)
Importance: Normal
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

------=_20240501003652_45648
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

The 2 bytes 0xffff is too short for being a PowerPC instruction, resulting
in an error similar to:
    /tmp/ccW8yjie.s: Assembler messages:
    /tmp/ccW8yjie.s: Error: unaligned opcodes detected in executable
segment /tmp/ccW8yjie.s:223: Error: instruction address is not a
multiple of 4 make[2]: *** [/tmp/ccyF4HIC.mk:17:
/tmp/ccCKUFuF.ltrans5.ltrans.o]
Error 1

Signed-off-by: WHR <msl0000023508@gmail.com>

---
v2:
Resubmit with diff content in plain text.

 cmd/sandbox/exception.c | 4 ++++
 1 file changed, 4 insertions(+)

------=_20240501003652_45648
Content-Type: text/plain;
 name="0001-sandbox-make-function-do_undefined-properly-compiles"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="0001-sandbox-make-function-do_undefined-properly-compiles"

diff --git a/cmd/sandbox/exception.c b/cmd/sandbox/exception.c
index cfa153da26..f9c847d8ff 100644
--- a/cmd/sandbox/exception.c
+++ b/cmd/sandbox/exception.c
@@ -19,7 +19,11 @@ static int do_sigsegv(struct cmd_tbl *cmdtp, int flag, int argc,
 static int do_undefined(struct cmd_tbl *cmdtp, int flag, int argc,
 			char *const argv[])
 {
+#ifdef __powerpc__
+	asm volatile (".long 0xffffffff\n");
+#else
 	asm volatile (".word 0xffff\n");
+#endif
 	return CMD_RET_FAILURE;
 }
 
------=_20240501003652_45648--


