Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D229CAC5B8
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 16:07:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C209C838C2;
	Fri, 26 Sep 2025 18:06:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="id2hdP8/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6136B835B9; Fri, 26 Sep 2025 16:54:44 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D72D83666
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 16:54:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BItEO0TI/Qg9SVbzLF9dZk4qW4l0bGIBZe8BSshrLAMi1+7/yorWtbvXA/lFJsG3F5/NnjOfjYopkU4ZLs/HCpE4VfdZw2eUHPlo2w9G4shUp3yMo4FI082PlviVH4GYh9TDvRghCa/YLAbSc5SWOqCN7W51xB7zYqgHzvHir00g/YkxuxFgPGB4Pj3EsqF61mKP4lW2X1FeH/sg2yVu4cQfh4rXuzb78PoZeTXNDZIadAXMR5jzHdrvs/kSsJbvR9EiI+VET2Dz1QFGTvpXPdkVhWi4K4gbEvaW4FrCr0H9wtyXkXiYDJ+fmoPQYYpZnz1yAHpGqNe9oFqSNaraag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQAhGzzCAeM5568ZS0Ry51u231zppxmlGaGkFqlLGxE=;
 b=Ff+XxDtYYT1/5emOdHO3Ew0UraZabY5Ri+G/MtyJyHurpu0tV5oO0RbWD/Y8m/zVK9U/5sg1e1QX9g302u92Xit+R8mxCCar4zkGt3NvCp8cq9ipAsV+buQdlvgyJ2sAJJbnBJfovjFnk5dsWZeb+UlR7VOUWWBcT2gyC3C9QwQPV6IG2HXUkh3wlxE41qkFZfAlGp6aM2oW19IcUJ9Up1xvsdFcSZL43/VbvS5fxm8eSuSbRyLzCcv98u1FQGuWe3TiaST9EYtVav4QKDn7eXV8XyJ0ryEuB2m9CJHOEYj7mYeNuFYsaajJO3fOkFZBgp6BZgRe4zTSW3xENa9HQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQAhGzzCAeM5568ZS0Ry51u231zppxmlGaGkFqlLGxE=;
 b=id2hdP8/jb9m9YqsNE5WAueaSoaschtLt7SOY/N2U0n+Vn8cEO8R/PF9jZMEc4nBUuN+cFV6HsnzoB3vXJ81yP+lCdofrEzVmxQl+B9og4McoPKUVI5n3h8zC/KPdUmVFO9U9118yt620iHwtWfe0mgaqaHUa/KJ/8Yo8/zs8D62kJeOFuQ/Wopm07HRvHP+zM3C3F0qh+MkS4rALMtOVyaClCH3ZnGDXDUJ6QjF4Y2jTuHy0KoiDNLLHkE3QjhLL2vlndR77JEYEedFWhNDXvP7EKy0m3mcfJXPNb2R0xrB+96ksjdftkQmEOz4s8fT3GiGVfsgVL9vWoWTPLy5sQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV2PR04MB11141.eurprd04.prod.outlook.com (2603:10a6:150:27c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 14:54:40 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 14:54:40 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 27 Sep 2025 00:06:19 +0800
Subject: [PATCH 06/10] firmware: scmi: mailbox: Update timeout to 30ms
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250927-scmi-v1-6-5e9354fb3bff@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: e7822c22-b10d-4b3e-9f93-08ddfd0c9db9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|19092799006|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bFN2eVdSYjA3NjFLN2ZDMVR2cWVhYVc1dFhaRGdGL2c0ekdsT2k4OUZ4c2tN?=
 =?utf-8?B?dmlEVG42YkE1eWZmbnhLbzFvNzdwVDJPZFAvdGpsQUhIc1RaWmYzaU1TcVMy?=
 =?utf-8?B?aG93aVpGa2g1TUFOaStGR3pUVi9iYlRXRDRTcTgrSmhoY200elJDc01xUy8x?=
 =?utf-8?B?YXdOTlJHekptSmw1UVNvVGlSQVV4c2ZZVkp4U216eFZkamJmb3ROeFI4dXM1?=
 =?utf-8?B?aWJrL0VXaWxuejlVamx5b1daemlwUG9EQjNtYVVOMDB6RHdFMGpFRE9CaENL?=
 =?utf-8?B?cVV5aVN5ekEycTEvS2l5YkJubXViSmd3N3hydkUrUzEzSHZ4NHJPeG9VendP?=
 =?utf-8?B?ZmdCS1AraDFsaG4ycjFvMG9IcmJ1QThiQThPTkZ1VWVoRzBCdVF1aEpxa3Ir?=
 =?utf-8?B?Q3V1Y0o3RWNKRGhJakdmd2FpUHB5Wk81UjhVZnZ4UGdTd0FHWW1FeldCL2hF?=
 =?utf-8?B?TmZ5bXVvM0RiNEdVUSszOVhMWG9JREhRZmV5SEFibmdHSjEyWE04c2ZLRHpv?=
 =?utf-8?B?YUpBeTVGeXdGaElUSXlNNWM3TVZPaExXZUw1eSt2aUI1NTJGWk80QWk4Witu?=
 =?utf-8?B?V0YwTVBxbThPSTJ4ODdWV1A5b1BkSU5JREV1NzRNUWczV0dlVWFnanIwUmly?=
 =?utf-8?B?Mll0KzlIMENKMTRFdTBDNnFGZ2JuY29CS2hNTGtkdThzcTFVL0txd3VicmxG?=
 =?utf-8?B?M2JUNis4Z2NRSnAzbHRaaGRPdG1melhVLzc2czIwc2tIRHhsUEtyVFZoV3Nt?=
 =?utf-8?B?OUJoYlBQa3dVV1BMb2ZuTlhnbVVrN1BOS0pUWE01ajlmdmhYbmFKOW1wSEE0?=
 =?utf-8?B?cVFrM3lXdE9kaE1PVGlOT3hzZkxublFqMW9VbjY5cXZMLzFVTGdhNXFrRjZU?=
 =?utf-8?B?TFMvN00xb2NwT2NIRElvZjByUHRIeVV0N2RjVGtHekxDR3VEVmE0eDNHVXh1?=
 =?utf-8?B?UFJEaCtpdjVSOGNvK05PdWFpQ09qajZvUWM0MmplU2ZpMlhrVVl1cDNKZy9p?=
 =?utf-8?B?YjJWM2pFbnQycHRod01lellzVm5uK3lSN3Fhd1ZOWktqQW1INnlmVlg1NzQy?=
 =?utf-8?B?d1ZHY3l1cXlsYzU4UnRBRmxJR3g5MjRVMkNYc1pya0FtcncwQWVTVVZUa1Qr?=
 =?utf-8?B?MGVwTHlNQXoxYnRGNXN6WHF4OTdaL0d0YlRleXU1NzhYV05QOHN2TU51aTlv?=
 =?utf-8?B?Z2RFRkkyUllqOCtpM255UGxXN3VRU2VzSWhkeFpiVGlObVdhV1JUL0ZzdDlE?=
 =?utf-8?B?Q2VyMmRieE5NNitqb1dhVW9WMEovZ053amZpMHJMdDJ1RThFd0NPeE1aQ2xM?=
 =?utf-8?B?TGxyNURVYW56b2RYMHRpZ2lmVHR6ajFoSzRERm5yUE1WMUlzT3l4UDAvcWcz?=
 =?utf-8?B?L0V5VkdSeWxrU1IzUUJKWXZhUjhkUVVocUkrTTJSdmRObkljRVFvN3ZSS0oy?=
 =?utf-8?B?WTFacDRLS0REK043aXVOSjVoelB5UWxDUXlJZjhCNjFLSWRUK2pPYjEzeXdX?=
 =?utf-8?B?Z3RYaHlyNVJGUkJPTnpXRXhXWFE1MG5NU3NlVFgvRGVkeXJENlRnTDB3dDFZ?=
 =?utf-8?B?SDBMZXJFRWFTcmx2Q1NxZmh2SVh1bUNwc1pONXBLM3Y0SVVPMmFqc0FQUkJh?=
 =?utf-8?B?RXlnc1VmMFhDTnJBdjh6dmNGUVppWnZVN0NtVDJwRmNLZEdSWDJyY3FhQ0Vj?=
 =?utf-8?B?WHJsZUtrRWprRXlKdXlFdVVnMTRFSnd2RWp2dGZIeDh6MXFZZU1Va3JGby9S?=
 =?utf-8?B?QWZ4cVhyRDNEMW5hRFhFdWEwYnh2UGFoOHRTWHRqQWtPVUdZeWQra1k5TFpR?=
 =?utf-8?B?VHJpYk0rU0pBYWFzZlFJWTdxU1ViQThhajRNS0dhUkZTOU1PbkgzajlqREpE?=
 =?utf-8?B?bUNDTFhBeWplNlh2cks0WUcvU2ovdnpQNHBURU50aE12RUcrSTlJNWI3NVZw?=
 =?utf-8?B?UVdRb0lSSnZENEJMSzIxcFFTOHVJYkRLR25NbEdvWThEYy9HMFhWZWpONDhp?=
 =?utf-8?B?bUlrZmllVktBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(19092799006)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UCtpZGdsUXBSNGRaTnkya2IvM1BadVcxT1VOQVVldFZXYUxDdGxidkNLS2JQ?=
 =?utf-8?B?eVBjNDgvN3FUcmwyci9LYU44Zk5WR3BlMWhIaXBxbm1DU2RZMW4yYkpCUHZs?=
 =?utf-8?B?bG4zZzRYRTJTeVRvTHh4OWJVNlVBcHlkcHVaUTVhNGM0MFF6d0xpSU84aWVC?=
 =?utf-8?B?WE51NHhUaGlSL2VIdHBaRTNIL3ovOFZodDc4d2FaRUhYN0tlZW0vUjJpVG8y?=
 =?utf-8?B?bjRVbE8wVFNPeVloUnNZdFF6U0JrZnlyUVFXRjlFOHQ3eDY4Z2hhMVVyMllL?=
 =?utf-8?B?QmIwNDRnbGxHeDJDb21tRFdxRE1DR05HT2FsblFpQWt5R0NIV1Q5US95cnk0?=
 =?utf-8?B?STJURTBrWU5DQlYrb2VOSTYzL3JsMExJWDMrODZNVml0eTAvMHdOR1V4MzFR?=
 =?utf-8?B?MXk0ZjBmQXdBRTREbjg1blBlMHRnd1p4ZUlhTmhQVHpUY09VVzQvQ045cDk2?=
 =?utf-8?B?eVZsNVB1dEtncHVKMndLRmVtejlGTUhXWEVQNWFzY0tjSk9CaXJsU21QWFNn?=
 =?utf-8?B?WEwybHlXWkZqTGtIVk53SldTRG0rUnlMWVZtMzRWcjkyYkI3MnVyN3dtV01y?=
 =?utf-8?B?ay8xSHpBVk1vVVhBZWhjMlpaRUNCZzZSMVZLTjArcEFiZVB6VEZvb3R5OTdU?=
 =?utf-8?B?UkZXQWpGRG5OSjR4WnF2OE5GMUs5bFNVYis3R0hJQWxEcVZqR1Z4d041UW90?=
 =?utf-8?B?ME9UZEVyQVFtUlhMUDBCZVBUQXM0NzZYOERGQlplcFcxU2tCbng4U3lmS1Js?=
 =?utf-8?B?b0NUOVRpc1FDYlZUcHFDZGJhU3pPRTBJS2JHclk4Znd3aEU5eFJ5cGJ4YzJl?=
 =?utf-8?B?TXpTSnVXRVBJMTg3ZG1Mc2ZDdUJWamwvNGtEMHNYdWdiTTFQR1BKSUNBQUJF?=
 =?utf-8?B?bS92SWwzQWZnbXpnb09NNG5RQjIxeUZvSXdYN0huSXR1OHZMejRBdkxSWC9K?=
 =?utf-8?B?Z3N4QndBRDFMQm9wQVlIc2FRNjBYM21zRGJlVjdqaHhUSHMrdjFNNDlOdHlx?=
 =?utf-8?B?MU0vRXVYenlqdy90ZG01VjdCLzBTWm1Rb3NUU2NwNlpkQk9HbU4yYXJCSENp?=
 =?utf-8?B?QTdkWTlSZXZvVFFGRTQyMW5Yd3JQNWE2Z2pGWjBZOU5KMjl1RWxtbWM1Ykxr?=
 =?utf-8?B?TTZpckpUYzhWVXg5L3JHQWYxTG80WDNqVVNtMDk4VEFkR0tDK2pPYll3dnVq?=
 =?utf-8?B?RmZ0dkYrTmRDYk91d25VWUhUQUxjVEtMK2o4YkpFemptWDRCVzRMZ1kwdUZ6?=
 =?utf-8?B?VytLTGh4NHovQVFuNVdNS1FDS1pLaW9EMnZqK0tyY2hKcDhPd0Rmem8rVWhp?=
 =?utf-8?B?K1FFNzR6eW5BbERGSzJrWm9ibmNUTjhSb0Q4OTFXcVRoWjNTM21GQWdIVFYr?=
 =?utf-8?B?UXpadGh1QWhXSExlOXhydWpTRUR6QlJNcVU5VG9MOGxlNEFIeFRMeGV0MjBY?=
 =?utf-8?B?RWhaVjhia3lhMkNDYUgxanRuZVVyeHRxSGRMdC9RUzFrNXlnVWt5RTMyKzFu?=
 =?utf-8?B?VnhnVzlkQkQwRnRTaW9MQ3ZmQTVYM3dZeEVHRHFLaG5YQnduVFg4em8zTVdJ?=
 =?utf-8?B?ZGRYeGVFbUtRU3NhZ2s2SkJYUTEveUQ1YXF5NHVRMkZFRjFXRlpwRHJQOHFu?=
 =?utf-8?B?Z25UZ09NS0lRUDNpVkEwTEdDekdONjNBVjl2azN1QTNFdVJOejlFOE5EY0dn?=
 =?utf-8?B?Rk42UlRkbXpZd1ZheHFxNVoxb0t6emM3anBNTTBHUzhYT2xFb3BvbmQzKzFk?=
 =?utf-8?B?b0x2QUxEZEhUSTkxNnZwUFVrSDdYQnRXOW1MWk5uOFkvUU05TnhXYjZ5SWxk?=
 =?utf-8?B?eFM5TjlPTVhwREVVRXhqNkRXaDNxWGtrMjB1Ym82OFo0YlZFdnVrckRvc0FS?=
 =?utf-8?B?allMUFpyZElrd1oyeVFIVnFNcU9FRHRIVE1qb1B3V0ZTUTFMc3pXVkV3cmRK?=
 =?utf-8?B?UkZvODJuMDJtaldKbkJ6RlVtaFZSVHdXMUVQYkJSUTVFcWVjVk5HWVJEOW5L?=
 =?utf-8?B?SWZXclQzVGpmQWtaYWxwckpWWU5DKzQwRWxBQWl4VTVNZXNicGtnTzJEcm9v?=
 =?utf-8?B?TndzNmp4TmRvWjUzaFhaYkxwMXdRaHNDODFzVTZaVHZrYncvajlaaGsrRVpE?=
 =?utf-8?Q?ENBgM9xzLK49GHYq7d887naNF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7822c22-b10d-4b3e-9f93-08ddfd0c9db9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 14:54:38.6016 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5U4/AlyBqxyso4VYmwKc0fgwLBgOtIsQ+IY8ndPdmUyMiqLcEOS/W73+zHBljZECTu8pyUKgqkx1GpFMVehFIQ==
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

Following Linux Kernel drivers/firmware/arm_scmi/transports/mailbox.c to
set the default timeout to 30ms.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/scmi/mailbox_agent.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/scmi/mailbox_agent.c b/drivers/firmware/scmi/mailbox_agent.c
index 6d4497f4b92ad21f7b303896fc75e2cdc27885c8..32b0fd9f589a30c2bb8bdbe8d655c3d47d0abd5a 100644
--- a/drivers/firmware/scmi/mailbox_agent.c
+++ b/drivers/firmware/scmi/mailbox_agent.c
@@ -16,7 +16,7 @@
 
 #include "smt.h"
 
-#define TIMEOUT_US_10MS			10000
+#define TIMEOUT_US_30MS			30000
 
 /**
  * struct scmi_mbox_channel - Description of an SCMI mailbox transport
@@ -87,7 +87,7 @@ static int setup_channel(struct udevice *dev, struct scmi_mbox_channel *chan)
 		return ret;
 	}
 
-	chan->timeout_us = TIMEOUT_US_10MS;
+	chan->timeout_us = TIMEOUT_US_30MS;
 
 	return 0;
 }

-- 
2.35.3

