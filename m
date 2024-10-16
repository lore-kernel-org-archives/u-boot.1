Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 226DDD1AD43
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 11:25:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0648D88995;
	Wed, 16 Oct 2024 13:25:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="dvCz2l0l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA58A889C3; Wed, 16 Oct 2024 13:25:33 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 908E488717
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 13:25:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4BK9wLGP12m+6X0ywCQKjrBC4ebKqdROwb1aD2AV4ijoHDqkOWZ2u2yExQpScILKYSK4gRftm0mO3lHFZYXpzkB+222MP2f0/8hePnOtdUn9axHbYlwZv/ZaxXx/7dCNgOMFovYQZ2xf93/43qMzmzk6FBOPs3odjlfIkSpXJe3BmsLx997eAVh0wsAjqAkGVzIaW7aGnHhkpz2laht/K//0Fx5OAX4PJEzg+fjULcobZF6kYmve4qWZ03M0Ch49HjUTpf2s0tmWqJxNNW4S0BwfQiSBxP6gS7uX9ixBjRemiuTncPVi1w23f4yHayuHrr+yNbTglZ268XRFYTlBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CsfRFVqndXYiADkcD9X703xSD8MwqM/m7kFp0Y2M/tA=;
 b=rs1oqbEJGcBRU259fAGzeHLZhr4fx4V4RrLT11SHT4Eop8ArF7XHv+SsGb1zwC2vZBM3hqxE4asmQV5Qv6XT9d/+Bx37CWTN+SPjmDwg0m7ohOpRnD95b51pmu+HPXkmsqmyF8//J2Oii1KJIcWThl0yg+jS0miw2t41GEpbCXPDp6BnaIs1q0Eaq6eZKua9+7rwp3n+fGiUisrqhJ5ow8DTl/EBbeuk3ttK5NT2CYyu9RmkgzD7i0iThTwwrpea9yo5p0F1mDPeHTQYOrTYq0t16/x07SNuzdohQKact38G4SCgHk1oDU9zJOPsLdiBHaPjzJiahzm6Hn6/ea2Mfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsfRFVqndXYiADkcD9X703xSD8MwqM/m7kFp0Y2M/tA=;
 b=dvCz2l0lFjTDUB76x/V+vMLk9CbQVqYMoGzFVKty/C37eV32Av7/NTsgfYLe7Txog6NdtW8TlcszAq0aqmg/Vy5nlTQ2UeVk6uWCHeoq8+6nvCHnaYCB7Pag3SsC6CBEGuVFCuO2VyBWHadiEry2CLoQEHb5DZ26JQT622AS+0o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI0PR04MB10639.eurprd04.prod.outlook.com (2603:10a6:800:261::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 11:25:28 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 11:25:28 +0000
Message-ID: <ba0dfee4-9c9f-4f7b-8139-5ce1741384da@cherry.de>
Date: Wed, 16 Oct 2024 13:25:27 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: U-Boot Mailing List <u-boot@lists.denx.de>
From: Quentin Schulz <quentin.schulz@cherry.de>
Subject: device_bind() with ofnode_null() tripping assert()?
Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0210.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::14) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI0PR04MB10639:EE_
X-MS-Office365-Filtering-Correlation-Id: 29a592ab-388f-41eb-479a-08dcedd53ca8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|10070799003|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q0t3b3NsSkZWZjhwUnRJeW1ySFlyNmNCbXdLV3I3VmtCa2NKaFdDY21WNSt0?=
 =?utf-8?B?WHlHRFdlNHJoNldWT1ZNVDBPWEQ0QnRNY1pLV3BOWW0xZlprbVkyVVF4bTRX?=
 =?utf-8?B?TklqR3FxV2NwU0hCT3JXd0FhTDF5ajJsZkt4M2hXeE9VdWxvYWFWTk1zVE1j?=
 =?utf-8?B?dEorc3dMN1ZqSUMvLzBPQkFrZUlUT2tEUEhONUhQUmdnakVuVnNsOHJiQVpl?=
 =?utf-8?B?RUUvclBwZFcxbmU3bHcvczFFU215M3FkUElqKzZYYWkwbWVUTi9aR2JCMkd3?=
 =?utf-8?B?ZFh0bERUL3Y2OW81M2hvQ1JNaDRRMllmUWYwbXRkTGcrQzVkMTdSV2I0TVFq?=
 =?utf-8?B?dTA1Z2czNWFuaXRpbEFyNnZIc2N0THoyZ0V0bmJvWU5neHY2T0NmeXFHSlBw?=
 =?utf-8?B?NzZOdGVSSTF4VE5sUFoyNWRXSlZ1Mi9YUkdtUERKSHpIQi9PRTZueWU3ZWsw?=
 =?utf-8?B?bVNxTTVnbjNKbVNHZFhBWjZWZGFjVkJMc29QYjIzMUY1cGFFMHRQVXlJWXhK?=
 =?utf-8?B?aTJoNjFYVnhUVmV5bDIwemx4RzVNRUVuQnMrRC9vRHE5VTZMVDJ0eWlpZWxa?=
 =?utf-8?B?ZmdTWTZJWGpicTBsQUF0WGE5bnRla0dETkdWVlp4WUR0bVY4T1QzaEw3Tm16?=
 =?utf-8?B?eVcwWUhhcFVSOXJqZDgvN1EySjQva1EwMGEyYU1PSVRpMGhudmcxTmxwOXoz?=
 =?utf-8?B?SThZRmRTNGtDWFNtNitOK01IQU8zRHh6UVYza0lsbHoxQVhMQjRkSTEzT0hY?=
 =?utf-8?B?NlBEVTZSMUo4aEpsU1ZWOUxVb1RPV3hvSkZMdEdLQWdmLzgrZWdqR2FIaWx0?=
 =?utf-8?B?NlJ0ZHhpSUJ3Y01tb0J6cGcrYzVoTlJsZ3ZHeFVCQWR2cklsditzb3BKVmho?=
 =?utf-8?B?T2g1dXUrOWlSOUFCM0tYanBmRlN0SmVPRnVyY2w1S1RaU09XT3lrVTIxNTJm?=
 =?utf-8?B?OFFzZk1ndnRpOVZtVUJSa25CTFVhelp1dXZObEpvclA2TThZSEx0cGJFdGhY?=
 =?utf-8?B?WG5zSTJsVlpBblgvanIrek5JWWZTdGxQMjVuY0o3eXlPaHE1a0wzQ2p0Zkwy?=
 =?utf-8?B?TnVGNFc1VExJakhpMm9ZOEt2VDNya3JIdGVqUndOUk11V3NLTG1VWGhBZ0RU?=
 =?utf-8?B?MGhXVEdxMVFObm5TK0xncmU3Q1k5cTY2cWE1UVhEVTU0L2psQzJEUjBLendD?=
 =?utf-8?B?TFpZTEg4L2pVOUMxRWVvcnFwMzhRNEJMN2lOaERwdDZqSFc3ZmhjcURNd2Jo?=
 =?utf-8?B?akZkU3lNdkVlaHVOZjkyRVBESW9TeElKbjlXTWF2b1EwSVcxZ2cxdmJnMEFP?=
 =?utf-8?B?aVc2cTE4cUFNT01QL3Mvb0sxUXFocGlBOWsyY0lqUThQRi8rWEpXOVJjV1lC?=
 =?utf-8?B?Zmk2UzByczJBckF5OWZDaUNLVFdUZFk0YWJtK3VxdGhVMVFPM2ErWlJjc3BU?=
 =?utf-8?B?QldWTDNPQkRnQ244ak00dUxvejNDMU9ndnBmaFBET09KMUxTKzk4UFBOd2Vm?=
 =?utf-8?B?Qll0RCtUYWJwbG1VSS9wYnR0NXcrcVVSbUloaXJiYkh6NGxIeTZJb2c0OUNJ?=
 =?utf-8?B?cm1NY2ZDR2Mwbm1xMmtlZ045eDk3QURjQ0FpVytINjJ5M0twZ0ZxbXJrMXA2?=
 =?utf-8?Q?08g6wnIBAomnqUGYZTNvI8QuPVVMdVJ82ThWo5HrNM3E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVY3eDFQcmRjbWtrWUlxc0U4a0tUYVpKblAvajZ1aWRzdHZ0T2RXYStwaEk2?=
 =?utf-8?B?NGV0L3h2cVVEUkxOcEVyWTBmMWdXZHpvSHorVC85eTRnUDZwcU5PL0tVSUhn?=
 =?utf-8?B?QTh3YzZ6Mk5rVmlDUG16U0VnQi90bTd0dW9aMVE3SWNqcllGRUd1V3FiazIy?=
 =?utf-8?B?cTVIeUkyYlRGMlpOUzJWVkhqRmFIQTZZL2sxYXpzejZYS2tqT2pLRXpJano5?=
 =?utf-8?B?ZEh5L2tTUy9TT3oxUE1aTWFrdExJYnhpY3Nrc3RGZ1BIZjgzaXhkWTRmTnZG?=
 =?utf-8?B?dTV0ajRpTGg0eE5jTjdBN0J3K28wV1poQmNLaWxMd0ZUaGtNZlNjRDFVZzY2?=
 =?utf-8?B?QlpXYWpOQnF1SENmdXd3UzVYQnJCNzlHSyswWk53bURrc0FjSER5cjczMEVi?=
 =?utf-8?B?R1d5NEVwd2lpdUpOU01rcnIwczl3bE0xOFRDeFRVdVFSekRUNjl5ZVhpQWN3?=
 =?utf-8?B?VFloN1Q4R2ZWNFFGRy9uKzV0dytzWFR3SFB2TDlXcWFqYVhtZXpPcmdoNWU3?=
 =?utf-8?B?aWRNVG82K3FtMUxtNmdQOXFXY0VNWU5TKzJ2U3VSTTYvd1VRLzMweTlLcmJV?=
 =?utf-8?B?Q2FWQmE4NXNjQW1QRmRzampHcnNKUXowNVNFU3E5SHhCMHhnd2JhckNqK3pj?=
 =?utf-8?B?MDc4Y3dxUUI1SGlZVXJzTkJIVTg2dUVhdjd5azJpWDBTMlBNRkxRVXNNMzBh?=
 =?utf-8?B?Uk1PQkZreExMNWJxRHNsQ1IwYUhkeEZFaVZTcTE5eC9DcFVNYlUxK3BmV3M4?=
 =?utf-8?B?dVltcmsrbHFiRktzWTNGT0l2TVFyNDFZaTJaZ1h3OGFlTFFWSGJJTkdjNzg0?=
 =?utf-8?B?cUYxR3gwdDlNd2pFNk84Y3RNWFNFOHVobFBrQXJWWUNhOEk1N0RGU2dDSGxn?=
 =?utf-8?B?NTJFYm56NzNiRDhxZUVWTEtVbkpzRVJEeVFiNVR2Ri82S0YzMklSUHhpZUxr?=
 =?utf-8?B?RFhPUkdPMU5SZFY2SHdRNXh6NUV1eGIzSmkvY0QwdzV2MHVRbWZYdzJxNk83?=
 =?utf-8?B?bnNEQU9kU053RndZb0tPVVdVQ1RkeW1XcjU0Sit0cE5sQ1FBZmk0L1lndlk3?=
 =?utf-8?B?ZmcrUUx3aHBKRHZ5SWlYbExueVRpU05HTkpEVlNJYkNGU2dyc0ZvaWF5WEh6?=
 =?utf-8?B?eUdGV2RKSllwUkVwMnBaWkZDQ2ZpMWJ3ckphNysvSy9HU3J4ckgxUmhFNE91?=
 =?utf-8?B?NmNuMHhScVBpZmJGeThiZFgyWWo2emZNN2hvaVBuZmNzdEhoOFk5dVkxdENK?=
 =?utf-8?B?dElXUk5Ia1kwRC9lRnFtSU9hRVR2VkJvdFBNTU5oQ3dtMElNaXNianRUVkpY?=
 =?utf-8?B?bVVHM0RYWEhUSFVidlF0TkJpeGlkNExvUVQxS0dJSlEvSEZWY3NEYUVlc1px?=
 =?utf-8?B?WSszcEREZnJXYmdPQU15UEFRVTc2Y2ZnWlorZlpaOElGVnVCREE1TysrYTFa?=
 =?utf-8?B?YjR2TXJ1bW9KL2ZTRXR1T2J0STBVTXZyVUZiaEpFT0JiM2pzVmFPQzVyYnBm?=
 =?utf-8?B?b01IakZCWExYVmRJZGVsMS8wSHVIUUFjRHFQbHp1ZlhiTDJPMUdVV2xlcTA2?=
 =?utf-8?B?MzdnQXgzYWVHakxXaXVMV2hiTXVuWHNwK2lsOEhGeWx2SzE1ZzJhazdiNkta?=
 =?utf-8?B?TUo0bC9RcHlCTVlSa3FtV0ZQMVpGVG5TbmRnV0xiQk1UK200Rnlpd0tLa3hJ?=
 =?utf-8?B?cU0rWEJMeENlU2F3U2lQTmVqMDVkcyt6WHJCZmtVSmg3eEdtRkZZa2s0T0NV?=
 =?utf-8?B?SEpJZU43NUNaQkZNWnJxSEpPVnQ4WVdzVUNyQ0hmSjJvTzdZZlFXOHQrZ1pY?=
 =?utf-8?B?djJnUVF4dUhmS1NhZGZxdzljSEsrWWgrakVXSU5rNzVpR1RIc1NJTU1OL2Rv?=
 =?utf-8?B?NW14Z0ZiSkZJTE5JSm1KNFR2ZlpjNy85NGFZUjVyVk9uaFJrMSsvQnhlTEtn?=
 =?utf-8?B?SlhoM2dKQ3cyWlRFVHQzWktybkpldVlvNDVML1g5aXpiRlZjWVNnV2NPL2pG?=
 =?utf-8?B?NDAzWFRuenhyZzR4bGZsN1VZbHptOU4rRWZaUG5NUDUyMkV5UWpOL3FIZkpP?=
 =?utf-8?B?WC9IVmpINW5McXd4SnREdlRXSFpHY0pZc00vQXFHeXRvMHpMQWY5TW96OE1H?=
 =?utf-8?B?ekgvdFZXcHpuTmtRTFpLOURPV09kNmR4TE04TjNLWXB5djlJd1R6ZUFLZjIv?=
 =?utf-8?Q?uAg022zB/qeJw68Se2Y/QqU=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a592ab-388f-41eb-479a-08dcedd53ca8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 11:25:28.3458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7hvZJ520VnrgSMoknaKKSZjLevONL4e9PmQPiCsjBTCEfL8nCxCM21X2SvX6Uw7BHBmMs+LSLth1ipUAGHpSHRQGJ+NGorO7R5onoKedGms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10639
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

Hi all,

Not sure how to word this better so here goes nothing.

I recently wanted to debug some issues possibly related to DM which had 
a bunch of debug() log messages I wanted to see. To see those, one needs 
to define DEBUG. Once that's done, assert() calls are now built in.

It turns out that this means I cannot boot my board anymore because (at 
least) one of the assert() fails (specifically an ofnode_valid()).

I've for now narrowed the one in SPL to dev_read_u32(protocol, 
"arm,smc-id", &func_id) in smccc_agent.c, c.f. 
https://elixir.bootlin.com/u-boot/v2024.10/source/drivers/firmware/scmi/smccc_agent.c#L91
If I change ofnode_null() with ofnode_root() in the device_bind() 
creating the scmi-base.0 device from the SCMI UCLASS, then it goes 
further, c.f. 
https://elixir.bootlin.com/u-boot/v2024.10/source/drivers/firmware/scmi/scmi_agent-uclass.c#L377.

However, I then get another assert() being tripped later in U-Boot 
proper (right after the Ethernet has been initialized and before I get 
to the shell, no idea if it actually is related to Ethernet), which 
makes it reset again.

So... I basically have no clue how to go forward with this. We've 
started to discuss to decouple debug() log messages from assert() 
(meaning they don't share the same knob) but that wouldn't fix the 
issue. Should this assert() really be tripping? If not, how should we 
handle that instead?

Cheers,
Quentin
