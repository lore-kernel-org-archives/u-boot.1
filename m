Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A1DC71136
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 13:35:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E031582B70;
	Thu, 12 Jun 2025 15:35:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=hugovil.com header.i=@hugovil.com header.b="yrzmPIMj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DA8E82B7C; Thu, 12 Jun 2025 15:35:27 +0200 (CEST)
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8113828A2
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 15:35:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hugo@hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
 ; s=x;
 h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
 :From:subject:date:message-id:reply-to;
 bh=pnm3w7W5azYjkvK1Wdp6P+D8Lp534ny0xpnixmCWTHw=; b=yrzmPIMjeNd/j0MqzSTAQAPL6E
 tipdi+MtDrX5R7NAJXwgh5juUJrIlm9HB3c72iIsl6PrwBzkMt0TLDijQDkrEsa9OyMTPC+nRU9gq
 qmW0fP6rf3Z3wO0hnMpiDdn0zNmz6uRltoBCN9y0lD5kuMYW4i2JkDQa2NKaKQIB2fcc=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:48270
 helo=pettiford.lan) by mail.hugovil.com with esmtpa (Exim 4.92)
 (envelope-from <hugo@hugovil.com>)
 id 1uPi5R-0007FK-C1; Thu, 12 Jun 2025 09:35:21 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Hugo Villeneuve <hvilleneuve@dimonoff.com>, Tom Rini <trini@konsulko.com>
Cc: hugo@hugovil.com, Fabio Estevam <festevam@gmail.com>, u-boot@lists.denx.de
Date: Thu, 12 Jun 2025 09:35:18 -0400
Message-Id: <20250612133519.764041-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: [PATCH] board: var-som-mx8mn: Fix alloc space exhausted in SPL
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

After enabling some options to support EEPROM read in SPL
(CONFIG_SPL_I2C_EEPROM), the following error appears:

    alloc space exhausted

Increasing SYS_MALLOC_F_LEN from 8kB to 64kB fixes the problem.

But instead of manually increasing the value, adopt method used in
commit ce3f23404c19 ("board: bsh: imx8mn_bsh_smm_s2/s2pro: enlarge
CONFIG_SPL_SYS_MALLOC_F_LEN"):

Dropping CONFIG_SPL_SYS_MALLOC_F_LEN option allows it to be set to the
default value of CONFIG_SYS_MALLOC_F_LEN, which is set by default to 64kB
(0x10000) on i.MX8M platforms.

Suggested-by: Fabio Estevam  <festevam@gmail.com>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 configs/imx8mn_var_som_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/imx8mn_var_som_defconfig b/configs/imx8mn_var_som_defconfig
index 5a9f31b1c2a..0596e33fa04 100644
--- a/configs/imx8mn_var_som_defconfig
+++ b/configs/imx8mn_var_som_defconfig
@@ -17,7 +17,6 @@ CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL_STACK=0x980000
-CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000
 CONFIG_SPL_TEXT_BASE=0x912000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x950000

base-commit: d7c449c3d83a986d61e38d1762433c0607caf5c5
-- 
2.39.5

