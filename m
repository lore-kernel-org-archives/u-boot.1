Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24A4D69114
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 15:06:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57843893AC;
	Thu, 28 Nov 2024 16:06:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="lAWjwIMB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5187893B6; Thu, 28 Nov 2024 16:06:07 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::610])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9532893A7
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 16:06:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPLYSF/xdzidp61FYsm9CiiGb1REBlN8VgXVSwMJFf0lEcX1ivXTKYjeubHiTOQyw+Xq3ofOUTq312rA8hfXZE4rMfk3uoXO9hG3kGEm54l1mCMkOb7C4axBy0eo/Gj98nhID22ZArNcPghAZ/Jf8LHQrS1HZTtLDXq9aUGrxXQCUBV3n91hxGo/1tmaHpVf/NGFnbR2+kl1W9u1L13FMDSRyEHhzS4w1d7RKYydm9j1s4YGqiBHuk82uDD3AqkxzOOkFpq17gZmTWL38gv3nEicBh7bJdNoLfelOYuDGoL9WgfROIayAFe/2OJDjwcb6YqVvbfRwsgLDUqMXaY2vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZK/PqFSl6R5fMCl+BuYwrF3DUoD2RoBsH2cCEeGi6uM=;
 b=xkyKkhXZ9SnNe911Tl5JX1k0fSChdjxO/A9lcAdmxMQ3FvwqanoYZRN0JRS4dojbQ60NpGoHBNq2fmpjHQxF2Gtk9fmcxyji8X/5U8Zv1y/Byvd/ucc5/xfypePQfAWLSQtDXvqkDrr73miKrjX5ZBN6JFIGFoBRoR11+TgiJ2oqgYJfIjWlzmsLil3GB6dGsJEMkvEcaQy+fl6Q8V8q9lJzV51zPoUi7TkYQLyUwXVSvwiLgn3lDVPAwJZfQ7vynIiT/D12qX1PVWWWSFsNBCh5K6UA84IuMK8ItGk5az485r+cwlVsxvK6NTnA3nlw34WRLcnY0lrJuzwuwI4G3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZK/PqFSl6R5fMCl+BuYwrF3DUoD2RoBsH2cCEeGi6uM=;
 b=lAWjwIMB8j3180Xts3UHw9onLOA/wxtKgybssI9fwDqZQVUsd/maR63zVnMh99zHW1uzBoCq3/0w602sfzEpgDUiQZanh+VYzJ5VjIer22IOxIF2ZzBtowprvz4JKDdeD4cxGKSiIOFbmuV855fu/2UFUPR3K0L1gq7itbqA0DU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM7PR04MB7142.eurprd04.prod.outlook.com (2603:10a6:20b:113::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.12; Thu, 28 Nov
 2024 15:06:01 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 15:06:01 +0000
Message-ID: <cb8deb5e-e3a7-411e-92ca-442300be6923@cherry.de>
Date: Thu, 28 Nov 2024 16:06:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lwip: wget: Fix incorrect rebase of 5907c81 on top of
 5907c81
To: Adriano Cordova <adrianox@gmail.com>, u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org, trini@konsulko.com
References: <20241128143704.590211-1-adrianox@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241128143704.590211-1-adrianox@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0182.eurprd09.prod.outlook.com
 (2603:10a6:800:120::36) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM7PR04MB7142:EE_
X-MS-Office365-Filtering-Correlation-Id: 9483aea9-6b11-4609-780d-08dd0fbe2c0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SFhscXo3MGYwNTZaSW1RVk5ER3BMRHB6ejF6Ykk2N21lY0JTV2ZwdWNVaHFU?=
 =?utf-8?B?c3ZEaWgzTlZQakNIRHRKbkpLUjNXVWhSNXZ0VDUxbkR3NHp4QUN2YUJTRy9n?=
 =?utf-8?B?bnJlM1NPOWVocWVOcGJGWjNPekZyZDk2LzU3UU8zTDFldEZUN1pYa2RPbms0?=
 =?utf-8?B?Nkhnc0Jza2srbExGc0hTdjUrNGVnNlRHTXAvSTdsUmtLTjV5TnBNUGRMWEVN?=
 =?utf-8?B?R2U5QVovRHRUajhiRVR0NFVWd1hlaDFVd2RXV1NPRzA0UVdWWE1DRzkyOXI0?=
 =?utf-8?B?Yy9qU1pBOVdXN1AyTWR2NVlLWjYyK05hU29PZENRQUVaQmhScXN6MWtjRmpv?=
 =?utf-8?B?WGdISllDSHVVOWdZYUxsMEZURDJrVnhKM2x1V2RWNzFCeTFOUjhmVjRxY3dh?=
 =?utf-8?B?cG5PR0U4YW8xUk1Ydjl4NGs4NlhjYldvSUJxVTJYQU1mbDNhN3Y4OU9hRFRt?=
 =?utf-8?B?aXlWMWxLZ3FpdXBlNnBNYTlBcFpFT2ZlZEJXZWd6VGtVR2RpK0gyMmJyVkNo?=
 =?utf-8?B?Vk40eTB3aFJDSWg5ejNTZzN6clh4RWlxVGc3aUpETDBxSEtSRE1ya1pUS3Rj?=
 =?utf-8?B?TzMvQlladGJYYW5ueXdkZ3ZDZTVncm04N0dvdEZmNk9ZVk9pb0t1Z0ZmRi9z?=
 =?utf-8?B?azdBZ0dZUVpFMElucTd5TFMrN1duQjlIaitjMFZzUzRVamE3ckE0NnMzanJy?=
 =?utf-8?B?SUJ4Uk1xYUljd2ZPaVludjliRGM2Z3AxTnBUTFBNeVhJNmZ3VUJvWVZJOU1m?=
 =?utf-8?B?bXp4V2FocW1FZnlmeEthQlppMVlhN0VvNTJBdjUxazlHWXpLMzRUUXUvQU1T?=
 =?utf-8?B?V3AveFRpRkJNaSs0NTA0a0J5cWp6eWpzMlJRbEhHNWNaREI4b1JqMmJ1OWZH?=
 =?utf-8?B?ZTNVQjRHOU9GSEhmV0RZNnlNanZBU0p3M1I3YTJXenZvZTdkQjhFRys0UkhL?=
 =?utf-8?B?TS9VdHVvVFpQZUlRNlc0MDlCU2xQSGtCOHdkaHVmOGg1Y2ovYVhqaUlaQjU3?=
 =?utf-8?B?bm9JWGMzOE41MDNlSnJBM1ZCUXdTcE9aM0twVlNIQ0ZrVjQ4ZzJpWGZlNUZ0?=
 =?utf-8?B?MVZCQWpWTHN4ZU5qS0tvRjM3UDg4Z3Z3MlZNRWdGa3JETENXYmUzRWtuTGZ6?=
 =?utf-8?B?eUswZk1DRm9hVGxQSTdHMGtKdnhMVmttMUs0dGJxdHZkUHRtTVUrcnB5eDFL?=
 =?utf-8?B?WWVJRDhwQ2FOa0pSRWU2R3NsL1U0VW5yVFdrZXFWRlIwOHpTU0VVUlJLaGJ3?=
 =?utf-8?B?MkFMdlNpR0tsQ3NxSWNUUFF0YkZ1TDdwVlU4NzN3ekxzU2lRZUlwSXJKUTJo?=
 =?utf-8?B?Nzl2UGZ3ZHg0N0Fpbk5HUHQxZDZjN3kyQUM5OXgrbU9TTUcvaDhNSVczR2Zo?=
 =?utf-8?B?bm54MENjSytyTVkwWEsyTElRaGV3ZWdmMzdtWXhLYW43Sm54R1hPWFkrL0k3?=
 =?utf-8?B?REd4bmtzT2VVbFFDbTFpNUpYTExIZys1bVJSQXBIMGl4eHpDeUE1VWhoeGxF?=
 =?utf-8?B?Yk1tWmVvSGlqeUVzdVE4VmtTN3cyd1F3bytCNTBxQTBUVlQrY2N0blZQK1ky?=
 =?utf-8?B?TDRmWDN1d041UW5COWhGRFVsa2s1eUJYblF1OWsvaUhNZEk4d1cvYXFwcHVT?=
 =?utf-8?B?WWNwMlFjSUVVMHlKaWRqNnJGa1ZmMHEzUzA2R3hkKytPMXRKZkJHY0RKQWp1?=
 =?utf-8?B?ZjJoeWhtZXlLV0tkVXVXUTlsVVQ2VXdJbDlxdUlCYmJjK09CdzVCM2JYTncv?=
 =?utf-8?B?ZGJFWXhNMUVLT1M3STZ3YlhaaHN1Y1Nid0tDVUF3bWVCWm1tL1hNMHo2WGl0?=
 =?utf-8?B?RjdOZnluT2JXWks5eU1idz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDBUWjFWeDMxOVpJNzdGOG1Kd2VHU1UxOEw4UkgvWlpEWnRMRzV5MTI0SHlN?=
 =?utf-8?B?bFora2ZlTjJIUi94UjBEeGdTeEJwMmRvOFM3OUt4Z2Y5REI5RmRicUhQSGps?=
 =?utf-8?B?V3lla2phYm9URW9uOTJ6ODhwdjBVdWhGbHNiZFI2dlFoU2NPaEdJTm5sWUxF?=
 =?utf-8?B?TzVuQkxXN1hrRzg4VWJSdHc5VjRJc0RQeTJyRzI3VjZOM3k4dW0zMnY1SlRj?=
 =?utf-8?B?aTU3MDBmR240aEF5cFdRRVZteEVsMEJEaHFHYzJ1enQxTXZHbEZrdkpwaVht?=
 =?utf-8?B?dWFEZ2podEQvZEdaUnpUam1pNEJKQ281UCtockU1Z29jV1FOZUZKK0xnbytM?=
 =?utf-8?B?b0MrYkVFdlJZZW9Gc2VlYW5zUlJ1dklCV1dyOUxYSlVESkExbHNvejJQZ3hX?=
 =?utf-8?B?SUtjWXNJTVhFSXBWWUlFYW9GdnR4azlHZ3RsNzYzZ1RPVE05M1VuOXlzSWc4?=
 =?utf-8?B?U05yN0dvZm91ZFhEVTNlNWpvbENvWWpvWUpjeUxORi84d3pHbWM5VkVrUTRm?=
 =?utf-8?B?YlpBTVJxY1lqOGdUYzVZSDRXNHVjUWhDNHVHZWxWS3k2NFl3WEQzc3I5VzlM?=
 =?utf-8?B?NXhyd09oQzFST2pyOFBZdmpSWDJLcTV1emp5MEtDZTRyb1l1WUVWemFvT2dv?=
 =?utf-8?B?bEhqeXp3aERsTldCbG1GYnludHk5RldpQmgxaHZJa0l5eTVwbHprajdtRVNr?=
 =?utf-8?B?d0xEL1Z1Qy80ZDE4a2NDUk9FeUVlTXV1cXcxTWNHaEFzczdYWjBIUUVVMTRM?=
 =?utf-8?B?RjNqOTBTQnlYZVFQNnVOZnhQV0Q4WnBPWXcvbnRDUmQwNVFkZ3ZPVFZEQUY0?=
 =?utf-8?B?NU1LbjQ3c3FLZ1Rhd3M3L3BETEVyeVphUExXcGRKalpHdlJHK3lNUmRqRmZY?=
 =?utf-8?B?OXFpZ0xMZnZ4R0xQVzJjeE16V2xwbGw3VC90aU9teWY2dmVWK3hyQThKckVF?=
 =?utf-8?B?Q1VIRGxZaUMxWTRCUTVzeWEvWEJXZFI3YkVYSGpvUEM1YzErQXFWOHVTUmhW?=
 =?utf-8?B?a3o5U003eVRHYS91YUJUZEhoZzVsTnkxTnR5Q1pmemVmYnZrVXNKYVNhRzZz?=
 =?utf-8?B?WDkwSlR6TmJjRWhQeXlmTTNBellKNE4wS2hXQXBIbTk0N2Jpa1NhSFN0U2l2?=
 =?utf-8?B?NGMwcFo4Z2cwc2c0SkpYemRyZzl0MFVFdHYrc0lIZnJVaGRZa295Ym9GN3h4?=
 =?utf-8?B?eHZwQldXaW4wd0xnalhXMFdvOEFEQmdFVUM0OWkxNEhxcDB5bGlrU0k3cVJp?=
 =?utf-8?B?YkduMUMzRDhBcmlVWHVseUZTMkNudmVNODJYVzd1SDkzZC96T3RydHVyR3I4?=
 =?utf-8?B?MUdXQk5rSkJmWWgvR20yTEVrUG8wajZzei82aFFkckNDM2pBeTFVb2Z6elVp?=
 =?utf-8?B?TEh1SUc3THY3ZTJxK2dKQTRUSGUyczB1OGdYV3VQeSs4V2JOMHZDU1dySlRi?=
 =?utf-8?B?Q2FDQmZkcXFNUXFBL0lZT3RJVmoveFcvMW9Lb255VjIvUGFLbG1QZEZvUGc5?=
 =?utf-8?B?U1VndG8rdHpHOEU2Sk0zd0k3SFZFVjF4OGZQdjA3QlNpb0NnQlZnOHVSRFVR?=
 =?utf-8?B?Ni90M0w4RkpTd2ZOb21hdTZseC9EVXgyQ2VZNkUrNndEaElJOFAyUmRnQzZG?=
 =?utf-8?B?YzBBOWlENEd6N0tYTVNzaGhId1BNWEcvOHEvenE0QXhUQ0J1NmhIK0U0UGFN?=
 =?utf-8?B?OVNtRTVURHp2TFdYN0V0bVE1ODBzYk1xRkxvN2orSGJYR3dnSk85RkhVR0d1?=
 =?utf-8?B?TnRFUEVJZ3pxUEllcXluZkxCMks4aDlFMTdtRWxCWElLVDJLcUhZZzVTVFpV?=
 =?utf-8?B?b0l6WGdoNnB2aGoyd0wwOXVLRXJzQlpBOGFFL0RtUkt5NFpqQ3hjMVkvRE4r?=
 =?utf-8?B?VlJkOUIyVmtCanVPNXNjc1hXWFJPbmNTbXVQWSt3UWYvRnNSTURHdmtaQmNC?=
 =?utf-8?B?K0psTWZMa2RxaW54R2JnQXNIL2VLcUd1bGU0SXRHU1pUaWMzdlVIOU1oS1hS?=
 =?utf-8?B?V3AwT2d5V2pzaUJXa3FnR2lCd1hvK2d1T2ErSk03ZzdWbWg3NVZuUU8vaDIv?=
 =?utf-8?B?cHhUREEzKzJYQStnRGhtbFVVOXZ6T2NObm5EQ0Y2bzVRQ1Q0ZWJWQ3ZFVTR0?=
 =?utf-8?B?cVlyak00T3dTZkRGSlp0ZEI5M01QTVp2cTJZRzNmbW1pdk5Gcmx1UXRjVkRR?=
 =?utf-8?B?L0E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9483aea9-6b11-4609-780d-08dd0fbe2c0b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 15:06:01.5194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DflUzu32vgFQyW2oU916y1r2iSv1+INTDMDvWNKbIR3tTF69OjVeD8kdwSQJrGCp4ldswPqn1yfNc+TIsbS8Jvn420a1/FumqUlW1urEHL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7142
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

Hi Adriano,

You may want to check that your commit title is appropriate here as it 
seems odd to me to say "rebase of commit A on top of commit A".

I don't have anything else to say on that patch otherwise :)

Cheers,
Quentin

On 11/28/24 3:37 PM, Adriano Cordova wrote:
>    Commit 5907c81 ("net: lwip: Enable https:// support for wget") was not
>    correctly rebased on top of the changes introduced by Commit 6cc4d04
>    ("net/lwip: wget: put server_name and port into wget_ctx") in next.
>    This commit re-applies a  couple of lines from 6cc4d04.
> 
>    Fixes: Commit 5907c81 ("net: lwip: Enable https:// support for wget")
> 
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
>   net/lwip/wget.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> index af48d741a4..8b3e5cf29b 100644
> --- a/net/lwip/wget.c
> +++ b/net/lwip/wget.c
> @@ -288,7 +288,6 @@ static err_t httpc_headers_done_cb(httpc_state_t *connection, void *arg, struct
>   
>   static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
>   {
> -	char server_name[SERVER_NAME_SIZE];
>   #if defined CONFIG_WGET_HTTPS
>   	altcp_allocator_t tls_allocator;
>   #endif
> @@ -297,7 +296,6 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
>   	struct netif *netif;
>   	struct wget_ctx ctx;
>   	char *path;
> -	u16 port;
>   	bool is_https;
>   
>   	ctx.daddr = dst_addr;
> @@ -307,7 +305,7 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
>   	ctx.prevsize = 0;
>   	ctx.start_time = 0;
>   
> -	if (parse_url(uri, server_name, &port, &path, &is_https))
> +	if (parse_url(uri, ctx.server_name, &ctx.port, &path, &is_https))
>   		return CMD_RET_USAGE;
>   
>   	netif = net_lwip_new_netif(udev);

