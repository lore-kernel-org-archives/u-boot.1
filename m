Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1130CC27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 08:43:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CF25886DB;
	Fri, 14 Jun 2024 10:43:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="oOB1r/WF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A699387EBD; Fri, 14 Jun 2024 10:43:19 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0718.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::718])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A83778871F
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 10:43:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gEsWQbtrJ/PUNPs01NqFAKBmDGtpWfRQuUqla2XgdfwD/YOBRWC7h2LxIP4Xw5JCzIQUFk/CrwfRgeXs3EQahol4aA8hAS53CKmZT1vq/nZFYQV8zhLM2+Cmu6izlN4h5RYhYocsyReBNF0gj008oz37X6g+U4V2yDk3zUgIVF+Of9CJAFRAGceINiW78qEsN4OY1TnAzSbA4JFk666Fe7Xbab5DYb3BaoRdOy00/PEqWgFD+/ZjE6WGdAQVW+ew27H67TsYKuW/Lhr1ijqvz6F8w4z4Wh1jd7ow1ugitU+QNV2yU5prM1AZQg/toRoocHVY6d+8beLFeHBBNSI9eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1C747j/5YupoSnsRNBSFkUJ2iSi8EDXljdT0tG9mxo=;
 b=YgTJDPuzWPUbvfQdN5tjfHU0bXaEBPEmcC3f0MlVV7+rrz3yW4d3L2pzCQYHzOuI8xYS7alW1mu6q2fizNYVSiLw8aEoy0ptOhN9uHEPyyo5gFQoOC6zJQiD6xRa1Pnhminob5ghO9/DKL4cHJZxgXuxeBZ/7YXTgDb1sJZH3WXPAzFRDw7xOtll0dgNzNgQyNv23KXFRql387wPJCITgKAq/Dowg+aAmw/pMvO9q8iVUSsJ/HBg/xa0pptpml1RUNnviCEW2GZoAChflREEVA3cIlNGb82HfFIdXgSbljQMjaK/p3WGufp8ihr1RKtq2nh4jSMR9VQcRO2pyOqmkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1C747j/5YupoSnsRNBSFkUJ2iSi8EDXljdT0tG9mxo=;
 b=oOB1r/WFbSkJp7QrcNHj+EDP18mJNL0rWfocm6J3FQWubacbKhJzV/Gy8BCp7sMLdu01BKRlxGnYYVKq7q3VsNNgzf/9a3/pS8KaXX4m2c+0wdnuCZm0mrBrDrC9+LkwMXeqeQweqZbmqMWnM6ZAo4AcKSkMaF+AKs28uk13tzU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by GV1PR04MB10329.eurprd04.prod.outlook.com (2603:10a6:150:1cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Fri, 14 Jun
 2024 08:43:12 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 08:43:11 +0000
Message-ID: <6cf18006-bed8-43cb-aff8-591781f8c3ac@cherry.de>
Date: Fri, 14 Jun 2024 10:43:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] doc: api: bootcount: Convert to rST documentation
To: Vasileios Amoiridis <vassilisamir@gmail.com>, trini@konsulko.com,
 hs@denx.de, pro@denx.de
Cc: vasileios.amoiridis@cern.ch, u-boot@lists.denx.de
References: <20240613220212.37078-1-vassilisamir@gmail.com>
 <20240613220212.37078-3-vassilisamir@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240613220212.37078-3-vassilisamir@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0045.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::19) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|GV1PR04MB10329:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a5666af-4d4e-4614-6888-08dc8c4e0601
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|366011|1800799019;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2REZElJM2hBbERnZVJ6SDd6QU1nYnpPQ05JS1dFemZqM1JXU01SdG9IbHBE?=
 =?utf-8?B?bXo3a3d6Qld4TDdGZGFWWkZSOXk2bkJ0SzAvbmVZTkJWNEFBNTkwekNkOFdw?=
 =?utf-8?B?TjhZQXRRL29lRVExVGxEWjU1bzRFRmsrWExFZUlXY0dJRjhOTWhUWHIza0dI?=
 =?utf-8?B?YlhmSXE0d1V6a3A0M2NWSFcyUHAyb0Ruc2IzLzZCSjRwRGp1UDJWY2hucmxk?=
 =?utf-8?B?OTU4UFAxS0xUWGdWYTNOeWJnbEhvOXcwc1lRR3JUdm5XSHdNa0dMYUY3THFD?=
 =?utf-8?B?UFBLWmNNMEU1QXRoVDdnTGJ4VkMvbk9uOWtEeGNJZklPa3crTHBzWmlSWXdF?=
 =?utf-8?B?RCtOTW9zcWNkMTAwbnFNUXNYQU9BTW1OaVMrNFczU3lVR25WSk1MUlJOQkhs?=
 =?utf-8?B?SGNuSjIyYmhMb3B6N2NCZEtkcTYzR051cDBINnlhalRzZ0didDV2cXlGTHFT?=
 =?utf-8?B?a0xuRDI2Nk1leGpocXI2bHBDN0xyNHlQa2EvQlRPa1c0WlNCMldISUt4Nk43?=
 =?utf-8?B?dkVpbWZ3c05FeER5RjZHb0ZHWU05Q1F0T1JDZVE1dFRpamhLV0RyeXIrdC9t?=
 =?utf-8?B?Qzc1a3ZKSUdLeEFnWGtSTU0vcUd4Qk9JZEhJeGVPQmZ6UDc1RTJld2g5U0U5?=
 =?utf-8?B?a3pCNlpkVGpxNXZzSkw5V2pEMkwxR1owSE9ZaDFxcFFBb2tEOGdKaHdubjFu?=
 =?utf-8?B?dldaanAxaEtXYktSaGZYSTd6bzBVWk9NTWxHVFY4R2FPaDRlc3RyNEV4RTNH?=
 =?utf-8?B?U2pGQmpzamhCZWJ2TFIxTTFMbDJzSTg4MEY0Mld3aGxwKzl4ekJDdGhYcXRK?=
 =?utf-8?B?SFQ5THlDOFBWWHo1TDE0NnJSWEV6UnRBSHFuenVTRkdLZC8wbkVxaE1HY2JQ?=
 =?utf-8?B?Y2c4Z3Byb0xBTmsyWmY3d1E2U0htUWxhWFM2TlFoNDhWTVQrVnArRW9vWWFW?=
 =?utf-8?B?aFUvZlp2TXF5YmhWZGRTMTU4N1BCRzhub1VVdTZTUG9HVm1hWEttYkZKRnZF?=
 =?utf-8?B?ZkJ2bkNIKzFSNDB2eGxPQzQ4NzRrbVpIZmprbjlRTTRmMUtyblhNbWJseDV3?=
 =?utf-8?B?NklzU2JTeVNKVHFKbEFRRHYrMjMwc251emo3QVNlVTM0TFhhVzMrQ0dNRjVi?=
 =?utf-8?B?RElYcHByTVhCN1BGdjBEdG12VXdxMWpDQnJZVVVxbGFxUWd6TjVYbGtrSGJy?=
 =?utf-8?B?dkRWZjJXd290Q0tTYXhjcXJha0N3TFBzdlozVEJHaDBFWEpqdjBFNG9icm5D?=
 =?utf-8?B?c3c3T2QvU3V3ZUFBd1N0djluamJoSjA1dWtUZDhoNDAvdE1QMTlJM3ZEYUJv?=
 =?utf-8?B?UDBTNmNPUTJmbzEvbUpWOVh1NFVUM3dHY2M5am1pamg2SUNVeVdEWW1BUGFC?=
 =?utf-8?B?R1JwcEpsSDVmdkdQdnNWTXlTdjBRR3NmS1JZRDVlOTBXTEViMkF2U05ReHRy?=
 =?utf-8?B?Ym1JanYxeTNldktxMXhrZWswRW5ZWkJwdmxxL1AyV2x3SzV4ZjdtY2t5VTlX?=
 =?utf-8?B?M3ljRmtQSEFvWlZ5NVJoYWFvaHpCc0R5NkVLWm0rSFRrZzJET29nSFZZdnRw?=
 =?utf-8?B?cTBiQnNQZW5mTVNTTCtta3plTUN2WUhVODAwdTlVanJiZW9OWmUwaWFvejFO?=
 =?utf-8?B?bUFnNStLWHNCS0toSE1GUUdhcm9WaVBSb1lOTjRYZGFrQzhiQ0hFZDBFam81?=
 =?utf-8?B?dktpOTFVcGxMWWNucWRPOHdOOTZBRnNTM2hacnpmaUhNRllaNjVvRGlJeUFD?=
 =?utf-8?Q?J01dvvuj5uhkUFhiRjsQS/oS13N4U4lP97SKLxM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230035)(376009)(366011)(1800799019); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dm9JejNpcENERGgrbmtIQjVGazhrR3M5Qko0d0ZERWE0Wk5oKzZ4QjJaMW9x?=
 =?utf-8?B?OFRWTkR3Z0Z1NDhYNlpmcysrV2VoRnYwd3BTS0ZWVy9EUFBqYjA4UjBPKzJH?=
 =?utf-8?B?YXNueFdGWm9BZzBJVGN2UjVIZC9qbXlmUUhpd1VLcWs2dW1TVmhMK01EbmRV?=
 =?utf-8?B?TTUzaCt0aDArdEw2ZWdIV2szNGtmeGJ6NEw2SVdmVmdUb0crOEtLU3VkTjBS?=
 =?utf-8?B?bDBRK1ZHMGFIbTBNWFllN1FIdDhjd2NZK3FCUUFJOWZCNXVBS2U2OGlDRk9O?=
 =?utf-8?B?UHQyU0xFMHU1WEFzbVVrbExQQTZlcDZDbklIMGdQVEdTUjBldTJkcGpGZXU2?=
 =?utf-8?B?LysxdlB5L3pwYUtyMGgxZC9qQWo4a2laSjB1V0QycGdpTGpZcUpKQU5nSXNn?=
 =?utf-8?B?VU1IdkdoUDhVa0Q2TkVLbEtaM25rdzlRVlFGY3R5Y1R1eTZmVlh2MnpwWXRQ?=
 =?utf-8?B?TU9XWHVJUjN6eHZKNk5JWmY4dVp1T0JQN1kvMkNZK1ZFNkE4VGM3NlErVUVy?=
 =?utf-8?B?WlgrWHdMOUFyMmNibXUzcmFFdWRTblJ4bXdkZXBDRmVGdExNT1lrc0pPekll?=
 =?utf-8?B?cWtCNk1GK0xOVkJZVlZDcm42M3dSYlJwRTROZytEemJ6K2JuaTFQdUxzVzJD?=
 =?utf-8?B?eEgvL3dWVEdMb254RFAxbFFsb2pJT1hSYWpmYUY3S3dMVUQwYmk2bmZWYWFh?=
 =?utf-8?B?UWhReHdGOGRXL1lQNnNobmVPSXUvbVZlOW1jMW16ZTI1MFNyanpYZWJxNERC?=
 =?utf-8?B?OGNsQUVHL0c2R0FaY3lJaTlGMld3MjdkVWJNdGxwdWdsNHk0dXczTy91TDJa?=
 =?utf-8?B?Qngza3NQbWtTVFRjaEY5RTdlQ0xKeXErSkZ6NXFITksyakFETm41UjhaRXVv?=
 =?utf-8?B?WFU0OThmb3oxb1Rtd3ZBS0djdWh2dENBU3FmSzg4b011MWZweW1tVmNDVjNo?=
 =?utf-8?B?NlQxRWtrSGp5VDdCWmRzMXN0azhzMFNWaFhUa0ZqamFHNEpjdmI1dFpwSkZY?=
 =?utf-8?B?ZkdBMXQ2Y0ZoYmdKTmxTY0UzZVlERnBUWmlFZE9RZnA2TFpaTDU4UVhYTDVh?=
 =?utf-8?B?UW5kM0psQStwZURiRXhTT2IvMWx6VVZrVHZhbEFpNnkwZGNVZWJCUmpVb3Vx?=
 =?utf-8?B?TVdFUlBkbVQrMEFlVHBEVmJpOVg0YUZ1ZmxBVnlrOU0veWIvZllEdzNWVEhq?=
 =?utf-8?B?WHBKcjFjVjFlQ1pQWTRsc2YvU2xOT0tldWQzYi9MTHlNRW1lTGZJR0JFZGJq?=
 =?utf-8?B?aEtIRHBpUXBQTXEwU0NRc3o3QUd2TDBLRFJaS05IZnk5cjFTQW1uamxZdmo1?=
 =?utf-8?B?MW9ZVjlDZEhMb2cra0VjMkgrd1VDSW5yeHlqc25zcUFBZURSeEZzK3ArNXpC?=
 =?utf-8?B?bUxobnVYMWlnV3d0aUlkbmxBaW5pNWVxQkJUSVMxVUhQd0p6NUVpVDZINnpU?=
 =?utf-8?B?dnVJa091TXVaOVJ4MUIxWjdmMVdjYU14MmtiR0QyYjhrQzh1bXJIa2lzazRr?=
 =?utf-8?B?dmtrc1o2U05FcmIwd1Z3S2IvZ01xL3FiSlJmeEM4SStVa3JMTDMzQmhJN2sw?=
 =?utf-8?B?WGhrVDdCU241eTZlWlJFQ0NtWVpoK2Nib3lzZnAycjJEWXMxdVdLOFU0RW8x?=
 =?utf-8?B?dTQ0N1BhRHZ0c1A5OGNzRlNFUEFxSk16aCsyUHE3d0tNbU5MenhOK0dBaEVY?=
 =?utf-8?B?U2MydVhNVDVoempJKzRtSEdnSy9sMzVJSHJFVTdOMGlkbDUrVTNKS0haZHc3?=
 =?utf-8?B?Uk1TSk5MUFlxMmhMdmlJditnNG93czBjcW10ZlFFNWtCd1lKRVdBMHBveUVo?=
 =?utf-8?B?OFFDWWptR0hSZ1pMN2JiUVRQeXpPRXpnYW5PVlJHbGZCRW4wQlNZMTVlNWN4?=
 =?utf-8?B?bms5WmdOU1cxcG5ZVWF1bzN0bk1YVmpLSklpdTI1U1hDT1hwb2gvdUQ0aTZh?=
 =?utf-8?B?WWlKZnFDSDRSekhQVXhKSEg1c0s4OFpSb1ZSRTk2cFZhUWZNRytEaWpnT2Ni?=
 =?utf-8?B?R0pNaDVVek9WeWtPaFlJOERGak5FWTVSUTZnOEFFLzM0SVlQVXQ1dUs2VFJH?=
 =?utf-8?B?ZS96K0treGZ6OFA1ajlzekE0UDBZemlJYkJyM0tTalpmZDVmVGgvWWJXVThG?=
 =?utf-8?B?SmVkSGVOMXd5Z2hKY3B3MjB5NXBQZmNrSGFjWlZ1cVhaMk1uU2lRbDZLMDBp?=
 =?utf-8?B?blE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a5666af-4d4e-4614-6888-08dc8c4e0601
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 08:43:11.6733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m2oSJnMvs0cGogzt4boge3KmOFeeXH8pAexOEv/LLfCz8YgO8nDsB58egaZ8xrWsQMknZ4SLWNouFvxKDmOSny+qyduvM7wN0NgdQfCeMS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10329
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

Hi Vasileios,

On 6/14/24 12:02 AM, Vasileios Amoiridis wrote:
> Move to the new documentation style with rST formatting.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>   doc/README.bootcount  | 53 ---------------------------------------
>   doc/api/bootcount.rst | 58 +++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 58 insertions(+), 53 deletions(-)
>   delete mode 100644 doc/README.bootcount
>   create mode 100644 doc/api/bootcount.rst
> 
> diff --git a/doc/README.bootcount b/doc/README.bootcount
> deleted file mode 100644
> index 0f4ffb6828..0000000000
> --- a/doc/README.bootcount
> +++ /dev/null
> @@ -1,53 +0,0 @@
> -.. SPDX-License-Identifier: GPL-2.0+
> -
> -Boot Count Limit
> -================
> -
> -This is enabled by CONFIG_BOOTCOUNT_LIMIT.
> -
> -This allows to detect multiple failed attempts to boot Linux.
> -
> -After a power-on reset, the "bootcount" variable will be initialized to 1, and
> -each reboot will increment the value by 1.
> -
> -If, after a reboot, the new value of "bootcount" exceeds the value of
> -"bootlimit", then instead of the standard boot action (executing the contents of
> -"bootcmd"), an alternate boot action will be performed, and the contents of
> -"altbootcmd" will be executed.
> -
> -If the variable "bootlimit" is not defined in the environment, the Boot Count
> -Limit feature is disabled. If it is enabled, but "altbootcmd" is not defined,
> -then U-Boot will drop into interactive mode and remain there.
> -
> -It is the responsibility of some application code (typically a Linux
> -application) to reset the variable "bootcount" to 0 when the system booted
> -successfully, thus allowing for more boot cycles.
> -
> -CONFIG_BOOTCOUNT_FS
> ---------------------
> -
> -This adds support for maintaining boot count in a file on a filesystem.
> -Supported filesystems are FAT and EXT. The file to use is defined by:
> -
> -CONFIG_SYS_BOOTCOUNT_FS_INTERFACE
> -CONFIG_SYS_BOOTCOUNT_FS_DEVPART
> -CONFIG_SYS_BOOTCOUNT_FS_NAME
> -
> -The format of the file is:
> -
> -==== =================
> -type entry
> -==== =================
> -u8   magic
> -u8   version
> -u8   bootcount
> -u8   upgrade_available
> -==== =================
> -
> -To prevent unattended usage of "altbootcmd", the "upgrade_available" variable is
> -used.
> -If "upgrade_available" is 0, "bootcount" is not saved.
> -If "upgrade_available" is 1, "bootcount" is saved.
> -So a userspace application should take care of setting the "upgrade_available"
> -and "bootcount" variables to 0, if the system boots successfully.
> -This also avoids writing the "bootcount" information on all reboots.
> diff --git a/doc/api/bootcount.rst b/doc/api/bootcount.rst
> new file mode 100644
> index 0000000000..9435a7ef15
> --- /dev/null
> +++ b/doc/api/bootcount.rst
> @@ -0,0 +1,58 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +Boot Count Limit
> +================
> +
> +This is enabled by CONFIG_BOOTCOUNT_LIMIT.
> +
> +This allows to detect multiple failed attempts to boot Linux.
> +
> +After a power-on reset, the ``bootcount`` variable will be initialized to 1, and
> +each reboot will increment the value by 1.
> +
> +If, after a reboot, the new value of ``bootcount`` exceeds the value of
> +``bootlimit``, then instead of the standard boot action (executing the contents
> +of ``bootcmd``), an alternate boot action will be performed, and the contents of
> +``altbootcmd`` will be executed.
> +
> +If the variable ``bootlimit`` is not defined in the environment, the Boot Count
> +Limit feature is disabled. If it is enabled, but ``altbootcmd`` is not defined,
> +then U-Boot will drop into interactive mode and remain there.
> +
> +It is the responsibility of some application code (typically a Linux
> +application) to reset the variable ``bootcount`` to 0 when the system booted
> +successfully, thus allowing for more boot cycles.
> +
> +CONFIG_BOOTCOUNT_FS
> +--------------------
> +
> +This adds support for maintaining boot count in a file on a filesystem.
> +Tested filesystems are FAT and EXT. The file to use is defined by:
> +
> +CONFIG_SYS_BOOTCOUNT_FS_INTERFACE
> +CONFIG_SYS_BOOTCOUNT_FS_DEVPART
> +CONFIG_SYS_BOOTCOUNT_FS_NAME
> +
> +The format of the file is:
> +
> +.. list-table::
> +   :header-rows: 1
> +
> +   * - type
> +     - entry
> +   * - u8
> +     - magic
> +   * - u8
> +     - version
> +   * - u8
> +     - bootcount
> +   * - u8
> +     - upgrade_available
> +
> +To prevent unattended usage of ``altbootcmd``, the ``upgrade_available``

I think what was meant here is likely "unintended" (not deliberate) 
rather than "unattended" (unsupervised)?

I understand you didn't introduce this and just migrated it to rST, so 
free patch to whoever feels like sending one :)

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
