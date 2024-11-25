Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB761D3B7D3
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 04:13:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7681A88EF5;
	Mon, 25 Nov 2024 05:13:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Enm1AMcA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 413ED899E3; Mon, 25 Nov 2024 05:13:29 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::600])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27B3888EF5
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 05:13:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hGIERdPQUQDUEXovcgua1yD36nkospF2D7CVaBvArUsuwQzPdWGnQCW2Y/T57H5M14oBmX2H/emQyPCpFSvBA/lf44yjyCKIC0BN+iLCcJ4+MT/t0ZvlaGKN53JvoKpRKnjUzX1mdH/MRm9G5ptcFeHJ2Ffm/X6SiSUj1474zxnRLaPcxysk7Bxk2R761/s2LuC46oFE9+ht3CLmPJgNFVHV/fDCVTAqSF2jpEyRMUs/O9Oz7fk70DJoxCsAWdtaf9OybNuOuyScL16wZlbUVe2bUjMsvmtaxKb7GTYBphjRtmwG6bMZHvUw9MuvoRDcavxSliICRtihZwaCUFvINA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4NYEvp1LNSv5ySBTsYisTHZSHoif3Ke668o5DtKbCM=;
 b=cvnTRFuvufSIcEh2MO+4nD31vSNi7XIfcN1aRH7FhKnJ1aJyG+B/yIYpBAh9mKlmDH402lYJ6MgcAoyFc6aANlTLgPtxGfKjv0ufg1xEJAv424C/KPvr6mUQYLmpeaIIc7GSjNsKs2r08Hfnpi9BiPYR7dLJ49xLoDMT7p/QhbZGkRzGHoow/RHzC4qkLaPXqVZF1kpgcrX1U9nS4GSB0Ox3OqW9HOIqt23YZR5u7ocronHa0fOjrcvzHopiYBxF1UU3TsjcZF/Xi4aBpykuOe7ZDDB86ahExNgj1CRo4ZJ2iSP52F21KkIYwCifwxb4XuQ72/OtrHTKZu0hw/slcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4NYEvp1LNSv5ySBTsYisTHZSHoif3Ke668o5DtKbCM=;
 b=Enm1AMcAd8GwQQtdhOowJYC32yxS/lc0koKzDB6ZVEFjNiFqT7ob43j1c46maxztCkXwhVTzobX0IRl76BOBD2xI7z8y3Zeyac0X2dq2KCfyO4pQEXcTeCgrY77wEIj7xUK/+hpt8kscZLNjGZXaboROWuhe/fH+UaGew0OJH1A=
Received: from MW2PR2101CA0022.namprd21.prod.outlook.com (2603:10b6:302:1::35)
 by MN2PR12MB4207.namprd12.prod.outlook.com (2603:10b6:208:1d9::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 04:13:23 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:302:1:cafe::d5) by MW2PR2101CA0022.outlook.office365.com
 (2603:10b6:302:1::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.10 via Frontend
 Transport; Mon, 25 Nov 2024 04:13:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Mon, 25 Nov 2024 04:13:22 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 24 Nov
 2024 22:12:32 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 24 Nov
 2024 22:12:20 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Sun, 24 Nov 2024 22:12:18 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v14 0/5] Add the USB5744 hub driver as per new DT binding
Date: Mon, 25 Nov 2024 09:41:57 +0530
Message-ID: <20241125041202.980-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|MN2PR12MB4207:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ff2a2c4-2be9-45c6-9b10-08dd0d07808f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0RzL2ZFYlhwdHBpemZjUmtGVUN6c0V6dWFqallNdzdaUmh0S1JDaXVLZlE5?=
 =?utf-8?B?OUVjektSMTNra1RHUzdVMmdpdk5KVklUeit0cGhLQkgrbXg1QmY1M2V5Yldz?=
 =?utf-8?B?QlZPMDRCL2lmWkNqem9wTURTaUk3cDNzWCtmK0VmUkNDZ2NLbDlDS1IzMmxF?=
 =?utf-8?B?cUhmeUFDVnZLL0hESmR1NU54ZCtHZFpGbzRNUWNTcUZQeStCMDBZZTRIOWU5?=
 =?utf-8?B?VG1rVGFRZGhpRTU3bTZoNm16UU1Zb1NSeUpPU0MzUG1RT2thNjI2MEF0bCtJ?=
 =?utf-8?B?eDc4Ym5INmhNR3FybkI0NkxNU0h4NCtSWFYxbW9TTkcxTmQ0UVNPd2tpVDNN?=
 =?utf-8?B?WXRuR0srL0lwYnkyUXdnMjVHcFhIeUE0c21YYU5YL3hScWkyQUV1Q09nd2l5?=
 =?utf-8?B?Mi9xNFd5QmIreWQ5S1JZL2s0bktNamJ0NnhrT0FzNW1QaVp1ZmI0NUZ4SDd4?=
 =?utf-8?B?V05WSkpwNHVpTGJUbzBqc3BqOWZKd0JOM21UbDMxbTZlRlFiVkYzV1gvb2FV?=
 =?utf-8?B?QWEyTjVXd3d3RDdrQU1UNk95WkFtRTh1eFY1S0twa1FyV0s4dFlvSzVudU43?=
 =?utf-8?B?TU9pWHN6MXQvWDBqeHpLMUJ6R0FwR25yWDJEYmtYc3pGS0tBKzVIWjRGSWtO?=
 =?utf-8?B?ZE5ZZEFGN2JrZHh6L25SVVNJdERBZk9BZE1JNXZMRng1NmJrUW9sNlhZU3U1?=
 =?utf-8?B?Y0lIWE5UOEJtOEtsbWwyUURadGVjdkxtVytPY3lrTnczR2xGRlVJdzlGMExU?=
 =?utf-8?B?THFuUzl5N1E4N29rQ2QrMHFBVjlDTVlLUGpDUHg1S1Y3ZVRNYTN1L1B5V2Fr?=
 =?utf-8?B?aW1SNzhSWDcrUXEyVUNHNzlTaVNwNVloQnZVYjAxd3JTZDdTTzZhY0M3TEV2?=
 =?utf-8?B?enBkRjZqTnR2RDR0NXRsS2dQL01jekttZ25YeFFQZ2krN09ENkRabkRlSERW?=
 =?utf-8?B?SGxkcFNTTjIybmMybnY3STQvZGVKM0poU3dKbjYyamtvS1kxbSs3eFZnUnNE?=
 =?utf-8?B?UWlLaEFQaHplRjFDY2lDMUVyQVNsbksyNWE3THRlNGVGbG5vVXpzOXJKM0N3?=
 =?utf-8?B?OTNldHI3UWVoYzdDOTR4RnNMRjlTZnNFcWdnMWhCbTNXV2hHS0tud2xQajVl?=
 =?utf-8?B?dzU5aUpUeUdWNjBVOFl1UlRweTNBbnhnRTB5cTlpUHQ1K2k3ZmVPZ3FwV1g1?=
 =?utf-8?B?ajZ6Rnpnazlyb09KbGpQRE9KUm92WHJKY3UyWFNUWDk5MGlIUFNBMEpPTWha?=
 =?utf-8?B?N1AvZzhMM3l5RWFqQmlzZDJDUXRNYWgwdUh5SDRES0Y1TTNVaWp1VnN6c3da?=
 =?utf-8?B?WjFWeUI1MXdlUE1KQ0VoUmVsZVB6YjA1eU1pc1RYdjJXYVhMTm1SbUZZYmVO?=
 =?utf-8?B?dlFzb0RzZ2ZzampSZEdadzQvQXN2ZE1ybGR6VXpIMHlwQncvblhGU1p0a3N1?=
 =?utf-8?B?Z21nZDI3UTVPSFFCSVU1cUsrV2pFbzRhb3NBUTRyOFM4dXNpV2cydVNIU3Zt?=
 =?utf-8?B?NGhnYkxYSFV3Y1kvdVZDOVpuVGVQOWFWampwc01WWE0zME96OC9XYTFjSTYv?=
 =?utf-8?B?ZkRsOGx1SkJVQ3diWXR4cnJNd0hha0VuVnhWREdDS2tzV2t4NkZlV09XZEdh?=
 =?utf-8?B?WGs4V0ttN21HOVRCZGhnSWJ2ZmNaSTdmeHhGV0pIM0pzcmF2STFCTmNtanJ6?=
 =?utf-8?B?bFRZRnh3YmpFOU9ZWVVzSTFmU1EwRmkva0JPcG13NWNrK1h5TTRiUVV0OHQ2?=
 =?utf-8?B?Z1F5MzhqTEgxTEpBeUIxeFU0ZFY3YStYNUEyUkFyVm81Tk1VZ3E5MEs2R1VR?=
 =?utf-8?B?VC9pQnU0bngwSzJwZDAvdEFRT3ExRE9mUFUrUkZVVzZSVi8zK05mczJSNm8w?=
 =?utf-8?B?WnBwZFFtNkx0NEJqRkRoWGxRZ2xyakJqa3VFdmYwdTlEQkhIcGphU0VvRXpr?=
 =?utf-8?Q?bx5qc+iFJ4pK2D8dAtA5UNHwy0Ar3OVx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 04:13:22.7743 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff2a2c4-2be9-45c6-9b10-08dd0d07808f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4207
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
DT nodes on KR260 AMD board.

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

Changes in v14:
- Remove the 6/7 patches from this series.

Venkatesh Yadav Abbarapu (5):
  usb: onboard-hub: Add reset-gpio support
  usb: onboard-hub: Fix the return values of regulator APIs
  usb: onboard-hub: add support for Microchip USB5744
  usb: onboard-hub: Add i2c initialization for usb5744 hub
  usb: onboard-hub: Bail out if peer hub is already probed

 common/usb_onboard_hub.c | 195 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 190 insertions(+), 5 deletions(-)

-- 
2.25.1

