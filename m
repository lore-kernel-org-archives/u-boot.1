Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B72D374A4
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 15:09:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF79389013;
	Thu, 17 Oct 2024 17:09:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="hmnI/TWx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA6F88900A; Thu, 17 Oct 2024 17:09:51 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::625])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4DAC8901D
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 17:09:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BiQQ8aLsGwSMr6JQB3wot1RvZ38M0EKpuPsP14XZuQQwEyAN9vzNQUdR87s9h9obkysnKznIuPebCi7Hvqq3b7EmxkgAu0KHCKme6YIUngWapRBgZUyiWQmTl2r7K0cVlomrJLzW6OkKfB74m6CQMRUL5JLaxQXPgM4i9X+eJ85AGlo+Q0X24lPOIhRyT/bznwXB058eG6Xhc2bHY0LppVXoIHJ80kuetuk8bJi14CcDB/WsCoSUWHEsqqbjKEzCroYycNsRJipmbZ7QQAi6WUfTcFnRk5oiDrJmgjKxSSFYOpgQ7X0B1xj/nSnrFDv6rktixiCw8WZI4+4M59a8sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtxEcq8/rrik0Wzr48GC89XrcrhsXRwtc+txb7k+RT0=;
 b=uP3oBMuj0shTfyBevqdx9iuugbp8+4nYsoZpjqS9qIW4e9BgJ4NJGRNFLiA+0A1pGf6ZoKT2k9BKSh/8V8JFKIBX4NkyMcch5xUl4t4HsWFr5uOZVwvmDYQ6dxDb1NSjL300zxzRcdUwOGyzgJeBGIubN9OLKpw/GNPeuTEAExB2Xt6YWV2c5VQ00siyWPDJNRmNHjP8ON9pmnrDELClzx1jHsoBRPiKOcxgh9ziO8D+zjtZfEE6C0o+/QS4sxEwAl/BdEWTydJEwRigByA+SUr9eH4bSSP8merLOAQPj4Gu68k1TRlEeF8ngjmWlOUqSJbTZFjhpLzY+QbRW6TCLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtxEcq8/rrik0Wzr48GC89XrcrhsXRwtc+txb7k+RT0=;
 b=hmnI/TWxp95EGxVCWzqHrCY+AHaQvb04QNBuIrKnzr15d96OTQdif5XWDXlUnh6KbHpn99PDr0QgmLQ65DfVbrefzZe6QWoiJSOuLYs/83PlOLX/JsPZgkXgGdRtxT01R/Grjm9fOAyhnzC8A5mCKKlh/wmfwE1+KuJ5oBhOTAc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GVXPR04MB10705.eurprd04.prod.outlook.com (2603:10a6:150:223::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 15:09:44 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 15:09:44 +0000
Message-ID: <b62ddc9c-ef61-4ab9-a00d-5ea4a60e40c0@cherry.de>
Date: Thu, 17 Oct 2024 17:09:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dm: core: downgrade some dm_warn messages to log_debug()
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20241015-dm-debug-less-verbose-v1-1-366e8f00b556@cherry.de>
 <20241017-clambake-trekker-048460185316@thorsis.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241017-clambake-trekker-048460185316@thorsis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0167.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::15) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GVXPR04MB10705:EE_
X-MS-Office365-Filtering-Correlation-Id: 72a051ff-5fe6-425a-ad1f-08dceebdbb44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2tIWFNYZ1JrMDlrM2xVT1p5STk2aGg5cUV1Nnh3cjE0enRTZmhYUFNCaDRS?=
 =?utf-8?B?N2YwRUxvMyt1aWxrRGgrZHlNQlhJbVZUcnIwbzY0djU5cGNjaHhKMXc3aS84?=
 =?utf-8?B?SGFKVTEvTmxDOEdOWmk0SDc1dWl5M0E0bWFKL3pvVzZtbWxFVTlaeGpqMXp2?=
 =?utf-8?B?ZEU0dWlJYVMrem5lMWdRRTdwRHFXeVVpd1FaL0drMFViY0dRMEhPbTJwTk1p?=
 =?utf-8?B?OUgzNW1OY1ZCRFRIQnNvRFpVMEY0UTZrWjFNdkZ6eEEzT3NubjFyK01DVkxu?=
 =?utf-8?B?NURSb1lmREZwZGlYb2dXMFJoa1k4T0x4bzVGTEhRSWN0U1U4RUpUbWtkb2RN?=
 =?utf-8?B?b1Y0NTdYcFdHRWJWamtFdXdtZ1FOWDRidDlvK0F2THcya3ozcG5ab2srV1cx?=
 =?utf-8?B?VFBhRnVNSVg4b2p1VTlxTVUvNXEwd2xRNEJLbTA5L2hOczR0T2EwWi85OVNi?=
 =?utf-8?B?WjFnczdNMFM1dVN1czRSUVVnZTZyOEsxZjl1TFpFSGJzMjVuajk5Zkhvcnp6?=
 =?utf-8?B?aTdkeldqNHgzQXUvcnZFLzlXdHBXZzYrdFVITWFQUkNBWFVQbzF1YlliMU5k?=
 =?utf-8?B?VnZsY1RDZFdiMUZTWHh0ZHNjcWVRYnJHeFR6dmpaYlhmS3NtcTkyYlNZUmNT?=
 =?utf-8?B?cXVwUHVGN09NY3BHdFRObzBtRkd1RGpKNlM0MGxqd2lJRDFvMWh6K1NRbVBG?=
 =?utf-8?B?aEdCVFVyTnYwTWpucHMxNDZkblpTU2RZSDEveWdIRkJlbjA5ai8xSTY5NGc1?=
 =?utf-8?B?ckc2TVFOMjcxdWJJU2FXUE1va1lEb2dXd3duS0t5cC9yNURlYTdzMk5WTFp0?=
 =?utf-8?B?dTFHWWNyMFNYYmp4YWNoUzd0d2VVT2RvY2thazV5Y3FJZHlqNERqNDVFZWNW?=
 =?utf-8?B?VHlUMjlaL013dDNBejEvRXA2NW96cTJsWjhsL3JhSndPWEpWTkorc3JCRGZn?=
 =?utf-8?B?ZjVsUE9QVktxOFZSZjMrYmlkSSsvMXZuaGNqZ2RpVzNSMm85NDBDanViaGlt?=
 =?utf-8?B?SjFJQmRVQlFiT2xvYlViNVNEN2FBR0paaFcyV3ZFaXNselJGd05LYVpGNTdn?=
 =?utf-8?B?NkdySlVmb01qbklJSHlLU1VQTWVTRUc0YmFQNklWQzRTZUZsTlI5dUFTRk04?=
 =?utf-8?B?Sm9nNHJyMDFPdHNnbHE0VzU5YmZWUkV6R0R1SG5obkRJZnB1RndBMTRSaUVS?=
 =?utf-8?B?aHU1NkZrUVNUNThNQk9YbzlCaFp0TVJDSlFFbUwwcS9NdENIdkdZb2R5OXhH?=
 =?utf-8?B?RjlqRzk0OThVL0JCdjZqVnc3Zk53b3dQelRwNzg4cWVza0kwVWRCT2lWaDRq?=
 =?utf-8?B?M1ozcXdhVXdEWGRiZExVMGhGY1hPWnFUeXlsb2dkMTNNNjhYblhOV0RxVHlM?=
 =?utf-8?B?dUpncXFLaTdERGVHTzdlVDNVWjM3WkMrY3NQYXk3QmNLUzRWWi9BM1dxZGhq?=
 =?utf-8?B?RFYzQWpvaTVSVTJpSW5oQkNEQ2Z4bmFJV05UOUJUWk1oWlF1UUR4QWRiT28y?=
 =?utf-8?B?SjJFTkZ0bFBLQ2x3VnVlNENiYVcxbndpV1dBVmp6amxkRmRRRERFUzVSdnVO?=
 =?utf-8?B?N1ZhMitES2dvZkRNaVZtVGRGWXBWeGJMK3RiQ3NzNUJPWEpYbkQ1S2ZOS25O?=
 =?utf-8?B?WHc5TE1YZExRdndwQlVrblluVjg1aGt3Vm12MVlKWTd0SWtnSVpMNzVUR2Zt?=
 =?utf-8?B?REFPS2xUQmVPNitqcEx4VjZjbDUrbE1vdjZheFBucFVBR3M5cFM3OVNhQTBQ?=
 =?utf-8?Q?XO8v7MsfZvrNSQ91wGOpFa9mO4w6DeNL/hCcEfg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjBqYmo0c3B1Q29kT2ZQMVBtZUhVeW5aZVVmL2VUQVJpc3RKaTdTR01sUHlS?=
 =?utf-8?B?bnovdFZEcC9TbnQ5TTBlRW5uUElEUDFuU0JxODFvNzQwWUgxWE92blZ5R3E2?=
 =?utf-8?B?Z0N6M3JHNHVzc0h4WnFnTVhGMTFOUnpjVE9kUDJCODN3QjNMYzVJK1hZOW13?=
 =?utf-8?B?NGtvcGZIWnlXWmpyOGlqOEtBTCszVDExK1FCYTBLQ1U1SjlUVlUrZjhsazRj?=
 =?utf-8?B?bzI1RXFqYmoxZXFuU2ZTQXZhcnpjRG5tTk5EWkFxUWRHREdiaTNOcTRZbWRo?=
 =?utf-8?B?ZFAzVTgwdVp4MU5KYkppMmlXc3Frd0U2Z2NlV25yYm5Lb0NacTdnU1hoRlVE?=
 =?utf-8?B?V0JpTElRVVN3RVNGR1lzRFh4MmxkY1ZGckR2VjZKckRhM2ZFM29qS0dlblQv?=
 =?utf-8?B?bmdrc1ZudGIwYnkyRDJFdVN0Nk43dnFpSURIM1ZXUXhiUC9ldmh2UXBwSDlF?=
 =?utf-8?B?NUFzNE5JS1VVM3p6aE0rck9NdFM5NUs2Uis1eWl3UlB1OWxTYVpwaTRiLzJh?=
 =?utf-8?B?TEpJVEl2TE5xbXpteFRWWEsreVZ5Z1B5TkJrZEVmekJOQnZsWGlwUVlyWmJY?=
 =?utf-8?B?RzAzQUtFVjJYTUhIemdSZWg1VGdGYUlTRWZ0Wnp1bFVSMjRSZ0pwd2JHcytr?=
 =?utf-8?B?WExOajdGTUhTSlNXTzVVNjU4b1pyM296dGt5akNRWDdGVHNNY2VLdEtZUkVn?=
 =?utf-8?B?QXNsc2hLK2xIKzQwRlN3Ulp4VkQxRDlDZFAxMjA3VCtQM0kzUVBvbnJHOUVR?=
 =?utf-8?B?NUpTMStrZ1MycjNOb3Q4RW8zOXlGVlVzMUt1R2pzZDAxbTN3R01aQi9KcnpS?=
 =?utf-8?B?MUJrOW0yU3ArQnpQYVFFS2MvYUdMbmtUWUlXWUhOWUllcjEzUEJCVVk4d2Jt?=
 =?utf-8?B?K0pWc2pCUkY1ZUNncURucERXZTFTNHM1MmdsTWozZHFua25FdzdYM2N5QUk4?=
 =?utf-8?B?b2hlVW9aRnhiM0N6K21lT3d3aytDcS9mOXpxNkx0azdiNnIwaHhBTHFTdGhx?=
 =?utf-8?B?Y1d5SVhYOWx3TExFTU92eGhNZVc1RVZpUTJESHZNTTdIOVVlSEtvNE9PaXIw?=
 =?utf-8?B?WGJxZ0tQSldpSmUrQUFtcFZpQU9qMEg2VmRJcjFvbkdhWHJtakZNMVU2NjBO?=
 =?utf-8?B?QnEyVGZJd0czQjdxY0d2QVBpTUEwZ1dGNHlvdnlTK013YjF2WURodWRuSHF2?=
 =?utf-8?B?VVU1SHMvRTlkV2pGWW5WcjdOanVwTEhEekN5dTVrZCtnWGVmRk83dU9rcVo5?=
 =?utf-8?B?a2ZoeGZGVXRNMU5BNC93eGZpNGNYV0NJb3BOUlFqOXdSVmpOakVJVWRHS3U3?=
 =?utf-8?B?LzA2d2tsNTlEQmVPWFdLLy9lOFhRcm1USGdGbWNHYUlHQTNlblVXNFMxVGpy?=
 =?utf-8?B?T21OSG43VXAvc25MN2w2b1Q3UzNvL2pHR1p2LzZpOUpLcmE2ODFBdFYzOFNa?=
 =?utf-8?B?VkVZL0hRUUh0RE14ai9HRVZnWHp2M25ZakVJdmZ4QUs4bk8rVmV4TnRXV1Y3?=
 =?utf-8?B?c243ekNwZWxYdWVJOU1VSkVxcVR4MTdZQ2libis1TUp3NGYxZXZxWFNJeXp0?=
 =?utf-8?B?aHFqZEVSZCtBbWRTZk14QS9sWU9QYlBwYlRuY1JLOThBL241QVF1cS9rbEhD?=
 =?utf-8?B?UThXSHZaWEJ6VE1SejVLay93STRlMnJrOUxydXI1U3FmRzZZWXUwNUlXSXBZ?=
 =?utf-8?B?RFJkdm11cnhhYzljbHlzb1NpaTRHUzdZbVlNZ09zQkVSLzRHa3l3UUU4bkln?=
 =?utf-8?B?UjU4aWpMMXFmM2ExTU1qRTZvVDJLQS9FM3U2dFRLSG8wWEd5TFV2MGoxc0hZ?=
 =?utf-8?B?NVFoaldUWVpHbEZRb3pnK1ZJeE9aWWFYK1ZqQWdhWG9vZkgyeFBOdGd6OU9q?=
 =?utf-8?B?WjFFRjFvTWhwN0k2RmNUSHl5WG4xalpwYjNnS2M2eHcwVjQrQU5sWUhTWXZx?=
 =?utf-8?B?NWxFRWw1a2FEQmR4bnVXVFppanMwS1oyZk8vemJRbEdxRFIvTWhaeEdhMlJJ?=
 =?utf-8?B?VURZZUtXWE5EUkpCTitxaURwR2xaemI2dWhJRDhLQVVvWi9mN1ZONmRxSWxT?=
 =?utf-8?B?TzJGV0J4ZTg0QnBTN2o3dU4xeUxDK3VPdEFXNUhoTExVVnJUNTNORFkvY0xF?=
 =?utf-8?B?ODQvYW41V04vK3p2ZkcwNXFxMzNxdW1paUVvb3NvZWROS3c5WG0wV2pEMmwz?=
 =?utf-8?B?TEE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a051ff-5fe6-425a-ad1f-08dceebdbb44
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 15:09:43.9278 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 18lbGTMsfj1j/KBdePGhCzbb4P3quys5MM6FezxCKLvTZ+dPdFxsPyvFlzJoeybL8mdyc5apYZuD54QdONKBmfFN4+x3ECWYMJJkVwDHePs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10705
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

Hi Alex,

On 10/17/24 4:56 PM, Alexander Dahl wrote:
> Hello Quentin,
> 
> Am Tue, Oct 15, 2024 at 04:32:14PM +0200 schrieb Quentin Schulz:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> People complained that enabling (SPL_)DM_WARN was now totally unusable
>> due to the amount of messages printed on the console.
>>
>> Let's downgrade the log level of some messages that are clearly not on
>> the error path.
>>
>> Note that there's one pr_debug in there, because it is followed by
>> pr_cont so it made sense to reuse the same family of functions.
>>
>> Reported-by: Alexander Dahl <ada@thorsis.com>
>> Fixes: 6afdb1585112 ("dm: core: migrate debug() messages to use dm_warn")
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>> Note that I am not entirely sure about the "not found" and "not large
>> enough" changes there.
>>
>> Another note, %#x isn't handled by tinyprintf so it just prints "x"
>> instead of the value.
>>
>> Finally, I don't know how one can enable LOG_DEBUG level without
>> enabling DEBUG which enables assert() so I just tested that by removing
>> the #define DEBUG in include/log.h :)
>> ---
>>   drivers/core/of_access.c | 36 ++++++++++++-------------
>>   drivers/core/of_addr.c   | 26 +++++++++---------
>>   drivers/core/of_extra.c  |  6 ++---
>>   drivers/core/ofnode.c    | 68 ++++++++++++++++++++++++------------------------
>>   4 files changed, 68 insertions(+), 68 deletions(-)
>>
>> diff --git a/drivers/core/of_access.c b/drivers/core/of_access.c
>> index d05be273e7bbb68c3ad82ef4c1c036ae7f68ae61..77acd76626257b6da95a27d107052ff8800c2b67 100644
>> --- a/drivers/core/of_access.c
>> +++ b/drivers/core/of_access.c
>> @@ -490,17 +490,17 @@ int of_read_u8(const struct device_node *np, const char *propname, u8 *outp)
>>   {
>>   	const u8 *val;
>>   
>> -	dm_warn("%s: %s: ", __func__, propname);
>> +	log_debug("%s: %s: ", __func__, propname);
> 
> Printing __func__ when using log_* functions, is redundant, isn't it?
> You can enabling printing the function name through the logging
> framework, right?
> 

Only if LOGF_FUNC symbol is enabled, if I understood correctly. Not an 
excuse but:

$ git grep -o "log.*__func__" | wc -l
202

So there are a "few" other places doing that. Will let Simon decide on 
that one, no personal opinion.

>>   	if (!np)
>>   		return -EINVAL;
>>   	val = of_find_property_value_of_size(np, propname, sizeof(*outp));
>>   	if (IS_ERR(val)) {
>> -		dm_warn("(not found)\n");
>> +		log_debug("(not found)\n");
>>   		return PTR_ERR(val);
> 
> What about using log_msg_ret() instead in these cases?
> 

log_msg_ret will log with LOGL_ERR and not LOGL_DEBUG if 
LOG_ERROR_RETURN symbol is enabled, otherwise it'll simply not be 
printed. It's a change of behavior/expectation here.

If we go this route we should at least make this a bit more useful by 
adding the propname to the error message since it would be printed with 
log_debug() at the beginning of the function, and the log level wouldn't 
match. Also, this means that enabling debug log level but not enabling 
LOG_ERROR_RETURN would basically print the first log_debug() and nothing 
else in case it fails. A choice to be made but it's a bit more complex 
than the one above.

Cheers,
Quentin
