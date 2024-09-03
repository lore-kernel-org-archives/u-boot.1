Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7E9CD3420
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 09:28:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2878E88B47;
	Tue,  3 Sep 2024 11:28:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="f9oC2XTk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACA5188B9F; Tue,  3 Sep 2024 11:28:26 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::615])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80EE88871E
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 11:28:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X+SY1tBe+804qiZIc69i/2//NGdmDKdRvT4w2Xu4tMXjyWz/7YEK0q8CWEaUYgu5L4hLjsUxkp659Yss+4CnzRNg94jIb7V6/xfIAsyGGuRRzqwkDerCg1QTMOPZYoP5TH5qy2rK0J/qJzTyDGVE2FMWEESttrvU8E/pTZii4TSgZHq7SQ1tCmXYcURoHJqmS5t0z8cp+GZMbyUvgGRDWmo72Ph2BMxJq8js5WAn+5RNoOlqhIP4Bt3+CAMu/Bomssu0VT5S7NmivrKahqSjPxz0SXsmQRPZ9qoSwMMPLqTK1vzdYhxpJlcPAGD8Vro/d1HUF5bD5zBwIexdm3IRjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0A/qsz4fmdl1Gpba/ZUBS3IqdztZ390oIEb/zrt8tlI=;
 b=vFABtLM2/x2MeH2w9hlCdVp/2AL4o4uJKxkbKtxFYr87JCi/TG5fyqFh6Z2/M/GfUumxvBTGR5+MUYpDXBA2Vn2GiNgzuJTl/DPVhiEZR5l+BdCZIbkWrQ9KhKN0CfAkSvQARp/Zz0fbB2LOf8gk3HBdMnA1ywS67raoZDS6kN6rsWdnmbPiJDkFdwoex2RIoRlrhgOh+4DL1dzLzQ7OipcouVnIyTlJxzKRVc74TV/yPMWK9dkAhXXBpnFPn15Pd+PhwpPp/YhsYnCzWz/zRFuRUCAocJ7cdsTESovR/znLcZP0X1GCvlOCkvHFawrBmt849S93YU7INsHq3bwzwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0A/qsz4fmdl1Gpba/ZUBS3IqdztZ390oIEb/zrt8tlI=;
 b=f9oC2XTk43G3UjdkcgiFBxMaO10vt0kW+58DpLSRyDgCmYRrdxqov1vRvhjfw/CIw4ypxPOkRtSw1FzDDFhyhs/RXrmklSUXC+bM881xqiHK+3wdWRXx+DhkU60YGb+h5UDb+Zyp2/kz9rEVnb3eY9Qvn5YacCJ6p4pJHHaJ59o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB8245.eurprd04.prod.outlook.com (2603:10a6:20b:3f9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 09:28:21 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 09:28:21 +0000
Message-ID: <63f3d458-e6c1-4995-b766-b0d04a69a837@cherry.de>
Date: Tue, 3 Sep 2024 11:28:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cmd: mmc: Allow using partition name in mmc erase
 command
To: Tomas Paukrt <tomaspaukrt@email.cz>, u-boot@lists.denx.de
Cc: trini@konsulko.com, festevam@gmail.com
References: <3hD.ZbWV.1{t85GxWb7T.1crWYj@seznam.cz>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <3hD.ZbWV.1{t85GxWb7T.1crWYj@seznam.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0262.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:86::16) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB8245:EE_
X-MS-Office365-Filtering-Correlation-Id: a54954d1-4571-4604-688e-08dccbfac0c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2x0VHNWZUg4dVE1c3Bud1lDa3lPUE1ncVhHZXdZZUhwQUd3ekxWZm83UzVh?=
 =?utf-8?B?ck1OSlUxVTJIZFhsK0NEWm4wTjVaa3JvVGtnc3plL01RY0hzWDlXNXdjbzN5?=
 =?utf-8?B?NnZaaHVqOFlCemxKaE5sRWwxMDdXc0JCMGRaZ2NUVUF6bzl5NTJSNE9EclJu?=
 =?utf-8?B?Mm1zR01iSXFBSHpZK3JhN2JuWnVSYjJiOHJPUHZ4Q2tHZ1d4M0Roa2VaYzht?=
 =?utf-8?B?ZURPeGpQanR1VkN1M0d3V21tWHhwSmwwU2ZKWDlQSEx4SHFGai9DamROSjJG?=
 =?utf-8?B?dGdUNFJJTmdVWUtrMnF6eUJ0Rnp3b2J5aUM2cFZxNDRMYkEyTUp4dUk2bitt?=
 =?utf-8?B?NkhPS1d6OGdjQ3lMaitxZ0wrcUs2aHRVMDR6bWo0dlJHTC83S0Q5OVpYKzFj?=
 =?utf-8?B?Z1pBbHZKZDhkTU1GeHBkalRtT0pHbkkxdTN1Q2hFSGhzZlk3RFJpRjFieEFW?=
 =?utf-8?B?allCdzFDNXR5ZzRUNFFXTkhzTDJEck1QU0hGc21NM0hLeFlVVExjelNFV0Ra?=
 =?utf-8?B?OENscXJKMWlpYTN6N2xuVzFDdjRBVDgwS0k3bGFJemlNN2NDUGJMUitLbzZo?=
 =?utf-8?B?bkFSS2lPY1VjZ1BscmZyaXpCZ1VCUHhvY1Q1dDEyZ0FYS2hmMSt2bk5lWUFv?=
 =?utf-8?B?dWFZTGl2bWhFTHZOSFNyY2FPbXFxVkdOZkJXeFMzSW9JaThraGJjVit4NUVu?=
 =?utf-8?B?aEp4OFplQkk0bjl3VzR5eFdMZjVSbWQxQkNZTFhlZjZRSmx1QjJYYzZ3bDk5?=
 =?utf-8?B?YldmT2lQOWc0MFdmSmFheTBvMWdPTmRQdGt2R1pOcUVlOFQ1cHVTaTB1eUIw?=
 =?utf-8?B?cFdaOXp6TzBPZjVDdWdHUzl2cnZQZTJ6N2JaY3JDZWhnNkFQQm1YS2dlUWp6?=
 =?utf-8?B?RE45R0JOSTZUTS96bk0zN3JleTZ6Vmh5Q09pampwaFV5UkQxTHZOY2k4cXIy?=
 =?utf-8?B?ZWc3NzFVL2VaV0MwQzJPWEhhNUIrQmUybUpObE80WkxKQ0dvZ05zRmROcUdG?=
 =?utf-8?B?WVZCSHhKUkpDaU1PbUtDaG5SL3NUUG1yUW5veFNUa3VTb1dJenB3d1R2cGlK?=
 =?utf-8?B?UUYvcTRGWGc1NkhySW4rZkIxQTA0UWFicjg0OEdOT050UzRCaEpOVDV1Zndt?=
 =?utf-8?B?bk4xWWczNjhkNmJVVVhlQVdvU2l0QVRSZkpYUHlqdFA5OVNrajdvNEtTS1lw?=
 =?utf-8?B?Z1FGSSt6dDF3eUE5UjMyckhtVGxJVDlhMlVLWERMRENpUSs2bEw5VDh0eTln?=
 =?utf-8?B?amhvNTF2cXd0N3dlVTdtTXdxWitGbFVqR3llalFWT0g3RkRld3BtYWFHNnNQ?=
 =?utf-8?B?MXh0R3JMbmdycFZrY1E3blpBWmlJWE1MbWsweEtBRUhyK2oyZnVsWDlkTmJI?=
 =?utf-8?B?c05qUEtOKy9LdlRaSmoxU3Bxc1h1dVhFdStCOWVZK1Z1SG02bitIb0JHZWNj?=
 =?utf-8?B?WUFaRFEzQ2crMDNmODVlQ1ppQ2ZoR3pmL3dDWCtWbE56N3VyUTlNNm9EUzFV?=
 =?utf-8?B?TEVONFF2bTdvU3VtT2k1a05LbU9aQ1ZkVHM4TloxVnQzWFRxZHBUSFEvd2pz?=
 =?utf-8?B?dVdBYlg0RUNzbHdTSnR4TGhPdXc1bTBtZ2QyaGErSUV0SFg0MU13Qm16SEJh?=
 =?utf-8?B?bkpKY0c5d0xsVEU4aGR0L290KzcyNDhEMjRXejhUZmEwMlpUckZEQnZmZjB5?=
 =?utf-8?B?cVF5YmlOa3B5RG1UakJQK21kdmRWdmtEWUdSNVRlV2ZtWXpIQ0tlSEVUNk1k?=
 =?utf-8?B?K3BqSlhBVzV3a3NlSlZwUitKTlRMaENTcGplbVp4V0gycnVuOVJxL1BpbHFM?=
 =?utf-8?B?Yy9ETEFJMlFOY2N1a3JJQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekY4NUlzeW9oR0c3VG9UU1ZiOWVlZDQ5cXdmRnRFRlhMeC9DdHJNT3JlNU9a?=
 =?utf-8?B?YVNrMjF6VVYrZXVOUXVDNmF4TFNrMERldmJWVS8xb0pHYk1BdlUzNFFVZkhh?=
 =?utf-8?B?UWN3OWpOZEdoSnp5amdlYmw5cG1pWW44anlDZ01remluOE8xVnk4TURkR2xS?=
 =?utf-8?B?NXowQTBjMHZJREJHNnlXMXNzS2xSN0tLYW1SOTluWnhYdTZJUUU2aVhBdEhx?=
 =?utf-8?B?ckF2d3dDdm1EL0M2QWY0RlNuN21ScVROTzVFaFRCWk13amdFYUsxRmp1dWxt?=
 =?utf-8?B?TmVJaUlHMmN5aFBPYXF2ZzcwOHdPemQ1QVd4YTBWZng4N002ZkVZNmpneDRJ?=
 =?utf-8?B?MXBIMi9TZnFIZ2NMcnI4WFE5T1lMZ2xmQzZrY2JmdXR3Qm16dGorTGdIV3My?=
 =?utf-8?B?aGJ0QUxiUUpHa1dYL1F5eGE3SmxxbGdudnJDUkJSRGZvTkJFNGFSUnplMmhM?=
 =?utf-8?B?UFY2ZkJwWHNyM0o2Yzk4UTRxY0RBSzZWM01jd1F5NS81L1hwR1pZWkVNR2V4?=
 =?utf-8?B?RWF1bk8xbUlYYUpWZ2poY0FMeVpFUzlzeEQ5RFZ0UEIvWWJUbzRnRjVWeFcw?=
 =?utf-8?B?c3dnTzBtaXphNy9UWVNlVlB2WFo2SVNaYnRUd3pGaTNFWEU0Ti9acW9xbHZq?=
 =?utf-8?B?U2hQQ05FN09IT2hWVWFMVThZNW1TS3lKSG0vSXA4LzkwLzdRbitzZzhvYTQ2?=
 =?utf-8?B?WGNOM1A0d3hZbmhIY2xwdUQ3bEJraGhmR0E3VlIrQ09QZUJ0RmFRQ29DYXNo?=
 =?utf-8?B?RWxJUmk0NU5XQ2YzRGxaNmkxeDNkd3F4Z0QxQkVVWVhyODJnV3NYV0Rod0VR?=
 =?utf-8?B?NkhlNVIrNi9DbEhNZ3cxT3BrK3BhVlpscjM0QUVnMENpdk1KWFdRbzIzaVEv?=
 =?utf-8?B?TzVvTkNKY01vQmJPbTJKbkpkYlFncnVOYTVldVR4YnFOUUJkeHNwYjEwUUtD?=
 =?utf-8?B?Vk92M2JHOTE1TlZPejN3RXk2MnlyR2twK1pZT0lobGpjS3g0SmpPTGJaNGFP?=
 =?utf-8?B?bzBMRXErOUJiSFNQTGFWQWppWmYrWnRUOWlLTEpJSGJVc01XSm1BcXB3M2h6?=
 =?utf-8?B?Z05JNnJYSW1zNlMyZno5cmhXcUdPT3hXamw0NExnS3JENnpLSFhBdERPd3B4?=
 =?utf-8?B?cElRUm8xU2c0eVNmbjRoWlh3VzNKdXhieWdSelJOM290S3FFTk9QR1dwZWpy?=
 =?utf-8?B?b2QxVE5ZNDFUNmdaTUtNa1hDSU4zVkZYZ3NIMTlVcERqNGdoVlVReUpRcDRZ?=
 =?utf-8?B?bWt2Y3lhUDRxTFFva1VXS0g0aGpFL1Z6N00vMWVrVHNFcU9rME9mcGM0Um9H?=
 =?utf-8?B?QWpsNS9PZFgwaWpMVXpGaC9iQWI2bnpLUzArNVZHeUlZczJYSHZvSko2bFFX?=
 =?utf-8?B?Q2JJY2NiUXA4am5oaWd6NTBkTW83U3Z0a3hiUkR3UStTYUIra1lCL3hwYStx?=
 =?utf-8?B?enluLzgyYkhVTCtGQkYrWVRPb3JkdWZqSTFJZzhQRktHM05wVFhId3JnMkxQ?=
 =?utf-8?B?RUFaSEVsQVBPL05DTzNFc0ViWFVpeWUwS1lQRjVJTjNiWkxKNXRNeC82bmRG?=
 =?utf-8?B?cVJaUFlUb29ZcHZ6cUlxZHVsTkNuQUxyYzhLdkhWd2VETEZPUnYzZXhLRkJX?=
 =?utf-8?B?OStYdWhkS0x4eWE1UWZvdGQ1L0xIRnZEaGtoMFdPRWRMZjc3WGRRYzZYUFZN?=
 =?utf-8?B?aGMrb3Q5a09PUzVSVWZadktKMDJKekV1N0xoM3ozeG1hUjJDaG9SV05LZERv?=
 =?utf-8?B?NkQ2Z29QNDFrcnptdHVwbE5haiszUTE3ckxoaUwyY3BYUVhNVVg4U0VkOThU?=
 =?utf-8?B?SVE5aDl5ODFqb0lkcnJDeW4zL3lKTFhWdFlINTV5SFhVZytHdytIaUFpaTNY?=
 =?utf-8?B?OUJLRnVoUVdDdnNHR2FOQzBaQkxLZnRoRUx5d3k3RU01U2RDclZVL2JRcUhI?=
 =?utf-8?B?MHlkdDdUUjFTd0drbzZjWVJyNTI2UWVnRjVvSE5RZ1RvSE1mbjZKMGhycUtU?=
 =?utf-8?B?TGNkZUU2dW1Fc3ZVTWVmWFdOZEdKTitHWkF0dnI2R013NWZweHRqVzNXZGxM?=
 =?utf-8?B?ai9tWXJoMnF6TTN6MFA5VCt4RkN4TTcrQjZDanFhWGIvK0pJVUJUeVBPbWZW?=
 =?utf-8?B?VE9haFB0MnhBamE3NjhpTHdVdnUyTDNTdENxZ3d1UjkrYTlEWnVJcXpWS2M2?=
 =?utf-8?B?S2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a54954d1-4571-4604-688e-08dccbfac0c3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 09:28:21.7590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hvhPA6PmlhrRBQsy0osYYwwLJGY/HqmlID348rm62D0ILC1wzGZrcbHOFWuM6hR3LZhlpOkAGKaYPb9kk1wfqBJWPZXUgHDFOOHlg5poUEA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8245
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

Hi Tomas,

On 9/2/24 8:49 PM, Tomas Paukrt wrote:
> The mmc erase command currently requires blk# and cnt parameters
> which can be obtained using the part start and part size commands
> if the entire partition needs to be erased.
> 
> Simplify the use of the mmc erase command by allowing the partition
> name to be specified directly.
> 
> Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>
> ---
> Changes since v1:
> - Swapped init_mmc_device call and argc check
> - Removed round down info.size to a multiple of erase_grp_size
> - Split the syntax into two separate lines
> ---
>   cmd/mmc.c             | 17 +++++++++++++----
>   doc/usage/cmd/mmc.rst |  6 +++++-
>   2 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/cmd/mmc.c b/cmd/mmc.c
> index 7244a90..2fc05f9 100644
> --- a/cmd/mmc.c
> +++ b/cmd/mmc.c
> @@ -472,18 +472,26 @@ static int do_mmc_erase(struct cmd_tbl *cmdtp, int flag,
>   			int argc, char *const argv[])
>   {
>   	struct mmc *mmc;
> +	struct disk_partition info;
>   	u32 blk, cnt, n;
>   
> -	if (argc != 3)
> +	if (argc < 2 || argc > 3)
>   		return CMD_RET_USAGE;
>   
> -	blk = hextoul(argv[1], NULL);
> -	cnt = hextoul(argv[2], NULL);
> -
>   	mmc = init_mmc_device(curr_device, false);
>   	if (!mmc)
>   		return CMD_RET_FAILURE;
>   
> +	if (argc == 3) {
> +		blk = hextoul(argv[1], NULL);
> +		cnt = hextoul(argv[2], NULL);
> +	} else if (part_get_info_by_name(mmc_get_blk_desc(mmc), argv[1], &info) >= 0) {
> +		blk = info.start;
> +		cnt = info.size;

Same question as for v1, are we sure that the partition block size is 
the same as the MMC erase block size? Is this guaranteed by all 
standards (all MMC standards, and all partition table standards)? 
Otherwise I assume we should do some maths here to figure out the MMC 
start block AND block size based on the partition start block AND block 
size and to pass the correct information to blk_derase(). I hope they 
also are guaranteed to be aligned somehow and that a partition block 
size is a multiple of an MMC erase block size? This maths seems to be 
done in mmc_berase() (at a quick glance, not sure it's appropriate).

Cheers,
Quentin

> +	} else {
> +		return CMD_RET_FAILURE;
> +	}
> +
>   	printf("\nMMC erase: dev # %d, block # %d, count %d ... ",
>   	       curr_device, blk, cnt);
>   
> @@ -1271,6 +1279,7 @@ U_BOOT_CMD(
>   	"mmc swrite addr blk#\n"
>   #endif
>   	"mmc erase blk# cnt\n"
> +	"mmc erase partname\n"
>   	"mmc rescan [mode]\n"
>   	"mmc part - lists available partition on current mmc device\n"
>   	"mmc dev [dev] [part] [mode] - show or set current mmc device [partition] and set mode\n"
> diff --git a/doc/usage/cmd/mmc.rst b/doc/usage/cmd/mmc.rst
> index 5a64400..55391fd 100644
> --- a/doc/usage/cmd/mmc.rst
> +++ b/doc/usage/cmd/mmc.rst
> @@ -15,6 +15,7 @@ Synopsis
>       mmc read addr blk# cnt
>       mmc write addr blk# cnt
>       mmc erase blk# cnt
> +    mmc erase partname
>       mmc rescan [mode]
>       mmc part
>       mmc dev [dev] [part] [mode]
> @@ -44,12 +45,15 @@ The 'mmc write' command writes raw data to MMC device from memory address with b
>       cnt
>           block count
>   
> -The 'mmc erase' command erases *cnt* blocks on the MMC device starting at block *blk#*.
> +The 'mmc erase' command erases *cnt* blocks on the MMC device starting at block *blk#* or
> +the entire partition specified by *partname*.
>   
>       blk#
>           start block offset
>       cnt
>           block count
> +    partname
> +        partition name
>   
>   The 'mmc rescan' command scans the available MMC device.
>   
