Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74277C83F17
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 13:11:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FBF682E37;
	Tue, 15 Jul 2025 15:11:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="cREA63fC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 521FE82F14; Tue, 15 Jul 2025 15:11:47 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9FD982BF6
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 15:11:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cNa0c7UTvVub+toduprmfVp9njNd7kkObm/IFD8jYeEMjIZ7C8fS+SjdzLGW2voWphOyE7psHv0Wm+e0Kwlo7486ZmZVyfUYsGV+3oTqaukbc6Zd2Xb69i+95QSspMjBrTB7ZrMjRRVx+6/sOUkNDksawNhoG8To3asWlI2j43yasWhsz/N6QGfNtSljFCwIfxDpqJOpM4U1d4ufGkuywDWyzd7Aq/lLl/DlWCO0S9jMPPUxnQtm32YQbiy1OV3/iheBoKfVJg9U4qIBYRcYroEH0GsP/qei21myFyfCmjQVTXbC7sf+i6qmcoNM7xfynjE4GVYtVjjsYabNwQgngA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15VFctlD/2NhJyGtQkt2OGzB7Usqd/u9zsDcYmp0w4k=;
 b=ED7iu1v7mMyFEWmeywHcOv+Ndh9zwmm6x4e/nQGYk/Kb9gHCJfboS/4bU/YNOJf7tOvJAVa8iKk0jvi/DS3tOS9PPgLwBz2ItCPbepPeN+bdzaU8Mpny8/jgeyqZQOxfIBNkThmnLO9EQ6O122M5ssEFSF2P0Mw/wdXfvm+U2hk5ABzCaA2NJiyLbfLHDo47pXs+D9z0I4hhanRbf6rkwyqbxad3l2ar3mRfXNV9omHPpxQOVL9vUhYw0iNJTBAcBVrit9lHz5SOHPqvEUyAMC79Qlbf/Smqd1fF69jJ2WT7wzaQammINzl+tQiZacbt7tTh/FG2j19WV8e0+jBtJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15VFctlD/2NhJyGtQkt2OGzB7Usqd/u9zsDcYmp0w4k=;
 b=cREA63fCFrqry03Yo3sxroVWLt01yuonQqYi+/EHtGsfw6FSRhC6rjp51MPg0WpcW5TapEnzul4XDx3Jfs4b1GFODVkXlWs87KevpwVZomffTN48ywJ8r0esVOcspMCmlaPsBkp4lxImZnUqSc9jdMKjW+wY3v/rs9dHHzVHOLY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM9PR04MB7489.eurprd04.prod.outlook.com (2603:10a6:20b:281::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 13:11:42 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 13:11:42 +0000
Message-ID: <9390c906-4462-4e02-83f5-5e7d05dd956f@cherry.de>
Date: Tue, 15 Jul 2025 15:11:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: spl-boot-order: Defer probe of boot device
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 u-boot@lists.denx.de
References: <20250712211232.680047-1-jonas@kwiboo.se>
 <0df75337-a0e0-4076-93db-aa8632e23c8e@cherry.de>
 <13913124-c2b9-4072-b57e-7012b2a222ec@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <13913124-c2b9-4072-b57e-7012b2a222ec@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0079.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::20) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM9PR04MB7489:EE_
X-MS-Office365-Filtering-Correlation-Id: 33526a02-92d1-4929-fa56-08ddc3a12433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OFlnTjE0VnhsWFBheHMvRWJrSGl3SjRqSlJJdzRVOGJGRUUyZjVoQk1NOXgy?=
 =?utf-8?B?ZkFaWFpBdDBUWTdMT1NMUDBwcmZ3aHk2ZTViQ0FSeFVLTWFRTThmY0dQSjNw?=
 =?utf-8?B?U3FmdkpkN3A3dnFHMGIwdDN4b2dwU1VhOG9JU0hpRGlVUmhMQ05tb2c4T1Bv?=
 =?utf-8?B?ZExSbFp2MHFlVnZ3QkV6STltTjBjVEZQV204eWJleGJIeFQvVkczbitvSlBQ?=
 =?utf-8?B?a0dYL2Q0cnJoL0lqTW5JTTNLYTFoUnBKdzVibDU5b2F0Qm16UXRoYnZESEVJ?=
 =?utf-8?B?VFY3N3M2aFN0c2FjQ0hDMVhFMlBDbXVvWktiU1pERXR6a012L1dtYklGMkdv?=
 =?utf-8?B?a3FWQ1Zndzhnc2Vnb0V1UDFXbWNITVdkeWZpakpaVUUrSnlSanhZelg3MTlJ?=
 =?utf-8?B?dldxcUc4REJJVUJ4LzBvOUJPLzJxYnpaL05YaEdHMFZMQjZ3dWZBTjlFQUFG?=
 =?utf-8?B?STN0VjZVQ2g2STg2amxiZjVjZkxHdS9haXB0aEVwYzRlSnBBSkczQVVjbUVq?=
 =?utf-8?B?V2lZOXJ3MFNzOVJWSm1mM2Fyd3BSeHVjK2YyRjh1Q2V4K29xdmpNdzBhaVE5?=
 =?utf-8?B?Q2ZuNnVzQWJoVnRXL25MaU5nQ1BNSy9iaUZucFZmb2hENXlIVzh6VHY3Mk4v?=
 =?utf-8?B?UTNCNVc3dHhxM0syYXRQUXVTL2xZY3o3MnpjZTBnRnlBcWRYY3JsT3N0VC9V?=
 =?utf-8?B?QzJjMjZYUlJIdVYzN1dORFY1TEIwM1JrU0dZMlFCSUlEdmp3b2lROGc4aUpp?=
 =?utf-8?B?UW9BZEgxVDBGUGI2VjM3OW9vd3VEUE94eUwyWldDdTZ2amxaYUpmNWlRVm5o?=
 =?utf-8?B?Q1YrcHhlZlF0OU9IQko4b1NGaEZrSGhXYUY0VHUxL1oyWEFyb0dSQ2lybDVR?=
 =?utf-8?B?Ykw0eGNwcDBIREFjTEo5ZGJZQlJ1WXJ6VGtseGpQNTZsd045d3JhbnU3bEs3?=
 =?utf-8?B?N2o0NGNjUTRRUHpwaGZ2TGNzeENtWnJDOURFMm8yMElyVWtNT0c2TEVYeGxy?=
 =?utf-8?B?RTFQYnBKWFRza3p0TFlKd2dpS1F3TEVUSmNsM1I3ZHJsaEFybXNoSWQ5VUlM?=
 =?utf-8?B?aEFjNzZTV01PVzRXSGpwaG9adm1jdkpEQVNoNzY1dDNoRlZtMVlWZFNINVps?=
 =?utf-8?B?U29EQXNoejlOQ3ZLVWpqelpYNmJRamwySFIySndQcVZLbnB4ZVdwUThqcDRL?=
 =?utf-8?B?dlBZcG5TWXlWeXpuSFJmY3pnUlMxWHhKbDZwc0Nvb1RVTmpYb241ZnRyNS9S?=
 =?utf-8?B?MjhoZE9DMllEc2gwRmtjUjFCa25xOEpNd2Qrd3VycjczYmYraSthNzU0b0hS?=
 =?utf-8?B?T1IvNTlCeWRDRnRaRVpFU1cyajNscUoxaVVKVi9DamgyMjFtTE94RFN3K2RE?=
 =?utf-8?B?UGkxV3orMVVlNjloZ0NGSHBxNi9rbnBhN0pNRmJRbHV4YW5JNk9sek9jc3Vm?=
 =?utf-8?B?QnpFUmJrbFpXbVMzMkIxM2c1V1J5S3NXQTdodGV3THBhNTgrc0pCb1Z5Rm5i?=
 =?utf-8?B?Um4xQ1VublhKSnJmWmpLNEhSaXVaV3RRT3M2Ni9NT3hySXNCWHlFdGMwU25G?=
 =?utf-8?B?eVdMeDZrRnlDQUJjTzdEbFQvSWVVVFoyTzJkclZMRXp2N2VOeElDN1ZBY0VC?=
 =?utf-8?B?YmZWb3V5WnljS0U2aGNLV1BacTcyUDY2d2FVUGhjRzFCUHE1a1dXTnBidWpE?=
 =?utf-8?B?T2JxR1haWDc0SVU3Qnova29VMHcyWTFxQzAwV2lReTFyNVJ2blRvU2RLSFlG?=
 =?utf-8?B?d1hTYnJRejhLaDlhZmdTZ3AzNXBXRlJOSjIzRGErVDgxL3VXZElOK2pRT3RE?=
 =?utf-8?B?VnIrVmZ1NmdqT0ZtcTNNR2NxNzI3WlNJY3I5Q2NjelBJWnY5ZXJhNjFMcE5I?=
 =?utf-8?B?VTMvamNJR2YyaVBwaWV0OUpuTlNyVUhVRlg1UW9RcHhtcG0xV2N2YWlteWRT?=
 =?utf-8?Q?RS7W03aS+Sk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tm5YLzBaMDVtcnhscHVPbTFTVWVUMVY4Vjc2WUFiM3VHZ2RJSTNyaGRKelVh?=
 =?utf-8?B?d05pUzk5VkhHMzM3QUlOb3NWSHdXdUp2M3gvZGhhcGlYM0R5ZDMrTTQ2ZmtH?=
 =?utf-8?B?M012NzdkRGwyeUFBeUxza3pRcW1od0NFK2N5V2hlL3JGN3VGRUYrR2Jrc3dL?=
 =?utf-8?B?QVBZWXdyWFl6NlJhLzFRcUlnRkpGeHMxTXBIb1FqM2VZSVE0UmpVRjZNUVRR?=
 =?utf-8?B?SnFlRkVmYWljOE5EZjJvUC9PZUJPTk5JOFlhVmNFUk9ILzJuU2krS2JhVFlW?=
 =?utf-8?B?Smp4aStVOXBhS2xudEpKUFZkaVFyakJ4VkRLYnAya3ZNekFiUzIvVDZ5dFBh?=
 =?utf-8?B?SU1idWVENVorVncxajBub2V3Y0xzWTdSUjVtQUs4MFhuRzZrT2F0NVd1NkZl?=
 =?utf-8?B?bDI5UEhuNkNaeVJGVjQ1VWF1dmxMak5UdS9KL0xPcjJtS0hQL3l6Z1hOWHpW?=
 =?utf-8?B?QW9zaElmSytIemNKY1NWYWhxTVFuQjBIV3liMS9jb0d0cDFzaHJvT3pORnBB?=
 =?utf-8?B?V0JTT3ZJRGxKUVljQitpVFBDOUFJQTVDL1cyVkZGaVI3bVVtRWxXSkF3Rlor?=
 =?utf-8?B?dUttOWlJTzBqTTNubDVxU2VMc0c0UDBDQ2NmWlM5aFJ1WjhSZ0VjQW5adjU3?=
 =?utf-8?B?c2hyVVVUUERhK0wyWDJ1WStQYkpXVzFxNVNNOFVibHVwdDcyak84Wlg5dmN2?=
 =?utf-8?B?TEErQXd6M3d1elhvOFl1UlZ0UCtYK2N3T1NhRlZiVFB1UHhoN0VDSWtld3NH?=
 =?utf-8?B?WXZHVmErWTFSU2h2TnoyZFpJQ1dpK3ZFYWV0dkVEYnY0RWljK1RONXcyVlFZ?=
 =?utf-8?B?TVdIZzE2VDhnaHF3bWtTTlhjVE5ESFZGNkhheXN0QVdZeGxwcXpXMWtkclV5?=
 =?utf-8?B?Ujg0d09taEk1TC9WMmxoLzBaOWY0UlNTZWN5VDZKRHZZL3dnMzBRUVJWZll0?=
 =?utf-8?B?ZTQrMFZNZDIyTTdQWWZoQzFjWmF6SFJ2NDdydi9lbGRxNzViTW9sRmNrQ09H?=
 =?utf-8?B?alR2TkIyaklBOGdCMW5VYmRzelYyU2dldzRQcGZBT0QwYjR3UngydEpPWGZv?=
 =?utf-8?B?eHRUTU82SWwxTEg2OHZJbHBxNlBqT2RNMlh6ZmNXdUJTbUpuNXYxdEhHVnYx?=
 =?utf-8?B?VEJ1c01rbWtHUXJETnlrYy9XTk5OTERHRXR1d09jODc4K0ppWmhTSkpGblJj?=
 =?utf-8?B?RHZnWXdzTHBPVy9FN0M1UkFubkhQdDRab1lxTjJlWXYyVGI1ZE1paCtVWUQv?=
 =?utf-8?B?aW1XeFV4S0tFT1BNWFNkRjlsbDFsU3l0eEFHZW5BZElMdkp5ajhwcmtIK0RL?=
 =?utf-8?B?a3lucGxxTDBxS2hLZTNqSGlxYnNkWGwwQmVkUXRhUWM3bTdBZjBHQXl4dk9X?=
 =?utf-8?B?RnpZNWpvOFhHVWwyaDRrNkdMaU1QSTZEUTRFVnRCa1VJbldqSU9LTjA2RytI?=
 =?utf-8?B?MWludGdzUVJTbTQrK3RTajEyWno2VjhUVVowNktldERDQTU4c0t6TnhFeEFP?=
 =?utf-8?B?ZE1GbW5sbXJEQVNZbjkxVkhtbzRLeGNyeXg1RkVwOEcxSThwc1VJZUNYMmRt?=
 =?utf-8?B?bFNoaDkrcDhpaVFYS3lKa0FWL2FzSzBpbjBNTERENEQxUXRyQ2NwNkFWSC93?=
 =?utf-8?B?ZzFEUlpmQkpTNC9aWGhENlM2OVhTNDhIQzA0V0pXdEFKYkUvQ1Rabjg2M09Q?=
 =?utf-8?B?L1VQOFZRdE5RUWVGcS9PUzRzYTU0NFgvOWJYWmJqR2lNd21jdXc4NzloVUtI?=
 =?utf-8?B?MUlSQ0NKakIzWHMydkFkVXloM2NidmpJMHU5cXpBbkREcHdpYWJ0a0tPT1lK?=
 =?utf-8?B?dko0N3VoV243b294cStDY1B4MGVVOGtqa2VHM0k3RHNROXhxcE5td3NDb0Fy?=
 =?utf-8?B?RmlLai8zNGdOcmczeXhMeHphc2lRZFIxS1AyM2hIYm4wb2txdnpFR2drQkFL?=
 =?utf-8?B?SWZldk90UExtM0JLY2hWZXorUm4yRVd5d1ZHT282YWNTZm4vdWR4cWhuSjVp?=
 =?utf-8?B?TzQ4YkhUVVhoVDFQMFo5a0t3MmFQNkhnRnRjRjhLMWxzVklEa1lHa0h6UHFx?=
 =?utf-8?B?SVVTU1R5dGZTVkpqUWNtRmIyZlpLL2JMOG1aSzFIaGduWFBBbjdqWTZrSHBN?=
 =?utf-8?B?TzVSbXZjekpld1dXSklyenpaU2I3U0k4UGJQZnV0SVBlNllBbnhmT0tGQWha?=
 =?utf-8?B?ZlE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 33526a02-92d1-4929-fa56-08ddc3a12433
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 13:11:42.2394 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dfym0wDJbBd9tznv/UmuYJIBrnvK0VMggai56HYObogZByDtGm+qBIxovFk1MCHFMuBaLQeljjCbilvaEu0cbEgRrw5DDOjX6weoqrw0v/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7489
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

On 7/15/25 11:36 AM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 7/15/2025 11:07 AM, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 7/12/25 11:12 PM, Jonas Karlman wrote:
>>> Boot devices are being probed when SPL boot order is determined. This
>>> may delay boot slightly and can prevent booting from SPI Flash on boards
>>> that use same pins for SPI Flash and eMMC due to pinctrl being applied
>>> prior to booting.
>>>
>>
>> How would that be possible? One cannot have the same pins used for SPI
>> flash and eMMC at the same time? So that would be an issue in the DT or
>> a misconfigured DT for the board?
> 
> Correct, basically there are SoCs, RK3576 and RK3588S comes to mind,
> that share/mux pins for FSPI and EMMC. And some devices with those SoCs
> have options to mount a SPI flash or eMMC module using same connector.
> 
> E.g. Radxa has a SPI flash module for ROCK 5A/5C that can be mounted on
> the eMMC connector. And ROCK 4D has a shared eMMC/UFS connector with a
> SPI flash mounted onboard (in some configurations).
> 
> When I tried to boot from SPI flash on my ROCK 4D and was trying to
> describe the eMMC module, SPL would instead first probe the SPI flash
> module and apply the pinctrl for FSPI func, and then when it tries to
> lookup more boot options, it instead probed the sdhci controller and
> applied pinctrl for emmc so loading FIT from SPI flash then failed.
> 

Yeah... but that's an invalid DT you just used, no? SPI flash AND eMMC 
cannot be used at the same time? So we should either have SPI flash or 
eMMC enabled in the DT and not both? Or are you planning on supporting 
booting from SPI flash entirely and then somehow have proper load stuff 
from the eMMC and not SPI flash or something?

> With probe and thus apply of pinctrl happening later when images are
> loaded we should be able to create a single boot image that dynamically
> can apply correct FDT/DTBO depending if it was booted from SPI flash or
> eMMC. Or for the ROCK 4D case (can only boot from FSPI->UFS->USB) being
> able to boot from SPI flash and then switch to use eMMC for storage.
> 

I see... So the point would be to have a DTBO with pluggable eMMC which 
disables the SPI flash and another one with pluggable UFS flash and load 
the appropriate one based on the boot medium used by the BootROM to load 
the TPL? This however makes a fallback impossible (e.g. booting from 
SD/SPI flash so we don't know whether UFS, eMMC or no pluggable storage 
medium is provided, no or corrupted proper on SD/SPI flash, how to know 
which next storage to try?).

Maybe we would need to tentatively apply pluggable eMMC DTBO, try to 
probe, remove the drivers, apply pluggable UFS DTBO, try to probe, 
remove the drivers, etc... Seems very complex though :/

> Something to investigate more in a follow up series.
> 

Have fun :)

Don't we need to describe the eMMC (sdhci) controller with the pinmux 
for SPL to be able to load proper from it? Which would conflict with the 
one from the eMMC controller's? This all seems to be due to some WIP 
state, bring-up of Rock 4D and odd HW configurations rather than stuff 
we should support in the long run?

I'm still a bit confused by what the plan for 4D and the additional 
pluggable storage medium are, do you have anything in mind?

With my current understanding, I would say that we simply should remove 
the part about preventing to boot from other storage medium as that is 
the result of some WIP state that shouldn't make it to upstream U-Boot? 
We can describe the current limitations in the documentation if you want.

Not wanting to probe devices before they are used is valid though, so 
the code part of this patch seems reasonable to me.

Cheers,
Quentin
