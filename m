Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9913606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 16:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aaff26CF;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=mLgozlOv
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9CFC68186B;
	Fri,  6 Nov 2026 16:46:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LFOjItT8q9xC; Fri,  6 Nov 2026 16:46:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org ABCB081771
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793983614;
	b=HjtHpHhuXgU/MbPPTZkymLmmWpH78loDgrUOvbZD4MrMW30SSDmavADBKx4lCvv2x59a
	 WAc/S9BWwnuP27f3u6djLEGcfMz4aBIiI7+PcG0b4sZA7m4GVVtGk1gX4p6ufRqokB5Ss
	 bfnUayH9DOCr455W8HpNSbBmBruDu18kwiyKdi1COfrepmZLQB9p4irpatK4+jdT7LsZM
	 PMKiRK8Ns9YYLzlOV1QJMvq76VovvQvoIR9WptRFEhl+8gfuGf/UZBvBte7bRB5cEVQyf
	 QkYkXexz1uyHnQDTOIE7YPevmMX2w58pOXUkxmyRGn2F+tIrBQSJD+JOE8/WQkz5bLg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793983614;
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
	bh=yHrYdXdJNJX19YYjRqe0BBB+EOlPzjUDQwcQP/60R+0=;
	b=a16vtzRl4xnjoEaNhf8r2luYJSIiYw8QYFBMxa1J/Y98VZPWNQXFx6aBtq1uFlYqfinU
	 TVDi/7/9lExGhk8tN5rD60e1QYqkYCMU9Sb3nZSrWGZVsu2DrB/6pigqvqrkaJ6h1djIC
	 Pe6vfmaP4HVvkOmoObU5iCUQStsg8kjaLQCytQ4D84CkTODuqeI09QcX1vZBRpfFNLD43
	 04zmjC6ot9QLtJ0t/6239gUWKW1l0/3ZIs8IR7KKqyBml/VhmOSLat9Zghx0KQBOlG4vX
	 nnnOS0nm4vESBWkhczOSeKIuQtBn403awViFoKLe4jxjpf7mWB2BKU2832yhwlPakgA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=mLgozlOv;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793983614;
	bh=yHrYdXdJNJX19YYjRqe0BBB+EOlPzjUDQwcQP/60R+0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aaff26CFsvgnvvqmJtNTn5NRtLhVrlTtgtXYpZl7VfD75uonTxjkzLLqIuGBaFG9W
	 SFLantIV15AHqtE6CnJMehvqmFkLL6XsmVJn+MGGjCTWb6m6TQb7H17bl2bmyhcExe
	 YzmqvhyfFt49RhhRUVi6/FUs0JzxTd2ItbCeO7wKA3iH3OJlReGQOlD6gNDatLbI41
	 PHF4nPmifjLOBj3SAaqYPFUQyxMrkUqNf1iLA3LqyLFYFUGZXIfKnpW36zAhuFSkRp
	 JWuijDeBI6kuzcp8ivJ+hjv+1zYaA37kY/O1Wuo4wLT5NjyYNpObKWHckpiVggIsCW
	 dzIvmjg8SpDww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ABCB081771;
	Fri,  6 Nov 2026 16:46:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BE2B14B8
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:46:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BB03481771
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:46:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QtM8cR3pBGp7 for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 16:46:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E89AF8138E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=mLgozlOv
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E89AF8138E
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHrYdXdJNJX19YYjRqe0BBB+EOlPzjUDQwcQP/60R+0=;
 b=mLgozlOvaxNy2pn+DRO6z48bGAEfVyGwTGa6SLcuLPLS77etaUWWHDJk0pa4+HmlZcuIAUkQiatp/6zLgjtiUoQA61zrGKL7PqCbL1+jDroKES6L1mHkWB7671hMmT9cb++fpMsnVEGF1e7OCxHNUXytuA5QrzpVFjXD9YveD3NRoiqILp/PqTvhpn5nR5qrp9eQT6uCnTxZzRjr0cOJXKTqxyg7t9qpbeLE2pIRZk/jetSrBkt6X9xFQStFPgtXNS4DlyZ5CPuLCHCTS3w5jXgvVI4ETNtOeJq6WhxdriY1s1knlCXyFmOgGiEOpfUAAbFSUScs+mmz2fkiaMl9/w==
Received: from VIVP296CA0009.AUTP296.PROD.OUTLOOK.COM (2603:10a6:800:357::9)
 by BR0PR10MB432114.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:2c8:2b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.5; Fri, 6 Nov 2026
 16:46:45 +0000
Received: from ZR1PEPF0000E6B5.eurprd07.prod.outlook.com
 (2603:10a6:800:357:cafe::a0) by VIVP296CA0009.outlook.office365.com
 (2603:10a6:800:357::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 16:46:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 ZR1PEPF0000E6B5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 16:46:45 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 17:47:19 +0100
Received: from [10.252.31.114] (10.252.31.114) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 17:46:32 +0100
Message-ID: <99888b6a-90b6-416a-bce2-b5e83d36de0e@foss.st.com>
Date: Fri, 6 Nov 2026 17:46:31 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/33] clk: stm32: propagate rate changes to the parent
 clock
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>
CC: <linux-amarula@amarulasolutions.com>, <michael@amarulasolutions.com>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, Lukasz Majewski
 <lukma@nabladev.com>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.u-boot-project.org>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
 <20261104085036.4012238-21-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20261104085036.4012238-21-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PEPF0000E6B5:EE_|BR0PR10MB432114:EE_
X-MS-Office365-Filtering-Correlation-Id: b899cd27-3eaf-402a-41b4-08df3c258b23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|18002099003|22082099003|10067099003|4143699003|11063799006|261028144727099003|261026140227099003|261026121527099003|261102123227099003|261021121427099003|261021123027099003|261022075727099003|261022105027099003|261021135927099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: VvMExgideyYkZUfS/TG9WqqTXRXHBfqREhYSldsZE43jIBl6BILfBao+boLAxgKd6OGNSYV1SdE0Jpc94kujW6i9W+sTWA5nA39GwpNnYiLE22sHX7/JI3dc/Tk1thkkL15R57aMIRDcBgxoOOC7tT3MIwT43137C3Sej6mJVUjEAuRq/f5CoHFRkCiQlkqi+kZB/qCh5aVpHrPZMd7AY9jmBil4dav7XuPeC6zwspmUsEaHM/YkeG28VN4EG16p/I6A1Emrvubu3lYocvFyZTvGxCekYAYTcjEK7ph7SKteRtOVp6fb8OkiXPYTHt8pyqvfdjtP4Ny/SfeSU/s23aCVVrZYQYgSDWyvuX1biUNiueJmcvrVH1GJ5tuMnHAyiWOefJ1LNSHAXye48r5nljvxnofaqk9hs2TTauOwpFzYoI8ZUmvBGJvvfY24j99N0Pw7W7flRv59MTJZUEQ6J7Frg2akXvnJK/2+kxmbEtrTksCB33rq0O3iCT5shNdrvDyUYiXnmZDC/KYcJcI3rdZLmwfWtKuI7c16DxxhNzI6aVoOXpsg9tCkOVaaf2lAbFeY4IfzAlu0/pwcYYofPWMCVFclCyvXe3k0IbUw9ne+S+PY/a/nd1phB1FRPkS0Qu13GAWB12U9UVbuRcYndHpaiuf9pfWFcrmuAITKQSktQZAewzLL5kNQhUBD+8i2WYmjkp2MGoIFDMvxtIuIuQ==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(261028144727099003)(261026140227099003)(261026121527099003)(261102123227099003)(261021121427099003)(261021123027099003)(261022075727099003)(261022105027099003)(261021135927099003)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nHDublLZnSGtK6sOSfVtxitRfud9y7lRV4HVp9Bi7gKjmRfW3eNQzl1gSABBt705KNKoJ4RKfsA3peLcIo2HO8IamUsNvb61KqS+bAxN3m6DGBxUgyoR3ts4/qV5D/0Ss+shs/J+ad6HZQGBs+AAavRh7Z9wGX0fXWW8zdGOJqMLAFLyIbRWwNBv40JSDjaLemX0w+oPiVnmllU7ONXHlvzoNgLS7ZziH2nY8LGP+QJ5h59Rrd8TNoqWgo4kt25w5RpfBmRdDs7zVhtR0yThZw6dfjDtUHTKxctMjc9BV+syjNb5kFf5U7kdd0C3ND8HuAtso2a4D3r9MzBUFuW1gxwGO7zhl5Ol8rMe++Rqa3WSl/wtlEdgVSYLHzIGPzf8Ku2+QaO3IXNHedgm5IvfpDzepDYLdn4z6SZ5cTfVK/Ys5FFGZMwX9SpdvqVdyIjw
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 16:46:45.5449 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b899cd27-3eaf-402a-41b4-08df3c258b23
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: ZR1PEPF0000E6B5.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR10MB432114
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/4/26 09:49, Dario Binacchi wrote:
> Since commit 901e0d95df3b ("clk: stm32: fix clock counter"), the
> set_rate operation of the clock is called directly, so the
> CLK_SET_RATE_PARENT flag is ignored and the rate of a clock relying on
> its parent, like the STM32MP25 LTDC kernel clock, can't be set anymore:
> 
>   stm32_display display-controller@48010000: fail to set pixel clock 27000000 hz, ret=-38
> 
> Use clk_set_rate() again, which walks up the parents having
> CLK_SET_RATE_PARENT set. Unlike clk_enable(), it doesn't update any
> counter, so the issue fixed by that commit is not reintroduced.
> 
> Fixes: 901e0d95df3b ("clk: stm32: fix clock counter")
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> 
>  drivers/clk/stm32/clk-stm32-core.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/stm32/clk-stm32-core.c b/drivers/clk/stm32/clk-stm32-core.c
> index cd6bdee5412f..f9a0ba2f5748 100644
> --- a/drivers/clk/stm32/clk-stm32-core.c
> +++ b/drivers/clk/stm32/clk-stm32-core.c
> @@ -168,17 +168,12 @@ static ulong stm32_clk_get_rate(struct clk *clk)
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
> +	return clk_set_rate(c, clk_rate);
>  }
>  
>  const struct clk_ops stm32_clk_ops = {

Hi Dario

This patch is coming from ST downstream tree :
https://github.com/STMicroelectronics/u-boot/commit/804e2d5f7b376703a465e1a9a81b5d7db7adfd01

Please, keep original Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

Thanks
Patrice
