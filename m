Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D3FE77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 10:38:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F8F180379;
	Fri, 20 Dec 2024 11:38:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="t9jKEdeQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FA9B80362; Fri, 20 Dec 2024 11:38:10 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 343E880243
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 11:38:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+j.ne.posteo.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id C2F88A418E3;
 Fri, 20 Dec 2024 10:36:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4891C4CEDC;
 Fri, 20 Dec 2024 10:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1734691084;
 bh=M2HPBPEgay09pfjaAnVuymSGTGcu1AzKyUWo35oiP4k=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=t9jKEdeQtghn2cT9adU4pUrqq8JXWBwcxMIgEknXSR4fVRRoU4yx33N84F+3Mu6gZ
 yE0NfpYyItydxjRwkYWVBw8Tw5jl+lOPG01PGDrvslM5UjVpXuTat85nr9eLe4vk1u
 sIeNBXQPIIKcfdi/KKBidzFuP2zi/acRrKWWtYGAhQw7OfDHLhhYFI8qAMihnwCsAt
 n3fXh6AA9kjoSDuLAD4NpVh+R9TYsqm5Q2zjtZyLwl47I4gISDElhlLCKzAbt7mvqy
 AiRZsnqPYsqFoq8LbiULEw7tLjejnN90TELlsqnz3LrbB20MHxhjd2AIqJG45UTW2Z
 4wGUVJ9P2I0sQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id DC340E7718B;
 Fri, 20 Dec 2024 10:38:04 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?=
 <devnull+j.ne.posteo.net@kernel.org>
Date: Fri, 20 Dec 2024 11:37:53 +0100
Subject: [PATCH v2 3/4] powerpc: mpc83xx: Use defined constant for SPCR[TBEN]
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241220-mpc83xx-misc-v2-3-ff4c17ee5fa4@posteo.net>
References: <20241220-mpc83xx-misc-v2-0-ff4c17ee5fa4@posteo.net>
In-Reply-To: <20241220-mpc83xx-misc-v2-0-ff4c17ee5fa4@posteo.net>
To: Mario Six <mario.six@gdsys.cc>, Tom Rini <trini@konsulko.com>
Cc: Sinan Akman <sinan@writeme.com>, u-boot@lists.denx.de, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734691081; l=962;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=7kGpXJCjypF3RFCuBEXZAHkX1u8EeP42zwcw/fItZn8=;
 b=1Mg2R6++8NebKFkOEgPVZFCLfGohq3fbo7v7DDOi93v8A5XV8WTWKenDTCJm4kEF6xLeZclE1
 mUBUBAJ4mD+BldFeJbcz+o68/T2pxGNDz673tDK37QRWF09Y/LCxNoo
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
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
Reply-To: j.ne@posteo.net
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: "J. Neuschäfer" <j.ne@posteo.net>

To increase readability, use the defined constant instead of specifying
SPCR[TBEN] as a number.

Reviewed-by: Sinan Akman <sinan@writeme.com>
Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
 arch/powerpc/cpu/mpc83xx/interrupts.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/cpu/mpc83xx/interrupts.c b/arch/powerpc/cpu/mpc83xx/interrupts.c
index af517213f176cf59cc82b54dbe5247800a6c40e6..bb37a1332c877951e766a8891687dae3f05b6ef8 100644
--- a/arch/powerpc/cpu/mpc83xx/interrupts.c
+++ b/arch/powerpc/cpu/mpc83xx/interrupts.c
@@ -12,6 +12,7 @@
 #include <asm/global_data.h>
 #include <asm/processor.h>
 #include <asm/ptrace.h>
+#include "initreg/initreg.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -29,7 +30,7 @@ void interrupt_init_cpu (unsigned *decrementer_count)
 
 	/* Enable e300 time base */
 
-	immr->sysconf.spcr |= 0x00400000;
+	immr->sysconf.spcr |= SPCR_TBEN_MASK;
 }
 
 /*

-- 
2.45.2


