Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09232606A321
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 10:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zTI0wIvL;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=DzNLQPsB
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D99C08121F;
	Fri, 27 Nov 2026 10:30:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id umXHgb-e47x3; Fri, 27 Nov 2026 10:30:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 25D418121A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795775441;
	b=bMWdfTN+ILL20COWsIRXX5PsA5gqGyxKx0wT0RY4RvNxEiKBLBkS8SDJQ1dhMMA2eNaU
	 TJf91/O6WtepElqr1MvDhx+swGIT6Fb7ENPL7ruCac+9YQO0RlA2+0wdVvK7mp4QoJD4I
	 J/g4pOInKtcVK3fML7tKwZgTJbSsocne0ISEXKrLrLKuz/H0fkFwgMYwqmsrxppO0qIiF
	 21czH4O1v30OVe3Dun7oSEzDREezo/96JDYv9pdeACe3MahEI4lL5iMPUhuhNmnLOV5Er
	 J4dQas2zP+f/qUGNV6q5QCxdGyZz+SXGtNGaG89HsfZOpVlH6xZ9bzhixcV40DBYODA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795775441;
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
	bh=MxB0WP+ZujdkTOwqeG3TXU9eB8QB9ifWaq0dZz5WFLc=;
	b=SCs/H+QGWsqCpPG9FYuKDwz+nF0WX2x76Wqu+rtDQw2q3ms57PDcDtew3sg10dTzZC0/
	 orNZsnvr2JdyJ5AgkIQT3hFYF92vRH7gNIle27Uk4x2U+yEiO86/0vF85Z5SkZcsHUxF7
	 /tOjf4doHYdKVVNUKXC4GUF+WZRGLvT4bTPI1VU7mM9PvEe2cr+WmYFbDrf72PgJPPd2d
	 C2uXmJp7ys3YDOmTGR+J+lL9LBNBe9wiiwfGXoWSoORjjYRgisi+kKk7UPmOuvq1+SwUB
	 HABMUI0gcS7ud17bJbMLjfQmG9qW5sO7rJMnI14avhVI1pYxJCfLq5LYtHzjaA9sLYw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=DzNLQPsB;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795775441;
	bh=MxB0WP+ZujdkTOwqeG3TXU9eB8QB9ifWaq0dZz5WFLc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zTI0wIvLsrPcagljt+Gxc+Ao3GNNt6BPbBBpb96Y0CpuVLG4XurELF8Whh66PDtt5
	 4pr6GNA1psqDwV0c2SS2Tn3fn+VMd+mYXzzj2803rWbEq1bH+LpUrLq+uMC9kfJ7IO
	 TFwTBny/Sao7pQTq/TtYg0BsnhftPdxHBl2uvB8XRoRsleHZX5BjkntFo+5YitUTWk
	 ORji1EFS6deNfQQxa26udFGzqLWeBzIzz4yt5SfAPJJpw7NVIDdpI+k8188NlQDRuh
	 I0XLM4Tcf/DsJhA4g2BzmuhHqY8BfNYqRwka3EKlEhGlfJykr1JwsH9wSCF57zHRnv
	 VMKfPnyeeDBXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 25D418121A;
	Fri, 27 Nov 2026 10:30:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9E8EB266
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:30:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8FF448121A
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:30:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DW2LOum7w6sx for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 10:30:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A3C5581218
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=yannick.fertre@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=DzNLQPsB
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A3C5581218
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxB0WP+ZujdkTOwqeG3TXU9eB8QB9ifWaq0dZz5WFLc=;
 b=DzNLQPsB9RX1tI9ql6MNyUolqWvS/drbummRFOop10WemT5CyH/nFk1TgP3W/AT4KpTEmHkaY8JPJiV2c/zQZTclh8gJ3NQ9mX25N2u/Po7CBANGe4maO52aUDMWi1faKo2yqwR8KBWeKUZ8jniGKGE05jamhSuBgQo7xqMie0wXkQM50UeDaRlZMhc0nsmvpESuHIQcvHLW6wWwUUUYuxeqntdDCtiP+y5zu8Z/4RdLPeqmyfsWPSLBduWjo5J/lGnyFcSaUkPCfZ3qNd5hMD1iu8okZUQV6UFYBHGcZGSH/5GlTFvedT0qZ2EkYzVfi5R/YCxSDVmGKLtt+IIy2Q==
Received: from PA7P264CA0263.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:375::14)
 by GVXPR10MB8508.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e0::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.688.4; Fri, 27 Nov
 2026 10:30:29 +0000
Received: from ZR1PEPF0000E6AD.eurprd05.prod.outlook.com
 (2603:10a6:102:375:cafe::87) by PA7P264CA0263.outlook.office365.com
 (2603:10a6:102:375::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.10 via Frontend Transport; Fri,
 27 Nov 2026 10:30:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 ZR1PEPF0000E6AD.mail.protection.outlook.com (10.167.241.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 10:30:25 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 11:31:14 +0100
Received: from [10.48.87.178] (10.48.87.178) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 11:30:23 +0100
Message-ID: <64337014-f5a4-4121-a992-132f1c99a8b5@foss.st.com>
Date: Fri, 27 Nov 2026 11:30:23 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/35] video: stm32: ltdc: stop looking for the panel
 once found
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>
CC: <michael@amarulasolutions.com>, <linux-amarula@amarulasolutions.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Raphael Gallais-Pou
 <raphael.gallais-pou@foss.st.com>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.denx.de>, <u-boot@lists.u-boot-project.org>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
 <20261107143241.2236511-24-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Yannick FERTRE <yannick.fertre@foss.st.com>
In-Reply-To: <20261107143241.2236511-24-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PEPF0000E6AD:EE_|GVXPR10MB8508:EE_
X-MS-Office365-Filtering-Correlation-Id: 46359061-cbfa-4d29-5bc2-08df4c71731d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|261021135927099003|22082099003|18002099003|4143699003|56012099006|11063799006|261022105027099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: bKqvYMwk/fgihCksL9rDeZWSPuzPt153DwvDwnWMo5RyVFHQgZNzvuZpBh8a806XDnIDLdtfnNVFpN24RwtBKZAUlpPq20mrCMOUPhkHb6PuQu2u84Za84VyUox2xmtMfR7J+HjtrHzU/EjB7PX8nlKunquMFWuPLgNEZMpIyv4+CBwRFJTn4mi7yaSmIhKY2j419kYGavqB3GUq9Ifjtn31wv66ohqtJ/AY6GiJcxawTAzPQXV+O9cRkTRdbjUMhSFOsBJK+nXEaAVknLEme7ntccIat40SLSp+2hNmJNAUgD4JLqFEjqNzWsrLRpEM0vBN+spZc8QJxbQkHRmEYJ0UVYXhvyuLYISYjKkJ9DanYsAwU9dFMN9A81+ATcAXlkSQ4vChmrsorSFNWGOGrhQL6HKzzeyxRdZQniwaCUOX9Us1/bhLBdxgRniinFsOVldl/PWsYQxkiiFAVtGpIbHUcSBMkFlTksZw1MuIqLpPOUzSCthQ5Q9CCBHC40ZEd931cfUTqKrM5jdbaUrAfYf0zs7g2LOY9hfcbHZnwIQxiAYI7hX8fg1iGG6mfGP4rn081Yxk2kzMxwo5G85wlXrAYmlA47m2oTyu0ISzxUPtegjDcNsuPXKINojGMtmPeBqcrWO/gkcYrASXGcAe/C4uwBL58xgkAbr8PFCWdKFiK80odeVoxMJdluKgMXa3f1d46L7HtP6faQq8MfHIdA==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(261021135927099003)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(261022105027099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4TKPwDAV9ldTEQm/Vm14R4ehXk22K7j42D5mqdBLQQU3JmB30bTYnv2KVlPeTvg0L79Tzv4iqXdbQcAup5Q33gH/cZsSjJFRIjUxdtp3b5D1yI/BxWlSH3RkPwp/jzoJVvIB9n5YAFFqnM/b3A291nuVzhjIxQihhPjRTTi+AJnkucDI7+4Q5P1Q2gBnVhQsCZ/lG0H/cJviQUUFrcq76WZu5KQQJpp/d9P/XtTMLMT+7AcbzkOO+p3eMLO1Ee1cydLYCHKuBgfVFGVaswYceKEzsAbXrik97VwSXe4QqWFbU64QEP8GRaYRH8/o6RXfH1bEfpxiDOHF8hj21MJeZgGyh9s2NMxTPmz/yMDhcWQmfupWx5eqtufNu/c/PMFAgBiNptZ4QPDsUGeRVNOL3J9MJ78LutGhoM9QV9pB4zGSStdCEXefKleD9DJuZyCm
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 10:30:25.5982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46359061-cbfa-4d29-5bc2-08df4c71731d
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: ZR1PEPF0000E6AD.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8508
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

Hi Dario

thanks for the path.

Acked-by: Yannick Fertre <yannick.fertre@foss.st.com>
Tested-by: Yannick Fertre <yannick.fertre@foss.st.com>

Best regards

n 11/7/26 15:32, Dario Binacchi wrote:
> stm32_ltdc_get_panel() looks for the panel on each port of the bridge,
> without stopping once found, so the panel is only found if its port is
> the last one in the devicetree. This is not always the case, e.g. when
> the ports are added by a DT overlay.
>
> Stop at the first port connected to a panel.
>
> Fixes: 35be94614733 ("video: stm32: ltdc: properly search the first available panel")
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
>
> Changes in v2:
> - New patch
>
>   drivers/video/stm32/stm32_ltdc.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/video/stm32/stm32_ltdc.c b/drivers/video/stm32/stm32_ltdc.c
> index 7bd6724bc2a7..da580a78a5db 100644
> --- a/drivers/video/stm32/stm32_ltdc.c
> +++ b/drivers/video/stm32/stm32_ltdc.c
> @@ -571,6 +571,8 @@ static int stm32_ltdc_get_panel(struct udevice *dev, struct udevice **panel)
>   			continue;
>   
>   		ret = stm32_ltdc_get_remote_device(dev, ep_node, UCLASS_PANEL, panel);
> +		if (!ret && *panel)
> +			break;
>   	}
>   
>   	/* Sanity check, we can get out of the loop without having a clean ofnode */
