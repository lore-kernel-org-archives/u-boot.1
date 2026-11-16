Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29846606A329
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 10:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oBA5V58K;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=fMPP6v59
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 038D2605F4;
	Mon, 16 Nov 2026 10:17:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UBR9gUoCl0Yr; Mon, 16 Nov 2026 10:17:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4BEBE60666
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794824235;
	b=AjJyKO21BMjVX9FX9GV23TAZgXWCVrClSu6NLJNYyvkcJGxa5PgRRIWF5WDO8VPRj78O
	 fdowlvYFmXsaff3JnAIsv0LzzyhaiS7sgNheKqx2oGWPK4mb5nlWJZeKRJYyqLYEyOKKZ
	 vFE4b4PUtS0FN8MF1eLVHyiS57iNeORyCbX/2dLN3gYR3wqhK2EEq+xLkmmuxT60PDyn/
	 2ulB1Y8RHFSZWp/6909sL2Eali7aAuJeJaO/rrrOrBTkLC8uIbGVheocxqrQ2mADmKeav
	 mW3EWFonTChC/4wOjH7XZnrjhYS5SgtP9y94kge3WS+iHkyYxrnkiV6IQheEgVIRARA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794824235;
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
	bh=Bs/Sr3yRAsOU2fiK249MmDVydEhT4NJ1Qns2TK9lC+g=;
	b=CB3QYhUse2D8RfaB9/GBEbkwcuzypEK9bnYalMNXrWAYWQbKgW2yzMTU2L4lgfKe+Mc1
	 aGzNdp/FftnEiCoQHC1TXLniul3huowY2wWy+j2pZxa1Q4BxKCQeVi+Eo61Q2PN4YxNxF
	 sFq2b7vspV4qsxarbH4/1NIbjGXQ05rFwltW11Mmr+xGuWxdE0Lqx3ESKLKRbRAI1LSpx
	 zHxupAryzBFjcrIQeXioa+rEXQbhBkSIm8XukJ5SRHUXG0a1/QAe7Q+gSkIql/iZvNgAv
	 1n5kMAZhZqhqXp4WrKbhtkq3Wkp3mH5aLiqnRLjLpZYe+nmbr+8qPa0Gt0xpLnFmD4Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794824235;
	bh=Bs/Sr3yRAsOU2fiK249MmDVydEhT4NJ1Qns2TK9lC+g=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oBA5V58K0uyTLQZrs01OIthiryfHVSVySw2molcbq0PPWXQafFhBElPSPZTSjRev7
	 X1UvOrHWKMnbcpag5d/NBnrrV6gLHvtBLbmlzJflTko4DF3M4FHRzNDA9wycEOQ14E
	 VQZ4s9tSpfcMSS8Uq2oq4gCF6gVpGueU6A8XUEsJctR/95e4N2x5LBBdlBbfi6+NUE
	 S4Mj8VL/cjXAmTETCjHzgA9OHKbLwJX8lPEcGxNAOBLpC/8vwKV4ZZqevmpn01FvI5
	 3bxdEr6NtKyYp0tanhWwQrZueoJE5YVzDpDfYQNChLmvsfFgQz6yieDqu5D/X4zQWO
	 aadeWrURgOL4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4BEBE60666;
	Mon, 16 Nov 2026 10:17:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7F2AA4DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:17:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 708CA400FB
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:17:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BC6sNbw25VBz for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 10:17:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8AD2C4009D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=fMPP6v59
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8AD2C4009D
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bs/Sr3yRAsOU2fiK249MmDVydEhT4NJ1Qns2TK9lC+g=;
 b=fMPP6v59vAS0PA9LQs2GCQFNA55m/1BcBf2UlmVWhUdRZPnGaFb+6ClNAQKF7Zx+rap0kXlvo6L6Ct6opu4ShVE9ETK4gZsPwF+Tnzuj9e0gi6Jjv1Eg8KOwks4MW+SzlhaUtgTI4YUdc3etaJxFP1Gfkh8bdt5H1Wb3917cXoP67yooUKvKecYtXz7Edo/4VRfsQBT/BzlFeL0FLVDy0xBxfPZ8sZQwBvlZeQtdx3n5ZsLBg/FMUGGtAkfgRUvSjIX2c07PDH3IZPNUEM48Vydit9Bm7ievk3uc6Ys0zZlqyAGKrzUrIdrldMbPYwIlsfJV2AEM7gqhcKtxk2IK/Q==
Received: from DUZPR01CA0182.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::16) by VI1PR10MB8229.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:1dd::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.4; Mon, 16 Nov
 2026 10:17:04 +0000
Received: from MA3PEPF00000405.eurprd04.prod.outlook.com
 (2603:10a6:10:4b3:cafe::14) by DUZPR01CA0182.outlook.office365.com
 (2603:10a6:10:4b3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Mon,
 16 Nov 2026 10:17:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MA3PEPF00000405.mail.protection.outlook.com (10.167.241.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 10:16:59 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 11:17:33 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 11:16:48 +0100
Message-ID: <872fafbf-e6ca-4544-abf9-1244049ff0e7@foss.st.com>
Date: Mon, 16 Nov 2026 11:16:48 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/35] clk: stm32: fix set_rate propagation for parent
 clocks
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>
CC: <michael@amarulasolutions.com>, <linux-amarula@amarulasolutions.com>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, Lukasz Majewski
 <lukma@nabladev.com>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.u-boot-project.org>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
 <20261107143241.2236511-21-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20261107143241.2236511-21-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA3PEPF00000405:EE_|VI1PR10MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: ac8b8c7d-c49c-401f-f6f1-08df43cac004
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|10067099003|4143699003|11063799006|56012099006|261026140227099003|261026121527099003|261028144727099003|261021123027099003|261022105027099003|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: OKVCgWEqLrN8ohE79XhvO8etWvQJEZSKLobc4hE/qa2cb+C7vEPo2uZgBM23auxZ3ISLyEgY4+l0Th8EaBxaFnMA42GKlvoT0UKONql12KS2EI+Spx9L+SOFUNbxXlar432v4zrhyruoLoguiGhL/W94ghOZ2rM1L9W/GuZZ5g4qcx91U3Az7IFPVzM4hjFcgeu4l5AQXp9dkUf4kXkLML9ZsUzNnG6owsuqAy1m6hzlHPUpRxc9Fu1Q5igEJuhs9tNWn5p5u7p0Nx7TFPcMx5M6eRed3agCmHpZLiBpD7K7waBIni8HjHJ+Dh7dcXslkVKpnsLwrOKAM5Ys5b0HFSqsY7G1Rg5lBdKWa5lYvYWy/Xcj+8rAyhddqFF0DzD60J/uerpuCNFygMEy+08OrLANUjbkzxzDjdYR4htwnOCW7VADRYu/PZW8MnHlZ0lXocvtATPnTKwaz02uW6YAXEOf7ZASEdIc50bXnWHWCoT+995CVb1Ekg9xa+LVfbfUQDE1iQ8t7eTq1GDzt/49lzjnQesA6Vgig9rpXB8xXayDlxbuosfjF5kNmfnA1AWWvqGxJOx8kcTTUrskrfdYMxUMkw3fRHOGOgbu4zwDzMQqy/DnpMiXoGEPIZpVhTjtT5lC6l51slAxe3qy/oTqQTWk0NCJ3TutSxtFGHSx3r5IKSMbFVqotB2t/1zqdTbX62bFihyaLrpNPsj1L4Wwug==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(10067099003)(4143699003)(11063799006)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261021123027099003)(261022105027099003)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XLDi1WuV9RaHy89tTN81KOVMRhTDvpwuRsOWKfy62GZLaZjoWRrRVdKdybevc/Bhi4YkBZzOUXYv66JNlGUMHGyYpEgyDHLwrRHbDyC/3sPrqWN/gWiTD7ldSLXtwslK5qIvk5xHjuUXes1unHNVZ5oJWukYfEwRw8Ns5OVRwk2nT6oWft/a8zrHG7abS+R/TQ+w/rR96Ib+xU13luJh6KDYW/oDdSrsqdNdBbaHlP+rO3qPsqiCue5xiI+aYRNLIenK27lEvkQn22a1RtVRXzdYz/RP/Oix6ZuFczA/V78SMq3u3fmcdpG7mJPJSLjYKeU7LqB3a6M/hT1W48dilmfYGg5MNIg7A7XniH10qMu5cqdSYjTw6OA8c9t8eIdfi4VyuET5KVYpd21ybr5DdGrd0SCzyj3o+U7howADuuNyB0QxxIMLeAgi9SWalxXP
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 10:16:59.2853 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac8b8c7d-c49c-401f-f6f1-08df43cac004
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: MA3PEPF00000405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8229
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



On 11/7/26 15:32, Dario Binacchi wrote:
> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> 
> Use the generic clk framework set_rate path in the STM32 RCC wrapper
> so CLK_SET_RATE_PARENT can propagate rate changes to parent clocks
> when the leaf clock does not implement set_rate directly.
> 
> This is the case of the STM32MP25 LTDC kernel clock, whose rate can't
> be set otherwise:
> 
>   stm32_display display-controller@48010000: fail to set pixel clock 27000000 hz, ret=-38
> 
> Fixes: 901e0d95df3b ("clk: stm32: fix clock counter")
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 
> ---
> 
> Changes in v2:
> - Take the original patch from the ST downstream tree, keeping
>   Gabriel's authorship
> 
>  drivers/clk/stm32/clk-stm32-core.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/stm32/clk-stm32-core.c b/drivers/clk/stm32/clk-stm32-core.c
> index cd6bdee5412f..29d2f64e0c76 100644
> --- a/drivers/clk/stm32/clk-stm32-core.c
> +++ b/drivers/clk/stm32/clk-stm32-core.c
> @@ -168,17 +168,16 @@ static ulong stm32_clk_get_rate(struct clk *clk)
>  
>  static ulong stm32_clk_set_rate(struct clk *clk, unsigned long clk_rate)
>  {
> -	const struct clk_ops *ops;
>  	struct clk *c = NULL;
>  
>  	if (!clk->id || clk_get_by_id(clk->id, &c))
>  		return -ENOENT;
>  
> -	ops = clk_dev_ops(c->dev);
> -	if (!ops->set_rate)
> -		return -ENOSYS;
> -
> -	return ops->set_rate(c, clk_rate);
> +	/*
> +	 * Let the clk framework handle CLK_SET_RATE_PARENT propagation for
> +	 * gate clocks that do not implement set_rate directly.
> +	 */
> +	return clk_set_rate(c, clk_rate);
>  }
>  
>  const struct clk_ops stm32_clk_ops = {


Hi Dario

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice

