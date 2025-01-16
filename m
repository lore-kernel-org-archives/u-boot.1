Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26FD7C02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 11:30:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4543980703;
	Thu, 16 Jan 2025 12:30:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="JJrlO9AC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B56D680719; Thu, 16 Jan 2025 12:29:59 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2072c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::72c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB8A780214
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 12:29:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E1FX0+iWvs7KDo1SQr2uulWSHF58cFsNA18cjh5hTmjxeFqCi3nm5tF214GRYh8N2NMvQRLJRglFSnA4aVL/j3QYZr66Qw4xKWTvUXvh269M3XKY0u2DIbflj13krR45M4oLJWFy8ckH3/Hyh0XVo6xjaJw4tjSxYudB3w1weBd2YsFtZBSJW6jb4O1vSIg8l4vLbkFrOh4U8NXr+WTt9WVDxDaI2cv4VKMKpG/ZzOIF7f4mt5GtYVjilZVR1kOT8Z3K0ksZs/6V74pnj7pspncWjejnkrByXF2Xmz2Nl5IjVIUh2J4LdHFbgTPxub+TEAF3l0W4zLCG8ERpq0ouhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkmCrxImdcxNXD1FqouEqn8OlTlsVp31p1VC7ni2fhQ=;
 b=rM7gGUmoPv0+vunRQki/lehU7L1hdStPVwF953oB0eydl3nnKROLHge7FQVPT+Kp17SbLDwIo9Pux6c8893Sa+o2Bbq7rQX4MJ86J0P8v+ijWAR6m+FaxKUw5RkxipaqKRJPd0qglDz4IHNKof7CeWyBBhfhg2T8ECcigXpbC8wRDxJlyAX7brmtNm84IcQhGOHD/q/MlzszfEhiO3ShRIF8WRrPd2bJGOlB5EnGimuGpcbcnFVphxjlPCdDTGJqdj4qwNoI/Z/nnA6EcxnsuHraac21H/IVLJtGjHkEcEbprA8TjqLT/VFlq+sXZD8Upvm2po6QMcp+M61I+SLc3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkmCrxImdcxNXD1FqouEqn8OlTlsVp31p1VC7ni2fhQ=;
 b=JJrlO9AC1ZiKZGNuJLLjKgF3aVRAON5nap7vu+ruJHRChgsoBouxoB7JVF28zm5o3zn64mx1P/ZYodHX1yJ4Gvx41rbcK2zTIMez6uVCnki6wW3s6273Zd2VvsPEPoqy/U9FvXCcuDlYWvpGw0KcRo9vk1mCVnA6XDYw1jzL9IP3LZQwYNS19VGcRq7bPX83Rn8wOFS0lXR34k/3cYxYwNnaA1cqeb2lcCJOodybxuebwl1cOOL9czOcfmD4RN7LsSLILuXl8XgkEJBPcgSAZlhiqY3uFX+AsybSUYZ0Ev05ib0oCkbj+zWiLRyyGAcatCsuEHWgGm30dba+tMLfAg==
Received: from DUZPR01CA0259.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::7) by GV1P195MB2656.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:150:1ec::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 11:29:54 +0000
Received: from DU6PEPF00009528.eurprd02.prod.outlook.com
 (2603:10a6:10:4b9:cafe::93) by DUZPR01CA0259.outlook.office365.com
 (2603:10a6:10:4b9::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.14 via Frontend Transport; Thu,
 16 Jan 2025 11:29:53 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU6PEPF00009528.mail.protection.outlook.com (10.167.8.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Thu, 16 Jan 2025 11:29:53 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 16 Jan
 2025 12:29:52 +0100
Received: from ls-radium.phytec (172.25.39.17) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 16 Jan
 2025 12:29:50 +0100
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <d-gole@ti.com>, <n-francis@ti.com>, <mkorpershoek@baylibre.com>,
 <upstream@lists.phytec.de>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 2/4] configs: phycore_am64x_a53_defconfig: Fix GPIO controllers
Date: Thu, 16 Jan 2025 03:29:30 -0800
Message-ID: <20250116112932.1983801-2-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250116112932.1983801-1-d.schultz@phytec.de>
References: <20250116112932.1983801-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009528:EE_|GV1P195MB2656:EE_
X-MS-Office365-Filtering-Correlation-Id: ac3992b1-a6fe-4b77-62f9-08dd362118fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wGEYp8yiabrNmWr1UY28WX6hjYoHYKEIDRMyqkBVeJurhuT7ejUt6kJ9jIpP?=
 =?us-ascii?Q?wcEo7Aa2me4Eiw5+eRigr+0RSfXIiscSB6nMw2UOrVezlTGSYM2rud9Tl7O+?=
 =?us-ascii?Q?Fu7WKH73SWH3mOB/W7Hfy54uJVe9YCqsudaMZBLYQsWe5tia6q80eyJCd5zN?=
 =?us-ascii?Q?5IMSA22SCZF15+bKeEWEo7WidTjMIJFMJuaJ5sx5eoUcufmPj2Hjx8576pnG?=
 =?us-ascii?Q?dXAy3JOrgPQXDdy0Vl7R4nUlrCQzDczHoDw7WeKFz4e8Qmyllmk9N5U7VMWJ?=
 =?us-ascii?Q?zSQCfOJFL5nfh3EEz/n1arwqSN4fMHY3cYTcQYU98t8erONwGqtpNd2/O7E9?=
 =?us-ascii?Q?Gudrp0ePFEI3g9X9jDLmOGTHu4KB7OxDuRGaeE5+/H2wW9cXlfxvR4F9DxXa?=
 =?us-ascii?Q?jZmL5z3Y0dSWkP5yWmwrOMUGW3Yy7kVSNEMej0e8UpzDccKaYpP3VrXvOyk4?=
 =?us-ascii?Q?E23HabYsZrzrKaT2u3DKbml7E5x/EwpwqkWusGdmm1BjSk8oE7lUFAvMgmit?=
 =?us-ascii?Q?lS5x6tiWtl/MCfhp/z9rdlO38LBKl4NGQrPgpiftuwCzfRGGkF85jWbK2fGH?=
 =?us-ascii?Q?YyZsiI9MXVDJ0ZcBPRpxZHwuqHWgyHOJNEU3aUtnPR8qIh1ZUd3NbLKYg3OQ?=
 =?us-ascii?Q?SVAAeNhEgBvom7ptTZjSYGVr4X5xwbhleSL6Ym4iUpdy49GjsZAgv+JKHqnv?=
 =?us-ascii?Q?oy0hiiQ+hjYokwEJwHeuwKxk5ZJ8Zun+5cEkZkVKajiWdI/Pn/jvs86D45GP?=
 =?us-ascii?Q?Rr3qZ8cXQJUknAoap/odlMdjXjl5WFL8zcYMU+DtCV9x2peQx0ODRlVhnlGJ?=
 =?us-ascii?Q?1rHp16Bqvaw5G9P0bJ6sXnyb8TMWED2wbZNdsZhCcckKCzU48PslttZybx7H?=
 =?us-ascii?Q?1XK9BT3EQclyMEnkS/1A+fVYRZs++KPFke8azD9/AaC7Lc7IpxWK3oufMZF4?=
 =?us-ascii?Q?41qop8RRkPj+LhWN95HhH8Jt2pc4EVSORJyTSQDx4dnH1/5lovzmf4yGsFRn?=
 =?us-ascii?Q?J1Y7j5KjZFPleKehanjKKxUgyHT8LEFfZCAbG3DClBEvpjaRYNSUVyCiY/g4?=
 =?us-ascii?Q?MB/i866AAeieZF2STxKveXykQ9JYbmsaiMklbOG+289HwRWMkQN69FDIaUfE?=
 =?us-ascii?Q?/MqtwYDsnbO0D/KTmgIbDJyzoMoKmW4AIs50UVBsfNVcrcOppqpYDysLu5/W?=
 =?us-ascii?Q?QBfkA+gjlhhV9oVNe7wPcI0W5F+GL4pxPkjkYb39r0OEGDVdk6JxKlAWD2zN?=
 =?us-ascii?Q?tGfsQJ6rYRWze9Zecm4LsfasULzO8+8kxM8FgLQB3r44kpQEXJXkbhJIe2By?=
 =?us-ascii?Q?rK0l//XAhQC3mx1fp5OahrMIWsMTFIxsvnnKeiM3bGtbI3b+IUj7ltc/kRQZ?=
 =?us-ascii?Q?7kbm6JPeQYW9r9khIIFxFedPZeyMkhLQpy+GK+ZvRzK8WZZ7DFlUPUZylWoV?=
 =?us-ascii?Q?8SttLCMJH0lvJYmEwd8u7dNTdyU7U8G45fvaDaBLjQvHaht5//MnowJE4AGi?=
 =?us-ascii?Q?15du3qNH0loMkWg=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 11:29:53.6842 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3992b1-a6fe-4b77-62f9-08dd362118fe
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009528.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB2656
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

The phyBOARD-Electra does not include a PCA953x I2C GPIO multiplexer.
Remove this configuration as it is a remnant from another
defconfig, and enable CONFIG_DA8XX_GPIO for the DA8XX DaVinci GPIO
controller instead.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 configs/phycore_am64x_a53_defconfig | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/configs/phycore_am64x_a53_defconfig b/configs/phycore_am64x_a53_defconfig
index bc450004722..4b9dcceda45 100644
--- a/configs/phycore_am64x_a53_defconfig
+++ b/configs/phycore_am64x_a53_defconfig
@@ -112,11 +112,9 @@ CONFIG_SYS_DFU_MAX_FILE_SIZE=0x800000
 CONFIG_DMA_CHANNELS=y
 CONFIG_TI_K3_NAVSS_UDMA=y
 CONFIG_TI_SCI_PROTOCOL=y
-CONFIG_DM_PCA953X=y
-CONFIG_SPL_DM_PCA953X=y
+CONFIG_DA8XX_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
-CONFIG_DM_I2C_GPIO=y
 CONFIG_SYS_I2C_OMAP24XX=y
 CONFIG_DM_MAILBOX=y
 CONFIG_K3_SEC_PROXY=y
-- 
2.25.1

