Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 122BCD49208
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 10:08:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B33208946F;
	Mon, 18 Nov 2024 11:08:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ua1yLuEO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5EF389463; Mon, 18 Nov 2024 11:08:22 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D9BA8946B
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 11:08:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/haDpcMS51kOvJpYiqu/XVSCdfCb6wcmZAUhdxsRGD4xjyEwY7dWYCHOrT9IVFBRxDMp1pU00x9HmF/Lhvd8FJm9LNEXGgwJ1AUXRzLsdoLNJzm0zKe/bexDEID62/UKhHAr2fYfABRTP5zJZW1F86SzNco/fp6CdOyk6mYSmepmHdIeB5Xw9Jyh6jbrA8XT7bbEUb4gmooGFBKR0XWeNptCPym3UzrZZzTmnHHN+41YD6eDyXb2g0M8xg6qWP86NqlQd85H9PntGSyNCer0xNz8vb+RmWZKsUfMh+3b8NThw4gbiX6W6T1UGyjv7pX2+GgXyfmFo9t0dFtrFWAqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FnJGoDyckuqDCKovJ6PhA7d0tcYMbJJ8T8G8yKBV3I=;
 b=atdqICyrHw0EWP9CS1CHKJzJnyKOcCvhAZrZjXBGDVK2WY+EFoezKZrv5ZDKa0auOUoc0vMefaaR6JZa5o8gmPJTmXY8Xo97aLOvygFOTPDb5EWIsMzMfRU2bTwZx/Qye14FztRnLP6vMAcH4K+6LiK9Kv1hiP4xTjCJr4vH0Yw7/cLs/J25j6RzwpUuS4rvPxRskKtvw3LBSusnHOd/Sh++E0UGL31OCeS8ojzTaHuf9sBuT86LqzgOpnvUZqgPl0KLnyY+zF/67Qzs32txc5/snZnGKpw3XmfmXVIBBjs9AixMZiI+COSPGGZv2j0iC3lzYmzCMNlf99gdkl2KCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.12) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FnJGoDyckuqDCKovJ6PhA7d0tcYMbJJ8T8G8yKBV3I=;
 b=Ua1yLuEORSIr8ycNjpwmcZeWdl5prcS1qEp7qXd1EHw1GsY3QLLyPwMRRT85D54Nu1EFJso1ML8MUxDovY4vjaD5jZUvKbbf0BsM3aFwZx4a2QoV2ciMwfh2ExHymPPxLc+CD+OtU9wEwPb88nRe+C91w2DSE2cyl+GT+mxElzY=
Received: from CH0PR04CA0064.namprd04.prod.outlook.com (2603:10b6:610:74::9)
 by IA1PR12MB6484.namprd12.prod.outlook.com (2603:10b6:208:3a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 10:08:14 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::36) by CH0PR04CA0064.outlook.office365.com
 (2603:10b6:610:74::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Mon, 18 Nov 2024 10:08:14 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.12) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.12 as permitted sender)
Received: from SATLEXMB03.amd.com (165.204.84.12) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 10:08:13 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 04:07:56 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 04:07:55 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 18 Nov 2024 04:07:53 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v13 0/7] Add the USB5744 hub driver as per new DT binding
Date: Mon, 18 Nov 2024 15:37:40 +0530
Message-ID: <20241118100747.30121-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|IA1PR12MB6484:EE_
X-MS-Office365-Filtering-Correlation-Id: bab0080d-468e-4163-18b2-08dd07b8ea1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWpGSTJLWS84VmgzRHM2aVRLZ01EZDJKR1czNzNpZjJtVDdSeTBDbUkwTUls?=
 =?utf-8?B?K0lna2dRTmVFbnZNKzdEam1Ib2VtYTNHNzlXdURzbU9NK3E1bHdibjNIbWZX?=
 =?utf-8?B?MWZlaDNqRnpCL1poeFNrVk8wMHRYUi8zMElVQjQ4VjVkNmVtS0FZa1JlTTly?=
 =?utf-8?B?K2k3Z3l3TDNFQXlpWXYrR0RNU1VibXhtaFZYOUJEWjh1bXd5NTlud3ZtQzVq?=
 =?utf-8?B?a0ZMN3FqSzl1S3JrdXUzMXhFRkxkTlF2YlpKYm5iTGdJbjVLRnJyTGowdC9O?=
 =?utf-8?B?RGptNGViVkwrU0J3UnVCSFJ6Ymo0cTNYd1VlTVJjMXpVeFlZNEhjWE0rQzlz?=
 =?utf-8?B?VVc0M3B2d3llbmhVOFpVWDFUQmpBcE5EY3QvUWcvdGp1VithQ0hpczNxMlZq?=
 =?utf-8?B?NU8raHJNNmFESXRROHJydnR4Nyt3cEc3c1hYZUJTTzBmSXdyQ0MwU3RBYk01?=
 =?utf-8?B?djdxaHFGQWdmeEFWNTlvNVNMSWo2NFNtWjRia3c1cWhYRVpqTzZiNDFVdmZB?=
 =?utf-8?B?aExBbTZzWmpXZlhabWhTTlg2dWRkNHBMZC9vSlJGK3lRcklqZXl6OFdoc0Mx?=
 =?utf-8?B?aE9zWUQwL0ZRcHNJWnZMWktYczFadFl2U0xkVjc2SWExbXZxSlFad3JxNDcv?=
 =?utf-8?B?alh0TnZjTFk3Q2EwM0tQS1Znck1EYlY2cUVrMDJzdkhaUGhQek5IU2FidTNW?=
 =?utf-8?B?d2FWYUx3TVRoajI1WEwyaXNVTjIvNkYwQk03ME84dGNCVC94bnBCZ1FYMkZG?=
 =?utf-8?B?c3hCZ0FkWHlOcytxN3NkSnB5d3FUNzZWZXcwci92QUh3U1RLMTlnR0U1SWVJ?=
 =?utf-8?B?WEI0TnpPUDNYbi9INTV5NGdBZldUQ0JQbU0yVG1saVJsMER3ODhLWWM4cXl0?=
 =?utf-8?B?dTZDR0JjZEh1b01iTzJPa1RxYS9wdmtLL2cwNkRhOGllcmtNbkZiMzkwdkwx?=
 =?utf-8?B?b1RwMlFGTWFNWFdaaGkxRFhva21CdVRlMEhOc1MyaFYvVTdlZHpJQ1E3TlJn?=
 =?utf-8?B?UzN4dStNOEVOd3c5dG94RklXeVBTRUprMzlmWVVlRFNxREk0RERNTWg2dDIr?=
 =?utf-8?B?azk3MDhiVGpGTXVaWTFvY2R4d0FBRDJDdmhZa2VLc3FJSEJlYTVFOHhteHhW?=
 =?utf-8?B?TFJNL1NEckl5OWhjUzlrcklWeWgxYld3NzBnRFJzT2Zzd0ZXS1ZJUWNSQndu?=
 =?utf-8?B?bnZnOGdKUnRyT0Y2Y2ZqYkp2SExQU0hXdlZMaUh3R3Zmc0NMQlpyUkVQWXcr?=
 =?utf-8?B?WXR4QUcrdGJ1eGJ3TWx0QW53ZHNnTEV2bTRuRyt5eDY2Z0lQTnc5UlhvTW5v?=
 =?utf-8?B?NzQ0UUVvOTlOUnY3c1A2NzFLTU55clVpcjZqM1J6ZjZzOC9pdytGV1o1L0FQ?=
 =?utf-8?B?Y1BEdk9kMHpxbVJDWWhqRnU2MitLNnFPZlhnQ2lXdHg3QW9EYWtyamtKbkNl?=
 =?utf-8?B?bHE3Um5HZGROSlp3ZW9nUUx2Q3lVdU00bFg0aWhpQUJuSE92Mmx2NVhsUU9L?=
 =?utf-8?B?U05OM0FmS1N5VUZjOXhYb2VKV0xjNjcxSjZTbFM1WmdnNTFhTTk0bXF6STVK?=
 =?utf-8?B?VVdvbEQ4WEZBejNvN2JxRzQyRzloaG00YWNrK1FKWmZqTDJ5Q1lKRWZveW9l?=
 =?utf-8?B?dEF0azZ3TnVxY1MxVVFzMmpXZkhMdmZkYkUwSmpYVHlBdzlpL05sQTQvMmVw?=
 =?utf-8?B?L0gzWm42RFQzUzJ5SzcvK3BuOGtNaXNqcVZITUhGMS9NZnRYeWZBVElWVXZr?=
 =?utf-8?B?UlhBVDdVd29QVGYyWHJrZXBBSUtCdlI0RVBiQWxWdkJianZYMmlpdS9lZ05K?=
 =?utf-8?B?bUR1UkdZeHdkWkhVeWVUNllkai9GTHY1K2daNGRaeWlpUFViQVE2Z0xDaHhP?=
 =?utf-8?B?OGtLaVR6OUxnNVd5RUtZL2NPWFNjSm9SemhKTFJNamFhRnc9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 10:08:13.8562 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bab0080d-468e-4163-18b2-08dd07b8ea1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6484
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

Add the usb5744/usb2744 hub driver which does the reset gpio toggling
and the i2c initialization sequence.

Tested the USB5744/USB2744 usb hub for usb0, usb1 with the
DT nodes on KR260 board.

Changes in v2:
- Added the power_on_reset_us variable, for post-reset time.
- Removed the DM_REGULATOR ifdef around the regulator API's.
- Rename the i2c_init and fixed the return for the API's.

Changes in v3:
- Rename i2c_init to init.
- Fixed the return values for the dev_read_phandle_with_args API.
- Removed the unneccessary cast uint8_t *.

Changes in v4:
- Fixed the indentation issues.
- Fixed the Reverse xmas tree for indentation.
- Replaced dev_dbg to dev_err in all places.

Changes in v5:
- Add new API for usb_onboard_hub_reset.

Changes in v6:
- Add return for usb_onboard_hub_reset in probe.

Changes in v7:
- Sort the structure onboard_hub_data data.
- Remove the variable gpio_desc * for dm_gpio_free().

Changes in v8:
- Sort the list for usb5744_data.

Changes in v9:
- Added the Reviewer tag for patches 1/4, which got
missed in v8.

Changes in v10:
- Removed the GPIOD_ACTIVE_LOW flag in the devm_gpiod_get_optional.

Changes in v11:
- Added the usb2514_hub_data and updated the reset_us to 1.

Changes in v12:
- Updated the power on delay for usb2514_hub.
- Updated the usb2514_hub_data in the patch 1/7.

Changes in v13:
- Updated the reset and power on delay as per the
USB5744 specification.

Venkatesh Yadav Abbarapu (7):
  usb: onboard-hub: Add reset-gpio support
  usb: onboard-hub: Fix the return values of regulator APIs
  usb: onboard-hub: add support for Microchip USB5744
  usb: onboard-hub: Add i2c initialization for usb5744 hub
  usb: onboard-hub: Bail out if peer hub is already probed
  configs: zynqmp_kria: Enable the USB onboard hub
  arm64: zynqmp: Update the usb5744 hub node as per binding

 arch/arm/dts/zynqmp-sck-kr-g-revA.dtso |  48 ++++++
 arch/arm/dts/zynqmp-sck-kr-g-revB.dtso |  48 ++++++
 arch/arm/dts/zynqmp-sck-kv-g-revA.dtso |  18 +++
 arch/arm/dts/zynqmp-sck-kv-g-revB.dtso |  25 +++-
 common/usb_onboard_hub.c               | 195 ++++++++++++++++++++++++-
 configs/xilinx_zynqmp_kria_defconfig   |   1 +
 6 files changed, 329 insertions(+), 6 deletions(-)

-- 
2.17.1

