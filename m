Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A84D0D74963
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 05:23:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F285889207;
	Wed, 30 Oct 2024 06:23:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5mQnf/p8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DF45891E2; Wed, 30 Oct 2024 06:22:57 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::620])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 936B6891E8
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 06:22:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=luPEBa8N0ADg+TvfWXvuVjs/0RAMllZt0HjMyj8QWd1x+4702/zE2dse1Q5J9aoOhKdVp9QFCOdnu+8q95Lim+WnaGvg11uqwcdqd7xGX3gVqtjT8x64J8sl5vWS2lpBpGxuTVoGUKialcNmtJJTO9+9avD9XjLQ5kMVy7jZILmD8nZZpxhvQ8UaLQpiu1ToQ8wnVRy/qHtcIfoMBqkhWT1WdxlcskhkAgo0QCY8i6kX1Qnz5lxsypc5Rv8603/hp1CTqqAoLxjfjv3y/kM/P5lnNGHxmWul+XgngJcjSlb21KF/we+1bcoitUJ0JqfH+DUe5lF2cdvcOAPUvj7X1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mShNdzn05RAYvSwV9sw/g2bOHCHAR5FIbObj0Ni6qFU=;
 b=VvLnE0Qgi7vrQiVTZs422XiVCuha6neGYc0AfcxYd5lLcObIApCWmDc2OfHRtoKvQ7m3z+fPGD5o29FUHaNvynQv1fzUvyZbxNiL6ceAyfCQzDWSf6cKGlzD5fhgxvMq16/qcvpqOLL3ZZbS6Q+bM5vktGr2gI66UNClJORxJ5RTe9Ne1jgRtbqQFLq/6WKKwVm03YLIBtU20rDpLqWKUWWoEww95tq82jBS7cM7wfHJqpEoyZb/W5wvmciuTK5HLfoc7963D6uBbFQqZUlmU/7WALuvZbjc0Dkkj1gxzIQGJhClm6dY6wO2PorghTWeUYoAyBMTM88j2B0ERpQhvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mShNdzn05RAYvSwV9sw/g2bOHCHAR5FIbObj0Ni6qFU=;
 b=5mQnf/p8BNes88uAnqwcVjfuyNrSh+io/ZOlMCaBXJ047HEacZNsRc5Fl11Nrf7lHtWPM7b25CMQdLRlkS0HlB6g6wGAKfRS9WTlnDLAxg1tcIgyN/kD4RjNoAiPityPkvM3RJwi2567coXszqs+4wjJHXuZxu3DKxf4XMJaLP0=
Received: from BLAPR03CA0005.namprd03.prod.outlook.com (2603:10b6:208:32b::10)
 by PH8PR12MB6940.namprd12.prod.outlook.com (2603:10b6:510:1bf::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.31; Wed, 30 Oct
 2024 05:22:43 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::bd) by BLAPR03CA0005.outlook.office365.com
 (2603:10b6:208:32b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Wed, 30 Oct 2024 05:22:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 05:22:42 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 00:22:14 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 30 Oct 2024 00:22:07 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v8 0/7] Add the USB5744 hub driver as per new DT binding
Date: Wed, 30 Oct 2024 10:51:53 +0530
Message-ID: <20241030052200.24243-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|PH8PR12MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a10d183-69f6-4b3f-a2e6-08dcf8a2e15f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VkxyTXkzUjdtbis3cVVQOWRXK3pabHlYRGhoOE91YUlaZ3dWVkxGckpySW5O?=
 =?utf-8?B?ak9hWmFqclVRMklNNnZSYmEvazJUclMrZXNUOUE2UW1sVy9qRUlMejE4OG44?=
 =?utf-8?B?NXdEdkdrUVdrNjZpWERIRGhpYVYwN1B4dXJWL2dBbDhxckVTRkdJdWJoRUd1?=
 =?utf-8?B?ZG5RL3dzQytNM2lPRWpLWStnSlNkckIxQzdHNWxITVBJdmhIQ3p1cUtGWGVK?=
 =?utf-8?B?M2pDMlhJOWMxcEFUcnp6aktkbUNscDJuemR6aUg4a0xxbEV6bGw1b2RER0VE?=
 =?utf-8?B?YlcyZ1UzbHdwMy91ajI1YUxZWTM0d3M3SU9QZGczL1o1dzNXQnVoSFY3Y0FH?=
 =?utf-8?B?S1RLN2hFdHQ5WDY0dzI5dmxVcThOQ050ajVBaEx1cDFBa2YyU3M1K1BITUcw?=
 =?utf-8?B?ZnVVeWhCZFJUUk5kcGxDSjRtUWtueml1MzZMR0N5K25xeVZsZ3NsbWJTVlZ4?=
 =?utf-8?B?eXBNRkZXQnhYQ00xZzZmLzk5SC9jYXFoT2dpT1pFMEtIODdwVEM1UTdqVlV5?=
 =?utf-8?B?bG1XOHcxdEwzME1KOEJ2V01ENk0zazFlTUNVRmZWRTVQYnhXSUNqZlR0Y2pO?=
 =?utf-8?B?a3dXVzZXdTQ3bWdUcHVoSHNUN3NNSXFoM0h1N2ZjVlc2aTJXL2JyRUZnMFBO?=
 =?utf-8?B?eXMvZ2o5ZnNxbitVTlgvVDNWNU9RbHU4VVl1clgzVmlmVG1PQ3pKR0FuRXR0?=
 =?utf-8?B?WVI4S1BGT3U1OURvMlpLdVhxOUtUTkdQNEhVQlhGRjNBOHBiNVhtWndvQUVQ?=
 =?utf-8?B?R2lUbm5IMGFEWnRmQ1pobE5wVnpvYVkvWnFldWlEb3F4a2dtcXJGQnVKRHVy?=
 =?utf-8?B?UmJQUkhBeFFWRkluYlpqbzJXQmVVUFI3dE9hTzduMUR3N2x6QitidDZTNkxS?=
 =?utf-8?B?MzZZSSs1akJNUDEwOVVidzVQeDVhRDJsM3pGaEZDb2cyTGZRSy9XOUx5Yjh1?=
 =?utf-8?B?eWt6U2RXeWJYcnN1QXZDaTlLY1E3U3dPRjFVMFR5c0dwYVJDcTY3cDdHNHBo?=
 =?utf-8?B?bjY5QTJxZ2t1SURPZDBpK0tIMnFqbTE0RytsQVkxa0ZwZXRxSGg3Y3IxbWcy?=
 =?utf-8?B?QlVSSnROSzgzOFVtVjJQZVZ4U3FCb3UrcEJ5NFA3YlBmQ2hIY3dPTUJ5TlM0?=
 =?utf-8?B?UW5Wejc0SEZCMzZDRUJYUjlzNWJuYlhucmg5bDRDOEZBbzFEVDZYOHlCMExs?=
 =?utf-8?B?YWVBaFhUZkdzMHpMUzU4ZThTQUtsSllsZFdYMVZpbmlSOHZLM3ZDQXpEeWFo?=
 =?utf-8?B?UDNnM3Nicmw1UEVCSDY4bURXaHRqSmtaV2JpZkNhaFo4WDczaXhOTStlTmxS?=
 =?utf-8?B?SzFvc2ZOSDF6dzZnYjN5L2dEZUFCa0JWRHY0ZWpoMnBLZDV6VkVCWTNoOHdL?=
 =?utf-8?B?R2MwZXpSMUJjMHdCZENkWWk1ZFhxYi8wVzIyTTdpV1c0NXNFZitqV1RaVmlS?=
 =?utf-8?B?MFFaL0JKckNLQUUzSEpZU3hqK1c5aGxvVHB2UmhQOVF6blA3VkpabzllSnJL?=
 =?utf-8?B?MGZlUUo5em5tM2FBbGlrK2pIWlYxUlQyRXErbXNEZnZRMHJkVTNwWHh5NlUz?=
 =?utf-8?B?YUU2WGFVdkR0QkpTS2NPQTVQcTdFTHB1NUt1ME5tSDhQNnpJcDdiZUdXdXZI?=
 =?utf-8?B?WFVkY01xelI2SmZJUWUzS0FsKy9nY3NoZWNCVmsvVUZUSE1FS1Q4RlRudUNl?=
 =?utf-8?B?OWF5RSs1VTFINnNzTHF1eUZ3VHVPYURjTHY4ZXU3Y295R2h1Nk9FQ1I0bW9G?=
 =?utf-8?B?NXpkNjdKRkJTNExlaUFLd0svUjkzUURIdDVCeFQwM0xhOUxJUG1jeTFhbUNs?=
 =?utf-8?B?aXVERlUxUU9jUjdHYjJUK2wvYzhVcEc0Qk4vTHdER0xFYjZMVVB4N0NYNzcw?=
 =?utf-8?B?MklRa2loQ042T2tzOXdyRWtMcXlXdFpJU0p3d1F5UG9xUlE9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 05:22:42.8518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a10d183-69f6-4b3f-a2e6-08dcf8a2e15f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6940
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

Venkatesh Yadav Abbarapu (7):
  usb: onboard-hub: Add reset-gpio support
  usb: onboard-hub: Fix the return values of regulator APIs
  usb: onboard-hub: add support for Microchip USB5744
  usb: onboard-hub: Add i2c initialization for usb5744 hub
  usb: onboard-hub: Bail out if peer hub is already probed
  configs: zynqmp_kria: Enable the USB onboard hub
  arm64: zynqmp: Update the usb5744 hub node as per binding

 arch/arm/dts/zynqmp-sck-kr-g-revA.dtso |  48 +++++++
 arch/arm/dts/zynqmp-sck-kr-g-revB.dtso |  48 +++++++
 arch/arm/dts/zynqmp-sck-kv-g-revA.dtso |  18 +++
 arch/arm/dts/zynqmp-sck-kv-g-revB.dtso |  25 +++-
 common/usb_onboard_hub.c               | 190 ++++++++++++++++++++++++-
 configs/xilinx_zynqmp_kria_defconfig   |  11 +-
 6 files changed, 329 insertions(+), 11 deletions(-)

-- 
2.17.1

