Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C8EEE6B60
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 20:56:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4659683CB1;
	Fri,  6 Feb 2026 21:55:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=hugovil.com header.i=@hugovil.com header.b="qeXFgm2H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 707ED83BE1; Fri,  6 Feb 2026 21:55:51 +0100 (CET)
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B5FD83642
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 21:55:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hugo@hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
 ; s=x;
 h=Subject:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Cc:To
 :From:subject:date:message-id:reply-to;
 bh=qSZe+u6+9ZLHriehg3UKTBlNSX7U/+q6X62Nl63M4kQ=; b=qeXFgm2HEgqZXL4B6sEj5VCWJg
 RsmpsFpoocuTziTo3X3rsqsYcr00OKG6/0IOfpi7r5xAj0jwmQXyGmtt9PtPQwLdVvHJ73iibuRCo
 eiZ7wSUlS7hnzFsg19H5ZN9aZ5vbftYKCjjLM1ktJBiRMoP+5+wI/IjHKkYrE3im4M1w=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:35962
 helo=pettiford.lan) by mail.hugovil.com with esmtpa (Exim 4.92)
 (envelope-from <hugo@hugovil.com>)
 id 1voSrj-0001FX-Bu; Fri, 06 Feb 2026 15:55:47 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: hvilleneuve@dimonoff.com, sbabic@nabladev.com, festevam@gmail.com,
 uboot-imx@nxp.com, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	hugo@hugovil.com
Date: Fri,  6 Feb 2026 15:55:29 -0500
Message-ID: <20260206205537.2906980-7-hugo@hugovil.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206205537.2906980-1-hugo@hugovil.com>
References: <20260206205537.2906980-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: [PATCH 6/6] board: imx8mn-var-som: compile SPL-only stuff only in SPL
 build
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

SPL-specific stuff is already in spl.c, so avoid compiling other source
files in SPL build.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 board/variscite/imx8mn_var_som/Makefile         | 4 ++--
 board/variscite/imx8mn_var_som/imx8mn_var_som.c | 4 ----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/board/variscite/imx8mn_var_som/Makefile b/board/variscite/imx8mn_var_som/Makefile
index 36d9c36dd2d..b75661ce271 100644
--- a/board/variscite/imx8mn_var_som/Makefile
+++ b/board/variscite/imx8mn_var_som/Makefile
@@ -4,9 +4,9 @@
 # SPDX-License-Identifier:      GPL-2.0+
 #
 
-obj-y += imx8mn_var_som.o
-
 ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 obj-y += ddr4_timing.o
+else
+obj-y += imx8mn_var_som.o
 endif
diff --git a/board/variscite/imx8mn_var_som/imx8mn_var_som.c b/board/variscite/imx8mn_var_som/imx8mn_var_som.c
index 14aa93c527b..945f389cdd9 100644
--- a/board/variscite/imx8mn_var_som/imx8mn_var_som.c
+++ b/board/variscite/imx8mn_var_som/imx8mn_var_som.c
@@ -49,8 +49,6 @@ int board_mmc_get_env_dev(int devno)
 	return devno;
 }
 
-#if !defined(CONFIG_XPL_BUILD)
-
 #if defined(CONFIG_DISPLAY_BOARDINFO)
 
 static void display_som_infos(struct var_imx8_eeprom_info *info)
@@ -221,5 +219,3 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	return configure_phy_reset_gpios(blob);
 }
 #endif /* CONFIG_OF_BOARD_SETUP */
-
-#endif /* CONFIG_XPL_BUILD */
-- 
2.47.3

