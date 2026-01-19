Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A64D0CA5FFF
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 08:20:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 069AE80B98;
	Mon, 19 Jan 2026 09:20:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="NSl/2vOe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D70083015; Mon, 19 Jan 2026 09:20:31 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EFF2800AE
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 09:20:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uvAfCsYCkvXav5dHiTvcheN8eIkQHxicacIMto9RGenxLataN4FyTny1JA7PY4TYECLDQ2bpC5H2XAhCcOl6i67ux260UraJBvioFOq6M8NA1d68H3deLdWhQoK6yowcGbeCYj/YBCTj3p0vzQ5HJYm8pWLahjSHhDjbbEskkIHo5ddSn3RMYab729D8WCTlG2ENuiCArPzl3QI/dkeg9q5XwmfIu1sUZoGlNvUiXDW5t82D9INu4l330a31ndDXipi3LvVHlbd6zdf4M05UUFVcsPdJcRtTw3Dxjqxm0HxV3SG8Kd3yh+aAd1/LWKmzTPPdJaznffGVjZEo89q67g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7/dXLzUtbBEhZI2akNWjqpM9ICJnFYPxpw5F1klFgw=;
 b=MvExuz8ahV1PFA9Jjskn6xTB5WZDJKPIcqMu0/dU44TTx3Q44etoBzRU6HzyP/CdHWxOHQxeXIMQYyYAqpRE4jjof5Y4tbZ1yD8HZDR7k2z6BXM2tkoqZpsWyGia+egA6aWUNFiP2/waVcd6VQlvhrJRad6DYnCxyVVGZDAUHkmBcuLWWvbfuYx3q/nqcpcjPq0RWMupcqNMmLeKvcMCl/km5Fp+oBuP/J82bKqJDurhjyjwaS91qzVFpIlDe7U5YhdYlR6f6WhZxzsitoDfvDUBFW+Vs08Mf3n2FA4Z9TdkpjxvOOg7KDiFD8n5yEkSHAZRQP9ZA6rRceHHZNnjug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7/dXLzUtbBEhZI2akNWjqpM9ICJnFYPxpw5F1klFgw=;
 b=NSl/2vOevJ/EZeBJzG3pDG7gyY0QRP+5YHiSypdkrNiQ0NhRFBnZJ/epPi20i2TCBX9KBMrSGM2mwJ/EJcCzXwaq/xwpjDGNt/qfzMoDuXr4WWaKBBbRD64nupIDpYO/LSxpqSNBQukojB9aYH+3uKTvuBYhERiog016JBiaiUHQ3jqxmvEkfjhr+fAtBtABKkJ/s2Ww+Ly6OWn2c3EMz2S7hsNRdSzu4ABWJ6TUmkk6kQmZUAgg5UEnb3eaTzd5HxqQ8RLmo6ro0sRPeVSXh8aihpBt05Joim89UxPe9DV8NGMoqGVL1i+IpLRhP8xBbpb5obx7uLkmFGrkrepHMA==
Received: from DU2PR04CA0303.eurprd04.prod.outlook.com (2603:10a6:10:2b5::8)
 by DB9PR10MB5930.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:39a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 08:20:26 +0000
Received: from DU6PEPF0000A7DE.eurprd02.prod.outlook.com
 (2603:10a6:10:2b5:cafe::79) by DU2PR04CA0303.outlook.office365.com
 (2603:10a6:10:2b5::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.11 via Frontend Transport; Mon,
 19 Jan 2026 08:20:26 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DU6PEPF0000A7DE.mail.protection.outlook.com (10.167.8.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 08:20:25 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 19 Jan
 2026 09:21:44 +0100
Received: from [10.48.86.129] (10.48.86.129) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 19 Jan
 2026 09:20:24 +0100
Message-ID: <f88f0727-315e-4210-9f55-3e4d3019eeec@foss.st.com>
Date: Mon, 19 Jan 2026 09:20:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] video: simple_panel: add support for
 "rocktech,rk043fn48h" display
To: Raphael Gallais-Pou <rgallaispou@gmail.com>, <u-boot@lists.denx.de>
CC: Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini
 <trini@konsulko.com>, Yannick Fertre <yannick.fertre@foss.st.com>, "Raphael
 Gallais-Pou" <raphael.gallais-pou@foss.st.com>, Philippe Cornu
 <philippe.cornu@foss.st.com>
References: <20251207-simple_panel-v1-1-8688d221aacd@gmail.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20251207-simple_panel-v1-1-8688d221aacd@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.86.129]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7DE:EE_|DB9PR10MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: ea6bae2e-a6ba-4228-ef33-08de5733993a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0daR3RxUlF1aW55TWJCMFphcUFGMmpLRmI5bUJrc0VaVEM3dlR1N2hNa0ZV?=
 =?utf-8?B?ZnJQUithVFAxS0lzeStEWmt6RjlyT0hyL1lYOUlTMkZqZEhsZExIRUVPT3JX?=
 =?utf-8?B?dFNwVUM0Y01UbHh1NGVXcElVSnNuclpvWkJxUUNZeDhyV0srUlpuUlhmK0pY?=
 =?utf-8?B?dUZoVnA4QW5SQnhjR1J1Ukx2cEE3VTFYVWE5OUdwZk1qS1pRcjZWU2RhdnA1?=
 =?utf-8?B?NDJBdEYwaFZNQlN2YkFSelQ3RGtzMXpZQzJwNVBHbjZONndSWFMrcVNCdTBv?=
 =?utf-8?B?QmdnRU12ZkRHcmV2dG9ZZ25nSldOUmJXdlkyS1FjODVMcy9oTllkRUlYUXF4?=
 =?utf-8?B?dHQrT3B6OHhJd3JvM3h1d050S3M0SXl5TFBZM2pNSG9qYzQzMTRjVFBZbXpo?=
 =?utf-8?B?OXdDQ0ljTHc0azNSTCtzT0pLL3lPZlNiNXZ6cUpBOGx6Mmc2eUhJQ21rM0VF?=
 =?utf-8?B?OUVvdzRzWWtVcEFaWnlzUVVkeWJZSzhaRXF1L3VnN0RpWlgxcEt5OUVpQTZh?=
 =?utf-8?B?Y3BCRG1mTmlGSUE5TG5OZzdSbXlsdklSYlJCOGlVdC9mSUZvUGIyMy9PYi9I?=
 =?utf-8?B?RytWc3JvTVhwOXAxL0VxVkl2bUh1dGpYeDNrRi9JUlJ2aWoySTFsVEowcHU2?=
 =?utf-8?B?QVcvQW1ONWlHQnVsV2dsU0x6dnJteEpsZk92RkpKZWtqREZMRU1WdjhpWTk2?=
 =?utf-8?B?RVJsbng3eVhOOW5PbTdzK2FPSFJiTUNuWWJMcmlLMm1YYXlEbDBFa0lTc0tQ?=
 =?utf-8?B?cXhUOWErdk1mVStqMWxqb2haSHAraU4wc1k3MEJ1L0lCdVFqTFUvT3JNRE1M?=
 =?utf-8?B?Z1VYVDJZMjFFQkJvOEh0R3NRT2dmTklQdHEzcXpTUWljT3loR295YTZ3MzM5?=
 =?utf-8?B?cDFtVS8xNFk3RWlpWkhRUFk0YnA1S2JnK0xvUjE4ejRBdUdWYlY2UDBIMDF1?=
 =?utf-8?B?VnhiemNLcHZ5TmdoQTZKRDE4WjNPL0ZId3l5VEtFdVJNdWVvVkJoYk8yaHhq?=
 =?utf-8?B?K1ppUk9JUVdLeDdVelB0UlJiclBaTFNCRFZRbUFmKzE0aUtQbk4zT2FZd0E2?=
 =?utf-8?B?S1plWm0zRU5NKzFRZnhlMFg0cmdIWURiY1dHYXE1RmhTWHdFalY0L292Tk1z?=
 =?utf-8?B?MTl4Ni95d2JlUmN3K1BvY3F1bVFSU2MzbU9QQ01wNEdJaGg5WjZTODc0SXdt?=
 =?utf-8?B?VGZ4bS8vNk9SWnFsNkszN3dZR0g5d2FlTTV1aHA1VHhhTUxEUXVDcmJLRHc0?=
 =?utf-8?B?OFp2OEdDNzRaN0RLZ1VtZnJLVFprRjFLMWZScFNpQmlraUNhQ1R3cHROSDhm?=
 =?utf-8?B?YmdMU3NpdUhXUXhndllqalpjRGM2Z1BqdzRkSHZ4MmdPb3o1TVhRVHdSSEQ0?=
 =?utf-8?B?MURZcEpTV0x1SzB5NHAzUEdhSkVEY0xOWGdxUHhFL1BvRXVudlJXSy9QM1Vh?=
 =?utf-8?B?TTZOQktFY2RhbUptcXp4UWxUZEQvam5saEtZTUFsYUVaNE56dnE4ZlF0Qis3?=
 =?utf-8?B?djJESzAyanJjZ1hpM1NaMXg1bCtaUUpyVlJFblQ5MUNZYm9hREo3c29zbTR1?=
 =?utf-8?B?NlpVSVE1OTdDYU5ncjBDbVk1d3NqUysweTZxenlmbTAyQVhKR2FkZ3J3NFp1?=
 =?utf-8?B?QlNMaXA1ZExJK09IY3lxMnMzdDZXOVNJak85N1dIRi9WUHFYTFdzaTlhYjBs?=
 =?utf-8?B?WURNT2JaTGMySUc1QzJVRVlSaTlpVUJxT1lXbnJ0bVBBUXZ1ZjQ4RTB1WVVJ?=
 =?utf-8?B?bUFsQ2R0bWlmOTJtbDdlL1FhRHRwMVJUd3pvek00aCtUbDJlckZVeHl1b05r?=
 =?utf-8?B?TTVTNG9ycGFRb0IwZTMybUhINlFhOTQ0eGZRZUlCa2xrWlRoY0tPM2Y3QXcx?=
 =?utf-8?B?MzhCbG05SXlFSDlpTUp5UTlnb2l1dU40L2lFOXZPOHRIZklMWHFIOUI1eGdk?=
 =?utf-8?B?Mk5QWE5uM2tUREZmOXZ2U3M0ZEtNcStoaHEwMkw0eE95VmJkQ1JGNEpNK3J5?=
 =?utf-8?B?aU9kZDd5V2lJNTVyMGhLY0FpSkFXOHl2MFAyZThwTnpSRkxJbFFEcXA5d1NM?=
 =?utf-8?B?Vm5yM0gzZ3F5U3hMbG11eUVYUmkxTG5rWHhoaXJDcndVUm1lcEFJeTluZFhy?=
 =?utf-8?B?aXNpWTFGc2ZRVEF2L0djTFJPMHBWcnRDellRNXMvMHhyN01tRUgyUEFDRnRr?=
 =?utf-8?B?MGFFZk5ieGZwN0JSNlBJY3lTazBrZXorMitzRkNxanNVOTllUkJpLzhpaGcr?=
 =?utf-8?B?QmJDWFBkU2R4MEdDMGt5ZHhEZnJBPT0=?=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zo8FVjB64YZpED6TnZkmdMRxUOqofV5+bjv1Lqj6xiFfJ+8gg1dysp2w+3+gQro2AI+7CcAtMcPuxC5qrBPnIUa1usQ3PWcZDb1SYdyoNg14HrwwOUg2SjF2yNRa7rsrWWnqZIW+5jY7L2KiaElhAsLfinLOqjgH505lvElR9EfSJvOGhZQTHuZLiTWSZ7AT2E8o1PLaDqmiolWUWXpJeACA6s55fPQC0CosiEeqnaqZxKvLbWRf3yzNwgoreDsuIX5uuDfyEp6cspWDLfBfpeXKFHR6QhjVwjbyThlqo2t92OcKDSl33B3MR1q4FMduKSQCXyk3rBOrIRYGjDyqdt3qsFdOdCwjQCuMn1QjBQOOPIE3Di5I0X8pOWzdyEuFx6djV3YJ2TmWZ3rYmWVOX1QFOQky2F1Klj0zY0u8V0s3hyjE1VOkwS9mTxZlsv2VU0YXU9xHhyhY0tG9nlCbggQO+FEQq2FVXF/AO5tp2V67371MpcLcInkZwRQTfdMo1Cf5Ig9ICvotF81kmRJNotdnrd8ZZl3M99ep7RqgSmsOuN6I52URsG5/li/qnG2gCiGQt1qHodKd6vWVVVKvfHU3atqdyW5NRZ0mT4hZQ1vV2yXTQ11hXoTCRD80Q+v6HttmTKmCcri5x/UDNwNNUiFORhDteLGD9kzBwIB4kg7XjFKJlXe0Tz3YUAq9YLzd
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 08:20:25.7770 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6bae2e-a6ba-4228-ef33-08de5733993a
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000A7DE.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5930
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



On 12/7/25 21:09, Raphael Gallais-Pou wrote:
> Add the compatible "rocktech,rk043fn48h" for simple-panel driver.
> 
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> ---
> This patch has been tested on stm32mp135f-dk board.
> ---
>  drivers/video/simple_panel.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/video/simple_panel.c b/drivers/video/simple_panel.c
> index 0f23df701bc3..d3a58c883883 100644
> --- a/drivers/video/simple_panel.c
> +++ b/drivers/video/simple_panel.c
> @@ -201,6 +201,8 @@ static const struct udevice_id simple_panel_ids[] = {
>  	{ .compatible = "boe,nv101wxmn51" },
>  	{ .compatible = "panasonic,vvx10f004b00",
>  	  .data = (ulong)&panasonic_vvx10f004b00 },
> +	{ .compatible = "rocktech,rk043fn48h" },
> +

unneeded blank line

With this fix:
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice

>  	{ }
>  };
>  
> 
> ---
> base-commit: c7c2c3c0101f625c01bf101d652e03a6d4aa950f
> change-id: 20251207-simple_panel-1a910ee5175d
> 
> Best regards,




