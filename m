Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29482606A33F
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 18:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=h9Fk8g5Z;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=M1HMvtVH
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0623B4092B;
	Fri,  6 Nov 2026 18:17:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u8_cwRI4UYuk; Fri,  6 Nov 2026 18:17:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3800E408EE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793989025;
	b=jzVqpTnWFbcCgXUg8HXAVkCM/HZRy/kaimVuYk9EKepgRCJs8WXmoAClDFoN2OAdpqex
	 prvoFkM/RwPK5ickWBmBIO2uW+A17Aa0jo8ja7wUhWMz25uqGkzaF6HRMlCAJilkWcAku
	 GgPITsjTZ8RaH7o1MWunKfLjgLM7LXdl2BzXw4F8uce7ShOov/3YjRyTOPwu/8/KB7BEw
	 fRsmQysk4evVfC9gZMWeSHngZKcL8l6tzKF2bNG+aYY8qVaEOQoLFCpIesb5Blux0TVS1
	 4fYlPuZRwaBvnxBhWZ30dCxwv2gDH99LluGvJKhF3RgVCoqrFjPDdxvdG9mFVsVJk7A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793989025;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Ix4J6SAa8aUP5c5epyvnFt8PRdxk9VrbFBhipa50qDA=;
	b=l91gedAc8ngVQeFFkTc+YmONCM0VYE1bC8i/mjQpgCj7oVVVXkH1CZb91HKcE58krUhN
	 kGvjQL93JZ5EYkT3zk3yVRT+cQzJqFEu2A/dgz6A3CdexbQ42BjKaNFS8VXn+tirJXkZj
	 csUpYeUIAO0zRGV94FVu8CShMXTmMjfMuC8HawALa53fCLZBIBt2wTuKvdmIFz6GG9427
	 5chWtrTDPZpkDlG9dVWEZN3oeMYfCY+E6kQMtKKPVhRSWYSFma/voT7sve+puUyuYquhK
	 EbZMqArTpuLJBwlnqxl/DaEK0+6D6aOha4LWtxeXEwP3DUdGF0dUtISZrSv6qipC7MA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=M1HMvtVH;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793989025;
	bh=Ix4J6SAa8aUP5c5epyvnFt8PRdxk9VrbFBhipa50qDA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h9Fk8g5ZusZWkDHarSLUCKXszcOrHI3Mx89fppVFGVp5yxoUs1nuKOLdrTgRJkpz3
	 HV+nfsDwb7P42RgnWxJxUMm8A18Yiof2vW76lTnYGoh5yPTw5Y7j/apLzAG0+wPTmn
	 DKk1/pvl/vuQugwwbSMq0gyC+oDJKFfqSQN0dSI7SKvks58v3djmZofG9/1DHXPr3J
	 MlnR4csNcJK7PhZOBXdRhG6UDcrwt/REnPlvyaOfRrR4CdA9rCFri1W+bhsT/6gwGI
	 4mqmKEPNA8aSkc7qIxSGwy7o48V/M7ZeP03XKl3zEc98/YXq6lad2AS7UhGH3fC13s
	 nZCfLE6zJTj1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3800E408EE;
	Fri,  6 Nov 2026 18:17:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 18394235
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:17:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EACB4408EE
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:17:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TAsnBBf9H3Mf for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 18:17:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C8F0C408E0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=patrick.delaunay@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=M1HMvtVH
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C8F0C408E0
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ix4J6SAa8aUP5c5epyvnFt8PRdxk9VrbFBhipa50qDA=;
 b=M1HMvtVHUdgf7ACJWeg8E2w5imXY9JL46iuSSXIANf7JBvx6UbCpCiGeXprTH6wEjDrfV++1x7OjUxJRJUVmhgktgbN1jV7iz92lyAE/70Abudeu+e+E8zh4GIabdnJ8y8ab1YUfgMc0TlhswrZxzgYSOP0TSM0LJwdSjL6b+41lX0cZaYdJL+2WlvTtldn14gaXjuSfoUH4zAu4USSdjKwP8bNO2cjYY8JFrD0bNPsQwkgEKA1mu/Eg/mAPXy51MdnO1ANYwQU/B5yb3czYf/UZmPUdRz34+pgjDQR5YhD/0x+r/tN74hVdnUjgLBMESLtS4qBbW2IjFthqZmybIA==
Received: from GV3P280CA0090.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:a::31) by
 PA2PR10MB8874.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:421::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.4; Fri, 6 Nov 2026
 18:16:55 +0000
Received: from WA1PEPF00009B3D.eurprd05.prod.outlook.com
 (2603:10a6:150:a:cafe::82) by GV3P280CA0090.outlook.office365.com
 (2603:10a6:150:a::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 18:16:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 WA1PEPF00009B3D.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 18:16:54 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 19:17:24 +0100
Received: from [10.48.87.100] (10.48.87.100) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 19:16:52 +0100
Message-ID: <a947daf0-dd16-427b-849f-cc89755cacbd@foss.st.com>
Date: Fri, 6 Nov 2026 19:16:53 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] gpio: stm32_gpio: flag secured pin as protected
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Antonio Borneo
 <antonio.borneo@foss.st.com>, Fabien Dessenne <fabien.dessenne@foss.st.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>, Vincent Jardin
 <vjardin@free.fr>, Pranav Sanwal <pranav.sanwal@amd.com>, Simon Glass
 <sjg@chromium.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20261106-upstream_pinctrl_update-v1-0-4f3d4f6e97fc@foss.st.com>
 <20261106-upstream_pinctrl_update-v1-2-4f3d4f6e97fc@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20261106-upstream_pinctrl_update-v1-2-4f3d4f6e97fc@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: WA1PEPF00009B3D:EE_|PA2PR10MB8874:EE_
X-MS-Office365-Filtering-Correlation-Id: 607b3c4a-f893-4f42-ad85-08df3c3222f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|18002099003|22082099003|261022105027099003|4143699003|11063799006|56012099006|261026140227099003|261009221227099003|261009220027099003|261009221727099003|261009223327099003|261009223027099003|261028144727099003|261021123027099003|261021121427099003|261102123227099003|10067099003|41080700001;
X-Microsoft-Antispam-Message-Info: MIsJmKdCglpxXE7XGj+i9Sd56k+ky6iTF8kpXv6sV+VOr+Rec6oieYduSRtWxN1IryGkSeqedf1ruCV3Vo2fTIjxxOPleNOOjNG6M5oNnYVczOQQ/Jn8ZgUJHDsRh4SUHPSpbmOE91rbpzXHU/pDG1DWOgWwwlb3YYVPvDGL3sh7IItqJPJuZG3St9OX6j8hESUlk+DmkxK97QhDtPEHeulBCvJcPvKtY1in2JOYOQlRFiZ286TddQVjZBCFFugPvNp3kHR/sul6as4aYkXhs9DhIrzi1XwM5bK6PKPuXgsyw1rXKPZ0IXzQx9WQNjWGf2FAfUwG+ZrYTzQwuF17JgDYTTiam1IxhYJkvyUeWivRVGZ6nFOfLPmiTxN8TfSfMEIlwZUUGtPtpJY8R8uI2VlH2+o/KMOU+adc50jQG3LIKumoPj0A51c25s8dn+fJLwPll/hs6QSfvi8SIqJrTOWfxPO/s8O4btn2kPIslt/Q8aoaiG+MP2TxhXO1NbPu3IA1JquScx9Be+uiK9whQJEJrEDZI9a1EUwa6RCoU5gJm10j/Tqlzc9niD0yCzdoIBZk86028Y0yzEikcCW9dJv0DxpKhxOvSQPvG8TKiYBaCtPsufFCeG6xigArEcptknpwU5rW21FdHaKNj5dYYDZUHkT7tmXKfRKqO8ak6ITLO2nu7Pnq6EFjOSzXHX2o7qLIIUu6o0PvjHJQHLK4dFxq0Wf2vOzCWS128G4FRY1ySCXZUGJ4xadFaQZ73Q0q7JTq74KrI4x2iSDtx/wO5Q==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(18002099003)(22082099003)(261022105027099003)(4143699003)(11063799006)(56012099006)(261026140227099003)(261009221227099003)(261009220027099003)(261009221727099003)(261009223327099003)(261009223027099003)(261028144727099003)(261021123027099003)(261021121427099003)(261102123227099003)(10067099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oSAxXpt31QKnTHLjx+EGkD+IJrVza5980unmsO2FJL3OQ0FIdo/OTf10rN0TRFhitHGkt3twpLzr19OOIan9kvdu1Ut44k9KIsD/ui7ARgp7JVcHJu8ZLTyczPPdf1r7v6LpBGC+HU0E2tsOURC8i65dWRcGFSDW0Fdxtz3WIF6b+umo5VcxdFradLgaVFiD+cCbPwc9+14wnHQzZiJ/0zW69IGJN0PZeCjehoHFEcDwP2o5qmLWQ+uBU47DV2kowUIvAFo0k/8IfWG2rQUGZmZlqd+seBdE9a3BLuE+G82ENpqkn6b5AMW4QhyruP6hSLJ2ryRFxl4K1v0fQp6OK+5tLSLiurCY3s/1ipwDFxDGIQljF4sQ0dICZU6Bp9Ny/caN/goPkvKfnT9YLQRpPCyc0GfFCvG2Z1mYDUuy6c8svrwwlLmjDHAZecVAXY80
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 18:16:54.1079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 607b3c4a-f893-4f42-ad85-08df3c3222f2
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: WA1PEPF00009B3D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8874
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 11/6/26 12:18, Patrice Chotard wrote:
> From: Fabien Dessenne <fabien.dessenne@foss.st.com>
>
> When a GPIO is secure-protected, it can't be accessed from U-Boot.
> In that case, set its 'function' to GPIOF_PROTECTED.
> This makes the "gpio status" command returning the "protected" status.
>
> Example with GPIOA6 pin secure-protected on STM32MP135F-DK:
>
>> gpio status -a
> Bank GPIOA:
> GPIOA0: unused: 0 [ ]
> GPIOA1: func
> ...
> GPIOA6: protected
> ...
>
> Signed-off-by: Fabien Dessenne <fabien.dessenne@foss.st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>   drivers/gpio/gpio-uclass.c | 1 +
>   drivers/gpio/stm32_gpio.c  | 6 ++++++
>   include/asm-generic/gpio.h | 1 +
>   3 files changed, 8 insertions(+)
>
> diff --git a/drivers/gpio/gpio-uclass.c b/drivers/gpio/gpio-uclass.c
> index 33eaf2a2022..8567e8493fc 100644
> --- a/drivers/gpio/gpio-uclass.c
> +++ b/drivers/gpio/gpio-uclass.c
> @@ -867,6 +867,7 @@ static const char * const gpio_function[GPIOF_COUNT] = {
>   	"unused",
>   	"unknown",
>   	"func",
> +	"protected",
>   };
>   
>   static int get_function(struct udevice *dev, int offset, bool skip_unused,
> diff --git a/drivers/gpio/stm32_gpio.c b/drivers/gpio/stm32_gpio.c
> index e354a4148ca..77bafe18ef9 100644
> --- a/drivers/gpio/stm32_gpio.c
> +++ b/drivers/gpio/stm32_gpio.c
> @@ -170,6 +170,7 @@ static int stm32_gpio_get_function(struct udevice *dev, unsigned int offset)
>   {
>   	struct stm32_gpio_priv *priv = dev_get_priv(dev);
>   	struct stm32_gpio_regs *regs = priv->regs;
> +	ulong drv_data = dev_get_driver_data(dev);
>   	int bits_index;
>   	int mask;
>   	u32 mode;
> @@ -177,6 +178,11 @@ static int stm32_gpio_get_function(struct udevice *dev, unsigned int offset)
>   	if (!stm32_gpio_is_mapped(dev, offset))
>   		return GPIOF_UNKNOWN;
>   
> +	/* Return 'protected' if the IO is secured */
> +	if ((drv_data & STM32_GPIO_FLAG_SEC_CTRL) &&
> +	    ((readl(&regs->seccfgr) >> SECCFG_BITS(offset)) & SECCFG_MSK))
> +		return GPIOF_PROTECTED;
> +
>   	bits_index = MODE_BITS(offset);
>   	mask = MODE_BITS_MASK << bits_index;
>   
> diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
> index 8229a5faac1..9e2d88cad26 100644
> --- a/include/asm-generic/gpio.h
> +++ b/include/asm-generic/gpio.h
> @@ -110,6 +110,7 @@ enum gpio_func_t {
>   	GPIOF_UNUSED,		/* Not claimed */
>   	GPIOF_UNKNOWN,		/* Not known */
>   	GPIOF_FUNC,		/* Not used as a GPIO */
> +	GPIOF_PROTECTED,	/* Protected access */
>   
>   	GPIOF_COUNT,
>   };
>

Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick



