Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED04C3DA6D
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 06:55:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A36F1831C2;
	Fri, 23 May 2025 08:55:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XtMLywb7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33B32831C3; Fri, 23 May 2025 08:55:22 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::614])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E0578310F
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 08:55:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QUlFovrZGaLwy0fJg7ujeGWOu5PszUynAW2tX6+vqKVXhjsK43Iwyvd+C2CmNg4grIeQfe73/MN4+A4flLTE7maDsPMd1hE4Q535xcxOcS5efpcSVUjMUrWcLqlRxCPhbpuQKIg17HQDAaFWZ4P93BjThIps9044ktQErprQqVrOQ2lVmq/h2XzFyIFGcCUI/eC7cBrMVCy1K6X1Z1K/n45XbyajMcVJ0yfvxSEiMVv0EF+zqDerKgZwccMl7vTixxt8uBojV3DzjggUGQNgCgqUA7+p8pUN/OqdQ/JZwYFGJ507B6x3BIq303U4mHGn5QJkymT2EoO/nwV0deOvBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KNz/JcPLUIxZO6LMVRxgnhdeufSsrMp+NYWBl3hBEc=;
 b=gG1jkJ3YoOCRAl3YHGRloEO/DaC4C2+xReVfinap787C7dXJz0r9Hc4HM57fRUTrdopWolVItxRntM9M8qvdtqC1BzEUOPlk6kWQV8k5/H/nIMpDWYDi8c47vitGwAJ82coapNqR403/PJfchrSVXKWmDgiZoWOtQ04oxbOPzPJ7SqT0qM5s5FxbwmJTDrZmaalKXY5pHv1qrK2ACzwINvxNwiPNw0+llGiRWTJlWFXTw/NjxKcO0HO+qpv3LvYg+SfIzy3rLqQrJ+r7qZqr06RiVZYDp06/gJSnecnC+91Qok6wfLvEddTjuZ6KvnHDRf0UAlhlVNIdlg/GhsQ3Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KNz/JcPLUIxZO6LMVRxgnhdeufSsrMp+NYWBl3hBEc=;
 b=XtMLywb7Q23xyBBtdJv/tAkn28mjnODLCGor3oIyUbUPLNDEvjcMxvFGZjMESk6N+Gw0nbfeuTktgndw9/WgzpfSuUWKYp3Fg6bIMU9evXX6/Xl5xbnpGNGo1SNcAmXAHIRZY1jODZt25ZOhpcosGeBeXvp5B505W5SK4vE63jE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH3PR12MB7715.namprd12.prod.outlook.com (2603:10b6:610:151::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Fri, 23 May
 2025 06:55:16 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8769.019; Fri, 23 May 2025
 06:55:16 +0000
Message-ID: <9c7c8b93-7545-49bd-a364-5b0d23d92da5@amd.com>
Date: Fri, 23 May 2025 08:55:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: gem: ignore tx_clk if MII is used
To: Martin Kaistra <martin.kaistra@linutronix.de>, u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com
References: <20250415150400.136723-1-martin.kaistra@linutronix.de>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250415150400.136723-1-martin.kaistra@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0130.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::23) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH3PR12MB7715:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cf7f399-3a1c-479b-b149-08dd99c6c5e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VStaRUpPTHRtWjBFblN1Z0hlYkt3OVRaSTBkK1FkaEZ2R05yNHZvLy9GQms0?=
 =?utf-8?B?V3ppNDUvZXhsNXpENnlZdGE4SkhsVDIwYnRCaVREelhMQVBCRDV4aXBhOFND?=
 =?utf-8?B?NGh4NVBHdTlLc2JEb0ZteUhKdXdOYmpiai9MenJ3QXVWcUtDMVFWQVpaZjZv?=
 =?utf-8?B?VUdVUEFSUEozS3ZxRm14TjlCc0ozczk1eTlQWkR3L1VHRnpmUndyWC9NMkts?=
 =?utf-8?B?bTl4NkkzV1J3Zi9WRUxHdlJ3MUtKeXZUS3J4dEdweWdkc0dZNjYzeHdXZmFr?=
 =?utf-8?B?TFRkZ0xtODMyQ1IwRittTmpQVnFvYmxvMVl3RW5GMUQ0U091eEgwTnBoTzc1?=
 =?utf-8?B?RENQRFI1SVpBVHBmcFB6bldodXE3MVYwMldvM0NybFg4bUUvY1dlb1Y0Yzgr?=
 =?utf-8?B?Rm1SWFNqY05iV0NidW0zekRJRDByUDV5U2RxMkRFQm1McEZNKzJpMTd5WVFG?=
 =?utf-8?B?VDFxYURrOGd4MDY0MjhrQ3N0UWFLL1J2Sm9GbVBaM1FSUTBYSjZEbS9zTXFh?=
 =?utf-8?B?SlI1QkZYZXRDcko0eEpvOWs0M2IxNEVSanRybmFKN29FdFhYSDh5N3puNU83?=
 =?utf-8?B?R0pob0c1VWlSN3kxN250Z002YzZObGU2bkpKSXgyaVU2VXJ1V0pxSmYyQmds?=
 =?utf-8?B?RTB5WlFsS3d4UENrcnlNU1p5RDJWaFdQQnAyOEw3R0lqajJvL1JrV1hlUGFS?=
 =?utf-8?B?QTRPbm9GVzNFODlHOGVxVVFLNWFXZ3pJbng0Y0VRRVp6WlpSbTROU2FCMG5T?=
 =?utf-8?B?R3N5R1FZVWdkd01ZOWdjbzJHaXVzR0IvcGtneWNiaUthY1ZRNFpHMGdCcDFu?=
 =?utf-8?B?VFBJNFJOMThsMFhvQ28zWDdrRUxaV1FWTUgwNkhJc0lwZmEwcVl4MU9DVXZN?=
 =?utf-8?B?Sk9ETHZhbHJaVHM2U2wyYkdCYm1MV2c5WSs1di9xUHI3TkgxZkVqZXdpZ2NR?=
 =?utf-8?B?OFZRWWdPZE45LzIzbjJyVTNPeDNXWDJQWVVsbnVGS3JWREI1Z0xVYitLU05N?=
 =?utf-8?B?MW9IUXdadnI1Tm5Ub2dxSy90bDU1aW1xRUJIOFJPTDR3VVhnbzN0dkNXTHR1?=
 =?utf-8?B?WU1wU3RQZ0VsTnlMQk5YZ240UHFKZjA1QitiUTVPdGx3aEVFcHdIODYyUVdE?=
 =?utf-8?B?ejBKR0JZVlk5dlQ5c053endPRUpUaFlzMjFMdmtmMjdIZ1Jielh6aUpEc2cz?=
 =?utf-8?B?UTBWTnJFWDRQbVUvby9wOWl4NWdQQUdEb3I4UVJwZStIeElVUThmRjNZS1Bo?=
 =?utf-8?B?WFErbXhpa0ZLRUJBUGxXaDdDMkRZelZYeVhtRGIva0phOFR2MzZYM1VJU0pZ?=
 =?utf-8?B?WVdLUmFsTjVSK3FpOEl2YTBQampMeTQ0RERONzNIYXNldGw4S0ZMWjA2Qkty?=
 =?utf-8?B?VU9xZWZiVHRweEdaRWNmdEFkeFQySDlCQ3J2K1A0d3BDL3FvY2YzNmJkTUhn?=
 =?utf-8?B?NlhCYUt3M0pYRS9lTHU2eSs1YXZrUkJiQXRCZitaSFlXU1htZDlpOEVYdUVY?=
 =?utf-8?B?WHhaeStyejczWStESXFvNzNWNkxDeG5ZSnZNREFnWTFOWGJPYzcvbW9wVFN2?=
 =?utf-8?B?Rm1OZlBHK1dzL2YxaDNidlJKZXJ0bFhXZnEvbEJRTjZkdDhzcEdjaExkU05O?=
 =?utf-8?B?bVRzRmVhS0VLbmo1RnhqN2x0WkxqZm1CVkNxcnR1M1V1TDRzMzRtWnVXdGx3?=
 =?utf-8?B?OEh3T0xGQ01ESitZcHc0R0wxTHN6bnUzT2lkYnZRUmVISEdDNko0aElYS25O?=
 =?utf-8?B?MHVQbmI1VFdmekx6dkx3dUNWTUQyVWtRZy90MmppcUdaRnAvZWZRTnFJWmpo?=
 =?utf-8?B?VU1MZ3BzMVJ0RjE4SUgxWStpT3dOSDZXNDFWQnBURlgwMTQ5QlAxVG1id2h1?=
 =?utf-8?B?a2Vhek9FVUZNOW1rK1graU5sTFd0bG8wZFhZUFl4bWlnU3o5WTVDRzJFendo?=
 =?utf-8?Q?niLFRgN1jnM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDhGYkNmcXYrNS9ZUzI4OHV1TnRGT1pIdkpSbFkvQW1sMENHT3FIZnhoTDdw?=
 =?utf-8?B?bWhmWVZZSFNCVkF2Qm83TDBLeThkajZLcy83cGtWTmhCcmFVazlkR2tPcEgr?=
 =?utf-8?B?bDM4QnBPVitsT2dwLy94K0VRajBoWndnL0N2alA2N0pUNHcyMmdRYXZyVXla?=
 =?utf-8?B?MUtURXF2TXNnSEtDci93b05xSlVjU3Y2K0lQZWc4eUFuTkZ4a0U0NXVWNGJZ?=
 =?utf-8?B?c1A1cUNGL2c1NE9aMjJTUGd6TnFGL25DREpjbVdadkx4MEovYU9kWE1ISzY1?=
 =?utf-8?B?NzMvZ0czVlRkNDZleDBUejAvTWJhM2tza2J5dzQzcXliS1RkY0RUaEF1WmNU?=
 =?utf-8?B?cTZtQmE0a3JKL2RPRloxOU9hZ2tWN3NkLzAzTTQ5dDhCV3VGWXVjT09lQ2w5?=
 =?utf-8?B?VGFZeVRZSnZDSGF5TW1aVVpGdHVmckJGczR0UW5aYzVRdDVRYkZQa2o0N0wv?=
 =?utf-8?B?cEFoNVFobENHSTJpbjAwSTU2Y25MdmpYVk1TYndCZHlNZzlzTXkwWk5aL21r?=
 =?utf-8?B?VzB6YUxBWmF6bTM5aGkyWkE2bmVhSXpzdUVCR04wVm11N2JvY2JZSDF4L2Ru?=
 =?utf-8?B?b1lVVXc5MGw5M1hZdmNOWFNPamk5OHA4VG05K1BSNXdmZ0trcnZEalJZNDFM?=
 =?utf-8?B?NnJ2d0NwUk9QWE1FTXRJZktkVkRsTWxIalhFRmhVTytrUWVJOUdwcHFaaCsw?=
 =?utf-8?B?L2lUaWR1OEdjeDhTb2xpWjZSaUZ4WURaUjZabGVXQkhyMWh1a21heE5mZVly?=
 =?utf-8?B?cU1WL3ExUFdmd1d6Z2U4QzdScm9lNlY4QW1PV1EvSndnWGg3cWdLVkRRREhv?=
 =?utf-8?B?YkFlSEJJaGs3WGg5ZUVDQjZjcjlIUEEzakhTcjgzSDF6Z2l1MU5ZTzdWR2dm?=
 =?utf-8?B?MzRvMTBEQmk0cFlBRlB4Qk1OZWl2YmJ5KzBaSzFEdytRV1grWmdNQ0Z6NnUz?=
 =?utf-8?B?MEM4UUE0OTF3b09tWWVaMSt5VEdmTE5LaVpJSXVjRTMrNyt0bVVCWWt4ZGQ0?=
 =?utf-8?B?YzZjQjVwR282QUtIdm4zbXVqZ2d0dGFNV3E2Z29jYURIdStGK0FwSVNlNXFE?=
 =?utf-8?B?c090cGt5cEQxdktXNXJ0V2lrRzVERDhRV2RvTUhSMnQ1VkVjaUZzVTExZ3Rt?=
 =?utf-8?B?U3JOSmNrZlRUTEpLemlveGRSSzJPT3FIRm5LVm9xMVJHb1dlRTJrN1dJRndY?=
 =?utf-8?B?d1lVT2RWRTVKeUdENThRYUxad09Yd2Q4NUozT1MrSmpIaWk3dFhTUWxhSGov?=
 =?utf-8?B?VTRqVWp3L2dMeWVHNWhVNU9TMzhCb3lsTlBaSlhIdnZKY2lWN3JCcENzOVJ4?=
 =?utf-8?B?ZTF0U1JiOFFBTDRJRWtwMlIyMnFRZnRrQUdQYjdUbzlxem1UQ0FnUS9xaUZN?=
 =?utf-8?B?SXdRVnFDc0hDV25venZlYm1IbTVzUWYvbDdSVklPZk1vVGRFbGRBTm02TUVK?=
 =?utf-8?B?K3Z3UHdvUUpLc0VtVkRVc2N4a2k4NVlRT3d0UVZlTFRGNDcydXMvcmdhbmls?=
 =?utf-8?B?N2g1YzhmSHo5bm1yYjhNN2pmVkRiYXYrSVM5MUdEbldCejFmMGkxQ2hnTzdy?=
 =?utf-8?B?OHdWT0ZDTC9uYnBuMDhRaUFudmZVS09vdEJQVkppYmFZR1UyYTBHZUVqWlU3?=
 =?utf-8?B?Y09BZVV3ZFozYnFTc1hSR0I4TTBPRWNzS1c4MG9DMHp1QlFoQkI1dWNJK20y?=
 =?utf-8?B?RnNOWVUwZ0Z2THRLS01ITG1qQlVOMWMrZXMxMUFpdXdWcGRUTFJaWXJNSGFu?=
 =?utf-8?B?UFcxcFQwVnFLTzV3MDBZTit1NU52K05URjBPckozbng2NVZNdDNmVmdJdkt4?=
 =?utf-8?B?RFpwdFZKS04yTkJ0Mkd2dGN3MmpDMXBqME5jME9sU2JmNTAzSFY4TkRWOEg3?=
 =?utf-8?B?dWEyS3RsaTZoK1E0dEIrcUJjck9KZzQ1ZnBQNDBQYjROWFdXL1BLZWRlQ1B1?=
 =?utf-8?B?TVZmQ3hYemZQY0dwdDRnZFFhZDVVdEE1amtVbDlDSDZTMkhmUG1raEk1Z3ky?=
 =?utf-8?B?THkrVE9OcEhwU05SUVJuY1pldGZaRTB6cXU5ZjFCTmViSTRWRDVxSGRNZlBt?=
 =?utf-8?B?WTBqN0Z2dGc3L0ZXVWQ1UGJyaE4yV1ZPVG4wOUVqWFVua3VpakZNMlRlbVFF?=
 =?utf-8?Q?zBqidlhwAKwhOy8ef+I3eRbgb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf7f399-3a1c-479b-b149-08dd99c6c5e1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 06:55:16.0661 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4CPRhvkYMpBRSPujfUpBGy6eQAFPnVEAo9BTir/5QCDCalXWWqSoLTvQq4uxkPeh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7715
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



On 4/15/25 17:04, Martin Kaistra wrote:
> If the MII interface is used, the PHY is the clock master, thus don't
> set the clock rate. On Zynq-7000, this will prevent the following
> error:
>    zynq_gem ethernet@e000b000: failed to set tx clock rate 25000000
> 
> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
> ---
>   drivers/net/zynq_gem.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/zynq_gem.c b/drivers/net/zynq_gem.c
> index 461805ae53f..703e22479d2 100644
> --- a/drivers/net/zynq_gem.c
> +++ b/drivers/net/zynq_gem.c
> @@ -567,12 +567,14 @@ static int zynq_gem_init(struct udevice *dev)
>   	}
>   #endif
>   
> -	ret = clk_get_rate(&priv->tx_clk);
> -	if (ret != clk_rate) {
> -		ret = clk_set_rate(&priv->tx_clk, clk_rate);
> -		if (IS_ERR_VALUE(ret)) {
> -			dev_err(dev, "failed to set tx clock rate %ld\n", clk_rate);
> -			return ret;
> +	if (priv->interface != PHY_INTERFACE_MODE_MII) {
> +		ret = clk_get_rate(&priv->tx_clk);
> +		if (ret != clk_rate) {
> +			ret = clk_set_rate(&priv->tx_clk, clk_rate);
> +			if (IS_ERR_VALUE(ret)) {
> +				dev_err(dev, "failed to set tx clock rate %ld\n", clk_rate);
> +				return ret;
> +			}
>   		}
>   	}
>   

Applied.
M
