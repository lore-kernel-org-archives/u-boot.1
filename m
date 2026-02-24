Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 304C6E9B262
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 13:31:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C75D82BF2;
	Tue, 24 Feb 2026 14:31:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="oTnpf/yB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0F6083D8A; Tue, 24 Feb 2026 14:31:35 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E24C82A9E
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 14:31:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.delaunay@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MM5fWYfJkvvLRJB0EZaSAWYpUZwSz1lzSjIlbYdLDVrGC3kEfn6agS6586sBpK1CWHm04tMWVqMYy5/4D6ASYhJKnMBp138pBHmyYeicyiEMEpUv1VSYd8uZzDdZU/QZnfGKDLNZVgjmb6ZGo3oAv1ekWAsatbuVk92GlrUqEG4WQHXxqmDN3jlgl2G71NHYyh1Ufl7Q9ewXkLOLmgMxfqdT07XxO36+HzjVkEmsU8rtsYmgJO/2Sj0RfkXQJQtu7e0t8pFXAeWEr07lJfHmWDMZascQ3YOYnHAVoXgpMCAyyG2OoqI1tH13j77tUzcJYrmK0Q+zgK89HyHYvk2nlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIfmiMJgd3+Ynfo6hoKGxbHlN8tmbwy1H9gbkpku6yk=;
 b=pNYCPyRI1240dt07dEnTGYqfu/3HPzAm14evX9kOZQkYZjFgDKY7GH1pnEAUETGgvdYgErx7qizuIxImvdCemj7xM6ucWu/PYxVKEcToSXVlOjiuHnGED9q1fhyEujizneOilAAVkslrb/eCwbeWW56JZQemXFtsgzCEba2dtS1cfCtF8lwAi7gE/rvK+Y2FMWmfiupbFFYutMY/8j2oZRPUzHPA779hY9VQx0X6U9TRDagmA1ANrDqU0QWirq7uX3TH1Kp+LiSOsDpdyF2KwrdgfcwZbzxo78BcnCjddgrs+t1dja6NOobI6WVOU5t7L2xQHoNO4LOfMA5zoISpbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIfmiMJgd3+Ynfo6hoKGxbHlN8tmbwy1H9gbkpku6yk=;
 b=oTnpf/yB3R2AKQ0X/3Nq3auJFG3jgY61kwbuwtvKej7bpSsHGXv9wD+au4ckZuFguU+MXGjKbY+XgimmL2lI1iKBOAJxsKzcuJQp6rCpbmFdKxXiJNJXS3TWviLDp4aKUualb23SyifX/O2+f2iCvrRv3Y2EoRFsqaF5KCEPHu/uy19rV5N47u6RvrjwYM0dBYpLTfF88VYoSi1RfzlXWkea6mAI2vLsnSVem94fgc18btlG5zfsHMKHM9VZaTqJh9Sc44jav+RiMLZXRbdDBXBqycUxQly0d51eDJ4119ojft063X528iePw+PB7iO1IAFMyE02S+/o9DmVxI0XLA==
Received: from DUZPR01CA0317.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::27) by AS4PR10MB5941.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:519::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 13:31:29 +0000
Received: from DU2PEPF0001E9C4.eurprd03.prod.outlook.com
 (2603:10a6:10:4ba:cafe::3c) by DUZPR01CA0317.outlook.office365.com
 (2603:10a6:10:4ba::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 13:31:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DU2PEPF0001E9C4.mail.protection.outlook.com (10.167.8.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 24 Feb 2026 13:31:28 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 14:33:35 +0100
Received: from [10.48.87.244] (10.48.87.244) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 14:31:27 +0100
Message-ID: <ab70bf43-4157-475f-b2ae-27fd9b98d659@foss.st.com>
Date: Tue, 24 Feb 2026 14:31:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] ARM: dts: stm32: Add bootph-all in
 stm32mp215f-dk-u-boot.dtsi
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>,
 <uboot-stm32@st-md-mailman.stormreply.com>
CC: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, "Valentin
 Caron" <valentin.caron@foss.st.com>, Nicolas Le Bayon
 <nicolas.le.bayon@st.com>, Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Gatien Chevallier <gatien.chevallier@foss.st.com>, Marek Vasut
 <marek.vasut@mailbox.org>, Thomas Bourgoin <thomas.bourgoin@foss.st.com>,
 Lionel Debieve <lionel.debieve@foss.st.com>, Yann Gautier
 <yann.gautier@foss.st.com>, Simeon Marijon <simeon.marijon@foss.st.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Cheick Traore <cheick.traore@foss.st.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Quentin Schulz
 <quentin.schulz@cherry.de>
References: <20260203-upstream_add_stm32mp21_support-v1-0-48ca3409cce1@foss.st.com>
 <20260203-upstream_add_stm32mp21_support-v1-7-48ca3409cce1@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20260203-upstream_add_stm32mp21_support-v1-7-48ca3409cce1@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.244]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C4:EE_|AS4PR10MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: c9512e91-a2c3-4666-0894-08de73a9042e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R2ZOeUhXSDllZUZTc3NLQ3MrV3hINHVKN2RQWFRUMWI3NDBUMWtKZlMzR1kv?=
 =?utf-8?B?alI0V1hlaDdxc1psb1NrY0lIdkpYWVd5RjkwbnhmWi9kQkpUQ0tBOVo4aWdG?=
 =?utf-8?B?S1ZxZ3JPM2FmUElNQXByK1h2cUREZHdpRnQvVi85WDFjRzE1SzNGUHdWN0w0?=
 =?utf-8?B?bGFJeTFQYVFPbFIvVi9CTXQ1eURIbnBJR0ErQUhrazVpL2tOQUZhMHFEZDJ2?=
 =?utf-8?B?VzB0TGNhZHZCdGFoWmdOMzdLaXlUS3cweGhoRVRIYXhxZnJoVUc0b2tGc3A1?=
 =?utf-8?B?USsya1FNcEFva1JpTkFYUmZjdEtuZDZYVGlpNU4xd3VVUVJQaHplVDRSRlc0?=
 =?utf-8?B?RXhEbjRodWdLMVV4dy9helYwVU5HZ3I4dzc5QTJneTVKOHNMZGNXUCtscXlo?=
 =?utf-8?B?SlRDS2VMQXlwS3BrVUZ0MzdMN2dMcGQ3RkFHa3liV3Z4eFBSS1hnTzZvOWg5?=
 =?utf-8?B?ODI0eTE1djhRVUpDbk1Pa1lQVE83MkRGbmZ3Q041N211SXZkSHVjSHdVcmJ0?=
 =?utf-8?B?M1pCb3ExZXFHWVdyS0l1NG1PSkJCSzhnL25Obk8yaVBGN0xwSVZ5Y09HVklK?=
 =?utf-8?B?QXltOEl4MGFZWk5JMlRnaTdqTEU4Z1FLbk83ZEJsUFk0bERXU3oxbFRPV3Er?=
 =?utf-8?B?RytpNldoZUdnd08rRHpzekZPWkN6eFVoM1ZMUHJLeWsySDFSTTJDNkhUUTJx?=
 =?utf-8?B?eDhpdWplRXlLM3JOZnRXTlJqd1YxOEIxWHBpN2VDa3FoZFZ6VEUvYzd2VkdD?=
 =?utf-8?B?cTJIQ0VDZW5jOU9oYm1aNnV6OTR2MHNlYW5QQXF3T0crbHpMYzJ0WE5CVk5O?=
 =?utf-8?B?NE0vZVFKbmdKblBvZEMwaGRvZkJVdklwU0dMRkFYc1BMMHFTU0Q0QndrM3pZ?=
 =?utf-8?B?YU5qZ09zbFlSZTBrenowNFNKUjRJWWwrQWxNUkFZbUxXTSsyQk5WYm91blNn?=
 =?utf-8?B?a0R5Y2lmZDFlUlJCL2cyM2dDWUV5aTBPZGRpaWtBSzZxb1lZVWNGV2RqbjlB?=
 =?utf-8?B?bllVSDZQMm41NjJueFZmM0FqWHdIdjNXWWpTeUtnNGJMZ3dmaStHdCt5a3Jz?=
 =?utf-8?B?YjRhYUhUdS9naytDT0RQTm5jdVcxdVpsZjVhNnhGT2VjaWRwOE41TGVBNi93?=
 =?utf-8?B?VDlsUS9UZGpRd3dKaUtvMTlBTGxJYmVBTDNVaTlqTndZYmxtUVRTSThod1p3?=
 =?utf-8?B?b2ZNYUJ1aWRqc01SNnNsLzNkRU90QXJ1UnYrQ2FqRFc3emZoMC9PV1haekFL?=
 =?utf-8?B?L2E3Y00rYWYxOTU2d09sSU4xSUg5cHJOVXFxeEVQMTR1ZmloMUJYTENTQzRy?=
 =?utf-8?B?US94MDJnWFVCN2lLVjVLT1IxRHdiVnFxUTY5cytVOFp5YXg4S2h5bmJtVFgx?=
 =?utf-8?B?S2FldDRIT2Q5dmtjWENEWHNBbWZ6VEVGOEF3Uzhrc3k4aGg3M3Npakp4SUk4?=
 =?utf-8?B?ZTYrUHdjUkJZaURxbnNhZE1vazFQWHJrNkRNaFF3STlIMnFLd3I4MkViQVdV?=
 =?utf-8?B?UnJPRmM4ODRNcFcyN1QydHptOHA3SFNpMTVHTFBWUWxLTUIrM3dSRlBqall1?=
 =?utf-8?B?ZVZTVVJiOFhQNFVuUzQzVWdDelJFbTRtNng3c0JQblI2aHBpeVpBN2hIblFs?=
 =?utf-8?B?RFRLVTdjaTl0QzdOblBwWFIwMXhSVHlvYXN3dXp3a204ckoxbVJFYzIyQlZI?=
 =?utf-8?B?TUtlQmZNSU1HekpvUHlvOUdGblFaR09QTnBPNkZMVW5rZ0hicjlyZG95UHVh?=
 =?utf-8?B?MWswakpKdlZLZU1KWi9WZ3lqbit4ZWQzbVl2VCtEVFNBcnl2eUdJSjYrbFdK?=
 =?utf-8?B?UU02QWJ1MUFjV2ZlZUFIUWRaUGx2RnVTWDV6REJtd3Y5Zmo5VmQyTGpzYjBV?=
 =?utf-8?B?anowc0g4eVQxdkxneS9xY2F2elBLNzRCODlkSHpFMDZITS81YkRFWGszb3pq?=
 =?utf-8?B?UUd4RDhyTTUxcUgwZmhSZERpR0doaU5kZ3RjQkFOeWM5VHd2NjU3L0xWMnZT?=
 =?utf-8?B?c1BWUzVwM3YzWFBCb0lxdmJPeVZHYUloWnlyMDdtVzFhTUpiYnVKSmJrSlpO?=
 =?utf-8?B?dHA5a2lLZjNXVXE5WjlzY04wZ3lvaXlOMEhyWGY3YVloZVhudHNiNEZvMmo4?=
 =?utf-8?B?eVZ3aENrUUpPSE13OG1qMjBwVS9qeTA3SVBSWWc0d2hQUFMwbTdDUTQ5Unpy?=
 =?utf-8?B?UHFCR2k2bVZoUmF3aWtZWHFRTnBha0J1MXdzV0ZIWFlBYW9hWXl3MXlyWXZJ?=
 =?utf-8?Q?Z7t+CodiBLY5Cn/EwNE7nX4b93X5ZVJ8Xz8ftyym5E=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HzZc7EkkpyGIdsAOevQ50E/pi06zxv/hrQ5EMz8as6wE3u/JMpqHapzKOUsN2o9gHBl8p8Wxi4/hGrN+v0NvR9sQpgiWn2KHirlDbwcPgOH6xuDGs8ZnJ4lyooiXrr7tPxUE0wT0rQOtnIP8h82UCHtm6qsf6bHjG/i/0A6ZFktKd1K1JDbvUxKIBUWuCsWanZqQw31LOv+6qSFzYfCUQ90cobCVhg06tmihJBuDMezKAuFcRXbZhXlOzsSXAu7Fly6N446MSs47pWIMl3IHsfbVWYlb/JmK9b5mP9U101/SvO3s8PvVJSn1Gg0u81qWnClOpHamB6LKc0nealETfh48U/TKm7jUwAX8q4UGOLNCc7AaWw6wmuQCyOW2r9TP2pG2IUh8Qjnce22BjC2RVuvamCxpgrMXZsGtpj88qFT/wyLhzr+3Bt+3/42Sm/ns
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 13:31:28.8888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9512e91-a2c3-4666-0894-08de73a9042e
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF0001E9C4.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5941
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

Hi,

On 2/3/26 17:49, Patrice Chotard wrote:
> Add temporarily bootph-all property in usart2 and syscfg nodes
> to allows stm32mp215f-dk board to boot.
> When DT kernel series [1] will be merged and synchronized in U-Boot
> this patch will be reverted.
>
> [1] https://lore.kernel.org/linux-arm-kernel/20260203-upstream_uboot_properties-v6-0-0a2280e84d31@foss.st.com/
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>   arch/arm/dts/stm32mp215f-dk-u-boot.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/dts/stm32mp215f-dk-u-boot.dtsi b/arch/arm/dts/stm32mp215f-dk-u-boot.dtsi
> index e4b44af6df9..0046b22db7a 100644
> --- a/arch/arm/dts/stm32mp215f-dk-u-boot.dtsi
> +++ b/arch/arm/dts/stm32mp215f-dk-u-boot.dtsi
> @@ -9,3 +9,11 @@
>   		u-boot,mmc-env-partition = "u-boot-env";
>   	};
>   };
> +
> +&syscfg {
> +	bootph-all;
> +};
> +
> +&usart2 {
> +	bootph-all;
> +};
>

Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick


