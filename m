Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3147CED266
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 04:58:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2574688DB3;
	Tue,  8 Oct 2024 06:58:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ijXp4sIK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0F4C88DCC; Tue,  8 Oct 2024 06:58:37 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::60d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 581F588D82
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 06:58:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQPpqGd9hQ8B7uJJyz/dfc1woGjy//kIzuQgwnprFLa/h/u7ORMow78+PcBWwRQB/7FbUqVclLTmq9LGeVXsF1nVeuUYYzPj70Wb0tmeUNSa8n+EqSCYMLtyRKfp7p/sohVJr1ksMwY9JmxRpOueEkwudGVvjub0LO3nFC3BC7yDPt+0nmOJUz3Xlw7XPKGHwN18CbFoddm49DvrQZwX81bdBC8hIS8Rx4g5JKMs/DAOoqwPutNR03oaYMQyFwbBHx64JAaibrZEf28t4gYZwIV70KHg/m5VyGqfp63JKBNTqfDGMMDBleLDaPHy0A520A8VnIGPEw2BYLkWFpGhBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAjyJIKKQ8UO6Y3O+35nN5rT/AIQJSjlDlbHwogtD2g=;
 b=DZ3ZjY8c7KgJntEeHwOkkyTBbbUfnrvE+PrpOPwwluvctoDArv+bltkoh2Xz7CL2j0ojTgi0tabPY3dEuVJUs3QNGq8dI4no70WltoLXl/rJh/GQAM1m4vuPGFQDZKtiP+l7wxMA164AHUbwVOhp6bKQulzoZMLqxKpco9zmPW8Q6yAJy5JPUxaU9PLTi1jw11eYD5dhiakBk8u0B+Rky6NBC2rPqXvndLurSyaQ14TRnQeTEzWBterJuX7fFlLtkmYIkNL4Wtljvd+5kGd60Sa1qF4H4xQaJUwiJuM6baGnZTQwWqqqrhP4z8ptina+xZwAbvOrxlfsoTseZ5vI3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAjyJIKKQ8UO6Y3O+35nN5rT/AIQJSjlDlbHwogtD2g=;
 b=ijXp4sIKt1z/ckz/kdk5QPh0c5/2EZIWX0L9YEb9kzliIVA7qv6QAaPCg+bs5igPAf2Edim0i/kpIE2ZhhphAH4rUcMygMnS4hWOjPk0VxRjz8U3JJ+gwDjSIJiRpdrsrGhEu7KAKH1nepk8Y2FjHu2sm4DN2pPvxupfq1eONOs=
Received: from SA1PR02CA0002.namprd02.prod.outlook.com (2603:10b6:806:2cf::6)
 by IA0PR12MB7625.namprd12.prod.outlook.com (2603:10b6:208:439::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 04:58:29 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:806:2cf:cafe::10) by SA1PR02CA0002.outlook.office365.com
 (2603:10b6:806:2cf::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23 via Frontend
 Transport; Tue, 8 Oct 2024 04:58:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 04:58:28 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Oct
 2024 23:58:28 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Oct
 2024 23:58:26 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 7 Oct 2024 23:58:25 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v6 0/7] Add the USB5744 hub driver as per new DT binding
Date: Tue, 8 Oct 2024 10:28:01 +0530
Message-ID: <20241008045808.28757-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|IA0PR12MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: c0a53a1d-044b-451e-a3d0-08dce755d97d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkV1dW5VdWFDMkgwdnBHbTh0NkN5NHVLNmE2OVZyUkdhcW9VZUx1QksvRG5z?=
 =?utf-8?B?TG5FRTBjT0RkQUFXVWhIclJDdE1Wbld5OXRQNVcyd2RrV3ErRGM1RE5DYlZX?=
 =?utf-8?B?UkFROEdYRGlpaVpQN1N4elBpeUN3S2NpVUVVWmlCektQa3JyZkdoc3pFRnRy?=
 =?utf-8?B?QVJsRGlCU1hUQmF5NHpTY1o2eFlkaDdSQ1VMdENySzEzaG1kTU5XNHlHSGg3?=
 =?utf-8?B?QU5kalZxck1BdjA1WFphQUVQUlBQZlRXZWZRQ1VZYXlWTG9FTUhyVW13THJW?=
 =?utf-8?B?TmNwQksrZW1yOUF4M2psMmM0ck1EYVZtbk9McnlsQnBKbVBxVWJKNCtWTjRJ?=
 =?utf-8?B?b2VZZHMxclpoUXRDRHdoTHVsTXNNZnFBbGRITkVHMlRKQ2s3ZmhCdkd5VE5I?=
 =?utf-8?B?M2hrRWU1SjBqQUtjZkUyUXpvOVlJWEdtb3ltdVhCSWNoTmRVN1h2YVRzYVJn?=
 =?utf-8?B?R3ZDRFNrdXpsT0laQTRNUGlUNW9aaFdKMVM4emNxeXl2MHZ4T1c3WTZBZkZI?=
 =?utf-8?B?Rkpja3JDRlJEbmQ5WkhLL3dqOFdGaHJDcHlnelprMXlEL3dIM3ZVVytSY1hD?=
 =?utf-8?B?RFBIWmVBcGlMdys2akU5YkdyQnhQODJSbHVvcVg5cEpDWnhrZG04QzNtNTJk?=
 =?utf-8?B?YWlodDdYR1JtdjVQMVg4MFc3VVFlZmJBRWF4TkluZHNVMC9kSnMvMHZvSVZE?=
 =?utf-8?B?L0dxRGVLZEQ4UVk1Qy9tOVFReThKa0xuUDNuN2UyazIrMVF3QmV6NmRZT2hP?=
 =?utf-8?B?NEcxUEtaSVQrYWExSGhZaG0xYjhMN1djaDg1VDQySUJsdnFaLy9ERk44WHV1?=
 =?utf-8?B?TGdEVjFoMFphZmoyNmp5NVRnVCtRaThXQ2h6ZzduRjhWS2RmUWpBeGVIaDhH?=
 =?utf-8?B?ZnEyNzZmS1NlazhEdXdiN0Y3QmZXbS9IRkMxSFd2U1pWUlgwZFpaWTJSSHNw?=
 =?utf-8?B?VENaTDBidElicmROZkQ3Tmh6YWpkMW9mZlp6Vk44RjEvZzJGekxmYW1VWC80?=
 =?utf-8?B?RHRoSjZmaDQ2NkpENDVDVGtDUWNwTmRmcnVpZlJzWlNmYlJJL1VucXBKTGFL?=
 =?utf-8?B?U3ZlVmlyZUlROGN2cUUrYWtFM2c2V2ovWHo5dGl6dGRpV1pHdlZXbVZCL3Ri?=
 =?utf-8?B?cGdjRkZaZHozdVBXOGRabU5zaTRHOFV6U0NRREdOMlN3emk0VW5ORVhKOGov?=
 =?utf-8?B?VzJ6SlNOSDlTSE9mcFRHYWpnOFdrdE5wNzJlQXFTaDFidHdJbmo5alNoQW9C?=
 =?utf-8?B?M3BPZUpHcllDRDE1dFM1YzM2N1Bhb2ZHOTZtT2JIaDFhZjVsaGZlOVNrZFNv?=
 =?utf-8?B?WVczSE93RENPejQzVXRmSFdZMkNIaWE5dnVpOWl0Qi9KWEpJRU5Hb2hMM3Vu?=
 =?utf-8?B?cFU3NEZzLzRhRzBZVm8yZjJhSW00STAyUmlCZENFM1NlRGxmOGh4QmVjazhV?=
 =?utf-8?B?NmVOdWhvdzNtYmNXbWE5ZkpoUkVRTDN3M1JINGl5clNqQjhPRlhzRlhyQTdw?=
 =?utf-8?B?K2ZSQUsyTHdXLy9ZMWIrTzBFbGNaeXlVQUU2VUM0V1FmaHlGeEdlVGJscVlp?=
 =?utf-8?B?NmdsSkZQaGhQWlBnbUs1NytlQWxyZWJGeUJGNklUcTJtWFBNL1ZQZUNXYkVN?=
 =?utf-8?B?S284NlRDamZ1ZkFqQ09HSzlqcWNWTlFzWW04d0JZR0JSMFJxKzk3V3BzbmhS?=
 =?utf-8?B?eEgrTUh3RGZkWm1pNk1GcDhXcDRTdFNYbE5sajFKVmhDWitUc2NKekVpLzNL?=
 =?utf-8?B?YTNuMnpHR2IwR1BhQllOYlkwdWhYQThLOFpNYWRJQTJEMXNuQkZPQUw3NlBZ?=
 =?utf-8?B?ZHc5ZFV5RFhGOGNYc25iWTNLSGpObXpHMUR5R09ZenJGaWZVcXFuVnVmYVlW?=
 =?utf-8?Q?XAR8ho6HXufQj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 04:58:28.6112 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a53a1d-044b-451e-a3d0-08dce755d97d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7625
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
 common/usb_onboard_hub.c               | 193 ++++++++++++++++++++++++-
 configs/xilinx_zynqmp_kria_defconfig   |  11 +-
 6 files changed, 332 insertions(+), 11 deletions(-)

-- 
2.17.1

