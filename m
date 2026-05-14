Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69DECD37AC
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 03:36:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03728846AA;
	Thu, 14 May 2026 05:36:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="PG+N83SC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 375E0846AC; Thu, 14 May 2026 05:36:25 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F143784683
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 05:36:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQm3L63wiZHyhjMTMh56WQsfVnCf/nNEfJNfNp8Tzyl5YaVRkx3VqnINio008YHgD8L8mgPTZf4ryAbIl/8i8IQ2Gxtk4MC09zNvQe8OeQo/BCt7zjLXMPG6KQbznOWiYIBP6LRUTU9I2bLE8biDkMVTynA75zg59eIkcY0ILh1uC5Gj0P11K0FgWeQdLNGyN1WEjoCA08pL+88dX8Q+QD9+eJaei6dwm/avk9CTkMAbSJDj5y/g04Pb60OP9mAFUFBsRKdEN4IMZA2KH6myyuIT+EX5XN2dNVeE26C42ygw4O6cSFoFgcfkMO0KUnA7k1PnpMpoC9osIEb1p6e1og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NdDKhJzIpVMA8BEnvIAXqBhNVr5AToY+eWkmEaNifAo=;
 b=UxnKzYJOpk8OoQf/5b8Yqfsr9j4rXB7tO5Pa1I/HwXwiBsFDXtt5cpngn2WpUy56JEhx/MwihEGF9G7E3FqTua30c+r+U3FGzK7Z+KuRB9q8sZvqXbYjUr6q0B/7aXFpDtdWJxoPQY3yGgd3hzJcwWDpb5k51yQT0v2YDyISMH4vAWOg3tky8ktalcMPKE5v2Zx5wwGFRA4PQ9b8fdrFEM+sJCc6MHQ2QYoxmh6+jAqXb/cxe8AcxzRouP1TKov1X1CjsuBLdCW0GVTge4ewaZAGkmRY8L4b+eGGlUfjc7J9j5rsToZJFB9A1ct6k6FC1jVa3Nh8mPOuEhkQ9MER5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdDKhJzIpVMA8BEnvIAXqBhNVr5AToY+eWkmEaNifAo=;
 b=PG+N83SC6bDe3K07a7fu/KfU3okkDZ76VC3WpscXg1W9YLLJwQg0Ng1SYgGpZdPivlka1XonuRPs6zQqLZcaAp6lfT4Y2IfmSadtqcN307hVmRRdYbQpb2FVouROLXlkLx5CvwdknVVAIkHSdpyxtdCKy9m5NepQkTXg6K1RGnoms6DQoyjo36C6VgFOeMeRGQeovNidkyQnSXX9PxuSWd2uf60UCRjgvYCDSZXz0VcEMHQr0M0LTj26QGhp5Sps85dy8YeVRE4ag9K5Hruaz+SkuRZKzBolcLxNCpztseQWg6ysEng1e8nkSKAv+uhH9ZjfObkDZ5LoTFP30PgwuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SJ0PR03MB6874.namprd03.prod.outlook.com (2603:10b6:a03:439::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Thu, 14 May
 2026 03:36:20 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%4]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 03:36:19 +0000
Message-ID: <c328b9bf-0c49-47d4-b058-147aa6f15357@altera.com>
Date: Thu, 14 May 2026 11:36:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] arm: socfpga: n5x: switch firewall setup to driver
 model
To: Chen Huei Lok <chen.huei.lok@altera.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20260428070017.16807-1-chen.huei.lok@altera.com>
 <20260428070017.16807-7-chen.huei.lok@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260428070017.16807-7-chen.huei.lok@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|SJ0PR03MB6874:EE_
X-MS-Office365-Filtering-Correlation-Id: 8301c6d3-9f31-42d1-260c-08deb169f62c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|55112099003|11063799003|4143699003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: VVPDOIBCHY4jk/pyK31Xgam+LvKD9btKE7QGENSxIu7fQqJzKazrg8dq3yNlDf8ZZMrOJXRDak4EUYsnTz0LbL4yvgnw6strHEy7XGU/XmCm9IX1Z0Jzihi0jWcjx3cZbgZsZC9/dSQwtM/xDEj5ofgdki8aZFdHX+riHlnoUa7N8vjR9lytssU0+A8Q6G6m331TZk6+Uq89AQAG5Hzmk0HiNrwSFgc+cPKIXN6sxk6v2DnFI6+Wmp/INQYUj+iS7RdyhW/7+9ehxn3MqiBsT6x36bqMU88Jys/SjY8ZAqcT4oTPyqB9ITlIyZj2HGo1y2vI1KPViL5LhrpP1tpwCIiVvYAr/tSJa7XACR5Nd8+vejFf9E0cZrcaYEJyhVHtft+3Rjjpx5op+0YFUkgbb2euTrfClCrztYD3aP2dNYY4mWVXX7XNmhFAIAQtYrc+6UqdRU0CE4nxjGdv5+xh4tG2Yk/JPQtaK2ohFER59I9JTb6dbx2dns7Ix61ddLwhZ+ROISnlR9pWV8uGse2rE7DD7p9ofFihT2DD5j+2Ffp8klz4yFDYx4lN0XAfS9+Y9/i3q/zBiMfIgCl4akKpFUQcp0SAc9crQ2AO2OIWMLQY0bRcDF5qYFRDl5HexwESBBL+W20mH8H85P5ny4c4WF+IhoxGRqzpr3lFcKPePcECn8s+jsr1OyRS5q/XpN3o
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(11063799003)(4143699003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEU4M1kwdUYxcE9jTnY0c0lyMkdGV08reEh6V3NjTGxQT2dQRmtGWVh3NUQ5?=
 =?utf-8?B?NTdNL0JNL3JtQzFtanhieVViQ242ZXdETWd0SnB2QUpjQ2N4UUhITktzdDNW?=
 =?utf-8?B?ZFF0L0VvMWlpOVhSZlJuN1YrSXdWV21IMklTZG5NdUdacTNIOUx2OEk3RnlC?=
 =?utf-8?B?ZlVpSHpMdWJuMWdXWkovTjdiaDdTOStlMWx1WENGZGU3UVdJZ2NuU29Ybi9Y?=
 =?utf-8?B?bC9xU1BialR1TnZjS2tWRmprZkhWS0dqMnk5WVdqMFNjYU1MMU5zYzhZV3N1?=
 =?utf-8?B?MndCR1NPV0VEOE9WeVkzbkRCUFp5c2U5a3Ywc25ZVHBVZk8veVorM01QSWYr?=
 =?utf-8?B?ci9aMzVKNlFEbng1TXFsaWlMdi9NRks3UGt1c2c2Nnp0ODlTV3NUZkgydE1K?=
 =?utf-8?B?UEZmbm9MZTRnZGlkOS8vMnJSWGtnTkZwNkJjb0IwWkNEL1NkT0VlWEFoTjlT?=
 =?utf-8?B?bGo3TEZYVzJ4ZGlkekYzWERTTTRTd1l3cmovNkQ5RGh3ZzdCNTM5L3l2aXBa?=
 =?utf-8?B?YTJIYUl1SEpFdGJzUnJqUThzRXNER20yRU5STWlkU1NybFdPQ0xiRVZpWlVv?=
 =?utf-8?B?U2M3OWl3TFFKdmU2N1dwV21ZU081b25xOXRMTXZRSE8zL0Y0eXlEbSsxaDZG?=
 =?utf-8?B?d1Izcy85QVRIMTVsTW96UnN3cXlrOEQzejZxRUFjZ0J3Z2FVdSt6cDNkNjcx?=
 =?utf-8?B?alNsSXBKbDhRMFc0WDJLOHVST2NlR3BVZ1cwaXUvNkEwTkUyTXFRNjZuV1Vn?=
 =?utf-8?B?d0IzYmE2OGRaYnRocVY1QlpXRzJzUXJqc2RJcHZhS3ZhSUsvUStqOWx0YUtH?=
 =?utf-8?B?ZE9hVXB4VXpYYU5JVXR3b21SWVo5N0xhNFZ0aklVaXhnbHJnZ0hpWHVXeGhY?=
 =?utf-8?B?TWpmRmxxeUJFVHZqaUU0bURDZlV5R0hZOXA2anNyWWdJY2lQL0twNHJ0bnBy?=
 =?utf-8?B?RHVBd2RQdk96a3NjbVJHbktHeDM1dTVMTnAvek5LUytieWliU05reVRUNDkr?=
 =?utf-8?B?blhvdTQrRldVN0RPcTU2c3IzS3NRV0tSV1NwcVZqTXMycFZjaUdXdnBzZGdG?=
 =?utf-8?B?RmF3eVFOOW9EUUNPa3RES0Fwc2UyN05la1VoZ2RUWVE2L3BQTHlvYnhuaUdR?=
 =?utf-8?B?TWh0VnJScVJRam81YVF0M2h4QUVQSUEzM1VGQzN0bGFZd1ozNFdrRlpOQzZx?=
 =?utf-8?B?ZWM1ekdiZzVJbGNYOUlTZjRTZmhzcTNiVEJXck8xelowQVFkbnVrV0pFY2pT?=
 =?utf-8?B?UzRpcG5iV1Zha2R0b1VnQnU3TzJGaUw5SlMyNEZIdHRpRThDTk1adTdqRWxW?=
 =?utf-8?B?Z0FxbTRaYWpQWGtEaXpsZDZHRzJtOEFBbVlyNjc2NWJtcTBVelptMFBxODRi?=
 =?utf-8?B?MktXY3RhQTE5bVNoZ0xIK3YvYlAxa3RXWjhQYndJbnA5S2kvWTVEdUFoQjJq?=
 =?utf-8?B?dGIrM0MybSs4WE1lQmhRK3lzQnJvUU5zVWZnUkdnQVlXWElxMU0xR2x0eDdv?=
 =?utf-8?B?SGE1WHFMSUpBNERjMzVuSXM2UEVPNDQ2aEw2UE5ORXNNSHZ5a3JZVjNYVjRx?=
 =?utf-8?B?ZlJlTmxPV3BSa0dmWDZ1NURkU2xoeTE3Q25tcmdwSXZtdUhvcndBbk1uTHNy?=
 =?utf-8?B?QXgxV0lwZzhuL3AzMm00a3o2UFhROHBhczloVDRqcmFNbW50OHB6VXlES3J3?=
 =?utf-8?B?Z21vbHBNRzlocTlpaFNTUG1YZnBZLzhYTThlT2tzaHorUk5YeXFsb2E0aWpu?=
 =?utf-8?B?ZS80ancwblhMV3FPNDdSSHNuS05sVVBrclFRTGpHWHJNWWRrOTZLQkc4RHdP?=
 =?utf-8?B?bzNNei9KbENzUUFjRktILzZLWDduMXZWNUd1cHdFQThncUZwK01KOTBCelMw?=
 =?utf-8?B?aHBYRWNvUm5vRHF2NFZnVG5hUlp4YkxoUHBGVDhEdmphU1pTQXBYaFkxOHNY?=
 =?utf-8?B?NjJxYTRab1lVNmNSNWh3TjFWQmowb3FIbjFZak1pMGhiSTMwRzYxZVMwVCs2?=
 =?utf-8?B?NWxNc01HZUszMDhucVFCQWdiVEFGa1dVakVqRTJHSzRPQ2RwcGlUZjNFVEw0?=
 =?utf-8?B?dE1seTFXUzVwbFdZdWRiQ1pqQW5wUW9BeFBDQ3YvM1FmQTBsQTMzVmRlZmdt?=
 =?utf-8?B?c0gwbXIyYkxYN3pKSzh6UGpTMjcremJWZHdJaXN3b2RPQXBCN2UxYlV0TldV?=
 =?utf-8?B?dEdBWXRNamlYemF3dmoyL2t6VGtoaDVpZjVHSGFFb0IvQlVZQWtXZkxRbVBU?=
 =?utf-8?B?UldJT28xWWVST0ZFZkhCWnJOOXRoOFk0RUJ1cGhoY0NwdUFOeVBaTTZPSlRM?=
 =?utf-8?B?TnhKSTY2U29wY0tQU09RL3F5bzg3OXB1WU5nUVkrYXVkVG5iS1ZNZk1BUml0?=
 =?utf-8?Q?kwS4kbmFYrYIJzV8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8301c6d3-9f31-42d1-260c-08deb169f62c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 03:36:19.6493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: frakFX9uWEa1/clU5bjK5Rb71WWtG9t0YFABO49icXoUi+zpTP5RbSAG/BTQoSEcmQwbUU1nrqHUUadTH8daFNpLU34GNkS11LLjuX82Xjc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6874
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

Hi Lok,


On 28/4/2026 3:00 pm, Chen Huei Lok wrote:
> Move the system manager and L3 interconnect firewall configuration
> from a dedicated firewall_setup() function to using the driver model
> (uclass_get_device_by_name()). This removes the hardcoded firewall
> setup in SPL and relies on the driver model, making the code more
> maintainable and aligned with upstream practices.
>
> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
> Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
> ---
>   arch/arm/mach-socfpga/spl_n5x.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-socfpga/spl_n5x.c b/arch/arm/mach-socfpga/spl_n5x.c
> index a49be837921..f776d0c0327 100644
> --- a/arch/arm/mach-socfpga/spl_n5x.c
> +++ b/arch/arm/mach-socfpga/spl_n5x.c
> @@ -69,7 +69,17 @@ void board_init_f(ulong dummy)
>   	print_reset_info();
>   	cm_print_clock_quick_summary();
>   
> -	firewall_setup();


If firewall_setup() is defined in a separate source file (which is 
implied by the function call existing before this patch),

removing its only call site should prompt deletion of the function 
definition too

Without that, the linker may still include the dead code.

The diff should include the removal of the firewall_setup() implementation


Best regards,

Tien Fong

