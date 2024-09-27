Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F43CEBF65
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 07:01:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2D5E8906C;
	Fri, 27 Sep 2024 09:01:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WFiEQdaC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 754A789081; Fri, 27 Sep 2024 09:01:43 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::62e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6400089034
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 09:01:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oggcCodYNd9VYKzfMPzSh4CVpSWPiq6+9I1YA9/vQo6pF6oaAdJyFA8zWKwFVqa92FnWjN2n1VsfskxyJKvrIIZ4FdYA7ah4rbehm6FM7XEGfvbOpzGOUXiml/HYswKolrux+HxGTDrMcJPonrUUXJ6yryAPBB8cYLCXU3EuxxDpxpQ2krtytlCN5VApjNRs+Uam23KARYeKuMyHqFYIUzI7/gQBz34tGnG2z3p8Wk1X/B0EfVdjMFXSgH7QLLUen4dY9S7IYG/3GNmF3l3WRIDfS1O3siz81vJCPO+Rb4Q30ctB1C+CHPMBqc5+zu758oThqsdHlifPrL02w7J14A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dbada1MLVrtAligd47sJAQHLIJ/mPXslFRQyWlRYZD4=;
 b=A4P9x07PQgGX0uPwwXam+BPl/6fHYGFDs63B8wlbsNvzklx+4WYfno9FQN3iAQY4A9idZB5FAD59aDIf+VOXC76LTP17iTGmQovnuofLH56NfztnBGv0uL+kSz/0LXnv/idOHsTHvad7xZeo60WpviJpYxsKqmOpu+NFgnO09m7mJAml43r6gEzU8+gcHVFT4dJEiP2Lqb8kJYYb24GDuT9vjUH3IPhza9t6RU4knRAyrfYa2LLGhdzEuEAMslgibp658lnR8dZlb8WZQyGU/FjDrv5Ok9du7SCE1pPxIa0Kph37DLQppcL0lQkSu/w5Lb1k0wQ7Dvr0XRszjSGf4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dbada1MLVrtAligd47sJAQHLIJ/mPXslFRQyWlRYZD4=;
 b=WFiEQdaCAbUugIkQAYYeOm71noS5tUuFlRXiSn5Ew+3Ryj8EIKNwnMExFb0MmAceRYT5hced0CUA6kBX5SLYdmMRM/2q5NWlHimt4a3YrbDOkMvmklXnm/OLspTQQjFhAHXHdml9lYLJjjeVYU9BQJCL4dFFYBlhDd8lldEXXOk=
Received: from CH5PR02CA0015.namprd02.prod.outlook.com (2603:10b6:610:1ed::9)
 by DM4PR12MB6183.namprd12.prod.outlook.com (2603:10b6:8:a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Fri, 27 Sep
 2024 07:01:36 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::eb) by CH5PR02CA0015.outlook.office365.com
 (2603:10b6:610:1ed::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22 via Frontend
 Transport; Fri, 27 Sep 2024 07:01:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 07:01:36 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 02:01:35 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 02:01:34 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 27 Sep 2024 02:01:32 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v2 0/7] Add the USB5744 hub driver as per new DT binding 
Date: Fri, 27 Sep 2024 12:31:30 +0530
Message-ID: <20240927070137.21816-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|DM4PR12MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: 70a66ebc-499d-4ce4-61bb-08dcdec23a48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TmtKeDFoaHMwOVFxZ1RiNkNSTmc1bVErdkFkRHlQdWtPaTNKbmhreFVyMUU2?=
 =?utf-8?B?VUkxWHZyckZ2aW12c1krRG40eWRQOHNtQmNHLzhRZnZ0bzNFeTVKSU1ST2Fv?=
 =?utf-8?B?QlpOUVNkV29XOGtIa2Zzb2lQL0VrMnh6bFpSbWJ0Sit6ZmdpN0xRKzNoaUFy?=
 =?utf-8?B?STZGVDNZY0V5VFpNNW9UbWJWUnRqNVRZWUo0QlVaamVHQmpXbDZ5Zjc1ZnI2?=
 =?utf-8?B?R3BlNFFMUlZtYmlDMWNabWhVWTJKZTdaSDQ3SlI3eUd2dDluMGh4ekxpaG10?=
 =?utf-8?B?VHlzL3hrWXMwME1lTUl1MGJpMWQyNk5IRGNZaHhOUTFSN28zQlFhTXdoZlZ2?=
 =?utf-8?B?ZDNwSzBERVZ4QXZrRis5U3pnSnl3SFp2K3RKdkFOdGxPVjlIbjFNNVZsOElO?=
 =?utf-8?B?UHJCY3VUeDE1VjZSSmpXam5XcjNNVU1uRlNWTkRyeGhud3lLeVdsdGRTcGJ5?=
 =?utf-8?B?VVB5a3p0MXl0KzIxZE81ZFVuNHFWWkhtNEFKcHVYREVqVjcvZGhrTlg3aWVu?=
 =?utf-8?B?S1pvTVZsMkZJY1NQN3hTUUJpaFhQL3dSTWpIR0hIdFQ2Qy9GMUoremh0RnM2?=
 =?utf-8?B?VHlWbjRUNnJwTjBaWEdQMEl5Unc2eXlTM24xSDZqS2w5SUtsQ1h2eUVnU0tD?=
 =?utf-8?B?WDBadmFaWmQzUnlWb1RIY1lyYUZGdmZlUU9CTHVYaWpBbXEvRlFRT284VEFW?=
 =?utf-8?B?V2pWSzlLM1VVUW1BNmxTYmtRSDFmWWVoRUp1OSsrTnZ2VFZQM1V1UHFMNTcv?=
 =?utf-8?B?aWRISy9qNWpRQ1J3SDZHaFJMK09KajIzc2FlNXZycUVxREJZeCs3MWJ6eHRx?=
 =?utf-8?B?UHhWR3Rzb1ZNV3NVV01KaDcxM2txNDBOelZiZGhBdm5kSmMvSUJNLzJtMXhS?=
 =?utf-8?B?SGw3bDdSenlLZEpHVVEzZ3VFWUNScFNibTdJM2JtbER0cG9RQ1h6OEJ2Rjdk?=
 =?utf-8?B?Y09UTThxd09PY2V4elpuWEgyMWR3WkptZTRDUmJqWnFqbE9HRFVOc1g4WXly?=
 =?utf-8?B?Vm90c3F3Z0x3RGVEcHh6Qm5GNS9mMGVoTDJoYlJqNXRsWm9Fb2N2a0x4alZq?=
 =?utf-8?B?NlQ5bFFUWUZaU1NzYm1KRklTSHdnejFMcGlYODhOeWY1WWFlc1d6Q1AreDBY?=
 =?utf-8?B?c010RkZJWm1aMlE3ZkxDaFhEYzIzbUV0UHhsUW1rY2hrTXUxSFJ3M1BlQU1L?=
 =?utf-8?B?enZxSkIzZWd2ZTBEUHRWVTZUV29CT0VySVNTQWg4Ylg3MkhuYTBIeDEvNE1s?=
 =?utf-8?B?M3BkeGJvb1lCWmZwMUpMRFJNbm9sM1g2Nld4UVJ3YmZTV2JaQ2Q3dFpuTHpC?=
 =?utf-8?B?NXhzcXZ5bzk1QXNqTzRlRkZnYS9Pb3J1aldUNGROOWhDWlNSTW1BVlZFQ0RY?=
 =?utf-8?B?d2hRblVrcU5BbHA4Mk5XNHVMaFlBa2lwc2hxRTB1Q01DSUgvc0g3K1VpZFhx?=
 =?utf-8?B?VGNEamlRT3Z6blN5eWdzaHFyby8rcDcydWFNZS9KaGxEVGtpOHJkTjhLQTcx?=
 =?utf-8?B?eXM2U1dlY2R2ZDdLQ2hWckxOWE1JUzQvUjVMRDdnUlpoak1mWG1Id24xVVBV?=
 =?utf-8?B?TnBCVmUwYllvK3R5YmZyN3RRWEpiV1hyRWdFNC9sVlFoYVJDMk9PbE1hYjNY?=
 =?utf-8?B?Q2RpdTlPTVZGcE1aRC9PRHk2Yzg5Si9aelYzNGlFYzUwcDhnQU1KVkhRNUdY?=
 =?utf-8?B?VHVlNnhjUFZyWmV4cnFFRjlXTjJxanN5aE55Qnhzd3I4VEtaT1VBSnE2dUlO?=
 =?utf-8?B?aSt5ZE5wUUE2d0JyV2orcWNtc2tlR1VZZCtQYnBQY0pMbkhENTBxVkRLaGh5?=
 =?utf-8?B?bmRNd1ZqeVd0dzcxSklTWjF0ZzdRTHdvQUlqRXNZbnhtUWlsOG5QQm12ZjBq?=
 =?utf-8?Q?2dksM8/YhG197?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 07:01:36.1674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a66ebc-499d-4ce4-61bb-08dcdec23a48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6183
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
 common/usb_onboard_hub.c               | 178 ++++++++++++++++++++++++-
 configs/xilinx_zynqmp_kria_defconfig   |  11 +-
 6 files changed, 317 insertions(+), 11 deletions(-)

-- 
2.17.1

