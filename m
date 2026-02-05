Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01036E91286
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 07:18:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C01C83015;
	Thu,  5 Feb 2026 08:18:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="t6jpZWy0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDA32839A8; Thu,  5 Feb 2026 08:18:39 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB4368063E
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 08:18:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/v9BhaBt+IDBg+JccIueL9T8c5cyKFCETyQrl8NgYpP/rTk+D4w7GjRV3h5LyezUCbC4kZqJU7W7SO70XLRfB+jQ5xKgN4TYM4iVAE9PxD4SsPhyB6QU+CMceB/S9MqHPrbNXrd/J8j55w9m9BTFd2MIrbrtxhsw0gqcOy3mMxQfb6upp5zz6NelL/qMPzwDyouSblF8MHCW6kmhAy3dBxWDGPXydf97xbc9aMXRZUuaTrkxtCyeIgloE5QlbrIjFl71XZ5RPJ+9l3kdOpHrBx8jnpPwUOepmvOiIhbcwQjaIFF0cvlAshBU4aNsa5Zg7s7L52WU0zjtXz+j3XAyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zecO22Cexo+2LULfzd0WRU9QG1vzDUAZh+vHgX82p6I=;
 b=eCjiDWnWicxadE1sJWZZZzClbJGj0MBLHFOGQCKsqF7HL5NKNVkUObqTZRhhtUHXzxYir0l6Fb5xaJpELuIc38HRVv4j/LNmtMdl86uNYkO3mPGo6b1sPxvaqvPVkw4zXKM/JE+/CtD4IxmQrH2Cx3zwWhzXSuGNbn+FsCaDEt4ItBGgOyCm1sJSL6Y9tEokVocQThHFqyxqEThKzWiG2dpaC1TYYwpr54fGagYKLYPxH2JE+sfrd9vJ8U96FcRTfqwwf3JHOYEvDCvUzYSXSYyxJn4L973yM+HxGBTaSgepkGYTxxDg27zlohmrh8i51vsf06xPnR+ht0WjRL1t3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zecO22Cexo+2LULfzd0WRU9QG1vzDUAZh+vHgX82p6I=;
 b=t6jpZWy0UJUKHWNjbBeWh6HXw6h53p4GaTB7VuKpC2TuE8NIfp1U8vYjgj7gKT4h+HquSialpJ6SKLaMTgSnCQi5+a/8PIDGdrjYAi4BoYCp110U6YWRJYxoSZCDTEAE1y2IJZOq2ieXQF5AbKNfie5sg6qYu8xqRwHe21vV8PBKGzRg9j29zwRUkLi9tfb7sQkj3uMP60zsWRjDZvJBAlB1m29w5CdCQ4u1K0nJnUjaWFq5BDm83YkHMdVrIg6mevKuuHlQrqZKSTXBINjHvo9TfFPkuXNJs+46fc+shfTQ039F08fT/n2TK9b0dtzFJoClre9gTPCwDrGqzylF4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by OSKPR04MB11414.eurprd04.prod.outlook.com (2603:10a6:e10:97::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 07:18:34 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 07:18:34 +0000
Date: Thu, 5 Feb 2026 15:20:10 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 07/14] toradex: common: Add missing headers
Message-ID: <aYREqj0kkanBInMi@shlinux89>
References: <20260203-cleanup-v1-0-4221c13e7558@nxp.com>
 <20260203-cleanup-v1-7-4221c13e7558@nxp.com>
 <20260204120855.GA30917@francesco-nb>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204120855.GA30917@francesco-nb>
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|OSKPR04MB11414:EE_
X-MS-Office365-Filtering-Correlation-Id: 034c24c9-3660-41f3-3140-08de6486c567
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vZJN2O3RMUZ5aBNjxe6Bz4YUJrpX7CviXGnv1/toD7U0BsWVcr5VRBUgA1Ye?=
 =?us-ascii?Q?wAwGby2MIdHYvgKVAUXXV8he5VzIrWL/oI1TJps+qAopjXdrJLJs2ciC788C?=
 =?us-ascii?Q?9ioxhn13TUI56sD2ApelClcGR73Q42Yv297FSsTlouBitVeoeKd3qVBprwo8?=
 =?us-ascii?Q?W14mjByarIcrVStTGfX4bRRb6WDITP7CMO7LZlAdxnytdugP1v5lVSuJxCxR?=
 =?us-ascii?Q?mZjIuyO40+RHn7F6HJuz0T/bXMWUplLwstPtf+52mYqpQmahW6GdxhCjJZAq?=
 =?us-ascii?Q?FQpKaD7b9wURNxtAyMdJ0uOAad8fvpWJmsAayoejPd9klPKUYehw9xOGLMsu?=
 =?us-ascii?Q?X8bYLJmxijVdUXQpK8a1BM2FbIUMG18dBRYJNrEcVTj24+JRlo2Rs127Mp6C?=
 =?us-ascii?Q?MKaw2lwmniUPty6h+mnq76F/aygiBUS4dv0MldK8Qx7teqro9Sriw/u+7VN6?=
 =?us-ascii?Q?quzpI0Mmewsg7iDuygqC2fNqUmJKGlZ0KEoWk1IHuA9vhbVxtrwHRWj+KK9U?=
 =?us-ascii?Q?8fnopOgFzWDuBWGiQXdzWL/QHbdDls5epyXV8iuw4W2EnZTIXOEDMqFT9n4t?=
 =?us-ascii?Q?bno+GWvY+Oj5VbA4VRAR+TBI7EGpsxaWU1c+qhCdj57TGNk3rJKSAN9wMxf6?=
 =?us-ascii?Q?cudGuw6QbKsrZ+4vdB29HazYfAewNvYjZFzCtzvhKh62RM/J1HELhp+cKHPN?=
 =?us-ascii?Q?CDfGZ2Velvzq9XzNor5UTL+nEIKudrZ5oCfyqORMV1tQULtP6cUwhdVdfqXS?=
 =?us-ascii?Q?OC/vq4M0kbwDpAaOZ6MRyPproDzyaZoCHt5a05z6bj4CACt8oZK78Vr5iyu/?=
 =?us-ascii?Q?Hou0EdiFCqnp0xVkbkadkwqhgVmYwkg9hi2fQarzZVb7+dc0Qj0jwXalOooY?=
 =?us-ascii?Q?MpSMAA6TRcF7wwy2p2ghDjiPpoG+MNxAJFb/TqUcOiyREuPwjylZJ0AcK7Pv?=
 =?us-ascii?Q?Yh97kHgBTs0UerWxA8sYdBPhRZU7nKpyOsCR4T/4VO2dfkHQ/scfsNV0e6xL?=
 =?us-ascii?Q?ODUblvcqTrDTLCxF7lysW1RKDy3j2aUrbb5S9nHSsxSBDtN7Ls+BZ8IV4CIj?=
 =?us-ascii?Q?hAHQK8Sn38TyQyL1Ufcel1WaaT9z9i7J+0Sv4C/ogx2TJX9h7BbKDy6wQaRz?=
 =?us-ascii?Q?O7s3xixIlGdkjgvmxavEnfre1o3fsURCYsPPNKhgH8GS3jpEmeCquCnGwOJS?=
 =?us-ascii?Q?LxE3djk4jaSFlxJQ6ljidXgrVF5/CbrxB9EsDNTuS2aMchj2pn92XVAbMEvo?=
 =?us-ascii?Q?l1kOqO/T0rqsPiSPlibrViYpowDzEpUGrJOuo35VTCndDsOmoXut49eGm+yA?=
 =?us-ascii?Q?DCsoFuCAyxi5vGM5V+SzoD9n8Bbn7k6BNvv3aM7ydxv/n072WLtmF2UBc+cq?=
 =?us-ascii?Q?QoB7D95ClKShjumMhQNX09RVID+sEqHOtyQxU3NDeJH1PRqLGzBV9FIG85S2?=
 =?us-ascii?Q?YGCqyLOUvQzD9vHUdi40kKiGoC9Y5QeCRQMolfNRBQtJlSwfhkHEsqz1iHoJ?=
 =?us-ascii?Q?w4j8kKLoZXySkerR34J8xXUOuKVyFx91Ssvhn2stSrcHAmovaaKnCpP+PBnY?=
 =?us-ascii?Q?PcnHcDnHyrRN6tzAkJ1xPZ1JTMa2vb2fBJfzrgpXLaNhwvDYTL/TYud1wKcH?=
 =?us-ascii?Q?0/CZ+mS9FSWntcpD7ULEAjY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uF6yOp0n/wniiI1Q2iPxLCsVPyAORO3YG5qV52jY9q/mbWE2Qk2JBCoTH+Hq?=
 =?us-ascii?Q?ZeToaIku9KrCwvtzOzn9U6XSme85ZianLg1lJGsnH59p3xsoTH5/vE9xv396?=
 =?us-ascii?Q?3JBcucOGAOkXPgwojSylkL8eGic8FzUVnQtQyBBArSQ/c8nhR0gZXY7vXR7I?=
 =?us-ascii?Q?LXqD8xDmFKVIUAvR8juC/SAKs1YLRdq6/aXuT37MRhDpxmzdY/g9kmS8wN3I?=
 =?us-ascii?Q?PIotn+WCIReQpcHG8sH/AE2h7fee8kIbGOHMz7nRQfNdiV8BcUSpDgb0M0Cq?=
 =?us-ascii?Q?2EngnFHb8GM/d2ZasnpINjwbsFXb/5scxjFarp7y3zDkpQCbO76tV7pvy47C?=
 =?us-ascii?Q?nBfSCbPqSMkNsF8sCp0h5zUoYW/LE4szNrscnSOYA63vSapi/SREr7ZOrHSI?=
 =?us-ascii?Q?X6/wtFogLSGCgXZhC78LChCQRXvUyTrNozvsJtOOBFmIUo5rqbbH6ffbBP8N?=
 =?us-ascii?Q?ayewZz+gaDjUj6TTVJE/KJnjx5SBl6M8ggwoFogins3a2ew4tki/udZNGzoh?=
 =?us-ascii?Q?f8JXAinEwUOuWycKDXeTsVyCKpDgd41gGZI3V3M3VdEmywQQgjG6KxrY8eHa?=
 =?us-ascii?Q?2T5G863EmCcE3ZK3Hc1RCJSevFzqgmtwr7M6NvgXaWh20jTEjuFuArpbR+8+?=
 =?us-ascii?Q?pbnhlHwq20mULgviFei14prpRj4MXin1buYtBQ5o/uSOtpYGplvLiUKmMPCt?=
 =?us-ascii?Q?JqfjXdyiJRlEFmi/gt4ALDnHA2tV70iMUkfsjwoCM6JekKGMgh5+altSTWJk?=
 =?us-ascii?Q?id/cs48VyJQb6Onb2DqiSGM1swDSVPK1ScoHN/6qz5Lc6xIsnXDbe+VQUaMp?=
 =?us-ascii?Q?MhIaT42y0/bgu9GLu+kC26qaL9QD9eqNech2iqbqHr8tb6Z3halhHbZHVWnL?=
 =?us-ascii?Q?v4SdOts3o3vMOMBxrtrEFj1U3bCTUMtQ/fUzqZSznB7+v7bAkKDjHwvw7tzn?=
 =?us-ascii?Q?YZjwpxQC9kPbzN0nKQkifhVUnkzkaimcEIzuTFH6+rr1lDmcyYlUC67oX2Wy?=
 =?us-ascii?Q?CzAuqwZx3LSRmesgSr+8Unn9M3a+SlUibZND7FbJTj8WoeArRcMKaC95pdUI?=
 =?us-ascii?Q?LXlU/cWA6RUJLOaDcEHhBE8Pv0SCCo8dfOr665wxGywnx6QRzUJW7o2ULZmr?=
 =?us-ascii?Q?1+wgR+n+saS3a1BXK3C0bbnuu4pCnuTa0tuTLaDivBR8HRe+IHOmSEJGMc5M?=
 =?us-ascii?Q?DcVM6XiaVJa1XAJC7PuWCQhy9U5DCt8RN+HvkwKMIcS7Hesj+D/OVWAQl4sn?=
 =?us-ascii?Q?UwhOkQE5COaMNBtDdru1xSlHgcuTQ7jeP0ZOTM542Y+yYIDRjGjhhzI9v5MT?=
 =?us-ascii?Q?Vpme1SNSe4T0rweI4Q+EINILczDjeRbLv2XmXW0P9h/H8uOHzGOop7jNUXhM?=
 =?us-ascii?Q?a8vAXVcgdPykh7g8jOvNUowwvSX9GbGlp3bREzqh4O43w4gEr7S5QqL5Jaah?=
 =?us-ascii?Q?c0yim6ODipgSRl3C30zgbfOalK00OXIN1t6f5n3IOehyE1/BKaejhi/HjfLl?=
 =?us-ascii?Q?D1PNRF04Ol4BvxXPHe9JIEl2MUu8SPHC/36sAq/7KFN0Fd/FvhDTncYSl6Lk?=
 =?us-ascii?Q?1QbqCZroraNpdm+kXkAu4RjNPN5OFZeBsT9Fd5nTUe3A+Vn8u07mhrwPE2iZ?=
 =?us-ascii?Q?3vUjNkhB9KEcWOB3wMv6fOx/82yXgUGy3Mijlro3sC95tkOrQzr+AUCYyY+g?=
 =?us-ascii?Q?v9ekA1O5H4LYgPH0AMzA8/65nJoXemsodwmbUyGDRrH1wTuTNQBryTzcSr/j?=
 =?us-ascii?Q?O3+waBwXhQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 034c24c9-3660-41f3-3140-08de6486c567
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 07:18:34.1866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ROQme4tZHwJ2vZ0DdH6etCIjDTCqnRmSbkKOTpaT6d7S0jM/fYe6EEViH56M7JEiRoziGUDsHYDyI2XiHFXdKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11414
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

On Wed, Feb 04, 2026 at 01:08:55PM +0100, Francesco Dolcini wrote:
>On Tue, Feb 03, 2026 at 06:41:38PM +0800, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>> 
>> Include linux/types.h and asm-generic/u-boot.h. Missing the two header
>> files will cause building error after cleaning up usage of
>> asm/global_data.h.
>> 
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>  board/toradex/common/tdx-cfg-block.h | 2 ++
>>  board/toradex/common/tdx-common.h    | 2 ++
>>  2 files changed, 4 insertions(+)
>> 
>> diff --git a/board/toradex/common/tdx-cfg-block.h b/board/toradex/common/tdx-cfg-block.h
>> index b28033d8332e09d063a6a8ad1d4e334703077f00..067daec0d776070b0b53fc26d1043d6eb781a527 100644
>> --- a/board/toradex/common/tdx-cfg-block.h
>> +++ b/board/toradex/common/tdx-cfg-block.h
>> @@ -6,6 +6,8 @@
>>  #ifndef _TDX_CFG_BLOCK_H
>>  #define _TDX_CFG_BLOCK_H
>>  
>> +#include <linux/types.h>
>> +
>>  #include "tdx-common.h"
>>  
>>  struct toradex_hw {
>> diff --git a/board/toradex/common/tdx-common.h b/board/toradex/common/tdx-common.h
>> index d446e9f1d5ca7d3d5a1318b389393d28854e2263..db3369a8f9ef9b409c53c45e94aa5f22933a44fa 100644
>> --- a/board/toradex/common/tdx-common.h
>> +++ b/board/toradex/common/tdx-common.h
>> @@ -6,6 +6,8 @@
>>  #ifndef _TDX_COMMON_H
>>  #define _TDX_COMMON_H
>>  
>> +#include <asm-generic/u-boot.h>
>> +
>
>maybe just have the forward declaration?
>
>  struct bd_info;
>
>and that's it?

I would not add a common declaration here.

Thanks,
Peng

>
