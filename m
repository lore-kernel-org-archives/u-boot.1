Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABEFDD59F76
	for <u-boot@archiver.kernel.org>; Sat, 13 Dec 2025 14:05:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EC8D839DE;
	Sat, 13 Dec 2025 15:04:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KpfXNW63";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 303C8830E4; Sat, 13 Dec 2025 07:59:10 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0A6983045
 for <u-boot@lists.denx.de>; Sat, 13 Dec 2025 07:59:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mGlBZZXJD4RjUoMPlExoDFripx1kX41T0zE7RfXIkkQKCPVF2NV3JQH5uP+4/EHZ5/rGgzEFzKCYxhf4ctDFceeoVBG54ljOMPutLrR1vtAA4dNuyMtWb1BZHgOGQwkyHumGezfk51a8F5tW7xkJWfyJ4iLaX0s59wNmdLGWosiwPbkyttqwS8h4aEIj6AopP6nXhL6anukGjB8UwgHJjB8Xiw11O7Rd9CH73SKXa32ZznEi0ltUmyCHcnBMICtvNBPiGewZqT70sAwEy/uheItUwKUuXh06zWW+c4vo9M0PmjlSfrPg/pax0EAX2FsK/LgwzCHOoGQqr9tNkrx5xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYxGDEqw5qQyT1bmKy9an9dE6bVbWJDp4HnnD/Yo7ko=;
 b=J8JW0zQffPgoMbcVObvfvorWDLFf1yW82ahzoIQHUv71QXAkvd0OHqRczcvt3keYqLsBNKqFFrZ5jN7yZX1LopKvTiOTTPg9Hx5SD9PxVqUtwv1N8NGqBeHWpFf+q7kF1df/s/zKY7hdYXSCkZUHJwmPHTDVTz5Ayy6ce9KbY2b5u9VhGEQATUTEImPCqXjiFQsx7HmgjNnaQqxHJUtclZuEXiSrecdYdhp/Ea9h3OpzuAQB+7zV1vykQgI/LOZ+j3GSQ4ZMLZ5Hn1QZDtQvBxODsRmJPjlpT0YfL878EEkqjrOp3Ut44ig/eU2A3+T4HCz9mTZE03RppevPvL+lZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYxGDEqw5qQyT1bmKy9an9dE6bVbWJDp4HnnD/Yo7ko=;
 b=KpfXNW63LHNm3HUglKqh2kLAbr9m18AsltEM8NUQv0VDi5m6piLY+LNAEH7Us+nk5+iJZbUusqoP8wz+Ul0JW4C4pO6Y7apQGw6vt1+fItyCgwTHuGYw9KGm4ZXXUfYO7Hhb+x/n5QdlM+KWoxJU8L6z4w8RapmhlWhpRRUHZGE=
Received: from SA0PR11CA0033.namprd11.prod.outlook.com (2603:10b6:806:d0::8)
 by DS0PR10MB6222.namprd10.prod.outlook.com (2603:10b6:8:c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.11; Sat, 13 Dec
 2025 06:59:02 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:d0:cafe::6) by SA0PR11CA0033.outlook.office365.com
 (2603:10b6:806:d0::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.9 via Frontend Transport; Sat,
 13 Dec 2025 06:58:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Sat, 13 Dec 2025 06:59:00 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 13 Dec
 2025 00:58:57 -0600
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 13 Dec
 2025 00:58:54 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 13 Dec 2025 00:58:54 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BD6wigo3392354;
 Sat, 13 Dec 2025 00:58:45 -0600
Message-ID: <fbf79118-9d1a-4da0-ad65-9ae8053833a1@ti.com>
Date: Sat, 13 Dec 2025 12:28:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/13] arm: dts: k3-am62a: Add r5 device nodes
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, Tom Rini
 <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, Nishanth Menon
 <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
CC: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>,
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, "Kendall
 Willis" <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>,
 <u-boot@lists.denx.de>, Anshul Dalal <anshuld@ti.com>, Moteen Shah
 <m-shah@ti.com>, Santhosh Kumar K <s-k6@ti.com>, Nathan Morrisson
 <nmorrisson@phytec.com>, Garrett Giordano <ggiordano@phytec.com>, "Judith
 Mendez" <jm@ti.com>, Aparna Patra <a-patra@ti.com>, Jayesh Choudhary
 <j-choudhary@ti.com>, Chintan Vankar <c-vankar@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Neha Malcom Francis <n-francis@ti.com>,
 Prasanth Babu Mantena <p-mantena@ti.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Beleswar Padhi <b-padhi@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, Andrew Goodbody <andrew.goodbody@linaro.org>, E Shattow
 <e@freeshell.de>, Devarsh Thakkar <devarsht@ti.com>, Peng Fan
 <peng.fan@nxp.com>, Jerome Forissier <jerome.forissier@linaro.org>, "Sam
 Protsenko" <semen.protsenko@linaro.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Andre Przywara <andre.przywara@arm.com>,
 =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
References: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-0-f113b156f83f@baylibre.com>
 <20251210-topic-am62-ioddr-v2025-04-rc1-v7-10-f113b156f83f@baylibre.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-10-f113b156f83f@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|DS0PR10MB6222:EE_
X-MS-Office365-Filtering-Correlation-Id: eeca9da3-b4a5-4c90-8b2e-08de3a1517df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TnB1WWhMdGZFUVJnRzYyN25vSUgrZC9sNnkyb2VPMituekdvcDZyUWo1cGRY?=
 =?utf-8?B?OGtvWE1XdGxNS1VIR3cvdkpGSTFZUjlSZzFFQWxjb2tidk0wdEFLNlFzQ0V4?=
 =?utf-8?B?VlA4ZkFFOXFWcHNwcjlzYU1JZnNoOGtvNjJ6aDF4cXdyMzZQVHUzQTlnbFl1?=
 =?utf-8?B?T0ZLcDM4cWcxL0lNRHk5KzdSMlc5bHV6VVRRYVZWYjlBemQvN1gxQWgxWWFz?=
 =?utf-8?B?T2U5SlFSUHVnWnhBSXVta3FiQ2piOFdTUnA2OW4zUG13MmRQOHBtM1RuanBP?=
 =?utf-8?B?UkdINVY2RjZwZ0t3anRhVTRQM01VSkwwaUFtbFV5NG1BL05qWHhkY2xkdnRa?=
 =?utf-8?B?aWtMQnBWakdIVlN3RVpaV2R0c0p5VlhKV1hhOXRuUTZXTnY3cXBMTFp6QmZi?=
 =?utf-8?B?Tk9nWi90K2FoNkNLczBxbUJZd05Fbmwxakh0MzJYc3o5N1BsS0UvUnlrSVpC?=
 =?utf-8?B?Y21sc3RzTVJ0a1BTU0wvVGRsOGVFNHJmUmRVNHZ6Ym1BQUMxU1ZmaCttSTNL?=
 =?utf-8?B?TzZNOVRMcGdRSXJZR2o3c3BQYUp3WDNubWkvenVoclJFbWtTSmVjMjdoaDRh?=
 =?utf-8?B?bEFLcUZtZFJYMjRXS3lXY01jVDNjU2NINUdmdVdvak1rSmI5Q2RLc3ZTSkpV?=
 =?utf-8?B?eUI5MmtINlErbFgvNk1sZ1kyaVFmN3lObVY5Tm4xWm83OFV5cDVjNTNQU2t6?=
 =?utf-8?B?NDFUc3JNVGwzU0c5ZVVKUElvNnNzOXhodkJRU3VEY1YyMFVmKzdnZy91ckxI?=
 =?utf-8?B?MXYzODNBKzBXZjZoaHN2UjJCUlFaTXFyS0hsNVhobDZlZzhablloVEpEdTd1?=
 =?utf-8?B?Z2lNdngrOXYxOHd6d1o2dS9QbE1JTkxzQkY5YUl3bVNqUGNqM0NwUXFSZGRa?=
 =?utf-8?B?TnV1dnVjTW82VkI5SG9TUSt4TkNlYXNTV1EyWFdzdjlaT2o4Y3hnaEVlUnhy?=
 =?utf-8?B?ZGszekMvcmVqQm9YVnZSeU9FQ3VMeWJZQ3ZhSVZpY3Q1N2kvMi9LU0xtcUQ1?=
 =?utf-8?B?U084bXRxZmZZRWxUdkZLRU9COVY4SVdDdnVoN1R1OEFMeFNxWjVkTWlWSzNk?=
 =?utf-8?B?RTJWbDJvenZ5NEJBWUxYREo3eHlQTGZ3bk13WG5ZcitYTndIczdxUmU5aG5B?=
 =?utf-8?B?RmN0bE9RNXNlTVVoSFlqZnIwOEZVZUtDU2pPRG9xVjZuc0ticitRVFFKVFhn?=
 =?utf-8?B?YlhlRG1pT0Q4SE1UNlUwenlscFNHMnVmSldxRE9MUHIxNVhweVRRWTFjeVF1?=
 =?utf-8?B?WUZ2VWFjREFlYUo5cVlwUjgvemdKbjlRR3E3c0pKU0MzTk1DL2JGdENMbEZ5?=
 =?utf-8?B?NUdBNys0ZlBmZmVsa3dBY1NTc1lySi81R1RmU1VNU1pvYmhhMG9kcW5mS3JI?=
 =?utf-8?B?TVdsbmVXQ3hSbUdjQldmTFFoUkw0eWFsN0dLZjZVTTNURSsxSXIrY0VRbmgx?=
 =?utf-8?B?YmR0Q0JMZzNra2xab29UZDJwMVVCdC9XQjRNaml4ZGgvdTE0Nm9TTFBJKzdC?=
 =?utf-8?B?NnppNi9IMlNrZDNvNTlwZzBiSUd0REpsWVNJaC91d2twZ2xENTN0clVoMEl0?=
 =?utf-8?B?RG9QaU43M01xMDJWNDcyNGVqeEdYaGRTQjRLekNZMkdwcUtLKzNIbjhZQ2pZ?=
 =?utf-8?B?dW05dzAyb1M0KzN0Y1hzcWpEUVNsNkVUWG9oUCtjbE91SjVmNG5xN3RINndI?=
 =?utf-8?B?SjlHa0t5RzlXSS9abyt3SWNDNTJkOWRhVmVPaVljUG02VEZ1MkR4cjFBdFZh?=
 =?utf-8?B?R0VQYlBvUXQzR2lEMmZNeE1CTG44N0ozUmV3NXA1U3QramxtTVltTDM4ZmRy?=
 =?utf-8?B?WnRlYkJoWVFwRmZ3TDgrTEI0RHBFLzc0QTNZMWF0Y0NvbGlNS0JVUlVwbW1o?=
 =?utf-8?B?UU5yaEVNNFMwR1VmblpkRWR4MUNhSzgzV3lJOHVGbWdNaE5IOS9MUUhtbWdW?=
 =?utf-8?B?c0YxZmNpMFMxTTZLdUR0SURKY1cyU09SejNUSHZod01Fd0dGNis1RUhYSnlV?=
 =?utf-8?B?UjZNbkVVclZVVlBxMTZRcGNVelp0MDBGOTZxRkExN0lqUDZnQXYyRjN2UXRi?=
 =?utf-8?B?cnh3WmVBT004aEtVTG1YK0RMY0VTZEJHdTY0dGpxUHNYUTh6by9naUwyZnFH?=
 =?utf-8?Q?Lpg8=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2025 06:59:00.1754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eeca9da3-b4a5-4c90-8b2e-08de3a1517df
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6222
X-Mailman-Approved-At: Sat, 13 Dec 2025 15:04:07 +0100
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


On 12/10/2025 7:39 PM, Markus Schneider-Pargmann (TI.com) wrote:
> These are needed in SPL to be able to resume from DDR immediately after
> booting from IO+DDR.
>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>   arch/arm/dts/k3-am62a7-sk-u-boot.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi b/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi
> index a70fc88317e04de032e4da1428e25eb78ecc30cf..84f3a5c199b344d17300b9672cb9c77f607beb6c 100644
> --- a/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi
> @@ -16,6 +16,10 @@
>   	};
>   };
>   
> +&wkup_r5fss0_core0_memory_region {
> +	bootph-pre-ram;
> +};
> +
>   &cbass_main {
>   	bootph-all;
>   };
> @@ -68,6 +72,10 @@
>   	bootph-all;
>   };
>   
> +&wkup_r5fss0_core0 {
> +	bootph-pre-ram;
> +};
> +

please have it in your todo list to push to kernel device tree. with that

Reviewed-by: Udit Kumar <u-kumar1@ti.com>


>   &cbass_wakeup {
>   	bootph-all;
>   };
>
