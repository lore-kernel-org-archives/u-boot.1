Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA174C0219E
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 15:26:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9EFB807B1;
	Mon, 10 Feb 2025 16:26:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="rAMVoc95";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79F8C80A55; Mon, 10 Feb 2025 16:26:08 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2071a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::71a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4108F803CC
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 16:26:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qE0lf0osbiJoBzp9+rHM8hTgNve0U2Q+zEnvdnEzb0SG3uBBgej5ZTlXHJ88tAMLtBz7aqTAp+uzjGe43ynTMaCERtGquHnd2eKxWSBEmgROo5CSCpwXsltI4Guap0MI+OXCOGyZMpaWhl1n3ZPPQulT9Mu2r7T+n9tn/fOw3uiuD3e5Nx31dVWiE0/XM++F5sSfMXAaWyGOXN4QIrr1H1ehbZTInyt8Nek/EzWmUnDpgzDQ78K9A1HWnJ1bCCRdoVjGg+yex9MxxQ21m4dHFOq4foRGFiqC3Nnb9IoFBs3g4iIgQfvTIrnjXBYKBcdi96sOmLSSSAwjaF2k/v/48g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VsD7AOFI+r6my2QqCWPiXvQ4ws+FCtAMNxKua0jDkCA=;
 b=XrzUOsUwGPCCzQgch0xlcSB9LtsCn9zKM7wTJ7WcB6dXAEcnOAnscr6wbOmtc0HJVOuMysCjHPl3unv5n2QTTwJG2paVqCAwZ5GpY+F+a+TcW8fNeD0XkTCgGzwMcp+2yXE5rfRR6gKScxdBCvOSK0j0b+PI6VKZj3afy5TwAN39qNiuGj399FiwFx+gLzIZGQILfEHfYUBm1zoSjiKiNJ6T58cUWIP8EyzI3RdTjbDfwc6FW4+SCxF9EZnVZ7xiAhI9beiWFyVFQGZUKrDMvcBvpnqA36mz/iDNtD7c3kzDfVVWxM3D1sU5BwNV0X8VeKyL/ILBp8lnckdwnDalWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VsD7AOFI+r6my2QqCWPiXvQ4ws+FCtAMNxKua0jDkCA=;
 b=rAMVoc95xzUA/a1iQYwl9JCNF//iJlpce2B7NmLwKaleSM42IP1Yj/3goGOVAqDdsI+Njw0NCckNgncbsrlAyyYmx5ba+5kWHZkRPpxPUPhgg3M6H2dBLvUuEpcsolEDFppALzI4IU1RSS77kB/MqdprvczOb6oUKhO9rrx9gCLYpjAbFTKK6rFbOeJvBF7vqzUexE+/0Mv1HfJLd0JLYHnDI+Wjwap+7HbiZgJH+hYGgnxBUxKK5PHGmfcsiXdERQbZm7lAhhw7E4qcbIudhUEcaVRo2POgNwYviO6CVGmPGYuB5cYNi/uGPE7uA3UGux0Ha/7vwmJ+Gt/ST2n8sg==
Received: from DU7P250CA0022.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::6) by
 AM9P195MB1016.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1f6::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.18; Mon, 10 Feb 2025 15:26:04 +0000
Received: from DU6PEPF0000952A.eurprd02.prod.outlook.com
 (2603:10a6:10:54f:cafe::70) by DU7P250CA0022.outlook.office365.com
 (2603:10a6:10:54f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 15:26:04 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU6PEPF0000952A.mail.protection.outlook.com (10.167.8.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 15:26:04 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 10 Feb
 2025 16:26:03 +0100
Received: from ls-radium.phytec (172.25.39.17) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 10 Feb
 2025 16:26:02 +0100
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <upstream@lists.phytec.de>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 2/4] configs: phycore_am62x_a53_defconfig: Enable
 ENV_IS_IN_SPI_FLASH
Date: Mon, 10 Feb 2025 07:25:46 -0800
Message-ID: <20250210152548.1263498-2-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250210152548.1263498-1-d.schultz@phytec.de>
References: <20250210152548.1263498-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000952A:EE_|AM9P195MB1016:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a5b7df8-1bda-4783-8e18-08dd49e73bb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eVh433s8ZJn+KmFm6ScPfPh3F38fhOAzJkvEyPZ+p/1pLENTE3EWnXMxiEAk?=
 =?us-ascii?Q?PHZ+2xoKnYCYLs65L8KFYij2q0yVEktdO9iju3Cjtzf0heICXJpOSJyCKsmD?=
 =?us-ascii?Q?pstj1XieESOJpWQGVLBaPcgDXxzz7cK3Y4JVg3NUkP3xpg5OiI3tAVG0tyKB?=
 =?us-ascii?Q?QHoxdsMOoM0wdfuP8ekULQJRJe3AH4v7Pmzt6OancHf9Q8TdDCa100vNNepg?=
 =?us-ascii?Q?RqlFGXoJVni8tvN20wNBcgAzTvD+Fl70CTx3sK3+J/YzyaYOj4co4xcl8RTm?=
 =?us-ascii?Q?DsjSqpktcPP7tFfa01kWPq6X2Zkr/J3v9LI2pzr0ZJp8aX6Ut9OkFD+Sdxni?=
 =?us-ascii?Q?4wrtSnAZ/gJX8eFlxUuDS+xDh5rEnUdAil9yzYXBqH2ksstL9jMeZqNz9UFb?=
 =?us-ascii?Q?OlNC4TvhY+VWLYRePYONUzc74uZCLTx4FG+pmoEkVk1hB0/A8yAbOdjx5oFO?=
 =?us-ascii?Q?gxIxARoG+N+o+jkScUQTL8zZrADljBXczHt2dJogxONHZWMLbt5RMXNQIIRX?=
 =?us-ascii?Q?Ovizy95tqWfAwwM0AeoU/MB2Go7cgRP2bPLD4mYV7dZMpxIm1Gk0GX7mD4QB?=
 =?us-ascii?Q?cMAxYaBZHP53ZbSYSUZrvmacgRnz5nDp1I1ob7AIAYpsrp3miYWKuHm7teSH?=
 =?us-ascii?Q?rX27pEIHQFXSnj+ErlYpi9svjLRnBp5FBhJ2SIsPnmepa9oEDdBnPb+eMkHH?=
 =?us-ascii?Q?Y1wekzjHL9NWoNJvHpU+2EtitgcbTufN4Vp1zOkzY0HT69tOZaAIykpkOtRL?=
 =?us-ascii?Q?JT4qWdNeh8DwVgPiPQuZ1GqjtPozwu3RnRd5zirQLL9Ovy+KA1diMsP3WjGd?=
 =?us-ascii?Q?+4E/HCtC2WItB2zkQV9/6xq6bwOGrQ5SoUcVGS/vuT0yg44cy7hmDkZkTMkm?=
 =?us-ascii?Q?zSyqKuwkGtG+quch0opW4Dwf33bT6R3Fh6wBE9239T+DpR7ZrVR+WAHwq/r/?=
 =?us-ascii?Q?28xzGLBip/n9j5YlznqMSF92yJO3RkrIY9R3tFWRjK8rGyqSPpSnr3K8vdQ2?=
 =?us-ascii?Q?4Hsz29JWBHg8kDtVGwFJMkUWIameq0mLfgK2Jbb4uJTXFiuWOd/rS449dv7d?=
 =?us-ascii?Q?g+1FMYG0mSMKg30d+GMYDlhCXf0HZv1f7T4xVvzcPXz1/Kyb22c1sMlyIq+Z?=
 =?us-ascii?Q?+Nn5HpKFIvixuHuiNTlu9CKYdJvQ4xnDjyaj0IFYd2ba464e5xTxyYoZ1Sai?=
 =?us-ascii?Q?hESVArZgPwrt0G4SqBJM0TtdnaNN+vW9PQyjY23x28DNX5WqFXjxUxMHNskt?=
 =?us-ascii?Q?kE66vZGc2lKxCttwIJHfCZpLvcBPZwS0pyqLcqY85Bjieml3QHBVs9d/Vwvs?=
 =?us-ascii?Q?NCGlXzN4y1SZlXVuY0q3zMT8DNLQToa+dtViELacBoUEiySvfHVWCUbAK79r?=
 =?us-ascii?Q?mAsC8/JeSbzkO1tEIKhSX0E6zsgi7KxjaFZbSs9/qC+7WBTHcPvWWBW5OilG?=
 =?us-ascii?Q?fpnWAdO7KPlxbeJMZvYfPFHfPHLhmxdVp7Zat6esmpDnsb9hleL6t84mKP3V?=
 =?us-ascii?Q?0Gg936IFioBLpBc=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 15:26:04.3683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5b7df8-1bda-4783-8e18-08dd49e73bb2
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000952A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P195MB1016
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
 configs/phycore_am62x_a53_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/phycore_am62x_a53_defconfig b/configs/phycore_am62x_a53_defconfig
index 0494fc408b7..d7aa59bf1dd 100644
--- a/configs/phycore_am62x_a53_defconfig
+++ b/configs/phycore_am62x_a53_defconfig
@@ -13,6 +13,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80b80000
 CONFIG_SF_DEFAULT_SPEED=25000000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0x680000
+CONFIG_ENV_SECT_SIZE=0x20000
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am625-phyboard-lyra-rdk"
 CONFIG_OF_LIBFDT_OVERLAY=y
@@ -84,6 +85,7 @@ CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_NET_RANDOM_ETHADDR=y
-- 
2.25.1

