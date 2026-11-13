Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD04606E226
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 17:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YYvVBg3e;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=bODaW6Fw
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0250040B1F;
	Fri, 13 Nov 2026 17:16:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qXJ36zDsp8tD; Fri, 13 Nov 2026 17:16:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5272540B2B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794590165;
	b=Kb/curE3pkcQLTF8tIoUOT5gqPUJUPt+a1cv5ybSnxYYmQbtxQJS1OSY66oSfBqa/blk
	 ZVrqGA0vdu2BalVhLqxTnoB7/oOeVL1nWvoCHiz2GWwZUJCuhxS5+cbYAAW4cwc4OI6Cp
	 Hw8tgla5vQqtm6gS6CKZ29gHL9UprTlxq69AiYmgGcXke14oJ+6+HdtNJL47Ny6WfQFCT
	 grM5iw4Nbwv7F5mcLWbES/NLF934p6XTEnIJlBQmmHFNw8/6FL2Upka3cRTmmXz+TiIWB
	 n0/sIZGLLJFwkeDmsVaHnI9QOKrVwlWt745Danb/f10Pq03MkqTCyUuiZa2bEXX6NRA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794590165;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=aEVVWISLNPvSbT/B6VPFVJ+VhuxWdxL7hnKCOGRBj+8=;
	b=k4cBwncazPazKisEGbjB6GM48zOG3zYwFXae7aTo93snM8I0zztVixsk0JBxngLRinNh
	 Q0pIcW6h3jGYgF8hwbDtgLX7fR11fsBv04zRHDvUcWEn0rgvYjwgoc3SWUf8ywYc67K/r
	 VhSJu12gVkeBKGMIoet6AUnLeKks+A+TNUSGeCTp+3DSP4xuxL2OTla6u7Iz8edIai/A/
	 ddr2pvsVXv9uGNJ1rvUFQkZMCpH4Km8uyQ5coIRKlpvkuZ2Ut605Lz9xRL6f1h7d+mbMH
	 vfEmBDCegi46c83ST1Wf1fsFQkd2H/DX7EaIXUpBnWUiwxqHE3U/eTWIJZVYuyPemHw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794590165;
	bh=aEVVWISLNPvSbT/B6VPFVJ+VhuxWdxL7hnKCOGRBj+8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YYvVBg3ezHayvpUsMp7GddtzJgMwtxEZMPHbaPSmT/BDAHFBrUx+uUXpc58lJlzwz
	 ahVuR3SBeTRw0JOeSWhTNTeQr56x7JDtK9jA4zWyYr9b3AU8w4bthDGO6cXC1cSTds
	 bFA0nlsqEnTNg/NTGeVohWVPA2Q07ysOFaxs7qX5xraXkI76s//L5xU1iikS8uHpDo
	 Bd4TOw7c7dA0L2nOPf2H327YtoTFHn/cMOl4Ws86tFYdzDNiPLBSiCOpsBbjYpS8zw
	 nYx9lhxurFxtWzDP8CvnBGl1K0XZCNCTPECTO1dA4IELzMrslDBeX7Wzv7ZTS8/Ory
	 swfAwWRzovqwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5272540B2B;
	Fri, 13 Nov 2026 17:16:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F1B61A6
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:16:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7F8C0606C7
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:16:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4qsVeW9kjSP1 for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 17:16:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A68A560669
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=bODaW6Fw
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A68A560669
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEVVWISLNPvSbT/B6VPFVJ+VhuxWdxL7hnKCOGRBj+8=;
 b=bODaW6FwBftNl+AAfA/VvmawznU0Ueb3YQ+a7NYQhz4RSOr+aXcPZPZQ6HlyYnjkNWq2/4ha8uQfJLziK679FMm0QppLB00KsvGAJ7kEHOci4aRnC2q51aJcRDcjNWR12K1J/wMdNBNPOFLdFXqApWVgkYstpqa1O2qBAFHBYV4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AM9PR04MB8538.eurprd04.prod.outlook.com (2603:10a6:20b:435::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 13 Nov
 2026 17:15:59 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 17:15:58 +0000
Message-ID: <2e72e5bc-acf0-4294-a39f-f523854c2483@cherry.de>
Date: Fri, 13 Nov 2026 18:15:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] clk: rockchip: rk3588: Use GPLL rate for CLK_TSADC
To: Jonas Karlman <jonas@kwiboo.se>, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>,
 Jagan Teki <jagan@edgeble.ai>
Cc: u-boot@lists.u-boot-project.org, Elaine Zhang <zhangqing@rock-chips.com>
References: <20261111231251.160051-1-jonas@kwiboo.se>
 <20261111231251.160051-2-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261111231251.160051-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI5PEPF00000937.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::828) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AM9PR04MB8538:EE_
X-MS-Office365-Filtering-Correlation-Id: 1de04ec7-d443-46bd-57bd-08df41a9c877
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|4143699003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: C89Zi/xTo2fs7TNQfB3/+Fe7EyD9pxO4SaoP5wnD7pnUpUCnyCbpCEbBvAgrvpQjf7+48EJwYOzg6s3R1dLFrPyuPge9vxwAQpzSeB5ZzHZ2FVAkU9plWUJJHZMEaPCJS/aaPOvyV9F8kC0T0KtJqzNCWm2QB/+8QAd9WyKkyvuNLWcNwfdyvXlxJU+h0OiNpLlJALp3HGD1PdUbFk/6MP4az3ZKrHxol+CYkh9u+azLggviRGeb8zx8VIo6Qlcx7X6qBeXyxpeBq5WGH73bQ+3A45Odpf1mQgLbldWwzZGa0fzauNxZ+SMh6ZsVw0nThHk6lp76cm+8i9cGHo144or9+FW4cOjQd0V1yp0G2RZ0fjFy1HMuwsnR0SKVukDYU3xkmTQK6dsUbN1B9GrXQk6j3zxm7BJqZ8X/Bc5LpaenrcU2aJ27Ww+wNCVRK3dGBv545XzVhrAbIQgMB+D8B+iVGAAaChluFbo3DX6+g4pV3OrwXV8+Kpl0mmlf19SNZo1zYbrkyUmVQ84yzK+U59sF2DhaFZ8A6/5GLqhFYftR1/Fc+WmyDh4TE693RPZMxOwncqaLULlJaYSdM4yodM2210G8fKG1JdB1c4Wz/cuNdei0nX+5CXO0u3os8VoVmZ//J58t0UwM3TpODZ3nEyfd72weKSbYkdpYrXyEXiw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anIyU2pzbEhyRmczWW5zRjRoaFJuTWYySEhmUlQyNmNCMlRQRnZicURzdWFP?=
 =?utf-8?B?QWpUYTZ2VnduZkwveVUyeVpQT0h1dVQ4K0hsUnJROEtrZkQ2YnZkSkFuSjBy?=
 =?utf-8?B?Q1BYY1lUTjJieUdqdE5yOGIxZ1lRRmdWc0VnVysxT2s1dURNUGN0REphYmxD?=
 =?utf-8?B?cEJEVDgwMHlLbHNMQVJvWDNLbkRjQU8vWmVnS1JtMjZvRWJhRjBvYzgrdHhy?=
 =?utf-8?B?M2p3K0d5amhJOUxrdW9ES1RzM0E5VlAydnJ5RlNPR1J5c3pVcGNWM2ZkNEZT?=
 =?utf-8?B?OWtMTnRNOS9BL2tuUnkxY2RzTFVhdW5ZRS9FeTdLZnpWb2lkT0srOEtNZmpt?=
 =?utf-8?B?dkdFUkkxL3gwSXZEYmNWbTBYNGtDMzBUT0JhZmJuM2RncWRka3ZVNklZc1lJ?=
 =?utf-8?B?UGpqNkFSYXhCS2pHQityWm1RU2Q2QXpuYW11WVR5MUpENzJFV1pUQXlLQTRC?=
 =?utf-8?B?M1Ntc3ZDcWtpS0ZJK1J0YS8xbjBxaW15eExCeU1CYUl3VjBLaEZhb3lOTHU2?=
 =?utf-8?B?VGEwY0lPb0ZQZ3V5eVBLRjQ3d3NJcVNUa0o0OXBiZ2ttaktiYUtoZmR0MmR2?=
 =?utf-8?B?eGxLQzM3NitxcTNPYkhwRCtyOVExSGljY1JEN3IveHlCa2dkTS9pblNOU3Zq?=
 =?utf-8?B?a0ltWm0wTEIvVnFrVEhqSHFicFBndGZoY3lyL2tOREtwcjdpSzAvU1ZTTGEx?=
 =?utf-8?B?VWhYRVY4TEQvM2h4cG4wMW42d1NabXhGR2VGa1hRZVBJdXM1YklQeEFUcmww?=
 =?utf-8?B?eEpPUVVDMVJudmxmMGI2eWRWQUVGSXFLT0QrRHFNaDQ5NlArNFdtNkMzZ0Mx?=
 =?utf-8?B?WUVhbUVnWTBzdThsVm0zUUprTjQ3eDdRRVExVkFRRmE0Y3hNc2gzeGdxUVZh?=
 =?utf-8?B?OWV2OFZzVGZvVmw0Mk4zd2dKaWtSQVo1RndaSW9DNVhSU29EQUZSbyt6Snl0?=
 =?utf-8?B?ZDU5SVlnb0xVTTZDTzljY0ZvSFRSKzVDTWliSC85OWxpWlh6OGVPWThTRCtS?=
 =?utf-8?B?aVozaGJ1RjVDOUJxRCtXdWNadW0xeGswaGtHS255Y0Y4YVRlSk5MajVHbTRN?=
 =?utf-8?B?WmVnTVdqSldLaElnSnlIK3FVRzFUNUU0N28xaExBZFBGbE1CREwraEcrbE1N?=
 =?utf-8?B?Q2E3QmhsS2dZUDJsMjNIMW1qdDVYelpFOEp6S1hCYWUyYlA0c0ZRR0IrdFVq?=
 =?utf-8?B?aDNNeUNhbDlVMkNrbnNlQmhqcXFtdUQ1VUlOclZVeG9GVk8yZWxKMnRjNGFT?=
 =?utf-8?B?Y1FBSlZkM2ZSWU1od1FOdWxKbTlxc2t1N3VMcmh2cXlrcVByMzZXdGdaVUNP?=
 =?utf-8?B?Z3JUbStoU2tRNHYvSnF0ZlRnWFRQNmJ4OU9hMm5TU1B6Ykx1TmluZ1ZFYXBH?=
 =?utf-8?B?UCtZRGhoSTRVdEtGL1pKOTJuc01lZ3J4U0xPQkJYMEI3NXRXY003YUVIV2xT?=
 =?utf-8?B?WlE0MkpHYk1XUHVVRDZxaWdGMGNlUmFsa2xlSUY4SEZFNjk4cHRJYy9XUFI3?=
 =?utf-8?B?R0ZBVjlOS3FpdVovcFFvYkRid1hWU2hNejNTU2hRUGU2ajFnVUdWb0tMSmZt?=
 =?utf-8?B?clRXWWZmbGpzMkREdlVGZGoybUFJTXAyYVR6NWoxNURHR1pFQnROa2dSVGV1?=
 =?utf-8?B?aE9vRHJXYWN6eWMvaUJmazRDSkxyN3ppS3lpRkE5MmlnbnN4MXhvMk9xWE01?=
 =?utf-8?B?WTZvMUEvWjdvdzFiQVdablNORU82TGlTbk9oYjdZUmZSN3hIUEtsUWtGclV5?=
 =?utf-8?B?djlTbDFGTlZtVDRKQ2J5RXpmcWVVNEZ2dnN1anllZ0lnem01Zy9hU1QvdWdN?=
 =?utf-8?B?Y3ZSR0NudktBS0c0YnpYZEJKbUhxeFZmZEZ5NDl2Sjk1ZnB5cEpoOUFGYm1K?=
 =?utf-8?B?azE0QlMvUmVOUk1oQjRjKy8yblBzVnEreGhRcHcwaDV6M3NQSWREZDZGK3JM?=
 =?utf-8?B?T0lDVGdZY013NVhIMmE5S2pkZXhTaGFrbHFCY1RVUk8yeXptbDhnOHd1RG1m?=
 =?utf-8?B?b0R4dTl6ZERzVEk0SEZ5Zmk2ZTRNN1llb2lYVkRkaUJkM2U0YlRDdm5IaDlN?=
 =?utf-8?B?L2dDWWYxSTR6RUFGbTFzN3Zyb0o4MTk4ZkE4MHdzOVdLQURuQi85QzB1Szdo?=
 =?utf-8?B?enk5QUdCcWlKOWZzQTAxZ25FUU4rbWlwZXBMN294VXhHOVducnpWMURieGF0?=
 =?utf-8?B?REt4S0RGVEUxN3Y3Ukd5ZTF5M1BuTmh4aW9rdXhjQjhGTDlvWEZxZzcyeC84?=
 =?utf-8?B?dUxFdTFxYmNYWStwejJkK3JBTkJzZ041Y3JCeGx2cXVDLzMvbjgvSk5Uc3pI?=
 =?utf-8?B?NEpJOG92YVZSck9IK2JjRE0zMkx5YjFzRlBZQUo0aDVVOWE3MVNOZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de04ec7-d443-46bd-57bd-08df41a9c877
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 17:15:58.6054 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z14ujQk7jtfL+b8dsdBrwJajUlWxNcltw6f/YW8t2g5biueJs7zYoZX9tjhUvkkiRvlRCLP4ro1MXeRAn6EiBuZCZKPrwx1QKQNI8r0kKZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8538
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jonas,

On 11/12/26 12:12 AM, Jonas Karlman wrote:
> Use the GPLL rate instead of using a hardcoded 100 MHz parent rate when
> GPLL is parent of the CLK_TSADC clock.
> 
> Fixes: 7a474df74023 ("clk: rockchip: Add rk3588 clk support")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
