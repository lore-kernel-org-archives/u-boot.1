Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0970FCDD56B
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 02:58:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FF5488DE8;
	Thu, 19 Sep 2024 04:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="n1LFg9dc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E46CA88DDC; Thu, 19 Sep 2024 04:58:03 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::608])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9A7788C60
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 04:58:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=syz5oLMNfRNmrb+H7j7kJGgHdh4A8s1wa1NQ3j1g115qZM2eE23jEPvw6d/gjXA6ADwxnd7VMzVMlQFOL/aY8f/DENINhng0UqRxFP8yF3M0jaa8q8buqYrZc7CfTWlkUg1oMdKZQA+dLzxEVN2WKfpdhLUajPofx15fJRhyWZRA0TGnzs368ETYlLm1sQ9yxf0iH6Jy/xb5V8yEaocI5Jd4xAU6LZDBreDqPD37r/cpFq/T++vvIeutIRbb4M5TqfK5zwWmd+qR3B/5v+KV2GXMKyR9HPLd8HjIGJpqIr/OKFQFekfl08cC2sbX/uMkvU17ACjdYHnHydY7FFfUuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cMXO+nAJvzANEucFUfmBSpg0VsDd6yckmAIbw88zJo=;
 b=Knf15nupma6eCj3D+c1YIDHir83Sbc/JswpTIrX0jILoB2oq1r0ZsU5Fm5v4UvtVvu0N1/+lvHmB+YOXI2+nOevnJ5i5meaoDMpRAbmYpGhaLeXLveXl6OFi9vpgpdl+frl+GQvLMdq37gqMNFKZRohgoBU6czOXnLdOqNCEeVGdKC0WtjnlgrzaR8dzeqbzQtAKizkVrSTGyu/1eblAd63PE1oRFsRQgm7mdHEgPN0GyYWe4+juA8zINNMi7O/KQCyv7bhq8NekkCQQqtcp9dFT1uKv47Cxy27OiaRLAJF/Of6aHoyKtWKI/t3c5BgcCiq1bu88EskqzSd+6+naMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cMXO+nAJvzANEucFUfmBSpg0VsDd6yckmAIbw88zJo=;
 b=n1LFg9dcbLNyPi/ACkjs+yiU1eUw3wDc3Pk6JhJELZHPjljCapILbAecSms7hsf7UFf/UpUZXRSO8xlKdRMDp9/sCX/H+MOgRLaRiw7Iejl/HaY6gQqzshNKsdWuJu67Igdjc47ihrKHbhPCDiFGuxOIIjkip0jduEEi9ul4o3OPYkXZ9ZhAdyrvVUieVyJLueyOdsIZQ6axm/0Y41Z15/jGunyT7/pZfqQ2JvdwpULwaS4loydtihSmsWpj+NAuuNPoPgAvBgNp/Qwm/ffcBIyU/o2l7JnFQ+bM49qp2Gb7a/pW3BqgeGTrwD7sWfjpJI2+GU4tELyLd1mJ4kLsMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9986.eurprd04.prod.outlook.com (2603:10a6:102:380::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 02:57:59 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 02:57:59 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v3 00/21] imx9: various update
Date: Thu, 19 Sep 2024 12:01:18 +0800
Message-Id: <20240919-imx9-update-v3-0-80f9786cd1f0@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA6i62YC/1XMywqDMBCF4Vcps25KTESTrvoepQvJTOosvJDYY
 BHfvVEorctz4P8WiBSYIlxPCwRKHHno89DnE7i26Z8kGPMGJVUpbVEJ7mYrXiM2EwnpSBtfOYc
 aIRdjIM/zrt0febccpyG8dzwV2/t16oOTCiFF6cmQ987qmm79PF7c0MGmJPVf2mOpcimxtgYtS
 dPgr1zX9QM9ZSN53gAAAA==
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9986:EE_
X-MS-Office365-Filtering-Correlation-Id: 97a89a76-b964-44cb-8005-08dcd856de49
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZjNQZ21KZjBwc21GWCtvVGpZYlR6YXFwNTQwRHA0Z0lPWFplZFhDUWZrcnBK?=
 =?utf-8?B?NEZDQWtQdlpPWHNHMmlpNjlLVG1ReGF1WnU1Q2R5UjhBYUpBenI5OGxPbkxh?=
 =?utf-8?B?VC9TOTV4d3JwVlljYVk0c2tqVkdTalV1aFdOVEIreVVlMm13LzBOQ2NFQTRS?=
 =?utf-8?B?RVIyYmY2ZmE1WGxaR1phdS9JTGt2SlhaTFpJM2Q1U1djWkwzV2ZjeEd1YUJP?=
 =?utf-8?B?Tk45WkFiOC9EdGFCVXhtOWFGVnIxVDZ0UmgzR1kxSXk1SkVzbWh4R3p5V1pU?=
 =?utf-8?B?ZjlEd3pQZVM5UExCT0l0enB3NmtCb0IvbEdmams5Vk1EdUMwUVQwYzB6WS82?=
 =?utf-8?B?M0s4cVJRYm5xd0Zhd3B5RkphUUQrODRzSFNHWnhDNFFBTkF3OGNJTWkyKzMv?=
 =?utf-8?B?ZHBhbzVRRTB1ZzFpclpid3VEb0ZIWmdreGJ3NWRqQVNtYVg2RmJmQ2E2bTBr?=
 =?utf-8?B?UE95NFY4UUt4bUR5ZTlJdDUzZkVJb05RZXlTd3J2NXd2Zm5XRW1pNkI4VTJG?=
 =?utf-8?B?VTl5UHJuMlZXZC9CVndGd2t4cFhQaXdybDUyZnNxN3BPT2JoOXNCNHpDZzNV?=
 =?utf-8?B?WHZ4SWNzNEZJTjZNM2Iwb2VvSlB5c3JpSHRNUzhoQnU2czNVZHpTMktsQWVB?=
 =?utf-8?B?QlAramt5ZE12cHhOWUhTSVhLRmN5aDhacjhtNmZUdUtPWE90V0VtQmVFMlQ2?=
 =?utf-8?B?eVp4VVJ1UUlWZFdQWi9UbUlZd2RaZXVWUnVSaDB1ZWl0Rm13ODRrUnMvelF5?=
 =?utf-8?B?U1dCS0JzOEo5SzRucGdueStDa2VsSGljKzF6RndHeFVoRmg2N3NDeE83V2w3?=
 =?utf-8?B?MUJHcjR3OTIxZ0dyd0JGSzBUdXBtU0kwcm1xQ283bjBTTGNyenpIUjRYaWI5?=
 =?utf-8?B?dlhxZUI4c3lFaHpHNUJlbkJCQmM0S2poc29jTWxHaGpOVk1sOG44eXVFNVl2?=
 =?utf-8?B?NDRWTWN3N2haMHpUdzViYVdwZzZEUjlhTzhnYlVpblJVUnB1SnJBRGxxV1Zw?=
 =?utf-8?B?Q3RXbmxtWllOV3dQRTVLN0k0RUxWMVRZa1d4WlY5S1V2S2tRQTgyMWR4TlN6?=
 =?utf-8?B?clVXWmlGQUhHZEVBdEVwaDl3clozOTJiYlRoNlI2bllhdVpDSG5Leit4VVVI?=
 =?utf-8?B?WmdlTWU2MWdxMWtOem8vMUZLc3dlT2FweFJRQndXNDBWdjBLVzNjL0hhMWx0?=
 =?utf-8?B?VE9PeHFrSkhxeWNCWHptSTJHMGthaGl3UFVodCtwem9ETU5CQ1NMQ1h0eFRF?=
 =?utf-8?B?cjJMajc3dnIvTTIvSS9PdS9MMlYrVFBRc3pncXBSWHNzaXVKK09yd1VIOVJ3?=
 =?utf-8?B?ZDF3Ty9IYTlkZUk5ZUtLRFgrMGpHNHc2WVgyakdFWm43YndYTFRIa0JyQjQz?=
 =?utf-8?B?blVKVHU3d0hwc25rQ05hUjNvdnNBNzVNeThqU2xaNFQ4UmpieFhOZVdpLzBn?=
 =?utf-8?B?bWNpNHRlNytOOTlnL3JxUWt0bkZEQ2JoS2lCcWZDSGR5WisraDhEdkQxVEhJ?=
 =?utf-8?B?bkpERE5uOWxWdDBIbDlLOWVLKzlIK1JQamNsaUFJNkpBSVVYQ3AxN01YYWNk?=
 =?utf-8?B?ZkY0Sk04bmlIc1Zab0FiV2ZkVE4wRVloLzAvOG9rMDZNR3N4SWRhSmhJZzJ6?=
 =?utf-8?B?amhRUWR5UDFqU1F6clNpbi9CNUtIdzZVcitPOEJablpzMmRBa21kZW9oa3ow?=
 =?utf-8?B?ZEErL09xazMrWjJnOWRVWERMbnpHbHhScDhTUjlyTVhBRWZ4YTMrZWZyN1NB?=
 =?utf-8?B?ZmRFVk9LYUFaYUx0dTNMeFRRY211YWZuVEpUMWllSU5VTjd6RkFSdUFsR0tD?=
 =?utf-8?B?TzhXckdRSnU4bGtUVE8rZ25PdnNYSWZUbm9jdGJKcTBreVVtK1A5dXVVSDZp?=
 =?utf-8?B?aHRWRnpwMnhyNmFHQU95ZHBhTjZuNjdOa05laVhhR1N1VVFpK01IVXFuZElC?=
 =?utf-8?Q?yySkYFSv/Ik=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0ZFWWlEY21EdDNRUnJHUC9Rb0FOVTVhYzNvbnFsTXRaVHBXM3ZaS0w2Q3Rr?=
 =?utf-8?B?V2FWN3hwZUIwSUN5Yk9qRnRFcFBmQlRMNWRHOVhRWUc5RzRXanlueUIzelBD?=
 =?utf-8?B?Z2FnaVpJUjdoeVNqTDNqNTNKUDdRMDEwQVd5M0xXdlUwcEVhUGR4SU14WVY0?=
 =?utf-8?B?THl6YnZ5UFduSm52TVRKMnRIaEFSbVF2cHArYm52OGQ0MjRtTGNycmF5VmxF?=
 =?utf-8?B?ZUlKanI2SnhZQVpBQnAxTDVaQnNmMDlaUG4vcEw3RUM3eERCRlN4NlFySDdQ?=
 =?utf-8?B?VEU0ZnlMOVlTU01wNyttSWxYMmhMazJBVWI0WGRYWnhYMCsvQ3l2OHpJTUVC?=
 =?utf-8?B?VnJ2SGRLT3Z6N1VVNmFudFdzcTkzeE4yelR6Yy9xYlR0TWZ0SG91SHgwN2FB?=
 =?utf-8?B?UXNHZm5vQWU3bzZJTjRIcklzZURROTBkbG95bFM4L0dIOFBZNXVKa2o2eCtv?=
 =?utf-8?B?RXlJSGFqTkp6N3MvMGdORmJITk5OQWtPN1VnTGNVL0xDeHhYSStCQUtyck53?=
 =?utf-8?B?dXZCSjlVZ1Y3ZGVHMVBSTGRuZE15OHZNQWwvMGhUZURaT2VwNDRwTTNjcStH?=
 =?utf-8?B?Z2tvZU1xQm0xVnRFVEtmV3lKaGdaTk5KeUdPMWgzOCszc2dCNTM1VDZHVUc5?=
 =?utf-8?B?VU05TWh2Z1pCeHhyaVo5YjJXYzhXeVVsT09QQ2N3SzV0dGdDbUdmQUdXaHBq?=
 =?utf-8?B?SGNNZzllUmRHRHdldkZ2Z0hsSlNXNCtlQkhQeFp6bXZpdlJ2RzMwT2Z5Mkk4?=
 =?utf-8?B?U3gyRnV5b0U5VzJJQUpUK3BFMzVZNVRaUFJhSTlHRExESm4yR2pzZ29iUHE2?=
 =?utf-8?B?NGVDaFZKanR2bVg1SkpCZTZHRzNtZmp5SUlHWUgzZ05UZ2ZHLzZTTlkrYzVP?=
 =?utf-8?B?bWEzQmRFZFRKU0ZQM0xKS3c4b0lITUliK1BYcU5yVHNXZG5Wd0k1R1dscmRQ?=
 =?utf-8?B?a3JBMEt1YTl3bnRxVE80U2Q0ZXpZK3VnS01IMmRvTFFLdGIrbEM2dTdQczJ2?=
 =?utf-8?B?YzFtYklUTGtxbXRoSmtGdDVndG9pdFAvUUdienN3WnlEWG9YQ3kzY0NPOHU0?=
 =?utf-8?B?MFpwY3FwckVrSUdtREU0dmwxWUt4RGJ5d2JzRW5XRStSbjd6RCt6LzBxOWdq?=
 =?utf-8?B?am02MndSOHBvR1I5ZjEyLzVDNXZxWTJYcG9tdWVvQk1OS1RtS0dFVkVCTVFY?=
 =?utf-8?B?MWlaQ1RidjdDUVZUMGFGMjF6dTBDbGIxbWI5QTNzbEdGWGZ1Z1daTkJHT3NC?=
 =?utf-8?B?cGprWGNQNW16S1RZQUdtNURSSlZBRkpIcDcycXZ5alArUVo1Y3MraEdQUWUw?=
 =?utf-8?B?d2hBQ2NCSXozMDhOSzk4UEpVcjV5NmlGV1VvUW1mNDEwZlM4YzRvd0x1UXFH?=
 =?utf-8?B?TnNYRDdEWnBIVkZZTWNrNTJ4SXkyd0FQcjYwL1RTYnpCZXhpNUR5SzhRdC90?=
 =?utf-8?B?RGhkWVZtdW9UUTBWNHViRExVd2VKSC9qTVI2d3hLejhSSVhQOUg5djlMdDZo?=
 =?utf-8?B?S2FWbUpWNW9GL0ZCRXlKNU1RUE9XeFN2bnVBQnhZakp6T2F4TXN4cXNLaXh5?=
 =?utf-8?B?V1UwVGxNcjQ2V3RUZTFZNGVzdWRBMi9hYkVza1lkbDEzOGF6dDFNVm1qVFRE?=
 =?utf-8?B?eVJNNndaMkZYRmZ3SG1vejZkV1hEei9vZGFMMzFFNWdnU2NsaEJhVGMySHdl?=
 =?utf-8?B?eFRHc29VS1hFNmozaTFYV01reVltTmE5SmNGK0pZbFp0NUFKbm41ZUpoSWpP?=
 =?utf-8?B?OTNKSm9ZVlhoZW5QeXBYSDQxRXNOd0RLVC9tMEJENG5kamh4SS9La3RXUW9L?=
 =?utf-8?B?RDdXaWRzMWhpdmhJOFVseGhtVWVtaFNKRTdKNlZKbXRmckU0L0lSTlgxM3BO?=
 =?utf-8?B?S21QK1ladWVYdlhrS1paWHpqbUtIZGY5bjk4U1FUZGVQN2pZYzBnVDhUZUsz?=
 =?utf-8?B?MVpXYmVlaUZNM0piallpR1R5YU03VmoySFpGTHVyZjFoM1gyTGxSMWxUUVdY?=
 =?utf-8?B?bEVvY3cwRUYwM3l0SThkN3lvSk82V09vNTNTVXN5TG9KR2ltZWRpWEkzR0Rs?=
 =?utf-8?B?YmxxUTlBZWxvRVJCZm12cVBZcnYwT0M1UUFxVHBDOXVXY0NXU0FKTzV3eDhU?=
 =?utf-8?Q?F/C7GqQ4eqUzPNMbkQbELs+RD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a89a76-b964-44cb-8005-08dcd856de49
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 02:57:58.9601 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V8Wb1hwqo6BiSkbmI7ty1XVJL1eemm8pq1uMhrKWdtD30jXeYSj4fa1AH9w/G48jjtObUBGj2UnA+pRFuMTj1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9986
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

Several updates to i.MX9 SOC and i.MX93 EVK, the related code
has been in NXP downstream for some time and gone through several
public releases. Some are directly cherry-picked(with R-b kept),
some are modified from downtream.

This patchset includes:
power domain on fixes
TRDC cleanup and update
MAC address update
i.MX9301/9302 included.
runtime detection of voltage mode
PMIC update
generalize some code for i.MX8M and i.MX9
i.MX93 EVK update and misc.

CI passed.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v3:
- Rebased to Tom's next tree to avoid conflict
- Change back i.MX9 critical temperature to 'maxc - 5' following i.MX8M to
  give some margin in patch 16
- Link to v2: https://lore.kernel.org/r/20240919-imx9-update-v2-0-0d798d9e08ad@nxp.com

Changes in v2:
- Improve subject to patch 3
- 'EL2GO' -> 'EdgeLock 2GO' in patch 4 commit log
- Use HW_CFG1/HW_CFG2 to replace bank2,work[3,4] in patch 5
- Separate patch 6 into two patches, one is MAC update, one is print
  ELE information
- Typo fix in patch 12
- Drop patch 21 "imx93_evk: Enable M.2 VPCIe_3V3 and deassert SD3_nRST",
  this needs kernel dts update first, then U-Boot could follow that
  logic.
- Link to v1: https://lore.kernel.org/r/20240917-imx9-update-v1-0-4fe8effc937e@nxp.com

---
Frank Li (1):
      imx9: soc: imx9: soc: Align UID endianness with ROM

Jacky Bai (1):
      imx9: soc: Mask the wdog reset in src by default on i.mx9

Peng Fan (12):
      imx9: soc: wait ssar when power on power domain
      imx9: soc: Change FSB directly access to fuse API
      imx9: soc: Print ELE information
      imx8m: soc: Drop disable_pmu_cpu_nodes
      imx: Generalize disable_cpu_nodes
      imx9: soc: Disable cpu1 for variants that only has one A55 core
      imx: Generalize fixup_thermal_trips
      imx9: trdc: cleanup code
      imx9: trdc: introduce trdc_mbc_blk_num
      imx93_evk: spl: update pmic settings
      imx93_evk: Remove CONFIG_IMX9_LOW_DRIVE_MODE and ld defconfig
      imx93_evk: add back Low drive mode ddr timing file

Ye Li (7):
      imx9: soc: Configure TRDC for M33 TCM access
      imx9: soc: Print UID in big endian format for EL2GO
      imx9: soc: Change second Ethernet MAC fuse layout
      imx9: soc: Add function to get target voltage mode
      imx9: clock: Update clock init function and sequence
      imx9: Add 233Mhz DDR PLL frequency
      imx93: Add Low performance parts 9302/9301 support

 arch/arm/include/asm/arch-imx/cpu.h                |    2 +
 arch/arm/include/asm/arch-imx9/clock.h             |    3 +-
 arch/arm/include/asm/arch-imx9/imx-regs.h          |   10 +
 arch/arm/include/asm/arch-imx9/sys_proto.h         |   11 +
 arch/arm/include/asm/mach-imx/sys_proto.h          |    8 +-
 arch/arm/mach-imx/Makefile                         |    6 +
 arch/arm/mach-imx/fdt.c                            |  129 ++
 arch/arm/mach-imx/imx8m/soc.c                      |  179 +-
 arch/arm/mach-imx/imx9/Kconfig                     |    6 +-
 arch/arm/mach-imx/imx9/clock.c                     |   40 +-
 arch/arm/mach-imx/imx9/soc.c                       |  258 ++-
 arch/arm/mach-imx/imx9/trdc.c                      |  175 +-
 board/freescale/imx93_evk/Makefile                 |    6 +-
 board/freescale/imx93_evk/lpddr4x_timing_1866mts.c | 1995 ++++++++++++++++++++
 board/freescale/imx93_evk/lpddr4x_timing_ld.c      | 1496 ---------------
 board/freescale/imx93_evk/spl.c                    |   55 +-
 board/phytec/phycore_imx93/spl.c                   |    2 +-
 configs/imx93_11x11_evk_ld_defconfig               |  127 --
 drivers/cpu/imx8_cpu.c                             |    4 +
 drivers/ddr/imx/phy/ddrphy_utils.c                 |    4 +
 include/power/pca9450.h                            |    2 +
 21 files changed, 2582 insertions(+), 1936 deletions(-)
---
base-commit: c17805e19b9335e1fb5295c81b59eddf88d1b9ec
change-id: 20240916-imx9-update-0ce38f6ccd3d

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

