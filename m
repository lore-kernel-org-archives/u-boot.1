Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C218CDD56B
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 02:59:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1545388FF6;
	Thu, 19 Sep 2024 04:58:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rp8ETpD6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17A8788FD2; Thu, 19 Sep 2024 04:58:33 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::62d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3224089045
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 04:58:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RlqpEv4chadUGgW5sEHA/jvSWfV5J8PggWjVW5iHYDCQ2eQ/v3f+YTtVPUyQLVHjieqw/bnqkk4VHyCXtOUreEEtOIK5FgEhMx1A/SqmBlAC9J786fRMaSaBlkiiPy1gVa0BXz0cfTL0u4kwSmM5DDEbgNEyrpgSc4V4C4hfSm6hQzxgpWiYlQTG3rAQVwIfQm+7MVFQdbFno/ntzJWoUkVXR+wgJL1mldSsFyc0ZKpuCds/qhYts+aX8dhZz9sQfEI4JSqoqlRRR8cZdsbmALJDURdSq2Je3bpfTXUvS9hWXSywaIsLqm9TXe1domOmVUGC4Z1LY3lMYU52PfD+Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hfx8J5sJpXTNQkxrdqcStMh/25NyxrrWQ+T0xb1XGMg=;
 b=pNycfIjVpWeGDDDOCcinnbp8rsvNYL+/nUrBi7DvwDq4kKjeNX/sVQflq08QxyWqn2gaCR1Fj+rctVGl5BE+jsLuOr0o3RtVkGtqh6241mRNGcOMdBjPoWirJQIsx5j1jBE1Nc6o5VZmAQX4z0xaY+wBB8OfHnRrCQfWjKDDw7MnRcMgP6OEVGgsziw2g1B85nwvxF//e0j0FwfEeKzU7VdwtK3oH1oZwbYLBSGQOe4mkuQjT6YudhMPANrPgGfMTO8XPFpxZq5beJ5mfA9FaXS9dgB+1Ll0UZQt4qPWfnCcaLpdsCQO9U8X6U1MsyWzr30r6tgzRHX4zDCEh5cdFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hfx8J5sJpXTNQkxrdqcStMh/25NyxrrWQ+T0xb1XGMg=;
 b=rp8ETpD6RStWVb0sFTNkebu3LpSZJtTTZAk4msSE5U3sHbAb3NCA8uXRTzFnQwCGP36tZ0tfM3ld5VbigLXGZ8MZ21bD2A25DsQgFl1XIgRjYRYbSqAdkpYeThVya9aPCUBhnriNfrz5x8qweJ1liQKf7H00mIiRFIXHenN5D62+eBq/yS6DP2TDzzfB0qA2OzTihL1/am/I+n0zZrQab68Ns+gwWX4L0orQUOvTKF6VIGUXECvOq0NumobtomyJkNWQc2K9NOimrnUeZ77Pzx3b27bDAQiSgoY3vbtfjZbuSg9FjlF6pX4QVxkTsFY3l31+wE8Jnh8NQKeAIMzyJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9986.eurprd04.prod.outlook.com (2603:10a6:102:380::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 02:58:27 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 02:58:27 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 19 Sep 2024 12:01:27 +0800
Subject: [PATCH v3 09/21] imx9: clock: Update clock init function and sequence
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-imx9-update-v3-9-80f9786cd1f0@nxp.com>
References: <20240919-imx9-update-v3-0-80f9786cd1f0@nxp.com>
In-Reply-To: <20240919-imx9-update-v3-0-80f9786cd1f0@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9986:EE_
X-MS-Office365-Filtering-Correlation-Id: bc721f39-8d41-4350-0226-08dcd856ef5f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bEdOTUxvN09JM2p4UVNZUkNxMUc1WkkydjNWbHZMVCtDVVNzb3A3bk1IdXo1?=
 =?utf-8?B?QndUcGo2OXJNaUpCRmVQQlBjUWNWMHRsVzI4SnpJRVJ4ZWpGdWVqZGhFRXYv?=
 =?utf-8?B?MWErWFkvcTI4TC9PK3IzbFY3eGtPZHJLS2NIcmJTODJ4bnl2RXJMa1BBT1ND?=
 =?utf-8?B?M0ZBMFJvaEFYUHVNNWloRTNZV2dIRGR1dDJNZjRQMUhwRUZ6UUpaM3I3aGVF?=
 =?utf-8?B?WGJEZlRaWkg3WGdsbzF4bGNhbmZySkFjaUwxbnZITko4dCt2alhWRGJXOTFU?=
 =?utf-8?B?S2hTWkYzcmlqNm5zOUpCMTRnVUVpSExlT2ZsWnVDS0s1Y2V3WjZReG5VKzN4?=
 =?utf-8?B?d2drYzZPb0crcGlyS3psdm1VbXpMUUpMUmhuY3lTOVFEeGY1QzZzSXJKbUFS?=
 =?utf-8?B?d1l3RFFyZ3YxWXNqcC9OejN2NGJ1RTMvQmhBdnV2emhEcENxK1VSVThmR0g0?=
 =?utf-8?B?T1cyT2hHVHpxdDUrelYxaWtEQlRtMkppMTExSklSdVl3Q3phN2R0Mktsemwy?=
 =?utf-8?B?KzJEZERlVE02SC9RNUVnWG42VlJUS0Q2WUZwUno5L2N0ckxiV3R0T0tnQnBB?=
 =?utf-8?B?ZnJrZlRMMUloLzYrUFViZ2t3MWhUR0RqTWY2K2ZrWGNEc1FndXpNTDQxWnA5?=
 =?utf-8?B?aS9IdHpzNnVreUUvMVlUQ2RQbGs1TFRPcHU0NWFoSGdDYld4WmpwWk4xTGVr?=
 =?utf-8?B?aVZUZFhOb1gxaVRVL20zd2o3M3RPenV5TGhTS1hJVmNLK0lTRm9mdE8rT1gw?=
 =?utf-8?B?SElZbkw5SWlBdFlzZXhibmVNMklvbmIxU0ZGZUZpSm9lcjU2TXRuUHNnczRs?=
 =?utf-8?B?SHJEL0ZWTWE5TjRDTUQ1d0VyMDMzVWVPaVRvRVBjaTVwQ3NCaTFqdjZpVEp2?=
 =?utf-8?B?NS9yT3UzbCtEZUR1blZCYmQ5OWg0bTJTZTRZblN0a1Z6bi9MZ2tqcjhyWkw3?=
 =?utf-8?B?a0R1SXlYU0dLRUYzbWppdlM1OERaR3Z6Szk3ZGRnNGRTczN1bUJRYUJkQ09K?=
 =?utf-8?B?dTVlNUNUdzZZREVEbUJaOC9Id1FiMnVIN09CN1pya0RrTnFHb2NWVXdEL0pG?=
 =?utf-8?B?N25Bc3FOUWRJcmsraDhQMzRPTk82MjJzU1oydk9YeGlPeEx5T0RiaFpZZGsx?=
 =?utf-8?B?cTNMLzFGL3diT2k2TWVjbTNqaC9mT2pNKzZkOTU4SFZ1TS9ZVko0SjNrTFZM?=
 =?utf-8?B?RmJrQkJEZWlERWIwd1ZEc29yTGhrYTJtTmliMUlmeWovTk9mN1pzSkVMTCtJ?=
 =?utf-8?B?RVlHTDZXRnB2VzNDK294VWc2Q3lPc2ZvWTY4a1QxUVFQTExtZFBOMEhwVGJQ?=
 =?utf-8?B?Mitqd3k5SC9TOVc2VkQ3aVRtZDA2dUsrWHhJYjRwd0dBR0dmcTczK0xQRE5C?=
 =?utf-8?B?Q1NGb1hUaFRLL3BMbTJMOW5uS2piNExySWlnSmJKYjVudDZTTGI2UXNHWlRm?=
 =?utf-8?B?LzR3RXVQL3RmWmVJbkZrU002U2wvdmcrYUVoVm02RnNhd3d6NDdoY3BPNVJn?=
 =?utf-8?B?TFhkRGNkVEI5TmZjRHY1QXh1UUJFTFF1a1REOFJheHRQUEJhK01mMnJpdzNp?=
 =?utf-8?B?ZHFVMktXNlNmNFFkYlZjKy93a0VPeTZVdCs0SU9CVjNLTHRNMUFVM3NNTU9L?=
 =?utf-8?B?eWh2YUlVeUtPMFJNdXk3Q3Zxb1JZSmRWOEZTbUhuRzZXRjZQeE9SenpSdHVt?=
 =?utf-8?B?NW0wQ2w5Z2lnWUViUjZmRnpBRTYvMXNwakJ3S3ZyYnU1aUpmalNjOWtsZ1Ju?=
 =?utf-8?B?WU1sR2JBVEpsVmV5d0dvN3hWcDllQXJVNzM3RTIrQnk4ak5lcHFtdTROYnlY?=
 =?utf-8?B?U3J5ZVgwek9mYkZ0ME5pck5qQWJVYVpkVUxxenRlMGtybEtBNlN3c1FSQlJy?=
 =?utf-8?B?RVE0QVVxa0o3UVNmeWRYYlc2ZFlVOXQ2QlhiZTRVUnRaTmc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2xkbm11VUNiQXhwMGNRcmpwTWZmMGJTZ1pwTjhaRVo0cUI5ako4K1RGQ0M3?=
 =?utf-8?B?QWNYN2lkQjNUT2lDQWZrakRaUXlHRW5hNXMrQ2d3UjVoTXdDRG5Ya2U0M3dT?=
 =?utf-8?B?bm10dnZXRzQzdzVmVjArVXlKVnorR2NuRzFDQXloVEZXNzJHdjg1UHZlVlBi?=
 =?utf-8?B?VURHdkxqd3YvRDhuMitoZmFqWmRvcFg5VUhqUDdiNHFzNERHcFZ1NWxiR3Yw?=
 =?utf-8?B?UDIyanVjcVNZQnVaazU4UkFFUFZ1bXk1eS9JNWwxWUtIT3Y3UWRPYUVDN094?=
 =?utf-8?B?Z1ViQ0tWN1d0bVNXY3V1dlJlcFNaZTVmTlR4RXg5VDVmWEREYTBPd1lNQ0hl?=
 =?utf-8?B?eG9KNi9TM1NZZXNLVWlhV1BTU21PTloxMzdESjA1bWZvL0tneUM3bnZQTVpY?=
 =?utf-8?B?UTVwbG5ubEpvcUZaVTZ2SUFuZU84MktZU3NBMGpSNkQ2N0R3cUJrRzh5eEZU?=
 =?utf-8?B?azhmUmZnd2dvUGpDRnRlakhraXhCZEhqVmtTZlRpenYvSEpnRmtNZk5nUWw0?=
 =?utf-8?B?N1V0UHpISnhPQ3RQWW5OTlV3dGFDWjhlSkNOTWNPUmpKeCtydHBya1BqbFF6?=
 =?utf-8?B?Zm1ycExWMWdPNjdNdStoMlNJNEtIL3ljOXlxNDNJQUhYZ01iYnpPcTYwOEZL?=
 =?utf-8?B?dW16UEx4UStrVjhrakFZY24rd2Q1SVhmNlNJSjZZaXNpRVBNaEVtV2VtNFFN?=
 =?utf-8?B?dnEvL0EvT2JFSndZMmNQOGJkYTlMdU05UjZ1RHVvSU9NMjhuNUdSM2ZGNmNj?=
 =?utf-8?B?SFBSVXBKcktwRlVvdmoyRTcvUGF5YXFJWmdSbURCMlJCTDVhdy8yMGxjSkhT?=
 =?utf-8?B?TjE1TFN2OVRHT0wwM1luaSt6amVhMlFIVno2aHB3aGlzZmlpU0NHMUVYUytB?=
 =?utf-8?B?ait4WHMvdWh6MmxFbURmcGpVZ0NLVFNWYXFqN1BaMHlCYW1pcGpYcUxUOXN0?=
 =?utf-8?B?Q1VWWURNQWJXUm9HSXM2bmFCUnhDdFh3MXA4S0lmN1lpQURqaFVkaktDdnBL?=
 =?utf-8?B?bEFSdmtJY0kvblNIa2hPbXJVcGVMR2JUZlBwTnNGZldrMjRDb2UwcEpmZGU4?=
 =?utf-8?B?bDNVNE5kYTlZR3lwY2dsTWZYbXJ4Uy9YemhhUnYrZldLb1g3S05KWGlTcHVx?=
 =?utf-8?B?eWtEWG9FV2pRaHdNWEJRWVhybm5vandzblpaWUJkQ3ZWcXozWXFFM0ZSUzJv?=
 =?utf-8?B?Y2oyMHBPcW5qYndCZmJ1WjQ2emc3OElOc1JOaWU5V3Z6bkJtSlBhVmpUaDFL?=
 =?utf-8?B?UmZ2STFVd05FNzBUbFREWHIyZjNWQUI1TlNmWlI4YWY3WGcvQXVUQWw1SnJ2?=
 =?utf-8?B?WWpIckU3V2hyOVpaUSsrU2YzSUt6emR0SHBPU3lHNW1UaDlqeS83OXVxdEU1?=
 =?utf-8?B?eDNNczF1SzFuY3NzZm9BSk5zUFdDVHB4dDZVRzhvNjBZZUJUdHl1QXZRUmE0?=
 =?utf-8?B?c3YweGdnaUJFdlc3aTNpaExwencwd25MWExnYzQ0Qld2RkFYeGRLSEVrVUZ1?=
 =?utf-8?B?NHhpbVRVeFExUUs1cFFXdTArTGNVNEx3T3pqRGtVc21UY09HeXhYNk8vSERQ?=
 =?utf-8?B?dWVyMVVhbklZWGFlbGhRcFBEYWhLdWJOT2JBTGYrOHBQOTFWS3hNRXRyMWRn?=
 =?utf-8?B?a0wvWXN2dlJDekhpT0paQ2JXR2NGd0dTeGpUcGhvMG1KTnBXdFNQMXNreWho?=
 =?utf-8?B?a29TNkNBUkVzS1dkQ09LMWVtWEJpMWNNaUdxSFJ0VWNLU2JpVmFvTWtvR0RH?=
 =?utf-8?B?SmZ6N0k5emZZS0J2WkdVWE1hdG5XY1dYNUVJVXlXNnZLLzZuMWRuRWc1UlIx?=
 =?utf-8?B?bGVEaUFZNFVaWjBEVWtXL2RVMG5rVGRoOVJVZk12WmpiemxwaW5vSDF0QVV1?=
 =?utf-8?B?aEpDQXhuQzJMeGRHbVJ2dlhSQ3N4R0RSVkZKSVZySjRPL0lmcDZVYklMOGYz?=
 =?utf-8?B?QWVpT2Vxei9WUmpjQkEvY3BqcktpWEZtdlhkU3kvSXAxTFdPUGIxVzVQbzZZ?=
 =?utf-8?B?UFpuMXNxdUw2cVEwWHgrYWhma3pvd25LYXVLc2ZWVVpJQVZ0Z2tJMVcwNDB6?=
 =?utf-8?B?eE40U1hNMHZIRlYzUXo0WUw3blJJaVVyaExadFVtNGdUdkN5N0JVYkJ3NnRm?=
 =?utf-8?Q?dsgN/MwEGavKZbsFWLRWtMAc5?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc721f39-8d41-4350-0226-08dcd856ef5f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 02:58:27.5530 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kFyo0sykohqmCMN1bt9YLT4lCbnoSkLy64bPM7vaUjsLAanHde1vamB3G7ICWFhAzjjmePRVTyONOQbDTDDvvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9986
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

From: Ye Li <ye.li@nxp.com>

Since we use SPEED GRADE fuse to set A55 frequency, remove the
set_arm_core_low_drive_clk function which has hard coded frequency.
And adjust clock_init called sequence and split it to early and late
functions.
Set the authen register in early function, because CCF driver checks
NS bit.
Set bus and core clock in late function, because the fuse read and
SoC type/rev depend on ELE.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/include/asm/arch-imx9/clock.h |  3 ++-
 arch/arm/mach-imx/imx9/clock.c         | 22 ++++++++++++++--------
 arch/arm/mach-imx/imx9/soc.c           |  2 +-
 board/freescale/imx93_evk/spl.c        |  4 +++-
 board/phytec/phycore_imx93/spl.c       |  2 +-
 5 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/arch/arm/include/asm/arch-imx9/clock.h b/arch/arm/include/asm/arch-imx9/clock.h
index 1ce6ac4c3a8..76f12118592 100644
--- a/arch/arm/include/asm/arch-imx9/clock.h
+++ b/arch/arm/include/asm/arch-imx9/clock.h
@@ -211,7 +211,8 @@ struct imx_clk_setting {
 	u32 div;
 };
 
-int clock_init(void);
+int clock_init_early(void);
+int clock_init_late(void);
 u32 get_clk_src_rate(enum ccm_clk_src source);
 u32 get_lpuart_clk(void);
 void init_uart_clk(u32 index);
diff --git a/arch/arm/mach-imx/imx9/clock.c b/arch/arm/mach-imx/imx9/clock.c
index 1433e68874d..76d19f1cba3 100644
--- a/arch/arm/mach-imx/imx9/clock.c
+++ b/arch/arm/mach-imx/imx9/clock.c
@@ -782,17 +782,10 @@ void bus_clock_init(void)
 	}
 }
 
-int clock_init(void)
+int clock_init_early(void)
 {
 	int i;
 
-	if (is_voltage_mode(VOLT_LOW_DRIVE)) {
-		bus_clock_init_low_drive();
-		set_arm_clk(MHZ(900));
-	} else {
-		bus_clock_init();
-	}
-
 	/* allow for non-secure access */
 	for (i = 0; i < OSCPLL_END; i++)
 		ccm_clk_src_tz_access(i, true, false, false);
@@ -809,6 +802,19 @@ int clock_init(void)
 	return 0;
 }
 
+/* Set bus and A55 core clock per voltage mode */
+int clock_init_late(void)
+{
+	if (is_voltage_mode(VOLT_LOW_DRIVE)) {
+		bus_clock_init_low_drive();
+		set_arm_core_max_clk();
+	} else {
+		bus_clock_init();
+	}
+
+	return 0;
+}
+
 int set_clk_eqos(enum enet_freq type)
 {
 	u32 eqos_post_div;
diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 52aafcbf99c..44e2166509d 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -741,7 +741,7 @@ int arch_cpu_init(void)
 		/* Disable wdog */
 		init_wdog();
 
-		clock_init();
+		clock_init_early();
 
 		trdc_early_init();
 
diff --git a/board/freescale/imx93_evk/spl.c b/board/freescale/imx93_evk/spl.c
index e4999baa95f..2ad7489ada7 100644
--- a/board/freescale/imx93_evk/spl.c
+++ b/board/freescale/imx93_evk/spl.c
@@ -123,9 +123,11 @@ void board_init_f(ulong dummy)
 		debug("LC: 0x%x\n", gd->arch.lifecycle);
 	}
 
+	clock_init_late();
+
 	power_init_board();
 
-	if (!IS_ENABLED(CONFIG_IMX9_LOW_DRIVE_MODE))
+	if (!is_voltage_mode(VOLT_LOW_DRIVE))
 		set_arm_clk(get_cpu_speed_grade_hz());
 
 	/* Init power of mix */
diff --git a/board/phytec/phycore_imx93/spl.c b/board/phytec/phycore_imx93/spl.c
index 5efa38a1442..17a8736c73f 100644
--- a/board/phytec/phycore_imx93/spl.c
+++ b/board/phytec/phycore_imx93/spl.c
@@ -130,7 +130,7 @@ void board_init_f(ulong dummy)
 		debug("LC: 0x%x\n", gd->arch.lifecycle);
 	}
 
-	clock_init();
+	clock_init_late();
 
 	power_init_board();
 

-- 
2.35.3

