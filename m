Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4CCFC021B1
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 14:52:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DED48801BE;
	Thu, 20 Feb 2025 15:52:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="RKvya0jk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 863BE801DE; Thu, 20 Feb 2025 15:52:33 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::602])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BA6A8007D
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 15:52:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=valq4xK+Zq+AaUnRm3MoSOvcVJRKu1gEEpankPU2q1+bSOv35pBBGxtZ2xYWnNmt5zuRj8t30CN9xH5tQ76MAjTzMDSUARwl9CjVJqrcDlffp8+0pVk2LCWsBuC8m8qwi5iUc70MdVVJefiYF8kRrbeYmVctWf+YVsI8WUukCPaeMjsfVWNz1/pPe9bCTj5gnrIdrV7XKr+vw54H7rLccplMCnjoR2wgxbXsrmr2eFocH+31YB3MfsEwFvJdzXuzIql9a+D+pdAI0/PeIWlC816GzZdXY10QST/cDvezm1KtqI4k1K5oy8l9yfEuTHNtJ59OLIGZwwnnZDzeF2vUZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAeJ8DReiHyy2+SOvpNxPau3etvfy/lbE4wJSmQz2Co=;
 b=LLbzxAoVp7XJluAJPVwaaVCz9QLO9WAeFnH6lJM8+ZnX1LL7ISaImTe218yojZtlkBk3La9cbCvPRbKa8x810G05unb84BJLXx8ousB+/hW4uHP4NBcIsRVJ9OtrfhbJsibUZlPHXmLKqBDsNccSK8GMPZH1iQbnOEZJsBrB2QG5eZ7bdwlhHp6KONbDVZPCksux78SSMEUv45j3NiysjztR0VnLRvA3x5axm3tyzCnRvXBD1C5dpD468j/KYO5hBYthgADc4K5TbwiISL9PX+9ffl1dxLWgcaQDUwtBM8rZ+XpL62wlGcXeQ7/7d9YWAMw09LxC9wUzhVlxx0VQyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAeJ8DReiHyy2+SOvpNxPau3etvfy/lbE4wJSmQz2Co=;
 b=RKvya0jkUfuTyWbax/k/5CSZBoNw6KZ7F+l574xZGlUUQwkHOYJQIJ4KzLCLs7oirDfq4ZGnE+PzOr0uVLCcUD4qxQPXjuTAIX/WNgOn8q7oOk8vU18V5kXmF/mJYOs19qsKCdLpiaBShAzc/Tk3AgeklDGsqzQG0Re22rXK8VA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB8095.eurprd04.prod.outlook.com (2603:10a6:102:1c6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 14:52:28 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8445.016; Thu, 20 Feb 2025
 14:52:25 +0000
Message-ID: <6c99ba5b-c4e0-4d7b-ab30-35cd20407a0b@cherry.de>
Date: Thu, 20 Feb 2025 15:52:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add 'bootsource' /chosen property
To: Simon Glass <sjg@chromium.org>, Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: foss+dt@0leil.net, a.fatoum@pengutronix.de, heiko@sntech.de,
 devicetree-spec@vger.kernel.org, u-boot@lists.denx.de
References: <20250205-bootsource-v1-1-95f4ba69ac27@cherry.de>
 <CAFLszThr_vLbhU7A0_0VTLCGW03k6NmtxLVoW7OzrtxGFertZg@mail.gmail.com>
 <fb6792e8-97c5-4d0e-8ded-e73ea3a7513c@cherry.de>
 <CAFLszTg9-jMk0PBBSEVT=FonzRUNJOQ5NBMdDYUihWS8NkMhbQ@mail.gmail.com>
 <fc2c6f06-98d9-49d3-9ce5-46dd675e8846@cherry.de>
 <CAFLszTi2pa56uY95BRvd0snNJC_4qLV3Nm=_4EK5xXDzbmGF6Q@mail.gmail.com>
 <87h64vs7ch.fsf@bloch.sibelius.xs4all.nl>
 <CAFLszTgaHhEKvDeK_U1Rsm450+7GYeDu7gE1U=vkYEkS9W+tFg@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszTgaHhEKvDeK_U1Rsm450+7GYeDu7gE1U=vkYEkS9W+tFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0017.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::9) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB8095:EE_
X-MS-Office365-Filtering-Correlation-Id: b0fde77a-f880-4f5b-b611-08dd51be3080
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WXZYWkZXSlFkcGs1L0dTbVZrdi81MHdDQ203ZXZVR0g2SlZFMVVRVlNLc1dl?=
 =?utf-8?B?K3UycWdjQjNsN1ZWTzFPRkY5VExuRHZiMi9FQUp4QnJ0V3k0Um1USlJVMjRj?=
 =?utf-8?B?djNMUXJONlVSeGYzS1RwdThRaGZTLzhnU1hNU0F1MUNjUWdZU211Z1lJWlNX?=
 =?utf-8?B?NS85L2JwNnZxblQ1dWp6ZUtQSlY5V2JmYmJxYkhxNE9uRGxzd0xmZUNMNFJW?=
 =?utf-8?B?WVcrTm5aRVc1VnlJRHVZc0VNd2tMMkFaQjRWTmxIelJjY0hnVG4zVjQ1MFFt?=
 =?utf-8?B?N0VTenhoS09ZSEs3djJSZ0tqZ2FrSHJYdHJnR1g0RVJPWG1SVTkydmZMankz?=
 =?utf-8?B?SW4wajNYTm5tNW9CaFAvMkJGYXp4bkVwMEpFRlZXWTh4SW1DNWN1Sk9tK2pz?=
 =?utf-8?B?Y0VSRGZsLzBCR0IrZTBlMXFUWXRqTHJGLzIzNVpuN1gwMUFCUkpQM2FMOTlX?=
 =?utf-8?B?V1JleW5NTkFzK3Y0RlVCUnpwa2d3RUVpaEpzMWRNVWhwUFgrT1AwaVkvMkU1?=
 =?utf-8?B?RUE2dFFFRW4wMGNxYnZkcmZyaTRpT2h3NjRLdEo2WFkwaktxeEZNN2llRmE5?=
 =?utf-8?B?WEVSUmlnajFiNjNwQnNYT2F6VzZkNVV2TjlVbXpXenZNRWVWTVNvdkFEbzI1?=
 =?utf-8?B?c290UDE5Ny9lQWRaaGdvM3hzcDhrVkJDeWUyZVVyRTdFOWtVMTJRV0xYbVN2?=
 =?utf-8?B?ejVtOFNHdmlNR0U3bEtqMDIxbllEQWpYS1NkdFNLSXB0QlEweU1EMmxRNmJO?=
 =?utf-8?B?VmZibHJSaHo3ZzNBbERSTnpmMHoxK3VNYnB4d3RyeXEzOU9mSVU2c285NERm?=
 =?utf-8?B?WXhpaS9NOGh3bG9vQk11aXJVZEFlR2F6TE5SWnlGVFlaVms4T1g5VU42S3pB?=
 =?utf-8?B?ZHFObmZJT1IvakFSUkcwdThBb0tYN0ZVMzd6ZGVrdElFY0ZnQlNiYkFDWk1I?=
 =?utf-8?B?VzAybU5xSzEwQng1V2NtQUo3NFptL1ZROWlQSXd2YlczREVUdWRUV3pjdUNS?=
 =?utf-8?B?YjBRdEJ3T21SeGR2MTU4MnVLYjE5bnZtSFhyb1pPdjU3S0RqaDhMMUtvbXZO?=
 =?utf-8?B?c2NkOERIM3BGY21tby9GRU8vbk5OdTNMbUEweXZxelJ4dzJlQjJYT2cvN0Fz?=
 =?utf-8?B?OThoUnhMN1BrdktMei81WjF0U2hvQlRLQ0xBWWFNZkRqQUZiWHovd2NYV2Ns?=
 =?utf-8?B?OHdER1Y0dGk4Z2l0Rnh0U21FMkd1dTNBMHIyQzM3RkZJTGNRT2N1TmV5cDhj?=
 =?utf-8?B?cW9WU0ZxSGRwRk9DZ3dudWoxZms2UmdmemxGdWJQTEU2STB4eG4vMCt3RzE0?=
 =?utf-8?B?aDYySmdOa1pXRFpJbHZ3Q0doY3BBQnVYWmtLYjV2elMvOTFBMVFKRDhmVXdR?=
 =?utf-8?B?aXI0ZGJPSWNxNDdNa2NPamJZUWdmbVZUWWFpMXEyQlUwQ3BDWTlvRmNQblZV?=
 =?utf-8?B?djZiVkROSERkQTFUN2M1Y1UyajIvZ0VxRjRiUGZmOWE1bUpLVzk2Z3F0VW5U?=
 =?utf-8?B?THRZVGpBSGtEZTNLcVMxM0ZtaldMRmdMN3Y2QnUzOVMwWmYwTWdjU1JyUy9p?=
 =?utf-8?B?LzVkWmY5YUJCWUlDNmtSTFhCNm03cmdPZGJsb3JoMTNqUVJKWVJyNTBQOTMx?=
 =?utf-8?B?ZTFxSE9rYzF0dkpiYVJTUUQ2R2JRL2ZMWEpJamVSUDNSa2pxNVhaSmVqd01t?=
 =?utf-8?B?ODBuRXp3V3R6dTRiSnFySjNUYUJnY3NzaE5vcE5Vd29FRlJjOGZyd2lCNU1U?=
 =?utf-8?B?MlowdnJnTFhhUmFXZnBrTWY2alM3V1lCOGJvcEVGdCtGK0hyWTAxMXlDdkUw?=
 =?utf-8?B?dk1WakNJOTNkVWdkTjBHZkpqdHo2dTUrOGdjS1lya2crQUhXbk4xclJTK1RW?=
 =?utf-8?Q?N6JOv/XM+0Pn+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2FxT3FuUEFMVmc2b3FTcFFEOWhUcVA3a0tVRk9pc3YzVUx2YnhLNmtIYXdI?=
 =?utf-8?B?Y3FlQXduKytzS1BWSHZUY3gxY25Sb0pJWXRxS2FiWFdSRXQ2OWpQK25xenN3?=
 =?utf-8?B?SmJtVTFjWndweXpTWXQ1VE1GajlDZDBSSkZ6dklTUWVoaXpOVnRmVGVYMkRq?=
 =?utf-8?B?dHViOHo2NmlLTlczZGYxZTlKT3dZU1NjVzFicVlGd0dPNXMvaGNlNWVNRTlU?=
 =?utf-8?B?SERZb01MK21ObDRiTldOekp6M2I5QUgxS2FmZG8ydTFHVk5LVTRiV3NFNnRt?=
 =?utf-8?B?TWNmUGJxc2RZQnN0a2s2U2tJRzdHMTFzWGlhUFdmWnlVUnFqeFF0ci9pNklI?=
 =?utf-8?B?SlRWL1FGUmNoZ08zOTdCTCtlYzE0UEJIdlpIS2JscEllRWtrb3FhU2NXM1J4?=
 =?utf-8?B?TlQyMEtCRHpFang1T2hxOFhpQTJwQnFaempMZ0tzVEpUb2Q2cmxwbVZBSEZJ?=
 =?utf-8?B?RWZwT1VpZFcvVDhhRjNOMjlSSzRySHM0dk9jRDJlSTM5bGxHTnJ2Y1JKVUx1?=
 =?utf-8?B?LzRMQnpSVlpmYzY2Zk1kWFB1aGlzZSt5V0ZLVTQ4TjFPaTg4VDdiTEtKNTVi?=
 =?utf-8?B?dnFFWGFOc1BqTHdxMG82NkVrbS9CRWt4R2d1Y0srRHE3QjJ2akl4VXVRRUpn?=
 =?utf-8?B?bGV2eGdMYUtmZ0Z3aGhTRUJscVRCNkxsYUQ5NzJKekNqYlo0QnhndnpwT2RE?=
 =?utf-8?B?RUtvN01FNHhhQm5pMUxxK0U5L0M5MWJjdGNZRFhwRFdNTDhkWDEwTVB6Yytj?=
 =?utf-8?B?bXVCR3hJWVhKZzZxb1Vib2VqTWU3YkZpRnVuWHhXUkgrK0tsSk54M3Q2bHdE?=
 =?utf-8?B?cDZRNmVrdWNJU2p5S0JLcWFxR2FyQ3paVDlOdmp3TE1Vd05IazdnT01FYWEv?=
 =?utf-8?B?SU1OTFlvTXkvSzZVNnVVRzhobTdmYzZyQTkvRms0bUg4OFByc0JCZUY3Vm8y?=
 =?utf-8?B?ZHRhTVdydlRkeDBVMFZwcDI0VHZBSWFHc1FkcjYyM0RTOFlLVi8xYXhqYmR0?=
 =?utf-8?B?V2NqM3RsUnBWbGc1UDY1NzdvWXVVRGtqN0orV1hHRVlWMXhVVG1LdUQzUW0v?=
 =?utf-8?B?Y1VVeEsyUnlyZW5EV2grbFBjZWNpTmNwam1aWXRWRktBTnMwRnFYUGdmME9u?=
 =?utf-8?B?Rkx2VkxHUktUSnFoTGcwK0s2VUl1enVOTmdNTEFPdzgyTGhIM0N5dTh4Y2p2?=
 =?utf-8?B?UEVmZmtKZkN5Nk1MbG5sMU9yVHRkektGRU04MTNsUzA1MExMZjEyaGZienFq?=
 =?utf-8?B?SFdSQVhSbitEQWYwN2d5RlUyNGFUNktiV0VVL212ZU1xKzhFQ0ZISkROSDB0?=
 =?utf-8?B?SS95ajFQMXBxT3FFRE1CWEMvdWpFWnBFUDNwNm51TlBXcGh0b0x2Sm90N1JN?=
 =?utf-8?B?KzB4bkl0Y1RRWUNwSVZwd08vL2NSNHFST0ZWM1lQcXBzeGVTY3Z2WkpsQkMv?=
 =?utf-8?B?cDVUTzV4NzdDYzE2T0tYNnJ6c3p0T1J2QkJVb1VCMTZBRmo1M3Z2YXg3Uy8z?=
 =?utf-8?B?T1ZMWFlyb3h6NzFCR2NOSk15RHdHdnNGdUtzT090S2VITEtMZjJvT1dXS2ZU?=
 =?utf-8?B?aGtkMjZIL1EzdGg5UGxHOHJGc3lJR2VKTHVjQVpzeXVLZ2xCYkJSdC9KSUV0?=
 =?utf-8?B?QmExc2pRRlhVNkV3L2Q5WXl3K1Ezd0ZxN2k5R1pVRm9EZk1vekNaOXAxeStJ?=
 =?utf-8?B?OHpySy9FcVdDQzhUeTNwTEVJQmRyQ1JFSjRqRHAwcUVIMVlRN1dteDgvOE1V?=
 =?utf-8?B?ZDJoQmh1ODVHM3ZLMWtUZFExUDJ6cTBGcEMzc0xONVNoNzhjMWxWSEhiWjBN?=
 =?utf-8?B?S2lFeHN6Mm1GVUc3NUZoUTdQTk1zNjJpRlk0eDVwZVZzSVlPMEIzckZEVkU2?=
 =?utf-8?B?Mk1XKzBveUJxeno0VndFQ1dPTGhlOFpGNjFSUjYybHQ4REpCa0ZINWY2TmUw?=
 =?utf-8?B?T21CQXVBZnZqVEZCaGRvREYvYm92b3UzMVViLzhkT0FYd1VDdjVSSUwzTWd5?=
 =?utf-8?B?eWJpdVpoRkRYWDIrTDlmdnc2cmNEYTBJTUZZY053K2NyeVVabXlNNHB5UEcv?=
 =?utf-8?B?bkN1SGl2WWhmV1J3TUE1SFhVSnY4TXhMbE1CMG1mTC9IMWlHdlorNytNdlNw?=
 =?utf-8?B?QjIwM21BQUFzc29PYm8vK1p5TDRkTFNyOHRNdmhQUkU4anRSOUNBRU45MG5j?=
 =?utf-8?B?dmc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b0fde77a-f880-4f5b-b611-08dd51be3080
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 14:52:25.7250 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jueuYl7FhDofu5KQ1ezsuX/3Ft4cKMsJW+JHkiNk215CFk8Y6D6BRf03Cw00c8A0kpq1kpmC442TO9LlqRaEYmOIrc51zPG12g8WexHSeoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8095
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

Hi Simon, Mark,

On 2/15/25 2:04 PM, Simon Glass wrote:
> Hi Mark,
> 
> On Sat, 15 Feb 2025 at 05:47, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>>
>>> From: Simon Glass <sjg@chromium.org>
>>> Date: Sat, 15 Feb 2025 04:59:06 -0700
>>
>> Hi Siomon, Quentin,
>>
>>> Hi Quentin,
>>>
>>> On Mon, 10 Feb 2025 at 09:25, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>>>
>>>> Hi Simon,
>>>>
>>>> On 2/9/25 3:28 PM, Simon Glass wrote:
>>>>> Hi Quentin,
>>>>>
>>>>> On Thu, 6 Feb 2025 at 08:46, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>>>>>
>>>>>> Hi Simon,
>>>>>>
>>>>>> On 2/6/25 1:33 PM, Simon Glass wrote:
>>>>>>> Hi Quentin,
>>>>>>>
>>>>>>> On Wed, 5 Feb 2025 at 02:12, Quentin Schulz <foss+dt@0leil.net> wrote:
>>>>>>>>
>>>>>>>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>>>>>>>
>>>>>>>> Bootloaders typically can be loaded from different storage media, such
>>>>>>>> as eMMC, SD card, SPI flash, EEPROM, but also from non-persistent media
>>>>>>>> such as USB (via proprietary protocols loading directly into SRAM, or
>>>>>>>> fastboot, DFU, etc..), JTAG, ...
>>>>>>>>
>>>>>>>> This information is usually reported by the SoC-ROM via some proprietary
>>>>>>>> mechanism (some specific address in registers/DRAM for example).
>>>>>>>>
>>>>>>>> It would be useful to know which medium was used to load the first stage
>>>>>>>> of the bootloader. SoC-ROM shall be ignored and not reported in this
>>>>>>>> property.
>>>>>>>>
>>>>>>>> This can allow client programs to detect which medium to write to when
>>>>>>>> updating the boot program, or detect if fallback mechanisms to
>>>>>>>> unexpected medium were used to reach the client program's execution.
>>>>>>>>
>>>>>>>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>>>>>>>> ---
>>>>>>>> Bootloaders typically can be loaded from different storage media, such
>>>>>>>> as eMMC, SD card, SPI flash, EEPROM, but also from non-persistent media
>>>>>>>> such as USB (via proprietary protocols loading directly into SRAM, or
>>>>>>>> fastboot, DFU, etc..), JTAG, ...
>>>>>>>>
>>>>>>>> This information is usually reported by the SoC-ROM via some proprietary
>>>>>>>> mechanism (some specific address in registers/DRAM for example).
>>>>>>>>
>>>>>>>> It would be useful to know which medium was used to load the first stage
>>>>>>>> of the bootloader. SoC-ROM shall be ignored and not reported in this
>>>>>>>> property.
>>>>>>>>
>>>>>>>> This can allow client programs to detect which medium to write to when
>>>>>>>> updating the boot program, or detect if fallback mechanisms to
>>>>>>>> unexpected medium were used to reach the client program's execution.
>>>>>>>>
>>>>>>>> Note that this property is already set by Barebox and I'm planning on
>>>>>>>> adding it to U-Boot as well, specifically for Rockchip SoCs.
>>>>>>>>
>>>>>>>> I have some doubts about the wording, especially in the case of
>>>>>>>> hypervisors or chained boot programs. I'm not entirely sure what would
>>>>>>>> make the most sense to put in the property for those scenario.
>>>>>>>> ---
>>>>>>>>     source/chapter3-devicenodes.rst | 3 +++
>>>>>>>>     1 file changed, 3 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/source/chapter3-devicenodes.rst b/source/chapter3-devicenodes.rst
>>>>>>>> index 8080321d6e60d6b1e86c81af86c6850246a0223b..defd1a46e4ffaa4bb085306b5e153d38b740ac66 100644
>>>>>>>> --- a/source/chapter3-devicenodes.rst
>>>>>>>> +++ b/source/chapter3-devicenodes.rst
>>>>>>>> @@ -456,6 +456,9 @@ time. It shall be a child of the root node.
>>>>>>>>                                                            the client program. The value could
>>>>>>>>                                                            potentially be a null string if no boot
>>>>>>>>                                                            arguments are required.
>>>>>>>> +   ``bootsource``          O     ``<string>``          A string that specifies the full path to the
>>>>>>>> +                                                       node representing the device the BootROM used
>>>>>>>> +                                                       to load the initial boot program.
>>>>>>>
>>>>>>> Could/shoud this be a phandle instead? It might be more efficient.
>>>>>>>
>>>>>>
>>>>>> In terms of size in DTB, phandle vs string probably much more efficient yes.
>>>>>>
>>>>>>    From user's perspective, I'm not too sure?
>>>>>>
>>>>>> /aliases does use full paths for example.
>>>>>>
>>>>>> Having a full path allows for easy consumption, just cat
>>>>>> /proc/device-tree/chosen/bootsource and you'll have the actual path.
>>>>>> Otherwise, we'd need a special tool for that I guess since it'll return
>>>>>> the phandle number and then you have to traverse the tree to find which
>>>>>> node has that phandle number?
>>>>>>
>>>>>> Also, I could imagine some scenario where:
>>>>>> - a boot source would not be available in DT yet (though we probably
>>>>>> shouldn't write it in /chosen/bootsource since we wouldn't know the
>>>>>> proper path to it), e.g. USB loading, this is usually done via a
>>>>>> proprietary protocol and/or tool (e.g. rockusb/rkdeveloptool for
>>>>>> Rockchip) but no USB support yet in boot program or kernel (that was the
>>>>>> case for a long time for RK3588 for example and I still have at least
>>>>>> one device without the USB node described yet).
>>>>>> - a boot source would be available in EL3 but not EL2, so does not make
>>>>>> necessarily make sense to have it in kernel DTB for example. If it's not
>>>>>> there, can't have a phandle.
>>>>>> - a boot source supported only in boot program's DTB and not kernel's
>>>>>> DTB, we probably still want to provide it to kernel's DTB even if it's
>>>>>> not a device node in it.
>>>>>> - a boot source doesn't necessarily have a label (though we could use a
>>>>>> full-path phandle I believe &{/some/path@1f000} probably works). That is
>>>>>> not uncommon for SPI flashes for example.
>>>>>
>>>>> Well I'm not sure what we are defining here and which programs will use it.
>>>>>
>>>>
>>>> I'm not sure to understand where the confusion is wrt "what we are
>>>> defining here"? Can you please clarify?
>>>>
>>>> Used by whatever and whoever wants to have some specific logic based on
>>>> which medium the DUT was booted from, e.g. software updaters, distros or
>>>> CI tools (labgrid in my case)? If your software is assuming the DUT is
>>>> booted from eMMC while it is actually from SPI, you may think you're
>>>> updating (including security fixes) the SW while you're not.
>>>
>>> So for example, VBE includes a node which tells you which device is
>>> used for firmware updates. If VBE is used, does it supercede this
>>> setting?
>>>

If I remember how VBE is working, they are for different things.

If I recall correctly, VBE will provide which medium/partition/offset 
was used by VPL to load the next stage (SPL IIRC?).

This /chosen/bootsource would be what's reported by the bootrom. I.e. 
where VPL/TPL or whatever the first stage loaded by the BootROM is stored.

E.g. you could very well upload VPL+TPL over USB via rkdeveloptool and 
have it load SPL+Proper from a local storage medium such as eMMC, for 
example if VPL+TPL somehow got corrupted and you need to recover the 
board. In that case /chosen/bootsource would be the USB device, not the 
eMMC.

FWIW, we have /chosen/u-boot,spl-boot-device for storing the boot medium 
that was used by SPL to load U-Boot proper, I assume this would be what 
VPL/VBE would set for the updatable part of U-Boot?

>>>>
>>>> Throwing ideas right now, but this could also probably be used by
>>>> fastboot/DFU to know which medium (e.g. MMC, SPI) to update by default
>>>> instead of using one that defaults from the env/bin. I have no
>>>> experience with either so maybe that's misleading.
>>>
>>> What are you planning to use this for? Can we scope it to that, initially?

I have our RK3399 Puma with 9 possible booting media scenario (SPI-NOR, 
eMMC and SD card for TPL, with the same amount of choices for U-Boot 
proper), not counting USB loading.

Our other products have 4 (eMMC, SD card for TPL, same amount of choices 
for proper), not counting USB loading.

It is possible to have a board I'm trying to test eMMC/SPI boot actually 
boot from SPI/eMMC based on their state and content. I don't want to 
think I actually properly tested eMMC/SPI booting but actually tested 
something else.

So the answer is simply CI for now, for me. I'm pretty sure it isn't the 
only usecase since Barebox added support for it too, long time ago.

This would also help debug customer setups much more easily if we know 
they are updating the wrong storage medium. We also have customers who 
have U-Boot without serial, so just looking at the serial output is not 
an option.

>>>
>>>>
>>>>> I don't really like the idea of mentioning a boot source that is not
>>>>> in the device tree. In fact that's one reason why I believe it is
>>>>> better to use a phandle, since it enforces that. The RK3588 things you
>>>>> mention sound like things the vendor should fix from day one, if it
>>>>> matters.
>>>>>
>>>>
>>>> There is no such "full Device Tree support day one", especially for new
>>>> arm SoCs. We still do not have USB-C support on Radxa Rock-5B (it's on
>>>> the way but still), the introducing commit was made more than two years
>>>> ago already. I don't understand what's being suggested here.
>>>
>>> You mentioned that we have to use a string because it might refer to a
>>> node not in the devicetree, e.g. we booted from USB but there is no
>>> USB node in the devicetree. My suggestion would be to add that node,
>>> even if it is empty.
>>>

Considering that DT people usually advocate for the full dt binding 
picture when adding support for a new controller, PHY, SoC, I'm not sure 
a random empty node is going to fly by them.

But sure, that's an option.

>>>>
>>>>> If the boot-source device is not in the 'kernel' DTB, then why have
>>>>> the boot source there? What use could it be? This seems like having an
>>>>
>>>> Informative?
>>>
>>> OK, but this is really what I'm getting at. You must be adding this
>>> for a reason, perhaps many. So please can you list the actual uses
>>> your software will make, with this value in place?
>>>

I need it for CI of the bootloader, much easier to parse the DT than 
parse some possibly changing bootloader output.

I can think of other scenarios like making sure updates are applied to 
the bootloader that is actually being used, helping debug people's 
setups, allowing userspace to have different logic based on which device 
was used for loading the first stage, starting manufacturing 
provisioning if you boot from USB, go through a full recovery process if 
booting from SD card, ...

>>>>
>>>>> alias to something that doesn't exist in the tree. But it could also
>>>>> be used to just have "my-silly-device" as the value, with a magic
>>>>> meaning which no one can figure out.
>>>>>
>>>>
>>>> That's fair.
>>>>
>>>>> Re not having a label, we can add one. Yes, fdtdump does not have the
>>>>> schema and doesn't decode phandles, although I suppose we could teach
>>>>> it some basic things, or add a new tool.
>>>>>
>>>>
>>>> If you don't use the same DT for U-Boot and the kernel (which is the
>>>> case for all Rockchip-based devices as far as I know), a label may be an
>>>> issue, especially if you don't keep the symbols in the DTB. Because then
>>>> you need to guarantee that label X in U-Boot matching node Y in U-Boot
>>>> also matches node Y in the kernel and not node Z, so you need some kind
>>>> of hardcoding/mapping somewhere in U-Boot.
>>>
>>> Wouldn't you set it correctly when you update the /chosen node? There
>>> is no sense in putting this property in either the U-Boot or Linux
>>> devicetree. It needs to be added to the Linux devicetree, in the FDT
>>> fix-ups, just before booting LInux, like we do with other things in
>>> the /chosen node.
>>>

How do I know I set it up correctly? I don't necessarily have the 
symbols in the kernel DT and the path/phandle value may be different 
between U-Boot DT and kernel DT.

>>>>
>>>>> So overall, this seems like a balance between short-term convenience
>>>>> and long-term confusion.
>>>>>
>>>>> To me, the strongest argument for paths is that /aliases uses full
>>>>> paths rather the phandles. I believe that was a mistake (it caused
>>>>> problems in SPL as it bloats the DT), but I've not looked at what it
>>>>> would take to change it now.
>>>>>
>>>>>>
>>>>>> And additional argument for full-path: Barebox already uses that.
>>>>>
>>>>> Were there discussions with that, which could be used here?
>>>>>
>>>>
>>>> @Ahmad, any piece of history you'd like to share here maybe?
>>>>
>>>> What I can say from glancing at the code is that for Rockchip they do
>>>> the following:
>>>>
>>>> Register a bootsource type (e.g. MMC, SPI, I2C, USB, etc...), a
>>>> bootsource instance of that type (e.g. MMC0, SPI3, I2C7, ...). The
>>>> mapping between what the ROM says the device is vs what it is in the DT
>>>> is done in their Barebox-specific DT via this custom prop in /chosen:
>>>>
>>>> barebox,bootsource-<bootsourcetype><bootsourceinstance> = &label;  #
>>>> à-la /aliases
>>>>
>>>> This gets read and resolved and then inserted as
>>>>
>>>> /chosen/bootsource = "/some/path"
>>>>
>>>> into the kernel DT.
>>>>
>>>>> Anyway, if this is the way you want to go, I think it would be useful
>>>>> to add some of your notes above into the binding, so there are some
>>>>> rules around it.
>>>>>
>>>>
>>>> I'm not sure what classifies as a rule in what I suggested, could you
>>>> elaborate on that maybe?
>>>
>>> Let's get the info on what you are actually going to use this (you, or
>>> your company).
>>>
>>> But overall, I don't really have a strong opinion on whether this
>>> should be a string or a phandle. If we consistently used phandles
>>> today, I would want that, but we don't, so it seems that ship has
>>> sailed.
>>
>> It probably should be a string because that allows you to specify some
>> additional information at the end of the path.  For example if you
>> boot from a disk on an AHCI controller, there are no nodes for the
>> individual disks.  So if you use a phandle the best you can do is
>> point at the AHCI controller.  A string also allows you to specify the
>> partition on a disk and a file on that partition if necessary.  This
>> is similar to how "stdout-path" and "stdin-path" can include
>> additional information about the serial interface (i.e. baud rate,
>> parity bit, stop bit).
>>

I really really want to reiterate that this property is NOT to be used 
for storing which medium was used to load the kernel, rootfs, or 
whatnot. Only from where the BootROM of the SoC loaded the first 
user-flashable/loadable.

Also not from first stage to second stage, e.g. not for storing from 
where U-Boot SPL loaded U-Boot proper from, this we already use 
/chosen/u-boot,spl-boot-device for that.

I do not know which info all SoC models or vendors are exposing as their 
first boot medium. Rockchip stores that in an undocumented register as 
far as I could tell. c.f. BROM_BOOTSOURCE_ID_ADDR for the register 
(somewhere at the beginning of the SRAM it seems) and 
arch/arm/include/asm/arch-rockchip/bootrom.h for the meaning of its content.

I guess if Rockchip's BootROM could load from eMMC HW boot partitions, 
and they would expose the information, it would make sense to be able to 
specify that in the path. Similarly, Rockchip's BootROM looks for a 
special magic value at different offsets to detect where a first stage 
bootloader is loaded. I do not know if the offset the first stage 
bootloader was found is stored in some undocumented register/RAM 
address, but if it could, it would be helpful to know as well. If we had 
two copies of the bootloader at offsets that can be read by the BootROM, 
we could imagine storing the offset of the bootloader that was properly 
loaded and provide that information to the user. E.g. if we boot from 
the second offset, it means the first one got some bitflip or corruption 
and we should fix it.

I guess we could also imagine a BootROM capable of reading MBR/GPT 
partition tables and reporting which partition it used to load the first 
stage bootloader.

There's just so many possible scenario I could imagine, I am not 
entirely sure it makes sense to try to have all those supported in one 
single string property?

Cheers,
Quentin
