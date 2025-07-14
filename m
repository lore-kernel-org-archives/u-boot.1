Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DBEC83F17
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 16:35:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EA7382E37;
	Mon, 14 Jul 2025 18:35:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Qzhm/hJM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1673282F14; Mon, 14 Jul 2025 18:35:53 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2401B82CEA
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 18:35:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9qO0JUiLT0iFQSaxojfBbePTqqfm+8HgLUDTPZi8+R13vYQY0RxDPa/WM5ZpapsOTbD1wQ82wWUHEmt+XWE3uGY2GN+R/LeU4aeSj3+uMkIrIgI6H+JFz5fydkM5j9EPg773ijtHLWdIATQ8ZbGoPPLma+jWsGppyc5sxFjljhBkVrrbK9DCdZIj/zBbXEpSkgvPI+t8IyhU8L0WAFZ+vKia2QnwGauAw7LeH2JaGaSJDgJmMxXUz3sTydKPnekrCNTA4C/xk7JzDJRTl7L9tQRSX17YDTkCgp3Kp3A9PaHfM0U2YjxaIgbyGFX3QNu7ksjkGhymSRI+yGFzQwKYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AS6lnU1otgDuyeMrVF58YG049s6YBqN3W4HM2TpcCsk=;
 b=BkwXTvUw0uS02WjQpPP3qRyWaJ88O3k0atDAnGlHG4cPbLSgB287laxPVogCGW7dD/TPUg23JVuI4dzIzzlPpeJ5LvgKUAZekvYuLAVzg23GAM5DM9W6z+GjfraESqanfsPIX+tRK5Ldp9cUMQazUC68R5lVRJjr3lklR6JVSOm1FZoGVV8BRdRMiRsRq1IAjZ+pRPfqC+2WAzlxI3zqYF75QKPOvmgOHNSRVvqxBDtNZhB4/TDYIWZqbzH5KNLGZShxkzZcXh+GRf9inTPX1lX72ir4vStUxhzXws0dt7c12SJTLse9G7KfNfoDMnM/S9p/ZbpodLdZ8z6h51xucg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AS6lnU1otgDuyeMrVF58YG049s6YBqN3W4HM2TpcCsk=;
 b=Qzhm/hJMA7KRU7pWYaxIVDeELrtQhke3gFobxLH7T6LbuTIsAU+P3QvxCzFzBFWI5k8Z8ZumB60ibdlC7F75iaYxByuslRYmA9cYyF7MIhGlTkiWyzbv6DsY/x5emafHI8qEdoJgA0mEISjLzD8i5PWIzfJctflnRHBGoSfqGLw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM9PR04MB8113.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 16:35:48 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 16:35:48 +0000
Message-ID: <6034d52d-36ff-469a-8113-afaa9c26682f@cherry.de>
Date: Mon, 14 Jul 2025 18:35:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] board: rockchip: Add Radxa ROCK 4D
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250711230613.217996-1-jonas@kwiboo.se>
 <20250711230613.217996-5-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250711230613.217996-5-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0060.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::49) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM9PR04MB8113:EE_
X-MS-Office365-Filtering-Correlation-Id: 19b1ca8e-dae5-4d2e-2211-08ddc2f47cf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OHV5UElVd1RzRSsrYk82MFh2bmQ2SDZFTmcyOURsYkFGeGVSM012RXZETDJn?=
 =?utf-8?B?cE1WVGpGRHQrLzg5NXBZYjB2ZytNTnNNdU5paGc0S0pSMjNRVlRqV3F2Y1pE?=
 =?utf-8?B?SVFQc1BlMXFQYk1nNzBPRTZ0QmVPcno5cHlHYVVKY01SYVdvc1MzT2RDTE82?=
 =?utf-8?B?RzZkSTJSaGFac0ZDcDhCSzVTL3NLYzhmNXBGV2d2emV3N0MyRERwa2JwcFhl?=
 =?utf-8?B?dnpzUDY1c0VmcGdVSVozMFlpbVNaR1pIaU1TbHphdjM1c05wRFhoaWdRaTZD?=
 =?utf-8?B?SFBhRFFzM2JSRTR6ZGY3Z0plVmxHVjM2OEdqR2ovWjlYaHhEN016QUp2OGxS?=
 =?utf-8?B?aC9MV3RjMnQwem1BeGdNcVpBbldaTXdTQVBsTFJWdXk5d1pmMzNsT0RXcjJQ?=
 =?utf-8?B?eDhjOUNzZXBUdU8vbVJ4eUZZZjFodmh6T2VvQ3I0c3dmN1RKUndhc1pSeTg3?=
 =?utf-8?B?RTA5cm1oTG95RlZtbGhmdlB2NkR3WUJXcUl0dTlNNWJXekxNZHBqNW05cEU0?=
 =?utf-8?B?TDRZVDcwSWpQenpuSWE0dVI1VlFqdzUrcTA0MFllVTRPekoxMVdZY3lUbWNt?=
 =?utf-8?B?SXdGdlZMTTRIYnUvV3I0RFpoV2twOHJCRnZaemN4aUxTSjVNeEpHbHlWRXJ3?=
 =?utf-8?B?R0R5cmJockdOaTRObVB6UThiSUVidDJKYmI0ZkRCREZlUnkzN0tzR0xaTVll?=
 =?utf-8?B?SmplZ1BTVnZDNk5UUlJFdTBvNStMOEFMa1RBU1AvdHFvdTRiNk9ZZkU1K0lH?=
 =?utf-8?B?MU80bGRUbmZ1cm1DQkFhU2dnUFh6V28rSitPZ3JPWVFPOGpCSFdpaTdsOWEx?=
 =?utf-8?B?VEwvREFxdnZDQ1dkcnlOaUxmSEhQLzljK3VwQmhVWnFwYXBlZTRGWit4WGN1?=
 =?utf-8?B?NFNBNWJuNnR1YUhOYjVMeXdsbzJzRFkvTGliT1NzOGNuajFSR0dRcldHMllx?=
 =?utf-8?B?ZUNvZVNPK1VneFRpeEw0Y0FFS0F3OWt5ZjdZVGM3SmZRUDErWFdGM3U2Y1RX?=
 =?utf-8?B?UytWaXdIMmtnWURQekZob2dNajlrMytETlBxQ0dTMUE5RjFJUU9PZ1YzTHhQ?=
 =?utf-8?B?c1FmTzBjUkZLM3dleXRYMVNzbGRMNFdkbmJWQytGWVBONkVFVnRuSWlDTnJZ?=
 =?utf-8?B?SGs1b2xyaDlxcFBRL0JTVlByZk9sU1ZaRlBNRWp4VFYxZXpaNmdqREJqY1Rw?=
 =?utf-8?B?VDZITUViZ0t2dENoM01kbmFCaDBoeWhPRWRoRUNqV080SzlZUEtLeTZMSnQ1?=
 =?utf-8?B?ZUd5WkY2My9abU1MR3d2c2RZSjc4WmJydTV2bjRkc0ZOaTVvc0VCVitzaGgr?=
 =?utf-8?B?dnFDdnRwKyt2MisyVEhHd2MwTmFvbUpzSW44dlcyRXJRMU5MTUFROHhnTXNV?=
 =?utf-8?B?aDZuQUx0MndTWUxCL0c4VUZza3JIcy8rcGxIbG95cU9NSzZaQTNGWTN5V0pQ?=
 =?utf-8?B?SUNWTWtxWVVCdE9aOGNWdzA5RnpsTnVmNFhGRDE2NjdoNGgybXUvbGJ0algw?=
 =?utf-8?B?elAvUy9xOVJadTE1VDBnNTNacDMyMHFEbDlBM2hsZng0bnJKamcrTFlPbDcw?=
 =?utf-8?B?OWQrS3lwWU5lbGNEZHBIMjFmN3hJSU1wQ0ltTmVWNWo2UytHdUtQNkZ4NnJI?=
 =?utf-8?B?NXJyYkxTTVlHTVBIdGxWdjRQdUQ5aUhPZ0t4Vlh1Qkl1enorVTF4N0Y3ZUpz?=
 =?utf-8?B?UmpZTGNmZVk4WThEMUFnSkhCVjdReC8rNGdSbnloa25DVlNoenN6b2N2S0p5?=
 =?utf-8?B?YXc2eWR0TWNxdyt3RFh6d2xlTFVMK1pyT3BBcWhmVGhZN09paHFlalJNcGlV?=
 =?utf-8?B?dzFmSCtZdG9POGszRnJlaEIrcHVqM1R4elhuVzZRVytNWVhyUlJxTVRZd3Nz?=
 =?utf-8?B?NktPeXBKNHgrN0F6aXNUaHYrRjZKQnozVDBIak9wUVU5ZFNlMHpCcndqa2Ja?=
 =?utf-8?Q?x08tZ2MI+78=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzJ6YkhjbEZuaENyN3pqTFVuUWRvWldGckdUVHZnMXJwVzU3N3F3VjRKa2Zt?=
 =?utf-8?B?UnVSYnZWOTRncVNpZGRuZjh4Sk1RVG1xaTY1YVdrY1hmWktZRGhlWG51K3d3?=
 =?utf-8?B?RlZEUGZnNDR1VTRSanRkSUd6eHU3STJVY3VHRndQbnBtd3pJaHAyS3VmeEVG?=
 =?utf-8?B?dXFYYWRjcU9wMVpray9JNWFQUVpQbFJMNUV0UzhMMW02OXVpekx2ajlrT3Jl?=
 =?utf-8?B?WnZBQUtwZXVxTS9IUnJCdzJxc1pOQ3Y5dEJTYkZZdmdvM2htSFNDTjdWWWxl?=
 =?utf-8?B?YXlJT0FjSlZrMDN1MXpQemtySGtvWU5ZU29lN003SWljT0NLL1QydzMwMHdX?=
 =?utf-8?B?VEdrclQ3SU0vclZUTGNWcHZDU3FWZm8wK3k5WG1qUTU0Q0VDWitFc1U3dEtK?=
 =?utf-8?B?WVZpUDhTTHVxaWNXaUhpalA0SWJFeG40eERkMWVGVWo2OGVsWnBNeCtKSmla?=
 =?utf-8?B?NEp2RHlCdlVVcm15N1MycG9wZlpQVHlJSEN0Qm4rMXg4SkpXc0tKcEpxWlds?=
 =?utf-8?B?dEw5TjJPN3pFcVc1WnZxM1V0cFU5T3hCMWhVdzEzaFR6SG56eFVTOXZjNWdi?=
 =?utf-8?B?U1loUUhlRVd1bWwxNEo0bTE5Z1FTN2ptK0F4bUZyRElkVzl3cXhuSjdIOWxO?=
 =?utf-8?B?RTZGNk93ZkZrS04xdUdxcVllV0ppQkpONFlvMkYzNTBWaFF4Q1lzUDJyWWp5?=
 =?utf-8?B?RmtEamJBK0RBL0psMXdCU3hmV1pUOTNCREJTUGU2QklmUENoMnRPNTg5bmJn?=
 =?utf-8?B?MXh6NFVUQmQ1QXFvRjFiY0FXUFhNVC95b1VlVWdjWW1xUG5rUWw4QWNoRDlx?=
 =?utf-8?B?ZllJdG5KMStkclBJbkdoTEhNc2NGZDRrT09DSVp3QWEvTTRkRTJLQXFVTUt4?=
 =?utf-8?B?UXd5ZmlqaG1vV1FnSHU0Yy95UDZVckxUUmVMVXNXVjZPR1RkQUJwSWJzVzY0?=
 =?utf-8?B?Y0p2V0tiVUxtU08wa3NwMENhQ0R0eHNHdTg3SUVqcUhoZ3Q5Uy9sVlppaHBh?=
 =?utf-8?B?U09Pa1pXekk3Qi81VnVUOFNPZU5HS1M0MDhoMjZKaVFZMkFNSGU3QzFOMTI1?=
 =?utf-8?B?NGVzMExtRDR3cUFlaFN0TWdkUlRRbjJyZjNLLzlYMTZFUWQ2cithODltTTlL?=
 =?utf-8?B?ZHRTY04yb2JlNkJyaTg0cHJoczZNbEF1WDI0N3hseGk3bzBScEMwWG5tdys2?=
 =?utf-8?B?R1VyNEh0bk9DZEZSa0RJZXd4RytxSldTbFVKTUg2UUxPNW1NN2ZjK1ozYjQr?=
 =?utf-8?B?cmdmZ1VaWHZxaWlXWkNlLzViZGtzT1oyQ1JEU1dVcDVGUFJRUEZGRzAwUG5l?=
 =?utf-8?B?T1VidndMVFV3Wklscmo1NmpqbExYeTR5VFF1MU9raU9Ld3ZLKzE2ay9Rajkr?=
 =?utf-8?B?UTRYMTJkWnE4QjF0V2hNRVBjbDkzcnkvaEdVb1dyQlRkSHNMTHhXS0F2Mi9t?=
 =?utf-8?B?ZElIdTVVMG9IMlBhNWpHemRyZXdwYTI3NnQ1ZE1QdTlSdVV2Q1Q0amJObzM5?=
 =?utf-8?B?MnFmRGUxWGJTbjdRWU11dGkzV1A3ZENzK05ZVEpHcFpyZVkxVEFGS2xTSFNo?=
 =?utf-8?B?OHJPWUlRTC9KME1GeU01MzVtR2pNdWxWZ3J6UDJTcExTRkRNYkt6WW8waExt?=
 =?utf-8?B?RXgwV2t4eTJWbjk0N2RrMlNXTlBtcGVIOWF0cHlHa09XWUtxcGhoUHlTajFE?=
 =?utf-8?B?SVNrdE9zY1MvK2JEV3pBdVJySUgrME5kRm5zQVVmNHU0L3BXT0hXeElzdVBh?=
 =?utf-8?B?Tkc4c3Q3ZVpNVmpOb0pqeUJXU1NYaERRVTZGczdmd1VYYnJGL0xqbC8zSmkx?=
 =?utf-8?B?V1lBSHlqQndQb3NmY21SOTY2SEVOTmdGTTE0ZjVBd283RVc3SUpzN0J2dlFy?=
 =?utf-8?B?VWhYU1ZqamVkdUg5SHRoTGhhQVpIbTJPelllQnVhQVo2OTQrd2JQL0pPWjQ3?=
 =?utf-8?B?TEJMb1E2MlRrWUIwUWlaZVY2ZHQ0N1VWc0pvWTRtS0Mxak4yeEFSMjFwbElu?=
 =?utf-8?B?V3Y5MXVRNVcvQ3BvdUtnWW0rR2QxSXJFYUZWZDBpQ09JaWFVdk5ubXJocmNO?=
 =?utf-8?B?cXhxNTRzcFNNRTBidTdDSnRKZXA5RHcxVTUwYzRoRXBZUXowNG9MbjBlL0xh?=
 =?utf-8?B?YmdNVkxIVGxKK2pWanNtamFiTk1Zc1doVWErNjBrUkxFRnNJdHQ1TVhqTG9O?=
 =?utf-8?B?MVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b1ca8e-dae5-4d2e-2211-08ddc2f47cf0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 16:35:48.1886 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8nt8G+FIR+OpILyUpsYnOrxO/hJ517mhevTiERp+ittkfxZ8oPhJfoRyTiiQ3hBn7/2lnea68fppAfLziQMSHx0Run4Y3FVdJz2XrnuCsms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8113
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

Hi Jonas,

On 7/12/25 1:06 AM, Jonas Karlman wrote:
> The Radxa ROCK 4D is a compact single-board computer (SBC) featuring
> numerous top-tier functions, features, and expansion options.
> 
> Equipped with the Rockchip RK3576 or RK3576J SoC, the ROCK 4D boasts an
> octa-core CPU (4x Cortex-A72 + 4x Cortex-A53), Mali-G52 GPU, and a
> powerful 6 TOPS NPU, making it ideal for AI and multimedia tasks.
> 
> Features tested on a Radxa ROCK 4D v1.112:
> - SPI Flash boot
> - Ethernet
> 
> ROCK 4D boards with SPI Flash is configured to boot from FSPI0->UFS->USB,
> or directly from USB when the MASKROM button is pressed, booting
> directly from SD-card is not possible on these boards.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   arch/arm/dts/rk3576-rock-4d-u-boot.dtsi   | 15 +++++
>   arch/arm/mach-rockchip/rk3576/MAINTAINERS |  6 ++
>   configs/rock-4d-rk3576_defconfig          | 68 +++++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst           |  1 +
>   4 files changed, 90 insertions(+)
>   create mode 100644 arch/arm/dts/rk3576-rock-4d-u-boot.dtsi
>   create mode 100644 configs/rock-4d-rk3576_defconfig
> 
> diff --git a/arch/arm/dts/rk3576-rock-4d-u-boot.dtsi b/arch/arm/dts/rk3576-rock-4d-u-boot.dtsi
> new file mode 100644
> index 000000000000..5056a1cecb83
> --- /dev/null
> +++ b/arch/arm/dts/rk3576-rock-4d-u-boot.dtsi
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk3576-u-boot.dtsi"
> +
> +&rgmii_phy0 {
> +	/delete-property/ reset-gpio;
> +	reset-gpios = <&gpio2 RK_PB5 GPIO_ACTIVE_LOW>;

Why?

If the upstream DT is wrong, please fix the upstream DT first and 
cherry-pick.

If it isn't wrong, then can't we simply patch the PHY subsystem/driver 
to be able to read reset-gpio too instead?

Cheers,
Quentin
