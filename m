Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25357CF9C6E
	for <u-boot@archiver.kernel.org>; Mon, 23 Sep 2024 11:21:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D047288B16;
	Mon, 23 Sep 2024 13:21:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="mJzW50c2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2A1488C91; Mon, 23 Sep 2024 13:21:11 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AB3E88A0E
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 13:21:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4I0hbrbB46dOBZa1KBhu0tWoMM41CxzV8BmfGSJeT7YLHBKM9HRPBphHdJ9zGO9RGgsIvOtHWf60V6LDEpnzCh1BwkZAP7npRo1WFF4p1vxlogWVAaiYtjTbRYQDUR7vYlYw3JOkByNVLT8jKLnBLwuuFXXJ88M6iguMwPmPHAJTUTPhKWphPcCQlAim1pBq5gxYI/Ze08EahurO6HS3Tsqgxs7vCxrZxMRmK5ZNh2rFsM6/1ntl9L8wt46QqQG41eHhoMM85ZfRkqcAXXUy+YYTHQLzKTXgLzIQwtFdloX/PaBtIyHCJ8gZ6/c51jwOfhJXhyLLbe54WqEXYCONw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TzDBgAVCwBSumxbzMG9ajbsuZYT1m5myCStT++HQcU=;
 b=xEqa2STDcceNsOZauirUyNbtqbYAUI/PuLeC4O1PBQjspmRGBlxNN07oQyI/VxF8l3opCfz5fCfp6Xt4Jn8Us3JIkYXj8l8ZcE0J10KFQnWehtWoUjzY1RJBOba1wOgy9rQT3NeMWMW7rF/01yJ68cNQKSF8ev9FDwi7J8DTHK7TLj3UF2hPPyV0Qy7B5beDPrejE6nM0z8vqsi/4WJRijVfbkDZGw5k/tKK2dFmQ2jjlD19jfDa9sgqXwQCJFC1JqymhrS0LXN5PS6dV3y9/dxnkXBgAbvaG3NYxHg+a03o2j7wHue6P3hoCqr8RSisVOrCrM0Os2RBo8MVq5OI5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TzDBgAVCwBSumxbzMG9ajbsuZYT1m5myCStT++HQcU=;
 b=mJzW50c2G2ppviuKhBxCFyhUA2nbY7KnffLSF2QC396hshzYMExtiia669PScW4uFZHlCkUkCQF2TQeziZmgEKL62HdcYTJX94pDPj9LdBupRMSYwU6LSZRnUrHuzLyR4aPuyXJE+Fjxuts8LE2ecgw+xfNdMs5VctcFnDNOT5A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by PA1PR04MB11084.eurprd04.prod.outlook.com (2603:10a6:102:492::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 11:21:03 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%2]) with mapi id 15.20.7918.024; Mon, 23 Sep 2024
 11:21:03 +0000
Message-ID: <2a207719-e37c-4289-9470-2324928e24bc@cherry.de>
Date: Mon, 23 Sep 2024 13:21:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/4] board: rockchip: Add vdd_cpu reg fixup for RGXX3
 Series
To: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de
Cc: jonas@kwiboo.se, trini@konsulko.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org, dsimic@manjaro.org,
 Chris Morgan <macromorgan@hotmail.com>
References: <20240919140022.511067-1-macroalpha82@gmail.com>
 <20240919140022.511067-3-macroalpha82@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240919140022.511067-3-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0007.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::11) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|PA1PR04MB11084:EE_
X-MS-Office365-Filtering-Correlation-Id: 83456e85-51c8-47a1-29e6-08dcdbc1cf4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHNTSUVxT3VHMWhCYmE5b1JFbzZQb0pNZGM2SFRMYnNZODVoV1k4QmNWKy9q?=
 =?utf-8?B?bXhzNmg0aG9zb3ZUR3U4S3VJYUhBT2ZmaUZEWnpaQ3pxam9IL2Fvd1pHN2FR?=
 =?utf-8?B?MzlUaVdjQ2JKNEpwZDhDdXhLN0U1cWlWc3E2TTRPdjg2OW9Xa1IzN1Awa1JQ?=
 =?utf-8?B?SS8rdVlFZFBGVWRETnk0M2hlYXoyS00yNXk3VkFLQTVNN1VNRTQvQlZDSDdW?=
 =?utf-8?B?SHFQZDJjMmdKUzN4blhLQmE1b1YvVUhSRnNoY0puU1hZNVJ2RWxuU0laRWxX?=
 =?utf-8?B?SnhlUm1CVjNZK3VjRnhOcTZUekp5SVlMVDNLbXNhdHpHWjQ3SStrMi9QSWtK?=
 =?utf-8?B?KzBYWTZTNy9qb2ZRVFNVNXhHNkRWS3RreHZPbE5zNXZJNFNUNWdzQ1hFT2xL?=
 =?utf-8?B?bnpZMkR5dUNDbzZWblJ5bTl1ejBsSUh3RTQ1Y0FFNERJZzhqMlh5WEhIVStN?=
 =?utf-8?B?M05yKzVTK1pPMWVyb3Q2UFZGb0p3ZjhSYmNlQkVKbGZEUzZzM2lpelVFNklp?=
 =?utf-8?B?eWpRM1F6Qmd1bTk3bTNnektMM1VKM2NjSU1oRTJMYk45WW9xa3grMFdJeEtJ?=
 =?utf-8?B?RzRpMFBBY1cxUGh4azZxc2lPbzhIdlE3SktsWUY5aGhVOG1xS3h6b2J3akox?=
 =?utf-8?B?QlBiWXpneDNJY0RrNGxneHpNU0NmcXVCZFRqL3JRRHNucXdYSW1ISHNaN3p2?=
 =?utf-8?B?YXZiakFPSjdwejFjNElYOGxjV3ptQ0hCL2xJV0thdmZscmplMXBHRE9vUVo5?=
 =?utf-8?B?UFFKczM1VVNoS0hmZG11aUM1aDA1aXF2QmxBOC9maitsOGVKNjBEbTR2VW5P?=
 =?utf-8?B?VXFZazJocWc2WU9nbFlwUFowaXl3MWRWOVUwODNCTzQ2dy9JVytRQjB0TDVK?=
 =?utf-8?B?TW40ZnJOU0Vac0RkZEtFWjFpYTRLRWVDSUFaOHBxNDJZV0JlcjU0Rjh1WUdr?=
 =?utf-8?B?QUQyYTZDKzlSNXZ5YXN4WVBuN3BpZUNEQzhiMjE2b2FHUVBJU3ZvdFoyNGpN?=
 =?utf-8?B?WC9vV3BHdUdISjhPbjkyWlh1NUZjZU9jUmd2ZTV1YXAxNndJSEN5WnR0TTNU?=
 =?utf-8?B?QTdaQUFtT2d1Uyt4cVJrNThqc2U0N2szanowRDdZSTVjbHhwcHlWT0pISnJR?=
 =?utf-8?B?aWNGZzV0Q1J5RU1QaDAycVBNM2pTT1F6dE83YmZ2ZUZoUk5hdmNrdkxzUGFF?=
 =?utf-8?B?czJad2VTczhZYS9obDVCeTVWWmd6OEJwWlBqS1NtT2tCU2kydHdwV0pTV1lJ?=
 =?utf-8?B?NjM0c0R6K1RIaWY5NXo2RXV1N3ZuaFNpSEpXMXlPbFphNGp5WkI5Tys2ckFy?=
 =?utf-8?B?TkxGVUsrQmMySXFUUkRZajQrOVY3bjVKMzlRaTdpTDQxWm9YbEhYRkl6cnZG?=
 =?utf-8?B?WmcwQVRxNngwNnF1akl5ejFPUGNsZ01hcmNVeUtZdGVrblpHcUtmYmtLNVVp?=
 =?utf-8?B?VysxZWtDYTlVQWdXMU9sWGxQandrUWNmZ3RXUW5VV2xjbkJ3YnE0UGdNc2pU?=
 =?utf-8?B?RjRUbWlqNXZqdG1Ka2hiZGVsQkJ2dlJxTENoVlptYnhabEltMURwd0liRm5Y?=
 =?utf-8?B?cHd2dzd3cTdGMTYySHZ5RlZybFIvQ0F6aXRqMWhjbHJwSzdEZk9yRHJDaE1v?=
 =?utf-8?B?T1ljSHN0SC82dmpKdDB4YlU0TlcvaUIxc3RXQmhvYWNoQlczVlhtZ24wWHFh?=
 =?utf-8?B?NC94QjFVVWhlbnQvTVFON3RVS2EwU29LNGtZa0diWmU5VE9FeDdjRkt3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXZVTWJmSWhNWnRsbDdNYkdVMnJiODltOGNoeGxRVmQzak9MTWFpb2xYenVS?=
 =?utf-8?B?SlF3THFoMjZ5WnZUc1dKM3pZNG5qWFUzSnY2QVNPZDl0bFVMZHFkL1RoOGlQ?=
 =?utf-8?B?S3JRdlBkTGJwUUNQb2pEQTFPa3FMTkVReXZPdTVjc041M1VuMVdDTWZhczBE?=
 =?utf-8?B?cEE2SFJMZExuRm1wTXBnbFo3SG5ERUNROW54R3RFdk9wcCs5TGRnUUNBbTA4?=
 =?utf-8?B?am9pL2tTU2tYWFBabHJMSXNMQ2tVQ3JwV01DTUwxK1lFRnhMbCtSOHFyc0F0?=
 =?utf-8?B?RzdEV254b2R5NStJYnlmaU1kY2c1YlhGc1ZNaklCSC90bEY2aHc0dDRJc3Zq?=
 =?utf-8?B?cWJzb2lkdzFmdzVuNGJLYXFRM2VnQ3JDRjZHT211VE9sVGIwdndIOW5lalJo?=
 =?utf-8?B?cXlHNjh6YkNQWmFrRUVGemJEeWEraE1ydEYrQmxpdG1JL3FyY0NRa3psTVJh?=
 =?utf-8?B?cThKT0lMOGJnYVNVd1JKMDZPVlc4dE94WW92cFM2NG82dmtsUmN0dEN2dll6?=
 =?utf-8?B?NWk0RXExSFk5SGh4ckpWZ2Y2Y2FrcWdrbXJsRWVFZVBPMFJWZ0tEeWhZRm1p?=
 =?utf-8?B?akZweFF6bXhvQzdXWXkzS3hPb29OV09WK2RDN2dnQnJIalRQUDMvRWRFWEJ3?=
 =?utf-8?B?ckd4NUt0cWFlb3hZUUx4aUhoTm5PSXZObnovRG8xa3lkVzV0Q3RuWmxlaWFh?=
 =?utf-8?B?c2I2RFM0WFdkamlFTThHZHRUSlpTeG1qWlFsNytlNUFFWU01dW1ueU1xbFZP?=
 =?utf-8?B?a1Y4eFN0S25TVVQ3Sjl0TXQ0N3JoaWVieVVpd2VVUU5keTliTzRpckpDYkUw?=
 =?utf-8?B?WUxvK1puMnBzY3E0WC80T05KdWh3UURaaVh2SmVkQVFaZXJYSEVYdi9SemMy?=
 =?utf-8?B?WWZDY3JDZ1FmeHV2TXFqUVR1b0V0Z3B0Q3dxVE1SZjc5M2xzMnhSNUUxRUhn?=
 =?utf-8?B?NTN0ZEhTRnJRSGdjM3k3azQ1V05JUWRISGNGNGcxQzNJUUI5Y01DdURtNTE4?=
 =?utf-8?B?RVd0V0x6d3VQbXpsVys2dnNTK1RTMjNNUG0yY3FEdGRUT25FalhNeXNxTFJT?=
 =?utf-8?B?UzErNmFSLyszTVBoc3NYbkRmQ2hLNFFyWk1ZNFZVUTVMMDRzZUdlSUtjOE9n?=
 =?utf-8?B?MXNoZDh1ZkNYMklPMGhuWGJLcS8zSTlraUNBeERqMTFFdnVlS3BxVGg5OFBt?=
 =?utf-8?B?d1R1RGI0ZGJleFJpZWlPRW1oU2tNNmVTU1pxQnRRS0wraHlrYzNCL29lVytZ?=
 =?utf-8?B?VlFOVUMwbWlkSjJyMFFnWWRpZmk2WnFWWTNudFJvaU0ydytDNTlyRVovTkFt?=
 =?utf-8?B?WnRaNUhzVUxqalF6WjNxQldWVWFWanBJdXFTUDZMUUVEOHFyZWh2R3FqTStD?=
 =?utf-8?B?WDVCSzZ4SHU5K0hOWFowWnZob2tCNFRFYmxpdzEwckpNd3JyVlAvNTVESno4?=
 =?utf-8?B?YUtnZ2pXa082d0s4ckRULzNLRlVpek9ITmRQNDdUb0hrd01Ed2RpRzhBYzB4?=
 =?utf-8?B?S3FDUzdTazhxVW40QnFMRzRoRFBjRnVNTVBzUXBqeDd2YTVicmJxdEVmNjhn?=
 =?utf-8?B?S1UzV2JpUHZTZ3FiZDZBUnQ4clc5eWF5Ni90U2wzeW1icmZEa1pCdW1VaXdM?=
 =?utf-8?B?UDFlUWNBVVliSi96TlI4eTZJUlV6UFAyRzQ5eXVFQ0NoblNrTnRscncySENm?=
 =?utf-8?B?U2F4YU5tU2c4V2pVb3FMM3RKbWtwaTVzc0NKdkY2b1lkWXF3YWVPQ25FdURD?=
 =?utf-8?B?T0ovTG02V0NNK1lRcXg0aXZtOVFWbGRTcjg3aDJwTDdqc0poUUFZVnM2QjlC?=
 =?utf-8?B?T2JKZjIzSUJlZFpnZkpmVFRYQkYzTkt4aDg3aDJNdk42VHd3RzBKQVJVZWI0?=
 =?utf-8?B?S0VnTVRtWlVMQS9IMEtTeWUwNHRmSXVKempJWlYvSzhnK2V4V3FmNmc0M0dq?=
 =?utf-8?B?NjVHZldNcG1kb1NmWDZyQ3lCOE90aG9rMzg0L1ZDVElOcTB4b1AwVllHQnlW?=
 =?utf-8?B?YnJ0N1I2aHFhR0J1ZVUzYThIamZZb3BIOXFwRWhRblorQ2QwVnNIeG43b3pi?=
 =?utf-8?B?dDBCWDdEMVRyNnZmK0k2RHl5QU5udnpFY1JlUmZVQ2c1dFJ1SjJNbmpBQ005?=
 =?utf-8?B?cnZtUTVzMDh3V0xTWENTL2NldE5wTndTWlR4TnFIL1lUZ0VjUGI2cFlJNGth?=
 =?utf-8?B?d2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 83456e85-51c8-47a1-29e6-08dcdbc1cf4f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 11:21:03.4131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DJPL1j34SeL6RR0UzIIwYeaxWxiTj9LAcNd3j4SJdQ0qoMdYO0XTbfJyil0stCWmSCkKlTxUpZX1R1IlT3luHw0QWU/kJgEO6hYk8iKcnP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11084
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

Hi Chris,

On 9/19/24 4:00 PM, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Some of the Powkiddy devices switched to using a different vendor for
> the vdd_cpu regulator. Unfortunately the device does not have a new
> revision to denote this, so users have no way of knowing in advance.
> 
> Add code to detect if a device is present at addresses 0x1c or 0x40 on
> the i2c0 bus and update the devicetree if needed.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>   board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c | 147 +++++++++++++++++++++
>   1 file changed, 147 insertions(+)
> 
> diff --git a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> index 224019f9ba3..c1d1826fd14 100644
> --- a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> +++ b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> @@ -43,6 +43,7 @@ struct rg3xx_model {
>   	const char *board_name;
>   	const char *fdtfile;
>   	const bool detect_panel;
> +	const bool detect_regulator;
>   	const bool uart_con;
>   };
>   
> @@ -69,6 +70,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
>   		/* Device is identical to RG353P. */
>   		.fdtfile = DTB_DIR "rk3566-anbernic-rg353p.dtb",
>   		.detect_panel = 1,
> +		.detect_regulator = 0,
>   		.uart_con = 1,
>   	},
>   	[RG353P] = {
> @@ -77,6 +79,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
>   		.board_name = "Anbernic RG353P",
>   		.fdtfile = DTB_DIR "rk3566-anbernic-rg353p.dtb",
>   		.detect_panel = 1,
> +		.detect_regulator = 0,
>   		.uart_con = 1,
>   	},
>   	[RG353V] = {
> @@ -85,6 +88,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
>   		.board_name = "Anbernic RG353V",
>   		.fdtfile = DTB_DIR "rk3566-anbernic-rg353v.dtb",
>   		.detect_panel = 1,
> +		.detect_regulator = 0,
>   		.uart_con = 1,
>   	},
>   	[RG503] = {
> @@ -93,6 +97,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
>   		.board_name = "Anbernic RG503",
>   		.fdtfile = DTB_DIR "rk3566-anbernic-rg503.dtb",
>   		.detect_panel = 0,
> +		.detect_regulator = 0,
>   		.uart_con = 1,
>   	},
>   	[RGB30] = {
> @@ -101,6 +106,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
>   		.board_name = "Powkiddy RGB30",
>   		.fdtfile = DTB_DIR "rk3566-powkiddy-rgb30.dtb",
>   		.detect_panel = 0,
> +		.detect_regulator = 1,
>   		.uart_con = 0,
>   	},
>   	[RK2023] = {
> @@ -109,6 +115,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
>   		.board_name = "Powkiddy RK2023",
>   		.fdtfile = DTB_DIR "rk3566-powkiddy-rk2023.dtb",
>   		.detect_panel = 0,
> +		.detect_regulator = 1,
>   		.uart_con = 0,
>   	},
>   	[RGARCD] = {
> @@ -117,6 +124,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
>   		.board_name = "Anbernic RG ARC-D",
>   		.fdtfile = DTB_DIR "rk3566-anbernic-rg-arc-d.dtb",
>   		.detect_panel = 0,
> +		.detect_regulator = 0,
>   		.uart_con = 1,
>   	},
>   	[RGB10MAX3] = {
> @@ -125,6 +133,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
>   		.board_name = "Powkiddy RGB10MAX3",
>   		.fdtfile = DTB_DIR "rk3566-powkiddy-rgb10max3.dtb",
>   		.detect_panel = 0,
> +		.detect_regulator = 1,
>   		.uart_con = 0,
>   	},
>   	/* Devices with duplicate ADC value */
> @@ -134,6 +143,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
>   		.board_name = "Anbernic RG353PS",
>   		.fdtfile = DTB_DIR "rk3566-anbernic-rg353ps.dtb",
>   		.detect_panel = 1,
> +		.detect_regulator = 0,
>   		.uart_con = 1,
>   	},
>   	[RG353VS] = {
> @@ -142,6 +152,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
>   		.board_name = "Anbernic RG353VS",
>   		.fdtfile = DTB_DIR "rk3566-anbernic-rg353vs.dtb",
>   		.detect_panel = 1,
> +		.detect_regulator = 0,
>   		.uart_con = 1,
>   	},
>   	[RGARCS] = {
> @@ -150,6 +161,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
>   		.board_name = "Anbernic RG ARC-S",
>   		.fdtfile = DTB_DIR "rk3566-anbernic-rg-arc-s.dtb",
>   		.detect_panel = 0,
> +		.detect_regulator = 0,
>   		.uart_con = 1,
>   	},
>   };
> @@ -172,6 +184,22 @@ static const struct rg353_panel rg353_panel_details[] = {
>   	},
>   };
>   
> +struct powkiddy_regulators {
> +	const u8 addr;
> +	const char *regulator_compat;
> +};
> +
> +static const struct powkiddy_regulators regulator_details[] = {
> +	{
> +		.addr = 0x1c,
> +		.regulator_compat = "tcs,tcs4525",
> +	},
> +	{
> +		.addr = 0x40,
> +		.regulator_compat = "fcs,fan53555",
> +	},
> +};
> +
>   /*
>    * Start LED very early so user knows device is on. Set color
>    * to red.
> @@ -361,6 +389,44 @@ int rgxx3_detect_display(void)
>   	return 0;
>   }
>   
> +/*
> + * Some of the Powkiddy devices switched the CPU regulator, but users
> + * are not able to determine this by looking at their hardware.
> + * Attempt to auto-detect this situation and fixup the device-tree.
> + */
> +int rgxx3_detect_regulator(void)
> +{
> +	struct udevice *bus;
> +	struct udevice *chip;
> +	u8 val;
> +	int ret;
> +
> +	/* Get the correct i2c bus (i2c0). */
> +	ret = uclass_get_device_by_name(UCLASS_I2C,
> +					"i2c@fdd40000", &bus);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Check for all vdd_cpu regulators and read an arbitrary
> +	 * register to confirm it's present.
> +	 */
> +	for (int i = 0; i < ARRAY_SIZE(regulator_details); i++) {
> +		ret = i2c_get_chip(bus, regulator_details[i].addr,
> +				   1, &chip);
> +		if (ret)
> +			return ret;
> +
> +		ret = dm_i2c_read(chip, 0, &val, 1);
> +		if (!ret) {
> +			env_set("vdd_cpu", regulator_details[i].regulator_compat);
> +			break;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>   int rgxx3_read_board_id(void)
>   {
>   	u32 adc_info;
> @@ -485,6 +551,16 @@ int rk_board_late_init(void)
>   			printf("Failed to detect panel type\n");
>   	}
>   
> +	/*
> +	 * Skip vdd_cpu regulator detection if not needed. Warn but
> +	 * don't fail for errors in auto-detection of regulator.
> +	 */
> +	if (rg3xx_model_details[gd->board_type].detect_regulator) {
> +		ret = rgxx3_detect_regulator();
> +		if (ret)
> +			printf("Unable to detect vdd_cpu regulator\n");
> +	}
> +
>   end:
>   	/* Turn off red LED and turn on orange LED. */
>   	writel(GPIO_WRITEMASK(GPIO_C7 | GPIO_C6 | GPIO_C5) | GPIO_C6,
> @@ -547,6 +623,71 @@ int rgxx3_panel_fixup(void *blob)
>   	return 0;
>   }
>   
> +int rgxx3_regulator_fixup(void *blob)
> +{
> +	const struct powkiddy_regulators *vdd_cpu = NULL;
> +	int node, ret, i;
> +	char path[] = "/i2c@fdd40000/regulator@00";
> +	char name[] = "regulator@00";
> +	char *env;
> +
> +	env = env_get("vdd_cpu");
> +	if (!env) {
> +		printf("Can't get vdd_cpu env\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Find the device we have in our tree, which may or may not
> +	 * be present.
> +	 */
> +	for (i = 0; i < ARRAY_SIZE(regulator_details); i++) {
> +		sprintf(path, "/i2c@fdd40000/regulator@%02x",
> +			regulator_details[i].addr);
> +		node = fdt_path_offset(blob, path);
> +		if (node > 0)
> +			break;
> +
> +		printf("Unable to find vdd_cpu\n");
> +		return -ENODEV;
> +	}
> +
> +	node = fdt_path_offset(blob, path);
> +	if (!(node > 0)) {
> +		printf("Can't find the vdd_cpu node\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = fdt_node_check_compatible(blob, node, env);
> +	if (ret < 0)
> +		return -ENODEV;
> +
> +	/* vdd_cpu regulators match, return 0. */
> +	if (!ret)
> +		return 0;
> +
> +	/* Regulators don't match, search by first compatible value. */
> +	for (i = 0; i < ARRAY_SIZE(regulator_details); i++) {
> +		if (!strcmp(env, regulator_details[i].regulator_compat)) {
> +			vdd_cpu = &regulator_details[i];
> +			break;
> +		}
> +	}
> +
> +	if (!vdd_cpu) {
> +		printf("Unable to identify vdd_cpu by compat string\n");
> +		return -ENODEV;
> +	}
> +
> +	/* Set the compatible and reg with the auto-detected values */
> +	fdt_setprop_string(blob, node, "compatible", vdd_cpu->regulator_compat);
> +	fdt_setprop_u32(blob, node, "reg", vdd_cpu->addr);
> +	sprintf(name, "regulator@%02x", vdd_cpu->addr);
> +	fdt_set_name(blob, node, name);
> +

I'm not sure this is viable in the long run... This relies on the 
properties for the two devices to be identical. Are we sure it is 
absolutely the case?

An option could be to have a DTSO for the "new" regulator that removes 
the old regulator entirely and we would simply be applying that DTSO at 
runtime before the kernel starts. I assume you probably want this for 
SPL or U-Boot proper as well so applying the DTSO there would be 
required as well, not sure how to do this though.

Can you please tell the HW vendor to have some way of detecting some 
variants of the HW instead of letting us just guess stuff? How do they 
even support this in their downstream kernel/bootloader????
Have they already ran out of channels on SARADC?

Cheers,
Quentin
