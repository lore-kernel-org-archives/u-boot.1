Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C82CDC0218C
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 04:15:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7B4B80F9E;
	Mon, 27 Jan 2025 05:15:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="wwgYqdtb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC7FC80FF7; Mon, 27 Jan 2025 05:15:31 +0100 (CET)
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com
 [203.205.221.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D0E680FC4
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 05:15:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=1425075683@qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1737951321; bh=3vlNsd3sHhZr+A8CheIJ1hB2/4rUylYcnsrKk5HTaKU=;
 h=From:To:Cc:Subject:Date;
 b=wwgYqdtbz9A553/0gt2GXA5zL5VkrpReEZyeU2Sv9ZuoK/vgtPLOK8ARWE1Jqn6xn
 cbUtsVsooiVVA0CHJbuwDAgLuafnBbWoxV9OuVcBahBNR4Ubx6MrmlVNflD09fZi9+
 3IJo0hJgH9bF0IX4aXaydo4KzUTmS0zleNEExQFU=
Received: from ubuntu.localdomain ([112.51.40.31])
 by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
 id 3D388C6E; Mon, 27 Jan 2025 12:15:19 +0800
X-QQ-mid: xmsmtpt1737951319t67mlju1g
Message-ID: <tencent_207D2C7A640737D8D4836580A0303D275109@qq.com>
X-QQ-XMAILINFO: MMvVzQSdFuTpKTaxgTKENGfMFjQK13Ehw/D/ZEyBDiSl2eM+qV/qrbqvJW3TrV
 UqElR3CcGvE2HmJmP8fNNMMpkoszlsmnkuMdq1VDL0/NszX/ja9921Q4Yvn7AZJHpI/1bm0DpIPY
 68zupHGinWsMT2+027IyDJGnrAe0q6stLtMQtj7ZDMTf01rcFTZSFQzXI9TA/xSRXv7Qw9y0uFMq
 /6o725zsEPIZMCfp/9tqXis0Zgx2RSvIpdEMiapnidSLLwuxMUPNNf6dhX42qXkwMS7fy3VAMh5Q
 8bmg+gMsCE9mVX8hoDd6KSB0i8t0nnQzBbMK7pwfR3AHI1oRW+SXmGaN2nkLE/MqGvCkSrK2cXjS
 G9y8R1aoiSmAI4QaTn1pJqdfy7GiuEypGk/yD4bFLePH70OOwFgslB+NlXSukxZmdZo6jZUlCVnL
 Qp829RZ50LXpvihbDQMRCKWS/DZShbdKCRCP/SqRLm5fn5g26pA5SiOsJAMJHBpyIfmN8ugFvMhE
 exTBz1mqX60mIS0Ra4pxiznkgPQ0I9bapaclSofZiP/1mZTwrC9ktsFvue88N/06Nhsh+MA1C7PP
 1akv2TwcbcyuwT8aGeVExqsCBAEXqfQ7CpYgUFPA9Wx5WTYnyAbC0E7kV5G5WWrj87Cg7rIherWJ
 J5A+wzsoaLkKCtIOnu+hafPA/WWHATrSJG4/SHRacibfQ9cSErNrFlkbfGSPs0S+NpAn+jUtXmwb
 X0cB/HDIvrwbptlX/CA096FCd+6QEJLCztuqUoyq1DiWThR9hItXAjjYCE1sKKHZoYfpR8TFydKI
 YOS386Nli/jtLlraAF4hHaecuXoMYwdFCdrsyO2VmrcOKs4IEMaGOa/eOUqVa+mt+3RfJ1I9SsTO
 /9UQj2Y0aFF13mWUn95VD7OjGz2fhYiTV+wXopXF2nmMPm26KM5mZ6I31/T3KDFz6HBJl8jJon7i
 J5uW661fEh5ZOaQ8Tge69a7Db3gVjiwWTJKSbGQYPEmbMMwln8UCsloG60IbkvFAhucDVQ/i1Lzk
 61Bdc7jA==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: 1425075683@qq.com
To: Liya Huang <1425075683@qq.com>
Cc: "Brunham, Kalen" <kalen.brunham@intel.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: [PATCH] examples: fix building on arm32
Date: Mon, 27 Jan 2025 12:15:17 +0800
X-OQ-MSGID: <20250127041517.35670-1-1425075683@qq.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Liya Huang <1425075683@qq.com>

Refer to the commit a3c101a61348 ("examples: fix building on arm64")
fix for arm32. crt0.S does not even build with
CONFIG_API=y, CONFIG_EXAMPLES=y:

    examples/api/crt0.S: Assembler messages:
    examples/api/crt0.S:32: Error: lo register required -- `ldr ip,=search_hint'
    examples/api/crt0.S:33: Error: lo register required -- `str sp,[ip]'
    examples/api/crt0.S:39: Error: lo register required -- `ldr ip,=syscall_ptr'
    examples/api/crt0.S:40: Error: lo register required -- `ldr pc,[ip]'
    make[2]: *** [scripts/Makefile.build:292：examples/api/crt0.o] Error 1

Use valid register names and instructions.

Signed-off-by: Liya Huang <1425075683@qq.com>
---

 examples/api/crt0.S | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/examples/api/crt0.S b/examples/api/crt0.S
index d2a97557817..d33e1c4aa4d 100644
--- a/examples/api/crt0.S
+++ b/examples/api/crt0.S
@@ -29,15 +29,17 @@ syscall:
 	.text
 	.globl _start
 _start:
-	ldr	ip, =search_hint
-	str	sp, [ip]
+	ldr	r0, =search_hint
+	mov	r1, sp
+	str	r1, [r0]
 	b	main
 
 
 	.globl syscall
 syscall:
-	ldr	ip, =syscall_ptr
-	ldr	pc, [ip]
+	ldr	r0, =syscall_ptr
+	ldr	r0, [r0]
+	bx	r0
 
 #elif defined(CONFIG_ARM64)
 
-- 
2.25.1

