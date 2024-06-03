Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F429C25B76
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 13:35:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B21888830C;
	Mon,  3 Jun 2024 15:35:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="sB9ZOxdx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 507EF882AC; Mon,  3 Jun 2024 15:35:20 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20722.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::722])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3444882F9
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 15:35:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsUEH01NmGpQvPaVDXo9XLPDzppZruxKu60HARmDs8av8B22+J75T70x2UYCB2bACP2HvytFjVzCHgRKG1QPfhtTJrtY6aYG19kneex1oaIg5jlbLxmT1c0U8hk/phk3uSd6OooHcpfXY+KDgebPHnjRTl38Q2ecEe+FK09P35b4c0qO1TxPwi8BqSrCESzaZw/jxxa4fnqIwmDnTUNudlxUssUhRztqSoYY/O3q4n+yFHTitnPrmVzxyjP6tKp2vozAKfUBX/0NPKcgenKrei/JgkXJWUME5yz0YyOcUD5gRjh0gsmuVdGAM9drQCNWZGiLgnpNjykbmXGNKScmSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bm9tptLHXD3APTkD1WBYLPsTiWvaGprzcyIBVnSbsTQ=;
 b=IXxNu4O2bt2cosZW7LJCFkuWRQ/WRtDZ7MLnCNZlAJROj9cJo0879J1qsdCUZeTzGVXpH9TIbEATNHMIaV+NgUGebkQQc1qF7EorEMsAdseaGpe6OupS2QPKnOODfb49m9OXrhMckAw+QVk3ej9H/jm/w1ldLsxgMKz0oTJQQHnt+WRvNP9/wwkKcviRrrLQ9wlLx6FDc8xCxim+AFxhKj4z4wiZ3qpmpBL4CUhmWAKIBHw8cdrlAr7QROG5dTrRE15FBtX/YFG9+dlG/LVPaaCstK217BGL58x1Ouo/uiXmIj/YhpumL0wTCo0KGBjsrnhp01Wcc12h9Q7rEhUlJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bm9tptLHXD3APTkD1WBYLPsTiWvaGprzcyIBVnSbsTQ=;
 b=sB9ZOxdxDcgm/RcQ/29yF4iGIQsHtqKEMIjm0+piRn9erryWig6NU4ZK/f/T+EOtxSjc4HUcIA8ozidtYokI2lkILqkcotK6mlCbiTilhCc+Yc/ieuZff568d8Aug5II7EPj5UQwyGTb9xiLtbCxd/SJM5Fx7o7AYcTK47gLuuQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by GV2PR08MB8678.eurprd08.prod.outlook.com (2603:10a6:150:b6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Mon, 3 Jun
 2024 13:34:56 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6%7]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 13:34:56 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH 1/2] arm64: zynqmp: Add 'SPL_ZYNQMP_FIRMWARE' to Kconfig
Date: Mon,  3 Jun 2024 15:34:46 +0200
Message-Id: <20240603133447.173402-2-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240603133447.173402-1-lukas.funke-oss@weidmueller.com>
References: <20240603133447.173402-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0196.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::18) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|GV2PR08MB8678:EE_
X-MS-Office365-Filtering-Correlation-Id: 469a052b-122e-4e49-8d9b-08dc83d1f53a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|7416005|366007|376005|52116005|1800799015|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SgnXolTqqKucHI8eafTa61r6FOBT8SpvH1c5C7/Z9H8+4RhZb0R1AcOooKcG?=
 =?us-ascii?Q?Vmbn81BVrG3JlycIlqXR8KVDG2GBWMjVJV0RQ/X9puD1TyDLaFHajx2yC6rT?=
 =?us-ascii?Q?8Ri7nomAXHHLUkaGyPPhSWMgFBY8wZCnE2wLcD+oody1LEAYRqw7GUS60nGJ?=
 =?us-ascii?Q?OrxDiTtFtHi7y4hYq7SitC0D/FveoKPs8i8k+LpAaqt3ACkNIhOA7MY0TyjS?=
 =?us-ascii?Q?hD6O+I3Ys6I6njnV+orllXY1jEsiI0bCjrYfnFWA0jChsIc+DwbCTlSemLNP?=
 =?us-ascii?Q?AvqGUU7HMoohOkapUS/lg9/dhJX8Q4+TSEsvmtglhcm+LgRq/sxezRQuE34I?=
 =?us-ascii?Q?PvWCFDQnen0Du1nLGbe5MoKYoYTWhw5+/UUl4pEpinNPy29jLL5kZuGC3m+t?=
 =?us-ascii?Q?c84CKAvJcAPpNE3GT9tpXcIRm8y05rOyWYeAAQTcOmyHqx8/rv7eenmtgcwv?=
 =?us-ascii?Q?1uqQYFEWsD7tZfYG6QO4eFx+Fc6l/RIcN/tDStpKOoiLpciTjLdb1IbwH07l?=
 =?us-ascii?Q?G+FkN49hMaUgV2U4bP/zTSL04yHP9jLZX5sAh+fxeyvcf/l3GIplWKk5t+fw?=
 =?us-ascii?Q?sVk51gCKeUzsQFdrHR9Lz5SzgwlOAPiy/LcRh3TTiCCJap2vceFYarbNS1ql?=
 =?us-ascii?Q?EsUKrLiErPCT4f/4Nvdwi/9GDpTLbJ7owOtJZteUFvPju3FafmDOIEvsQUXB?=
 =?us-ascii?Q?ZqQpv7DtZ8EdhnZt9mDJQC/i3ZL6mwOGQNMFpMd5gT4qHRHWFFk65g26x/yL?=
 =?us-ascii?Q?JMoF5Sp+3uvkzbyYlQK/rn6lyZ66GiVVGrwh7SQ8M9MzVkh2XFqcFjK3ZXXH?=
 =?us-ascii?Q?c0bA4aLZKyRGW9iZoyw0mt0D5FDrnSTelzMFLStHRNXwp9g3cPKKuPcybzlI?=
 =?us-ascii?Q?N/FIAahhwC60hhK79wVqYgmSKEnd6z/JvMSFXq7PC5mBkgbUAnGSbZksoL8u?=
 =?us-ascii?Q?A2zWRiDVSARnH8mh0vmuhA2zdLILcVbx4WbNvIuyDK7KjKVHmpoPlV08MF3S?=
 =?us-ascii?Q?aBzyrgRvr8Z581X7nnCzAx3CMQ0OmCGKPORzsbfPaWF2C1ObvBCFFLhkn1Uu?=
 =?us-ascii?Q?Pxy1MsGRxah3wLi//CfZrLUKaaYjvuYc0XiD5+tFcAGil4YujHRmzNDEY6eZ?=
 =?us-ascii?Q?hItKEtirk1A9VcscJtFc97cYRaEcupfHY5Lp6b9ReBrF9phIEWuf4dNiLBWc?=
 =?us-ascii?Q?cd48z7GY4uIlXefyAcOsFXYBO8tfOBSIGE78MbjEXJJeEf9bWI/Dm2hffV50?=
 =?us-ascii?Q?b7AtMjyjnF2bbOJmp+dkHk1Ijr1nXnHpJUpklQX05SrIJ1ZnDUx2nbomvEQy?=
 =?us-ascii?Q?qdPH3MCvFU8l52APE+1XSWVd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(366007)(376005)(52116005)(1800799015)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g1M7y+hDqTPak3pJtyPQf8p00QApTYGqLXqHrXw8+wZHjbn059uVuQRO6uIV?=
 =?us-ascii?Q?zmPGf22izO1jxVnsCvU8BpZDVHZIDSr6zewLJbbECLhPEMaRDOMQRVHDNlnS?=
 =?us-ascii?Q?C9VCLfjU9AWPZ7gxaEsMLVYqbAQ0uhX5XSsEGZ9b0H1Go9C/KfmaWGksXKRy?=
 =?us-ascii?Q?9JVmmlj26ykD7LxScKmRdOgTcEOda4nD7ZOSE68hUYNDEhfg2iacaVX1PFRU?=
 =?us-ascii?Q?kLf2T8qft4D8GexVxrZCDXTAXxcw4a1QfYq38qrkQ63FsTdhY4ByKxTcqRai?=
 =?us-ascii?Q?mEOggJGsQAgiqosWuprM45+lub7Y4A1gys/NfwJjmgs3g1Fv3A65u4zrdT5d?=
 =?us-ascii?Q?37A+sxBnXJ3aN8MDGWFHdUevWr813fMjmpKrcUw4YMh5J/mYak/aQlAigbZ6?=
 =?us-ascii?Q?ArWzADB/o0eOW8LmLTRiJsBz6uFtIpKQvvhtDL2lf3FH3FYiWBsuhgx28vet?=
 =?us-ascii?Q?QqWjTnIiu0lnqA1JvSDl68fAV71FaYdqjVdS4fNi/37gwzbTzHI/EUW1hnvy?=
 =?us-ascii?Q?eJWVHMwL8gGF3XKb+LhI9y+eR7N3nKAl4H8JapCixjNiUqhN2TbeW4Mqq/mq?=
 =?us-ascii?Q?U1cdxbPfyd+ezPJ6MspRWXOc43x5N4SX8jGzlnaYUf5TgfaIfAzVgB8DnY04?=
 =?us-ascii?Q?tO0F5WyvTknYrK4RsTj8asTqrGQk3wmjqK8mgKF6mm/jk2o68UGlGhy0Nv7X?=
 =?us-ascii?Q?2/R6ZZIVj/o0KVtlJaiUJL/zQVo8ESooa5wuA/DFOaDoLTJNOiYmHlOvWMwE?=
 =?us-ascii?Q?TbnT7UlxYIf0FTiE81nKwLZV0lw9BdxBQTiJVLqAJkTpU22O9A1uN4CaBRPp?=
 =?us-ascii?Q?Dt8Xmx/osdcxTVEKi2fVZe/OY4e+Buyt02aNmFSU7yw7RGLbMtM/jgZHyJ1i?=
 =?us-ascii?Q?kc3YFbI+fNZqyiKudDwvOlySrSoIkDXwmMgwnQ3d6ZtwZ+aEyiSi5bwedm4G?=
 =?us-ascii?Q?a1kd/UCxwpgoHOQRZba2AS0EVPVE5Qgrz397ezHV3oVCTyRpV3TJB7Zo63pJ?=
 =?us-ascii?Q?0Zm9IUNX3nGwmIU6A7nM5bK0n1Cr6mEidbWrcjqpp6MIdIk1gFEw2kNEar5n?=
 =?us-ascii?Q?SPtNhD6MPxFZUnrC/xu/pGuS5vIy+FoKwy4ZdE41eE3J9sesDJnAmZRFrDxI?=
 =?us-ascii?Q?jM7jqoFXTKL96fMpo2U9TVOBiyVmCFRpBnNZlTjN7HYkApuUEh7wS2DJFkwm?=
 =?us-ascii?Q?2XLqvT1hj/OLptsxoEzAgXhkHh78yHzHdb9ygi8pAZU3zUTNwuYTQ9zgcShm?=
 =?us-ascii?Q?AQ9eA5jf06FM79Oud+mS0ipwVVAy+eWMbX2gnrrs5K+8BTng7O++EeSF5c8d?=
 =?us-ascii?Q?s2eqN520M0hVDILbvfNSq4BO6OvV7Cuu+3qWzua3LHqoaqRFcAS19GUbZsDu?=
 =?us-ascii?Q?wAyCksM/x9sBjpA8khcbsuMlmzUdQORdXuIY7T/yT0RrW0nmab84cg5dEPOQ?=
 =?us-ascii?Q?b+w8dDd4d89f3WF+ZMWtvYUHkoU+I99xBEP9auTBvzXvT7z+lRBzA0ysCM5c?=
 =?us-ascii?Q?8YwEnRIDAc4wo9phRd2uFA2uahZ15x3CXxMlWZvmwKRwd3mjzkdimjXAHWgI?=
 =?us-ascii?Q?Jr/9IsIe8+6MjV4wIT2RVDLwzfsgR8ImxK6wrNBD8k6jcbPLYW5/mUMfoNNO?=
 =?us-ascii?Q?LQ=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 469a052b-122e-4e49-8d9b-08dc83d1f53a
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 13:34:56.6376 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OiPN9Jn1PUV3R+NHk9/SLiIeS3wPjrWbGm+mGfFDE7OCrrZ7r3hbGKjrnLuzsVA+9Tx3SCMiiVa4PR6IYBA8Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8678
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

From: Lukas Funke <lukas.funke@weidmueller.com>

In order to make CONFIG_IS_ENABLED() work with 'ZYNQMP_FIRMWARE'
introduce an additional Kconfig 'SPL_ZYNQMP_FIRMWARE' which is selected
if and only if ZYNQMP_FIRMWARE is enabled. Driver are adapted such
that they build with and without the config being set.

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

 arch/arm/mach-zynqmp/Kconfig | 2 +-
 arch/arm/mach-zynqmp/aes.c   | 2 ++
 arch/arm/mach-zynqmp/cpu.c   | 4 ++--
 board/xilinx/zynqmp/zynqmp.c | 4 ++--
 drivers/firmware/Kconfig     | 5 +++++
 drivers/mmc/zynq_sdhci.c     | 4 ++--
 drivers/pinctrl/Kconfig      | 2 +-
 7 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-zynqmp/Kconfig b/arch/arm/mach-zynqmp/Kconfig
index 0d2238ace1e..304dce45439 100644
--- a/arch/arm/mach-zynqmp/Kconfig
+++ b/arch/arm/mach-zynqmp/Kconfig
@@ -36,7 +36,7 @@ config PMUFW_INIT_FILE
 
 config ZYNQMP_SPL_PM_CFG_OBJ_FILE
 	string "PMU firmware configuration object to load at runtime by SPL"
-	depends on SPL
+	depends on SPL && ZYNQMP_FIRMWARE
 	help
 	  Path to a binary PMU firmware configuration object to be linked
 	  into U-Boot SPL and loaded at runtime into the PMU firmware.
diff --git a/arch/arm/mach-zynqmp/aes.c b/arch/arm/mach-zynqmp/aes.c
index 8a2b7fdcbe9..100dde2f372 100644
--- a/arch/arm/mach-zynqmp/aes.c
+++ b/arch/arm/mach-zynqmp/aes.c
@@ -17,6 +17,7 @@
 
 int zynqmp_aes_operation(struct zynqmp_aes *aes)
 {
+#if CONFIG_IS_ENABLED(ZYNQMP_FIRMWARE)
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 	int ret;
 
@@ -54,6 +55,7 @@ int zynqmp_aes_operation(struct zynqmp_aes *aes)
 		       ret, ret_payload[1]);
 		return -EIO;
 	}
+#endif
 
 	return 0;
 }
diff --git a/arch/arm/mach-zynqmp/cpu.c b/arch/arm/mach-zynqmp/cpu.c
index 6ae27894ecd..3515be257a5 100644
--- a/arch/arm/mach-zynqmp/cpu.c
+++ b/arch/arm/mach-zynqmp/cpu.c
@@ -188,7 +188,7 @@ int zynqmp_mmio_write(const u32 address,
 {
 	if (IS_ENABLED(CONFIG_SPL_BUILD) || current_el() == 3)
 		return zynqmp_mmio_rawwrite(address, mask, value);
-#if defined(CONFIG_ZYNQMP_FIRMWARE)
+#if CONFIG_IS_ENABLED(ZYNQMP_FIRMWARE)
 	else
 		return xilinx_pm_request(PM_MMIO_WRITE, address, mask,
 					 value, 0, NULL);
@@ -207,7 +207,7 @@ int zynqmp_mmio_read(const u32 address, u32 *value)
 	if (IS_ENABLED(CONFIG_SPL_BUILD) || current_el() == 3) {
 		ret = zynqmp_mmio_rawread(address, value);
 	}
-#if defined(CONFIG_ZYNQMP_FIRMWARE)
+#if CONFIG_IS_ENABLED(ZYNQMP_FIRMWARE)
 	else {
 		u32 ret_payload[PAYLOAD_ARG_CNT];
 
diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
index f370fb7347a..95a134b972d 100644
--- a/board/xilinx/zynqmp/zynqmp.c
+++ b/board/xilinx/zynqmp/zynqmp.c
@@ -147,14 +147,14 @@ int board_init(void)
 	int ret;
 #endif
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_SPL_BUILD) && CONFIG_IS_ENABLED(ZYNQMP_FIRMWARE)
 	/* Check *at build time* if the filename is an non-empty string */
 	if (sizeof(CONFIG_ZYNQMP_SPL_PM_CFG_OBJ_FILE) > 1)
 		zynqmp_pmufw_load_config_object(zynqmp_pm_cfg_obj,
 						zynqmp_pm_cfg_obj_size);
 #endif
 
-#if defined(CONFIG_ZYNQMP_FIRMWARE)
+#if CONFIG_IS_ENABLED(ZYNQMP_FIRMWARE)
 	struct udevice *dev;
 
 	uclass_get_device_by_name(UCLASS_FIRMWARE, "power-management", &dev);
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 8789b1ea141..ae785d55d54 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -30,6 +30,7 @@ config TI_SCI_PROTOCOL
 config ZYNQMP_FIRMWARE
 	bool "ZynqMP Firmware interface"
 	select FIRMWARE
+	select SPL_ZYNQMP_FIRMWARE if SPL
 	help
 	  Firmware interface driver is used by different
 	  drivers to communicate with the firmware for
@@ -37,6 +38,10 @@ config ZYNQMP_FIRMWARE
 	  Say yes to enable ZynqMP firmware interface driver.
 	  If in doubt, say N.
 
+config SPL_ZYNQMP_FIRMWARE
+	bool "Enable ZynqMP Firmware interface in SPL"
+	depends on FIRMWARE && SPL
+
 config ARM_SMCCC_FEATURES
 	bool "Arm SMCCC features discovery"
 	depends on ARM_PSCI_FW
diff --git a/drivers/mmc/zynq_sdhci.c b/drivers/mmc/zynq_sdhci.c
index 935540d1719..3e4cae60c17 100644
--- a/drivers/mmc/zynq_sdhci.c
+++ b/drivers/mmc/zynq_sdhci.c
@@ -992,7 +992,7 @@ static const struct sdhci_ops arasan_ops = {
 };
 #endif
 
-#if defined(CONFIG_ARCH_ZYNQMP) && defined(CONFIG_ZYNQMP_FIRMWARE)
+#if defined(CONFIG_ARCH_ZYNQMP) && CONFIG_IS_ENABLED(ZYNQMP_FIRMWARE)
 static int sdhci_zynqmp_set_dynamic_config(struct arasan_sdhci_priv *priv,
 					   struct udevice *dev)
 {
@@ -1094,7 +1094,7 @@ static int arasan_sdhci_probe(struct udevice *dev)
 
 	host = priv->host;
 
-#if defined(CONFIG_ARCH_ZYNQMP) && defined(CONFIG_ZYNQMP_FIRMWARE)
+#if defined(CONFIG_ARCH_ZYNQMP) && CONFIG_IS_ENABLED(ZYNQMP_FIRMWARE)
 	if (device_is_compatible(dev, "xlnx,zynqmp-8.9a")) {
 		ret = zynqmp_pm_is_function_supported(PM_IOCTL,
 						      IOCTL_SET_SD_CONFIG);
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index a1d53cfbdbe..d2ccfb724af 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -335,7 +335,7 @@ config PINCTRL_K210
 
 config PINCTRL_ZYNQMP
 	bool "Xilinx ZynqMP pin control driver"
-	depends on DM && PINCTRL_GENERIC && ARCH_ZYNQMP
+	depends on DM && PINCTRL_GENERIC && ARCH_ZYNQMP && ZYNQMP_FIRMWARE
 	default y
 	help
 	  Support pin multiplexing control on Xilinx ZynqMP. The driver uses
-- 
2.30.2

