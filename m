Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB29CD4F5E
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 14:18:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F69684851;
	Tue, 19 May 2026 16:17:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="S6qGkGo1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9DA48484D; Tue, 19 May 2026 16:17:58 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2EAA8484D
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 16:17:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-jain1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QSAMG1KNmx59bkrNE1qN0FjpBqXUGGDNMqphuxBtK/z1jKx7v+1crlxQKoYnuEbQAUiUmV6RU/MiOOFDla62+0fUzGJ0A+mSfq9NvJXloJW0hQOxWUQjK1D+yeWhEFUJoG4rrX/VkBfX+Tsdetkl8Zxnp90KgbK61/a3ZHYKH36jx9VGXVicoJPv3ozZEQEOEDEvSnx2b6Q0LRiuXfS/zJyd/4ZASB25iNKioVu9Zs+hymHxHThp6yuNDs6FLKIXMnZQx8NRKNVq6WVnbHcwd2MkQgC2rXcKFovwrta0xg+VDhHDtkn5E6mJGATFkJC7vRwOydJ3xu/od5XS5f8ajQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2RNywfabc+bWI52jhVWnD2n/zkI53sHVmzaapNN39g=;
 b=gFW9kcNBPWXu1M8MUn/oglCEnIggrvE10Qe/vX48OgDza0ZvBEm9guXMCTTLvj8dKUi1rl/Z21mXZBKitdj318SMypiRT/W8mkXZP3+NB1bO/euTTe/wh25IZpTPJab4dxZQgNC7p8nEQzlf4WgXkdyi7Gyhnh7lSSQHoK/CW3h48bti8EQP7o6TCQ7+Wooa0bJ4OBRdxg7QVNJBFmh8/d0J80mxM8hRVKFWCZ+32Qwdc2b+ldfzcMNKLIuV+TFVsPf1QAmO8Dg44jRukZa8URgxx60tojUGnLyaS91WoWkXUr1efBsBa0Re+9OjxUUVcVm0rfbo6AO+V0H3SbIElQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2RNywfabc+bWI52jhVWnD2n/zkI53sHVmzaapNN39g=;
 b=S6qGkGo103ysmHE61lQZS5F4NzH5ChMYmaonu3sHokwqDNhOxbk1XQphuOqmSsxkeTZyyv3dBTBKqEdeIVDvEsaeL8vFngm5il7sjdQjWBDDQXdTFYZzGeiZZUnhN00TpXWi943ykbXvdm+ia2HbUNr487jtUDalixvVY9ezg1Q=
Received: from SJ0PR05CA0124.namprd05.prod.outlook.com (2603:10b6:a03:33d::9)
 by DM6PR10MB4217.namprd10.prod.outlook.com (2603:10b6:5:218::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 14:17:54 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::8b) by SJ0PR05CA0124.outlook.office365.com
 (2603:10b6:a03:33d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.13 via Frontend Transport; Tue, 19
 May 2026 14:17:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 14:17:52 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 19 May
 2026 09:17:26 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 19 May
 2026 09:17:26 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 19 May 2026 09:17:26 -0500
Received: from a0512632.dhcp.ti.com (a0512632.dhcp.ti.com [172.24.233.20])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64JEHH0S3643846;
 Tue, 19 May 2026 09:17:23 -0500
From: Swamil Jain <s-jain1@ti.com>
To: <bb@ti.com>, <trini@konsulko.com>
CC: <devarsht@ti.com>, <anshuld@ti.com>, <praneeth@ti.com>,
 <n-francis@ti.com>, <s-jain1@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH 2/4] configs: am62x: Add splashscreen prune config fragment
Date: Tue, 19 May 2026 19:47:14 +0530
Message-ID: <20260519141716.1346635-3-s-jain1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260519141716.1346635-1-s-jain1@ti.com>
References: <20260519141716.1346635-1-s-jain1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|DM6PR10MB4217:EE_
X-MS-Office365-Filtering-Correlation-Id: 07d72021-9bf4-4bc8-e4b1-08deb5b16a0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2a89w9jY6Bgb9oZvspivasDfVxfYkea5nsJ+Wb+Gi6E6jXGZsCgSwjNwkwZfJRPI61/P7ut8CquBNJhrN8PuJD/lkDjoVsZgdkG1gJGg0KGiPTp0+/ch4xAkWn28zhONYYGBAERj0l5Gxz4i80AXWAIJRayDELpHi48vNHb1SlPeXwJeaS4xLp+LPkDcgM+7dUO2/QILQWhGc5+eqf4UZ78BgJEqh5d4WTn+bMsW3oGegvrBaOaqeasoQsaYbq94Y+Ep6Hw3fe45L5YplAfoE1r1CUDOcIer9V/dZQ5aHFYA5pylqljk2r+BVCn3hsnqzC5vuoKokmaSTXg172BLIeUl1M/elpKBX7kgQGvydycaAFJjMD4CRyPHqeUKJ4Y+hknLcdYrt3bDKQg5s3mb/HDS88TizH3ivzRZQmMR5kHdEJhc+HoOWKDQy706AayKUmV1ymdHQ6oXTNfIsfMz8BRb5/mO675qM7Z/m/+qfvzKU5v6SkAWelaKiBdRnB+3aYB/diZLxn9ezAC4h1/3IllXtrS6yQ6FfMCuY9oDJaLYuBOfF13dvhLkdpbNhnQei+McC5fWde+4C6unmYmscv+UMG6Fxw/CEvgA8c8RrRxBWUSdnwbF/Tfu0u/mMP/tYXBO3tWr2PN2idlKuJibFQ1i+XGfwEwmgykq6G/WYxpEVfHes5eqd60/s8BUc5DnQWMGHUmesCrSwy4K3sdCsVTkG3QIUiRNGywcpQrSFNU=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JOLSoO4/HPQyxYaP1JmA2lIHTRGwvCrQUrsYvsrc9gOxIBoVHxMyJTnncHLkDO+mq9tzJ2hw9G9ItyK1Ek7oiaylJJs7jFklKYO797evGkg40FthJaZBxKQUJ3am4cAxT6/YKorzrCmQyOp+XdIyvmEvIa+kjaIPmdmFOckZgCCZ2tdP6ZzMukRAMaO488snCHdkXOkGEgBhHCXzxCbrp0bumkeASAghg1unP33HMd8FZOIzPyiRkJ32/ZHd3q9P+Z1Rj6Zzt4hHvObluTH+ABJqJ0GpEtgznALhxojagm/krXszFMY/0ermtXqIzmFVqmnd/785e9Pa9vhq1FYbqUTHXMW8dk6/yD1wbluTbN+7zmZuZCoAPCPSDcogTAyMMtLQH23nujYjMNtqzJiSJjAVPTBVTu5L3LaMg9BtRELNJPu6WYtdfoX1IQsa7agg
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 14:17:52.4828 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d72021-9bf4-4bc8-e4b1-08deb5b16a0a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4217
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

From: Devarsh Thakkar <devarsht@ti.com>

Add config fragment to disable splashscreen. This is especially useful
for platforms such as AM62P as splash needs to be disabled while using
TI-DM firmware with display sharing feature enabled.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
Signed-off-by: Swamil Jain <s-jain1@ti.com>
---
 configs/am62x_evm_prune_splashscreen.config | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 configs/am62x_evm_prune_splashscreen.config

diff --git a/configs/am62x_evm_prune_splashscreen.config b/configs/am62x_evm_prune_splashscreen.config
new file mode 100644
index 00000000000..a92f0f7aad5
--- /dev/null
+++ b/configs/am62x_evm_prune_splashscreen.config
@@ -0,0 +1,16 @@
+CONFIG_FDT_SIMPLEFB=n
+CONFIG_VIDEO=n
+CONFIG_SYS_WHITE_ON_BLACK=n
+CONFIG_SPL_VIDEO_TIDSS=n
+CONFIG_BMP_24BPP=n
+CONFIG_BMP_32BPP=n
+CONFIG_SPL_VIDEO=n
+CONFIG_SPL_SPLASH_SCREEN=n
+CONFIG_SPL_SYS_WHITE_ON_BLACK=n
+CONFIG_SPL_SPLASH_SCREEN_ALIGN=n
+CONFIG_SPL_SPLASH_SOURCE=n
+CONFIG_SPL_BMP=n
+CONFIG_SPL_VIDEO_BMP_GZIP=n
+CONFIG_SPL_BMP_24BPP=n
+CONFIG_SPL_BMP_32BPP=n
+CONFIG_SPL_HIDE_LOGO_VERSION=n
\ No newline at end of file
