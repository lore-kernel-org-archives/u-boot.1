Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4407D41D71
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 08:50:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08D6189444;
	Tue, 12 Nov 2024 09:50:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H3L1YqXm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8553893BE; Tue, 12 Nov 2024 09:50:44 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::60b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C13A9893BE
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 09:50:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Et8lMxwmYjv4Jkg7sB7RN5uyn8Ldia30kkBRd+7RMComz/xt+vDrMPSVLVqCE/fNm9Atq2Czmoe0e3Tuw3IDM5qU6lFUaX1Ozs7dZpJshy0l4/p0aYz/EU3zFSbhr+A9M1Kt+iX7NrDtyZ/8rlbmLeaZ5HXWovrWEbiM3LmhfXfSr0fLhAJXy3sa5EuCm0qpyG+WbFQDEYtE+Oq5ql+DQ7udAFelJYJdhMIpel1m/dJSPuoYpwyu36aRfhbOUI2W++vAUCPqHT+s3evmTSaRYPtcy63YSrr75Yk3ixSowCr7RgQoFfbFfwtDUZ4340KwIwS/Y4ZxniCDiQ7DyUjQVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGEqCP34mt+UQaSxnI5uSTmrRYmxm0Q7W1vaCF5HXIk=;
 b=og3d2NfAO5CEJDbWCARLq5MBZnHHHUwn29thh0YAT4DTZLGIhM5PBf2VaA5nsULtrMw4TZIfZD8oYdNYCU6WsiKlH5FIAAvlrhkLhuUP/cZoOK1fn7++P6MuYYiWIe8wD7FtyK7NvGJfB/YWyiLbp24k3GIbA97OdQ1UbKJxLWxlR1ljXX0xh8SZXWDVNulZEcfrc5UPrq1ChI4DH0XJvUxkUWvHnl7K21bEpKGOV457Wxe5THTSAaJia7qcdmcfY783KZqL0Uz/ZegUjYuKFhUnwrHXl1ND5yon0ygYE/qS7PM7dQWxrvWRUENtLwRywMYJwAzUcHsK72g/F/4G9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGEqCP34mt+UQaSxnI5uSTmrRYmxm0Q7W1vaCF5HXIk=;
 b=H3L1YqXmv4BGFTx3/XYZ7vHgQjomz0yvkxen8/LJawBqYpms1ve2qRpI6hXAUHJknKKXZn+QU0DFjohlJqY5KrZ2R58Os58FMuGHKApViSuRcRZNXpa7LoSNNSYqio7w41gD9LEyjhr46wJ1DxIIZ4WD6jBp51sx1RSVwLknuac=
Received: from SJ0PR05CA0167.namprd05.prod.outlook.com (2603:10b6:a03:339::22)
 by BY1PR12MB8446.namprd12.prod.outlook.com (2603:10b6:a03:52d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 08:50:38 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::9a) by SJ0PR05CA0167.outlook.office365.com
 (2603:10b6:a03:339::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.12 via Frontend
 Transport; Tue, 12 Nov 2024 08:50:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 08:50:37 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 02:50:35 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 12 Nov 2024 02:50:34 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v12 0/7] Add the USB5744 hub driver as per new DT binding
Date: Tue, 12 Nov 2024 14:20:20 +0530
Message-ID: <20241112085027.21352-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|BY1PR12MB8446:EE_
X-MS-Office365-Filtering-Correlation-Id: 30492453-c045-464d-ee76-08dd02f71460
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cnlPRWFiR1RNTTk5R1NHb3FwRUY0bkluR0JmUmRGRW1wUGNWWFBEdnRkeVRJ?=
 =?utf-8?B?UTkxcEJvMEFRRmRIN0NUQ2pINjE3Uk1IUlExRXZOQW9SMVZxVTdrbnVOVm15?=
 =?utf-8?B?MmRUU3d4VmdlRlNEdS9tZ254TDgrWnNHL1AzUzhpSXpoOWROZHFCcjBnYm9D?=
 =?utf-8?B?YkhsSlhQbThqaDJNUjF3MXN4Nzgyc0ZBcGJlYktyNVlzOVAyQlZIMWVuN3B5?=
 =?utf-8?B?dVVQWURSM0VVWnkrc0RKM3ZIblVqWGV0OGhVTDBXdnBnMGZnSEc3U1BiaXE5?=
 =?utf-8?B?alVrdDlwckd2M1BMUGltYzZZa1hSTy9ZYzFBVzJpQlVjM042NzNPd2ZYZmNw?=
 =?utf-8?B?NmZ0UURUb2J4Wm82QU1RQVVoN0IwaW9ZMGUyMmFsNlJCQ0E5MkFNOVpMVUh2?=
 =?utf-8?B?T3lBc1l3MjFqK0k5MmlUN2VBbkQ0Qk5wU3N5SUNrRTdOeTN6d0dvS2lRTGZC?=
 =?utf-8?B?dVZXY1BkcHJyUjFHczRqTEUwWTV0ZTRYQTU5RG92RkgvNG1XL3Nvc1UvaWwz?=
 =?utf-8?B?TExTSlpISHN0ejVrUFVlOENnWHM2RlZtM3lLRUZ5OWRiTEkyZ2dHZ3lCTzRt?=
 =?utf-8?B?b2ptanRncXNRdWpYdVBFZHBDU2VUdW9XcjVLYWVyRC9LKzViZXdCZlEvS3Nh?=
 =?utf-8?B?S1habUx6aWcrWEtmK21vSlBidWFUT0VOeDlzM1RNNGQzaDhvWm5DL3BML0ww?=
 =?utf-8?B?aGtQVGNLeDZJU0M3NVgxU1Jkc1huY0pIcFNtYzFOdXBXdXRrKzB6ZkwxY2lq?=
 =?utf-8?B?MDdKUHRPREJ1THNwaDVSaS8wNDkvTFpCdmMvVVFhaXh1MDF5bmdleUo5Rjk5?=
 =?utf-8?B?d2VEa3BFVGpnNnZFTU9Vd2dEVW9IRVEwUmY0eEFJM09nV3llL2EvaGgvaXUx?=
 =?utf-8?B?QlR2OVo5TmtUWjZpY2YrMDVuWnpyOFA5RU1sY1pZZzhuWlV1d3V2Tm0xdGIv?=
 =?utf-8?B?aHU3VUpPUWRMVzRoRkVyL2hCODM4MWJSekV6NE5LNUVjU2ZhRHRVMXdzV3ls?=
 =?utf-8?B?dDRKaThYN3pjTjJpTmJMOVBiNUFuelppd2YxNVJoanZKeTQ3QzFHa21XUmxy?=
 =?utf-8?B?MVEwL1BnRzFQSjc0eXNPT09icW1HTnhsODdacVVOMDR0emJXTk1ZWWMwaE5r?=
 =?utf-8?B?V0dsZnNzREJLb09sd0gyRFFDM3REenZZUlpGaE5TUDJSOTFUQU1temZibkk4?=
 =?utf-8?B?ZVR6Vms0YmExdE9NVHYyQ3lRaVhQd1B1NHJGVGZkTkpRSk9UU1phU3ZHNmRs?=
 =?utf-8?B?UEo5OGRzOFNRL3lEMW1ySXEwMTF1VzB1TnJEeW9rSUY5NjI5U3dZZWp4NnZL?=
 =?utf-8?B?Tk9pN0VKaytOdHpzMnNDYmVnMjFsYTRudWc2VU9BSkdzRFFvU1V1SXFsSUI1?=
 =?utf-8?B?aksvaFFMcVM1WVIyYm53dUNMZ3hISHNYekFueHhmeGJQOGZVYjJuUnlseWtl?=
 =?utf-8?B?QUJPOHRWbVNWaFRDQzJPWkZiUW9EZ0MzNHFGZnd0UUNjNlFGdWZLaUdSaVdq?=
 =?utf-8?B?L0UyUXRKaUtEVVlZbTZvYnV4SW5ISGZ5Rk1ibXVzRXFKeHcxQnVITTBBc1pa?=
 =?utf-8?B?U1c2Nkl6VTVqSHd1eU92eUJEWGZYUERwMkJFUFcvN3RieUpyNlZlcXhsRWpI?=
 =?utf-8?B?cURVODBSSVJZMWpIVDVBZENZWmhBWVJGd3ZqT3VNTytwZHZIT1VZbHNvZkl2?=
 =?utf-8?B?bURtUmdZcjNVTjJMdG5VaG9qbHN3L0I2ZDlhNm9SbGE2L2xPUUwyRVMra3Fn?=
 =?utf-8?B?R3huSEJ5SHVQS0trQ24ySWl5cHVGUjhEelhiWU9vTFlEKzRoN0h3Z25Ja0VR?=
 =?utf-8?B?RUJ4TmpwVnRoKytYb1VpQUp1MUxIdFI3RS9sV1FYUVRwdXk5L3pyMUcwL0Yr?=
 =?utf-8?B?Z25NL2FML3QxazZsTnJkWDdhTHpFT3FwRlU5TGRRR1JjVlE9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 08:50:37.6834 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30492453-c045-464d-ee76-08dd02f71460
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8446
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
 configs/xilinx_zynqmp_kria_defconfig   |   3 +-
 6 files changed, 330 insertions(+), 7 deletions(-)

-- 
2.17.1

