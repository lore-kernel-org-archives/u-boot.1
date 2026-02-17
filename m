Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95978E68165
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 10:50:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D20D783AA9;
	Tue, 17 Feb 2026 11:50:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q+YayGTu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6BE583C32; Tue, 17 Feb 2026 11:50:50 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 616AE80325
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 11:50:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mlHtRb+RFV1Mec3ORX9BwQMSWMb6d/qYFAbg+yQ1jKE+6SberjuNhLv5PgoMGqpJGQhN9B4aqT7gWrYKPb4kOvcdA3GcTURJ5PyfF6mIqGVBBfqmlljBf9x3zxwUhI1lhzH0m7UzxeBZmtdGFeZj8ZGEEOII/USnIoqaAtjbulgbqqyHqQWd/wS7ffPl+nlfM/vVFazPNUb16aT/OuOzE1CShFJtAfXupQ4tx7xxXdnqBTEJy4B255rTtOSz2rechHDvlUsrtELhQ6W6vT4dd4cusb+u7VeUkaEF1D8Py3mSXqV9gXyV6d4810Yv9AfxZlMU8NwwKW0jrXW5GEoEEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqY3Bga3NkF1T1rIm7NfKwpN4CYQh/R2eNiXwcRyW/M=;
 b=gbHEUBFc7esoc1wknos90/65qQXylL4iksK0QxdMlPDSQsqiwXx+O/GPKrV5l+Crk4FkNMmWHrzJrNzBjn3/Wyq0Bo4FKHHf5vAmUNw2HJj2GL24vaGSECAxJKIOmUQg0x7cYSMVnvhPqQ1APs7rJSgReI34taR0EFOeQ7rEyE4XMD91O7438TYoozdb7599LhL4RRacL2oT0VS9f/qRqM0BQ22GaQJf/sYRntXWhgbSrqJAQQD4KzMm7lb6vdj6Whqv7fEqaAaHB19JTP6eLorifHrnZseu1zfhcZ2dzLo6uvg60muzqu291JUQolSHS65EzuSqdAt3fehbOwXGAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqY3Bga3NkF1T1rIm7NfKwpN4CYQh/R2eNiXwcRyW/M=;
 b=Q+YayGTuN6mp14eDBDxqUZB1rxWbHktLgL24F5jCoesGhBtQG7DtOB/GZHMVCoEr7A0E1LGrxYNuksUzuJv8dlI7gn2dYTfiCMWiATWbyD3z9dqlQ8ZWWp2kfE6UouBPEGnZY9VFLwhslEmL9zjs9ooDzHRd2WuooIRYxD09L8M=
Received: from MN2PR01CA0037.prod.exchangelabs.com (2603:10b6:208:23f::6) by
 BY5PR12MB4275.namprd12.prod.outlook.com (2603:10b6:a03:20a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 10:50:42 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::db) by MN2PR01CA0037.outlook.office365.com
 (2603:10b6:208:23f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Tue,
 17 Feb 2026 10:50:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 17 Feb 2026 10:50:42 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 17 Feb
 2026 04:50:41 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Feb
 2026 04:50:40 -0600
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 17 Feb 2026 04:50:39 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Marek Vasut <marek.vasut+renesas@mailbox.org>, Padmarao Begari
 <padmarao.begari@amd.com>, Pranav Tilak <pranav.vinaytilak@amd.com>, "Prasad
 Kummari" <prasad.kummari@amd.com>, Tom Rini <trini@konsulko.com>, "Venkatesh
 Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH] xilinx: Enable GPIO delay driver on Versal platforms
Date: Tue, 17 Feb 2026 11:50:33 +0100
Message-ID: <6744d3a93f48658178a53d218a4a6ca2fbb050dd.1771325431.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1191; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=A0EgK5706WxPR3UJccqVCId7OfKhx9EKYtyHhfmeBys=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWROcf/VcWTD/cjFZ34ekqvIv9+3wHbuf2/35VXvjC1tR
 f+4Sdjc6ShlYRDjYJAVU2SZzqTjsObbtaViyyPzYeawMoEMYeDiFICJMF1h+Ct0e8+VZJvyzTY3
 bx/I/z+rYbu08en4tz6PXp97s2DVJ8d/DP+Llt45Zptpu+Xf9R+r6j5wfheZbaowK6j6o+uJIwY
 tU004AQ==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|BY5PR12MB4275:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ec1354-28b9-4897-cfa4-08de6e126550
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vzN7YDVzI0K7k+4viPr+sEH2JigkIEm4Ddbh8qORZGufB7EKK1XrnySF+QAe?=
 =?us-ascii?Q?1plXud8xQsIbfvABQ/O7VQQn441aRBQaWAApioFWgTcgaCtTnxjTHDylERw2?=
 =?us-ascii?Q?MFu8krfT8hGXC3CKdX/jhmOtsh/kaRNupu0HIm6GPOSWyPFND295dcOZkWFA?=
 =?us-ascii?Q?9PYTq+tq6T1krMY/nDiRs/Lny2Eiml21JzbVmqFFm/oHuHMttAlZVsmHRv9l?=
 =?us-ascii?Q?Ocsd5pi3W6HCMmK29fqzbyV9uY4dfSDRV9D0GqksrBfRQKQT9+YYJ4PAKMbP?=
 =?us-ascii?Q?6uQHEKsgmUJQLqvuNSKFO7AfAbB0A7YG58VQtfalnAzZt6+1NfghobXJVFL3?=
 =?us-ascii?Q?xzglXKWI2RDc/Qf9tHzsxuGgFn8poc+FF6JuHPoONIEYKniJSaKFwuJH0Nmq?=
 =?us-ascii?Q?FM2WXAmlnpjJqMsVdz/p5gVvXuBf8eY2pE950TNMH2AzDPVwZkldK7jN7Bvi?=
 =?us-ascii?Q?jsOUzqgrTtC1g3wCo8ce2IkV7RH/CUjXNZCcTk7c3iSXKoOcekEzbPDubaqF?=
 =?us-ascii?Q?+bQyrvCvMkMfJqCf+zTw6ByV3TZVyLbSIxnK8ZwVK0M8Cdrm9EhaC9JvNTxR?=
 =?us-ascii?Q?udSRbXhC5mavppaSCXZK5IbJma1ISLiRt6rsogg9QvQL0Xw8ZHR8PUkZvPOj?=
 =?us-ascii?Q?Q5sZWrM6f6SE0jgJe914ktKt256DAOMnFoSBWXqUoGLU3lchw3UnKUlPGjgE?=
 =?us-ascii?Q?I2reISV3Pvdq5acX/JWeeEx1GTDlQ7R1e7HmW+WbM8T3A8rWx+zyeb7L7aM6?=
 =?us-ascii?Q?EJq9uuuWr58SuGYPaQsFq5+Rdrd7E+W+KDL8K+bWmcbvxAwgdVKTd8BHvli5?=
 =?us-ascii?Q?61dzx7eADKWm7KANMnUT9jsFu/fReOKD/Sb5e9RsxiqpfoFrW2UCZUZAG5l3?=
 =?us-ascii?Q?O59BmPhK3J7qo9DTAJgRJg60GmBAo7TERAbxuzsVWGmidxstrzhLIIVp/ROt?=
 =?us-ascii?Q?vUidLQ4TR2bWFMULGXHJrPCNZNJOrxBy1d2wvWBXzj4BAipuIMz6ILEhO5cV?=
 =?us-ascii?Q?AHlsZpcknm9NcU+eS7KqK5jKSPoI5m4EEzKXTUSoLexhedYpqbU4ZuwWrbPR?=
 =?us-ascii?Q?R3jZX5aMzWXRRbeIWnIQs4byUCHLhkgcDvtQFJVccb5eS101bmdygrwsOoao?=
 =?us-ascii?Q?AkoYuw4x39K+TFWbZkF5EMuvfRsgQ90+E3QS5cItj2FxQMmm1x4AtLdA8y8V?=
 =?us-ascii?Q?Ivmdjxlrx/VPYw/jw3p6C9WIsdfmCB3FPZkG5Y6gvfSeQn1WItamTUhn0o0O?=
 =?us-ascii?Q?CctcetRyvts71cZ0HNnyXqtGk4g8z3nVRvJ2vQaDq9pUXfhy64MP9ENPHYfU?=
 =?us-ascii?Q?2J6Nk5fcqBUoWNxeWtJaHQeobO5guwnd0h8V9H1T/lgshPP7eDD41pHXbFE5?=
 =?us-ascii?Q?P51DX7YmyLaxqSluw0rDv8DG2HF9hqij7Q4Bqxgi7InNiKEpR/2WqpAqdRdv?=
 =?us-ascii?Q?/YRV3hF5SKsxql0lEkcnvJAvUzsDTf51me8viaFTRmjV0pAz9MJnWwcNCI65?=
 =?us-ascii?Q?MJkzXN3R1qFS+fC4NRx6hX5yklXRsy7gTnvm83z85zvgw9JD54aciLF481PR?=
 =?us-ascii?Q?lHgqRzA3JSf9UcbpjVcggKZuiGBYmqddt5C1EubKb8EeEi2dzwiELApmpp/8?=
 =?us-ascii?Q?DXMX6BqbWgjhWAXdaMbowK7ywGsBdK7HMDzSWGNQh2K8T5tt+j3R+x4T6IUo?=
 =?us-ascii?Q?zFgrpg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OIHx55rmn0KZ8bM3kI9s14HlVgTArGVakGpqHdYneB8lTutgktN5f9vB0IjZq15QUl/PSMp9OO7shUihLUq3p+j251mAipGFhZ8V/yU1PfwGpysxzqyQMrP0mC7yeA+AxLTzb4fOsblufj3ETJi9vIY/yFYbv/n3M8CrCc5fPwfld9j6Kp3tzUALJYNzpsVPjPStbn+L5J6ai9AaMkfE5aDyPyK7MzIEqCwVcH5G+U+5f4Wh5p9SgvEJ8iggElUDPOpFcvsdCr5aZGlu1u2LV8JVjmtRFNopXQ1I2PKvSI00ZZNWBSLDTQ4GGolloZMlehyDWRbrtf8gXPoHDhG0iu3mwlQnPfa2YjlhjdyWNh+WDN53jDurnO5AbHTTbNJoeYnpaWM2Vf0xCUQhdBZwNcf/BBXADAUXC0xqvDE+jvNJ7dAbUcFtg1/Fa/w3kQpq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 10:50:42.1002 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ec1354-28b9-4897-cfa4-08de6e126550
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4275
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

GPIO delay driver is necessary to use to extend delay times for USB hubs.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/amd_versal2_virt_defconfig   | 1 +
 configs/xilinx_versal_virt_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index 94dce5c191c4..0296f378ea7a 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -82,6 +82,7 @@ CONFIG_DFU_RAM=y
 CONFIG_ARM_FFA_TRANSPORT=y
 CONFIG_FPGA_XILINX=y
 CONFIG_FPGA_VERSALPL=y
+CONFIG_GPIO_DELAY=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_CADENCE=y
 CONFIG_I2C_MUX=y
diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index e8d6f4cf6d63..d5d60d7f87d0 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -87,6 +87,7 @@ CONFIG_ZYNQMP_FIRMWARE=y
 CONFIG_ARM_FFA_TRANSPORT=y
 CONFIG_FPGA_XILINX=y
 CONFIG_FPGA_VERSALPL=y
+CONFIG_GPIO_DELAY=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_CADENCE=y
 CONFIG_I2C_MUX=y
-- 
2.43.0

base-commit: 54f9b6528e34f1f75c2258ed29887f496a35dd6a
branch: debian-sent3
