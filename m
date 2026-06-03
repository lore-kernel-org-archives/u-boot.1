Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC9CCD6E55
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 06:20:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A572584855;
	Wed,  3 Jun 2026 08:19:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="DxUa5+f0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9471984857; Wed,  3 Jun 2026 08:19:58 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97A7983EF9
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 08:19:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZY0rxULmXychL+dt2n09KCUzwJHYMKJsL56U5M/nTsS5Udx9a6mDFPMG5yJaqlht7LvgFlsEQai23tL/3cxUcym01hLbgEDpEeYt/TJ8dsDEJrS6h7SN1uOTG7CMmwxX5APWn2dlExrHX4adJAwD6knha/MFHgCYhbsLMmQuTLbtaAv1LWHZGfOTkuaKIskFWUrPtG/OeXoVo1TzQTSEdYv2s8xeUOZmQnsM9rWf2lP95vytBi1jGe8XjO20+f7JZwBvX9k4nkfDeV2lY0tPAPBjZ2mGZtjTavjx8qA07e7dcpsDTefHQTCOZjJboCjBEX8ATidMbWWQqJufufPebA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rDLPsLua0pNf0x+oemFfcRG8ASZmMtrpBhXBYJOHII=;
 b=jfxIFRv+4u9MvCbVbFMbaxCk3V4s6O03JAtAJL/CffEmlwcmnwGn9k1GHVRYXVc3NZhv2rtz8d2nQ5UFcHSPdr30NQj0QzfnvnBW1qnAPGnKOBAS0ZE05Xq8xE8BsKaaKiAd+67J6NyQYzISn0Q6wxQh31KSjbw3X/JgpqSVXcgU7CYVweu9L/5hWdYv1R6c8bp4OKIY8vic6X90lmDKxJOD4MZq2rUg2fygbaoXPeOHqhREhFLgPqPmlc2Ke7QQrhxDrtIpp4BrS2r/VYNBHt30mYzc+8Mc+YLheiKTjW4xWDuivHMyW1Wyx9JL0ojJiu6aq1aQaJnZ4scpP2pYzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rDLPsLua0pNf0x+oemFfcRG8ASZmMtrpBhXBYJOHII=;
 b=DxUa5+f0XEonV0IEB+OPnvCQnCZyVB5PBceWA1T56KpwYY8ieB8p4wbcG1mtwwtSrXKIDjFztVS3kfyldhgRq6qSpD9k2stEWnXx3tqfki9/21lvZiFtUBja9N1jSqhCyHDSfGqOv4Z6Br2DarvnE4UByj5PJLDdVqOdHLqd5EzRe7BhUHAEX0K5QqQigwJFd5M6AJa2lE9c5FYIhfjB2su7aJE/6Vl6l4V9ziZmJDErEdS+q/cz8e1hisOF0GCa5LPlZn0dgzjsZk0vhoWLAQdM9VVgBbrIg5DwPs2nSV/qJ+85X9zVq6OZW+DiJsNO5qJwRUXVJWCxsc+bUN5Y3w==
Received: from DU2PR04CA0314.eurprd04.prod.outlook.com (2603:10a6:10:2b5::19)
 by AMBP195MB3199.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:6f2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 06:19:53 +0000
Received: from DB1PEPF000509E3.eurprd03.prod.outlook.com
 (2603:10a6:10:2b5:cafe::38) by DU2PR04CA0314.outlook.office365.com
 (2603:10a6:10:2b5::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 06:19:53 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DB1PEPF000509E3.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 3 Jun 2026 06:19:53 +0000
Received: from phytec.de (172.25.0.51) by Postix.phytec.de (172.25.0.11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 3 Jun
 2026 08:19:53 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <marek.vasut+renesas@mailbox.org>,
 <u-kumar1@ti.com>, <peng.fan@nxp.com>
Subject: [PATCH] configs: phycore_am62x_a53_defconfig: Enable fastboot
Date: Wed, 3 Jun 2026 08:19:46 +0200
Message-ID: <20260603061946.3078750-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E3:EE_|AMBP195MB3199:EE_
X-MS-Office365-Filtering-Correlation-Id: 909bc9f2-bc15-47c4-5151-08dec1382044
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|56012099006|11063799006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: fYQ/sIecD4IVwJe9BQEUxSyEvQEL2vYT6uZKORi4VOHHlBSmv01zDUGNZGWMx7Lxw0g2ndMADtZlAOHEdJND+p09IOnvpbW5QvMenDjsnDIyxk960CeWY4ISYrUjZmZ6Jfsb3YJ5d8a4E/ledoPq2x75fb6mNRkUGnbrYtEre2RlsFVW6FfZ3FR8KEfT0U3hFSmeQrn2Ld9YSRSmzpE21QcnE3tgWfnea8HfagRhgh/zoRjiMsDAEir3pQWZup4CBE7XbN62RgSEhhVOw8Jz1ORrbXYPz1fh8FyfpqnNxhfrSHSuMWpqTbkUYxN1I1Wtw5XeLSFnJMgdQFymGSfPgSKCEvLcqBctV+nFhJ2VZmdP/MEYoD+xvvTP9/VBBGYw57gEIagAQh98Eb3KGsrPWguEaEbGF9y5Mx6pSk2Koh8eDa8lLnhPYYOkslwZBH+/7/nMS73qSFdhVgGKW2fsMOklOLPphWZBWclvDqN4u0gfq3xz53x19bnF6Reg9rhXnw1SAK+8dQpr32Oorz2OPWkCDnWdSF0CAdJaGikWVudig5aWmyL+7sMUS4/1poY8htS0zY+k1fHxEN1LPNzCItziMPm75t9HijiL6dmHyWtaBAgGOupwp026cLF8GfeKHccC4Qfo/9oUoZjAxUB8JBHYmMiu8ASGMnsLHZpCet+DtlVXT6sJwi6UaN+FJU3lIQKNvw/GMkZ2/X/27BYC9sjXQBHi4ZvUJu+U2l1iuKs=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099006)(11063799006)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: a0b9sPS2lTcn8r38rgOh71YrXwoZHEJiDaw6C/qbyJIb50tFnXzZil/ZTlQ56R5ikRqaeZulfWwrZg/N7hjDi1xFkntCExBSe51J+mtoFG5jcNYTK7v5qbu6Z40sC5ifPuZ1KEceTg3Rfv0/IeEPt6BE3OzPwsJocQLOwuhQm1l7DD213a0GiZuCKOCTKNn+lY+BAk81OJPn3I2wTECeG79OQDLKZdMy33yIt46y1dwKGDQsWd5PISCg7wSiSRdIe5/wVtZ6Bp6JGCbZEFov5LDsHtyRSVl4A4b273yzp4cdwI8iDO4COrfeoVUIm7m5AAn88akt2sBHDZ5YAc3YhkWyNl4mR0kcHbwyGqVXt5DuGa0X19sug56qYMrajBq/hjGjGv2opBkd9JwGnICr5a3dwBbPsApdodV71lIDBfSj4SImktZyK1MF8UXFo7v3
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 06:19:53.6163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 909bc9f2-bc15-47c4-5151-08dec1382044
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E3.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBP195MB3199
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

Enable USB fastboot support for downloading and flashing images via
the fastboot protocol.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 configs/phycore_am62x_a53_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configs/phycore_am62x_a53_defconfig b/configs/phycore_am62x_a53_defconfig
index e990d556531..ddf53b481cd 100644
--- a/configs/phycore_am62x_a53_defconfig
+++ b/configs/phycore_am62x_a53_defconfig
@@ -108,6 +108,9 @@ CONFIG_SYS_DFU_DATA_BUF_SIZE=0x40000
 CONFIG_SYS_DFU_MAX_FILE_SIZE=0x800000
 CONFIG_DMA_CHANNELS=y
 CONFIG_TI_K3_NAVSS_UDMA=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0xC0000000
+CONFIG_FASTBOOT_BUF_SIZE=0x2F000000
 CONFIG_TI_SCI_PROTOCOL=y
 CONFIG_DA8XX_GPIO=y
 CONFIG_DM_I2C=y
@@ -169,7 +172,6 @@ CONFIG_SPL_USB_GADGET=y
 CONFIG_USB_GADGET_MANUFACTURER="PHYTEC"
 CONFIG_USB_GADGET_VENDOR_NUM=0x0451
 CONFIG_USB_GADGET_PRODUCT_NUM=0x6165
-CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_SPL_DFU=y
 # CONFIG_WATCHDOG is not set
 # CONFIG_WATCHDOG_AUTOSTART is not set
-- 
2.48.1

