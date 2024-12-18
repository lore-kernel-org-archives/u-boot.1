Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F36B4E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 09:18:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF5788022B;
	Wed, 18 Dec 2024 10:17:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="Q92lu9rJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42C1380269; Wed, 18 Dec 2024 10:17:59 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2071f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::71f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AC728021A
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 10:17:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OnL3BhzZZExCbzDjqQMJr4gnxwen0GKdYnyK6LM7iPTIJaTz2ZhDzhenHuAFdASoFFPJ+u+jF0Y25MYuZpokA1jTwQEzTnVSwY5ig+JyyrL2XmQHdwuZP1zrQr+3Q7mfbxsSwVx1+fd5Omm78au3s4eichTnj51ZnVVnKCEdDUStn6meVzICbjK6n1qdfRpjvtuYXRVxLikHMBPvwjb7ahvRuzkEhyAZL/OQuRY1Og+rxnQGposo4Zb5s530ipoEIf+C+9Eb3p6+QKtu/q9dqnyjix/LrOt4cZtAt3iDj1PsfFJRXnMKELYRXnj31XrpM0MSg7VuRSpixLIKqn1bBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdlUcqTuzfm62Tl1INmAOpmWcccmR0wF5B9Yuxgvag4=;
 b=HZjqDh/8wsmuZnyY3vBXUjwoWtOVUFJk6d6Jc8RvaJYYE4f0FQgo8V1IlrInZ4WU/Oee5XxEdnjZAyxD9PJPkRW62B1NpGYKOg4vqM/cFt1DXECCmIpRwv6g9Mx7ZpzOPcDcGbaUK/tkevKNpzVNn6LMChAXmSoL3TpXYvDLBRQwoodF0tLCMIWDYk5wP3tanfuuEcW10FbovkmNMwQa6TB+fyd9KFP7xzae8xrJujs2zVFWB0fiJaXxktE5BtF16x9mnFUIn+TS5gvdQKwXLyv/QVgcRs1I3iiqoP2XgEeRVjPuDyCi12MjQ0Mz4i8TzbrY3v2SuIBi03jfDqQtSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com; 
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdlUcqTuzfm62Tl1INmAOpmWcccmR0wF5B9Yuxgvag4=;
 b=Q92lu9rJ+dwqhsk6MmgNkK38rJVvzMzhfBAgqCtiyT6hpN9oZy3iV0NlRgtHEG24vhHnrg2ByuiCIfKAamzzTC1q+8ZBp2vRlSIGFj4PujbfBLrlEE2OQ3PAbFY+Qo7brunSfJczLOjmN0foBdbioszG6+YPWnIT5z8w5EJ4+sE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AS4PR10MB5943.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:51b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 09:17:55 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%5]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 09:17:55 +0000
Message-ID: <93a5b107-63c7-4d44-a0f4-f4079935f8e8@kontron.de>
Date: Wed, 18 Dec 2024 10:17:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] imx: Fix usable memory ranges for imx8m SOCs
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, trini@konsulko.com
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Vitor Soares <vitor.soares@toradex.com>,
 Paul Geurts <paul.geurts@prodrive-technologies.com>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
References: <20241218090007.692815-1-ilias.apalodimas@linaro.org>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20241218090007.692815-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::9) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AS4PR10MB5943:EE_
X-MS-Office365-Filtering-Correlation-Id: 249268b5-a220-4a12-1489-08dd1f44db67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OFZMSHphaFc3Skg4VVUyd0ZWUS9Fb0JISzZIOFpWWGRKaUZKZTMyUUxLUUh1?=
 =?utf-8?B?VnNRS1A1WGQxbWZ4ckxFVnVZbk01N05hdmVnazdxL3Y1bFg4byt0Y1hiZE9H?=
 =?utf-8?B?Y01VdFFWb3ZUK3JCbENmZU1tbnlqYUNJNHBXN3ZOWlZVS3VGM01HN2RTQ0kw?=
 =?utf-8?B?Y0hlK2VkSzlpY25sMitWNXNneGlTUDg4TjY1VVYxWUp0S3ZWSHZ2eW5aUlo1?=
 =?utf-8?B?Y29ZSm8rV3FmZ0hDOHNUMEZ0a01qbG43eGdKZWRNSXBKVi9aaFNvM2p1bnNr?=
 =?utf-8?B?c1ByVnJPWkNodE4xRVVRQTRUbnRuUGFCd09CMDdmSVBBT0k0SFpUN0V4bSto?=
 =?utf-8?B?UXVqTDZlWmlGQm9pU1YxajduNmoweVpaL2xHWlF4Q2JRTjZWNVNjNXRmSFBv?=
 =?utf-8?B?eSt1QzRkd0hwWVluZzREQUt5RFJBM0VhMGt5U1dGRkwvV0RubXRQRFVsNyti?=
 =?utf-8?B?VDdJZ1huRkpibUZnME9nWWFzVUhEMHRxcEh6YkpVYk5wT3BGMWpLdXZMQ2RQ?=
 =?utf-8?B?Yk02cGpLVUxUbFZlN2tpd1RDMFVRRGdpZVlVQ2dmUGNrYVlWQnZXRlFTTy9I?=
 =?utf-8?B?ZWdkV3c4Unc1ckVGZkw0cExjU0RIVVJzVTVlYjRzY2lSWkw1UVp6VWJydUdx?=
 =?utf-8?B?aUJUTWVWTFBhMDkreG84WEw1U1J2bWd3OU5xTUxUakNhOW8vNDFWVkpNanZL?=
 =?utf-8?B?WjFJTTVERHh5N09wTGQ1NzF1TW5jVko2VkU0SWtzeERjZWpzdWV3bXFBc21U?=
 =?utf-8?B?cE1OSWh3ci9IcjBxcmora2llaXFNbjVGRE1ubzhUdmVLNDlVTDhoNUFPcEl1?=
 =?utf-8?B?TDJpS29aODBNcVplMHE2NGVIRDFVamtQdHBPdlZSbmdIVFFUdVEzQndpTzlU?=
 =?utf-8?B?WGVpcHM2bk0wWkd5WElpbFUxeDFrbHVId3NuMXoxV3Z2eHhBd1JaZHk0RUtX?=
 =?utf-8?B?SW1IVkVDS2FlNE5Cb0htTzUxYVZubStraUIvOGxhaVh1QlVpUkhicWhTVlcx?=
 =?utf-8?B?Mi9JWnMvK1BncEFRZWtJL04vVUwwNWcySzFqT0k5aU1SZnhFRTJ6MzJ3VzAv?=
 =?utf-8?B?THprWDRhZi9oeXU4eUpUbWZzSk1qVGNTcW1CaFNmTVFpTHo1NUZiSENENzZl?=
 =?utf-8?B?OEZOVHRnWTBFUGx5Y3hVaUtvMjF3OEoxZERCSnBKeTRvb0hvcXdjaXczNDQ4?=
 =?utf-8?B?UFQ4TE1XMXZEUGZhMFUvVHNLbW5qS21SSVAyc0ZEQlFQdFVSZFg1V0pyNzBP?=
 =?utf-8?B?YVpwY0lBakxtQ3I1VFI2SExqMi9EaENrV3dHTHBCcjZwWDBVSmZ0UkpJSnRi?=
 =?utf-8?B?NkRWZVdtWDRpOUxKZC9XR3lOQ2ZjTFludURvZ2Q0dktJa3FUZVhjVmF2OVUx?=
 =?utf-8?B?K3VPOUhMSE9NaGxleUM0K1pyN2tIOTVHVHF5QWZWanJOREp2ZjlGM0FmZkRP?=
 =?utf-8?B?MGE0dk8ybFdFMUh2WHErZzN2NWViS2p4b3R5ZUNvM3RjREg4S0orbjRxWThn?=
 =?utf-8?B?MEVMRWQ2UHhhc3lqTnBLTDYwT05VZCtVaVFJaXpDLzZLOWRPWjZMQ1JUK2RC?=
 =?utf-8?B?TjVFaXpta3VVTHgrNTB3MVZ2NHNOVnlpcmV6KzErdzhEK0JUcGRjbGdBZGhN?=
 =?utf-8?B?T3A0cmhWRUJCVi9yZTh2MUc0THg0OUl5dzJJM2MzVEE2c3N2UTE5UmhjTUFG?=
 =?utf-8?B?TmdRZGFsb0xoVGFrYmhoZHJXcFZkbmtUdEF5amlHUGFUb3dWOCtuR3RaekhP?=
 =?utf-8?B?TjY5Z2RYOEk3RWJWRjByZ3ZLaXdjbHF3Q0dSQUtleC94cW1xQnZ3VTY5OTFu?=
 =?utf-8?B?TC9kLzZrbFpqOFhncE4xTjY1WVZ2K09RcGRLa1NuRzNwNWpHRXVZRndiMDY1?=
 =?utf-8?Q?soY5rNJPHgZL7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTZGdTFTRi84Ny9vZEFtWjJhUVlCdVgxY2UvZW4rS0IwMkNIUWlsdXRNZjdE?=
 =?utf-8?B?ZTJlNUU5UGlTMDRZUUVsZTFBWEY3eS9yUVptMk5ZQ1BtSmhyOTI1elJ4Lytt?=
 =?utf-8?B?UTVPM2pqbXpLRDhOd21EYzJoNEtDNVhVZnJQSWxJZWtUYkpMSkFQQ2pqTTBv?=
 =?utf-8?B?dkFoWVVCc1VLN241UGFhL3B0aUxqTU9VMU1nTWFBRzN6a0tuWWNiWmIvc0Qw?=
 =?utf-8?B?SDJXVHQzRy9aMUovN1FNQ1didUF5T0JqTTNkTURYOEdjRjBueEpXejdWVWV4?=
 =?utf-8?B?Zjd4a1pXY0RqcDhjK2p5YVpEVExTZmxJd0YxMEt5ZmVHTkQ5aTZhZCs4ZlQv?=
 =?utf-8?B?VXN2UWQ2L3BpQ1E5MklYeHJCV0IyRE1Vd0laSXA5aUJ1RGRYRjV6ZXVZMnRM?=
 =?utf-8?B?UnI1MEVvWkxsSGRJZ0x5OFpJMFY4YUlybkgzUlUxMXEyMUo3cHdYYTJwbXN0?=
 =?utf-8?B?VUZaaGE1UEptV04zakViZUtkZmNIb0loQ1B3a3JWa095NGkrYkRSZnBiZDJl?=
 =?utf-8?B?ZUJUSG5tZkxLZmNybWE4YUgzTHF3OEVTTDJMaUNvcXBkK2lnUXg1dHVTaXV2?=
 =?utf-8?B?MHY5ckh3OGE4K3ZuUE0xWW9kVEhhK0d2V2xCQk1CMkc2T2pVaHdyS0ZjdE0r?=
 =?utf-8?B?Nkh3cGRvT2ZVL09Gay9lakJFcTRwTEl6TCsweTVpd2xaVHdLWDkzQUw2cC9R?=
 =?utf-8?B?N01qbmhXK0VpVnRyVVdRYXNzc1gzR2JzNnFUWVlnRk5Hb0lnN1hSaEV5bHBM?=
 =?utf-8?B?V0ZNZXlMVHg5ZVh1c09PeUR5R3MrOUFPbDg5SjhlSXFKUkgxb1ZWaU91Ykxu?=
 =?utf-8?B?aVFCQnVWdWsvTC9tSks5b3BnUzdSZ0xiRlZtM3lwWDBxTkMxZFE2SEorU0FX?=
 =?utf-8?B?UTdKbDVvQndPakJFQVg0VVU3US91Z0d1MjFQdjdDVzB5ODBJK0ltdU8yQ1Vl?=
 =?utf-8?B?dnZqcUNCMTl3ZTg2bnBsTDRhSDVFZStjTHdla1plc2Y4TWkzZFU5c3A4aHdD?=
 =?utf-8?B?elVLYzB1K3VTckJMclJYbWdFN0RIOURJYmhCSGM3bXVtd3o4THdRU3dkMFdj?=
 =?utf-8?B?cWFmY0lrNGg4eXRPcUs0cmlVMHd2UDUvSmlmNTB0SkRxMlBTeGNibEMzMU5v?=
 =?utf-8?B?bjJIU2Y1aCs5SDJ1WGNld1ZDb3BELzZJV2NLQmtIdXlqekNDYjNzWEpqY1o0?=
 =?utf-8?B?WnNCeWhLZ1FJZ0o0RnZ2OG5vcXM4aFJrdldYOG9ueFd2dTR2NS9zUWJveXFL?=
 =?utf-8?B?bW1OaVFaL1RuOStNMi82emcyQm4vTU16L3l4b3RDR2l2TzByaHRyUGpHSjFW?=
 =?utf-8?B?N3VIMm9ac2FKTVVlMVFUQm9ZbjVHd1lhVnpsWnNxcHlOcVhKTVdWTVhYRjBX?=
 =?utf-8?B?N2hYc21sRkNBaktqL3V6b2dyOUFYbVMyaDNwa1M0Umt6bVNFczk3TnNNVjd5?=
 =?utf-8?B?dU52L0lXb0Nsay9XQjVvWHJZcGZ6alhCV0htMWpSaFptaGxXdkVhT3R1cSts?=
 =?utf-8?B?TXZoQWlNdHd1ZFllMTd4RGJwK3c4MWl2aCtEUjk0UDBGajVCbzRmUVdyekhm?=
 =?utf-8?B?aTJhWERIZ3JVcEFOdU9Oek1lczFoSTB1ZGlYT1MvME93ZFh4T3RTRDdURHVN?=
 =?utf-8?B?ZjZnc1BQenM4ckhHUVNMVVViYldERDhEMmNoak5vWU5qR2RZanJMRExsN0xK?=
 =?utf-8?B?OGVSSHRGT25KSXlqcHpjcGc3S3BIUmFBOG81cTNFc3pZWDFmaVdOTU1tWmtS?=
 =?utf-8?B?NkMyMVlKVk1Qc1FMbnh3dGpEL0NOeFhiRFNOMFhaTG91MVR5MG15a1NvQ2hC?=
 =?utf-8?B?Z29MMTY3SHd5VFRFUEJaRDJXdHFLVFlOMXN6WWo0eHl2UmlWTkUyNnlCcnVu?=
 =?utf-8?B?UFVlZk5VQnNTRDBkQmp5YUNPT0tJckNBMDBxdDh3TG5VSFo4SDducElyVlg5?=
 =?utf-8?B?cEdINGNML2lFMTBoUDF0V2Ztc3B1d0dXQU9xaFluOE5CT1VqY2pkYlczaFNv?=
 =?utf-8?B?M3hPcEx0anA4b2FCVjRBOWdiays1d2hmcmM1c1BoQUkzZUlRemw5RGF6WXk1?=
 =?utf-8?B?L1J0UjFEMTBLUDZqUjhVd3hJYWxnYXpaazI2bE9aaDlEUG1Yc0xOR2VKNksx?=
 =?utf-8?B?RUR5SndTcSttSXc0NkNqbmRoZUdGeC9qd25qRkJBOC9qcStNK2V1M2NrcCtT?=
 =?utf-8?B?ZWc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 249268b5-a220-4a12-1489-08dd1f44db67
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 09:17:55.6975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n24PR6mi5cimgmsLzbzCiLrA4fxyK9gQK947+/slF7xlz4MrNgbm4alkigbGO1+hGWtvQDlMDbt6L5B0fIbSc/7uNMjduS6BSjF3mKkRwXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5943
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

On 18.12.24 10:00 AM, Ilias Apalodimas wrote:
> commit e27bddff4b97 ("imx8m: Restrict usable memory to space below 4G boundary")
> tried to adjust the usable memory limits on a 4GB boundary.

I would be nice to also mention 74f88b72219e ("ARM: imx: imx8m: Fix
board_get_usable_ram_top()") which actually introduces the value of
0xFFFF_FFFF. I guess it would even qualify for another Fixes tag.

> 
> ram_top is described as 'top address of RAM used by U-Boot' and we want
> to preserve that. This is defined as a phys_addr_t and unfortunately
> its size differs across architectures. This has lead us to a weird
> state where 32bit boards define it 'SZ_4GB - 1' and 64bit boards as
> 'SZ_4GB' unless it was otherwise defined.
> 
> With some recent LMB changes and specifically
> commit 1a48b0be93d4 ("lmb: prohibit allocations above ram_top even from same bank")
> the board fails to boot properly although the commit above is correct
> since it's making sure that no memory above ram_top is usable -- but
> added to our memory map so EFI can hand it over to the booted OS.
> 
> The reason for that is that during the LMB init we add all usable memory
> in lmb_add_memory(). In that function any memory above ram_top gets added
> as 'reserved' for LMB. With the current values tha's set to 0xFFFF_FFFF
> for this board. Later LMB is trying to protect the memory area U-Boot lives
> in with lmb_reserve_common(). The latter fails though since it tries to
> add U-Boot top (which is 0xFFFF_FFFF as well) to U-Boot 'bottom'. This call
> will fail since 1 byte of that memory range is already marked as 'reserved'.
> 
> Since we are close to the release, LMB seems to assume that the address
> is rounded up and is the 'next address' and so does parsing and adding
> memory ranges from DT files, bump the ram_top of the board by 1byte.
> 
> In the long run we should change all of the above and have 32b and 64b
> platforms define ram_top identically.

Some more ideas for cleaning up the situation in the long run:

* Get rid of board_get_usable_ram_top() and fix the drivers that require
  address space below SZ_4G.

* Parse the 'dma-ranges' property in the SoC node of the devicetree
  which already tells us what address space is usable (at least for
  i.MX8M).

Anyway, the change looks good to me for now, so:

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

> 
> Add a Fixes tag although the commit is correct, so people can figure out
> the broken scenarios in the future.
> 
> Suggested-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> Fixes: commit 1a48b0be93d4 ("lmb: prohibit allocations above ram_top even from same bank")
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  arch/arm/mach-imx/imx8m/soc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
> index 9588b8b28bf2..85dc8b51a145 100644
> --- a/arch/arm/mach-imx/imx8m/soc.c
> +++ b/arch/arm/mach-imx/imx8m/soc.c
> @@ -362,7 +362,7 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>  	 * space below the 4G address boundary (which is 3GiB big),
>  	 * even when the effective available memory is bigger.
>  	 */
> -	top_addr = clamp_val((u64)PHYS_SDRAM + gd->ram_size, 0, 0xffffffff);
> +	top_addr = clamp_val((u64)PHYS_SDRAM + gd->ram_size, 0, SZ_4G);
>  
>  	/*
>  	 * rom_pointer[0] stores the TEE memory start address.

