Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3422DCFD315
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 06:48:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9C5C83EAE;
	Tue, 25 Nov 2025 07:48:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="miK6YnUg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0834E83F2B; Tue, 25 Nov 2025 07:48:09 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32E0383D13
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 07:48:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7Ef9nX3M61Oh9428uLSmijPeApIiIsg97oTmoaTh++VjK7He3PwShX3tbEage22ta8ciPOhDXVuspmfsALAUUjJPoWs7mvTeSscnTTmeFG4INkDdCT49lfMiPDzBw436ae5ui4Z0uVMHykziD2CkFeaR6pG0izIvO+B6DT2+qT7vO+znSexs7kreY5DG+3/NqclTxXKI2ThUOo9eKIKyJYnzd9QIku4svuNQ+sXLB+lkJ6BJgUlWuoC7RMabR+5kVmX/LFSoCuEyBYGxeDaiYertik4ZqvHIZckEMv7sB0ZAk8kAS/gIqNW1ZdXUvJKlp3GMmXCGXGf+8CTIBn3wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6XaTUT7FKUuJBcC9aYc1oBvAF2tYBVSnHE1oBqFG4A=;
 b=exnFrUCjRvAHNOIDXmwgxNwJI5ZSlKKU+m4T6k1OQ1Vodb9vXtYdSELj/3V98i4XlbMNvDV1jgEP+gC2G9SVCSZ/ksSwVqEePP2NsvBgi0LOZSgCiX1BSZDr7iwAF0gXX2thNq+aQjGMiTIAR5Mz0h/nphDUWqgxmbRr6c/ksb1S30vHl42ivRAMqxXvsqkiJl5uEBvY3vqH9UjObAlGZsd+1jBlUO/I6iYy6TQvPOoDKVnOuhy6VP1VpC482Y//38zYN0oq5oihHk2a6SgEL1cJjFOo4kUe4xBp0vjgggvtn8BrVxRzscNpYxVtIG5rFsiTqEz7icStuBwrpBsDGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6XaTUT7FKUuJBcC9aYc1oBvAF2tYBVSnHE1oBqFG4A=;
 b=miK6YnUgn+NKvr5lgclEy1cM13oB2sk/Kpipo1MYIpSdTzM05+X8FVSrd5V5qs7G+9YhFRp6M8O6Y5mHLfyOm0WOXTTtyeMtz5ZyoPOrDivES9RSyH6kyWi7Ywvoex/XwZbhaO7vxFxuHlcfp44g/oAQ1rvG5JHV/xcJnsI7kwPsvOkjg+FbdImNjrN6pPjkzG6ZSc9uTrqsnGp9Wfa34+Y847IwTD87XCDTg+T9lPM+VnZRJhORFt6e4nbKRxZ/jMYXQsvTa/pn9e3U+3/N2VQdRArRPqZ5dl7re+9jFocgn9FRucEg8EI4pvgB7vr0+DEHd7B6TmIhmaVcYjtERw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8831.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 06:48:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 06:48:04 +0000
Message-ID: <a27e5bb7-dea7-4659-be32-4111bf8a5f9d@siemens.com>
Date: Tue, 25 Nov 2025 07:48:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] spl: mmc: Account for
 SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE being a choice
To: "Chee, Tien Fong" <tienfong.chee@altera.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
References: <cover.1763140421.git.jan.kiszka@siemens.com>
 <2a3e21ea1dd00565857793228cf1a0ee27d550db.1763140421.git.jan.kiszka@siemens.com>
 <93c1f877-ac83-4802-bfc4-4338658d8e5e@altera.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <93c1f877-ac83-4802-bfc4-4338658d8e5e@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: a4fccd81-f5c4-440c-ed25-08de2bee95b0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHU1MVFhdElnWTNqVzZIUG4xckh4REdsWUtwcERFcWpGN3A0NXowQ3VPcFFq?=
 =?utf-8?B?VVhkakNmVS9aY2M2WWt4N1g1QThSVDVLSzZDdGlPU1ZxcG5LTjg4dkhuaFNK?=
 =?utf-8?B?eE5JekhkWEQ5dllMZzJ3YktjTjMra2hEREpsN0YyUHhpT3Y0dU9CM1hvdXFY?=
 =?utf-8?B?US9tZDFOb0lNQmVOdExVS0krdWVOMk1aTGJQeTBjc1NMa3VDVFZEZ3Q4bDV2?=
 =?utf-8?B?V2JGVWsyM2poUGM2d2xsMkMvUmhHM3l0VjM2c0Y1REJoZ2h0ZGdqTm5SSGZi?=
 =?utf-8?B?SStvY3VwbWpGZEJUbGxoUnU3K0daSC9PeU5vc2wyYWRrN09QbGtZU2JjZnJK?=
 =?utf-8?B?cmZ4ckJiSzQvMjBqV3BLbXkzeHBRTFRhWEdHcVN5d3NGS3lBQ1JUZmZnZTBY?=
 =?utf-8?B?WWpvc29JYkRXb0cyKzJMb2xnRHc1NzF5OW1NT2g0YXlWRCswK29TVmZ5V29l?=
 =?utf-8?B?T3NVMlh5ME54emFKZlpjRFFKYnZJWVcxbUVnZkRFUVpVNWRkZzVFVUFsTFl1?=
 =?utf-8?B?bERDbHRtZW5yemtRNnNxOHhCM2ZjZy8ya1hmUElWSC94K1IzbG0xNEN6cWNJ?=
 =?utf-8?B?bHZDVnVtdXg2TUYwRkVxV09CRHhKV3EwYmx5bXdtSmgxUW1Uc2RlOUpwSGli?=
 =?utf-8?B?Ny85ZmN1bTVGYkdCYjJOVVNyZGxjS2pyM3JNYytUUFBtYVdTQmxidEFka09a?=
 =?utf-8?B?UEpmdjBXanhLQkhPcWpneitLK1VjNEJZK3pkQzdJTnpLWHZSWjIwQytMWEdU?=
 =?utf-8?B?WlliTXBra0VLM3J6dHYzc3VUNDBsK3JEdG5Xc00xRHVDcW82V2Z2czk1QVhU?=
 =?utf-8?B?T05CcDNyMmJmVG5aVGhpMW9JN1pHeERoM0s5bDV2Z0d5ZnFTb2wxbTY0NVc1?=
 =?utf-8?B?cDNhajh0RVJtZGNLbkxGUDRjZWRHanFtQXJCSTZpMlo0ZmJFL09sWGcvaGVS?=
 =?utf-8?B?MEJ3allzSDdPblJZMzRTckFSSWlsaFd2TmtiWHR1bVZrQU05VE1ScVV0bmFh?=
 =?utf-8?B?cmwvM2Z5bU1pTlludTJpcDMrc2RKQStsSlhHTkVUb0ZJbzBMK2VvZ29TTGdk?=
 =?utf-8?B?NE9Wcmt3ZHFUeHhLWG4zSUwzZ0NkbUE2RmFuTzVhWlZWOUpra3Q4QkZZdWtC?=
 =?utf-8?B?VHdpU0kzZmM4QWgwWHJqRHZ2RENKeG5qWElEdVF0ZHFoSE5zVy95MTI3Zlpv?=
 =?utf-8?B?aUd3a3VBOEtFMU5SQnhURE5YR1JaNlNCRWZxckx4R0tLSVJEQlVXNkhDcEFH?=
 =?utf-8?B?NU5UR1JSQmowSmpycDg5TTRGa1pLd25DWXFwUnVsWnFudzF5N25lVTBESFIv?=
 =?utf-8?B?b2tra2RmbDVTUitLbERKdlgzTXpERVN5eFBXcGM3ZVFPNmtjeEtWQlRPR2F4?=
 =?utf-8?B?UzZUQ1JEaGpzR1RqM2VyaWE2RGdzN2R5Z0NsUXNVMnErYlB0MGJKaXlraVl0?=
 =?utf-8?B?NjM3Y0tyWVF2TXJib2dOeUpsZEp2RWFIVkNvODZvNGpucDhoOW1CWFpCbThh?=
 =?utf-8?B?YzRrazR3SXFaTWpmL0daR2ZZOHZkTit4eHFyamk1L3RKbjV4bzBrZUlVYlBy?=
 =?utf-8?B?ZUJYUXFIV2RzVHdFS3ZXTitXL1hGMlViajhWamhrQlgxajBMWUxacE1rY24x?=
 =?utf-8?B?czBBNjhEWU0wek92MFFDYlRQbmZxZk1ERHNzRG1vS1RMMENyK2NSRGxwQU0w?=
 =?utf-8?B?RHNyU0hIQ3ZjbFZjaVRQZVlWUjRRb2l1MVVYLzZBRTF6NlkvUFR6cDhGVndN?=
 =?utf-8?B?b3BaVW5vSWw0NitnTjV0VW4yajhldEg4THlRWU5rZk54d1UyWk1YU29LWnc0?=
 =?utf-8?B?ZnhlQmxOZzlBeTZFRlgwZ1o3bDNnNm1rTFZKZTVGc2ZUcnllaUtBdEZpZ3Jp?=
 =?utf-8?B?Rm9nZ2NyaW5qUC9EdG8zeWlhcHdreXduSUw4ZHNwSnJuMVk3Tjl3WEhkODBG?=
 =?utf-8?Q?ZNAshd0AMV+wGjGyCdMmzDP1ep8zuTMa?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2ZxRkVFZ0h6Z0VvNzRnYkhwRnV1QVF2dzlSdTF1aTFJQWsyQ3JQdDMrRS9F?=
 =?utf-8?B?dnd2Y1BEUDlpTHIxTjk0ZmFKM0NBd1lXT3ZLWCsvcTBxU05Db2pFS0FzVjlW?=
 =?utf-8?B?WnpNL1lUOGtLdkxxcHkvVVdnTDdnWHNRRjBONkhOaytPRzZ5UTNEQXlvMmtL?=
 =?utf-8?B?SXRkU1pGeHYwUGVZODZUdE53RGVURUk3d3dOSEJ6cHFFK1FrM0ZTRnJ0SUty?=
 =?utf-8?B?UzY0NWprUC95WHB3aVFuSkt3SHFhL1A3SENybUZ3Z1JxVW8ydGtFcWtPVmpw?=
 =?utf-8?B?UG96OHdpUmhUNzUzbjNLbHBJZG9sejhDenIwR3F3OENsamxLY1BsMnRPWW9w?=
 =?utf-8?B?VkR6UW1TQW1uZ0lNNnpraXNiOVM3cGlCbjNUejB4dXVNaFRVOFZFcUZVaENi?=
 =?utf-8?B?VnFiSnU3V1ZRZWdIcURsVE9mMjZZZTZhTm9qaVQ0SlZvR0pGa3V5bGhRRUxk?=
 =?utf-8?B?VWRkdzh5Vzc5S1BrVk5XZkVDeWJHaWtXdFRMWGIzcFdFVHkxSUdvcGFQQUU4?=
 =?utf-8?B?SDdBMkFXcFZSRmNTcUNNMDFpZGxwVG9oN2ZSbjdXcjNnYktGMkJmV3dXdGF3?=
 =?utf-8?B?V2VJNm9kV1pDbG1ZYUViWWduOWVhMkdrQnptRERvUVd1OFJmR0tSanlROHFk?=
 =?utf-8?B?Tm9nZXBJVUNEdGRUd29lM1FNUkVWRXhGbStibFdCOUZUdTZFZTUyY3owUGM4?=
 =?utf-8?B?V09DbWhjTlVFeHF1b1JxdEwyOWo0TUY3eWNMd0xqLytDVUE5UHN3Ui94RllF?=
 =?utf-8?B?VVpBRVg2UGtrdGdnVjVJN2dkajI1Z24yeDUyTGtOY3VwNjFFWHdzTUhMSDRF?=
 =?utf-8?B?V3I4aGtPWWNkbnlhcnYyZU8xaUFETkNkM1ZERG5WbTRnNDFBeHU4cm8wS29C?=
 =?utf-8?B?SzRJRlBCclpDUVZ4WE1lSXFSY1lDbUtZRXF4QlcyS0NDbkYxZGx2Z2kvTmkz?=
 =?utf-8?B?QVBDUnZrNERQc05WV0ZVOWNSTWgreTNJVDFQM09rU3loYWJ0VUREclNyc3Ry?=
 =?utf-8?B?ZnNxaWJJQnh6cEF2aXA3YnNQSUE0cXN5K3UyVUJsZUNuTW81d1JBMXc4TVJl?=
 =?utf-8?B?R01RM01KMVQrZjZvM0w0eGRXalhkYkVDNCtQTWZ6UTFJNkdlTVVLZ2NFdHhU?=
 =?utf-8?B?YlNjcnNYY21OQ1NsRWorcjdFM0hYM01SRUUwUzdlLzUxK2FKZ2hYRndCRkIv?=
 =?utf-8?B?akJuSW91cFd3TTdFdTA2elFGQzY2V2FxNkhsVkFXU1QrNmMyU1BubE9XdEp5?=
 =?utf-8?B?TjV5NjR2RE1JdVp1Y1pCZkQ3RmRkaWxFTUJFdDlWaE0ybVo3aGFRcVoxcy9K?=
 =?utf-8?B?dW91UlNwbEE2N2lNa3hZNStrQ1NaREVtcDFuMlNvMmZpc3JvVWhzdlhnSE16?=
 =?utf-8?B?ZU12VVVFTzhONUIyZm93cndldyt3ZmRwanV1UFRQTGEwaVdDbzBQR1hneUNv?=
 =?utf-8?B?TytRQThBei9jNzduTHdPQ21VeFJZSHRpZlE1ODIzTW1vSVkrclFWWnp4ZEN1?=
 =?utf-8?B?YTQyTnFTR2p6TllNRkhqeVFMN0svTGZmT1R0eVJyaHp2TWxLbUZKQlhkSk1k?=
 =?utf-8?B?SEo5R25reUhhcW1md0hTaDBVUzZ2RHBwb1VuKzNFN09tS3NFL250QWt1b1hC?=
 =?utf-8?B?bnNsZmx6MmJDT0k4WnRpeTBPYzRmZHoycG5qWWI0TFh3ZGM3U1VPZmFyL1Mw?=
 =?utf-8?B?WTZXVS9sVGpFUTNkTkdsekpmTGJIa0FMNkVqUm5YWWMyZXc0Z05pYUFhTnln?=
 =?utf-8?B?dDdDSm45MVNiK0FvSGR4ZVhqWEp6aEdSTXVhSzBjNEFTTCsvY1NzaW9DcUtZ?=
 =?utf-8?B?S0l3Skxuc0kzcXF3blNBVW52RlRTWG1UeVdrTnpRMkc4R1Q3aEQ3MGpibFBt?=
 =?utf-8?B?T0sxRmdxd2UyS0QvaTQxbFl1NXFYQU50L0FIWklld0xPWmNiVFNydm1mZ2RX?=
 =?utf-8?B?c2w1dUNQQzVIVnRJTEYrMTM1Vk5DaGUvTFFTbEZWeXFjb2dTZEZSRnVRTEFr?=
 =?utf-8?B?TGVCcm1rc1B2eUZjMU53MUcwbHJLRUt1NnZ0L0crcUgzeFp1Qmh1ZkVMQW5I?=
 =?utf-8?B?TlR4WmJab2pnY2I4REh3Vy9ld3FtdlBiVnJDRFJtSExsS080VndxNUlRMjlL?=
 =?utf-8?B?TlZ2c1lqWGZFYTg4Tm1sSWxReEZ6bjJERjhSTFI2VFpXRnJUd1pBY3BxMys2?=
 =?utf-8?B?NEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4fccd81-f5c4-440c-ed25-08de2bee95b0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 06:48:04.8469 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SwWG0TwFtA9s+w0e5Wp9f8h1doMhUgNx+sTtFp/mXeX5bwi4Hk2h0IGSy4iq10NWx+1BhiIRXerqDjtJo1g5NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8831
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

On 25.11.25 04:58, Chee, Tien Fong wrote:
> Hi Jan,
> 
> On 15/11/2025 1:13 am, Jan Kiszka wrote:
>> [CAUTION: This email is from outside your organization. Unless you
>> trust the sender, do not click on links or open attachments as it may
>> be a fraudulent email attempting to steal your information and/or
>> compromise your computer.]
>>
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Add SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE as condition where so
>> far SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION was enough - though often
>> by chance as both options were enabled.
>>
>> We also need to explicitly select SPL_LOAD_BLOCK when UES_PARTITION_TYPE
>> is enabled, just like the other choices do.
>>
>> Fixes: 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>   common/spl/Kconfig   |  1 +
>>   common/spl/spl_mmc.c | 16 ++++++++--------
>>   include/part.h       |  3 ++-
>>   3 files changed, 11 insertions(+), 9 deletions(-)
>>
>> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
>> index 8dade2b501e..d24466b0c66 100644
>> --- a/common/spl/Kconfig
>> +++ b/common/spl/Kconfig
>> @@ -573,6 +573,7 @@ config SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
>>
>>   config SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE
>>          bool "MMC raw mode: by partition type"
>> +       select SPL_LOAD_BLOCK
>>          depends on DOS_PARTITION
>>          help
>>            Use partition type for specifying U-Boot partition on MMC/
>> SD in
>> diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
>> index 467114f8d9a..09e881c464c 100644
>> --- a/common/spl/spl_mmc.c
>> +++ b/common/spl/spl_mmc.c
>> @@ -106,7 +106,8 @@ static int spl_mmc_find_device(struct mmc **mmcp,
>> int mmc_dev)
>>          return 0;
>>   }
>>
>> -#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
>> +#if defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) || \
>> +    defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE)
>>   static int mmc_load_image_raw_partition(struct spl_image_info
>> *spl_image,
>>                                          struct spl_boot_device *bootdev,
>>                                          struct mmc *mmc, int partition,
>> @@ -415,19 +416,18 @@ int spl_mmc_load(struct spl_image_info *spl_image,
>>
>>                  raw_sect = spl_mmc_get_uboot_raw_sector(mmc, raw_sect);
>>
>> -#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
>> -               ret = mmc_load_image_raw_partition(spl_image, bootdev,
>> -                                                  mmc, raw_part,
>> -                                                  raw_sect);
>> -               if (!ret)
>> -                       return 0;
>> -#endif
>>   #ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
>>                  ret = mmc_load_image_raw_sector(spl_image, bootdev, mmc,
>>                                                  raw_sect +
>>                                                 
>> spl_mmc_raw_uboot_offset(part));
>>                  if (!ret)
>>                          return 0;
>> +#else
> 
> 
> There is a build issue when CONFIG_SYS_MMCSD_RAW_MODE is disabled.
> 

Let me check, but if you can disable CONFIG_SYS_MMCSD_RAW_MODE but leave
any of CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_* enabled, we had more
problems here.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
