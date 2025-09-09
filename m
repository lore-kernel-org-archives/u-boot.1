Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8819CAC583
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 10:37:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CBA7830B4;
	Tue,  9 Sep 2025 12:37:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="a0A51SYP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56143830B4; Tue,  9 Sep 2025 12:37:13 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20715.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::715])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C8D28318E
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 12:37:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tRpOORJO27FMdQ5rg0+XDGH6ECv+XpQlv5zebe5UMVR8pCdPICFeTEqdHxe5eY0qWEY3LdnKZSyhP7K1sptqcZSUu3F67nyGuB7xkJXTCOp8elSkVnQWT/Ih3kChA/Z0zLm0zn734LWdlUQQ+ALO2zemPjh9HT4liL8+57lxcA7JlEQvEM8yZKqqBQMVmPtqoNehWtAfX4NVk780SebNAHmD2IweoY7eK9Q8fwncm80CLcmyL1a/Z5kvA07rAvzGobnZPw6MzJZ6eRC1hPW9LnPN4cv0JBvyTaqpCjSjvh2qFRQ725mAhaxogngiUCq8y5+d0utN4SPbKAmEQic+tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=up9dvaB/euPWwBrQDJw0oq06iT5QIK1niusS8qPxzws=;
 b=l4qcXL4wzoQOY29obKMEcXyK8ev8266bT2gY+8gb7d5PK+KtmPHp6KopNsPAQpi65WtC7M4DFmVBekbfCU53DoYOspJdAXDL/ewlNt1qSLxtsCPUBQtRCbMMdqItlSXFIJGDGZErgkpr+3UQDCnEQUHXW1qRyHrru2cyj4C31S4LHnlV4qKhbx/R8FqeFdakVeZ6tBWk142iSqLMZU7bdGkM9nZlONMdKtK7Nhb+trdzUlFbzjAKkQP46APAY07sPRRpGjsUXLep1ERT+rJtAmLGr3PKclfsyW6uRckatwQjONbijckJONPZy+LYujZ4rLWFRpIAUXqTJfUY/UTOEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=up9dvaB/euPWwBrQDJw0oq06iT5QIK1niusS8qPxzws=;
 b=a0A51SYPWjz+E9wpH4pORI7mYOtI5aDIs2ZMIWHZqmYtDFyvA3/dDqJ35GlW0d6daQoRbnjL07BHrHZ3Zc9K3gauOEeWsBf3AErMZkxOMC6t4JpPOYSR8/ra3PHeLOXJdwE3MhLPdiR/5WHVNzfW/fI79IEwbAE06Y5ykiZ6WENupwf1L0Bz5Ni3v5muj5ZU6iWQt7SkoMRTpCAQu7O9iwZfg0W8aq+wWC+H9pgEpLgeRav9SlPYcxtskzA8uWMD7JMX8fdabcSuq4qLWu99geIbiLOXRdGtV5utGpEJXR+BpWrEbPnsjVF90Dleg++QzwhB+YiLZqmBYCZdg58oOA==
Received: from DU2PR04CA0046.eurprd04.prod.outlook.com (2603:10a6:10:234::21)
 by VI1P195MB0478.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:145::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 10:37:07 +0000
Received: from DB1PEPF000509FB.eurprd03.prod.outlook.com
 (2603:10a6:10:234:cafe::cc) by DU2PR04CA0046.outlook.office365.com
 (2603:10a6:10:234::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Tue,
 9 Sep 2025 10:37:07 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF000509FB.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9115.13 via Frontend Transport; Tue, 9 Sep 2025 10:37:07 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Tue, 9 Sep
 2025 12:37:06 +0200
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Tue, 9 Sep
 2025 12:37:06 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <ggiordano@phytec.com>, <trini@konsulko.com>, <d.schultz@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH 2/2] configs: phycore_am62ax_a53_defconfig: eMMC boot from raw
 offsets
Date: Tue, 9 Sep 2025 12:36:54 +0200
Message-ID: <20250909103654.3341398-2-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250909103654.3341398-1-w.egorov@phytec.de>
References: <20250909103654.3341398-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FB:EE_|VI1P195MB0478:EE_
X-MS-Office365-Filtering-Correlation-Id: abebf6d6-2386-4af8-43d6-08ddef8cd367
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+IjrBFoGnl+xYM2utP0Tn5XRWwASNceWCDKqK/Pu+mC2fkVAiH3jsJKTDPrA?=
 =?us-ascii?Q?AXXQR4FwgWmYtqCEUwXYM+TewDW4qBqo0Dl4dUbD2EOX+9YdIL09QlVgM9OR?=
 =?us-ascii?Q?B3m1RymeElEG1Zfm0M3ZkCdgQNMmtMxmd9M1+zNecpoCSkgDSls8nezuLCv7?=
 =?us-ascii?Q?cdmgcMB+qkX5UZH0KZb4gczz5o6OCuQGz18BP47IxVEey6ejskL+10WI75Fi?=
 =?us-ascii?Q?sOtPNs34eoKorlh+N5jiF7/s+W6XxucAEMlQQWDVOfKqg+gaXJEvQkr5Kkwv?=
 =?us-ascii?Q?K4pr4H47pDkwHdFJ3c27nVKnsZ8lXF45ID90/ZqlBLVXAOkHZNwqeiaZBIpo?=
 =?us-ascii?Q?ynlPCX4ZerJ5EoXPMJQ/aFBNNedo2uuo4mC0ikgTLERXElxXTyKT0QUjrFtH?=
 =?us-ascii?Q?Hxbuy3JZh+V05u/O2h8f9f2vVSLB/wBfsHQijVr2bw+0zNtFZsYiNkXPUF2q?=
 =?us-ascii?Q?6tZV60NmCvrNUbXIksKIvg7zj+L/7hXKFmQAzbG1zavKE48m8Gz1jZBgyoo4?=
 =?us-ascii?Q?q4ObnSx+udJpFgqf1O60oy8GWixHUlYZm/u43C7Z0oIO8QbWixgl8gcU1NF2?=
 =?us-ascii?Q?iseBZD76Emz2XK2keXYsNiRXzE3BNW4Pjtv5JTcBXMG7cJP1IoCaMPwACxDb?=
 =?us-ascii?Q?EZ/QkPf2jKH6HjR64wpGKHyQlTw+97yd8YTGXb8BKYGKCFDhYAjkd76jEoIg?=
 =?us-ascii?Q?t3Wqejbqe1a95BBjR5Tc2KHyu/C4Xdb7fyWgKYsG8qMzNp1MT6RfHhDY6nKJ?=
 =?us-ascii?Q?RUxvWsOJUgOUsWj9kRmldAhrrs2kIZwZsYPY3EbTFwLyZr8tovEq5jo35+Sp?=
 =?us-ascii?Q?bjk+ccCJkbrykzXGk/FSYVXFz3PF4jjnyjf1P9TtuD2wv90BOAaiHcBecHhi?=
 =?us-ascii?Q?0e2cU4gbif7K2sGL6IWURX/ZQFuui7Y4WIL4EiLClWxSiZmzMFXdDl8ZjYvN?=
 =?us-ascii?Q?lH1u62lp/2hsGElgVXIdC1ZamXUqjsh3v1uwA7JajAMiQTJmPGkJW0EmWRxM?=
 =?us-ascii?Q?GLhXOpmdfgVwFMmNs6w2xf7YwE0ARzFYhmYWIYKrAjyddSTb2mcbeaUebGJn?=
 =?us-ascii?Q?0ogl2daisJdB5bzb6rjLdMDkYmcIgZgzeFXilpU4ipHP5r7Zj6SqjSbl+bBt?=
 =?us-ascii?Q?aC/0CG4iyx7RB0qtPoOAOnn2NieiyaqNkaLE01gTdkVWq09mibCmKi3N3+5l?=
 =?us-ascii?Q?xO1Dr5F2Qv2rpz9ONP48aR4ZWR66BfWc7ZhVg1mAHnei1RP6cw84lGPyH510?=
 =?us-ascii?Q?0sS8Q9ViDkzChL6C7tjUfcXHGLVh3DCyCyIOU0Bva4BESrEaRvf8WZxtZke0?=
 =?us-ascii?Q?8WSLUpYxQnvPOKI0Et5y5nH+P/2vSIsFskbJGsOVi2fTj1JT+TXXBmmouDzh?=
 =?us-ascii?Q?2oTU9cWO6NcA+FV3rtLv11vKkuq9XGx4rE1d6TsehIqyrreppyhLQr8E3u0I?=
 =?us-ascii?Q?d8+Ctz79BUwcxLy1k2z+vff3CRyZIBBXKD5Gu6yz1G480WJEmcM8mCJvYL+c?=
 =?us-ascii?Q?rOfl8QtPzebuA6YDHf5kH3MZBali3Nj7K46I?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 10:37:07.6965 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abebf6d6-2386-4af8-43d6-08ddef8cd367
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509FB.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P195MB0478
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

From: Daniel Schultz <d.schultz@phytec.de>

Enable CONFIG_SPL_SYS_MMCSD_RAW_MODE and set the offset address to
boot from raw addresses instead of a FAT partition.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 configs/phycore_am62ax_a53_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/phycore_am62ax_a53_defconfig b/configs/phycore_am62ax_a53_defconfig
index 05849d05be4..27fa4386a21 100644
--- a/configs/phycore_am62ax_a53_defconfig
+++ b/configs/phycore_am62ax_a53_defconfig
@@ -48,6 +48,8 @@ CONFIG_SPL_MAX_SIZE=0x58000
 CONFIG_SPL_PAD_TO=0x0
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1400
 CONFIG_SPL_DMA=y
 CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_ETH=y
-- 
2.48.1

