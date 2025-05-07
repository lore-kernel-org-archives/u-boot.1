Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A50C3ABC0
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 12:23:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56E9B820EB;
	Wed,  7 May 2025 14:23:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="bqtSOj+K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90EB18212F; Wed,  7 May 2025 14:23:49 +0200 (CEST)
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk
 [78.40.148.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32E2B81F32
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 14:23:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=codethink.co.uk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=srv_ts003@codethink.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8eRWJDmZCgW+LCbN5D8hOQNPTMZgOfUtWdpn2PNSH38=; b=bqtSOj+KfhC35bKWFkq9bZ3l6N
 8u0iSZXHo5vLndFScaJ8y8FKgz+JakaEWNhbEjPC/61qStBl1ELSUxIcTucfc0FCD9W7KbzGygOKg
 8A7VIhQVoSeLVYdP/bblm1g7+7NS8ceAilmupXNTUOkrYDEcQODOCHnUEdosDqx5geEnfGMp1cQx2
 2Yx3zApTKIRWYtY4TgU3utVA5ZAYMXU0pAySQjLrD79P6NuJgmoG/jZtrw/dSLzEvFuUrw+59hO5X
 Ht9lYqYGFZhvxoJxVtCXaT9NlCTjZy3MqyVvUEcNh0hbpjhUcp/FKalbzXGMiUGG5DHqfK/9qpJXf
 Bbe73d7w==;
Received: from [167.98.27.226] (helo=rainbowdash)
 by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1uCdoN-009Yr3-3i; Wed, 07 May 2025 13:23:43 +0100
Received: from ben by rainbowdash with local (Exim 4.98.2)
 (envelope-from <ben@rainbowdash>) id 1uCdoM-000000024o8-3ULc;
 Wed, 07 May 2025 13:23:42 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: trini@konsulko.com,
	u-boot@lists.denx.de
Cc: nazar.kazakov@codethink.co.uk, javier.jardon@codethink.co.uk,
 Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] common: add config for board_init() call
Date: Wed,  7 May 2025 13:23:42 +0100
Message-Id: <20250507122342.495127-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
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

Add CONFIG_BOARD_INIT to specifu if the board_init() needs calling
during initcall phase, and default it to 'y' for the relevant
architectures which probably need it.

This allows anyone with a board that doesn't need it to just remove
it from the initcall list w/o an empty code block in the board init
file.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 common/Kconfig   | 7 +++++++
 common/board_r.c | 3 +--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/common/Kconfig b/common/Kconfig
index be517b80eb5..17539079f90 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -727,6 +727,13 @@ config BOARD_EARLY_INIT_R
 	  relocation. With this option, U-Boot calls board_early_init_r()
 	  in the post-relocation init sequence.
 
+config BOARD_INIT
+	bool "Call board-specific init board_init() during init-calls"
+	default y if ARM || RISCV || SANDBOX
+	help
+	  Some boards need an board_init() function called during the initcall
+	  phase of startup.
+
 config BOARD_POSTCLK_INIT
 	bool "Call board_postclk_init"
 	help
diff --git a/common/board_r.c b/common/board_r.c
index b90a4d9ff69..65ff5fb595c 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -649,8 +649,7 @@ static void initcall_run_r(void)
 #if CONFIG_IS_ENABLED(ADDR_MAP)
 	INITCALL(init_addr_map);
 #endif
-#if CONFIG_IS_ENABLED(ARM) || CONFIG_IS_ENABLED(RISCV) || \
-    CONFIG_IS_ENABLED(SANDBOX)
+#if CONFIG_IS_ENABLED(BOARD_INIT)
 	INITCALL(board_init);	/* Setup chipselects */
 #endif
 	/*
-- 
2.37.2.352.g3c44437643

