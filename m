Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03ED8CA0EE6
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 05:39:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F121802C1;
	Tue, 19 Aug 2025 07:39:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=norik.com header.i=@norik.com header.b="lQTm1F4S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C7EA80422; Tue, 19 Aug 2025 07:39:45 +0200 (CEST)
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12E968006D
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 07:39:43 +0200 (CEST)
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
 bh=NTZNxsqSWFUwyObWSVJcQorO/Sg30PtZDWVvFIRVUno=; b=lQTm1F4S3z7DMzBt0xNgy098Bu
 oYMbZI0DqO+hS4OjGSdXTjKPhqNB2oxAC+b9WuPgEuQ03iPT0s8p9cXF9Er4hdoqNSrU2C4KMaddG
 RiFs0vrmYP/U5BKvIShS88HVBBH1+l0hLWpUBbL/CWucJloi5bPi9Ewx1qW9v1e04goPWs5M83fBH
 XqIQVcmWvUQY/jcA6P9JpnnEpQeIOM9yaV9OTkkrndDfMSB8mJootEh62fkXo0zI8t2GTKX4noMWh
 X0Hzs24SoLXIC06U65HElmvI4krywrgu2kcmPxVuj3JZuXLSdzSfOlAqNM4CD2WL3twz5hIERZtfT
 KLXAACPw==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:56986
 helo=localhost.localdomain)
 by cpanel.siel.si with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96.2)
 (envelope-from <primoz.fiser@norik.com>) id 1uoF4Q-005L6K-1e;
 Tue, 19 Aug 2025 07:39:42 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Mathieu Othacehe <m.othacehe@gmail.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	upstream@lists.phytec.de
Subject: [PATCH] board: phytec: phycore-imx93: Fix EEPROM bus mismatch in SPL
Date: Tue, 19 Aug 2025 07:39:41 +0200
Message-Id: <20250819053941.908834-1-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
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

Fix PHYTEC EEPROM bus mismatch between SPL and U-Boot proper by enabling
CONFIG_SPL_DM_SEQ_ALIAS=y on phyCORE-i.MX93 boards. This way, both the
SPL and U-Boot proper will respect the device-tree aliases for I2C devs
and use the same I2C bus number for phytec_eeprom_data_setup() function
calls. This makes code less confusing and more robust.

Fixes an issue apparent since commit 79f3e77133bd ("Subtree merge tag
'v6.16-dts' of dts repo [1] into dts/upstream") where SPL would spew the
following error:

  phytec_eeprom_read: i2c EEPROM not found: -110.
  phytec_eeprom_data_setup: EEPROM data init failed

While later in U-Boot proper, EEPROM would be successfully read out.
This happens because Linux device-tree for phyBOARD-Segin-i.MX93 since
aforementioned commit enables I2C bus 2 (lpi2c2 is used for audio codec
and RTC) which breaks SPL I2C bus number ordering and I2C EEPROM bus is
shifted by +1. Now, lets prevent this from happening again by utilizing
device-tree aliases also in the SPL.

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 board/phytec/phycore_imx93/spl.c | 3 +--
 configs/imx93-phycore_defconfig  | 1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/phytec/phycore_imx93/spl.c b/board/phytec/phycore_imx93/spl.c
index 7b5d38d438f2..beaa536c6007 100644
--- a/board/phytec/phycore_imx93/spl.c
+++ b/board/phytec/phycore_imx93/spl.c
@@ -52,8 +52,7 @@ void spl_dram_init(void)
 	int ret;
 	enum phytec_imx93_ddr_eeprom_code ddr_opt = PHYTEC_IMX93_DDR_INVALID;
 
-	/* NOTE: In SPL lpi2c3 is mapped to bus 0 */
-	ret = phytec_eeprom_data_setup(NULL, 0, EEPROM_ADDR);
+	ret = phytec_eeprom_data_setup(NULL, 2, EEPROM_ADDR);
 	if (ret && !IS_ENABLED(CONFIG_PHYCORE_IMX93_RAM_TYPE_FIX))
 		goto out;
 
diff --git a/configs/imx93-phycore_defconfig b/configs/imx93-phycore_defconfig
index 6210be646723..af149128ed41 100644
--- a/configs/imx93-phycore_defconfig
+++ b/configs/imx93-phycore_defconfig
@@ -92,6 +92,7 @@ CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth1"
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_CLK_IMX93=y
 CONFIG_CLK_IMX93=y
 CONFIG_DFU_MMC=y
-- 
2.34.1

