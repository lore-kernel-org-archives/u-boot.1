Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE88C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 10:03:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEA1683600;
	Wed,  9 Apr 2025 12:03:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="VVBt2KT7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 436A183616; Wed,  9 Apr 2025 12:03:04 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41458835D8
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 12:03:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hi4XRGtQhzy52tHbJCFAy7dcGg+4ozOjpr3cpWKLXE6WQC21e5NhYm+JHDqwUp3T5R6JReyS2RONj5GupJLSsUJt897r0pEgpuAUagYv9H0GnGUEd/WRejuHkapKAX4oUY03f21rb2wEgUqBm4x93/P9KMdUIiqsTa2Ks5ja/OWlx9sSIkvNdcDslogW10AzkLeSxfmxFe3DWpza+JjIx78bYDBY0kVNOVQD3CBHpPHqcs9wFBUfmnZgP5RnGsWgjt8bf+0BHnFJ5eBT5rpkCo3/lhk/9yIf32R5dV4vTlNXP5glyhC//NaExmeruConINyeYBQ1KODC9uglJA4jqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RmInAbFQffcKbmbaAi089XFKJ3WO1qxdf9HlOcqAEo=;
 b=lysT8dmvcqz+czG38qOGWWxcB8sU0HluwHfZ9/7QJ/nZE6YyL4/wU/sHk84ZxMiKY07PwuXuuzlKkEkw4kThowt2uxO6ttlbBl8msV3BdacquaDebhXIbo7H7g7Z81ZMLzH0OUevap0X+qgI0Q6kUYY20ZfNny4WKwcT2GqCLG/pqCAy6PhZTyWW/N1vs9KESHbpTm/hTwcw+NhqBTCJApfOagNL+NXDDYJw4OCz59knPkFWGTWmOSEmjWjDR5Z0P7jf0SPSduwvntqEIBHJDcDwRhX+o8ie7N7MjfXoDMFlwBh+N3W+IAh+9kLCOSUHXf1yxiMJeKQJ9bWOae/3Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RmInAbFQffcKbmbaAi089XFKJ3WO1qxdf9HlOcqAEo=;
 b=VVBt2KT7K8scJiU1b5iiYjRrRoxvSNi1FkTvITWKZq6raxlxcto/aEe/gvfT1iisvHceJhtQNT2Q3ZxqZ0H0zXD/oKSx840KhW385QELKe8UZbFfMC/92Cn74456rFSXuScBjxlnNeNI7N/qqmc8EmDZlhqw1KJZ/g1a5h6O8NU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS5PR04MB10020.eurprd04.prod.outlook.com (2603:10a6:20b:682::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Wed, 9 Apr
 2025 10:03:00 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 10:03:00 +0000
Message-ID: <6b940128-c5aa-4499-b62b-1a63613d91e7@cherry.de>
Date: Wed, 9 Apr 2025 12:02:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/10] rockchip: binman: Include a compatible string in
 each configuration
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250329150626.2879942-1-jonas@kwiboo.se>
 <20250329150626.2879942-8-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250329150626.2879942-8-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0136.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::9) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS5PR04MB10020:EE_
X-MS-Office365-Filtering-Correlation-Id: 2abf0c95-fe0d-488b-aab9-08dd774db5b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SThaeStUalJ1enpMc0JPcnVad0xseVp2VkdBTS91TWVNbmtZQ1BXZGNRSWg5?=
 =?utf-8?B?dTFFWEFQNmFPZDNMeStCdUU5TWcyb09oM3hpZXdwSVg0WVVoY0lsUTlRM3Rv?=
 =?utf-8?B?U2ZObWJhbHpGVUN5clpzUklvK2oxMnZyVkZEM29YN1dXa0x1ZTNpWE9XVktF?=
 =?utf-8?B?ajZPYnZLZFl2LzNzUmQxaU9LTlVvYXZwQnlST0VlRXdZYkxxM1lDam05bi83?=
 =?utf-8?B?TVNGMVlqWk56OUtCditMSGtiRFlWS29lcVBaY0pUa3NHeUN0akJIb2lBZVJ3?=
 =?utf-8?B?bk4vaGJvNlV6T0xoR3ZObCs1aytVd0U4cktMTVhsQnc3S2E1V2ZVMXFmWHlr?=
 =?utf-8?B?MGc5V3oveTlTd1QyK1hhQmcxSkF2cE5LdXFwUUoyUytrSjN6ajZ4bmROKzl1?=
 =?utf-8?B?SmltNGhFWGFyb3pNb280VStoaWdIMVR4cnhSR3lqaFFNMGI1aGNLcTg5cmY5?=
 =?utf-8?B?ZnF6bHRsV3I5NHpZZTFBMkpJQU1LUlNCanVnVzUrVXIwblRRUWx3U3NvbHVQ?=
 =?utf-8?B?c1EzTFNicTh0cjZiYkhWd1ZGZmN4QXRmQzBRSitsM0JtUzN3NXBwVTNrZkJx?=
 =?utf-8?B?dVh3N1ZhbVY1c1JOYjk1cThMQVpOOFIwOE9naDBEdzFFN2xvem1STThZS21L?=
 =?utf-8?B?cUNxdmdoSUJNbkluUzg4SEI1WEh1Y2N4V2dTVXZ3eGdrYlA3TmhvTml4NVNS?=
 =?utf-8?B?TUpnQlJRMGMxVnozejdUU1NINzZlUThRTjBHWGNCekgzVVFHcEZiNnVZcHAz?=
 =?utf-8?B?WHVSS1JQUXovdGxkbFhzd3U2aUNXeUlZMERmOHFNMk03eHpheDlDb1lqMks5?=
 =?utf-8?B?TDF4RDhKekFuRUFyK2tiWGN1S1c2bnM4bjBjRTJjcUxnb2ZYV3F1UmxZTFV3?=
 =?utf-8?B?akt0T0JTdWk0QWtvUHVFQ1JvMml0dlRHSmlzZGtEZXZPaXlJOXpvRUlpRlc1?=
 =?utf-8?B?VzlWTVJIdGcya3N1dklzUEZhRXlidGJOTkNSRGVwTDJWV3VPUklTUDU4UGxt?=
 =?utf-8?B?LzY0RkI4NVh6bnZPdU5Fc3ZqQmhTTk5HazJMT3pRZEpOU1ZnU2VyYXNabzd0?=
 =?utf-8?B?czVJRllSME01UytMOWNPSUJiQzF1L294amovTW9XSVBxTUkrbis1bkpZOWVZ?=
 =?utf-8?B?ZkwvbXJndkpWc1pmdm5oVkZJWktOWStTdWE3bUtkZnN6NnlRV2JaVkk5K3cy?=
 =?utf-8?B?S3NDR1FtbCsrWXkrcXZscjFUTkdQTVVVVTRSeFg3bzQ4VW0zV3hobE9ZbTZ0?=
 =?utf-8?B?aWo5RDZtQjVPQVlwcU03S2k5KzZobTc5aDVQUjZwU2d2NlBLY3UxNkxJcjFP?=
 =?utf-8?B?TTd6WVdsNGt2clNHOWFUc1gxT1RiVVh1ZjBXTmQxL1BBK2ZBL3FOSUplUEtT?=
 =?utf-8?B?TG1HNWdrWEVpKzFuZk80VE5UUFFzcERQajdJa29mSWFWUVc5MTBLc1JHV3Y2?=
 =?utf-8?B?R01MSXJ2QnIzZzJ1SU9GNUQ2TVdrSklWUDhXSnRvZE5SWTMzeWg4MVROaUpu?=
 =?utf-8?B?RFhMMUI5dk1xNnlCVko2L3IzeVRxVDVodkVFci9aZGRHbmpEbDc5bHhZYi9m?=
 =?utf-8?B?Ulp3a1pnQ3NJYW8wWSttTDZra3haaERiaHBDbnlNaWVNcE9zV2NIcDdmWHV5?=
 =?utf-8?B?Zk1IS3dIRWIrRWtnc2dHNUNUNnJ3dmQyMWVkWG5HMEVySkhxRithU2tKdHp3?=
 =?utf-8?B?UFNvdFl5bVBHWFJGUm93akQvV095SkJCZGdFa1dCamk4cHpTSDlQMzZWaWVP?=
 =?utf-8?B?N0JlRW9sWFhQV1FHYVB2Y0xxSUprM0diV1V2WlJFWFZzK1k4eXJlck9GN0Fu?=
 =?utf-8?B?VVNDVUR0WC9GRnNqNC9JL1BhbjFVbWhuTUovbGZKRFdKQU9ubkx3TnRpV3Fa?=
 =?utf-8?B?WHFadDE1K2k3bVVJbVZham56dGc4bVQ5UFBvRFExSFVqdFpYejdEQTFPL2JQ?=
 =?utf-8?Q?GFG3i+2YSBU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFRPelRKMmo3Undydit0eUU1eGlsRXJYK0hKczMzZnFjZHc4YWFIUk8ybnBy?=
 =?utf-8?B?S1YwOHhybE94eGFGdUZncVZYaFBSVmZnakdKVUVPajh6bUhOWk1nMzNxcjhE?=
 =?utf-8?B?Z2dyZnkwUmZMSUgzQ01MK1BHU2pNL2FTLzNucC91cDFlSEgrUmlHcU40bTYr?=
 =?utf-8?B?Nkg5TGhNK1lzV0k1SVhPcVprOVd0L29CeVl2TDhJeEhScDFGeld2WWt5RENh?=
 =?utf-8?B?YlgvRnI4RUNyd3A2Q2owc2k5Vm9tb1l4UGdFL3F1cldyMk9Ua0llV0pjaUhV?=
 =?utf-8?B?azZxTmVxajZKclpUSjkrRkNCNllmT2FtOVEyT21vMVFsRmVacEl2RjEyNmE1?=
 =?utf-8?B?QnRPWkRPS1UvRER3VStrd3FMZW9VamIzN21aRGpiZUczWFlWbGF2c3RQS2FM?=
 =?utf-8?B?a2VIUS9MKzVHdmxERy8zZ1V5b21CLzIyUVNqbGhyWVVoc1A4SkdUd2RncXZO?=
 =?utf-8?B?RzhkVVFDa2wvSDkyc1JJQkR0YndKak5uWGgvZTRSKzFOcy9XQW9oamtRN2Iz?=
 =?utf-8?B?Q201RWt4YUNQQXRDbFovNnlkQlJyVEM2T29jTjhZSVBUYnpmaEhwVFRNejdv?=
 =?utf-8?B?c255KzJnemNwS1NLOGtHQktEZFNLZTVZdlBJU0s5VVNEZytjWTdmTStabUFT?=
 =?utf-8?B?TG0vbS9uU0JUMncveEpkdkIyN3lXdDV5aVV4d3pXblFrT0tSY2F1SVBoN0JH?=
 =?utf-8?B?ZWt5SUdLbjNCRFdyVENRSjNOMEUyOStHQ1ZHWU9UVnJEU1g2ZCtER1hHakdN?=
 =?utf-8?B?bnorb3c4L296YWh0L0ZvczM3Q1V5N1MxZVFHdkQrNk92OXV2bnBMWmVONnNB?=
 =?utf-8?B?azRiV0Q2c0Q3eFBvelozcXd4OUxFdG4zOG9tQ3VWdGFIbkt5UUFzQlhZYlJ3?=
 =?utf-8?B?WGVPYUlnYWN5T3JGYTZxbFZHdUdYMXhDN1FuNW53K2FpM0wrWDZCVmd4YzRj?=
 =?utf-8?B?TU9VQlFWL1BRYkFHMU04REtzd3k0MW4yaUpvb2w5M0twYllnaFlsZy8wNENr?=
 =?utf-8?B?bzhGV0k0L1ZuRmxOZ2RxSkpzN2swYk9sU1dlb2xHQm02RndQd0RkQVBTN08v?=
 =?utf-8?B?RGpXSTMvU2lNcGwyWjE5Z3FzVzlTQXJaZ1FQa3VLUlhHV1Jldk9zc1VxV3pY?=
 =?utf-8?B?V0pZYXJsSXphZ290NXMwQzA5MENZY3NNcnFoMTVWYXcxSnhrZHRvMUgyN1o4?=
 =?utf-8?B?ZTRoaDNzRnRQck1zSGJqaTVGeGRDU29vbTFGczUvcmhaV3BmekphUGMvejFw?=
 =?utf-8?B?UmcvR3VxZGJBcExoWmVpbmdYc3ZSU0JWZG0xMDlDV0MrL1YwTVB3UDVPdWF1?=
 =?utf-8?B?QnVOVlRsVDM2TUFYcHlxUkNQeWtCVGpDYm9nVE9Lb0xCdlhkMzFyWWQ4TVgv?=
 =?utf-8?B?Q0tOK1BLRGVXV0xRODRvTk11WTNCck1Vem5aeXJqRlFzUjFSVHNFSjIvS0FX?=
 =?utf-8?B?SGphWld1VTFVUUhiMDZPUGxOVUU5ZEJiUTRFMUtpSlZ4WXdTKzNaWlRvd1RJ?=
 =?utf-8?B?MFlteHBpRnM3SThkZXF2N1RDeVd4NGU4UEZDU01aeVpOckR4aFloSEpXUDFT?=
 =?utf-8?B?NnZ3OVVqdDRRU1czVlFPRmVsNndScTg2YS96czJ1ZVEwc3NwQTgvUW5QNVln?=
 =?utf-8?B?ZnRkbFExVEpqeDJoNFNDQU10c3pNenFrbVpoa3c2Y0FFU1dqN09GRGtIa1Rr?=
 =?utf-8?B?SnFCeTFtUjFYSWZOZHlJZW1LQ1JwR1pkeUZsT2lmTVR6YlFYWjByNTIxcjRh?=
 =?utf-8?B?RzRhV2V2Z1RYbkdiZzFQdC9CdFg0UlNpVVltb3p2cmlRRXZRRjNaU2FKUTEz?=
 =?utf-8?B?Z1JTMHlTenJtdEVJbE1aQzBQa2VxaTBiZkNqcTdyT2pleVVYK3ZIUERhZHkx?=
 =?utf-8?B?b1VXNCtpL29KNjE3a3RjcW51QU5XNDVCU0lKMUNGRXdmcWhBbnF3dHprbzlT?=
 =?utf-8?B?V0llV25Bb3dYTEU5SjNEb3ZFY0lZeHpCL1ZpVnhmMmZuVFRNdnd0cXcrOW1R?=
 =?utf-8?B?YjVFMXRNV3Y4QmNMaXVYNHArNTRvNE5sbWcwemtiTFlxMldqSit5UkN0WEVV?=
 =?utf-8?B?dlJLOFpzekhPZmNManUySXkxZUZ3cVZJMi81SzBOWEFYcmREdGhYSHlOS3hK?=
 =?utf-8?B?K2xJa3lvbHhlU2pKbGV3UGFmYStPczVMWmR6VFJRb1VOeVlraGI5WllxUkRo?=
 =?utf-8?B?R3c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2abf0c95-fe0d-488b-aab9-08dd774db5b4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 10:03:00.2531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zSJXKaCpvftJqX5XoggW85CH7KVDdcg0thz4krGa7amGhFMs93wEdbU/0Tj2aYxSvMBbWszjn3tzjF3mA3cU1zQ8jmhR6C2BRhG3WYBzxgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10020
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

Hi Jonas, Simon,

On 3/29/25 4:06 PM, Jonas Karlman wrote:
> From: Simon Glass <sjg@chromium.org>
> 
> Provide a compatible string in the config nodes that U-Boot can use to
> help decide which configuration to use.
> 

Can you tell us more about this?

I don't think mkimage -l/dumpimage -l actually provide that information 
and the docs are sparse as to what "so that things work correctly with 
FIT's configuration-matching algortihm." means.

Looking a bit into tools/binman/ftest.py it seems like it's a way to 
expose the DT compatible property from within the first entry in `fdt` 
array property (a DTB) into the configuration node in the fit image.

I think it'd make sense to update dumpimage/mkimage/etc... to dump that 
information as well?

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
