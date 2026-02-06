Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC2C6EE6B5E
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 20:56:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C97A983C61;
	Fri,  6 Feb 2026 21:55:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=hugovil.com header.i=@hugovil.com header.b="VDFvwiGP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 984D183AAD; Fri,  6 Feb 2026 21:55:49 +0100 (CET)
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B096D83A64
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 21:55:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hugo@hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
 ; s=x;
 h=Subject:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Cc:To
 :From:subject:date:message-id:reply-to;
 bh=SeAEdEmbjsVWm2zACvHH18bXw0q9kHmIbc9jtF1umyc=; b=VDFvwiGPSNBclums+8eDD994nH
 52d32H5F2IFalrmg2xIxzfM4imUcKLQnsAyv85LOAhtXr/3JNHymGTT9nBm+6BP4JlkQ4pNE4gxle
 ehgSJ2f2jxmxYQiaDHlZEk8kMQRhxWRwpmSwH5JejCzrPRSO78S5ydGuAV5IeEssmOQs=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:35962
 helo=pettiford.lan) by mail.hugovil.com with esmtpa (Exim 4.92)
 (envelope-from <hugo@hugovil.com>)
 id 1voSrh-0001FX-IM; Fri, 06 Feb 2026 15:55:45 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: hvilleneuve@dimonoff.com, sbabic@nabladev.com, festevam@gmail.com,
 uboot-imx@nxp.com, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	hugo@hugovil.com
Date: Fri,  6 Feb 2026 15:55:27 -0500
Message-ID: <20260206205537.2906980-5-hugo@hugovil.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206205537.2906980-1-hugo@hugovil.com>
References: <20260206205537.2906980-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: [PATCH 4/6] board: imx8mn_var_som: let clock system enable UART clock
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
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

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Now that the UART driver can enable the required clocks, remove
the hard-coded clock enable.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 board/variscite/imx8mn_var_som/spl.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/board/variscite/imx8mn_var_som/spl.c b/board/variscite/imx8mn_var_som/spl.c
index 01a63c69641..e86bd37544f 100644
--- a/board/variscite/imx8mn_var_som/spl.c
+++ b/board/variscite/imx8mn_var_som/spl.c
@@ -41,13 +41,6 @@ void spl_board_init(void)
 		puts("Failed to find clock node. Check device tree\n");
 }
 
-int board_early_init_f(void)
-{
-	init_uart_clk(3);
-
-	return 0;
-}
-
 void board_init_f(ulong dummy)
 {
 	int ret;
@@ -57,8 +50,6 @@ void board_init_f(ulong dummy)
 
 	arch_cpu_init();
 
-	board_early_init_f();
-
 	timer_init();
 
 	ret = spl_init();
-- 
2.47.3

