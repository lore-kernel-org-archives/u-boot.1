Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6953CAC5AE
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 16:06:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 124C3838D7;
	Fri, 26 Sep 2025 18:06:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rN9FGDlE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08065835B9; Fri, 26 Sep 2025 16:54:31 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 226BD83666
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 16:54:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLLjFpIzDjVTNFuxi8tRsxs3IoniT+UmKRp881EDlpCMGJfqrZ7Ns7TS9Z0D65wia5atInkrXK+gzjR8lq98g1L7TKoL3tz0IlvPL1Hs7/VTrHJqqo+5FMKhaRHacIzB3e3+YyGAHHQdyDERm0iGVqAKr0HOZ5LYiaTEPmfCLO+RP4gi7RnIfLmQSK7rgKASsQ+lcgkQldc12YT6/s81LuagKgb8NB2i8exIFK9Wq+CTysVYNbsJtlNs8gBbJCSk39K5/Hfg6xbOXUOT9AdXz4S/pxH/dmStwwinM5PUW4IPupNXnN2skckrJxL291f9ANwLlG8/vkt+m0BRRhR5jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzaKHG9G4hzpJozPHIavExQ3sHXPacAQExYivxLoSPk=;
 b=G9sYr7jn1ZZ6RCjgTOzJLopo6swHUlw/jxxUq1AYDqYZ1hAj82DzjWkTsaVjVMf56eC4zE947SBsZrPLst00wxlfy9GWM8xUyR5Q3YinhPJidu4GYTD4yhjcJvv/fhXDehqnyk4wq3yz+tUcueDsQ5ueHgouBQhMRxqwZKHVuFnFBWwwrAnbgPWHVFQucmha2JFId+1XCRUut7hblaLLowSoZszUhnQsAzGqJwNtqgl/15Bn7RrvIVuxU/KKdcxuKI2CrOi0VVbVoK5tz6y9kvvIZVLRpZk/1PUTQHbMGaYmTrta5QygjZ+JbM1N/p2dOnsk3BCq+6TjPIWpnVCSBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzaKHG9G4hzpJozPHIavExQ3sHXPacAQExYivxLoSPk=;
 b=rN9FGDlEKZmNjnitV4HdHRUM3v7J/ngO+wgrpOhajgfdfRbAlbmPwgpsuriUKFP5/LIjU0EN4cpJQjLx0+5DbTQNPnnIOkP6sHZLILyTrGGlLp3g/t/v/CSAAAlvfirAoGQN1eFo/e0bJ3lFkrNH+IYJaBPo1X0WHWKu7ClgF/ZJlBHj6WAG5FGIQ4CU0Z1Fpvw34q4EI3JGMj6ki3xZEJSJeZdHUupKXIGxmgDPXQxqeRhJYVcd7jGR32xAXZW0mYgg89J+JUfKuFaLocjsHv+6P1Q6rb5HOjt+mrAwXH68H2HatXV/tQGFCD6jvoo35Ih7t6UlQnSwSuKtAPirkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV2PR04MB11141.eurprd04.prod.outlook.com (2603:10a6:150:27c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 14:54:27 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 14:54:27 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 27 Sep 2025 00:06:14 +0800
Subject: [PATCH 01/10] firmware: scmi: Typo fix
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250927-scmi-v1-1-5e9354fb3bff@nxp.com>
References: <20250927-scmi-v1-0-5e9354fb3bff@nxp.com>
In-Reply-To: <20250927-scmi-v1-0-5e9354fb3bff@nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SI2PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:196::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV2PR04MB11141:EE_
X-MS-Office365-Filtering-Correlation-Id: 800e39c0-0818-421e-6411-08ddfd0c96ec
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|19092799006|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M20wQ1d4cEFlRnFYOTJJem9pSnZINVd4a280WVFRaXhBTWx0V2t6M2pHTDhp?=
 =?utf-8?B?MlNBRGtIRVZYSUZrVFNqdjNIZnd5WTVSdWpyL01acVZYb0gwMEw2WWM4ZVhz?=
 =?utf-8?B?RGtneGNoTGd3YWhXZTlqSUozU29oeG5lVXVPNVNlUm1XMmxudDZMWTE1alJL?=
 =?utf-8?B?aFBwT1BSN21NeHkwL2tVeThVS0MzQ25ieDBrSEt0N1JyVUcyamxFdW55bE1q?=
 =?utf-8?B?a2ErSXlzY0puWStlc2kvNzQwY3Z5ejVpckNiNlVJMkdRRG1nMHhac1E4WFlY?=
 =?utf-8?B?NHNNU21seG1KcThEWHpZdjJGOVBmdHNJckQvY2w1d1BrNzRnMStMZDVHMVJs?=
 =?utf-8?B?alp5OGtLU3kwOVZVTkcwQzM2cHZyV2Q5eXp0NFB6dVFWbWFKNk0rSkJYRGFr?=
 =?utf-8?B?eUpwWTZRdE9SNXVhMXpQaDdRMTJoeVFJQWd5THZ2NENNTW1JbWppK2xmbnhK?=
 =?utf-8?B?Rm9pTUV4aU5sYlJkN3E2MmErQ1hiZG9nb3Y4T0MrbHhKV1QwRUlCbmNwVEo1?=
 =?utf-8?B?czlvbUtoT3A5c2Rha09MVlpQSUNCYXN2QVVGN2NPSnlTMU5qOForeTdSbWo2?=
 =?utf-8?B?ZnYyTHNiVmk3VGtpcVFobDc4VHdkTWVSeWFCU0piV2lDMUpveThEZ3Y0YTBs?=
 =?utf-8?B?RENHczE4UTFMdWtCL05LK0VHMEdOTTAyK0FRbVdldzdBd2g0WVVrbHIwNDg5?=
 =?utf-8?B?dkljcko0Y1RkM01WY0hsQlBGd3prZ3dPL29NYkYvYy85WEFwSVRlQytJVXBp?=
 =?utf-8?B?aVdTKzk5T2hnTElrMHg0aTlaMHlYSCsyN3FkY1JmYXBhV3V4alU1VzNwdDR5?=
 =?utf-8?B?K2orbi9BcFJDd0hwYTN0NXdNd2RsVkswREpiYVpneWNhMXZMQWgrajhlTFpm?=
 =?utf-8?B?S09abWZiK1l6eWRoRGo3TzlNNHdnbTJkZXF3NlRFTi92Z3BFSFNQenhtVms4?=
 =?utf-8?B?ZTVrQm94NTNxQzFXZCtTMFlGLy9iY0lNRWNiTFMxcVRoakRhWmdDbEs3MU1a?=
 =?utf-8?B?cDlqNy9DbEpYcTRramYwTG0wam5QeHlkTkFreERzRVVqNEM0UDNRc1JNRnBw?=
 =?utf-8?B?ZytGNVZwWkN2MnhSaFUxUWY2TGVxaTc4SG85WS9aSG9oNGdTYnZoZGlxQ1NY?=
 =?utf-8?B?OTdzZkxoeE5pemwwZjFGTFQ3TW9GUHcwQVJqQ1B3U0pJTkZBSUViaEFzdTRs?=
 =?utf-8?B?UlBrOEptWDk3eVNYcVRuanJmcU81STNScmMrTlFXNW9GMUh3QmxYSEc2TGJu?=
 =?utf-8?B?T0xJeDFNdUJZdm1EKzQrVGk2OGRTRmxWWTBBZ0RaWFFoL2Q0bkZSZmVvOUNM?=
 =?utf-8?B?UzhCYVV2TnR4VGN1Mm44Yi82anBJc2pzcUdEYXFwY1d6SWdHblUvcUcrak5S?=
 =?utf-8?B?UXBiNFh0SXpiSUpNSzhuRThLTFpML0lFdTFpZURsMEdzbnlsdFM2REMyRmQ2?=
 =?utf-8?B?RURtRXgrQkpuSUdrdnAzL1FMTEtQTWl3N1NPNUt1SFdsYzRzTmlQSjAzak45?=
 =?utf-8?B?RitLaEplUUZKcnFNdGpqYXlUeWJEdGlJVnFxT3lYdWdlV05tWUloMTl1ZXRC?=
 =?utf-8?B?OUgyQURVeEVQM2Jnb1dTT2lqRU8wNTV2T2FVZjY1d1NzR3E4N0pjRnZGa1lw?=
 =?utf-8?B?TlRJd1dvcGdHaXJZR2MvaHZiRzhQMVVTZnp3OGhEQkRGZ3BYQnJCN2hWMVJy?=
 =?utf-8?B?NkVXZjlId1kyMUhyUmhkMEFlRDlLaGhxcmRjTURNMG1UK1JLZVMxR3BsNXdW?=
 =?utf-8?B?eE05WGdtSUZqWjhmNDQvZ2NRQWxRRW5GL0REWkdSOXpBQXd5KzNXUU91cFBm?=
 =?utf-8?B?ay9KS3ZLWk9BL3VWSFhqRUNnclpWdVdBc0NnME9iNWl1L3RYQ1RBSWlvMlh1?=
 =?utf-8?B?WG5nSWNpY0RSQ2tqMEZjZWRGbGZ2OExvSk1NVGU3TDlUZGsrR1pSVzVjNFdO?=
 =?utf-8?B?RHRUMWdCM2t6MHNCVHZINGRtSGZvaXZhb0JjRVYrMWMyWUhDZ2hsWkV1UXR6?=
 =?utf-8?B?RzFHRWllS3dRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(19092799006)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVRyaWRuT0o4WkFiUzNBZ1Rkanl1TEI4ZUMvWGZudHQ2N21obno0SThjYjA3?=
 =?utf-8?B?M0c0ZGlsQllzTDBnN3dqb3d0Qm95T0ZaMHhpcTJndXdEc0o4cGhpS1NyeVc1?=
 =?utf-8?B?MzFsbG5TcXA1NVhmdW9kdFRJR21uUGw3WVp0MzVpQ0JkK2lSZU1tcGRoeERm?=
 =?utf-8?B?WHM0SXVoQzI3QkdEWW8rYmo1MFJUZC92SU0xV1Q3eS8rcVlUZXE1THkzNW9T?=
 =?utf-8?B?OVhyLzJzbDRiVGFNTDhEd0V6Q29iMlo5V1BqWXpHZGQ3aUVmbytqQTQ4c0FH?=
 =?utf-8?B?ZUlsOEh2OThrbTR3N0F1ZU5HWHhLZVhuVko4STVuUThWTEsrbW5VK0piRUxl?=
 =?utf-8?B?WUdDL0FyR0RTRktremIvSTFnUW1KTlJ3aHZsb3FWSTBMRUxrbEJZbEJDREdR?=
 =?utf-8?B?RzBwQzloUDVlL0w3QjR3ckVlMHlzRysrQVhZZTcvWVh1ZlNkb3EydDhiK0M1?=
 =?utf-8?B?SVdEL0E3ZllhWTNjN05CcUw0ZHg2Tnhxekk0aW5vWHg1MkVHQ0RjMEdDU3N2?=
 =?utf-8?B?VlRveFdPTlN2RWg2UjRrYis3SysvS0Y0cjdOQ1NyeUZ2U093emU3Qi9EME9I?=
 =?utf-8?B?QXhhVlloejV4WnY5bnV6QnRNcDFyQTNKNDJ0WDgyb2Y0QlI2TlUwV2lZdlBi?=
 =?utf-8?B?Z0FUdzdOZTVyd2NxQUpuYkZmUmdaNjhSWUwrMkJqZEZQTjlEUHY4U3FmaG9r?=
 =?utf-8?B?NThRcktodnBVMU5wNnhWblJRZnpwU1Q3bC9sY2tDZlFXbTFGcW5PaEY4V2lu?=
 =?utf-8?B?RDZRcVRGV0luNWoramY4ODIvaDEwVmpRT2RxcXh4RFk5S2pBdnFkcktXZml5?=
 =?utf-8?B?N1Y0UzBrVDJVcmJsRkJoOUFsVzByOXdnbzhoeGdFZzl5SzRBOXJtS0I1QjQr?=
 =?utf-8?B?amdHQVRwZjJ6VVNEbVpVYUQ3NFhKZUFpQ043NG9vUHoyT0RVQlovMjJ1OGlZ?=
 =?utf-8?B?NURwUy8yUkhPVGxFMUpMVS9YS1AxVi8vL2wvWkFGMTlIZ3NQU1MwMjVLMzgx?=
 =?utf-8?B?UkF0czFZdU5EVlZjRmk2MXFHOEVkQWpNeWR2UWVCbVVOVXArVXBDVGd2VEx1?=
 =?utf-8?B?MWN4bGJaMUFFT0FNOENHSDA3cTI0VFdDdVlDeG1qSnF6KzlyOVhJejYzV1pO?=
 =?utf-8?B?OHUzS2RLdFpLYnRUNVlBc096eE5DTmoxdndOUjJPQndyU1BicDREelFvbi9H?=
 =?utf-8?B?UWgwRzFjbmRUWHlqSng4RkNUS3p3N1Rkb1lBdkVHbDZNSUljRVIyeDRPY3RG?=
 =?utf-8?B?Q2VyNEJPdGphdmR5eGRrbVJiVGpnRnpXdng3bFQ4anRqQUR6YlFmTC9BNTlo?=
 =?utf-8?B?eFRqQ0VQUGMvaitwVlc5MGNFSzdwT05ra0V3QzlEbHRiWTlXYW5VQWxsa1Bp?=
 =?utf-8?B?azFTRmVCNFJNU01LZTlYbnBjMVNrc1BaSmp1dndBYit4Q0ltcnVUSVJxNkZY?=
 =?utf-8?B?UEVnV1E0QjBIMlI5T0twL3gxMm9sYWwrcEdGOGU2SG1DWEt2eEZ5WVp0aUw1?=
 =?utf-8?B?bG1vcWs0UnFKZGtDY3ZYWjJEeDl4SlNpZlA1YmErOXlaYXE1d0k0U3Izd21l?=
 =?utf-8?B?NGk4eHJqWFp2ckRpR3VRQkEyZk9VYTJIT3pXRWMraVp6dDNXUlB5M0hPYS9D?=
 =?utf-8?B?dFpUejZCdG1ocFp1UU1uRmJnazhOdThybVl1SXQ5a1hvTlZOeGlScHl3TTMy?=
 =?utf-8?B?OUZoUjdwSExZUG8zVE8wQUtyT2g3V0VzdVBSUm8yZXRxK3Q4bUN5WG1OQmFj?=
 =?utf-8?B?ZzJJYmcyQWRyeFNEVlYrZzc2ZE9qMFZyRDZCT1NwTGpTWWJJc2tUaWVFNEI4?=
 =?utf-8?B?bU1jaEdiWUFqK2RRRDJJMVRwbmJaeXhPN0pWazhYWTFFVFovSXI3MDJPcG9Q?=
 =?utf-8?B?Q2lRNm5Bclp3RGdvc2J1Q1dReHV2WW01bWFIU0NqSUVrZStvRDhRRU5tSVNY?=
 =?utf-8?B?ekMvY05JdUVMclk4N2F6WlNyenByeTNwT1EyemQ4UWJXWHVqem9OZ3FiOTJ1?=
 =?utf-8?B?eVpFWktwaGhaVVZJSXNwL0FMRXAvcTZXM1hYSGZFV3NWRytPdk5jYlRWMzQ1?=
 =?utf-8?B?aWtyVVNMUXVicUV6a1cyR1c3QmZ0d2ZUWW1NZk44dmloeVZJNWRKWjZERG84?=
 =?utf-8?Q?rDH34gEUzaYyxlF8q0GeqzwSr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 800e39c0-0818-421e-6411-08ddfd0c96ec
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 14:54:27.1781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C7r8iQIM6qa9BjfFlyF8p9qOlIxP5nAvU23F+b/CHlKZuW2qUERAwxk2j9KYiZ3jigUXPtkTYZWbHNw/Go7alQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11141
X-Mailman-Approved-At: Fri, 26 Sep 2025 18:06:25 +0200
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

Typo: 'to' -> 'too'

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/scmi/smt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/scmi/smt.c b/drivers/firmware/scmi/smt.c
index 3253f4211d624c8a1d35e803636189d20830f8ed..a7721bbe54ee286fe88dabb7e015944feaea2843 100644
--- a/drivers/firmware/scmi/smt.c
+++ b/drivers/firmware/scmi/smt.c
@@ -129,7 +129,7 @@ int scmi_read_resp_from_smt(struct udevice *dev, struct scmi_smt *smt,
 	}
 
 	if (hdr->length > msg->out_msg_sz + sizeof(hdr->msg_header)) {
-		dev_err(dev, "Buffer to small\n");
+		dev_err(dev, "Buffer too small\n");
 		return -ETOOSMALL;
 	}
 
@@ -191,7 +191,7 @@ int scmi_msg_from_smt_msg(struct udevice *dev, struct scmi_smt *smt,
 	struct scmi_smt_msg_header *hdr = (void *)smt->buf;
 
 	if (buf_size > msg->out_msg_sz + sizeof(hdr->msg_header)) {
-		dev_err(dev, "Buffer to small\n");
+		dev_err(dev, "Buffer too small\n");
 		return -ETOOSMALL;
 	}
 

-- 
2.35.3

