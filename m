Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7677FC3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 08:41:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C817583A71;
	Thu, 10 Apr 2025 10:41:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=norik.com header.i=@norik.com header.b="G9crX0Xh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4D5883A7A; Thu, 10 Apr 2025 10:41:26 +0200 (CEST)
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C809983A62
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 10:41:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=primoz.fiser@norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com; 
 s=default;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KI613fEmXI2TzrbUIUGjWmPRBZ8TXp7BGl73PPLNCQ4=; b=G9crX0XhQAdgf5Fwc9kRLuYhRY
 8ZTCoV3NgGbmiPWASi/7I1o7dPKjQXlnuN4Yc7mjTnAhynBzfcx1GY24iDLgLOTB8cysSd76i4hMo
 WTkeWG4DS2+qRgETeHk4SQ6lmUeAhi1BWusfenVKkT54zvLDl0f54ZcY1RzZ9aP6Wx3YrMHHWaK/u
 7tSPlLYB9lCnytE3JHLwJRpZCgW3UCu4K9BsMSAWgP12MrUzX89aXBFsQI32eURYC6NfJkvOPy01K
 1a79Y7lhasTR9XElTF9XN5XNRUANhjc8QrbtmhMOQwjP1phby4xNW/EF0sh4JliaFBZOILbVdJ6lq
 PZXVW3WQ==;
Received: from [89.212.21.243] (port=54584 helo=localhost.localdomain)
 by cpanel.siel.si with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96.2)
 (envelope-from <primoz.fiser@norik.com>) id 1u2nTQ-0007zv-14;
 Thu, 10 Apr 2025 10:41:23 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Mathieu Othacehe <m.othacehe@gmail.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, Tom Rini <trini@konsulko.com>
Cc: upstream@lists.phytec.de,
	u-boot@lists.denx.de
Subject: [PATCH 5/6] board: phycore-imx93: env: Move bootcmd from defconfig to
 env
Date: Thu, 10 Apr 2025 10:41:21 +0200
Message-Id: <20250410084122.1010297-6-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250410084122.1010297-1-primoz.fiser@norik.com>
References: <20250410084122.1010297-1-primoz.fiser@norik.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id:
 primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

From: Leonard Anderweit <l.anderweit@phytec.de>

Move the default bootcmd from the defconfig to the board environment in
preparation for RAUC support. No change in functionality.

Signed-off-by: Leonard Anderweit <l.anderweit@phytec.de>
Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 board/phytec/phycore_imx93/phycore_imx93.env | 9 +++++++++
 configs/imx93-phycore_defconfig              | 1 -
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/board/phytec/phycore_imx93/phycore_imx93.env b/board/phytec/phycore_imx93/phycore_imx93.env
index d0694f23269a..3a36597cae84 100644
--- a/board/phytec/phycore_imx93/phycore_imx93.env
+++ b/board/phytec/phycore_imx93/phycore_imx93.env
@@ -2,6 +2,15 @@
 
 #include <env/phytec/overlays.env>
 
+bootcmd=
+	mmc dev ${mmcdev};
+	if mmc rescan; then
+		if run loadimage; then
+			run mmcboot;
+		else
+			run netboot;
+		fi;
+	fi;
 image=Image
 console=ttyLP0
 fdt_addr_r=0x90000000
diff --git a/configs/imx93-phycore_defconfig b/configs/imx93-phycore_defconfig
index cf9800118ac1..e99676d4f62b 100644
--- a/configs/imx93-phycore_defconfig
+++ b/configs/imx93-phycore_defconfig
@@ -35,7 +35,6 @@ CONFIG_REMAKE_ELF=y
 # CONFIG_ANDROID_BOOT_IMAGE is not set
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_BOOTCOMMAND="mmc dev ${mmcdev}; if mmc rescan; then if run loadimage; then run mmcboot; else run netboot; fi; fi;"
 CONFIG_DEFAULT_FDT_FILE="oftree"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
-- 
2.34.1

