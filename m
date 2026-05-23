Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4EB5CD5BAC
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 12:23:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1454D8488B;
	Sat, 23 May 2026 14:23:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ejvU3qFY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AC0384881; Sat, 23 May 2026 14:23:13 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 372A583E81
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 14:23:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MetDgf4ztjtArZQFdQoIKk7K20PE6LVfMamUivZ1l+swLuKPGJE7DofTn9mqP7VXDZi1GXrZwQUaRsDWlwgsMEWNvq6VaEJpM0Bxwj40Vc9pyHYQY1tY2HJTZFQYS1Tr0YsGASgAcBxB69yPrQA26g77/yUD1HeRuzFA/FvTt5OGCB/BN6Wwqzp8MpTb3PdkuYQWC5BESlw75zANZG6BLZsrPtWWdlV+U4dsxREjq75pXoXFS51keAipXmL7RQVfnYgm4CcCCK8LAhIiY/BB/kBpcRrScgBumul0PcbWBt+YUnEOXgQBT8Cyw/2zPvCwojBs1yaPXONfzEoEAEQBFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LngVAp7Dc10APaC4jUmEG/mrof6KAI8P263/6WCEtEA=;
 b=njoEAVYKFxtLxcDBEsgWGuKO3i9gkDu9AS/Al9bMyKxW3yFKMQwRMam5Rmv3ff32r/ruvf4QpmPO4qBYMt0xk8JGsrjDhbY9NZEPaQENFlnjTjQW+hDf6DTMblDeZBHxH053d0o66ilCkRwmGMNNHP2RLWiH8tPR8JRqg5+0cr0uI8OE+U19AUwsEn9Pv73O4ky4gKi0IBz6e1RDwhGPM5kLoF61E/rO8pyDPF/n+Nz2K/IIuvn+kqrPBAAQ+Z+eV+i2m5XRGXrf0puOwU8VLqwVVfPCSS2iYgpV8cjLOuDN/yPIXu3codCKHR89NqWDDAYJwSGePrnNOOrfN+96Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LngVAp7Dc10APaC4jUmEG/mrof6KAI8P263/6WCEtEA=;
 b=ejvU3qFYtycNKOk9Jh9CL2lZDLTfD5j+Ppzmk/pbyG5MPN8JQDWC82lUTT2wQ/YiF4ZGua/dw5DM01ztBC+i/W6JjB1fpfJ6kRX1oBiKh49lBg3AXbJXgULfk0DmgvQMz5QNsrQXO7YojqDjgMJxlrmx/5nIDVv0Es99nt5GKMxoHhr8GuRU1p9/Lem9dWEH0LXBfqHcV3Vu7cDwSqHz+K46W2y0goFZABqq4+elWil7Iu0jz8M8zvV8ExWgoTS6t7hiIPnZjMvKzPjfrCoqyxrBPYzt9aBOrYPfuzWB2FjmzrqnQlq0jKQyACjlNXbILdzleXeodX3VQjlsbClW/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by GV4PR04MB11976.eurprd04.prod.outlook.com (2603:10a6:150:2e9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Sat, 23 May
 2026 12:23:09 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 12:23:09 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 23 May 2026 21:39:46 +0800
Subject: [PATCH 03/13] imx9: scmi: Drop get_imx_type
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-imx-misc-v1-3-2898c9eca9f8@nxp.com>
References: <20260523-imx-misc-v1-0-2898c9eca9f8@nxp.com>
In-Reply-To: <20260523-imx-misc-v1-0-2898c9eca9f8@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MA5PR01CA0255.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:223::6) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|GV4PR04MB11976:EE_
X-MS-Office365-Filtering-Correlation-Id: 17d8d03c-3f80-4a2a-598d-08deb8c60cea
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|52116014|1800799024|18002099003|22082099003|56012099003|38350700014|11063799006;
X-Microsoft-Antispam-Message-Info: 2CLz3h+JjfN/GrXRK3xToO/Zkk5VuFSrWFbKr+Ijuf451zVaizbq2lLwclGo4dSEiNhoYEx6PmbshKseK8KTm0sO7jgazyYXf8D2l3br/2DIbYLFCjdAnl6+mRW1D07IViZFoUz7Iqe0npSwg483oUpTixCWtYwxGFBq0k/Bz1NFPPVr6iXV8FS4wSFCqbniQF12inBTluaXhlIe6zNUv0rLo7AO1ovY1Ai1NavlgCTJyoxl7JTO+AxshozG1xSfRmOH7bMF4/mEDBReQVVXAa3X5bq3pgHTHMWJiybxE55nVQs3aHbBp2XzzIhlhvAuKmRWxaX429jrs2nnzk3dqm8fbXfb6j2IQ/lEnQegKpZnQLh/nbdV7WRynZA/ogN1mCgm/9DwcD7GzCxmE6ssfC7I4ott3kS3l51PVtCyCHIMXOloNKL7vUTiG32ECnndY3/OpvC/FR6yDP419U9G0G2jqu62DFF9A2EAq5iez03G5vgYMwXhOUIfJS4i/AsUXNp1LeimWai5CtxbkhE80zXz4REaBf4OvdRxC3bODYPCa74dncz7VQYayhjSiGzyDzDHIb0BpKNhbjwRjcdXVB82FQQsA0hdYUrKg2wCVPEf8GgqBCVulh/61igeJ7J1qZRoMZ6f1HGU7kd/VvcgNiZ7GJSPbdBHSTLfl/ZNIihmEJFEc5hLm9UsQQzue6d2ZPibYxb5nUQp7O5+YPTXfplAUyIqyQm1zoLsizqdH/HVki1ksMrnS9KrjYVMeGpD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(52116014)(1800799024)(18002099003)(22082099003)(56012099003)(38350700014)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0pEQ3NQcmo5emdCSW11UFk0RzYyUFA4Y3ZETU1qSGVqTkRiRit3cmNWUk5p?=
 =?utf-8?B?aHlFaWRLVTEwekZvc2swdlEzVVJvN2hsQXFqdlBsY0wwUHJvdHV2OFgvY01N?=
 =?utf-8?B?elVnbGtReWIyeDYwUXNsdXJGT0VQQ2xOSks2Z3pGeXM3NHBuV2pqYTNVNGFJ?=
 =?utf-8?B?UmVmQWlvS09aeWJGeFJEMDVyODhVTHRZSmYrOElqU2N4MEF4WTFtblFjT1ZH?=
 =?utf-8?B?RG90QkdsY200eHhtWGE1VThyS0d6aWRpbXV2WG1ubjBsUEtjVXdscHRycktF?=
 =?utf-8?B?M2M2WnFrSEdMWWtYcFpHTGlwT0FOVGl0SGhJNmxrQVlsVjFzZEZlUTZRSy9M?=
 =?utf-8?B?cThuUHFiWkU0aUtjUys2amUzVkoxYVpHaWpwY3RlQnd3ZFNYeG1mdW04d1Vz?=
 =?utf-8?B?MGhFMnNaVktVZmVEbVYyY1BwRFEwK2lkU3d5dm1vUDVSM3J2Z0JZbVRUQVJo?=
 =?utf-8?B?MzBBajFyakR3K25teFoxQ3BoU2ljVTVYa0lkSnVhVC8rdzlqNGRTLzJlMEpH?=
 =?utf-8?B?R2tyaXB5MXY3UWljeE9zdTZ0bFRXaEhWbTdWRExFU01peEh0Q01SUlVwRCtQ?=
 =?utf-8?B?b0pKbHFib1Z6em1ob2Z6aGdRQ2xnVDFqWjk5cHk4bnNZaG1kcXljUkZ4dlpE?=
 =?utf-8?B?dzk5aEZtVWkwdElvV2dLY2c4L2VDYkRRQ3dwVm8vd3FKUGpNbk5IY0F4cU9C?=
 =?utf-8?B?WWQwQUtURkNzSW9NcDJtV3IvYjdWTVJsUHFMM2ViSTFHM1VVTmxoUDlMei9Z?=
 =?utf-8?B?dkUzNVpQcXdReWduSW9xaHNxaUUvL1BpZTl4cUN1WmZwS0prcTRvNjdqald5?=
 =?utf-8?B?U2VzOWhqVE84QXVEQkRnQ0NqM1pQSjRES3FMY21RM2NZTFErNVBtdjBUS0w1?=
 =?utf-8?B?TzZpVW44VzhzMVJUQi9qc3k0c2xsK2NSbzdERXdubWZpbE1DRWZxU0kyczJK?=
 =?utf-8?B?dExYL1NDb3NmQlJmVkFHK1lrSGVUbE1jLzhFekF6eE9hMklpUXpTNnVob3FY?=
 =?utf-8?B?VWFMb0JqbDN0bW5oOCtNVkF4bGVWeGxwdGRmUG9tR2I3a0JYV2ExQi84OGxY?=
 =?utf-8?B?V2RNdmtlQ3FuYnQ3aVVIaWxPRGQrejJRTU5kYU1hcS8vNDVXWUJxYythQXU1?=
 =?utf-8?B?OUFkbkFnVGFWbDlKRGdZUUg1OUJmRHRMclpFRG9COWNwUDl3S3crbk9SUDZy?=
 =?utf-8?B?RytrZUY0NWJma1doWFM0ejFMWGpGOWsydExJR3RGaWpNNm03eUc2L1FiYjhp?=
 =?utf-8?B?Y01RdGI1Qk9zd2dkOVRvbmlveGtCeS9BTnIxdWtKYW44UkVUYlUrZFpVbld0?=
 =?utf-8?B?K3Y3MUh6MDFJZkFmcHRLTEg1RG5ySUFlOTVISnp2eGp0cXpCdDRvWGlENEpF?=
 =?utf-8?B?NkdNK2l5Z3lhTUU2NzQ0bTN5aXcxa2JqaTkvTy96L1E0bktHSUJyUmtMdTc0?=
 =?utf-8?B?QXdhaWlsSEJBN1JpLzlYalJHK2dNeXNLTTE5RllIUHhEekxYQTB4U0o4OVpn?=
 =?utf-8?B?YTJLVUZnVjZkZHdhZjFHK1NMNjd5NVJoYzIra29Od3luOW40WXd1anN4RGJi?=
 =?utf-8?B?K1h6MHVtVlZsQ2FXa3ZNRWtpSGsyQU0rbStWTlhSODMvOVlwc1VqZHZrMGpt?=
 =?utf-8?B?b0xIUU9OTVpTSFhhUzB1bVJIZTFFNlQ5UHp5OGtLYm9nRHpzYXVwLzhDUWRE?=
 =?utf-8?B?c0wxaVBIdzRUVGYrY2MyQmRCWGZaWldHMEgwTWR0Sml1bmF0T2dXNW9LbjUr?=
 =?utf-8?B?R3JXUWRZZFU4ME45T3h3RlNndGhzOVBNZ2hFY0s0dCtXdFBiWlJWMkhsQjU1?=
 =?utf-8?B?N3hrSHRoaVhrZkpZUWdybUw2czZLYlRURUNMRGZRMjZFdi9jOHl5ZjZ5LzNV?=
 =?utf-8?B?cVRZZFoxZ2d1WWZTeUN3MnBVbXlWak1YTVkrRmRKYjJBTGw1QmJndTMxWjdn?=
 =?utf-8?B?aldYOHJwWFQ4TG5mREJjTmZpNTB3djk5ejFqeDVaeEV4eVZLS3V1NDFGRjV4?=
 =?utf-8?B?L0RGV3A5OHVqbU8xeG1tSXlnS2NubWIyYnA0clV2cS8wZWNlN2VHUEs4dUVN?=
 =?utf-8?B?SjEzR1p2WHZJN05aQ0UzNUJOTWhQNGQ5Y2EzSlVYQkhYemZTei9FR1luZWpv?=
 =?utf-8?B?VXRaWUJLZjVSU1BTejVCbjJpVVNjbXpBbC9GNkloV3pIR2VGeWxtWU5Oa2E1?=
 =?utf-8?B?Y1J1eWtGMkpWdFlPaTBXeVpjNHpJd2YyVnlhOFErMVJySjZ6aVk5Z1JucWFY?=
 =?utf-8?B?endQd3V1ajFWRzJUbkExbUY1UWU0OFJLelBiY1lwMkZIaEliUFpIQ1h2UkpS?=
 =?utf-8?B?UFIvZ0lPU3Q4R1cxUSt6c09iVGluU3pVc1pSOHZlbXpwcnRFSlp0UT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d8d03c-3f80-4a2a-598d-08deb8c60cea
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 12:23:09.3473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q3FQfoUQTA0xvC5pHGxHPqvSlbB3o7gHzvCWZovVNSukII59RSXLwNCS4f+T6CnjtWMYSaIElrHGLa/yIFjjbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11976
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

From: Peng Fan <peng.fan@nxp.com>

There is no user of get_imx_type() for i.MX9 SCMI platform, and cpu
information is handled by cpu driver, so drop get_imx_type().

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/scmi/common.h |  4 ----
 arch/arm/mach-imx/imx9/scmi/soc.c    | 10 ----------
 2 files changed, 14 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/scmi/common.h b/arch/arm/mach-imx/imx9/scmi/common.h
index c3610127dce..0cf7f3e4439 100644
--- a/arch/arm/mach-imx/imx9/scmi/common.h
+++ b/arch/arm/mach-imx/imx9/scmi/common.h
@@ -32,10 +32,6 @@
 #define IMX952_CLK_24M IMX952_CLK_OSC24M
 #endif
 
-#define IMX_PLAT_STR__(plat) # plat
-#define IMX_PLAT_STR_(IMX_PLAT) IMX_PLAT_STR__(IMX_PLAT)
-#define IMX_PLAT_STR IMX_PLAT_STR_(IMX_PLAT)
-
 #define SCMI_CLK__(plat, clk) IMX ## plat ## _CLK_ ## clk
 #define SCMI_CLK_(plat, clk) SCMI_CLK__(plat, clk)
 #define SCMI_CLK(clk) SCMI_CLK_(IMX_PLAT, clk)
diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index 7c107c88bb4..59707bbccc1 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -715,16 +715,6 @@ int get_reset_reason(bool sys, bool lm)
 	return 0;
 }
 
-const char *get_imx_type(u32 imxtype)
-{
-	switch (imxtype) {
-	case SCMI_CPU:
-		return IMX_PLAT_STR;
-	default:
-		return "??";
-	}
-}
-
 void build_info(void)
 {
 	u32 fw_version, sha1, res = 0, status;

-- 
2.51.0

