Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24D0D2E9FF
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 14:43:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 311D0890D9;
	Mon, 11 Nov 2024 15:43:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="nplKPIIm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3005892A1; Mon, 11 Nov 2024 15:43:34 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::62a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCD7988C4C
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 15:43:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfQhtO4oY18l1hM5aKI0vNnG+1ywrM2Ds7SOX/E/fyFEI25KdIIrkYviH3nfuauRYmCPPkkqTFyqEj6VXR9kwaJRMyouJZPpysmaT9oMqNQKorMeaIVHwoReNiAmFUAF1ZHPEq+L9xpoACLvv0ZYqbLnKjDEuwKSpZaBo0aHHoxjQF0BYgNtAyqBX217hR6J6TN7gbTx+CfnT3BSNiKc0/uCQyJH8Vi5m/4JwwARbqxzwL1knE95OsoxcB7husnrW8XKblkcI9z+xlhOwU9VZ26/ATaR8yhasX3dcF9lcQAEg1UhoTEqL/PuIy+fcgG9tm2topms+JadAM9yXlbNPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3epbz9eLPv/kh1gCqe7pdZ/p3XL1BxOb/TTfGN2G5Y=;
 b=YGpkI265l/TtgL7RhacmsDywcwmY2jo0a1WYQtBWL6fw0P5lz2fYYChHG4IrBXKlSsAH73P7d8yQbA+bK9ztL4fkJ1ld5WzpeXxwjZT8XhyttD2Rm1aC96Kihgz3/5MVvwTYXTuRPWEoEQ2dV+OIVuaXUEmVUjfpT4OMsixD8EWTuJMGlnlfwB0gccqbkJJN5EQpXbuKp1q/jrPcPbYY7W6SeFoefnz5SdFMaDSHc7ft7AL9RwJ0yqmDKS3LoIa/B1bXZg5DLHN2mBCruCu3LW5zPizkU1Zi+aFM91M/HeCFK6puQqD0Ol6vuqywhjDYjvQuYrdGLOhbou30HErMiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3epbz9eLPv/kh1gCqe7pdZ/p3XL1BxOb/TTfGN2G5Y=;
 b=nplKPIImr2n2Ac/v+hqwVHR+fnsiNOElWPhwD3/3cm+NBMzuDiU4eZisUA1voBgKuqKRw+5k/3NgE+Clfdw3z7+6fUVYH9rhy8WPrKzr3BA1IbX8OcCavwzASzNpLVV3WHqqOHQCIkfE7B/M8xWrMlJths58kMLjZkfmTvjUW4M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM9PR04MB8970.eurprd04.prod.outlook.com (2603:10a6:20b:409::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 14:43:30 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 14:43:29 +0000
Message-ID: <2dfa3ca0-346a-431c-b412-68f5ca1e2d8e@cherry.de>
Date: Mon, 11 Nov 2024 15:43:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Makefile: fix empty MK_ARCH when using ccache
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <foss+uboot@0leil.net>, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjd@chromium.org>, u-boot@lists.denx.de
References: <20241111-mk_arch-ccache-v1-1-e27f5f605bc4@cherry.de>
 <9883B8AA-CA7D-4A59-ADB0-ABC86210273F@gmx.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <9883B8AA-CA7D-4A59-ADB0-ABC86210273F@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0433.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::15) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM9PR04MB8970:EE_
X-MS-Office365-Filtering-Correlation-Id: 84d21e49-91cf-413c-e0ba-08dd025f34cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UFZrQ25wSGNnOFNjd3IxQ25Id2JLMzN0bzJZQmRXb21JNjQyTGVFcjNQWlJn?=
 =?utf-8?B?WDNtS1lYbFNKd1dEYTAyT055SHNvR0I1SmFUczYwY29ibHJGdVVwZU8rNmhF?=
 =?utf-8?B?clhXTDVzcXBKREVtNGZHK25KRkV4OGpzS2RhVUdGQkUzOEFHZHVMY2E0YnY3?=
 =?utf-8?B?K0h1b3NNYVYyNEJzMGZHa3dqaXU0aDF2ZmRvcGZ2aEl6cnBNYmpScHFmVjBl?=
 =?utf-8?B?RDVNOVNrR1F4Z2RKWEpHNXNzb1NlZU1ORjU2Q2YrUURQSEVTMnFWenFrMzhJ?=
 =?utf-8?B?UFozbHRBd295bHlNeW84a0pTajdSK2dXOTg4blYvMmgxZXRWOVVMaDZwaThO?=
 =?utf-8?B?K1R3REcyb2hIVGdLZU9iRjhKbkl2eGZCRG5hM1ZNZ3RlVDRmbFlUYjlrRndo?=
 =?utf-8?B?L0JJUGExQ2xJdmFzZTFIN3JVNVdCbUpHZERsamt3YndDU3h0ZmR0T3hKakdW?=
 =?utf-8?B?MnNUamppSEpjMXU5MmNtc0hIVlpMYU9uNVMwTjNOcm9MdXkxYk9tbm5lWWU3?=
 =?utf-8?B?ZnJReG9jK0Mxcjdva3h4Yk9VSGp3czBnODFkems4VkxJWk1uL2NOdVhSU1By?=
 =?utf-8?B?M0Ryd1d0RzZ1QkpmYmllejBtVVk3d3BaQkUzUEtNWTFRdC9OK1Q5bzA4amsx?=
 =?utf-8?B?NVR6RTVKTEZVUGdNQkZjY2RNM3dCUzJPL05DTk1UdWEwZFltSHBFdlNDZWU2?=
 =?utf-8?B?cVNuN0hDN1BNN3ptMFpnejJMcy9ybENUdkJaV256SG1ZTVVQdGJ6cEJWeFpP?=
 =?utf-8?B?ZVAwdUZCWHBUdmc4YnM4MHVkZnNFUkxydytJWlYzSjQ1R00rUUtqUE9iQ3Az?=
 =?utf-8?B?RlV0a0oveEJyNisxelQ2OE1wVjV3OWJIYkNMM3MyRyt5TVAxTGRwVlRDYjd3?=
 =?utf-8?B?MWdlVmNkM1hnNi9QUDdZUnB2WFNicFlZQUNyRDFjYW0xMHRKMUlPTlovUUE0?=
 =?utf-8?B?L2M1M2VTZEJ2ODRvNU10NEpFMjBMSGZkQjFUbG9KUzJvaDZyeUxJMXVpWm0v?=
 =?utf-8?B?R2xmS0J2UUMwTXQyZFNLNldIalloZkxtNU1ja3F0MnBmMURJNFo4cmRIWmUz?=
 =?utf-8?B?WEc1RlNkaEpVL2doWFVFMC9JTnIvaTdCb250R0dISkJ2NUs2T0E2bDJyakxv?=
 =?utf-8?B?TkhBTUdmSnErQjQ3YUJISFJvazg0bUZ1ZnpFdEpXa2xGU3pDOXBmMnV0c3RS?=
 =?utf-8?B?RTRrMGJCTHVJNWUvbnpHSklaV2R3d3ZPTmZsd0dPYWx0STE1MXJmelFuWFBV?=
 =?utf-8?B?S0F0aUMvZ041dmZDbEloQmZQbnV0c0tWMEJFaEZucjBYLzBiR0F1S1k5eEMw?=
 =?utf-8?B?WTdLQnhERCsyc1pBS3JhT3FzaWhjSDdmSUYvTldvbDh0N09Jc3NHb1FDSENy?=
 =?utf-8?B?TG03NWVhZkdLdW45ZVAwczBUZXhuZzVLTnZIaVFsRHlXZVE3WGFnd3VMamcx?=
 =?utf-8?B?Z1p5Z3N0SytlQkszcE55N1UvdlI1YWNxMHJrRkRZWEZPbUFESVlzUG5CaGJN?=
 =?utf-8?B?WlhvU2dhSjBnSGF1b2VBVUpaNFJGSjVPaVA0WWVzVXdmd2dEcy9aT25YQWJx?=
 =?utf-8?B?S3NhdDAyQmRoNXBPcm53M0VZTlg5VklicWJHSnhrWHMxUkRZdzIvTmVqRWhH?=
 =?utf-8?B?cjJTUmhvUjlWUHptV21udGRiRzZoa2xxWi9RSHhuOHdkMUdHZkZIa0pSSXZN?=
 =?utf-8?B?U1FuQlkyNGl6ZE14cTBOSHdhZ2VFcHB4STg4Vzc0ZEhDMHl6Rm5vL2NrNnZ4?=
 =?utf-8?Q?lfC6+NaDTBH97+CXgmmLB91XJvUyL/JzZrTjsRR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3FwaEtUaklLcjhGakd0bGxVa0J4YjdZYWFFUG80cjk3Y2Yzclc3aDZXVExO?=
 =?utf-8?B?bWhhdWx4d0FjV2VoN0w5RmtudkFJN1FXUGxLd0FLbEtlT1UrZVY2ZnlJRHlG?=
 =?utf-8?B?aEJLaXBoYXR4N3BpdWZaM3BKaEh3cGxwNWNuR25oRTIza244Ti9vS2xSRGF0?=
 =?utf-8?B?MlBrMUsyWmZkMXlLR0cwTWpCUlBXbko5S3FLM0J2VmgyMDdYYXBKUVE1S1pY?=
 =?utf-8?B?emxwOGpXNDlMdTd1MFozcVRzaGNYaUNoaldBQlo4ejduOHVkY0UvcnliK2Jx?=
 =?utf-8?B?bSt3czhJMWhnQUxjb3IrQzY4dDhxL1I3MUxtc0tWQ3ZqaUw5dTdCR1ZiandD?=
 =?utf-8?B?aVlhY0NKZ1d1VnBlZERDZ09Fak9KZWxDYTZrUGJReTdIKzR5M1BQcG9zc2ZP?=
 =?utf-8?B?OEFPNXZlMlA1eHVnTzJURFJ6bE4xRlNqNVdJeDMrbU9IUTdBYTZlaXRubWZw?=
 =?utf-8?B?cDREbDJadG41UGlYYzU1c0lKek5VR29Jenh1bEJ3bEtIN1c5dW85dEJ6R2x2?=
 =?utf-8?B?SExLRksxOWxLZTBFVjc5WVp3ZHZwTjJ5eTBGdG5OYTJPMmIvcmpDdWhRbUxw?=
 =?utf-8?B?emRoOVJObUIwaVVOY1Rhb2FOTW5ZNDVxRExhOGtvRVJqSGxOSGVRaHpORHBt?=
 =?utf-8?B?a0hmL3FUMnNnWW1yMXllbkVDcjlXZ0ZULzRCS1FkVUZJTlJmN1g5bFViVTRq?=
 =?utf-8?B?TkxabGdYRFlKTXE5UjBINjY1STA3RUdNWmppc1FzWkVsRmZIUDdCS3VaZmZP?=
 =?utf-8?B?REFhU1FIU3ZyajBDUm1kL0FYMmdoOXFnRnZRRk1kUTc4b2VWV1dHUzJidXZH?=
 =?utf-8?B?VzVrdkZjYm85Z3YwYVJadlF6Z2FkZTFDZGEwV2lsSmZUUUkrcEgzTTBnby83?=
 =?utf-8?B?K0Vua2dSbUpYelM5WkIzODBpYzhYMHdVamlRVEdNcE42bGhWeU13V2hSL1JN?=
 =?utf-8?B?Z0Q5ZU5SMk92TTVDYjNsNVRUYjAxMXI2bHAvYkFVd3BHelRNUHB0MjlTVkdC?=
 =?utf-8?B?c05aeHh3Q21BOXpSTVJLUlZYaDRkejdyVGZKdThhZDlHKzhwdlZaS1pjQmlZ?=
 =?utf-8?B?OVNYaXhBYmgzNVVLd09uLy9CbFUyVnZYSmljQnd1ZmxUbEVkZnlFY0VwcDNu?=
 =?utf-8?B?dm9nN1AzR3grYmYxVUpWWVFOSzVhQnR0eVVpWHNIWnc1WVYvejVLYkpCSURE?=
 =?utf-8?B?WFNubVpHY1hLV3RKWXYxVWhUemluK2JjUjN2WE1FOVJGekR5T1p2NXpGSVpJ?=
 =?utf-8?B?U1ByU0lYUU41TDVuS3BhTjdjY0toVWpDRXgyd0FJMnVSQmluaXdxVGRQVHdW?=
 =?utf-8?B?SEVTT2puckJ2R3h6elN0YksxY2ZIdDBSYmp0azZtQmVLM2E1TVhDOFpoRXdh?=
 =?utf-8?B?U3VmT2poZXNsMU9ISXYxWGZJMStMeXZqQXdSdklPLy9kb0FFTHNXZUNYREx0?=
 =?utf-8?B?bzM3ZHlhcmg4YlpNRVYyekh5M2ZGVTVtSzROdEo2alVTZHRybXJlOWJMRTE2?=
 =?utf-8?B?VEJOblJzOU9DRTU3WjBtZ3E2clRRcUQxaGpHU1hUMlVRRGx1RkxLY21YbFdG?=
 =?utf-8?B?YStDZmRtRVBzTE1kSnE1d2NlYUxTOHpCQ2Jydk56L2JENmNlcUtIb1E2ZmlS?=
 =?utf-8?B?N1V6RWtTR1Y1OTg4RXlQTmM4bEllbWprNlRlS1ZZT3BRSWVhT0JSZXlJRUlQ?=
 =?utf-8?B?aGxibjlXMjB1NzFPREoyeEZYbXBQUW5abVdScXJaalNMZmQ4ZHVtdUNteFJ6?=
 =?utf-8?B?ckFMOWVuKzZuRDRNd1RGVndGdE52cWsxdnlPUkdiMmVLc3l0ditDT2R1OXp1?=
 =?utf-8?B?YmhSN3lRLzc5MEsybGlvZElhQzRRbEtBVUhUU1NWN3ZWYVU1Qm5oM0g1ZkFB?=
 =?utf-8?B?VWMxcHY1R00zRTA2WXY2ME5abmkxRlF3R0dKdmxuTGVweHJUR0EzS3FiYXU2?=
 =?utf-8?B?K09nZTZWbVl4QmljQUxibTV5Z1dmbTdmenNGVzYzcTNXNElNL3hEMVNyYTBu?=
 =?utf-8?B?YXVaZ2pVTXhpb2VSeW1KVE8wOVdtSnJzM01LeFhUcDBYUnh2bXFoT2xKOVU0?=
 =?utf-8?B?dnB4emZ6VTgzK2JaSTRNbUpqM2FiM0FDTDVybGpaZ3dhR0p2d0xUZlJOQm4w?=
 =?utf-8?B?SDljUEJVamtRdW42V2RkbVlGUFlrby9KakFlRCtYZDlVYUhGVmx1cUNuZ0hU?=
 =?utf-8?B?SkE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d21e49-91cf-413c-e0ba-08dd025f34cb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 14:43:28.9393 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mzPqavwjgapzbpXa9+l4xEaLBC+3CD0i+PscIEFGcyWQUCRYZLzzINUfYOktm5CPW8T4/dxnZcwlIgmhW7Rb8atoTCjReJEySbLJf7m2I1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8970
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

Hi Heinrich,

On 11/11/24 3:27 PM, Heinrich Schuchardt wrote:
> Am 11. November 2024 14:20:49 MEZ schrieb Quentin Schulz <foss+uboot@0leil.net>:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> One can use ccache by prefixing the typical CROSS_COMPILE value with
>> "ccache " (e.g. "ccache aarch64-gnu-linux-" for Aarch64). This however
>> makes the MK_ARCH empty because sed won't find a match anymore since it
>> expects the CROSS_COMPILE value to start with the actual toolchain (with
>> an unlimited number of white spaces before).
>>
>> This is failing builds since commit 7506c1566998 ("sandbox: Report host
>> default-filename in native mode").
>>
>> Add "ccache" prefix to ignore but participate in the matching regex used
>> by sed to identify the target architecture.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>> One can use ccache by prefixing the typical CROSS_COMPILE value with
>> "ccache " (e.g. "ccache aarch64-gnu-linux-" for Aarch64). This however
>> makes the MK_ARCH empty because sed won't find a match anymore since it
>> expects the CROSS_COMPILE value to start with the actual toolchain (with
>> an unlimited number of white spaces before).
>>
>> This is failing builds since commit 7506c1566998 ("sandbox: Report host
>> default-filename in native mode").
>>
>> Add "ccache" prefix to ignore but participate in the matching regex used
>> by sed to identify the target architecture.
>> ---
>> Makefile | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Makefile b/Makefile
>> index 7275a02f24ca64ebd46c5dc6e769dcdee9917dca..71743db16fca930567edd67eb77f1c94e9b7b4e9 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -21,7 +21,7 @@ include include/host_arch.h
>> ifeq ("", "$(CROSS_COMPILE)")
>>    MK_ARCH="${shell uname -m}"
>> else
>> -  MK_ARCH="${shell echo $(CROSS_COMPILE) | sed -n 's/^[[:space:]]*\([^\/]*\/\)*\([^-]*\)-[^[:space:]]*/\2/p'}"
>> +  MK_ARCH="${shell echo $(CROSS_COMPILE) | sed -n 's/^\(ccache\)\?[[:space:]]*\([^\/]*\/\)*\([^-]*\)-[^[:space:]]*/\3/p'}"
> 
> The target architecture cannot be determined in this way.
> 
> You could use the riscv64 compiler to compile riscv32 when providing a gcc flag.
> 
> You should not make any assumptions about the naming scheme of vendor toolchains.
> 

I am assuming nothing more than what we are already assuming for the 
last three and half years, c.f. f7691a6d736bec7915c227ac14076f9993a27367.

Cheers,
Quentin
