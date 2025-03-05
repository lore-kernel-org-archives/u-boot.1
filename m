Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC5EC19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 05:00:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FC0C800C1;
	Wed,  5 Mar 2025 05:58:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="NJELTx5A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 485BE800C1; Wed,  5 Mar 2025 05:58:56 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2071f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::71f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AE6280FDD
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 05:58:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UzWbEqsg97RqNOmoyjEjIg8J3PJArorqzppuvQzS/rpK3I5pBjmuDPpOsm1IEnyWm49i+qvBD2+G/LjYzddY8jcXB+kNSUQhY49eczJddKqg/7h6ePHKEpJrV4VkBGyBOFqQkdNmIpflt0qsClW1aHa7h5P6j5KKm2OP8chgb5EbohzwiUd+p/Guug1pa2IsAytPf7LqYN9iY38C7PJjSAIs3j14RP3pvJ8GxE6s/Tz5jKj5FcHxq/VuHgNb/z3IwULzE1a+nQZVT4AZGKWt53tOyWG+gmyznAadjE4i2TIU+oAFLXL0A4PtMuyKY8FRtoHH74r+nVrNM2q7F/bBDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xMQrnq6/XNu0pB4x2oGWijPYw3QyFrmBhGhHuteKhI=;
 b=tgiE5QNdrYe3Nz5j7dX91usaRJPiRpKfdK4Afh+OJFopjjW+LGRd0f98I6zKCPSnTReblOSSYlt9Uiq3zf6febdXD1XZOMS212gnkP9DhvD0sIRBQTrnNqnvjp2LqK1mvuoQ+2rQBANir4gRbbtTT5SsOZTjZEbfNrQrbOdrJD+kQ1hUG+nXTmunDPNgbyK0vckqG5ifTQQjixNGSpYITX0V7hBOWOO+oSFaIoqIKBGhbEqbX8A7RXRwIHjGa18wbwGV8n+lWiFmk00oyPoJshfWLoPgh4bAOYXH+cvTug8iw9Yw2O6CMBSUb6Vdb3pKcQ2rB8Fp4RC8QNdad0kxWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xMQrnq6/XNu0pB4x2oGWijPYw3QyFrmBhGhHuteKhI=;
 b=NJELTx5AKAi+tC9YdqrnJmAOENVzprmTAVAj072lor9TtaFKUv718nIKfxB11ZldcdmmzIi+WxgfJBsBB7JjPfn3AMxlfrH8MnqpC67yW1CRP9cnmxRuGGro8Q+CX9MfW/45oCFjB9g3OGQl8nzKHeiNfSG3kXY/QiLeNBBqcoChfJRNjEjXQtZkxlhNYodakeWbbzYHwwKKtyYtJGIQYw4OZ6z5NI1EPwfcUMAcX6SqW0VLYls1QrRhhf3k5oYQRAHDn9oifovf88uyTiQsiSo2M+iWy+bAHM3dCDcGRAtd+qNvxkWMYJdTNLTvuHJ4Uen3An8qvTgyqCRF3ESpFw==
Received: from CWLP265CA0265.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5c::13)
 by PR3P195MB1022.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:95::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 04:58:50 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:401:5c:cafe::82) by CWLP265CA0265.outlook.office365.com
 (2603:10a6:401:5c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 04:58:50 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 04:58:49 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Mar
 2025 05:58:47 +0100
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Mar
 2025 05:58:47 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <ggiordano@phytec.com>, <d.schultz@phytec.de>,
 <joe.hershberger@ni.com>, <n-francis@ti.com>, <afd@ti.com>,
 <nmorrisson@phytec.com>, <d-gole@ti.com>
Subject: [PATCH 04/13] doc: phytec: k3: Add a common part for Environment and
 EFI Capsules
Date: Wed, 5 Mar 2025 05:58:29 +0100
Message-ID: <20250305045838.3614661-5-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250305045838.3614661-1-w.egorov@phytec.de>
References: <20250305045838.3614661-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|PR3P195MB1022:EE_
X-MS-Office365-Filtering-Correlation-Id: ccb70fdf-872d-4079-799a-08dd5ba26b54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Sop2YHNyFCyChc1YspKx1s4vWVyHKf5IgQ2oCigqMLbuj7xhh6eBLQ1wQ8je?=
 =?us-ascii?Q?iFpkGXFsdRFHWUNExVCB3TZdeO8EuANswgYvgtFCeWlg9JDE3hDMnBinyS1R?=
 =?us-ascii?Q?z33XFi0mMkcAPwGXHzDD37MSwV7VmNYbdiXtm47KcWl1kSWJ8BPkacN0oKnc?=
 =?us-ascii?Q?HPOLdMVk5jKSAAFchSmfxAzxNgYzDl+lSsa6Kq0Dwhi74Wq+tEQbNyiNuZBQ?=
 =?us-ascii?Q?UxtD7YTeu5Q5bUGotFIOIj5UwtmWVcGgmws6WQfm8WMf4oAvTCs7xoXvNxhI?=
 =?us-ascii?Q?Ax4mEOa9HDtetbHmpjJvpLTIOSnyGsGFIlpOk0TzfbcZ/eaO+0A3rCpKlnNg?=
 =?us-ascii?Q?Fz4UgXRaZdlvUPxRddBzq+T6j+YXiDWx9zu3PQ38hYqpwIIUJHG8tu9us3Bc?=
 =?us-ascii?Q?ED1eLsdvqvnw4VcABqVeidcdKYPbfkXnnipaSMegID+iL7OgF7POLUoG5hQw?=
 =?us-ascii?Q?sQrJaBf1PP1ow6sKd/X3/2aSMgEcN9v2oEUmLjy2zaHObRCF242BQMXgpg3Y?=
 =?us-ascii?Q?H1uZhF4pSDBHLTxBA/1aX6PJYZ0N/as5QYKhNxK9SYZQa4UQW01h68nuLWtO?=
 =?us-ascii?Q?eWseSSsc9Xev3is5HyHSxCt/ng5HuelZXTOHnaBMY0UZxNK/jhc7hE40rVzA?=
 =?us-ascii?Q?MNKMJWkK+NIkar8ca7fXfZBzkZXIH2uMJFQ4p2fxztP2JEZqEMYaTwZYIIKY?=
 =?us-ascii?Q?OxKJiLJy3qE9KUgk0RPpN0mlJ3RdUZxdoMNkfzrY4y8L3EGYUltl+7iZEBtX?=
 =?us-ascii?Q?IceTRmbD33sgAuvueVAcRKXTSGOHa0Fi1p8T/6jBXNGmvMUHi9aITLCDhUs0?=
 =?us-ascii?Q?aZKbu0XYvx62DOaz+QxHFWSNZZ+SZHhbd9B4NXhBqCAyhKamFquzGgUGPBFX?=
 =?us-ascii?Q?rCQIS5F9t0d17egqyeAyWRDzboG+844SPs2jSLzGY2DhkLbSoxEbeIVlWiEx?=
 =?us-ascii?Q?KYhwIFBXKAQqkMcP8PnYqMLlbgfrE42MksOyncCEvz57grfos7MAe+cv+dkX?=
 =?us-ascii?Q?DEoMAtft+ezzeaMX+jV2yjwq7ztFsyOOS9/45+hzCxJjfLMFRXoKWn0L5NDx?=
 =?us-ascii?Q?3ZGofsmUTF0ExATmQaQ9CAW5E4hup1qJrClxe5C6VFJOB/RY3z89aXLYkAky?=
 =?us-ascii?Q?uijIUw+72M15fzhk8mX5j3YUsBTltShjWPGGFBsxw2bgMil3fhc756O02gO2?=
 =?us-ascii?Q?JC5u/jGVF/nCBJrOl+8E85MxeOcTboQ6xEOl77JIt3Q0Uopd7aSOTLswvcrk?=
 =?us-ascii?Q?HUQ4t7DygJRzbC1vfzR0M81PlzTMD3+RHfXUMcH/5KFVVMRq1UKUMisiW/hL?=
 =?us-ascii?Q?2Y4SsQIhj/zwDibaQRj0Wm0G9MZsjZYglyfEshU9GaWasx2O6ZK/jeDms2nv?=
 =?us-ascii?Q?K1UCuWCEg6Jc/qs4xaZkIO2UH7ZAtz516TeNTXWLVv1cxHqfAlABitTxyd4z?=
 =?us-ascii?Q?+SbFA+C2Nrox78lF391NyLi2bFUBwsNbLPUc/FevvWT44XKPuhDQuA+iaIuY?=
 =?us-ascii?Q?MTVQJ0kperKbNO0=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 04:58:49.9537 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb70fdf-872d-4079-799a-08dd5ba26b54
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB1022
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

Provide a common part for our K3 based boards including general details
about environment handling and EFI capsule updates.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 board/phytec/phycore_am62x/MAINTAINERS |  1 +
 doc/board/phytec/k3-common.rst         | 67 ++++++++++++++++++++++++++
 doc/board/phytec/phycore-am62ax.rst    |  2 +
 doc/board/phytec/phycore-am62x.rst     |  2 +
 doc/board/phytec/phycore-am64x.rst     |  2 +
 5 files changed, 74 insertions(+)
 create mode 100644 doc/board/phytec/k3-common.rst

diff --git a/board/phytec/phycore_am62x/MAINTAINERS b/board/phytec/phycore_am62x/MAINTAINERS
index 670c7473481..8f2b8069ad4 100644
--- a/board/phytec/phycore_am62x/MAINTAINERS
+++ b/board/phytec/phycore_am62x/MAINTAINERS
@@ -12,4 +12,5 @@ F:	configs/phycore_am62x_r5_defconfig
 F:	configs/phycore_am62x_r5_usbdfu_defconfig
 F:	include/configs/phycore_am62x.h
 F:	doc/board/phytec/phycore-am62x.rst
+F:	doc/board/phytec/k3-common.rst
 F:	board/phytec/common/k3
diff --git a/doc/board/phytec/k3-common.rst b/doc/board/phytec/k3-common.rst
new file mode 100644
index 00000000000..ffb50b51ad6
--- /dev/null
+++ b/doc/board/phytec/k3-common.rst
@@ -0,0 +1,67 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. sectionauthor:: Wadim Egorov <w.egorov@phytec.de>
+
+Environment
+-----------
+
+
+Variables Set at Runtime
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+At runtime the `boot` environment variable is set to reflect the source from which the board was booted. This ensures that the correct boot path is followed for further system initialization.
+
+
+Environment Storage Selection
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The environment is loaded from a storage location based on the boot device:
+
+* If booted from eMMC or uSD card, the environment is retrieved from FAT or a fixed offset if configured.
+
+* If booted from SPI, the environment is retrieved from SPI flash if enabled.
+
+For all other boot devices, the environment is not stored persistently (ENVL_NOWHERE).
+
+
+Saving the Environment
+~~~~~~~~~~~~~~~~~~~~~~
+
+The `saveenv` command will store the environment on the same device the board was booted from, ensuring consistency between boot sources and stored configurations.
+
+
+Capsule Updates
+---------------
+
+Capsules for each of these binaries are automatically generated as part of the build process and are named `<binary>-capsule.bin`. For example, the capsule for `u-boot.img` is named `uboot-capsule.bin`.
+
+
+
+Performing an Update
+~~~~~~~~~~~~~~~~~~~~
+
+Each board has a dynamically generated GUID. To retrieve it, run:
+
+.. code-block::
+
+ efidebug capsule esrt
+
+To update the firmware, follow these steps on the board. Ensure the capsule binaries are available on a uSD card.
+
+.. code-block:: bash
+
+ load mmc 1:1 $loadaddr tiboot3-capsule.bin
+ efidebug capsule update $loadaddr
+
+ load mmc 1:1 $loadaddr tispl-capsule.bin
+ efidebug capsule update $loadaddr
+
+ load mmc 1:1 $loadaddr uboot-capsule.bin
+ efidebug capsule update $loadaddr
+
+These commands load the capsule binaries into memory and trigger the EFI capsule update process.
+
+
+Important Notes
+~~~~~~~~~~~~~~~
+
+The updates are applied to the boot device from which the board is currently running. For eMMC, updates are always applied to the first boot partition. Capsule updates can be performed on eMMC, OSPI NOR, or a uSD card, depending on the boot device. For any additional configuration or troubleshooting, refer to :ref:`uefi_capsule_update_ref`.
diff --git a/doc/board/phytec/phycore-am62ax.rst b/doc/board/phytec/phycore-am62ax.rst
index 0c5b4814fc2..e1f741011e7 100644
--- a/doc/board/phytec/phycore-am62ax.rst
+++ b/doc/board/phytec/phycore-am62ax.rst
@@ -176,6 +176,8 @@ Boot switches should be changed with power off.
      - 11011100
      - 00000000
 
+.. include:: k3-common.rst
+
 Further Information
 -------------------
 
diff --git a/doc/board/phytec/phycore-am62x.rst b/doc/board/phytec/phycore-am62x.rst
index 56c1fd8354b..36315b49931 100644
--- a/doc/board/phytec/phycore-am62x.rst
+++ b/doc/board/phytec/phycore-am62x.rst
@@ -176,6 +176,8 @@ Boot switches should be changed with power off.
      - 11001010
      - 00100000
 
+.. include:: k3-common.rst
+
 Further Information
 -------------------
 
diff --git a/doc/board/phytec/phycore-am64x.rst b/doc/board/phytec/phycore-am64x.rst
index 01c42b90660..71f1fd7b404 100644
--- a/doc/board/phytec/phycore-am64x.rst
+++ b/doc/board/phytec/phycore-am64x.rst
@@ -175,6 +175,8 @@ Boot switches should be changed with power off.
      - 11011100
      - 00000000
 
+.. include:: k3-common.rst
+
 Further Information
 -------------------
 
-- 
2.34.1

