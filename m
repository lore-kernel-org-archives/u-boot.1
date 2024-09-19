Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069C3CDD56E
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 02:58:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21C0188F4D;
	Thu, 19 Sep 2024 04:58:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="R2BiFhvw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7422788DB6; Thu, 19 Sep 2024 04:58:09 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::603])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9461288ECE
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 04:58:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ejQtgMLvM9xcojl+wAu5uJQ9yvalaMy4fPFrrZV1QbT8rgEnoPGY4iOeZQrGV7s0W2eY25bNIIpwqu6cSzjeeD8jYrPutWO/+a5Li8xQUGJAZYYBYbUAll9UHGsZE94bRThOX8RSv7BsjsUO4SbGCf21clhJANn8/GtP3g6C1G3yNp2OE+xD3VP6QOG89rdXw0XlUr9JwYEspzZUxWgnHDeMucZY6k0RRCI9Y6DwWpyB0TxO6DqACDcEHeV7UoqjadhN499ce8upWwYxUyJZj3aRf2cqpKfqBobbMhtFvG167AnC8RTjthd/mTKseWR+7A6EgUGjo5H+he/Zg8oq7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1d0zOEJRc0LQB82b5PzaEcnVgqL8Kcr+qjPDFLlOInI=;
 b=io5pdnpIlQwQmsA2PHi2Xjja6Mz6USlMS1AqY6fG1XCiA0TnkygeMrLlFhsVE89kRz2myFxr6KFeN26M8uNtLhNkhoBIX2YmXpOM+RiacSk+AnJhqSxUHdaqRzhkQvroqSQNvdwojmJ/STdnrSeualTRJ7c9zXgU+dS/EVXOcRIGpbbsfnWwW0Wh6ZVfDMd3LYdCR0NpDbdp2tb4fse1FauvcFQOELKHy30ZdCMNP5KCXrXG4jzQgXqyRExJAWqa7PG2pjEQr/CnV2Af44aFHPnHxOMG5m55MS8v2v/Yj9X4uyAuGEjWB8yK3gUCd/5Wceq1Y1NHwyEQwNTrMDBufA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1d0zOEJRc0LQB82b5PzaEcnVgqL8Kcr+qjPDFLlOInI=;
 b=R2BiFhvwDZCLSwlrWKJjpXjpqUH7aNUHKqeGR6PQkdb1gMvHAQpJCHfsls8zwFA8unyEGXcWLW8OblpapoEIGBp7gs5dAU4zky/m8trewtAn6r15RIiZCkIXlAI+51pAOMCVp4P5I1b9R3f/95K8HfgURF5fGLG6NKBNZ7mA/lomszplOAAl7iQtXtRvQXkmHMvtCcj1/oS/EAPnCz8u0bdRXknuV5R+4UkM7McS/LOjwh2KUzQa1pZdOMKzJsw7/5IHuaiBJHJAuftVi3CoJNcvATreZC8nsirNkJHghpor3Tlhsi5buB96U2zHMmAja2HSSH9WrYzL8HpWLGiCNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9986.eurprd04.prod.outlook.com (2603:10a6:102:380::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 02:58:05 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 02:58:05 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 19 Sep 2024 12:01:20 +0800
Subject: [PATCH v3 02/21] imx9: soc: Configure TRDC for M33 TCM access
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-imx9-update-v3-2-80f9786cd1f0@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1621d737-a96d-4b8d-35c6-08dcd856e260
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFJLb2ZqYXRxak54Wm5GRTh2WE8raVA2NGZkbVduWXE0aFV1Y21rT2paYit0?=
 =?utf-8?B?VHM4cmpOZUNydmVWdnZJRWkyNHZMZVRLRk5iS09nd2RUamdWNjdpWTZaNFl0?=
 =?utf-8?B?MDhnODJQbHA1SHRlZTV5ZFlNaHhZZG8vc2ZNL3dxVFpyeFBlWEFOQ1BYbjVJ?=
 =?utf-8?B?MnlUN0NxSG84U0p5cTcwZ1JCblZXTGM0YkcyREx0Nkc4cTk1SU9qRjhhT2cv?=
 =?utf-8?B?VTY0ZzdXdUdiaEJUUk1YR1BXa3A2ZUNtMXJ3d29pK0QreEtERFM4eHFoaHJX?=
 =?utf-8?B?enFqb0Z6dks5dEs4NWJ3TUJ1b0NFcUQ1anNCVm5lMlhVS0xKcHE2RjV0V3Fw?=
 =?utf-8?B?WWxvMXIxUHhOTWJrOEtaYzFrL2kyTEJ2TkRRMmx2RmVnSzJTZ3ZwVnVRME1Y?=
 =?utf-8?B?cFM0VzAra01LejdHbVFmczdqT29uM1VSN0ZrL012SU5xeUFkNm40VUdRRUhL?=
 =?utf-8?B?eEJ5eVU0ZHkwQVU2R2ZDaGVRc0ZNTzlVU0dYWk1rMGJwZWZ2a2dIQmJ6Z0JW?=
 =?utf-8?B?ODlBYzhnS3RxREkxazVZR2dnUXJ0M3psTC80blhBQnU1MUhqclVxYkZQS2Vy?=
 =?utf-8?B?SmgvR3RpbEJJWWdrM0srL1h5UWdvOVV0STRRUHNRajdTNmVtSDJSQ2g1Situ?=
 =?utf-8?B?RE0vZmRGMXdNWFNmQXlKUlpaVFNxU1hkdTR3ME40TEcxNlVyUmlObFVmYStF?=
 =?utf-8?B?WTNyd3FCNlhMMHJ2NzBPV0R5cUxrc0hqVWZJc1d1V0RZOTFaK3BPSzZwdXl2?=
 =?utf-8?B?Qks1a256bWdOMmJFWHFKUEw1TVp3d1JKNS94SWN5NGV3VE1sWmlxUjZldEFQ?=
 =?utf-8?B?a0NNNUZTZFo4VzkrQkNBRDJTTExacG1kdFZ6enR0TlJlQUpqdHUvSC9RQWZR?=
 =?utf-8?B?Z2VQaFF4Yko1cVA1MFZrK0xQRWliRytTNkVWODRGYXBRTGlENnVFaGFnRno1?=
 =?utf-8?B?Y0srSjl2bnNTZFVuRmZxL0JIY1pqWk5oTmRhaGJXQXBzYzZnM05RcFMyaGsy?=
 =?utf-8?B?TEdkTnVHU2hZSURiQmRVaVlZTUgzenRYV0djTWNEUDUzZ0FDNDM1d0YwaTFi?=
 =?utf-8?B?OUpMdThKK0crM3BIWUlYNkl5ZXg1RFhsL3QwalJVRGdjOFlXSTl0RE9pZk9L?=
 =?utf-8?B?QXdHYm5mQWFLeGxWc2ZJdHQ5MlkyaHhBQVBHZ3dLdU9kTnA0WmhKWGo2WG9y?=
 =?utf-8?B?K1Bjd0llT0dsNkhJdHVZRWFuWUFvTDlVcGU5dG4weGZWODZDdkZsbmRSbit5?=
 =?utf-8?B?bnVQSVIrQzhraG5DTnJLN3QzUkcvNmRPbTl6ZGRjZnNDL1o5aTYzSllhTUFE?=
 =?utf-8?B?T2dHYzhIclBFdEhnR0JSWnZ3WVNST3JWUEc4bGRvYVFwQ0VMYUtaWm1yTzE0?=
 =?utf-8?B?U0Z4SlFsTU8rUTNvdktWaDB3SHQ4RGJRMUNCOTRsRFBCTlR4dGFSSHBhL1B6?=
 =?utf-8?B?MU5VMEhKcm9GT2piN2RoeHZDalUyQVF2aHJ6ZStWTysxMlBwWlFmWEZVSVB5?=
 =?utf-8?B?TWxRbVlZTlpuU3k2YjJYdDNtMUw5MW9odXVWYk0wM04zUmhDZjI3cWNNUy9i?=
 =?utf-8?B?M1lvWFc4YVB6ZWx3SFNTb3h6K0lYZkVLTjdxU04xNlFoc1pKVnBNOS9kVWli?=
 =?utf-8?B?NW1zSGo1SnYxeUtRZit3NUdpU2VtRzFKMnIzeUNEaE9XMDVIUWFaWnNGcWpK?=
 =?utf-8?B?eUNBMzd2Z3hEK1FXVnE4QUltOEpqNUJBMDlXVlB3MnE1ckNIOGliLzBzemVP?=
 =?utf-8?B?YTlsZEZjaVdYZ3dkMERTSVRVc0MwTTQyd0ljRXI1eFNSeWFqZEdFc2lGK1pM?=
 =?utf-8?B?YkFpcmpUY2hjQkJJWGttbjZEMkxUK3NVQ0FzNVVpeVBNL3hBazhQd3hDVGRT?=
 =?utf-8?B?Qk8xcEFJMTZ5YTg2VWVIVFJiYkwwdU9yWmV2R2FHY2ZCWGc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDZVWnY3U0pHZ3ZlaEdhWE9EalVLaEJSd3RXZDNMZVJHLzBCQkJxcm9ONWc3?=
 =?utf-8?B?a0d6dnZlK1lrYVhVYmgrd1I3cGVPd29PU01PcFdGbk9ZY3J6OUdZb3h3dTNI?=
 =?utf-8?B?d2Yzc2ZwNkJVMVJIazZ5UEw3cVdiY3ExK1h4UytoK3FtL21vTHQvTDFSWnVn?=
 =?utf-8?B?NTNCK2xmM0ZEc3UrZzBVdVo4eUZuMWFGOFFjYkNZTTZnNGQ1MCtoQmhKYTZq?=
 =?utf-8?B?ekp0Z0Y4RnphMWN0YXJjTy9lQStnYjBIMUcyNlpnMmRrc01CTk9hak9FNXVH?=
 =?utf-8?B?bU9vVFlXYmNwUXBsVC83dU1EcElLbkdOenRVaFF2Sm92QnVtRy96TmtLcnNO?=
 =?utf-8?B?Ykp4R1NFRGp6U3VZMlVBT25YeGVsRWF4T0pCbGxaOWxwZlNldVI2UTNXaHVJ?=
 =?utf-8?B?dTNzTU1hQnNvZUYrbmFycGdOZHVIUUIyUnlNR2h1dm52NVRoZHdoOFdsS1hC?=
 =?utf-8?B?ekx1bERDdzM3WjhwWTZ3NXIwQnc4eElBK3NtRjdvMVZDY3E2NFVYMkZaWFJp?=
 =?utf-8?B?Y3hGZmJmSDltUmRXZTNFNXc4aGtyeUd6bEpOWlRzNDU1ak9raHFONDdxalJB?=
 =?utf-8?B?NHQzU1gxM1djOTdyTnhoV0lnR3pYaVpZd3crS1lQWEdNdUI4MjlDWHNtK3cy?=
 =?utf-8?B?bHZzcDVaNVZTMVRSNVhZdXA1QjBYeGhTY3Z5azhDRVVvMW5RNE1RMThseU11?=
 =?utf-8?B?Mm1WMlo1LzNDTFNldGlhV1dkZ2w1anpVamFXTHJTdHNNRWo0WncwaEdnbnJ3?=
 =?utf-8?B?ajl0Y0tqdEJEZU5GMjJiOXlhSm1mRngzK0dMWUsxVEt2ckRSNldjQlJqNVh4?=
 =?utf-8?B?ZnRiNTBMZUc4a2J2UG9oSWpZMkh4Ym1FeXEwWDlGc3hpS3VtOWsrTTltcU10?=
 =?utf-8?B?R1BxdlJjMEU5OS9rdGFNWTZmdGE5eTNpSFpXM3k0SUVmOVhqNUNKUHZ3ajdR?=
 =?utf-8?B?bnpMeWc0K041UXQzSEluNzdKLzZZSkpyMVlmc1NieGsxOGhLY1ZGMEJHTXpu?=
 =?utf-8?B?WDhNQmtPT3M4OEVTUW9xbG81VnV5R2pLT0JYTjBhdXJXZ1lpNkRrWnA3Qitm?=
 =?utf-8?B?V0FqamlpQlhJV3lIdVhNSXJxYUxlYjRENm9VYWY4VnNRZ0VObHViOGFiK0ht?=
 =?utf-8?B?SURFSGxwR3pIR3lOM3JLRW11cDAyMmdOREkzRmgzZHcrTjNLM1VwUVdBVGtt?=
 =?utf-8?B?Rm5hZVBlTVljWTJhV3JWbldVVGVnWUlsOVhlODk4YitVRThNQ21STUpXaC9v?=
 =?utf-8?B?SkozOEpzZ0U3UUhVSk5XVnBONENQWnlSZnVwVS92WUprK3VRbzFvVEIycUVp?=
 =?utf-8?B?ZVNKQmxPeDVCdURpTE5lV0FGZjFaM3NnTmUva0Q5ZmVCeWRiMnBEd1A4NDBL?=
 =?utf-8?B?bmdEYkwyWmhsUzVFZEFwU1JOUWRtY3ZSTWl1NHRPVExHUW5oZ3V4NldaOVFx?=
 =?utf-8?B?Y3dVL1NUTGNzWnB6RGhoeUxYazlWbVBobStoVzZ6SENEUzRLMUZmRks3a3Mz?=
 =?utf-8?B?TVRGZXF2eHAzRE1Ld2xOUjhZb2JuQURSa1VZamx0V0xTRzN5TFlYUFV3bW9J?=
 =?utf-8?B?OVl1MTV5OTFwK3F2ZzJJZkJRM0UrVkdRVktrMTU2ZFEvbDY2SlBmVGRWd2Er?=
 =?utf-8?B?enAwT0gwcWJJcFBWdjZGelFoeGJtR1FtSjFzQXpITmxaU0xoWTZxT1JzV0RE?=
 =?utf-8?B?MnVaQ3hMTTB5M0luTEpKRFhESEgzV2N1RUxFcUJkemF1N1FWSHdOeldQYTA5?=
 =?utf-8?B?cUVHcy9XeUpMSXV4TU0yK1VSUkZ3WnVaUlJja0RyVlNDYW9IRExab0dQRld0?=
 =?utf-8?B?NHFWdmsvWnpxL3ozdFhPaG9vNnNiMVlYQisveWlzanlpN3QwRnZERjdsWEVV?=
 =?utf-8?B?Sit0YTl6L2F1T3kreHVTRUlhZGlCL0FMb0RSV2wycU5BRjFGUEsxVkJybmFs?=
 =?utf-8?B?bkV4VUgvNEpwelc4L1hseFhTaDVXdEF2VXgzMWdOSlErUmtLOW9Yd3kwN1NS?=
 =?utf-8?B?Y0M1bEVDU25XcWNUNzhlV3J6bXVXUzFUYitwRVkvVnBDQm1qQW1PR1pmc1lo?=
 =?utf-8?B?T2NqT0dMRlQ1dEdPVmc1NEN5YkpLZFpiaUVzM1ZzcWlPRXNyR2FxMGxSdnBN?=
 =?utf-8?Q?K+tydloSXCCouwectx3zHGn2f?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1621d737-a96d-4b8d-35c6-08dcd856e260
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 02:58:05.7564 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pevdG4e2fvRzrlMgJJBPqjVXSvPcmYmS+ezbDBMsaxp6W9E0XBWO/4YdgZjen9odUfkKfSiTN4dW7bT75bZ5LQ==
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

On OSCCA part, M33 TCM is used for ROM PATCH and protected by ELE ROM.
So after release TRDC, we need to configure TRDC for M33 TCM,
otherwise A55 can't access the TCM.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/include/asm/arch-imx9/imx-regs.h |  1 +
 arch/arm/mach-imx/imx9/soc.c              | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-imx9/imx-regs.h b/arch/arm/include/asm/arch-imx9/imx-regs.h
index 9953c33b73b..fb6de533d12 100644
--- a/arch/arm/include/asm/arch-imx9/imx-regs.h
+++ b/arch/arm/include/asm/arch-imx9/imx-regs.h
@@ -25,6 +25,7 @@
 #define ANATOP_BASE_ADDR    0x44480000UL
 
 #define BLK_CTRL_WAKEUPMIX_BASE_ADDR 0x42420000
+#define BLK_CTRL_NS_ANOMIX_BASE_ADDR  0x44210000
 #define BLK_CTRL_S_ANOMIX_BASE_ADDR  0x444f0000
 
 #define SRC_IPS_BASE_ADDR	(0x44460000)
diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 3ee2f3d881f..06032f2ff59 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -792,7 +792,7 @@ int m33_prepare(void)
 		(struct src_general_regs *)(ulong)SRC_GLOBAL_RBASE;
 	struct blk_ctrl_s_aonmix_regs *s_regs =
 			(struct blk_ctrl_s_aonmix_regs *)BLK_CTRL_S_ANOMIX_BASE_ADDR;
-	u32 val;
+	u32 val, i;
 
 	if (m33_is_rom_kicked())
 		return -EPERM;
@@ -817,6 +817,18 @@ int m33_prepare(void)
 	/* Set ELE LP handshake for M33 reset */
 	setbits_le32(&s_regs->lp_handshake[0], BIT(6));
 
+	/* OSCCA enabled, reconfigure TRDC for TCM access, otherwise ECC init will raise error */
+	val = readl(BLK_CTRL_NS_ANOMIX_BASE_ADDR + 0x28);
+	if (val & BIT(0)) {
+		trdc_mbc_set_control(0x44270000, 1, 0, 0x6600);
+
+		for (i = 0; i < 32; i++)
+			trdc_mbc_blk_config(0x44270000, 1, 3, 0, i, true, 0);
+
+		for (i = 0; i < 32; i++)
+			trdc_mbc_blk_config(0x44270000, 1, 3, 1, i, true, 0);
+	}
+
 	/* Clear M33 TCM for ECC */
 	memset((void *)(ulong)0x201e0000, 0, 0x40000);
 

-- 
2.35.3

