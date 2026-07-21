Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F29C44532
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 14:05:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D06938081C;
	Tue, 21 Jul 2026 14:05:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WMqTQvur6adk; Tue, 21 Jul 2026 14:05:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ECF1780D8B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784642732;
	bh=5X4QThCAMsf8n06Um8jQO1QOb6noEI9+XvirSXiEwjA=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=y0UEzWN6oPUEsysB5cqJApUQ4MHEzFZl6qQ9py72EMCP+AvXMXopuJAhbCrdfissc
	 qCPkFTnJArlVDRuTlX+xg5czCzlv8e+4tOVlDb/zdpudRsOqh8ybxl5Uq/4BnmUqKY
	 FnZGmTkccg4ubGfc2/gYTcHyHCp+6K8gWLLa+J0Ki3Oj6CHR9y1ZjrrdN5PMzytvLR
	 iMu7CdVo/iRbUB+fDQYpwc8Jrg34vscQb4PFYJPHu3mLCeEKFYvZZxsDi6bP7WN5MY
	 XqNxjCDxHf+BLuYQeSvdBvkurcqB121+GycMMMQ20jKcHQe4s15F/+M3dbv6nujV7g
	 RAXUZmo8FkUqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ECF1780D8B;
	Tue, 21 Jul 2026 14:05:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9978E96C
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 14:05:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 76EDD400B8
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 14:05:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WPWKX7eWv2aM for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 14:05:29 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=quentin.schulz@cherry.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 1B2E040055
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1B2E040055
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1B2E040055
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 14:05:28 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4281184659; Tue, 21 Jul 2026 16:05:27 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1903803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 16:05:24 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kAnkINQzkGqO1zRmhAYWbP11geitUZ3AVTXk09ymO+lDDzU2tbnGiiMzHOoJQ+L1XZOp8cFYiE5FEcZxSeXZbpnC3b5xY4QeE2+5KLUprVDzVr76dJF1DGmmD6i+GE6BX8Z4TowzLGlqlqKaXvJkVq0n4IWqasIpASTcZJ8yiMX7AyduUav+sD9mpBRmfZiCAR5yGFBvGm2ckaUrLh+YHgFm2CW0ISoFhBzTTO9G+bC0GK6t0DETeZPUIlQMqH/XrU92I84oiSKPzB7pd76HO8U2edpeItrEgEp6zlvBOJYTi8x1fFzFa4GEVKGzR4q8e8RY8quCIoBGml7ikEOS7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5X4QThCAMsf8n06Um8jQO1QOb6noEI9+XvirSXiEwjA=;
 b=ogZ0Sz5rIYxY5r3cD/Wqo7sxYyAlAfnLZVCqhfWHz5MCSD49pyx/Fq9C3/JXeLEaP7Qb4IkkjiR/KMcMoB+bCIWCMu+qnf6oSHXReFu3IT/X29+M5VJdd92ypOaiItZLDfqtF8jokGBFzLm+Pd+PPyErbU85FESPscMizs+vSNtveLRNsh7Af+zHBcJwX+FPaG7IvsSZXZFEFyIYbALXI2/IHk7mF1nkgZhVMXcDGjIvLeAbdkNyy4TklId4qBhGHNeAdLE1Ys/gooWM7z9M2GiXPU+419ogHNl6BwuoJCCKKpkVx2Hc8N5qp7KBLYwTtvvzsY3HoF2QhGd9JTbC+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AM0PR04MB11968.eurprd04.prod.outlook.com (2603:10a6:20b:6fd::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 14:05:21 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0223.012; Tue, 21 Jul 2026
 14:05:21 +0000
Message-ID: <9052feea-38e6-454b-b74c-53ab92a281c7@cherry.de>
Date: Tue, 21 Jul 2026 16:05:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] clk: rockchip: pll: fix overflow and drop manual
 two's complement in rk3588_pll_get_rate
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.denx.de, Elaine Zhang <zhangqing@rock-chips.com>,
 Jagan Teki <jagan@edgeble.ai>, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Finley Xiao <finley.xiao@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>
References: <20260713-rk3588-fracpll-v1-0-cdf47f2ca0b8@flipper.net>
 <20260713-rk3588-fracpll-v1-6-cdf47f2ca0b8@flipper.net>
 <c6beb0ac-0155-4437-a398-0e01241f0e47@cherry.de>
 <CAKTNdwGusMZxvAwrCtmnYDEAn1+dSBfEY4+MSgZx-UJiBKfaPA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAKTNdwGusMZxvAwrCtmnYDEAn1+dSBfEY4+MSgZx-UJiBKfaPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2PEPF000008AD.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::647) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AM0PR04MB11968:EE_
X-MS-Office365-Filtering-Correlation-Id: 248fade1-64d3-46cd-0341-08dee7311a50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|366016|4133799003|4143699003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: B4Xa2/seyYM0AEbLH+0nUO100XS4g+fgJcn7rwS3sLxhIxQtAR4O/1xp7765gs2toqQYEenztq36Auk7+vkNH+EB+WMTCmxIuaXxeACoS+AoGAnvoMoDCpFJcDuNrKTajApnsOY4o1iMqndHdNVjcGTG9MTmZbaqtjsvJ5hymzwxQPmzfHGUmqJIjRdoa2epLbIUw8SkbqSO5sbHWkc+ru5L1IWdtzgKjtWXEl3REbUzOs+FegMGDEQH1FXyabRP05qBFdnThJPQ1ZoAiaIJAnywqgSzFLVHdoSt9OlDkuGNOjBLRv66qpRPI5DO6c9iuoVp6Jq4tPAHHG9yi/Qd6JIzotL4Q88g5GHqaVZkydNCcpkY1O8BcbYbYxQeqDjhje9yA6fz8ANwkDwE2C/fxJrg4tjm+zMgtIt521E5Y5TDlorrqJlra2lbRdsJW31pvd8pONRGWEy5RFRbolC/aOTanvSfWahyFAfDDaGjnueZq1Ssjdk7UporfWzvSnWSxNWAVMl/2ow16YECDYf0xNmJcgfWvJIhRIjeTuXY9w0eSZBgPw9RIBeyaWlMtAe/1z6LGmC3yXjf+wckyyz11lqNpCIzpcGaW8aq2mC4+Jf3qRVUoIb6dHt5Liwul1L7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(4133799003)(4143699003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VU1xYW1zc3UzTGZGZnhDeTV0Ky9Zdy8yZEJVelBiL2ppdWdienZVZm9BT0t5?=
 =?utf-8?B?cEw1WUlqamFkWE5uaEJKU01pVERLNE5GejdNVHVHWmZJczZqM3V2U3RkNk03?=
 =?utf-8?B?MkF2ZVZVWklGeFBZS2dGZXF0V1ZIbm5QcGx1RllQTXU2cjFsWjVac3VKaWx3?=
 =?utf-8?B?b1lTbFdyemNXV2RJL3YxT3AxMU9rN1ZVTW5PanVIdnhDZVQwNkx2VHZEUTBy?=
 =?utf-8?B?d1R5TjY3TWtPQ3FNdE9HVHg4alJjRFVBMEpEeXZVclJhR0dWa05uU2JieGhT?=
 =?utf-8?B?UEdPZ0lHb2t1Ym9xSEZXS1ZEQ3BiQ3d5OWQyNzRzU3JZd1lESk5PSnlob0NO?=
 =?utf-8?B?dEw1Y0VPKzhnaUplMk93RnA5NE5UNUxDNUdOTk5MOWh5bmY4RHBPTS80STN4?=
 =?utf-8?B?amxSVmtjVk5yWlIxdHIwb2NlZ3VoeEVBVzVFL0ZmdVovc2QyZURGVC8xYTlP?=
 =?utf-8?B?Q2Ntd25aOWFMR0tHZndrM0dXSlpXS0g2Y1dyT3dyakNhU1p5cWxRQVFoL0xh?=
 =?utf-8?B?T2Z6dVFVaXphMFBsOS9mOGxINzROV2s0bUlSV3lFWlVwNkU1NExHZlNhTmtU?=
 =?utf-8?B?ZFlQQi94eGlBbUR3OHRrajNoUFdiaExPVEZ2RmtXa3dVTWk4MTc1bTl0Vzc5?=
 =?utf-8?B?K3FOanNLQ3BCeGI5bnBXVkVwQ0J6OHBBK2s5UGEwcEpPYUFnVUFUVis5Rjll?=
 =?utf-8?B?K0V2UUlUd3RnSUQ1VGZMeW9nRE9HMlBzUHdPUFErdXlJVE9icXgxTlNWWWRj?=
 =?utf-8?B?T2NDZjJraU96Wm9neVRMQzkvRUZ0N0NFNEtoV3laQzVDaU1vdjJ2bFhvMFhF?=
 =?utf-8?B?Tmg2VGEyc283dFowQTZqYkUrbkNnUko3OWhXVDJFOGFWRTJvQVNjQnZENlQv?=
 =?utf-8?B?SXF1TnA3bmk3Ly9KMzA5a3hwUUNhRHRnOXdrb2dpY2NwcmVKQlFXMGt0SVF2?=
 =?utf-8?B?cDhzTU5BZzlvN2ROMWJac253T29WSHlHNnpPUTBiSGtSWUVMeC9TUEUxR2RZ?=
 =?utf-8?B?NERpTEs4bEtYZlNSYk5tMDRYbGliL3lzUmFwenMrYkJWVlVYZktIQjA1d0xi?=
 =?utf-8?B?RUFPVHovZEZQTXlwVFV3QkJMaDJRVURPUDN1ajQ4cGJ2U1laTHJ2SXdYUnE2?=
 =?utf-8?B?OGJ4TndnZFRyMG93OGZmK1BQRE1wcE5hY0lOUG5IR2EyZkxFUWFLU3NxZ2ZM?=
 =?utf-8?B?SVZONUdCNUVaa21ORTBaTTVadmZROTRvcVNFUHZHaGRvNCtobkhIdUF3V0pU?=
 =?utf-8?B?bWhJQmtSTVRxd1BlZ3RSMWs5TjhOV2E1RWM5dEw0Q0RpUk9iK2Y3NVU5OE96?=
 =?utf-8?B?cTI4M2h2bzdKbHJZRHVhYysra0Z5ZmsycDYxSXY5Zi9BQ0JEVnQ4N1NJTFlo?=
 =?utf-8?B?UnJQaWlib3E1NVh6eFo3WlVLRUh0cUxoUnNLaDlHRVBDY2ZrM3RKR1VUV3Fi?=
 =?utf-8?B?cTJsVTM2NUIzMnZGNzRPbXVXSVJRdS9keGJiM3ZPOXhkeUxjMkd6WVgva3gv?=
 =?utf-8?B?MDJ3SmJxc3l0bXp2MDR0Y2VDNjc1V3hjMG1OR2JLa3U2TWJzVHdRQkpreGdG?=
 =?utf-8?B?M0lHZDMvakxmcW5VcVdYZTN3ejZLODhmT1paOTVnamFiU1IvY2NxWjZHV3Fw?=
 =?utf-8?B?djhQQmNCWFdjZ1RiUGtROGg5dTZTYU5XLysycHF1SDJQd3NabkxHV25rd0VI?=
 =?utf-8?B?dGd1VzBKRVFkN00rN2xFS3h2V0dYQ0FyVlBWN1BVTGR1cDhsanR6NGRJZUpG?=
 =?utf-8?B?QzNZSHplaEh4MTJ1aE9tYkx1S0RKSm1YSUpGcmIxNU8rbU9iZ1ZDZU5jd3VJ?=
 =?utf-8?B?akZnUlVIWmJtemNKR0FBRmlLeWdWYWxrMjNqOVNuakFVc3dHdDlQK0hCZzlQ?=
 =?utf-8?B?TlUvV3Y3OVI2SmsxTThEZFBpZnBMQUFWS21KMWZFa1BPUElqME1QVzFzaHBt?=
 =?utf-8?B?NzVNcFRmbHRPc1lzODZQZnFlVHRTS2l4WTgyUGdDN210Mnd3RUxXdkJjSUtK?=
 =?utf-8?B?ODM4U1U0SzYvWWpUeFNVOUxlTmUrM1NhVmFvMjN0ZG9GQm5MM3YyRDFsRDZH?=
 =?utf-8?B?WEliRkpzZjBoK0F2NEl1dzZ3SHlQM21xcTRjem9VVWVWU2c3VUZSUVp6cVdr?=
 =?utf-8?B?TmFkTnhkYTk5WnRDd2k0ZGRxU01ySzhDamx6MmtxVFUxNlB0MHMrT3dUSWht?=
 =?utf-8?B?dWErT015WWx1eEpoL1V3NnB3VHAvUjJ0K1FUekgzVnQydHVtTElxeTdmbDNL?=
 =?utf-8?B?TjRQQ3ZZd0pXOWhFbTdQMnA1SjJUelp5b3UyTzIreU9NK3lzdVh4aytaUTlL?=
 =?utf-8?B?eW9jaUQyYXk1Rm5xWjRtYWtlTGZWYXFiaVBtN0Zlc2ZldVVUTkY5Zz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 248fade1-64d3-46cd-0341-08dee7311a50
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 14:05:21.5425 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9HL7p200zalNiDVan/IoQnXkYJr+bVK55tfcVQvrdV2G8We5luhAyO9zkXHTXUG4IFby7ucoqNM0yEKICdRUb1uHtovvKIUkFKkVj67z5TI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11968
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5X4QThCAMsf8n06Um8jQO1QOb6noEI9+XvirSXiEwjA=;
 b=ap9RFosJxB3YTW5n1dQwwNeaEsk/fOtg9pDq0j6XCFWnxP4ndvG2dB5I0dF7Tdi8CK8+Bd9s9mwaD10abFjQPXsF8lEmq2d+0RPrYn4yCJcl+4GvpFVfCDhaqFjIberEIBAkuLA/qWaEfpvfobpiVE/unYMjMeQQ5o+VhPm3+z0=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=ap9RFosJ
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=cherry.de header.i=@cherry.de header.b="ap9RFosJ"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <quentin.schulz@cherry.de>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Alexey,

On 7/21/26 3:34 PM, Alexey Charkov wrote:
> Hi Quentin,
> 
> On Tue, Jul 21, 2026 at 4:56 PM Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Alexey,
>>
>> On 7/13/26 8:35 PM, Alexey Charkov wrote:
>>> Current code calculates the fractional component in 32 bits before
>>> assigning it to a 64-bit holding variable, causing overflow for real-world
>>> values of k, given that OSC_HZ is 24000000U. It also does bitwise manual
>>> massaging of an unsigned representation of what is actually a two's
>>> complement signed value, which is confusing and makes the code harder to
>>> read.
>>>
>>> Read k into a properly signed type and promote operands to avoid overflow,
>>
>> I'm not sure this is correct? Converting an unsigned integer (readl
>> returns an u32 and con is a u32) to signed (k is s16) is
>> implementation-defined as far as I understood (c.f.
>> https://en.cppreference.com/c/language/conversion). I'm sure I
>> misunderstood the spec but considering signed integer overflow is
>> undefined (and I guess one could understand casting a u32 storing a
>> number bigger than S16_MAX into an s16 to be some kind of overflow), I'm
>> a bit concerned here. I probably forgot important stuff I learned a
>> decade ago :) Can you point me where/what I misunderstood?
> 
> It is indeed implementation defined in the C standard, but given that
> U-Boot enforces the gnu11 convention, it's defined to be reduction
> modulo 2^16 [1] along with two's complement representation, which is
> exactly what we need here.
> 

That is helpful thank you! I was sure I was missing something as I don't 
think we explicitly handle this anywhere in U-Boot or the Linux kernel 
:) A few more related questions though if you don't mind :)

I'm assuming we're simply masking the bits 16+ to be 0 (modulo 2**16) as 
stored in the u32 (which already carries an s16 value just "as" u32) and 
not care about signedness when doing that (otherwise we would have an 
issue since the MSB of the u32 is necessarily a 0, thus a positive 
value, since the register returns 0 for [31:16] according to the TRM). 
Is that what you meant by "along with two's complement representation"?

We also build with clang, but I'm assuming it respects the GNU 
implementation with the -std=gnu11 argument we have in KBUILD_CFLAGS. 
May I ask how you know this implementation is part of gnu11 from that 
webpage?

Cheers,
Quentin
