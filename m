Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A30D5AE72
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 08:25:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E62D78921A;
	Thu,  7 Nov 2024 09:24:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="d/RTwTXl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BD8189220; Thu,  7 Nov 2024 09:24:13 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20712.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::712])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 155EF88EBA
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 09:24:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rszjI/GX8abB+M/OG8yg16COpEKd36JQ/h7hdfFIEIw/yooznvyt+2GDIayCBy35I4Wp32nXKpigxiy8qtJLKfFY/vnkMdxYKtORirvfYznAtPCzZ2NtYGbl8Q/Fo88Xx8ViWr8DMmBOwJYeIRYHU4vcWFOcTYVpp0BLsoKEwpAlimQMIKd4TuAonshuJ3BOqgMn1ucp74VSmvlyiWc/p5a6PoOTRNCFNaXTeilALTShcz58IqQ2tx/EzR82q1O8lDf+pY5zrPu6qsXEjPPtb0Tx9AGL1BnuV70Cy0nSyJ1xqP23+DF1KnXdbrI4a5segzdLuMG5sWOcf3Q+nuui1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEHVMyV6CDIG73Btqb/UD3yIIYCB3CrqkMonuXMt3ns=;
 b=cT/D2sjaLLsD4y2m61YoTl/zstm2XDWG2XoYOzJX3oLaXESimCUfMbvyZI0EFSHt/1X0qGmPHzSjhbCjEgdM2EdnyeFPmWkmFIQ8eM99MO/bltuWp+sa5ArryXQMJQ3jP6km9vbEkHPlb1pda3NPWaF6XXLGVAia26evHpD4WW2n8N8YWS9loIH4XyGw66TOCCBjsRXmxOYYSuk5h9WoZeR9mwo1aMdzjKAXSMJRM8jzGNNU6ftjTMl5FHdkNoL9+NpBwSnrAjkro+qZmyrdnMhvEGKuf04/P1fP0gCBk099QZ73idng3dAb+RkbwPmQ6IrTa1V4Ajy3d8fgpUJzAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEHVMyV6CDIG73Btqb/UD3yIIYCB3CrqkMonuXMt3ns=;
 b=d/RTwTXlFDemG547q2jvtV3y1rWHwL3ZsMkPLzMSnkErEXrN+LFOB7wZu6EYezKcYgD40HJYtqjiNWyhiNbX3hpSDN6oAKidhaUZPcGQzwTFiLgAuZZefwQZCt4E9AwRtLuU2/QXIjgIZn2orOfo8p7AO3mgsg74WnAuSAjcKpI=
Received: from DU7P250CA0010.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::28)
 by PR3P195MB1120.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:96::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 08:24:07 +0000
Received: from DU2PEPF0001E9C4.eurprd03.prod.outlook.com
 (2603:10a6:10:54f:cafe::df) by DU7P250CA0010.outlook.office365.com
 (2603:10a6:10:54f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Thu, 7 Nov 2024 08:24:07 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU2PEPF0001E9C4.mail.protection.outlook.com (10.167.8.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 08:24:06 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 7 Nov 2024
 09:24:02 +0100
Received: from lws-moog.phytec.de (172.25.32.77) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 7 Nov 2024
 09:24:01 +0100
From: Yannic Moog <y.moog@phytec.de>
Date: Thu, 7 Nov 2024 09:23:33 +0100
Subject: [PATCH v2 6/6] doc: phytec: imx8mm: add OP-TEE integration
 instructions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241107-phytec_imx8m_optee-v2-6-bbc3747a60e8@phytec.de>
References: <20241107-phytec_imx8m_optee-v2-0-bbc3747a60e8@phytec.de>
In-Reply-To: <20241107-phytec_imx8m_optee-v2-0-bbc3747a60e8@phytec.de>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, "NXP
 i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
CC: Tim Harvey <tharvey@gateworks.com>, Manuel Traut <manut@mecka.net>,
 Benjamin Hahn <b.hahn@phytec.de>, Teresa Remmet <t.remmet@phytec.de>,
 Yashwanth Varakala <y.varakala@phytec.de>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.1
X-Originating-IP: [172.25.32.77]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C4:EE_|PR3P195MB1120:EE_
X-MS-Office365-Filtering-Correlation-Id: e7ea293a-7c88-40ec-1356-08dcff058c2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TTU4dFVLT0ZMeWxyNy9uWVZBQ1JWQm93RUtESmxRc1AzZENqQUJJMnVpLyti?=
 =?utf-8?B?WE15TXRLVHo3WU13RTA2YzFuUnV4N3VBZDBxSHZHcFgvUDJJRmVCdTJQdXk1?=
 =?utf-8?B?aUU0TitIdHdwQ1o2OFFSUGpweCt2NnRJZzY1bjBvKy95N1MramR6Zmd3c3lL?=
 =?utf-8?B?REhMNjdvTFNBOWRwSGlrYTBIcXQyMzlnbkcxTVIvNDNjK2xzYWo5dVhDRDJn?=
 =?utf-8?B?cXA4azQ4TU52WEhLY0lpOTdtM2lPRzNXU2Q5WFQza2xnSlV0MkJPZ2NGV2xx?=
 =?utf-8?B?REl6QXN1c1NlejQrdDFOQ25JdFdYN2x6Y252cnlEZm9ISEx1Y1JrR2hWTERq?=
 =?utf-8?B?TzQ0UzBsSllvV3I1M2c3VjNXc1lETksrUmQ5NTFtZk5PYVhkNWVvdS9rVWpa?=
 =?utf-8?B?bVRmNzNuQ3dDaHBjSk41MVdkUjVJcWVIQ05LMFJCMW5LRDdUdXZZeW1CR1gw?=
 =?utf-8?B?cldVZ0xrR3A3ZlBPZ1R2bXRoTnNJMVFmczlEOXNYUkNyN2Q0d1pEdXhRWFI2?=
 =?utf-8?B?S1BaSXdweGZCdEZ4WXl1U3FCU05OUTJzK2NuRHUzMDZ2QXJCWTQ4WXE0Rzhn?=
 =?utf-8?B?eEdlMGExK2Q5QjRVK01SVXpzb3czQmYwWjY1Z1JjSVVBZ3VuZEhwL3Q0WmNZ?=
 =?utf-8?B?VXVqNkZXNy9NVW9QL2MvU1l0SUdxUmYyNmpFc0dIWTZjRjlmN1hKczQ1ampE?=
 =?utf-8?B?M2VxSUpHZTlYdFM3REtudVI2aUpSRjI5elJ5T0s1UUJrUDB1NDBJd3NYOXJs?=
 =?utf-8?B?VDEyUUZQWnhKam5RU0dpcXNBMVNJU0tDOUhQWlVLNlBZNHIyUkxTejJCeEFr?=
 =?utf-8?B?YjZyK3o1c1hzaFdvdFhtdm9jQ29ZYUQvQmNheW5IR3E4ZWFlVmtxTUltSm1Z?=
 =?utf-8?B?Rjd6ZGhDSTdlbDQ3V2piMHE3cmhScm9XWWNtOGxZMmUvWTNhWXRtNFRYL2F4?=
 =?utf-8?B?UWxOVTgxai8vbU5IVWYxY3dXQjZtSXVLSExyd1RYdDR0Y0NGN3NTVXdER2dy?=
 =?utf-8?B?ZUdLK3JZU0VLQmhJMUx6RzlHTUN5TmRhZjFMNnRERGxiejRUSGx5eENvcU9p?=
 =?utf-8?B?N2trUjJ5R0E5NFZVSys3bVBuSTU3ZXVuekQ3ZGQrZ0ZnTWdwVHhZaTR5MXVG?=
 =?utf-8?B?eU1SeGxDOTBvcWd1cVN0VS9IK2hzNVg4Y1lhaWRkRFFsMmo0QkU4QmN4SlFx?=
 =?utf-8?B?VHJiWGViUnlMakNSSEJzUHFuRnVhamNibmR0TDZ5Q0F6cWxDeStlV1lBa0c4?=
 =?utf-8?B?Y0JBSEMvQ2hIaXh6bFdKeDFzS1BuV0FteGxFUTFiN2xCcXFaZ2tscnhvdWlS?=
 =?utf-8?B?SVVhcTJsZFFmRWh4bVVtOVJNbHlMSzBMVXl1dmp0YUQ0aWwxY0V0WEwxNUNK?=
 =?utf-8?B?UE14R0xrVTFhSlBlMVZqNGdzMWdaTXpKYlllWlRpZjBiZVJXcjdkOEpFTit1?=
 =?utf-8?B?bUNzTjhsbVg1c3psWlU1T2l3VkxVYk9mSUZ1Z2dBK2RVVUpqQlY0Y0tzaURL?=
 =?utf-8?B?YjE3SUVwblFuSll5dmRTYjFGTmhQM0FsUTNXZ0R1UXNvQTMzSEU0SDE2RWQy?=
 =?utf-8?B?S04rTzdsVHZKZjI2SDJ1eFJoOHdpeE0xTmZSN1EwZFphV2ZYOXJZb3dPd2VK?=
 =?utf-8?B?TkY0cWYxdGlHMnlKc3BKcDRpUzVXTFFxNjdEK2lrRDY3N0NIUU5MWitzVFpX?=
 =?utf-8?B?MVpKZVRNY1FadksrSnZQWjAwelRwRGFEbUd3OXFSdW5NZWNnYlJKc09kbGg4?=
 =?utf-8?B?SHp0eUROdUtJZW5GTGREMHBha1BFTzdmRGJWQTgrMzRqbXJadUJVSFhvNnVQ?=
 =?utf-8?Q?64al/TkWRm+DYKgRiR8ZwxucYkt6lOw9ktgb4=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 08:24:06.9954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ea293a-7c88-40ec-1356-08dcff058c2e
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF0001E9C4.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB1120
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

Add instructions on how to build and package OP-TEE for the
phycore-imx8mm based boards. The build instructions are identical for
phyGATE-Tauri-L and phyBOARD-Polis.
Also fix missig '-' for TF-A build instructions.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 doc/board/phytec/imx8mm-phygate-tauri-l.rst | 26 +++++++++++++++++++++++++-
 doc/board/phytec/phycore-imx8mm.rst         | 25 ++++++++++++++++++++++++-
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/doc/board/phytec/imx8mm-phygate-tauri-l.rst b/doc/board/phytec/imx8mm-phygate-tauri-l.rst
index 28b614fd144..d9b5124365e 100644
--- a/doc/board/phytec/imx8mm-phygate-tauri-l.rst
+++ b/doc/board/phytec/imx8mm-phygate-tauri-l.rst
@@ -9,6 +9,7 @@ Quick Start
 -----------
 
 - Build the ARM Trusted firmware binary
+- Build the OP-TEE binary (optional)
 - Get ddr firmware
 - Build U-Boot
 - Boot
@@ -20,10 +21,32 @@ Build the ARM Trusted firmware binary
 
    $ git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
    $ cd trusted-firmware-a
-   $ export CROSS_COMPILE=aarch64-linux-gnu
+   $ export CROSS_COMPILE=aarch64-linux-gnu-
    $ export IMX_BOOT_UART_BASE=0x30880000
+   $ # with optee
+   $ make PLAT=imx8mm BL32_BASE=0x56000000 SPD=opteed bl31
+   $ # without optee
    $ make PLAT=imx8mm bl31
 
+Build the OP-TEE binary (optional)
+----------------------------------
+
+.. code-block:: bash
+
+   $ git clone https://github.com/OP-TEE/optee_os.git
+   $ cd optee_os
+   $ make CFG_ARM64_core=y \
+     CFG_TEE_BENCHMARK=n \
+     CROSS_COMPILE=aarch64-linux-gnu- \
+     CROSS_COMPILE_core=aarch64-linux-gnu- \
+     CROSS_COMPILE_ta_arm32=arm-linux-gnueabihf- \
+     CROSS_COMPILE_ta_arm64=aarch64-linux-gnu- \
+     O=out/arm \
+     PLATFORM=imx-mx8mmevk \
+     CFG_TZDRAM_START=0x56000000 \
+     CFG_DDR_SIZE=0x80000000 \
+     CFG_UART_BASE=UART3_BASE
+
 Get the ddr firmware
 --------------------
 
@@ -42,6 +65,7 @@ Copy binaries
 .. code-block:: bash
 
    $ cp <TF-A dir>/build/imx8mm/release/bl31.bin .
+   $ cp <OP-TEE dir>/out/arm/core/tee-raw.bin tee.bin
    $ cp firmware-imx-8.23/firmware/ddr/synopsys/lpddr4*.bin .
 
 Build U-Boot
diff --git a/doc/board/phytec/phycore-imx8mm.rst b/doc/board/phytec/phycore-imx8mm.rst
index e9dc2259907..5a4e8a669c6 100644
--- a/doc/board/phytec/phycore-imx8mm.rst
+++ b/doc/board/phytec/phycore-imx8mm.rst
@@ -9,6 +9,7 @@ Quick Start
 -----------
 
 - Build the ARM Trusted firmware binary
+- Build the OP-TEE binary (optional)
 - Get ddr firmware
 - Build U-Boot
 - Boot
@@ -20,10 +21,32 @@ Build the ARM Trusted firmware binary
 
    $ git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
    $ cd trusted-firmware-a
-   $ export CROSS_COMPILE=aarch64-linux-gnu
+   $ export CROSS_COMPILE=aarch64-linux-gnu-
    $ export IMX_BOOT_UART_BASE=0x30880000
+   $ # with optee
+   $ make PLAT=imx8mm BL32_BASE=0x56000000 SPD=opteed bl31
+   $ # without optee
    $ make PLAT=imx8mm bl31
 
+Build the OP-TEE binary (optional)
+----------------------------------
+
+.. code-block:: bash
+
+   $ git clone https://github.com/OP-TEE/optee_os.git
+   $ cd optee_os
+   $ make CFG_ARM64_core=y \
+     CFG_TEE_BENCHMARK=n \
+     CROSS_COMPILE=aarch64-linux-gnu- \
+     CROSS_COMPILE_core=aarch64-linux-gnu- \
+     CROSS_COMPILE_ta_arm32=arm-linux-gnueabihf- \
+     CROSS_COMPILE_ta_arm64=aarch64-linux-gnu- \
+     O=out/arm \
+     PLATFORM=imx-mx8mmevk \
+     CFG_TZDRAM_START=0x56000000 \
+     CFG_DDR_SIZE=0x80000000 \
+     CFG_UART_BASE=UART3_BASE
+
 Get the ddr firmware
 --------------------
 

-- 
2.43.0

