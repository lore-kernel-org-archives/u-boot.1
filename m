Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0030BC25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 10:02:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6055188348;
	Wed,  5 Jun 2024 12:02:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qgz4KhoT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1579888363; Wed,  5 Jun 2024 12:02:37 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2BC788252
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 12:02:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZD/eLvToH7oGBy/W5S03uS44sVWyz0/Kzs9WV+z9zos0OqiqhoIT5MxOLlgZKWYMEafpoSY33W5VR1X9ZreWycCDCpGU4FROq7hWhnPfu/fFFuSbReDlZ+k1fTtvQHPlO5AY4CrOTlEtI/oAuvQqxX6gIPGPc+7ZxdzgNnZ6qMueGe2zrRSM7DcnxV0joO6uS7GTdMBwNSd0Zwt8ne0kdvYyWuTb4vz5YtLlhS7OUHKQOt1nyWTU/R5y1vrxB8yaQ7gwKAZ4yVkV/tLMsDIbnP/aTZwSdTeeQiBQIvcjhf2SUUI0EAw0T5XOY7C1tcN1oxdxoIslpHvRSWBnW8TmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1asj9Sfxgd2Y9i32oqK6D/1VAsl8d97ONFzGGDtCi/o=;
 b=cN3Swa42U+V8bAiLnCUZcumnqJ7rxPEPM6lO5tcWdz57kj1ihshHa5irGsTaomaaLWNRQRz8OKmm9WcTk0YjKqlrNCDhTyN4BmuL0hewj5WGx1zLyVZSJkyfwnNc7zi9ehhhYUJheakhhGpgy1Phyiu7e5bqc9LIGoTCWOhushPXDyDyDpPIoMWqKLWw1iqvxiDTo/kB122xNBdp4lozE3EPsTtQTBiYlwEy/D+Gi73rTeQUQWfIjqHa9Xl71FtvA4FX8VapvFkwDc1E2zJc9uYkVQ4J9Smv+OwnpwT3zvT2QOYDS/hoe3u6Y/8ITY9mOS/7gHFi3tnWzUEraUBkag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1asj9Sfxgd2Y9i32oqK6D/1VAsl8d97ONFzGGDtCi/o=;
 b=qgz4KhoTtnuVK+oFHPdVHXiHoP99DdoKBwInAsJP1Gug4SW0OFm5QT2bi1AgsF2oZa+pbXJL1IrPM1TirAloCxrWuOWD4qZooPgEbLd5hB30khX0/YEfAqTLkwfEqJSA46+AXRRh4+he4zRMlnhfkKcUYyl0W7p4ErXZilj+jSc=
Received: from CH0PR03CA0440.namprd03.prod.outlook.com (2603:10b6:610:10e::29)
 by LV3PR12MB9093.namprd12.prod.outlook.com (2603:10b6:408:19d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Wed, 5 Jun
 2024 10:02:31 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:610:10e:cafe::14) by CH0PR03CA0440.outlook.office365.com
 (2603:10b6:610:10e::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Wed, 5 Jun 2024 10:02:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 10:02:31 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 05:02:30 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 05:02:30 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Wed, 5 Jun 2024 05:02:28 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH 0/7] Add the USB5744 hub driver as per new DT binding
Date: Wed, 5 Jun 2024 15:32:14 +0530
Message-ID: <20240605100221.3571-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|LV3PR12MB9093:EE_
X-MS-Office365-Filtering-Correlation-Id: 274ea7ac-f21c-4eaf-9841-08dc85469d67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M3VVRlNCVmZzNG1SeTRYa1Y2U3NnNExTeUwzRUMwckpyU3JrRlU0OU0vMVJK?=
 =?utf-8?B?WUk1dVRWZVZqM3AzamVvMHdzWmxyZ09JRzZSdE4reGZjcG9saWR1OUNlbjd3?=
 =?utf-8?B?VW1jNFFHYTdCSzljeU1ObHdidFJyLzQ4aWR0ZHdjQzlUcUtKTWFQcG4rVm1Y?=
 =?utf-8?B?R1o3b3MwQmlicUZRY3RTR1B1THBMMkcyaytGbWU5MkRMRll5bEd0c1pnM0x2?=
 =?utf-8?B?MDdzR20xalpZeFFHQ3oyYTIyZm1HSGhFT09QSktkeXJNTXIwZEZlTGREV0dV?=
 =?utf-8?B?ZkU4Mmg3WjBOVDhzQTdXVEF2OFlid0hhaktZMXdBWWlDdTJiTXg1cmhTM01Q?=
 =?utf-8?B?WjJ6emlZb0oxUGhlNEc3ZjNEamVIMGp4L1BKTm9lUUJMMUhSZjJJT3hUaEwz?=
 =?utf-8?B?WHpMUEppOFVuYWUwMEYwYkV2djdENURnMUNOcmw1a1IwUHA2K1NCb1BiL0ZF?=
 =?utf-8?B?QzNlZFd2SEZhbVA3c0NhVFNqbThKV2xCV2ppelc4aSswS3hvOGh0Y1ZxcThL?=
 =?utf-8?B?ZDZ6WWdsRjc4K2pXUWNud1RZTTVvdS9tYjlBdVBhTzNHanFpUmVkYTNFRkNB?=
 =?utf-8?B?V1JUcEJRZjdBS3ZoYzNZeFhUUEdsQmxSeXJkSXlxeEh2SVBmNDlFVUR1bFlR?=
 =?utf-8?B?M1ZBNXJPLy9iWFI5aWtFVk9hajJ1NnZOU2VwRGFuSll6SVZCbGU1SGZsMnZC?=
 =?utf-8?B?YTdYekhzSG1mTG9BVlBUb2s2Z1pLQ0liaDQ5T0pkaGJxMkxaeEJJZlpOOElZ?=
 =?utf-8?B?VFhxMWlIZ0pUV3JmTDh5Uy9yNGhxSWFFVlpzZnpNZXhrZm1pc0pBWjA4a216?=
 =?utf-8?B?eUNZSHNQU1l0bU1WWWF5YmptTDF4ZVFMSkFnblBWZTg1Q0gwSVF1aFpRekhp?=
 =?utf-8?B?N2s1NmpCdU1waWRsL1VzYWxuN0JQQmhhekxQcUF2aWhKN3dkVlVsUUl5OGpO?=
 =?utf-8?B?ZjREWC9PdEtzM2xXM0xKcEtXUmdXayszSHkvbUtKSjB6OU82ZlR1TW9DMzBX?=
 =?utf-8?B?WDh2dW9PSWFoVlRmSHVmVW0ycXdDYVRRcmpobFIrbEUxY1Y0eTlTQnQ2UUJZ?=
 =?utf-8?B?dXc1ZWtOdWZ2UWNxSVM5N3VsSG9tTHV0VGdZWGdoeTZ1Q0VmNmxLcnpkSkM4?=
 =?utf-8?B?ZVVJSE5PYUNaV05sZ21aNFdncFkvSlkrdVN0QkxTQWJ4QTJLT3pZT3ZVZWVV?=
 =?utf-8?B?a1lSYlVwa1Y0VlBsV0Q2bVlPZ29tUEExeEtiSWsva1BldjVSbTl0N0R6Ykk0?=
 =?utf-8?B?U0lac0prTVlsbWhmNUVaWFFwVGdLcnVrN21lSDJwbDdKREFhdklGL0FERmFW?=
 =?utf-8?B?NGwrYjhSSG5laU9rUllkbG45ZkZjbEkxRlRkb0xzOThTanYrdFFnRG0zVUoz?=
 =?utf-8?B?YyswSm9OUWd2dzlNNFZXdmZQcDllOGZCSnhGTnR4UTAvN09uVWVJdjFwdTVT?=
 =?utf-8?B?LzJLSmpoanA5bk9xQUVlTHlHS2RjOW85dTBPNnlOMGI3VjBTOXpzYnlkU3hV?=
 =?utf-8?B?emJPWWdmTHpHTHVPWHlTWnJMNzMxY1R0SWRvRGFUMGpNa1p1R2lOQmxKRmtn?=
 =?utf-8?B?VklFZlJJQmdqakRudFhSZlk4d1RGOWlQSW1EN2MzUHkyUTVUcXpyc2RsQzE1?=
 =?utf-8?B?ZExBQ3o0Sk9qNlcrNjBoYmI4Z2pRSXBOK3A1TG9OcmlLL3hEb211UGFzc1Zl?=
 =?utf-8?B?VFZWRXVhajMwdDRoQ2hJRE9HRXIrUmdvUHZZZlJ3c3JrS0pISUVTcmN6blNm?=
 =?utf-8?B?UmlDS1k3VmFUZjZpYTBCaVc5dGM4amFNL2VQcW5BeVl5MmxmN0U1YWlrbXpz?=
 =?utf-8?B?THFxbTRWTkFQbFdXcnlSQWVEcnoxZGNXaCtIbmx6SWd2Y2FiWVMwVVNmSVJR?=
 =?utf-8?B?L2FkVzFpdm1ORDRXeWJsNk9XNFlhLzU2a2dyUkJkQUZkTmc9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(376005)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 10:02:31.3691 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 274ea7ac-f21c-4eaf-9841-08dc85469d67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9093
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
 common/usb_onboard_hub.c               | 176 +++++++++++++++++++++++--
 configs/xilinx_zynqmp_kria_defconfig   |   1 +
 6 files changed, 304 insertions(+), 12 deletions(-)

-- 
2.17.1

