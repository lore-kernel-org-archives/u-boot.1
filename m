Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD9FE83070
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 10:00:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B285A8405A;
	Tue,  3 Feb 2026 11:00:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="cZDRXCxY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4608C8406D; Tue,  3 Feb 2026 11:00:43 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C56D8404D
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 11:00:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oaqIOGLxsP/18/+s4AbyQvaN7gdIxbMXmrOoD4DrnLhUEamMvt+kIPDogIvuti+Cq7jSoMAhGP+OWpZgd198CWw4m/5nj6kmJlp1DOhri5HYzVk6c7BOllz0PJCskQddzQsW9+1kcdzzO7CtR8HCoc+2etXEWFegtUkK9Dk6iz7u9bP1l7Gj5u2nAVrY0IMFldAglZKJzoSw5u3zBUR1CcCuJftgAz0MguPeQceRwnedu/Jc6QKYLOEL7lUtel+YQv9QjrFleXoF/7mvSPZ//FfnJAO2zhrKNQe1yyOt+3QfSPS/VJdZl3aUHtdG5j9cvDMCFwfk8hO643om6Jo9nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dydN1RvPSsXJ/rIvjwK2gq7IKDspiWrcMzmPCpc9xA=;
 b=QMI8/kZ9V+ldiRFaUk5sPMJNoHULtm3F69+IPM+AzFHpMGWikX4QZog9W3pgg5O4tjVJQmeBstcHUxzdKRfn8Gpm1wp+DhWYafBhUhBcMQMTApAvOeq8LRWE0L7A4oKUnD9Aab23tly+6dq9VnLQpj95TL5uKD8UJIjQcoIIO/XIVg+SKdXCl/nwlhQlMurQga9hw4T3acIVtRkcQzuGL7uWAbOrXW4T1huy/YTzwwo5M26G44bSKCpms0Zp87IoKrckWiMGJZA+OTZni0azD0tEA0SnuPn19v8iGcvFCSb7K4oVj9h8Cm9cTllz7WSP/613coVBhm99K+3FOitAnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=linaro.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dydN1RvPSsXJ/rIvjwK2gq7IKDspiWrcMzmPCpc9xA=;
 b=cZDRXCxYp0+duJjbEu7b/9HWrPDrKIx+nXTcbG9ha1pcQ3n8Z7eANuLD2Oz4gq9UWMSAvUkI4swXUBgdwoY0XZzQVxkaNoxbpP8qC3W6w7xAzdvW8pDkZOnT+qVcExnQZFs7iDRbaK+c5ZzHutH6u9mh49pF81rAIbJS6oa05Og=
Received: from MN0PR03CA0030.namprd03.prod.outlook.com (2603:10b6:208:52f::19)
 by DM4PR10MB6111.namprd10.prod.outlook.com (2603:10b6:8:bf::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.16; Tue, 3 Feb 2026 10:00:34 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:52f:cafe::a7) by MN0PR03CA0030.outlook.office365.com
 (2603:10b6:208:52f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 10:00:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 10:00:34 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 04:00:31 -0600
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 04:00:31 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 3 Feb 2026 04:00:31 -0600
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 613A0UH83751464;
 Tue, 3 Feb 2026 04:00:31 -0600
From: Anshul Dalal <anshuld@ti.com>
Date: Tue, 3 Feb 2026 15:30:20 +0530
Subject: [PATCH] board: ti: am64,j721*: use correct fdt if eeprom detection
 fails
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260203-eeprom_fdt_detection_refactor-v1-1-276eecbbe398@ti.com>
X-B4-Tracking: v=1; b=H4sIADPHgWkC/x2MwQqDMBAFf0X2bCBGWkp/pUjQ7Eu7hxrZBBHEf
 +/S4zDMnFShgkrP7iTFLlXKajD0HaXPvL7hhI0p+HD3wY8O2LR8Y+YWGQ2pWRAVeU6tqANzZr+
 E2/IYyB6bGTn+/9d0XT+SopctbwAAAA==
X-Change-ID: 20260203-eeprom_fdt_detection_refactor-eddfd0b25b81
To: <u-boot@lists.denx.de>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, "Guillaume La Roque (TI.com)"
 <glaroque@baylibre.com>, Jonathan Humphreys <j-humphreys@ti.com>, "Sam
 Protsenko" <semen.protsenko@linaro.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Martyn Welch <martyn.welch@collabora.com>,
 Dhruva Gole <d-gole@ti.com>, Peng Fan <peng.fan@nxp.com>, Anshul Dalal
 <anshuld@ti.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770112829; l=1928;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=ihSr/36+13aPRIc2FQaOLdvdQKHtIUaqh855ZZExIYo=;
 b=9ihz8kfd3sYsHglLDIr+OweM9lPJt7GHXyKxP+8t/ZK25D22+AW3aQV8W7a5toyZIffseqfOM
 4NCYzQ8oYelBNRHwk2psvEDdhw+VaOAfeiv+NLsxTH7v8G2JbE1RKQz
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|DM4PR10MB6111:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b41eea8-cdc9-4d6f-a721-08de630b12da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TlErcEgyTHlocUZENERRVG1uKzFQMnl6eGNZYXZEZ2QyYXBFMUxudTV0bHYr?=
 =?utf-8?B?ZDk2bzc3eTBCNm42Ym1HcVFncVBSamRxMTM4MTlKWXRjN1F5QmpqNllRZUlz?=
 =?utf-8?B?TjdYWWtBUm1EY1VRQ2xXTC9Xc1ZoRFNIaHd2MVFzT3F3OVJUR0VnM2E3d09J?=
 =?utf-8?B?alFJMGMrSURMOU5hdTNkVlozWjZkZWh0RjZyVStxQUU5djd0VmgzdWhXYTls?=
 =?utf-8?B?Y2NBcFdubDlMc1lyUUMyZFUyR0ljTWp2RDVqK0R2VE5LQmJjb1RNeHBUdVZp?=
 =?utf-8?B?Qy9zaGRhc1ladmFNU1Z3VTl2aEhseThPdVlKZzQvaUhoQW05b2hsbFdsRkEx?=
 =?utf-8?B?NkpOMWlLbE9JU01ueU1Ic3FvRjR6THJjZ3NZbHYwQXg4a29mYWlJc0xEQzdC?=
 =?utf-8?B?bjZTN1lQeWpOUDhzWFA0N096dEVoRTRRQk9ubVFuRVJaRDhzdUF5dUtBOGxh?=
 =?utf-8?B?MTZoaG1INUR1dlhpak1WMkN5NXh0WlNLdUlTL2VOc2U4OWVIMGQzR2tHb3Yx?=
 =?utf-8?B?UlVtb2ZaKytLY3hOS01CSTdIdGptL2pDT2J6aXp3V0x4dmNvUHlNOWppQ3lq?=
 =?utf-8?B?eW51dXk0clkzVmFZOWJmSlkyL3EzQWtpUFRSQXo3L3VPMGpEL0xaZkpoaENp?=
 =?utf-8?B?K1RXZFB4dllibWl2WTYrRDBFeHhZTWlieHBpa2o1TE0zV2krdTQ3K2l3TE51?=
 =?utf-8?B?TEgvUEhSdVg3TG5ZclhVbURjbWM0ajU3RCswZm1SV1JudEhObmZ3ZlpaRWJD?=
 =?utf-8?B?Q3VBRXBJZWNEclo4dG1ramVlMC9NTTczL2s1UU5vMEM2V2psS013MXVweG04?=
 =?utf-8?B?d0NYQndRU3F2dnA4NHczeDFhM3FNMnVNNjFpTkxFMDd6TzZKdXVPeHloMUlk?=
 =?utf-8?B?cmRyVUFuNWM2M0Z5Ny9XUjhqazNCUXF6SEYyR0dSU2c3bTdJSFd0TTRqeVhK?=
 =?utf-8?B?NzB0Qnhic1ZpQTVTZG8wd2VkQVg5T0ZVWlRVcG4weGpsdW9ncFRjR1U2RURX?=
 =?utf-8?B?OXBaNzRJb1EvZllhSjRaVnA1a2FBdlF5QkdXT2puL2cyNmZxK1NrTW82cGht?=
 =?utf-8?B?U043TlAvckp2ZjlnZktSMHZSMldKUm9udjBMdjdETUpranNpdWE2QWZZR3Ux?=
 =?utf-8?B?RlQ4akhHcjdTa3QwU2xFbktVdTM5L1Rja3JYdk1DdE5vMjRDYlp2Zjh1bnlq?=
 =?utf-8?B?aEdVYjh0RHEzNVo3VHNkcm1tNlVzTVJGVnZFVVg4b2xJU1drWkxhWWZYNy9O?=
 =?utf-8?B?VEkxZGcwYS8zemk3cTNzUlpKNy9Ud0R4VVJabFpLOE45dnJaSjM1Sk5ONURN?=
 =?utf-8?B?TTc1WXBZTUFUNmpZUlp6eWZHSWtCL3RQbU5LeG5PaXBFbEpSVHI0Zmp0RlM0?=
 =?utf-8?B?S2FXenRVamRPbFQzQUI1U2JVcktCQ1hoUE1TUXJmd25Ma015dGtxVm1ZbEYy?=
 =?utf-8?B?U3BLYjAxeHhaT1plaWdsNXluVHgxOUFFNmMrTXRNaEkzbmwwcGJ0UW5yRzJ2?=
 =?utf-8?B?WVhGdWM4MDFOTklkTXlBZmozck9tSFRxTFFrZThLSEVwRXFjSm9vV3hlZnNS?=
 =?utf-8?B?bm1nREYwK0dnRm9mVlZQVXlIei81M21XNEFCR2xWaXpRSCtmRkNLMW8xRjRS?=
 =?utf-8?B?Z3ZJd2E5U3JwTW8ybGNRSkY5aFgyR0tSUkRYV2NrSDNkbFBPQWVBSGQrRWZC?=
 =?utf-8?B?bEtRSmREV0VGMTVIbzRoNmpRR0R3VnVCSisxd2k3MU45WGsxT3RkSTNQUjVH?=
 =?utf-8?B?QWZlY1Z5U2RQeFh2RXgzWjNDSWQzVlp6dWI4QjY2aUhGTktvS01mTFQzSDBx?=
 =?utf-8?B?V2pMMWxlanl0cVBNVjUva1ZRSk1WY2tENGVvYlNrc2FueFdUVW44d20zdHpQ?=
 =?utf-8?B?NnRINHdqZE9pYXg4QWFEZjBIYm9UWmRFdFhmVnBBUjdMYlQzZmdnUGhYcjE1?=
 =?utf-8?B?ZGphRmcrc0VOdEtXOXRDOWlhQk1LZUhOKzU3RmQvSWtadklMc1R0K1RTWGlS?=
 =?utf-8?B?TUhUclhJVUpBN2w0MWswejlTcWVpWUVyTy9GRktEeG84NTM0RTNMVzlDKzNq?=
 =?utf-8?B?dDlIMHJNVFNuaHdXQnhtUno0T2J5WTRadzA5c2tXRldMOE9nSVd3dGRrV1ky?=
 =?utf-8?B?aHk2MW11SWhqcmpydlZsOW1YNk5jYXQ5ekREZytXOVp6WWNUTmJXNUhuR2NW?=
 =?utf-8?B?VEIvUVZMQVZ1UlB4b1hDMUowZzdxeDU1K0RrUVRhU3FWMzVGTEFJaWZpbzhF?=
 =?utf-8?B?ZlVlemkzbFNsalNRWVlpNzZMM2l3PT0=?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: onY7iET93AngHa6vTkENEk/qUYFBm78SCEo6+YBin9nj07LAynv7G49Hym/KapghaMd+5PT4BE9+3MVLpB6A7g+cb7FllfXw7AdssTnliR7fr8Tjk8CnN734LYuuiDHbhK5LpUrnmBLbzF2n0dh3fwiCT3gYz20W88cRf+L9ZxxdlbxVOU+PpQEff7txHNaOv7wh1N4pZG/bob3eRU4hMcyOthJc5P6mGnmKCcOPhEdznKXQ4a0FeplqugMFHxN81ZkR2kSuGlTEcUOlZ6+j6wBqi28llFDtGLGLGkazLtnWTc8EzObRjmCP0WzICat71Bj+RMHl3Bag5rX4bzIpiPKyIr0o6Xot6HPLB+9ilm/oSdjsTDr4FTbTSl6I/KEeXJmS/9P5588+GNH5BCx3SnSdqCqpK3oUHDa9EUeh3njPCLQc2rwuiItqHN6bycz0
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 10:00:34.4022 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b41eea8-cdc9-4d6f-a721-08de630b12da
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6111
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

We currently provide default board names for each board in their
respective evm.c file. However for custom boards, this behaviour
overwrites the default DT as set in the defconfig
(CONFIG_DEFAULT_FDT_FILE or CONFIG_DEFAULT_DEVICE_TREE).

This patch changes the default name to be NULL which prevents this
overwrite and allows ti_set_fdt_env to instead fallback to the correct
DT as set in Kconfig.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 board/ti/am64x/evm.c  | 2 +-
 board/ti/j721e/evm.c  | 2 +-
 board/ti/j721s2/evm.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/board/ti/am64x/evm.c b/board/ti/am64x/evm.c
index 25076a8a588..c6ddc44d14c 100644
--- a/board/ti/am64x/evm.c
+++ b/board/ti/am64x/evm.c
@@ -138,7 +138,7 @@ static struct ti_fdt_map ti_am64_evm_fdt_map[] = {
 
 static void setup_board_eeprom_env(void)
 {
-	char *name = "am64x_gpevm";
+	char *name = NULL;
 
 	if (do_board_detect())
 		goto invalid_eeprom;
diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
index e030fe7dc87..7260dfbe4ec 100644
--- a/board/ti/j721e/evm.c
+++ b/board/ti/j721e/evm.c
@@ -363,7 +363,7 @@ static struct ti_fdt_map ti_j721e_evm_fdt_map[] = {
 };
 static void setup_board_eeprom_env(void)
 {
-	char *name = "j721e";
+	char *name = NULL;
 
 	if (do_board_detect())
 		goto invalid_eeprom;
diff --git a/board/ti/j721s2/evm.c b/board/ti/j721s2/evm.c
index b6d1964146d..92d5c849864 100644
--- a/board/ti/j721s2/evm.c
+++ b/board/ti/j721s2/evm.c
@@ -103,7 +103,7 @@ static struct ti_fdt_map ti_j721s2_evm_fdt_map[] = {
 
 static void setup_board_eeprom_env(void)
 {
-	char *name = "j721s2";
+	char *name = NULL;
 
 	if (do_board_detect())
 		goto invalid_eeprom;

---
base-commit: 1de103fc29761fa729dffaa15d0cfb2766be05e4
change-id: 20260203-eeprom_fdt_detection_refactor-eddfd0b25b81

Best regards,
-- 
Anshul Dalal <anshuld@ti.com>

