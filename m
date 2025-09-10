Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A04CA101F
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 14:06:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8522E8318E;
	Wed, 10 Sep 2025 16:06:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="SP0DyJJ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 317488319C; Wed, 10 Sep 2025 16:06:38 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on2071c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::71c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAB6B830B4
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 16:06:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aOh9niSqBZylJYwUjPLKSIMccFyhh0JHqsksn1BMVlH0NQliF7qTWUDqaC21aXK6nRqYOxqsd7rsTfzp4S9arEHVtWBLFIUhGuciRmZRGJQmyRKKs8OdBmnBT7dCrJo72GxeR8PdrHIPTm9CoKQTgx1wkE3NwA2xRkGhbn53H0MdttnIVdOT7sRqkIVbIQxXHCe3SQ6nILbjzChIS2SeyyDacHUlBlJFEUiaUhhY/cXp8bX+KvsDoAC1wRpa4tG4cpILEeqjgyIl7kl4pAQlGArMXgE3kpta2sW5+cszTp5H4oxTAiFJ5HwMVD/xyW97HevU6O7uaTRxBrWfsQA/WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BklGeOfqaJ/wzCmOM/G4EOmkri3zqlVY0ZMCU0o4qzs=;
 b=Pv+X5qKH8dBosbzQizqRLYTdSeogmhgIwppIdy/e55Sm1HouD2x0SJ2zLjmXBGhl1xbMCoPucchpPSMkNGQujOv6Vo5kyh7MdkTLU5U3l4xeepWfe/zwF4SLs70VENcIXrnWSm389ohJ1rShabX7KCIVYlMu55egTkT+TiB70jBLVqDkgXvCqnoAjzYZatB0T8vB1MD5IGZ4BaTkN4G3A3H7lfK46TAJSoK0Fuo//fMd/5aNLfd7duYkjbTzqm2FkmdlaeNnbEt5v0vgMN7nb+IP+opdIRCoXQugkTA+8FwO1U/TTX1NhU+woXbBOCWYZN6ldHc/GlZgLsR2rePaNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BklGeOfqaJ/wzCmOM/G4EOmkri3zqlVY0ZMCU0o4qzs=;
 b=SP0DyJJ+aZg+I0n594FnXvlyx/ZVZtVws1iHNXILaaAttyeAp2snC99q/bZU86r6Dgj1E7N8yC+x3g0V2ZKSGI8SMDvfZ8f6CiyxyFtFErXA7pTXoQ9zuAjfXRTB6yfC2fA3LdCcz+itu8tugrlWQ7WdmhXxQCOJqF8sKOd+TPruqpzKFx6ceLc7u4npyBps1OC+6etFq8eLOssbqT57bvwFsp//UexGKTwySS0vEqb6oUpYr+hWg3CCAR//Kkm+9J3QuVhuNNxakYddUOozkwqf6mf389QoIafaEpY9KgeyTv2a1VkQ3ISockBq6e1XtvQA+dxs6AETq3ywGcfJ6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from VI0P195MB2484.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:248::6)
 by PAWP195MB2446.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:368::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 14:06:34 +0000
Received: from VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 ([fe80::24f:8371:2871:5981]) by VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 ([fe80::24f:8371:2871:5981%4]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 14:06:33 +0000
Message-ID: <50c51eea-af1f-48ad-bb15-eeeeedbf9bf1@phytec.de>
Date: Wed, 10 Sep 2025 16:06:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: mach-k3: am625: Unlock MMR registers again
To: "bb@ti.com" <bb@ti.com>,
 "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "trini@konsulko.com" <trini@konsulko.com>,
 "s-vadapalli@ti.com" <s-vadapalli@ti.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "c-vankar@ti.com" <c-vankar@ti.com>, "kishon@ti.com" <kishon@ti.com>
References: <20250815160240.3575140-1-d.schultz@phytec.de>
 <63e0078fbf5cb045b79a441dca0f2f71fd3962e5.camel@siemens.com>
 <d47cb78e-e3e4-4a65-a0d0-b7dbf22e7339@phytec.de>
 <20250910120815.ifbg5fndnaodopvt@bryanbrattlof.com>
 <64f1a6561417bf7ff9d8e92ea69e1ef842bd2055.camel@siemens.com>
 <20250910125335.orpc2lrm2amncbwg@bryanbrattlof.com>
 <ae14d825d76df8b65cf82ac78a43aa0c47689b52.camel@siemens.com>
 <20250910132609.bfqpdflcgfbtouq4@bryanbrattlof.com>
Content-Language: en-US
From: Daniel Schultz <d.schultz@phytec.de>
In-Reply-To: <20250910132609.bfqpdflcgfbtouq4@bryanbrattlof.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0104.namprd04.prod.outlook.com
 (2603:10b6:303:83::19) To VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:248::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0P195MB2484:EE_|PAWP195MB2446:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ad05c75-9b53-43b0-3d9b-08ddf0733f5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWx3NTBlam9lWUlRR2N3Zmd1U0hnc2o5aDdsbFlBS1JoWVBGKzZRQU5XR1Fx?=
 =?utf-8?B?eUdJMWFUamhFd0lkVG11dC8wUnNFaTYvUGhoVmo4aEFmNk4rYVZvWGRPVGF4?=
 =?utf-8?B?eHVIdVl6bjdXRmpDa3NNV2NSMmVkelpSRDB0RlBrQ2lycDJrdkFJSFZqNldZ?=
 =?utf-8?B?OXFWR0RGM1NvWmVjbzJJVGV4YUVJQWh5RzNIRy9QMWxXS1MyaUlhRzV4UFow?=
 =?utf-8?B?NjBWRnZzL0l4Ty9raDlWVStrKzd0UWh5ZEVDd2huK0xJQi9mSXlKV2RQWS9s?=
 =?utf-8?B?SGwxMzZ1b2oraFhTZURsTy9acG5GTVNlWUlpdSszaEk2NTFnRUdmMzYwSXZW?=
 =?utf-8?B?cy9Wamllcjg1TnRYVDVkd2xVUVZJNGFyR1ZCdG1YdzBaMjIra3EwYWpTZzJO?=
 =?utf-8?B?b2tVZ2lDbGRqQWUwQWV4L2NIUDZnMngwZk5tV1JOQktNazUra2xVOS9PUnVN?=
 =?utf-8?B?d3hVeVFqYjM3OVAwbVdUTEFkOWJyMC9icWgyei9obmxDY1pwZXZoQnFkREdZ?=
 =?utf-8?B?N0RjdWVXS1RUSkhsaWpYM0dBL3YxcUZLM1h5SUtLc2YxR3Z4VUIwa050QWNV?=
 =?utf-8?B?b05odmNVTXJ5WmZUVGhwZXJhQWY4UERxUnRDSU9KdlM4RDJOaFU4U1Z5enN3?=
 =?utf-8?B?YTR3dzYrbnovNmg5VktHRG11aHlBSHNNL2tjRFJwaWNpQXUzelpmcFhhdmpY?=
 =?utf-8?B?aUJEMHUxNk5WV3lIM2ZtYjdGdGpURTFMT04zb0lNUXBjczBFTUswL1R3cjJK?=
 =?utf-8?B?ZkJBWnlMSHRtRE1iTE0xWXZDTytEYXN0eEsyMlBtYTdvOStyUWpDQzh1SFVL?=
 =?utf-8?B?SEZQemVVWVNrSU5CODNNNVd6RktVRUlnSFZscHR0SENlOElpaDJqc2QrZ3hQ?=
 =?utf-8?B?WHhjbHBXL2ZzaGZDS3lQK0hkaElUY09idzlPVmw3R3ZMT2paNjJ2NkdxcFAv?=
 =?utf-8?B?K2lVbFhEd2RVWG5Ta1BwNG8wTGQwZklkQjNXdFAxRzQ2MnR6TExlc3NpV2pX?=
 =?utf-8?B?QnhOaGpERFcrZEdDWEg0SUIrRXdLNzNlZ1pQQWJMWlF0S1NDb1RtR21icDRy?=
 =?utf-8?B?RUNaeUpaaUJzZkhpNWRIZWJWY1F5UEJnV0IwK2k4dzdHdzA1QVNCZUVaOWFD?=
 =?utf-8?B?Unk0ZGpheTVtMHMrdFRya21HL0g0RWJ0NE9ma2pZRE5POEQ0NmIvWTcyK1BY?=
 =?utf-8?B?a2tDZEhrZUdVaUZmZnFYZFV1c2w1SUMxNlZiZUtid096aFpRcmF1bUtidDlT?=
 =?utf-8?B?WVhkZ3Uva25vQ0lKMmJuUUlYN0ZmQTYxMFJ5RlQ2U0I5Y3NMZFZnWU5ac08y?=
 =?utf-8?B?V0grYUdxaUludThnSHQ0dWoyYUtYWnFGeEs3NS9BK0JxdUgvVHlIMEF0SDdT?=
 =?utf-8?B?RURBd2tVZXd1bTV0SXljcHdwcVZma3lGODdpZUZxaDUwajZqTTAvWmR5Nk1t?=
 =?utf-8?B?TW1WZnhCRjV3QnludkNxTWpqVEhHN0w4L3NvWGt3L0JwSG9EMkt5N3F0dWQ5?=
 =?utf-8?B?VStKSE45OGx1SXQrSXV2SnZzTlI4V2FnSGhNUGJldVA0ZjNBNHd2NVdIOUJY?=
 =?utf-8?B?OW9RV20zcmNlWjJDVTBrK1kwMDJVZ2RMditpTHJseE1oVVBiVlBudmpIOVlm?=
 =?utf-8?B?OGhsNTRYSFZJd1l0dEEzb0ZYRUhCYjRGb0RMVzFQeFpIZUJwcitxSHI5c01y?=
 =?utf-8?B?ZGJkYTZ1RWVRczg0TTVVbHBKMWcrZ2tGdVE1N2tFejYzUmFHOUhBL2Ryc3Bn?=
 =?utf-8?B?eFZIa09mMEdxdlM2UnJaeGdQVXdmVktTVGQrWVdJYzNLanFxRUxlU1hUdzky?=
 =?utf-8?B?RkdPdEh2L3RRVUxhc3RKZXhEc3FLY3JQMm9ucHRNdkk0TEErcERRSnU0TFUv?=
 =?utf-8?B?RnZkU3pXMEdpYWErV0RXYVJ2MlFIS2M4ZkF2NEJlejlRRnRsMjJ1bkkzR1ZZ?=
 =?utf-8?Q?b2IGSIHaHyY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0P195MB2484.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWNzbTNNQVN0anVPemtPazVVUlg1aGg3MFVhTFVPZ1UvTHBiWlFnQ3JtVHF3?=
 =?utf-8?B?UWdCbWVzbU1xRTc3K2JFa0tNcWp5S00va1NiMUp0Z0ttb0NlVFAwZExnNmR1?=
 =?utf-8?B?MGV4VG9vaDZZZ25qTm5BSE1vU0tSenpkaFprL1g3YStpNjR6NCswM0JJaUVT?=
 =?utf-8?B?dmh0UWRxdDRaR0ZNcGpsRVl1bnBGSkhrVUtxOEZpNXpkSXF1b0FVL1FNYm1R?=
 =?utf-8?B?Z2ROUVRGNVd4TDJvUUMvNUx6U0xsaENLTFZydVc3RXpiSGU3NVNvOFJxc0Fr?=
 =?utf-8?B?VmV1NzdFbVRQdWhQWWlhblJDcnNTZ1pyUDJEWlcyL1dGUjk1TmdDS3kwZUN6?=
 =?utf-8?B?R052MVRDd3hDVjhjb0FWOTBkMjY1QnhFeG9ZYjdDMHB2dUdZREZzS2M3UGVK?=
 =?utf-8?B?bHVuWmV3QisyaFdwZE1XL0ZGVWR1ZkF0T2o5dFZJYnlOS2VKOHJxMnRhcmJo?=
 =?utf-8?B?c3V4YU1jdGNYdDBHdm9NUlZHemN4NWdZZU9HRWNMVVRhL1VKZVpRZngrMGJ0?=
 =?utf-8?B?V1MzMXJkY2ErR3hybXJVNnVZNHpYallQR2dNU3dOZnc2RkFzMnpUMDdBSmtG?=
 =?utf-8?B?QStWbjN4RU1wUWNMUDhoWG9LLzh5MzQvcUxTNnNUL3pKa1gwZ1pLeXRpTmg3?=
 =?utf-8?B?c0xmY0Q3MjFRbXdnQkVaVkV4SlQ0UVNwZTZmdFNFRW1XUWFnMG5xL3V5aWw4?=
 =?utf-8?B?RUFPV0hpU3J3b0hodmxjME1uL0ZxMUNSc2NCTUVHeHAvenZ2S2dwQ0hFbVB6?=
 =?utf-8?B?YTBPUCsrZVorQUN4eG1IR3F5RUxDNjR6Wnk5Tk1ObWNuMzJxZXR3eEJGL1pU?=
 =?utf-8?B?emp4eFJ6Y0Y3cTJ3TTVnZ25zUXQzZmtuVkVPUnRseVlSVG54TFVCNHovRCtH?=
 =?utf-8?B?SG90Y2ZNbUtWbHlsYVViWEUvbFgxY251NXVHUm8yQmozY3BDUmQ0UjA5TXRY?=
 =?utf-8?B?cG91amZOcHlvZDhrakVTSEVHUUlBMFNBeGtuUXdJMTlVN3JZRWt4VVdCZHNF?=
 =?utf-8?B?WXU5UUdiVmpHdWUvVXR0Z2ZkRS9UZ2kzUnhBaWhzQmJ6MjFtNEVMZ2pQYUFL?=
 =?utf-8?B?R0VHOTMwUm5TL3JNVGgxaW85WlFVem1rVWN3ZmxpZ3RLRTBralBhM3Y0VTVC?=
 =?utf-8?B?U1BrbEhJVzI4a3RIR05UTC9Xa0J1bHFxa2ZmSG9yTDNNdEpBdzNUYUs5Zmlm?=
 =?utf-8?B?dnRaL3c5dXRkZ3ptNW9WT3FyOG1UaE9jdk1hOE5ZVmtaRnovRVlNWDFZQXpv?=
 =?utf-8?B?VHdydHdPSlUrSGNLbk9aOGcvRzVZQis0SnEvRlhhMEwybTJVNUNyZkNiQk81?=
 =?utf-8?B?eDliRkhaTmdlQU91WjNCd252TEFYR2hVN0RWSVdlUE15cVBWQldmbndpWDRX?=
 =?utf-8?B?NmNjbVAzTWFxcXhrd21tWHp1amR0VG9sRXN5Uit2Vjl6WDY2eGxGWnBRdXdk?=
 =?utf-8?B?TVlBNGd1bVlhaUY2Z2Z5bE9EM3RacXg4QUZ6TzRMOVIzY1hlb0V5TGRGZWNy?=
 =?utf-8?B?NHlySngrRFA0dnBSNmlaZEJxWmV2YmlWdXlvNmdBaXRFMEpxeXI2Q2lBQUtZ?=
 =?utf-8?B?aVl2V2tOTitLZzlwdzJZZWJxVDRkbGVvNTlwR3hiK2FFMXpENVdSUWYvOEpB?=
 =?utf-8?B?L2RDemJIRGUxMUZtSVJPSytIMlZTczdrUmhkNkdSRS9PN29QNGhtWVZkUnVB?=
 =?utf-8?B?cHBFZXVaMXg1WHhiTUNqTU5OdmVjOTdYUXptdlo0WTl6dmZIcmhuNk5jU1ox?=
 =?utf-8?B?dDlqZitWYVVTMTlIWUhBR1dzaWV2SHVPL29DRG5aZG5aeHlyaHNMSUpwWjha?=
 =?utf-8?B?VWEvY29JdUxwYkVyTTgvb2lDaE9GQjJHZzdsbjFhbkhHUTRWaFRORXlHaDdx?=
 =?utf-8?B?ZjExVHpCSDFhRVRhbUJONDVlaEhYaklIdWFyTmtCMDJwNzg2SStKS3VoMXFp?=
 =?utf-8?B?Y3ZpVTlRRmNXVUw2ZkpMYkJ2eFprRndodHpGMm44MmJDYktuL0pNU3gwU1Ju?=
 =?utf-8?B?YlBGNTZqbStmQUZQSUNFd21HUTI2eTZId1hGZTQ1QW96S2FVdzdFVjV0V2VC?=
 =?utf-8?B?aStFNDZ2M3M4cEh0MDNuUC9qNTlpZlFZY0lVTmtqSTNGaU42ZFBsUEdSK2th?=
 =?utf-8?B?dXpaMXYzeFVxN0pnU2J6M0lMdm5TZDZSVUZ6bWxMRnY1MlVLTGoxcWU5dEhE?=
 =?utf-8?Q?sxFKqdB5a/NJDviL86J0fJ32CNOX/skh9IIqDDYq85Iz?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad05c75-9b53-43b0-3d9b-08ddf0733f5c
X-MS-Exchange-CrossTenant-AuthSource: VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 14:06:33.5092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +JLQxOv23brgotemxXfaN7LWIcWO3WID+KtlGdmwxpBMEou6a+VVq38IievgKREV8sErbECmNKvjnqJBjSpOhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWP195MB2446
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


On 9/10/25 15:26, bb@ti.com wrote:
> On September 10, 2025 thus sayeth Sverdlin, Alexander:
>> Hi Bryan!
>>
>> On Wed, 2025-09-10 at 07:53 -0500, bb@ti.com wrote:
>>>>>>>> The watchdog requires to have the MCU ESM error source enabled to
>>>>>>>> trigger a system reboot. When booting HS-SE (security enforced)
>>>>>>>> devices, the MMR registers are locked again and all write commands
>>>>>>>> are simply ignored.
>>>>>>>>
>>>>>>>> Unlock the MMR registers again to successfully enable the MCU ESM
>>>>>>>> source.
>>>>>>> I'm just curious, could you please elaborate a bit, where the registers
>>>>>>> are being locked again if they are being unlocked by ctrl_mmr_unlock()
>>>>>>> in board_init_f() before enable_mcu_esm_reset()?
>>>>>>>
>>>>>>> Is it TIFS firmware?
>>>>>>> What else could be affected?
>>>>>>> Do we expect to leave General Purpose Control Registers unlocked
>>>>>>> when we return from board_init_f()?
>>>>>>> Does it mean that the whole ctrl_mmr_unlock() has to be re-done
>>>>>>> after k3_sysfw_loader() call?
>>>>>> I really can't tell why those registers are locked again. I figured out
>>>>>> they're only locked again after loading the TIFS firmware on HS-SE devices.
>>>>>> So, I also assume the firmware itself locks those registers again as part of
>>>>>> a secure/security feature.
>>>>> Hmm yeah this is likely a bug or a config issue. Ideally we
>>>>> (U-Boot/Linux) should be in complete control of when these are locked or
>>>>> unlocked. TIFS or DM shouldn't be anywhere near these MMRs.
>>>>>
>>>>>> The A53 SPL will unlock those registers again, which will be permanent. Only
>>>>>> the watchdog is problematic because enable_mcu_esm_reset is currently only
>>>>>> called in the R5 SPL (config only enabled in the R5 SPL defconfig).
>>>>>>
>>>>>> BTW: We have seen the same behavior with the AM68A/J721S2.
>>>>> Hmm this is strange.
>>>> Thanks for your assessment!
>>>> Do you know who can be contacted at TI regarding this possible problem in
>>>> TIFS firmware? Maybe this has to be fixed in TIFS firmware indeed?
>>> I've started creating some noise internally to see if we can debug this
>>> faster. Most of these teams are fairly insulated from the outside world
>>> and can only be reached via e2e tickets.
>> Thanks for looking into this!
>> I read it as if we would not need to create an e2e ticket for now?
> That's correct. I short circuited the e2e process by creating a bug and
> messaging a few people internally to jump start the process:
>
>     https://sir.ext.ti.com/jira/browse/EXT_EP-12916

Just for reference, I already opened an e2e post some weeks ago: 
https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1511852/am625-am62x-hs-se-spl-cannot-write-to-mcu_mmr0_rst_ctrl/5813164#5813164

- Daniel

>
> ~Bryan
