Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC936EE6B60
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 20:56:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E27583C72;
	Fri,  6 Feb 2026 21:55:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=hugovil.com header.i=@hugovil.com header.b="iFkTs/Uy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 608E883C51; Fri,  6 Feb 2026 21:55:50 +0100 (CET)
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77BF483B0B
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 21:55:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hugo@hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
 ; s=x;
 h=Subject:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Cc:To
 :From:subject:date:message-id:reply-to;
 bh=YcHFDHIfQi952cavkKgGV/crXfahhLYq45W0m2fRHzI=; b=iFkTs/UyanZDJqgvK4qDLEeJ0U
 ISLQ8KbOZYjBDZ0QWK4S/SM0/anigfIYUOonGAjtYjXjlvESJ3/oqbxslgkQFl7zftGLq+wVn3ynm
 Zn470R5j5yv1EITN2MFyPl+5+YRMJ4DAISFuJsBZw8SxVFqbFh5thv/QYVFaBN86Gi8c=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:35962
 helo=pettiford.lan) by mail.hugovil.com with esmtpa (Exim 4.92)
 (envelope-from <hugo@hugovil.com>)
 id 1voSri-0001FX-Dz; Fri, 06 Feb 2026 15:55:46 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: hvilleneuve@dimonoff.com, sbabic@nabladev.com, festevam@gmail.com,
 uboot-imx@nxp.com, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	hugo@hugovil.com
Date: Fri,  6 Feb 2026 15:55:28 -0500
Message-ID: <20260206205537.2906980-6-hugo@hugovil.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206205537.2906980-1-hugo@hugovil.com>
References: <20260206205537.2906980-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: [PATCH 5/6] board: imx8mn-var-som: remove unneeded header files
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

Cleanup the file by removing unneeded header files.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 board/variscite/imx8mn_var_som/spl.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/board/variscite/imx8mn_var_som/spl.c b/board/variscite/imx8mn_var_som/spl.c
index e86bd37544f..483e9be400d 100644
--- a/board/variscite/imx8mn_var_som/spl.c
+++ b/board/variscite/imx8mn_var_som/spl.c
@@ -9,12 +9,9 @@
 #include <spl.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/ddr.h>
-#include <asm/arch/imx8mn_pins.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/mach-imx/boot_mode.h>
-#include <asm/mach-imx/gpio.h>
 #include <asm/sections.h>
-#include <dm/device.h>
 #include <dm/uclass.h>
 
 int spl_board_boot_device(enum boot_device boot_dev_spl)
-- 
2.47.3

