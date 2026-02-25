Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BFAF357DA
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 07:37:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E768783D8A;
	Wed, 25 Feb 2026 08:37:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Q6YodtWW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69C3C83DCB; Wed, 25 Feb 2026 08:37:15 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FB9E82A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 08:37:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 98CBC403BF; 
 Wed, 25 Feb 2026 07:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1772005033;
 bh=bbLBA7L5YOPGu+/Wnr85J8mrnXSsHmK0Az3Zr9cQFP4=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Q6YodtWW8l5uBne1mNiutu9Lt0o+xeg9CF/6bZ8oq/lc4If+Xq22oRNpypzXyINzx
 7q2c0w6LBSXObtGyi5j2IJUkN3YROje5FUsnVXRWvxIZ8Qch36iAVk75sNoHFq4Fnn
 fSJrjx21UXS6ZFflfRH64E4epZ5dlAawJGFmNNxk6oP4yvAAQUIvLXda+U2kCYWNac
 j2Ma1dFmQcb2gypL+O4Z1DfUvUZf/xVTARKKoDVwFJQQfLdMHUKOEDzsGJo1mP3ckq
 KE6GSs33ZxwpXc1N1SsahySlqUtSMabyAQ0NokW5zuvLit/YXdyCofs6kKzdAH16TX
 R3G0zoBz5KIs9u/N4S5j9axYA7I88LISCXGa1OeuxJ7UEw7Hmhq8Pt0FClXRWGcGaL
 cMXHgVQFsixr/UlAJfKeLuowJdzTVvuayLpDUP5HbPQ7s60J1PCiV5MPI1T0/03M/Y
 urEhqSYoKxulW9f0l9+ZRhU+q6LQbu1usSyaR+UgmOfmxJj1v0rrTBP1ZkAe0gGyzW
 0bRVvujJ7xBiN1vj9AelR15xtNWPFSmZMmhIS0YsWzykZGuOk1d4Hd7KnSV0jnXRF+
 n3ZtatZArOjOar34hv5PBWGMgPzqQGFsZmv+ZrUB0x37KCWo1xODh08GVomJgIxmEF
 uY1gtlPaSApwLO71OER+Garc=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>,
 George Chan <gchan9527@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] boot: don't select non-existent CONFIG_VPL_CRYPTO
Date: Wed, 25 Feb 2026 08:37:11 +0100
Message-ID: <20260225073711.51688-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

Symbol CONFIG_VPL_CRYPTO does not exist.
Don't select it.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 boot/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index e5db165424a..e9c8734ecb5 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -386,7 +386,6 @@ config VPL_FIT_SIGNATURE
 	default y
 	select FIT_SIGNATURE
 	select VPL_FIT
-	select VPL_CRYPTO
 	select VPL_HASH
 	imply VPL_RSA
 	imply VPL_RSA_VERIFY
-- 
2.51.0

