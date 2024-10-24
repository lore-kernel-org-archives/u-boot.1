Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 289A1D0BB69
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 07:04:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA9008932D;
	Thu, 24 Oct 2024 09:04:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="u8kCDFrZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FBA788D97; Thu, 24 Oct 2024 09:04:24 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20726.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::726])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C55CC89330
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 09:04:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9foY4ewiDOo9edwLBFP0cPbmyVp44ekpKLDYEf37zANs8a5gReShJ8qSz+1ltz63Y1yMQdONAxYH8qnZy5KZ/a/Fk/cZTQQQQQFMLzJjXIOLjCoZz2Qux6jXOknH7e+jPm7dre5DoPKKAnTfVP+ULXcQ2byfAFrFjNASvKyTeiRiM2Tiey+5j3JExTykAbJqH25MilIEJgjZQXbQs6UZhMzKb0O+w4BIoTcUqO7iY3OG4tolAAJ+5U0dRy+PN4ck5dUnPqfE5smDS1ZNB5UASmL8R694/Vyfk/LepTEiJi2woDeCVFYy9ma5+ZTk0ludtmtcJ2UFzwQRC2DqjG6yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEHVMyV6CDIG73Btqb/UD3yIIYCB3CrqkMonuXMt3ns=;
 b=AaUyp6ipcdXSwAr9nG2Z7It0b47w/b0xSNflrNgPZByTAAR0sJwK3O+4ZueWwwL6KIJFFtscfs9+RvVMlm+szvHZa97qf0a4EmVqFFdGkfUXhEAtp+K56Q2Bvmsv4QPg13i2ouoZ+M2hMjErNztGdxPClIz9L2VNsKSb+MqBvfdkkLJ7ja79Gbd3+11Tar+d4lC2rCcKdp9B8xWMW8Vq4WINnXxKBgbkIQQpFQCC7BRVOGpcfmFXMxww8ha6rANmb7TtGJzIhTHYcIhbzO4hYOGRq2lbQD2A3cHYRu2yV+mU5SAd5vigo4oMLyUnHZk1M9DGLPoqxuHssqteUfQanQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEHVMyV6CDIG73Btqb/UD3yIIYCB3CrqkMonuXMt3ns=;
 b=u8kCDFrZvkK7s78aNYZSSveUXO1pVRhHieyCgd9WBXlDL0GeFd/i/ek6GrzpDrOtCrh2Sb+Cy+gdRcxWiT1WQXwrXGQnn7yjJ/dBJcMIMwLbp1TPIg2pBADmohvGVnbdv4GAwEi/eleiNwhZ+3fXHxYcObGvK0AUImlxqZ4JCSU=
Received: from AS9PR05CA0337.eurprd05.prod.outlook.com (2603:10a6:20b:490::9)
 by PR3P195MB0959.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:a3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Thu, 24 Oct
 2024 07:04:17 +0000
Received: from AMS0EPF000001B6.eurprd05.prod.outlook.com
 (2603:10a6:20b:490:cafe::25) by AS9PR05CA0337.outlook.office365.com
 (2603:10a6:20b:490::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18 via Frontend
 Transport; Thu, 24 Oct 2024 07:04:17 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF000001B6.mail.protection.outlook.com (10.167.16.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Thu, 24 Oct 2024 07:04:17 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 24 Oct
 2024 09:04:12 +0200
Received: from lws-moog.phytec.de (172.25.32.62) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 24 Oct
 2024 09:04:11 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Thu, 24 Oct 2024 09:03:40 +0200
Subject: [PATCH RFC 6/6] doc: phytec: imx8mm: add OP-TEE integration
 instructions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241024-phytec_imx8m_optee-v1-6-fc6b78bf9a9b@phytec.de>
References: <20241024-phytec_imx8m_optee-v1-0-fc6b78bf9a9b@phytec.de>
In-Reply-To: <20241024-phytec_imx8m_optee-v1-0-fc6b78bf9a9b@phytec.de>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, "NXP
 i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, "Simon
 Glass" <sjg@chromium.org>
CC: Tim Harvey <tharvey@gateworks.com>, Manuel Traut <manut@mecka.net>,
 Benjamin Hahn <b.hahn@phytec.de>, Teresa Remmet <t.remmet@phytec.de>,
 Yashwanth Varakala <y.varakala@phytec.de>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.1
X-Originating-IP: [172.25.32.62]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B6:EE_|PR3P195MB0959:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b2b3145-1cc4-4d0e-8d33-08dcf3fa1346
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWVnaXZuUFgyRmZLUC9KTTl1Mlo0NUJTZkdiRGZrU0VNUURBcFNydVZOUWRj?=
 =?utf-8?B?SFdYdkU4bGNzNnYyb0hZQkpwUFR3RUFFNEtISjZxczJJNDdWTmNYdVQwMTRv?=
 =?utf-8?B?MUZBRUZ6WFZFNjgxMEpmOGJoTWtieHBZNWNJR2h4Y2VYdWNBTTNoNEJnZFdK?=
 =?utf-8?B?eThYdEo0dWcxbS9HcmRhZUVabExIcytYekFFWjRJMTN1Vm1aRkRINWQyVm1z?=
 =?utf-8?B?VTU1Y1ZLb0NOZEVQaFFZV0YwZ1FTQkRxdzJpMTZhNVZSTWlEc2NiYlplSXBp?=
 =?utf-8?B?WFVqbjdROExMS3lZQk1oMzNCOUJrVXUwSGRXN3haZXFuTERFMzFRZWhRd3k2?=
 =?utf-8?B?Sm9TdUk0bU9vNTRldGZTV21XWGZHU2MzbkdOd3kxYUlSTlVlODd6all3ZFZL?=
 =?utf-8?B?OUxWMHNwcU5pTWFoTFJnbTZCTElWckRlRWRmaURLb1JyZW1JZkY2WDR0bTZT?=
 =?utf-8?B?Y3orUk10R0RTRHVZS3dqT1ZyRVZtYkt2MjZEZU1aVVRhY0pQQy9LQW0yTHRS?=
 =?utf-8?B?RVhEeHJFQ2NGZENoRmxlNnBMYTM3bmZYRGpNOTBEaE5Mam8xSE1rQmdyMGkz?=
 =?utf-8?B?ek9vcmZlRXZ0MVFRd28vaDY2NFlsQ2pWSW5pcWtwQm13TEEwOUQ5dUFTbnk5?=
 =?utf-8?B?MTVqaGljenRtQ0UrbmtueDBtZFA0QnE2VlZpcjNUdnVTTDNrZzVKbm1rSzFO?=
 =?utf-8?B?K2NFQlpFQlNwVUtaUS96YjlBWmdEa1hlQjZrNk0xcG83dHZNclBhY0J6ZFRq?=
 =?utf-8?B?RHpCV1BieXgrdGNiMGVXa3FtRUhYdktWVmE2eEpZWVMyeXNNRFJWVG14TUtL?=
 =?utf-8?B?Q1p6UHVkUGVGdnZtcVV5cGRiYWxmbnhIRUJGa2FCM2I3WTFDVVdMVXIxRnpu?=
 =?utf-8?B?UUhuZCtPWEYxaGluYmNsUXhlNVphV3BQRCtDeU9Oa3k2TkFMQzJYd1E4dnVI?=
 =?utf-8?B?QTNwZVRjbmk0TE1rN0E0emhyU2lYWUUrRVh1cVBQQUdGL1RtUUdFSkdodkZ0?=
 =?utf-8?B?UWdsQkdNTjAydkVxamFYaXZmRTJyNmh5NVc2aFp0cXlPMDBMbk5TWmxpaUdq?=
 =?utf-8?B?cHVrSUtDb050dWdLczExZXBoTUlEQzB3VE5YMFFUcVJiZGZDNDhjOFhYakZ6?=
 =?utf-8?B?T1NwdkV0ODRXS2NrMjRpVG1XYWN6U0s5UmRPVFJnbURDeGhvby9JcFlvSHp3?=
 =?utf-8?B?bk9CQjBnQkxnZ3FhOFNlYU15YlpVV0VrUnAyczk3V1o1TnJ3b01vTjVtN2lx?=
 =?utf-8?B?NWJ3aXgzNFR0cElpMFhMMW1xSkFmQ0JFaTJmRmlsUm5RUXhxR1F2V2psUlJY?=
 =?utf-8?B?dkV1MnJUV1p1aWl2akhld0ZFUTZ4STZuVnlVTG9LcTExQTVWREJ1Vm9RbXJZ?=
 =?utf-8?B?ekZGSlllbDZWM2V0ckttaVIreW5PWG9VNXhidU5JMlErOHFSaVU5U1RFRFlk?=
 =?utf-8?B?UUE5NnZhMHY4RkdiL2VmaFZnU01MY2hsTE9VQ25ZZG43dDBkZjRZUjJYTTMw?=
 =?utf-8?B?NWIzL1FOVy9sL2dIbTJDWmd0K21VMEROWjExYkgzNElUcTJQRVQxbGIxRzBL?=
 =?utf-8?B?ZHlRbnJWRWI1VjZtazIwakQxSWJZYlVCMXpmc1dPYTFKWm5ITE94V2ZNOTBB?=
 =?utf-8?B?VzVaUFE0NlhRdDRPRjNQRnU1d3FxUkc0bWJrNXNta1Bub3pqZUtyTGhTd2pl?=
 =?utf-8?B?a3l0amw2TGNYZTYzOC81RVM1ZjRnN1Rad2paUjNtdmxVR3hmaE9rbk5SSDY0?=
 =?utf-8?B?Y21ZaGl6blBFRGRCSUFWMHFqUkl0dkZOUFBuZjZuZHVoeVBFSG0zY05qMkUy?=
 =?utf-8?Q?YbmGqzQNlguzW8ScpfkirP9y8DI6Z02xRYEo4=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 07:04:17.0219 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b2b3145-1cc4-4d0e-8d33-08dcf3fa1346
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001B6.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0959
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

