Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BD9EC1459
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 14:34:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06A5883E7F;
	Tue,  3 Mar 2026 15:34:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="iaxsZpQN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BFDA83F61; Tue,  3 Mar 2026 15:34:13 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6B6B838BB
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 15:34:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BjlrmklbXQ3IKwe5HenLIqra+MdE7HTa7aXvXhYqedMN+FxFcrHZcxVTUHGXwGoxvLinAVSwLjbhKhl8NOHokZjyHm4J94eecK00B8TFpIppvj7arhwuCZoaGyyGfu/PVCc6STYWCa1fU5OjKUoUD2vulmZp0C+gxFskZME9ZZOw1QZsN4lineHh3P0QCIc1yW1L49ixVMLPqxAFS/T0FlnHSeeK/yuHL2E08WPKM9cVuqjbaShFnjipaSXiTYVXM0yeFSHRfyHKUF4uPUWLsGQOImooX5AswHAp1Lwflp1f+pHnTKdeLC0Z4N0ftnxj9ctWe1Q/d/NeEZjQdjcFSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQZrgJiOFrWUUOcaaWUfie9JEg1RQbqyCd5VidtJZvs=;
 b=A1+Rtgab7ksUMrgwUBUh5wu4iXYWmki1ZdVBzmjRG1Oq5Hv+MdM3lUVNpcb84gFlfSi9NkHJQsMZqsyaU3RmbexeH1QSGv6W2cqAeikBVRl+28IL6xBs5wCgVcWJIFHkoL0O3X2MbBfef2DnKhW1x7475iAR74veL/ZG70Gcy3nswtLE6qEvxNpbbk9G0acuJBXZeC9i9XmLld5VZJrv+2z1+OujAgTMSCi9yqNmgr7oDCzQpzbs7M5c7fIHDUU1dJa//wBvjeSZeHc4647GniZmbLUHnNo/kDCQ5KvL8B2x6wXPEn2cwCPvI7sBNENUCsgIs9KKdIYxvKRIULtD6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQZrgJiOFrWUUOcaaWUfie9JEg1RQbqyCd5VidtJZvs=;
 b=iaxsZpQNI3KUA9zkqiC/kWvw/ON35VWmqVy4hgE746HfAfFAZezxG+T1rwd34UKao0P78iQK87s2XKzPs/DH7IQinESDZvHeQakDgEj6ZXlODZrqdjhmrZIk5Rup9mGxXK50ZcnfJseHoYl5mBf+XxvGl9jieB1xwLaSdTuwfmM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AM8PR04MB7777.eurprd04.prod.outlook.com (2603:10a6:20b:236::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 14:34:09 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 14:34:09 +0000
Message-ID: <5a1c0a8a-73ca-48f2-92d7-2bc156a52520@cherry.de>
Date: Tue, 3 Mar 2026 15:34:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 09/16] binman: test: Move ChromeOS test files to
 test/cros/
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Yannic Moog <y.moog@phytec.de>
References: <20260226234802.345968-1-sjg@chromium.org>
 <20260226234802.345968-10-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260226234802.345968-10-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0311.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::18) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AM8PR04MB7777:EE_
X-MS-Office365-Filtering-Correlation-Id: 72f96729-b80e-4937-abb0-08de7931ee24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: eeVsd7QZZmi8faHuOXjkwe+cG8ow+ssAkHrcpIbl6HLxdmedPpcwV3N2D/cmyeAyDhUB2MECg4r1/1/bVuK9/NdrK+WQEYn9UaFEmj3g1IjwQH2xVa8+99gdf+HkyBbyik/BEIjsLiZQhGU/ce4OINAiOSEDDwHrNY3wghPJBAvEya9+CTbKuuekdqtsbq+0ZDAP45jRXeNptigGT9QpT+6s2z6W4UFUOZkSV389rCIIZ16ohBO22bmN9MopvuQpFdz4QDO1SebUM6KSDkIFKzuyAsDYgKbskNfQ8BgxsOzvFsJVpxhOELc8A6uA+jl3LFgvBBA5KiIV8fON1qtRi3lO6SrUTCmyi1bX7JXnUPUTpjqSXu2pPxeujIMtVtkhRzsk/wI/kCjxPB+gTSvm7sr6Y4xlLUfSmGOm1WrwPNTAnkmf0sX2EBz3Bp635r96RlohMajDe2ALwcA0ek6kup+5E2cczdR9d716ACRwNH1vATEVljuiUEkQXmlluDc5XJu7PRjJ6CM9lBW15kzCQnFn/uaMYFbfsxn87+GR7j95F+nqx7ogs6mU1zf9EPdprcLrRkgPkhZBFYxQKccWacvKlNv46fHgkVxkvV4vFBGEr7/j00vJak6Ku8Zfery25li7OtKRwJ2J1ANV0pDBgQUzr6dZ8AKRcjNuq2AgA+eD7QB7xDTXnI2qP15K+yxpa8l2Xtzt4sd5/cMsTT4RVyWAED/ngska1V1zUd4uVag=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SSt1MDlXQjQ0ZUdhdThPSW1qL0pmT2JyWjlSd1lKVUVFWmErdUhDRWd5ZXVS?=
 =?utf-8?B?RXordHMvaWc2Njh4TElIR3NzaEswKzdkL1J0a2kyK1NXaTZ3RkhMNGFPZ2RM?=
 =?utf-8?B?STJEdVJyUi9IYnIwOWcrcUlEem1RQkYxOWl0WE0zL1pOOTJzeVltUEFRdCtB?=
 =?utf-8?B?S2JhUkhSZnlkWjFDaGtLVmtCNFNWWmVSS3FLMEV4Mkd0SFFEYnBoVWN2czR4?=
 =?utf-8?B?ZlVqV2JhbHRsdllOd1VQVzBuUGZBUXZ4dDhZNllhMU1NSkJia2tSUVFRcW5q?=
 =?utf-8?B?Umo0VjlxVmo5R1pnNVNRQm5OcWliMDhBeHg5eVFTOW1rOG9KVUFUZnM4REVK?=
 =?utf-8?B?eDR0WDZkRXJzcXo3L3NqYXhoek5ES3NHbkJZODBJdDZ4dk9DRjBTZ3hUR0l6?=
 =?utf-8?B?TXlRZUNHdUZROE5FU1FZUUVnUElLYVliR0N0djlETVZsTWNPSGd2bjZoOHJK?=
 =?utf-8?B?eU5FWEYyMlZzM2Q3ekFsMU1zWjM5QnZzYU96SWRqZnBadDlzRVFhMHl2L2JG?=
 =?utf-8?B?ekprZDZQeW52bUN4ZS9uT2xnUkdzRjMwaGl5TDhwbUxmYjByV3pZTkFuQU5a?=
 =?utf-8?B?SllJTTZhUHhEUXFqMDZTakRRSmRkc2lxZHZyZjVPUTRSZVpEL0pYdktDZm5T?=
 =?utf-8?B?YVk3blhpQ0xXVlEvclZCZlhPcmFEcGtmbDA2TXhYdTF2YjJZS3hXMllpOUMz?=
 =?utf-8?B?WTY0WEVOZzRDQkZqV1I4bWNUOWwvZEwrRFBNRVRiU0JnVVlaNFBvc2RXQkkz?=
 =?utf-8?B?Y3E3OXhoYmFLeDk5NG9RVUUyaXFNQVZ2NWh1SHlWeWtVWUk4dGUrV0xRMFIr?=
 =?utf-8?B?am1uWnk0dnM0NmFIblB4R3BUSEtoSzBENVJUSTVqUmJteDJEOTlVbll2UGI0?=
 =?utf-8?B?bm1GQy9vL2dYdjkvWFZWWHFOdUF5Z2tGQVVWUG1tT28rSVpBcGg3SmRRSExZ?=
 =?utf-8?B?SGt4dUZpKzBVQ0RqeGkrSkRXc0cxNHZ2anZXdlBSeVVhelJFVUd2eUt0TkZP?=
 =?utf-8?B?QmdJQ20wQVhqM0pmRHlCcndjTzhLdGtoSWVneTYwQzRNWVUvNUptTDJDdnQ3?=
 =?utf-8?B?UVhnaWE4cUpLKzR2dDVvOTZpWHVVdm1UWGw0TEhhRU5jUE56SEEydWlVeUd0?=
 =?utf-8?B?S0p3dFNJTGZzck1pWFo4ejdZQm80bnJkdUtKZVRuekswdkxDeXNZWFU3Qk1Z?=
 =?utf-8?B?UWoyT29NaURnQzBnWGs5aEZzeTJQTWNGMTU0Sms5aXVudEFBakE5QzYrZU95?=
 =?utf-8?B?MXNzcmw5SytzQkxsbi9tcFJ4UUhGbmNub0R0S3FnbTNwbm9IWndiVTBjSXBY?=
 =?utf-8?B?NllHLzlzZUNHZnRqUy80eFhJY2FiZXIyejlrUzVMNjg4VVFBL09EVkh2dEdW?=
 =?utf-8?B?RHpYNEYvUzl3Y1RvTWNYZkZtQ3haVWE0M0t3MDNJemNFWDFFSWFjekJhaElL?=
 =?utf-8?B?OHVDVWdleHNjSE1zbnN3anJjbzdkNDM2aXM0dWRTeVlyeEFEc2RmdWNtSWhn?=
 =?utf-8?B?UGlsMnZSckM0YSsyZG1EZXpHSmFVMmg1YnBXR3kzUy9rbzVhZ2ZkMmdXbHhZ?=
 =?utf-8?B?bnhpYWJadGJSTnFsT0dXQ2QrRnJKQkhYdzdKZlFpRTkyQVlaakFKRVFUTzlp?=
 =?utf-8?B?cG1iQVBFSFA3VzdBUDlPekhlNHVyb0ZQcDZwU0ZjTzVHVWU2VG1SRERnOTNh?=
 =?utf-8?B?eXp1L2NVMzFSSGpMb3R6Qm53SmlIVjVjNXVsNUVKb2pNcHFxNENDMnBrTmJ1?=
 =?utf-8?B?MU5ZQmdjZ2NQeG1LbXdRY1R4ODdvUVhvUExtcm9nb0RYaFZIeGdkUCtSQ2NP?=
 =?utf-8?B?dWQyOVhkbWVCb0lJMTF2ZTV2a3oza1RnMGgzbmsvUEFkN0F0a1V6REFnc2hQ?=
 =?utf-8?B?WWg5TDRMVU1CRXY1Z2pGbmM2dlRrK3JTcEc5N0V0WHM0UHp6OVg0M1NjZFJK?=
 =?utf-8?B?L0tvVlpjdU5XcEt2QlBLaExCMnVaZUV1NnRDZ08ySVhzZFdVNUEwRE9BK2ow?=
 =?utf-8?B?US9MZW56dFd2QmdDVUJUZTJQY0NLWjAvQlZuK1hkRUdrV1ordXVaTnNOSURv?=
 =?utf-8?B?a3J3bG1vaXRWQnJSNXpyQUN4N1hxWk5lNzVqb0NFdjJsOUJXWVpacmhwVnBP?=
 =?utf-8?B?S0hOMnFJWmorMXJPcXhlOFdHVEVnT2h3aExEaWJjbzZZcFBPUXEwa3Nic3JN?=
 =?utf-8?B?djZpbzNkS0F0cTRVTmx1RHNFanRheDU4cmhGcklTNnRxeVQzVG1wQ0xWYVhF?=
 =?utf-8?B?bkxldEFJT0h6TDJKcEx5Y2htajlQYWhWTVRXWitLb0NQRHR0TnZtQk1sbGZx?=
 =?utf-8?B?OUZpL3Foa2E0SXJBbGc5Szk1OEVhTjlMZVBzZzhvbExJdEVBTDlEUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f96729-b80e-4937-abb0-08de7931ee24
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 14:34:09.0567 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rt3eIPcbDglXbu6orsRiucGgemM6HyBDUU0Z8yTtUMVSvlO6YwoFddH8urB9IzJ1O2upeS0flrXwFX6dWxCvWSZyHjSwW+b5HoKYXYXVWdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7777
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

Hi Simon,

On 2/27/26 12:47 AM, Simon Glass wrote:
> From: Simon Glass <simon.glass@canonical.com>
> 
> Move about 10 test files for ChromeOS entries (GBB, vblock, FMAP)
> into a cros/ subdirectory. Drop the numeric prefixes and update all
> references.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
