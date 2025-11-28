Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B93D116E2
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 16:39:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4C9A83BF1;
	Fri, 28 Nov 2025 17:39:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="MOp0t9aU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 591B783B8C; Fri, 28 Nov 2025 17:39:08 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB2E0838FA
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 17:39:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WNkytF5KXuVmMKi4pdKikwkZEh1UO22H49gOdNVywHbuAuW8JlWPpwf8CneU99VGEiW7+dl85e3Tb74985AIJxXPh/EPpTkwhlStlhRVtuNe9tO6sZr8kw3rnZ4JpAlsmeFrK4beQvA6iERZi4ekBdEVM/6mP0J8XxTi2AvNvHgv22McRtx2nEqHpOPgCCkZeMCBgc0rUWgjqj1E9io5I2yp2m2xFev0cqpquip7QYojbAOs4WTpmg6EcsuUVUiMWNor030O1L+Yn7fznzYp11juPrQIg12aDAhSrWctMyHLU/UVHk3j8uYEpTBBolxcpSU4/p9nqUCi7YRKei0aHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJD11xnfxu492QyXaIPkT3J+wWvFujDpBDxiTeFxtis=;
 b=axa+JyrAb2q1v3JuWmj4iqbXw1CwKJvsZef7MgrY32rJK1oRaUhwK5rfCwqGyQN5BMwzbwqRW2siJp2yVBeZxPX2Bn53rClrD8HYKeDuSzom1pJA8DfwWanWJ8sX2hJljFL1r7bMdbMCeTq+nj49w7wOeQ+TKykGF0yw0RU8phR6CPU1vSzzgxYNdcHQyVgMhVUCXTRn1yT1Tau9KHXUXXi0C2G20V9IYiIOXZ+oeC5+rbmrGjI12tODHhWR1hYg+XppBdicvZboBK6xO9eDUNCe4YjEjr3fvfpxyrx8p9QyBzJSmiBthLxclabvHLKvG9B5FaYqJv4TOHo3wrxNOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=mailbox.org smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJD11xnfxu492QyXaIPkT3J+wWvFujDpBDxiTeFxtis=;
 b=MOp0t9aU4m1z7U3lFYwXyt6IarI1Rwzc+pA8oSOuAYXMp8IaMEdccLKAJrFF721pLtSwBiHdE0RCYiHe6vnaZkENGCr0CmY5pHWZ0PCEzWepLGfFMg2DXX+nKo2K9EocnL3TGY8YkhJZtQKIugKnm0jjio1hVYUzDVZS3SBD4Kd6zQK/plzc3XN2BrB9hlk4hvG1FXa7jiJWdPVKvBWrXYkvXgX6bY8chYxNo0vzIy5Xm4lmCvda+vFuk0jL9YSx/5Ja9XZK/r5R8uz3+IjILsFcN5fZjeWwXuIUgnrKsddeqgT37ixbLmCaCAefZrIR5XDuMXP5mesBfeMvzowX/g==
Received: from CWLP123CA0257.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19e::17)
 by AS4P195MB2010.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:587::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Fri, 28 Nov
 2025 16:39:00 +0000
Received: from AMS0EPF000001B0.eurprd05.prod.outlook.com
 (2603:10a6:400:19e:cafe::be) by CWLP123CA0257.outlook.office365.com
 (2603:10a6:400:19e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.16 via Frontend Transport; Fri,
 28 Nov 2025 16:39:00 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AMS0EPF000001B0.mail.protection.outlook.com (10.167.16.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 28 Nov 2025 16:39:00 +0000
Received: from [192.168.2.141] (172.25.39.126) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Fri, 28 Nov
 2025 17:38:59 +0100
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Fri, 28 Nov 2025 17:38:41 +0100
Subject: [PATCH v2 1/6] phytec: adapt env to ampliphy-boot bootscripts for
 imx8 boards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251128-wip-bhahn-imx8_cleanup_env-v2-1-93ebfd1591c7@phytec.de>
References: <20251128-wip-bhahn-imx8_cleanup_env-v2-0-93ebfd1591c7@phytec.de>
In-Reply-To: <20251128-wip-bhahn-imx8_cleanup_env-v2-0-93ebfd1591c7@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, NXP i.MX U-Boot Team
 <uboot-imx@nxp.com>
CC: Teresa Remmet <t.remmet@phytec.de>, Tom Rini <trini@konsulko.com>, "Peng
 Fan" <peng.fan@nxp.com>, Leonard Anderweit <l.anderweit@phytec.de>, "Marek
 Vasut" <marek.vasut+renesas@mailbox.org>, Martin Schwan <m.schwan@phytec.de>, 
 Yannic Moog <y.moog@phytec.de>, Simon Glass <sjg@chromium.org>, Yunus Bas
 <y.bas@phytec.de>, Stefano Babic <sbabic@nabladev.com>, Fabio Estevam
 <festevam@gmail.com>, Benjamin Hahn <B.Hahn@phytec.de>
X-Mailer: b4 0.14.3-dev-2ce6c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764347939; l=2366;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=lcsHiWy5wqydz5D4/a3S6G9qQ0y1LEeB3IBmUoj6flo=;
 b=Q+3GG4Ltr6Og5u0MmbyrUWWISEECDl3o0fvkYkrMJaGG2V+r37OfWLGTd33RyisPOMbJNXis9
 8n42REBLpfoADWHIhibpNfxtOic+/NHy1ExLWZmG7G3N47caSswyzqj
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.39.126]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B0:EE_|AS4P195MB2010:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a1ffb81-a7b2-46b4-a5c9-08de2e9ca21d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZTBrRkJvNkpsczhKRC9BN0JiSUtFL1IvMzJCU3E1MFdUQzdUbmptWkhvN3Yv?=
 =?utf-8?B?K3hZVEdxZ1NhMkhJR2VucC8xdVhUSmRFOGhXTE1pYUZDVjEyL0kzcEV4N294?=
 =?utf-8?B?Rm9URGJTdm1ZanBTUTdUK3hpZzlaV29EUFM2U0RTRDRWNndaekgwRE5obW5M?=
 =?utf-8?B?SlhuSThaUGtyMllhUlFEbnNMQ1o4MHFBY3BYRXIzR3gwdEIwOHlQZzdzdEQ0?=
 =?utf-8?B?eW43RW5hUXN5VXRWY29QU01qK3ZYd3NXZmNVRE1YT0xBdFIrN0tWMVA0c054?=
 =?utf-8?B?MmM1UVh1SzNhUUNZYXZiN3pnRGYwZ3NSUkQ4T3hQNEEzK0JBMEl6L1pIQXd4?=
 =?utf-8?B?THJJQ082U2E5Nm5Zb3dwWXBVU0pRS2gybzVXM3huNE4zWnhsQ0dnbG5FdGlS?=
 =?utf-8?B?bE4yMDRaQ1REc0Y1RG9ESXNtem1GRmViUklPQWhBNkFSS09LOE5tY3U4WjdC?=
 =?utf-8?B?aTlFcUo1R1gzVWw0aXdEM2FiMHVYZHpURmxqaVpBd1JrS3gzMi9PYjBLeTE5?=
 =?utf-8?B?SUFlWU90a0hmcGFqYkhhM0NhWHRmNEhka1dZTU5DYzRxN08wZHNsd0dQRmF1?=
 =?utf-8?B?WEJtMUphcHBJQWZBeUxJaW0xSlhybGlueEFtbUw3elVjWTdZK3FUaEE4Vi9B?=
 =?utf-8?B?MUd4YW1LcDdCUmk5ZEJaaGRFQlE4SnpMMW9pVnVJbHpwRHEwUEFYNnFnZTNM?=
 =?utf-8?B?NkxlRUtTSFpPK0xaRzgwS3lHMzBieElKa0FOT3ZMWGlkVVVXN21Xd3VDUlEr?=
 =?utf-8?B?SlgzUGNCY3FpVlJhNm5wVHpzSFdNUEIzTFNuZmJxdlV6aFJ1dmgvZ0pxZTEv?=
 =?utf-8?B?VTBPcFl2b3NzYjVTWUgxNmtEVU84MFAxVWdYS1RkbVUrRzNMOTBFQi9yTTBz?=
 =?utf-8?B?aWlBNjBlUmFwVkFyODMvcmlOZ2lqV1pWcHRxVUxpNHNid3Q4ZFNvTlBQM3d2?=
 =?utf-8?B?b1ZsK05odURHLzFRMjB3MGxoaFBkS1poTkpWNUl5dVMvcnV0bjZVV3Y2M1dt?=
 =?utf-8?B?YktaQytPejU4bWw2cGl2Rlg4dUhucDJqRjkzbHRuWkp4eTZKdlpSOHJNbER0?=
 =?utf-8?B?QUMwWjdZakU3SUtnZ1pBNVhMQWRSZm5UQzk1c2QycC9jbEhQMDZWRTJveVBr?=
 =?utf-8?B?cWVxMGFQb3lTSEdpWDc0SHhQekl4RnBPL2hqTEIzUG05R2I3SDRoUTE5MnN4?=
 =?utf-8?B?ajRtNkJzamRnTFplY3BXY2ljZFFOcE13NjZLcENwWXdUZk9lT1Yxb0l5U3Ir?=
 =?utf-8?B?MlUyTnpYalRraG9GeFFQeFlrN0s3K05pSmhSMzFxR1N3UVdhRGZSY1pmb3lW?=
 =?utf-8?B?K0JjR0t4SDJRTzZSK1d3ZkFGeEJZSnRkLzBXdnltOE45amUyUWJiYkhycXhO?=
 =?utf-8?B?Z0U0bTF5OVMyTVpTZStTMWxSMnZHWEpRMXhMb3laK0E0NFVmcTA1K3lMeEFI?=
 =?utf-8?B?OUNQNDlMelc0MjJ3aUFzMTV2TUxIQllUZStHRFJkRzF2QVVXWnFyaGFmckwz?=
 =?utf-8?B?UGkyQkhvRmZyRk53Z01WSmdJbEswcVIwRnVmNFNRRU1JcXZrRS9Pbk1Nc0Zl?=
 =?utf-8?B?NGNCWVVDMVdtc1RZN0tNR0hER1JFNUVMTXpZZFZHVFh2K05TVmFDemJ5OEl0?=
 =?utf-8?B?ZUdYS0NtcW9nSG9NcTQ2NGxrWTRwczM0a2dPRmJjLzd5WlcrOVpCbDFmMHZh?=
 =?utf-8?B?NHFDZkVUUi9PTGUwSURqVmJ0bnZjVWtsMkFuR3lOUllNKzhHTVZDamE2UEpC?=
 =?utf-8?B?Zk1oTmR6RHFRcG9HY3ZNZFFrTjZCRlRTWU95WmFFekFmYzRXLzJaR0RvZzds?=
 =?utf-8?B?Skw0R1BPMTE1emhsSU5SZ1l0VTROam96cGp2U3gxdlFDbGVNQmNOVTAvUERV?=
 =?utf-8?B?T0xtVkV2NUhLZGNvd240WERCbk1kcGYrSEdoVzNIWFVsQXJFUVBINVBuZkpr?=
 =?utf-8?B?cmYrWEdHN3NvSVVuVW9oWHNGR2VkelBjV2h3Nmh2dTNwODVKanF1NVBJQ0RQ?=
 =?utf-8?B?R3AvTGhGQjhXSnpIc3lPQWt0KytVMU1naGxlUDBadHZzVTkvWlZnaTlmQjdV?=
 =?utf-8?B?UDVrdWVXcnMwWklFN0VFVTdacjFhU0JielYzSmREMWJHN1FwSlN2VmhjczFk?=
 =?utf-8?Q?yW7Q=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 16:39:00.2423 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1ffb81-a7b2-46b4-a5c9-08de2e9ca21d
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001B0.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P195MB2010
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
bootscript has a builtin default. bootenv_addr_r is no longer used, as
the bootenv is loaded into loadaddr.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
 board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.env | 4 +---
 board/phytec/phycore_imx8mm/phycore_imx8mm.env       | 1 +
 board/phytec/phycore_imx8mp/phycore_imx8mp.env       | 3 +--
 3 files changed, 3 insertions(+), 5 deletions(-)

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
index 70044997adb8..8fa275e388cf 100644
--- a/board/phytec/phycore_imx8mp/phycore_imx8mp.env
+++ b/board/phytec/phycore_imx8mp/phycore_imx8mp.env
@@ -9,8 +9,7 @@ bootmeths=rauc script efi
 bootmeths=script efi
 #endif
 boot_targets=mmc2 mmc1 usb ethernet
-bootenv_addr_r=0x49100000
-boot_script_dhcp=boot.scr.uimg
+boot_script_dhcp=net_boot_fit.scr.uimg
 console=ttymxc0,115200
 dofastboot=0
 fastboot_raw_partition_all=0 4194304

-- 
2.43.0

