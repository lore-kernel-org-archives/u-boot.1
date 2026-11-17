Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF1A606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 06:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nniRehYK;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=i4fCVBml
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 67B5180FC6;
	Tue, 17 Nov 2026 06:52:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EJMrH4Ny-NGH; Tue, 17 Nov 2026 06:52:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B093D80E8D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794898367;
	b=mANMRHu4E4ech1JkgDU5TAcBIIl1i+jfTZuxpWOGSOSPS6x/hfklchy5oFkPpYBJXcKb
	 5WP0sHDaPlB4aWFhIe3OMFY5oFLT6fvNotznkSUNtp/UedAuAAcWZXEGqhkk8wxHa5j1N
	 p6D5ysQaYiPJRLPboEFi8uNqfM2hWN8EgojCmmtSRuEx6BGJCt2sWRCr6Jiy0prHshQgL
	 2xM+Kn2Dol1ZA6BcnVnK3AJXqw/sxwbODHpp1+5tBgjJistC4PLVQFKdi+aRSD5mzJpzw
	 VjDkAM6bZUFWt2pySDC4fzEE2k8KcNZ3rt/FFS8XuPovuLH0MIwavZd1UZlso+Zm3sA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794898367;
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
	bh=Ag/0e8kFbme8M4fFSWi1cyBVZ6eEXJVJESHfl7iMQWo=;
	b=CDXEY0/XWjp6XJ5bKah8IhKqknxYFntZMSDbLj/B2mKL55DAK3fAmwD1r7mV2kxM1Z7g
	 M4+ZpoioZKuZxXEPx8cF+mFZWVuxkq64Wud4ediIsKTIFyJJeujpKnBwV/a4iu//S3UjX
	 nAe/N/LEQmjTAgbZRekD/1pO85/EOSjIwsB5vzacCBua5uwnvc7iKZJIFw8J/ekFl8bOw
	 LbFDQbo/AxnCW7Rk+kz4YgtkMWlFW8Td3p4Df7fPQM/mksXqwZ1Q8wqwhNvdDSxdl3Aso
	 xnN2BIoBaBewbnp8+Vkdzz9uuCRVeDIH8QRD0uOHFlBLsk4HTQQj+273fJpQMkd4BGQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794898367;
	bh=Ag/0e8kFbme8M4fFSWi1cyBVZ6eEXJVJESHfl7iMQWo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nniRehYK5OCu3btZ4t92Fx/gPZAMlwY3Dd3HdCtwn/LTgtsvRbmlvUufl8eDFsuWU
	 VAtIB7WGqhRxHK2TeXYHjRq+OIiaJ7mx62vuDXQ361yE9ko13v/01yy7Y1sFjtProu
	 08cNFny3pFY1vv4zaC9tFLxu0RLIY1DdVNvfsSNppEz2XMybesbPEAENyQt/NgrzDc
	 JNzpvJj3YRQQN/33ALacKZAjc7mjPXK6eaoz/WlzI5J4KovBgGCKfPVILKgSeF5xJ9
	 nvQ5z/FgCCwzFCEkQuR74alieeUy3ftariplwzRdvPwkIWI5pgCOaOoDxe4RuxXvl9
	 Np+xgIeLBt4Kw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B093D80E8D;
	Tue, 17 Nov 2026 06:52:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 29A99260
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 06:52:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 06E7160828
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 06:52:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U-Uzo9VcYl3w for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 06:52:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4B02960774
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=i4fCVBml
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4B02960774
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 06:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ag/0e8kFbme8M4fFSWi1cyBVZ6eEXJVJESHfl7iMQWo=;
 b=i4fCVBmlVS/fmZW+kC1KFuXtsnI8CK8GvkGyxYwZLhDDanUA+IaFU8KXiuIIKuQSBQCNIOQ8tYC6dalfcchqDuD47YzYLnuloB5va8tmhBcJIGNqAsLldhS4n0zZ1DnDLbOFI3MNlUuGqMeNy7k9sScFk6FHjbQgGrKnNtN2yhpexA0m3B729v0qPXI2d2/TBuotbjNxfUS78Dhx84yU/SloSpIQ1T1X2a/uKmSbu5EUU13ht8ZTM8ip5MmKXJn4XJMs5Z+IJjZTOYhsV151Eh5eQxUK0Su8O0slGeLcMhF7vlrJ0Wol+SL0IX50N4/GrlkAYYdpaD6Eeh9M7o6j0A==
Received: from GV2PEPF00046837.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::332) by PA3PR10MB9258.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:4d7::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Tue, 17 Nov
 2026 06:52:38 +0000
Received: from WA1PEPF00009B3D.eurprd05.prod.outlook.com (2603:10a6:1d8::11b)
 by GV2PEPF00046837.outlook.office365.com (2603:10a6:158:400::332)
 with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.21.615.13 via Frontend Transport; Tue, 17 Nov 2026 06:52:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 WA1PEPF00009B3D.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 06:52:38 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 17 Nov
 2026 07:53:38 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 17 Nov
 2026 07:52:37 +0100
Message-ID: <1fbb3c04-1296-4264-affa-fd4f284f17bb@foss.st.com>
Date: Tue, 17 Nov 2026 07:52:36 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/20] clk: stm32f: Constify driver ops
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 <u-boot@lists.u-boot-project.org>
CC: Lukasz Majewski <lukma@nabladev.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
 <20261116173546.3487841-13-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20261116173546.3487841-13-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: WA1PEPF00009B3D:EE_|PA3PR10MB9258:EE_
X-MS-Office365-Filtering-Correlation-Id: 04ae2c28-6c0a-47f2-9e45-08df44775e25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|18002099003|22082099003|4143699003|11063799006|10067099003|56012099006|261026140227099003|261022105027099003|261028144727099003|261102123227099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: bBEayLz03e5DF+qpdFmnXkpp+kovyq8Li7isvvXMbL82+1IUF6cDu9Sn+vyckWC2XrlWudek8KkQ+pfvqL8rM4rAjBqzWJS2enkAmGfBif6bZjp7uogpocFImbML7Ux2C8EgqHf1/GguiRsmwTMAWGU95MhD07Vzw4KxPDXUe/Qz0FuNpKUgPQlBU7DQoORLY92erhInb8ADtXCx909qmlTkzMowvcMSNi+oIJTkNvJOfJSBpzsjOfwuyPuzAX4ED25uSdYu1AengpYgUBmQpSZ/FdJKgSVLrlH17bweIBNAQQOoUriuFQXTwQsEr3kz1YzHgUbSd/J98Aem9JETx3IuzehDUlKUMZhHMuOsDceGnk0pIOargq/vH+vKLVsrDhwKmXHgztxvqcEUa7HNp5SaAGHWcv9ahmXY7snd10M0IiFYTv/afGz4Jgamlh6lzazSLSho2bmHIKnheJk5jPbjRfvxKVqyLt2lQwtxMDAplFoIsbScIYrQfPqYNI55r0bYfh/b9SFKmNmk0rSL9OwSw8AT08jQ5xH6uMxKHp1Haj5i7J0jsjwOnG+4JrNA+OlSMmLE+0AGRdXlX6k4CzeyFI+7zdcp1Y7GzYXDTMu0tQicSKYEY0OloLlt2JIMMQKRgWk190YD93M3TbqgwZROwvHhCB71SOzNNQClN4mzfv0U55mnqJZNR+AIRoL6bBy4vbbBuBAFp0bEi7Ci2w==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(10067099003)(56012099006)(261026140227099003)(261022105027099003)(261028144727099003)(261102123227099003)(261021123027099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kDEsSan6k1opKc8kqxqAusxUY2yix/sWDH2Bdk5P2p6bC6ATKBbgdXl41TgrSvzWn3e5GlH5iP8pa1Dgs8YhN80ZlJE/QJajwan1hpiXOAomyjrYPl39RqNpcTYwbbwY2Z1kDMvIcLIrawlrGEDSNHB67yzDHz78vwQRZbVvyOlzvKuf93czydDauaMZ6VrYB0Ja1KRX76IajNpA7FHzYIPZovHr6fIUCcFg+mzYVtxLbpYAv6p4ZGg3D34KfNKR+wbtu0p9A5QHyQYL/YWUtNj8bYAtOVmKkEhRxnBcGE05GeFVqvuzkZiAVly7oIEI/6m/El0n1GwWdHK6MDOAA7T9e7hDLMm2cNA4CoW95MH7Ocr32M1lTo8Q1DJsVISGettbCyNS4xexPGmhK7nzqqPK6y57jLvjbf8ujpuZsCMU7GhVnLOjgICvAwDxtYtj
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 06:52:38.0040 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ae2c28-6c0a-47f2-9e45-08df44775e25
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: WA1PEPF00009B3D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9258
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



On 11/16/26 18:34, Marek Vasut wrote:
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Lukasz Majewski <lukma@nabladev.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.u-boot-project.org
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
>  drivers/clk/stm32/clk-stm32f.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/stm32/clk-stm32f.c b/drivers/clk/stm32/clk-stm32f.c
> index fceb3c44b94..0964e0b1617 100644
> --- a/drivers/clk/stm32/clk-stm32f.c
> +++ b/drivers/clk/stm32/clk-stm32f.c
> @@ -717,7 +717,7 @@ static int stm32_clk_of_xlate(struct clk *clk, struct ofnode_phandle_args *args)
>  	return 0;
>  }
>  
> -static struct clk_ops stm32_clk_ops = {
> +static const struct clk_ops stm32_clk_ops = {
>  	.of_xlate	= stm32_clk_of_xlate,
>  	.enable		= stm32_clk_enable,
>  	.get_rate	= stm32_clk_get_rate,

Hi Marek

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
