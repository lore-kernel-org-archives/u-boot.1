Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C7BD5E127
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 04:04:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2875688FC4;
	Fri,  8 Nov 2024 05:04:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gcd+n5bN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1822E88F4F; Fri,  8 Nov 2024 05:04:00 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::604])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A729C88E63
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 05:03:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVyLdInQJTERCjbhVeWb2TeeJf/UzUokIa/1psw4hAtRHTw8rjdBsjpcy2QJhuQJmQ928SX2ah5cFEyiiJ7EgNkpgLEbhvbsGiCQ5aibCcVyTSdUhHxMlctkSKsLtFPDhfpisXDXAjReg1kvs8bV0PaYd4WMpHSNwL+JVxATmoMGrTTrTuoEyxOOmBZp/xT2gHj7qsqZ6JXp6tttZ8jgrSzGOdGDh3K+abAKI9B9UCiMXiU8RfIWAL4SOlk2AqJQoC/Ls5RpRi0Az23eT5eF6ZGEW+XpSl+lFs3IuSdlGBoJe8MEKe1y3K5iMnQmJeuD/iDfb68stcRFIpKxa1Rspw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvzJ4tSNBkrYB4LggNT+ubKhDjFPp0gxnujrxKIBNP0=;
 b=RtiMDpUHaV7Yoq7qkVW58al1hLN7zDEJlTEMkLlBryQAUcvCNZ7ZHb8eEKbA99+asa3fl3HzOyUHPYC691uNIlE9aFUreHboLZKuhV8Bkn2n8JNpNCfNTUYqv/t3TD0387XZ2JqhUneDbz3ORApudF8ywU/p9MEeKp/68ncDcR6wOGP0xd1F+tWNj3m6lUCGDc2mD8OhcDFVG4EnBIXns25rE+KPLk24FEEr3n2xK94zCML/F5avFYxFk9JAv2cmWeSB6AK+9ajMONSrnYM1X3SKp3gIRfN/50H7SOYyJQ6ajlDWT4y+5+XeMGGEcBh7U2kD3DZUEclYkCN5LtH1oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvzJ4tSNBkrYB4LggNT+ubKhDjFPp0gxnujrxKIBNP0=;
 b=gcd+n5bNw9ws7lBhL3a/5htDIWddlU+uLopfQR5nZCHunH/F4txouEPnPPAG6p14Vq+aEG+aSLvR8OgrFSPK4O0CRKdfVRH7QtEvGiishe4Ylax7otywUDebB/4DfvScu/HTcOhC6OOJDJ+BHCF3tsCN3w7nA2QechpsuRN9xwo=
Received: from BN9PR03CA0954.namprd03.prod.outlook.com (2603:10b6:408:108::29)
 by MN2PR12MB4288.namprd12.prod.outlook.com (2603:10b6:208:1d2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Fri, 8 Nov
 2024 04:03:54 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:408:108:cafe::ba) by BN9PR03CA0954.outlook.office365.com
 (2603:10b6:408:108::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Fri, 8 Nov 2024 04:03:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 04:03:54 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 22:01:20 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 22:00:08 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 7 Nov 2024 22:00:06 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v10 0/7] Add the USB5744 hub driver as per new DT binding
Date: Fri, 8 Nov 2024 09:29:52 +0530
Message-ID: <20241108035959.19970-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|MN2PR12MB4288:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f1e8f1c-a3ad-48c6-65e5-08dcffaa5cec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NDhYOHBHb0lSY0ZCcjNPUFNTRUQyU2JkcE1jQnVpYm5xbkFFVWc2eEJQSHov?=
 =?utf-8?B?V2JYNUlZM1UvV1NaMEJPVmozRXN0ajFlYytKVkh3S0ZZbHFHRFVkUXNXUzdF?=
 =?utf-8?B?Qm1haVVWTGpPa0h0SW5PZjFrTVQ4Nmo5WE9tV2taUjBhNXFMMDAyTE9KM3J5?=
 =?utf-8?B?bzBvd1lDVVBJWm5vUktTTmQ2SnErM1BNVEVIWllCTzVtYmNnTWZUT010UkZM?=
 =?utf-8?B?STBSck5YWURwQmlCWHdRWWVJMmNySFR0TE9hMjFSeTR1SWJab01JT3ZWVjNz?=
 =?utf-8?B?ODY3V2FaeTFveWdObnNuWExLTFBTdDdrNDVYSFdyUDJNTzlzcTIxMGNHdmJu?=
 =?utf-8?B?SHFHc2RkZklMUEVlQVZLbFZ3RitkYlI2OHByL3l2djJKaXpXWnVjMWhUbWY0?=
 =?utf-8?B?L3hVUEg3NTBVNWQrSkFnUmphaVUxcVZPSFAxSThZWHJSVjZ1TE4zMTdKaWU2?=
 =?utf-8?B?eDBzcXcwaWp5VSt4ZUJIMWlITlFhbzNqdUo5Z2pkRXM2Q2RoaVJpVC9mek1y?=
 =?utf-8?B?NEJmblptejEwV1pMbmZmZ29tMzMycjJiZ1BaRlE5dFpOaW1GTlpJSlpVUjg5?=
 =?utf-8?B?MVJOTE5UcjBRY0FpRFdERjRVaFc5cUhwTE5ON21nZTBhTUkyMDVvdm1LeFJ2?=
 =?utf-8?B?bjU0aXJmREgzRUtTMlh2RDFzOFhmRGp6MEtJdnNQRkIvUWRsWWR2d1QrOW9W?=
 =?utf-8?B?Kzd3M2s2YllmUGRIc3AwQTZ0TzNwVjI4VVlINzg3VEZmSWYyRHplY2d2SUlF?=
 =?utf-8?B?L3NKTFpNRWoxdEdtekZSSDZTMnA2K05MVWJOVlhDMHV4VUgydVBSTW14RnRs?=
 =?utf-8?B?dVliMndMSG9yMlN5elhwd2pCNkhXRGZzazFTKzlVVS81ZUQxcFZMT0dEZ3ZB?=
 =?utf-8?B?L2hWSUZFWnBmb0FyOVFXc0VsSzFtV3FlRER5MkxNL1laNHlWVUdnU1NxOHZn?=
 =?utf-8?B?YWJhZkVkQnFwZ21CU3pvY1hSY3lJT1UrOUovd2ZzNVVOYUtFUVg1RklHSXQv?=
 =?utf-8?B?dzF3V1JFK1ZjL2tPRkR1eFN4THpQb1RiNE5NRDQyQ2QwL2JEd204R2c0VHgv?=
 =?utf-8?B?RGFXQk9lQjNacld1MGttUkF3Z0lOeWVnU2MzQnQ3SDEwajk3cFpLY0FybU5h?=
 =?utf-8?B?SEViejZkb1dsTW8rTGltamZoZFk2cEZkbm5tR2hoRk1Icmo5Wm9Nbk80bXZ5?=
 =?utf-8?B?ZEVmVXprSlJaandmUDc2RnJWYXNZVmRyVERLVmR2cHd6ZlVIQ0swVUl2bVVv?=
 =?utf-8?B?U3A5VWpaUmhISG8vMkkrQnJOcGNZTmRhUEp6cmJOTS80YzNEaWZOaDVsQ0ha?=
 =?utf-8?B?TGJVTERNVEdnbVpJTDROTWhDcGVHbkVCZUhwZXZ1UC9DcVVXQ1FxM2NZdjlF?=
 =?utf-8?B?R2hSQlFPME1tZ3N1UHhaU3R4eFNKcWpJVXgrQmhhdmNRNmFReUdua3F4V3B1?=
 =?utf-8?B?bnZvSGZtaTQ4UW1aV3c0VlJ0MS9Tdit0SGt2U1Rad0hzZTcvcTBhbExLdXMv?=
 =?utf-8?B?Uk56d2dldWc5eVBrRnpHcHpKQ3RXZ2tJK3F2TGZtd1NONDVQempSS3AvZGgx?=
 =?utf-8?B?RnNGSzdUd3JYT2VLNlE3Q3dIVVFTS1d1TEtuN2V3YnBlQ005dFBoZ1dzdjgv?=
 =?utf-8?B?Mk4zS1BzUmhCek1sTmxJczkvSXdMTkFwcGJLMEgyU2t6dkxuQmhDQ3RVNml2?=
 =?utf-8?B?S2lMZDhXV3UzUjhNSXppdlZ0YWRDYmRxYmROUkU1QWgrbUpwRkV0dG14UWt1?=
 =?utf-8?B?cHlVZG8rTXlHTElXYm9OYm56Nm5EN1VrMTQ5TFdBV3UyZmROVkdYdmN6Y09Y?=
 =?utf-8?B?a0ZubXphUGppT1AzL1hvTlplQmJ0enQ0eGl6WEJmYXV2Nm50M04reHZhbmt5?=
 =?utf-8?B?R1VXRGE5YXM1c0dtZTJjT3VxV3pKejdzbk5PZnNZNjBDOEE9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 04:03:54.7506 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f1e8f1c-a3ad-48c6-65e5-08dcffaa5cec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4288
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
 common/usb_onboard_hub.c               | 189 ++++++++++++++++++++++++-
 configs/xilinx_zynqmp_kria_defconfig   |   3 +-
 6 files changed, 324 insertions(+), 7 deletions(-)

-- 
2.17.1

