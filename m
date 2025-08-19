Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D1BCA0EEB
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 14:26:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 400C482D88;
	Tue, 19 Aug 2025 16:26:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LmehAzbo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2297A82E05; Tue, 19 Aug 2025 16:25:59 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::620])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FDC9802C1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 16:25:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ei+HJgUXvc1PURSMeSAqiUNCjS6huM8c3Nn+62h3tbL4r79jDrV91pRnvYmEIji59nR9OVVdsEshFuV1wGrsm7MqXH+lQrHUM4suQqn7FzYeFn7phuVYMSDQwT8fuKWMnKIVQzVslt9fUafXYZq3iNYGLRM2ZKpWUK+HxRFp/r32y5rFUav965PnEG0JiGyIp7WBLOzkMU3d+rzi0+YW5WZiqs9JCvIERdZn5cIoL/4Q0nTTB7QlK7VeatOxpgLFMhI2zhR9HVJAB0UeGOb9UkkBAgWEOJPtGPwFlU1/fzsR6o2nqH17L5zi9FMcVVVvklihnhMs8RwkLhdWWXrFJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MAAtANJQwLrGwE1HEoYHEtN7bqmRUa9g54TFiEGKc/g=;
 b=SRuRLOtDxGWvbzbRMdpXmSOUiDdzkKKfyi3OgnJks/vXqY7JdV33vjcWWOv4G2My0EalwpmeCSgc8B1Zu/pmDI0jNHUFL9RC3g4uEbrn5Df/ENDTOxBOmASko5yMQJs0El0QuVO2OzNG+y84ut2KBZ4QeXnsROsZ6JZLTyqlNP00AKfi9ituXXaNfw3sokMbRKrMElnYywPdQehc+jrn6ZB+DmrYwFo0ZN8ePOUij22iNjazN1YOmQ1EUsT4HzqNC8adkcib4lYjG2oh5q8P+5K9WNwlYnJpP1As95CuCSH+uDyxJPeM2e/VwdW4b0D8Ydz3AGRSbTCM9A7SELn1QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAAtANJQwLrGwE1HEoYHEtN7bqmRUa9g54TFiEGKc/g=;
 b=LmehAzbo29K+zfGpit5IqRuDwELHB2KWrM1SzfdUZ74X8rY/P0Bb1YRRXl/DaPh8swfHfWdOznQYd7pG7YnpvElmy8MwxGX9YSgpOFPtyQ8r/dANX7oLlbtHeSMEOSEq+JZIujckd4NXR3g/vF3x6OcWnmsW9nfaNhW9ayGKLgQ=
Received: from CH2PR07CA0043.namprd07.prod.outlook.com (2603:10b6:610:5b::17)
 by DM4PR12MB5961.namprd12.prod.outlook.com (2603:10b6:8:68::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Tue, 19 Aug
 2025 14:25:52 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::1b) by CH2PR07CA0043.outlook.office365.com
 (2603:10b6:610:5b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.22 via Frontend Transport; Tue,
 19 Aug 2025 14:25:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Tue, 19 Aug 2025 14:25:51 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Aug
 2025 09:25:50 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Tue, 19 Aug
 2025 07:25:49 -0700
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 19 Aug 2025 09:25:49 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Casey Connolly <casey.connolly@linaro.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] env: spi: Fix gd->env_valid for the first write
Date: Tue, 19 Aug 2025 16:25:41 +0200
Message-ID: <03aa59f72f47fe0ecafd1e1ca52cbb8a5a8f0446.1755613540.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12244; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=/r+IcCrVKjzGsHQBSeGMCMXqPH4Beh0e3jLOvXnSLI0=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQs6Uw36W6bvrGJ38DoDvsV2fUHgpumeB5dbqDmf3d6D
 MObLf9edZSyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBEjvxg+GcSp3mhMKDqGu/7
 Uu2klez3LjjYNT85s77/bGuS671LnDqMDJMCOHSuWx/ckPeun9dkRWqn/LsDOnqVTdxrzDn/62R
 NYQYA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|DM4PR12MB5961:EE_
X-MS-Office365-Filtering-Correlation-Id: 089ecc7e-3a3f-4606-4c60-08dddf2c4cf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eCSsDjjw1pn9gs1EtUG/m44nmhrxW3wT44ezPvDa7QaPsTEfANwm4S9tiRUq?=
 =?us-ascii?Q?pTuRJR+6P2mhNu6QNxpVEnULm1TvpF6Jh4ugSAfHrkfzsgq/7XmeH2MH9ezy?=
 =?us-ascii?Q?xJpehdl9ufBwU7y7y8z/GYRjbJw4KZt7D/JS3sxoBRApKQUGpawfe7kVHIiE?=
 =?us-ascii?Q?fyRYeX+SbVAZSY7P/3PVtrfy5/MCR/aLw0ugqJsxHfCJaoZgCZEpPc6rWolU?=
 =?us-ascii?Q?oETTn9VJ392wxJo78l/4LBd+iC94FYONGPLCR3o5hB9Pb/qJ/Kexnk3td6Yi?=
 =?us-ascii?Q?++WxB6S0VX62DI3oxuGY7ncyohHSI87KvYv/HOjkg15s19N3iqddr+o1Uo5X?=
 =?us-ascii?Q?WsAhrpA+VtRBkqwOoyjRkdZ+6Vt5RC6RxnWOWBjWxfZ63PzfozI6v0qUzvUi?=
 =?us-ascii?Q?p4WaMGgRb+JzhuT1TgxWwxv8Qq9qp/BBMxv/916hxvQyWDZHnOQrIB2rhRD9?=
 =?us-ascii?Q?C/PDPOWDSL/oAlTU3WC5tJiMl6M8tCU6JnwADu2RKjbfN4lJqGmoLjkPyghP?=
 =?us-ascii?Q?A04Mzw5Z+KWuHA4UAz9H5cpsuyVRAdOQGSsWE+SGbCKxqzPModZT7eV2xygP?=
 =?us-ascii?Q?d/QedQ4la8RdiNPnyzsDXj3xzmjojBcVV9mvyha80BWZrdYPiYj6rxdv7uYf?=
 =?us-ascii?Q?iClJqE4m7ObB3c4m2xqV4rZJ/3k2dhBW54s+DKgEVOK6oAV/EUd5RH5Ch2+u?=
 =?us-ascii?Q?kt6v5AVmw9JrS1g1qRRaf2qy7wEUgVaT4c2WENZSLvErpyMPQr1oGXgAtd4D?=
 =?us-ascii?Q?O/3Ldyx7IQBX81GZpj7S9mbtv0VG0qa/3AVCoiqwsd9x6Wo1JFGgkfp4BSH8?=
 =?us-ascii?Q?un9Gin9fyoUgIljqv9x4MUoWsSCws+pd7ZJ5yUF/YCC4NG5Hkn6l/+dRPFGc?=
 =?us-ascii?Q?DvcROWyduebsTbOf2REEECqKtRpRn6+jB51o+4OqBauPI3csrPvucXj466WA?=
 =?us-ascii?Q?3cIKHv7+kSAs6uH7H8OMS2LxH1tbHse1OVHgXc/Jzjf/+RXnwK3ON+42XXlD?=
 =?us-ascii?Q?5IoItDDsIFd2si+42lRT45uz9WV045ZYOhZs0GkhWKtLwkrqpFjZA6OqZLKr?=
 =?us-ascii?Q?yfV/fDfyiZf6M0soukphqOhGcW8s4XP2yhw9AOTtXVLqA3G7UVIysenzmhJS?=
 =?us-ascii?Q?RRnrFchrHd9RXul/0TemRVoItJd35RKECLPnIqp3DH0Eb3hvW+oo1WXt00ne?=
 =?us-ascii?Q?bcrkf9BoVWasJFVPbl1sb4aRaClNoWtmtE6Y+Gb/HHki13NkdsjWiV9RovLR?=
 =?us-ascii?Q?QUGWQvZPq6DLdpC6cpB1/U97FzT7rzw5ZeROgDA6BC5fH8fopfbHYg0WZFdO?=
 =?us-ascii?Q?3AOVjmj9zqIjjL4jSewQjTLyhpbCVSPufoK0da2Z0SzJiqX3VyXc0HgEYwhp?=
 =?us-ascii?Q?RCE9yx/SgqKPhWWi7q5reWB2Ixjl5oKj5u3jC5EnVgOIdqEDPDoEqWW5gZBR?=
 =?us-ascii?Q?UtPgrcadN+8aBW1fBww/acZBeg5UV3Ee474cTCbkC2bC/EGhgMeqrQDaA1VS?=
 =?us-ascii?Q?7sG0+4OGGIw2j9J97j74kTzzwgo9ib6l+0hz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 14:25:51.8278 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 089ecc7e-3a3f-4606-4c60-08dddf2c4cf7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5961
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

When both location for variables are not valid (or empty) gd->env_valid is
0 (ENV_INVALID) which is setup by
env_sf_load()/env_import_redund()/env_check_redund() calls.

When saveenv is called in case of SPI env_sf_save() is called which
contains logic which describes new/old variable locations.

if (gd->env_valid == ENV_VALID) {
        env_new_offset = CONFIG_ENV_OFFSET_REDUND;
        env_offset = CONFIG_ENV_OFFSET;
} else {
        env_new_offset = CONFIG_ENV_OFFSET;
        env_offset = CONFIG_ENV_OFFSET_REDUND;
}

In case of ENV_INVALID option the first location is used (else part)
and variables are saved with ENV_REDUND_ACTIVE flag.
The second location flag is rewritten to ENV_REDUND_OBSOLETE.

And
gd->env_valid = gd->env_valid == ENV_REDUND ? ENV_VALID : ENV_REDUND;
is executed. env_valid is ENV_INVALID that's why ENV_REDUND is setup
but that's not correct because the first location has been written and not
the second one.
That is confirmed by
printf("Valid environment: %d\n", (int)gd->env_valid);
which is showing number 2 (ENV_REDUND).

That's why change the logic how env_valid is setup to be aligned with
offset calculation which also cover the case where initial state is
ENV_INVALID.
Then print about Valid environment is showing proper location where
variables are saved for the first time.
But also it is fixing behavior where the first two writes are going to the
first location instead of the first to the first location and second to
second location. Alternation is happening after it.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

U-Boot SPL 2025.10-rc2-00066-gf2925ed31728 (Aug 19 2025 - 16:18:55 +0200)
Loading new PMUFW cfg obj (1836 bytes)
PMUFW:	v1.1
Silicon version:	3
EL Level:	EL3
Secure Boot:	not authenticated, not encrypted
Multiboot:	64
Trying to boot from SPI
SPI offset:	0x280000
load_simple_fit: Skip load 'tee': image size is 0!
NOTICE:  BL31: Non secure code at 0x8000000
NOTICE:  BL31: v2.10.0	(release):xlnx_rebase_v2.10_2024.1-27-g14cea4616-dirty
NOTICE:  BL31: Built : 04:42:28, Sep 19 2024

U-Boot 2025.10-rc2-00066-gf2925ed31728 (Aug 19 2025 - 16:18:55 +0200)

CPU:   ZynqMP
Silicon: v3
Chip:  xck26
Detected name: zynqmp-sm-k26-xcl2gc-ed-revB-sck-kr-g-revB
Model: ZynqMP KR260 revB
Board: Xilinx ZynqMP
DRAM:  2 GiB (total 4 GiB)
Xilinx I2C FRU format at nvmem0:
 Manufacturer Name: XILINX
 Product Name: SM-K26-XCL2GC-ED
 Serial No: 50572B111F2H
 Part Number: 5057-02ED
 File ID: 0x0
 Revision Number: B
Xilinx I2C FRU format at nvmem1:
 Manufacturer Name: XILINX
 Product Name: SCK-KR-G
 Serial No: 51011A21CT4G
 Part Number: 5100-01
 File ID: 0x0
 Revision Number: B
EL Level:	EL2
Secure Boot:	not authenticated, not encrypted
Core:  102 devices, 36 uclasses, devicetree: fit
MMC:   mmc@ff160000: 0
Loading Environment from SPIFlash... SF: Detected mt25qu512a with page size 256 Bytes, erase size 64 KiB, total 64 MiB
*** Warning - bad CRC, using default environment

Variables from 0
In:    serial
Out:   serial,vidconsole
Err:   serial,vidconsole
No USB device found
Bootmode: QSPI_MODE
Reset reason:	SOFT
Net:
ZYNQ GEM: ff0c0000, mdio bus ff0c0000, phyaddr 8, interface rgmii-id
Get shared mii bus on ethernet@ff0b0000

ZYNQ GEM: ff0b0000, mdio bus ff0c0000, phyaddr 4, interface sgmii
eth0: ethernet@ff0b0000, eth1: ethernet@ff0c0000

RTC #0 - rtc@ffa60000
!!! For TPM reset a full power cycle or pressing the POR_B button is required !!!
starting USB...
Register 2000440 NbrPorts 2
Starting the controller
USB XHCI 1.00
Register 2000440 NbrPorts 2
Starting the controller
USB XHCI 1.00
usb_onboard_hub hub@2: data_buf i2c_write failed, err:-121
usb_onboard_hub hub@2: onboard i2c init failed: -121
Scanning bus usb@fe200000 failed, error -121
usb_onboard_hub hub@2: data_buf i2c_write failed, err:-121
usb_onboard_hub hub@2: onboard i2c init failed: -121
Scanning bus usb@fe300000 failed, error -121
Bus usb@fe200000: No USB Device found
Bus usb@fe300000: No USB Device found
       scanning usb for storage devices... 0 Storage Device(s) found
Hit any key to stop autoboot:  0
ZynqMP>
ZynqMP> mtd read "U-Boot storage variables" 1000
Reading 131072 byte(s) at offset 0x00000000
ZynqMP> md 1000
00001000: ffffffff ffffffff ffffffff ffffffff  ................
00001010: ffffffff ffffffff ffffffff ffffffff  ................
00001020: ffffffff ffffffff ffffffff ffffffff  ................
00001030: ffffffff ffffffff ffffffff ffffffff  ................
00001040: ffffffff ffffffff ffffffff ffffffff  ................
00001050: ffffffff ffffffff ffffffff ffffffff  ................
00001060: ffffffff ffffffff ffffffff ffffffff  ................
00001070: ffffffff ffffffff ffffffff ffffffff  ................
00001080: ffffffff ffffffff ffffffff ffffffff  ................
00001090: ffffffff ffffffff ffffffff ffffffff  ................
000010a0: ffffffff ffffffff ffffffff ffffffff  ................
000010b0: ffffffff ffffffff ffffffff ffffffff  ................
000010c0: ffffffff ffffffff ffffffff ffffffff  ................
000010d0: ffffffff ffffffff ffffffff ffffffff  ................
000010e0: ffffffff ffffffff ffffffff ffffffff  ................
000010f0: ffffffff ffffffff ffffffff ffffffff  ................
ZynqMP> mtd read "U-Boot storage variables backup" 1000
Reading 131072 byte(s) at offset 0x00000000
ZynqMP> md 1000
00001000: ffffffff ffffffff ffffffff ffffffff  ................
00001010: ffffffff ffffffff ffffffff ffffffff  ................
00001020: ffffffff ffffffff ffffffff ffffffff  ................
00001030: ffffffff ffffffff ffffffff ffffffff  ................
00001040: ffffffff ffffffff ffffffff ffffffff  ................
00001050: ffffffff ffffffff ffffffff ffffffff  ................
00001060: ffffffff ffffffff ffffffff ffffffff  ................
00001070: ffffffff ffffffff ffffffff ffffffff  ................
00001080: ffffffff ffffffff ffffffff ffffffff  ................
00001090: ffffffff ffffffff ffffffff ffffffff  ................
000010a0: ffffffff ffffffff ffffffff ffffffff  ................
000010b0: ffffffff ffffffff ffffffff ffffffff  ................
000010c0: ffffffff ffffffff ffffffff ffffffff  ................
000010d0: ffffffff ffffffff ffffffff ffffffff  ................
000010e0: ffffffff ffffffff ffffffff ffffffff  ................
000010f0: ffffffff ffffffff ffffffff ffffffff  ................
ZynqMP> savee
Saving Environment to SPIFlash... Erasing SPI flash...Writing to SPI flash... offset 2200000
done
Valid environment: 2
OK
ZynqMP> mtd read "U-Boot storage variables" 1000
Reading 131072 byte(s) at offset 0x00000000
ZynqMP> md 1000
00001000: 5d691224 63726101 72613d68 7561006d  $.i].arch=arm.au
00001010: 6f6c6f74 6e3d6461 6162006f 61726475  toload=no.baudra
00001020: 313d6574 30323531 6f620030 3d647261  te=115200.board=
00001030: 716e797a 6200706d 6472616f 6e616d5f  zynqmp.board_man
00001040: 63616675 65727574 49583d72 584e494c  ufacturer=XILINX
00001050: 616f6200 6e5f6472 3d656d61 4b2d4d53  .board_name=SM-K
00001060: 582d3632 47324c43 44452d43 616f6200  26-XCL2GC-ED.boa
00001070: 725f6472 423d7665 616f6200 735f6472  rd_rev=B.board_s
00001080: 61697265 30353d6c 42323735 46313131  erial=50572B111F
00001090: 62004832 6472616f 7465735f 723d7075  2H.board_setup=r
000010a0: 64206374 30207665 797a203b 706d716e  tc dev 0; zynqmp
000010b0: 696d6d20 72775f6f 20657469 46467830   mmio_write 0xFF
000010c0: 30304143 30203031 66666678 203b3020  CA0010 0xfff 0;
000010d0: 74206669 20747365 61637b24 5f316472  if test ${card1_
000010e0: 656d616e 203d207d 2d4b4353 472d564b  name} = SCK-KV-G
000010f0: 6874203b 72206e65 74206e75 6b5f6d70  ; then run tpm_k
ZynqMP> mtd read "U-Boot storage variables backup" 1000
Reading 131072 byte(s) at offset 0x00000000
ZynqMP> md 1000
00001000: ffffffff ffffff00 ffffffff ffffffff  ................
00001010: ffffffff ffffffff ffffffff ffffffff  ................
00001020: ffffffff ffffffff ffffffff ffffffff  ................
00001030: ffffffff ffffffff ffffffff ffffffff  ................
00001040: ffffffff ffffffff ffffffff ffffffff  ................
00001050: ffffffff ffffffff ffffffff ffffffff  ................
00001060: ffffffff ffffffff ffffffff ffffffff  ................
00001070: ffffffff ffffffff ffffffff ffffffff  ................
00001080: ffffffff ffffffff ffffffff ffffffff  ................
00001090: ffffffff ffffffff ffffffff ffffffff  ................
000010a0: ffffffff ffffffff ffffffff ffffffff  ................
000010b0: ffffffff ffffffff ffffffff ffffffff  ................
000010c0: ffffffff ffffffff ffffffff ffffffff  ................
000010d0: ffffffff ffffffff ffffffff ffffffff  ................
000010e0: ffffffff ffffffff ffffffff ffffffff  ................
000010f0: ffffffff ffffffff ffffffff ffffffff  ................
ZynqMP> savee
Saving Environment to SPIFlash... Erasing SPI flash...Writing to SPI flash... offset 2200000
done
Valid environment: 1
OK
ZynqMP> mtd read "U-Boot storage variables" 1000
Reading 131072 byte(s) at offset 0x00000000
ZynqMP> md 1000
00001000: 5d691224 63726101 72613d68 7561006d  $.i].arch=arm.au
00001010: 6f6c6f74 6e3d6461 6162006f 61726475  toload=no.baudra
00001020: 313d6574 30323531 6f620030 3d647261  te=115200.board=
00001030: 716e797a 6200706d 6472616f 6e616d5f  zynqmp.board_man
00001040: 63616675 65727574 49583d72 584e494c  ufacturer=XILINX
00001050: 616f6200 6e5f6472 3d656d61 4b2d4d53  .board_name=SM-K
00001060: 582d3632 47324c43 44452d43 616f6200  26-XCL2GC-ED.boa
00001070: 725f6472 423d7665 616f6200 735f6472  rd_rev=B.board_s
00001080: 61697265 30353d6c 42323735 46313131  erial=50572B111F
00001090: 62004832 6472616f 7465735f 723d7075  2H.board_setup=r
000010a0: 64206374 30207665 797a203b 706d716e  tc dev 0; zynqmp
000010b0: 696d6d20 72775f6f 20657469 46467830   mmio_write 0xFF
000010c0: 30304143 30203031 66666678 203b3020  CA0010 0xfff 0;
000010d0: 74206669 20747365 61637b24 5f316472  if test ${card1_
000010e0: 656d616e 203d207d 2d4b4353 472d564b  name} = SCK-KV-G
000010f0: 6874203b 72206e65 74206e75 6b5f6d70  ; then run tpm_k
ZynqMP> mtd read "U-Boot storage variables backup" 1000
Reading 131072 byte(s) at offset 0x00000000
ZynqMP> md 1000
00001000: ffffffff ffffff00 ffffffff ffffffff  ................
00001010: ffffffff ffffffff ffffffff ffffffff  ................
00001020: ffffffff ffffffff ffffffff ffffffff  ................
00001030: ffffffff ffffffff ffffffff ffffffff  ................
00001040: ffffffff ffffffff ffffffff ffffffff  ................
00001050: ffffffff ffffffff ffffffff ffffffff  ................
00001060: ffffffff ffffffff ffffffff ffffffff  ................
00001070: ffffffff ffffffff ffffffff ffffffff  ................
00001080: ffffffff ffffffff ffffffff ffffffff  ................
00001090: ffffffff ffffffff ffffffff ffffffff  ................
000010a0: ffffffff ffffffff ffffffff ffffffff  ................
000010b0: ffffffff ffffffff ffffffff ffffffff  ................
000010c0: ffffffff ffffffff ffffffff ffffffff  ................
000010d0: ffffffff ffffffff ffffffff ffffffff  ................
000010e0: ffffffff ffffffff ffffffff ffffffff  ................
000010f0: ffffffff ffffffff ffffffff ffffffff  ................
ZynqMP> savee
Saving Environment to SPIFlash... Erasing SPI flash...Writing to SPI flash... offset 2220000
done
Valid environment: 2
OK
ZynqMP> savee
Saving Environment to SPIFlash... Erasing SPI flash...Writing to SPI flash... offset 2200000
done
Valid environment: 1
OK
ZynqMP>

---
 env/sf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/env/sf.c b/env/sf.c
index 961e853eaef7..57ceaeaf3d89 100644
--- a/env/sf.c
+++ b/env/sf.c
@@ -148,7 +148,7 @@ static int env_sf_save(void)
 
 	puts("done\n");
 
-	gd->env_valid = gd->env_valid == ENV_REDUND ? ENV_VALID : ENV_REDUND;
+	gd->env_valid = gd->env_valid == ENV_VALID ? ENV_REDUND : ENV_VALID;
 
 	printf("Valid environment: %d\n", (int)gd->env_valid);
 
-- 
2.43.0

base-commit: b589e7f533826088aa8c83c13a1afd860edd7340
branch: debian-sent3
