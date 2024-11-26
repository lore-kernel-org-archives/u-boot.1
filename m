Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C74D66BA3
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 01:21:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE68689CA5;
	Wed, 27 Nov 2024 02:21:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=qrv-systems.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5945D89CA5; Wed, 27 Nov 2024 00:30:08 +0100 (CET)
Received: from mr6.vodafonemail.de (mr6.vodafonemail.de [145.253.228.166])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A37E89669
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 00:30:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=qrv-systems.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yuriz@vodafonemail.de
Received: from smtp.vodafone.de (unknown [10.0.0.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by mr6.vodafonemail.de (Postfix) with ESMTPS id 4Xyf1p0rStz1xyV;
 Tue, 26 Nov 2024 23:30:06 +0000 (UTC)
Received: from tachyon.qrv-systems.net
 (ip-095-222-025-162.um34.pools.vodafone-ip.de [95.222.25.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.vodafone.de (Postfix) with ESMTPSA id 4Xyf1f63Qsz8sWf;
 Tue, 26 Nov 2024 23:29:55 +0000 (UTC)
Received: by tachyon.qrv-systems.net (Postfix, from userid 516)
 id 5F3742E01AD; Wed, 27 Nov 2024 00:29:55 +0100 (CET)
From: Yuri Zaporozhets <yuriz@qrv-systems.net>
To: u-boot@lists.denx.de
Cc: Yuri Zaporozhets <yuriz@qrv-systems.net>
Subject: [PATCH] bios_emulator: fix garbled printing of disassembled SET*
 instructions
Date: Wed, 27 Nov 2024 00:29:53 +0100
Message-Id: <20241126232953.20860-1-yuriz@qrv-systems.net>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-purgate-type: clean
X-purgate: clean
X-purgate-size: 1180
X-purgate-ID: 155817::1732663801-A6FFC465-45CAED29/0/0
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

When DEBUG_DECODE_F is enabled in bios_emulator, the printing of
SET{O,NO,B,NB,Z,NZ,BE,NBE,S,NS,P,TP,L,NL,LE,NLE} instructions
is not followed by newline and is, therefore, immediately followed
by the printed address of a new instruction. This garbles the output
and makes it very difficult to read.

This patch adds missing DECODE_PRINTF("\n") calls to print newlines.

Signed-off-by: Yuri Zaporozhets <yuriz@qrv-systems.net>
---
 drivers/bios_emulator/x86emu/ops2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bios_emulator/x86emu/ops2.c b/drivers/bios_emulator/x86emu/ops2.c
index 43270102f7..1ff27b2af9 100644
--- a/drivers/bios_emulator/x86emu/ops2.c
+++ b/drivers/bios_emulator/x86emu/ops2.c
@@ -245,10 +245,12 @@ void x86emuOp2_set_byte(u8 op2)
     FETCH_DECODE_MODRM(mod, rh, rl);
     if (mod < 3) {
 	destoffset = decode_rmXX_address(mod, rl);
+	DECODE_PRINTF("\n");
 	TRACE_AND_STEP();
 	store_data_byte(destoffset, cond ? 0x01 : 0x00);
     } else {			 /* register to register */
 	destreg = DECODE_RM_BYTE_REGISTER(rl);
+	DECODE_PRINTF("\n");
 	TRACE_AND_STEP();
 	*destreg = cond ? 0x01 : 0x00;
     }
-- 
2.39.5

