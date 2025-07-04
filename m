Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE64CC8303D
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 12:33:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7510082A8D;
	Fri,  4 Jul 2025 14:33:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="mamWglBm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5976F81D5D; Fri,  4 Jul 2025 08:10:35 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::629])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 327FE803DF
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 08:10:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/yb5G/RdWjxjh309fHcrJp4NGSJA/0wHcE56GGAkD5C8h8xgLkhjHOVU89pCLkIK2d/vNI9h1FmBwbhZuwwuPqxxQk5ysXTmq31KmTvHAyL6cWPOAfr96ZMUvkfV7VisrwvC3a0OKvKoudVCbBZFIuPrE7pBfSfUNlJMNaJvPIHuVKdzuDGJlL3W+MyRLAOVx3xnWbgox6YzTtOjLT8bAAhTcAprXDYMIZGJ65LNETOdtZFiBzwBeoHKMQImz3fnzRxqN+stgNtqKv+qpcKcYNWKQ+7eSMzSzXfyIckq+kosI42FH4aVca5BWreJMc7Fd/MaZIP8BuoBlObvXQadw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDOG+IBJ8ODGAJQ4IK5GsGe2dDKWSDIbndlSgXmOwuE=;
 b=UBYoOx1/wOHlSjjxsEYhDNv0OJF1N43H1VV5jGvNsuTCs3Y8td0I/wOR5Yhj5yVBR40XIRXXJu7lDDB/ZXY8ZP1WdkZTYuzncRjCZZh5kLBiS5EFpvec4+U0LhfhN9bx+0tz6qSm+n1H7u3LrBiILaEV0Oh9G+6S8hbCP5LseF0AxENaZI6Rj399Zkqk8x8LSPUvYmwl5elOsySUwe2teaM2xVEbrTvINu9RjOTGG1+IePOv7xqmPXX5Zyz0dzkOxE0ajx53hsEhyAIy7M36SW1Ome9VjyUohQlAJZt7mzPD8i1kLKGLxvJ+HxzBtgmKMpI9QlBrb0YljvAOSTHK6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDOG+IBJ8ODGAJQ4IK5GsGe2dDKWSDIbndlSgXmOwuE=;
 b=mamWglBm/1o0VGm6oG6D5Jbm3ChuUqTBMFZ6CWhlW5TlPQaJUfbucSi6hlh5oCLrN4NTMDOSsaaJqm1npDryh4RQWi/EKUaNs+p2AnBslFNcH4JKRrlBUcR5p0TkQtjeUToOdHvKxYauUn3sUvA9QfBGUN1S118J1hTQNkWGQ05EI/gUkZcqyl3Rch8+/1povhen/WoruAK/3f/A2qm80zpJ7WQxsw/yBhzsvpVDOVPhND10jioRiBWbPD7HXu+ja/lxmLrpRue21vFw5u959scbAClcXuD4z9xOul4MzZFR2U2npqtfQrzLJxHb/dg+70v1VW498QbBPS5Vo7XiKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by IA1PR03MB8045.namprd03.prod.outlook.com (2603:10b6:208:595::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Fri, 4 Jul
 2025 06:10:20 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%4]) with mapi id 15.20.8857.036; Fri, 4 Jul 2025
 06:10:20 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>
Subject: [PATCH v2] configs: socfpga: soc64: agilex5: Enable NAND boot with
 UBI / UBIFS
Date: Fri,  4 Jul 2025 14:09:56 +0800
Message-Id: <20250704060956.10955-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.19.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::12) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|IA1PR03MB8045:EE_
X-MS-Office365-Filtering-Correlation-Id: d6c28552-d815-4481-b4a4-08ddbac17416
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ISG8dfmUJrx23jPPBiQCl47VCOsk+g7Q7cFcx5Pa4dgbnRAqmCFtMtxvtNOz?=
 =?us-ascii?Q?Xux91EJv4FUWV4rwz5+cN1o+k7eHPbHdkz5rOuqpamy3DrOWfR9Ci/FXUjBb?=
 =?us-ascii?Q?jnS/MJB14Yq4YQktem1JtlIVGYnceI30rWT/dzqlPUoDBkVjj7n+g3qhLk+5?=
 =?us-ascii?Q?HV8FfsWBfip98Fc5rPAMFvv5v9qv0fYWEKf+7T+glGsjn3b0Ndognce0OeLO?=
 =?us-ascii?Q?xNKvSHLB7RBtyxCXkcAadAYB97WAvpASezIBZn/91UHnhJ+wsMV2EuppXt+S?=
 =?us-ascii?Q?99WTZw5il6DbZ4XD2YNMgMBintlnXbFFr9e0z3iGLM6WK/mVoy/g00T8ryYz?=
 =?us-ascii?Q?yQo3aGXG+hhp3LxsAKLE9lA7cH+9Yeij6vgh2j98qtioLIaSZbGyFUra3bs/?=
 =?us-ascii?Q?ERHuu7rgie2eHdt/il6XBHl1+zno889eatxkLrROrH8vw3fec9SSaVWpT+MP?=
 =?us-ascii?Q?hifEyEOXIpLBVy/uVxq6/Tga8cZ4yDHHoZrvC/IjEKROeebrCYqbDEADqH4C?=
 =?us-ascii?Q?Qq9n+96m596G2+0vb7O4dgCnqzVHbxBdgNnd9nEl4e9uORAU1wIatxErS95c?=
 =?us-ascii?Q?4iq38kh+TCaJpxERHthnd0KvVS69gfC9KWyJ1cdA/Nch/N2BxJQ+wOLm5s12?=
 =?us-ascii?Q?b7llhsjkGMlDqvcpEazuiST24dAuRCo6Vcc3xWkcB1t89qlOwkYs/ksuoaJx?=
 =?us-ascii?Q?IIfHrMCfYjLKa3ofjwpC/YbZoO8YyGMkbhhryHDepcPAzuMBxqnJlpbV74PU?=
 =?us-ascii?Q?A/ZB9o4CLSyyXF1G3UcCY9HHT6Fg5DxtFFnxINEEVZE6LnM9OwduqRUUr2ga?=
 =?us-ascii?Q?AXzH1nS8qIQ29bLMxBq5jGt+cA5iaBKFtMQgnTJXuGEBzbz/BUSACm5Tll20?=
 =?us-ascii?Q?H2Fdh7GwSMx0Pw29cFNi8Ft6BAA+7si6HlQPKOs2WKvyS8FSjJ3ec78Ea+0J?=
 =?us-ascii?Q?u5JR1dTO1sSDV0LZByPgPgk169FmOWBRMePK7soH4urX/gSkpH4PAt84/dXK?=
 =?us-ascii?Q?0RlCie8xY/slynlH7donoNzyndCiPfttqHitoFpiUfOOh4cvLqvk5BfS26HZ?=
 =?us-ascii?Q?H7PRgml/D/kaGRSbhn2wKXhNzC58/WUF66F/pDmDOddS//Ye/VbmZLtUIXLw?=
 =?us-ascii?Q?2suHHGsxwf30709BBjCfskH0uTf4QaUeUDbxy8a+48F320frdtfVrSjyrDV0?=
 =?us-ascii?Q?8eNFBWUwHodxgNUsoN/yLrAuJsLCJ27ns8zIThdyUSSDTb6AREAdnCffokWR?=
 =?us-ascii?Q?CfQ7v5EUQTOzhYNnmqA/T8P4cqYlUHGL29IzGKXw/IuY+g6AUeP96YO73qty?=
 =?us-ascii?Q?KaRU/vIV7n6HCe0Yuhnxrkyj2zbOIzx+1K61LDUTIA0M+PJzGYmERJjBKoUY?=
 =?us-ascii?Q?Rs9j55LXhE6zQC1WPTrbdh7YR1KqNw5BALybhN+GZnrVmr+JW7hV6xxeImPg?=
 =?us-ascii?Q?NV8sRd+8TEY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hlYwaioU62Ebl7N1t2K3pNfOWPegQKQogb9+LonUNwPAxbWTDt6oJTyd4MqO?=
 =?us-ascii?Q?y8dCJEBzBnQTCTYird24qjn6lYlQJgAM1LPmki8jdzxa8bIH4XdKiGbgXVSe?=
 =?us-ascii?Q?OzEfLkNVULflfadm7xklCSM2JZlkuM1eNx2RwU+iqvURTwbnfSktMm/cXdNi?=
 =?us-ascii?Q?aE8ge3XYXDP3Z5ARJ244JwZPzGl541gYdKb86HpxOo7K42xmyJZWt67t6e6u?=
 =?us-ascii?Q?zp7/laWGnkdXY8QOvWlfPbxrHmk3I/mOcl+OVpJA/A4sthr/XjMII6BRSUeq?=
 =?us-ascii?Q?rdEOEu4X0VjS0F03rzLZfJB0U2ZzYNq4v1snuDZZYXLdlLWdnNRd8AQkn6Ni?=
 =?us-ascii?Q?6vslXZPE/oVFiG8foSPML1ChoVoyL3+YmkcWnvdh/VVCfxBHs0D6YPhi50fZ?=
 =?us-ascii?Q?6L2+mTyuZn5UfguBtDR85QHv3tLjLV8cVZuFTWrD7TJ4pdxYZ7qYDOK5xZ58?=
 =?us-ascii?Q?BrPeF7R+1iSuNwqCdiipmkIMrlwS+AdNiLOlmzQ2v9owVQq0eZ89RHpK4uPg?=
 =?us-ascii?Q?bzjsBi7HDSSdAFpEXQajMN28UQ3E+Dm6r5xDVFmcZSEkB2kARb5YDRWZQFpr?=
 =?us-ascii?Q?p2bg0yx/XTkziUFnAZBo5pRR29iCg0/NVJNH82mFK0e0iPXzs1+yofy7odq8?=
 =?us-ascii?Q?vYnfh9XwClR3sp9JzR0wU3nOszwioDMn1FwyexD7B/ww/EOudhmK2ACYBtH6?=
 =?us-ascii?Q?UyrC/T9Bsn22/DYxfnB39Wp6hdQZo53VLuadgnlp7aC2Eee8SjuDL+u875AE?=
 =?us-ascii?Q?bBbWSFl/mMMJzy5vlVuT4fKbIm5NuRatbNaI+zlupOpvDtvPV3YjPNIayQRF?=
 =?us-ascii?Q?aETYp1DIGIAOZYmB0Vhv2gyRATQ6uUSPddb2OpwZru38FawM7mfFHhFlzEyj?=
 =?us-ascii?Q?CWRh0TL8PB4kFonBSgw590FlZULAql43lO0WEXPP6Sapx8ey2IKrWMLQiFLl?=
 =?us-ascii?Q?aE5nzl8KmCOkjIIcbi+krxT4zkaPM3CjAObUvEzaEK+iPMyprIuWkFdcYXO9?=
 =?us-ascii?Q?PNIVomaRBT0ARVNFcAEag2JyHCzt5INX+A0zUHM57aovnWwq98fCtMBLCjFd?=
 =?us-ascii?Q?Emt03Zmca7OLKs6SQcSa3bwyItOnLkraD+K/buIeM0RiMkTbk+JwiY4Y6FHB?=
 =?us-ascii?Q?S0l36FLvCxPdMM4ILjHJeQbI/diZbl6hKGBg+znq7x8l7TG4OoSn5pvLMleK?=
 =?us-ascii?Q?i/lr/FJJxTIsFxwSBwCtkDA5K3mPDzYog012TavYtjhp/79I3OU1V79f3pIm?=
 =?us-ascii?Q?GNpZh10eg11uUN/jMSzDIeXUv+44FLkcO4nf1MPpU1iZKevwlsfi0XKq8Yyk?=
 =?us-ascii?Q?moboQWg297hcqXzR6zUeNrWgamRsr3ZR8HaHWYm5B8n3VtVM2VY5iK9DsiFa?=
 =?us-ascii?Q?tKSWTcTHfFMSdZ55YsSepakX/XFdW04PYUt5YZVF21m9dvxbSbR3mVblbuqg?=
 =?us-ascii?Q?/I6Lfgt9D/DNBg0JjUJa5z+nWjWgD77j4tF9URch0OJXa0PQI5F8HNHaccY2?=
 =?us-ascii?Q?3DmwwAGcUHMDzZBLEMsmHthcmj/4OvztP4bgGwathebcfPGrm4d23R/5l9g7?=
 =?us-ascii?Q?TEdBDpnbdqHzd5nWMhYxYoJUu3ZuRAyZPUPwVgYfG9jOJCqZ8+zqVXlgGGww?=
 =?us-ascii?Q?IQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c28552-d815-4481-b4a4-08ddbac17416
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 06:10:19.9944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tzsuta19bqOpWrzDhGV1BbbsWuFitINbDijBGYmptTEe7eaUGSC7mSDMefDvrfDi/kicOpr+dPkfRXf7omtF6Jq0Ni8MjH7UhMoz43C97RA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR03MB8045
X-Mailman-Approved-At: Fri, 04 Jul 2025 14:33:47 +0200
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Add the required configuration in the U-Boot env to enable Linux NAND
boot with UBI / UBIFS.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>

---

v2->v1
- remove additional space
---
 include/configs/socfpga_soc64_common.h | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/configs/socfpga_soc64_common.h b/include/configs/socfpga_soc64_common.h
index 5ed17671f79..83b600c7fcc 100644
--- a/include/configs/socfpga_soc64_common.h
+++ b/include/configs/socfpga_soc64_common.h
@@ -73,9 +73,31 @@
 #define BOOTENV_DEV_NAME_QSPI(devtypeu, devtypel, instance) \
 	"qspi "
 
+#if IS_ENABLED(CONFIG_CMD_NAND)
+#define BOOT_TARGET_DEVICES_NAND(func)	func(NAND, nand, na)
+#else
+#define BOOT_TARGET_DEVICES_NAND(func)
+#endif
+
+#define BOOTENV_DEV_NAND(devtypeu, devtypel, instance) \
+	"bootcmd_nand=ubi detach && " \
+	"setenv mtdids 'nor0=nor0,nand0=nand.0' && " \
+	"setenv mtdparts 'mtdparts=nor0:66m(qspi_uboot),190m(qspi_root);" \
+	"nand.0:2m(u-boot),500m(root)' && " \
+	"env select UBI; saveenv && " \
+	"ubi part root && " \
+	"ubi readvol ${scriptaddr} script && " \
+	"echo NAND: Trying to boot script at ${scriptaddr} && " \
+	"source ${scriptaddr}; " \
+	"echo NAND: SCRIPT FAILED: continuing...; ubi detach;\0"
+
+#define BOOTENV_DEV_NAME_NAND(devtypeu, devtypel, instance) \
+	"nand "
+
 #define BOOT_TARGET_DEVICES(func) \
 	BOOT_TARGET_DEVICES_MMC(func) \
-	BOOT_TARGET_DEVICES_QSPI(func)
+	BOOT_TARGET_DEVICES_QSPI(func) \
+	BOOT_TARGET_DEVICES_NAND(func)
 
 #include <config_distro_bootcmd.h>
 
-- 
2.19.0

