Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB2CD41D52
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 05:08:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B69C893AC;
	Tue, 12 Nov 2024 06:08:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2je97rjA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E40CC893B0; Tue, 12 Nov 2024 06:08:00 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::616])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5D93893A5
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 06:07:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1k8n+rbEyaqjWxKr0D9uq+2amHHbYQbzbvz7DAWtU2fjmyziJcpPO74zFS8743BMMvHJbeGxN0YqrRzUeZc209Bxxyo9m3OPQAf0Ygfr1gq2vO1IE5QRCz1gx8P+QwlQDpqEz50NS3wdJpaScpuMTrE8SvRgWFfVK+/xpQgM1SbA898FTHzLGVaG7VhjdTZIxg6tbw03bivNGJktYNvIxJrUn8KSb5aULwXgeHI+xrfi6fJTsqGLyk8qIkLbaxdZkVP5g9qSFPPH9hy9kAXx3Y7agjwVWWR7cCI1kvytk/qAWj4f+3ZFf2zOoY5ZN1DlxuXIulu7lJvUByNrKQZXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkDSHTfFSNrJmm7DH2/Agr5WFn27zBjQAEEoHbqMR98=;
 b=u7FX2CKo1gzCPGQLX/1rD5SVwTfadONBzQZoBCvENxiMz+FKJuOPDagozr6A3bXdqsEFO3mCvF0bCmPVlZ5atOxTpG/CPCqHDlEubh9Co3AAMp52M2NoBXNF7h0yU//wpLDbn5pzLqzXI0MYmfeo3zUzG3n535lPJa/Bj8A7fN8KGG+V52cl8h2n9TlAYGyueOfyIHhK9Np7pkuREd5MRME8VdcvT2vgrb/7Ez9vPwxlU9CFBLKCaMN/qqTJleG8hfJ+e/NTW15pstNRV0BW41X2Bt2MmhosZTd7uz78Ei3r3T+cMG/S1W7fMaKzrnC0fNDhLpNnrGc3bhnd6iR0nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkDSHTfFSNrJmm7DH2/Agr5WFn27zBjQAEEoHbqMR98=;
 b=2je97rjAfBTeWnBvubNAw4fMOYl6tZl/6+hVMpBpcid7M9YmqpJzuHOrRfPpniR0f1eiWopjoDJPzQnzMuTlNgl/tW5j8tJEy6b2BK+XF5GCdaJhxM2L7ob86qQtFrRbcfNu8rpeeZhUMGaD0JjtXO12mkOGTzdTtAGRGnPakZg=
Received: from SA0PR11CA0200.namprd11.prod.outlook.com (2603:10b6:806:1bc::25)
 by IA0PR12MB8647.namprd12.prod.outlook.com (2603:10b6:208:480::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 05:07:53 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:1bc:cafe::f4) by SA0PR11CA0200.outlook.office365.com
 (2603:10b6:806:1bc::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Tue, 12 Nov 2024 05:07:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 05:07:52 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Nov
 2024 23:07:50 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Nov
 2024 23:07:48 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 11 Nov 2024 23:07:47 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v11 0/7] Add the USB5744 hub driver as per new DT binding
Date: Tue, 12 Nov 2024 10:37:33 +0530
Message-ID: <20241112050740.15343-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|IA0PR12MB8647:EE_
X-MS-Office365-Filtering-Correlation-Id: 03314ccb-5eae-4c85-c3cf-08dd02d7f648
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SkVDSU80ODYxdUJreUF2RkdUNHVoQzZDMFhOREh3ZktFdENLNHBGdmFaaUJ5?=
 =?utf-8?B?cG96Z3ZqU0tSUU5GdktRcGM4QlltVi9aSHJCdFMySEN4UmxxZWFXWVV2d0Ev?=
 =?utf-8?B?WjNhL296REswTnVhMUNwVnFBRkNhVnZBMVplQmw1bExlVkpaV05ybEh6dWx4?=
 =?utf-8?B?T3phZFhkVEZOSGZjS1FOdERoTWc3NWlpOUNFUXFkRU4yazFMY3NzRG1vc1dX?=
 =?utf-8?B?eWg0c3o0alBYM2FDUnNnRjBoTkhIaFFRalcxc3JrMkNrcCtyZy91MmJ6Mkl5?=
 =?utf-8?B?RzRkMDNkWm8rd21rTThqRVhhNGZZd1NFTml2TDVaYW1GcjBBczgwYnZHQ2Jv?=
 =?utf-8?B?ZFZBMWZuYzZCRFNUdW1xRXNSTTZMVElPYVRMd1B3VmFUSmpsdmdHSHZ2cS9C?=
 =?utf-8?B?NWVRWVFLR0x2QXZOTWdqZVpmSzVtOWl0SXNjbkVYMS9OWE1CM3RueVZySVRW?=
 =?utf-8?B?b2RSZVRISmdkZ3ZpbWtNNGFwck9KNncyRDQ2UGlIZ0RlWkRYaE5pWHlPMk1K?=
 =?utf-8?B?NkpnMHViTWdsUGNwNWJUdVFrcjJpSURMWkkrZVcyY1pRSVhzMjdrYWptQ0x4?=
 =?utf-8?B?VXlhdGVyeE1mTDllZDBQYzJON3lMK25HN1dOZjgvdXhYWWVuUktrOStjYzRZ?=
 =?utf-8?B?VVFNQmluL2lUUE5WQmdYZW9tRGphNTBvWjlvTUZMb1ArRXRvVEZ5NXdoY0lU?=
 =?utf-8?B?ZEhkR1hiU29xaHdUbXlXOS9CRmdkaDhlcjM2OGNIV2JnY3VmNVgrQk0xMHUv?=
 =?utf-8?B?Mkh5QmIraHhRZnVyUW1tUzhEUE4vaGZUUG9jNWRyTVk0SVhLYlFGbTZkU0hF?=
 =?utf-8?B?bHk0YkcwKzdYR0RnZVVVRkxjZk4yYUlzVWNxSnhTNmo3bUhzaWQ4YjBSYTJ1?=
 =?utf-8?B?ZWJPRyt5M1ZzUVJpOG9XMzJOZHhmK2tFYkl0VmZJNXhGcEZHakRYMEtVY0s2?=
 =?utf-8?B?RGxrcEdhNWhIUUk3N1QvaTV2aGR0YVExTDV2dGdWQnhDN0NmYU9zeUFWYTVY?=
 =?utf-8?B?KzB5bk82WngzTVRhT0syd2pmMVVYeERmRlJmeDZHWkRCeWhLZUJlSSs5ODNt?=
 =?utf-8?B?dytjYWFxUVBNQ2t4Sjd0aU9reWRaV0l3R0syaXZmTlV4UVkwQ0Vxc1BXNWVE?=
 =?utf-8?B?dy9nTGdLMGMxalFEVjE3VUp1NEJYZGU2ZTFJUFpTbjl2VUN1akkvTnkxd1hk?=
 =?utf-8?B?azJlQmlGTTcxQTJEYW5sNzUxN0VJaVkyeEJwaFNzNmsxWDBrc1cvclk5QjJm?=
 =?utf-8?B?MzkvYncyR3dzQ0xkbnQzd2kzUXFzV0lUVFNSZ2Q3ZkkxOFlyMkJGQ09jUmMy?=
 =?utf-8?B?R1NaSUV4NHNNZ0JzWW43aTlrTXUwdUtZdXI1Smx2bzFsMklSVVVsWHR4b01w?=
 =?utf-8?B?WXdHblFKbDMwK0c2bjNsWW9Cc0RrRTJpWGJMSFZvM0kyT0twQkJmUVN5ZVpp?=
 =?utf-8?B?RlZuYjRsMjZibEtMOTA2ZUREWG9wbU5MUU5zeGk3RnB4c1RkQ05xRG1nL3Z3?=
 =?utf-8?B?amJoT0hYNGgyTGVsYW1HbzVHNkpIVi9pbWNBQ0pLL0xUQmE0QTdFQk5TUnY1?=
 =?utf-8?B?SkJTaFFid0VWVjhReWpuUFBlUW41Ui9lbFdmR3FKMHJOWVJnc005S2pSUjk1?=
 =?utf-8?B?MWNYQ1R5c1hndGp5WFdtZlFERU1zRHB5T0swR2tOMU4wRlF2Z0VRdS9mdXhl?=
 =?utf-8?B?RW9LcW9tbVV6NUE0eUpWMTFCVHBSTmV6cUszN0ZuMEtzRVBXSzgxSy9scEpC?=
 =?utf-8?B?TDZBeDlFVlhFakJ0QnN4NkMxd3lUb2ZxRkFEQWYvbnk2Tm50c0F5cEtQSWFD?=
 =?utf-8?B?Qm9yMnJFWGtuYm56NXNuTi9UTllqQkJQYzVETll6eU5rbVduY1dMV21EaXpM?=
 =?utf-8?B?YURhQkIrZm0ySG5BVFhDQVdZK0x5NFFacmJ3ZithTXpTL0E9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 05:07:52.8728 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03314ccb-5eae-4c85-c3cf-08dd02d7f648
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8647
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
 common/usb_onboard_hub.c               | 194 ++++++++++++++++++++++++-
 configs/xilinx_zynqmp_kria_defconfig   |   3 +-
 6 files changed, 329 insertions(+), 7 deletions(-)

-- 
2.17.1

