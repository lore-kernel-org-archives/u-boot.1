Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D21C7CDD56B
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 02:59:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F84088EF2;
	Thu, 19 Sep 2024 04:58:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rJ5za/pe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E37E688FC1; Thu, 19 Sep 2024 04:58:24 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::609])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04F9588EF2
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 04:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIPYF/d6gl9ntuvcDfbE/RUsIrxEBcYomDrgS3jjb4yMkm7IT52niP/BYRfRLYZGQgEpFSqcJkmmJcwawlvK+FWhQ3UzuwHU6xRVY4KIsyh3V3wErWHdiIGk+nf9cZ5wZc+/lDf7XXCsKhfzlWzbpSsHahbEwHyQnYMPmQrzIoQPIaeFQDXJtJnmKguFh5dbXAM+wtxir+3RieBA8zr4rPIk//qp+cwtigTun89u7YZz0raUS0/C6YAxvj3F810TuGZddPCI7E/Olc4yeLWywrOugf5edWnA040/aW0mI9y5MtQL8w4sASnkxezTamlBKvmmGsFqLhYhVG6iJf/+lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aeD/FvxWL3TGyrOroVH3sEhUumB+egqQnhQa4Sgvppw=;
 b=KMRxr3exQRaYyuNYZHCC4DDlO4JfN/PUJZfGyfZZIvF+c2gBi5TZCT8UrOp2YESto6SqQeAOirg++/GYaRvaLIT79zxIHtThMzvCr+ir569McOAkMj92k1ECCb6xj50QtCWs13NAEIlT0Ur1Uc6EmGVv+JE5o/KwyLPfXgmGRPmWx1xgM/m0SmOQ22bfiqFk3dUWC79IZeY8w0Bl9RbcXZOzpIssPZCoY4hh2JUPwc8xI1+YV6fon0MVhbd7YCq1R++T0jVyL4UlxHJ53IArp/w+wFimmbQ4ZpL9sTRdLmIxzW/Bigts5EWc/cPIiNMHxFwJr6O8mHjgCoDf+ffFCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeD/FvxWL3TGyrOroVH3sEhUumB+egqQnhQa4Sgvppw=;
 b=rJ5za/pepJrK2MmV8QEry2f4pYLnh0v3ENhBcQg8MZnzH/g5GVlI2q8WvlG+lQRVg7J6rH+S36t2isUd7R8LkQaWVtC+AZYD+stLjLem25eq/u/g3reooAVofqy0hvIu8qV0m/ZYSuILUYnwm7I0hLvEi7V3d0+csFhJYQftS6caiSB19ko69YNZfGLZ3PW1Vnz2MRuChNgkeEUPI6SsqRgR7bsoxDysFvLuTfFBsncq8+/FAIXqOVGpprFV0rHfABX97JMPbvwxuaPKGt5FFxYcd7S35/qUmtO7Hp66w8lTCJlu5CZgm39v3ohsZ0ERAuLxrjcIttwBLVXJUTr3FA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9986.eurprd04.prod.outlook.com (2603:10a6:102:380::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 02:58:21 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 02:58:21 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 19 Sep 2024 12:01:25 +0800
Subject: [PATCH v3 07/21] imx9: soc: Print ELE information
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-imx9-update-v3-7-80f9786cd1f0@nxp.com>
References: <20240919-imx9-update-v3-0-80f9786cd1f0@nxp.com>
In-Reply-To: <20240919-imx9-update-v3-0-80f9786cd1f0@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9986:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dc18af7-7324-4628-6f3d-08dcd856eb91
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3pVZlFQdm9UTVZJRzArSDJjTHJTL2Q3cytPWTJuc1ozNTh6cVBCSitJRXNq?=
 =?utf-8?B?WEdnMGswTEdHTVQvZmI0VWR6blNybkEwZmk4bzkyQlgvbVlqNjhNaUhSNjFk?=
 =?utf-8?B?eHVETXNnN3RSMnRWRzlVS0lSTGhCclpCUlR6WWNrOStWWDJiSWZVQkVyL2FH?=
 =?utf-8?B?MElBNjNRYWh0b2dpVXVXQ3NsTkYrQzZlMGxmR1dsdVVsMHdBWWliSVdPTHFZ?=
 =?utf-8?B?Wlk1ZHVadWQvcGRTcDd5RlVteDBBTG5qUzZiNDZSRmdmaXF2YzJhZStkU0hy?=
 =?utf-8?B?cXVYc3crT3lWbk5aVkR1V20vYTFielJLd0pCRGJKdDFvUi8zQjAwYkRzb2dY?=
 =?utf-8?B?NDlhRmE5NHEzR0pzY1pUQVlNQStOclJpOGpuUUxmcTBEd0kwQ0swTThIUC8x?=
 =?utf-8?B?ZGhtTmN5REJBMTByZ05uTSs1MjNqaHBvUm9QbitYV1l0MFdzckVNbjR2cmxj?=
 =?utf-8?B?TU9zMFBON3Nnbml0dE8vN2ZTeFRJYk4vS2JsZmpmK2o5NkI5LzUrb0UwTW53?=
 =?utf-8?B?TVJ3ekd3NStrQmJSMmp4ak1Db3FpWTVaTlBsN1RlUkc2OVM2emJBdWNCa0Ur?=
 =?utf-8?B?c043a3NWMUZ6aU9DOXhoQUJpcXdxU1FoUkN5WHI5VENacExBS21ncE5RWmgy?=
 =?utf-8?B?ZjMxaERiNnNxVUNQejdHS0tQYU1wUnFDeUdLU3JYaEd1WW1MYTZCeVlvSU4x?=
 =?utf-8?B?UWxsZTBrRUVrc2tMSlVUSFRPbzM0aGlabmpoaTBIMDdXelovMUlDems4ZzlN?=
 =?utf-8?B?c2hsb0NBQnplOERFQWFvZnlrOTZYZWM2akhTSnhRWEN3WXpTZ0NGUHVvb1RL?=
 =?utf-8?B?azFoZG1tenlhNEVzQXFPdWJvZTRHVEhURTcwbnZpRFhrMVROc2FwdWp1dVc5?=
 =?utf-8?B?azF5NkdERmlvMlFnaW9ycDMreDltMjJKTTNXOGVaUUUrby8vekFTNkVCcUxQ?=
 =?utf-8?B?TCtzQktjVGRjblJvVFMwUjh2bmtjN3Y5bnA0dndDWFRZaU5KTnRCU092VHpj?=
 =?utf-8?B?SEJQa2JnQnQxWENoWXVpNzN6L0ZkUjBGSXJVcXNIdzVZZlFvdS84S0hKL3Ev?=
 =?utf-8?B?QmRYZkROemNsNkhMV3BOenVSSHVFb2EvZWxiWUZSY3FqbWpSYWJiMkxRSmJz?=
 =?utf-8?B?K1RsUG1iUGtONDlBRDJLZzZnVm83WHdQamFBVjRZdllIakRaZFdBaXl4VGJV?=
 =?utf-8?B?R2EwdTJzVXI3eGJIMUdhV252dllXaHAwQjFrRGpSNVlmRDFYNmNyQW9SRzkv?=
 =?utf-8?B?NDhaSUhiVGwveVJJaHZaeFhDb1hBRTVlY1pkenBNQkJQbHdwUFVETWlGMC9R?=
 =?utf-8?B?Z1NjOGJkTkljNGVxcmZibi9BQXlZSmw0ZFdJczloYkhhQjlVQ2UwR0pqcDJm?=
 =?utf-8?B?em8xTjh5SzZDWG04S1ZVZ3dmQmZHaE9Ic1M4aXVuTVFzWlkrMElEOEE0cUR3?=
 =?utf-8?B?K1RMblRiTU1xWExYdkQybUpMcy82SEZtY1lmNWpHa09NRXNuT1hoY3gyZWNm?=
 =?utf-8?B?UjRCYzlnUllTMGgrV1RDQytmRGczOW84WFlhcmxrZENBK1FPemlkMFU2ekdh?=
 =?utf-8?B?SlNNN0xXMGJxbTgyUHpYekhjWnpZZEtyZnMrdmtKZXIxb2NzUThLcW1vRmZJ?=
 =?utf-8?B?S0dKOGJrQXVybzJGWUNhL1FMSmJ2ejJhYTZTTUJLeTVCeEhSbFllSVRMVlpK?=
 =?utf-8?B?MGJFWXJEbG1qRWhieVpkcU1RTmpwQTJOSWVUM1lPM052TWVhbTc4cS9TWUkw?=
 =?utf-8?B?UjFieWtNRHpSYlNYTDhMU3VBdXcyL0Z4QzlHQXBkYnlFUGQzZkY0Umo5U0J2?=
 =?utf-8?B?NlNsa2ZSM1BNdXl2cHlCcHZSKzhSdmFvNXJXWmVtYVpzdEEvVFMydkV2Uy9k?=
 =?utf-8?B?aVRGUmNkU3kzNXVPV1pZUDJMaGxEV1ErL25sZ2daZ1RQZnc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUVVdWcwdVRSVWVRVWdEdkJ0alMwVDdNWmYvanVHNzI0dkFJWjhjZXdMTDR1?=
 =?utf-8?B?dVViRUFITEcrbkxKVG56Zm1MZTMwL21XT01ORDVhR1FtenBQaFJ6M3dSd0Jz?=
 =?utf-8?B?TEtYM2pSTElpYTJqcC92QnRnYkNEd1RZeHhMNWpXQk10aDFlZ2VaUWloVzA0?=
 =?utf-8?B?TndCTHRvMGFYMjRtTkU1Y3ZHckZiN01ocldzWXVvM2ZrclVoRVBSUGJkRjBV?=
 =?utf-8?B?VVV0eDRMUlZueHlLYzNjcitsSjRBSWNRSUtuOFV4Q2tEQWV2aFBZZXdiWk4z?=
 =?utf-8?B?eE8xMHRCK2lnb0J4UE1MdEVnSWN3RmswKys0bzkzM2h6THhwYThIRmRuVW1L?=
 =?utf-8?B?cGJUR3Y2MDdlQkc4NXBqMWYyVGM2M3I0M01md2hvcGNpa01KRkpWUTlsTncw?=
 =?utf-8?B?SDR6MTBFWGNXeFE3TmQyaS93ejhIcFVlYlBYNHYrbGlvZytMSHZja015K3Rr?=
 =?utf-8?B?cmw2TGF1S0piNFh4YjNtR1hyN0pLUEV0NGg2SGVOOE8zek81em55b1NPMEtL?=
 =?utf-8?B?czBsK3FXbTFaNER2OXJPaUlEZUszaXoyTkFsSFlNTndqbkhXSk5FRS92ZFIv?=
 =?utf-8?B?clVYUEVrWkNIS0M3TldVRzd3M2gvbGV3YjRVamNHOG1DWWNXMm5HUk9nSjJB?=
 =?utf-8?B?Q3R2UmtPZ0E1cGNzNkFrQnV0em03V3ErdlhGdS91Uk1wZUtpQksyTTlneEd2?=
 =?utf-8?B?QjdEZVYyNTRIRjVGVm5pdThGaUVScnN0eEhoODYzUGlNd0FWSEJFRnlXbStU?=
 =?utf-8?B?NUpuU3o2dVp3RllnbXlBaXR3WkNqendHK24yeWFyWUw5V3FwdUdCNno2cEJl?=
 =?utf-8?B?d0dmNmtIUmNYa0tpekMxa3IvWkJabUxyTVl2a3YrSzc5VG96RS9jM0xsSTNt?=
 =?utf-8?B?QzBRMllsWHhIbnlRTzJBWEpLWG50OEZ6cjFRZDM0NnZiVUZRaDhMV1lIVEpR?=
 =?utf-8?B?YUNVTDlQRCt6dFNpbHJ5ZGsxUlE0bW1GZy9HQm9vNGEwYjZ2TUlsS0RKL1Jv?=
 =?utf-8?B?YWxITlhMUnhleENSZjl6MlZ2L3Jtb0FIclV0MEo5TGdOMDlZMlYzNkJpdFBq?=
 =?utf-8?B?Y2J5SytWZnZkME5UVmNObFdVeHVPeWIxVlEwUE9LRVVVYnFISFZacmVtd3dT?=
 =?utf-8?B?OVFxTDRzVU1YbGIzV1N1cnppOW93WDVoR1ZRRmVOV1JaRUVlN3hVeUJudm9z?=
 =?utf-8?B?WFpRVEYrODJWak1ERkZ3Y3JGVFdTWGxrcUxJVGR5akFqKzFRYUpYRFJ0VUpo?=
 =?utf-8?B?enVSL1dFM2UzZzZBa0QvZVl4K0t3Y0FQK25HTFcyVm1tNVBrRjlTTzA1eFhK?=
 =?utf-8?B?WUpreklTWW5vVmhUS1Nva3crRDBydGRtZ2YzcTJuQTlucUhNWUxKSkVkZ20x?=
 =?utf-8?B?MExBZmRVSVZ2QkFFRTV5MGNEZXlNalpVNUwxTVBLMFNkaUZQQnNORi9nQ2xH?=
 =?utf-8?B?Q2VQWkFUSkswVGZNME9RUDFPMXZKcXNBT1QyVlVqMFZjaVFoRFUvN1kybDg1?=
 =?utf-8?B?d0lxQjdkYm1QQzROWi9QT0UwM1Fxam9uc3h2cDVRRjZNTjRzK0MybzI4WkdH?=
 =?utf-8?B?Z3FtcmxNS1hoZEpabXBuTWI2K3IyQVJDTHZaUSt6cEJwUFNHcTNHeDRUZ0li?=
 =?utf-8?B?bDVvdWpOR1d5bXFQMWxKWmcxL25hNkEzT2VqbnJBeXRYekU0cnFRNmpGNHlv?=
 =?utf-8?B?NU9Bd3VwMFJXOS9lejMvRWpDUzJtRHRTeHVKRGxaVERzRjBJU0QwczhyRkZG?=
 =?utf-8?B?bEFWUitTNDFqOTdZZ1FyWUdsV0h4elVkRnFWRWxMTGJib2FINTd1ZkxxTHpr?=
 =?utf-8?B?dklXM0x0TXFsSGQ3USs5L0U2TFU2b1c4dWxjMDFNdXZQQlhoNjIvUzJDRThk?=
 =?utf-8?B?UkxRYnAzYVBOd2dSZVFkK20zNHFBZ1RDd1BBT1pLeVQ5RjJCY09LenFZdjU3?=
 =?utf-8?B?MlpZbmkwM2l6SEh1UVMzbmJEWEN0N0QzSEVjRVVkVDMyUlhwTWhnS2JjbEpl?=
 =?utf-8?B?bGFEamIvNEVWSFA5NGR5dU5QVmdlYmgwU28wR1FVa1EwbXl5YlY1b0dxRnVx?=
 =?utf-8?B?eXNIcHpuakJyeTNHRzZnaEp1QjBIb1RoUGlPNlBiNisxVEJOVitZM25taTdo?=
 =?utf-8?Q?Kl8WSaTSdZSwpTA80jQ+tZCde?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc18af7-7324-4628-6f3d-08dcd856eb91
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 02:58:21.1615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gi0uf0yPHC7JuwmUO1oRPjyaRGZJX4NI+gPVJUI5mbNwpA+cZJnxGFbzQcW0l9bIAYU+Weml2rK2Ijlb+lzMTQ==
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

From: Peng Fan <peng.fan@nxp.com>

The boot image includes Edgelock Enclave(ELE) Firmware. Print the
information out to let user know which version firmware is being used.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/soc.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 9494c739969..ba04abff262 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -582,6 +582,39 @@ static int fixup_thermal_trips(void *blob, const char *name)
 	return 0;
 }
 
+void build_info(void)
+{
+	u32 fw_version, sha1, res, status;
+	int ret;
+
+	printf("\nBuildInfo:\n");
+
+	ret = ele_get_fw_status(&status, &res);
+	if (ret) {
+		printf("  - ELE firmware status failed %d, 0x%x\n", ret, res);
+	} else if ((status & 0xff) == 1) {
+		ret = ele_get_fw_version(&fw_version, &sha1, &res);
+		if (ret) {
+			printf("  - ELE firmware version failed %d, 0x%x\n", ret, res);
+		} else {
+			printf("  - ELE firmware version %u.%u.%u-%x",
+			       (fw_version & (0x00ff0000)) >> 16,
+			       (fw_version & (0x0000fff0)) >> 4,
+			       (fw_version & (0x0000000f)), sha1);
+			((fw_version & (0x80000000)) >> 31) == 1 ? puts("-dirty\n") : puts("\n");
+		}
+	} else {
+		printf("  - ELE firmware not included\n");
+	}
+	puts("\n");
+}
+
+int arch_misc_init(void)
+{
+	build_info();
+	return 0;
+}
+
 int ft_system_setup(void *blob, struct bd_info *bd)
 {
 	if (fixup_thermal_trips(blob, "cpu-thermal"))

-- 
2.35.3

