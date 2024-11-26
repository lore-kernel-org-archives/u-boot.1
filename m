Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11DD5D66BA5
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 01:21:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D66B896F5;
	Wed, 27 Nov 2024 02:21:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=qrv-systems.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9AFB89562; Tue, 26 Nov 2024 22:59:58 +0100 (CET)
Received: from mr4.vodafonemail.de (mr4.vodafonemail.de [145.253.228.164])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0ECB89372
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 22:59:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=qrv-systems.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yuriz@vodafonemail.de
Received: from smtp.vodafone.de (unknown [10.0.0.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by mr4.vodafonemail.de (Postfix) with ESMTPS id 4Xyc1m2y3Gz1yJS;
 Tue, 26 Nov 2024 21:59:56 +0000 (UTC)
Received: from tachyon.qrv-systems.net
 (ip-095-222-025-162.um34.pools.vodafone-ip.de [95.222.25.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.vodafone.de (Postfix) with ESMTPSA id 4Xyc1d1Tmgz8sWb;
 Tue, 26 Nov 2024 21:59:46 +0000 (UTC)
Received: by tachyon.qrv-systems.net (Postfix, from userid 516)
 id C9D232E01AD; Tue, 26 Nov 2024 22:59:45 +0100 (CET)
From: Yuri Zaporozhets <yuriz@qrv-systems.net>
To: u-boot@lists.denx.de
Cc: Yuri Zaporozhets <yuriz@qrv-systems.net>
Subject: [PATCH] bios_emulator: fix garbled printing of disassembled BSF
 instruction
Date: Tue, 26 Nov 2024 22:59:37 +0100
Message-Id: <20241126215937.15532-1-yuriz@qrv-systems.net>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-purgate-type: clean
X-purgate: clean
X-purgate-size: 1114
X-purgate-ID: 155817::1732658392-0DFFA46F-3B111F56/0/0
X-Mailman-Approved-At: Wed, 27 Nov 2024 02:21:04 +0100
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

When DEBUG_DECODE_F is enabled in bios_emulator, the printing of BSF
instructions is garbled because the '\n' symbol is used instead of
the correct '\t'. Fix that.

Signed-off-by: Yuri Zaporozhets <yuriz@qrv-systems.net>
---
 drivers/bios_emulator/x86emu/ops2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bios_emulator/x86emu/ops2.c b/drivers/bios_emulator/x86emu/ops2.c
index 32fecb3479..43270102f7 100644
--- a/drivers/bios_emulator/x86emu/ops2.c
+++ b/drivers/bios_emulator/x86emu/ops2.c
@@ -1280,7 +1280,7 @@ void x86emuOp2_bsf(u8 X86EMU_UNUSED(op2))
     uint srcoffset;
 
     START_OF_INSTR();
-    DECODE_PRINTF("BSF\n");
+    DECODE_PRINTF("BSF\t");
     FETCH_DECODE_MODRM(mod, rh, rl);
     if (mod < 3) {
 	srcoffset = decode_rmXX_address(mod, rl);
@@ -1341,7 +1341,7 @@ void x86emuOp2_bsr(u8 X86EMU_UNUSED(op2))
     uint srcoffset;
 
     START_OF_INSTR();
-    DECODE_PRINTF("BSF\n");
+    DECODE_PRINTF("BSF\t");
     FETCH_DECODE_MODRM(mod, rh, rl);
     if (mod < 3) {
 	srcoffset = decode_rmXX_address(mod, rl);
-- 
2.39.5

