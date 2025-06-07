Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 767C1C5B543
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 11:49:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 897D082B00;
	Sat,  7 Jun 2025 13:49:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="IQFEeMKg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FF5C807B1; Sat,  7 Jun 2025 13:49:32 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8304681F0D
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 13:49:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-175-200.46.114.pool.telefonica.de
 [46.114.175.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 6B3293FAC5; 
 Sat,  7 Jun 2025 11:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1749296970;
 bh=WoMbB2zyn7vWBPYbb5TYuN6gcojieNOF0NTrXFnvlOI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=IQFEeMKghpIW7NRr7hKtFTmVGoofJCSsG1PZvT6Da2U7PrN4mC+X28S6qeE5yJmZP
 WReiAWP7srNi21rzAF4BYgxDbGEDyT/wJ2JcwW3IBiFbcSqusrobNH3YB0KosT1rXd
 /OmTAwhPOik9C73zdMI6OSR0lqxNitxju3g4kT6ynaI8SmFEEOYi1Q7CNI22wK+isr
 D+q6QXdHIpw0qjM0dkr6PJPeoL7UsCqSXtdvZp0t10Sm5K7AkULJ9uMXeuZx9hLhRq
 DvT9X5wIqL95ANB0gxITXQF1omEMnHfBP5n2nxNX0w8MxPky+sHT69YuSh8bEadzYy
 JBsXt0IBtwebg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Mario Six <mario.six@gdsys.cc>,
 Casey Connolly <casey.connolly@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Ying-Chun Liu <paul.liu@linaro.org>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/3] sandbox: fix dram_init()
Date: Sat,  7 Jun 2025 13:49:03 +0200
Message-ID: <20250607114906.209959-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250607114906.209959-1-heinrich.schuchardt@canonical.com>
References: <20250607114906.209959-1-heinrich.schuchardt@canonical.com>
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

dram_init() must not overwrite the value of gd->ram_buf set by
setup_ram_buf() for main U-Boot or board_init_f() for SPL.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 board/sandbox/sandbox.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/sandbox/sandbox.c b/board/sandbox/sandbox.c
index d97945e58fc..43f4edc39e9 100644
--- a/board/sandbox/sandbox.c
+++ b/board/sandbox/sandbox.c
@@ -101,7 +101,6 @@ enum env_location env_get_location(enum env_operation op, int prio)
 
 int dram_init(void)
 {
-	gd->ram_size = CFG_SYS_SDRAM_SIZE;
 	return 0;
 }
 
-- 
2.48.1

