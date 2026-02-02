Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F39FD172B3
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 01:43:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1120583CAA;
	Mon,  2 Feb 2026 02:43:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QpCUj47g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D829D83B5E; Mon,  2 Feb 2026 02:43:05 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0BB583B5E
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 02:43:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EUij+I077XgZbuMIUIE+QcBtoNvgjLRw39hqvVXHNNghNY9TBiyRQnF0nj8mYNsJtldfHDniSdv+lBHSA+C2cl3jCzf94Jw2/Mf9x1S1CgnseGbr6/+5whosG5jcZr0Dy8utcLzQyUkNr6iIIqOnbudTE8EIaH6sd3vRldqRrCIPQHaHX3pBN9/kkeTdsnHIrwQogrzRRwas99OGXq2vbe9JpQcA0Zct9/AZ0o0S0IBhxe9MfQzETHawzWmnFdsQAraZu5aIc2mc77hr+ujZGvjpuO8h/KcM+c8dVt26sfo39ypm4F69X8u45Zx3rj5c5zRMj3M5poSdUhH/ti7LnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zb+7T7oxOvHkQrNEfv+d3mcSOFlONpro8UzanXX6Dwg=;
 b=iQjpgDPGYEFhwz6efEAlER8L8WObALKuCpM1QSkcQ8CyZaD6HV6H6MbUNXCqkHAefIn1JARDL4GRepWkCf+qBw9KKLPP8K6q1NPM9Llsdibi+63wuwKAB7+q867zHYqfwBfuq737jGLVDAJOW8EmLHDkAKzqG5OIhsaMGjj8Xaw2o8LcU39ewIkf0UALqJ5RK4W5xzwlZrIfO3fL2zvQvDf7IUZSVjaJiAcNCcZWataNiz+UttLq3t5cGLJrDe2LOowWVF8P2iTyQEg/3jTR+REKlqMxMmr05ssP7SfqRGY8wPzAI5q+iyYRxjVs/FrHoLvhSTLxY8vNnhFqLbPR6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zb+7T7oxOvHkQrNEfv+d3mcSOFlONpro8UzanXX6Dwg=;
 b=QpCUj47gfK5H6cTWAo2x6h85c7mhJtuwxJvzNvo70+2TMVWmiMONqBvXhUq11oP17mKIfW0A0NbG4B2CQPnaWMtpAb4CNv4ZlL+WY8fm+9bjkTIC5VUvKIPqTaw8qXWTKgZm05EuEHMSA04SEmj7Xql7xhVlgZcSlEzRiaD+48qOqFvnrObiu45uBDWArbf4iQQ2cizZvfthGmXOMsWp1/Vs6bG1wqxNZmaDSWuIp+rVXewHqi/eBcPfoMtlDpd9jMDyTHkHUy5B+VeOWenM4hPqULEmF8JE1xkWLzPaOfWNzczP8RQIDGPfizbCZyLsYY3xE/jKvY85AeANesLYJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB11483.eurprd04.prod.outlook.com (2603:10a6:800:2cb::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 01:43:01 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Mon, 2 Feb 2026
 01:43:01 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 02 Feb 2026 10:57:45 +0800
Subject: [PATCH v2 2/4] remoteproc: imx: Add i.MX95 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260202-imx95-rproc-v2-2-b85fc7db23fc@nxp.com>
References: <20260202-imx95-rproc-v2-0-b85fc7db23fc@nxp.com>
In-Reply-To: <20260202-imx95-rproc-v2-0-b85fc7db23fc@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SGBP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::19)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB11483:EE_
X-MS-Office365-Filtering-Correlation-Id: 7376c6d6-0282-4218-1e64-08de61fc66a5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHJJaGFZTUpxSG5ha2Y4MlFiNGdyb1BUcnJXT3cxYmR6M1pVUmRwZXBvMGs2?=
 =?utf-8?B?UzhsK3Rhb0JTRlRkTWZHazdFVEVFUzd3SXFudS9sRWI3RGNHTGNkd2hHeFZz?=
 =?utf-8?B?WmVTckxkVUU4VlVPd0xZOUVkS1NIeWxldmNETWs4bThUa3lnVVVxU1BsKzVL?=
 =?utf-8?B?UmFOM2tFNkFoRnAvTzlnWWI4cVIxT1dzSjdkYjZZRVB1Ykg4azBFSnZwWUd5?=
 =?utf-8?B?SzlxUkdRRUpNOGhZZXh3UXBEa2FHRzFRYTU3U202eXBzYnpDLzFaVEV2QUtH?=
 =?utf-8?B?OS9rajBCeldTcXRMZC80d3dDYkFTREFiWWZzK3NxdmNlbGt1SlN4RXo2ZDBu?=
 =?utf-8?B?Wm1jNEMrNWhzTElaVXF4SzZWZ0l2NS9SVGhRaTJCdmJyRkxPc1BHWXpMY29z?=
 =?utf-8?B?ZFloZXFwS2hoV3haTHFrOHJBUmhTNE5GTTFES3JiSkZ5YlB6Y1NXV3JFNEI5?=
 =?utf-8?B?dFVyYXlESDZVTjM1MDhwTzhmeGJnTzVCT1FZdmJoUE0vVGJjMnJvUUJWb0hk?=
 =?utf-8?B?clF4OEhndEI3Ui82ZDliNmtCTWROaEppNFdJcGNTQXVCWkJCRGRzY0RjaGxU?=
 =?utf-8?B?MzNaRFZJYmhVVmpmKzNYWFZKRjlNZ2lIZEtXcFN4QTlSblptMmNLejFvUEFi?=
 =?utf-8?B?TS9qTHEzYk15QzlvU2lES1pXdVdzVEFqcnk3UlhkVC9IcURSaU5lVnozY3ZH?=
 =?utf-8?B?UnlxUHpOcFJVb2twUCtZYXQwNFUzdTJjcC90ZkNZYVNkcDBocnFFZW5mczdY?=
 =?utf-8?B?bXdveDJmUjJWMTNQZzZEdmpoSHdRdmphNlQ0cFRGdDdHMzU4WFVmbFpYNUFJ?=
 =?utf-8?B?UUs0WHMyTjNPTTR1aEgxUHgwRTlMK0gvVnd5cXI1d0JVak9jNDl4YVJDaGZG?=
 =?utf-8?B?K2xHeGNkM3BnN2lvaEg4VU50YmpwUFcwZUovMlB4UWhETGxHanNXQlNjMytK?=
 =?utf-8?B?Wmt0OG5GRWVuWXkwY2FqVXQyQkgyYW9iQzNEbDJTcmFBbEQzUVlUV1c1QzlK?=
 =?utf-8?B?bnE5Zi9ibGhuWFVFQUkzMVczbjNWd0xyYXhPTUdBQzEwekpoQ3c3RTVGVEtG?=
 =?utf-8?B?Z2F2cllFNituQmVYV1FOd2Yrdm9sUm5NdEhFQ29VS3lCaVBGYmFHdzFQUm5J?=
 =?utf-8?B?NVdKQi84ZFlWZEdwNFBDTWZPWnFyVXR0eFM2VjhvVDR1ZHluOUZER3NYM1J4?=
 =?utf-8?B?OEpOV2l0OS9WQVNFdlBMWUpKYWMzcGUxL2I1dlJEN2FBT1BwbHpGUWhheXpa?=
 =?utf-8?B?M25Ldjh1YjNzZXF6MkxDT0JncTZ4Zkp3cVFNYXNLVU1XeVpvZ1kxS1hWWHdJ?=
 =?utf-8?B?MG04a0ZmdXF5Q2xBNzVOa1JxdTFtMkZHVXpDbnA1M3Q5ckcvRHFIVmErTDAr?=
 =?utf-8?B?TW1rWmxScU9kdDNQS01rcnVVR3NXYWZmdEg0Y1o3N2NQSkUxaDVQbVBwcVBv?=
 =?utf-8?B?QmV2UWh1SXRzQmNBK05NUENwcCs1NnNaNFFoWUZOQXc3YWx3NWZ5Uk1RbjFM?=
 =?utf-8?B?Vkk1M0hYTE9UTk95TE5UZ0p3ekVXcSswNUp0VElvckNuaVAwNzF1am9SWkFz?=
 =?utf-8?B?UHdwWG1nRGhKRHhBUTRobngydzFLZHB1cFg4K2h1Z05Td3RaK29IUVdLTFFL?=
 =?utf-8?B?S3A5Rlc3cHRrOUFlOGZoNXhhTU4rWm1XTTNGMnk0MVpYemJNY3pXTk02UnpY?=
 =?utf-8?B?WHRaSVlWOFJrUVhOMndIRmw0VGxDeUJQdk9OWkJEQVBuUXUwQWQ4T01iSEZ1?=
 =?utf-8?B?UmRJeGdLQldaSU9UVnc1bXRsajBsOEN6Mm4wNzNIRjRFajBLL2ZjSlBDOG1O?=
 =?utf-8?B?Qi9RRWJSWlBndGswcUZrd294M1dDZyt0WUs1ZUM1TUFqYVlsOHVzbC9oano5?=
 =?utf-8?B?QzM4RVdPeENEWUhLVVBibkxsc3EreDRhRzhjUklOUzNCNXlSY1VobngxL0Nr?=
 =?utf-8?B?SUdReFFTVm16SnhnSFZxNUpGSHdYeFhGK0JJeEI4UTFZTzJWQ2FMWWU2Qjc4?=
 =?utf-8?B?c2RSclhXd1llYm5KcVlNNDBrRGdMSkJTeHFiTzRiN2VoUTgxcjY1V1BLNk5j?=
 =?utf-8?B?SHEzWWNNSVIzZCtLaVJMbDhGSklxKzdxbW9OQUV0ek5rRkRVMnhzcncybW56?=
 =?utf-8?B?djZ1RENna3NYUTRXWStHQUVNbTJFUjhUakkwYTZTSTgyQXV1WTh3dmtVVFZk?=
 =?utf-8?Q?wAAXx66dK+ssmBisTxGBxpg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjlvTDQ4K3lPSWQreTB0NGFJNHRjNnJlR0xxcUVta2pNUXZDdkp6MitOci9X?=
 =?utf-8?B?OE9ZakwyaWlsRGVJT2NWYnlwYlZHam9odVZRclV2d3l4TnFha2I0MU5peXgr?=
 =?utf-8?B?RVN2UVVzMzJqR0UzUWtYSE05WjNZVEp1d3I3dFRtbzFZd2ppSlF1ZGw5NFlS?=
 =?utf-8?B?ckZQT0w0d3VUU3haNU9DVUlUaWFDa3d4TEo1ckVsM3cybFlObGowYVNtcWRN?=
 =?utf-8?B?MmhINkFoUVN1VTVVeDhXSTF3V04vQ2VYSzRscENHcW5kakZia08xaW5nc3J2?=
 =?utf-8?B?R1VOUWpaczBETzgzK2RSSlBQcWI5cVNlbnNjaE00YVFiWmlmZGFQRm9SV3ZB?=
 =?utf-8?B?T3JzT0VjalJPNHVHQWhOSjk2bG02SEZ2QlQ4VjVTaXFBVlE1ZHZBS0Q1cXZ4?=
 =?utf-8?B?Ym13eFRsNHBaZnltaHdaVGJXT0wvQlB3bHB6K1pwTHNITUoyUlIxajI3V2F4?=
 =?utf-8?B?em9OdFJZUWFKNFZQRzRMbXpheWhCZzh3Y25ad0t0c0htUmNzOCtCYkVGelNt?=
 =?utf-8?B?L3NRMWdDbmhFekhjbVJqZWlabVQ0MHUrUHhQQk9XelpzTy9PWklPVU80NXht?=
 =?utf-8?B?NEd6T2lYck9ONWc5Vml5dE5ZN3hGTnM4cE0waWo3Qkk1K2hLbzUyeUxQb1hw?=
 =?utf-8?B?YmEzd2ZzbTRScG1TYzVBb3A5UmJWdStCVWpkZm91dmFxWTlkNnhCTzZjQ0VL?=
 =?utf-8?B?RUdpdnJMSlRPaXZva20zVUtGNUVqcXFEaHNHcklhcWVWcStIWTg1OWs3ajVj?=
 =?utf-8?B?aVJ5eG5oZjhiR29MQjVzS2cvemtmZzQ3UVRLQmMyRmtVSjFsK1JKRGtMUnNM?=
 =?utf-8?B?amxmMWJFMm1MYnozblFoVDdpbXJWNHdlN3pobUlWdGlHT2pVQzhpNkFqQ1I0?=
 =?utf-8?B?Sm9sSUk0aHliOFRXbm1VL2pBTHhLTlMvU0c5SERlUlAxWFdTVWFPTnNiUXRC?=
 =?utf-8?B?RGhDNXYxbmNXQ2NTT21IdWgxbkxJeVI3RnJpT2IyczMzNW9qT1dzTGRyTmNW?=
 =?utf-8?B?ZGJRNjRSdXZKeTZDelVJOTd1eW5aSlBid0d2Q2JLTDJMdGNlOTNWUlFEWjdL?=
 =?utf-8?B?K0tSTkgwLzFaZGFOckVBckRLQnBYTWxiKzdYTWw1ajZCOUhSUTV4RjhMRFBQ?=
 =?utf-8?B?TTFqTU5SVHdqUTdqS3NCSElnVk1xQ3ZQb3JoS21mdjA0TGdERENMNDNTUjR4?=
 =?utf-8?B?SHp0TXo0b1kwbkY2NVNNU1UxV2lqNW9XOVVSR0JDQm1zVTJpTm9XWTBrcklC?=
 =?utf-8?B?clJYOWRaL1hrUEdUQmZJMnNJSFV3WGNyblZWMmtvUHhrWk5GRUxxYnArbzVi?=
 =?utf-8?B?YkJTWmRnN1d3WFQxaUJkZmRCU29qM1QwZ0ZlY2E3ZFNWN2sxaXdwVnZoeHVS?=
 =?utf-8?B?YW9jaXN1Q1dsaHN6YnAvQU0rTzh3WWRvV1FTTGJkcE42dnR6blgzcG1LQ013?=
 =?utf-8?B?VURaQmh6TmticEh0cmVnNElIZlp6ZjZqTW5lS3dVbmFvNmJyTmw1OVZUaHhB?=
 =?utf-8?B?V1paODFzSmxVYXJnVGp2TXlJeUNLbm1SeU11RjBKN0pSMUFJdVNNUU51aWcv?=
 =?utf-8?B?N0NRb25rYityTnBWTFZvMVljNE9hakFtYXBQR3ZqZzZnd0dZZXYwbjJIT1Bm?=
 =?utf-8?B?ZmtuUFZkdjdjcno0bEVJZ3BFYytSQ0VQRWRuT21vWWxvbEpFbGVvbnRiS0VP?=
 =?utf-8?B?TFl5YjRpOGVwRTZIcGlJK1ZtNjRsL1dYZjd0V1RMUnVITWM0dFYwMHMrWktW?=
 =?utf-8?B?V3d4anhZd243LzV0RzczV0dkMWk3WmZ0VG9LT216VjFaUW95eVdIRS85RXVp?=
 =?utf-8?B?TWlHMUJnWWRSSXdBb3M3M2lOQ2toWE5GbHRTYWM4OW00dVp3SHVXcFU5VTNp?=
 =?utf-8?B?SDJSMGVqYzNoaUdGcjgrdldiZUNWZGw5VitJaDFubXRlYVdIVUtKK0MvcHk3?=
 =?utf-8?B?WjJlUG1oRlNFRmxVaGJtNUs4ZXFMaGEvSG92cVBBZ21NaUxuQ2VYK2NMeWw0?=
 =?utf-8?B?MUtacUVaSCt4UG1iaEgxRnUrbVMxbWdMRHJMQ28wUnRuTG05VGVKYi9WSFAy?=
 =?utf-8?B?b1NyckVMOWEyN1ZwREJnS1ZvQ1VsTEdXdkRaRXR0bVZrdWRSRjFsNVArb2Na?=
 =?utf-8?B?WnBST1V0M3c0aGJtUmF6ZDBXbFpwSUZGS0ltMUorUC9LQ2VsSGlsYk5pWFM4?=
 =?utf-8?B?bE1XdS9pdndYS2lSaGFCSTFaT0hVcU9TY3FTVkN4NWc2QUlxeStFZXRXUFZ3?=
 =?utf-8?B?eVptK2Z2Yk5xSEhOOHozcE9aend4WEFFbzd0ejQ5dlp1NWtRdlVhYXFUSEdX?=
 =?utf-8?B?Nkc2dFdIQTZyZllZL0ZkejBNMTdaQkUrb0kwVWlSSjlKK240Q0Q4QT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7376c6d6-0282-4218-1e64-08de61fc66a5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 01:43:01.8088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSpm7yP9dxFNYt9gKkHVPxaYtVj/DOi7Lt8cK8ha3ChYY/zehUvILsKtO0Hq0k810lMdJtt4hxl8q+SXcDwktQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11483
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

i.MX95 uses System Manager(sm) API to start/stop logical machine or cpu.
There are two modes:
 M7 in a dedicated logical machine, use LMM API
 M7 and A55 in same logical machine, use CPU API

Extend the driver to using LMM and CPU protocol to manage the M7 core:
 - Detect using LMM or CPU API in probe using API scmi_imx_lmm_info().
 - Compare linux LM ID(got using scmi_imx_lmm_info) and M7 LM ID(the ID
   is fixed as 1 in SM firmware if M7 is in a separate LM),
   if Linux LM ID is not same as M7 LM ID(linux and M7 in same LM), use
   LMM protocol to start/stop. Whether using CPU or LMM protocol to
   start/stop, the M7 status detection could use CPU protocol to detect
   started or not. So in imx_rproc_is_running, use scmi_imx_cpu_started to
   check the status of M7.
 - For above case (2), Use scmi_imx_lmm_power_boot to detect whether
   the M7 LM is under control of A55 LM.
 - For above case , after using SCMI_IMX_LMM_POWER_ON to check
   permission, scmi_imx_lmm_shutdown API should be called to shutdown
   the M7 LM.
 - Add a new ops imx_rproc_ops_sm.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 168 +++++++++++++++++++++++++++++++++++++++--
 drivers/remoteproc/imx_rproc.h |   3 +
 2 files changed, 166 insertions(+), 5 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 9eecbe70f0b..3f8cea127ec 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -11,6 +11,7 @@
 #include <linux/types.h>
 #include <regmap.h>
 #include <remoteproc.h>
+#include <scmi_nxp_protocols.h>
 #include <syscon.h>
 
 #include "imx_rproc.h"
@@ -37,9 +38,25 @@
 #define IMX_SIP_RPROC_STARTED		0x01
 #define IMX_SIP_RPROC_STOP		0x02
 
+/* Must align with System Manager Firmware */
+#define IMX95_M7_CPUID			1
+#define IMX95_M7_LMID			1
+
+/* Logical Machine API Operation */
+#define IMX_RPROC_FLAGS_SM_LMM_OP	BIT(0)
+/* CPU API Operation */
+#define IMX_RPROC_FLAGS_SM_CPU_OP	BIT(1)
+/* Linux has permission to handle the Logical Machine of remote cores */
+#define IMX_RPROC_FLAGS_SM_LMM_AVAIL	BIT(2)
+
 struct imx_rproc {
 	const struct imx_rproc_dcfg	*dcfg;
 	struct regmap *regmap;
+	u32				flags;
+	/* For System Manager based system */
+	struct udevice			*lmm_dev;
+	struct udevice			*cpu_dev;
+	ulong				reset_vector;
 };
 
 /* att flags: lower 16 bits specifying core, higher 16 bits for flags  */
@@ -65,6 +82,41 @@ static int imx_rproc_mmio_start(struct udevice *dev)
 	return regmap_update_bits(priv->regmap, dcfg->src_reg, dcfg->src_mask, dcfg->src_start);
 }
 
+static int imx_rproc_sm_start(struct udevice *dev)
+{
+	struct imx_rproc *priv = dev_get_priv(dev);
+	const struct imx_rproc_dcfg *dcfg = priv->dcfg;
+	int ret;
+
+	if (priv->flags & IMX_RPROC_FLAGS_SM_CPU_OP) {
+		ret = scmi_imx_cpu_reset_vector_set(priv->cpu_dev, dcfg->cpuid, 0,
+						    priv->reset_vector, true, false, false);
+		if (ret) {
+			dev_err(dev, "Failed to set reset vector cpuid(%u): %d\n",
+				dcfg->cpuid, ret);
+			return ret;
+		}
+
+		return scmi_imx_cpu_start(priv->cpu_dev, dcfg->cpuid, true);
+	}
+
+	ret = scmi_imx_lmm_reset_vector_set(priv->lmm_dev, dcfg->lmid, dcfg->cpuid, 0,
+					    priv->reset_vector);
+	if (ret) {
+		dev_err(dev, "Failed to set reset vector lmid(%u), cpuid(%u): %d\n",
+			dcfg->lmid, dcfg->cpuid, ret);
+		return ret;
+	}
+
+	ret = scmi_imx_lmm_power_boot(priv->lmm_dev, dcfg->lmid, true);
+	if (ret) {
+		dev_err(dev, "Failed to boot lmm(%d): %d\n", ret, dcfg->lmid);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int imx_rproc_start(struct udevice *dev)
 {
 	struct imx_rproc *priv = dev_get_priv(dev);
@@ -100,6 +152,17 @@ static int imx_rproc_mmio_stop(struct udevice *dev)
 	return regmap_update_bits(priv->regmap, dcfg->src_reg, dcfg->src_mask, dcfg->src_stop);
 }
 
+static int imx_rproc_sm_stop(struct udevice *dev)
+{
+	struct imx_rproc *priv = dev_get_priv(dev);
+	const struct imx_rproc_dcfg *dcfg = priv->dcfg;
+
+	if (priv->flags & IMX_RPROC_FLAGS_SM_CPU_OP)
+		return scmi_imx_cpu_start(priv->cpu_dev, dcfg->cpuid, false);
+
+	return scmi_imx_lmm_shutdown(priv->lmm_dev, dcfg->lmid, 0);
+}
+
 static int imx_rproc_stop(struct udevice *dev)
 {
 	struct imx_rproc *priv = dev_get_priv(dev);
@@ -146,6 +209,20 @@ static int imx_rproc_mmio_is_running(struct udevice *dev)
 	return 1;
 }
 
+static int imx_rproc_sm_is_running(struct udevice *dev)
+{
+	struct imx_rproc *priv = dev_get_priv(dev);
+	const struct imx_rproc_dcfg *dcfg = priv->dcfg;
+	int ret;
+	bool started = false;
+
+	ret = scmi_imx_cpu_started(priv->cpu_dev, dcfg->cpuid, &started);
+	if (ret || !started)
+		return 1;
+
+	return 0;
+}
+
 static int imx_rproc_is_running(struct udevice *dev)
 {
 	struct imx_rproc *priv = dev_get_priv(dev);
@@ -207,6 +284,14 @@ static int imx_rproc_load(struct udevice *dev, ulong addr, ulong size)
 	const struct imx_rproc_dcfg *dcfg = priv->dcfg;
 	int i;
 
+	if (IS_ENABLED(CONFIG_IMX_SM_LMM)) {
+		if (!(priv->flags & (IMX_RPROC_FLAGS_SM_LMM_AVAIL | IMX_RPROC_FLAGS_SM_CPU_OP)))
+			return -EACCES;
+	}
+
+	/* Only used for SM based System */
+	priv->reset_vector = rproc_elf_get_boot_addr(dev, addr) & GENMASK(31, 16);
+
 	/*
 	 * Before loading elf, need do ECC initialization by clearing the memory
 	 * region, if ATT_ECC is set.
@@ -239,19 +324,65 @@ static int imx_rproc_probe(struct udevice *dev)
 {
 	struct imx_rproc *priv = dev_get_priv(dev);
 	struct imx_rproc_dcfg *dcfg = (struct imx_rproc_dcfg *)dev_get_driver_data(dev);
+	struct scmi_imx_lmm_info info;
 	ofnode node;
+	int ret;
 
 	node = dev_ofnode(dev);
 
 	priv->dcfg = dcfg;
 
-	if (dcfg->method != IMX_RPROC_MMIO)
+	if (dcfg->method == IMX_RPROC_MMIO) {
+		priv->regmap = syscon_regmap_lookup_by_phandle(dev, "syscon");
+		if (IS_ERR(priv->regmap)) {
+			dev_err(dev, "No syscon: %ld\n", PTR_ERR(priv->regmap));
+			return PTR_ERR(priv->regmap);
+		}
 		return 0;
+	} else {
+		if (IS_ENABLED(CONFIG_IMX_SM_LMM)) {
+			struct udevice *lmm_dev;
+
+			ret = uclass_get_device_by_name(UCLASS_SCMI_BASE, "protocol@80", &lmm_dev);
+			if (ret) {
+				dev_err(dev, "Failed to get SM LMM protocol dev\n");
+				return ret;
+			}
+
+			priv->lmm_dev = lmm_dev;
+
+			ret = scmi_imx_lmm_info(lmm_dev, LMM_ID_DISCOVER, &info);
+			if (ret) {
+				dev_err(dev, "Failed to get lmm info\n");
+				return ret;
+			}
+
+			if (dcfg->lmid != info.lmid) {
+				ret = scmi_imx_lmm_power_boot(lmm_dev, dcfg->lmid, false);
+				if (ret == -EACCES) {
+					dev_err(dev, "Remoteproc not under U-boot control: only support detect running\n");
+				} else if (ret) {
+					dev_err(dev, "power on lmm fail:%d\n", ret);
+					return ret;
+				} else {
+					priv->flags |= IMX_RPROC_FLAGS_SM_LMM_AVAIL;
+				}
+			} else {
+				priv->flags |= IMX_RPROC_FLAGS_SM_CPU_OP;
+			}
+		}
+
+		if (IS_ENABLED(CONFIG_IMX_SM_CPU)) {
+			struct udevice *cpu_dev;
 
-	priv->regmap = syscon_regmap_lookup_by_phandle(dev, "syscon");
-	if (IS_ERR(priv->regmap)) {
-		dev_err(dev, "No syscon: %ld\n", PTR_ERR(priv->regmap));
-		return PTR_ERR(priv->regmap);
+			ret = uclass_get_device_by_name(UCLASS_SCMI_BASE, "protocol@82", &cpu_dev);
+			if (ret) {
+				dev_err(dev, "Failed to get SM LMM protocol dev\n");
+				return ret;
+			}
+
+			priv->cpu_dev = cpu_dev;
+		}
 	}
 
 	return 0;
@@ -372,12 +503,39 @@ static const struct imx_rproc_dcfg imx_rproc_cfg_imx93 = {
 	.ops		= &imx_rproc_ops_arm_smc,
 };
 
+static const struct imx_rproc_att imx_rproc_att_imx95_m7[] = {
+	/* dev addr , sys addr  , size	    , flags */
+	/* TCM CODE NON-SECURE */
+	{ 0x00000000, 0x203C0000, 0x00040000, ATT_OWN | ATT_IOMEM | ATT_ECC },
+
+	/* TCM SYS NON-SECURE*/
+	{ 0x20000000, 0x20400000, 0x00040000, ATT_OWN | ATT_IOMEM | ATT_ECC },
+
+	/* DDR */
+	{ 0x80000000, 0x80000000, 0x50000000, 0 },
+};
+
+static const struct imx_rproc_plat_ops imx_rproc_ops_sm = {
+	.start		= imx_rproc_sm_start,
+	.stop		= imx_rproc_sm_stop,
+	.is_running	= imx_rproc_sm_is_running,
+};
+
+static const struct imx_rproc_dcfg imx_rproc_cfg_imx95_m7 = {
+	.att		= imx_rproc_att_imx95_m7,
+	.att_size	= ARRAY_SIZE(imx_rproc_att_imx95_m7),
+	.ops		= &imx_rproc_ops_sm,
+	.cpuid		= IMX95_M7_CPUID,
+	.lmid		= IMX95_M7_LMID,
+};
+
 static const struct udevice_id imx_rproc_ids[] = {
 	{ .compatible = "fsl,imx8mm-cm4", .data = (ulong)&imx_rproc_cfg_imx8mq },
 	{ .compatible = "fsl,imx8mn-cm7", .data = (ulong)&imx_rproc_cfg_imx8mn, },
 	{ .compatible = "fsl,imx8mp-cm7", .data = (ulong)&imx_rproc_cfg_imx8mn, },
 	{ .compatible = "fsl,imx8mq-cm4", .data = (ulong)&imx_rproc_cfg_imx8mq },
 	{ .compatible = "fsl,imx93-cm33", .data = (ulong)&imx_rproc_cfg_imx93 },
+	{ .compatible = "fsl,imx95-cm7", .data = (ulong)&imx_rproc_cfg_imx95_m7 },
 	{}
 };
 
diff --git a/drivers/remoteproc/imx_rproc.h b/drivers/remoteproc/imx_rproc.h
index 7a82dc4a195..1629bc7f6e7 100644
--- a/drivers/remoteproc/imx_rproc.h
+++ b/drivers/remoteproc/imx_rproc.h
@@ -51,6 +51,9 @@ struct imx_rproc_dcfg {
 	enum imx_rproc_method		method;
 	u32				flags;
 	const struct imx_rproc_plat_ops	*ops;
+	/* For System Manager(SM) based SoCs, the IDs are from SM firmware */
+	u32				cpuid;
+	u32				lmid;
 };
 
 #endif /* _IMX_RPROC_H */

-- 
2.51.0

