Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76553CFB440
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 04:47:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D711C87042;
	Mon,  7 Oct 2024 06:47:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="09KbF93x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6665488D5B; Mon,  7 Oct 2024 06:47:23 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E88788D4A
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 06:47:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ba7X2UGjaItrBndBWuvUva/0Iv4/TXmSsdaf+lnSla0pi2BTTD/pQ1AZVbn5IAx33XBMeChahuqxenkreeHS+LxmTU69gCSHUoaOtOCHek6q1CNjiVHPQCIhmvGkJrefqkxbaOLUr69U9GOJGoO/7iHOLV8qVVC37KVSXNa4EkOq51CfWVsKHp/zNChgCqeHhmrU8ixgHjh1K0nsL2I58aaYs4q07cXmZabXl26EHq3kt6o78+axJV1oCZI1clEqi2Q+/PLxpTEIDVyuGPSj+1DJs2r3FXReooSXxyvolzOuAvajxRO824tvDGPW13oiZ0B+GG4wQGHJAIm9HVNUjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MbOza0yP7Pt8ItHR+WD1lqvIe8tIKGXkT7O6UzABJWM=;
 b=td9oep3hXJ5y0GJbabNfsOEhGMIfgkVJyPwahgr3y+3mLhKIEE4ar+s26YShiNe63IEbLm1NB9QD2cc/vwxNxeMXXZR2KujtXaAyKs3Q+sZNpTGAhrEB3+hwDWT+Nmtx8nCN0GvuFR313XNmIk3RSpo/KlZYfQldNWF8c5PfWN7sBWRWZEzvqCeuHZx/jH33MkwZity9MAnAsym6sBybEgTB/kICsfmtzFPZM8c3z3W6s6o5ZobsgIOjSe7o1oWmxv8vxCZal4mLQdFfFY4h3Cwz8+IdsBHxWxBfNKfYhOIs5eQvU6fcNRS8f5TbOkFCyHFWgnBdKzt/jIEZfmXQmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbOza0yP7Pt8ItHR+WD1lqvIe8tIKGXkT7O6UzABJWM=;
 b=09KbF93xjNOHDkbVjIgWZ1ij4JXRu04SLIN0Z1Glw8CQkzl/QwRbUrD0wvAtYVBvccmQ2/YwK6pO9m6A5z0X1FNkND0Bw8/7d5EKAvM4uuqLsmGn5DKDkn5/CEIixFuN4TuurTN+S/+Nam9xVIq8w49vazjOGyBBiIEcHaKmu2Y=
Received: from BLAPR03CA0055.namprd03.prod.outlook.com (2603:10b6:208:32d::30)
 by DS0PR12MB8319.namprd12.prod.outlook.com (2603:10b6:8:f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 04:47:17 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:32d:cafe::ba) by BLAPR03CA0055.outlook.office365.com
 (2603:10b6:208:32d::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.21 via Frontend
 Transport; Mon, 7 Oct 2024 04:47:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 04:47:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 6 Oct
 2024 23:46:18 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 6 Oct
 2024 23:46:03 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Sun, 6 Oct 2024 23:46:02 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v5 0/7] Add the USB5744 hub driver as per new DT binding
Date: Mon, 7 Oct 2024 10:15:40 +0530
Message-ID: <20241007044547.23896-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|DS0PR12MB8319:EE_
X-MS-Office365-Filtering-Correlation-Id: 7043db94-11c0-4746-64cc-08dce68b1ee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SlNRcjd4QTVhYXBKTjZLRUtLYXNTM3psWjVMQURtZThFdnVmSzdOdkx4ZC9Y?=
 =?utf-8?B?S3p3dEFQZTltSlE3L08zbGx6TkljVldiZFN0dHBZMmRmK0NNTUl4NkZqaU1F?=
 =?utf-8?B?dTB6TCt5OXNIamxXL2V2MTJKR3hraGxyZVMzWk8rV2FhQ0VwMHROc0tQbGg0?=
 =?utf-8?B?LytqeFNIQXhtSFkxUGlma0VqeWxvMTR0UElaekhFZStpS1o2dklVbkQvK2Vt?=
 =?utf-8?B?dE9UOXArZ2ZhVTRGdnE5T2gyeFh6NTNWVkVCYnZpUVlxUDlVMWsyL1dtLzVD?=
 =?utf-8?B?dFl5bCsyTEtTNTg0UmF3RnlmMVN4ZEtVVzQxTEl6WUJnc0c3Ulp0Z1hLZ0pE?=
 =?utf-8?B?cXVURWdNUTNidGhOT3dsc0lhckRqQWRSa0FuYVRHOUQ4TGliWmZnd3NIdkZk?=
 =?utf-8?B?N0VrVHVWR0lVWkcyekF0dXg1MDFySTZyc09GNWJ3c20xb0dPUWU3NHRsbXc5?=
 =?utf-8?B?dlBtUHZOUnhmdVRVS0EvQVUyS0l1L1ErTjVCNmZGaDVoVVRtQU9lLzBLdlMx?=
 =?utf-8?B?MVU5VUVhUU43dTdETkhETy9OWUQ1TlZWNlF6Q21DaVd6ejFKSDlEZ3ovb042?=
 =?utf-8?B?ZXduUk1YTHdZajJrakZwK1V5L215T09iZFgvajBKaGFteklLMjE2cGljOWdU?=
 =?utf-8?B?aEdrWDc5bmNYby81VmJoMmg3QmszTkNCZC9TWkJkTjhoZncrT3B5S0VETzFS?=
 =?utf-8?B?ay9jZDZFUjF5bGw5VjAxbTFXOWdGb3VYZ2NZTCtCWUxQY0s2eUpJVThvNmgz?=
 =?utf-8?B?ZExtaXF1Y3VYSU1laTA2cVNvWFhoQWd3S2p1WUFMT00wSFZsT3hOR2RhZm5K?=
 =?utf-8?B?V3NaT3YxZzR2Zld0aXE0MkJpRGZQZzZEa0ZKOS84a3VEZ2hnMHJPdy83M0RD?=
 =?utf-8?B?ZE9iZEFnZ1g1UUF6QVlTSUlNRGthMlBxd2t5MkN0RitkNjhKOFp1N0NnZ3dq?=
 =?utf-8?B?dkQyclI5TEl6SXpjSnhrVk5QTU9nVzhMNjh6YlZyTHBjcEFKcXZORDd3L254?=
 =?utf-8?B?WXR4a05GLzVNYytBWUxieEFnVUlra0p4OG54czVFMmxDTkdEVXl4UmRodnl2?=
 =?utf-8?B?NGxvMnFJTkpEeStNblZyMzZXTkhKVVgrbTNnRFY4U3VhT3ZycW5NZElhUWZW?=
 =?utf-8?B?bWJ4aEVvUE1jSHdKMnNkTkhYSVJaTms5K2JKWkE2aFFnUlh6b2NXZGgvNld6?=
 =?utf-8?B?dTJxSWRZZElLeUw1Nk1adTlMV2pUZEpuQzFrN29yYVJsVHFVcTEvbGtiNkNk?=
 =?utf-8?B?ckdnNHFjUW1jUjQvVVJ0eEFkMzdVek4vV2Yxb1o1VzJJZk1oYzNmMzQ4ZHJJ?=
 =?utf-8?B?WVh4QlpLbThxK20yTmxHUXdGc1VleWwzS2F6V0Jwdmg2b3BlRmlVQUZveTIr?=
 =?utf-8?B?eWFvOUpwYnpOUXJkNUtTMTJjb1YwVlB1c0ZOU0VldUZuQjhyenVFbm9WK2hV?=
 =?utf-8?B?VmE5WHZqZldNMzdaMkpkT0VSSHN0QnJMcHJRT01WZDByaVpMeHAweENMcUds?=
 =?utf-8?B?RzBpU0EveUUxYzZhQkpybGpjQ3RtMHJrMjR5b0VVcWNUajBsamloUTlvVHdx?=
 =?utf-8?B?Tkl6NWhRd2xUejl1SXRRU2Z1NWtkY0V3MU1LbkFvRUVHWnlOckpDWXE2enRM?=
 =?utf-8?B?dUs0eExxMjhldHZDWHdZWGl3UXFtUUpCRlVjVXF4aTZJUVk2MmQ3aGNSS1ZX?=
 =?utf-8?B?TW05RDBad3JqVXhJdVJleW1hcDJZMkgxOWl3dlJNdmROK00reDV4eFQ1M2Jt?=
 =?utf-8?B?MTlSS0lYVy9xdFplZ0g0a0xDcmI2dk1LeTNva2JBSWZXbHlnWmNweVhpd2I1?=
 =?utf-8?B?cm1LbnJkVmZOWGVLMlp1QzNKNUQzNzBhdTVtU2xQajVqbUV0aE9ZdzBXcWNU?=
 =?utf-8?Q?3f0v7gv4H9obn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 04:47:17.2179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7043db94-11c0-4746-64cc-08dce68b1ee5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8319
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
 configs/xilinx_zynqmp_kria_defconfig   |  11 +-
 6 files changed, 333 insertions(+), 11 deletions(-)

-- 
2.17.1

