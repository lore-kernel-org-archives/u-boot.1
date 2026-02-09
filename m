Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA790EF06FC
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 01:29:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 234EE83C65;
	Mon,  9 Feb 2026 02:29:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YgE/9uU+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A465F83C39; Mon,  9 Feb 2026 02:29:01 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95CE283C2B
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 02:28:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YlzWPYIvc8Ju8zCdlFB/3jsKbtQ1K9S2EbQQ7VUXPgmiCZr4xJUf5un7n1kXzH69DfEv3aLYLkS5m6zwIjYPnhvavzVqSiJ4yP/wcUzSAD10RtD0SQwiFlrHYN6TVNgw/Uci+8AaMsyJoP0jkL7qE9HfSjpZsYiHM1TFw+ZSzmAi2bCFxKUspTk23lAIlE9w8mXWisxDpEHdkiZb2vGytbTRcr1rXeN7W0hZl39tXBiMweG0Xr7Sfy2Co1ABr0Lr2GhnO3Il+NA088PqIeRNMYUjMn+vCjYb93A1s+4Z1tdrEPAOk7Q7gcdiVmB6rKevttORCuaJ2K0upeiI/baqjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dxbr7uyv8Xqm+u1OsX4NFT/MEzMSpSPFOaM6+KTG3SM=;
 b=g0dsaDlK3wvbFeQWEITI5wMuW8vM/mlxtViYI4A5VnychkgZaK1wwRXvH3mvtKd0n9Nc8iZMAXyZF37PSyF+GuBTZoyelxSR+XbnpCFwcE5d7V8c0xYakLJLtxq/t455CmXEWnAJkIHugzzf0+92mtm/POHMXarYkkoJC42MKs9GS7OinENeEXg+M5P4qkOOgJNDg1rBB6cmqAgdsqi6RietSLxkYg3V310r85YotmjM/pkdgmbvaqysH5zYNTk0gPVcAYbM/eFrNxsV145jaWWP7ibvelRqcPlliDJLWdHOqYOvr830ZkShJF34RWJcgnqojoSt8Nu7lAwwrVBaIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dxbr7uyv8Xqm+u1OsX4NFT/MEzMSpSPFOaM6+KTG3SM=;
 b=YgE/9uU+vlx0W8hZFjMwiCPqDDNpDiXBBmpHQBiZ+PM37RgdDnjKtmDjKmpA6ugCyOjyF8s9WHarOMA9gp4/ghU7aky9Ik95qpIKFo0LXKQYBbagEpWiYGMtj33qhaLBp6Am6FxVeaXD09UROqsxzDIeE1aSCBkIkst+58U4E1GRnm1ehHgr57EbaMqKocuvtCBCDpMB0e6BjTAV1SvbowcLshW2VTOkt6ISkZCW7b8w6AWfcAJgk9pLuvjwHvjSAkFH8nWZwCAD/XZQsmaPFYBjU1Zew8YiDgZZQYCd6yfet7q2RnW6F0jL08Z5rVcOnDeyXXJ9/ZBuorQbzQwKkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9840.eurprd04.prod.outlook.com (2603:10a6:102:387::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Mon, 9 Feb
 2026 01:28:57 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Mon, 9 Feb 2026
 01:28:57 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 09 Feb 2026 09:30:07 +0800
Subject: [PATCH v2 03/14] common: cli_hush: Include vsprintf.h
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-cleanup-v2-3-73a3a84ddbdb@nxp.com>
References: <20260209-cleanup-v2-0-73a3a84ddbdb@nxp.com>
In-Reply-To: <20260209-cleanup-v2-0-73a3a84ddbdb@nxp.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2PR06CA0207.apcprd06.prod.outlook.com
 (2603:1096:4:68::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9840:EE_
X-MS-Office365-Filtering-Correlation-Id: fe547d52-98d6-4b25-90bf-08de677a984f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L21HUVIybWlIT2tHZkVYNEJwUGpHamU3N011NTFUbDd5MXJqMmNXSm4xWVAz?=
 =?utf-8?B?ekFVb2ZuM1FvSURoMkFXRkc5TmV1dStISUFrbitjRzVJdnpmZVdKaTA3V0c0?=
 =?utf-8?B?WFc0bGd0T1kyL1ROWHhZNXJ3d2krRlhvZVEvWC8zc2U0dnJqZC9ON3BpTU40?=
 =?utf-8?B?bXptRzNMU1hmWkRsS0dpQmhYb3dtOGZnR2U1RU9qelJ2NloyWmJObDJmUFlS?=
 =?utf-8?B?YjJZZmc5UFYrano0U1VoUk1kbGRwaHY5MGQwS1FvUmlBamRDc3RSUzVxZ1lz?=
 =?utf-8?B?WFpGTVV5S2RDWGk5K3N6Z2NEVkZxaUVvd2ZNaXpQOTVGZEc2TDF6WFBGcjFr?=
 =?utf-8?B?SHJFd3lYTCs5Y0dNdmNqYXl4ZkE3YTFSZmc0TnJxc2NENHZ5ak5pWnNuWWN1?=
 =?utf-8?B?VXpIV1lpOTQ4TkZmY2xCL04xOXBralBaTzR1NDVqTXVLbzNPSkJIQmdra3Q5?=
 =?utf-8?B?TzUvWjI3MkN3VHJtaVZ3U1dUa2FRTXdjQ3IyTFdCSk5VOFVDV0FGZzlocXVP?=
 =?utf-8?B?R0NWTm9LbHdkUm5PZC9LSklpcGcvUGZkejhRMXlTMkh1VVRPai9qakxJY3Mw?=
 =?utf-8?B?c0V4WVNzemJPRVF0aDFHRGphRHg2RnA2Z2I5TWJhei9vY1k3UHZ3QjdJTURz?=
 =?utf-8?B?MGFjWFVPWEgxOW9tZFNoZVFqa0RNZUN5RVBGS1FGZTFTaGd0TlMxOEZRbTBr?=
 =?utf-8?B?WVl6T09YdjVPUTBraUQ5K3JTLzRRdlBSV29Hc1RlNUVvc3NmUVBKU2hCMlo3?=
 =?utf-8?B?ZmVIaWxmZmZEUmNzSVpFQysxMVRGWWIwQlRaZ0FnN1crd0F6akJEUVpxR0VR?=
 =?utf-8?B?SGs5MmlZbUV4UnJENFNtMEtWaStlT1RiRjhsYmRFKzdEVmI3Tmw4UUNTc2xh?=
 =?utf-8?B?V1oreXZCWGZrajhWalJVQy9keUVlUlpWbDNWZjF0em56MkpxRXdrUU1oVDQ5?=
 =?utf-8?B?NFk5Z1RzYWJ1RHQrWW42WXVONk1DNE5vNFo1dnlydEJURHdNdGkwUklJRkVz?=
 =?utf-8?B?WnNYaGMxOTdnb0ZrYkxwcFg4MWgzd2djcXFFMlJTNENCVDhzMXFzWWFPSVVM?=
 =?utf-8?B?aGczTXFGYSthR0xVc3B4Qld4aUZ3QlpHZHdWV3ozQVg2akovTnRzM0cwZG1S?=
 =?utf-8?B?UTl3ZmRSSElhRTRnYlNYNXVsQ2UzVGw4ZTMvNUVLeU0xeGo5U290d3IzRUxC?=
 =?utf-8?B?UGhQQi9UNlVoelk4citqK1YzaXAzSExOZk8rU1N3N1k0V2tJWmdsTUVob1RI?=
 =?utf-8?B?dnF4WldzeUV6bWp2R1RLNGJ1TERkcVpJelRnOHFLYngwQUVHUUtWOTM3M0VD?=
 =?utf-8?B?YkNhL1c1OURMRUhUWkRaQ1l0U3NqZUdnNjRMSVRWSThaOStZNVE5U08wbUJL?=
 =?utf-8?B?M1BDZFIxR2JBd0NUNDNjeERIQzBhL0F5RWcwTlB2eFBVaEdPWTdvR3ZDSGxY?=
 =?utf-8?B?c1JvZ3N4QTZ0MXFKUlpNWFNIS2VKYXAvcE9nbGx5dm1mTFpkL1RlMXlkK1VQ?=
 =?utf-8?B?ODN1bFBlVzF6NjdHMWV0aGlpTmV0UkpVT3FMbHNFWHdJY2REaUNQTzBENUZC?=
 =?utf-8?B?MjlRNit3TnRHTlFRTUM0eDd0aGdzNWhZQUo2TzZSaTJaelpRdWpzNnJaYVhQ?=
 =?utf-8?B?THk0ZlYxTGt4bThhcDRON2FGN3U0K0ZIT0NBVjNJK2xsMTFrYjU0b1BOV1Vi?=
 =?utf-8?B?bnh6SGhSZnFoTGRnaUhFYkQyV2M2UjROd2tETTN1VXpINS9MYzkvcFI3Qzh6?=
 =?utf-8?B?VEN1TlpEOWVmZ1FZbEthWGtZUXBCQTNyMW4wY0VncVFrODRXcGJ5dW1iTzZE?=
 =?utf-8?B?SzR0TnpZMlUxN0lGbW5UcFIvR1hQejZlRWZuWERrZmtLbldvSkZEQXhBcnh3?=
 =?utf-8?B?eG53SVZ0NXI4TFI5YlkwM2F4bERzRmhNRmViVE1aUTEraXFFcWNrbmNXcE8y?=
 =?utf-8?B?U3c1MXByODFlMzZEQ0FvQkNwdmFIb1NKRkZiN1hyVmNLZUUxd2hSUFNpekEw?=
 =?utf-8?B?SndBTE5IaDVzb0ZrTEszNkh6bFdJM09UcHQvRVBkRHU3czNPejAzZTdvTmwz?=
 =?utf-8?B?d3Q2V2JoZTRoNGg3ajdiZ0lFcE1OYVRadDc2d3Qwb3FKeG5SbDhLSzJaNnZ6?=
 =?utf-8?B?bDlCSkxYcXk0eVlTWUlqUERGSWpSQXR2UW81eGRKTGwyR1Fyd0hLcVVINGlX?=
 =?utf-8?Q?+37XcGh0R6bI5bZzFSjPa34=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zlpkc0ZRd2FqM2NLL0pNK20waThGeGZLT0thZkthbUlEQXpCdUZpQVNQUE0x?=
 =?utf-8?B?NXJRalgxdFpITy9RV3J6S1I1WmpJYXY3MDJHbUFpMnBPZkw3QkFXSyttVWNx?=
 =?utf-8?B?V0ZQWHBqTFVQcmJJMndYR2tMMkhSVW1QbnJCTXF6dS93RkVrRUxKUEluTkV6?=
 =?utf-8?B?NzFnTmhFcFdOeWlLd1FaL1ppTVNCbC9HMGNpMWhQMzVXQ1k3azBodlNoS244?=
 =?utf-8?B?RUNNSEx6dGIzK3dRaGpIdzVDWFpGVWNuZFVINVhiYUY4QS9vNndwUVE4d1Rx?=
 =?utf-8?B?TlR1V3hIVUxJai93WmJEdm9BbHJESXcvd2doMHkrQStITzk1dkVDZUtlZXlQ?=
 =?utf-8?B?WmxXMHFMeE02U1dzUHNRMEM1Ny9NdythaEJ3YkJsZUplZ0dTeml3elJGRzBV?=
 =?utf-8?B?OElrWEp6SWY1d3N1L1MreXBYdFFiTFpvcXZybzQ2T1dWaE9MWDNQcjhOWHFC?=
 =?utf-8?B?ODRodmxnS1dYZ2VqSTc1YmRGUlRiTFdxTngwTEZ1Um94eExkclVJdks5OUhB?=
 =?utf-8?B?Y3VkY3FUYm5JSitMaVRiRmdIY3VMMWpEWS9MR3JSMHJmUFJVelMwM29TZDNi?=
 =?utf-8?B?bXRiY0pCa1Rmdi9ONlFPS1Y2YlFnNWdCVWpTRGdmRG1Za2ZrRjZvRE9wazhY?=
 =?utf-8?B?K0ZtYWtiYm1iaklYVnkxcmQzZ0FoWU96cTQ3QlBMRWFxdUJ3U2ZUSUFwNmFX?=
 =?utf-8?B?b1ZVY1ZqZDBjMEk1SXp4dU9ZcktDUm5rYlVJZUwwZHpnRmRUNTZKWk1TTzFY?=
 =?utf-8?B?Qm5BRmtNeVJkOVFWWStjNFZ5ZjNWNnFOVU9rQnh2a1hIOXgxQmg5SjFrWFRr?=
 =?utf-8?B?TExFRG43OWJZa2pPVEl4MklydlJMeFk4dDE3KzRSNEgzQUExUFZrdDdWYlhT?=
 =?utf-8?B?cTZUdjZ1YnFwNDUyeWxkS3pjN3cyZHZwcEFKRUt4aFArbGVZTGFEYlFHVWpq?=
 =?utf-8?B?Rm9nd0F6YXlMSkZsbjFZRlBUN2NqYWZza0gzM3lkakFGNUNuV3dCb1J2TXRT?=
 =?utf-8?B?UUlPU0VJK2NXZi9oR0k1OHJBSEMzTkhyTFBxTWZINnRGYXExSVh0Nkx3bzE5?=
 =?utf-8?B?QjVpYVA1NmhFMlFUaythQnpMcXk0bnd6ZzdDN3RrL0ZtVXF0MVNXNFZnSnZq?=
 =?utf-8?B?bzF1SWg4Um9VNWxDTW5oR094cDFmQlNyUzlIMVV2cHA1eVNBV2RZYzQ3eS92?=
 =?utf-8?B?dVUyNGpaVHNTWVh5Y3R6cGR5NWZTMVBuK3NIRzhONTA4V0ZaVHlRNUJXSE4z?=
 =?utf-8?B?WXZYVndHb1luR3B4UEQ1M3cyNDQ2amFpWWgvV0FNb29mYkd2L3FlVDczS1d0?=
 =?utf-8?B?N1FjeFJJbENFeTVQaTAza2VqQzNvcEtMZ0h4YTJZVG5HR3dLT2ZZUmNGQ2VL?=
 =?utf-8?B?ZU13aDk3QlJLMkZLaWZnYmk4ZUZuaXJKUmlDS0tZaDkrSGZJRnFLTFR6Skg3?=
 =?utf-8?B?SmcvKzd0amJVUXJ6aWsrZVRUOW5ocDBwYVJwVDd3NGFZcm9yK0h4VWRGREFS?=
 =?utf-8?B?aW94SjBqMmpNKzFLakxXTWtMcmlSdGY1bHpBY3ZxK0pkSTErNEE1UjJGaUdP?=
 =?utf-8?B?dDFqdHU2clBnSUdpR0JwOExUNHhKTnRGUVJiL0RQSDlYbFhIYVFHYzgrNkNB?=
 =?utf-8?B?V2JXSzlOKzh6VXJaTS9nektGRmppK1BMR1dhQk1rSzBOb29qQTROdW14SXpt?=
 =?utf-8?B?M01lUXVlenRsT3ZtUkZlU3IzWnlhUGpLeXJsTUZSRnBmYUdnVU1UNnVXZWRF?=
 =?utf-8?B?czhPTCtDY0hUbytkN3RwSmdkSGgzOEZ3YkhQazE3T1JUTUpML2VPdTloWVdj?=
 =?utf-8?B?aGdmNVBwSUN0c0xDSk1LZ3FiYzIydHBBRlppYTBJL2VINktYUlRPRmdnYmd1?=
 =?utf-8?B?eVp3WUdjNGRwZW1BblVaMlNzVThsakYvVlB0a29GMCtDV05GYmRrb0xsR0Jy?=
 =?utf-8?B?SWJvaklqeDc1aXphN3ZOZ2V3M0JtakhUakROWUN4NC9KM1BROFJzNWZhZU9R?=
 =?utf-8?B?SUxRZmtoNkwwMkIzVlFrK2gvb0QxVklwbUY0QzZxUGdPVzh3SUhOY0RUUzBP?=
 =?utf-8?B?TFlQdzNtNExybVdDL3dxZ1g0YmZvODJrWkx1OWJzMWV6SGNNMzV3OW9PVjhV?=
 =?utf-8?B?alBVcGwzT3JYY2N3U21xN21qd1E2US9YcHhmZTVXUHlOSm5yY0p5M2c4Y2Vt?=
 =?utf-8?B?elpCeEpFZjN0MXphVlpaYnY4ZjZvam9OWEVVTWlpbkczb3JXS1NwMy9GTHFr?=
 =?utf-8?B?Q2NuY0dxb09hK0Q2Z1kveTZmMzcvUVJyTEdKL09CZWZ4L2hHNVVaMTdaM09J?=
 =?utf-8?B?dWM4VmVZbWxEMHh0RFc4K3pneVVzR1ppenU0bjN0SnVoalVUZXV6Zz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe547d52-98d6-4b25-90bf-08de677a984f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 01:28:57.5103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z1emVV1CT6oI+U2v+Cw4jzQuykBNSprh6n3De6wKigYKkp5G/0WOKbtGMTRkRreaXFpueKStq1aB4uSDeF0TSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9840
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

From: Peng Fan <peng.fan@nxp.com>

sprintf is used in this file, so include header vsprintf.h.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 common/cli_hush.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/cli_hush.c b/common/cli_hush.c
index 7bd6943d3ed65bb24c709af0b195825a26d65f39..fb087960c9206b1e7fe4454bae53f6bc1cec1bdf 100644
--- a/common/cli_hush.c
+++ b/common/cli_hush.c
@@ -83,6 +83,7 @@
 #include <cli.h>
 #include <cli_hush.h>
 #include <command.h>        /* find_cmd */
+#include <vsprintf.h>
 #include <asm/global_data.h>
 #endif
 #ifndef __U_BOOT__

-- 
2.37.1

