Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B4FFC44536
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 17:50:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 45EF1408A5;
	Wed, 22 Jul 2026 17:50:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id heBnJr_zX3bG; Wed, 22 Jul 2026 17:50:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 697ED4087A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784742648;
	bh=1UKFEzBVJ+A75IZsS/Gqsvjci6eY5RZoECqiStLkiDs=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=DbHvSxXEqvuUGPEt9mel/lvlbgvh3qC1fLdVqe63Z4fFuVD5wHZb48GHW4I2qNEal
	 ND3S0EXUhdRuAoaMVLV5xPHCSPBXhafPh4obLcF29GRnQEmpJGwBnZBVfo6MQ58egS
	 RYRFEMEBQHTga1WKw+nc3/jhqNTV5mwnS3X/zSx/Vvj0MfsOZzmf4PtLE+zp20yF+p
	 aF8rPSp0ok5C637W30ewQFPPdMxHv9P6SwWvr46MmpqxMtk/5LJpugLGeVFbPQfWSB
	 Js3yz8kHmmZX+pY2/C4cbDUfhIqLK+/qAKFfozWOM+Ius7/VjJyAtx9bSwZSwkZnSb
	 XPLrXSXkVT6Qw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 697ED4087A;
	Wed, 22 Jul 2026 17:50:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1E003224
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 17:50:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 044D14087D
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 17:50:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w29sl5IR0MQI for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 17:50:46 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A5ACC40874
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A5ACC40874
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A5ACC40874
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 17:50:45 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A7B3846A4; Wed, 22 Jul 2026 19:50:42 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A52DF83E76
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 19:50:40 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6RtC1tn4SPnO1w/BcxuqCiz37uJLJQFmz3zrX/vzxv+mHLjNZWXAugL4jVSTa88upKsj1rUTwdhnpBtPFK+PjZGK5dnRPfgnv3b0mmawg/IeMH36R+F3/NkOPMmu0Fo6DPAr4J2vYLoNlHUkzIEFW7Y5P3Y+ubP6WSOCmCFY7NCj/BG84pB3c9drElZ3/K8mcd8WMDoeBmfhPjFwhavrXGF6UG2nv5GfCjn1PG1AGxFhJUs0/9iekxPxLEJLEmWOzlXjo82Bd8fGt+R/RLUSV0uVjMvtKlI7SidD0w7E8MAStA66wUD5Pe8ntI17+kEjWhLSd5qf4AxPnfgJMlbcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UKFEzBVJ+A75IZsS/Gqsvjci6eY5RZoECqiStLkiDs=;
 b=E6TEZC12GB/3OL5Dm1FF3xqMCjyAwlY/T5sO283wrNDiod2bfZfq+QQNvkVdlqPgz3cDuSEl0hsmZYmH9NQliiHr7/e3fnCJosltSoEtrSIobHarPJwo+gk+M0jCrdFvJLvCxhrQH/2PTPUEXH2hHWAK+22N1d2UUVX/n+dJQ0RU3yEeonaNs63/yDx8VsExMKU3Z4wxFK2uBBMKreNxdgxp5Qli4HR0Tb1gEmVfV82YSE1EZZc5iYTwUJ0Sq7nC4ONLRXfX8BGmQsb88e6Q0qBiCrj3pGvUUbuVgr9AKwT4Md0ymEBqVt0IunVNZkkicfiI5oF7C92tvZEUZVs2xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AS8PR04MB8021.eurprd04.prod.outlook.com (2603:10a6:20b:2a7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 17:50:38 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0223.017; Wed, 22 Jul 2026
 17:50:38 +0000
Message-ID: <6061bb21-733c-4024-9da5-e9ecd1db913d@cherry.de>
Date: Wed, 22 Jul 2026 19:50:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: led: reject unknown LED state instead of silently
 returning success
To: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
Cc: trini@konsulko.com, u-boot@lists.denx.de
References: <ifny32czr2jodibz3wyerwqfjzbepdkt3tfhvgw5qp6ymm736m@kmqqewswdxqq>
 <b6336f00-4c3f-4cde-9702-353bf9a0f7fd@cherry.de>
 <za2nl6cv6cpqajy25eb2y5nvin2o6rkxotiussamspnvsdze5f@aq6ebysavqth>
 <3939b025-f5e6-43df-8fde-79bc6b4eb721@cherry.de>
Content-Language: en-US
In-Reply-To: <3939b025-f5e6-43df-8fde-79bc6b4eb721@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIUP296CA0070.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:337::8) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AS8PR04MB8021:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ab54fb5-e2f0-4cc2-8d3c-08dee819bd86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|56012099006|10067099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: zEAisXkJhqvWUqKYrKO7lElLRc4M/A1/jhgqsvwjWcoAR1g663gAxm0x0mh/rY1QWFJKwgfqYYuSUXtcJANCPuNyZcUaaUQdEPEQhNKbsBE5pRyYjapOc+/TFcEA9+43ANDMff22yt9uqCXC6NCjym7IcS39Q5I4gn64sPCv5SfKdmFNCvVTHZbbxpwHcSwwh48t5AzdVSFF7Jsd/ET0AegRUPnCZuqn6RSE7GSf4tv9/NLI9cMDsRM7edwwxFf8lhTfAqSiPY+UP7yJ3mZkaMBGSvLnVd74yeNfSVZs+91kaQGOsh6u9mi8WJ+ExAOXeAcoR0SXhCp+01BLvKM7c9CKt8fpOaZFL9+zYqqA5KQdwBsaOpH+CSDPEqzrJugMoWFid6eNKR2GhXZPXa8Z+8XBlESV8QdiDdV00u3ysGxIg5BylJ3niiO7yu1DfvSJHyv7SHDPvhFzxsAtJVW4VVxJ4CJMINAt7KOpMbiz5PFjAVy9u/Q35Z8TtVpwzHGK/rsB/ffpK/1/CxDY5JB1NS4vtgaDuizBQprn9ZrSPphjBMbw9SkiRI6qCel6EZ89JBqd8imEKhM9/BK8NZhz/cZeSLOtHRmb8bGF4y2huo21awfGi3gKNzLtENPmQ4r8YCexEvvXVmJ9+4MlVfJo+FGIGS2slStIq/7WcgubEWA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(56012099006)(10067099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WSszVGFLcXJHcTdCVDA2eGEvNDJXMFJZZXNDMnV5NjN3aC9obmpoZko5ODVW?=
 =?utf-8?B?SXNNNkdHWjVqaklhTlZISXh3dytMOWxJM1NCU3ZIY2ljbEMrU1hGYXJZTTQ1?=
 =?utf-8?B?TFRpazQyQk1uRndmT29YVGc2T3IwTnFqMndCbk1vL1hnVXJwR3Rtam9IaS9V?=
 =?utf-8?B?L2NpSUJZSE10cXo5UG5JN21taGh3ekRZK0hvVkx3Z3VwNUZWWDNhWDRUQzFj?=
 =?utf-8?B?UGVmVEpMQmNsdW5yNkcxWXZ0MWRtY2Y4aTVQYWRMajFPbXNlcXkwOG5IYVBC?=
 =?utf-8?B?bE9oM0VtMDlZRktFNmR0NWVaRzdQbjgvbTgzMVQ3TDBMcWNTK3hNdEltRitw?=
 =?utf-8?B?NTlXdTI5dk9JR0U4c3E2RGVPNHBFbmNiNFZhZUpvZUZ2aFRmcnpDSTllMkNs?=
 =?utf-8?B?MGJIUER0Uk1hb2NNa2lSYkhHbTl2Z3Y5WmMwT3VyYWhyZWYyb2dkdW5EWmVT?=
 =?utf-8?B?NkdsVzd0ODZnRGppa1dKVEdwNEk4Mnd1TEVlQWpJMUtRdkJQVW1hR1gwMlZV?=
 =?utf-8?B?bGIyV001VG85RlY0VDE5RzJTbk1lNEJLQk1qRzJTK216SHVpMWtmMnozRHZw?=
 =?utf-8?B?MkFxWUFiRERJRkl2MzBqMUZUWVBTQ2ZhWHhaMVhoN3hpeDVwSXpoZU11WFVa?=
 =?utf-8?B?azE5bG0yTDAvOTFCaGVwWDgvMm43a2Vma2x4Z3hRR1krS1A3VUR4aE9zSUtl?=
 =?utf-8?B?cE90Uk9icDVEdGhxU0pFdmpSenpzZEhXQmUrbUpHS251Vms3STdTYzNUVWY0?=
 =?utf-8?B?M2RZb090c0JlcURLdkFSK2RFQThyVTl5QVNhcWN2c3E3Rk9oUDBtOXc1Q2h5?=
 =?utf-8?B?N25PekpRTjh3U1VXajhxckt6L1dPak5SOXRMNmpLYmhPSmVoSWZSd3REUHhW?=
 =?utf-8?B?ZDh4L09mcDR1bWp1blpHNVlxSU0wT3JLVmRBcVllYlRsRDVZRWlpODhNYzRt?=
 =?utf-8?B?MUFZVDFaOWxPZ2tGajFDaWl3am51Ym1wb2g2YnBZR1dibVZoeDNBMmhYeElH?=
 =?utf-8?B?MEhOUHVEaUUrLzdyajBFeUk5S0ZtMVFXT0J3bmtiZldWMG9YZmJnVkFxTDRU?=
 =?utf-8?B?Q283RzV1amExb0tEdmhWUkVtbjE3S1JSMjBxNXpKOHQrUUpvS2NxbVZ4aVV3?=
 =?utf-8?B?T3czdy9zaUpVVEhTdzJaNW5Kb2xrdjVNRURmLzRZdEFnZ3pDMTdtWHRHcTRu?=
 =?utf-8?B?ZDBOSWR2VU9YZHMrUm1GTm1SbUVKeDhtdnRUOUNIRXhHRUhBNmxVNUMrWUx2?=
 =?utf-8?B?T2ZMZU1MUFJMQkdQN1cvOGJvQWEzWFhocmdHd3ZnY2RURmF2M1dZUzA4eFc1?=
 =?utf-8?B?RTc3RjFGdk5CV2RwRFQrTFpVL1ZaS0M0L2JQc05DdVduQitoSk9sdlpWOW5m?=
 =?utf-8?B?Sy9WakNhMDhoUi82V3VmT1JLUGhzNmJ6NzBXSXVvSCtjRk1ucytyZS9Wczd5?=
 =?utf-8?B?ZkIvdmE0SzBVUE51L0Y2aWdEMmlkb2xzczBnOGV3b2xKeEEzSUpTaXk2am5M?=
 =?utf-8?B?YkJ3QWlzU05peXR4UDBZZlJreWxjRnJCeWVhczZjK0JNallXS1BsZWZqSmFk?=
 =?utf-8?B?VnljOEE0ZWx2Wi9YTUsvRWVEYnFDV3hZNlZpSE8xR3hHTXdZS1FRRlpLLzJC?=
 =?utf-8?B?bEpWRG0zb3FhQy9TeGJ5RlIvMGlmSUZ0cVVQZm9OL3FJSkZEL0xlMk9MMU1T?=
 =?utf-8?B?L2ZZZElYZnl6YnRnUjQ5Q244UGRGSzBrS0RvZHlDeGFuNWg4RTlpSU8yb3A3?=
 =?utf-8?B?NzVoMTc3VUtBREhLMTk1SHRMWSs1Sk9HQTF2TEY4VUh6SHJ5WFRwbi9TWjU3?=
 =?utf-8?B?aEVqeUVxU2dYVy9maXRNMzZRWS9hbWVUN0o0VGU2cXBYT3MyaDRxYWt4SlZE?=
 =?utf-8?B?M2xyQkZlTjlETzJqSkpFRStxdDlLaUEyeUVZbE84eTRYblFNQUxXVDU1dzQ1?=
 =?utf-8?B?ZC9YZ2UwbHB1Ty84TFQ4aU50ZDJUN0g2ZXBOVy9vOFdvK2RzUG1qRjZ5eUxM?=
 =?utf-8?B?K1hHeTJaNkViWmZ1N3A3RzQwVlR6MFpSL05ZM2xteVZKY2ZWQ252WlBsTVY2?=
 =?utf-8?B?dUJ0ZUpDL0VpNENaNnQyQklWdGdVbkNzdEtXSzFaWnVmZVhSOWZRckh5ZVQ3?=
 =?utf-8?B?QlpNSDg1UzJsdHVySUZOVDRTMWNPdU1OdnVpNXg1bWcvam0vVlY5Z2FrVzNM?=
 =?utf-8?B?dUpqc2lCeGZJYUJXV2FSdGl5cnMvSHhUVE9vUXVHekd2WUt3ZXZEK0UxOFQx?=
 =?utf-8?B?ZHZ5T1VaMGJXeHZFWlRhYkx6L0hNOXZTZGxsRkZTNzhiTU83aFp0ZU9ZZGJn?=
 =?utf-8?B?UlUrQlR3SWNTZ1IxSUx0a3NhZFpEallQbDIwNXVlOE1ha05CbnhPQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab54fb5-e2f0-4cc2-8d3c-08dee819bd86
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 17:50:38.6404 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o6B2jkd58xGIyu+YgPCnDXw1ofB3qBEXOAf7c9ITjZwRKNaDUC/tiWVO/ux3bo1NsPVu86uD/nBg8hTD2Y4IzoJEdzL2CQpTKSl5HDeopHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8021
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UKFEzBVJ+A75IZsS/Gqsvjci6eY5RZoECqiStLkiDs=;
 b=P/v2jnlpPh94iwnWTThU5Nv9sBMom5IOArU3eTvZWLCpL3urWgeXHANZNwEQSXMwk36J0HNlNKAdexII7+DH7CuQWuZ1M1A0/vs3eSKdNz2EAktPPhBYJUAno29Pg7uN3LH+5g9YEKz2+N1gzQAgPbREJqvl7ggGiLHAbrd7p+Y=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=P/v2jnlp
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=cherry.de header.i=@cherry.de header.b="P/v2jnlp"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <quentin.schulz@cherry.de>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Just to sum up.

>>> On 7/8/26 4:32 PM, Naveen Kumar Chaudhary wrote:
[...]
>>>> ---
>>>>    cmd/led.c | 6 +++++-
>>>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/cmd/led.c b/cmd/led.c
>>>> index 296c07b3b38..d547276e480 100644
>>>> --- a/cmd/led.c
>>>> +++ b/cmd/led.c
>>>> @@ -27,7 +27,7 @@ enum led_state_t get_led_cmd(char *var)
>>>>                return i;
>>>>        }
>>>> -    return -1;
>>>> +    return LEDST_COUNT;
>>>>    }
>>>>    static int show_led_state(struct udevice *dev)
>>>> @@ -84,6 +84,10 @@ int do_led(struct cmd_tbl *cmdtp, int flag, int 
>>>> argc, char *const argv[])
>>>>            return list_leds();
>>>>        cmd = argc > 2 ? get_led_cmd(argv[2]) : LEDST_COUNT;
>>>> +    if (argc > 2 && cmd == LEDST_COUNT) {
>>>> +        printf("Unknown LED state '%s'\n", argv[2]);

Don't print on an invalid command. It's pretty clear what we support. We 
print when we don't find an LED because that's not a hardcoded string 
unlike on, off, toggle or blink and the user may have forgotten to 
enable some driver (or added the LED to the device tree).

With that change made (+ the Fixes: trailer added to the commit log as 
requested in my first mail),

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Please send a v2 with that.

Thanks!
Quentin
