Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07826E77198
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 07:00:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B47980655;
	Tue,  7 Jan 2025 07:59:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lC1zGBv3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D15838060A; Tue,  7 Jan 2025 07:59:25 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21C78806D8
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 07:59:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vsgQ71qZbvYqO0AEqHYbIQkf0dBQLlF2F21ZsCOhy2n8juScS2M895fnceJ0sj0X7otlP8q47aARTR+q4zzsv76zHSXIr6+tIpmgHTPcdTU39khkHMaQJqj9DD8Kasft2nLtTL+gF8o+BfurYwNa3I2YUUKYy0sd9v4pMaRp1SDbruFLH7J+HOhUaopY4oRTkt51GQmBsfEil8ZiZZqDe08h/6uF83EGWWJ7GbW+0cUDHCsJitnKUAw4pnuh8TPFXF2ZmZFzoSNQWxNTPfD2SHTx+LgQx97iE6KJvvJY4i6VwTvNf8eE+d/rPiA2m4GzL57k/bQwyAoVVzWcrHUCNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5uAZON3a9AeO8BesXQjz8XhsVzjudUGhDqIwVmmAs+A=;
 b=UIl9TRMReynSY52YPiXdqAkDvTVDyF2JLLL1Bvalm/JEW2TqJQg4JfHmuRrBa5letwZd0j8CXcjtBQhgqaDqHOXU7VOn4BjabKnV1BZmDenfKe3lTLbPjIcGR5ptbDND86l/VaOznkhbM+FaEG1obCIiENnqjZioN4hKmDhZieGs1/n94xCoCo4Ntgm3oW2pgiJjiT0HDxe03fOnadWKWawVtMt+sw8DOykNaDArZg22T+yeeVu0hgUs2C9IqJMl+U2pfhlqaA3w+ccGT2BO+rshM/Nfar0wLN1qd7rzmOG0GuCr1Ovqx+tb+MyUOiAWiOEbsetoIvgVeVL880lJ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uAZON3a9AeO8BesXQjz8XhsVzjudUGhDqIwVmmAs+A=;
 b=lC1zGBv3JvZvnLpu+SURRBswKIToogvJBxgZkQJCusY1W3vHeOcsDG6Jw7aP+4JQK3VbrSxzw9SYQI77hubT81usvwjInVZZWtUfsBiI0EfvEmp55xLaZxA/CGzt+E+/DluGENCaC899dTWpYNAV1FIVep0zhav4e+/sY+rkDY0Kf9S18qCZsZqLj9MBRCx8boK8KtTrwFPqhWIDuwIAQiSZQpYMyuK/1zUjv+wvxZvdrbIMvX0gNITyFtxoYH2N5p16fB0c4gIyOL7JdJQN/VDvCU3GN7MX5nOnyUmcUyDweLkDYGQ76jKp2uzUgaQLbY/dLHwsvklYiGOZy9tkog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10523.eurprd04.prod.outlook.com (2603:10a6:150:1d4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 06:59:17 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.018; Tue, 7 Jan 2025
 06:59:17 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 07 Jan 2025 16:05:07 +0800
Subject: [PATCH v2 07/16] imx: imx8mn_evk: Drop DECLARE_GLOBAL_DATA_PTR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-imx-bootstd-v2-7-97671b1694cd@nxp.com>
References: <20250107-imx-bootstd-v2-0-97671b1694cd@nxp.com>
In-Reply-To: <20250107-imx-bootstd-v2-0-97671b1694cd@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB10523:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ca1d6b8-8cdb-4b6e-bbe6-08dd2ee8cd1f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZHJ5NWRFSTdzQlk4QzdJWDQ4K1JmdU9lQWdGWCtibkd3d2R2VG10aWVUSWh3?=
 =?utf-8?B?Zldra1loMkh3a01IcWtHMXlZOVYyVEg1bHk3S2JhS1FQUXNlZDgxbG9sZzNm?=
 =?utf-8?B?Zm9MWUttY1ZwQ1Fod0t0MFZyL1VtSVBzQWdGVEhZQWJHM0JNck1RdFFYWFhp?=
 =?utf-8?B?Uk82LzlrcWsrWjkwRzIxbjJCYmh5SmxTRmJJcVdjRUFUZEJackx0Skx6bkQ4?=
 =?utf-8?B?Q05qV0w4THpJY2Vxa0t4T2pEaVpYTUE1c2l1OWRiblk5VFVoMUc2eUFyY3dx?=
 =?utf-8?B?TTRxVXdWTGozMU9zQkVOaFl2eW5tNFYxNnpEWG1QUEtNWTZlQXZLS0JXRllh?=
 =?utf-8?B?SzEvWkdIRzdxUi9zb2xmd2FPSFlKbWFpUkozUFcrZ0RuUVZvM2xTVmVMOHBl?=
 =?utf-8?B?bkpDUTZaaGY0U0FJbUNqZGJ1VTM5TmNwLzluSmxKSlRtT0dUT3lwNEpMT1NU?=
 =?utf-8?B?WmcrQ2svMEJaK3V4NUlOb0FjR0hoWDd6WDJZNWg2K2NNWnRaWGY0VjR3SFBC?=
 =?utf-8?B?c2tqb2QyRkZ6MGtKNTBYYnlJVit6ekhUT0tPNkJWVGttN0liUGJ2TTk4Rkll?=
 =?utf-8?B?Z0paT25EUEZUVVIwTDRsSVM0K3hxZzlIYWNxRFRibHROVStubTRNYWFqc0N0?=
 =?utf-8?B?SXN2KzNwODByRi8vSUxhN0VlMC9IdnQwNWsvUlRWdWprZ1RJdWdVZGprYm1X?=
 =?utf-8?B?YThOMDZhVUF3YnJhSXZnaEQ5Q1ZUVUw5VklMdHZYamRLOEg0WW9vZndRSmhQ?=
 =?utf-8?B?QXg1R3FlVFhGQmFSWkVONzlTUkgxd251SGo3QlNJVjhXYlhoK1JCSnk2NUVD?=
 =?utf-8?B?cjMwQnQxUjcySGhtY2s3SGhqZ29NbGdsSGV0S1dPTUViWmxQMDZhYUZJbktm?=
 =?utf-8?B?UGRaTWRuUTZ6Yjg1eWVzcTQzVE9ZQk9SdkJieGFoY1RpRUxtYnZEcDlNdG5m?=
 =?utf-8?B?dWt4TlFLdlBhT2hpWkVHQy9MWDE1d1I0S2VDbDRBZ2NoZU16MFVQMm12QnZx?=
 =?utf-8?B?c3o5OUM1WEN2VGpCbWh0clh3REJuM1ArRVVlcjJ4d3dVcllhZlYwZjlJWit3?=
 =?utf-8?B?NnBGOU1OU3hvZ0xGQW9qRzlSMzNrL2M2U1c1ekczNWo3N0JJZi9maU94a2xw?=
 =?utf-8?B?TDlwUERnTWF3V1owMmhVNFM0YXlGY3cxc2xpaC93M2ZxaDdoL2FNK3YyZjdm?=
 =?utf-8?B?K3ZPdGUrS2tDS1hyVFZHTFF5Y21udTlybFRsMkt3TFNRT3pRLzRoY21pTUdz?=
 =?utf-8?B?S3UyL2UwWUFicjJ2bjN0dENaVHpmci9ZK1ZOSzJmemRxWUkwNmYyaW56NTc2?=
 =?utf-8?B?cW1NQnViWkNrRTRKVlY3d1Q5cHlYUDNzL20wZER3dzBSNk9FWFlhVG9pZzNl?=
 =?utf-8?B?Y0gxbjJ6RHRhY0RwdkNOdVdtdStJdTZwMU1lOVBOZ21wUHJ5OWkrOW94UnM4?=
 =?utf-8?B?MzFjU240R202NmtuV2RCTlhUdHJ0dGJwa0p5aGd4eTBBM3VXczVqRm9rRFY2?=
 =?utf-8?B?dDRmb0dTdXBoVGFoS3dCb0JVZ2xZalFOeTloaUxJOVU3d0VRcWhURkx6SlV1?=
 =?utf-8?B?bG02cGU3N0U4bklXWGE0RXQ4K29jZ3RTVVFxWG9QV1VyZzZ3S3pYQURETDdJ?=
 =?utf-8?B?Z3BiWEl1RHhMbU8wVXdIV05xcW1Ib091dDhiV1JZQmhwQnRETHdBMEZoM0kr?=
 =?utf-8?B?dUlHcU1TamZiMVkzZXd6cG42Q2l0WVJCdjV3K1BteCt3ajB5bE1WR1hpTWxj?=
 =?utf-8?B?eDdkNHFOa1EzVnFmOUZwVHFML0ZjeFhBb2s0YWk5V2tTTHExOUt1OVVKTlU1?=
 =?utf-8?B?UE1XWmhzV3ZhNG90bWw3dlNSdFpOQjJGcmpYZ3hSTEFMUW9CeWsyZzNqc3lx?=
 =?utf-8?B?WnBQQ0NOdHFWY1VNeHRLVEtHVGcrWndUdnNNYlE4SHJreDdtMlprSW1BZWRU?=
 =?utf-8?Q?h157XmpxauJ67L83M6Ez5J+qFJU1FqAz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFFXc1ZKYmlBM3ozTG53eTJrSC82NE1hV3oydWdMRzYwSVdCcTA0TE1TdXRZ?=
 =?utf-8?B?Y2YwWndSZGVhN0JyUUllVzZtTXpnaG1sZkVObUcvQ3Y0UWRhRGR6dG5ibnpZ?=
 =?utf-8?B?TWNRZTNSeWZab2YrTzA5bE9zbTZwVFpMOUhsZ3d3dUt3Uy9icWlDMmZ0cXB2?=
 =?utf-8?B?TWpWS3hDd1g2ZFZ0ejVXUTdMdEY3UkNaZ25DZ0VjMVlqaFRFSTRXd0hjNm9j?=
 =?utf-8?B?UnVZT2ZLa1NzOVRMeUNPbnF2TnhHOWN0NkVuaXdSb1lxVGpiMGk0NGNyM0d6?=
 =?utf-8?B?KzdPOTd1aEVnTnZTZWgyT1FhM04zcHR3YXVwYXpBdmhJN2xSMmthczFrZ1NY?=
 =?utf-8?B?KzYyOXlYdDlJUU45UFh6dU5uZ0pTYWc5ODhnZnFnMEloNFN1U0ltajhHUGR1?=
 =?utf-8?B?SHNjM3RYWG53WDJ6TVJ1YzEwMXFtdHBXL0liOElvTmJtSStlakVEdHFMemI4?=
 =?utf-8?B?SXNWay80VnNoWHJzd1RhaDg5bTZGRlBKNDIxbXNlVUcvU3phNFlnOXJVTjRj?=
 =?utf-8?B?cXdHWEZjbm4wcnB0TnVrOExDKzF5VmZVTzg0WTVlRlUwKzg1UWhwcEcwTksz?=
 =?utf-8?B?OTYxZXI0cWlSUmlqVm5hYWt2dk9wU3RaZDFXVFFYN3hsOUZ3Snk0ZUhrcHhY?=
 =?utf-8?B?aStlb3BuM1ZKQ2N4WFFHWDc3dFkyL0hmVS84d2dlc3N6TDYvcDBJN2VPa3Qr?=
 =?utf-8?B?aEZOdjBuSk80dWJjc1J1WVJoRm0zWU54SWtoa1M1TDZlMGdGUHFuQ29XRzRu?=
 =?utf-8?B?S2g5a21rbVRZWWNOOTJ2ck9qZGhRQ0tJL2xUTjJKZ0R4VXUrWWQ5RHZLSFJL?=
 =?utf-8?B?R0FJc1pnbGdiOUlBRzI4Y1pZVFVudVQ3Q041ZU03WFRPaERLWi93Y2JtNmYr?=
 =?utf-8?B?WVhsa1lhUVMwa3BEMDk2M3ZCT0MvQjBGYkU4OVZVbW5zSW9uWEd3dlRlRy8v?=
 =?utf-8?B?MGcxKy9RMExxM0M2QllhVFFSMnJVUUloVXVDckFBRWh5Z2tsYXpaWVBZTk9R?=
 =?utf-8?B?aXRRUjZQYklJRVVJSVZKSXJLb1J4SnhrdXgwWTJHN2pPTVV2M29QS0x0Wm1S?=
 =?utf-8?B?K1grUE83WGhoZjBLV1ZQbzFYRW8wTUpMeVFoNFZWeE53aXdNdmUyZUxCZTdX?=
 =?utf-8?B?eEdTS051SlpNR0psbzlUUy9Zc250T1BCUVViWmoyZ3NoUlNPZ3gvNVhXY0Yy?=
 =?utf-8?B?UGtIZStrNFJ5aFFlN2ZTNkhwK1RPS1R5SXJacEtweUdsOU5xUEM4UW9Ga2ZF?=
 =?utf-8?B?SDg5MXdyN3BxWTBjQTFKbzBMYzZmNU0wOG5iR0R0QkNxMkQ5M1MvYTlqTG9X?=
 =?utf-8?B?d3hLdFZNVzBTMi9LMzVyNWFVR2RCTXlzbnh1Y0p3bTBGNlh2QjZwbmM1QXVH?=
 =?utf-8?B?Q215Ni9WRk8zUjlXUkhLeForNnk5VXRhTm1FalRuMXNzTnNadGJmMjJWRkVq?=
 =?utf-8?B?WEp4VWFFRkVSeXZOZ2RmVlhaTHhVYUZSV1lzU2R2RVEvK2krUUhSK09IMWEw?=
 =?utf-8?B?Y3JZMUtOWFU1bjlHc0dlUk5jTVo0aXRnMUp2dFh1Yy9wZHgrTUcwaWloUGZv?=
 =?utf-8?B?Y2Y5YklVV3cwZ0JSdWNHa2JDQXM5ZFhkZW02NEdIZVRXS2JtSEtNdi95NURi?=
 =?utf-8?B?Qk05ZDg2bXJsbUpBVHc5TTZJWWN0RnJkWWlNeEl6V1R1bVM1bnF6Q1h1YVpW?=
 =?utf-8?B?K3A0WFlOUVdSWkFoR2ViWlFpbXRXSU1yYytMSUdWT29GOGpySUxMLzNvSzRP?=
 =?utf-8?B?ZnFwd0NvVUx3d0ZtZkFYMFRMZDYxMjdlaVpLNWlERGhIQllGVlZqQ2YyWjZy?=
 =?utf-8?B?TVVoQ0s4NHNxZmwxSU1SbjNlbjVZU1ZTcWRIdUtDQmJ2Zm1lN2Y4M3F4TC9u?=
 =?utf-8?B?WVhZbWIxWk1ZTDVHRTREeVB0TGdrK1B6azF1WkMxemVWbVNQLzJiRFovZUdZ?=
 =?utf-8?B?aXhXNTBkM1hBQTQvRXhyQXZlMGMzVytCQ2xVYVQyUVVVL0psbEtRUlI1cWxD?=
 =?utf-8?B?SHZWby82QVVSQ3U0SGxadzEvcUkwYkg1c1dpcVJFRVJOY3RpSzJxbG01Znc4?=
 =?utf-8?B?cjlFbVBPbXVCUTUzNmF5bGZ1MEZ5V2l0dnVSSUl4cDBUa3AyRExSME5xTkd4?=
 =?utf-8?Q?bV4KX+tUtI5q8MjnFUBregWCG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca1d6b8-8cdb-4b6e-bbe6-08dd2ee8cd1f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 06:59:17.4129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: it+BUhkc1KJm6djSkHtUvPdB3mfP5hpzrT5PEcMom0QgUsaJo4XLMKampu2SXhPxstc22w8J5E9XWvSOY3VHxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10523
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

There is no users of global data in imx8mn_evk.c, drop it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx8mn_evk/imx8mn_evk.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/board/freescale/imx8mn_evk/imx8mn_evk.c b/board/freescale/imx8mn_evk/imx8mn_evk.c
index f20ffbc52501a8a5c3ae9603b04847bab2cbd8dc..1b9dc51978b555256532f22e1cfd317bacee5b37 100644
--- a/board/freescale/imx8mn_evk/imx8mn_evk.c
+++ b/board/freescale/imx8mn_evk/imx8mn_evk.c
@@ -3,13 +3,10 @@
  * Copyright 2019 NXP
  */
 
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <env.h>
 #include <init.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int board_mmc_get_env_dev(int devno)
 {
 	return devno;

-- 
2.35.3

