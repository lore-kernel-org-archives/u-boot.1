Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94551C2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 11:37:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2565682B5B;
	Thu, 15 May 2025 13:37:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="YgOCuEOa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD6E882B45; Thu, 15 May 2025 13:37:49 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::602])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CD5D82B20
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 13:37:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oLBnx7NiO3VANfESjtHXTyN/iOf3JyJYuBejjQeyGR9VT7YorbnGJ/Hs/n8HWxZkwokjV0NzKTVtkSnnwUMoN/Zyam1yUS8cZRzvNS1VdN7G476LvI3cQUWDJDBymmMQVt8lK1UQskXwkFLHqvcIlo9i7r1g9tQc89nHzbpv6lVKF7SGjKP0Njezjfh4btJ5Jf64cmx/qExd+hBQj/1WE8E0+JKZ0cj3q4Hes4TkMM1quN7XvlXE0EAr7akdSYPio1PymELsS/ig15X1M5D3fntFdyhPuO0anKleyXm8fjTFqqbzpuEwV+5KRqiiEDn+ODXUOobT90RHE21FPrxqFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oza41ug4oERtSvXHqhEqC/rPspcooFA7Xotfa7E8I24=;
 b=NtioUA71FU2Kt46qGUv60xoonm59OAM1m5v5s3XjOu0ghmdBDeU8LcnrYYEbP0cQJKo3LNd2jRYhBHqYBiLY9nE9UAtZWRncFF46Qrxe4o1YelVBLLQJCQ6/Z8MwuVR/CdiXmLleJi3ZqFEQ1HGS9sPytm5wrADJ83WYXebcmnXJ5ALZqht//FQaL2E5UlpUR+T3QPt+n/J5k3ZDYAApOx8rdzWZAqIhcVaLrXHKdAegDr76lV13NRzcS0Sw38lnn1Kttu+dCjDxPRMiDDvJMnfQuY70ho4NLJvjCyovsbvuVnNYCrwI0LiXFqYaieTRGgYfF9XAMc8CZyINlf4Puw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oza41ug4oERtSvXHqhEqC/rPspcooFA7Xotfa7E8I24=;
 b=YgOCuEOa7cE9uT/sUQSiXidGcXh6DOgJXPwXDvb+WqmuIEchuVX4wbeETM+j0URUeVzGEBwlEADArGR3xrsqXX7iJ5d94TuCq6wmcXWObvDHGlrZ3ZH2F84fQN8zBxd7INkMQEYJAJbMhVJE9pA+Wj7mFeBqzoyIje472bSn0fA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by PA4PR04MB7968.eurprd04.prod.outlook.com (2603:10a6:102:c0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Thu, 15 May
 2025 11:37:45 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%4]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 11:37:45 +0000
Message-ID: <58419801-d2c8-49bc-9c0b-ca07e423c950@cherry.de>
Date: Thu, 15 May 2025 13:37:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: imx: imx8m: soc: fix the macro name
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Paul Geurts <paul.geurts@prodrive-technologies.com>,
 Peng Fan <peng.fan@nxp.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>, =?UTF-8?Q?Vincent_Stehl=C3=A9?=
 <vincent.stehle@arm.com>, Vitor Soares <vitor.soares@toradex.com>
References: <20250515100253.730388-1-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250515100253.730388-1-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0034.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::7) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|PA4PR04MB7968:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aca63c6-a56b-46f0-b069-08dd93a4e957
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0ViWk5zeE9EUjhOa1lRTVlZQ0JDNHZkWlZBSEhiQzUvbDlxcmd1R0ptMC8z?=
 =?utf-8?B?UkZ0VjBNTVoxMyt0bFV4N1FTS2k5cXlHdmh4K2VFZWk4VWNyU2xSaGY0TVRF?=
 =?utf-8?B?cU9aYThNenRyZndybmhxZGNvalNZZGQ5UzhRRVpRNGJua05hbFdQSHhRZm9H?=
 =?utf-8?B?OGt4V3ozdUtNS0kyem5Xak81bzEvR2swRWFmc0dMS3NXeUlQYmQwTTM2eXZu?=
 =?utf-8?B?ZkhQaUtMS1dLUXhoeGVneE9CZ3g0aDdEQ29uTDlneGVwS1Z6NUN0MmR1cHdW?=
 =?utf-8?B?cWc1V3ZrZE5ya3JqT0srMUkxYkVHSk9qUzZCMWg3aHJ0cWVqUTc1L0FhUldz?=
 =?utf-8?B?OU0rV1B1bWg5VXo0RU5PVEhyS0czMnJaa1pIWEhDMnUwcnpFbkxrMHY2YVVE?=
 =?utf-8?B?Kzl0eE9pVHZyR1h4U1Bua25sNHVEMzBxbjlBMGNMVGUwb3VhRzcyUFFIUzd4?=
 =?utf-8?B?Qng1UnpxNlZsL3FNM0pqM1FSS0NRU2RTTmZ0aEQ1ay9XaGRzckl0K0s2d0V0?=
 =?utf-8?B?UlhpeGg0R2dJVm5IQ2NoZ005cnNtMm94RCtsakZIbW5KVnZBWmNtODA3NUE5?=
 =?utf-8?B?dEVRengvTS9WdmI4VlN2TVgyNVZEQW9OM091bTRSaXUyMUpJMFIwMzlNY3pS?=
 =?utf-8?B?LzlwSXZ3Z0kra1lJQTNjUG0xbnVCbFFWdEd4S1ZwRXZRRWo5ejhpcm1MZ2Qz?=
 =?utf-8?B?OXdRNitNcmJ0TFM1NUV4Y3hGT3EyNDBPN3A5czZxcCtoYlh3STlyUCtQei9o?=
 =?utf-8?B?U0Y1eGhyMDBEV0FQeFJKdldwc0dGVjFWS0dzSUU1bHRuZzZyclkxelN1Mmcy?=
 =?utf-8?B?VWxueDh2MURyWjhsMklwMXg2aVBOeWNHblh6VlUzVlcyQkZZMUZ4TEUrZkNz?=
 =?utf-8?B?elNtb1JDNHJ2R01Fa0JyQWsrTEVHSVRRMXVhVjlXekpyUnMzWHMzNG5mTWNP?=
 =?utf-8?B?SUVzdWZJNzB6dWVqR2lkakFqbWVjNG0vYTk4YW1aTU82RGNScHlleEJ1TEQw?=
 =?utf-8?B?Y0JRRWJCQUFxeXFNOUl6dk5BNzZSZ3k1RWtiQU1saWsvSVIzbUVEOUFuTGx0?=
 =?utf-8?B?cW9QVU1QS3dlZ2cvTEd3dDVPdTNTMmNmYWhjeGRldnFZK3NzQklMRXZqWVZZ?=
 =?utf-8?B?Q3o1RHdjZ2JSUHNja1g0S2FDYnlWSzFTUFl5QVZZNG9iY2Y5THhvRVpIM00x?=
 =?utf-8?B?YWtDQXhJeHI3eVp5YjU3N1ZKRDNwZVJaNFFGRVhKeENZaEUxdkYyL1MvQnk1?=
 =?utf-8?B?dlZCTzJFbGtkQzRrQlg3UjFTTXQzTW9sc0hZRzh3VmNiQXVJeU1RdTZWUk5G?=
 =?utf-8?B?N096aC9RaWNYNDVRVVc3ZGZlTy9paHU5YXU3N0JYcmhFcS9wVmh0SENxN2gz?=
 =?utf-8?B?RFdmS2ovY2lGSkxpcjJEd1NvYlhUbE1UMVc0ODFKRC9pKytVdXNLNEUzWU02?=
 =?utf-8?B?eUxxU1RUenlUNzBLeW9pK0l0Ry9uNFNGNC9PN0Y5b1NaTUtrNTNGN1V4Nmxy?=
 =?utf-8?B?eWs4TlJSN1FwTGZhdXduOHJuWWJKcHNGUVh3d0NrSmlyQkRQU0RreEY0TGpz?=
 =?utf-8?B?THowcFdoUzRFR1RsMEFQS1FKQU5ldFArSkE5ZkU0blkxRDVEZFh0akFlSUtE?=
 =?utf-8?B?KzNOUEdxUUpVQ29VMDR2ZzcyRWlpRTRFOS9QcDdxbFpHZ2xkdGZiaW04MytM?=
 =?utf-8?B?d2p2dFNtdGFmWTVnZUJNS09mdmE5NFZCVG9nb3pCcTJmMWZ0MVpyYUt0ZHpt?=
 =?utf-8?B?NFJ4SkxjTVlSVWZtOENEMzZLQ25heEFlbU14OGorRUxXZWhFdUNrT1hFbXl3?=
 =?utf-8?B?NzhSVzRGa2VXSFJDbFBKRjRPRWpLN0ZFVU9sKzIvMWVTREdzSHNXSnV2OEFZ?=
 =?utf-8?B?SGtRR0o0Z3k5bHNHdW9PMEVtKzkybW9VMEZKVlpMT2tlK3gzVzYzUmN6RHIw?=
 =?utf-8?Q?9CARIzO0BCg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RU1ibDFYdXBvcEViRzJ2Q0NQZjQ5eE9zNCtvQ3o1Q2xtaTI0OVJUYXhPdllY?=
 =?utf-8?B?UkFZOTJDYi9QNW15TUk3ZmxyRnhIdU9NcUNpWDVPU2NTbFBOUEM0T0lpU1JD?=
 =?utf-8?B?VU1lYUw0U3BHM2RqK1VndlROWEdVVjRxeUhHSENPWE93TmowNlE2aTR6aUtl?=
 =?utf-8?B?MzZiQWtHWmx3Nk9lZGlNczRReGUyTjl2S2JPaTlYL1JyUVRsSEpmbU1GdmF3?=
 =?utf-8?B?ckU3WjF6L2VheE42cW5BcEZMazEzWk1DSlhEMkppYTFjc2p0S01FYjE3Rjd5?=
 =?utf-8?B?ZC96Y0Vzb1ZtMnBQY21vdHlXMGQzTkx2OWxIVWg1a09Edk5zOUhjemt1QUh6?=
 =?utf-8?B?aktJYVpOZStEc2kweEdYRlVabXpWN2JsTlpmbHQwUm9xbTNhWlY4UzUxRzJ3?=
 =?utf-8?B?cjg1aDAvT21ZSUpPdklvQUtjc3dJMzVyQjFhOGhiNXE2WXk4RlJZOVR4T2xO?=
 =?utf-8?B?VTR0VDBMOUMyVGJJdWZCR3Q4dFFOZm4wTERYaE1CVHpwSlNvMnNnUTNJR2RE?=
 =?utf-8?B?SUwrN2lkUDk4V1habzNqVEhoTDA3aW5zNDBHZDhVRklpSTNhdFdxZXNFRXhO?=
 =?utf-8?B?VE1PSis4SnZvZUY3VmIxUU00eXpCczVRZ0FmYTlWM1pURmhQcGZ2WXllemJm?=
 =?utf-8?B?ZWxQTHFzRzMrelJ1RjFVWUJwK1o2WUw0bTZ5dDlTNDA0MWlIcS9Dd0ZSK0Ur?=
 =?utf-8?B?bkRWdkhPRTRLK1BkYmw0SElkQWNBdGZ5MHFvdmJKZmVaRy9KZnM1ZzArbnpq?=
 =?utf-8?B?REpqVzdlRDBNN3I4bmJkYTVDZUgwMXhGNlVmK1FVUG40MCtVN2l4TzhpblNC?=
 =?utf-8?B?N0JPYWNZNVVOMUJRaW94cEt1clZ4c01ueTNQTFN5dWJlQnlFMGxEaEY4b1B6?=
 =?utf-8?B?dEwraGllN3BzbHk0UDdxOUZFVXk3WUxNNzdnRG10dHI2QjFPaXJoVEpLN2tl?=
 =?utf-8?B?a09MeWN0MmltVFVCZmRNOUNUNXEwc3hlTmNHajg0eC9PWDBqQnI2TFRSSFY1?=
 =?utf-8?B?Zi9iMHFxUFJ2WkJnYVlLSUc3VlB5a3pkdHJPY0pIa2VtWjgzRlFZRmpGNTI0?=
 =?utf-8?B?RU9mamJ6M1lzbk9DOGpGZFNxa0g3cTVjSTJvaUFyMkgyTUlCVjVSN25yakQv?=
 =?utf-8?B?ckU1UFo4dTVWcE10eFk4ckJjaDIwTGM3ckczZEVRcTRQQVc3TVRZemFQc2hp?=
 =?utf-8?B?bG9JQVhGUnVLTUd0dE8xL0JHY3pOZHFzbHYvdXRLdzNGVmFiUDBkQ3hFc1dI?=
 =?utf-8?B?ZDBrZmQ0eW45SnVWcU9hZUR5Z2Z6S255bk1qYk9CSGU0VS9TQkdrdEV3L1l0?=
 =?utf-8?B?VTNEbThVRzZiYlJXdXljZ0lQc1NJT3kvc3drZmI5QkErSHFQK3V6N0xSZE5R?=
 =?utf-8?B?QUMvb1ZBQjY2cCtOaWNialFqeXNRNytFRjN0dGhKc3Z3L1NaQ1JLcFNnODQ5?=
 =?utf-8?B?dTdoOUNSZmFGU1VyTHZWUEEyZld0N3pmc1owK0Zkenk4WmgxSlZaWWY4em55?=
 =?utf-8?B?ZWJaalluYXdEZUpUWnB5aThCOGxYeGVYZWtUbmRKNFlQMWZMcHZxVkdpdjdL?=
 =?utf-8?B?UVp3czhuejl1MC9EOTgyc05qc1BuT1NWbzJ4anRhTnA2b0xuUFBDUGNQYnVQ?=
 =?utf-8?B?b3E4Uys5aVZuK0JETmNrNG5VeTBPTDhWTWxaSEpuTnR0S2xXZjlvOXhUYldP?=
 =?utf-8?B?anozTnk2TVF1TkJRbWY4U3NKMTFwbXVwcXgzVEJ1b0h1QVQ5ZCtvbWxuMk9u?=
 =?utf-8?B?QTM4MXExVGc0VEhvZkpHYmpXS1ZFZnk4dTVkeVplektHMjJSUndhdHpRUzVV?=
 =?utf-8?B?KzE4bzZDL3RBZkl2VklrbHdXK1ROeWpFQ1J1MzUwdVdwZEd1R1RUYklkaUpG?=
 =?utf-8?B?a0ZudHJWRWRuRHVaSTFnM2RJUnhWU3ROSDVDQk5OVFNuOEhHNjc1d1MyemxZ?=
 =?utf-8?B?Z1l0N3VNaXBXQnNDMDFVdUZlZUlCN2Z0ZVMwZkdDdENMZ2ZRQjJQM0ZseS9R?=
 =?utf-8?B?MHZqQmtXL1NMMUdmcWNLeEw3aitua01SaW95MXBrVGYwOFNIb2M3enptclJ6?=
 =?utf-8?B?OHczUFRvTU0zandKSnN2NXp6UHd2eDY4UlV0aE1Qd2JPK2FiRzJVMEowUUwz?=
 =?utf-8?B?SHZ0bE5CK0ZWS0dUYjBPWjgzNHRFKzN5TkpyYkNreS9aZS8xbmlsRjZocTJW?=
 =?utf-8?B?clE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aca63c6-a56b-46f0-b069-08dd93a4e957
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 11:37:45.6778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DOI0My1UlGwXEmmjZCh84lQ7Mrsfy5NNaPU8hgwclnC51ieJ1FgV++sUCce3Zf4j5p3DFVS2uL3qwkviJEs+ozOHZDPDkPNmaJyTwl4AR8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7968
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

Hi Dario,

On 5/15/25 12:02 PM, Dario Binacchi wrote:
> From: Michael Trimarchi <michael@amarulasolutions.com>
> 
> The function arch_spl_mmc_get_uboot_raw_sector() was never compiled,
> even when the option CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION was
> enabled. So rename the macro SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION to
> CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION.
> 
> Fixes: 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 
> ---
> 
>   arch/arm/mach-imx/imx8m/soc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
> index 567e8e9e81a0..806adcf145fa 100644
> --- a/arch/arm/mach-imx/imx8m/soc.c
> +++ b/arch/arm/mach-imx/imx8m/soc.c
> @@ -791,7 +791,7 @@ int boot_mode_getprisec(void)
>   #endif
>   
>   #if defined(CONFIG_IMX8MN) || defined(CONFIG_IMX8MP)
> -#ifdef SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
> +#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION

Maybe a good opportunity to switch to

#if IS_ENABLED(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION)

?

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

I had a random idea but I'm wondering if there's a way we could check 
all symbols listed in IS_ENABLED/CONFIG_IS_ENABLED and check they 
actually exist in Kconfig somewhere? This would not have caught this one 
since we were using #ifdef but wondering if it could help with 
migrations/renaming?

Thanks!
Quentin
