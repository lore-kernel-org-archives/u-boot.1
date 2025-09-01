Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F943CA0FF0
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 17:00:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 642B783990;
	Mon,  1 Sep 2025 19:00:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="PLDT1bpE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EC5383A28; Mon,  1 Sep 2025 18:59:59 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8719838C1
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 18:59:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VB1knB82Fl6cSi5T5uHVZuPcLcoPi45C6SPxSHXN8z6NfWPYDhXwtvqR3gwjthG1n0lchPBDRooRcSxUWoV6i5O1y2xtLwEQU54eh+RuFowDkOprtnMdMqKX5523SLN+KeAcVC1+6QB0a6oODE6jBgDks+ThP6n0SGWKsh7k28Qe+u3LQ3a6vgpao9vUKDGb273TUuYI7Z8DBEZk+uMt/DMsowKeXpBQpRcYRY5wv4I8uspsorM8hfjRZ84GQ8P4i6lKUuKFaZPRZCr+4oMte+GnYZ8IPeEIns/zvSw/jvTfmj9PGysZlrSlqcqO7f+F/e9v74RP4zHHDQ0+b4EHMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+K4od03hh11QnD5vBmAqhdU/OQYjqOCMO/tYaTnIY0=;
 b=b49yhvX+h3f4ExUNVj/ETaZ8h5KmR37aEIYFJ4ih1jJb0yPKWixxQM2+ZGa6Pss6S3RB/s6hFcWCUkYN2xnwRwItRWdNviqOHjqLvp2eo60bAGRPfMRociIwOFS00NK+zlL0LqtpyQZBWMuEu3pYZIWs1EJ1Bbz/Js0qYiIps3lNpnoRiLPKM+v124jeHcyVh7d0ybFCmYOv/mN3/YvPDALNLA8qhXf8UTIigGeLCpL0F4tUCeskKv8hMtTcyLMvBgohAQHJnFfgCnNk6QfukN5jXc17gvoGsKsZsfC8USXhu6YqJH5r7792KaDA0CU0mNF6lHg39rwieGfYE4dTlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+K4od03hh11QnD5vBmAqhdU/OQYjqOCMO/tYaTnIY0=;
 b=PLDT1bpEvBsQ+ucad+r8SsCzSySVH/oDzZEEbmZE81Hae8rRmvRugj9GkZsk+zVxMTUoOYOGdVltmbf3K2qsK1UfStgrQVZOCTuSMPa8MlgtBNmdWPvrn50NxT4PYqKrN2TvzO4j7Cmqdco0ftbVWn5yG7JaHQw/zuYs/sIjShfA27lei3ueWWytBAplyzgnUbYYxla1kViRMHgkJpUdym6wWs1fhKt5VAzCfwO0U4aZV1gpPKL5mLdnJ/hiTSHqULZDIWuhATTyQTsVHoQJVsTV3xRGbIUYTf6Ma0aNaWP24amUAGtNOmalhQOr7b8rWkerFpBwH/rcYwQM+HhffQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by PAVPR10MB7233.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:311::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 16:59:55 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9031.018; Mon, 1 Sep 2025
 16:59:55 +0000
Message-ID: <5c7dccfc-9b9b-48db-8355-d01db699f476@kontron.de>
Date: Mon, 1 Sep 2025 18:59:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Please pull mmc-power-next-2025-09-01
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de
References: <20250901050359.GA31200@nxa18884-linux.ap.freescale.net>
 <6c8ae3a7-858c-4d1c-8e05-9f7ad766bd93@kontron.de>
 <20250901145456.GA124814@bill-the-cat>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20250901145456.GA124814@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::20) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|PAVPR10MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: a756d232-0749-409e-b554-08dde978f984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cG9GM1VWZHl5TVd3Vkd5a3E1Qkx1aTNmYWpiQkljVm1rcUozODlxUmZadDlG?=
 =?utf-8?B?M3JOYU45cUJPbitYSC9PeWNOTHpNWEVGdkJra1krUHBhS0tsYmw4UHdIKzN6?=
 =?utf-8?B?bVhEWVRFYVNOVWUwenpWQ2VaYkxOanBFZ0JFb3JTZHhaQ2ZHWTNuUUtPNGdz?=
 =?utf-8?B?MFFsZjV1ZFlQUmZwOXhBQWg0TEZwWDJJTWZSYjNVcFptS1ltT2I5K2pkVHFo?=
 =?utf-8?B?YlNoM0t6eFFOMGt1QmJXSTNwT0NISTRoRVlMekVwRi9CeTNHMmR5eForc1NP?=
 =?utf-8?B?WDB2dHdmT2p3V29PSFhCUWlnaUJ4TXM1aFJNQk5mY3ZjengvclRtcHE1Wm1x?=
 =?utf-8?B?QllBaGpGNENrUkl1S3YvbjA1RW5uSk54VFRHS0N1R0JZQk1acEFZR0Yra292?=
 =?utf-8?B?K3RCUHpnMjkzaUhyMkRKSE9HcTZ5RDEwNnFtRXd2S09WTDNTMExjNDhoZVVG?=
 =?utf-8?B?Q1JkNFBJbUZ0TDVpdFJ6RE41dXFQZDVyOTZQK21XR1Q5d1hUUzRVb3ZQZ2RC?=
 =?utf-8?B?ODRpbmphcmxDVHUwWkkxbUJSWnVJRWZGeU1yTWNQalRYKzFjbUdLSTNaWHow?=
 =?utf-8?B?YjYxYlhqcnFGMllyU3krQUkyc1J0T3gweWpNcHZHUm9iU2VCcmcvcjhscjVr?=
 =?utf-8?B?MDVQaDd0MkJwVlJpVERLVFVRNit1WXViM2dla25SQis2TVJNemRhRVl6K014?=
 =?utf-8?B?OThOQzZ0VUZnVU9WUnVFSFpQNjJ4NkRuWlp6TlNGaDBrVlBaN3FjK0ZER2Jw?=
 =?utf-8?B?M1FuZ0JJWUNrbEFaZVB0NmI0dUxMVW9NbWROWVg1ZFc3WmtlNTdCYmxiYVVB?=
 =?utf-8?B?SjlRdHREZ1kybGxjdHJBYzFvSWhVVjFTSmxTeDFuRkhkRzlsV1RqN1RyR25X?=
 =?utf-8?B?bnZucU1TV0JJcGphSmRVWWkyR1ZwNGdia0xnRVkxVnFKL2k4bXUxQzFSTGNB?=
 =?utf-8?B?cTdNdSs0dS82eXdVTVVyUkV5MXh4eUZPbzNabFVCcm9kVTdHV1NZbUVOSU8x?=
 =?utf-8?B?UWFvK1prMEQ0TjRlcnR4NFcvSTNYYzE3ajFTaCtsZmlqT2daV2FYdWt0V1NZ?=
 =?utf-8?B?c1VWL3JoWmc0V200dENSQWh6SkFHa0xqc0pheURrV3RMMmhuYWpEU09lcFNV?=
 =?utf-8?B?bXg0M2hIUTdvNmhrbjhuS2Z6d0RwV0RGRk9aU0E1UkJiVHA2MG5tbXJRS1B3?=
 =?utf-8?B?MUJQTFVyY09wd1BTa21YU1I4cGJvSFVRVXpybmNaNjZTQmJ2RkIrV2FtVXhs?=
 =?utf-8?B?bEhLbkYweFgzT2tBMHdUTFY2WDRGdGhGWjhRSndzWTl0dVg2RWNUZnJ5ZVFs?=
 =?utf-8?B?dnRPUWNFaXRkbVBDQjBoTmVSZStRME1LR2J5WHovRUhqUkdncFJqaUwvRE5o?=
 =?utf-8?B?dmd3YUpkMVRFYmxMZVZHZmx6K3dBeTFhZmkzS2wzaHJmZWEyTFk4VzZueDQ3?=
 =?utf-8?B?ZXd1KytWK1ZSck9IdUMxbDFVSFFMV3M4NEtxa080dUhZZEdJN091LzlpMXJ3?=
 =?utf-8?B?Mkx3TGdPTXNMaFhudjQvZmhMNmtuRDIyYm5ZelhEazhacUNlM01HTUVaNkIz?=
 =?utf-8?B?NlVBMEVzVzA3aDJjUXdFUkRjU1lVVVJLUUpuTDlRYm4zTXpvbHpFRjh3L0Yy?=
 =?utf-8?B?QmY5NnZJNW9wUlFsTlJmTXdsc0t1OHc3NVJHRFlxSldlRlVsTlI5Nkp3alZL?=
 =?utf-8?B?dnNNMXRTdmo3STUrcXU2UFR4Vkl6Ti9PVENrUG9yckFsOWpyVm9mZ1VzK21X?=
 =?utf-8?B?Q3NxYmMyVWdWY2k3WldKdFhzbGp2N2YrYTVxTTFZN3FqVi9OUUhFWDR1TnpJ?=
 =?utf-8?Q?4pmHzCQsBv9GftSRuaLHTa3RzWK22mLg/SPp0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlZvSG9ySTVsM2ViT0x1b2tpYWE0YlBOYmVyRzVZQWwrQ3lvQS9FWjZjRDNH?=
 =?utf-8?B?a0p5QmFaZGRjUGVnbWhnaHYwK0tUSmdKRjI5MDJUZGJXWERsWlhYdUVER0dH?=
 =?utf-8?B?YVl4QlpOSmg2OS9HS3FNSkV2Sm1MMzEwUWZJZHF1Q3BQdUJNV1JMV3NjUXFN?=
 =?utf-8?B?bWJlZnNkNkRhQyt4N3Y0b2VwY29jYU4zVkp1WU9xb1h6WkJkbUZkWTVpKzZM?=
 =?utf-8?B?NzV5VVc1cTJIZlloSmFyYVU2K1YrczFadU9Jd2tIRTErak1JQkFyaHVSM0Vr?=
 =?utf-8?B?TXFOOS8zdlk0MmtyYjRRaU1RQUtYZ2Q5Qkd3ekl3cmJYWVUwUU5LcUpoenRQ?=
 =?utf-8?B?ZmtpK0N1Z2p6S3dBb1B4TW5temhINTlRNFhoR1JqcE8vendqOFFNQWpZYmQv?=
 =?utf-8?B?OW1sK0pMQW54MlMxM2R2eE5oZ2JZT043Z1RuSnM5Nldici9kSXZWSU9aOVBj?=
 =?utf-8?B?eFFRSGowL2ZwVlBrZ2FZcDRQQlBhRFRLa3VjMG02YWZrT2IvQ2RsTFprVCt5?=
 =?utf-8?B?THhWVGFjTTc3WlNscDN5WU9QeFp4NE1GNjFLVzlkK2pmelhWTHVFR3l0aHN4?=
 =?utf-8?B?YkczYlRIWnJGS1kvUG1LbkxNb2dDRjQyU1A3STFVM3JVMnFBT25xWW5KRHp0?=
 =?utf-8?B?WkhWcWJmeXc3U1RnQUNlNEpnRXFiMlZrenZIZzMzRVNxVjZHVDU0UGo5c2ZJ?=
 =?utf-8?B?TUlKOExQLy9aVnp1ZjdPUnEyZVZIYXdNcElrWW5tZWh5QmNkd3lBV093VzdH?=
 =?utf-8?B?MTFyaGgwaUNlQUJkWWJwNlBiN1Q4ZzZLbm5TcG8xNXBoVkNXc0hKQkM5YWFB?=
 =?utf-8?B?RHRZWUl1a2E2NUpkTmYrbDlWLzliZnNwdVN5b1JNSURyQjJPZS9ZeFQrUi9J?=
 =?utf-8?B?dlpONHFaRXh2M1lWU1hiZnRlR2FZRVhrWjJaTXdUQmZQUnR2TjJ0VDgwT0lH?=
 =?utf-8?B?Njh2U0p6Q3duK0JJTG5qNWdZRWd3dmE1dGxWUzZ4bmhnSjVIeUYvUFg2UFkr?=
 =?utf-8?B?WFZpb3QxeFIxN2lDa1NTQ2VMUHN2Y1NJRU1aMGJMeUorNkNPMmQ2Ky9OZVNI?=
 =?utf-8?B?TFFiY2hQRmhWSVJUVlErc0Y2WUdMRmdKQjdUTk1hS2pGemlUQUNqRzlTUVpN?=
 =?utf-8?B?QVFVM3BIVXdyZno0bjdrQks5T04vb1MrY3VhNnM5WHhMWVhIT3RERzdHYU9G?=
 =?utf-8?B?MFlwNmZGenRLVzFsT05XMkl6NmJWSWdTRTJtdXlNRUNDQTRlWmMrTEhPb20z?=
 =?utf-8?B?TjlwY1MyUXNyNWl1QTR4anBZVDVtUFdjK0JjNUthcFN3QllYMkxHcjRSWXQr?=
 =?utf-8?B?b1VlYzhVMGttSWVpOFNmMkc3UmtlQ2d0RHJmbFVXaVZuMjdlb2dDbSsxR09q?=
 =?utf-8?B?OERLL0FTb1hrdUY2Ujl0YUVNS2dSN1RyQkMyZnFucjdIeUlzSTFaemI5YVR1?=
 =?utf-8?B?dGlQNDc4YnB5eXcva0NHUUNpWVdmV0UvUnQ4UFI4T0hPeFRBVmRpZFFHR0x2?=
 =?utf-8?B?OGlKVm5TSkdEZG85TTZPMzkyeTVpTkplTGMwQnJyQk85VElNeGh0OGZuc3Br?=
 =?utf-8?B?S2pxOUJMMS9vNjMzVUhJQTBqRVc2MFkrZXNtRDI0Q0dHaDBvaWJyNG9OTmJi?=
 =?utf-8?B?ekhRTDBBNHl5bmM1QkdOYmtSVlVZZW4veTJ5bEt3dmtPaTJxSERtdU1CYlRG?=
 =?utf-8?B?bWdJSWR3Yld3empGNWlkVVY3NFU2c0daM3BzVlBSZTJkSWdPS0tBendYWEZO?=
 =?utf-8?B?WHNGZWxIZ3FUMzNLc3UwVGhGcHR0anBsdkl3WUdFWnUzOGJ1R2ZFUThNc0xB?=
 =?utf-8?B?azBtMFBITnAwMXJBWHF4U0xkSmx2OXMwOHNUZkpZTzdOVmtBZkhDZ1IzcEZL?=
 =?utf-8?B?SEc4Mm9YdTN0YTNYK1BwVFgvRVlHeFQ3bzNXRktuc2doMnRoN1FoNGdUWFV6?=
 =?utf-8?B?Nnk3L1doV3ZEZWdBUnkwNE5DZXdOOVNCZGpxYUVmRXp0dlY0U0lBNzd5L1lU?=
 =?utf-8?B?V0NBaDVlbk52TzJtS24xWVFjS0tzQmJ6L3hPM1dNRnJvTFlKeWJ1OVRoVVV1?=
 =?utf-8?B?bzFDMFVGcVpBaFB5R3dKY29kUVVQU1YrK2xlb1A3RzFlS1ZFMFl1UEdubmpV?=
 =?utf-8?B?cVZRcm9rdGwzcFpQR3htTTg5T0UzV0w1VTRHa2J4dnA0cWdoeVdMYjFSejh0?=
 =?utf-8?B?UEE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a756d232-0749-409e-b554-08dde978f984
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 16:59:55.0640 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PSq+70k88UCf9JHpr43ENM0AyQ3ZYW2zus3T5Yv5oIQy+62Z63mXcRK9SqCE3yJzIp5ug6qGPoDHPyboKn/I8Swi6hAAXeVBJg4iKbJwVcI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7233
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

Am 01.09.25 um 16:54 schrieb Tom Rini:
> On Mon, Sep 01, 2025 at 08:52:32AM +0200, Frieder Schrempf wrote:
>> Am 01.09.25 um 07:03 schrieb Peng Fan:
>>> Hi Tom,
>>>
>>> Please pull mmc-power-next-2025-09-01
>>>
>>> ----------------------------------------------------------------
>>> Update compatibles for PMICs used by exynos devices
>>> Support system reset and reset status for pca9450
>>> Fix for pca9450 LDO5 registers and drop deprecated sd-vsel-gpios
>>> Two minor fixes found by smatch
>>> ----------------------------------------------------------------
>>>
>>> CI: https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/27536
>>>
>>> Thanks,
>>> Peng
>>>
>>> The following changes since commit c9ffeefeb3efedd754e3ffa3440bfeb15cea00c3:
>>>
>>>   test: Update logic for video test (2025-08-31 09:32:17 -0600)
>>>
>>> are available in the Git repository at:
>>>
>>>   https://source.denx.de/u-boot/custodians/u-boot-mmc.git tags/mmc-power-next-2025-09-01
>>>
>>> for you to fetch changes up to 140562d3a2b447079499d773a7d21ec1728692cb:
>>>
>>>   mmc: core: drop space before newline in trace printf (2025-09-01 10:33:10 +0800)
>>>
>>> ----------------------------------------------------------------
>>> Andrew Goodbody (2):
>>>       power: regulator: tps65910: Cannot test unsigned for being negative
>>
>> The change above has unresolved review comments and IMHO it shouldn't be
>> applied as is. In patchwork the status is correctly set to "Changes
>> Requested", therefore I would expect it to not be included here.
> 
> Yes, sorry Peng, I was just expecting a PR of power-related changes for
> NXP (layerscape and iMX) related things, not everything that's
> outstanding in Jaehoon's queue. I went through it over the weekend too
> and marked that one as Changed Requested but applied the rest of the
> series, for example.

As Andrew just pointed out to me my review comment on this patch was
wrong. So the patch in fact should be fine as-is. Sorry for the noise.
