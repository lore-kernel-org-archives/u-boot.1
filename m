Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA3DCFA466
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 12:50:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AEDD83DBD;
	Mon, 24 Nov 2025 13:50:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="LYNwsw/8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3E1883BF4; Mon, 24 Nov 2025 04:59:14 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 603E883ABA
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 04:59:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJB1RveVWNszSDCTp2eP3QumnHqsSrWkG9jDUGBHl+yU4ahEriceCwbHXSFFWNPh5VSQDJK6YHhHn6x9TiHorE2E2TKKC/MLOKwrt6zdArEtlAziJ4QzR2ti2GOtCkjZsgcqK31NHWHZWVAIzcQN1Eol3NF7EFaeIvkc1BHwHYMyG2VSkZj+p2022ZZU8YNcN/VfG2prlrJ/s+U+FXoQEUCgJmoRDlOgCL2KfjWtPj3SYNrS8NF+zX+GmZPCATe/Oi9dpQiR0WbDosSiKpBYgyUhcO48+8QIPd5RstRVdsMN2y199TbGD5OiOLUeHjzDYqZdDd9e84v+E4CMb8U5pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpndIjRuwxGGHV0CWKCODXIpeQN90cQKsRrA/B9hKaI=;
 b=G9Y3eD4jze5fzNd353SpDYLGWSn/nu7tBu10OuPD0Do2J0xzK3EDdLOI4MdvO2D3RcI2NeQbAiA54lrbUEzS4czJeTt2qfmII/yXokRiQWhqGKODc9aH9H1COmcoK1xuAI6b64J9LZ+DW8IqGCODH8E5z1y0TBG7B+aRzPZGX6jIGwdIKbN1f1JAJQqWjSUHYdsjkgn/9cnnCNjZIY75bnDoQm8y3yAwCutjvzpd/whzlC8JLaV/bvcQxPOWymPVvkgpTVoj4KocJPg3FK/eUaPj645neaOW/HIO0+8Px/d8udpOemfrJrtB1ika3reSViuVNj+CfD989GtjKdtbDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpndIjRuwxGGHV0CWKCODXIpeQN90cQKsRrA/B9hKaI=;
 b=LYNwsw/8VknO6Oq0hy0nFzsnGDzWWtAfi8oOEhl3NSdXzce4Y7sXEn/Fdt1iM1s2iVm1x3Ye7WYWb8Qw7BZ7EIWThACEJRbjPKKt5NmxNmn3JkBbau8JgHL5EPJbBz87cw5JgRPUXHzX7lYQEjapvl3Sk1ZF0nTlEZRSZrkYur4=
Received: from SN6PR05CA0008.namprd05.prod.outlook.com (2603:10b6:805:de::21)
 by IA3PR10MB8420.namprd10.prod.outlook.com (2603:10b6:208:579::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 03:59:08 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:805:de:cafe::bd) by SN6PR05CA0008.outlook.office365.com
 (2603:10b6:805:de::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.9 via Frontend Transport; Mon,
 24 Nov 2025 03:59:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 03:59:07 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 23 Nov
 2025 21:59:05 -0600
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 23 Nov
 2025 21:59:03 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 23 Nov 2025 21:59:03 -0600
Received: from [172.24.235.38] (lt5cd2489kgj.dhcp.ti.com [172.24.235.38])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AO3wrZl1249137;
 Sun, 23 Nov 2025 21:58:54 -0600
Message-ID: <094fc5b1-f271-40e6-9dd9-55710370b131@ti.com>
Date: Mon, 24 Nov 2025 09:28:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/13] firmware: ti_sci: Add
 TI_SCI_MSG_MIN_CONTEXT_RESTORE
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
References: <20251120-topic-am62-ioddr-v2025-04-rc1-v6-0-6dd99a7271bb@baylibre.com>
 <20251120-topic-am62-ioddr-v2025-04-rc1-v6-4-6dd99a7271bb@baylibre.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251120-topic-am62-ioddr-v2025-04-rc1-v6-4-6dd99a7271bb@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|IA3PR10MB8420:EE_
X-MS-Office365-Filtering-Correlation-Id: 653bd02f-d742-41bc-5c50-08de2b0dd101
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|7416014|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VFpMK3c4UlhxMlVWWmZDd0N0VzhQbGwyK2lSbVpQVXNZamJJOVpmdjcrdkZC?=
 =?utf-8?B?RVZheVRzelRaSi80Zm5jc0dQaU54T2JIL0tvUDcraStnMGRUclFXaVQwbUtj?=
 =?utf-8?B?Q0pLenYrTnBlVTBOWkk0a0x3MHNmQXV3aTQ5SHR0eWVUUFNMbHBvVHhsVDFB?=
 =?utf-8?B?SnBWSXE3NG1maXA0ZzJKWnFnc0crL0N6NmlWTXFiK0RyOUl0citGMnJCS25j?=
 =?utf-8?B?SnYxT2laU2pscDVFRkwrNi81Nm1vM0hFd1lTRkExNnZoWk5rWFlKaU5rWmtY?=
 =?utf-8?B?eU53QjJNTXNGNndITDhDNTVQVS8yMDR6aXJNc0NkL2NXT0t5YVFHQTlhTUpy?=
 =?utf-8?B?aWZ1dHlJU1gwQmVJTVlsL29NZ1JGeXJBamRIQng2b1czTUpaUndFbGRTbEVi?=
 =?utf-8?B?SDVueVk4SEp1eFlLbHZSbmdXUjlYb1JkcFNtRlR5SEh1bVh5OUMzR0RkVWkw?=
 =?utf-8?B?b1FjeWZsR0Y2cWpBR3NxUDBWd0dIMjVDR3hMdklObFZxSStEYit1YWszY1FM?=
 =?utf-8?B?Rnk5YmRBNlppb0lrZXlBY0xLbTZSWW9ZVld1MkJWWm9HclR5NHNKaW95UzBy?=
 =?utf-8?B?aUVpY0dkTk51NW5MQnduSmx5bFoyMjhaZE5zVXc2ODhlbzlBUTlWMkRqcitB?=
 =?utf-8?B?Wm03ak9oUm1MZkpESXFyKzJwaWg3UDRpTjJRTWVSRmxDRTU3QTkvUnlsdC9C?=
 =?utf-8?B?TUlSUVYxQmFzZXhXSFNrRmprMlF6QVBvS0dhcmJMWUVhdXYyZ3U3d2NaSUZs?=
 =?utf-8?B?UnNvUHBhcEtOc0s0dGcvb3JZdVEzeGNFd05ibVQrYzlmZHpZSzZPOGs1QWxO?=
 =?utf-8?B?S2JVMys0OEc3MXRDd2hhb0krMW5rK2w1dUZLOFNPUGJXQWhJaFpVREI1Y25N?=
 =?utf-8?B?eUdxaW9hbC9xMkdOWDRhRUZOcDdEbE03bE9sNU8yNUVZSGdtUzFYQm9IclJv?=
 =?utf-8?B?b1kwc0hndHVwK0tXdlU5YVJwNk5sUWNnOHU4QktxVnJid01DYnBYOURBb3Zy?=
 =?utf-8?B?WUdEdWtORmMxaGJGbWFCWmRzOGtBZnVuM1M4NjJ6Q0pqdUpNOHcyM0kwdDRs?=
 =?utf-8?B?cjFRZzlIWityU2lleFlTWGpYd1pLcFROMjgrdVJPNE51ZFpIK1NMaDJlWE1j?=
 =?utf-8?B?a3hCdHgrN3ZteFJMS29mcUVyY0VYR1ExRzg5ejlSalJHNzhydFE0aEVOZW44?=
 =?utf-8?B?VUlwUCs1cnB1SzVQS1d3MmNrUktwdWViSlhEVDJ2WEsxbHNKY05XcFZ0OXdn?=
 =?utf-8?B?NXlYOW1ZVDdoc29XVW5ROStmWGR0ci9YT2I2SG92Qk5Dd0IvK0JpOGdkU3VQ?=
 =?utf-8?B?Z3didU45RzBKN1p6K2lLQ3R0MWVvUG5uYlVyQ0pad2tDWHpMSTMrM0E3cTRn?=
 =?utf-8?B?OUF3Qy9iUGxNT21LSnNTTm5ycjBaTTlRK2xGWmtkOUV4S2FyMm9ZL3lydmJ5?=
 =?utf-8?B?TE5aMWIzNXpjTFhXUHFlR3R2SUNwb2RtQzA1UElnSlBFQXFJSGpOQU1nUkZH?=
 =?utf-8?B?NXo5K0pPWllNSDcxWUJKcXNGdDRGamVMVWVaRE1HaS9tdlF6TXJxWWxaZUZL?=
 =?utf-8?B?Tmt4OHl0VnU5TTdtRXk3bUZUVCtmR3JzN2h1UWt2N3c5T25WcysremtJZ0px?=
 =?utf-8?B?Qnc3TzBEekgxNWZWLzVGcnJOVGpySEpRWExBTHowdlh6YVRvMHBoay90VXJw?=
 =?utf-8?B?cnhFWFM1b2ovUk4rQnFxYU9TbU45SGFyc2swdnFJQjJXcGVxL2g1VktnWWhI?=
 =?utf-8?B?aDdwOE1UbGNTQU82QzgyU2tjSjNHRzJCT2pseGVRNWx6SUZYcCtQWjl4TEJI?=
 =?utf-8?B?aXdUOVVhbkZLTzcvKzRPZU9LcVo2UWhtKy9sVEoxYkVYWHFEVkl2d1FPNXhK?=
 =?utf-8?B?ZGdpOVNwaUZoMUZNZVI4dytQWkFMNnY0QUh1UHhyTU1HSlR2d3YyUmZNdlBE?=
 =?utf-8?B?bEFJcjhzMnNGV3dvMHBQODlieVhLUWRacVVrNm1tQk1MOXRleDREQzNyUWk1?=
 =?utf-8?B?bDJoaXJ4bGFRVmkwTHo5eVBiRzlTY1NMQktFTWJRMVNDNnYxTTZGRXlGYUo4?=
 =?utf-8?B?RlFjZXZCZUs1KysyS2ZXVVZISnhVREd0aXpNUVBBcW8zdU51a1lxbDF0aHg5?=
 =?utf-8?Q?VyGg=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 03:59:07.3901 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 653bd02f-d742-41bc-5c50-08de2b0dd101
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8420
X-Mailman-Approved-At: Mon, 24 Nov 2025 13:50:30 +0100
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


On 11/20/2025 9:33 PM, Markus Schneider-Pargmann (TI.com) wrote:
> This patch adds code to be able to call TI_SCI_MSG_MIN_CONTEXT_RESTORE.
> The context needs to be restored after booting SPL when resuming from
> IO+DDR.
>
> Tested-by: Anshul Dalal <anshuld@ti.com>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>   drivers/firmware/ti_sci.c              | 38 ++++++++++++++++++++++++++++++++++
>   drivers/firmware/ti_sci.h              | 16 ++++++++++++++
>   include/linux/soc/ti/ti_sci_protocol.h |  9 ++++++++
>   3 files changed, 63 insertions(+)
>
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index 6f57dcfe8de8f874318cd53372c798d182faae73..f1cb871e8f45013097f6f8188222770ffe3653dc 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -2710,6 +2710,41 @@ static int ti_sci_cmd_change_fwl_owner(const struct ti_sci_handle *handle,
>   	return ret;
>   }
>   
> +static int ti_sci_cmd_restore_context(const struct ti_sci_handle *handle, u64 ctx_addr)
> +{
> +	struct ti_sci_msg_min_restore_context_req req;
> +	struct ti_sci_msg_hdr *resp;
> +	struct ti_sci_info *info;
> +	struct ti_sci_xfer *xfer;
> +	int ret = 0;
> +
> +	if (IS_ERR(handle))
> +		return PTR_ERR(handle);
> +	if (!handle)
> +		return -EINVAL;
> +
> +	info = handle_to_ti_sci_info(handle);
> +
> +	xfer = ti_sci_setup_one_xfer(info, TI_SCI_MSG_MIN_CONTEXT_RESTORE,

function name should be ti_sci_cmd_restore_min_context or change 
TI_SCI_MSG_MIN_CONTEXT_RESTORE


> +				     TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
> +				     (u32 *)&req, sizeof(req), sizeof(*resp));
> +	if (IS_ERR(xfer)) {
> +		ret = PTR_ERR(xfer);
> +		return ret;
> +	}
> +
> +	req.ctx_lo = (u32)(ctx_addr & 0xffffffff);
> +	req.ctx_hi = (u32)(ctx_addr >> 32);
> +
> +	ret = ti_sci_do_xfer(info, xfer);
> +	if (ret) {
> +		dev_err(info->dev, "Failed restoring context %d\n", ret);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
>   /*
>    * ti_sci_setup_ops() - Setup the operations structures
>    * @info:	pointer to TISCI pointer
> @@ -2728,6 +2763,7 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
>   	struct ti_sci_rm_psil_ops *psilops = &ops->rm_psil_ops;
>   	struct ti_sci_rm_udmap_ops *udmap_ops = &ops->rm_udmap_ops;
>   	struct ti_sci_fwl_ops *fwl_ops = &ops->fwl_ops;
> +	struct ti_sci_lpm_ops *lpm_ops = &ops->lpm_ops;
>   
>   	bops->board_config = ti_sci_cmd_set_board_config;
>   	bops->board_config_rm = ti_sci_cmd_set_board_config_rm;
> @@ -2795,6 +2831,8 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
>   
>   	fw_ops->get_dm_version = ti_sci_cmd_get_dm_version;
>   	fw_ops->query_dm_cap = ti_sci_cmd_query_dm_cap;
> +
> +	lpm_ops->restore_context = ti_sci_cmd_restore_context;
>   }
>   
>   /**
> diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
> index ce50bf6800eb1fee70a872d8ae648b1a9582b681..3f8c27c7d8c5b35cc55c18ed33225e7b5262b3da 100644
> --- a/drivers/firmware/ti_sci.h
> +++ b/drivers/firmware/ti_sci.h
> @@ -45,6 +45,9 @@
>   #define TI_SCI_MSG_QUERY_CLOCK_FREQ	0x010d
>   #define TI_SCI_MSG_GET_CLOCK_FREQ	0x010e
>   
> +/* Low Power Mode Requests */
> +#define TI_SCI_MSG_MIN_CONTEXT_RESTORE	0x0308
> +
>   /* Processor Control Messages */
>   #define TISCI_MSG_PROC_REQUEST		0xc000
>   #define TISCI_MSG_PROC_RELEASE		0xc001
> @@ -1572,4 +1575,17 @@ struct ti_sci_msg_fwl_change_owner_info_resp {
>   	u16			owner_permission_bits;
>   } __packed;
>   
> +/**
> + * struct ti_sci_msg_min_restore_context_req - Request to restore context from DDR
> + *
> + * @hdr:		Generic Header
> + * @ctx_lo		Low 32-bits of physical pointer to address to use for context save.
> + * @ctx_hi		High 32-bits of physical pointer to address to use for context save.
> + */
> +struct ti_sci_msg_min_restore_context_req {
> +	struct ti_sci_msg_hdr	hdr;
> +	u32			ctx_lo;
> +	u32			ctx_hi;
> +} __packed;
> +
>   #endif /* __TI_SCI_H */
> diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
> index 52696763ecf6bc2336e796978e1cc02896db13ab..cb9798c8546617bcea9cc0f49f19c70e1e2c16f1 100644
> --- a/include/linux/soc/ti/ti_sci_protocol.h
> +++ b/include/linux/soc/ti/ti_sci_protocol.h
> @@ -632,6 +632,14 @@ struct ti_sci_fwl_ops {
>   	int (*change_fwl_owner)(const struct ti_sci_handle *handle, struct ti_sci_msg_fwl_owner *owner);
>   };
>   
> +/**
> + * struct ti_sci_lpm_ops - Low Power Mode operations
> + * @restore_context: Request restoring context from DDR.
> + */
> +struct ti_sci_lpm_ops {
> +	int (*restore_context)(const struct ti_sci_handle *handle, u64 ctx_addr);
> +};
> +
>   /**
>    * struct ti_sci_ops - Function support for TI SCI
>    * @board_ops:	Miscellaneous operations
> @@ -654,6 +662,7 @@ struct ti_sci_ops {
>   	struct ti_sci_rm_psil_ops rm_psil_ops;
>   	struct ti_sci_rm_udmap_ops rm_udmap_ops;
>   	struct ti_sci_fwl_ops fwl_ops;
> +	struct ti_sci_lpm_ops lpm_ops;
>   };
>   
>   /**
>
