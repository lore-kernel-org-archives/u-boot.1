Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78EE2CA0EED
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 07:27:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F16C980FA1;
	Tue, 19 Aug 2025 09:27:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="PweUtZoy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 163558211F; Tue, 19 Aug 2025 09:27:42 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D01B802C1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 09:27:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nuV2JmkoTGUDDxlw/AxyGYUDBJIqIsxQ7Svkx8Q7Ppfp5mInZYpMH7rsZrvOEyKKpPr8cNvCENLCOBacujOKTuXnUuIX/dqfEFUiU9ldVaP+imIeA8xlyM7U2nZCIb/ityr/gzE+35zKcKe7Bsva1wPBiV2DR/nGQex2HK3xKxIAFAil8Z8vhXPX0c8SSnpGKQGoLicGrNQqhEkzUO35xOn1gDmeY2aFbTVdXhiGhJfbRzopFYOHVAGTTIjgJ6g/IxOMCOtL00DWdMPmGdxnuWxX7G3g6eCNQkzb197rpI7DoQfMpXFeSeN026WMVJuMdpCt9vOTbW/PpKOnQ60J2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVxTmJMisNYOFYftZEQO60y0qvsKnEovW04lQCsH2ZM=;
 b=f+ZHx4NOUJX6aa4jYqDK3f4FtyDd6TAXzw4ooBcW/uUMH8ppvR8sYlcZ069RlwJWvly5MjAl56Bb1+XaY69tiFMP9/09yxQmnVKq+Bg0ubcQty+cOcHH94cAoSzgxrHZMRDwyPlrlk+LFkZGFIxSvyz1S1h0OckOz8DtOa5t4j2tW7RpPASeiBuQn2MVyT5N5vQipBF+PD3l4XUmRm0PDBMTwX3g13YUvCdhe/y4hMzp8uwjpIJsKteFG/VjTz2SOeT1yVaeykLc73+u/IOvYR713BzP5q5pCL8J5m6l+YDagBjXwWYCESR0hq9O3SOzxn4XEwQubDGcbrS8AwOEQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVxTmJMisNYOFYftZEQO60y0qvsKnEovW04lQCsH2ZM=;
 b=PweUtZoyQBgRl0122D94E8QFvmjpHAmUHsYb81BPDWgMKOhQkfmMhtOY9o2q751tKVh3Rdd6EPuVMv4fo4QbPC7UGXl90Yf1KpSMn7N9xKul8XXPpTbzVwK6CY+Wmo/rIuOrnwKzGW1XMq21fca+wCM+kTl6qqVyxhVx6C8SZ4J83vY62dcbTCmSohp4HmUCrnv0fZ9XLRLNdcLEcWLdRbN0rN5/8LAt7lvG8RsDY0fKNDabGsV069ncDHBGk6xRrgx0oEJ8gB+JqOlni4QJEKVMJBQn0UjO4fy6KOQ62nYlnGiFSesdREp64tLMF83RfOybi9fiMrVT1GBgwhFAig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AS8PR10MB5998.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:52a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 07:27:38 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9031.018; Tue, 19 Aug 2025
 07:27:37 +0000
Message-ID: <40fc183b-3c65-46f2-98a6-ebf8c7ecede7@kontron.de>
Date: Tue, 19 Aug 2025 09:27:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 20/21] mtd: spinand: Add a ->configure_chip() hook
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
References: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-21-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20250818100614.432931-21-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0328.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::7) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AS8PR10MB5998:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c15efe1-d7a7-4a69-0fa0-08dddef1df4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|7053199007|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VVhsUFhmTnVYemZDTU1qa2c4NmQzbkNPc2lHdEdURnVGaXBSbHowTXlLRFIv?=
 =?utf-8?B?TGt4eDgwaTdXT3ZoeisrQVhBUGd4YlVMNjJVQW91SW54M2lJVzNXbzFIRWZy?=
 =?utf-8?B?SHhJeEZydUYzU0d2MzgydkRadkY5cGNwWU1VMnpTNkNkVzllclNxSmI4VFJG?=
 =?utf-8?B?RGdCTXY0OWtIVVN5L0VYOVovVHhBOTBPc2JrdjRxdVA3ZFVGMUpnZTd0d3B3?=
 =?utf-8?B?dmNMem9SbWNudWdEaEhIU25BdTBGdWdRcURRaXdEWS90RGI2cDk0MjN1NEth?=
 =?utf-8?B?d3pkbnY4MjBCU281Z3dRUGFrM2laeHZ6Zk1SV0lzVGNxR0QwZlNYZkJRbzBB?=
 =?utf-8?B?TitBWjgwbnA0TzJyMU8zM3lmZWpVdzI0akcvR0R5TWFBZCthV2xBRHF2ZGVp?=
 =?utf-8?B?T2U5Rzlna0VxNEJuTThnTTEySFRpL1FVZjU4cFpveFFCSE9mYkJVTW93MENv?=
 =?utf-8?B?Zm5nUGpxTG9DVVZGNno2U0pZaklxMisrd29LVmUwT2toSW5wR25aNys5bDF5?=
 =?utf-8?B?eE54Q2FBdERETDNBVkNadXMwOW4vZTdXZFIyNFU1aERMUkVPWFBwdHMranRz?=
 =?utf-8?B?R0pISXF1Y0taWlpGRXU2WFJrZDJPN3BKYlhtaGpTdEUrMEdxd0ZHVHlKTGZW?=
 =?utf-8?B?azJ6dzVNLzU1RGpuMVluTmZJalFwMnhZU1dYLzg3UWZxNnZaeWxpVVNwVExE?=
 =?utf-8?B?cVRiQVR4Q29LUkhKVzFUQm5uM2VEdnkzWklmSUZGVnIrczhxSDZmY1ZqbUFB?=
 =?utf-8?B?RndYYmQ5K3FpdUZyQmRrTG5ZN0tvbitneDFzMVRUQ1RsK1d2d0NnMSt0TnNS?=
 =?utf-8?B?OEoyalJZOEVFTW5IYmhkbVRZYkZoVVVqZnh5WUVYRVJ5OWdIdncyZFkrUlNB?=
 =?utf-8?B?UEl0R2pIRk1JdDlHaGRYcjFFcm43U01ZVjJkNFRwbDMzQm9wOEZyR0V5SVd5?=
 =?utf-8?B?RzU1QnByTnVJbEJsaVZMU3hhODhTMXVrRTFOemViMXp4RmhIWG1jVk56V3Bx?=
 =?utf-8?B?ekMvTDZDWHdLcEtWb0hUV2ZlUEdmaGV5L1BRTVcwR0hVTkZLUnhKazcxS2ZF?=
 =?utf-8?B?VVkvcVVSeUJqNWoxcmxYbW5VanRGTWs2QWVQUHZIdFArdnNpTjliK1RjdkNj?=
 =?utf-8?B?R2wxZHl1b3JDVys3cWlYQ09YUXhkd0xWWitOWWlJTFJuaWpWOXRlZVFzeDNY?=
 =?utf-8?B?aE1FQUJIZFRPenppK2cybGxDL2RIZzNscG9IdzRBM1Q1YXY2TG5GbEhWM3BY?=
 =?utf-8?B?VjlhV0FMRzV3QUhuaDdMeEQya0RDSU1QMVhkcHc3TVVrbFJTUzVhelJPT3Z4?=
 =?utf-8?B?T2p6OVpjS2dyK2hTVE5yNFVVNEZVRE5iN2N1ZzU3RDl4UjlUd0lzcWc3Ty9D?=
 =?utf-8?B?Ui93Nzd6bzhLL1NJYUl1NTZ6Ui9BdGxqVzRCQXozbmhuZjR0cHFEU2ZwOExh?=
 =?utf-8?B?WXRtT25TZy90dnJENDRENzhIYzJTd25RaFV0K0NFWC9XeTYzTnFudEZwekIw?=
 =?utf-8?B?bzh0ZWZDdE4xamNtSjhWc0UxRzIwRGNjWDNRLzVkYWp4anplRHNXSUplcERP?=
 =?utf-8?B?aGdzMzFWdUpCVk1TeUNmNjFvOVJ0b2hTNWFIaS9rU2FYT2tCQkgyWFMvTXQr?=
 =?utf-8?B?eVRLcmYzOGlPU1VrM2lKMElQZjRERFNvUUxMT0ZWanQ0V0pGMWVPcVhrR3li?=
 =?utf-8?B?bFJQVmcvY2lWRGthZXVraVBVWlJNdmpYOU9TenVtbUw3RkVVYUVYWUhBRTZu?=
 =?utf-8?B?bUhISU1RZkw2Yk02S0tYeFlIZ1RVVkl1QVVCa2laUHI5cmlFQW5hRXlDc0Zv?=
 =?utf-8?B?aUtkNlBKWWV3cDRoOXpEODl1Q0haVm9DdXBtMzNjbTZ2a08wdlMrZk1Ubnpo?=
 =?utf-8?B?SUlDaEdHQ0pnUWRyNVgxbGttcktzR1lzTFJzS25FWXdRRGs4L3h5d2RraVhG?=
 =?utf-8?B?MDZaM3hQSExuVHpXT01PenBpOW5wN0FkMFB4SURPY25EZURueGNNcFBVR000?=
 =?utf-8?B?d0E0MXZJVUVnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnZiSXNyRzdraFoyS2RtRUg5TDlyOVh0alZOQXh1OWhSNlVuLzJGWnY5dmlU?=
 =?utf-8?B?L3JjQnk1OXFIOUlBOTFRK0E0ejJaUTFhU2pwL3VDT3BWbHl2RHhadU11aldz?=
 =?utf-8?B?Y05IdE9zZTl1Y3U2TVFjZDB1SHZDcmgwb29BWjR0U0tBRENlaEN6MnlWa3c1?=
 =?utf-8?B?aC9iMDBJYXVBQ3dIaUNmMjFkeEJKeEE4akVaSVZoYUJxSiszdDgxaUtRTTNn?=
 =?utf-8?B?R0ZhYkc5cGRBUWRjZnkwY1g2Z3preHRFbmplUG1nNlBXOWg3YVVCTm1lN005?=
 =?utf-8?B?MXg0YkdKeG9zWTA0ODg1OC9uSklxOE1yRUQ3Tm96QmVVYlpwOEVZYWtaZzhD?=
 =?utf-8?B?azI5S0wxeHBOTmlNUGI3T0V3QmxuL0ZSelM1a2M1ZUM3SlNjbnl1cnIvQjY3?=
 =?utf-8?B?eVFWdHFpWXc0NmRaOE5mTkMwQkFSSHpnWE1VY0E3TVpJczg3RXk1SFlMSVI3?=
 =?utf-8?B?RCtwOXNwUENuSUpYT25Vb2J1emJIR1k0aXZweEc5OEpjZlducjRPa25qZllL?=
 =?utf-8?B?OVNGQ0paOWNiWFBqVVJKMEpzakhHeGc4TEFzSWhxTkRldFJORnVZVDZWWFdC?=
 =?utf-8?B?czJuRlZQZWVwU2Q3b1pnQ0VGYW9ScktLdHExTG9hR0U0UWlsMkhRK3VyWVJV?=
 =?utf-8?B?Q1RlN2V6TnA3TjlXWTJZZmpENjlyOWhzUzAxaFFnTjRVZGJGYVJIRVFVN2Nh?=
 =?utf-8?B?Wk5oQVhWczFnMG1YQ0EwNEc1aVY4OFdjd1FGVGdLMm5uWENKa3U1VFJNMWlU?=
 =?utf-8?B?MThmRHdOa1ZWbTQ4Z3FXU25LUmo0Yi9nNTl1TnFZNVk5WVlrZ3Z3cE90VWZ4?=
 =?utf-8?B?NkF6Y3Y1V3F5enpmSkxlN1hDcEZDeStiRFhQTnZZczk4SEU2UTVaZUVraUt4?=
 =?utf-8?B?Z1RDWHBtQW9jUVJnUjV5MjNJNEFYT0FPL0EyK2FOcWtvR0M0U2tpdGtFeVBY?=
 =?utf-8?B?UmFENWdkeEN6anJrL3YvY1BkOW9hMDZyell0a1RYVGlpMkI4eXpRQ3p6THlj?=
 =?utf-8?B?d3doTXdJRTVreHFadDd5S05TYm9uYld6bUtMQnVTMWhIbHBaTUFSY3NieXFF?=
 =?utf-8?B?UitkMkVDN2MyUXh2MEp2d1dVQ3pPNjYwOFFCeldpSlBDSE9lSk54QTFSWDl1?=
 =?utf-8?B?WnZKdVBlVEkvd211WTkxbi8xTnJoR05WT2ZNVnRIcnYyZWlKWnZrZnM1WmFS?=
 =?utf-8?B?bzRJUWUxSExVQlBmYzhZZTczUC92VlRDL3VvOTBXTnhxZVlMQUhjcnhCaGJ4?=
 =?utf-8?B?T2pBYzMzVGlrekkvVmNtMWozNkJHTVJmdnduRjNQYitiMXRWTFRUT0UwQmUy?=
 =?utf-8?B?TjFFV3ZxcmlhVWRjMHVkMk1Yelc2b042Nm5SSXFnUmx1UVJGaE1md3Q4Wk1m?=
 =?utf-8?B?aWRLSkRicStCenliU2RFRVIzb1JMRVBZc1Z3V2ZuTUVtdW9BYUR1T0VEWWhI?=
 =?utf-8?B?NzZqdlZCSmN0Sm9ydXdpcFp3SFJuU1BNUUFZWThHSjBLbUpKVlNpWTNOZkxE?=
 =?utf-8?B?dFlSMjM4Sk43Q3Fka1c3QjVLY0NJd0pHNEsySjNGb3J0THdYSDFlWHlLSkhT?=
 =?utf-8?B?S1dMQlV0cGE0NXNvOXR0elRRSnAxeXNScUpiRHFJTnRFaThuRFRvM2hiZXdJ?=
 =?utf-8?B?ZnQ3ZjNGZ1E5SkJTVDhvdE51ZHBTbjJYY3Z2N01pUm1CaDRvdGczcnJheDF2?=
 =?utf-8?B?UE91R2hpdlNkUEl4akpmWmhHRkNLeDdlYUlWOUpiczJzalJMWDdhRUtYYWdK?=
 =?utf-8?B?MTRCZ2N6dVAwaHhRMXJTRUU0V2Jmb2NNWk1jZ2ZzWU5yZktIUkxnQ1owSWE3?=
 =?utf-8?B?VTF4OGNxa1pEYVppNzc0dWpSY0ljYlBwNGxnSWY1L1B5WU43SnZmM3hhUEZa?=
 =?utf-8?B?cDFHT1BGNk9zYXRVcGRpT0RqS2VQemJDQTRtZFQyTjB3djZiQmtCWVk3SjBl?=
 =?utf-8?B?REM0dzZzdlhZc2VsYnJvMUh2L0RSUlhmUkZxU3o2UmhabW8ybjhVRVJjSHph?=
 =?utf-8?B?aTVLbm5haDZZSURLc2dWZDlNSGRHRlFweEZ1WFovY3EydDVqUDNDL09USEM2?=
 =?utf-8?B?MDB5cnFpMFVsKzRxUloweE1RQ1cvS1NDTy81YmE3d2ZhY1FpUys2RHJqSVNZ?=
 =?utf-8?B?OFdBZlByTENGUXQwVlBJcjNkekVud0xxcVlzL2s3TDR4eWNkaEJBNTJMaDRu?=
 =?utf-8?B?VkE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c15efe1-d7a7-4a69-0fa0-08dddef1df4c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 07:27:37.2739 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9HWp9F8acy3V7C2UZh6WJGh3SOH/xiDmy2TBLy4YulRAFRVb9ocwNRKVkPgNksRvW3ou/6r014ThjUaCdnHTBKjYKeZ61Eo8BfaakXtBD98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5998
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

Am 18.08.25 um 12:06 schrieb Mikhail Kshevetskiy:
> From: Miquel Raynal <miquel.raynal@bootlin.com>
> 
> There is already a manufacturer hook, which is manufacturer specific but
> not chip specific. We no longer have access to the actual NAND identity
> at this stage so let's add a per-chip configuration hook to align the
> chip configuration (if any) with the core's setting.
> 
> This is a port of linux commit
> da55809ebb45 ("mtd: spinand: Add a ->configure_chip() hook")
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu> # U-Boot port

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
