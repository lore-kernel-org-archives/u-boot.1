Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51B1D0EE00
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 17:24:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB14284132;
	Tue, 25 Nov 2025 18:23:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="QCKxR4wA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA91184127; Tue, 25 Nov 2025 18:23:39 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3AE684121
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 18:23:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pzN3pNQXRK2QjGr3dCLzur0RMNFjK7DmPjaNKYrJRE31nbX08Ey+/pvZ1EBkZLkmb0FQ0f00N0l1nnQqmWm52yYao5PDy1s/cK4Pot8udcRGyugfj+FLopy3hfNFhmkk+ad2kBWb+X1suahfB9Qrygq91Ti1Q5BfJLTL6YGO9nsmrDOnBwWith1tU4m61UMWv47Dilq7vB+9dUeXa1Vx0crWxX54NEq0/oo8/Mv0qu0bDboSYWYyEvLlS7hCN0ZHnl3CeQp6SNJSXQIs31kgIrLikhSsMi3fkv24ZFQDImymAXLkC7Tk9wJOvXW+mqTmul2y1htQ812Drtu4WtOshA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqMvi8HwORlLEzsq9Lz8GFeUskyIZSUZLCr9MC8VoZQ=;
 b=vo5DblFIvtXECqgUzYsqYShXAcTBtYIq3r+5rdyuO0V1WR16GPZPVmJ8+NlchnvaUKmVegjLVwIjtxT7TwyJ/dB2uEGim5L8LrT+X0protEti4VzzR9sN4Q7LEBawoJ1fh+JLQAqFy+YHQS4Z96OpnF9H5OHK9UT/+LwAETJGklID1ypcOxVy4CEla0Z/aQpDc7E7492dnCU7LG0YE3ksEQG6gi//kJyiDbGQ/wQ6i9Uk4aSTayMH1kfcXLe3yxaZEy+hFurw/VOuq/8/nm9b0CHTmKc3F6nQJcvFaxl4RIe3mTyh5EhROJv42M95IidlckQKWUebSC4FWcum5E9Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=gmail.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqMvi8HwORlLEzsq9Lz8GFeUskyIZSUZLCr9MC8VoZQ=;
 b=QCKxR4wAbBbvwTs0nabWKRD3eTApbsic9cId6AIeYeN+6zv8WXhrmJPqfaiKvju7Utjk7xPxYdRVosRVr+yjfFjCY/XN1wuG/ybPC5H5QfBJdeDdXdUPliqCLkyRu5smrSItbY6G4AFNysIB1eDU8s/jyUfC1swdBfX08vErcKIfx3t4ivTs3B5VUILIYGCoJwhO8FzlCDj8UVkm5gGMQaDzcf2UQXODGAYDryoftey2PdvVGXjc3nNOyesMF+FsEfkVZ0Dt0wuQpeWRnTHEn+8dqc9pZppyptA8UAtyoafT/6HmEGS0pL0SustG5taEdnLzw0cvH9CtLA+D+uWt/g==
Received: from DUZPR01CA0185.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::11) by GV1P195MB1950.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:150:9c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 17:23:30 +0000
Received: from DB1PEPF000509F5.eurprd02.prod.outlook.com
 (2603:10a6:10:4b3:cafe::a9) by DUZPR01CA0185.outlook.office365.com
 (2603:10a6:10:4b3::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.11 via Frontend Transport; Tue,
 25 Nov 2025 17:23:29 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DB1PEPF000509F5.mail.protection.outlook.com (10.167.242.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 17:23:30 +0000
Received: from [192.168.2.141] (172.25.39.126) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 25 Nov
 2025 18:23:29 +0100
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Tue, 25 Nov 2025 18:23:11 +0100
Subject: [PATCH 2/6] phytec: adapt env to ampliphy-boot bootscripts for
 imx8 boards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251125-wip-bhahn-imx8_cleanup_env-v1-2-414829c01b4b@phytec.de>
References: <20251125-wip-bhahn-imx8_cleanup_env-v1-0-414829c01b4b@phytec.de>
In-Reply-To: <20251125-wip-bhahn-imx8_cleanup_env-v1-0-414829c01b4b@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, NXP i.MX U-Boot Team
 <uboot-imx@nxp.com>
CC: Teresa Remmet <t.remmet@phytec.de>, Tom Rini <trini@konsulko.com>, "Peng
 Fan" <peng.fan@nxp.com>, Leonard Anderweit <l.anderweit@phytec.de>, "Marek
 Vasut" <marek.vasut+renesas@mailbox.org>, Martin Schwan <m.schwan@phytec.de>, 
 Yannic Moog <y.moog@phytec.de>, Simon Glass <sjg@chromium.org>, Yunus Bas
 <y.bas@phytec.de>, Stefano Babic <sbabic@nabladev.com>, Fabio Estevam
 <festevam@gmail.com>, Benjamin Hahn <B.Hahn@phytec.de>
X-Mailer: b4 0.14.3-dev-2ce6c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764091408; l=2291;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=TbT06pcqgM6EzmHACcdREt2p1Wx5RWa0qsvrX7NmRVc=;
 b=lPd5IpQxziMxGfwstuH1eSZ8Ju1QnslOtB74lHL2qSE6uwpBQEFMtH7DD8UiRknnRbNgGEoDR
 7UqzuwCooZlCcG/oK4NLFkju1QSVstBDTFa2pGDSqBwFqw0vrsK2KO0
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.39.126]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F5:EE_|GV1P195MB1950:EE_
X-MS-Office365-Filtering-Correlation-Id: 586432b5-d646-41ca-5e54-08de2c475a6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0NGcE5obXV6MTgzUWplY0kvNXRFOVJLODMzMjBSbWRuTkswMURqMTNGU1Va?=
 =?utf-8?B?U3FYa0FwSXROVkd0cEpZVFc0emh1aS9hQTV4cVhIdHhVd05oMUl0ZmRiYkl1?=
 =?utf-8?B?emN2bDlDOCszbzJzS3B1QTBMQW4xd29yTkkzWkthSW5wZ3EvOGM5M0h1R2pW?=
 =?utf-8?B?U3FYV25rbTBVbC81WFk1R1p1MDIySGdlcmJlV2t3NzJ5Tk5qWFlWcW4rTG1h?=
 =?utf-8?B?NFh1NHdjcEJ6ZGdlWW5BREc0SGg0UGFXcFNOUFI0VVpIQXJHUEJhSStSOXJm?=
 =?utf-8?B?RDRzeCtCTmJGSFg4Ni9LSXd1L3FFc09IclBKdmNBa25tZlFhUEdBYy85Y3Nz?=
 =?utf-8?B?RHR3QThZRUd3cG1abi9ZNGRjcUpOTXRNd09oTnh1bGFDUXdVL0t3Tnl0VlMy?=
 =?utf-8?B?QmtjZ2tmSjBIbXIyRlN5UjNTRERIRWZhWDUrVndwYThId204N2s5TEp6UnpS?=
 =?utf-8?B?L1pLaDAxZW90eGk0R1JWcWNBTENJYzhZR09jbmJncUs5dHBzdVMxd0Z5Z0dM?=
 =?utf-8?B?Z3ZXcWZpOGhOVkhTbUhySWZJaldIWFN4c2RlUEFwdFUzY2txZno4RExxWmRV?=
 =?utf-8?B?VTdwOTN5bEVRVlQzSXBobXRxZ21Xbk9oSVNabzdTaWd6TmE3SzdYSlhYajhE?=
 =?utf-8?B?RHUxMkU3ZE5NNmRNbTZQdFM2YXVSSmJ0UjRKcUlRbXdWWDJDK2toK0NpTXc5?=
 =?utf-8?B?c1R5bldpRE1Id2dqc2xJNFRyL2lIcXEvNkNKY2VnTk8zQ0hRUzQ5YTlxdi9V?=
 =?utf-8?B?ZTJRNTJVWktsUElhWmxlZVlkLzhqRzdnQjN3cDFtWnQwTng1MHZzbGZCR2V6?=
 =?utf-8?B?dFcrYlAweHRoWmVKYVI0Um9seUxZbG56RFQ3ZnZidTNYcElxaTRDMVN3ZU5a?=
 =?utf-8?B?MWNZNEpTWHVjSjNobXoyZFJCUjJ6cDdLWTBibDJQMkhjbG45ZnJiQnRlT3cr?=
 =?utf-8?B?TXdwbWRRRkh2RG9xbVcvOHVKemhUMER2VDNTTEZQNGVEa2ZwREpXenZqUnhQ?=
 =?utf-8?B?cUl0S2Y5TExhMmhOR2xrWlFzRWNKS0U0aG9USkluREovQU0vUnB6YzlDSm5Q?=
 =?utf-8?B?WnhBNFBhZTBKdjlBbjE5Z0JtZEVpMVB0UjhQdEMrK255bW9xMUVLODRSYmow?=
 =?utf-8?B?STVESyszNHYzQ3ZSRFVHQ2hiTWl3VDRWdVZuL094RXM4MlE0UGc3ZU16cjNI?=
 =?utf-8?B?SXR0Wnp3Sm1YNjdmQWEyRTZZYVpOMVNZMU56YjFMaVJReHpzY3lMeHFva1Ni?=
 =?utf-8?B?YnJVdE5iZHp3aUVJeFgrd0llN05ocVVEYUNRZTVVRmJMeVltV1FmSFFMMmNR?=
 =?utf-8?B?VENhckZPVHl6TmlwZkI3d25naytJdDhRSlc0VmtQcUJ6ZzRBYnNBY3ZsWWox?=
 =?utf-8?B?MnFuM2xadVVoaXQyTENHQitqVWMvV3dEWU16WStaZzVheElCL1JvSXQ0bHo2?=
 =?utf-8?B?N3UyRTZFM1RXOUljejZGTWxHVmFHVjVyTGR4MTNiUmxuWmJtTTlvRGpyd00v?=
 =?utf-8?B?d2t0Mjd1MXJ2aDNRVXdGZkhEZ0xsSGlJNlhZNmVnNGVMT0U3bU51Vk1oY21H?=
 =?utf-8?B?eG9NZW1tQjhud1ZjVzE1V1g2RlNtMGovVHJReGtNL21MYVY0T1U2T0tzencw?=
 =?utf-8?B?NnFmQWxNV1VDQ1QrOWU4NnUzNnZsSWIvMi92U2JPVWNpd0dGNlpHSkJvb21m?=
 =?utf-8?B?ZUxiUjJ2bUwrYVc5bHVFbWhrUHBnVmdHaGJGaTNDa21YTmJzWExuQXh4MUs0?=
 =?utf-8?B?NTdxS3VVdW5PK0pieHQxekNZV0dja3VySURqT0JjZS92d0R0TWNGUENZdjRa?=
 =?utf-8?B?V3FDMVQvM1F1c2U4SHRsR1l4N3FKeDNBajM2azJyV3g1ZDAzTG1lWTJqR0ls?=
 =?utf-8?B?UFZCVlJ3VWpTYWpOQWd2VDR6Rkd1SmpxaDF1NTVpcGw5OUZTTVBmcWFyeWxV?=
 =?utf-8?B?bnZaZ2lGV3dWMmx4cjVDbUpYQ0poQXRUdk5EdE83NWhobmRWRkVzcmNJTVYx?=
 =?utf-8?B?UWY4WVFuMDJpaFNlYitUR2FpaUEzVE42Wlc0dVNxZmRhd0dTazdUWkY1Y1kw?=
 =?utf-8?B?Z1FVc2I5cCtCNHRidno4NlhHdm9YUlk0WG9YMzVYZEpOdVJMRFYwWU5kYVRt?=
 =?utf-8?Q?fj80=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 17:23:30.3975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 586432b5-d646-41ca-5e54-08de2c475a6e
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F5.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB1950
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

Netboot script is named net_boot_fit.scr.uimg with ampliphy-boot.
fit_fdtconf is not longer needed. The default config is automatically
fetched from the fitImage. mmcroot is also not longer used, the
bootscript has a builtin default.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
 board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.env | 4 +---
 board/phytec/phycore_imx8mm/phycore_imx8mm.env       | 1 +
 board/phytec/phycore_imx8mp/phycore_imx8mp.env       | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.env b/board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.env
index c744248ab7a6..5fe49e2a375b 100644
--- a/board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.env
+++ b/board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.env
@@ -1,14 +1,12 @@
-boot_script_dhcp=boot.scr.uimg
+boot_script_dhcp=net_boot_fit.scr.uimg
 console=ttymxc3,CONFIG_BAUDRATE
 emmc_dev=2  /* This is needed by built-in uuu flash scripts */
 fdtfile=CONFIG_DEFAULT_FDT_FILE
 fdt_addr_r=0x40480000
 fdt_overlay_addr_r=0x404a0000
-fit_fdtconf=conf-imx8mp-libra-rdk-fpsc.dtb
 kernel_addr_r=0x40a00000
 kernel_comp_addr_r=0x43a00000
 kernel_comp_size=0x1e00000
-mmcroot=2
 pxefile_addr_r=0x45800000
 ramdisk_addr_r=0x45802000
 scriptaddr=0x47600000
diff --git a/board/phytec/phycore_imx8mm/phycore_imx8mm.env b/board/phytec/phycore_imx8mm/phycore_imx8mm.env
index b3f091543282..1eb255878ba2 100644
--- a/board/phytec/phycore_imx8mm/phycore_imx8mm.env
+++ b/board/phytec/phycore_imx8mm/phycore_imx8mm.env
@@ -1,3 +1,4 @@
+boot_script_dhcp=net_boot_fit.scr.uimg
 console=ttymxc2,CONFIG_BAUDRATE
 emmc_dev=2
 fdtfile=CONFIG_DEFAULT_FDT_FILE
diff --git a/board/phytec/phycore_imx8mp/phycore_imx8mp.env b/board/phytec/phycore_imx8mp/phycore_imx8mp.env
index 323199b041b1..96636651157d 100644
--- a/board/phytec/phycore_imx8mp/phycore_imx8mp.env
+++ b/board/phytec/phycore_imx8mp/phycore_imx8mp.env
@@ -5,7 +5,7 @@ bootmeths=script efi
 #endif
 boot_targets=mmc2 mmc1 usb ethernet
 bootenv_addr_r=0x49100000
-boot_script_dhcp=boot.scr.uimg
+boot_script_dhcp=net_boot_fit.scr.uimg
 console=ttymxc0,115200
 fastboot_raw_partition_all=0 4194304
 fastboot_raw_partition_bootloader=64 8128

-- 
2.43.0

