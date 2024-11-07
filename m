Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 917E4D5AE72
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 08:24:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 367758921B;
	Thu,  7 Nov 2024 09:24:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="frlL0I8O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86D6C8922A; Thu,  7 Nov 2024 09:24:11 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::701])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B4A48921A
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 09:24:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xe3/Nn+n8mViYHXzF9RM7XuQanNFsAIScIVtFwBwBoIVMWr81194CIM5IVpo4CkvJhJzscHa7306VWW40ANILdFegbpDhcVUgXdWCMa+bUQz9ldOuunCHyMOZ8E+VzGGjvrwBoNoaf1xEeKJa4ouP+yD8X0OoREAcTXwm3kpkmMvFMuL2IgQUhQ1c17ypDCokDUwwPZmOUZLTW0dPx08SrBYZrGrWQd0bXjYttJMlVYHuZrc5ppemmtyMgMP+qQs9wKGhxOjqkNSHBp9klWWzLZWfWsD4L6dOnSlTlKkGRKY/wqaZkrNTnWpMehTTcsKIaarJDaepaDPWsW7seVNvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZ0aBXsv/GB4nromjqbeMvRAHbJbsV8rMBvnhzvCOEo=;
 b=vTWW2OFuc0JLKP+SEeeMJ8dHT2JvK+pKUdmwBjeU+Q66w9GqB7Xu1M+dZFaNKHWr0ShvzmjoxzlMhf0MRN4XVPeTPEIKuOlYBlRVKhT352FAD+e711KnV4rge7DmJ2uC6FcqatiX2d8PzerkmU1eUZQj2dbR+Fh9CPts6j/k3MpyQr1g5nUtv0zbywITrnHwFg+eZeqynuKvYBXnckQo4Pl1d+RRXtFmZkivOpYjdOT9GNxi4kGBRaMHFS+uOoyWMe69PCXuvlyJMo35XfxDp2ylUWN6ewjFBSE5Ns90k8s+07aQ0xVKwD19MWPcWUZt6RD5Du8xii+h8r8EKo0UzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZ0aBXsv/GB4nromjqbeMvRAHbJbsV8rMBvnhzvCOEo=;
 b=frlL0I8O12txzKM9AO6oW/x+HoowON352Uij2UbQePPncu5wyh+4SmjIzrrwmRDdcgA2vKzvd4eVDy+7CVyd/to/T3mF+V2pUV/FDj1iFF32eIKQ9//yYdk8QL20eI3zattmrQhklXCLYs7sHqS9Q6XD5QQ+wI4z0z6YU+AZzNU=
Received: from DU7P250CA0006.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::21)
 by PA2P195MB2532.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:408::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 08:24:06 +0000
Received: from DU2PEPF0001E9C4.eurprd03.prod.outlook.com
 (2603:10a6:10:54f:cafe::cc) by DU7P250CA0006.outlook.office365.com
 (2603:10a6:10:54f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Thu, 7 Nov 2024 08:24:06 +0000
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
 09:24:01 +0100
Received: from lws-moog.phytec.de (172.25.32.77) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 7 Nov 2024
 09:24:01 +0100
From: Yannic Moog <y.moog@phytec.de>
Date: Thu, 7 Nov 2024 09:23:32 +0100
Subject: [PATCH v2 5/6] doc: phytec: imx8mp: add OP-TEE documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241107-phytec_imx8m_optee-v2-5-bbc3747a60e8@phytec.de>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C4:EE_|PA2P195MB2532:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f826bd0-0997-44b1-c7e9-08dcff058be1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VjRyRHhQbEJ3U0FhaTVqcVNlLzcxcEJGNDk0OEt4R21qNUk2VjFLSEJEMzJi?=
 =?utf-8?B?TXVPd2tmWFRlK3pHenhsTk1aVkxSc24xSUNtMVBaNWIyZDRVOHVSbkU4cFhs?=
 =?utf-8?B?emdxc1FZTVZ3Y0dpSHg1VDJwdk12ZzNUSFVKTVFUS0Q2c0tYb3RUZEt0ZUx4?=
 =?utf-8?B?Z0dLMXdEa3hFeGg2YlF6NG1LVEV5MGE3Rnc3VGx2WlpRY3JlWWRIeVdYc1Zh?=
 =?utf-8?B?aVZPZlByRW5UVHpVK2lSRnp6QkNJb0paalZQSFd3Vmw4aHJLaFgrazVpazM4?=
 =?utf-8?B?VjMzSlZYTjQ4NFVUVVhPV3ZZcER1S2xKQk9PbmdDUTFwZWwvVGdweVdCTmRD?=
 =?utf-8?B?YXZvOTRyVERqQjZ4TVUrQVNxUGw0TysySlhFMnFIamVPQVVESlVneFZWV2dh?=
 =?utf-8?B?MXM4cS94Q21YU2RCSDRHRGZhMjJsaWdxa0I0R0VZV09uayttTFlNNVdLbXll?=
 =?utf-8?B?bUVWV2lPcEhHUmdON1hUWnVtVk1TQ2hoKytSZ0tyMFQ2MlgvQ0FjZGdqKzN6?=
 =?utf-8?B?OUo4aVR2MmZPTHFFSndIaGw0UmhYWmFRL1hmV1lUY3BIY0pieWxlbGZLK0J1?=
 =?utf-8?B?TW0xbTcyRzdXd282cnNiWkl5VUFzeHVJMHRzN25tYnBmM3RUT2kvRE1SNEUw?=
 =?utf-8?B?QjdHZDFoTENUM2F2RS9hYitCMEQzNVdGRWtkd0twb0QxcDBMeDltUUVma1N1?=
 =?utf-8?B?YmJoVksxL29PdG9rMlJmQ0xqN1FHRWlCZHFQUUtSZlZhUjVOMzlXdm9CY2V1?=
 =?utf-8?B?Q1Y5cjZIMHlGaXlaclBLZTNWUWZjMks3UVBpb1FJVUtNcjZPd003M1NHY3ov?=
 =?utf-8?B?YThEdzVDd2w5OGd6OVAxVUQwU01ESG5PRDhKY0RuMGJGOWRLMHVpMEM3ZnNP?=
 =?utf-8?B?dW04UEM4ejdnOCtITmQvTGs4d0xQQk43TmxiTFdTL2JicnJtT1UveEMrRmtP?=
 =?utf-8?B?Smx6ZnNZVWZyaTE1SFc5M2dabTljYlQ5SEdCYTZmQVVmYzFMOHRFK09vWXEz?=
 =?utf-8?B?cGVlWGh6VytNREhjaDBqS05tTzlTTU4rYktoZ0VGSHBsVFBaODQzSWNoVDVk?=
 =?utf-8?B?UlRKcTlYZUFYNnd0Uk9FcnpQeTNHZ3c4Z24wRW9ITkEwZ3cxUC9YS3pTNmU3?=
 =?utf-8?B?Kzc5VjhxQTB2L3E2STRncGI1clQ4N0FOcXpIUGs5TEdNS25xcVdnVm44cTkv?=
 =?utf-8?B?YVI1anBsVm1UdzRUYUdzVUY4NXh2b2NTaU5HRmN0KzVkRWFSNGxja0pEL1pV?=
 =?utf-8?B?T3M5Uk9qM1psTzFROTAxV05jWkVNWlJMeEVneDJTV2oyd1BXUzI1WSs0a0xE?=
 =?utf-8?B?QmZzTjU4QWxKejJLWGpRVmRGeGVxMGNLYnpyb3ZZS3d0VjJHZ2pVNldsU3B5?=
 =?utf-8?B?TU84dzNyTzVocThiYXBGOW1ZSENmcFNaWUJXSXJTYW1aNlRnNUxLUjdjcThn?=
 =?utf-8?B?bS9FaWd3c3JHbnVaUU5WVkRjNEpNMmRSVnNaQlZGVEo4c1l4NTlIRE9iWmg0?=
 =?utf-8?B?ay9JM1FrLzdiMk5NV1psRUJZUGhMeEdxVVZMN09TV2xxT05GaHBEMmV3VGw2?=
 =?utf-8?B?NGQ5YUo5K3pGQldhSjAxQll1M3FJd1JqMitkTXI1bnhnR3NWT1RVRGJldFFH?=
 =?utf-8?B?cEtPaHlLMTFqZ2pJMjlXVTl2Z3MxVjdGWXpoaHY5N1VIMldDZjNzamsvaEZS?=
 =?utf-8?B?Tnp2Qzg3RTdQUzZ5NU1xejlwZDA0RlhFRGJpVTVpOEFrSTJCZHFSbGxkN3kr?=
 =?utf-8?B?dTRZMFd2Y3E4Z0poQ3FxV1VyWjRsWi9ERDB5TFdqaTA5L3pEZTJHR0FEZUU4?=
 =?utf-8?Q?PXoOysAnkeYrmm/1k0o8SQkVE8Rwogtgo9iVs=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 08:24:06.5891 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f826bd0-0997-44b1-c7e9-08dcff058be1
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF0001E9C4.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2P195MB2532
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

Add documentation for the phyBOARD-Pollux i.MX 8M Plus on OP-TEE
integration.
Also add missing '-' to TF-A build instruction while at it.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 doc/board/phytec/phycore-imx8mp.rst | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/doc/board/phytec/phycore-imx8mp.rst b/doc/board/phytec/phycore-imx8mp.rst
index fda751aeffb..4bcfa9f39ca 100644
--- a/doc/board/phytec/phycore-imx8mp.rst
+++ b/doc/board/phytec/phycore-imx8mp.rst
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
    $ export IMX_BOOT_UART_BASE=0x30860000
+   $ # with optee
+   $ make PLAT=imx8mp SPD=opteed bl31
+   $ # without optee
    $ make PLAT=imx8mp bl31
 
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
+     PLATFORM=imx-mx8mpevk \
+     CFG_TZDRAM_START=0x56000000 \
+     CFG_DDR_SIZE=0x80000000 \
+     CFG_UART_BASE=UART1_BASE
+
 Get the ddr firmware
 --------------------
 
@@ -42,6 +65,7 @@ Copy binaries
 .. code-block:: bash
 
    $ cp <TF-A dir>/build/imx8mp/release/bl31.bin .
+   $ cp <OP-TEE dir>/out/arm/core/tee-raw.bin tee.bin
    $ cp firmware-imx-8.19/firmware/ddr/synopsys/lpddr4*.bin .
 
 Build U-Boot

-- 
2.43.0

