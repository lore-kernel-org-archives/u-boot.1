Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA535C2BA1A
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 12:23:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E9A388271;
	Tue, 18 Jun 2024 14:23:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="KMbLAH9b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB53D88137; Tue, 18 Jun 2024 14:23:18 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3F47882D4
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 14:23:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=treding@nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1C4dAmpi90ysZY5N/EHCyekBU91tCJEu7T6s0q2zonqxSOWGqMzkN/HwlTGZNf0KLzOW9zK1q0UOsmLG8jIQ7D7bDPwqijqujp4wO7IEjCk8Wf2MFwz09NermzmKw33nSsR6gk6sX8A1qzvz7SC8noAjwTBPP2ae28/tHhJT76jCFlgRdKKFVBsMxk7rQf/IrX2yrZCRFyAsc8BimVcbl8I8mKyuWTj8I/L19tgn36+dBOLaWTza2rXblMjtTCeie8+/+0TyK3Vko48Fu9bmMy3LF1M73F2nIP8Jk7s3O1IL37QQz34xNv9R0AH3ZQsKOCz0xHyGe9mVyv3+injcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PyO1v/Ch0pLLvY8jUJiJgh7bNM8WS7KWQJwL9hka0vo=;
 b=NI5XrKp8sD75V0dMnSxynhD19PqYGCbZzhS9u9BwIIWQYO7ajRzM+uGGmjXmHZxvpuLQ9X7gv350KBGEsiPD+QN5dSVJfWUpf2sbNYz1X9/O134qybVNJ9Gh5YGPMwtsY2/YnsmX/tVt4RJQQrOfRrmZrxdjNvv0noz2zpULodwBEu0n+kswNc8+wwZop8O2wOQvYq4EyWXwFeqo1waijdFAtOaCQmx7SVrBTbeCKqFNBfHp4YbQzcGZYPRbAFxuBmoIVk2flPU+m+bkMRJKBgfWF+mJi6mui0f3k37jNJUx+Y0JtfE2zgBPB/g7yELiaBp8ieIsi53PktIcGKXAag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyO1v/Ch0pLLvY8jUJiJgh7bNM8WS7KWQJwL9hka0vo=;
 b=KMbLAH9bXci2v+RAo55puziq25iiJyDJgn4P3NVQjueygAGXBe3SJ6OCCBM7qia5oejm83bwAAgMJL/R7CyIIov2rLSzJG7yo5tKJWEzh8pM8qiP9X3mZD6R4hO7sTMEoAgtkTyfW19JZSO3Suc0ZKIF0ple4TRYkohE6sr4EdPm2ocAxacPgyNbIqDcWtozJiG9pmJk8ciJ3CmtI9WCMLzpKI2C9Opio9q/mH5srIU/oHAjyk+i0gYoL3H+HXeWj9Kqy62CSzm0+qjJpOS+WjO8zKQXgIYeP0p0rrMEh1vZITtxhV5x3xpjftI4Ftzp/myg/0FDwdX+o5zWou1cew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) by
 PH0PR12MB7908.namprd12.prod.outlook.com (2603:10b6:510:28e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 12:23:13 +0000
Received: from DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::fcc2:409f:fdbb:186c]) by DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::fcc2:409f:fdbb:186c%4]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 12:23:13 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 18 Jun 2024 14:23:09 +0200
Message-Id: <D2351R7O6BQT.1TQPPLXS6F5AL@nvidia.com>
Cc: <u-boot@lists.denx.de>
Subject: Re: [PATCH v1 1/1] include: configs: tegra-common-post: make usb
 first boot target
From: "Thierry Reding" <treding@nvidia.com>
To: "Svyatoslav Ryhel" <clamor95@gmail.com>, "Tom Rini"
 <trini@konsulko.com>, =?utf-8?q?Jonas_Schw=C3=B6bel?=
 <jonasschwoebel@yahoo.de>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240618120030.41502-1-clamor95@gmail.com>
 <20240618120030.41502-2-clamor95@gmail.com>
In-Reply-To: <20240618120030.41502-2-clamor95@gmail.com>
X-ClientProxiedBy: LO4P265CA0226.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::7) To DM8PR12MB5413.namprd12.prod.outlook.com
 (2603:10b6:8:3b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5413:EE_|PH0PR12MB7908:EE_
X-MS-Office365-Filtering-Correlation-Id: 09905bc1-4d41-4054-c492-08dc8f916c3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THpKajJmUUxnSXM2ZnU5YW45THdMMy9iWjZ0MGtlTzcvbWV6UGtuQmRXZ2FN?=
 =?utf-8?B?TU1jeG8xOVVTRWY0WXFZclZ4NFp0cXEyeWxOYkdwRFRkTHlWRXZVZnhobVNh?=
 =?utf-8?B?TFMrYStqejN4dWQ0SXBtS09hbUtYbFpJMVdVdUU2K2xKRzFhSlhueHdLc1U2?=
 =?utf-8?B?Q3lpSjgrS0RHcy9vYzNXSlJSbkdDODRkcWxJa0JTTC9kQTdVZm1iSzNOK21R?=
 =?utf-8?B?ZHhRQ29ZRWREMzNtMHp3YTVkNWl0ckdVNmxNcTZRNlFRUHo4akpIZ3d4Uzhu?=
 =?utf-8?B?V2xXd0x0aDFOTytLYXIyVXM0Q25HaXUwL093VzJjS3VsVzdsYmVtV1hYaXpW?=
 =?utf-8?B?T0c4cnFGZjV5K2FMMHR5VnFPSFo2b2JBTk9ndlZtRWMrcDByRnJQTVI4QUVO?=
 =?utf-8?B?T281bm15am50Q0h5My9qcG1nYW5SVmFLRENGdGtJNlV2Qm9WMFpMcXlqcXd5?=
 =?utf-8?B?dWlUMUZEbEkrZjArNjBQeG03QWdGaXBUSlh6eTZBZnZZdXNaQy9wWldHUGQ0?=
 =?utf-8?B?NG8xeGloZDJqNGxhWUNlaEQwRFlra010c2o0c3liSFpmOVp2V1k1STBqeHdv?=
 =?utf-8?B?UWlTOUZPeUYvMmxjazVjTVJJQTBDMm5sTnkvWTNyUGkvRjhmV3FublhRTFdz?=
 =?utf-8?B?clRWWEgrTnZ6NmpiQ1phWDhITWRJL1FmdGZqdDZ3OVJKemIya1JxS3M4VVkx?=
 =?utf-8?B?dFJROERJTHUyQ1RkeGFOR0NJWE5qbUlmdEF0M2s1U3dKbi93Ym1VKzJUalgr?=
 =?utf-8?B?YngwTmtVQkh5VDlSRWhSQ29xeUNjSnZoUHpwOGFkZzZ5WUpNczh4UE11My9r?=
 =?utf-8?B?Rk1vQmtCY2lwRUhKcjNoVE1SbENETTNvem4xRTZoeUI0SmlvRGt0NmtVRXkw?=
 =?utf-8?B?cG1HcC9qYW9XOEYzWFNGaGV5aHBCTGZNVU1pbTFiRTRpUXpnQ0IvTnhQa3h5?=
 =?utf-8?B?enFhclg0V2paQU44R3BZRzF2Sm40U1ZnUUVyTG5oY21NcEN0VWlRVHMxaFJh?=
 =?utf-8?B?d3p4czVXcWVmV0txekVjUkNtV2lQcnpGRCtFTFJCUC9WZzd4TC9aTm9CWmxy?=
 =?utf-8?B?NnFZV3JTS1lQQ0RBdXZEbk1pMlpIUXFHVVBSYjNqUVRuaW9SUW8rZU9mYXc3?=
 =?utf-8?B?VjBVMG1kREl1WTVLL01uS0kyVUY5bnhJSTY5bjB1Q0QyMkljNzRFZ0RXNkJt?=
 =?utf-8?B?azFCNXp6c2ovaTlQQ1FkZVp1dG5BdTdpcHE3bmErakJvZGYrcXBERWJtZjQ5?=
 =?utf-8?B?WHR0QTVJVW5VK21yS0dxVStEV2dNODYzVE55ZHRtTEJ3dkZoSlorSFUySWE2?=
 =?utf-8?B?REtVcDQ2N1U5SWJaamZzeHRGZGZEOHNQWnpTd2hJdjVxbnJRK2wxUEF5MnNU?=
 =?utf-8?B?RU5DSVBVT3VwMFA2eGhuRWlFVnphU3lLNlpDVzBHRndDbG9ubHRVdlFYQWxK?=
 =?utf-8?B?bjRYVEdoTTQvNDdFMmloUGI4ZWVJc29WRGJ5YVpQS3cyaDgwYnFvOVdoSkNS?=
 =?utf-8?B?MWJ6ZWY3Mkwzd2l0UW52ekxMNm1aT2YyWTJOU3Y3L2dVREU4N1puOEg3bUNu?=
 =?utf-8?B?VGU3cFFoSkNMR29yV3RVUnpZNk8weXRmazNNUkkzeFJCdGtRejdSZGdaQTIv?=
 =?utf-8?B?U1F4SnIwMXJsci9rWTZtVk1RbVRBQkM5a0pUOXJlakczNiswWHFQMFBFc0ZS?=
 =?utf-8?B?NEllMUZ5cWJJQkpmREVMWkhKZ1crRjVjekRQaUFKbDdNWXNacllOb1dwMlBL?=
 =?utf-8?Q?nJAWDy6LBZdgbSusTaX4HRQXd4rOskWO2RUFBhQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTdvaTlTZDdoRUFuOTFjY1RXcjVZOVlJZUt6ZmFzeHEzR3BOcmVuRDhtSGVL?=
 =?utf-8?B?Z0hkVTM0MGZua294dDhBUHYwZnF0Q1JnL0FmMnhMcXdnWWErU20vZ3pLNWJM?=
 =?utf-8?B?cHo0K0kyVmpRbnkvUm1TdTUyb0Q1bnZ5Sm12UjFCS2xvbi9IdmtTNDljWXdu?=
 =?utf-8?B?aUpTWmdxR3d6eUw1U3MwKzQ1OTBxNW1od0dZSXl2U3hwRVhmbHVXQ3JYL1lw?=
 =?utf-8?B?Y0xkK0o3UFNtcjBGNS80WUx5aEczbHV6N2tEZWtreHRFdlBCRzltRVRFS0tU?=
 =?utf-8?B?RnFvaVlnMU1XbVNhMmlFOU5FelNHV0ZJbXdOc2dEWlBsdkFrNVR0NTJBY25j?=
 =?utf-8?B?VlRtQmxZTUxGc0tNbmd5cmFkeEI5REgrSWtXMHVvUnlIb0pEbHpyVldHNVhI?=
 =?utf-8?B?Y1d4bk5Ka252bHJhN1BRRGxxL2ZFdHFrZDFWc240Q0trZi9MVkRVeUxaNEhI?=
 =?utf-8?B?Nm53WTQrbmtla1ptbEgyNFkxSGZuVUZGZWdnUEtwbHk2Rno4emJCZWNZWGRw?=
 =?utf-8?B?bG1sSUFCb2dUaXlybWFFQXdjRG9GNG5CRXdFWGdoNStVMTBCb1FNV3BReTNq?=
 =?utf-8?B?SGk3YytKV0N3VWFLcWNpdUtBcUROd01TZjJDRzlCc2tHNUNrWGVpS01JUytC?=
 =?utf-8?B?alhxWUUySUFmMXNYTFcwNHVrSTJUMS9BVFNHV3EyTG5sOHF4MlZpZlVwZ0M5?=
 =?utf-8?B?OFp0eWsrd29pQlo4KzV0Q292UEJ3Tk9Ha0t0V3BFZWUyVCtYQm52MGdLenZv?=
 =?utf-8?B?TnpUbm9yM05EY3dPZ1ordW85Sk42cmIycjJLREY0SVgvOHhZcW8yNHRRRzFF?=
 =?utf-8?B?Z3ZLVmdSU0M0NGtrZXZxUEVEU0JnZDg2TzkvbE9WWlBTaDFjUEFJanVsbzBs?=
 =?utf-8?B?UG9veGE4R2dhZGI4eEFGbjV0Y0FKdW0zYlBTMGpwbDhlWWNiWlV4Q2pobjBH?=
 =?utf-8?B?a2diUUZZK0hkc3R4SGJUOWZXRlNFZXZsNnZLZjdJY3BTZy9tN3JrOC9SKzFO?=
 =?utf-8?B?cnJEVkRrQkZVU3Q5OUVBQUJROWZHQ0h2UlRYNHI2SHFjM1VzVW54RmVVWGor?=
 =?utf-8?B?R2ZFbVZWVXJuTFczeHQ3dFp0NW5wbWdjMjM0NWhWSlVvSW9Ia3FxaWVyT2l3?=
 =?utf-8?B?aWsyYXBWYWdZWmRxY2Q2cW1kSGRkVlhta0QrUGt1MTdZK3owenhQN2ZMQjdi?=
 =?utf-8?B?ZlM4WnN5REM5K0wwOXB2UDNPSTdSaVhoWFh3U2ZLdTltSkJkMkxrQ1lhcUdV?=
 =?utf-8?B?RkI5NVY4OGwwV1IzeVd6OU5KV28zVXl5cTJtRHZuOGVKcW9yMlBTS3JFY1h3?=
 =?utf-8?B?VGZRY25tRkI4ZnRCYy9rR09hNFZUSDQwcVBmbjlDZFd3UUV1UHA5bG4yZHhz?=
 =?utf-8?B?UHRWeXRWbVdxZzFVVlU4eWxLRVR0NVF1aEVySzkxbUhVb3I5MTVvZDdCeUFk?=
 =?utf-8?B?aXRBNjd0KzV2bFBtb1o1SGEyOXNnRllBSENnOVlDSFFVclRhRzlaaVRacnI1?=
 =?utf-8?B?MUtjZkRuRnJSMythRWZDZWQ3OHg5WHF2eVEzZVZ5ZjRYbUJ3bjI2YXp5VFlP?=
 =?utf-8?B?MTJOeTBMV1cxUGgxK1c0UXVlKzNuQUpkdnU3OTdXNDl5SnBBQkJlbnpvNG5S?=
 =?utf-8?B?c0RqZW1ZT09sRzVoOURvUTRHQnBLTGo3WitSQWU2aTJwd1N3VlpQZ283YlBF?=
 =?utf-8?B?M0kxQ1JDNmJUeEZGWTdnWjRXTXZaeEJ0M2xrNndtTDJCc1dSQnplUTBldXhz?=
 =?utf-8?B?T1ZCS2VXRDZoNmh6cXBjNkhqNHBWOGxQOTczUS9qb2ExMHhBV3lwbmVRMzJK?=
 =?utf-8?B?aWI3S3Jwd3dTakxtY2dzNHJyZ09BdXVOTXc1Z1FRQ3NTRndXaUlvWE5Zb1JO?=
 =?utf-8?B?VEZXd3EyT0VoemErNXNaR2tFL0UvYzBLM0NMdFc0RWZYVUtoczh5dDhhNENH?=
 =?utf-8?B?MndIZ0FERnhMMkUwY3RLc1VQVm5zRW90TVIxM09UMy9IZVVTWkpqT2JsTUVp?=
 =?utf-8?B?SENJejFDbE5wb1haMk5JUmVNTXJaOWFMREtTbmlXWTRTVEpYZEVXK3pobVVj?=
 =?utf-8?B?QUZBMzZ3bHowU0dpS1djRDZ5Qkk1RWtKQXAzSHY2VUFtSjhPa1g1YXNPZ1M3?=
 =?utf-8?B?d2tzUUFZWkxRMk1DNG9QMXJWdDd1cHVEeW5KVG9HVjFucDNBU09xWjJ4c1dt?=
 =?utf-8?Q?nMOINOa3gYt9glU2SvmBqFlHmCyjI1RtkUiO7G5b1XFo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09905bc1-4d41-4054-c492-08dc8f916c3f
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 12:23:12.9802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CHA6zY4tlvYjL2Q1qj+zX/tLTFK526KG4JGjH06+Csw7+TE5YEE0IhpCyCle6cEYRdT0qwyEPxSzpn6V12D8HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7908
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

On Tue Jun 18, 2024 at 2:00 PM CEST, Svyatoslav Ryhel wrote:
> This ensures that the device can boot from a USB device prior to MMC. Use=
ful
> cases are when installing a new OS from USB while MMC still has a working=
 OS
> configuration or if the OS configuration is broken in late boot stages
> (kernel boots but the system does not start).
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  include/configs/tegra-common-post.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

What's the implication of this if no USB mass storage device is found?
How does this behave when USB cannot be read or booting from it doesn't
work?

I vaguely recall that boot order doesn't always proceed, though
admittedly I haven't tested all of these edge-cases in a long time.

Thierry
