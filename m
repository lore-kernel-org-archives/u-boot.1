Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF94ECE58C
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 23:46:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A52F288EAE;
	Tue, 10 Sep 2024 01:45:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="BIT7PKjt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F7B488EA6; Tue, 10 Sep 2024 01:45:52 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C61688BFC
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 01:45:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-160-200.46.114.pool.telefonica.de
 [46.114.160.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 1CBC340DC2; 
 Mon,  9 Sep 2024 23:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1725925549;
 bh=idagWuS1lkccp4FAmLGonRHgYvwPEOwjpvE5wDLuwx0=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=BIT7PKjtub6U1tNUhBOc0+Eq7HriINv+Fdy1Qio5jHwql/4Bvb4nV5vbvrF2aj6sL
 vaFctVRZSl0vrWpxHPE0aKiVX1Kbmz9S53NTTkxnkG0D8YXh/Ey8YjfzYWNrQf0mh8
 pTMy2pRUkydMoN6jT4MWBRzrdCsqYOdGNOa0KlBfmdme7klm/XR5HSGKJ72EhRHLP9
 i+nUXR5hP8YdM0OFZl9vtXtnd2rCMiBsBjFuZq700g6tGYe0V7JtXyqYLmFGdNc9xz
 3Dw3USwJI4dN4K1s1oP1/FaDH9fr9I+VGxKw8Vfl7FoTOR5T7UDgV8/unITjSOUsMU
 imjzpVcs8NjfA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
 Igor Prusov <ivprusov@sberdevices.ru>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/3] cmd: clk: simplify clk command
Date: Tue, 10 Sep 2024 01:45:29 +0200
Message-ID: <20240909234530.27570-3-heinrich.schuchardt@canonical.com>
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

CONFIG_DM is always true.
The clk command is only built if CONFIG_CLK=y.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/clk.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/cmd/clk.c b/cmd/clk.c
index 6fda6efb1ce..2fc834e5549 100644
--- a/cmd/clk.c
+++ b/cmd/clk.c
@@ -4,15 +4,12 @@
  */
 #include <command.h>
 #include <clk.h>
-#if defined(CONFIG_DM) && defined(CONFIG_CLK)
 #include <dm.h>
 #include <dm/device.h>
 #include <dm/root.h>
 #include <dm/device-internal.h>
 #include <linux/clk-provider.h>
-#endif
 
-#if defined(CONFIG_DM) && defined(CONFIG_CLK)
 static void show_clks(struct udevice *dev, int depth, int last_flag)
 {
 	int i, is_last;
@@ -79,13 +76,6 @@ static int soc_clk_dump(void)
 
 	return 0;
 }
-#else
-static int soc_clk_dump(void)
-{
-	puts("Not implemented\n");
-	return 1;
-}
-#endif
 
 static int do_clk_dump(struct cmd_tbl *cmdtp, int flag, int argc,
 		       char *const argv[])
@@ -101,7 +91,6 @@ static int do_clk_dump(struct cmd_tbl *cmdtp, int flag, int argc,
 	return ret;
 }
 
-#if CONFIG_IS_ENABLED(DM) && CONFIG_IS_ENABLED(CLK)
 static int do_clk_setfreq(struct cmd_tbl *cmdtp, int flag, int argc,
 			  char *const argv[])
 {
@@ -131,13 +120,10 @@ static int do_clk_setfreq(struct cmd_tbl *cmdtp, int flag, int argc,
 	printf("set_rate returns %u\n", freq);
 	return 0;
 }
-#endif
 
 static struct cmd_tbl cmd_clk_sub[] = {
 	U_BOOT_CMD_MKENT(dump, 1, 1, do_clk_dump, "", ""),
-#if CONFIG_IS_ENABLED(DM) && CONFIG_IS_ENABLED(CLK)
 	U_BOOT_CMD_MKENT(setfreq, 3, 1, do_clk_setfreq, "", ""),
-#endif
 };
 
 static int do_clk(struct cmd_tbl *cmdtp, int flag, int argc,
-- 
2.45.2

