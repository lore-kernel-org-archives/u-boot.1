Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C34CCF9F0
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 06:32:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B7C983A9A;
	Sat,  1 Nov 2025 07:32:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="l12Z44XB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F50A83A9F; Sat,  1 Nov 2025 07:32:43 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B02F83A92
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 07:32:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xinxCPTQutwg2W39HD5UVV45EKnwEkiV/pEKrNpYAEzfuA+4jfp5RP5ZNPMoG3nLcuh8z6lA4CF3GdZW8mlEgbVHv8APi9SBXX7T0hY89kcb+so+y48NcCmLlgA+6lvviOfYVB128YKpnexFKOG7nAy1WjIb62GAV02yCtNaDqyk5LmgpI/GLTn6hTJqKjs2yo4C7mrd7eh9kDt1Cfg2ei9HOT+OzM+ZOPt0pxWZogQs2LzbornT6Sm6ZTJRh5WeD9GQTszNSgG6NvytdmkAWb5YWaWcZvUmjBOdUmXcLZIHFX56xMdSbjmFz6AKaWcXPl0u350irQwFN3ChROvZDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9cWd4RVDp+GvIQcAbDCHhKQ07cyeNcHTwFlMCS08AsY=;
 b=PMbQ4k6Y8CL4dTpOtzt6z5MvO/RvuCMsufWXwAIo6eytK9CN/XFJ0sv7GK3dxrVL18bSOpqrcnUKHZZkZIMXYGNZlxqpy9ZB3+pGRHFNU9IeXTLJ1CupUtV8rYDMn4wGYbhrC11ZpW0jxYjoCWwjcLE/ahbjTSjr583JiLGEYERZjN6JoF8H8cO2WSjyqWeXVFFlQqZEXUtiFEuzDatzLkz1cW+REVxT52EWtFqycglXZaNkxB71IICEyFAqwnPgvnrlqdThOmrJwd3I7ol8r3klK4p/ZXMhB8f2JxtIf8EEmoMtSrO4tJbeNHbvmzMcJhGd4wxj5hORYOAv0wbdQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cWd4RVDp+GvIQcAbDCHhKQ07cyeNcHTwFlMCS08AsY=;
 b=l12Z44XB6ktNVKhb29UD/xwcsC3xuvjPoRV+kuVmmRFhxNuEY4OyDIYFrf9+VFfB2S5jlWHkHZ2aqiEwYZlzniHGCJ3lePmeCBPBRpNooNjNHUpE01U73bff2Ut6b9QJ6qkg25lWHQ9cPn/tyZc1DLNOHAGpecVNMukpQ2slzOBWRh36iAKXpUY2ycdJATnchVdKC4840RtxzN2XK/BCdR7CeTTMjvDrqgn5B2MT/1kthiUFgacAAl60mk09Z4qL39sil32TexfjoViy8eQewKPaiKm4VFz3kMWvznB2Wdfak924HyQV3BU2sCFDPE79494Ao08slzOpm5Fs1Dwu0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GVXPR08MB11470.eurprd08.prod.outlook.com (2603:10a6:150:2e3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Sat, 1 Nov
 2025 06:32:37 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9275.013; Sat, 1 Nov 2025
 06:32:37 +0000
Message-ID: <d0e51598-8786-4f4b-a62d-7c981bf186a2@iopsys.eu>
Date: Sat, 1 Nov 2025 09:32:35 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20251011180636.GM298503@bill-the-cat>
 <ef6da754-8217-42ac-bde4-8752cbd3090d@iopsys.eu>
 <20251012190713.GB6113@bill-the-cat>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <20251012190713.GB6113@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::20) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GVXPR08MB11470:EE_
X-MS-Office365-Filtering-Correlation-Id: ff0b06f0-0cd3-436b-2fff-08de191072ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WUVTclVzOHVOMVdXRXZsTElwTXNuK0lTeFZrdnpyZnIreGxndklLTVQraTMz?=
 =?utf-8?B?UnJ2ODFwbHRnMTZwUnFtM2dpbzkzVVRWZm1qUjBRcXhqOTc3WGFUVkp2WjIr?=
 =?utf-8?B?YzRYODhTUEdwc002Q3pQbTYveVpSVURMTjU2Z3JPTEtpMGZLK29PdXNLK24v?=
 =?utf-8?B?NkRGckpkakRFbFlhVzdaQ2FmM2p3MkFmUnhibjlEdDh1SG9NaEl6dHNJM2tH?=
 =?utf-8?B?VVlSV0tvaldEeEVlVGY5UXVwc0JHZWZ6YzBpekpxUnNreTFnVFArUkRwS0NY?=
 =?utf-8?B?Ulhyb3JKWkRwcVlQdmhWamhQbmFxdThIWXZES3lqT0ZCRDBrL2hKNFhRbzB3?=
 =?utf-8?B?Mm95K3cvYlBoM1Jxc1dlNTA3WkxySHVzUVlzMFlMR0k3SnBkeG9vaDYySmNo?=
 =?utf-8?B?UGwzdVNTK1ZMQXF3enFNYW9RMXAzQU5OdXkveTlvUXJXL1orWUNoRS82dGts?=
 =?utf-8?B?ZVcwRDJTNnN6bEdxbVpoNGJJSEFyc1F0Z1h5T1ZERVpSVjVMZ2g0TnhXdGw0?=
 =?utf-8?B?dnFVa2JMWUJRa0JyQVZZUWR6TlA2dEhzZTQ4a01NRmRXMUNzWHRUa2x5S3Jm?=
 =?utf-8?B?YWJ3OHE0SFZDWkRvMUZRMzBrVE5yOGZQcXZ5M2VBMVVUblFzMVlyTG5PQmQz?=
 =?utf-8?B?dUxaTDFmZVVjRy9Qb3VwRzlPQjU3d0tBaTZHSXZ1aFhXbWNVWXhTaWhsSXRP?=
 =?utf-8?B?U05NazNYMml4bEZNQmcySnVGankycEpwUVZWZmhpREp1b1dLQ1dDcGdZNjVm?=
 =?utf-8?B?cTFMczFuVEhtRjV5cXdXTUxQUEtOcWZkeXMyWmNkNzdrZ2pQbWh3TDBaVDZs?=
 =?utf-8?B?VEhpZE9nRjZpbG9qSHVNY21pSzMyOFpuU3BYcUNVSkJVZTk5RXp6djQvSmRz?=
 =?utf-8?B?SUhHR2RsdnN3bmZoTXh3cXgwSGJBMEJDTXZJaDJBTExuUVNJY0d2Wm0rYVJi?=
 =?utf-8?B?Rjg1V1dGcjVHM1hac3d1OWdjWmgwR2RFZDRZVGNCVUNaRVM1SmtOcEVaVnl5?=
 =?utf-8?B?ZStKbVhnNjJicFRUUEE4aGFXYVkyNDQ1K1lTcjlYeFZ3NWcybk91S3RlZFZt?=
 =?utf-8?B?MXl4cU5wWnVveDc2SC9nZ0JEN3c5SlhvUGxpYUZwYTdhQkFwTHdaK0pLWFJY?=
 =?utf-8?B?amErUTBtcGRta01UQTlFemF4OEFsd0tKOEpWVGtUU0VMMXVjc2VEaHJDejZU?=
 =?utf-8?B?ekd0MXd2ZFgrdHhzdTQrSXBhL253UXdUWVFHZ0pxbXJOTXVhdU55MnBnVVUr?=
 =?utf-8?B?a3lUQ2NXclJhbHAvOWlwcHRiY2FTZ0NPd3AwZC9LV2pibkNSN09VVzU0SWk0?=
 =?utf-8?B?eVl1TzIxSmV2NDJpV0Rrb0hmWkJzekZzZjJlMnAySW5ub05KV0JUbVlMaFN6?=
 =?utf-8?B?UXBQMTJTUU40cHFYcHVIeTZibTA1UzdHMFVLUHBHZVNTT3g5Y3pnZ0pHY1N6?=
 =?utf-8?B?NW0xSVVrQWxXZlpHWldLd1pORGV5ajFxQTFmRW9BNzBDMUJaMTlKYXZoeDB4?=
 =?utf-8?B?VVJHQW5pZkcwVEhGcUUzYkdzSDIyMnBaQ2FWTTRPY25FZmRTSFhDcWRHT2l6?=
 =?utf-8?B?VytKV0QvaFNYL3AvdlNKQXAxbmJYR3h3VytPRXVSNWZHL3JyYzVpK1ZDR1o1?=
 =?utf-8?B?bkovR2VGdW95NXYzalJkckN1WGU1Z1ZYb1pVK0Y3a0t3cFVEQmpPV1ZnSmQy?=
 =?utf-8?B?aThheEdNMHZDNmV3djM5K0ZOZmJvWjFUOVVUdjM3UzBPL3o0Q1VxdlVUSGlw?=
 =?utf-8?B?L3JKNldhTXgyRStWSXE4KzFkR1dWY1JqcUZ2bm1LOU4rV1cvVCthcDhuM0ZS?=
 =?utf-8?B?L3NxTVlyM0MzeS9iRW1HbTJTNzBpUURBclEzMW9FY2s1Y0ZVYWRKUVA3RUJO?=
 =?utf-8?B?ZnFiRWR6eXlJZUIyeTBEVHZYbmZkblp2U0xRWEhITUZMN1NmcURaVDU3VFQ4?=
 =?utf-8?Q?UOU3rHGy8kCZ2qh4zMFQ4slr4wf8dCoS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnNVUzF4UVNENWpuKzE1b1Bzd1NhWkl3QVhIOWgyZFhrNS9OSU41aklyYW1i?=
 =?utf-8?B?bjFYOWlleG5GekZWb2lRTzlreENVczh0U3M0c24wbXMrSUlJOThxTEg5NDZR?=
 =?utf-8?B?TkhOcDBkMHdtUy9aTVJacy9uVC9QTjhFK2dPcFpZZVBQUStoTXYwZFBMYVlz?=
 =?utf-8?B?UGkxK0xiOGx2YkpwOUFNSWJQRW14SVZHWTJhTG1mWm1ZbEk5UHRKNDlnYVRu?=
 =?utf-8?B?aTR6bXcxZFNkaldqSkNpUWtDcFNMUUFrSmh5eFhPY2o2S3BnNTV6Wit0UVpX?=
 =?utf-8?B?TnlhQlNjNTh1NFRqK01RL3RtSVhuUm9KSEdXb1o2YjUzWXMwMUwycnhEdGox?=
 =?utf-8?B?VGtWRjV4VTFyWmNYV0EyamlES0pFNTU1Mi9DM3FBMFR0RXI0UEpIeVZuT1kw?=
 =?utf-8?B?RnFBeDNHcTlUZmFjUkQ0SkhMWjBhdWljNFdTTUNqR0hvWEVsVkEwT1kvSWV6?=
 =?utf-8?B?dmU3SFlKWjlYelZWMmJBeUVWbHpReWpCQ2NUZ0pDWnVucDFESU5IUUQrMTZQ?=
 =?utf-8?B?eFBwRkF4SVpmSHBrOGppVnAwZnY1Wm9oVHQwSmFPYmZkOUptazYrNWxFWWtY?=
 =?utf-8?B?ZktQd0UyeXN5eFhnNGlwOU02a0hBVEhOY1Rsc2FZLzdVNXEzYmErTGlhRHNG?=
 =?utf-8?B?REZXYWJGWDZheFhoaURQWmprUlIwTmV4NGx3Z3d6ZCszeU9FRUsvOGdtVDZn?=
 =?utf-8?B?UkVJU2NMbWFNVFNSYTQ0ZHVRTU1OU0hiQ082Z2NWZFQ3YmZLRGw2MWNIMlBN?=
 =?utf-8?B?TWtON1BrZkp3R1U2MWIyd2NabUcvandqRTI1QnJMdTZlZkVQa3ppUlg3S2t0?=
 =?utf-8?B?anNjYXlIR3FCZTBjOVk5alZwbjZvMUh3c2RxL0l6dk1lSk1JTVNLTSt2dVor?=
 =?utf-8?B?dGxMbWpSYjFmb3k2OTFzVjl1UlFNMDVvLy9JbzN0d0MvTEFCSVluOWFYRHVS?=
 =?utf-8?B?Ti9QRVlqTVd5SFM3a0dBUVhzaExGYmc5Zzk2Q1pIYTVYeU9kdDFueUk2OHZq?=
 =?utf-8?B?VW9OcEhCSHpsdGM5K2h1NVFOR0ZQZVliL3lYQ2NPcWpNalNoZXJzempLRHlU?=
 =?utf-8?B?TGw1ajRoc0tzcERMQWZnR3EzZ2ZNYldFNDBOZHY4a2hhd0RKVVZ2ekcrZjhQ?=
 =?utf-8?B?cHJlQURzUmppWC9DY0xpWG9sbzhWbjNOU1NNWUljSEVEb2RiMDFIVWdET0tH?=
 =?utf-8?B?ZVNLaFVXTFNYZUxCZmVTa21GdkJLMEhJKzZaOVNpQ2RKVUYvaFN4SER3ZXpl?=
 =?utf-8?B?czVRVkQ4dzNEd1k1NjJLUWtDZXlWSGJBOUlaeTJ4R3g4dXUvdW1Ea0pSTlFm?=
 =?utf-8?B?WWZMdGJ5aXlNbG1CbnMxYXdDdjduS1h2TThqeGllc2FzY0NIMVFpNTlhZyti?=
 =?utf-8?B?UHphMUVnSXFYWFBNTzlQbVJkRytKVTU0TEIyUmFpRTZ3SVFHb3pFa0dLZElQ?=
 =?utf-8?B?cFpmU3lLdGtNSjI4Vy9yUG1hcUpXVG95eTg5dm81TzRKY2FkSkcrbXUrUC96?=
 =?utf-8?B?dUR2Y0pGMkVjcndoVkJjNzZqOVRBOUFlaEdPTUpjTDRteHI1Tis1b1dmMVl6?=
 =?utf-8?B?bHIwdXVwUWtjTGF5ektrcEtwYUJSaWtKWjhDRGJWaDdpNHBlbXZqaStndE9l?=
 =?utf-8?B?RFJxQ2FzVWpObDFOT1IvVlRMMWhqS1dBVkZaNnZ3SEpMT0FSTUtWZk42ZVdp?=
 =?utf-8?B?bVB4TUJVcnZKWlpXb3BSWTdjQlM3WXR0ZWJXdlBwdVA0VlZYamxtMWVGNHUv?=
 =?utf-8?B?azdvSDlLQmRDeFNTWTU0TE5TVlp1Y1FFUkNqdEdlVyt2bzdYQ2t3MFRLNXgr?=
 =?utf-8?B?NVlSR09sVVVBR2tDYTB3UERFaXVOTU9zTUNic3k1NmsrL3pOOXUvZTFKRHlU?=
 =?utf-8?B?VllUeWNkSFE2K2plOEdGeGVDNjU5ankyY0h0dGwvd3EvREV2YTVzOWRYbG5N?=
 =?utf-8?B?QkJMdlJXYTl1RjVIWTZINUVEWHBkZFMxSGxyNGhZa3dxWXlBRTVjUVJmcW5Q?=
 =?utf-8?B?UGN4eTN3SHdXQm5lb1dyWjBKcUJWTGVwNXo2SFRYb2ZBRnJxRnBhMTNhTXg0?=
 =?utf-8?B?cWN0Zlk3Zy9ra0h5d2s0aGJFN254bjVsanUxZEwyMVliMTZJS3hRNXJGcVlt?=
 =?utf-8?B?TS9vRVk2NHpBWG1RL3BmNUwrRXkvWENVU0hwMFRuR080YzJ3R2E4dFBZR0Na?=
 =?utf-8?Q?+tsCfLr9vH7ZwOSMLWIQHjY=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ff0b06f0-0cd3-436b-2fff-08de191072ec
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 06:32:37.3046 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCFZDfq6AONklFjmULANU9a6VNO18DEDje7VVyZlTSHTOTP/8V0rB1ZtSxd25wUgiIkMMmjVGNe72pn4PbXRsdhBYNLcyi6BlKFYI9cgueo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11470
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

Hello Tom,

I just sent a fix for the issue in the my "coverity and 64-bit division
fixes" series.
If it's needed I can split the series and send patches separately.

Regards,
Mikhail Kshevetskiy

On 10/12/25 22:07, Tom Rini wrote:
> On Sun, Oct 12, 2025 at 05:22:15PM +0300, Mikhail Kshevetskiy wrote:
>> On 11.10.2025 21:06, Tom Rini wrote:
>>> I think unfortunately the report email for when I merged in -next was
>>> lost somewhere / wasn't sent. I may be able to get the details out the
>>> dashboard.
>>>
>>> ---------- Forwarded message ---------
>>> From: <scan-admin@coverity.com>
>>> Date: Fri, Oct 10, 2025 at 7:08 PM
>>> Subject: New Defects reported by Coverity Scan for Das U-Boot
>>> To: <tom.rini@gmail.com>
>>>
>>>
>>> Hi,
>>>
>>> Please find the latest report on new defect(s) introduced to *Das U-Boot*
>>> found with Coverity Scan.
>>>
>>>    - *New Defects Found:* 1
>>>    - *Defects Shown:* Showing 1 of 1 defect(s)
>>>
>>> Defect Details
>>>
>>> ** CID 537478:       Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
>>> /drivers/spi/spi-mem.c: 528           in spi_mem_calc_op_duration()
>>>
>>>
>>> _____________________________________________________________________________________________
>>> *** CID 537478:         Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
>>> /drivers/spi/spi-mem.c: 528             in spi_mem_calc_op_duration()
>>> 522     	ncycles += ((op->addr.nbytes * 8) / op->addr.buswidth) /
>>> (op->addr.dtr ? 2 : 1);
>>> 523
>>> 524     	/* Dummy bytes are optional for some SPI flash memory operations */
>>> 525     	if (op->dummy.nbytes)
>>> 526     		ncycles += ((op->dummy.nbytes * 8) / op->dummy.buswidth) /
>>> (op->dummy.dtr ? 2 : 1);
>>> 527
>>>>>>     CID 537478:         Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
>>>>>>     Potentially overflowing expression "op->data.nbytes * 8U" with type "unsigned int" (32 bits, unsigned) is evaluated using 32-bit arithmetic, and then used in a context that expects an expression of type "u64" (64 bits, unsigned).
>>> 528     	ncycles += ((op->data.nbytes * 8) / op->data.buswidth) /
>>> (op->data.dtr ? 2 : 1);
>>
>> op->data.nbytes  comes from file drivers/mtd/nand/spi/core.c, function
>> spinand_select_op_variant().
>> According to the code the max value of op->data.nbytes is
>>
>>         nanddev_per_page_oobsize(nand) + nanddev_page_size(nand)
>>
>> thus it's slightly more than 4Kb (I never seen flashes with page size
>> large than 4Kb). According to this estimation the overflow will never
>> happen.
>>
>> If it make sense, I can try to do something with it
> Yes, please see what you can do about it and thanks for explaining that
> it shouldn't be an actual problem.
>
