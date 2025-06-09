Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5923C61CE8
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 15:08:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1A148144A;
	Mon,  9 Jun 2025 17:08:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="XL1Xv9db";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C133482AA7; Mon,  9 Jun 2025 17:08:18 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC65F811AC
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 17:08:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bX9P8UIO8twzxntgZk2vUP+G0xb4fN4JP9JDUjwizzW581uX9jCUah/9pPOZ6fQD5kgHXihRtPRQyBEyNMkklBZ1ZDszzsXgvpmH/+9vTweWthN/RXlUDiH1s+HvpbnfsV4hMZGCGHFWI5z8kMRoz4WqxzrLF+0oo8c/sAN3/BzC7/uZXcJYr+3i5hgQA5pm1VldOuD7ws7gyhcaR3nvmQ7eOsdHj6N02w58h6kJD2jkG90MiTyD5LOMgrqqAIwt7duggesQtx6O4xj4SH+DKhUFDrbi7c+qpC2CjIUjmmGLNTacqOyhnc4d/11xmIvahhrAk3sQdsee+8vhS9eyGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uctO/oOV1c6/J9Mu51J57C0e9xqZKRGkFJ7TP5cDfuk=;
 b=Dsh313WjTS8xgP8DL6iDPp2QVSZtmo5aT1bMiJV7d7ZdxcSQZTVvFSUvm05RQ2e8KZes1smFucX5tBDb1ICDo4tYPo7Up3st9FZrEJC8ajITwA/D8BllqPQdUMkuKGUoctZDx49afwqWrvpjndGg+A2s/j+rtnWNJQhDR3MEyx5tf09hw3igw/tVhMa0meZggKh0Yy6gliR9ozAagdiRt9OB6wJJsP/suDBV5O6SmVfV/JLl4HTZuyUYnK6hjB01lVmyI+V+ibHXZrgAdhK+QBVc8jNkPqB4B6LMJTuzU02+a2SzLrQgyoZ3J25l3Be7fa8IwnPVOpRYG5uyw8QleA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uctO/oOV1c6/J9Mu51J57C0e9xqZKRGkFJ7TP5cDfuk=;
 b=XL1Xv9dbl816a/6MWXLA7CGNiYVWnaumsaLSVQMVSCBpzXG5Fdpk5daCHoDMIH+7fltQLcNgMQBOd3xpkDCDb0RcI4Jt/u1aHQ4Zf4JYZgK5LPTngKvceWpt421vYLpqdyrlKpeO1aq26kEcBvdU4HHmhiCw/2vYn0s6E7esL3tgr19iV9QTYiOygmS8wXI/KpmWR7DsrXkWjT2aqbvfPMl4J3wAMipVReaoJzGMjQ9Kv9AOgr87OMPzAb+6ODXMLg0/jA4FPdRvBNpQZ8ukht4ELnnMg2w8IDRuCCFujPYARqPOi01c4mO8MbL1UFOo85IB9ZVbtZNhwymyoKQ1gA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS1PR08MB7538.eurprd08.prod.outlook.com (2603:10a6:20b:482::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 9 Jun
 2025 15:08:14 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8769.037; Mon, 9 Jun 2025
 15:08:14 +0000
Message-ID: <cbbea5ef-2305-47ce-8cf6-ec5cff2f15fd@iopsys.eu>
Date: Mon, 9 Jun 2025 18:08:12 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] common/spl: improve error handling in spl_fit
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Edwards <cfsworks@gmail.com>,
 u-boot@lists.denx.de
References: <20250606205410.GC1382132@bill-the-cat>
 <20250606223109.502055-1-mikhail.kshevetskiy@iopsys.eu>
 <20250606223109.502055-4-mikhail.kshevetskiy@iopsys.eu>
 <25bb722b-4205-4009-bf4c-3ed4cc32adbc@kwiboo.se>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <25bb722b-4205-4009-bf4c-3ed4cc32adbc@kwiboo.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0034.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::31) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS1PR08MB7538:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bffc1b6-80fc-4cf6-067c-08dda76774ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TlhlM2M0dE1GWWY5MHNZblNTc0FXZTNGbTFxNmVPVEIwQmg3RHVKVlZ2QnJm?=
 =?utf-8?B?dklhWE9CcHN1OFFZb0g0MXNObHc0TXJUcC9ITUQ1Z3ZVdUl5cWJ0YXZMZTJY?=
 =?utf-8?B?OXBaM1FtYXZUSHpGV3lBZmNLYzFTVUExeWdQTjFOSXlaaVhhRDA0T1NWOWZz?=
 =?utf-8?B?N25RVTF4ZTJtaG11cFJGL2lpKzFRWG9HTUhPS2FQaHAwSW5IOXVicHNUcnM4?=
 =?utf-8?B?QUpQRUliUWVKMTlpNis0TjNkTEJWcVRiMGxma3RnOCt3TjNRemdwSnpMS1JF?=
 =?utf-8?B?KzlxdnpnOUM2OEF4ZDFXRG9FWHYva3NkS3c0UlpoWlpha204TlpzZ2xBcnp3?=
 =?utf-8?B?UlEyM3dEbUwwcUVJZC9xNGJUU0FlbGlxWFdqUlBTZGJYWlR3YjR2L3BJOWxy?=
 =?utf-8?B?SXhmWVVvdS91VmhDSDZhTk5pQlRhU2d2SW8veElaWnZOMkRxSUJXOENBMysy?=
 =?utf-8?B?ZE9tNWxtTVVwWHUrWlhWdmxYUWI3MHd2M0lxT25aNTFBT241Q0p0SHZJcElt?=
 =?utf-8?B?TkJ2RWJmQzFoMkZEK0hKR1dYaWZKRUFwNTcvV2dPcjRSSWV4V1hGL0E5bDFY?=
 =?utf-8?B?MUNFcFJPR0grMEFHM0RTWDJMOFNPbWU0dVUzRE9OYVJrQVVOaXVvTHBnVm96?=
 =?utf-8?B?UnZoZWVYWjE2em5XUm91eW92OWJQb2VHbEtvMzJyLzFYSXc3YXE1djVPZmw3?=
 =?utf-8?B?NXYwR0MvNU9aRlc4WnRkSDkrZE5XZklPaElCNko2UWQrRnV2NUhqb3Mzd2tv?=
 =?utf-8?B?cTZNVkp3SDZ6RnlBWGVxOEVBMnlIV1dkQmF0a3k1ZnA4eUIyTEIrV1dwL29w?=
 =?utf-8?B?ZGJRTVBnaXdiVXcwK0dMU2RabWtPSkRuek1zZE5QTFQvajNiNS9ZcGUwY1Iw?=
 =?utf-8?B?UDFzamcwek5GeHBvTUliQjc4SlhmakE4V2ViMFVQRkhCZ2FzNklQcjIrRkRk?=
 =?utf-8?B?ZkhMZk9PR01yYllFVUpFREpnLzVvUC9OU3M3S2NzZUEzYjhpY0U5eXMrYVRI?=
 =?utf-8?B?eVlTNkNLTmRxZHNENHFvNDQ2aldmSGZrSGNIaXpaWEY5dmtHQUxLSTBKMVN6?=
 =?utf-8?B?RTNrakVTVlZnKzhWT2dxTFZDR3RzMStpVnVvWGRsUVQ0b1VjUldEV0ZKbGlC?=
 =?utf-8?B?NXo4T0FWRkRtUTVQRXVYckxZU3J5NWsvVFA0U3BBM1VkOGNWbmpsSXIvRC91?=
 =?utf-8?B?M05LMWhrWFROWlhFZkp2L1ZVVGZGdDROamhTdW9Yd0RkNWlhV1R4bm9TRVht?=
 =?utf-8?B?Uyt0T01IZm01SlltQ3VqTTloOXY5S1JSeTJzQzc3Z0NwTHBLMTY3Q3BOWWR5?=
 =?utf-8?B?Ykpld2tMa1l0Qlp5ZFY2MTI5NnJaMHEzYTNFc3NtaURzZ0lxYjRDTEJGOUU2?=
 =?utf-8?B?THB5WWRJUll1MFhCRWVNNjhBKzRyU1VWdmxUamZ0U2R1aDg4elhxTk9teFly?=
 =?utf-8?B?cVQ1OWV4OXoydzBXWDZtcDdyRTJLWHdrVFNKVjl5L2phazl6RGY1OFA0MXFG?=
 =?utf-8?B?bktPZG8rWUJoQXdNSjVQVGVnalY4OGhqREFNU2xidExYYVJ4M3Zkd2tBVmpF?=
 =?utf-8?B?a1ZYODdnUzlrd2pPbWV1Y2JrOE1kY0ZFaXdWSnpYZVlpUlFpN0JYR1NIeEdy?=
 =?utf-8?B?S25LTC9OSTdpS3pkQmtXZEkybFBCUW1MbGUxNzFXZithaDR0T2pkSllpWlFm?=
 =?utf-8?B?SWFpc3F4T3RTTGZncUhLYVduNzRlTi9sQzRHb1VIUG1FbnBHc3BwcXVuUkgy?=
 =?utf-8?B?MkpBejlZQWl0ek02T0loMHp3VzVTRUFQZjc1NmNNOGRTYkE5ZEtIV2xsQ2hq?=
 =?utf-8?B?OEhVaVcrMlhEUEJKdGhsY0ZobjdnbGVxYmFEVVltVk9XbUwycDFnamprUFhk?=
 =?utf-8?B?R3cyaHh5eHBVV2VhbVVVV3JNV3gyeitmWXN1d2xpb2h2L2hKRFpKUmVacUJE?=
 =?utf-8?Q?4PyGjsWvyDM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2tKaCt0TVcweHZZRjRmSXNHRFc2MUJCUjg3ZmsyUXYzUlBZMkgxbTQvNFRD?=
 =?utf-8?B?T1pmQU1WZ2pWK3lGSytzcCtHYis2alZ4M2c0YkpoR3J6U1g4aFloa21HNmVh?=
 =?utf-8?B?QU5Rb0tjMHIzMjRLaFZwYyt5UWxxWDZqelA2M1o0c1pYd0VLdnE2Ukdaa0pl?=
 =?utf-8?B?YWVNdjhDczZLWFhRVVdlL2QvT2cyaDRkc3FyR3VBWGkzSE9HVnVQTTBIOXdG?=
 =?utf-8?B?L1B4ZHNRVGdKbHFQa3pNQ0E0emVUZ214QXJGVHRlNFZMQzg4S01BY2JzcEd0?=
 =?utf-8?B?dkQ5bGxzRkhEanZ3MTdtYSttY1dBWElyeWVvNlF3Rlg2V0FtSWdpSGdOd0RL?=
 =?utf-8?B?MWZOZnhzWWxveWlhNUhzeEFCUG1mMjZRaU5oYmJVcGRybktyYTJwSE1kQmsz?=
 =?utf-8?B?alNZTVFiVmNyazhjekl2OFJWL0xhOGExaU9yaHh5NFk3OHpiNGRkNDJqN0V4?=
 =?utf-8?B?NXdYYkJtNThxUVRrRVE4TWNNVm9WcWtvNDNrV0o5Yk1kNzRrbUVaN2sxeVl0?=
 =?utf-8?B?S3ZYSCtBbU9OcncvUzBqUjYxRlQ1eStCTE9FR1A1dm0xWDZxK2FHYjVLdWVP?=
 =?utf-8?B?WWVPR2YrS3M4V05USURSTHJtNlA3YVdGbUxuR3dsTFVLU2F1S25TalVhSjR1?=
 =?utf-8?B?M0RXMDgzdytYeTRpelhkY3B5OHgvcDE0NWVRSzhPamliYnhadk5oVE1NdXdL?=
 =?utf-8?B?d0dqcENlM3pwQlAzSk9LT1Bmb0lVd3laUS9iRWFjMWE1OTVHVUpOWWx0MGI4?=
 =?utf-8?B?eXNEMnZ4b1VUR0JLbVFRZ05mTlhIY3hTT2ZTQXM4Y1h6bmVVMUsrVCtQaDcr?=
 =?utf-8?B?NHNoSUFvNCsxUUtma3NJMjN5YWlLRmMzai9ScEFUR014Q0R0V1liRDVqYU1O?=
 =?utf-8?B?Y0o4SjBzYnhXOU43ZWNrcGN2U081ZGpKUFg1SEtYRUQ0WlRYS3Nza01QZWJt?=
 =?utf-8?B?NnM4YkhNOVBRN25sck9EY3dwU0t5YWYvdzFUL3Q5TFB5UERmTllDOG82VXV5?=
 =?utf-8?B?OHlEZnJNRTg0WE1TY3Jyc1c0cXNHSnZjQVN0WVdsckg5Ums0V0VSL2cxTTJq?=
 =?utf-8?B?KzlYbkttZEt6dXJ0MWhhYlJSYkxnZDMxa0Jienk5YkpzYnRXeWdVZHJDL3h2?=
 =?utf-8?B?QUNuQnhyOExaazFGQVhnZHNDd3UxK0svUXRmT0tkUW9SK0ZpZVNMU2hVdEhE?=
 =?utf-8?B?RmVGZHJKbnZrMVN2Q3BqTU9oQU5QUWFwKzdiNXFWSXh2MC9LZ3ZDbGpaQ1dH?=
 =?utf-8?B?ZE9QUk9hcWdjb0hsb2lnQklFcmRKSlpCVDJRTWRZU0xNVDdqVWgyd20xbHNv?=
 =?utf-8?B?MUxjNHF5TkNuaCtnZ0xXUFRoTElMVWJzdENyZ3FPRkRRS2hoaXp4K0lpd0tw?=
 =?utf-8?B?QXFxTmlBcXh6aURNOW1GMlFEdGpkR3ZKS1RhSXBoYXJIaWZrRHBkSTh4QjBw?=
 =?utf-8?B?ekMyOW1wQkJKV1BEczNSRFpyNDJORFZTZEpVeFRpbzdBcWhaVTRsUml6WDBo?=
 =?utf-8?B?ZDk2aG5aTWdlelkydGlSR1gwNWxPaFpRNUszYTJybFNLRlJnSjNLUkJMNTJt?=
 =?utf-8?B?ZDJDVGRQbXptWEx4TG8rUGQyYkd3bGNLRDVwU0IyZVRjTzVDb0ttVDE5d2lP?=
 =?utf-8?B?RjNXQlJoOUxyaHV3YXNRbmV0L3FZVHFhVTJQUElGVWNCWGFNY3VwcWhNUUM5?=
 =?utf-8?B?SWt4Uk45dDgwOUtXdTJ3dnJsQmVWVWxveEZVdEF3dzAvV3NBV2lWdnEyYThN?=
 =?utf-8?B?SXd4a0NTSW1EVWZsRjF0ZG9HNjkxeTM3R1J6Y0VRYzljZjltNkVyVUpnekk5?=
 =?utf-8?B?OXozZmwveEd6ZGE5eUZ1RlFiSTBNOVhqWHpsc3QySmZBNklWVWtoZ2Zwa1pP?=
 =?utf-8?B?QXJXZllacUk3ZGVzem54eFVkdU1vUFFiR0xLa3Q4VmNnT3g4STNUZWNYL0ZG?=
 =?utf-8?B?OHczWjEvSzhzZFhxb2xuVE96VzFseHovN1lRLzQ5aDgweVVkWWJ6VHcwV25P?=
 =?utf-8?B?NEt4VVlCaE9lL0s5VG5yRTBKdkhOUmJjNThwbFdYcXpZMFJwajlHTCtscnlL?=
 =?utf-8?B?YnFHS2w0UWRYakI2M0luL1NnOUZ5amNWU1JXd0FJME9yMkh6NUgrdUlFMlBi?=
 =?utf-8?B?eERkckZ2YWRrUXZnVXIzaFVRWlBYT0pwY0hHSWt2MDZ2a3k1b1VMRU1ISWxK?=
 =?utf-8?Q?6y6W/CYAltuM40WV9F4qXRk=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bffc1b6-80fc-4cf6-067c-08dda76774ee
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 15:08:14.3450 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v18VlwtrAxLYTGPak+QZzYL9FlWPssONbHBZSot/tFubFShbiauac7vwp9iOQdcB87jdZ88+OwZ0TpWbpn1OVtEoLSeiyVK9eoVo8UcnL5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7538
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


On 07.06.2025 11:33, Jonas Karlman wrote:
> Hi Mikhail,
>
> On 2025-06-07 00:31, Mikhail Kshevetskiy wrote:
>> This fix a possible NULL pointer dereference.
>>
>> There is also a risk of memory leaking within the same portion of code.
>> The leak will happen if loaded image is bad or damaged. In this case
>> u-boot-spl will try booting from the other available media. Unfortunately
>> resources allocated for previous boot media will NOT be freed.
>>
>> We can't fix that issue as the memory allocation mechanism used here
>> is unknown. It can be different kinds of malloc() or something else.
>>
>> To somewhat reduce memory consumption, one can try to reuse previously
>> allocated memory as it's done in board_spl_fit_buffer_addr() from
>> test/image/spl_load.c.
>>
>> The corresponding comment was put to the code as well.
>>
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> ---
>>  common/spl/spl_fit.c | 18 +++++++++++++++++-
>>  1 file changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
>> index 783bb84bdb5..438d1ecf124 100644
>> --- a/common/spl/spl_fit.c
>> +++ b/common/spl/spl_fit.c
>> @@ -703,13 +703,29 @@ static int spl_simple_fit_read(struct spl_fit_info *ctx,
>>  	 */
>>  	size = get_aligned_image_size(info, size, 0);
>>  	buf = board_spl_fit_buffer_addr(size, size, 1);
>> +	if (!buf)
> Are we sure 0x0 is not a valid load address on all platforms? On what
> platform are you seeing this being an issue on?
>
> On e.g. Rockchip 0x0 is typically a valid DRAM address and could
> theoretically be used as the load address in xPL, it is highly unlikely
> because SPL is typically loaded to start of DRAM at 0x0.

Actually I think it's hard to find a platform where 0x0 will be a valid
load address. I faced with an issue on airoha arm platform. It have 2 boot
banks (active and inactive) placed on spi-nand or eMMC. I occasionally
flash wrong fit image (with data placed inside fit structure). During boot
almost all available memory was spent to load this wrong image, so it was
not enough memory for loading from inactive image. The board was bricked :-(

>> +		return -EIO;
>>  
>>  	count = info->read(info, offset, size, buf);
>> +	if (!count) {
>> +		/*
>> +		 * The memory allocated by board_spl_fit_buffer_addr()
>> +		 * should be freed. Unfortunately, we don't know what
>> +		 * memory allocation mechanism was used, so we'll hope
>> +		 * for the best and leave it as is.
>> +		 *
>> +		 * To somewhat reduce memory consumption, one can try
>> +		 * to reuse previously allocated memory as it's done in
>> +		 * board_spl_fit_buffer_addr() from test/image/spl_load.c
>> +		 */
> For platforms using SPL_SYS_MALLOC_SIMPLE this comment does not fully
> make sense. With SPL_SYS_MALLOC_SIMPLE no allocated memory is re-used.
I know this. From my point of view some comment is required here, so peoples
will not spend a lot of time to understand why errors are not handled
here and
why the memory just can't be freed. I know that my comment is not the
best one :-(
> To my knowledge xPL is typically running with size constrains and memory
> leaking and re-use of freed memory is typically not really an issue as
> main purpose of xPL is to load and jump to next phase.
This is true for most cases.
> On what platform have you seen the need for this memory to be freed?
See above.
> Regards,
> Jonas
>
>> +		return -EIO;
>> +	}
>> +
>>  	ctx->fit = buf;
>>  	debug("fit read offset %lx, size=%lu, dst=%p, count=%lu\n",
>>  	      offset, size, buf, count);
>>  
>> -	return (count == 0) ? -EIO : 0;
>> +	return 0;
>>  }
>>  
>>  static int spl_simple_fit_parse(struct spl_fit_info *ctx)
