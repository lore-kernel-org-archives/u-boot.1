Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0146E7717F
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 15:18:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62937800B2;
	Sun, 15 Dec 2024 16:18:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SO2eFHit";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A191480050; Sun, 15 Dec 2024 16:18:30 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E327480066
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 16:18:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+j.ne.posteo.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 3A7475C5A86;
 Sun, 15 Dec 2024 15:17:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2AB35C4CEDE;
 Sun, 15 Dec 2024 15:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1734275904;
 bh=5VnWXTdx3EXnxhD+9eqa01AErWsAI47rGaC61/pfnDI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=SO2eFHitAh9dxFLgEFyXRw37NYy9cizcsKpjhTihV1mmXl+mfBugfcjI2okAJw9B4
 +GP59n46N09zWz+oFwN6Rn3aw1DU2JfXWx3KXSkZbJBaGQnj9toN2GOOIbzbwRRsEQ
 7OJRyutL6W2ztIEi5MUaiLSB0v+S6Uo7ErsJZqCPw5n/S72NKxLm3UKla93d1wPFy9
 okTk4/MqTNNMFbdWu7yVVKW0t79GK6sjh2PTwnT/9lQvXhBIFShwLkd77QHtsqYEvP
 vb4vlBv67AzDWDolQj3BckJY0+dnPBv/QlzpGBB/liVAVkelq4IpGusxn2dCxIJ6TM
 cccJEjXNTfOfg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0F2E7717F;
 Sun, 15 Dec 2024 15:18:24 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?=
 <devnull+j.ne.posteo.net@kernel.org>
Date: Sun, 15 Dec 2024 16:18:13 +0100
Subject: [PATCH 1/4] powerpc: mpc83xx: Fix timer value calculation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241215-mpc83xx-misc-v1-1-8cd6daae4f93@posteo.net>
References: <20241215-mpc83xx-misc-v1-0-8cd6daae4f93@posteo.net>
In-Reply-To: <20241215-mpc83xx-misc-v1-0-8cd6daae4f93@posteo.net>
To: Mario Six <mario.six@gdsys.cc>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734275902; l=837;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=X9I83qjkwkleJkwazR2W4ooKJgiVatQiN8xaQIBDfgo=;
 b=GKD8LbwRRMHwlkJsL9id0NJ6Z+lbW42sUKkiduEG3JgLuEBdCi4xHVW/bTTw0PTdOoVgn6HjW
 NQf7XVkoOS8A9eMAOiKk6Du8rJRkhXhkoEqtXoq2mhZluxIMhUkA6J7
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

TBU and TBL are specified as two 32-bit registers that form a 64-bit
value, but the calculation only shifted TBU by 16 bits.

Fix this by actually shifting 32 bits.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
 drivers/timer/mpc83xx_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/timer/mpc83xx_timer.c b/drivers/timer/mpc83xx_timer.c
index 9da74479aaa678bfab861950a770b216b604c433..f92009e4ccc8256d4c5f4d11e414dfc141f5a043 100644
--- a/drivers/timer/mpc83xx_timer.c
+++ b/drivers/timer/mpc83xx_timer.c
@@ -206,7 +206,7 @@ static u64 mpc83xx_timer_get_count(struct udevice *dev)
 		tbl = mftb();
 	} while (tbu != mftbu());
 
-	return (tbu * 0x10000ULL) + tbl;
+	return (uint64_t)tbu << 32 | tbl;
 }
 
 static int mpc83xx_timer_probe(struct udevice *dev)

-- 
2.45.2


