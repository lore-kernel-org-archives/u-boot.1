Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F8ACD4F3D
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 16:07:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92EC1847C8;
	Wed, 20 May 2026 18:07:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="GsMefkZ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C92F843B6; Wed, 20 May 2026 18:07:31 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47747847C6
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 18:07:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yann.gautier@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bAkk894Z/9wh2zgEoFA4aWud1TscQvspKiXw3sehEC8pgpeYe5VFZyH8dKabGf+qBSJ3riqfMJZ5Qf6wbOyspx/ZT6RmAolJs/TlVUwneVl5KEg2k7iTbEI2GnIrGXu3NQzCxZ1ciY0yC8T8rWuDaVws0UpL619twGzwCe8ln/6xosbY5kOEU1slF8PeOSXfn8dPLrnpjPV5l6atF01Di0y7umNOnpBm8UyMUG7kmWP6orhh5cbPIvzk9StaIJea8B+/TJrqnAe3yGPSFAiVuVjTaRh9BY9No5ya7cOCrSzM1+RCFv22XkUTZiN+RgCO3H37csoj4dXqvT63icg6Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZqqfm6MRoqNhJSSMa0A3sN625H3xi2OU6khIg+ZBsA=;
 b=CgYn8CFpKeZYU7Lzo6Hz+0Pls8aHeqARp+3cqOjA3zkuV6//TWd2WYgvzNVPbQFAWbWQrVTUNFLxeqXXnKnE0bsbTP52fdR/uB5pQ27X077FOMUD1GU8cQpnl85GQbbgogZbaWPS4l5F/Lox6601fpznJBDLLr6WRgiYlX/tnrwTrAEIdu46E13EdnpbNS8A7awJD6vQzMSnFxAejhGoJSdAly1DJCaHKaSkyBpPI3qaxJSPVmz/8poz0YMuX9auF9/8Je71oFcjgYKU7aRExfFFh2Tb8POpvABpOSFh5GIKvMZO/Nt0w4lzevqQjOxsRsVHaAKK2BqMiXl8K9wbTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZqqfm6MRoqNhJSSMa0A3sN625H3xi2OU6khIg+ZBsA=;
 b=GsMefkZ4RCTtXMOnRq4aGVAOOunow7BnZzn67t7StKDNMzZSC26vg39I62LdhJPLZlO4BIs0SmmX0t6MlkwlpppPA2d1nZSZTi/djBSCeylPn+nENsuIPrUIhtiY4HBQVKZ0aHhEooxT7WNFtT8IicaBpRJo2dm4FKrO8w8MvjuckvYXsyOhJRptQWJcfszR8q9/WJnRFS/dRsuqPknt44LupJ4KpMOgBKNxhYaFtNXhTi1dFr5S/guk9ho2vqu7d30ImcZFVGjqUQj4KVbg4AYw+uFQLCUSYcn9LaQ0fLvBP7NRgItgk11reCH8yt2lyvhPGKtSixikFmoYvaKZ3g==
Received: from AM0PR10CA0014.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::24)
 by AM9PR10MB4087.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 16:07:26 +0000
Received: from AMS1EPF0000008E.eurprd05.prod.outlook.com
 (2603:10a6:208:17c:cafe::e2) by AM0PR10CA0014.outlook.office365.com
 (2603:10a6:208:17c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Wed, 20
 May 2026 16:07:25 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS1EPF0000008E.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 16:07:24 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 20 May
 2026 18:10:53 +0200
Received: from localhost (10.252.1.215) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 20 May
 2026 18:07:23 +0200
From: Yann Gautier <yann.gautier@foss.st.com>
To: <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Yann Gautier
 <yann.gautier@foss.st.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Anshul Dalal <anshuld@ti.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 2/3] configs: stm32mp13: activate watchdog
Date: Wed, 20 May 2026 18:07:14 +0200
Message-ID: <20260520160715.175032-3-yann.gautier@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260520160715.175032-1-yann.gautier@foss.st.com>
References: <20260520160715.175032-1-yann.gautier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.1.215]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000008E:EE_|AM9PR10MB4087:EE_
X-MS-Office365-Filtering-Correlation-Id: 66d1016a-ca02-4464-b3a9-08deb689e1c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: 6uAqpWpyQmd2weVqb4PTTNVISNRagAkyA5xqIF2aohQL4Fm3EUYx+yFOsfm1i2ZVcTml9YCaFpjCbEyo0KcWxSQs8R78Hk/pHBPG0oEE1GqwggQuzskZLcTDrOXCt14NnMsACpD5et2qcmkvGCoh4MdR+94f6mmipF7ihI71Sd6If0DdnLYTFd1/ZVUZlStdxvbsGSy9WE//uTwxJ5A1taltT2QRJQu7qjt3KGDBQ2EUBLYLz2CLVz0FK1jSxGRiCqH/wwKuTCpSevJ9sXiHE8hpfyHE/ndnI76UBr3p+B7c2N0pAVcJsW2srmhwCDr31YijYY9HpeLSrzvgfbWU5CC96Fwa/b2XnIrV1HPNuqUvEUnJW+Qgs64I7LXFYnrRrWN7yhjUi9j6kizJ0CG5jly5dwa8wQDpxfdnOtjCi9coIhknkbrRSlCA7aAHtdu6cn9zgP6ZTBrYM/WWFTBaLYsjgT/4BFpIqhCS6+t6dY6aJz5bjI3NWAQtw38GpLKpASl1++0xwpCew0YKGFYMKqJVNtAxckw1E3cD9/7soR01GNqcghXwQLpamS0RamebyF668n269zxAbcnwprQhzxv7hCXpo7r3ohApBfpvPsSXZ/NSHeGuXGXGEGWFTxXJs1sEciIvt/AqoltSBF9kXH3P17+HKELYDR5jHz0XVsTxmKqWplGyy3V10mooYCXd9EISn5NqnqEDCsvTQkDzzPcYtgKeUFnSpBhCMO5UQmA=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QvJTaaAoEZp3rasjh12jJ0e90aqhvlI+ZXZDN8hlVyl2e87oiE1z/ufkB8HjxhS8jc7MPlqq0ErglLt9F1zvSN9ElfrEFNDwgUvhhVwvyX56FStxRHasrWHArsYHAPfKF5N8iYLk8jKqypDiErzHTCqXwWagyg9BP9eXcs2tjK3jRULfvft23JsZRgipcjiqs8PFtaqQGQXp2726xQ3CRBomkg+JAXONi4QyEkLRN0QG7wWkjVqZlXcr0EslBsCGX9F4Y9ZmQTGd2MhsgzBQn0m52zQIoFl/Bm7/UvEELUA32q5UopR2M1k+/kerv6uQndbycYk1kCLGWl/iu65EQRXCGbXM37XzMaaN7IzAgV2Be+qUd2k47yedv+6FghOYCbm9KBRDi5+6eC30lu6aMgmHCAjz/zSg3YFxKxE88B7v8yq/1cCpS9cqMHT4Obi8
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 16:07:24.7022 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d1016a-ca02-4464-b3a9-08deb689e1c6
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000008E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4087
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

No watchdog was enabled for STM32MP13 platform. Add the required flags to
support it. As done for STM32MP15 (in SCMI config) and STM32MP2x, we use
the Arm SMC watchdog. The required nodes were already present in Linux
imported DT files (stm32mp13.dtsi & stm32mp135f-dk.dts).
To enable this SMC watchdog on other platforms based on STM32MP13, check
that both the following flags are enabled in the dedicated config file:
CONFIG_WDT=y
CONFIG_WDT_ARM_SMC=y
And that there is a node in Linux board DT that enables the feature, as
it is done in stm32mp135f-dk.dts:
&arm_wdt {
	timeout-sec = <32>;
	status = "okay";
};

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>

---

Changes in v3:
- remove CONFIG_WDT_STM32MP
- update commit message

Changes in v2:
- update commit message

 configs/stm32mp13_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/stm32mp13_defconfig b/configs/stm32mp13_defconfig
index 620a6da2efe3..2ad57e23e445 100644
--- a/configs/stm32mp13_defconfig
+++ b/configs/stm32mp13_defconfig
@@ -113,4 +113,6 @@ CONFIG_USB_GADGET_MANUFACTURER="STMicroelectronics"
 CONFIG_USB_GADGET_VENDOR_NUM=0x0483
 CONFIG_USB_GADGET_PRODUCT_NUM=0x5720
 CONFIG_USB_GADGET_DWC2_OTG=y
+CONFIG_WDT=y
+CONFIG_WDT_ARM_SMC=y
 CONFIG_ERRNO_STR=y
-- 
2.34.1

