Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40506CEFC21
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 15:42:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F96488ED8;
	Tue,  8 Oct 2024 17:42:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b396JFGa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0620F88EB5; Tue,  8 Oct 2024 17:42:09 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::623])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9732588E8E
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 17:42:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZrL6haA7KS0Xv80gVh7ffCeNRZq7aqmDJOq7/26ikk0y/7MXWOGQlCMSdaaD0F7jxmqZHQVgT8LuX0gCszP/Lis/62kHfbpUSn+VND0+CtgtTNxvVImtwQdfJOcGnK69WqoTf77qQZTKyZsQ6cOm9cwlOMQwzWJgytaKWfwsMaJ5W1rD/7buy7/tMvbplMBOozDM+fzbFyQ60S7s1T0DGZKqEMpsouy6yz9LiJtuzbl7M0wbIYBT3JPuoQXbnAi0SKolrI9jJZOF7ZKt1NDHOxB6i0rPpAusgVdxFar2JUrNV+diFHrrRRWIlIb4s7iuKJyDPYquAo/Ofpcw/1oGXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VWykq/MFKhZ8kh7o55J4Rcx4+FCpLsD0rk/WiKzlpE4=;
 b=mLirMbbR0LCBpzvU51PY7BIqGj4EO5oq2oWNkiGOnucyJsMYLKNuoV18fnpaic7VcGFhOWsu61OCfDbJhnBUT6WVEot1ethDuCfL3P3yt50WUg2HdixAWv7SqKoVfk6B5nGNzCtsT8EUNT+tN0OMO3vUb69UbYhGI6nNUC1EHA2gtEEQwjZuFoiEOkV4zFwdYzYzqZDIRj/XJkaNPsb4NSRjBgMLwp4fNOYt67MR8x2nk2SYSVRkTr+LCdRGtV17f7U34i6tpAWX7MNEGYotInL0etTycxIEMl9RGsnPA8XShNzZcwARjvqNcReJAMrD5QXutBtxV5uadhOjOmzbvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWykq/MFKhZ8kh7o55J4Rcx4+FCpLsD0rk/WiKzlpE4=;
 b=b396JFGaep2oUQllHLeQ5Ni+vMzYlS7x1Bv4xaM7vNol5W6hdtjHBbHirQAmAcIYbtIJtne7znQftKGj7TeJGy/bPZsVieJ0visTlzRx0OMiuktN07QpboP3Na3BMwA7Ti0mTZthRyYNK/XTIvWoj0XECgFLVZ78Jy3vTRI60ug=
Received: from SJ0PR03CA0262.namprd03.prod.outlook.com (2603:10b6:a03:3a0::27)
 by IA1PR12MB8336.namprd12.prod.outlook.com (2603:10b6:208:3fc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 15:42:01 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::3e) by SJ0PR03CA0262.outlook.office365.com
 (2603:10b6:a03:3a0::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Tue, 8 Oct 2024 15:42:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 15:42:00 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Oct
 2024 10:41:58 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 8 Oct 2024 10:41:56 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v7 0/7] Add the USB5744 hub driver as per new DT binding
Date: Tue, 8 Oct 2024 21:11:32 +0530
Message-ID: <20241008154139.31204-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|IA1PR12MB8336:EE_
X-MS-Office365-Filtering-Correlation-Id: b2a971b9-f917-4326-7044-08dce7afbff4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nkp4ckJPQVFWc2JlNmNKYTh4Sy8yU2tVNENDcjEvQ1hkQzBDWWhKSGo1S1Iw?=
 =?utf-8?B?dm5SdlJUUHRWZzNZRXpaSjRkdTdzYVdKZkY5cEdiVXByRUU5VnQvK25HMmNr?=
 =?utf-8?B?MmZNRkVOS0NDUy9KclJOUXpncTRmWlVEbzExdEVxQmh4RkpBdU1EUmhadFM5?=
 =?utf-8?B?eHJTT21KRnRSSklDaFp1aHFtSnFhUXFBWGxjVGgvL0tRdi9KUUpZck9sWWVt?=
 =?utf-8?B?U2tqUmRxb010WG4rb1ROZEcwZFAya0lXQVNDM2pRbTRDMmNJN2NaQUJPVlFE?=
 =?utf-8?B?MmdkRkZjZURGSnhpL2wyUy9YdVN1OWRHQ2RtbmRwVFFMRkUrc0kzN1lDQ0pa?=
 =?utf-8?B?aWVjeHhtUGlZeGFYVEFsSzBYbStRVWRiU3NuZFR1Y1dVdGszNEJOdHZTZ0VU?=
 =?utf-8?B?MVAvVVZpcERqYmxGQU1rZ211UU5BRjlmMHJoUE9zS3hjSklpMDVYKzZWUUtS?=
 =?utf-8?B?cGNNS1p4dVNkOXZ1WXhOckdodnhGRytZc1lzem5sTGxuUzFjN1VOZHNFcG9Y?=
 =?utf-8?B?d3JhWTJjdllhem5qUlAzbkZnem9FOFEwZXR4WEo5S0lxUnpySnUyd0tjVm10?=
 =?utf-8?B?NWlLSncyUnpZS2dpT1c0WDJRYk5GelBJY25mK3RaZUp5aTZ4cTdLd21WNk1r?=
 =?utf-8?B?aU9iM1pQZVg3aWZEOGRyZUVMZkplbXNTd1N0ZlREeVpCZVlyT0tzQ29SNUFJ?=
 =?utf-8?B?eVlZVzVxakFJRlhBd0JOclhaRGRVM2wwRjU5WjVWUjVZRC9KdW1tMUEvREEw?=
 =?utf-8?B?eHprbitRYVdhV2hnK2NRWFdMbEVyMklxUE0zTmpmcEw5b3R1dEpUak9vdHpk?=
 =?utf-8?B?VTlCWXcwTUx3SmYrdm5yamllMVpjLzJETWpoV3c0bVU2RVc0S1FMNWF6Tmpl?=
 =?utf-8?B?OHM0ekp4RXR0czdmc2RkWlU3blJMVFY1MWVLYXFxdUpSMkxZQy95VExZYkds?=
 =?utf-8?B?M2p4OUdXRkdycWV6Sm5BZGNnK0NlS21PdndGZFpIVUR0aEVUejBFcitkeDN2?=
 =?utf-8?B?b2NRVWovU0VrM1I5d3hPU3REeHFZTEtCWjFqYm5wM21NQ2tSWFA4bk9JWUZa?=
 =?utf-8?B?OVRhWkxhQmg1OFR6ckZRU3VJWnhjYUl1ZnNuV0xHdUxycDVXMkQxWko3Y3RM?=
 =?utf-8?B?WlBPZ2Z6QTkyLzVkT2t0THFsb1FNMHJpdE0wYW4xY0lldDI0K0I0UjlyeWdM?=
 =?utf-8?B?VDZ1N0FYMVZUS2dxSEF6Z0pNK0dOZHUvVFVOU0o1R2ZTb1h0Nk9PVUpUak0x?=
 =?utf-8?B?TU5DVXVJK0hOb0JVZkptUFVub2p2OFdPQUx1TVpZaUQ3M0tYVzV0TXBpNHhD?=
 =?utf-8?B?aG4yMzFDVkY5d1R6OVRrMm5XWVVjeUppaGZQVncrTHRsbEJVdVBZTzQvUzI5?=
 =?utf-8?B?WXFZRUJBM2ZoTWZoTDhjZndINkh4UGRsWlV4VS9yS2VlbVdEb2JCU2o1TVRn?=
 =?utf-8?B?TkdSeWJNRnIwbURCTDBGQm9uNmN1WkkvMVU2SjB4akgwYkxVK1BuOUdoZmtX?=
 =?utf-8?B?YjVpSlNGazRJSlFaR3krR1dldGlPYkpuVWorS1UrWkovTkxYSGZvUCt0THpj?=
 =?utf-8?B?cEFuQnlVVWJob2FKdUtsVWtzaENubnpDZWk3Kzh1WW5HbnJOM0RuTUVKeGFu?=
 =?utf-8?B?WHlQaGplcXovZjlWTXk4ZlE0RFk1ZmQ3ZmJuMTI3REF1bGpCZnRHZXA4SVRs?=
 =?utf-8?B?RG1SRlo5eERtZ0RpVGNQeXNYYzl4VVgzR3EzaCtNR0ZhVjNrVjVZdXg2ZUl1?=
 =?utf-8?B?Y2EvTUZwNjZXZ3YxQWhHbWExV29Wc2c1UE0wTGtQekdmSndLTS9TOExiVStD?=
 =?utf-8?Q?NyZBM5hUwXBx4lWp7jHrAo8s6/xqe27fj1IqM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 15:42:00.4122 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a971b9-f917-4326-7044-08dce7afbff4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8336
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

