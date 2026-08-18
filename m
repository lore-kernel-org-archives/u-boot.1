Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C786C5DF70
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 06:16:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4A35F407D6;
	Tue, 18 Aug 2026 06:16:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uzEUt_vkyvaF; Tue, 18 Aug 2026 06:16:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0482A40687
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787033788;
	bh=OH9dZc+l9gJu4+3VjRMKxNudo8aJtGOIKI85+kCNUd8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=neE3XfVw4LyFqaCx3DOVLuZ8zMKRE2MVGK4uBLr94H5kt6+PA6VUQQKOwPE44i8Df
	 wgHQsIAUEs9MtIbdCHs5IfSrM26MdY36oRCquqVMb0zqpkk4S5X868WjNwciPiabwi
	 S9O0abqC6+vKdJ6VbCMLc9X35BBWmS1vkz/Hm7JQ41cUpkQr7/pVz47CfCct35MN85
	 E4MyWDmSJMh+qBmh2CKk97P9d+ulh2Vud1AbEJPorPIFidxvrqpiBIo/vAwz2BKvqK
	 b5u59X1urnow98dECyBqxYnglEAIcyn7VruucpRLchqDJgGYMJGRfJ5jfakFON9edw
	 XSvPK10g6HVxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0482A40687;
	Tue, 18 Aug 2026 06:16:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AC6232EF
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 06:16:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 92DAC40059
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 06:16:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id huDt5X3Rp33f for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 06:16:25 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=alice.guo@oss.nxp.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D0B73400C7
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D0B73400C7
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com
 header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-NXP1-onmicrosoft-com header.b=cn2e+trg
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D0B73400C7
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 06:16:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bLYu7TNG4Q9mz7VfZs7oecm7s1AKQ/Fx04YAkrqeXjnJenKgr10hxuGhFddi4AqhH46vSI6ZAwnXEgCRmY7LRftiffK0x5gW8R6VHPnukHtMpHNvHVAZRWiK864x1blNxFs/JDkNWAmeK45yO9qFKMDnJ02Ekyvm/hzJnADMadey8yJL2gaK4aEl/EfLUrPxcKhX0TuV+cq12/dZPPWJCjFkp3Yd2yDwNIy4DvOlXkfckMNdhWR2OfyTr5APDDi+lhyEhp2/azMMNvDRMJKlkHmmjdCzr1/kvylKxr/gRrJ1mVzCwgjl/vHW8+DKdQrdT/qi89nc2YKnInHbHYOpXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OH9dZc+l9gJu4+3VjRMKxNudo8aJtGOIKI85+kCNUd8=;
 b=gasqWJqaBcTIak//ZRs/LWbDzeNXUe8xehxhr7nF2wcoG66pXXj8QiXHECKWONid9BIPe3uC3ISwT0Mg8+o5Vcvp+qShL/aDVFvF/QU1m28M+Hhw8lNwjAuNmF/xLyGlCT+FxkwRs+7SmICCAsikU/vedsK46tKdhPZAuUaUtrjQf1zwjoGGY4hlYy5W3muAF+GPTpYTPHGBn5jNeuID+Rt6kC8rC2mo6DlZj4JpN2VxrNKnwdn7pFBKdcwTvVmzu7aWHmjVcRieHaVrlHdvZ7++nyP3f76wt1dcgk1MFD12WN6OOdl8RIaNPJWmMEisueDWGKuLZ72hz9Pjn2Filg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OH9dZc+l9gJu4+3VjRMKxNudo8aJtGOIKI85+kCNUd8=;
 b=cn2e+trgjPlLNg1pioYN5G3fKRZmATrVNspj0g4jFl6sE/UOu9zWjinndbfaSGe1lvyicj273hp28GDPXS7LALiIcD0IVoF3B/0rgExtTtkuez9WrrgyzfE2z7ZqAjMQJFlKlOQ0MdiOmpfYAtog80eywRU6FCYkwWkGceRY8QnBO4XkXp9LUuq4cqkE1iYhK1f/qZJbL9y6SrTF4cjpRu5fJKnZr2sCpPdzYbmIOP81wqxkQ7yDDKR/fskUwAOkpWpeuHYN8Og+hZdLmuXdlKLTWmSs0VwuhMD2Pf0ni8PwCjNoUpWh1lHA3t1gFdjoxVznZ7sShbNosa3i2Af93A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::22)
 by VI0PR04MB11574.eurprd04.prod.outlook.com (2603:10a6:800:302::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 06:16:22 +0000
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1]) by AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1%4]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 06:16:22 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 18 Aug 2026 14:20:10 +0800
Subject: [PATCH v2 1/4] imx93: clock: add 900MHz entry to fractional PLL
 rate table
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-imx93w-v1-1-2b1784c35822@nxp.com>
References: <20260818-imx93w-v1-0-2b1784c35822@nxp.com>
In-Reply-To: <20260818-imx93w-v1-0-2b1784c35822@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Johan Jonker <jbx6244@gmail.com>, Primoz Fiser <primoz.fiser@norik.com>, 
 Lei Xu <lei.xu@nxp.com>, Joseph Guo <qijian.guo@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SG2P153CA0008.APCP153.PROD.OUTLOOK.COM (2603:1096::18) To
 AM9PR04MB8114.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8114:EE_|VI0PR04MB11574:EE_
X-MS-Office365-Filtering-Correlation-Id: c1aa467b-b47a-45df-f4ce-08defcf039c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|23010399003|376014|366016|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 2/9eARnqQ25Rlr8RfnZDliMMODLYnZIaQXpJx8ANeDBwaTpn9h6pscthFCjOHnPIBmTa5F1TgmtFn0/ncCA84+1tHec7p1Z0zDgUvFrVAAzw5T2dvGWVtFMqVk71aO/ovGgjRoFALZQF2iqL0HvgZpin8ocRyMP00sswceWQotG5ptizvDRaVfhgTy72IsOh5NqVAigqfInx588PoqzGBS+oAXVSaTEFAuCBUC7mvFU1byMkHn230CUgG4dUwv6r2vfGIshedqKxdnJWt13R2etGL8uyNUGsLxc12imF8/7gCWXak9KSYMa1kxdbVimdr2mO2m0ovuGsROH/IyjQuo6q8COA+tsj5XEydu/8J9fLHV7LwvQWOfw1fsga6KXIXQQQcfmqQ22WOlSUeOnMeMOJ/sMg8AMMdIoxdueHqfG3PzczEMay53YkyGGtPC5LX7hzIPzxycaV1QRiHboI01mixblXma+sOVFrd4zJHDlTyEEsbpJwa6/jCFvB/UjqHN4QrZWo/x+T2AEz1nTWZwCAoF41jmyTrRqNKExpAwQwukmq4GQnFkIr4qExVHjHN3H9KB7mSAlOHgwEbU1JlymlfXaRNdkbowX+0/dw9Ez1pXgJfHEZs/AKyOSgLs0j4ZTUdge5pFDLN2J8Spj4jdQI3k2tS7rxIp/SdZrVqJk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8114.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(23010399003)(376014)(366016)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVhKRXBrQnNOdStuYTNoUVh2NlNRRDRsWklqT0hDRTNXZ3laVzRPM0VWSXNw?=
 =?utf-8?B?ZEpSbEtldUJDRTJ2ckdKdUJLazJNQ2c1N2RkQlZJYVJuTFBJWTJoWnFuN3ZF?=
 =?utf-8?B?Yy9aN2pIV2FLVmd3ZGdSQVVrTHdlSGhQRnU2anFpeEtuNjAxdmhRTjMzZjR1?=
 =?utf-8?B?SmxHOXp3NWVJTHhFRlNlTXIrYUhyYmVUVGtMMnJpdTExcUFkOFJkOXEvWnVY?=
 =?utf-8?B?K0l5NlZWQjNHNGZEZGovdzhKSWgxUVp5MEx5VzdsZEg2MXJuRkNPbmM3TDFZ?=
 =?utf-8?B?VG9uV1VEbjMzekNpTW1ZbHlmY2FOMEZhbzE1UGF5Vk5BUlg2eXRmK2pBSk5Z?=
 =?utf-8?B?OW55T2FLZ01CWGJ4M0x1Q1ZtZGpqRUplQlZXdC9RSVJ3K3BwZmZNY2J4WnNX?=
 =?utf-8?B?WjVySkp2NFhDYXU2bWVlTy9VcWpYRit4MEovM1gzRjJtc1o4MnhDZmJlRTJn?=
 =?utf-8?B?eHMrSkhnVXNQMkVqNUE4Q2Jnb1Y4aUg4cTViWDZDMXJKMTU0bFhYS3Fnejg3?=
 =?utf-8?B?cFZlbGYycXFPeFBLUkxwdVo5OG9CZ2lNdzhLN2dhbkdISUFKQ2lvZFYvT3hE?=
 =?utf-8?B?MjRPMzVGRk5FOFVrdnVRam5OeXRVZ0FhZUhJekZZOGNOWnJ6U0UrVWdFZU5l?=
 =?utf-8?B?VnhoV2hKaEg0cmtWZStReXROSlJsanRBcFZLTVAxRld0eTY3RWpXSGppeUVN?=
 =?utf-8?B?YWt2K2pPSmt1NCttcEdGYjJLcUdqUFZ6YzV4aGhrZ1FzUFNxS3MrVHZ5cTR2?=
 =?utf-8?B?MjYzdkd1MFlUdk5kUzF1VXdPM0tHRzRsa0RDc3l5OHMzMXhoZGpCTHlGYVZm?=
 =?utf-8?B?Snc4TUFwK3dWYWFZV3RSS2k4M0xrd0FwYnJrMzdGUWJ5OVhNVDZrTE81N2RI?=
 =?utf-8?B?a0huSmpPendTY3lQTWRTVHUvaG5pbjh1M1VzOXFXaEJEYkEwV2E3OU1ldWZW?=
 =?utf-8?B?WlZiMTVGenczQnpxYnlWWmdZYUxyQXBJSEhQd0p3aUx3b25HT2JmS2RPYWhW?=
 =?utf-8?B?TVh0Sys1Q0pCSTQrZWhUenRtRFJCNzl5Y2FlcGhWQXh1cC9QelkwSE9FQkZo?=
 =?utf-8?B?MEtXN2dUb3dtRHY2czc2NG5ocWFZU0czcTZMSnNyYmdmVnFqL0MrTGk0ZTJH?=
 =?utf-8?B?STYwb2pjbDVTQXNML3JncnlSR0pEQmJSVGJVWWRoMFFhUUpqVEFFcVI5K0Nj?=
 =?utf-8?B?NUxqR2tGdDlVNE1majJVZ1U2dzU2V0ZPd2VVZ2h6cVl1SktlamNmZDVKQ3lP?=
 =?utf-8?B?ME1wNmlrTXkwdGU3cW42amQ4dHA0b0JNSGJkbWgwdm9uQS93c0QwM1MzbGlw?=
 =?utf-8?B?Qy9nbmpYd0ZqMEpMNmdWcHp3U3RVUmdROGt0WTd6M2l1RE1TVmVEZ1Z2Q2Ro?=
 =?utf-8?B?N3dVdnVKVmx2bVVxUlhCY2JsV2ZoTVcybUN5dkpQZGVwb0t3ajlIeG0zWi9N?=
 =?utf-8?B?c2JLUXY4VnF6YThsN0s5ZGFFdXhVc2FTU3poZlJ6SXdKeGgwZGpEWWszYi9o?=
 =?utf-8?B?L1JyMFNmWUkwSEYvRE1vQWpSN1Z4OUVHL1VuOW9EaGZNYXh6SElPOUZoRlVu?=
 =?utf-8?B?b1I0RWNYVFlva3I4TlZWRnhjWFJyMGxmbHhDZWxzSXlHMW51b251Ym1yYXBY?=
 =?utf-8?B?eHRvUVFFTzFvcnpZWVFNUzlKUTZNelJBc21Qa2dEZVQwQnJ3VWxWakVmK043?=
 =?utf-8?B?SkNkQTZ3a2VHN290eG10ZGV6T081VFk3amRoNS9XK1lhdjUxcTh5R3dlTzVk?=
 =?utf-8?B?NDJNdURVS1Bwait6MlFPcUZyTGJCL1p6SDgzNCtCRDRFTHlPL2sxVUhxNmFR?=
 =?utf-8?B?ZlBuWkxqVTBUbTlYN3hlQUdUOGMxVXIvem13dTFWcXdDbnY5NWxMYmZqTy9k?=
 =?utf-8?B?U1NnRFQ5UEtUS1NxUjVHZ2J4U2pXTkd2TldReThvM3VtekUzQWtDSy9oeFFB?=
 =?utf-8?B?VnFTbHAzell5bDBFRDdmU0U5YjRHZFhIVFFuVE1nRDVJLy9mZlY1Z3VCdTF2?=
 =?utf-8?B?RHNHSjZOY2o2Q3MzYS9DU3JkcHZIc2hwTHFhSTZPckxkV3FEMzZqeHk4ZE1y?=
 =?utf-8?B?S2JyQ1ZlQ1VRTVNqcDhFbkRTcVp3VFMvSStuODJ0QnpLTzAvb3RubGJWYWdi?=
 =?utf-8?B?c2NmSGNxSGk1YTVsNVJBaXhXb1ZVVUl0L0FKUEY5YnFHZ0VlMCtCcVBNVDBu?=
 =?utf-8?B?RURnWU9jb2RSeUZpRUE1a3NDTS9uMHdjcVpid2N4YnMyTENlQXk4K2pYTWs4?=
 =?utf-8?B?aTgwYU44QmxVeXBFSXRPZzNGMFRqd3hZS1VqVG44eXpsRk82QW1EQnpLcm1S?=
 =?utf-8?B?VGpob1NuTW5RZmRqU0Q2RmxGd3lGV0VuSVU2VTNkckQ4RFVTR1pDNk9mZmtX?=
 =?utf-8?Q?DP9IZZN1KSO347oYXhFf6JxrILwi5AtH3BkKY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1aa467b-b47a-45df-f4ce-08defcf039c1
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 06:16:22.7451 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dOkD0zzMGDF1aK1EqSOLU/9ioIlupFZ+rldbkCEPsCXJSlz2DDAjpsmmZjyyshT9AQ65GBmTzHma0ctwzhztb5jkDu/PMUnBVOyg6MXpqA64SnzvjtkcpUWtCB2wCyiI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11574
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Alice Guo <alice.guo@nxp.com>

Add a 900MHz rate entry to the fractional PLL table so that the required
clock frequency can be configured to support DDR at 3600MTS.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/mach-imx/imx9/clock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/imx9/clock.c b/arch/arm/mach-imx/imx9/clock.c
index 4ccff67b7ab..4b89ee3b2b4 100644
--- a/arch/arm/mach-imx/imx9/clock.c
+++ b/arch/arm/mach-imx/imx9/clock.c
@@ -33,6 +33,7 @@ static struct imx_intpll_rate_table imx9_intpll_tbl[] = {
 static struct imx_fracpll_rate_table imx9_fracpll_tbl[] = {
 	FRAC_PLL_RATE(1000000000U, 1, 166, 4, 2, 3), /* 1000Mhz */
 	FRAC_PLL_RATE(933000000U, 1, 155, 4, 1, 2), /* 933Mhz */
+	FRAC_PLL_RATE(900000000U, 1, 150, 4, 0, 1), /* 900Mhz */
 	FRAC_PLL_RATE(800000000U, 1, 200, 6, 0, 1), /* 800Mhz */
 	FRAC_PLL_RATE(700000000U, 1, 145, 5, 5, 6), /* 700Mhz */
 	FRAC_PLL_RATE(600000000U, 1, 200, 8, 0, 1), /* 600Mhz */

-- 
2.34.1

