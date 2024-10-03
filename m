Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B4DDCF855A
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 06:29:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 550A189034;
	Thu,  3 Oct 2024 08:29:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mvs7l4cu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89DE98915D; Thu,  3 Oct 2024 08:29:02 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::616])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46D9C88FE1
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 08:29:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NNdwTZWT2scg63sgltNjUkfFyDZlCxzkxJrQi8UsUDBsldkpSyLMqTHnDT2ILg3K0De5Wzwf5PVNilFRFWZfaLijgtxRaEQc+BA7OyJH3T2GlB4ivaYIOsqr0gZFjTiQOZhiZa8rV5sg89oRxR1qrU02N7QvBXL122uDv5616nnFTPYwt4ecMdVS/TGnUuw0NwoTKZSCL3PdlyC1a6/FA7O5WUrVAi4wWzyhXeCoOZEW3hvFF4EmPgdt/xk6E2rxwFCIWwDMZ6diResD0Iz5WXUdfNPcHaWoJ0ny/IVOzidKhYV+TgfnFLePwL6UgKZWvXYyoEtaD9rVQx3ey3dshQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqpFHFqlL588O7tGRFIvamnyF2BCaN1HxFX6/2opDaI=;
 b=GCha1ilp8wT1ImzKKphKn1Bh/DHE20RKwAcNm6pDUiGbqgkRqSGCT4tbTR0XEjs0nxLyIVm4cBykDKQKo2bq985d46OZoy5601C5t769PXLEV7ysSQkDbEt9H1Kspjez0fowWi+BtcOjR9QQWTCZazXftNmK5r7k8gj4kTLB1frim0iKBikKxVFVqE5/tBs/LH9ajjV4D7zY8RwLOSoRYe//B03wtS/JgUJQn6mgoC7j06RoqOR6VFXVGUwB3+7x7x73iv9wkkhxSxGmVpfgDWtqciVmay/NYBE2NLKUFzHClF9lJQSbO1+c7+iCW2BHwtHYgpkAMeGgx9XUjq/6xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqpFHFqlL588O7tGRFIvamnyF2BCaN1HxFX6/2opDaI=;
 b=mvs7l4cutnJFXa3j2N9759tEKejDMXMwio1c3ICZLswoQKijCsGR0sHz3cjd0zP2qfnd2GWLQQ5HIs6OQPSBf+sj1u7nH7cQHlUaHbVN0mSKZNp0OozCz1HROWfMNIs3W+dslpYH7BRzpnAQ+3L5AuCaeT1fLfNli8utYn0pbBA=
Received: from BL1PR13CA0116.namprd13.prod.outlook.com (2603:10b6:208:2b9::31)
 by CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Thu, 3 Oct
 2024 06:28:54 +0000
Received: from BN3PEPF0000B36E.namprd21.prod.outlook.com
 (2603:10b6:208:2b9:cafe::c7) by BL1PR13CA0116.outlook.office365.com
 (2603:10b6:208:2b9::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.9 via Frontend
 Transport; Thu, 3 Oct 2024 06:28:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B36E.mail.protection.outlook.com (10.167.243.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.2 via Frontend Transport; Thu, 3 Oct 2024 06:28:54 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 01:28:52 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 3 Oct 2024 01:28:51 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v4 0/7] Add the USB5744 hub driver as per new DT binding
Date: Thu, 3 Oct 2024 11:58:37 +0530
Message-ID: <20241003062844.15338-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36E:EE_|CH2PR12MB4198:EE_
X-MS-Office365-Filtering-Correlation-Id: a04f18e3-7f40-48f6-5508-08dce374a76b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NlY4WFFwQVowbnJNem8zdGFIdjRxT2hGRnFPVnJiSXBYR1B5NnBveUVybTM4?=
 =?utf-8?B?dUdCeGdFd1d3WU9NbGwySFR3VzEvUTg5MDR3Ny9ZcERlNjNGdzl6dFdTUEV2?=
 =?utf-8?B?RnNyODRoaHF2Q3B2RWRVbUozVEN1N24wWXNvNEcrd2FweGx3WktvL0xYbVVO?=
 =?utf-8?B?SG1oMEtKa1pXdGh4amFuVE1rcWRQZndVbWFIekFjWjVHMWNIbit0cm5VeUJ2?=
 =?utf-8?B?WG4rWDZxMmhPUXFLcVVBQWJjaEdSVW5UZkVIcURJNktLVXVudm92aWIxTzFE?=
 =?utf-8?B?SVpSd1ZUNUdSMEhvQVVmYlVHMWhuRi9QMFRyVmRaWVFNcXhQY1VackNoNitS?=
 =?utf-8?B?em9qTmpzL0ZITDNsUFdha0pZRW8rU3FKVVpmRmpNSURFT3B2cEp5TFB6YXRu?=
 =?utf-8?B?dGVJRXY5Y0UzMHdKQVlETHVIZ1U2c2pBMFVGTkNldG1yVEtqUXpvZmxDOUVy?=
 =?utf-8?B?MFZNcFJLSVZLRmJnanlRbW5JeDQ4NkQ2NkVucEdkR0FHTkhuTUo5VU1wdGls?=
 =?utf-8?B?NE54QmpycVRXa1NkUllodUNFVmtGVURzMC9FSVc0S3lZZk1HZVVqUGxBU1J6?=
 =?utf-8?B?ZzVyMmwvZUo5NHUyM1dJd2VuSGZ2VkFYTmxvNEYxWmZpdCt3cVFoTjd1eWlt?=
 =?utf-8?B?NW1OUE5VYmIzWDljd0R5TmhVOUdCbHhjRUxqNXg0cmFkTU9rYngxZGFNNVlx?=
 =?utf-8?B?WnlUdGlibmk2SjdwT2hLTnZ0SDBYanRhV1ZzS1ZYRmFGVDlKY1pRVXJjbjRU?=
 =?utf-8?B?QmJmMmJHem1ubUJzWlFsMmhDZzN5Mmk3aUZoVVdMdmh4Z083aDllRFdLdFlY?=
 =?utf-8?B?T1BEV1ZvSVBrcUZrak90anFtdy9kdldKRnh0NXBiNkpMak5ydmxOc3JTSzk5?=
 =?utf-8?B?c2dOSC92eUNFMnlKS2ZXWVVQN2hkeDV5ZlpnNWplbnlIT3Nld2V5WmZVbjhM?=
 =?utf-8?B?NmxmUDAxSkRsUkV0RUFpUkNLVTE3MEkrNGQxOVN1YXJrclpFYXVDbi9vc3Y3?=
 =?utf-8?B?aVR0N0EvNHBjdTBMblJqMC84c3o1ekl6aTBNbkVnY3BSMlBZdHM0NWNySjM3?=
 =?utf-8?B?R29sVlphUGlYNnNkaURrK3hneUg2RHZHd3AvSnRNUWhhd1FuK1d2TlBqTXhN?=
 =?utf-8?B?VkZIWTdabjRyUXhnRjVVbVNoU1hwUlAwd2FuUXBmUGZ5c1FHVUVybHVld1FR?=
 =?utf-8?B?Tjc4bEpqNWJoZHRDRmh3TzRVTllVSEhrWTZZemd4aUFVd0REdk5idy9Yd3Zp?=
 =?utf-8?B?MmFnQStoRGRWUEQzQjl1aHp3ckFPWmJMcDRneFA3WDJXKzRDVkVVNWM3d0M3?=
 =?utf-8?B?T2hJRW1Gc2RQVGRXMUVZOGRONDQ1bXg0dnRndEZxU2FOKy9TT2E4RFF1YnVk?=
 =?utf-8?B?T000OGtNdWJTc3NSS3hVTE5oTDVXMFRIK1hyT3hMVnVCbGJ4RW42akZORFJQ?=
 =?utf-8?B?SEhWa3BLY1NRVnBDZTlkUFlSakF5WEdvVzB5cEJMdzZiSnJVNytncGl3VHF2?=
 =?utf-8?B?c3gybVZkOVBTOTc1WDFqRmUyR3hTUFV1SUNuRUpyTkE5YXpKcm5PTnRDVnE4?=
 =?utf-8?B?R3Nnb1FsTzV4cUN5QUNCQ01wWUdZZlZDd3JZT0dwRkRnUUV1cW9CWmh5cDRs?=
 =?utf-8?B?Ym1Cckc4RE13b3BPMHFGVU1FWldxTTJrVSs2d0RSODcxR2o1TnkyUEdYM1hQ?=
 =?utf-8?B?VHZmVzkxbVF0dXpTSVloTytKQ3N6TE5TVUhRQUVqc0lkcENYV1h2UHhzVUc4?=
 =?utf-8?B?L0g2dU00U1N6SEEyWTZ3Sm5aQlpXOFExcWw5b0pCdnRJbjh5MFE3OHVibFc1?=
 =?utf-8?B?WDRjakNRakRWMlM3ZFRMOHdxdzJaOHVVYTVSTDAya3JDNzdDNG11V1htTlJa?=
 =?utf-8?Q?grgKXXp3EaNOE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 06:28:54.3527 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a04f18e3-7f40-48f6-5508-08dce374a76b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4198
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
 common/usb_onboard_hub.c               | 180 ++++++++++++++++++++++++-
 configs/xilinx_zynqmp_kria_defconfig   |  11 +-
 6 files changed, 318 insertions(+), 12 deletions(-)

-- 
2.17.1

