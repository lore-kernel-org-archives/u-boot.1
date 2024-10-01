Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4EFCCEB2FE
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 05:22:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 676A2884D2;
	Tue,  1 Oct 2024 07:22:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kDP0evRK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A163589104; Tue,  1 Oct 2024 07:22:15 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::602])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DA6888387
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 07:22:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eB/iqZoon8y0dnQLv3HCi50vjf4srzQBUTlBo6iWtdXNwd1EU1TWSIvVAURTMYgugKg7UcTqEPcm84yZdKnibDJ0NsG+Xz3WL10aK7bSGeaAl7LViEsap17Zpp410LEo+OT9ulEJl1m8eZvAxeObReHH/Hxl4WLk4pKfMFTjZK1Ve4EH6R0yPYwre3y1ABRasry0HOmIcih+nkx67Ogvb6byt3qojxtQBbTC5HNdSCx2qV9ZFOxSEZvZ0WXzaXKfLTxJU3UKPeV76WC+2kDrdZGFdHhZF6wHLBdTZ6qmJEJ9+ybJkzKAzs75YnGec1EvdteR3YXWUHrrkhBrTfhVmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbN5oy06KFoqwVMEtPpAgOsXgXKtz+IghHtzDYb1QEc=;
 b=WTM20nDa9horTHiR3IDyIfEo7JkRrJ5ZDmU/i/65hf9mcx8QGuP4Uvclb0EjOYuGZ0diYyph0XDoL6tWQTUBZff+z6ySLI71EqOnJz09SrmjUwMo+wGoWFL0RZ31dGaWWmFLNiXU71afXsI3gbSE95/uhLHgB9n82VHZs+vVBiNiVcgtxnPEFRlrtt905XFN3ovKmihueEztgbcm4QujdODY45E1d2Zqd+3SI8wE/P3/ZNAmc7gHonWxXYgObDzBTO/wXtnEuamhOG3+6FStqH51ZQf7Dm3L85neDFsdiNn5P1S5ximZjhLwC9AsX8nbTZ/XxlNXCj7xbRYveuBzEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbN5oy06KFoqwVMEtPpAgOsXgXKtz+IghHtzDYb1QEc=;
 b=kDP0evRKGZEaPlg8XjFSrasoU8qa/F3fqSbtkPNH/eOcplXTccVMSM2LgNxf6TzbFpRXR50bTBRokse1tp7IZHx5ENkyAQCZeBamlS8AD1cK7Js8t4juh9ILTTUezCrDIdQ3jiqrLdBi3aIZjFAELuAsx6PdLdMiMQXXk6EuJ+I=
Received: from SN4PR0501CA0100.namprd05.prod.outlook.com
 (2603:10b6:803:42::17) by DM6PR12MB4402.namprd12.prod.outlook.com
 (2603:10b6:5:2a5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 05:07:14 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:803:42:cafe::e5) by SN4PR0501CA0100.outlook.office365.com
 (2603:10b6:803:42::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.13 via Frontend
 Transport; Tue, 1 Oct 2024 05:07:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 05:07:13 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Oct
 2024 00:07:07 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Oct
 2024 00:05:33 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 1 Oct 2024 00:05:32 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v3 0/7] Add the USB5744 hub driver as per new DT binding
Date: Tue, 1 Oct 2024 10:35:22 +0530
Message-ID: <20241001050529.17922-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|DM6PR12MB4402:EE_
X-MS-Office365-Filtering-Correlation-Id: 62399bcb-e673-47cb-d26e-08dce1d6e967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QU5NeUlJSDJ2QmNhQ0ZqVU1zMEdheU03TURHMnZjbWtEYUg5aWg2Vm42cWh3?=
 =?utf-8?B?T0U5dFY2RTlaWWhoanNxWlhWbTF5TGErdTd2TFp3Y20xcnZhOTk0NWpZNlBS?=
 =?utf-8?B?QnRCUFJlUmgxczV6VDcwSUlidjBHVmIvRkpIYzZ6WUhqdEhaNU80eUovMXhs?=
 =?utf-8?B?NzNTNHlkMnVMYW10cVFOeTVKWGFKems2cE9hRzBQTnQrN2xya1kxNTBEWUhz?=
 =?utf-8?B?V29nK1ovVmJEdUZ5MExQaFpYQVc5aHRLdHFvdE5tbm5NVlBPY2w4S0NQVFp3?=
 =?utf-8?B?TnNsZjM1cnJKQTV2cXgvQXlIcHA4cXJFUmR5TDVlclQ2TEZWNTJ6YUxOTVRa?=
 =?utf-8?B?aHFBMHQ2WXkyVk1BMjJIZllHcGFJT2hNRTlKMXVXQlZXWGtzZjh4YVBBSWhF?=
 =?utf-8?B?QTh1K09SdDJCckovMjVLbHFiWStFdktHdEZqbnlUbUZJK2c2T1pqSXR1TmIx?=
 =?utf-8?B?K0NCZTUxdEJ0OGNCb2pHRzQ1TUNMWDRJQ1ZwUEJmSHNaYlpHTElNM3RtdVcz?=
 =?utf-8?B?U2VVcDEwbWt5eFBzaDl4MVZwTlVDWmxRRGNldmhsbDh3T2xQN05CSkNaU3VJ?=
 =?utf-8?B?STlLcDZ6c09tVURrRGptRU0xNWRMVlFFbTJoZm1zK2VUNjlORjFmNHNIdnE4?=
 =?utf-8?B?Y2pIaFdRUVRYRzFxK1EwMGtRYml3UDkrbkI1M0k2RllLOVpRYmZmRTk3UmZK?=
 =?utf-8?B?cjFJMTh3OEEzVE9kUHU5dWZCUHY1RkdpQnowYWNxMDFaRS9ZeWZVUkxjRkpC?=
 =?utf-8?B?OHNBYkZCR3JRQkNOVXdwK2x5QVpXRlVNVGNUOGsvamp3OCtnNFRpSng5T3hM?=
 =?utf-8?B?S1F0Y0w3eW02QVJadit2Q3JqV2RraDBzdTJKTFVoSDI3RFRnY3ZyZlJQU2lN?=
 =?utf-8?B?ZHBxaTBSL0JKV2FYR0VtWGdudnJjSklRNE9KQ29oUmVObDIxMGJGb05icVVQ?=
 =?utf-8?B?cjd1cjJ2WmdSWmppcWpHZUx0cTdGRzY3cytNMnE1SFZoT0RmemNPK2NUTlcv?=
 =?utf-8?B?TkJDMkxBYjVxS29wK0xUY2xrOVVPNUlQcFJHMkxOR0QwODJuWEczZkFqOVFK?=
 =?utf-8?B?QUNPOXY5YURQaU9kczlRTGV4bWNkYnFMeG5oYTIvSWx5cy9DOGVIRmpJTk1o?=
 =?utf-8?B?TXBwNjEyMmVlTmF3R0V4blhDTVdweTNqWFo3TFJuUm12NTEzOXgvckRJUFZu?=
 =?utf-8?B?R0tzU2JybCtndXNvVnE0OVE3dGx5L0V1Smx1eFljV2pkK1RCeXV5L3N6eFRq?=
 =?utf-8?B?UC8rdjZQR3RuU3VHRjFjclVwdEtJYmswNXZzNWN2ZTFZYlhTVWJWbUtyaGo5?=
 =?utf-8?B?T2VLY3FzWXFuUDFkZTNORGE4L1hhRUc4Z2JabzFpYzBGOURpTG13WjZySW9k?=
 =?utf-8?B?SW5NWmRIQ1ZkL0Nwd3ozQVNFZXJOWG96QXNRYW9WN1IrdUNVR1lJZkJMUkVL?=
 =?utf-8?B?ZnNwWklmSUc1ZDJyTFA2QjJTNE1HZFdBVnZUUjg4cENobWl4SVYzakhmcWZJ?=
 =?utf-8?B?MmNVYkd2Z3VyQ1pKaGR4SzhMdlp6Q3BWSmRXMmtRY1EwaHh2dFMvMDA3NkZJ?=
 =?utf-8?B?alZ5bUdGVDNkSTRFa0VCYkRhblBpWUZIZ2RXdkJnenZaanIweVZwb3NZdmhV?=
 =?utf-8?B?c01UNGsrelRwVjlkVzdOZG9SV0JQTUJ3Q0twR3VBNjlXTllHZ1czbHAwWUkw?=
 =?utf-8?B?NHBvRlhsSi8xOWNHVUROUFpMdXRWTkdsT1J2Zk1qSVJxbklxakN5NW9yTXp0?=
 =?utf-8?B?bk42QTVINUNmMHVYOVBNSm9yL1AvdzNnVW4xZ3Z4TVppLzg5NVBmT3lDZ3pY?=
 =?utf-8?B?azdkeEZnem5BaE9oNDZ2TStrT0tyNGxjQ1NERXY4RjMwYjdlck42UFllWjIw?=
 =?utf-8?B?THp4Qk84UkE1bC9UQU0rOXNVUjVMVjdYeFFUdVpoNmRrcHZleEw5OG0xWGdU?=
 =?utf-8?Q?/BP6Pj2wQSO3posIO2wNNg4R+jvj6rR8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 05:07:13.4132 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62399bcb-e673-47cb-d26e-08dce1d6e967
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4402
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
 common/usb_onboard_hub.c               | 182 ++++++++++++++++++++++++-
 configs/xilinx_zynqmp_kria_defconfig   |  11 +-
 6 files changed, 321 insertions(+), 11 deletions(-)

-- 
2.17.1

