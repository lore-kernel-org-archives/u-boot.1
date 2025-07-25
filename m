Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A65C87FCE
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 12:07:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46D5E8393F;
	Fri, 25 Jul 2025 14:07:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="NY9gsarY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE42C83966; Fri, 25 Jul 2025 14:06:59 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7703C82F00
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 14:06:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8sHjeenXQNfC9315hispmVu6PV/JVt+AmdBm3MgoavPt2HwKGVMrYZPTBRXXXXc9YHbi+1152EHm7xf31fiTYpCjuyuqnAhd6IjFGtuHyUbZcrbcDMfBT0zdmJeaHxT5Q1FYCY6hWbAFslYy3nvYhzJT4VMa0wC84BGZpm3SBW4xyVVwIPHF9XOSCuucKN8Pc8gAtoWEQN/Q8WNribx23wsFI7Q554+iwuUsccTbn4S6JqTD+piNGHJOGB5BL5S6RTMmuTC1Y/k/9j+NwM3kVvIg1GOmSmlgh68xCHVKI/6HFkdF8ovySbEJOjakFmqCShI1pe4QZytThVoVvpufg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37ShRFQfOGx2pk/sqDFVb787XiXfxi40KXsf7TQh7+0=;
 b=mScWUYANGBfhtTMB6cu+wRedC5mhMC+9lL8CQshIBkvpqekI/T6HoQQSQ5n9SYvzONrS+PQGqXH+QEAO5nOp96fjlOclJbJMfvYuG0pQXQoqTLlBcO9ECTnJJPlC3dyFDXEaHtk+uTLganf58K0UmtwEJTU6X8aY9guyVM2P7jD9C2S0srNkneEfXWfV5IKdhDUWFsQIjWhIQVYGxgsnzqRVdN77yrgbnADYXb8T4Tm8V2iv2I7OcMSzG+YF7s9xXqsvNHqdryKBq47g2+y60xoR2OzaaZ84VC8Q/3RiaD8LmPZQcaoQ2RJQnxHuavMIfDjslfQB43wWk6B/acvD1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37ShRFQfOGx2pk/sqDFVb787XiXfxi40KXsf7TQh7+0=;
 b=NY9gsarYh33zePeMzG0LgbOiSBSlyXiANe5u7UsX2ghLkhge4apdm+RH2EYqcfDoBphjKITlQqWj35M5xob+Ee0zMviLGlHI42NIYMGLImLTgsXFCYCqYyMR83xjfhTGo5+jfIMnlaMQmkwB26J7E2pOem2XAxTM2Cl9VjZ0ncg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB9008.eurprd04.prod.outlook.com (2603:10a6:102:20d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Fri, 25 Jul
 2025 12:06:55 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8964.023; Fri, 25 Jul 2025
 12:06:55 +0000
Message-ID: <6eef2eb4-5f1c-459e-be6a-1d5343b5de6f@cherry.de>
Date: Fri, 25 Jul 2025 14:06:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpio: dwapb_gpio: Using wrong function to free memory
To: Andrew Goodbody <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250725-dwapb_gpio-v1-1-ee09ac9db7eb@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250725-dwapb_gpio-v1-1-ee09ac9db7eb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::12) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: ae612e7b-1d32-463a-818d-08ddcb73bf9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ck16ZTY1U3dnMU9za1VkemErZW5ZR3NaQ1I1Z3VUcHhmYmRCNWJDRk5nQVBo?=
 =?utf-8?B?WnAwRkdmN1RNZENCQktpZldXMWMySGcrc2dRS2FPczNnQWRhYTR0ZEwxKzlw?=
 =?utf-8?B?SmpDYjFKd25GcWRrUmhnYTgzbUVwUFJ3b1NQUWhDSUgrOWRRWW9OTXFHSVZj?=
 =?utf-8?B?blJZRVVFaXlTOVVLSWFrWTRNNUk2T0l5QWJ4elNhUnRmcXJ6a29XZUhjNm1M?=
 =?utf-8?B?U1BNQ2lyTUVPTFdHM3h0eGpwUlovQkFrUElmN0RsTnZ0U1VFb0ZkMk9GWGpM?=
 =?utf-8?B?LzVNOERvVmQ0MmVPc1dwdDB4bEtvY2FNdXBsVzYzWW9PNnpyY2JMMElQL0xC?=
 =?utf-8?B?bTNmSytzTThZalZFVCsvUWIxRllocDRhdFplOWhiU0VVbGpLTGg4RFZHWTln?=
 =?utf-8?B?ZkxBY2d3czVGc0R6ZzBHZkJTQW0ybmtrKzhlMFY1bkh2NkhZTGJyMnd4YUdD?=
 =?utf-8?B?MzlPM2M0T0NMOXR2bU12d1lZWTlpY0ZndEk0Ukg2bmNPV0l4VmNrTnRXU1V3?=
 =?utf-8?B?VW5raitzOUcyU2c0Y2c3cndhNjZ2cTZsMGZDamxnYTZTOS9CSUdEUy9ObjF2?=
 =?utf-8?B?NjdnOWtnUU9jUmVuSkNKdG9LaFdKMlEyWXNqQzdsYWRQTUt6b0FnWFlGZzFS?=
 =?utf-8?B?MTRESHpqWUFrRTBwK3cxdzB5bVhGL2wzdnF0TjNVdWtzUEhycFlzd0lXSGZq?=
 =?utf-8?B?dXhiVFlrWEM2dnVTZFR3MmNhVEJtWFRUYzVHOGJxRG5QYXM1aGplUndhbmtu?=
 =?utf-8?B?NkdPcTdKOGJ4VEdhRnNyS0E5MFNjL1J3RE9ZQmJSUW1DN0E5NFpxK3dpR3Va?=
 =?utf-8?B?QjFGZ0FDa2lQNGNYbkpvT1prNlJGUUhVVDJISVJ2UmUvbyszK3JqNVZ6bVdR?=
 =?utf-8?B?eTlaZzBFSWxmMTBqQTc3d1p0SjJuT01EVFR1UDhJcUxRRDhrVGQ1V0xLZjI2?=
 =?utf-8?B?dDlzMDZ3VWwvVUNoUmFkQU1wWmJERWVyYTdmWGpKVThScEVQTTV2cEFGei9U?=
 =?utf-8?B?UktDaE5SOFM1d2xST3hIZVgwdDJWSG9CUmtzQ3VFYjlrVFQ4K0k0aHpqWHps?=
 =?utf-8?B?UUtDdSt3OXVrcENQT0xWNFBCS0sxRHBQc0lZZHhBdzB3bERmZkJHMTRuWDNz?=
 =?utf-8?B?ZnNJSG5HeFRxdlpiZm03V1czcXBnQkcwNGp1Z3ErcnJtcGdrQlIrRlE2alJE?=
 =?utf-8?B?NE4wSHhEVDNSMUo4SUc2YnBYbkRreVZ2MXRUWDlLSXByYXNoNTZLdE5DUnBo?=
 =?utf-8?B?SUIwWktkTHZBeC9BTEdBeFlQUWpZaTNzWlh3NE84R1NpY2w0aEVsMzlDV1dw?=
 =?utf-8?B?b2lTcW1PVkp3K2pJUjlmMmpRU01IZlhzMlpQL01rWFQrUlhhVWVjUTZmdFE1?=
 =?utf-8?B?NUtUYzUxS2Rrd0JjTHVyVXo0djVIMTlUa0YrLzZjcmhmczM2Y09BVzFEZTBP?=
 =?utf-8?B?SW1yR0VnS3VCRno0elVJWE5GVWd6ci9Ua2lzbmhYeVU1eFlBWjgzTmNIc2tp?=
 =?utf-8?B?OVpleFFiL3ZiSm5DNFhGUmJGUjJjQ1liTGc4dmk1WFFuWmw4ZzlITkx6c1hl?=
 =?utf-8?B?YTFFdnNIU0czVWRXVXZFbVdaLzV4ZmtFS1hEZVhZdURBVy9qaGxEVDhscEFK?=
 =?utf-8?B?blpWU09Uak1nSGlmUlBVcjc5QnFCNkhtbms0MHg3L3J6TnkweUdidmMyUkU1?=
 =?utf-8?B?NTE2ajI2OWlrRGxxV1huQXNXZk16WTVhTGdPa1lGQktYQTVrZDhDMmY1dEFD?=
 =?utf-8?B?VXduNDUzQ0o5cGloZkNhZGFlN2hvMHdmS1VWZmlMRUpQWHFTMFNxeDJmeDdt?=
 =?utf-8?B?c1NralRZaTQ2dTZkNjNONC83RHJRRGxPaUtxemt4YjJXaWRKOVhsNXBUUnBs?=
 =?utf-8?B?UWpFaGxQT0VKTDJKd2I4NWlOSVJaSG9nN3o1clBOcWJJVDFGOUUyVHcwaUxC?=
 =?utf-8?Q?kMn3BnsdQ2c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M20rcTVZOFhhVjJwZUp2MG1hSEh1eDdNNFM5TGdDNlZkUXZmQzhYNlA5NUJk?=
 =?utf-8?B?SW9UN0h2R2J0UFpIUVFWcFlaL1ZTNXhpQzNuclZNa080aWtkQzJRa1pUMldo?=
 =?utf-8?B?L1VNRzNyYk1Cckd6N2JnWDNpOFNaVVo1ZGVobmtpemNEWG8wNHRUd0w2eFBB?=
 =?utf-8?B?S1RpVW9WM204SEhxUE04Z1JtY1pHV3JtVFRQUkxLdGkyUnVFaUkxbi9DZWhG?=
 =?utf-8?B?bFphRUg3YjJYZkNyazVldkZUZ3BjbGdJeGZCNzBNV0M2VE1lOWQ4cWlHUjht?=
 =?utf-8?B?VC9kM2dPM2VEbzF2L2dNY2VtYXZPby92Ny9NRk4zbGYvc2ROUVhFcHdPTG82?=
 =?utf-8?B?TjZybTlBb2lBbWRxNVNibkU4YlNJY0JuODRxckhxZllWdlM3cDlTMFVQcWgw?=
 =?utf-8?B?SzEwNzBxRkVlcVpVK20waEs0UGQzNTFJdDBwd0ZETnhFdDFnMTNteDFMRk9i?=
 =?utf-8?B?anJnclFrOGd0U3Z2aFB2dEcrVHRoRGVFQnlORWI1cVB5OTVSWHlBb3kxNjI4?=
 =?utf-8?B?VjRZa2Q1RzJBWk5iUW9ZUFpFTVR2S3dqWEs1MUpXZ3BvT0JTM1VPSlpTVFp6?=
 =?utf-8?B?OUtSYXVDOGxCQzhsenNmcVhGQWhQb2VNSG13ZTlqRmVPbGFkM3BUTkZxWTBp?=
 =?utf-8?B?WWlQMUR6MTB2OU5OeFRXdGxpSmpXN2lZak1Qb1Mxd3psZ1NWNHVxKzZSQmJ1?=
 =?utf-8?B?bUJzTzVkeitYMmlwZzBOKzY0S2MxSWZRTVFyQWdBTkVNSXpDYUpZOEZNaGtJ?=
 =?utf-8?B?S2pQYnZyUE52eXRidW1HTW1RZUJBV2RINS9UWHlRS0lQek5zMGxyQ0NhUVgz?=
 =?utf-8?B?MWV6NTJRR1Y3bmtOZnVDS29mZUIweW9UWW5KTmdsR3NiOW5vMnNmWjFHOGxm?=
 =?utf-8?B?Yzc2UmdLd1hFcWM5em1LWkFLeVYzMmw2bVV0ZzA4bGRBcnhvWXJpNmNDV0p2?=
 =?utf-8?B?R0w0UTlNUVlLek9QL0gwQTVDcWRFUXIvblNEeStuVW9RLzJESXBVMTBaSU4v?=
 =?utf-8?B?NHU3RFoyNjZGL1lnKzIxVGpYMjhCWnAyREw4eHFmRkFnWnREUHR4T1BlREQr?=
 =?utf-8?B?d05GZDhDYkZJQmNtY2dWeXhydDZNNW1LTVQ1bkdiMkI3ckFndVR0cCtZTTdS?=
 =?utf-8?B?K0RCSkdaSzAyelJrTXZ2N0toZTdCWWdXYlNQbFlvcUdGUUxtcU9HME5oN2du?=
 =?utf-8?B?c1hkOUpaZWh1dzFhUlpmV2tCOVZtZldwREIvRjYxTlV0aHM0NHdFbjUvT3NT?=
 =?utf-8?B?Tmh5RVdydHVTdWU2RHhqeXZ1Q2QyeFNJMmFJajFleS9qZjJKT3hGM3kybFhv?=
 =?utf-8?B?b0pwRTUzLzhVWi8rWldIL3F1cHI5UHhmNXlxcGpYOHBNcXEyMGxZTW5vTzdv?=
 =?utf-8?B?QWN3THExTlFDODBrUGVycUJhMmsrNmROazhLaFJtbkNEZDl6Qk9Mc05WS290?=
 =?utf-8?B?eWU5VUpGc0htOTMvVjI4YkFncG80TVlIR0hWNitPeFJJVGhybHZPQXRrVjdD?=
 =?utf-8?B?eVpOZzdzWTUrUzk3cU9OSEhZcGhoVWNnZ1NBTDBYa0tJRzJ2WG1BdUQyVlJO?=
 =?utf-8?B?bWxUWWFQbWRPNC84OG5zWXpkaUhUY1U4MXZVanBkdDIvc21KOStxeDVVKzZm?=
 =?utf-8?B?WTc0SmNMM1l0OTlMUVZHL1JmZTJSbGY5czdZaEkwQ05COUVzUzFITGp5WmF1?=
 =?utf-8?B?NXlTbEZYS3FRU1dUcS9PSGJhSXdabDBNY2ZPSlRtTlNwYzgxZmEvOVpTNEo5?=
 =?utf-8?B?bFBQc0N1cFVIV2RNTitOdEIxRk9Eei83amEzUTNFWFRIa1FzSWtSUFVkSzlw?=
 =?utf-8?B?L3duelpXbkh5OCs5N0hMeTJoOGxOVDY2OTNKTlh2TmlGVVFOYzVKemdKZkF1?=
 =?utf-8?B?UGM4eGRqVURJWk9oNkt2c2ZjeWF0VlVNYSs3ejEreFkydHowcE5SenoyTkhP?=
 =?utf-8?B?eE1oRytjN3I2T1dHdFgvNEJkd1ZWeHY2bFpOWnNJZmJ5ZlpLdDA0TDNqdXFD?=
 =?utf-8?B?NlM5ZUV5Z0U0Z3NOTk5kRGNxeWVpQ0M3LytwR0VHVEkzeTBYdUJoZk5MLzRP?=
 =?utf-8?B?bG5UTWhCYXVhOHFmVXFSTFpNd3BVUnRxZW11Mk1ZMzVmeVVTb1lNd2RGMmNt?=
 =?utf-8?B?b0FaMTNUeTJkYVp2R3pORkoyT3NLT1RPR3VSVTBHTXhWTmpNa1JrRnBkbGhh?=
 =?utf-8?B?Snc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ae612e7b-1d32-463a-818d-08ddcb73bf9a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 12:06:55.4477 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iVV6PWPSSkxrKMmbVHpGvvBMd9QVmGiLRWuGtKIhtFq82SghyuF3MjWuHmZJMTVMXp37iPeePa0G0fMJqtdFqqPqH+I9FvORYEKZYtiKxOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9008
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

Hi Andrew,

On 7/25/25 1:48 PM, Andrew Goodbody wrote:
> In gpio_dwapb_bind plat is used to reference memory allocated by
> devm_kcalloc but it is attempted to be freed using kfree. Instead free
> this memory using the correct devm_kfree function.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   drivers/gpio/dwapb_gpio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/dwapb_gpio.c b/drivers/gpio/dwapb_gpio.c
> index 04639a4cb68..7ab48780332 100644
> --- a/drivers/gpio/dwapb_gpio.c
> +++ b/drivers/gpio/dwapb_gpio.c
> @@ -193,7 +193,7 @@ static int gpio_dwapb_bind(struct udevice *dev)
>   				 ofnode_get_name(node));
>   			plat->name = strdup(name);
>   			if (!plat->name) {
> -				kfree(plat);
> +				devm_kfree(dev, plat);

Why do we even need a free in the first place, isn't that the role of 
devm_<wahetever> to undo things properly in case of failed probe (or 
removal of the driver)?

According to 
https://lore.kernel.org/u-boot/20250722-usb_onboard_hub_cypress_hx3-v4-2-91c3ee958c0e@thaumatec.com/, 
you need DEVRES to be enabled for that to happen.
So I'm really wondering what's the purpose of having devm_ functions if 
we need to undo them by hand if DEVRES isn't enabled. This is very 
confusing and misleading and will lead to mistakes (I for sure will 
never remember to undo devm functions in drivers I write or modify).

This patch looks good anyway, so

Acked-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
