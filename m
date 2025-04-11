Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28133C3601E
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 02:46:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C339A8328F;
	Fri, 11 Apr 2025 04:46:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="trYLAy9X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B15768328F; Fri, 11 Apr 2025 04:46:20 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB60782B5B
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 04:46:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l9khygJX+n72QVVeTPgmUMsc+THR+hwTe3l+Al5t9MCeDNoKEhzjARpG097fNekTDfb4g0NQO1o11MvKnVG2OADoPe52fTjPI2o26nbb+2zEBcjhP6favaqX2gf2bgXj09IFEowv+BHFy5IF6r+wZ2yyzpIw9L+CeFlohyELunmh5U5cbjPQdJZdpSOYFk+XHXsX1Ce6idAf2f3SBdOlf/hNC0sFIdz6m7mG7ZkJtlDkz2PT4xB5tYA+2Ksr10Lqj0hvTrfixssaW3wiHbCdHESVZVoDefcrZHCla45S/zrWhkcRft4z4LcPj668Fgh1ejQmxB02YAsIUAHUZ790Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABQ5gmGpmFVUgx05noF9qDrFusu1bVQg6NMLtHB2vAs=;
 b=kSwLIs+clpZ7YpbpdGx5dCxem8mU4Fg1Mu82EpM4XiEKW/tUklhZmWLUz1jLYO6SFJ5pYV+bsMUwtw8POgCoX27yr5dIkZ9uCs6xtogjLHWFcdzBd8POpX3jWs+ztObYGD0vOzay5VkMx8NLm7pNY9F0brZROLW8T4bNzfWcOEocGIw9dEBpX7ce7hO2+yMppKm3XzZdsgxY3wuFiLAPLFRYKikGgEK4DzrTXxAkYtuFEAl5TWZf+MtbZApmVNdTNx5Stv3t5rbVTMaIUoEmf+5BCMoUiAWem4/9hIXj0UkffjpsC9Ox+PEmp4+xuDsK2tMLvqRuDDYD9NDZjdWefQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABQ5gmGpmFVUgx05noF9qDrFusu1bVQg6NMLtHB2vAs=;
 b=trYLAy9XSpz1IRVvintIRckgLpKvMX8lVwaa+bMALzrX9VcLr9TiZgL1k+ic0Jn1LqK5YrBweus4XCndooVrDzmHcInGV9euvFvZTbaro17bnk0D5qtO2CavKqZARhdBz/9I2zGqo4JkMBcaLTscDyQajctbbpAgZE48Cv6xb4L2jiUj8JDp4pv4j54PgLyNmrRZQf5WY8FOusAm6WqthwoA+Bn96BcFS1k1EsZJnZrbYIJ73RBnLrRBMK2eXHlwtW2CgOGzDafmida0qopTasdyxnMbJ6X4dCxniAwY4zwpO+/7S6DrKGLsMdocmgaOvc1KmyZ7WJQJFC5vdfWKpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7798.eurprd04.prod.outlook.com (2603:10a6:20b:2a3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Fri, 11 Apr
 2025 02:46:16 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8632.024; Fri, 11 Apr 2025
 02:46:16 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de,
	Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Peng Fan <peng.fan@nxp.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ronald Wahl <ronald.wahl@legrand.com>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH v2] mmc: Simplify poll CD logic in case cyclic framework
 is enabled
Date: Fri, 11 Apr 2025 11:54:18 +0800
Message-Id: <174434362342.24440.17062757703643322844.b4-ty@nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250118031008.29702-1-marek.vasut+renesas@mailbox.org>
References: <20250118031008.29702-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0077.apcprd02.prod.outlook.com
 (2603:1096:4:90::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: b33192c2-1804-4002-08be-08dd78a307af
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eGExV2JWTi9BYzZWL0xzekc0ZmtqWUQ1Ty9majZhVENmOWZhTnRYZ1EydUEy?=
 =?utf-8?B?dStNSWZuK0dSM3BveGhQR1l6NlJZQkdTSDlOa2p2Z3hKSmpzQ3M2OWI0Umlj?=
 =?utf-8?B?TXE5YTlqVlNDNTFWZG05d0drcHg1VG4vZVZiWnZEUHRVQStSOFN4cFlYcjBw?=
 =?utf-8?B?UG5td216UWptcDAvY3pxci81cThLYTh0Z2lMNE8reHgrZVpONGNMK3pjR2Ju?=
 =?utf-8?B?eHIvMU44b2xTWWNVOVk4MWFVMkFqTFBvcDkxQjgxMHhFN1M0bncxQTJpLzNt?=
 =?utf-8?B?T0lMOHk2ekhZUFhacVpMM3p2MXVmRVhyNWk2eXptMk9lWndaYjNETmxYcEVs?=
 =?utf-8?B?eFlhQTRMMVpTYk9BR1hNTGQzT3o2NWFzNmNQMFNUUnhNaFA5N2xSdkxuS25S?=
 =?utf-8?B?dU1QZU4wWEFvYWY4T3NLaXZKdlBOckZYR3dUQVY4Vlh6Y2ovSU1rNXRrRXA3?=
 =?utf-8?B?eERvUGcxb1hCZ1A1UzZUbjFmQUgvZ1pHaDdhNXpOeWNuR2xCZ0MyWnlXM1Nn?=
 =?utf-8?B?d1FESGpWa2xBUjhyNUhOV3g4ZmFLS2lIUDBpQzV6WFN0Yk1tanBFNVVDaklR?=
 =?utf-8?B?RHI0MnJnT29IeHNQQmZQZlduV0NySWJuWHRlTWwzZ0hLemhtMDcydit6Y3E3?=
 =?utf-8?B?K2s5a2kxMGlIOE51dzFZTFJUNFZyWVhvMjcxaExmb1gxM3dFMGxTZFZDMFVO?=
 =?utf-8?B?cDBDcXdrVWFRTWo4ZTluUGNMWWtvamNFTnJlNWdrellRYUVtdmU5dE5nVStM?=
 =?utf-8?B?N2xhWC8yTGI3NGEreG56dlVxazJSMm4xWnRZQlB4Qms5bFFkT25qbUJzRzMw?=
 =?utf-8?B?QldEVFo3ZStBZXdkZ2YxMklzL2EzbmpvU0J3dVZTdmxlV29SVDV3ekRxTDVo?=
 =?utf-8?B?cTlFSzk4T2dpNG4zRGNoSWJsNWE4T0J6TVByZkE1cUNEc0tNaVR3V0h6bXZx?=
 =?utf-8?B?cklYbzBBYk8zRWVSVTlSVDV0aTZrMi9uZmZaZUE0UDZvNmlacVEyMlVoTy9T?=
 =?utf-8?B?SXZicjR4ZENzY29xQTh4RGVSdFBUSDBSRzhjTGtXZDZnQUxHd2Q0ZUZQUUp6?=
 =?utf-8?B?ZzUyZjdia0h5TnJlR1k4MnN5WFZVblRGbFhsb3FwdzBXTGNFVkdjcXFoYXp3?=
 =?utf-8?B?UWJHUzBYVTdBVWhFNGJjZEdRZUk5a3VZSUJwRlppUmtORDAwdzVCWFNWQ3By?=
 =?utf-8?B?Y0c3d1lFRit2dXNUcTV0ekpERTJLQ0N0Wm5QNUtFZ0I1WjZucHZocU1xR0Jw?=
 =?utf-8?B?ckk1SjhxWGpOVmk0SnFmV3dRRFJXYld1MklTVXlmZ0JOU0I3cXhBR1MybXpz?=
 =?utf-8?B?RWhocWllV0JNeDhORURLUTUzMkNrTUdqT3ZVY3F6bmNyY0t3QmJmeEluR2NZ?=
 =?utf-8?B?UTY5VVhjQmNhdTkyWGxMUW9ncFlZVnZtUWtyT053YkVrVmx0dzlrREpUSmpa?=
 =?utf-8?B?MW9BMnc3elVPelNNcHNUbU9SdE1yemJMMFFZTVpraDNub3AxRkV3dDJ2bEFo?=
 =?utf-8?B?Mk9pUk9FNXRzckFld1ZNdis0bS9oZFhwRFZqelN3VHlnbXhqNVRoL2dhQzU1?=
 =?utf-8?B?amRJM004TGZ0WG1Ec0lxRXdBdGk3UnFSWXdSeTRkOFpsdHV3VWNOenFxOGxD?=
 =?utf-8?B?M3BOY29TZ3g2bnRoYzV0MXN6Y2JZKzlRYmhINkZOZEgydVR5Ujh6SXVCMndH?=
 =?utf-8?B?U1dNMW8zRHcreWFFbWhSU1pSUVNHWXZ2MFJXT2ExdytwMnFRWEpOQkYyaVpY?=
 =?utf-8?B?b1pLdnROREZKZnJwRWtlNjhPODUxcWpZUkFkazhJV1lONk1FbTl6a1A1SnIx?=
 =?utf-8?B?aFhTamhzSElrSWtHamtUMkVwOVd3RnYvUW54QjFlWXNhRVVjVHVaWVVod1N6?=
 =?utf-8?B?QnRCa2pERWs3a29vcndZc2swd3RTYm1XaE1LcXc3Y2ZuUG1DM1FBY1luRVNn?=
 =?utf-8?B?cEVMdW9RYmJtSFRGbG9YYU5GbTZ0T3pOYWttbzdVOW9PUnFJRzFaWE5lWml1?=
 =?utf-8?B?QlUwcVhPb0h3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlppNGMzUkxtYnViMEV0M2NMM0hFVUhXcjRhMzhCV2syWGs1SitwSjNiNVhj?=
 =?utf-8?B?b0pkT3FnWGg3YWMxV3djSFpsdFZLQmdrRFROT2JJUHpOUVN1b05HUmVWV1h5?=
 =?utf-8?B?MEp5NWNrSnhhdml6MytON01JV0ViQXNha29QYlhOdCtNcE5tMUZGV3lvYTB3?=
 =?utf-8?B?WWptbTRyUGVMU1BITkVGMDdXNFQzeEpNbVdpOWpxeElGdjd2dHVrTktxYnRl?=
 =?utf-8?B?R0c3N1JxSGNRQ2lGaEFQVFltblMwYy9FV2dqd29XZEpmeStXeUtpWmp3dG5s?=
 =?utf-8?B?ZmhnNWlYc0tKSHdxUUdrT3lpMmljS092aHNlN2RlNDlXUzVMRTdNdFN2b2Vk?=
 =?utf-8?B?ejQxbW44bG9xdjE4d1R6Nm5lQ1d1OUdHdnltNGpUVTlhcUlXS1R5b2VlYXRz?=
 =?utf-8?B?NlRKc2tYUmsrT0VXakpqcFJ1MWp3ZFp5QkZaK2RncE1rb1FlM24rVUZDbmZU?=
 =?utf-8?B?eWdEbzZsL1FncXJSN1hJaERCYm1rd2xLMUFNbnVpVFo3MFdObWhxTjZXaFhO?=
 =?utf-8?B?c3dLcmhDQkhtUWI2c0ZmbzJSVzZxSHpMcER5cXM4THhSZ1FySEVIVkJjL1FQ?=
 =?utf-8?B?YWVyblEvSHkxK2wxanZyV1UzU25LVEttTVhUZ3BZaGxZc0ordUR0UXdJN2Fz?=
 =?utf-8?B?WllUbmlLOWJQT3RHdXgwcHhIa2ovdGFzeFlLV3hRZHNTMUIrVklQcDM1MXNR?=
 =?utf-8?B?SEsvWmhZV3BUVVRWd214Ni94WTZwTG5mZHEyZk5hSzJ3cE4vOXcrbzdtUE9m?=
 =?utf-8?B?Ym1TbHlkTmRHVDRHL3RPUUtmbzNUd0VvYXYzK1A2VytoRlp2WGgvY1hHdW0y?=
 =?utf-8?B?Z1pUZ0V6MFEyVEsxc3FKUEFRSGZaZDFOQlN5bVh4Nkh5Q0JNKzJnRzBSdnlY?=
 =?utf-8?B?YnphQ3pQdnE4YTkxNlR1QklCRG1iSm95Yjl0eGhOMXM2UnNSZTNFTjM3K0c3?=
 =?utf-8?B?dmJZcVovRTFtdUZDQ2g5NGl3U2ZMMFRmL09IS1Bad0pQdjVNaDIzS0JuY25m?=
 =?utf-8?B?aWYvZ0pFNTQ4a0UwS0FBTVhUZXpjRlFzM0NiUWN0NEd1cEJucWxNNnhpU0xI?=
 =?utf-8?B?d0FOdzBNeE05eXptbWxYYWNsc2FDOU5xL2dxL2pzM2dXTU5TUnY0V3JqdWJ5?=
 =?utf-8?B?VEFGdnBTTW5oV1dqOXg3ZStQYy8zd0tpcmNjZUs0Vjd3YmxZR1B6cGZucmxh?=
 =?utf-8?B?YkN1QjB1clFiTnBsaktmcmdVcVAxVDkyREQxWGJtQVB4ekZJSWJrM1V1TjZY?=
 =?utf-8?B?UGEzYjRCRjVCZm1lTHZvU0xyTGtqU0d1MTlQbG9XSGJuMC9VV3cyY2ppeXBG?=
 =?utf-8?B?NDhQMjdjUkszNG9LSVcxZ1huVUlFeUtTRk9XV2h6UHJNQkU3bHBVa3hZRUs1?=
 =?utf-8?B?dVV6WG0rSVlLanNseSt1MXVYTDlLdHpXQnFjTWhPS0d5VXMvU0ZXOWFibG5V?=
 =?utf-8?B?WXd0dTlVOWQ2cGdxdVNCR21Wck9aY2dlN2h0RzJnUzZFTHVhemdSOGRjTjdU?=
 =?utf-8?B?eHNwK1pCc1pQSFF6eHN3UEdOMkR5U1VQVXhlejVxamNlSnZId1JoaVFLYko4?=
 =?utf-8?B?R0srV0tQU2kvSzlOMWczY0NSeEFsVGVWNVpiWVZQbTFXa1QzdmpEeWdFd0VQ?=
 =?utf-8?B?OGFaRzg4RVVvZlFKWTFGUDRJeHlxRFVxN1RpQlZqL090a1YxdytwUE4wZ0Vs?=
 =?utf-8?B?U0N0OHpueWJxWkRPODBmZFE4OGEyOWQ2VFk5aDlNWmt1WGkzTmpON25OYXp1?=
 =?utf-8?B?c0ZyYU9wTjNTSEZhKzJwdmhEVHEzYmc1NmVjZXIvYWl6Nlp0SWdrdHV1RENu?=
 =?utf-8?B?OGtWY3hBaktsS2M4RUg3SGdrQU92M3FpS25COW5MdExGcnVkR3luKzROeHlL?=
 =?utf-8?B?UlkxMDBMaGdTTXdjVTh2K216WGg1MzZkTTc5dGZiRWs4WEdKblVFdmFIcTFF?=
 =?utf-8?B?RUU3OTFHQi9KNWZrdDlkUWFvKzI5Y2lEdEg0MDFCV0RnZVJyZ2xydmZPbGJ4?=
 =?utf-8?B?WlIyWnVma0dCcklBRWgrbS8xN2VLSnJRNStPK1Noakt1NFdIbUxNRVRWUkFO?=
 =?utf-8?B?NEN2anNTS2NrVTlkcXZGSDVmT2lWWEJhSHpXaDJsNG9iSmZwMWxVN0gvOW9o?=
 =?utf-8?Q?Bnhwcmj7N2a8jaAhis1XeFFca?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b33192c2-1804-4002-08be-08dd78a307af
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 02:46:16.8253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hx0Tq5AvjUoFapyQH4y+KSGcraT4jY0g0AhuAqXRndkOdVUEw66IEWYnC7frsWvR1RPffl4jhKq0XXRsUlebhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7798
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


On Sat, 18 Jan 2025 04:09:53 +0100, Marek Vasut wrote:
> Simplify 90cc07fd786d ("mmc: Poll CD in case cyclic framework is enabled")
> according to suggestions by Rasmus. The struct cyclic_info is zero-size in
> case CONFIG_CYCLIC is not enabled and does not add any size to struct mmc,
> so it can unconditionally be part of that structure. This allows clean up
> of all the other conditionals in mmc.c which can now be unconditionally
> present, as they also add no extra space.
> 
> [...]

Applied, thanks!

[1/1] mmc: Simplify poll CD logic in case cyclic framework is enabled
      commit: 4357167e0e941faa0471325450a30227fafbae24

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
