Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E17D3C3ABB2
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 02:31:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1851888DB7;
	Tue, 17 Sep 2024 04:30:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="O7rnR4+e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAA9988D9E; Tue, 17 Sep 2024 04:30:45 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::61c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CBD488C8F
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 04:30:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MfH1VBGhmQLyuQug1/poyFjEUVRgO/ZvCkfh2/Yqdz4HNt/maoFIG+s43+Xz78oxrNl8WVRK1mVX2tu0g76ZSFXPTlQERZ+kKYf9RCSBfyLsiRgb4dWtNkRkVE1sP889GwfIEuHBHCU26u0+zSmyCSD2Lf9oPoViBcjC+vnzJnSo35bGPSbbl85bgn2urni0a0HMwAOkIknlTDjALw27g60PotG231nCZOvmTfXloiq39EfT1rOmHCdJTA1GnTYfp/mykWBOIKTbjLMf8NM4lPmnSZ7b+LJUKZy4tAmROHs7Yi4kR5LwkGOQ+br2HJxFTeZAZuoqveLN/aXhpYFEWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZhDEhzS61Vkv9bDnfT6AoH9BA5bZuhIKaRCRi4GWIvQ=;
 b=rgQrxmT0teIDSOxwaTAEw4T8x9LxWIS6Td1LY9q37nIRRn3YgRmI/N61o8lzwekvqus9My5mJQiQT2CNP62scSBeqJr6Sg72DsU2NPaKWc60DzlDTw4T2BoIX81iZsmZAU6tWjGbBvq/cQkEHYjMe/+nSkr9ptOsGdza4PPND0c/rsuSOHaE8JCbllZ138Jc5yuPwxf4gGSaMuUd5DDmHdKm1qHksVJfXa4GgGaMP35cyLRKusE7ZJj/z27mU4FhG1zk8OAl4+BcJJRbobBWyi+7O+ev+R60JlGLY45Nz+73WcdJqaJdigqqociolecCzWfj3B1s9cTElAi7EhMksw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhDEhzS61Vkv9bDnfT6AoH9BA5bZuhIKaRCRi4GWIvQ=;
 b=O7rnR4+ejd0Ap5EmUbJ4Ghuh/RM57FK6kZW5GC9b+kCMPFfU/x+7bYWG1L8wtlSCMq1rUqek5RF3zhQxiX+GN0b0H0eWiIoE/uzVrQMS/tNAFsoKfZ/J/riqVMPYvjToilSIl33V08DBRyURdtBpdH2podVRexEpwAeRzaN+mGjA6glTINp5nBCD6x42sxKgzyxPkGTRkj7g8Vd16OSCS0nKcocr8HiuFZ5UBNKXehk5D8L1pS0BbwXB6KUVZkbx4eMZtooy1JNKyOT+b6/InaUs/Y+j4nwSe228rMd4I/vBNhfyBkDQEf78rqRyYTShejk7IMdn7o8QwiXZoYI0VQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7493.eurprd04.prod.outlook.com (2603:10a6:20b:293::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Tue, 17 Sep
 2024 02:30:42 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 02:30:42 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 17 Sep 2024 11:33:55 +0800
Subject: [PATCH 03/21] imx9: soc: Serial No align with rom setting
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240917-imx9-update-v1-3-4fe8effc937e@nxp.com>
References: <20240917-imx9-update-v1-0-4fe8effc937e@nxp.com>
In-Reply-To: <20240917-imx9-update-v1-0-4fe8effc937e@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: 477cff20-43bf-469d-5202-08dcd6c0b9f1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjFkNXFheklXOHFKZ2NVMENCNTVYTkhISGZqM3VZdytEcEhpQXNsUXZtazhQ?=
 =?utf-8?B?NjEySmxmS0R2d0FmaHltZS9xS00vK29vSHY2dUQvYkV0L291RFpJUXIrb000?=
 =?utf-8?B?WHNyeXdmTVM0WENmRzlkOS82UitTNnR3MDBJU2dUNlgyTThGR055WCt5QjJF?=
 =?utf-8?B?THdSd0Rha3JJcG51RWZSN2tPeWRVU3M4MUlvME4xUnI1NkRib0NlRmlzcWYv?=
 =?utf-8?B?UHFaMkVsUkdrdE9JeURCRnJ5djdKaUVxRTE2aFVEa2QvaTJKTWVYYUcwNk8v?=
 =?utf-8?B?S0lraGhBdkVXYkxBbDhCenl3b2ZJMENzSGR3enlYNThadGRlRk8vVE9QM3pW?=
 =?utf-8?B?NGoxRGR5UVJ2anRTZE93MzEvc24wckYvVXNGYWtmNUNEVHhDN0NFUi9wMk8y?=
 =?utf-8?B?bkNtRGZHcHkwNng5YVEvT2RlTTdKd2JpODdLeHJwcktKc2NrNUU4M0JjaXA4?=
 =?utf-8?B?R2dpWkNCTTNmMmVxSXBkY2pwYXpyYXBRMENNOVlIUDk5S2hpY2JzaU1FY1dq?=
 =?utf-8?B?aVRhdHh0NE1aOHkvWTd4N3RBOWhJODZObE5Cb0xPTXRJU1RSRDkwZU0vckRO?=
 =?utf-8?B?SVU5UnEyakZEV3pZd3daOUdUZ3VvRXo0R1VFVlhUallYdFBuM2NzOEQ4aG5n?=
 =?utf-8?B?TjZGK1FxMTViNENvM2VqcVc2VlJrL3pnMXZ1WnpXUjlHTVpWZ2QyKzdmWXc5?=
 =?utf-8?B?NERaeHV0UlFvZHUvRDVWbjN3Z1ZBQkxmR0hGeWo4S1dmcWF1b2MzaHRpcXZl?=
 =?utf-8?B?bzVPWStkUmkxUFEwbnF2RGwvay9nbkdkU29OcWozVDFLMVpZWmY4TnBlSTEr?=
 =?utf-8?B?S281WGo5MFlwcGp6ekZEOXY4Q1ExNkNxc3lscUNPMjN5cWRKK05kR3JFSkJv?=
 =?utf-8?B?UkNOOWYzVHkxaS82T0ZzOHlGRXJsblNhSGVPRG5VOExjdlc2ekYrSGlOUlZw?=
 =?utf-8?B?VVZiYjZJTEtVOVBrV0xieVE3cG1CUmN1M2NORzQyTFcxZHZSd1BROWUxb21W?=
 =?utf-8?B?R0J3NEF1a2JlVmlNY21HTUtqVnpLSTJKdUFPQ09sVW1FRUVJdVp6U1EwVWZv?=
 =?utf-8?B?bURIQXJyWGRUc0JUUjZOQ0tLa0tyZnM0TmhCeitxTm1HeWZFYlArZmxLd1dy?=
 =?utf-8?B?QTVzdlpKMVp6V2JvYW84bXNKUHJ6Mm0yc1YxRkdxSlViRlpBRjNpcktYaVpB?=
 =?utf-8?B?VWVxTldDKzBoQ2x4T3NXOFZLeDY1d09tS2phZ2pvYmkyTHAwSnhqbXVCdk5Q?=
 =?utf-8?B?dFZiVVZEMmMxdXlBZkd1cU5RdW9SRVZoK2lCMGNYZnpnUS9NL0xGVUkwMXFG?=
 =?utf-8?B?YWs3LzcwR1N2RHB5SzRudDI1L3pSWDlmeGhaWFV5eUg5VVNtYTg1alA4cG9N?=
 =?utf-8?B?aHA3QXYrR3AvZWRRaHpyR0pHMHI3T09NZE9YWWtkdG9CSURVNnArc3o3VGFX?=
 =?utf-8?B?Q3Qya2ZkeWVnV1I4ejlBdEY0c2JpZUNwRGtKbVBKUTczQVZNekZTbzBvdVpk?=
 =?utf-8?B?bTRKSlF1ZFFyT2Y3bTFQbmFmSDNTWXBzMzFlQXpLZ3c0K3RMR2VBRURnTUli?=
 =?utf-8?B?TDFDYjlxKytRa2xLREM3ODNhcVFJRll5YzgvaFNhazM4ZDNFekpkRDZrbXd4?=
 =?utf-8?B?a1FndXBIdjBNdElSRWxESFh6QXNDSjBQRTBhZFZ1TGt2cjVxMVZ0ZVp2Z1Bn?=
 =?utf-8?B?SENtNkQ2Z2h6SnVab25oVG4rci9mU0F5SEVqKytsT1FESy9mcWNYaXNpRHJS?=
 =?utf-8?B?Q3ZJRUw0TFZJaWJKNElwM3NIYmx0Z21GWWQyQTk2QmNNUTdTTzBwdm44cW5N?=
 =?utf-8?B?U0xCaitmamx3TkdWRmdLS1h2MkJPM2pLRXJjakV2UHBxd042UndLOVBIT3hk?=
 =?utf-8?B?eVFDL0VZbnpycXU3MHJsMnhvR0xvbjc5cE5obTQ0ODl5WHc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eS9pMjJsMjhvZHE5Ri9xTVVuaXNIMXQvaWl2UEVBWW14YXkrR3dncm8rVlhV?=
 =?utf-8?B?cDdmS3dTUzI4S0FtOWxWQS9rOTFVQWFaYzFlMWdZUlJKeTBxYWdpVjcwdXBo?=
 =?utf-8?B?LzlId1ZvOC9EdWhxcHZsaW1ZK08wQjBxNVEzc05CS1dkWjVaRXR4RG02TGVO?=
 =?utf-8?B?N3lnSnhXdms3WEhjVXArYTBGR0g5ZDg3WVh4MDBlYS9LY3VUeHVpb3V1RTQr?=
 =?utf-8?B?eC9ZV2JVT21ZalhlZGFDd0t4QU9PUjFtcHJQbFJUU2tMUGlyVjk5Q093WU5s?=
 =?utf-8?B?aWVlVFdXRmVMVVk4NVZPWjF1cFBhd0R2NkxwMVUwV01vejBvNlV2NFJyRmNU?=
 =?utf-8?B?bVJuWitZVTkxcnM1Z1NHS2w4eW1JQzhOazhrcGhkS3BFbHpsWlhNRER2WURu?=
 =?utf-8?B?b1hlV3NnVkZPWTU2YmYwaElHY1pRTnJETlR0ZGlZaDJYeG5DZGhEK1RBSGh3?=
 =?utf-8?B?K0h3OSt3Q3VrZTA1cTJGTTNwZHBKMEFLSENYOStIYS9uREJSRGdjdGp0YWtL?=
 =?utf-8?B?UURqMXVYVElSeUZDUkhiTlVqK3ZaOHJlcTFJNXc3dGV1aWZqUXlZampreVli?=
 =?utf-8?B?cFdyQVBCSXU3MzNrQWtTM2YzSElsMGplV3VEZm1SQ2ROdE1qMTVtVi93bVNB?=
 =?utf-8?B?bStDQnJJOUttcmYyUVhud1Vka0NRb0hmbXhUWjZJemRPUnA3eHZsT1p0ejc0?=
 =?utf-8?B?b1ArZ2JFVjJScnJvQ0hSa3pDT3h4VjRnbHJxVkZCWGpwVmtKVWZBQ3B0aHVt?=
 =?utf-8?B?ZzlIV1lmU0NNSC9OYjRLNFVwME5PbWFOY2s4Mjd0eGFrcVhuMGluYVgvRHZn?=
 =?utf-8?B?VEFiUW53TkdVeklILzdsT0N4NFp0dWsxRWdtUXV0cXB6SjhsZEVFeUl2SHRq?=
 =?utf-8?B?cFdiVHU3UUNkMDBIMnAvaml6dit1bkZyeGpYTTlQeTEwNlY1VEQ1aDgySkJk?=
 =?utf-8?B?N3BIRnZWUU5EeVRQdG5RNlp3VElER0d3OFh6d0kwbEIzeGF2WHZnZ1BldUpt?=
 =?utf-8?B?ZHFUSUp5M1IrWVI3OUJ5RGVoNDJlWG1hRjFVOVUrWVdZSEF0bEJrRm0zM1Zs?=
 =?utf-8?B?RkxxV1hkVDlFQThsLzNRUjB0bkcxTjdTQXlLUjdhdDJXVTFFUlR1L0dHUldV?=
 =?utf-8?B?RGkzSFE5NTlvZkRDTkY1bFljb29UMUtpbi9DN0dGRklhb1RZWTJHdndLaFVt?=
 =?utf-8?B?SmpBRUVRU3NFSXZXdUsrQTBWZkdmdlUxVTlEamJIcklEVEx5Nkh5L0kvNG1P?=
 =?utf-8?B?M0htNmZGbGhaSzlxN1JyMTFKekhXQlY5WjVQYWlrU0g0c1hjSklTMFA5aGJq?=
 =?utf-8?B?dG9iVHVxcys4QmdoWHNPQ0M1MmNYSjBnQzBDUWNtWTRpdGM5NXdmOXNXRXF0?=
 =?utf-8?B?YW5PL3VUUGxyZFhOSjFEUVd5b01MMlI0d1RBdUEvZ1h1SS9rVU5HOW4vSit1?=
 =?utf-8?B?ODQrTmRJR2V1MlRoZVBuM05NWkZZNUkveDNiNVpWYzBUb2NPMTZUci83SFBM?=
 =?utf-8?B?a2RDeUtvUjB5dHZDczQraTNsaTExMGcwSXdrcHJPQytySVpIa2ZLdHl5WDlU?=
 =?utf-8?B?ZUFMazJJSzVXVzdDUEhncDRqemlpVThyaFhSeHJjWWJUYjduTTBXcFNRWGxG?=
 =?utf-8?B?eDZ3ZThISXVZUXcwSjI2VXFFRUhzZFBnNFIvalRldHpoL0RiVWpOSERoSkJ5?=
 =?utf-8?B?QnRVM29wZ1BsZzNSNkJqT0lSU0s2ckQvNThWeC9LeFpia3RsRFpGVDFiYk9u?=
 =?utf-8?B?NXJ1Z3ZCOHVRMi83WUlkWFlTVjhNZTdTakxTWUQyQWo5eS9zQXBiZVcxYTR2?=
 =?utf-8?B?Y043QmNzNGpBa0JqQkVCZkVzY2llQkw5RHR2VWRQQy8xVXRYdnpMeFF5ZVEy?=
 =?utf-8?B?VG5HVVNoNmVFSXZYdnRCLzBaTVFOcDJzR0lhU0FWVytYQ21qM0NVMUt3Szdl?=
 =?utf-8?B?dDYzdldzU3dSWmhRUXhlVHZWNllTSWJSekUwY2pIYWhEVnlNTTF0TWtHRnBD?=
 =?utf-8?B?TE5GcG9BVkk2b1ZJbWNuV2ZzSDREQUpOcVFUNHFRN2FYaEZlUm9pdEZrWVFV?=
 =?utf-8?B?aGVmc0FXTDNTV0FoM0gwQlhteC9TTGNENFl6SjZQMk94L29GdWEwNWFqTDV3?=
 =?utf-8?Q?F57db7xlGBg3YdTXh2/yLCDsH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 477cff20-43bf-469d-5202-08dcd6c0b9f1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 02:30:42.5076 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h+yKuHasvAqR9a1Z32LTXHSJXdZ3o+iOABHScN8HdfCMbeh8yTTjq3ZYHXaZbMH0bbnAekB9uX0LzZbH5oyj/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7493
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

From: Frank Li <Frank.Li@nxp.com>

ROM use UID[0] and UID[1] as serial number with big endian when usb serial
download.

After update this, uuu(>1.6) can use below command to filter out devices
when multi boards connected.

uuu -ms <serial#> ...

[sudo] uuu -lsusb can list known devices with serial# informaiton.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/soc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 25b9116f2a6..f458fc0564e 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -563,8 +563,8 @@ void get_board_serial(struct tag_serialnr *serialnr)
 	printf("UID: 0x%x 0x%x 0x%x 0x%x\n",
 	       gd->arch.uid[0], gd->arch.uid[1], gd->arch.uid[2], gd->arch.uid[3]);
 
-	serialnr->low = gd->arch.uid[0];
-	serialnr->high = gd->arch.uid[3];
+	serialnr->low = __be32_to_cpu(gd->arch.uid[1]);
+	serialnr->high = __be32_to_cpu(gd->arch.uid[0]);
 }
 #endif
 

-- 
2.35.3

