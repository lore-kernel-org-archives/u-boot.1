Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC88EFD209
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 08:38:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C4FD83AA9;
	Wed, 25 Feb 2026 09:38:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="K8ao5Duq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D43C483E13; Wed, 25 Feb 2026 09:38:20 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB73482A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 09:38:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oXReVnBnEU4x+8CMdK1/xnPzrEKkR+JFfv2gKCQ0AxMgBaDzxrE22DvBDT1CpRNHwaatV2/zlvFF9F5qAd88FtTmCI+saGPltePtk+OqUF7CRc59o3hj3p2GtKylgsH5uCGgyd4kChtfFs0s9s9yDAN7uFi5wDiMwp4hViNS9i97/6wZodnXcQol4wzbJQZRQ8QCfXlNQjsoYnCwqEBTGoI7o5w7uWYf9N+OgvPBrcpiPe8/MY0JyLSiAp0LPpjyoviwWNZx56RQ3wLD8Oeyp49S9aaS5IpvYYl3K689s7b33RF0COm9kpxgLDefghZR6JLONuGqoijMa1Yb+fBvUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPl4UXLlp/hPLnsu8cXJhwo54gLSbtLZ6sIPQj+rnbw=;
 b=NKbGMVqFHXeebIosvOqTjq9RuAyfRhNPR3ByNPYAk+FK2HXmTh4IGGQxAOlFBRGUwXoTMO85gW7oPpv5dO6/95kWSf5mOj/wILdxBkqnoSyZ1igr9vv+ErJBcu7XBNCT3Uz/ytDX8FK6MUXRpe+a64gfjH8X1pQzZvvXK33BKOJt09Wgm5gfJm4zW3q/dxfC75/eqm1CaMRQhNEk4zZ3omcPzB6a7qdKmwat+a9KIbRXNvnXXtf851g6JMA0w++T8q6NBsW4KellSEJuhiUdhGOPKf8oenKgiaWaC3bRE/gKEnZBKOXMmpkJEK1EgXgk6566w0vKnUpKqpbmwyWt/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPl4UXLlp/hPLnsu8cXJhwo54gLSbtLZ6sIPQj+rnbw=;
 b=K8ao5Duq9Es3OPLAyJvCVchOYLSXoBNGsVU1dFskpFnDeu7GTC1z1xEka7Wcqnj78c4SPpykAeK6/JkWzQvBQU0chBhtqI0SAAZsXydNMEeQRnDBbNPS3GrxvhyeZk4tjIrvuav3CQ86+CzfR0WnUjoM7RkZdkPa3CWBcckrC0U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AM8PR04MB7923.eurprd04.prod.outlook.com (2603:10a6:20b:24b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 08:38:16 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 08:38:16 +0000
Message-ID: <ee169196-69a3-4003-8531-0ffa4e76bf6b@cherry.de>
Date: Wed, 25 Feb 2026 09:37:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] boot: don't select non-existent CONFIG_VPL_CRYPTO
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>,
 George Chan <gchan9527@gmail.com>, u-boot@lists.denx.de
References: <20260225073711.51688-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260225073711.51688-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::7) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AM8PR04MB7923:EE_
X-MS-Office365-Filtering-Correlation-Id: d2bdb909-5eb5-40fc-a7d7-08de74493844
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VVRJUVZYRmVmb0ZUUVcvSk9wc2NDT0E3OVlhbE1NWmg4TVZRYnM1eTkrMXlT?=
 =?utf-8?B?S2Q4Y0Q2QU4zWklyVjFyS25NUkh3WVg2TDFtaUl4UkVLUDBRYW1adGRKcitu?=
 =?utf-8?B?SzJoYk5Kdit4TzZpNWI2NHNqUEVhcUV6RExieWpXV0d3emNleGxBc1dPNHh1?=
 =?utf-8?B?QlAxUkxnT3dEeDNPQkNuRWtzTExFVEl4VWNWMnp5SDZUYng5ejJyK01CYTJx?=
 =?utf-8?B?UmNDNmpPUFFDcVJSN2tkMDBXTTlIbzJIQVBXdTg3LzVUc3QwNTc4amx2cnd2?=
 =?utf-8?B?NW9Xc3NhTnVsMjVjUTRScGhGcXpUbWlFSXJZQ3BMcGZaRU90TjY0cTU1dW5B?=
 =?utf-8?B?ckg1QUxSakJMNTlHZm16cmo0UEpnQjg4bnNPOFpSM0pQQ1dMNWt5VTFSTHR4?=
 =?utf-8?B?U0ZYYnRtWHdUa0hXSFhvY2xhOW5SU3lacy9hMGxESWg2aUJXWUwzb1k5UWhO?=
 =?utf-8?B?QXVOMFMwbUYyWWp3QkxFN1dibGVwWWRHalllSzM4MjZMdkZGMnVHQlp2WGY3?=
 =?utf-8?B?ZW0wS2RUZnhxK2JiVTdsZ1RMK2NyOHR3T1QxdHFwM3NWcjVLWG5meExER3Ew?=
 =?utf-8?B?UHdMZlk0TFAxb2oyZ0ZrbURCSmswNldTc2E4bmJiM1Y1V2gxK21ieGVoR3Ur?=
 =?utf-8?B?dWVzbUkxTjY0UmdqUlVIVWRPZmdESU9GbmRDU1NVdldBSElReHBKOGc4eEg1?=
 =?utf-8?B?NVl3RlltRmdZZm5VL1FHUmlpb3hOM3MwaFhSd3VtWGVUMmwrSG1MVW9KZXR2?=
 =?utf-8?B?K1BKVHk1aW1HdCtEdzVaR3FqT3NaellwOVJuKzZ2aXdmZTBteVNkU0JNZkln?=
 =?utf-8?B?dlV1V0tRMjRrWmtxRG1jNGtVb00xOTFaR3A2cWoycVdrVXJJdFJxbjYwdDI2?=
 =?utf-8?B?ckFCS2pNOTdlT1IrSlNZaUxoWjZ5MnY2bVIrcTFFNkNwVXdkY085UDN2SU5V?=
 =?utf-8?B?LzgvTEZaNDNIRnJBb0NiRkRJTkhjbVc0d3Q0bjFVTitCeE5pbjR2QktQZ1Rq?=
 =?utf-8?B?Z0F0ajhlSldmalNFN2V6Uis1aGprelZHdWoxSE1MamVlNWdXNmFLSTB6UGlV?=
 =?utf-8?B?Ukp0K0RoVHB2eDlQSnFheVFWaCtPbjgzU0JneFRMTzZ1dzZ0RUpCQ2gvZWVP?=
 =?utf-8?B?ams0dmdBQm9KZHZMQXY3bVY4a1MzbFlSMnZINXYvUWVpS2Jaem9GTHpkUXVQ?=
 =?utf-8?B?d0xoRm9vRjkrRVZmUU0yUXcySjNqUzVVMmYzd1d1K2dDZXFsQlZaTnAzNXVt?=
 =?utf-8?B?V2wvTTZDeE13dytzb0ZaUENucW1IUjhSQ2w3ZjhrekxoTGNXVUk5dUtsV3JU?=
 =?utf-8?B?Y3ZKZ0EyeTBoeDNpbzJvaFNwMWxIaEVPdDZ3NlJIdS9mWXhndXhNb2owR1B6?=
 =?utf-8?B?aUo2M293MkRMWkgwV053ekVxcWliZi9nSVpiWlZRbHdaa2xWNmJGQUFpaEdT?=
 =?utf-8?B?ajM4NmdmTTVqT3d6OUk2QVhHR1JDU1hZbUliTUtwS1c1WUd3OTNkVUdGVDNR?=
 =?utf-8?B?RlJMaTEwZmhPdzFXQmUzUVFqNWJxOHFOcGdjckpkQzhUUkUzNEZTeHRZQ3Fx?=
 =?utf-8?B?VXQ4ZFlTazNyS3BNOUl6LzlkclRvY1RFL0F5WGVZektTVGcyTWtzSzdSMWxq?=
 =?utf-8?B?ZWp2S0FmMXBwbjFyUG91bENvN3hteFB5bHo3N2pubVpmd2tWSENBaFRUNTdG?=
 =?utf-8?B?Q1BIL0Nvek5EVmhLK1crdDNmU29GWHNaWjFjMUlnRlhLMFdyYlYzVHBUS0Fj?=
 =?utf-8?B?WVRJZUVoV0JVaSs3MG5JcndLM1ZZQ3VaVlNzc2xLR0VCVG1GMWZqSkROcjl1?=
 =?utf-8?B?SUV6MmRNWGI5ZXlndWRmSkpqNXNHQnlkanlDR29TNGlYcTQ1Tkd2RVlMU2hW?=
 =?utf-8?B?Qk9wMjRabDN0ZGRHakdjbldneDRKai80dCt0aDBQMmN6RXJEYnJlZU43b0wr?=
 =?utf-8?B?SDdlaTJxZEhQb3JwVDYyRUdBT29yVUMrVkJDaC9rd3NXNWYxSThFM3JENldZ?=
 =?utf-8?B?OHhoeE5GdmxsaFV3K2pSdlJQdWcxMXU2OXdBZ2NUZC9acnpvdmFJNXlKbjd4?=
 =?utf-8?B?L1J0bXJrK0YwRXlvcnpkVmJTcU4rUDlWZHAwRTZZTUZTTDlnZ0pYRzJNdU1i?=
 =?utf-8?Q?dnnI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGRwTHZJMlhWa2xCeGZoNFR2dllsSC94WFAxZ3hmRnhYdUNNZ3dQR2FVQTg1?=
 =?utf-8?B?M0lqZUFSWTEzN1NvdEltRVZQSGdTWk92YzJZbFduOWNUSWJSK2hsNkVMNWd4?=
 =?utf-8?B?WHFCRVB3SDN3aXRSR1NSaWZJbk1BYzRyUjdFck9rK1RZYkxtcUdPbjNHUjIy?=
 =?utf-8?B?cldUZXpNZGlVNm5jMDJmRnlSV1EvWUNwYks5QjhKSUpaWHVBK3dUaUI0VStV?=
 =?utf-8?B?Ri9kT1hjeWFRYWQ0bE9teWtpY0FNckRaR3d4ak9MMm44Yi83NUNzTGdmVW5r?=
 =?utf-8?B?RUNhQlBDWHlNYSs2bUhXWUtTc0hyeDhHSDUwc1ZkRUpRenR0N2YySzhZY1hv?=
 =?utf-8?B?eXdNcGpiK3NxSjgyQUFXNTVoampXb0pZc3FYd3Q2ZTU5TkFCSk1jZjAxODNB?=
 =?utf-8?B?RmRuSVd1TW9ma1U2U1FMV2FmZ0tXV2ZZeXh4U1VzWU41eEdZUS93eFNGTjRW?=
 =?utf-8?B?MlUwRDlKbzRxWmYzbHB4U2FrU2hkNW4ydzVCVzQvQ3lpd1U4a2NHZ2lSVmFx?=
 =?utf-8?B?bVZIeDFjd2x4UVpST1k2UzNIcTR3cmdWV2ZJbXVxckREWlQ2K3RaVTFHOUFh?=
 =?utf-8?B?dFNtNVNKVGZWUE5WNzVzZk5Qc0ZRUFN4ZXZkNFowTWhXWlVKVlJZekNOWVkv?=
 =?utf-8?B?VVkzaWt5Y05qVzhXNkNXUGdDVCtWNWx4N0RrMGJLNjUzRXJpOU5aTmh3eEs1?=
 =?utf-8?B?OXNKZHd2VVBFRkQ3WG8wZGRhbktOKzNQRWJzQ0UzTldUWXhHNERjM2RYbWhk?=
 =?utf-8?B?YVIvcDRBZzdrdTMzVzg0YldHQnJ4NnlydTZFZjlSYk1uNjl2Q2pwRGdvQ2pU?=
 =?utf-8?B?cXpzTU5mUGd5YjQ1UjBtTHhFT0NqcndKTmIvcm9aMHd2akh3STgvWEkvakht?=
 =?utf-8?B?WG1hNy9BYy9HMmhjRW1oR3VaNENLYWRWNzZEb2EyWE9QUDRTbW1hVUJTY0lx?=
 =?utf-8?B?c3g0UXQzUzVHMzVnTGdDdnIrenVveG1YbGg2R0VMSFNlMThZdmxPR0JYRGV1?=
 =?utf-8?B?d0dHa1FBNEFDR0MrMjczUmNlMkJITFUyNWdrM1JWck4wYzZVOG1TWEZKOUx4?=
 =?utf-8?B?dkYvdmN1eTFEV2hWNmZLUFFZQWpER2FOVXVuNmpJRmI1UVZRVjA0VlU3TTBJ?=
 =?utf-8?B?aW00bHpHcGNBdFNvd1ZoUHNxcEw1UjgvbDQ2SGQ2SmswbmlzS29aZk1nNTQ3?=
 =?utf-8?B?R2FWMnoxYkx2dnNPcjFGODJIQ0hkU2hjTEEyUlJuejlXVExtZ2MrTldkeHk1?=
 =?utf-8?B?SWdjYW15ZVJOM29rS1UyZm4vN3lSbkVWejBpNk9RSU5BTDFXOTZmUC83N0Fq?=
 =?utf-8?B?WnFWVFZKV09WWGdVZXk5LzdxMGdRelRLeDFKaFJBNTVtcDRaSjdZZ3hHaWRL?=
 =?utf-8?B?OEZPSmtrRGhDODdURFc2Tkk3ZjQvVE9QcDYxR2ZlUHgwZ2FEU2VLaHdFSVgz?=
 =?utf-8?B?TTBLY0NiRndxTzBicWp5MkpOdmdkcEhTVTZUS0J0Tm5MNVNoNmFhTk5YTXQw?=
 =?utf-8?B?dm9PTjUrMEROemoxT1ozaW9nMWZmVFRUWEdRS1RVZnFTQ0hOUDVCL081L0Zl?=
 =?utf-8?B?dDFMVG9zNmlEdTBZdndtbkhVanhtMFhGSUR6blRDb0dFR1JyclNpSVIwcWNu?=
 =?utf-8?B?RzBVUExjeStsMDVTdThxSjNaSzQ2TWl4cDVtbE9lUkJUeDRydFpPa2dtZFJl?=
 =?utf-8?B?L3Q2bXdqR1FURk52T0VsNndEU1I1YUtqNWUzVDl5OWRwdkpQTlNpOXNZSGZF?=
 =?utf-8?B?Y1dpYjl1RkVqRkt4dHY0ZGpCdG1BSW9icVZVeEFLTmd6S0k4Sm5VOGQrdTlI?=
 =?utf-8?B?cDlxL3d4c2Q2aHB0MlVkRVl4TUs4T0dFeDFMeXFmMW42TUpZdHk1U3gxQ3pz?=
 =?utf-8?B?RXMvbmxsL29nWlVoWnNiRVVwUnhOWlhTRHZTclBvWWxsTU5mQ1djdGp4VVgw?=
 =?utf-8?B?bmNHc3ArWkx2eGdGTTVvaHJ3dXlnR2xmVkxrcHhsMHgxZjA2V0ZXQlhSQ3A3?=
 =?utf-8?B?Z2o4ZEVwcEFkWGVGNXpSUE5zaUFXcUxPTmF4MHZwb3dwR3IvSm1JNzZvWXRn?=
 =?utf-8?B?bzBUeUNsZzdvdUJDdUMwMGloOU84YmVtZ2NhR0VieDc0YTRkSVBldFR0cVkv?=
 =?utf-8?B?L1FjN0FLc3AvbFBuOE5JNHU2dzRnQ2R2TWlvUkJLazY3VTNBeFFlVXJ5YmdZ?=
 =?utf-8?B?cERORW9WZlg5L2QzOWJiOTFMNlVyeWF6MGN6am92aU04aE9ISGF2d291RHFE?=
 =?utf-8?B?U0xRUCtrcmxOWFhxSDU4QVlqRURTS3dQOUEvWlJtMnQwdDMxMnhDcU9zV2ht?=
 =?utf-8?B?anhkQzNoMnBzcnpKNDVoVVVUeHYwTys2UWdVOTdWTmljSEJLRnZudz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d2bdb909-5eb5-40fc-a7d7-08de74493844
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 08:38:16.0084 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +xQ6UBcWObJEjeGb+G++YfJV3SsRinlcbdPJ6xMnOYW+fFfUqLd9fmxhNPOmE+2OGw3AVbERgLJfldvfarK7zAgHTyzjZfumujREY0mHLtA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7923
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

Hi Heinrich,

On 2/25/26 8:37 AM, Heinrich Schuchardt wrote:
> Symbol CONFIG_VPL_CRYPTO does not exist.

Correct but I have a hunch this was based off of SPL_FIT_SIGNATURE which 
does require crypto support, so I'm assuming VPL would too.

But this symbol indeed never existed, and even if it did, it wouldn't 
compile anything else as far as I can tell since drivers/crypto is 
enabled by default in proper and only if CONFIG_SPL_CRYPTO is set for 
SPL, and only SPL (checking for !TPL and !VPL)... so something feels 
unfinished with VPL here to me.

I'm not sure we're improving anything there but I don't think it makes 
things worse, as such

Fixes: 4218456b3fac ("vbe: Add Kconfig options for VPL")

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
