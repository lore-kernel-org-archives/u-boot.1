Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3508AC83F17
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 08:14:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 660D1833ED;
	Thu, 31 Jul 2025 10:14:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="cusdBUJq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7928E833F6; Thu, 31 Jul 2025 10:14:03 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20729.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::729])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 453188334A
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 10:14:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1iGAb9qoHB5rtQriM8P3SxvGYVvggpQ+ctx2qv/ejKDIP3fYBl2atqRxXF+rvu9Jg9Yhm5GIejO/J3wojygHwpTm9AA/Ql3YndSde4h0sN1X3tRWdAS+UtviWro6/A7p1OpBM17VGHnW21oZtm9dDuayhmt7K2z6OsFh0Ptm6xFaqLouzBQpNLr2rDCGgsMIZRxnaOlhgDrNC8PWK1Ey2C+Oz0Mp6dMhuYWjS7jsSv0EWqnbsToT7Dg6HhZaXKIsjSj0ggnuRiVPKgFKCYGYk22cdb5z8xStP8tIfUt/ziuznic32m/cMSpQpQPqnDVJXKfAR1W4cL59yKZvimkOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHSUWxtmHXHJSARBIP1y+8U0lMEmOL2rw7M6E1djTRU=;
 b=ZFwadVe0/sk/F/P8NIlFEXnlKvL3TRu1tbCmeIBN3qt3lJzds2P3XBS74wA4VU9ADRoxMasg1WmBviH2ofVWv6oPnfEiGlJMUCobZUhQef+SHXXg3RaaSFhUZKqFDqT7zLkatug9PIRWEGsd3xms0nZAfwKeEbz/juxmA/UyJ0KlSSRusvTAkRbFLBc8e570pZty/nbkLbxm2CH3lxLmuG4JpmGsQDDz0G7xdTqIXJ0AJyF9JDL8Zm4gZRTWS0fAshUHh5EBcDAvDKJ5f2RLv1NzHpb//qEKpfNgHxnSNp3+BIhvdnqramQnzoKcR1F/v2Somh4uWPN8X70t4i6KeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHSUWxtmHXHJSARBIP1y+8U0lMEmOL2rw7M6E1djTRU=;
 b=cusdBUJqj1cyBX0S4MrRwROGeld2r/qrHfgIxO2VfHIDIcnEwEBs/cM8NbkmX13NujcFCnw88Az8rszOrrgSjwbEkbVezxeAjxX4fG08LOu4PoSCVD6m7823vUhpjJ9ElrmSPKgasXofclFl8719B3s/kylAA9ybW4JCD1guOVclhX/APQB7hQjxd/Pma+Myi8lYhB3vvOL3RveLEUpt04kltAorM1kC4LaRWmob3tvUGNGHwRzzICCefXbetvr+DkixY34CLrfbG2H8sW3A7wAVsyKMe6iYcUs4OCLHOTbRuF3mCQLmxu8FBrDaU2gefVvBcQG0cxeemkNqhN58Ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by AS8P195MB1159.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:3cf::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Thu, 31 Jul
 2025 08:13:59 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%5]) with mapi id 15.20.8989.011; Thu, 31 Jul 2025
 08:13:59 +0000
Message-ID: <984d6f68-0313-4199-8134-abd969220988@phytec.de>
Date: Thu, 31 Jul 2025 11:13:56 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm: dts: k3-am62a-phycore: remove GP tiboot3 builds
To: Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>,
 Garrett Giordano <ggiordano@phytec.com>
Cc: u-boot@lists.denx.de
References: <20250729-no-62a-gp-v1-0-1dbdb4469ad3@ti.com>
 <20250729-no-62a-gp-v1-2-1dbdb4469ad3@ti.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20250729-no-62a-gp-v1-2-1dbdb4469ad3@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0035.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::11) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|AS8P195MB1159:EE_
X-MS-Office365-Filtering-Correlation-Id: fe899d72-4a45-4f30-494a-08ddd00a3396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aXBqci9SakR6a2tTb0dtQ3I1M0JhS2pyMWxiM3B2Nkd6eS90Wlo5citwSEJS?=
 =?utf-8?B?SU5CMUxxc25tbXAxQ2NoYmRDaSt3bjdSZmpxb2szRkkxTkF6WUpIYzFIR0hJ?=
 =?utf-8?B?OVhSektOempPR1g0YmlGamlUc05qUU82T2NieENxQlluUXlZYWprcnhDdGlG?=
 =?utf-8?B?WStDSml4WlNlcG9SNHpHVkZyTzdwSjJ5UnNMQlRHbUxzckgySkhlUVhUZ3hH?=
 =?utf-8?B?WTJYNWZjVVpMWXdWSjRvMDZEZGEvZERtSlBDeE1oR1grUklTcmo1N1F4UENW?=
 =?utf-8?B?dnlFRnBVc2NqOUE1bzhNVXVYUUpQTkcrWVhCbVdYVXU5Z0NTajNSTzFOTEp1?=
 =?utf-8?B?TEJ0aFhxWnA1S3N6Z2lLZmwzTm5NUnpWYnFINnd5WmlxSFZwdXUrMk9oVTZF?=
 =?utf-8?B?emovOEwyRlBZaHEwdUVNV1dzNE9XOWc4SWpka3haUCtxS2lPeldRVXhVZExU?=
 =?utf-8?B?RnRFMjEwOFpnMS9LTHl5Yy9iSVIxZHlZNC9CVXh0S1duL2dQcms5N05CVVht?=
 =?utf-8?B?Q1JCSnpyOFVEaUZaWEd1Vng0RGFBc2ZTcytBTi9TQURGUzgxcVpWTjMwU3ZE?=
 =?utf-8?B?YjRPby83OVdDZmZzMG9La1JKNUhCQ0hCQmxkNWo4Y2NQbFpobStScjdITzJC?=
 =?utf-8?B?Z1VrZ3llQXdCTEJaR3F5Y1Fwb1FFS0NPbS9nYkRRWGgwVUViWkRxbFg5akQ0?=
 =?utf-8?B?NzVETVpPR01sMGpZN0VLK2ZiUTJjbEs0YTFDWG84aWhESUxpaGM2QzB0R2Nm?=
 =?utf-8?B?K1lwK09vWHk1MDB1S28yOW9QbUZFc3FCenJwRStCZjVMd3dDdHU3endGTjNZ?=
 =?utf-8?B?VDczaDN5clNUNmhxKzgzeXJncmVrUWFZUW5wUnVVRWpBMGtHOGg0MUJnOWtt?=
 =?utf-8?B?aEFweXNaOC9tbjQ1aGgyK251YzYwMUt6MzVTeld5ZzV4L3VReTdpZnNXdGxD?=
 =?utf-8?B?RzNqRVlYdUVBREJuNUdma2dvNGtzZjFpclNyUmFYT09PWk5lQTZPdkMydUxx?=
 =?utf-8?B?cm52Z2FkczEzemVweVF4OUFEcGNLOWxGSS8yU3czajBQdm1jcTlXZHNETndl?=
 =?utf-8?B?RFlvWjMwcG0yaDRlOFZVcEVMSTZ1UnFpRDAxTVMyUGN6MkxkTEM0UVZYeDFi?=
 =?utf-8?B?YzhSamR5LytZMnBmR3RzYXBGb1RjUTdjRC9Wb1Y0eGFwV05xZnU1Wlg0VGFv?=
 =?utf-8?B?RWJFc3VUY0hNdlJ3Zi9jQUtCTkk2a1BFbVZJTDM0Sk8yUDUyRHNxR1NtWkZG?=
 =?utf-8?B?WkVCZkoyOU44VUtHN2k3Q3dUMDA3VkZDTk1mcTQ2TkZHSkxmSEZDcCt6bkJa?=
 =?utf-8?B?aTA5SjMxMXU4ejlGS2pRY0dIdUNJVmFtekNtNU5TUDNCMVpJb3ZNbmVacjdQ?=
 =?utf-8?B?RmhYTHU0bTVTSmJUbmY4bkh2NU1QeEZ1T2VIVXl0ZEZEcC9waFV0eFZsS1Zl?=
 =?utf-8?B?STVLK3B6bTNEaUlDeVV6dWZXU1B4ZGVzVFE4UFR5SG5ubzBWVkNxNkY1eUdV?=
 =?utf-8?B?REo1Q3pjZzVsMVdjeXdhYUdXSjlVaU5kcVpKQmtSR1ozZjUxbzR6NU9TTUJI?=
 =?utf-8?B?OC9lT1Y4UWRsVnAxTmdmaEdQKzBQY0NOL1UzbDZnV20wUVR5NmJ3MHVlRjdC?=
 =?utf-8?B?c1lKZllzTVFoY2N0SmtJeENVY0tsZjdseUtHQklGUGszaUY4M2NFYTdrTmUx?=
 =?utf-8?B?VUkxSWtEU0hPaDhuWkIvWEJ2c2FYa044UkxIejU4RHpZb0hqTktzU3p4WThX?=
 =?utf-8?B?K3dtekdDdWxOQTJRN24rQVhkOWJ4aGJ6d3JDMFh3UVB3UjhkUG5mUk51R05m?=
 =?utf-8?B?UHIzclN1em5Xdm13UXQzeHVRZDhzNjlaVnlWRDVPbjRZV2J3Mkxkbml3cDdS?=
 =?utf-8?B?dUFObUJFU2ovNDNWUGZyZ1lOVjR1Q0VaZ3J2QTZqbjFvOGc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjFwZjVJM3ZtYXFycGdwTFRNVzBiMWtUQ0swSFBsSUN5NHpTd1p2eW9CSVdN?=
 =?utf-8?B?Qzh1N3FtN0h5clMrOGI3YURRZzhSbDA0UWxuRDRqbHVkSldMd0poemxXOFM1?=
 =?utf-8?B?WUUvaGlGK3JJWFRVdWlWcG02aDFGTlBNb3FUNjhkaVNwYnRVTEhNNnIxWkhZ?=
 =?utf-8?B?QnU5YWRiN1Q0eDg3OWxWY3VLNngwNE9uVzR6aVEyWXFSbVlCOWljQS9VZjR2?=
 =?utf-8?B?QStSK0h5VHY2ZkNZSnduSTFCNkJtYTBobEVXaTZqREdRcEdSQlpEZVRMNDls?=
 =?utf-8?B?WkZ3VTV6UG53alpCbjdGa3RBMHZZVFFBaTdZaTFTbzZtZkx1VDBkaW8wK1VJ?=
 =?utf-8?B?Q2xLaUJERC9SV2tBQXhuNnhSVTAxQ2s1bnU3djh0WitIaGJvblhmZGtMbWNI?=
 =?utf-8?B?eWhLZVlCZkxOOURKMlpnWGFidEZPemZvanFuOU5pUHg3OE90czdVQisrWFpk?=
 =?utf-8?B?NHloc1M3WHM0YVFhekplaUUveTNwSExwTmNsNGQ4ZENocmpZS2lHb3pVYmdZ?=
 =?utf-8?B?TStYWUZQRit5bW80SXltay9FRU9kUUlPRUNQWEc5dmdaczh4Q2pqUktkaFdo?=
 =?utf-8?B?dmJDQzBqOU1TNDBjMnBVUW1mMTl4cVo4QjJuckNkNkhIRWtZempZUmFTRUV1?=
 =?utf-8?B?RnZZOWZVaHRCeG1WcHNTa0dUZkhHZzFzRE90WGV6QmVVU2JKVU11dFlTYmVs?=
 =?utf-8?B?ZVZ2TjlJZG92cGkwd3NGQzJrbWo4WkQveWIxRWl0d2FndDZBOG11WXVEdmdB?=
 =?utf-8?B?MFFIYm1XUHZ4bytLSTFLWXJqOVJ5UnEyMTJ6YkpxUG5sYVZMSUIzOStubUNQ?=
 =?utf-8?B?L04zUFJUNEZacXpaSmFoUStNMXQ2UlZ2L3NUN1BTNFNPUHRyZUtPSGtMUk0y?=
 =?utf-8?B?OVgzTmx5aVlFT1hWY0xHUVFOSS8ybk9UNmtDWlhaOXN5YkVyK3p6VGhxOGtJ?=
 =?utf-8?B?MEpyb2JwWExwMDZYTWJncFB2THdmS1h0QU9OSUg2eWlwV2Y5UzFHTzc0N0gx?=
 =?utf-8?B?UWs5RUc2OU94L3hiVmdTNmpCcmxDTXZaa002aUxhYTN4VG12TUxqUUw3b2ZR?=
 =?utf-8?B?RTZONjByeW1iKzQxL3VBblFvR0lNa2s4M3ZSNTRhMVdQWjBBVlJ4M090M2ZQ?=
 =?utf-8?B?MFJCbHFWaFlMS1BBSUZteUE1aU1PM2xwV2RXalNkdVJ2cGVRRVp5bXdjVGxO?=
 =?utf-8?B?VzVEMTU2SFdLM2FWa01PSXFCMVlrUlkvYkx3dVVqbnVFZnoxc2d6ZUxYdWpR?=
 =?utf-8?B?dzg1T3d1ZGlvelR3dUtYQVNIYW1tWVVRU096UmdEaU5FcnRRQ2FicEJzaTRZ?=
 =?utf-8?B?NnYyL0JoMnRkYmZiVjZGY0pmVUg4TmJyYld3UEErK1BQcTBkS1dRVXZvNUow?=
 =?utf-8?B?VktnSTZGM3ZDL0VhU2hqemNyeWwrUExVQ1NpdHlBeWc1VzVhRER4MFg0eUNl?=
 =?utf-8?B?Y1A0SmhRK2JuVmxMNk9XTy81NU5YNnZPR2lnTFBHUXVxdTVzME1iWE54aFVE?=
 =?utf-8?B?WXg5R0w4VlZLTTVZWG5jUjdlbUNQcFBJTUpvd0twL0hScnRGRUJYdWtSaEVS?=
 =?utf-8?B?enNyM0NISGtGMjdPVEhOZ2VZNk9MTHVQL0dtUFhWcWxyeUl0dzZvRFFheFJ1?=
 =?utf-8?B?RW9jaFVwSXVBRG5RVkI1VEIvbElZZ21XaGh3aXpzMDJrVlIzR2xTRHk4NHF2?=
 =?utf-8?B?L3FXVlUwV3kwSC95R0JpZFkyQWhUUnR1QnNKbmtiTUhjWHdRM3R4NzFuWURy?=
 =?utf-8?B?THVsV2FINERYeXQ0UVVWNzRURy9JSzFzczZDeng2WE83Q1F4anNSUGw0SHZR?=
 =?utf-8?B?ck1sREpmdjg3TjYxM2FaNndERXEzZStDSWlUc2Z0Z282ZVJ1eE9wTVB0Q1M5?=
 =?utf-8?B?SnhmNGhScTBKMnVabVNwVmhDdWxiYmxBcURqVCsrQTVYZUUvUzlxcnNIK3k4?=
 =?utf-8?B?STZtZGJNZkJoVTRyeTJybC8ydnpRQk1lTlp0QU5rTFBFVUk2a2hZUmJhNHFu?=
 =?utf-8?B?eFMwd3p4UVBBUlltT1lPZGg2S0VwbEhwa1FhK1JoanpveHg5VlRzc05JUUs1?=
 =?utf-8?B?Sjd3ejJ0aVY3QWRzNXVldWFxS20wTkZoTjJ2UUFGSWsrZDBRT29WRksyb2hZ?=
 =?utf-8?Q?ncOMvGPeNOLjvUOtE2z4b8H6G?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fe899d72-4a45-4f30-494a-08ddd00a3396
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 08:13:59.1968 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lGe/UjaoqcpP+IoGYsXaJp/96hU6CCUdi4/acB+66npcv0Y6S2Q1/4zQO3ilrJCMrBzp5F9on1Z4PFYqr0z5Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB1159
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



On 7/29/25 9:36 PM, Bryan Brattlof wrote:
> The AM62Ax SoC family was the last part from TI to support the GP
> security variant, however this security variant was used mostly
> internally and with select early partners and never sold publicly.
> 
> To simplify things and to avoid any confusion on which parts are
> supported in the future, remove the GP tiboo3.bin builds from binman.
> 
> Signed-off-by: Bryan Brattlof <bb@ti.com>

Acked-by: Wadim Egorov <w.egorov@phytec.de>

> ---
>   arch/arm/dts/k3-am62a-phycore-som-binman.dtsi | 182 +-------------------------
>   1 file changed, 1 insertion(+), 181 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi b/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
> index 9bcdf74ffe46368ddc6a872d02f26378aba763a9..a284226320ccdf9953f2f107ee6595664e425156 100644
> --- a/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
> +++ b/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
> @@ -101,43 +101,6 @@
>   	};
>   };
>   
> -&binman {
> -	tiboot3-am62ax-gp-phycore-som.bin {
> -		filename = "tiboot3-am62ax-gp-phycore-som.bin";
> -		ti-secure-rom {
> -			content = <&u_boot_spl_unsigned>, <&ti_fs_gp>,
> -				<&combined_tifs_cfg_gp>, <&combined_dm_cfg_gp>;
> -			combined;
> -			dm-data;
> -			content-sbl = <&u_boot_spl_unsigned>;
> -			load = <CONFIG_SPL_TEXT_BASE>;
> -			content-sysfw = <&ti_fs_gp>;
> -			load-sysfw = <0x40000>;
> -			content-sysfw-data = <&combined_tifs_cfg_gp>;
> -			load-sysfw-data = <0x67000>;
> -			content-dm-data = <&combined_dm_cfg_gp>;
> -			load-dm-data = <0x43c3a800>;
> -			sw-rev = <1>;
> -			keyfile = "ti-degenerate-key.pem";
> -		};
> -		u_boot_spl_unsigned: u-boot-spl {
> -			no-expanded;
> -		};
> -		ti_fs_gp: ti-fs-gp.bin {
> -			filename = "ti-sysfw/ti-fs-firmware-am62ax-gp.bin";
> -			type = "blob-ext";
> -		};
> -		combined_tifs_cfg_gp: combined-tifs-cfg-gp.bin {
> -			filename = "combined-tifs-cfg.bin";
> -			type = "blob-ext";
> -		};
> -		combined_dm_cfg_gp: combined-dm-cfg-gp.bin {
> -			filename = "combined-dm-cfg.bin";
> -			type = "blob-ext";
> -		};
> -	};
> -};
> -
>   #include "k3-binman-capsule-r5.dtsi"
>   
>   &capsule_tiboot3 {
> @@ -197,23 +160,6 @@
>   
>   	};
>   
> -	tifsstub-gp {
> -		filename = "tifsstub.bin_gp";
> -		ti-secure-rom {
> -			content = <&tifsstub_gp>;
> -			core = "secure";
> -			load = <0x60000>;
> -			sw-rev = <CONFIG_K3_X509_SWRV>;
> -			keyfile = "ti-degenerate-key.pem";
> -			tifsstub;
> -		};
> -		tifsstub_gp: tifsstub-gp.bin {
> -			filename = "ti-sysfw/ti-fs-stub-firmware-am62ax-gp.bin";
> -			type = "blob-ext";
> -			optional;
> -		};
> -	};
> -
>   	ti-spl {
>   		insert-template = <&ti_spl_template>;
>   
> @@ -245,18 +191,6 @@
>   					};
>   				};
>   
> -				tifsstub-gp {
> -					description = "TIFSSTUB";
> -					type = "firmware";
> -					arch = "arm32";
> -					compression = "none";
> -					os = "tifsstub-gp";
> -					load = <0x9ca00000>;
> -					entry = <0x9ca00000>;
> -					blob-ext {
> -						filename = "tifsstub.bin_gp";
> -					};
> -				};
>   				dm {
>   					ti-secure {
>   						content = <&dm>;
> @@ -289,7 +223,7 @@
>   					description = "k3-am62a7-phyboard-lyra-rdk";
>   					firmware = "atf";
>   					loadables = "tee", "dm", "spl",
> -					"tifsstub-hs", "tifsstub-fs", "tifsstub-gp";
> +					"tifsstub-hs", "tifsstub-fs";
>   					fdt = "fdt-0";
>   				};
>   			};
> @@ -403,120 +337,6 @@
>   	};
>   };
>   
> -&binman {
> -	ti-spl_unsigned {
> -		insert-template = <&ti_spl_unsigned_template>;
> -
> -		fit {
> -			images {
> -				tifsstub-hs {
> -					description = "tifsstub";
> -					type = "firmware";
> -					arch = "arm32";
> -					compression = "none";
> -					os = "tifsstub-hs";
> -					load = <0x9ca00000>;
> -					entry = <0x9ca00000>;
> -					blob-ext {
> -						filename = "tifsstub.bin_hs";
> -					};
> -				};
> -
> -				tifsstub-fs {
> -					description = "tifsstub";
> -					type = "firmware";
> -					arch = "arm32";
> -					compression = "none";
> -					os = "tifsstub-fs";
> -					load = <0x9ca00000>;
> -					entry = <0x9ca00000>;
> -					blob-ext {
> -						filename = "tifsstub.bin_fs";
> -					};
> -				};
> -
> -				tifsstub-gp {
> -					description = "tifsstub";
> -					type = "firmware";
> -					arch = "arm32";
> -					compression = "none";
> -					os = "tifsstub-gp";
> -					load = <0x9ca00000>;
> -					entry = <0x9ca00000>;
> -					blob-ext {
> -						filename = "tifsstub.bin_gp";
> -					};
> -				};
> -				dm {
> -					ti-dm {
> -						filename = "ti-dm/am62axx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
> -					};
> -				};
> -
> -				fdt-0 {
> -					description = "k3-am62a7-phyboard-lyra-rdk";
> -					type = "flat_dt";
> -					arch = "arm";
> -					compression = "none";
> -					spl_am62a7_phyboard_lyra_dtb_unsigned: blob {
> -						filename = SPL_AM62A7_PHYBOARD_LYRA_DTB;
> -					};
> -				};
> -			};
> -
> -			configurations {
> -				default = "conf-0";
> -
> -				conf-0 {
> -					description = "k3-am62a7-phyboard-lyra-rdk";
> -					firmware = "atf";
> -					loadables = "tee", "dm", "spl",
> -					"tifsstub-hs", "tifsstub-fs", "tifsstub-gp";
> -					fdt = "fdt-0";
> -				};
> -			};
> -		};
> -	};
> -};
> -
> -&binman {
> -	u-boot_unsigned {
> -		insert-template = <&u_boot_unsigned_template>;
> -
> -		fit {
> -			images {
> -				uboot {
> -					description = "U-Boot for AM62Ax board";
> -				};
> -
> -				fdt-0 {
> -					description = "k3-am62a7-phyboard-lyra-rdk";
> -					type = "flat_dt";
> -					arch = "arm";
> -					compression = "none";
> -					blob {
> -						filename = AM62A7_PHYBOARD_LYRA_DTB;
> -					};
> -					hash {
> -						algo = "crc32";
> -					};
> -				};
> -			};
> -
> -			configurations {
> -				default = "conf-0";
> -
> -				conf-0 {
> -					description = "k3-am62a7-phyboard-lyra-rdk";
> -					firmware = "uboot";
> -					loadables = "uboot";
> -					fdt = "fdt-0";
> -				};
> -			};
> -		};
> -	};
> -};
> -
>   #include "k3-binman-capsule.dtsi"
>   
>   &capsule_tispl {
> 

