Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CEBFE7C4EC
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 19:14:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C5D487572;
	Wed,  4 Oct 2023 21:14:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4849887572; Wed,  4 Oct 2023 21:14:14 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAFAD87528
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 21:14:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb.corp.toradex.com (unknown [201.82.41.210])
 by mail11.truemail.it (Postfix) with ESMTPA id E289C20145;
 Wed,  4 Oct 2023 21:14:06 +0200 (CEST)
From: Francesco Dolcini <francesco@dolcini.it>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: Joao Paulo Goncalves <joao.goncalves@toradex.com>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH] toradex: verdin-imx8mm/imx8mp: Remove bootcmd_mfg
Date: Wed,  4 Oct 2023 16:13:58 -0300
Message-Id: <20231004191358.24488-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
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

From: Joao Paulo Goncalves <joao.goncalves@toradex.com>

The bootcmd_mfg env variable is legacy from IMX downstream u-boot branch
and is not needed on mainline.

Signed-off-by: Joao Paulo Goncalves <joao.goncalves@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 include/configs/verdin-imx8mm.h | 1 -
 include/configs/verdin-imx8mp.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/include/configs/verdin-imx8mm.h b/include/configs/verdin-imx8mm.h
index 8cb1f1aff353..8072d5d503f2 100644
--- a/include/configs/verdin-imx8mm.h
+++ b/include/configs/verdin-imx8mm.h
@@ -37,7 +37,6 @@
 #define CFG_EXTRA_ENV_SETTINGS \
 	BOOTENV \
 	MEM_LAYOUT_ENV_SETTINGS \
-	"bootcmd_mfg=fastboot 0\0" \
 	"boot_file=Image\0" \
 	"boot_script_dhcp=boot.scr\0" \
 	"console=ttymxc0\0" \
diff --git a/include/configs/verdin-imx8mp.h b/include/configs/verdin-imx8mp.h
index 942081ab84d7..5a34f6a9b205 100644
--- a/include/configs/verdin-imx8mp.h
+++ b/include/configs/verdin-imx8mp.h
@@ -46,7 +46,6 @@
 #define CFG_EXTRA_ENV_SETTINGS \
 	BOOTENV \
 	MEM_LAYOUT_ENV_SETTINGS \
-	"bootcmd_mfg=fastboot 0\0" \
 	"boot_file=Image\0" \
 	"boot_scripts=" BOOT_SCRIPT "\0" \
 	"boot_script_dhcp=" BOOT_SCRIPT "\0" \
-- 
2.25.1

