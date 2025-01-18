Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B4CC02187
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 04:02:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1C7F80771;
	Sat, 18 Jan 2025 05:02:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="SViOLyTG";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qaCBpzdU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CB9980757; Sat, 18 Jan 2025 05:02:13 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 663048036F
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 05:02:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4YZjbh5s1lz9smf;
 Sat, 18 Jan 2025 05:02:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737172929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UncXETU0kca0ui6qkkgZAstxDMX4YkcXZnSzy7Hs/fc=;
 b=SViOLyTGE+3HQZ6BMSrH5mvRq113RjpbqaW2/604GaLR3tNBo/x9n25b9iWnMSDJQ52w/0
 qZEQ2YARL7QPsorbBOyqjH7ObjGAFq1q/6anYHMOKTs6EwCUyXnB6hOarazSsK3aJrr1k8
 ZBbyFA03zDaMsym91rX0iV5fUjj/JjFWAxxGAP1ROhqfezj8O4pWCTdekvdhjzwXY1a32t
 Bq0PoaSU+IIcSwKjx+oA6R9lP18WYnk8ItZDI1MW7HJxm0EMR2bQ3Fj92Wc9NLAQzuEziL
 d0eylMjCP5PF2VlqTIYkCXxQz7+2JH0A03FYmW3DqObKdv0bg8RSpu2wk2fYxA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737172926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UncXETU0kca0ui6qkkgZAstxDMX4YkcXZnSzy7Hs/fc=;
 b=qaCBpzdU6np7DdRNJbgTCYAQZVn5iauIDaNLkxoDb/JbJbdMvaQTUXTXdE1lKrSTXSp2jM
 Hh6xWmCgG5YTQIm9KMbixlwaHQad9XIfylQvwoPmdSwwBeoV4QWYZPwkOAF1mE8JyjDcCV
 G0eNlYwtjQWGivkoPC0rh6Cvkit7aZBlyzSnEoptvoXdHCNk5/PiJEngZya+v3rI7eKsy6
 /GaoIHWeMoNdc7ISuVfVPKKrvib/DK1fgU4lIW7nj83qhCuxl45ge7PEAgOPleFZHVE29h
 yEzBXPijrJuovVmoQSGtKN1xOsgSY0JMbVLurF7vTrdONLiJozwMMC3Nk4p2Cw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Aaron Williams <awilliams@marvell.com>, Anatolij Gustschin <agust@denx.de>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Nikhil M Jain <n-jain1@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Ronald Wahl <ronald.wahl@legrand.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/8] cyclic: Handle return code from cyclic_register() in demo
 and docs
Date: Sat, 18 Jan 2025 05:00:56 +0100
Message-ID: <20250118040130.74921-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250118040130.74921-1-marek.vasut+renesas@mailbox.org>
References: <20250118040130.74921-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: nbmgmoy3se1tmn63wung9u4qt8u98qox
X-MBO-RS-ID: 3f8cd1743808adc03ad
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

Update the cyclic demo code and documentation to indicate there
is now a return code from cyclic_register().

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Aaron Williams <awilliams@marvell.com>
Cc: Anatolij Gustschin <agust@denx.de>
Cc: Angelo Dureghello <angelo@kernel-space.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>
Cc: Devarsh Thakkar <devarsht@ti.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Michael Polyntsov <michael.polyntsov@iopsys.eu>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Nikhil M Jain <n-jain1@ti.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Ronald Wahl <ronald.wahl@legrand.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefan Roese <sr@denx.de>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 cmd/cyclic.c           | 10 ++++++----
 doc/develop/cyclic.rst |  4 ++--
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/cmd/cyclic.c b/cmd/cyclic.c
index 339dd4a7bce..e98c4a488d6 100644
--- a/cmd/cyclic.c
+++ b/cmd/cyclic.c
@@ -33,8 +33,10 @@ static void cyclic_demo(struct cyclic_info *c)
 static int do_cyclic_demo(struct cmd_tbl *cmdtp, int flag, int argc,
 			  char *const argv[])
 {
+	const char *demo_name = "cyclic_demo";
 	struct cyclic_demo_info *info;
 	uint time_ms;
+	int ret;
 
 	if (argc < 3)
 		return CMD_RET_USAGE;
@@ -49,12 +51,12 @@ static int do_cyclic_demo(struct cmd_tbl *cmdtp, int flag, int argc,
 	info->delay_us = simple_strtoul(argv[2], NULL, 0);
 
 	/* Register demo cyclic function */
-	cyclic_register(&info->cyclic, cyclic_demo, time_ms * 1000, "cyclic_demo");
+	ret = cyclic_register(&info->cyclic, cyclic_demo, time_ms * 1000, demo_name);
 
-	printf("Registered function \"%s\" to be executed all %dms\n",
-	       "cyclic_demo", time_ms);
+	printf("Registered function \"%s\" to be executed all %dms with return code %d\n",
+	       demo_name, time_ms, ret);
 
-	return 0;
+	return ret;
 }
 
 static int do_cyclic_list(struct cmd_tbl *cmdtp, int flag, int argc,
diff --git a/doc/develop/cyclic.rst b/doc/develop/cyclic.rst
index 6f1da6f0d9b..604c0463f8d 100644
--- a/doc/develop/cyclic.rst
+++ b/doc/develop/cyclic.rst
@@ -38,9 +38,9 @@ To register a cyclic function, use something like this::
         /* Initialize donkey ... */
 
         /* Register demo cyclic function */
-        cyclic_register(&donkey->cyclic, cyclic_demo, 10 * 1000, "cyclic_demo");
+        ret = cyclic_register(&donkey->cyclic, cyclic_demo, 10 * 1000, "cyclic_demo");
         
-        return 0;
+        return ret;
     }
 
 This will register the function `cyclic_demo()` to be periodically
-- 
2.45.2

