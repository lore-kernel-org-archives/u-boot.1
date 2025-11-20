Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B10CFA441
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 21:26:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EEBD8392C;
	Thu, 20 Nov 2025 22:26:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Hwmvokad";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0233783936; Thu, 20 Nov 2025 22:26:52 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBE45832AD
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 22:26:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Haller@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BAbhKVxPFFO0pmPG1aKAuc3SeckclWqvLGYoCbII7AVma5yYAcvW6T03GE5ehegsMYv6dPL+XeQT5+xXj6OzForsohaw8iKEX9ejD0MVpystVaeImP3bLpeK1nsgm/9FNGarpsq1u3k9hCUl8pLOTQled7F+OfpxfN+Qz9k8Bo3BIwvTVvQfjoF9Wqo6IQgZqg1oUQREi2lQu25DvxRhrpTMW/ZQ9MHk4h8N5Ik6RoSQFM8bMsIeu2lidehp5RowOq3mlDVfA0yRUXId8GFg7zvHJy4dOD6rKHMzy6DzGXhfjWV4ht/8S09VfNizEAe3pTw2nw8/qJAe14ydBzm++g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68Bb3FQcpswk1ksUzg2KUTIwUzJldzDBRV+W8xQtV0s=;
 b=HNOccGTCCv4kdTMwrq+8j4GHgSYYFln1JdIXZ6a5ERaiFPFuJvVAtU4SAVQtmgR+0azPjgcgAVTCFvm0m1510PF4T64IB/WgzhyyP8aVyohZi948TnOlV/oxpcybX+4bqYP4Q/ORRv1epmuqjjZwbf8WlzTE7KBrgimxTS2B9m8SSfEq2q3eNGnMMt4peywWaFGRJBWO0WzHs1k7I0glhMj+uUXWhdzgcHOHfJVf/TNP/jD+EbdwgoHZSPKL4nb1GaX7TUP0Ivk/cvRJ6y+HyggTrw45wgYbhwUQft/Ze4jOScL7qIcrrHlGBabxzT8pnII1Q7ufEF5SAZGv4k5XxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68Bb3FQcpswk1ksUzg2KUTIwUzJldzDBRV+W8xQtV0s=;
 b=HwmvokadqH5NLY9y4jP6+f+ThKVOhRN/7vhcFFRdtRduSE1QURaHhjCWUGN0X0jhkKol6q1QkLaJQPSWBACjvE69pyf6f22dGtLJL+WQjFXnBGdcImqLzR4LPgX/D4DWQEZTMoRqzjuMfy4HXqmoD0b1uV/FnKJNglkMBYZP7orhPTBM06g7o4MYteV8WZdX9GUMXecZyMJPnrSWEHnoMYivcFnFsRmKGcOVzbNLAC23rvc2oY+1lM8aZXx8/NuUxpGisxzhzJOWUHTAXZ1x+dEEH0AtWsMR3ju8QI9HGsvI8DWXhpJcvEcu3AVcF31a2Rx0v+3HLjYPkCKGFmPWsw==
Received: from DB8PR04CA0027.eurprd04.prod.outlook.com (2603:10a6:10:110::37)
 by FRWP195MB2914.EURP195.PROD.OUTLOOK.COM (2603:10a6:d10:17b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 21:26:48 +0000
Received: from DU6PEPF00009525.eurprd02.prod.outlook.com
 (2603:10a6:10:110:cafe::7b) by DB8PR04CA0027.outlook.office365.com
 (2603:10a6:10:110::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 21:26:47 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DU6PEPF00009525.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 21:26:47 +0000
Received: from lws-haller-privat.phytec.de (172.25.39.212) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 20 Nov
 2025 22:26:45 +0100
From: Dominik Haller <d.haller@phytec.de>
To: Wadim Egorov <w.egorov@phytec.de>, Tom Rini <trini@konsulko.com>
CC: <upstream@lists.phytec.de>, Dominik Haller <d.haller@phytec.de>,
 <u-boot@lists.denx.de>
Subject: [PATCH] configs: phycore_am64x_a53_defconfig: Drop eMMC HS400 mode
Date: Thu, 20 Nov 2025 13:26:17 -0800
Message-ID: <20251120212619.41062-1-d.haller@phytec.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.212]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009525:EE_|FRWP195MB2914:EE_
X-MS-Office365-Filtering-Correlation-Id: 62621b95-d792-402f-d0e1-08de287b8315
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5OB1jAOjpYl/XttMY3vuZIdZro/p0hKI+Q7CyGB1vtvoMwMvoudiwQcIpUD2?=
 =?us-ascii?Q?YK3jF+yx6jAnJuClWgBb9BfWRFHQb0Imb86VAtYzgNe5pTUFUDIpgwD+4gZe?=
 =?us-ascii?Q?G34/lkoacxODyARsRA79OyJP28e59lrDKsXTTU02GfaBRMaKCY9oXCgEzDmt?=
 =?us-ascii?Q?Jxz1PJf4UcZX+r3XF/CqISaVrkAnngxDCl0nMby+5ya5TpK5UHuyFwTi391x?=
 =?us-ascii?Q?gMT0pdYRZYsq9GA8cgvj4u134hPM+ZcWbcPsijXa0nztEv/Aeve+OTxWOicO?=
 =?us-ascii?Q?HqpICyewj4We0dY5YBVOKQ7eE9iSoztc1frAEBgBvAeYw6x+6n4Ud1b4vDSm?=
 =?us-ascii?Q?/ZqlHbuAwg71VV+77qQrMO8cRx5G7/Nn+WPhzXSUpHtJHEAR3CpXIiFCracV?=
 =?us-ascii?Q?dvMf2uLLlkbjWkuxHqyzsNHy8PVw3GoxHelJ3C+3UcNBogBlr2wSe7wjhFUX?=
 =?us-ascii?Q?bmZGo5z3cznhIvCwnahU4p/oL1JD3dl24TUCa6g97XV4RuitLbqud00GPRBj?=
 =?us-ascii?Q?b0UN1AnIfKccTtNw7R3pIxKCgYTIdly9qBLBofyIx5nzqz02CxxAaWL4ycjG?=
 =?us-ascii?Q?6qbUP5QJzQwAwEkOx3RLF2BE8d90ln+z1DEfvHw0er4iCNCYLHbla7fScB6+?=
 =?us-ascii?Q?qayLQWWwdGtLTFFbWO0aRHtTkkc+2Nu0/cCbC8c8L/iD3vne4u4tviQ9Tjds?=
 =?us-ascii?Q?k7JsAK4E3DzQcqN93mVQrLlIDTNBiNbx/4nlPQ664RgxSKQqv90eb8JLwAoM?=
 =?us-ascii?Q?kSeLnFbxeRZrCJUzYn5qVJr9R7VNkeSiynQCxj9cvTgS+iGgxCrRfSNN2fWa?=
 =?us-ascii?Q?fCgpUKMJQCpFU4abifxnoUGhzLp5+ZgpmaNQZETfXlgK31KbLdvybqzkwyF3?=
 =?us-ascii?Q?rgpVIhcg5/PaY/KvqzYOX0lSmzNBRLylxL+E7ke9GPIPKzBfcZ8NJrpEPNuZ?=
 =?us-ascii?Q?UrrpY/2qSpWKdCECH4WYwFFDOOaH6Tyl14nQhFy8sB7mUYrZSMWwvMiMmS1+?=
 =?us-ascii?Q?R7h9uYbg3MI0blcIL7r0WfEFog9ujTLu5D1MXgFgVddCcuybUM5AKOau69hn?=
 =?us-ascii?Q?yE0/pRsmf6b4UCmSjVWuMFsZ3IPwt79ayVpxoXGaKxyoZiMvp9eywYQsBI3v?=
 =?us-ascii?Q?5QA16Fv/uG3eXCnOjTSQQyKrqVBGLwt8ZCizthLyNGEUClPDnmXSlbxdVnGm?=
 =?us-ascii?Q?DGzeVOdzDcypqliqAkUeDdaz+kBmQZBE0II0mbaggBePas9D/F44x54HP6M9?=
 =?us-ascii?Q?bLhwCMCihMgxNcReAndFoZydBRWIEGpF1+huozmRnOT8Kq+nQ6X81GZ31ngh?=
 =?us-ascii?Q?LKUTzBgu5RGHdwoqz2IZ2fT9m5pGGJq/SsIQ5Tk2zm1FNIpuDDWYdXbXUPx4?=
 =?us-ascii?Q?2zuxQv4L5uN92YNrwh5olZDghoxnU62Pgx8M98T/KEXwPUJPNvmdsJ/jb2sp?=
 =?us-ascii?Q?9R4JoVahig6rv6A5bt4I8Kpwh3EnaAEn4uOayM17a3OjBTHtq0RsQt+9LafC?=
 =?us-ascii?Q?QqA5K1trJdhHgVNPPFw2u+BC1wZ831h3XrAAUyg3CeBFlmnbAglY4qd936kj?=
 =?us-ascii?Q?fBWmTISPTbPx9AcxurQ=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 21:26:47.7824 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62621b95-d792-402f-d0e1-08de287b8315
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009525.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWP195MB2914
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

Remove the unsupported MMC_HS400 mode and select MMC_HS200 instead to avoid
confusion.

Signed-off-by: Dominik Haller <d.haller@phytec.de>
---
 configs/phycore_am64x_a53_defconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/phycore_am64x_a53_defconfig b/configs/phycore_am64x_a53_defconfig
index 9d6aa9c308c9..2e0964157436 100644
--- a/configs/phycore_am64x_a53_defconfig
+++ b/configs/phycore_am64x_a53_defconfig
@@ -122,8 +122,8 @@ CONFIG_SYS_I2C_OMAP24XX=y
 CONFIG_DM_MAILBOX=y
 CONFIG_K3_SEC_PROXY=y
 CONFIG_SUPPORT_EMMC_BOOT=y
-CONFIG_MMC_HS400_SUPPORT=y
-CONFIG_SPL_MMC_HS400_SUPPORT=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_SPL_MMC_HS200_SUPPORT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_SPL_MMC_SDHCI_ADMA=y
-- 
2.43.0

