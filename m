Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE0CC3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 08:42:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 919A183A90;
	Thu, 10 Apr 2025 10:41:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=norik.com header.i=@norik.com header.b="JKAyrsvl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C03F283A56; Thu, 10 Apr 2025 10:41:28 +0200 (CEST)
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6C5E83A61
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
 bh=iFljJS+T3Da1LzVzwOzSuePsiVt5WStcZHi0GJB6ME8=; b=JKAyrsvlQ0z9T6Uwl0PEXKZXkJ
 9dqmqK0tva+IPVlIKgpm0vLr53IKrpUDeEU++JcbGw51fd/dTx6CbndYzrJ4bzyxBUYWuXY+5kEF3
 FGS+Y4U9IhdnmKo4SxU2TFrttYtvNKekUW4TZ9WpA/HvszY3o1V5Ecd4IJbWi3VrZlWD437weWiK6
 dGK3o6P5dRH0gr5CHxKDjE93yx1k2qUdVP5gUWydGXQhYNDIqhhz2J2g+EfRLVP5wSqd00cHZxtLR
 4jqo16YJ99G3oSupabL+cUPPI/xRHSQX4xbJttPwkEqyGq5sFesj4DR88lLpMs/16L3lTnhGWgwjU
 jdwwdlGw==;
Received: from [89.212.21.243] (port=54584 helo=localhost.localdomain)
 by cpanel.siel.si with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96.2)
 (envelope-from <primoz.fiser@norik.com>) id 1u2nTQ-0007zv-0t;
 Thu, 10 Apr 2025 10:41:23 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Mathieu Othacehe <m.othacehe@gmail.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, Tom Rini <trini@konsulko.com>
Cc: upstream@lists.phytec.de,
	u-boot@lists.denx.de
Subject: [PATCH 4/6] board: phycore-imx93: env: Add option to disable
 bootenv.txt import
Date: Thu, 10 Apr 2025 10:41:20 +0200
Message-Id: <20250410084122.1010297-5-primoz.fiser@norik.com>
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

Add support for disabling external environment import (bootenv.txt) by
setting the ${no_bootenv} environment variable.

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 board/phytec/phycore_imx93/phycore_imx93.env | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/board/phytec/phycore_imx93/phycore_imx93.env b/board/phytec/phycore_imx93/phycore_imx93.env
index 52c234a4206c..d0694f23269a 100644
--- a/board/phytec/phycore_imx93/phycore_imx93.env
+++ b/board/phytec/phycore_imx93/phycore_imx93.env
@@ -20,8 +20,10 @@ loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
 loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
 mmcboot=
 	echo Booting from mmc ...;
-	if run mmc_load_bootenv; then
-		env import -t ${bootenv_addr_r} ${filesize};
+	if test ${no_bootenv} = 0; then
+		if run mmc_load_bootenv; then
+			env import -t ${bootenv_addr_r} ${filesize};
+		fi;
 	fi;
 	run mmcargs;
 	if run loadfdt; then
@@ -41,8 +43,10 @@ netboot=
 	else
 		setenv get_cmd tftp;
 	fi;
-	if run net_load_bootenv; then
-		env import -t ${bootenv_addr_r} ${filesize};
+	if test ${no_bootenv} = 0; then
+		if run net_load_bootenv; then
+			env import -t ${bootenv_addr_r} ${filesize};
+		fi;
 	fi;
 	${get_cmd} ${loadaddr} ${image};
 	if ${get_cmd} ${fdt_addr_r} ${fdtfile}; then
-- 
2.34.1

