Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85377606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 16:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uhoGWXln;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=ZIop5RRI
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 607FE80FB9;
	Mon, 16 Nov 2026 16:36:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qh57Eu5vyTSs; Mon, 16 Nov 2026 16:36:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 91D4280EB3
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794847017;
	b=TL/pmeNaPEXJODIm3usYSUR7oOU/t9v2KTfkTM95oDyUHaR+s3Cpt9daA1DstFIZ1zwO
	 3do16ZSKSlsskwFiU/R3R3/zO47kaR9dvLwT9MrHhYH/Nz8lgV35wHeMEQLukvLEMsNI4
	 9iEMPzbe1p6vg2MVoQQuwzRjr1wGTPkO0MfZsEwrX/P0NrFoJ2ZZMPoXmeKipPi0fSLKs
	 27dEEGh7ovqxMh5in04dMjItfh8MMLNKiz2UHvZPRQWwHjMRyv2HZStMyF43Bagjh93ar
	 UFE0EB82RWbNn82rJDN8KA8b6cX2QIkrjSzF2facabvyHrOb1dWQaSol0/Jb8FT6/bg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794847017;
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
	bh=Xs9ChoE6Zxvoki1LNuAqg3pM9XVd1FPuM31rc8zrwps=;
	b=PhkUpKJbVCytI9YfByGxJqfYwcKa2DxTCWlFo5A7KpujTCPLBj0Xp+OQFxISFmWT6ZOx
	 Khn9H84c/eUaVJFZZ/9NDTL3Sa9Itt4fk1qZbjFb6QkT5F5BBoFApE78exCS2CD6ZhCGX
	 FJbgitASIH2Rld9wYarfv/kWuH4uEc8JGcyIW8uu2a0pvUG9hTvI92HJ9jbkynvMJMOpK
	 KK2nlt7LYyB+dFkMJGPPqKYO67W+GGm4pMaVPN+ehSJqVWpSe/2ZFe9tgK3D0vZlZA4+M
	 pwTttpXoGu0dfnqyAvLg3AsyRlxLH944+87CNx/8fACzfVXHbgCDcl5HhNLlYiXHh0A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794847017;
	bh=Xs9ChoE6Zxvoki1LNuAqg3pM9XVd1FPuM31rc8zrwps=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uhoGWXlnUb6NzDowOD5XFUPNnsh6wQRD7IPs6Jpn/mt6U3kymMxhruRFMcezfkZuH
	 JqTxFTeRPwzBZRKuFUzx/m3wBXtftD6pGAxGC15yg4t1V+fdoAhz8Isk7To5b/swFs
	 QzeEtqx3qY/lNTk16SsLvhi5v4J2k4q9TMU+14BBiXdD4RLWGIAa88Vw1oEnKAaSfE
	 32FNTnkJABmq9gy8tGp8Odt3yDU+2id26IC7xV6OPb4T7ht6kfdvx+g3xpFvBtOMeK
	 p+qzCOlTLlmTexT9fyddLG0hgyhCXlPvSV91QyBVCKBP95KB1Ec4flU0JVIFpMC08g
	 kiJOKo5Wqlm2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 91D4280EB3;
	Mon, 16 Nov 2026 16:36:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D893E169
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:36:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BE4AA40282
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:36:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j_iovGMBo17o for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 16:36:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2FF2A4009E
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=ZIop5RRI
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2FF2A4009E
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xs9ChoE6Zxvoki1LNuAqg3pM9XVd1FPuM31rc8zrwps=;
 b=ZIop5RRIZk9YTPyHmp21VQTviAVK0yg1gYkoOoehRmEdb7+2JZfhdxkwEL0Q7tMQuWhyBRrLPNkl3oM3bFvtw864MYk8bYgWLjgvFp9VvJSae+sQ81syPDq8j33WEFiKF9rsxh3Zx+rIZUVFroJAEzRz0+nt46OxIn+amRQpEcILkdiBOzKWiNKbrtEJIcBuFyzxMX+pPRrfLZnLApRXOv3lPXyxVccXQUJ7S1TaCVZOoSDypYcmkWU2XN7tblKO1Ff1b/xsaDYeSnNb8TJlcXZHXbfJypsrS5A1o9OfHVKzc9/gLJfvarFn9svVQuu92GjLD40WItQE1QRldX//hA==
Received: from AS9PR05CA0356.eurprd05.prod.outlook.com (2603:10a6:20b:490::22)
 by VI1PR10MB3472.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:136::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Mon, 16 Nov
 2026 16:36:46 +0000
Received: from AMS0EPF00000569.eurprd02.prod.outlook.com
 (2603:10a6:20b:490:cafe::40) by AS9PR05CA0356.outlook.office365.com
 (2603:10a6:20b:490::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Mon,
 16 Nov 2026 16:36:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS0EPF00000569.mail.protection.outlook.com (10.167.242.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 16:36:46 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 17:37:46 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 17:36:45 +0100
Message-ID: <871c7b7c-d419-4f1a-be9c-e53c1a9bcc37@foss.st.com>
Date: Mon, 16 Nov 2026 17:36:44 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 34/35] board: engicam: stm32mp2: support FWU A/B bank
 bootup
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>
CC: <michael@amarulasolutions.com>, <linux-amarula@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, <u-boot@lists.u-boot-project.org>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
 <20261107143241.2236511-35-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20261107143241.2236511-35-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000569:EE_|VI1PR10MB3472:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a708039-425a-4225-0061-08df43ffce2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|18002099003|22082099003|6133799003|261009223027099003|11063799006|56012099006|260925021311599003|260925022911599003|260925021911599003|10067099003|4143699003|261102123227099003|261022115727099003|261026140227099003|261028144727099003|261021123027099003|261022105027099003|261022075727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: AiKeBWKnhlo4tvhm8xhe4Qehv5LduhlIMsawAqf1qJRrwZT+QAwK3HuhZXLwBpAAb+8PWifkl9YZeSwFxM7xtYjzPkg+A7qV686z+F4lLQWQGWx7pjogVi6jqzwpk+xW0IsYI1x2dRXrM+tfluHtfrKmQZBeH2R0Q2sngU1a353x/jqDnSXq0+ODcOdlm69JjcsVOjFzGxsb52klqyMUfX9UxxyWVwA6XDUsR+w7GpE+sdQTbkd5PgckRI+1exPMLueWfN1asV1PDshNpgrSQUMmKsFPVYpL52n/fftqa83O13Pr8nJegFu5/TTtWsOZPprcnhgQ076xoeVo3Aj9vvm2l+wLYxTAY0jWku4JKgjf/0U2nkHIxw6WPcmTE/Tec7J97KZCXMbbSUNvamHp7lZBB3BeLPvXICnfnKrnF3K1VZ/fz0RB5zsvu2YU4mqrDc0lZlr+Yu+gdgrYjYaHtLgTwbroDwPnTGE+slnMPrajMwtWkhE0zlppaGS107Fl6BdrpWBQyV0gEysL4ZvxGBylFdXiO/W9tM8e5V8NqtX0K2+HI/4HcIQrGFdff1TLzfUkp63rzga0jK7ub2TPtzdaqB4KA+ikZmmXuBTRzlk51sIvmCNfMict+069CvtXnmOeoVgBmPp7WRU05BOaQWHw1BmrcRsspVTuB/MlX7Q9+GWLSN5FOs+znD5oJyJelaC3Z5qCsOf7JA7kHAk39Q==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(6133799003)(261009223027099003)(11063799006)(56012099006)(260925021311599003)(260925022911599003)(260925021911599003)(10067099003)(4143699003)(261102123227099003)(261022115727099003)(261026140227099003)(261028144727099003)(261021123027099003)(261022105027099003)(261022075727099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6XJ4NUpvjtaM3yrdZZa9XvildU+T68Nv38yltMExb5g9sVV3SSbCVlIbo0PUsDWX4lResi1Ojta8MxLE2GZm2otxyCQxHzlqdlb5Z7QiZi+49Oq/F1u79R3Rr48oEK2EX9lh4RG0PBh90eVQiVeqhDaakd6VqvVIkgQsps28D0Ud0OAehfFGEI57qjHYlpqz5wyCrKAXpNAL3rkd2VozvmfDCX4FoJDvvP3agEmM4gVU8uj+iwvcFLmCrbBEN163iSJT5V9OUQ9DRggAdG0l2Vo200YjRfpxrfWKy/FZxAGPsJEABkagYoFOFqMbUxWP29SpENRXFI32Prxw30AkXNTiSzEOni7Fk/nYeJZjzVvh53KwljgyZ1pUPiNxN9AUAiqGvx2XsugnyWaAN5JZcTXLbPDL9ABVDnGL2hsRRNusIlUe71NYFgGaYTuRYkBI
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 16:36:46.3880 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a708039-425a-4225-0061-08df43ffce2e
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000569.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3472
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
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/7/26 15:32, Dario Binacchi wrote:
> Enable the FWU multi-bank update. The FWU metadata are stored in the
> boot device, so point the "fwu-mdata-store" property to it at runtime.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> 
> (no changes since v1)
> 
>  ...m32mp257d-engicam-microgea-rmm-u-boot.dtsi |  6 +++
>  board/engicam/stm32mp2/stm32mp2.c             | 40 +++++++++++++++++++
>  configs/stm32mp25-microgea-rmm_defconfig      |  6 +++
>  3 files changed, 52 insertions(+)
> 
> diff --git a/arch/arm/dts/stm32mp257d-engicam-microgea-rmm-u-boot.dtsi b/arch/arm/dts/stm32mp257d-engicam-microgea-rmm-u-boot.dtsi
> index 8a3723baa116..3055d661d849 100644
> --- a/arch/arm/dts/stm32mp257d-engicam-microgea-rmm-u-boot.dtsi
> +++ b/arch/arm/dts/stm32mp257d-engicam-microgea-rmm-u-boot.dtsi
> @@ -10,6 +10,12 @@
>  	config {
>  		u-boot,mmc-env-partition = "u-boot-env";
>  	};
> +
> +	/* moved to the eMMC, when booting from it, by board_fix_fdt() */
> +	fwu-mdata {
> +		compatible = "u-boot,fwu-mdata-gpt";
> +		fwu-mdata-store = <&sdmmc1>;
> +	};
>  };
>  
>  &ltdc {
> diff --git a/board/engicam/stm32mp2/stm32mp2.c b/board/engicam/stm32mp2/stm32mp2.c
> index 64317f271ed7..e15141677775 100644
> --- a/board/engicam/stm32mp2/stm32mp2.c
> +++ b/board/engicam/stm32mp2/stm32mp2.c
> @@ -12,6 +12,7 @@
>  #include <env.h>
>  #include <event.h>
>  #include <extension_board.h>
> +#include <fdt_support.h>
>  #include <log.h>
>  #include <splash.h>
>  #include <asm/arch/stm32.h>
> @@ -217,6 +218,45 @@ int splash_screen_prepare(void)
>  }
>  #endif
>  
> +#if CONFIG_IS_ENABLED(OF_BOARD_FIXUP)
> +/*
> + * The FWU metadata are stored in the boot device, the SD card or the
> + * eMMC, so point the "fwu-mdata-store" property to it. The phandle is
> + * replaced in place, since the devicetree is already in use.
> + */
> +int board_fix_fdt(void *blob)
> +{
> +	u32 bootmode = get_bootmode();
> +	unsigned int instance = (bootmode & TAMP_BOOT_INSTANCE_MASK) - 1;
> +	int node, store;
> +	char alias[8];
> +	u32 phandle;
> +
> +	node = fdt_node_offset_by_compatible(blob, -1, "u-boot,fwu-mdata-gpt");
> +	if (node < 0)
> +		return 0;
> +
> +	switch (bootmode & TAMP_BOOT_DEVICE_MASK) {
> +	case BOOT_FLASH_SD:
> +	case BOOT_FLASH_EMMC:
> +		break;
> +	default:
> +		return 0;
> +	}
> +
> +	snprintf(alias, sizeof(alias), "mmc%u", instance);
> +	store = fdt_path_offset(blob, alias);
> +	if (store < 0)
> +		return store;
> +
> +	phandle = fdt_get_phandle(blob, store);
> +	if (!phandle)
> +		return -ENOENT;
> +
> +	return fdt_setprop_inplace_u32(blob, node, "fwu-mdata-store", phandle);
> +}
> +#endif
> +
>  int board_late_init(void)
>  {
>  	const char *fdt_compat;
> diff --git a/configs/stm32mp25-microgea-rmm_defconfig b/configs/stm32mp25-microgea-rmm_defconfig
> index 0f1b7db7abc8..73f8f7cf96b6 100644
> --- a/configs/stm32mp25-microgea-rmm_defconfig
> +++ b/configs/stm32mp25-microgea-rmm_defconfig
> @@ -14,10 +14,13 @@ CONFIG_CMD_STM32KEY=y
>  CONFIG_MFD_STM32_TIMERS=y
>  CONFIG_ENV_OFFSET_REDUND=0x940000
>  CONFIG_TARGET_MICROGEA_STM32MP257=y
> +CONFIG_FWU_NUM_IMAGES_PER_BANK=3
> +CONFIG_OF_BOARD_FIXUP=y
>  CONFIG_SYS_MEMTEST_START=0x84000000
>  CONFIG_SYS_MEMTEST_END=0x88000000
>  CONFIG_API=y
>  CONFIG_SYS_MMC_MAX_DEVICE=3
> +CONFIG_EFI_CAPSULE_ON_DISK=y
>  CONFIG_FIT=y
>  CONFIG_DISTRO_DEFAULTS=y
>  CONFIG_BOOTDELAY=1
> @@ -25,6 +28,7 @@ CONFIG_BOOTCOMMAND="run bootcmd_stm32mp"
>  # CONFIG_BOARD_INIT is not set
>  CONFIG_SYS_PROMPT="STM32MP> "
>  # CONFIG_CMD_BDI is not set
> +CONFIG_CMD_FWU_METADATA=y
>  CONFIG_CMD_BOOTZ=y
>  CONFIG_CMD_ADTIMG=y
>  # CONFIG_CMD_ELF is not set
> @@ -119,3 +123,5 @@ CONFIG_WDT_STM32MP=y
>  CONFIG_WDT_ARM_SMC=y
>  # CONFIG_UBIFS_SILENCE_DEBUG_DUMP is not set
>  CONFIG_ERRNO_STR=y
> +CONFIG_FWU_MULTI_BANK_UPDATE=y
> +CONFIG_FWU_MDATA_V2=y

Hi Dario

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
