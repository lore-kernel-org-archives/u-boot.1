Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B39DCA0FED
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 23:16:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A68C831A4;
	Wed, 10 Sep 2025 01:16:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="VvessubK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2CCD831B4; Wed, 10 Sep 2025 01:16:13 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E16F28319C
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 01:16:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RkoELPUEYZ6ur4bNJlVp0ASXAgMPjvjVdMOf4uI4SZFCpPgy1fkYnKAfRGTFg4UVJDgPaS81c4isUl7Gzp++dm7Ch9dK6SjW4E0kxog9hNSiRahE8QlGSkd9wXVSAz2x9VdEiT+h+zTzVlXvQoPPXaRa81ddYyKIs5qRAO/5t82GEsKE5sWx7q3te2ozejLWFnzYFDstAoeEczerITIUj1z2hOK1neCkxzpG/C5/1pbgKGFtj7QOCuWzRGILuieBUlFM3jrDNCKvzRb3MvFXl3bXB4lJ8/Sq6CxNVKJ0B4GAYevDfnMQxuUduE3qQLb9S3V2EMSz8quO/4HFP2NzHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/syHrTGxCCWp+JYyo27fbSh6Zh9/dLDSE+sSZDLowFc=;
 b=ewHuIE54rMKWl5qE8uwsvQUoyOIjEi+Fcm8FBDm33xC2oYQA7lfEidRYlecGAeQd/lwL5/jkeLLWQoIcGH8SV4PMvZon4uNTPY5OR756WbMBJAe2mcYjZE1+D1bnkGbXqiuQDIiOyC/Lxt3iT0XL6jlwvD58Kpw0dUGlTarcdXz/BTIp/yxAloZ+XWbYJJ7arnxwG5vknDQxM1wAA4KHNETbsg6nyuz+R9x0spjoW8dUHKAgDQgEAREx26Pw+TUQWbcOmj6UEvU1e46BJ2bBkhMSYAhhlINbCH4dQrT5mWlajdsb5dSfG6yL3j9Xe/9r2rEoKcCxUiXzAo8tl+voZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/syHrTGxCCWp+JYyo27fbSh6Zh9/dLDSE+sSZDLowFc=;
 b=VvessubKzSO4/N7yO8gLe5uIhaylGVJf/S5nI34QjX00Su/Ui1YH49duf5xIXaKghjwW5Ap1w84XIFoIKafnM8g5OIcg+DPDSHX/lllDuvZxkWg7obMTImKQMma2LgUQg7akZ2k8V4KF5AGTj5jvdMriJemcEm4k1c6SxYMzUv6tcVGM1ViOPNdrGazZYP5pfM+CSDBOtNOpVGOUrqCia1/r05ilXlPKc9t87/BhLNoUxh6fk4153bAFq2lIsBtZ2rEKQI8twcjj8SKbp3rLuuelkDpUqju22HB+k0Z2oTUo5oIwE6345WxS5c4QfsnaM2mvEobyqZUDOTh4/o41Ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV1PR08MB11001.eurprd08.prod.outlook.com (2603:10a6:150:1f2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 23:16:05 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 23:16:05 +0000
Message-ID: <6758d551-cf2a-42dd-bf2c-5574c89277af@iopsys.eu>
Date: Wed, 10 Sep 2025 02:16:03 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] airoha: rework RAM size handling to support multiple
 RAM size
To: Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250909225751.19544-1-ansuelsmth@gmail.com>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <20250909225751.19544-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV2PEPF00006633.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3d5) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV1PR08MB11001:EE_
X-MS-Office365-Filtering-Correlation-Id: 74970046-630c-48f3-b1e8-08ddeff6d99e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nk90eXNQc1o3NWMydkN1YjhCN1dqazdGYjhGcjRRSURoZDNYdW9DVytaZG52?=
 =?utf-8?B?UFZvOTM2cW1YbUZoaGpNOWZ6cWh3bktub1VmMUxzSnpFYXJ4SnJmQlFoaDdz?=
 =?utf-8?B?VytYRWRsdnJWRmUxYkNORG80MUJvS1RVZXF3cCt4dHVXOGhUWWVUbjEySk00?=
 =?utf-8?B?enh5MGpUbWZnUEl4RUh2MGhBU1VHMnJXamEwcUlIZFBBQU9qeW5BTVFGMjFh?=
 =?utf-8?B?MmluRzh0TVlVVjNia2N1SmRJSThIMTN4MnlwZzdYNHBGMHFVZ0dsSloyM3ND?=
 =?utf-8?B?OG1FU3hWKy9iVTk1RXpORDAvWkxEM1pQMHYxUG94elU3bzd6Ry85cTV5RlVv?=
 =?utf-8?B?bzdqVU1QQk1JQ0lOWGdTaVZTL01TUE9zQWRNQVJyMnM3OURQZ1R4V0dRMUls?=
 =?utf-8?B?SGZIMENHNEpOQ0NYeUdHWXZ6OWV0WUJDUERSTVY3VnhPbEFEdnp4U1BXVlRJ?=
 =?utf-8?B?SGZkWFVhSHplWFVnejJJTVNPeUVmU1lXa2lkb0MyNzJQaTRIaEJCTmZFb2tW?=
 =?utf-8?B?U2x6RG9oc01aS1A2Y0FRemc0OHhDU2NUZVA5dlc5T2RYSld1SW5PdUVwUWp1?=
 =?utf-8?B?cnZyYzJPdktsOXN4K2Y5TmlwbU1ab0psOUh2V0h3ejIwaU1GWFA1RkRTaTlw?=
 =?utf-8?B?d1NjVzhiS2hnQ1pPT1ZXanRzTkR5UnAyNnBTOVphU1hxWXQ3ZWFIWjlOaXhS?=
 =?utf-8?B?cTU1OVpOZmpGUHNSZVIwUkNvOFJIbW9CdVF5c1JxV2daQmF2TTlOVXI2YmI5?=
 =?utf-8?B?KzBFNUp1TDREVS9VNUQrWnRRK1NOOFBydTNQeHBobHoxRzYxZ1VQanZ1dWZr?=
 =?utf-8?B?dXIrQXZJblR2ME9CVWFYdHJFY1lDNlo0MGxGVEh2UWpvMmpUSTF4U3lYTjIw?=
 =?utf-8?B?ajdHL0E3dkdhKzNJK1Jxckx4MGNwSFlNTFdiZFIrc0ZrbnQyYWd2TzFidkZy?=
 =?utf-8?B?OEQ1ZFRINUU5dXNNZWk1TFVTV0xkZ2VhODZkZFVzZHk5c0VYYjdpWngyR1Fq?=
 =?utf-8?B?MWE4ZWdDSDFZb0g4L0Ftd21GS083dWhhNkxlbFloNW1JK2hNeGZEVEVJS3pa?=
 =?utf-8?B?dkhoTDNZKyt3dGtUdjcyYjN3UXZrbGFPNndSV1Yrem5JUm9VSFM5YVBQSUVB?=
 =?utf-8?B?UFNzSlpvYkI2NDZpeXlDa3p5VlZvK3NzZnUzQkpCYUtULzk2a3plQnRud2tt?=
 =?utf-8?B?enNUTW5LeHB4S2V0UXpOWWw2bGthcExxVzIrTEUybnRwZnFLQXpwVDdMVmRa?=
 =?utf-8?B?RisyWllJN2swTEZMSmthamRRNmxibFhsQWdtOXB5ZDJSSy9iM0hETmsyS1Fh?=
 =?utf-8?B?VVJnVkg1TmxRSVZxdG5zZXZqVnFITUovRzR2R1dONndqaEZIWmMwOHNvYTUy?=
 =?utf-8?B?cVZKOVBtZW5Sc3pkOCtJRkhrSE9vVEZMTVBpL3NRVWwydjhSR3ZaUXJ0TG11?=
 =?utf-8?B?L3BaRHZ5OFJrWno5eTh0NG9xUnJJTWpvMHM0WWZybDNaVVQrci9oY1hNRHMx?=
 =?utf-8?B?SmVQZGpPZ1h6ZjRMVnNCWGlqSFVRQXpud053RHJzNUQyNDczWlBRV1FYTnZx?=
 =?utf-8?B?TzhvcnNPVytwakQ2VGlQZVQ4SitReTN0bkFZYUdnVlVkMXJyWWlsTTV5SEZj?=
 =?utf-8?B?ZkwzMzFmbkNTdCtBMFRLVG9VTFlOdG9KYmVlTldwN2JyVkpPTE95N1VMVUxC?=
 =?utf-8?B?Um9zdmppSlRGRGdrcnpzb1c3eFpoWTZTZWc1VnBGK1Bmd2drZVNiWTBCcEJQ?=
 =?utf-8?B?R2l5N3hLU2VjUjRmTlQvd3owaXJEcHg4TDMzVXFuQXZNK08zTU45YzdXZlRY?=
 =?utf-8?B?d0VhNjk3TUQxSlk3bnBSWkgwYjJMV1pqRDhCaStGQzBEbzcxbjVzUktKaUd6?=
 =?utf-8?B?dFRZNHlmcURzSGlnRlVRMnUyMEh3RWFUWEhZakY1aWlhaEpnMUcwak1GV0dv?=
 =?utf-8?Q?NYx+pIoszug=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1pKTjJJVHNIRWplRFBsVGJMeG5TU3Z0QTBuV1FpNGQzOUJtOG5USTVhV044?=
 =?utf-8?B?YmJFVFdrcnJZZXNuMU1hckhzUlNxelEzaWRJZm9kMGxJOFVSNXpVUC9WbDBv?=
 =?utf-8?B?eEtyRzBMWC91NFdYdkF1ZGdQdTZGY3BDNUxPWk5tNHFBdVJPUEtraE1iT3Rr?=
 =?utf-8?B?U2pnSVB2NUtLOTdVcnF6dWg0SGRlZUovNitTYTE1clVQZUZaZzc4VjlJcjJv?=
 =?utf-8?B?SHhqSVNNNDVpaUx0aVN2YVAzRDlyM1RIRzlOTlU5SE9SN2JsNXkwb01OMWVX?=
 =?utf-8?B?WkxHa2ZXeHhBV0hOWlNSSDZLZ1lCT0wzZGtkUkZQL0p4a1dSYXh2ZTJFMVg3?=
 =?utf-8?B?aGhBdHc0Q0RlS0ZST1lYQkc0UjJiSElCOVJTeTlUMEV2c3dLak9ZT2FKRGd2?=
 =?utf-8?B?dStGMWVYcnBOeXdvMmlQV2FzS1RmUm5VS3VGcFpSU2g2dlczMXUvL2x4MUhE?=
 =?utf-8?B?NDZOTFJRK0F1TkFxZHBsbjU0YkhZRE10TE4wZU40Y241N0ZCMDlVdytraVVa?=
 =?utf-8?B?S0U4VWp3emVNSW0yb2daZDFIcFF0YU8vcWxYS1dIUXVGQTlCTE1mT2xSSXJM?=
 =?utf-8?B?NHVJd3plQ3g5bWhwM2diZTV3dWxvWUltWUFLTU5MZ1BWaUVHaEVoWDlldmZB?=
 =?utf-8?B?OVJ1TUk3NnpubDlIcUJRY1YyZTNibEdYZEFaRjNUREV6QXYyZU1ham0xQ3Zj?=
 =?utf-8?B?cU80cWkxRHUzK1NBRCt6YmlmcFF0Mk4wUWtrN1E5blJDemt6S3dVd2U1allR?=
 =?utf-8?B?R2FuRThvR3RHZnVrOG90R3dDMGVZQmRJdFNPT0JMNWNzOWVJaWhicW9FNnFl?=
 =?utf-8?B?VGhOY2JBTzVyWkhwTFI4T3hmY2NmdldYRkJJZUcvRXVQcTFXajQ4V2hnK0ZT?=
 =?utf-8?B?TW5kenhPbFp3RTJpSTRDRkE1V0ZkM1Z0clFEOFFSUHpraDdvSEJ1YXdGTTcz?=
 =?utf-8?B?RHNSVmcyNnlrWktMa1N4Zkw5OUJuL3Y2aXVPbGZPVFBzRmhzaUxtalZTM01S?=
 =?utf-8?B?SWtyY1VIeGlYRnVvWnBPNS9NdFZQRGlPbkVZWFg0dXZXT1V0SDBZc0t6T29X?=
 =?utf-8?B?akJ1Yk9yS01sOWZSaDZ4dnZwcG9xZmptb1J0WkJGY3h3RmZGeDgrc2kxWDJw?=
 =?utf-8?B?c3FXblIvb2lQRmU1L2dCQld6dGFHZ0xUWmRRVlFtSFdRQittQWszc0xXYm1x?=
 =?utf-8?B?a0QrUHdtMjY0OEdvNVZnRkFwQnpaWEo4V0h2OHJMNk5LT09BcW5HU1JiQmRI?=
 =?utf-8?B?dnlFdk1jYzQySnBWVHMxeDJsbFNpelYvQXU2V2JlbURaaVBiVVI4Q3NJZHI1?=
 =?utf-8?B?dDNyd08wZ0NrY3htb2MzNTBjd3JMYVlSVmQ4emtkT1pBSkNoT1BnNlR1dHRL?=
 =?utf-8?B?Qm14bjVyaXphMG05SmRNWCs3aVMza2svSXNqU01yUk5DWm1zbjVlbSswdTNX?=
 =?utf-8?B?dis3NVZ3dUN4dmt2bmtKYjc1bXN0ek5VVDY1cUt0bmRKZlYxa1Z4VEFOOE9h?=
 =?utf-8?B?ZjFqQldZV3NQQWdjOVRKWlNxcTZhVmpxQXNHWVgxSklDNmV2L2doVXlXYmdv?=
 =?utf-8?B?eElLRzhlL3NzZWlUQTE5Q2hHYzdvL0hXcXF2SSt3cW5FVlhUMStuOWRYc3Rh?=
 =?utf-8?B?emNHUFFTbUhvL1ZNdW1CcDF0M1dUdXZzRzRvRWhTLzRtK253Nk9MZjFEcnA3?=
 =?utf-8?B?WUJOTnFGcU51S2VEdU53NEx3VlhhMHE4bkFiN1Jvd05zRTIzQnRKb2dUWm9p?=
 =?utf-8?B?eG1wMnRaaUlvSUhhYjIwSzhIcG9GdTFEcHVRVmo3MXJuQTkwQlo1a252cHRv?=
 =?utf-8?B?OGJ2T09tM3VobDJBbEx3Q2M1Q21MQ1hEeUZ5Y2VDNk5hVEg5TWowajJrdDZH?=
 =?utf-8?B?RHVJRU1BL0pZVWNLY1NMeDlYWFYvTi9aYUE3ejExcVB6Njl0N1RJUjdKN3A2?=
 =?utf-8?B?aFBEZ0NsekdaWnJXUVZpQUlQTTFPY1lIa29YS2lvSzdhMzJKMXlSdzdqam92?=
 =?utf-8?B?RyttbGllanF3M1lPVGFFTDB1Ukk5Szdqa1V6SXFwODFXYW1hRjIxbUpXV2My?=
 =?utf-8?B?V2RZVWNnRVo4VnJoc0NEVDBBVTFLOE1zZ1hwdlBKMzlzM291L2dCWStpM2tx?=
 =?utf-8?B?SWMrYmlSc095ZlE0bFR4UEtRSWdSWXJWY0ltNTZzeUxXczJGZmh1WndwSklo?=
 =?utf-8?Q?YZrOYTnuosG+aKKFyYTjn64=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 74970046-630c-48f3-b1e8-08ddeff6d99e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 23:16:05.0476 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /eWr/TDvdmrxoe6FSRduYshmqn6lsM950weQTL0/s4c9aXdOsx6vMEDpltvnQ6/hfd/eay6Eq7iEvleRAcTPs2RcG8bDfykWLxZWjjQPE3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB11001
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


On 10.09.2025 01:57, Christian Marangi wrote:
> There are multiple version of the same reference board with different
> RAM size and it's not enough to base the RAM size entirely from DT. To
> better support it use the get_ram_size way to scan for the actual RAM
> size of Airoha SoC and increase the size of the memory map.
>
> Also rework the memory map to account for 2 memyro map. The first one of

Misprint, please replace 'memyro' with 'memory'.

> 2GB for 32bit DMA and for safe usage of U-Boot. The second one for the
> rest of the RAM since up to 8GB are supported.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> Changes v2:
> - Add memory map to support full 8GB
> - Assign 2gb to first memory map for U-Boot
>
>  arch/arm/mach-airoha/an7581/init.c | 40 +++++++++++++++++++++++++-----
>  1 file changed, 34 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-airoha/an7581/init.c b/arch/arm/mach-airoha/an7581/init.c
> index d149e0ee3c8..11992027d92 100644
> --- a/arch/arm/mach-airoha/an7581/init.c
> +++ b/arch/arm/mach-airoha/an7581/init.c
> @@ -2,10 +2,16 @@
>  
>  #include <fdtdec.h>
>  #include <init.h>
> +#include <linux/sizes.h>
>  #include <sysreset.h>
>  #include <asm/armv8/mmu.h>
> +#include <asm/global_data.h>
>  #include <asm/system.h>
>  
> +#define CFG_MAX_MEM_MAPPED  SZ_2G
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
>  int print_cpuinfo(void)
>  {
>  	printf("CPU:   Airoha AN7581\n");
> @@ -14,12 +20,28 @@ int print_cpuinfo(void)
>  
>  int dram_init(void)
>  {
> -	return fdtdec_setup_mem_size_base();
> +	int ret;
> +
> +	ret = fdtdec_setup_mem_size_base();
> +	if (ret)
> +		return ret;
> +
> +	gd->ram_size = get_ram_size((void *)gd->ram_base, SZ_8G);

I think this will not work correctly for 2 memory regions with a gap in
between, see  an7581_mem_map. So I think we should use get_ram_size()
twice (for each of regions).

> +
> +	return 0;
>  }
>  
>  int dram_init_banksize(void)
>  {
> -	return fdtdec_setup_memory_banksize();
> +	gd->bd->bi_dram[0].start = gd->ram_base;
> +	gd->bd->bi_dram[0].size = get_effective_memsize();
> +
> +	if (gd->ram_size > SZ_2G) {
> +		gd->bd->bi_dram[1].start = gd->ram_base + SZ_2G;
gd->bd->bi_dram[1].start does not match to the virtual address of second
region, see  an7581_mem_map. I think this is a mistake.
> +		gd->bd->bi_dram[1].size = gd->ram_size - SZ_2G;
> +	}
> +
> +	return 0;
>  }
>  
>  void reset_cpu(void)
> @@ -29,20 +51,26 @@ void reset_cpu(void)
>  
>  static struct mm_region an7581_mem_map[] = {
>  	{
> -		/* DDR */
> +		/* DDR, 32-bit area */
>  		.virt = 0x80000000UL,
>  		.phys = 0x80000000UL,
> -		.size = 0x80000000UL,
> +		.size = SZ_2G,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
> +	}, {
> +		/* DDR, 64-bit area */
> +		.virt = 0x100000000UL,
> +		.phys = 0x100000000UL,
> +		.size = SZ_4G + SZ_2G,
>  		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
>  	}, {
>  		.virt = 0x00000000UL,
>  		.phys = 0x00000000UL,
> -		.size = 0x20000000UL,
> +		.size = 0x40000000UL,
>  		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>  			 PTE_BLOCK_NON_SHARE |
>  			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
>  	}, {
> -		0,
> +		/* List terminator */
>  	}
>  };
>  struct mm_region *mem_map = an7581_mem_map;
