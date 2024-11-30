Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F90D7361D
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 03:06:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B395F892FD;
	Sun,  1 Dec 2024 04:06:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=qrv-systems.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BB9289615; Sat, 30 Nov 2024 21:56:54 +0100 (CET)
Received: from mr6.vodafonemail.de (mr6.vodafonemail.de [145.253.228.166])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C62989437
 for <u-boot@lists.denx.de>; Sat, 30 Nov 2024 21:56:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=qrv-systems.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yuriz@vodafonemail.de
Received: from smtp.vodafone.de (unknown [10.0.0.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by mr6.vodafonemail.de (Postfix) with ESMTPS id 4Y12R75sdNz1y1V;
 Sat, 30 Nov 2024 20:56:51 +0000 (UTC)
Received: from tachyon.qrv-systems.net
 (ip-095-222-025-162.um34.pools.vodafone-ip.de [95.222.25.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.vodafone.de (Postfix) with ESMTPSA id 4Y12R03Tsxz924J;
 Sat, 30 Nov 2024 20:56:41 +0000 (UTC)
Received: by tachyon.qrv-systems.net (Postfix, from userid 516)
 id ED4A32E01AC; Sat, 30 Nov 2024 21:56:40 +0100 (CET)
From: Yuri Zaporozhets <yuriz@qrv-systems.net>
To: u-boot@lists.denx.de
Cc: Yuri Zaporozhets <yuriz@qrv-systems.net>
Subject: [PATCH] bios_emulator: fix incorrect printing of address in "call
 near immediate"
Date: Sat, 30 Nov 2024 21:56:25 +0100
Message-Id: <20241130205625.24668-1-yuriz@qrv-systems.net>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-purgate-type: clean
X-purgate: clean
X-purgate-size: 1189
X-purgate-ID: 155817::1733000207-31790462-49501709/0/0
X-Mailman-Approved-At: Sun, 01 Dec 2024 04:06:04 +0100
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

In the x86emuOp_call_near_IMM() function the address of CALL is
printed incorrectly when jumping backwards. For example, the correct
disassemble of the bytes below would be:

0000E8DE  E8DBFF            call 0xe8bc

(verified by ndisasm). But instead the address is printed as "ffffe8bc".
That's because of the following macro:

    DECODE_PRINTF2("%04x\n", ip);

while it should be

    DECODE_PRINTF2("%04x\n", (u16)ip);

Signed-off-by: Yuri Zaporozhets <yuriz@qrv-systems.net>
---
 drivers/bios_emulator/x86emu/ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bios_emulator/x86emu/ops.c b/drivers/bios_emulator/x86emu/ops.c
index 57422ec3d4..31b52df9bf 100644
--- a/drivers/bios_emulator/x86emu/ops.c
+++ b/drivers/bios_emulator/x86emu/ops.c
@@ -4200,7 +4200,7 @@ void x86emuOp_call_near_IMM(u8 X86EMU_UNUSED(op1))
 	DECODE_PRINTF("CALL\t");
 	ip = (s16) fetch_word_imm();
 	ip += (s16) M.x86.R_IP;	   /* CHECK SIGN */
-	DECODE_PRINTF2("%04x\n", ip);
+	DECODE_PRINTF2("%04x\n", (u16)ip);
 	CALL_TRACE(M.x86.saved_cs, M.x86.saved_ip, M.x86.R_CS, ip, "");
     TRACE_AND_STEP();
     push_word(M.x86.R_IP);
-- 
2.39.5

