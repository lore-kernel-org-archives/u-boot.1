Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09289C25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 08:30:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 086B487B42;
	Thu, 26 Oct 2023 10:29:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="a9VNIhHI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD08187B3A; Thu, 26 Oct 2023 10:29:54 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on0728.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::728])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E56D87B48
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 10:29:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhcZ/bdT52m+bip0ehpAw8tPk9g6RrBkTiPK8XGwTdV5neVw7DFLo1/b3XuUWnvXNu4zV4Wg53YZvvwdKe8EkI0hgOLUdnqPwb4/Jva1XWUnRaJA1mA7YXBXqO1L1s+IVcLfxM+7BX+xaZ5i4tx6vW8WpXH1GgPIarY7O33o+RJDcyuTX9o7NDAtEQ8YEiqeMEcJ9UNGvwvQ8423xCYxLiXtn+b1V07b8He6EihRYWo2qnQsG4HNr0SJe1Ndvnnr8Z7JWAyo3U3RVD/o/hLdCJYlRXrAYHOjeXhqGrEqKl5Up0zFEo78yu0W2FMdQjlyAwEYLShJJWqacjwEVFhzfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3K3CovZPSvpJ3KLGKlBfvjouMm8IVErRGMgdrtbkDjM=;
 b=K3aHyFLCllc5EsXJKt9gOVufSUMeHeExtJuF5uNdPU1VyE1XKPTcoUK3XEZCitmWkHBo8Ccsfl1p6tAObfinJvrxOaqXEKP2QpUovwVlWMXSAJW1jomyM0fKb6F/j5+qisfSBKotJ7rGoA3nh2yTouBkeI+aV3FsAKBmCwYWWD8xXd5/FFkdDJw5waQIclNliuPwkXe86N2ouxdAdEvagKLWYDeZECh8/738+WjYOoHknULQ3mVNa6bIhxrigj7S4CM1lP407lkTJmICj5YqeyVpEsQLqLga7BUEqUjzyhzkc/f/oO4p3S9Ro9UE9KehdLSjRDsvKYBc+9t5qxGdYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3K3CovZPSvpJ3KLGKlBfvjouMm8IVErRGMgdrtbkDjM=;
 b=a9VNIhHIN67wCYsNx2FM/hWRJ2RrZVWz9P3dEyErN4k5OuR+7WwgM6URcqTFHfPbEjERtCt2jhnx9ZvMinjKugeoARxgpmVG9bnDOmpsPRAElB7QxVmxqTpQRvFNIslCiR/HYUxHijcB0J8pMNmGGBX8eL37Yw4zuRD6i6TAjH4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS2PR10MB6751.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5e4::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 08:29:49 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6907.030; Thu, 26 Oct 2023
 08:29:49 +0000
Message-ID: <f9ce2b20-1fa1-408c-9ae6-4dd382c9c999@prevas.dk>
Date: Thu, 26 Oct 2023 10:29:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] imx: spl_imx_romapi: fix emmc fast boot mode case
Content-Language: en-US, da
To: Marcel Ziswiler <marcel@ziswiler.com>, u-boot@lists.denx.de
Cc: "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Peng Fan <peng.fan@nxp.com>
References: <20231026073220.244387-1-marcel@ziswiler.com>
 <20231026073220.244387-3-marcel@ziswiler.com>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20231026073220.244387-3-marcel@ziswiler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0302CA0016.eurprd03.prod.outlook.com
 (2603:10a6:205:2::29) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS2PR10MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: a4fbe6ab-b494-4653-4088-08dbd5fdb82e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0kjSSWcbcb/JnnKq0rpVRaKaIcuU80w04Bq+HRD23h659z+rfA4RUUKIcR4FebxuHhJyz4ZLcyARGct5YpfV0NjnegpzXhh17Ao6oiX1IK29/2n+ipTzZHoZJLuScfuuM5UJnFeewZUWkCZDr5i9rTrlntozBEL8Ux/LPr72eZ1a2X9V0ELjXWFJdNxhgPMYRTMG+ZYuSMlA+hrmsX39Z/lmNhO5wcf/RAh1nWCRzZv+onqgkt+9ndIDnpk6att7+rS4rwDkROsgG8P1zxdnH3oyfHH6Ka18n3eM1jbII2tgzMhHxvK49S1jl8CpT2rrEP4O+P+kZ97ocoWKw3f3azC5SJ7WMJ36wE3ERw7GT3OEsXYgVRxrzFsbNODuGv1umQDoku1DhDpxaa9VAbu/02GZP7srb3EYOKmdmMFo+s94QCFRE0iRX2YmK8J7q3lWIvnKPVb+/b79/VjU23z62MSUfbNVV6BxqA2oDhbuznH4QUwrYxh3/gKA4IseJnhn97s9ktblJVTBQb6srQYnd9PisKKu9zYyNua7QxD6biUTKo3TQ+f8smqprIq4W/j0ca7tcA4QGIewE6T09l3qPIxg8t1G5JNw6P7SMCk9Rxh1rrcph0ef6NR00G+qtkjQGKot8/I/TaZt4W7TZHxOOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39850400004)(346002)(396003)(136003)(366004)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(31686004)(4744005)(83380400001)(8936002)(36756003)(26005)(2906002)(8976002)(44832011)(8676002)(38100700002)(2616005)(66476007)(4326008)(31696002)(6506007)(478600001)(316002)(5660300002)(6486002)(66556008)(6512007)(66946007)(41300700001)(54906003)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?My91bDdoMWNuZ1BSWnVzdVl0S3Z2RnprSWJsdDZuY0JhUkFXcVl1QXN2NjhD?=
 =?utf-8?B?dGNGOWJYUUhuNGZ1ZkdRek1LUVE4aXhWK01CdzZLV0gwZTNtcmluK2RMS3B3?=
 =?utf-8?B?ZEhuOE1mTDZsdVFTN1RDZ2gzNUY3VnRYeXFXdXEzai81R3JWZ1Bwd2JGc1lU?=
 =?utf-8?B?TmlOY09zT3hJZVJrNXlxeUJzcitnVGZjTVJXQ2wzaENEV2NacThYQXh4a1o5?=
 =?utf-8?B?ZHFRV3NVZUlRZnJpS3RSMzhvVE43a2oxNVVFT3FkVEJEdjBtOUo5enZIVEIx?=
 =?utf-8?B?UktwcEdPZ2syT2tjRFIwYksydEdSSDFsbDh6QUdtN2poYXZ2dEZDdllNczVC?=
 =?utf-8?B?UzgrakpqUHdtRTN4b0Q3cWVYanllNDRlMWI1bTlWTGVXWmFvZnZhSjluZWJD?=
 =?utf-8?B?OWJhRU5MdUxHR3hTRlBSUnpBM0lsM1k4bzdsbCszY2xVSG9GTDRBTW0zQUNU?=
 =?utf-8?B?RWV6aXFzSFl2VXNkZDVjZVl4a2dLWXZ5S3hhajdMQms5dDN0c0xHTG1pQnRN?=
 =?utf-8?B?RFZPbW9JejNhb0Izb2tnU0RSWUwyeG9FRjZRSisyWGhkcWlua1JONW9tZWJa?=
 =?utf-8?B?QmU3SkRqMUtCTG1oWnBjNWxiWXg5dE16OGpISzZFRDF5Znk0bi9taTNtUmt2?=
 =?utf-8?B?U1d3WXMvckNmZ29zcVljK0J1OVF4WVpjdmNxWDJPVjYrSGFzMnVmZU5qVDly?=
 =?utf-8?B?QXlIQzJnNlZ3NS9xM1Z3LzJBREh1T21BbkdNOW9WOVdyanZpNTFkVTQ5L0J0?=
 =?utf-8?B?WXAxeTlCWklvZWMxdVpPWjBmdkxENmZGdjh1MkJsd1g3anNqcEo0dVo0a0M5?=
 =?utf-8?B?RGtpS2xndzNDT1hySmVVd0R5WCsyUVkzRXNkSXRZcWMvTEdCNnJRdGJqeUdp?=
 =?utf-8?B?Q3Z6VHpoT0UzNitUaVJ5NWcyTHdxSTFJTEtxeDZ4bzFyTk94RWZVZEhQWTZq?=
 =?utf-8?B?WUVON0tBZUkrUVp0cCtnY20wVWw3U0pVd095UGVnVXFwbEFoSzhaV0M1TnpX?=
 =?utf-8?B?aHRMRk1UT2ZqbGh4Z21POUc4cmFYTzZXNWgyMWFWaDRBUW5wdmVDb0hxYU1l?=
 =?utf-8?B?d1JxR2FoNmNkSEFFQmxUNG0vY3R0K3dxZGJXYVMybXBBTVdkZ29HdXBRdjZj?=
 =?utf-8?B?REZxUW4ycXFleFFsV3pKNTdjaXZXeHRLSysvVlBCSkduZUZGNmxPUjROL1Ny?=
 =?utf-8?B?R2xiRE9naWl3Wm5HQTlzVTQwemNZR2FkK3lwcGFmMVIrVHdpY1gwZlFYOUtQ?=
 =?utf-8?B?djFSZm1CVGVDTk5IU3ZPVWRIZm1iR2JGTnV6YmhDM1AxeDkyaWE5RzFocm9q?=
 =?utf-8?B?WHBLNkR4UHVuOUpyOEZtRHhMVkZ6L1EwNWVBbDlTV1FLL0hBQVZVZFljYk9C?=
 =?utf-8?B?L3BBQnNCOTF0aGVNcWVMZDB3ZEFJWjk3R2pleFI0c2lGdXRoSHY2NDhSNlBC?=
 =?utf-8?B?YkZTTW95UDQxZlNHYjFaSXpVQjVBc0IwU0VaVEt3bjZkRHIzTmxnci9mVEF2?=
 =?utf-8?B?QnZBWVYxd3c4YS93SDRjbXB4cDlMbFZhcTZzYnZhVlMzdjVpUDdYY1cyVzQ0?=
 =?utf-8?B?OTlxR3FXb2lpUDk1YlkrbTJWcHRHbTVLTHJIMkxFeE9Ib2paaWRobkJXUzhv?=
 =?utf-8?B?RWhFWkRGOEpUbUhLaVEwTG9aYzgvc3VIditXUURaN1ZYS2RnOGFsMCtTeXJr?=
 =?utf-8?B?UHVCOVhOWFlYUXJkbmdVV0FOVlk3Q2hwN1BpR2JFbHNTeFIyT3lZOEdZVk5h?=
 =?utf-8?B?TGUxTTdERnMxbTh0UVBydlZ4ekl6K3ZSY1ZJQ0hMRWptekFPWndVYm05RjBY?=
 =?utf-8?B?Mk9tM3huVURhS0c4YWNuaWw5NEJnQUQwc21RUEcvSTFZMXd2M0FwSkxRY3Rm?=
 =?utf-8?B?YUlQWlhVa1lodGt0ZlhTKzFBd2hubkFMMFlsYlFEUy9UM2Fzd2FGSXRsb2FW?=
 =?utf-8?B?RlJ2Y2oybFJhNHNwMEk5VXNOQWhHNlQwWTIxY0ZjN3QxMUt1Qi9qbHpwWnFF?=
 =?utf-8?B?SEJxckVHVmprbjFyczhyM2FZUVdYWE9nTzJmZjRQVFhrellBbW9SaGEzVU5l?=
 =?utf-8?B?alJZMFlpRTEzQVdpbWZ6Y1JCZ293UTZJUE5uMDdIZU1BLzM3eStyVk0yYUR6?=
 =?utf-8?B?aDIyTEhaK2pSQ2hsNS9pMVR5eC9RcWxzYjU2MlJCSjR3dVBYVFJYM0FEVjJ1?=
 =?utf-8?B?UEE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: a4fbe6ab-b494-4653-4088-08dbd5fdb82e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 08:29:49.7774 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CZNuHsaoHj2wZ3JgTWct8Z2x/XJm9ewEvGzDkI+T64gb+705pP/UiQcWfuxbF1tScF0nnSJ+WV5okoBRcu872K3JtHS0e6ew8i7ABFipQRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6751
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

On 26/10/2023 09.32, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> This fixes a regression in the eMMC fast boot mode case where the buffer
> was missing 464 bytes.
> 
> The code figures out how many bytes must at least be fetched to honor
> the current read, rounds that up to the ss->pagesize [which is a no-op
> in the USB download case because that has ->pagesize==1], fetches that
> many bytes, but then recorded the original upper bound as the new end of
> the valid data. However, this did not take into account the rounding up
> to the ss->pagesize. Fix this by recording the actual bytes downloaded.
> 
> Fixes: 4b4472438f5a ("imx: spl_imx_romapi: avoid tricky use of spl_load_simple_fit() to get full FIT size")
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 

Thanks for reporting and fixing this, and sorry for the trouble.

Acked-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

