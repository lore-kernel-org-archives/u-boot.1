Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 135B5E77198
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 06:59:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A95480613;
	Tue,  7 Jan 2025 07:59:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VY1MMK2m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD56C80612; Tue,  7 Jan 2025 07:59:08 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83025805F5
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 07:59:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jMOPvNrVbda+D1vph1C0pfaFBoqsPrEY+zPmrRGxl4Z/xaYEgDcRwbnGLL4yE6VVFHYbyxhWl6pKTSZXYDW5iVjyI9Fbo7PGRHsdElBIRfWsNxZ5ZMAWVjQRQPdrkKam+mK7U9WaeqEjRdWY555PGwGkgK5zDOtyPmLr/5+QUm7pRpuF6NoYKpvXYUUTqwZs4CiQpyvkud65rPssc5vujz8djejtoi+KhoT1HJDmByjJElSh6tkOuM2pvDPoSnk85gPQYHwCvCiDhPXql6pZBhzqS5QHTRo8KKci1qHyKCznA/2a2FL7hXTk+5m/rXi/4J+At2RVuUuOLQ3PAHDuGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzSjFFM1DR1TcWx5tJJoCwCcVZ/715ZbU1pMon62uaE=;
 b=cFJ/9ePm4xcdoBZwErHdy3rpD1pTAXvzEWFEy5yyfFdPQHmR+THhov0e62DKtI726tqe2FvDm/b0EO3sphxzA22yWtps1ovdq8Dxh/nArVoxengirAhoR3HIW7Uzk5GYAjrmeQXScRmCsvtKb75pC3OAEbj1DpcIJcDzqk2gGe2tQjK4UXVEorVQ8bgOMgrteQKMEC8kkdVL9C1auuswv0/Ilaza744XUBASRjQS2toiNdDeXwWtIoRTOV9LsCM/xu6oRLtyDlgQ93Lv4U+Adjder25rYlXmtoqogfYFIL20VLhrbgq1OKIhflgv5W/Easl8FQrzyfBsoV0HhkC9Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzSjFFM1DR1TcWx5tJJoCwCcVZ/715ZbU1pMon62uaE=;
 b=VY1MMK2mx+QRojR0Wjj+fGcdveJq3ZkWhl6/S4XwBcGaQS2Q/2syFzQPWYPuWU6sXUm/A5C3rmBEPG9yISLNqjIpylsKkE8QpT1ESRbCGS4sGZm9md8xkIvWGTm/yya9LWye7FmWd/gfbaFAcpQ1uNnPNCT/mLIY80WPPuP6ltD3cIgKVtIxdHe1XBA3G2Hawc1QaH0GBj1Xah31fykAUQwzLs0Xccj7bdCHXjaEIuWyMJsPk1xzoRI9fyAwPnhj9hGgcvQMdwJjLJ2PtM2GMjTmEZcUILK0k+IiKFS0BZEm4UheOvKAWxY8h0kbfgilYFxS4CSezqhrpzlqV7ItWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS1PR04MB9478.eurprd04.prod.outlook.com (2603:10a6:20b:4d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Tue, 7 Jan
 2025 06:58:58 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.018; Tue, 7 Jan 2025
 06:58:58 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v2 00/16] imx9: switch to bootstd for i.MX93/1 EVK/QSB and
 i.MX8M EVK
Date: Tue, 07 Jan 2025 16:05:00 +0800
Message-Id: <20250107-imx-bootstd-v2-0-97671b1694cd@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACzgfGcC/1XMQQ6DIBCF4auYWZeGoWJrV71H40JgrLMQDBhiY
 7x70V2X/0vet0GiyJTgWW0QKXPi4EuoSwV27P2HBLvSoKSqUd1Q8LQKE8KSFid6YwZFLUl311A
 ec6SB11N7d6VHTkuI3xPPeKyHoyXK+s/JKKQg2Tb4sBZdo19+na82TNDt+/4DTAH1GqQAAAA=
X-Change-ID: 20241231-imx-bootstd-abbf2e9e0d75
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS1PR04MB9478:EE_
X-MS-Office365-Filtering-Correlation-Id: cc60dfcb-5732-441d-a0c0-08dd2ee8c1f7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXN3MlNFZEU4Z3FoSlNhVi9FMUdoSzYzcVBQSHZocWJTNFV2S2RmdGsyUld1?=
 =?utf-8?B?dWlnL3BlOWpIQ2FYRkhSTUxLcVNNQ25PNkJGcnBJT2ZlcVJvTlVXcjFYM1ph?=
 =?utf-8?B?OUo0clN5Y01vbDBFaU5QWFVmNlZNMVZDOVN2V2lNSHVGeWwrUHRVSXBUUHpZ?=
 =?utf-8?B?bU5KbjNiOXlXZ0hBM1lwRFdmLzBJVEk5UjFnVUJ0amZPam1ndFJGL0lhOEgr?=
 =?utf-8?B?cDlSWE5xUzJEZHFPaHltRDNTSUZpZXFPdXFuUE1KVEticmVrZmJIdkhwRzRw?=
 =?utf-8?B?WHNHaVRCcnlCWFNOVnUvVkRLS0RUWjE0MVYvdTRCN2NWcmlQbDJvQzZCWlZk?=
 =?utf-8?B?bU8wNlJyK2E1bUsyVXN1aG5kSGM3STJOYUhYOEM3eDhEeVBuTzZHQ0NkV3ZN?=
 =?utf-8?B?QTI1S2dIeE94blpmK3Q4Q3hyZHhBVUQxWFJqTkljUGJjbFB1MWN5U0VUOHdU?=
 =?utf-8?B?a2g5RFVFMzE2dEowNzN0TjQ5SXZ3TGRoRUxiVTRMUG4xODZTRVpINC9IT2Q3?=
 =?utf-8?B?KzNvOExrVGQ2ZTFFbUxUaTB2ZkRmTFo0U1ZNbTFNSm5UeTVTcGhvMzNSQlZh?=
 =?utf-8?B?VlZZSys0RTBCSEk5bXB2QmUvaUoyYW5nUEhMK01ob2dqS3JGVjBYUmd0RUo4?=
 =?utf-8?B?akxaRTlNRXlNaVZadkZTeWdDQTRSWno0NmFEb01Lb3huM0greHRrRmxuaFUx?=
 =?utf-8?B?RHFXZlNVaVdZRk1YanV2OGcrbTdUdTZ4KzcxdHN5U3BSNEhjYjZkbldVK2kz?=
 =?utf-8?B?S3orNmtHeUl5ZWo0QVliMzVrcHQzOER5Vm9nQTM3VWlvcHlMakxsWUNOT2V0?=
 =?utf-8?B?WXFnQkt6VFI3akE4REJYNzNVTjZNYUJIYmhKRXh3MDRpUlBvK3d6QkpWTUJQ?=
 =?utf-8?B?K0dsajFXYWtQTkZqWHljSld6NVJFZGcwQzF4dUk4ODM4MG9VclhCU1lZZGRL?=
 =?utf-8?B?RXVWZXhJYXBUbncwRGMwU0tXcStzYWdXcDE0TFVtWFdLa3FocVltYS9rTXBx?=
 =?utf-8?B?dExoUTRSanJFYStIc3hFb2VvdjNYV0NmeGg0c01EV3krVjhWMkt3Wm9QYkdY?=
 =?utf-8?B?Y3N3NXE4czlFUTNqT21MNlZhYkVjd2h2Si8zYjNreDc4VlJ4ZEo5WGVHQnlW?=
 =?utf-8?B?dTBzRE9NcVhSTkg0WnVhS2RLMEdhWktjRTdpQ0tsMS96aXdERit2VTczcmVh?=
 =?utf-8?B?MnBaMFFEeExTZFVNcGlVYTlCdTd0c2NmRS9Mc0FzMUtheklRbWRKSEVCWURJ?=
 =?utf-8?B?SVA4M0VTTjlwL2tFM1dGSXVQOWcrZ1phMkpSS2dDN1ZlOW5jUDhLWE96T0xJ?=
 =?utf-8?B?Y1NoY3ZXanZwUmdqRFlvV2NPYnNrdEU4dVlUOUs3Z2pSbTlDdkU1UWRzemdr?=
 =?utf-8?B?dGVNZ2kwWVgxT0NIZmliZTFYS2tMaEdnZU41elVwRXhzcWhpK1FmSEdLOXda?=
 =?utf-8?B?dENHbVNreE1WbmZUQ0hleUtETzQ4c3d0RVYyTFNtcHBES2R0MzJKNndBazgy?=
 =?utf-8?B?emMwdFRuVlNhUGFpeW9vc0N0Z3NMNG1VT2ZWQVBSRFBWVy9WcHBsdXV6ZE50?=
 =?utf-8?B?RnZ5M1JxN1NkU0lpMEZvRUhjNVA1Nm1jOWxSYjR2M0VJOGxUVFJjWXVhc05t?=
 =?utf-8?B?KzZ0d2M3bzkrbTF5dHRiS1RCbnBvb0ErVFlSeFh4NHlreEUvRjg1QjJMN0F3?=
 =?utf-8?B?TUhjYTZTVE9maW9adEZzZGtOYmNnSVZjQXdSZDE5aExnUVAyNTcxUU1KaWFv?=
 =?utf-8?B?Q2tVUnZWaXg2b2M2QTRUUjl5cm9yZ2ppUWlnd2ltK3dzMkdielZROE5UYXBO?=
 =?utf-8?B?MW1iY25ZVG9DWUw1alNVQVRMUmwxTElaQkVJeEdmZjhLKzFRSE9seFpqUXJM?=
 =?utf-8?B?UnRzSWROMjk3YkQ0OC8rWUlwcXFUck9Rbmx3TWVjdmF6NWpTNGovZXk3UURq?=
 =?utf-8?B?ZnhFN0ZCMjhwUFRkUzlMNEFXV2dSTG4yZDc3bGFkSm5SK2dtSHpCSmg3UDZm?=
 =?utf-8?B?bU1pQjcxUnJBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkgvQ1J1REpLbjBTQ1ZpZnM1RlEwN3VWODZFZHdIVGVGc2xLTU02NXpHazZC?=
 =?utf-8?B?Z3RZcmtyMFRxTS9JWWtGelZaaTJ3NWxwQVgwMDB1UU9iTCtwY3JrZlY3VWEw?=
 =?utf-8?B?dVpyQXB6bFp5aERYS3lpbitWYzQvUFIzUEZqcmFCYlFaMDdOUVFhaXVzaHNJ?=
 =?utf-8?B?aE9lalhTUlRuQWk3TWFDL2VrWDhmMjVZRjJQOG92ZERmdldaVlVtUVVGNVUy?=
 =?utf-8?B?aFllK1BkdHZHU212U1g1YnV2cVduYkdOdWtkaXkxRm80Mzlna1FGRVRFakZT?=
 =?utf-8?B?N0cyT0JCOFRpNy8xSndDOXM1T2dhTDhVRHRzYzduNlBNSjk5b3BsQy9icjA2?=
 =?utf-8?B?S3pDYUxDVG1SdlNac1gvbUtHdldjclRlM1JpVDc1bXJHOUwrakh5UUcvdW5T?=
 =?utf-8?B?elFDNUJOcmFwRXdtekRZQTVTdnI2aWFNcDdtcXhTMmxBc01GZzUrc2FpVmxM?=
 =?utf-8?B?VndHSklZOHNSanpyTDdFamZqM2VRYUMxUTNLZk16ZW1nazlkMjZSWmZ4ckdM?=
 =?utf-8?B?NDNxanI2TWx6cFRla1VhZjlUdTdzWVdvYmF0N3l6NnlWVVdNeEtoekZ3UDZk?=
 =?utf-8?B?bzB6SmtDZnByQ2pBYnJPVllDbmZ2bkVIQ29FTktkL3NRZkQ5cUhyMWFCTXdq?=
 =?utf-8?B?YmIzYXpzM2w4NG1lbENjcUZQQ3ZmT0VwQnlrWTAwVlV2VnZMZ1pVSWFYTHUx?=
 =?utf-8?B?eWw1Ym5FTmpJeDdSNWNGNzBlZkpuTkR6WW1NNklEL1JkclRJaHZLVExpMWpX?=
 =?utf-8?B?K0xVMHMwNWR5bFU5bVZHczIwaHlTck84ZndjUW9ocjFiY2JSeFplcm9hVlEy?=
 =?utf-8?B?ZU1PQnZoTHp6WmprQ2s0Y0ppaXZha1JZTE5ITzBQemhQZjZsd3oySEN4NGxv?=
 =?utf-8?B?Y21OUXpwQmtJa1poVlY5ZTBEK0t3N3FlRDQzd0V4MVR0STJmbkhSeGREM2Rx?=
 =?utf-8?B?RkQyOXVHYVJaZkRYWUhPL1pkMHZwTW92L2FNaDJVYlovU2lsMHM3eDdoNVFV?=
 =?utf-8?B?YTdFMHdjdkU5K0dMd05JTDhTZjFMWk1qSFZGWnRsZkd5N0RyOWJyZHE2OVNv?=
 =?utf-8?B?YWJPaUVoZ1l4TndiQ29uYnRyamVzSS9qUGZHOEI0S05lMHVjbVBYUUlUVXhQ?=
 =?utf-8?B?Vlh6SnRnRFBBQWR2bzhCL3BvU1l4VDhrd0JBVnNnM2VuQkpyUnhaTkphVnhS?=
 =?utf-8?B?MU1selZXU0ZvY2VtdWxzaFp6K3pEcnBYRndNdm5rMzJzZFIwNTg4dk5RVTZR?=
 =?utf-8?B?TDZ6WWxsV1ZBaG1MaWVsVHZ5OWZ2bjM3VVgzek00UUVkNXlzK2JmdFdZVDZw?=
 =?utf-8?B?MUZzcUJ5Ym8rZnZrTzNlZzJEM1psYzFQSkVpcVZkdFRzSWtyV080bUs1STFP?=
 =?utf-8?B?Vk1YV0U3L21IL2xSM3RxamQrVEg3ZGJaMEhiTHV1cjRYblpIeFEyMjhKc3JN?=
 =?utf-8?B?K2d5YVZvWlJHdkhmOTM5NnNFV0lVSmRZbVU4QldpcHg3MzV2dlFYMHZBZkJq?=
 =?utf-8?B?a3N0ZHQ2aDlKWVVJN3VQV1dFZVcwSzlEQUo1MGhtcVFsK0xQQ2JHSTFrMmRx?=
 =?utf-8?B?czhDa1hmZEt0VDEyUDI2U3BnNDRtaTRVMHZQb3BjU1BBQW1RZDVIOVpaWTJk?=
 =?utf-8?B?SUVQekpMVm1XbmNHWjZqcTJSaUVaYVVOM1Y1TGppVVo4WTgrRFhwMXRpVjVL?=
 =?utf-8?B?NTNrdlJDcXhUbE9EaTlkZU81bUwybU1pVHhpQXEzTGxrMFV3SDNqVHEyQ3Bk?=
 =?utf-8?B?TWJibWc4dnI0RVFoN2hicEgwYk5ZemVHQndmQ0lIblU5d0dKbzJqVHR5RndW?=
 =?utf-8?B?WHFGUm9CckorcjhjTkgrUEVJTWh3U2lBOTh4WEU2QWtLdFhuQ2VtVVNNR1pE?=
 =?utf-8?B?eFBPY04rUjRENFFoSW8xZWhpSWRtTEE4N1F3a1hwNndCckw4Q1hqaFFTS0Jq?=
 =?utf-8?B?SEJPTjc4OXFDTFNHenlPYmt0NUNGd05DN0VjNjdRakJ1TjlCdG1DcFhRQlRz?=
 =?utf-8?B?MUVjTTh6SmdheHo4a1VFdDUyUWtZMkFaRitGNzBubUJycGh5UEFLL1RVb21R?=
 =?utf-8?B?S1NsVXhpcHNyN3N4aDAySHJPOVgydERiWXlHQ3VFQjFVR1JlNGRIVUhxeUZJ?=
 =?utf-8?Q?ARoRtWUYiDw41ofZ6pc3HAeCR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc60dfcb-5732-441d-a0c0-08dd2ee8c1f7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 06:58:57.9645 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IfNvm5hIR6K3JAOgEq11sk4Uczrqzq/n99BSVWaglrq2Gs5jcvGD/ZS3h+wGrbFCwdL/oyTc3U25MZ6qYRnnlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9478
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

Switch to bootstd for NXP i.MX9/8M boards with a bsp_bootcmd as fallback.

Some cleanups are also included together with this patchset

CI: https://dev.azure.com/pengfan/uboot-ci/_build/results?buildId=16&view=results

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v2:
- Separate cleanup headers to separate patch
- Separate drop global data to separate patch
- Drop CONFIG_ENV_SOURCE_FILE since same as default
- Link to v1: https://lore.kernel.org/r/20250104-imx-bootstd-v1-0-e09618cc1d65@nxp.com

---
Peng Fan (16):
      imx: imx93_evk: switch to BOOTSTD
      imx: imx93_qsb: switch to BOOTSTD
      imx: imx91_evk: switch to BOOTSTD
      imx: imx8mp_evk: Enable dynamic settings to mmcdev and mmcroot
      imx: imx8mp_evk: Switch to BOOTSTD
      imx: imx8mn_evk: Cleanup headers
      imx: imx8mn_evk: Drop DECLARE_GLOBAL_DATA_PTR
      imx: imx8mn_evk: Enable dynamic settings to mmcdev and mmcroot
      imx: imx8mn_evk: Switch to BOOTSTD
      imx: imx8mm_evk: Enable dynamic settings to mmcdev and mmcroot
      imx: imx8mm_evk: Switch to BOOTSTD
      imx: imx8mq_evk: Cleanup headers
      imx: imx8mq_evk: Drop DECLARE_GLOBAL_DATA_PTR
      imx: imx8mq_evk: Enable dynamic settings to mmcdev and mmcroot
      imx: imx8mq_evk: Switch to BOOTSTD
      imx: imx93-11x11-evk: drop duplicated nodes

 arch/arm/dts/imx93-11x11-evk-u-boot.dtsi     | 118 ---------------------------
 arch/arm/mach-imx/imx8m/Kconfig              |   8 ++
 arch/arm/mach-imx/imx9/Kconfig               |   6 ++
 board/freescale/common/Makefile              |   2 +-
 board/freescale/imx8mm_evk/imx8mm_evk.c      |   3 +
 board/freescale/imx8mm_evk/imx8mm_evk.env    |  67 +++++++++++++++
 board/freescale/imx8mn_evk/imx8mn_evk.c      |  12 +--
 board/freescale/imx8mn_evk/imx8mn_evk.env    |  67 +++++++++++++++
 board/freescale/imx8mp_evk/imx8mp_evk.c      |   5 ++
 board/freescale/imx8mp_evk/imx8mp_evk.env    |  57 +++++++++++++
 board/freescale/imx8mq_evk/imx8mq_evk.c      |  29 ++-----
 board/freescale/imx8mq_evk/imx8mq_evk.env    |  60 ++++++++++++++
 board/freescale/imx91_evk/imx91_evk.env      |  29 ++++++-
 board/freescale/imx93_evk/imx93_evk.env      |  88 ++++++++++++++++++++
 board/freescale/imx93_qsb/imx93_qsb.env      |  29 ++++++-
 configs/imx8mm_evk_defconfig                 |   3 +-
 configs/imx8mm_evk_fspi_defconfig            |   4 +-
 configs/imx8mn_evk_defconfig                 |   2 +-
 configs/imx8mp_evk_defconfig                 |   2 +-
 configs/imx8mq_evk_defconfig                 |   3 +-
 configs/imx91_11x11_evk_defconfig            |   3 +-
 configs/imx91_11x11_evk_inline_ecc_defconfig |   3 +-
 configs/imx93_11x11_evk_defconfig            |   2 +-
 configs/imx93_9x9_qsb_defconfig              |   3 +-
 configs/imx93_9x9_qsb_inline_ecc_defconfig   |   3 +-
 drivers/gpio/adp5585_gpio.c                  |   2 +-
 include/configs/imx8mm_evk.h                 |  22 -----
 include/configs/imx8mn_evk.h                 |  30 -------
 include/configs/imx8mp_evk.h                 |  21 -----
 include/configs/imx8mq_evk.h                 |  22 -----
 include/configs/imx93_evk.h                  | 105 ------------------------
 31 files changed, 444 insertions(+), 366 deletions(-)
---
base-commit: ec9263b4f15c4cf82eb6a211c67baa6385065b8e
change-id: 20241231-imx-bootstd-abbf2e9e0d75

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

