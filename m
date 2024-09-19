Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D321ACDD56B
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 02:59:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77B8F88F99;
	Thu, 19 Sep 2024 04:58:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JXmtHuW+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0F2D88F92; Thu, 19 Sep 2024 04:58:34 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::62a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0954288FC1
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 04:58:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xGyOLs8jYLFDdHM3zXf67Ds0yGQHV5A1yC1Mc/wzppRchJ+Ppp21MvBfI4K1lpDEWlpJ5vF15bz50XtctT4lxRJkLocqsm1KOZ0vmXj30Ca+bsSyqJDil3hKe2KXwyuXDsv9i/SegnZL8iCKRJJMCMd8NL3qnxutiDHWjY78faKTc5EdaX7eQtjRZjy9EU1yXvCc0pBVxwCIybC07THGit4C6IUgXpRlMWchvsyMvxj0O+UtJ1P7CKD6NIyqyUhVIhXfh7EmxE23oOSO6x5lZMNacl8Z2HSlMnpTgCxD52HfG0JOZ4VOptHxI0zTFUNcVNhNiJz0uJFG1se2KsEPUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wczl0HI5w7KandG0ewlD48ptUN7AK4+i8zQQq7KIxkY=;
 b=MM5O2LP2Q3muEdF6x5RSNUpqALhfEzoxaFgIUXIdti+68pbd49w6UUsWovEE9JaAwVJ+A+qHHfzmtocdd/6xOWybtTabj8dI5vb8P3AlZ83x497NW6ygYCOHtgCw6QiZN0gCjhWe0Qv7pFYsRnrF+4U5Q6dAeq5Fc1VjwJOnMlNpxn0CTe92f3h74SzXVlYEDL6CMjEqbqQmhWuCMq2rS0scEu313V6W5hE36n8XotXlVuZag7owstCbEP4XeYbx5Gi6UtztDMQyL7pJ4SkCU9wxGeUx3y52ScsvZ0YnIPbymsR/bKnwdKF0Umcxu5mTL6tNb+tG+vpSuK24+yMeNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wczl0HI5w7KandG0ewlD48ptUN7AK4+i8zQQq7KIxkY=;
 b=JXmtHuW+gnYfswU5+UPad+afmEsqjb+qfEteH7r5Ybab4bV3TvL647NAZYiHEWXLOw9p6onWeZoe2ex+HkpBsgOoqBzA/VDIvR/bnMzUOTafvBqxrrNvdUUq0EDGt8xA8/hzTtoLvQWvUlfPnchk5X65FXkWktBlYAr3e198N2mtGXhenN0BS8ql3/0g8+cFYvw9USJaX6QKXGW7aL8w39Gk5hVClBdc+CSA9CEBJds/NnJmTTVXr0IszJenSSiW7aMNBXpCE44GVdgvr3hbd/oySdczvwfGK9nBfcgtawSWkZsMR9fzvS9tfklQHJ6ipBQ/yWcWLVnHUiV4tJ+SEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9986.eurprd04.prod.outlook.com (2603:10a6:102:380::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 02:58:30 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 02:58:30 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 19 Sep 2024 12:01:28 +0800
Subject: [PATCH v3 10/21] imx9: soc: Mask the wdog reset in src by default
 on i.mx9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-imx9-update-v3-10-80f9786cd1f0@nxp.com>
References: <20240919-imx9-update-v3-0-80f9786cd1f0@nxp.com>
In-Reply-To: <20240919-imx9-update-v3-0-80f9786cd1f0@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9986:EE_
X-MS-Office365-Filtering-Correlation-Id: 087618a5-a1f0-47e5-e67a-08dcd856f10f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bGR0NFd1ek11SURsMnV3VkZDRHNjMGhaMEpOTXBkZ1ErdmtnN0l4ZWpnd3Nm?=
 =?utf-8?B?cEN2NzFQL0Z3S0srTDhGbTdaeVlhMWpHemZraEo0ZTdHb0pyRFAzUXJIWGNK?=
 =?utf-8?B?YnV6MXEyVnhFTlc3Tm1lL1JUeVIzODJYRzk2Z08zRHlvNjNMK2lxaXo3NnIw?=
 =?utf-8?B?T1hYNkwzSUh0ditDMzVSUjZLMlpTZElBUkZjYkYrbXRHemsraHZCdWFpZ1p1?=
 =?utf-8?B?Vmd6akk4U1B2UkdYTGo0V1BhY3ZSTWZlaDA1Tk9Ib1FEOXVtYkN2OTcrRjhi?=
 =?utf-8?B?RVB0cEFwQ04vNWRyM3NEVDV1eXNkcFFINGVkUUoyOFZsVitOUGVGQmNXa2Zv?=
 =?utf-8?B?TFRNS0ZJcDFReW1MRm0vYTJueThJbUcrcHFyVXRzMGdrK21zU3crbzNMbGZR?=
 =?utf-8?B?L0VWeVdHMmdNdVpvTzE5MXppOFJkV2JFaEpyd1BvNlY3RUNZdUpTRjNqVkE2?=
 =?utf-8?B?eTZkd3FuRVpyeFNTbXpVbXhvS2xIUTJDdC9rTCs5SzhDOGNMaThuRWFDSVZk?=
 =?utf-8?B?Y2tsTTNwT2lleEVkZXdMVlh4SVhnUnczN24wSEZsSXJ0YkZKOXRPUWt0U0s3?=
 =?utf-8?B?OTZ1Z041dm9iZnl2ZTkzOWJ1bWZPR0p1Wk01ajNWVGxYZ3NVL1VreEtMQUwz?=
 =?utf-8?B?M1E5Z0txb0huVW15R3NDZjlYLzA4MC92VmUxMGxpZk5BWCs5MFVaYXlLRDhr?=
 =?utf-8?B?TnBYN3dwUW9PRk1hai8rWWtBU1V6a25qMFY2OWk4cnRwNFpQYlg5ZDVMTWZW?=
 =?utf-8?B?WmcyT0tOeU9GVi9YZUdHelVPK2dkSTF4N3V6dWVwS1l6eFA5RUd5TXg2clV6?=
 =?utf-8?B?UTQzSkF5SDVwSmxWUVl6RTVJZURKYmlKVjFhOXlQeHVFMlBRZ2orNWhvSjRo?=
 =?utf-8?B?VGM5VFZzS2ZjWEs5TEFCeXhYT2tFWko4L2orZkRLdUFjd0VtbklKNkZYbU9Y?=
 =?utf-8?B?ZTJpa0JXTFNjSlpESUlldDRzQ3JGcmlJTUhzM3lsUUlFakhXbVViNlBZdWdm?=
 =?utf-8?B?bW81REh4MUFIUUN4dnhTK095eXFXZC9qenlmbjFPZnVEL2ZqK3dvVjZEZ01r?=
 =?utf-8?B?ellka2xQLzNtMHBsVGZOSFdnU0wyNHFoQzlaUU9xMml2dksxWGZtYUgydU5L?=
 =?utf-8?B?akh2d2VWU3RTenpoakhYYys2ZVVQaUhqOEVqSEpWQmxZL2Z1cVFsR1lxakpG?=
 =?utf-8?B?a1dFdUhoelN5QjAyaEdnTGR6WDJBcVJIRGk4SU9yWWh6aUw5RXlnR1pSSVBx?=
 =?utf-8?B?N1YzcU5kSEI4YnhmYWxXbk5IZ2RhSXN2YkpNcXdoRERobFhUVlZBSWRkekRS?=
 =?utf-8?B?R3pQOU11dHNic0ZCWUZia2IvNWtPdzdKMU83Z1krdWtPSjNBQXYrdkwrZWIw?=
 =?utf-8?B?bVJCVHdaWStBWmJuRTZsRy9JKzdGK1h4b2o1Y0JTcFFuYi83emxod1JwU3ZN?=
 =?utf-8?B?eEVWaTM2T1czOXIvK0JBR3ViVjBMMEtwSFdjQmMrb2w5TDdweS9KRXRUazRN?=
 =?utf-8?B?cTMvUStBa3dML3ZvenRpVDRoSy91RWxlVTQrV3ZKTm1RaThVajRtWTB4aUV5?=
 =?utf-8?B?bmdzWG1RUHl3bllVS0JSTHFwaHdZMjU4YlIxY1owLzBBQWcyZWJiVFF4TmRj?=
 =?utf-8?B?eTEycDI5MStEV1BsQk1CR0dEMzl1WFh3Rmc0ZVd1cGxZNW1rWlI4UVVVOXB5?=
 =?utf-8?B?MnJmRURzZE5YYXFFN0FBTlRLM3p0bXBQdFgrbWhOYnp0WktGVmF2STI4MTlv?=
 =?utf-8?B?emxxSlI5T0MvV0N3T3VKMkhRcGtlMmFRMEplVmxtdEpnL0FFRy8vODRHbEFk?=
 =?utf-8?B?S1pSaExXNldEa1ZtODhnU1I3UTR0WHVpbE96WDJGOTd0Sk9teTRlc0ZCTmpq?=
 =?utf-8?B?c0tnSFhFeXZrZ2Nsa1JuOE1iaFdCMFFtYzl1OTNFQ2ZoZHc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NU4vN0FNS25WL1l6Nis5NW1ER2JSRUc4SHJEbFRtSkk1cTAvYVNHVnN2Y1l6?=
 =?utf-8?B?dXkzQVpGVk9rdzdhZGVlNkhWSkNYMWRoL21CRGd3Tk5MWEI2em1zT3RTQVgy?=
 =?utf-8?B?Z01vSDhWSHM5ZHpJOFA3TnNIVVlSSHZQYTJRYjUrcVF3andBeStnOGZleGI2?=
 =?utf-8?B?STgzWlZXNWQ0ODc3V0hMSmRPM0dKM1RMa01VOGpydmdTZGRFQ1BnK0NoYWt4?=
 =?utf-8?B?c2pMMXl0bWZLYmY0UXp5YVJlMTc2R3QrQ2s3YlRhbHdxYUpVREdsQyt4ZGZX?=
 =?utf-8?B?dGs5SWtDbG84NFR5dzFvOG1yRmZJZy93YUJVZW90eDlCTFJ4RnMyOW1DVWJZ?=
 =?utf-8?B?d1gyQkYvbXdtbkcyNzJVSXNUYmVPQ21GcnFLcEFOcmozQWtJNHl4WDFaUkhh?=
 =?utf-8?B?WW81dW5MRkVBYlE4TW9WSndZR2xPMi9wNVhlSHl3QU12Q0pSWVY0cmVRWkhN?=
 =?utf-8?B?R3BNYlIrUzJwV0ZHRDlCLzFFZ2dtam8ybHZNdFkvdlU4WEdiaStxWWJxVWVw?=
 =?utf-8?B?eStFTWRuVWJ5NXVHV01HekFUTkZhZ0d4ZG0xQ0JCUHBncDNHY052Z2g3V1Zh?=
 =?utf-8?B?YjQ0TWloNElwdjhYMklVV1NmczR4TFdxREx1REFZQkdLUkxaTWFyZTEzY0ZS?=
 =?utf-8?B?NWVGWW5Wd3VxcFhNRjVFV3NOZ3FvM0ljUytsaUdlRVloVmhzdTYra2ZUSTYz?=
 =?utf-8?B?YXBxbDl6ZW1oQzl5Sk9OZEcvZkI4ZVkzMUtxMC8rMUZiTGJVaVlCWXRqeGhZ?=
 =?utf-8?B?R2d1TEVINytQSGdZV3FzN2hHcmRtSzdDbEN1YlJUODZvVUpYVjduYVNGbGht?=
 =?utf-8?B?TmVJWDRqR3BCaERLK1Y2ZEJZNlZSVmM3a2NRZnJkTTllV2RyK1dPWkVLbHRX?=
 =?utf-8?B?T0NhVDh3RTJ3QU9XS1RsZ1FSYmY5NVVLMnRZTEVhZzdEa0lHQVlZN0h5U24y?=
 =?utf-8?B?Y2MrME9CZHFxdGtGOXRDV2dlY3VleFEvcXg5eEREWFpTSkh5M0FFSDJFVTBQ?=
 =?utf-8?B?OUZoZk5DN3UvVHZWYXpiMHRGK2ovd0hOM0tKSzhqZENha1pqdGNpM2Voa0Vs?=
 =?utf-8?B?SlNsQjM1QjVscnlXakljMlNjQlVwSVMrdlgxZjMzeHBQK09hb3ZleWJ4RTZv?=
 =?utf-8?B?MXpGNnJBTTRZRWV3MTN3bnFhb2pOUHpxR2FZVjgva3kzbFFXSXBJYWJsbHNJ?=
 =?utf-8?B?S0RKb3JuV1RCVXBWbDFINXVzTjIyYWpqeDZ6elVZN0ZqbTIrNEFxL0V0bFc5?=
 =?utf-8?B?eTJIK3pPdXNMbFVOc01aR2xJT05UNkRyRDhoNHVqclFlb2xWVFhIM1hqSXlu?=
 =?utf-8?B?S1FQc0syVW9Nb1g0WHI5cllEQU4wUlRZZGJmNUM3eHFSN3hKekZlQWNsT1dT?=
 =?utf-8?B?cEs4QkVPNHNiZEFPWjY5SzRKbS8rZzZVQ1VaOVk2SzJRQTJBWDA4MVloNk8y?=
 =?utf-8?B?TmhBTUM2emt3TjE3RktKUVdiMnBqN2hHZDUwZzBENWdtNjB2M3JCdzZvOGN5?=
 =?utf-8?B?SkoxYVRHa1VTWHpjTmI5akpWQlcxVEVqNDk0bkc2M1FRdXNYUTllYzlxdDM2?=
 =?utf-8?B?NjVJU21GdGRzQmJFT2ZQeUpNRWlpR0RoMTlCTTlSZyt3amdRcVBtRVROWFVk?=
 =?utf-8?B?NEpSK3dtQisrRzNSNmcyTFJMZ3YwMTk3bzZXT0F0dTNhdHRYVmd5djRhZ29a?=
 =?utf-8?B?ZnVVcDcwRXdGTjduMWpBZTF6a2JiZ2o2eTg5RFIwa0Z4L2NJTlhLZnMwYW82?=
 =?utf-8?B?WnQwSGxQMGViOHRyWDB4NmVrR2J0UVQ3VFk2K3dSR0ovRTQ4Nzk5QXgxRGRz?=
 =?utf-8?B?VVJySGR5c3VmbXRYTXNPMXI0M3VrM3crODJkZzUvblFHWjVzanlCV3ptQ3la?=
 =?utf-8?B?dGp1djFLNU1lTzZtMGtzeXNERCtsU3B4YmxDQmFkOElOb1dFNmo1QllwaFlr?=
 =?utf-8?B?d1Zta2xvSFZJaStWcnYxTFE4SHVYdkJyN1ZCRVJCQ3hJSk9SVTBGTVJYcThp?=
 =?utf-8?B?WnE5TFJLeFhVdG5Pc1ZzanNFY21TS1JyTVRKUlZTZG5IVEorTHVXWWVvMktj?=
 =?utf-8?B?Wk43TCtvTUVoL3A0d1RHeW5NUkNvd0x4U2YwdlNoODN1Z1dlT0RxUEZBWTU5?=
 =?utf-8?Q?CsykTGlkPbtUlYU95bf8OI9Z2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 087618a5-a1f0-47e5-e67a-08dcd856f10f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 02:58:30.3794 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +sBdbxoWNxCdvP9C0vBrpk/4YdXw7kqi26ytB10V+u675hpxCjsti59CKI46I6wMFsyO0nZyXo6ZApF48YpIaA==
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

From: Jacky Bai <ping.bai@nxp.com>

Normally, the wdog will be used for trigger external PMIC reset
through the WDOG_ANY pin. If the PMIC chip has debounce logic for
the reset signal, in some corner case the wdog can NOT trigger
external PMIC reset if the SoC has been reset internal before the
PMIC captures the WDOG_ANY pin reset, so need to keep the WDOG3-5
reset masked in the SRC to let the PMIC to do the reset safely.

Reviewed-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/soc.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 44e2166509d..0d909c3e853 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -240,15 +240,9 @@ static void disable_wdog(void __iomem *wdog_base)
 
 void init_wdog(void)
 {
-	u32 src_val;
-
 	disable_wdog((void __iomem *)WDG3_BASE_ADDR);
 	disable_wdog((void __iomem *)WDG4_BASE_ADDR);
 	disable_wdog((void __iomem *)WDG5_BASE_ADDR);
-
-	src_val = readl(0x54460018); /* reset mask */
-	src_val &= ~0x1c;
-	writel(src_val, 0x54460018);
 }
 
 static struct mm_region imx93_mem_map[] = {

-- 
2.35.3

