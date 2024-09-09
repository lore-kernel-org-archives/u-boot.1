Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E9AFECE58E
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 23:46:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E0D288EA1;
	Tue, 10 Sep 2024 01:45:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="fiE24vkH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D476B88E42; Tue, 10 Sep 2024 01:45:51 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ECC088E93
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 01:45:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-160-200.46.114.pool.telefonica.de
 [46.114.160.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 64B8D40DC0; 
 Mon,  9 Sep 2024 23:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1725925548;
 bh=EVFPQP1Q7kG0gKLPZuJqJf6ke4HGggYLLRPgbm5Hpd8=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=fiE24vkHwUcii7I2P030XNQnaVjzUbuMaA/KVT7RCMAsKtZkhK7Oq1Lf8z0OpNgGb
 C4PoY/b3E/q8W9yPcRYllNMGM7gEoQosUApkk+D8SsMSvmemxm2zuQeSV5lKjKZOrR
 QhpiGaHHTKOnGyR0FxwAxG/dydDG6ZV6n3pCB1TyOIZ++736Ox2jtHxwLXcIToQp4M
 iD5Tb4DNDFXXUhvseL0vsR/m+bW00Lrmh/Ihuy7LKv+mLGWuzByev288N/g0buLidU
 WUdcP4P84T4RCx9rBq7qKzPbYwf9XBJTphfr5+Hymrz4el0OgZ9OOPfiAInYkvbEN8
 3wzycHWfy2yCg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
 Igor Prusov <ivprusov@sberdevices.ru>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/3] cmd/Kconfig: CONFIG_CMD_CLK should depend on CONFIG_CLK
Date: Tue, 10 Sep 2024 01:45:28 +0200
Message-ID: <20240909234530.27570-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240909234530.27570-1-heinrich.schuchardt@canonical.com>
References: <20240909234530.27570-1-heinrich.schuchardt@canonical.com>
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

The clk command cannot provide useful output without a clock driver.
So let it depend on CONFIG_CLK.

Since commit 258c1002383e ("cmd: clk: Use dump function from clk_ops")
the remark about deprecation is obsolete. Remove it.

Since commit 7ab418fbe612 ("clk: add support for setting clk rate from
cmdline") the clk command can be used to set clock frequencies. Mention
it.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/Kconfig | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 43f78a5aeb1..f1ab7c2cb92 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1084,13 +1084,10 @@ config CMD_BIND
 	  gadget driver from the command line.
 
 config CMD_CLK
-	bool "clk - Show clock frequencies"
+	bool "clk - Show and set clock frequencies"
+	depends on CLK
 	help
-	  (deprecated)
-	  Shows clock frequences by calling a sock_clk_dump() hook function.
-	  This is depreated in favour of using the CLK uclass and accessing
-	  clock values from associated drivers. However currently no command
-	  exists for this.
+	  Show and set clock frequencies managed by CLK uclass drivers.
 
 config CMD_DEMO
 	bool "demo - Demonstration commands for driver model"
-- 
2.45.2

