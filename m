Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A613C5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 20:17:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3A4281F0D;
	Fri,  6 Jun 2025 22:17:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="jwBP5d9g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BDC282977; Fri,  6 Jun 2025 22:17:40 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 283FB807B1
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 22:17:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QRo8gF2DEPjXD4HuA/zdYP7L5sZx7Qxc174hdRMC5mFQ5RKS2JzKqqKCn56TeS/gp9CeYU362OgHsSoRTv8S7tmoj6nVics4vBDAxjP67/o8J1FYkii961D64IsDiL76/qGGWs9rHeYQttvyk6m8GDmv8jf+xL/hZqpcbOD23WjAzL6YS/B/qFG1rgiOXDaSxhCI7GYSzTjQU7qPmju6t4XGxBCZmAdorpUKoRti4DR03OXS/tBSppO99KRJ/lcaCW0D/VyYDI6hVZOi/KBVA6PcnrszIj4MuvpxkChIEZtFRqHHffhV2OziZQ2iXffzCqEJctwzryHbgLiqzJBSvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfcJ6pG/kYEQMnVWZ+d29+sSHHk3kTjCZgqjfRSeLDw=;
 b=eRbpvstwvn39VALyIjXyN7BbNEZJQXLFJNidDO8g53A8eNjmBe3xBBptWanRbulcUyHSYpr2Cp4FJyNZmVbi1HUOs7OA0b/83M6+H2MMgY6ImNX2nJDaozlDDL8PHPRYNMVcBaDqpUwrrmZ496e2gmsjzGPjDxsazje+H2B9E8srRvI/quAaEuPMOdQ5D+XW4Bo9/P+csVHtT/8EQOiOvFKYYCMNuRijgEn94zb4vEjag88+mLSjeExcqmS+2GvoQYctEsrcPIKmUVrLtNHDK4YtWpCVyGG2WgnZI+2Hy4mGSf4Tvio5Mu5vr0nDQxczXmUJyZ+lbB2d/Fo7vw9LNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfcJ6pG/kYEQMnVWZ+d29+sSHHk3kTjCZgqjfRSeLDw=;
 b=jwBP5d9g746sb5WxmKi8LWudfhKOp6qfJxAv86WOJFxcwDJuQy9FWg2sU2SafTwgV5u5Pjo2YqjIY31syCHG8O8G3tUyQWFUmBNIBX1Ao4ikLfPUFtXCzArq+bqvUSU04elYuCmiMwfCrKGKRR7TWJWQLh1g39XhuFSrwEr5VxBHM0bjSo6THOgJUVmA9cBcLEK2x5Myf3uLBKtC5fe1M2cVPl/cH17LvvHppVhHt+PnCihZ4BpnZNuo8HFTCvIO5SrtdqbAF82uPOdo7WbXPpWlPF+yP0kRLcsGYMm1+DDqT5bYxj1rOo6MLqtrpAckoB+mZ5fLZidNTyHVg0pb4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM7PR08MB5399.eurprd08.prod.outlook.com (2603:10a6:20b:104::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Fri, 6 Jun
 2025 20:17:35 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8769.037; Fri, 6 Jun 2025
 20:17:35 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 0/3] drivers/net/airoha_eth: fixes
Date: Fri,  6 Jun 2025 23:17:25 +0300
Message-ID: <20250606201728.462664-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <6843478d.050a0220.6e23a.5ec5@mx.google.com>
References: <6843478d.050a0220.6e23a.5ec5@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::11) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM7PR08MB5399:EE_
X-MS-Office365-Filtering-Correlation-Id: 9887c446-e752-4044-1177-08dda5372c98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SGxsQUlLcFJmS3lKajZrTVd3MlAyTytZZThqWEczLzN4dUdqU3pnckFHU201?=
 =?utf-8?B?SlVsYm9pRmw2Rzl2R2NWNXFMdVo5cFFCcVkyN1dCb1ZLaEEvMUJKZ2RLeVp1?=
 =?utf-8?B?VXgyS0lQZExqUWV6a2x2eUxpZWU5UWFxR1l6bjY1ekdNaFR5Zkc0Z21jam9o?=
 =?utf-8?B?dW9YQWwwM28yRXdZanY5NFBRMk80Y3RZWkQyOEk3Ylp4SlZKcjJ5TjlQUXNQ?=
 =?utf-8?B?cjI4UWRGbmpjUnJPYmpoM096RlNjNXR4V2xaNjRTT0E5NXZ1WVlUaElKbUZC?=
 =?utf-8?B?RkptVEtXa2RXTGEwSVBNSmZDNWEwUWZQZ1ZRcmpWRkNSclgvS0pmZXU0L21t?=
 =?utf-8?B?RU5pRkN3L0dwaklDcjhFY3kzc1N0bVBwREpGZnVVam9IcFBmUnFMVmh2VDBs?=
 =?utf-8?B?R0pwOVlxWUFoRHR5WWJlYjFzUjN2RytOMGgzVlpVcTduc0JpU0I2elphNERI?=
 =?utf-8?B?UzBWSWpsdm5nK0UreUlwWmFCM0tpV0lGcWZvMWsvNjdvODl1YUhuR1pwcUpX?=
 =?utf-8?B?Z3ZSNTQvcWFHdVFFanZEbW0zZXJ6VkRyNlRTQWRLb29BaWtSMVcyenNWNUd4?=
 =?utf-8?B?aFk3VUFNZ1M5R1R5YWl3NCtHcytZdElsbE5UTTJLTWRRN3FkUDZOcDVsVVJs?=
 =?utf-8?B?RHBaYXhrenFwTHVUNU1sNzhUVGZ6QklMVGtzbmJtaUhRTG13VkhXWEFNZ2RO?=
 =?utf-8?B?L09qblNneHNiTGYvd0YzemNKYVI5SjUzZS9jTHBLWnU3MmRiWm1TeUM2bTMr?=
 =?utf-8?B?RWZDaUlWR0tZYmxmQXVzTjE2VU1FbDUwWWZNQjFWYkVDYlZCNWtNZ1YzSFRz?=
 =?utf-8?B?VVd2a1ZoSnZpOUpXemFVVjJiYzdQbkJOdU9VVU1HR0tpdXo5V2ZsSVFKTHdT?=
 =?utf-8?B?UWhtQldIQTNPTXRIR2Z2Tk9WQTZNcDhINEVFWnBNVFdoMGNzVDNPdTlCdzJ0?=
 =?utf-8?B?USthQjYyRGYxUmJYNHE4Wkk3dEM2NEo0bWRGclBHSmFYUjZJeTFRM3FnclpN?=
 =?utf-8?B?YWU0VHprbXpFQk1ialRYcG9lajlEcm1NOTU4K0lXb1hoVkhacjB4REtCbkxZ?=
 =?utf-8?B?c1lHWG1KeWpIQXpuc3kveDVQUkVHRjF0WmN1QU55VDMxQ2FwVGFJRUxvZlpT?=
 =?utf-8?B?VDRWZHZqUXJ3a201Q2xVTXd2WFQrb0tnbjdMY1MvblhxeXRmRTRqamNsZmty?=
 =?utf-8?B?K1o1TnpCL1FJeDhGNlZoSnBWQWcrb3ZjckpCRStWS1ZQbU1pYUhicHJDallq?=
 =?utf-8?B?UFRiRStjRWQyQ3hVeXpjWTkvWWJlMTFpQlpvbVVid1grUXpPa3VqQVJaR1pX?=
 =?utf-8?B?THZOLzJwUi8xMGNtUjBNNDhqUG9FamFDTHJKQlIxRTBrLzhvemNqMUkyNlg1?=
 =?utf-8?B?VjA3RW5JVDJhUEVOZ1FmUjBpdThMZUUyVkt6cjlvVkNSOXdLTXIzaVVwNlUw?=
 =?utf-8?B?RG0wZW1wNUptdVZybDdRdEYvYWEyejhVT012bG5vdHdWbm1meHNnbHRjejFH?=
 =?utf-8?B?M0o2ZSttTW9UYUtSYjY0VHhPaitPbzhVczl3U3hmMlBvejh1NVZ1V2tvYkt5?=
 =?utf-8?B?RFR6WFNIVzBicnJzVTFxY0UzK0J0c2FYTHR0cnp0Smk2NW5wV3g0NkFua2p2?=
 =?utf-8?B?S3dMdHh6d3ZuWngyN3M5cDkxWVFCTm9DeFBYNDdvQ3pjOG1FYXNjOXVVbHVy?=
 =?utf-8?B?UWdSdnM4NjR6enIxcW1nd291U1RrYk0xM3k3cWI4bTNacG5pTk5EL1BjdHFv?=
 =?utf-8?B?Z0FKbCtSVm9MWkdGTHc0YkFidnNvUlVVUHJMWW1UcE9iQ1QrNlI3MVpLYmtE?=
 =?utf-8?B?SllIWDArV2ZtK0lSc1czb0ZpYTQzRlJWZzc4Mkt2VTg3K3dMSkFhcWdOd1JR?=
 =?utf-8?B?NWdGUEVMdzQwc1lNOW1WdU40QXN2WEdrK280Qjdhc1VhaC8ySktGMmtYcXZL?=
 =?utf-8?B?THJxV2c3QzlUYlFMUDFzNGtZMU5DVGorMHN3NlVoSnp4VlJram5ybE1UQVQy?=
 =?utf-8?B?MUZNaUhEbUt3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWQwK2ZxZ0ZIemxXaS82c2FPMEoxa3BGYTJYa3FPVFV6UlpxRloxMVJGK3ht?=
 =?utf-8?B?ZE4reVg4T0t1VzdEc1pxWTZSc1lIekFLY2VZZW51REhlc0Zab3M3T3lZVHg5?=
 =?utf-8?B?UDBZVzJOdTByWThSblJhRlg2Zm9DdDI1aFpGd1JjRFgwOXlXazJoU2tCTXQz?=
 =?utf-8?B?WEFjYnJTc1hYeXlRaWVGVzBZclJPNlRBcW13NzFBaGEvRHFBd1pPb21oM1FN?=
 =?utf-8?B?L1ZJTVVITG9jT3ZSVjhydlhHdk9iMThPRlhIaXdPUTduZUdxbVUyZkVqZE4z?=
 =?utf-8?B?dDc1V01teUR1Y3RtYUFuVFVpSlpFZHJIZW9zc093anN1eFpldUwralN3SDVm?=
 =?utf-8?B?bEJYVzBNOFY3a3ZIYlRzV1krOXVtY1YyQnM4NHBvYWx2L1NQbTB0R3VYZDkr?=
 =?utf-8?B?ZCtqZTI0RmltZmt0azhRYnFCQW9VUlNObXhudVFDUlBqa0VWZzdXNklXbXhD?=
 =?utf-8?B?U2FXV2orOHdNMmh1RkMreDBOczBWMVRuU0VGL0JtTkU0N2xRbEpmSHpvRmlk?=
 =?utf-8?B?aklSYktKTUpuNnhlRG5kbjY0TmVLWmR0TEErNmVKZDdZa1VuVis2OElYNDR1?=
 =?utf-8?B?YSt0dHJzbVlGbFFTaHhxbWR5NEx2NFpINUpaNnFmUTFjaFlaNXhlejZWM3VO?=
 =?utf-8?B?eThjcDhKVEpwOG5paXVHa3cwUlB5RkU4bmFIQWhWVWYzczA2T2ZBaFFDak5Y?=
 =?utf-8?B?Y0NrOXJrcHZOTmllakdLK08rdmJXNGg1SUlpZGoxU0hFODMxQVE5b0JIbFZR?=
 =?utf-8?B?NWFhQVpFNkJvMC9Ga2pRdTE4bFo2anFyUE95eWNwb09xUnY2dit2UDR3NnJx?=
 =?utf-8?B?WmZBSTNoK2pucDZ6bWQvellVTmpIcDJPZVlDQktJLy9NbFlnNFpOTlRuMG1M?=
 =?utf-8?B?OWFQN2ZNVGVidlp3bWFFQTJ5UXNLNjVwR1ZXVWcvY2JwK0FTeDFjeXRyLzFB?=
 =?utf-8?B?eXlHTzhpd2JGMHpCeHpRQ2NENER1QkZ1NEJuenV3SE1WV0ZMSkxVbDZzd2VD?=
 =?utf-8?B?dmVqemhHTDg4bHg4YlRYc2xXYXVMcGlEU0FTcTVLbUNnbHhka3UyU25uR1Nh?=
 =?utf-8?B?VmdEUWhsdytWSE9zR2xFRldKWVI2anllN09jM2c5KytUbjdhSXN0MW5xWUho?=
 =?utf-8?B?VWF2SGw1TU44ZGhrVGJMWmkvZCtIMzJ4UXVYWTR5SEN5MCtyNTlPbEh2SWwx?=
 =?utf-8?B?NXV4K1ZlNWtmdytZaVB3Lzl4MVBJS3BtczhXVUZFYS9LdUUzRjQxWkhUUUg1?=
 =?utf-8?B?ZzdmRk5JeEhPelVueTgvOG5Mdk14a252a2V0MnByTWRwNUN3eWQ0ZnhhWDBz?=
 =?utf-8?B?M243YVFBWFRRN1l5VTFTTnVSSW56TjE5TXJvVFlWTzlYTkU3aFdzcTJxbWZk?=
 =?utf-8?B?c1Q3QnA0TURQcjhkSE9kT2xGN1R5WGd2TzNJWnhJb0p4ejYvS3c5Y3NtTjN3?=
 =?utf-8?B?TlBKRlRvaFZxbjNheHF3ZVVmeThCNEdLZi9IbnI3S3BxUzl4Wi9xOTNVSlor?=
 =?utf-8?B?SWJnTzF2L0JpaWNORzNndXVLQTlnTHRiZ3pnRDZyY0xtalVCMDduMld3b1NS?=
 =?utf-8?B?MFdwRVQ2c1p2U2liK1RHZmgwZFI3VklmQ1VwRlJtYUJrVG85SlgzR3l0MWV6?=
 =?utf-8?B?dk1paVVLYTRZMUxCaFpSeUFRTnAwYU5zWFZjR05TN3hHSmEyTi9VeEF3L0ZO?=
 =?utf-8?B?UFNoQkxaZG90ak5OQ2tpVFkwSWxpdmhMemFGcGdmcG1JcGljR051UVU5dEJu?=
 =?utf-8?B?d3BCM1B6Kzc5azBxTjJIVU80TzNURlliTkg1ak5hd0FTOUVXODBNRSs1Tm1S?=
 =?utf-8?B?bFJ0S2xKOXBRcXFWbFRKcDNRTXp0ZFI3Ty9vbkV4Wk8rWHVKSlZsVFBicVg0?=
 =?utf-8?B?Q2JIMlR3SHdrU2w4WWVjTzZhMkx1T1o2NzZ2SjB0QWY3Sy8rM0tjVVRaSHg3?=
 =?utf-8?B?akEwNE1tb2FwdURlRzRIZzZpOWdaZWcwc1l5SlkzdEZhYXVyNlRKVTJlL3Jx?=
 =?utf-8?B?YVBlMjJlN1l2SWtjeTRDV3d5MUcyVDBlc0Z5M3VKSWFiVkVpUWxaZUhWTlp2?=
 =?utf-8?B?ZXdVTlZmR2RNYXlIT2gya1ZPV0szVUVFN3pLWXp6QytPbE1mUDVtMFVJYnV1?=
 =?utf-8?B?b1MwWkp4RkxXK3ZaNzRKQ3ROaU0yMDNjZTNPNzAvZXpoWHJyemE0ZlNKNGpM?=
 =?utf-8?Q?pjkgzXWF0c4ECd/F+Df9n+0=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9887c446-e752-4044-1177-08dda5372c98
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 20:17:35.2112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m3CsTDnfRp9Udt4lTrUlIwU7RL2/Dl92dIElP4ZrJPgqJ3TjqS3aE3HgsJBhopkszzU793YScIy10chCuU/hDeG4OKtAKUrGSX+7JrpAJvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5399
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

several fixes for airoha ethernet driver

Changes v2:
 * update patches description
 * improve formatting a bit

Mikhail Kshevetskiy (3):
  drivers/net/airoha_eth: add missing terminator for compatible devices
    list
  drivers/net/airoha_eth: fix packet transmission errors
  drivers/net/airoha_eth: fix stalling in package receiving

 drivers/net/airoha_eth.c | 69 +++++++++++++++++++++++++++++++---------
 1 file changed, 54 insertions(+), 15 deletions(-)

-- 
2.47.2

