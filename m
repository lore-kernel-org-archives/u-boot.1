Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D297C4829A
	for <u-boot@archiver.kernel.org>; Sun, 11 Feb 2024 20:38:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A054878C6;
	Sun, 11 Feb 2024 21:38:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=t-8ch.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=t-8ch.de header.i=@t-8ch.de header.b="galUaUW0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9910F8798F; Sun, 11 Feb 2024 21:18:45 +0100 (CET)
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B22658785A
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 21:18:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=t-8ch.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=thomas@t-8ch.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
 t=1707682722; bh=citqXSm4WoqenG000b5IRA17Ql5+iOqnmVjdDIQmi8Y=;
 h=From:Date:Subject:To:Cc:From;
 b=galUaUW0ZCjTsuTdEXTWAIfyn51HlQYkTST453ewfpf6xBx7J+BOgTk/I5s0ruYJg
 h5yeaFLADlu4Zv7cBOsmBtkYXxstO7tccLF2osFG4RiAaY8p0XY5R0MjyWgrciwIeA
 +kB97ymuQHHpevkGKq0QfAD8O900DeKJEUwO7wek=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Date: Sun, 11 Feb 2024 21:18:41 +0100
Subject: [PATCH] doc: fix mistyped "env flags" command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240211-doc-flsgs-v1-1-c1c71f88933e@t-8ch.de>
X-B4-Tracking: v=1; b=H4sIAKAryWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDI0ND3ZT8ZN20nOL0Yl1jw5TElJQkQ0uL1GQloPqCotS0zAqwWdGxtbU
 AuocG0VsAAAA=
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707682722; l=582;
 i=thomas@t-8ch.de; s=20221212; h=from:subject:message-id;
 bh=citqXSm4WoqenG000b5IRA17Ql5+iOqnmVjdDIQmi8Y=;
 b=DO3kw3+q0P/sfsY8FBtOhT+OFiN4SdMgHdtC8rGCVyoXjtG9G4ThYk6U//+thRR/OS0IsLEbk
 huTLoSqTWMVAgOexZTJYzJ2zH+rTafoI2YTHcQxgJD6u3hdiDjhN2uX
X-Developer-Key: i=thomas@t-8ch.de; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Mailman-Approved-At: Sun, 11 Feb 2024 21:38:31 +0100
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

Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
---
 doc/usage/cmd/env.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/usage/cmd/env.rst b/doc/usage/cmd/env.rst
index a859e32798cb..a7e21693a672 100644
--- a/doc/usage/cmd/env.rst
+++ b/doc/usage/cmd/env.rst
@@ -350,7 +350,7 @@ edit
 exists
     CONFIG_CMD_ENV_EXISTS
 
-flsgs
+flags
     CONFIG_CMD_ENV_FLAGS
 
 erase

---
base-commit: d7aaaf4223d0a2f9f8c9eed47d7431860b3116d8
change-id: 20240211-doc-flsgs-31daddb198ec

Best regards,
-- 
Thomas Weißschuh <thomas@t-8ch.de>

