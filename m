Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812E5C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 15:26:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C12BD80B98;
	Mon, 10 Feb 2025 16:26:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="LTI/NhnS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 460E880AE1; Mon, 10 Feb 2025 16:26:09 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20721.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::721])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D846F807D6
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 16:26:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y6Wb9n12Lv//2urOwglQbFksX6ZLQH0FTAIGsQqH2j3KjeJWq8u2iNjPmlhGOYhmc1qINY+aMc2Md71mF7cDpXHM14NSqbuh03kc1rmyAu+M1tWH4TP+iCmij4H7IbSYuuKkkMKeY6FTLyVge3zdL/VRCgxpAWAFP9+aG2iVexGMdP0iyZNodnMzL2Vz2HNV3d0qHIXB/5DzZqmEUhWQ37n3PPrGKrVlhK5xD8Efd6KsddVvWVQh2aYJ701V13Yawk1mf37BHo7cBFpSS7S6Lv/9Ih1f/LPiNc9hDveufpYkZ1u4lV9fUvEnrsGjppF0AWrqQLg3mY8iNCXttjOOzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VbR4y5FtLLItvXm7AAdOJ+pTX3RPjFLFqkQbpikcTs=;
 b=FMg4l+M40OgtJyVBnGblYTAqL96VQDtrrMavvOQzgbqwVN1WYPVK7fpxej3oxSC/PHwV19Mi6sIEKViQtECnqRVtvWJ7SQvq7ZpmMADHaEypy8B+8LpT4f8TnxDt62NKTMPhBKFTbqdrHyUaDxWAklbKw6ced6Rkg5VskEDRKjbwwe3CKBXfCBky38lkz15RVf6lCs0FptNt7ffN1/WKrd2SvMgUUARiH4gRjrDmJWhPeKq0naPVmukso3IqafEmgJzUsHr3fnX+a+f4P2/088y8wMDQAO5zMxm3/RkpaP2D9VtsWvn7d12YLaEt5rxGQ5FIQ2Oppy0Afn977qP/mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VbR4y5FtLLItvXm7AAdOJ+pTX3RPjFLFqkQbpikcTs=;
 b=LTI/NhnSp3aSx+mK5/XJOc1RFxxxg+pJ2q2leC3Fd5exW6nBNNA31Wah4ROCyvtNaSfwxeDOmPzGEVOCPbktSARaBJYG6P76J+g8e0WI06AUPVZT1zZmY8riCyV9y1+SsKRdkN3q9OdL77oG5bZ0ZoL1BYDManCwRwqepF+yaLT2eucwzO+oYSwJhoKRchJz8I2IcLLXYXu+Tp4KRpBMehmQFfx+Ntfh1+5F0F1ODCpT2LrEpEp7fhg1NoysVGk4poQ02q15rScglqjFHpN5PGCwsT9ixHPzpOWDH+3YJ8yhDdzvU23iB0oEO81OJFWdfRzVfnNJZ0RW4IwmbvUiEA==
Received: from DUZP191CA0061.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4fa::16)
 by DB9P195MB1178.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:29a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Mon, 10 Feb
 2025 15:26:03 +0000
Received: from DU6PEPF00009526.eurprd02.prod.outlook.com
 (2603:10a6:10:4fa:cafe::5c) by DUZP191CA0061.outlook.office365.com
 (2603:10a6:10:4fa::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 15:26:03 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU6PEPF00009526.mail.protection.outlook.com (10.167.8.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 15:26:02 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 10 Feb
 2025 16:26:02 +0100
Received: from ls-radium.phytec (172.25.39.17) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 10 Feb
 2025 16:26:00 +0100
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <upstream@lists.phytec.de>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 1/4] configs: phycore_am64x_a53_defconfig: Enable
 ENV_IS_IN_SPI_FLASH
Date: Mon, 10 Feb 2025 07:25:45 -0800
Message-ID: <20250210152548.1263498-1-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009526:EE_|DB9P195MB1178:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c542ee3-3bdd-4841-4ccd-08dd49e73ac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?diaJqeALP6ljBD1CbAEIiSWHMFW1RdVVrIew4oOuDNZBN+F1dQYRW8lj2A5B?=
 =?us-ascii?Q?2j7NgCN+/nd39PI0HKf9u+my2zTQi45jRETIMWZnkRIKDLXdcuc4okcW+oLd?=
 =?us-ascii?Q?Tm7Pp1TMEFDCer9gJDVcFmH3Y31U8PvON02f0q5QPv6jL1ceyi+CIKBxgxOJ?=
 =?us-ascii?Q?7ogMWLKoLcZdeFIsW5lzA/vSiSF75cWmh7tjn95Jz/YSjEnQeKP5RSgWPb94?=
 =?us-ascii?Q?4mpKV7kOeBt4u4R+CKIrXecOWiPP1w5s3BCggIlQnSGw5SsS9tn2FOyiIB/x?=
 =?us-ascii?Q?w62qGjNCP/YEKxir31BQ9ywwG+2Hz25Tgy2DMGIB8aNvjT08Iw9WVwV9O6oM?=
 =?us-ascii?Q?Ns1gCONp4Yqyjv6OTkRRADfpbMcHhWaGwFLKD03wAMwfccDTrklCdWwpp1Sb?=
 =?us-ascii?Q?02EOTjbfH352glkzhYLK9FMjwdhPspANG0IGPV3U4BcVXLPmNwFGeAX8rwL8?=
 =?us-ascii?Q?f7fPK643CWCtXqeDV7c1YRAaq7RADth3+/Vl+TBXeDolnUZj3e6wr+clKfEd?=
 =?us-ascii?Q?mV22wpHUTuZjLQRhfC/bhO286a3J5ExrDqHOK9c5hZmrXrLA3CYcWIutXoLZ?=
 =?us-ascii?Q?o3h6TpiIQNnx8IVBu0s2959wE90wf8hs3BedL2Ap082IzcsTpTzYLJi2nFt+?=
 =?us-ascii?Q?MrHr4GL49MYzBm+mUqr6Xur5AEW0PSjGp5FGLCBNpdX4V0NGFRs2fxaAYTtQ?=
 =?us-ascii?Q?9EB0eFh9twKgeIFSw7Os07LnkF1BeWA0jcpw/5QJbLxzyNJG27TZT+3qfqS7?=
 =?us-ascii?Q?eY43g9Wboa1S6R+NnOxJ5UhYtZZzbC+Dnix88vgWuvtXdn4OHgvuHxX0SiRx?=
 =?us-ascii?Q?z5zrJ8wixPtQmJYlGK2/d8IeCWlaEwAJhq10rwyrM51TErSEx5C9cbgxXrPH?=
 =?us-ascii?Q?qkOZmzqwDiuYmciVoKV/dxoFc4ZKg+pFC18vMjJMfmB2732tZlnX3Itvpbj7?=
 =?us-ascii?Q?Fb9DEOZDLLerG0AmJOxzuzHm19SNhFPEFRUZdyqpBDhuANboRraWoD2BRSUJ?=
 =?us-ascii?Q?hOWAOp/n4J57OYf99VVxzwtVDzsQQYA5NqigQW8a9srP++dv231S8dhtVETe?=
 =?us-ascii?Q?bsdmrjkjXiHDobWC0J8HspXdixrje9bPlX3JQn0XlcmknPkotjCzxPoJYlgn?=
 =?us-ascii?Q?OdD9nLGTWDuWig0/J2taeBA112/k2aS4QDxYzTWWgLp6vVnvJph5S62EIkZR?=
 =?us-ascii?Q?E3/JMuI2lhnQo/XCDy1HVYqLsa9CeT09XDZuvJNaT+eWgyYT9grJYavZ2jCe?=
 =?us-ascii?Q?JHOYj2I/Nyet4baPadFBB/rdM31l2r0/TO983AaQngX8Pve+mQ5Ik9TKxMhS?=
 =?us-ascii?Q?BEpInF6mKJ8Erdt9RmVDTz1aMPC4neYanLWnQpbjTfnwcK6/F0rzlLdOCrGc?=
 =?us-ascii?Q?NCmSUJRBIi8jIg+ryUFlMhR++X8co4IF/Ye8Y83DaRpZJlUy0kQfB6PqG8o2?=
 =?us-ascii?Q?i/AlQKNeLRNZpqWP43qJSjwmQUYOnuhpIkCVuErbpQMhRyvyvLW6iLDECBmC?=
 =?us-ascii?Q?A2Pk/fpQ6gLWZZY=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 15:26:02.7938 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c542ee3-3bdd-4841-4ccd-08dd49e73ac2
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009526.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB1178
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

Enable ENV_IS_IN_SPI_FLASH to read the environment from the SPI
flash when booting from it. The oftree, kernel and ramdisk sizes
are located in this environment and therefore required to boot
an initramfs.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 configs/phycore_am64x_a53_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/phycore_am64x_a53_defconfig b/configs/phycore_am64x_a53_defconfig
index f0c7ee26384..4ee1bd829a3 100644
--- a/configs/phycore_am64x_a53_defconfig
+++ b/configs/phycore_am64x_a53_defconfig
@@ -14,6 +14,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80480000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0x680000
+CONFIG_ENV_SECT_SIZE=0x20000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am642-phyboard-electra-rdk"
@@ -91,6 +92,7 @@ CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_NET_RANDOM_ETHADDR=y
-- 
2.25.1

