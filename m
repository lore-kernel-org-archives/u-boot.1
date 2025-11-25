Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9473D0EE0F
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 17:24:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 911C184112;
	Tue, 25 Nov 2025 18:23:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="g/z7lmEM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18631840ED; Tue, 25 Nov 2025 18:23:39 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0604484118
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 18:23:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HHncYK6aAl44v6NeYgc1ceeapVwBIH3aow4Q32Ozdh3Ms3nRilVrzJxp2W2dWgH/cgBeckl6ludX2jvNMY4bIpt14udM9Pjtltn/TfjiisBZlxPituoYaE2+fYMKbJnfvNbu77NYsMPxC9t0W2C3MknhacW1dHCWr7yC3PbNes2eAih/kraZm/lW+oXcwKrUS4sx2UC8QQjLw+krcfHWZNh3K34nO3DRhStPd2u4BUkC86rJSk2IiHai6Jzee95MPlwcSfhdtF8PXU1JtYKN7Won6Iyov394D6WqRfsF8wOnMMeN8aUTwPnQrSWklKGlfOoycbMvgQlsGPdyuWukCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQEaDA6bG7M8NPFufiHjP86I7zfULXpprgA0hxXpDok=;
 b=SzVCIvqTVCtO0BNwGmMW7oxcNCKOWwDSZQgHp7LkXy22cxDq7DZ12A2jc/Zg+5bhskZj8GjneNDjFeTOVuaiCCgIVImN6x+6AhFzSzuv20OWjRslQGurBXPkk28bMtOiII8YoeyW6Iuv6uYlEtoGwSUT3d5B6XRftAQrqhR2p9AqDKikxdjSU2U9/QsIEc6X08yMchKWbBwWFvOIoKME769/HlSW2g47YSM+jA91H7eCJDoXhFAvOEVzAG+UP98wvPIY+hsxzpuxh3t8wdAcmv9bsLM3g7Mw2aVsqmBq62bxEOnVrNDScUCiliFkE2fq7off05TD3YRk4GP2vbkJYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=gmail.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQEaDA6bG7M8NPFufiHjP86I7zfULXpprgA0hxXpDok=;
 b=g/z7lmEMPoUc3UwzOFCU/MBefjTZ5OUxl3E4urnIHukr5kSN5EI+BaKPIM7YWzpc1plDYnHzRRtMr9ALn3ckC0rqhsaf8pFEZvTL4S8DO7e46lMl1sHSXcqCsKpZZ5rQlTvDnlEj6OtNsjKCsDqo5gSWRQq6yJ4rmOxHOuYoixIqeC2kzFXhueLnQFMkf34UlDMBTaUcHfv7sUjNuur9+XAPSc89zbv3oH0Q3Pcc+JYrUB2ylvcYtwTlcepHS2ZN8zgxfidYNeWEsDOJOt/OkdrjWfwIIYkJ6Fy64ngu7RhudPW8ime+Q3fBT2y9cYyegQT9Sec4fYJJBTX6uw2JYw==
Received: from DUZPR01CA0186.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::15) by VI2P195MB3031.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:2df::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 17:23:33 +0000
Received: from DB1PEPF000509F5.eurprd02.prod.outlook.com
 (2603:10a6:10:4b3:cafe::85) by DUZPR01CA0186.outlook.office365.com
 (2603:10a6:10:4b3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Tue,
 25 Nov 2025 17:23:31 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DB1PEPF000509F5.mail.protection.outlook.com (10.167.242.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 17:23:32 +0000
Received: from [192.168.2.141] (172.25.39.126) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 25 Nov
 2025 18:23:30 +0100
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Tue, 25 Nov 2025 18:23:15 +0100
Subject: [PATCH 6/6] phytec: sort .env files alphabetically for imx8 boards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251125-wip-bhahn-imx8_cleanup_env-v1-6-414829c01b4b@phytec.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764091408; l=2179;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=18A5Lnn/ufC8WAgTDIy1v9KrvTt5Tf6xG172p0fwk2U=;
 b=7Q413G64N6bpEyxkSj3jMDNYL1JYByuzm4AGsltmZhEqXtQs99xEfQXGG708ubBokWLXoCPLf
 fNdnKdf79+bDYnAq8NlCyNuB3OFjLrCHtQ4xxThhAnbHHrhm+cQHSGx
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.39.126]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F5:EE_|VI2P195MB3031:EE_
X-MS-Office365-Filtering-Correlation-Id: 04e26689-07a0-42e0-c030-08de2c475bfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?am9CSHdUdERkdXRDZXZUVG44VmpiZDFIYUNWZXFtRkYwQkZydGQrMjlyMWhk?=
 =?utf-8?B?MnFGZWkzdlN3b2xSTjVWSHZQY3pGQzVKZ3I0anZ0ZFlCTUwvcHBwWkNqQzRT?=
 =?utf-8?B?VkQrcUQ1bW5TdUcvKzBPZUpHUXZtNlltdS9ubTA5amE3dGtGYnVhcDZBcVBa?=
 =?utf-8?B?cjBsWHdYa01JUWdtZGZHK3o0Mk9KNEsvbUdTbFhxL2xPUGlkQ3E3TjJUNGNa?=
 =?utf-8?B?T3FBeHcvODdQWDRQTDBSN0d3UlpPOE8ySFVTVzlzVzg5NjBQcjdRZ09HcU1B?=
 =?utf-8?B?M3lTUWFZUjFNVzhHenIxWGF3L296bWtYK2pLWktuTkF4Vm9KWHgvYTVmZU1C?=
 =?utf-8?B?R2Z5bTF1c01HdWFSMVNvRnVCZEx1eW5CSE9sSVA1cW5sU0djVm9GZ0FHR0RU?=
 =?utf-8?B?aFd1Vkk5bWJRL2xFclZITmxGaVk1Mm5wdW5qTEdyeC9JMEc3amw4TTJxRzFK?=
 =?utf-8?B?VVppNUJEM01EcFNXUGViSkpjMUQ4L21WekVYMEJZVmRwSG1IcEN2Unk1QWxk?=
 =?utf-8?B?dUkxenE1L2xNVWlXSkxwem1mdFJMeHN6ODhJMWlBSUo3ZWJRbFFtVVBDYnRL?=
 =?utf-8?B?QmFzVXlNdXdGcVl0MktWN2hoNGxwUG5NOWlhbERmV0VKVndGOWVneTBDanJP?=
 =?utf-8?B?bE1OeVRJU1lOUk1YWUJDdWgvS2ZoYXkrZnhvb3JxZXZnVTJod05LbFQvN2or?=
 =?utf-8?B?OHNDSmFMZnRXbjFFWlN6U1F2VUhCSCtqZktRYWVsaE56ZWJ4N1ZUZVQ2Tmp6?=
 =?utf-8?B?RTF4WUFqMExSMUFnSGN3TTBTMGtsMytIZkxoVzBHUUNReEdSQmZ5OXkrc3Nz?=
 =?utf-8?B?NGdDZnZyN3pHZ002UzM0bWJJUmd3WjUrRXZ5YW1Kd0w5VmVzNTIzRjFEV1V0?=
 =?utf-8?B?K0sxaC9vYUhUb2VTM3orWEdMcmx4L1RubFNmV2JUeTJQcEpMVko5VmNtb1pY?=
 =?utf-8?B?eUxraDF3UmZNU3pYZVhuV3Y5SFF2VjJlcHJJbFpzcmFHQTJNaXZqaDVkek9i?=
 =?utf-8?B?Ky9aa2NiUFdrS2haR1l4aFVjNzg0ZDBUOE05dlkydk40a3AxVlF5LzNxditz?=
 =?utf-8?B?L1kwVCtwaSsxZGhWbi80NWRYSkMzRzJUeFcyWTJNdU93Tm5weGgzRjg1OUJ0?=
 =?utf-8?B?REVJUDRkOHc3eTNmZ05nRm5wMHpLMXhocG5MYW5TRFVQZit2QlRaR1hFNGJ4?=
 =?utf-8?B?MVU2ZlcreE54QmJ6RVp5Ti9GWlJHN3FFU1F1aTdDR0p6OUc0V01xN1Uyd0tP?=
 =?utf-8?B?a3hXWnFxWGQvL3hBbGIycTV6aEFLNFJ3NFEwcGNPZjlvQTNEVWJqUEdtNzJr?=
 =?utf-8?B?WE5welp4QUkxTm8vM29GN0s1V3o4QmZaRVVHRzd0a0g1QkMvTnFpd28zc1FU?=
 =?utf-8?B?am9yNksvdlFUODRxMHBhZ2h0M1RIcWRGc3RNcXBOeHlQU3dOY3kraDJEblRp?=
 =?utf-8?B?cUhqOEthU3B0SWV3dWhSUDMyaDRFZkNUOXU5R29jMHZseTIrWjVXWjFoR3cw?=
 =?utf-8?B?cVBNbWtneDg1L3YyTDh0V2wzcnZHWUl5bktqYTBBOGVNSm5DbytyN3RSUjRM?=
 =?utf-8?B?c2hTd0puR0lSYVdITnZxZGVTRTFFZ3Z2K3BOOGJ3c0ZNdFJFK1RMMFkvOWw2?=
 =?utf-8?B?YUNkRFpqQUQ4ZmhXUGNCZ05kaG1nM3JqWkh6UTV4enYvbmgwY2tnT3FkUWhI?=
 =?utf-8?B?cHRLQnE5eDBja21rNVp6QThFZ1p5cWN5T3IvKzd3dzhVS0FxSkM0SGdRSlNt?=
 =?utf-8?B?em5GbkN0VWZGbDRRSWJZVXZqcm8xU0w2Zm80eVdWSk5zVXo3MjdPTHVwclhP?=
 =?utf-8?B?MGRwSGlGVE1EMTRwZWhFRmk2emVQejM5dU1IUk5DNUw2d1VaUlA4aCtJN3Av?=
 =?utf-8?B?K1E5dUIrNGZyM3AyaWlLZDdTQnZMRjI3bk00ME9VbmxwTFQ2TmN4eVM1bG12?=
 =?utf-8?B?OEdRL25QbytKOEpIQnRHa2JSc2dHUkFYcytFSEpmR1NwVitCL1BwZDBJcWtK?=
 =?utf-8?B?SDJwMjB5aUZIT0FTd2tDMDRka2VlWHhUZlkxMjlJVTV6S2d2YnBRM2dXakxE?=
 =?utf-8?B?VlRSVEh0T0I4MUowWWtyWnlxaElPaXdGUm02cEg2bEc4TkRMMk5mbUdYc0JO?=
 =?utf-8?Q?ETjQ=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 17:23:32.9956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e26689-07a0-42e0-c030-08de2c475bfa
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F5.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2P195MB3031
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

Sort all .env files alphabetically like it is already done for
phycore_imx8mp.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
 board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.env | 8 ++++----
 board/phytec/phycore_imx8mm/phycore_imx8mm.env       | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.env b/board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.env
index b9f0b2fb8ccc..f064bbe3d31e 100644
--- a/board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.env
+++ b/board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.env
@@ -1,17 +1,17 @@
 boot_script_dhcp=net_boot_fit.scr.uimg
 console=ttymxc3,CONFIG_BAUDRATE
 emmc_dev=2  /* This is needed by built-in uuu flash scripts */
-fdtfile=CONFIG_DEFAULT_FDT_FILE
 fdt_addr_r=0x40480000
+fdtfile=CONFIG_DEFAULT_FDT_FILE
 fdtoverlay_addr_r=0x404a0000
+ip_dyn=yes
 kernel_addr_r=0x40a00000
 kernel_comp_addr_r=0x43a00000
 kernel_comp_size=0x1e00000
+nfsroot=/srv/nfs
 pxefile_addr_r=0x45800000
 ramdisk_addr_r=0x45802000
-scriptaddr=0x47600000
 script_offset_f=0x0
 script_size_f=0x2000
+scriptaddr=0x47600000
 sd_dev=1    /* This is needed by built-in uuu flash scripts */
-ip_dyn=yes
-nfsroot=/srv/nfs
diff --git a/board/phytec/phycore_imx8mm/phycore_imx8mm.env b/board/phytec/phycore_imx8mm/phycore_imx8mm.env
index 4bf017a20baf..f6d0c0553b5d 100644
--- a/board/phytec/phycore_imx8mm/phycore_imx8mm.env
+++ b/board/phytec/phycore_imx8mm/phycore_imx8mm.env
@@ -1,17 +1,17 @@
 boot_script_dhcp=net_boot_fit.scr.uimg
 console=ttymxc2,CONFIG_BAUDRATE
 emmc_dev=2  /* This is needed by built-in uuu flash scripts */
-fdtfile=CONFIG_DEFAULT_FDT_FILE
 fdt_addr_r=0x40480000
+fdtfile=CONFIG_DEFAULT_FDT_FILE
 fdtoverlay_addr_r=0x404a0000
+ip_dyn=yes
 kernel_addr_r=0x40a00000
 kernel_comp_addr_r=0x43a00000
 kernel_comp_size=0x1e00000
+nfsroot=/srv/nfs
 pxefile_addr_r=0x45800000
 ramdisk_addr_r=0x45802000
-scriptaddr=0x47600000
 script_offset_f=0x0
 script_size_f=0x2000
+scriptaddr=0x47600000
 sd_dev=1    /* This is needed by built-in uuu flash scripts */
-ip_dyn=yes
-nfsroot=/srv/nfs

-- 
2.43.0

