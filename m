Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D053CE7B1F
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 15:03:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 956F688CF2;
	Fri,  6 Sep 2024 17:03:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E5TU2JEX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79A8088CF2; Fri,  6 Sep 2024 17:03:50 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::61b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08E0188915
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 17:03:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XuCu+4pGk/SBoc2YK8ZW28AwX2rF2k0rdoPMm6NCUke0FIe8pHuWw9Zb88ZdLg5pz/aS2rcueDhzapWZWUDmti3PtG5LMFeZUqsIHsWOET5fq0ff0jDnetxBjtyFW0jDyayUetjHkBLBGqVT/Vdb8k2rFzK7UXogbvGa1vvD9QQ0DCZZemS6jByoq8hjrkhzPJLNCuB0jACDPbgM4W6vhH9yyeTuYuyRk/A9By3gQj1iSTBZXXOCPOGKTOibJR4PbNbfWpsWJp87hDYdW/+M3Dsm+GNJmRQXN42yzF4dYxvG2epXH+iIubwyR1ZG8qzonrQDFzu97q7PXo7/ADP1GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DEhgS5ajMZ6V7Hx17zu7lE8f8DTFW+VZ4rW+RUbWYg=;
 b=XpdoyAlp+ZpmNx6onVVo40frziC8GrVnf9zGnZZT0f6AmPYbS43YgVqG2StYcZe0vpJesOfmMiTXno4gOHinAd5Yv+J0kfyV1rIhKbe+uyQfUbI8aWjIwNTo4FALLCaivj3Imdjq215DBhLVjQkU2qLjPQSLtSRALkNaUODBE0Qia0tgS0SV1fmZiRA8DIFA9DWJ3IZbPPXcR9jRjSzElVoZcOLZPJIt7XJC08Z5NlG70s0sIXx+3u5b7WtRJMFJ83JO2BwxS7RqR3pZW8K5AetR4aXF28rZrR0S9h4wG3KG9Bthx/zZU8ZPLGKLguY5fN8ubCwh7yEw43mv2duesA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DEhgS5ajMZ6V7Hx17zu7lE8f8DTFW+VZ4rW+RUbWYg=;
 b=E5TU2JEXhyamFTnBAUkHuScWm7YweuxWm1NwahKf2QZaAEhCJFzTZhlwSsWGEKc4Tv31+gVnjnoxg9cTh4RomGjBkifpB9SL6Yg4cxwXDOg4pkSFvrt5Ty/rYZgoVNy2jYbhHlCF/R2raidWXzhZwnELw+pTGntOXf3WqHQ2l/w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by BL1PR12MB5777.namprd12.prod.outlook.com (2603:10b6:208:390::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 6 Sep
 2024 15:03:43 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 15:03:43 +0000
Message-ID: <a3f6f1fe-946d-49c4-a600-33bf8ffb11c0@amd.com>
Date: Fri, 6 Sep 2024 17:03:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Miscellaneous FWU fixes
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20240830114057.891069-1-sughosh.ganu@linaro.org>
 <dc2c0bd1-3aa7-4347-a4d6-5754a40e5b7e@amd.com>
 <CADg8p95OdP5DE39VO+2uu28q_MeYFD1qqUZOvoAXQwUztBGZmA@mail.gmail.com>
 <6f1e9198-e9ef-46e3-afae-62b3f84d97c6@amd.com>
 <CADg8p97A+CJjmEtiVVU3S4GLvEie2FFNi6nN2Ho4ZtAceddJ=g@mail.gmail.com>
 <17fdf962-20b7-4bb9-93ba-bdb7335c4762@amd.com>
 <CADg8p979GVQ+bk4RYUmE94Fnd1jQ6sv41V82ZRW=+gjRhn6dwA@mail.gmail.com>
 <41f4766b-7861-4608-905f-9717e6fdc230@amd.com>
 <CADg8p97-Nbn0AsnL4Tu=375uoONmPSgr9Yj0MnEB5u1O8P0AEg@mail.gmail.com>
 <db7aaa38-d66b-4575-a50c-0b1bdbcda9eb@amd.com>
 <CADg8p95Sg9ASrTOXOGJz8-HcFxuadRL6K9URYAQdZGCZ9NPgQw@mail.gmail.com>
 <1bf05e73-3ef2-4f15-87ab-64c32d60f924@amd.com>
 <CADg8p96KRn1i0amuxggwPr3CET+8AGPc7zkkvhvkjyhWXMPkEw@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CADg8p96KRn1i0amuxggwPr3CET+8AGPc7zkkvhvkjyhWXMPkEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0084.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::25) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|BL1PR12MB5777:EE_
X-MS-Office365-Filtering-Correlation-Id: a151e017-154b-4736-290f-08dcce85198e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T0N4V2ZSUXY3R1FRSkR0TmlJQWZua2RzY3hBdTg2V1BMSlFNdVBGNDdBVkhI?=
 =?utf-8?B?TDk5SCtUZEFJdXJNNmx0VGlGMVRYbG5xRG1VcHQxcFJnL2QyY2ZjbzR4eDdm?=
 =?utf-8?B?V0NOVXlvNjBoYlE1Sk9YdUNXMmtHLzhJVUhmUmNCNk1CR3BFYjdIb0RzSmh6?=
 =?utf-8?B?OEFEcncyQXFpUEl5bExlK0dnNVAvUm5tYkJXcGMwNld1SHZlQmRQclhlRE54?=
 =?utf-8?B?WCtiNk5UUXRCYVlWVzRIOEp5RDhsQW5SamlPMEhnK0l4d3JMTGdPUndyYXJI?=
 =?utf-8?B?SStPdUxCeC9qTzFxaTliMGVnRzVoSmV6amU4b0Q3UVZSMUQ5T2xTaFp2NTll?=
 =?utf-8?B?ZXVPN3VxcmxzUWp2c2JSbDl4WEkvdVVQM1VpZ1lXb29kNC85b3NaTDVBQ3Qx?=
 =?utf-8?B?TzlTQk5JWmN0WWJUbnV5emVuYS9GcmdXemJxVVpkOUpYQ3YrM21kdDVnMkhP?=
 =?utf-8?B?cG1QYk0wM2owT0ZIRVAxMzlHRERCMFNLS3ZGaGJQUVJEb2hOQUd5K3A4bDg3?=
 =?utf-8?B?Y2k3ZE1Rc2RLMXVXWFBJcDNEdEtrUFlxWThrME5LQWxabWtCeGRldGRxTi9k?=
 =?utf-8?B?V29Bb2xDbXYyNElSYlROSS9UbHl4STA2dC9UbVJkL29vMS9KMHVsYUFRRXZt?=
 =?utf-8?B?TWVZbzFDT01Gbk42eFdOTWV4VFFGcWVENnI2QzluLzNaMXVuRjVkUTM1Y2dB?=
 =?utf-8?B?aE5nYktYaFFnM3NMUmViS3VwZ3JhbWplNnZwbURTdDYya0N4YW4rUlhEQ2pL?=
 =?utf-8?B?WlBsbEZPZHVCeUozRVRxNEhpTnVISkRVWnFSY3hFTjRzWGRubnAveUdkUGJF?=
 =?utf-8?B?TVh6eFpOc1dwbExMbkY2STlJSXdraWpseGUvSDhOak9ETVdSemViRWdvTFJj?=
 =?utf-8?B?djFydit5T2Fzckxtd2JmOXZreDFzS1lmVWV6N3RkL1hleUQ2V0VSOFc3c2cw?=
 =?utf-8?B?aHdzLzVNVGFXSnB2cDFjWlBZTW14UVN2MTB4S2VlNGd2TnFmeUUvaXlHUGNN?=
 =?utf-8?B?djJiR2tJcStxT0FoYTdvQWNUNGZDZkp1Y3dFMzBCbzVra2FqbWpWdkV0a1Vv?=
 =?utf-8?B?QWNmVnQrRWVpQzE1R09QYk1QUEJLVmQvblc3c0hSQVdwNWJLbEIrUFllUHRo?=
 =?utf-8?B?TmRLdXhTdUdVc3p5SkIzNmNqQU1nNEtZRHJmeStKa1l1REoxL1FyVm43RGtZ?=
 =?utf-8?B?VTlDSmtqY2M5MjJXS2VmNXFuaTAxZE1Vek9yazlEcno0QWNEMWZtcTIvbnZI?=
 =?utf-8?B?RXVwTHBqbDErZU9senhJTjBqc3RHVUNUMzRqb3AzblZqOTNMNTU5QzBIZzFm?=
 =?utf-8?B?ZC9oc3p5c3lhdzdqem4yUTdTRWNtVCtqOXlZTVdaWkQvc0hReDBtMWFiMmgw?=
 =?utf-8?B?QUdkQzBvQU1LQTBha2hzZWU3MmVWd3RWdE52OVRNWkxudWQyTUtiOHlibGtW?=
 =?utf-8?B?Wll5Q0JkclFUMXpDencxNTBrcWU4WnpobnNOTGpDRjg1WllCaXhIMHg1ajFU?=
 =?utf-8?B?ZEJ4SCtwMU5BT1Zkb3B0SWJzQk9IOEpDb1oxMmpMSExFN3NZV2lqUVdGZnJV?=
 =?utf-8?B?VkZHNEY4ZkwrbjZ5NHJFS2twNEducFZva01WcXlYK3RYTE5lZEU2ZTZXNzdN?=
 =?utf-8?B?WTdpaytVdkxsdkJhOUFQaGJhZ2czTU85WWM0U3JhcEt0SVNySkJQWXlhQ0Q2?=
 =?utf-8?B?YTB6dzlTM2NZMU1aM2t4ZDRaSHNROURJUmlMeTdtRmpla3RvNTlsVW9sNGhu?=
 =?utf-8?B?bldrMnVBYWVDam9RYTJKRGV0R2crMm9qQitqT05Scm1jbmZPVEJvUWptNjNR?=
 =?utf-8?B?bFlQRElyaDZ5TVFkUVdTdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnRjbFB2Sy9BOHBLbGNUUUt1TGVoQXAxOHhLMUpzZ0tMeHl5ZEc5S2NLQnlr?=
 =?utf-8?B?R2h1b01mZW1RRWJBV3FOYW96UFY0QkZMVDBnMmhsNWJiVmtkSmJ0aml4WXAv?=
 =?utf-8?B?cGhnRlFpL3YwMm9XRTRIKzZ1aVIxVWs0dFI3VG1XaGN0cmFqUkxVcmZLb0hV?=
 =?utf-8?B?MndBRDAveUdDOVZXeGJobVRBTjhTSEdPdjNuclZPRElzZ2p3MUdIYWR1bWVV?=
 =?utf-8?B?WWN4ZVEzd1pkVlhrTmwzdE9KMk1EdzNDbE02RXBJUHJrUnZXTXpxcmtLNlAw?=
 =?utf-8?B?S2lpNTRmQTBpZmdJNHZFaWpwd1RFZERldFIvTzkvMUliOEhKdFdlcUpYenFO?=
 =?utf-8?B?Ym4xaERvRTBLYUVuQUxjbFpVYkVsZzBESUdZaHVlQWkvb0ZTNWNDMTM2UkJz?=
 =?utf-8?B?UnZzcG5Ddy9JZUVVb21Id0ZPZFY3ZEpFQWtQM1dScGkrb25wSnN0VmVPajZu?=
 =?utf-8?B?U3VmOXhJNWh5cG41N2pjTkRjK1h1OGlDNFQrckVTM2JSa0gxYXZGSGJOYzRE?=
 =?utf-8?B?d3NjcE1vd0VHWmZVcnZBSWVIUC9ObXVRdEFrL2NjK2Jod2Y3OE1KZHA5S3da?=
 =?utf-8?B?SnFzczVtNTlDcDhDYkxTNkxMQk5VWnB4ZzBkRjc0cGxFNy82R2dMalBRUmtD?=
 =?utf-8?B?NkF5eFlEYzdjTnJDWFd5VjdNalNQTWtzZi9WZ2xBRDBrMDB4TVRRRHFRM3NR?=
 =?utf-8?B?SVF6VnJscUVFbDdCMVdORmNXVWM3c3p6NXVXNEQ1YzNDT21OVXZ0Z0U5WGJF?=
 =?utf-8?B?OTBKVUhjM2s3c1hjM3hzMExPNUgwMlMzMUdUNFNORnl2ZDJMdm9aMjNVajZm?=
 =?utf-8?B?Z3V4Yk5pRG93NVB3c29QMVZRVHc2MUdDZXlHSm1xT1k0SDBoY1NEZUNqZHJG?=
 =?utf-8?B?b2NqK3lmT1hWRjU3dUtWU1RDb0E5UlgrM0VHUzR2aE9BR0ZIN0dGeitGZFlC?=
 =?utf-8?B?cXl3aEJCcXFHRjVJa0EzM082KzdxM1p1NmVmZ2JUVS9NcUhVWktwemNudjd3?=
 =?utf-8?B?akZEWVVnRm1lVW5DZ2ZYdGlmQjVTWDZIcjNXYWFweER2eUxwc21GT3dtdngz?=
 =?utf-8?B?MHBYc21iTnI5UmhQSFpnb2poNXc3Vmd5ckhnZFZpTEpBZzBOdzBQM1ZHZVND?=
 =?utf-8?B?cVdacC9Nd0wvRGk3ODZFRlRMWlVhZHVxQVNSQnZYaGlyQ0t6U2RUdzN6SGxM?=
 =?utf-8?B?YUNjeVhQUndIalNTRXFjN0pMQVhhV3U5ZUx6anlqZUs0N2E5ays3bEpDYUVn?=
 =?utf-8?B?cmg2N0g4VDVocGxRbTZzYlFjNDYrdE1TNnhwdk1GSjFuN05sdGx6bEhhL0pP?=
 =?utf-8?B?ekk2aTlST0YwaS9VVFZUcC8zUFlpN3BXekE0SHZmS3I1Wno3NHpFOWVXbXph?=
 =?utf-8?B?NERKT2djamc1N2NXeFVqZHFNd09NdWxzQzdDQ3loY3N0Y2g0Q3V6NEdJSnhy?=
 =?utf-8?B?cERtbElNWFh3ckNEMFRvcG9KRG43akYxaVJHTGJaTUYvSGl1aWErRzFuaU14?=
 =?utf-8?B?ZHgxekttOHhIaXpuOEJBV1EyeDRUdk43bGxJM0NDVktwVm1nZkJjMFZXeGVi?=
 =?utf-8?B?U21tR3Z3QVV0U3hPMmVGaUMyUGNPYy90K3c1TnMrWFZzTHVkTFR1U1lkSGJv?=
 =?utf-8?B?YjdtY1FYR3ZlT0ZxV3plSFcxUXZhTW1YT3IycGFLTFN3cm9NeWJsYlpLdHVR?=
 =?utf-8?B?dDRlRkF2dzFQNiszRjFoQ1NtMGVRWXYwY1BidC9Lc2RZamswczNPcXJnMG1y?=
 =?utf-8?B?c3pENzcwT0x3WkZIVG5tZHZGekhBRStFV1E4NXNyM1plbEZDekdHYW90alNV?=
 =?utf-8?B?cTJsWWhXbVJnYnJUWndiaTB3TFZvY0JOS1Z1VVk3WENvWityTmNVRHhmdHpk?=
 =?utf-8?B?MDRHUlpkK2FUNEdvNzRpb0VaNXg2aS9Xb1BuK0Q2dElWZG50SHBLb2RHdktk?=
 =?utf-8?B?QnBaWEdXc1JkTTBWK0U3OG84QXd1S3VjZmM3WVRTVDhEdVZzTjlXMHZjL3cz?=
 =?utf-8?B?NlprM2JVUmZOaks2bWpST3ZUbDRDUHd5U0ZPdVJzaEpzdEJSS2NMSGJSWVRa?=
 =?utf-8?B?ZFRGSkJxRnZwODA0Q0NBNzNJQnR6U01vSE0yR2tadDFBYlIzUVp6NXhRTlo5?=
 =?utf-8?Q?+5Fa0V/cR4pKmFkCGQpzjmVGq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a151e017-154b-4736-290f-08dcce85198e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 15:03:43.5190 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cMWkSmqQB2EUhU14ioUxJdTi0dkSYBEEzCSoBDodWq9psTkDuqqos1LLtKl7Quug
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5777
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



On 9/6/24 11:47, Sughosh Ganu wrote:
> On Fri, 6 Sept 2024 at 12:05, Michal Simek <michal.simek@amd.com> wrote:
>>
>>
>>
>> On 9/5/24 11:17, Sughosh Ganu wrote:
>>> On Thu, 5 Sept 2024 at 14:07, Michal Simek <michal.simek@amd.com> wrote:
>>>>
>>>>
>>>>
>>>> On 9/5/24 10:12, Sughosh Ganu wrote:
>>>>> On Thu, 5 Sept 2024 at 13:20, Michal Simek <michal.simek@amd.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 9/5/24 09:43, Sughosh Ganu wrote:
>>>>>>> On Thu, 5 Sept 2024 at 13:09, Michal Simek <michal.simek@amd.com> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 9/5/24 09:38, Sughosh Ganu wrote:
>>>>>>>>> On Thu, 5 Sept 2024 at 13:03, Michal Simek <michal.simek@amd.com> wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 9/5/24 08:24, Sughosh Ganu wrote:
>>>>>>>>>>> On Wed, 4 Sept 2024 at 17:30, Michal Simek <michal.simek@amd.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> On 8/30/24 13:40, Sughosh Ganu wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>> The following set of patches are miscellaneous fixes and some
>>>>>>>>>>>>> hardening of the FWU update logic.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Sughosh Ganu (6):
>>>>>>>>>>>>>          fwu: v2: perform some checks before reading metadata
>>>>>>>>>>>>>          fwu: v2: try reading both copies of metadata
>>>>>>>>>>>>>          fwu: v1: do a version check for the metadata
>>>>>>>>>>>>>          fwu: check all images for transitioning out of Trial State
>>>>>>>>>>>>>          fwu: add dependency checks for selecting FWU metadata version
>>>>>>>>>>>>>          fwu: do not allow capsule processing on exceeding Trial Counter
>>>>>>>>>>>>>            threshold
>>>>>>>>>>>>>
>>>>>>>>>>>>>         include/fwu.h            | 11 ++++++
>>>>>>>>>>>>>         lib/fwu_updates/Kconfig  |  1 +
>>>>>>>>>>>>>         lib/fwu_updates/fwu.c    | 31 +++++++++++++++-
>>>>>>>>>>>>>         lib/fwu_updates/fwu_v1.c | 18 +++++++--
>>>>>>>>>>>>>         lib/fwu_updates/fwu_v2.c | 80 ++++++++++++++++++++++------------------
>>>>>>>>>>>>>         5 files changed, 99 insertions(+), 42 deletions(-)
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> I found one more thing.
>>>>>>>>>>>>
>>>>>>>>>>>> I did this change
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/tools/mkfwumdata.c b/tools/mkfwumdata.c
>>>>>>>>>>>> index fbc2067bc12d..dab9530e499c 100644
>>>>>>>>>>>> --- a/tools/mkfwumdata.c
>>>>>>>>>>>> +++ b/tools/mkfwumdata.c
>>>>>>>>>>>> @@ -293,7 +293,7 @@ static void fwu_fill_version_specific_mdata(struct
>>>>>>>>>>>> fwu_mdata_object *mobj)
>>>>>>>>>>>>                struct fwu_mdata *mdata = mobj->mdata;
>>>>>>>>>>>>
>>>>>>>>>>>>                mdata->metadata_size = mobj->size;
>>>>>>>>>>>> -       mdata->desc_offset = sizeof(struct fwu_mdata);
>>>>>>>>>>>> +       mdata->desc_offset = 0x21; sizeof(struct fwu_mdata);
>>>>>>>>>>>>
>>>>>>>>>>>>                for (i = 0; i < MAX_BANKS_V2; i++)
>>>>>>>>>>>>                        mdata->bank_state[i] = i < mobj->banks ?
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> to break desc_offset location. I generated mdata structure and write it to
>>>>>>>>>>>> primary mdata partition.
>>>>>>>>>>>>
>>>>>>>>>>>> This has been spotted by (my debug) which is the reason why I did it.
>>>>>>>>>>>>
>>>>>>>>>>>>               if (g_mdata.desc_offset != FWU_IMG_DESC_OFFSET) {
>>>>>>>>>>>>                       printf("mdata offset is not 0x20\n");
>>>>>>>>>>>>                       return false;
>>>>>>>>>>>>               }
>>>>>>>>>>>>
>>>>>>>>>>>> But I got one more message below which
>>>>>>>>>>>>
>>>>>>>>>>>> mdata offset is not 0x20
>>>>>>>>>>>> Both FWU metadata copies are valid but do not match. Restoring the secondary
>>>>>>>>>>>> partition from the primary
>>>>>>>>>>>
>>>>>>>>>>> The reason why this logic is in place is to handle the scenario
>>>>>>>>>>> whereby, during the metadata update, the primary copy gets updated
>>>>>>>>>>> correctly, but due to some reason (like a power cut), the secondary
>>>>>>>>>>> copy does not -- this is because the primary copy gets updated first.
>>>>>>>>>>> In such a scenario, the secondary copy of metadata can be then
>>>>>>>>>>> restored from the primary copy. In the scenario where the primary copy
>>>>>>>>>>> is corrupted, it will show up in the crc check, and will get restored
>>>>>>>>>>> from the secondary copy.
>>>>>>>>>>
>>>>>>>>>> But in this case - CRC of primary is correct but data inside is wrong because
>>>>>>>>>> offset is at 0x21 not at 0x20.
>>>>>>>>>
>>>>>>>>> How will this event play out ? Am I missing something ? When the
>>>>>>>>> metadata is getting updated, the offset will be written as 0x20, and
>>>>>>>>> not 0x21. And in case the metadata gets corrupted, the CRC check would
>>>>>>>>> fail and the primary partition would get restored from the secondary
>>>>>>>>> (assuming that the secondary copy is correct).
>>>>>>>>
>>>>>>>> It is not after update. It is initial state with incorrect mdata structure.
>>>>>>>
>>>>>>> Well, if the metadata partition is being written with incorrect data,
>>>>>>> not sure how we combat that (or even if we should). After all, the
>>>>>>> spec clearly states that the metadata cannot be protected against
>>>>>>> malicious writes. The logic that you pointed out earlier is to handle
>>>>>>> the scenario where the primary partition got updated, but the
>>>>>>> secondary did not.
>>>>>>
>>>>>> I don't disagree with you.
>>>>>>
>>>>>> Scenario here is that primary partition is updated with incorrect data content
>>>>>> (but still correct CRC). This is correctly detected that data is not right.
>>>>>> It means primary partition is wrong and shouldn't be used and it is not used.
>>>>>>
>>>>>> But because it has correct CRC syncup code logic is doing syncup.
>>>>>>
>>>>>> That's why I think we have two codes which have pretty much independent logic
>>>>>> what to do. If primary is wrong sync should be from secondary to primary but
>>>>>> that's not what code is doing.
>>>>>
>>>>> The scenario of "primary is wrong" will only play out in case of
>>>>> corruption in the metadata. The scenario that you highlight, that of
>>>>> the metadata being wrong, but the CRC check succeeds will only happen
>>>>> when the metadata has been maliciously written --
>>>>
>>>> yes. And I did it on purpose to check your code and all error condition you are
>>>> checking to make sure that code traps them.
>>>
>>> The code should detect and fix any genuine error conditions that might
>>> come up in the field. Even the check for the case where the two
>>> metadata copies are valid but different is a scenario that can
>>> actually happen when updating the metadata copies, and there is a
>>> reason why we are assuming that the primary is the correct copy and
>>> should be used to restore the secondary. If there are any valid
>>> scenarios that are not being handled, they should be identified and
>>> fixed.
>>>
>>>>
>>>>> if not, then the
>>>>> secondary partition should also be written with the wrong metadata,
>>>>> and the checks would then fail. In the case of the primary metadata
>>>>> getting corrupted, it does get restored from the secondary partition,
>>>>> assuming that the secondary partition is intact.
>>>>
>>>> When primary is cleared/has incorrect CRC there is no problem and recovery
>>>> happens but if CRC is right but data inside wrong code doesn't check it.
>>>
>>> This is where I think that this is not a genuine "error" case. So, if
>>> someone has written a metadata copy with wrong data but right CRC, and
>>> only written this bad copy to the primary partition, how do we trust
>>> that the secondary copy is actually correct ? One can generate a
>>> secondary metadata copy where the primary checks pass, but the image
>>> information in the metadata is incorrect.
>>
>> If U-Boot knows that data is not correct, based on it's check (in this case one
>> incorrect field), you should never use it. If second also won't pass this check
>> U-Boot shouldn't use it too.
> 
> The fact that we are trying to counter incorrect provisioning of
> metadata, which can well be a malicious act of writing incorrect
> data/correct CRC copy only to one partition seems like an anomaly
> which should not be handled. I would still be okay if this were a
> fool-proof way of fixing the board, but it isn't. Like I mentioned
> earlier, we can still have a secondary copy of the metadata with wrong
> data/correct CRC, and which does not get detected in the initial
> checks, as the top level structure fields are correct, but the image
> information is not.

Partially agree. You are checking in fwu_mdata_sanity_checks and even data is 
matching u-boot configuration. You are checking now num_banks, num_images. guid 
should be also known to u-boot and I can't see the reason why this functions 
can't check it too.

And more and more I am looking at the code more things that current 
fwu_mdata_sanity_checks should be called before you mark parts_ok[] = true.



>>
>> If secondary copy pass all your tests you trust that it is fine. But if not,
>> then you don't trust it.
> 
> But we cannot detect that the secondary copy is passing all the tests,
> as the issue could well be with the image description, and that would
> be detected only when an update is attempted, or the user identifies
> it (possibly) using the fwu_mdata_read command. And before that, the
> primary copy would be restored with the incorrect secondary copy, as
> part of the metadata read function.
> 
> What I think can be done is, as a middle ground, we can instead have
> this as a platform policy. So we add a function pointer for this, and
> when such a scenario is detected, the platform can have a callback
> which then restores the primary copy from the secondary. What are your
> thoughts on this ?

I have to think about this more (not on Friday afternoon).

Cheers,
Michal


