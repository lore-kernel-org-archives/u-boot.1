Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE116CAC5A7
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 10:49:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EA45800B6;
	Tue, 23 Sep 2025 12:49:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=norik.com header.i=@norik.com header.b="LuSxMWiw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36CC780C93; Tue, 23 Sep 2025 12:49:12 +0200 (CEST)
Received: from cp2.siel.si (cp2.siel.si [46.19.12.180])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D0FB80050
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 12:49:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=primoz.fiser@norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com; 
 s=default;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RCxNl34uob9/zxOT6lwnU4IIBLIG/1k4zeV1MQ2pJYU=; b=LuSxMWiw5sNOK9J7oVkKDVi46B
 9xxcInmGYfHeg1PVQNc0cBgNav8o03Zg56+SkKfvDHnXNjd06GmcrU0ROFG/m6hpUkT7pqBFoLDnh
 v0L2oMVDMz94bOWdkRo+0xINY2BTZOyutOjA2+0E4Cuqi3vCewl3t6drJAotNJ62Kbkpq7GAKMJ0X
 GXo0o/2zNLZTyrBWVKJ6eyBTaMpBo0HQWo60eqL1lOmwqVgSfWyhFhfIQgqDkuxDIZAdrwUWvfE4F
 o73AD4UlxL78iy17m6HhTavfkQqfuXzbG84J86PV2hHvhUgdMrDoayapcIerPUaRC9gHXkQTfoO2l
 wn1D5meg==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:48620
 helo=localhost.localdomain)
 by cp2.siel.si with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98.2) (envelope-from <primoz.fiser@norik.com>)
 id 1v10a6-00000001Dqq-23Da; Tue, 23 Sep 2025 12:49:08 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Mathieu Othacehe <m.othacehe@gmail.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	upstream@lists.phytec.de
Subject: [PATCH] board: phytec: phycore-imx93: Set CONFIG_ETHPRIME to eth0
Date: Tue, 23 Sep 2025 12:49:07 +0200
Message-Id: <20250923104907.1817958-1-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp2.siel.si
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cp2.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cp2.siel.si: primoz.fiser@norik.com
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

Set ethprime to eth0 since FEC interface is considered the primary IF on
phyCORE-i.MX93 SoM based boards. This comes from the fact that the same
bootloader is reused for both carrier boards, that is phyBOARD-Segin and
phyBOARD-Nash which both use different Ethernet PHYs on the EQOS (eth1)
interface and thus eth1 cannot be used as a prime.

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 configs/imx93-phycore_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/imx93-phycore_defconfig b/configs/imx93-phycore_defconfig
index 0acdfd2bf53c..4c952e966d1a 100644
--- a/configs/imx93-phycore_defconfig
+++ b/configs/imx93-phycore_defconfig
@@ -89,7 +89,7 @@ CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_MMC_DEVICE_INDEX=1
 CONFIG_USE_ETHPRIME=y
-CONFIG_ETHPRIME="eth1"
+CONFIG_ETHPRIME="eth0"
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
-- 
2.34.1

