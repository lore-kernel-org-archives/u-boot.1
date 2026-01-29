Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B7ED358EC
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 09:40:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F42B83E69;
	Thu, 29 Jan 2026 10:39:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UF7Pnewv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FC9683ECF; Thu, 29 Jan 2026 10:39:47 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 813B680086
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 10:39:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BpkSRBJh/3VtIC81pigAM7nzR2HnXlGJj2JbTwXfNK2s8lDdK+V7NUS7aROz8pXnreAveqEeKN1w4KlpjgGhrzxiqugiMmkGA24XcWz3DP9fkTMx8tdzgTzFg2ljA5Pcg7YRlq+++hOJBCEiGb4UYkdLgUNI5xGihGHi4ySa2qBQQqPVs/rry8Fq0ZqkKiOffezX6XynoC8dKjQjO8rUCLWsbZcWX7xVgwslcoRPWI//vFWMi4bxxFtAf8QsES/a60AapBnAyMCm/R8JG7NOgA5jlAT7ABgFka356f4eNu4xgvJ8aSPRzIwyRwMaEi/Sl2ycJ5bExr5DW3FWp+w3iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dhpf0A1uupEeYRPwwRoC0xkrqknU22yOJJ+VbjEEHSw=;
 b=nyekCx56kJbF/buVKL97/iUllPiKvGXD5Oz0ogSSrlb/LfODFm8LfUpNI92ANt4zCUz1+0gbk/N5nIqKOaN8o7XCuGXneOf2peOTMHHmQvjriN+huYPK0K6TszIdL9GubknKai/31iT4U0itOrsP0wqlUW52F2F85wXU6E2Ay7SYYXkvkS5fJ+1J6RGhEh4WCqEAKDDHBy9+axVPCQiKa6Ze/YapKAQh5IfWa8E3QKWT3VoPuZgk3pRVuAyZlPfikxdab/Lp1mKsE5/J/ZMNnWpfAOhk0ZvUBNdjwxfU6SZkRwcPENKgCJIZFWHl03WqbV4dquw1cinY87SC5T4zjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dhpf0A1uupEeYRPwwRoC0xkrqknU22yOJJ+VbjEEHSw=;
 b=UF7Pnewv89qAuytNCpn2/WDT4wmozRZkgvr5VtRLvM4ZyclAwJa9Ghr20kUj2vVXoDvviDS3/tIvhqysOQCS2/rVKVUFa2moDDYhqSefPkjCUVQvk9Y+LoYp0hTksCstKLFQPz7rvc1/rfsS2IhCCuDddw7oqDb233a+4QyJUJhbkkA0Dvp9PgWJegVmoOh+YILXkQAxYluw9aYdw7r+qgXYQKNEeaNqwfwaff/LIgRBP4FcUOVGjPNttkIw2cuM0piBKLcLMs0hb1xdsX0ki8wBoiqFG8Fm/Dc1StGe055RobCBpQ0ada2fExm2kYciSfz6k5c3jqA57u1P8YSnQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10384.eurprd04.prod.outlook.com (2603:10a6:150:1dc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10; Thu, 29 Jan
 2026 09:39:42 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 09:39:41 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 29 Jan 2026 18:54:08 +0800
Subject: [PATCH v2 06/12] imx8mn_evk: Cleanup headers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260129-imx-clean-v2-v2-6-1245ad2c3a01@nxp.com>
References: <20260129-imx-clean-v2-v2-0-1245ad2c3a01@nxp.com>
In-Reply-To: <20260129-imx-clean-v2-v2-0-1245ad2c3a01@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SG2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::10)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB10384:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ccc5c38-1e1b-4fc5-0923-08de5f1a540a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N1o1dU04ekt3dUxsa2t0Q0Q0S1czWW04ckhhTlFPMm14MmVteE9DM3BUSmN1?=
 =?utf-8?B?ZFVPcHBtb3U5VU9zSFgvc1ZZcXdMN1A2Umkzd0xESUplR3FnNkVxM2pObk4y?=
 =?utf-8?B?bnN2MTJtdTdKNjMyWjdnYXEvbWNUSkdtdmpBSGZKaWliZVVkczZBT3NzbmVG?=
 =?utf-8?B?em5QTzR0eGxHektqQUszYTNzUW8xeDJrY0JHRmttb1UrMlZOcXRpV2czQ1hP?=
 =?utf-8?B?UHBxN20wRXFpdVJWUFJUc1pZb2NtaU13TmhQaHFRY2xvamNWNGZqNHhrQlQw?=
 =?utf-8?B?TGJMd3MyYXFoN0hZUjhOOFlURGNxTzBQMjJFdThibjk0Qkk5Z2pIeERCK29P?=
 =?utf-8?B?b1NoTU9ENG5JTnU1c1gweEZXTVNIOHRGMVRQckZ6MXFXcXVYYTBDUzZjMU9F?=
 =?utf-8?B?TEFGWUQzU0IvQTFVVURmVWRjd2E1Y2o5NXkwbEZDcW5NanJsTGJjZ3dKNm1q?=
 =?utf-8?B?dHZuT1pyaXRSOTQ1aUp2T1J6RThyMG8vU05HMzV3TjZHWWRWTk1jYlFwZXdD?=
 =?utf-8?B?YUNRSXc2eG1HNFoxZHBRbkFhQ21PUy93QnYvQWNKekZISlBKYk1nS1N4TjlP?=
 =?utf-8?B?ME5aa1JlTDV1dWhQQWMvUXpOSm5NekRoUU9BQjdEeVhISGdOa0NDSUJXN0Nj?=
 =?utf-8?B?TVhOUDJNWFhVVUpCSXY4VVNVbGt5ZUJjQzkybWFjcWo2aWpYckorRGR4bDJi?=
 =?utf-8?B?K2ZmZk5uZ0djUnc3bFFHYkRGVVdveUV3aUoxQWFBcmdSd1VxT3ZETXFnTlI3?=
 =?utf-8?B?TndMcHlXaFJmcVhZYmhRM3M1OUFqUVB4b1ArdmlSMC9WOHNHdHFtTlQyQTlO?=
 =?utf-8?B?ZWhMWFJxSDNpTnpla0Vibm9rdU12T3dmS3lGMjlON3lzcHZVYW51T2FHSWlT?=
 =?utf-8?B?U3VEUjZYem8yVTl5cjh2SWVNV250RkcvOU11KzVRUnhFRXpReW5wMEtCbERo?=
 =?utf-8?B?U2JjYVdtWk9UNmh4UWluSVhXVHNpeEpPNzR3aTN4RkpPSWVmM01KaURWV2E4?=
 =?utf-8?B?aSt0ODl1ekxHMkFDclFSNVgyd25QakdVcnNTVlNoRGZvdEdtTVFwdTN0UmZM?=
 =?utf-8?B?VFp4c250YlRkZncyTVg3UFhROUNkL0JTQ3dMUWlzTWxEaWd1WVBjQnlUWEJj?=
 =?utf-8?B?dW5jNlBnQTUyM2YwV0hoOURHeEdFU01OYU9ZdVk3RFlwNm9UaHNmY1pSU1ox?=
 =?utf-8?B?R2ZuYXVabkNQbjh2RnpaZ3NXWUN6MlM2ZUlweDVuc0dWRDFVVnducFhGMCtQ?=
 =?utf-8?B?QXNLaVNnc2xoS1ZteG5IREc5bWRnOStoVHhCTStWVUMxaitiTWNWcG5GaWFB?=
 =?utf-8?B?ME5UK0JPWVh2UU5BdVRHaWNCN0RyTXN2SzNnbW9sbjh2K1VOQjZmOHYzY0lk?=
 =?utf-8?B?WjhoOTBsNWlaOWZOSW02T3JOay9hbTRqdlN0NCs4VnRjUXlOV0V4WTByaFkv?=
 =?utf-8?B?UHkrekZBZVhHSjNPK1VpOC84ZWZLNmJVVHFqRXRLemM3dHNxbDhndjhYOVBQ?=
 =?utf-8?B?SVVkRG1LM3dTams0NDRyQXJEb3hUN1Z3RUNMb1RieHZvSklWbGp4QWRyb0pr?=
 =?utf-8?B?b2VzZHpLVTd5SmNHUlpKbTkvcVh5SEc0Nmowd2JUK25VNVE3UVhkTWQyVklm?=
 =?utf-8?B?Wlc2MjZPR3l5UDBlSkIzQkdyS2NrZktUTm00YUM2NzFvOHVhSm40WW5sNkUx?=
 =?utf-8?B?L01MRms2R3VZa3VIa05iN3V0QVdLNTNBdTRreHk2Q25WRVhvUnAzdXZiZGsw?=
 =?utf-8?B?S1BRWWFHcTVUUHFoa3hQZy81a241M2R4WkNyYjByZ1dWSDdIRzlIRWpZVW42?=
 =?utf-8?B?dmRqOUJnNmIxbDNicEhLMFA1ME1kWWExN0lXUjFJSzZjVCtIR2o0Y2s2aDNE?=
 =?utf-8?B?TkRySTEvWmpET095R2t2STFFNWRNWkN0alhDRlY2bHF4bVA4a3JPNFh2c3Ri?=
 =?utf-8?B?b2RIemorb2tRSGluWjBjUjFYQzh1emtLekR3QTIxZUNWL2RYM3dZTXBlU1M5?=
 =?utf-8?B?alV4YkNNYnI4dWJiblRKbnhKcmVuTW9lSTR2dmV4Rm9ZYXVDVy9lTVR5dnlF?=
 =?utf-8?B?WjhHOTBqblJTY2FEUlU1ZlczMVd2SnJCY09QaEEyR2VGV0Y2aEhuWHJnNldK?=
 =?utf-8?B?bnRSMTA5MXg5MVJSS1h1d2JTbmFMOHJyWEhMdHJvNmMzcEd2WlowaER1d1hJ?=
 =?utf-8?Q?IXCY08j9Jw7zRPGYKcf1BPU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2JuWlk0cmxIUTQvOVpGUjl0cEpUTHNoblZBb1c5ME5xSER4V0t0NkdnS3d6?=
 =?utf-8?B?L2xqd3ZCb0hqQUorWlJQQXJuQjllc0FNZkp2R3ZnMlh2c0pjdVV6OXV1dFBy?=
 =?utf-8?B?ZmZJNjFwdWpYTDNkQ3ZKM2xCWnA4R28rL1ZsSURrNHVYeVBNbXhOQlA1VnB3?=
 =?utf-8?B?akNjaVZIczFwNFQvai9Md0kwYzZoSHBkb1F4QVFRMmlxVVVVVmh0VGMxWXFs?=
 =?utf-8?B?bmh3TVMvdUtlM2I1RHkwQng0ZURBN0xIR0VFdG9xeFR6TzkyZHI4dFpWWFdQ?=
 =?utf-8?B?aUJ2aHR6MFUzbzRuV1lnSWM3b3l4bVpZNXVhVnJPazN0endBUmVkZENURStB?=
 =?utf-8?B?WmFIRXlRNGxqQmQ0amlBWkQ3VFJLRDF4cGtiUWJYaWYxdDh5RXFnQ256Wkhr?=
 =?utf-8?B?RjN4V05sUEtXK2lOUlQwcm9NdFZuc3g0YXJDdktaQUh1T0RMWDZBNG1ORkZv?=
 =?utf-8?B?NWY1b0g0UTBWWjYzZ1QweGw1MkdWSHYySWo3d0gwci9jbjUzSFNVa2VTV2Y5?=
 =?utf-8?B?N042Y3NoUDVuSVBVY1dibXVJVUpjMEVsandrUkp4V3ZPRFhOZjlWYURsaWE3?=
 =?utf-8?B?UjhRUjFSU1kvVmljcEZkaFZscVVyeWU1SFptWFBZK2FHR3BiVVBYRWR3M2RL?=
 =?utf-8?B?ejdmMlJYd2tBM2lhbUhsMDRSYVN1eGttN0s0NEY4RjBFVnR6OXFLL1VRTFlt?=
 =?utf-8?B?cmU3TkpTWmFVbHA3YU9RdmxuNTZ4cHkwbnZmd2Z4ZXdsMDhYclBmKzEyakhI?=
 =?utf-8?B?RVVZZ01aQUcyeXN3dGJGSGVWMG1abTJSYVcyYmtJdGErL29DYzE5OEJGNk9i?=
 =?utf-8?B?VnR2aVdoVzhlNWllYXZxYjQxTmtBeVRWUnU5RG5qRUY2V2xqTmJRTEFQZVl1?=
 =?utf-8?B?MXp3Sm9QVk9sM1pSTjlzclpRZTlQdU1WbkltSVJaZ2Z4RzJqSmRtQkJCTW5D?=
 =?utf-8?B?b21vN2NvYm5DckJKc2hUMGk4cUx1WHd5Yis1Nk8xSE5UVGphQzRURHhoK3hx?=
 =?utf-8?B?WVpNZGJYTThmL1R0Z012M3lpQ0JkRGJWWXMrU3U2T2V1VitjS1BxQjFuWWdF?=
 =?utf-8?B?N1JXNEhtRFFQc3BsMlN0eHA5bnFZbTZVUW1DM00zTmk2bkVMKzFvT0p0MXVN?=
 =?utf-8?B?VCtZNUhTM05CN3FPU2RHbng5NkFNcjdnWlo3ZDEzeUp4bDRGMlgyb2hvMVBq?=
 =?utf-8?B?Mjd6RkNvUnl3MTNvUFlGazVsZWcyWU9wVlpYNVY1M01meUFHSUN4bnl6R3Bx?=
 =?utf-8?B?Nk9RbjhuS2lCcmVHVGpMeDQ5Nm5LNUNxelpHSG5XZWNWY0tvaFFSSlp6WEFo?=
 =?utf-8?B?VXgra1lVRHBRMlhlREVmMmwrRXl0WHI1ckVWdm1lK3h3NkNkS1Nra0hDWm1r?=
 =?utf-8?B?NGxTY2ZSUHlHLzZmSVp2VjJjeThnZytOR0V1b1pxMldBbjVkOWpUY0pob1Bu?=
 =?utf-8?B?Vm1HMGZxaUFHZDhTTzJ2aTZKWEpwZU5CMHpHMTVXQTJvUTdpR3NGQ0RkR0dH?=
 =?utf-8?B?amJoQjhZVXZicm1BZjQzamhWalRmNFpuc3pzMFZ4ZTRBQlVoL3hvQm0vMFpM?=
 =?utf-8?B?R0lOd3VKKzRyTWxCUDl1dmg0L093T09kV0k5bDM4MEZ4UzdBRTZRYy85Tmt2?=
 =?utf-8?B?d2pJaDVXd3BLTnhtdklTZjZFdVNQckpJM1hwRHo4RnlwUjZUUjhsekZxN25B?=
 =?utf-8?B?TGduZVAyZ2hMZ3FML0V3Q3Z3cC9IRUhKYUFWeU4zQ0NWYUN5YUNmcFh5bzBC?=
 =?utf-8?B?TTJVeCtpL01KYkE0bkdXTXVEd0NjMWFpeGtGdWhwMEY2a0d3QjEyQ1BVcW5B?=
 =?utf-8?B?dTBoK0loUHRUNXRHSm5ldHhhZXFtdFRoWjM5aTdLZnVvNFVNdmVpdGY3V1M3?=
 =?utf-8?B?NU8vL0dhSmowYzY0eS9lUDFoNkxDQkQ1ZU12Q1crN1JLSDNST0QwTk5qMU5j?=
 =?utf-8?B?VzMrOUE1a1A2YzFkK0x1bUU1Y00vdTRKN0NkVmgzUmhvTlpLTGFFeGNqNGtx?=
 =?utf-8?B?cXU5Y2dKaUtVVFdJZGRrdHU4VXBYem5vc0xmVFVEcW5RYjZ5U3UvOEZPR2gy?=
 =?utf-8?B?NjBHb05IRDg1OG55aFBtZG1nT2NRQndkKy9Zdk1qa0wwQXFiRTBuY0FvN1B1?=
 =?utf-8?B?eENMaGl0b0VZbkVLUmRBbTZ3clFjUTJVSkxmVWxBUEEzOXFGbEpqNHhtOWxi?=
 =?utf-8?B?YXJNZ1lIMzJlZk1RVnh4K2FYYWRaMTBHVG9ZMDZEZS8vbG9va0ozckNnZjh5?=
 =?utf-8?B?VDNJa0FZQXl0ZVdrRjQ3U3dSdTJreWNWS0hqenpqaG5MTmprcG9JZ09rcDBQ?=
 =?utf-8?B?UXFTckt4b3FmbG1qbjR2ZWU4a3NSU1BQK3JEaFFFNkE1aVUzREFOQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ccc5c38-1e1b-4fc5-0923-08de5f1a540a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 09:39:41.8375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQBEQsOt39UC6d1KCKoILFgri2eOKtYPqj7wUuagPoK/j4BUgpSNlCmLaa208+x1ncuy5XJl6rAvJUmnU02mWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10384
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

Drop unused headers and sort them.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/nxp/imx8mn_evk/imx8mn_evk.c |  4 ++--
 board/nxp/imx8mn_evk/spl.c        | 19 ++++---------------
 2 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/board/nxp/imx8mn_evk/imx8mn_evk.c b/board/nxp/imx8mn_evk/imx8mn_evk.c
index 9d3f29f2253..e13b35c116a 100644
--- a/board/nxp/imx8mn_evk/imx8mn_evk.c
+++ b/board/nxp/imx8mn_evk/imx8mn_evk.c
@@ -3,12 +3,12 @@
  * Copyright 2019 NXP
  */
 
-#include <asm/arch/sys_proto.h>
-#include <asm/io.h>
 #include <config.h>
 #include <efi_loader.h>
 #include <env.h>
 #include <init.h>
+#include <asm/io.h>
+#include <asm/arch/sys_proto.h>
 
 #if CONFIG_IS_ENABLED(EFI_HAVE_CAPSULE_SUPPORT)
 #define IMX_BOOT_IMAGE_GUID \
diff --git a/board/nxp/imx8mn_evk/spl.c b/board/nxp/imx8mn_evk/spl.c
index 6554d445a59..f07443e5c15 100644
--- a/board/nxp/imx8mn_evk/spl.c
+++ b/board/nxp/imx8mn_evk/spl.c
@@ -4,32 +4,21 @@
  *
  */
 
-#include <command.h>
-#include <cpu_func.h>
 #include <hang.h>
 #include <image.h>
 #include <init.h>
 #include <log.h>
 #include <spl.h>
-#include <asm/io.h>
-#include <asm/mach-imx/iomux-v3.h>
-#include <asm/arch/clock.h>
-#include <asm/arch/imx8mn_pins.h>
-#include <asm/arch/sys_proto.h>
-#include <asm/mach-imx/boot_mode.h>
-#include <asm/arch/ddr.h>
-#include <asm/sections.h>
-
 #include <dm/uclass.h>
 #include <dm/device.h>
 #include <dm/uclass-internal.h>
 #include <dm/device-internal.h>
 #include <power/pmic.h>
 #include <power/pca9450.h>
-#include <asm/mach-imx/gpio.h>
-#include <asm/mach-imx/mxc_i2c.h>
-#include <fsl_esdhc_imx.h>
-#include <mmc.h>
+#include <asm/sections.h>
+#include <asm/arch/ddr.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/mach-imx/boot_mode.h>
 
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {

-- 
2.51.0

