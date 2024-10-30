Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CAA0D74978
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 06:45:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2CE289209;
	Wed, 30 Oct 2024 07:44:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HkGPOj6M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A186C89207; Wed, 30 Oct 2024 07:44:53 +0100 (CET)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::626])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D0BB89202
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 07:44:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tDcHQh6SIAwuMNJxsJXLGnL8U+NCzB/HgmbZaEStUiQEywb3erx3XH9arXoVn3nSqUcFa4+yroCN6MBTYagewQ9pZkNg+IcyLPmV5WAT7fIsOXh2WIc0q8IJWucV3O2bWNVRl6wbm4taVou4qNpen3iUIr2dAXSo/l4dBqNO97HYmOimN9hyYRPAUvA+cXHcWju+3GIQiU9T5s094nC2kCqYEKvBL4OZDU8f6VnIYTlpStshcVOHxfhMdDR1e3yHLKZlp62MpoVwcgFJ5QVbrWSmydZxgwJnQv1tdPO8zUrinkmvlflWXTv526OQdMGArhTRMKIVvrNcMAUm43C2Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ondd4a13+STZXRQAoNsl2YyQZ9l8N4Xdkb2YqXGcfqs=;
 b=PIo6bAxjbkgYid0rDntBv3x8eMWAWiGxNbmTBTFPfmwrFSzG3qcRqL5ELsbdIjLv60mQBWCTvvp55upCpmYxWofB3ve0+3Sm4kIhJmHFG0A2GAcRARKVZn/YskDDlmV0cZOvlr8jR5bDC1PtqVHRPzSIH110fWz+RVpZDJoOytlUpPOAKL3r8PArfn7Ktr9XQ3+HAF383rgqgUdgJavoKnnRzkZWg9wTw2fCmkx/VB5JwXi7Mz+ewn45ZQGbYt+j9vwP+ywvjUQqdvcO96vweFVma+v+TWiKtoNGbAMnxIjlYI8nTWci3lCnDEnboNBY7eB6bvwjUsEjgHT2736gZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ondd4a13+STZXRQAoNsl2YyQZ9l8N4Xdkb2YqXGcfqs=;
 b=HkGPOj6MJ/9EmKJf/vJhRO1U9Oga8IpI5zzgwt/Z8oHaatfjSoFjuOUM+1UmgUYsux7t1XWADMYRSEms5gMulOLVrwaOGaIOS6WqpsEvKFmjkZtjyMyKUiz8m+8u2GkOab9pU7BNbUE2Bet8xvl9SlrqgO0zLFAc68e9FLMwGSQ=
Received: from BN9PR03CA0257.namprd03.prod.outlook.com (2603:10b6:408:ff::22)
 by MN2PR12MB4374.namprd12.prod.outlook.com (2603:10b6:208:266::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 06:44:42 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::35) by BN9PR03CA0257.outlook.office365.com
 (2603:10b6:408:ff::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
 Transport; Wed, 30 Oct 2024 06:44:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 06:44:42 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 01:44:00 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 01:43:22 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 30 Oct 2024 01:43:20 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v9 0/7] Add the USB5744 hub driver as per new DT binding
Date: Wed, 30 Oct 2024 12:13:07 +0530
Message-ID: <20241030064314.28604-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|MN2PR12MB4374:EE_
X-MS-Office365-Filtering-Correlation-Id: 91201376-91bd-4fd1-1f46-08dcf8ae55da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WThibTJZc0JEbFQyVkRYUWR2VXJkMGxrK3NpZnhDaDVjY3BCWERSN1JXdjFl?=
 =?utf-8?B?dlJ0ZWxyQXBiVms3c2pJQ1N1T3J2QXNoYkUvdFVLeGVhQU5uUGdKZmRlc2hp?=
 =?utf-8?B?NlpFR1U1QnZkYnQwcTJuZy9IU1BzZ1l5QVBwYlF6dCsxSHJub0xTLzU1WkJE?=
 =?utf-8?B?dmFjYjdnL2k3UmxnVFpheXk5MmlFSWh4VzNzbW4xUGQyTCtnbWJoSnVGd3ZX?=
 =?utf-8?B?VjB0ZHlscWlPbDczaC9pK2ZDbExJK20zMTlGTW9RK2RlOHdMbUQ3TlA1WTMw?=
 =?utf-8?B?VXJkWDRXMVhDalA4TzlrcFFKVi91YXhsVVRlY29tYnlyNWNzTlRTNm1BOE1J?=
 =?utf-8?B?WHpHT3RpbTBROVFBd2k0Mi9FNmRTT1V2aENBMkt4V3FwN2M3Y0dyUFJLZVpV?=
 =?utf-8?B?SlZRUld1UGdDTmxzTlVyNkpFR1NkMXVNOHJJc3RlYkNoL2k2bnZwbEpCcGVG?=
 =?utf-8?B?RHNZVDNvQUppSXZSb1RzZHRCWGZoMm92aWs0T2J1elNqSzlLUDlqUkExeDNu?=
 =?utf-8?B?LzZ1OE1oczdjVDYzYmhockpkamlzMmJSeXdtWHM0K01HSG10YisxY2EyRkZ0?=
 =?utf-8?B?VVFnRUJza0RwM2d4SlZzeWZmcFNNM2ZhQ01lTURuMUtURTNiSHVzdHdGajJk?=
 =?utf-8?B?NExQYnRpbXBIUW5GM0RKZnBBTVRPa0JqOVgra2lmUzJmTTYrZkpHYXhlSmJM?=
 =?utf-8?B?Z2NHM3F6TnFDN0NJYnNLMFRCSTFsaW5oUEdqRW5JaW5sQzFnbmhoRFJPdmZp?=
 =?utf-8?B?aFBKQkppeXB5YlBqWEVGd0IxQXNiamNlcVhXdUVLNFhWTDh6eFF2dWxRZmpP?=
 =?utf-8?B?bzVnTUZNanBDaU5aWFZVZWdDQzBuMGI0SHlUSHduMHBoN0RodlZMSm56VkR3?=
 =?utf-8?B?dWZvQ0NjeVQ1dzhhQ2NLMUFiNDNQc0xvRWgxOHM1TTZ4SW1qb3cycHJ0Z0NK?=
 =?utf-8?B?M1I0NUdZOUIvcm1tcm51QTRQeVJuYzNzOGdBL1pvWmZLSXZ3UjFUU0NsNnpY?=
 =?utf-8?B?ZXpXOXA0Nys2aXk3b1lqOHZ5aWdzb3pvQWkxM0FjeEVraDJpZTdHUFNkWWVC?=
 =?utf-8?B?bGxTZ3RmNWlReFpGczNWeXdTOHNLTGlxREUyMUorSWJuZE5CUGQyNzhPaW0r?=
 =?utf-8?B?cTZNNkMxWWxmK0hIeDFiaE80QTRYVU5qaUZHQ0FaZ1NnakVvb3BkalBJZGtz?=
 =?utf-8?B?eGowS09HdTFwRXIxcXNiYXFPcXNsQVAwaFFDUnd3eXBIZHpCSHNiT1BIVTho?=
 =?utf-8?B?M2tENWxkeTVLRmwrM0FrQWMrSityVGNZTDAySWNMVzZ1MlhkMG5pM0ZqTU1U?=
 =?utf-8?B?b1pnZk5IdytwelhuUFdOeDJQeTlGR05HWHlzWVJCNWd6bXk4U0dLamZOT3NY?=
 =?utf-8?B?Y2xNNWtxbFJyZDdQSWt6Zi81Y0RJMXNCY0dDWFpKaGJCOEE2ZjVQR1N4QUFY?=
 =?utf-8?B?VEhEeE9td0VQcVg2bVVDOXNzLytEbzFxWjBKRWxzU1RrdVRDVWplbHM3RlJy?=
 =?utf-8?B?K040eUtSVkN2L3J3K2c3SERBU3k2MUhZeXcyRENPb2ZoOFhlQlIzZVgyMmpM?=
 =?utf-8?B?TFZuQUMyTVkzR001MmhGd3U2dzV0WGtEVnR6VGFkekN1Z3kwNlkzVEFWUWI5?=
 =?utf-8?B?REN6RE52SVVwT2NNaHZJR3BzQ2dzaFh4VStVZGE0VXUrUVA1cEdMUWdsMVhP?=
 =?utf-8?B?SDExaXU2dVRwZGNDS3RoKy9zQXZuTGx6T2h0eVFMaCtrNnk4YTNpVjdTUFR3?=
 =?utf-8?B?MVlFeTZJWktoOGJ1UnZEem5PMTVZUDBnaXRnTHh2eG5DR29UcXF3T25jYzE3?=
 =?utf-8?B?MFliZEFKRnNUc1g1WVBnWklwZEpNQ1Q0Nk1LRHg0UzRPcUlDOWNUOFgrTGlT?=
 =?utf-8?B?TjVYUEhPMXJKY2VBaGRtU2I3T1gxYmNUVmdjbDViTFFzc0E9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 06:44:42.7499 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91201376-91bd-4fd1-1f46-08dcf8ae55da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4374
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

