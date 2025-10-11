Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41BACCCD184
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 18:08:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6CC583AE4;
	Sat, 11 Oct 2025 20:07:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NMIpz7Wf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 950FA83E11; Sat, 11 Oct 2025 11:14:00 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5C5C83C2B
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 11:13:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LjJZ0GF8TYdhdP/BCYpOrrXEJRAU3pC2GDGErc+0TN6I9D3z3nT9GjDWFldyD4RbE4Wm01BFuwpOz9poZJ90bOWfLXgfazmrBWrWl4wHBB9yU6L0Aj1CDsJHKlEhnfBBdePA8JPYBiqMvkiyj93lamVDJ7c9zPtGf7SIh6WJemPiu8avX3j12CT1JXNkj+QrWLZh7kX7q1FiZbnjFZu4HBNpakk9nkyXhtliJjb7e1wnxP0WCyFhwmSCjl5RLczch7QZxbbFgqbbNkX8E1NPbPlIo4NS0AGSbDwv+wXRpXoOGXACBIB0ZcRvCnn1Fi2e8JU/DP/vhzqU50RjPX5V6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hu4WAvy0gqKoaqvhC2XUDT95EST6+JWMTMBobM66jE4=;
 b=VFv9K957nP2JWCvgCtRrBqaYrxGSQDaPWdxElj5acMCqZ1Oeo6m4qoeAS56yjvBIOwBsHPqa2qNTtl+CVO/cBFbyOCphmlLo1+RMH486ARO++pCY9chyeuFX/OACyT0IHrkjGgNZhVf4HZpWkJkrtyu83zIvVq30aC3rDNvmW+k8Pja8/b/I/JB823DmL3lp5n0eAADv4S6RFd3F2I9pLFCKahcfFSoo0pCSY9sksJ0gBCFbldzH2LUigLb/ZQYEgqeWk8zZJEUBYv3rHCVtPjbX1lhGgcKSGpl0Iwg5gWuyLuR06HzNwe/BCWbKSv+WX0EYTHY1zhPhxjiQQ5n54g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hu4WAvy0gqKoaqvhC2XUDT95EST6+JWMTMBobM66jE4=;
 b=NMIpz7WfbDOegNrIIjYH0Wcs1xa/qdooVFk6QTvbOfWv/wLUckyoGbaJHo7Ah9pFvyp32caiQUjEYIVlUX8I5hveA6uEdWzmYiL4MYwMpN4F8wy1W7SWXASoVsIjluj7vKC8Ink+ADLSpNfiTVPdhxFoK1+ENO5YofW+U9meqKO2SKOvbLQSOAwSeq2fH81uZ314Yz3wAdEIEs7Y55uDlRp6RuvIHRawBT1UIfWugYjDJw/jEMgyNEfgyP8HB9+hIGUjIRT7FUpDpAMdddX5s9hRivN9RioWcw4WMrRaOzt7biEZyPJ3o/7tFBsz1bQyGPj4GUZQI12hwuygXyr5Yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DB8PR04MB7129.eurprd04.prod.outlook.com (2603:10a6:10:127::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Sat, 11 Oct
 2025 09:13:56 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9203.007; Sat, 11 Oct 2025
 09:13:56 +0000
From: alice.guo@oss.nxp.com
Date: Sat, 11 Oct 2025 17:12:51 +0800
Subject: [PATCH v2 03/10] imx943_evk: Enable USB 2.0 controller host mode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251011-imx943-v1-3-072b9ede2b4e@oss.nxp.com>
References: <20251011-imx943-v1-0-072b9ede2b4e@oss.nxp.com>
In-Reply-To: <20251011-imx943-v1-0-072b9ede2b4e@oss.nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 marek.vasut@mailbox.org
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alice Guo <alice.guo@nxp.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>, Jindong Yue <jindong.yue@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Minkyu Kang <mk7.kang@samsung.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Roger Quadros <rogerq@kernel.org>, Tim Harvey <tharvey@gateworks.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Hanyuan Zhao <hanyuan-z@qq.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::11) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DB8PR04MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e917f21-277f-4aac-c60a-08de08a681aa
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|7416014|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZEdSc2pLZkFmWjFzL2J5NWwyN1NMeE9kVUlrQkZDeG5KVnVHR0phZGNzMDgr?=
 =?utf-8?B?aFNzNXdiczZqRTJ4emlldGdBVElpSGRxRmNwUm9RT0g3SG9hbm1reE9CN3B1?=
 =?utf-8?B?RzBLS0NMd3BoZnd3eGZCMi9QL0JEbUhCbkxmTzhYeDVxZG9jVEg3U1NVOW1k?=
 =?utf-8?B?N3p0dnNyY0VUMHN2UXY3YU1kQjVoc0NRTWFrUzkvbDZaRm5oTnBJancvd1gr?=
 =?utf-8?B?SERpVDh5N05GaXlDVnNmR1JqbWVnbHBWK0dSbkpNL3pWaHY3ak5TWmRLeDRE?=
 =?utf-8?B?bnRQNTJMR3ROQXBPV0lqZ1R0bEhhdXZndlo4OHRKWDgxMkxPdGJScENIKyta?=
 =?utf-8?B?dTI5TnF3c1RnT0VFWlJwU2xZT000WmZqWWRCNDNCZll2U0pMbVprN0tMK2N0?=
 =?utf-8?B?N3g0dFN3aUJiOGpsT2UrN1J3ZHU1SEJhTTlFRHQ2V2dPWEZmd080bFNyRUlm?=
 =?utf-8?B?WExETjBNK2pVcXRGcktscE1GczUzME9GRFJKMCtBTUJnalZwQ3EyMlRVczBP?=
 =?utf-8?B?SnplQXlHeW83TkJBSVF2Z0NsN0xHam5tQ2Q3dk9TQU9rZ1RjaVVqVzF0QkFv?=
 =?utf-8?B?bXZHVVVWbWV5QmY1emd6L3AwcnBFY0c1WTkvUlBua2tMZEdXNy9vNXpSb0R2?=
 =?utf-8?B?a2QwMnhldVM1NVVPSWRmZEREbEVvc2ZOQ2NNTStQOHZsUzVRRTNiZDVHV05R?=
 =?utf-8?B?ZHBhZ3Z6RTFybS9iL1RlenV2WUV6VzNvdXZJMzlUMGtXL25FKzE1Z2pmY1Zp?=
 =?utf-8?B?akxCWDk3cUtnU3h5bFB2VWVPNnVnazJKbDVJUjAwcHFoT3pHcExWN1Z2c2E0?=
 =?utf-8?B?aWVTUGZJUmFXL1Y3bkxyVEY0czV5UmhjSjNueGJQVWNjSW1HMG13czM3VXlo?=
 =?utf-8?B?amtEdlRoTHF0eDNzSlY4ODNNd3ROaVFYRmhWd00rZ3Jxb2ZKV2ZrRCt4cm9D?=
 =?utf-8?B?R3ZHT0l4RFhMMmlTNTVuUVUvMVlnQlZpZGF1cE9QM0h0Z1VubUowRFh4OTZt?=
 =?utf-8?B?Vm5SNzY0UjdXb0E2RmViQjRBZHBTMEw4NmFDa3owM3VGVmZNZk81ZHo4dDN0?=
 =?utf-8?B?WHo1czJIS0piZVV0OG91ekcreVlyYTV4NU9MdVB3MkpOdmlaU2lyaFR2d3JU?=
 =?utf-8?B?WnJpUTFTVklYaDE0NzNpdGVYc3llSXMvSk5QNUhSWU4yd1c0R2RKQjZOVzhC?=
 =?utf-8?B?TmJyWGVkNFcxd0ZIVmVyTTBlRXVGcVZmb2VWTDRpL25yckZtcTBkbUxsSWdw?=
 =?utf-8?B?ZmExUFJsTXViMW1tWUhvWmZJbkFOaTE4c004aHVheXNWZUpDRmg0cTZyb0Rn?=
 =?utf-8?B?WU9JUU5Iejc5NmVNeDRkVUpFZ3lSaDBiVmluVzh0ZE95UUZPRDNwTHpObVFk?=
 =?utf-8?B?am50TjF5SW9OanZVb1J0TmVUdllPZS8vZDRwaHhDWkdEd3ZUckh5WjcxWUNo?=
 =?utf-8?B?aWV1THJLQkFCWUVmOHJDejVjMnNFVXQ3WENaalBxbTdKSHdrZ1pQSzd3ZWlB?=
 =?utf-8?B?dy9vdm9MK2FRVWY4eVlHb0FYQTdUWjZ3M2loZ0VWNWFVRTRWRlY1UGI4NXNy?=
 =?utf-8?B?M29DN09CQjNrSGNpcU9vNytPM2ZLOEJoYU5VOVBCSXFZSVZ5dFo5dnk0S0ow?=
 =?utf-8?B?R0xXYlJlVHVZdElwK0IzV0cwSFpKcTFEZUV3MUVXUEpHeHV5NVo3Z1VkbEt1?=
 =?utf-8?B?aHU1SDV6MVcxQnNmQWNZeldzTDhVNTRZV2tFTmtidVh0UGlCbjFQUURzdm5X?=
 =?utf-8?B?RWV2NFFXUEtOV0xjNEVySnNTQXVLNVNqaEhGakRlb1VTWFVEOC9jSVIzcUta?=
 =?utf-8?B?ZHlFM2tXN0hiaFByU0p0SE15dndEc1BrRUtndFc5dTRJNk5GckdOOUErSlV0?=
 =?utf-8?B?dFlYRDlIeDh2K29jcGsxYUtXc1Z0Z20yNFVKNFhiVmRTZjNDVE05NVVBSjRT?=
 =?utf-8?B?ejdQNWIzdUpTZzlYeGZtanlaOUpNTzlRTTlHZ08walh6S1FIZEJzaGNRQmJs?=
 =?utf-8?B?ZTVkSWloS2FGaDQxZi9MZE5nOHE5bGJOc0draUQ2WXgxZVdhSWxzZGVSVnRB?=
 =?utf-8?Q?G7ev8n?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1JwTHdaR1gwQmRNcm5kR0VXcko2K284S3VUMDJLNU9DVXhsVGZKRElneXBo?=
 =?utf-8?B?WmxFREVzMU90TFdORHRCTjR0cHBxT2txSDduZHdUUGNsazFVdVV1MTdUalN5?=
 =?utf-8?B?QWJRVzdwUEpta1J3R2pGMEMwekVaaHBNNzhXR01mYkJFS1lYOGhpR2FnNzRZ?=
 =?utf-8?B?UjlkbW9yZEF5UjA4c09jNVFjSHkzYnJMcEMzKzRmRjB5OGY4NUcyQ0FtMW9T?=
 =?utf-8?B?V2dyeE0yb280NkJQemZtT1pIb0doNnB3QkkyVmtnT1ZVeEpOT1NlZGZ4SE50?=
 =?utf-8?B?VFNWZFdYRSt2V0U3UTNOYXhSZVVpTUhDdTRFazYyWlhMT2pYYXg4aUw4Z1cz?=
 =?utf-8?B?dzU2S2g1NktqVnVFcHJwVUJ1bFhCMWNXUEFCYlZ2YUYyZmhIWDNWSnQrbFg2?=
 =?utf-8?B?SFUzTVlacFFsbVYvZnlCd1hSZW1xbTlLMmg2QnRMVlpqK3VnMk5CbDBJWlBM?=
 =?utf-8?B?RHRNVWlWQUFnaklpZ1c5MEZlVU1YbEZrNnhEbU80T1dnTkR5TDQzcW5vMFJN?=
 =?utf-8?B?VWNVb3d0eXl4ZGVyODhnb0tKUUlPNXNueU1Edll5US9lWmRZSHRaVlJ4Tjdr?=
 =?utf-8?B?Wk1CNzNTVXpUUzRLRHNONUFEcitxd2VUbWxFY2wzYTg2ZWFLK2xJMUwzQWx2?=
 =?utf-8?B?NnFxRkVPd2VXOHU5bGkyN3lDaWR1WjRYblV6NjR2d0cyS05JdkhxS0Z6OUV1?=
 =?utf-8?B?K2JqazF0RHZSZzBmc05mT3JjT1FxUmpkOGtIRlFvQTlKNGI4dytnVExPaW4w?=
 =?utf-8?B?aUpUWWhBSlVqYzgvYldudmt6Tjl1WUs5YlA5VzEyQzF3M2k3ZWtMTjBzOHFS?=
 =?utf-8?B?djI2TEF2dTZ1VjlLK1pDYW03SllDRFNtTnRzRVJpdG5jNjhzZ1F4SHhpbnds?=
 =?utf-8?B?NWR0eGd0ZW5FUHNDNXhNdjFYekdFKytNOFNRMktzUS9DZUZXcVllU211ZWUw?=
 =?utf-8?B?ZVVxQUZVMjBaK3hRV0lJY3IrWGNkNVM1dThzUVNRejU2OXhoaWdWTGsvcUQ4?=
 =?utf-8?B?WmdQYWYzc1ZsU2hFaXFzbG5hMUhZRmZaR1lGQVcyLzRyZHJMRVNnVUIzaEpE?=
 =?utf-8?B?WGg3RGx6WFcvRmJITTgyRDU1WG1HYjlYRG1FdEZpVjVWSDNJb0dyQlFwbDVN?=
 =?utf-8?B?elM0alQrNVhDT2ZBUTRuWFp0Y0tDSTBuNUJSTFJSK0wzQlQ4czRRbXkyb3pp?=
 =?utf-8?B?MjhOeWszK3VBNDNrOFpjVmFSRmJ2dW42K2phUUlKNGVGaHcvYXNvb1U3ZGlD?=
 =?utf-8?B?b2F0dFpYQ1FuTldWYjgvOHJFT2MvbzRseit3amM5ZjBzT2c5WDJHeVNtTDly?=
 =?utf-8?B?dlUwYWxTZ0ZMT1RLUkVjVHY1VHl5RS82cDZPRDlEdTZNM2RXeGlmZ2JVcnFY?=
 =?utf-8?B?d0MrakJ0WDdLMG1kZm1IeDVDS0NGaVgwNUVYZkg3SUJHaXc4QTloZU5UeWNl?=
 =?utf-8?B?NUdkV3U4WU84bXNzRWxuMURhbXVRSmpzNW9NWEh1bFFxZDhhV3FxdThiQktq?=
 =?utf-8?B?TXVhZmZUYmE4d05Kd25JWVZvOVIzZHdadUUyU3UybVdYamJQeXZJN0Ntbkhj?=
 =?utf-8?B?eWlWRGdaYVZ0YnpOQ0JZYXp1OERkdVRRenEyaEJNVmJCMVo1VFhvZDdybTZk?=
 =?utf-8?B?d1lSZCt1NVZvb2RPaGNwRXd6S3lya1lxbG8xL2hlSHY4YXIxaElNN0UyYmpq?=
 =?utf-8?B?NytSSXhwbjFZY3IxMVk1SDd1YTBkUkhYb05ubkVNOHkzR3hJaExtV2h4MkVq?=
 =?utf-8?B?QUxZOWZmdThQMmZnelk3SVhoVWNxMUxjVFdxV0dqMEZTalE2YkJTeWcwQjNo?=
 =?utf-8?B?Q3huUThFdWRwdEVSY0F3VmtUYUtRZGZlK1BEMWJ0Zm1Mdy8vQ3BjUHBVd0NM?=
 =?utf-8?B?NnBYUklRT0VERk9XTE53aDAzdnQrMVlhU1JHS2RScjc0dzlyRHpLc010OGZB?=
 =?utf-8?B?eTdiUU9ydmJ2aVNzMGF6NHcxanlsV0k3cStPK3k1RkxJa1B6NVBmRTZza0dZ?=
 =?utf-8?B?by9NVlZFdDkvbnhoeEVySGoweWZyZzdaeldiUnZiZlBQOFVwRVl3a2lYOHps?=
 =?utf-8?B?blZDZEd3U1N5MUdaL3RFb0k2UU1LVWdWRklSdmNhaTArWUQ2ZlVObmVLNHJR?=
 =?utf-8?Q?GxFDQO5KwZ2wnks2OITydv3YK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e917f21-277f-4aac-c60a-08de08a681aa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 09:13:56.7526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /cTcUmOfgzOaSCHNxP6crvcOAG3Fq9B78Iwlup0s4Y674C9HeGJl8hTV/2+YsOD89yfeEbY26qbCtBFVf9dtmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7129
X-Mailman-Approved-At: Sat, 11 Oct 2025 20:07:05 +0200
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

From: Alice Guo <alice.guo@nxp.com>

This patch enables the USB 2.0 controller to operate in host mode on the
i.MX943 EVK board. It updates the device tree files to configure the USB
2.0 controller appropriately and modifies the defconfig to include
necessary support.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx943-evk-u-boot.dtsi |  9 +++++++++
 arch/arm/dts/imx943-u-boot.dtsi     | 28 ++++++++++++++++++++++++++++
 configs/imx943_evk_defconfig        |  3 +++
 3 files changed, 40 insertions(+)

diff --git a/arch/arm/dts/imx943-evk-u-boot.dtsi b/arch/arm/dts/imx943-evk-u-boot.dtsi
index 5496385dc4d..e6abe7ed2e0 100644
--- a/arch/arm/dts/imx943-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx943-evk-u-boot.dtsi
@@ -13,6 +13,15 @@
 	bootph-pre-ram;
 };
 
+&usb2 {
+	dr_mode = "host";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	disable-over-current;
+	status = "okay";
+};
+
 &usdhc1 {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/imx943-u-boot.dtsi b/arch/arm/dts/imx943-u-boot.dtsi
index 9c4882f7d79..9b2c1072366 100644
--- a/arch/arm/dts/imx943-u-boot.dtsi
+++ b/arch/arm/dts/imx943-u-boot.dtsi
@@ -83,6 +83,13 @@
 			};
 		};
 	};
+
+	usbphynop: usbphynop {
+		compatible = "usb-nop-xceiv";
+		clocks = <&scmi_clk IMX94_CLK_HSIO>;
+		clock-names = "main_clk";
+		#phy-cells = <0>;
+	};
 };
 
 &cpu0 {
@@ -192,6 +199,27 @@
 &{/soc} {
 	bootph-all;
 
+	usb2: usb@4c200000 {
+		compatible = "fsl,imx95-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
+		reg = <0x0 0x4c200000 0x0 0x200>;
+		interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 387 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&scmi_clk IMX94_CLK_HSIO>,
+			 <&scmi_clk IMX94_CLK_32K>;
+		clock-names = "usb_ctrl_root", "usb_wakeup";
+		power-domains = <&scmi_devpd IMX94_PD_HSIO_TOP>;
+		phys = <&usbphynop>;
+		fsl,usbmisc = <&usbmisc 0>;
+		status = "disabled";
+	};
+
+	usbmisc: usbmisc@4c200200 {
+		compatible = "fsl,imx95-usbmisc", "fsl,imx7d-usbmisc", "fsl,imx6q-usbmisc";
+		reg = <0x0 0x4c200200 0x0 0x200>,
+		      <0x0 0x4c010014 0x0 0x04>;
+		#index-cells = <1>;
+	};
+
 	elemu1: mailbox@47530000 {
 		compatible = "fsl,imx93-mu-s4";
 		reg = <0x0 0x47530000 0x0 0x10000>;
diff --git a/configs/imx943_evk_defconfig b/configs/imx943_evk_defconfig
index 27230ed3207..d308d29a1a5 100644
--- a/configs/imx943_evk_defconfig
+++ b/configs/imx943_evk_defconfig
@@ -66,6 +66,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_POWEROFF=y
+CONFIG_CMD_USB=y
 CONFIG_CMD_SNTP=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
@@ -112,4 +113,6 @@ CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_DM_RTC=y
 CONFIG_DM_SERIAL=y
 CONFIG_FSL_LPUART=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
 CONFIG_ULP_WATCHDOG=y

-- 
2.43.0

