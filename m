Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEBB9E7716A
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 15:18:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A40E8800AB;
	Sun, 15 Dec 2024 16:18:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="blXj0R6v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BE2180040; Sun, 15 Dec 2024 16:18:28 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7E408004F
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 16:18:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+j.ne.posteo.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id A37B1A40A93;
 Sun, 15 Dec 2024 15:16:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42694C4CEDF;
 Sun, 15 Dec 2024 15:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1734275904;
 bh=1N1RNmS2tMHeCvLbVbewftjSBLgtRQPP8PNnZaXYS2Y=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=blXj0R6vLTvh0N6dLAp3LwEu2x/L6K0TYgyr2sotl7pZsu0HuXNYM9TxZRQ8+YCu9
 9Y6Fd5964rhVhq8aW+x4LsbUFZ78336HksNeN/L70AZWQpFd8rWj2GEOtAgFsNMSIU
 TK8vJXufI0OGYvVRseU3WfNYXkIBImjK8PrmiPSqeGKFFWD596U1Y7jcvlhgBz7tZ7
 /vR4gnzwsYdfO5v9cuavlhkd4Yac1HghnkgMQiHajSD2bxqpUk1zaRXzHpvbrQlHgV
 pgPQ5U39qISGLAUUhQ8XmkR6I8jMK+l3dY4Q8ewumxRhvnGPs/CQ6/XRZ0hmCeM9cy
 Yhghi2zHyWf4Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3FFE77186;
 Sun, 15 Dec 2024 15:18:24 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?=
 <devnull+j.ne.posteo.net@kernel.org>
Date: Sun, 15 Dec 2024 16:18:15 +0100
Subject: [PATCH 3/4] powerpc: mpc83xx: Use defined constant for SPCR[TBEN]
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241215-mpc83xx-misc-v1-3-8cd6daae4f93@posteo.net>
References: <20241215-mpc83xx-misc-v1-0-8cd6daae4f93@posteo.net>
In-Reply-To: <20241215-mpc83xx-misc-v1-0-8cd6daae4f93@posteo.net>
To: Mario Six <mario.six@gdsys.cc>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734275902; l=916;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=kJCUbfAfUkZYqBpxwo4bs9D6hIqE6X1cmBqwutBIAkk=;
 b=5lO0rnYHjYjhu4KCyMhQegxgnI/E9W1mM3XmemGJShLb9Y3bEuwr3Pk+K4c6h3hVOXWe8gYp4
 rEq7R8XMB9NBmYHxbPUD2gu9erlpIbmfcs0SBcfZ2qJvVeyB67Ycig4
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


