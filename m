Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716CF606A323
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 10:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=a7flxbuo;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=XH0KBy6V
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DEF0F4052B;
	Mon, 16 Nov 2026 10:14:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WAGpiRN71IWM; Mon, 16 Nov 2026 10:14:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3A4C540560
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794824078;
	b=EZKIzqg7nr1crQUToz4qvAGEi/dKTQSL2sgssbhCr228Io8+HyCh+/eAjQ7Byvz/Bs5V
	 1Vl56YzS5LJ5A2cqxCk+txsH4mLJ7vy5GYFDQ8QAoFGEpLWvPDleSh38Z3NXO8tcIg2My
	 zOleaKJpOqd2+XqA9YJWbsFWxMt3aChua13umTje/mGtDBNwmRSNhIyI9tLUPbWSUYNB3
	 JWea5spE+DGP/LuqhFi1RG2jGTwYgfebw+5RdLtRnTC9i/4033TYtcpiUBngtI22MVrDM
	 HsdQ6/Q7rom931HmAMSXs/r7H3qgFQdcBRoYvUOGqTOM+lPMh4tFTfwsicAF5XV5aAg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794824078;
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
	bh=6yLja40R45cWF7mmJdZu3aB0IbuyGYzC9zphjD25Tts=;
	b=Gqkf0dWXx6KRXvvPz8fB6JNxwdLhWxP9vscf9pYqHAcKBCkXJZfdgWLp+LGwQU7EbPWV
	 z0+MH6ozJA7GQxog6lBtB8o+Fhg/aKaN+JDNoHbhKZ6/GzgzpxyFpTTFdwFKroj6Ig/00
	 KQCcaVTzQqPVusnQJpDRfKi5WoSKDV1HL9iM7By2UMXPfmUrk68W1uO6jU14uCJyGDjZA
	 6U9ZzLqUX9/Vj0G5gUsBXRiMz7yPW4b0d4xEV9QMUfV/0R7CgW3DehWSgSpgjXTzfJnIA
	 K0lCNkHSFLoonOJqSULwexLu4baGtC/WDHyWb1LA9xhDu6GVL8SsPazMRc1nj/jvl+g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794824078;
	bh=6yLja40R45cWF7mmJdZu3aB0IbuyGYzC9zphjD25Tts=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a7flxbuosn4IGNp6VD3BK/Hk5ocE1bsxO0lPPp3QFzKbOpnfUrlmrTKC/JAhCkJtp
	 TkJyzPtG2K5hgkADP/smt8Bez++GVyvq9pegt3aiP2RacNmruaR1A0mamMvfZSHln4
	 HLELKpQ7Plq4n9n27qwJKRLUOl4PJOWS21rh8oj5O7i6u9LFE0hNe1BAGPWhggKwKU
	 WgFAMY0O0GLQF3QMHimsJ1eB1Jc2fW5NnmcHNRGvW2gkQz1sUzORuZTw5Ht9kpfqUN
	 WVDKFqol7zddQOkt7THil1fYFhKVVZiAtEe0MCG87zbZfSt0T2174He3PENzitJgjg
	 9wc/2bABF7Ifg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3A4C540560;
	Mon, 16 Nov 2026 10:14:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6B9F11E7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:14:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5CEEF400FB
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:14:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vh-piAebfF_C for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 10:14:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3F0664009D
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
 header.s=selector2 header.b=XH0KBy6V
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3F0664009D
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yLja40R45cWF7mmJdZu3aB0IbuyGYzC9zphjD25Tts=;
 b=XH0KBy6VMUXY4H19CbjjaTl86R8ekBlGbHxW+9nW4JvQulT0WKppJEzazRn9g1L2olvqTCQ9pZR0ytIx3j8XHPJ0vg8LPXU1VzncttK0xaM7vPp3lh5l2NUx1ImtrQCruyy2ZGYM19YuM5f7ceWh05ojy11gBN2rCbEm6YC32dr+k/e3RqB3p21sVlp6CbzDbgPDTrKOcy+j3IUimWXNyXP4QXsEXiXH3dhcf3FOcAsjG8tcUji8AzEmOfMKPeDPnJOQPFVhO/zbr1UfoZmKasEjjNdboWXEwBLytdDYPyJW/zvkq8wHsZOpcPumUQp3B0oiYGf55aOoQYsI1inIMw==
Received: from DU2P250CA0022.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::27)
 by GV2PR10MB9802.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:30b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Mon, 16 Nov
 2026 10:14:30 +0000
Received: from MAD0EPF000008BB.eurprd04.prod.outlook.com
 (2603:10a6:10:231:cafe::6e) by DU2P250CA0022.outlook.office365.com
 (2603:10a6:10:231::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Mon,
 16 Nov 2026 10:14:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MAD0EPF000008BB.mail.protection.outlook.com (10.167.241.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 10:14:25 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 11:13:57 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 11:12:56 +0100
Message-ID: <0743b535-3bc6-4a86-a885-7f156a9efece@foss.st.com>
Date: Mon, 16 Nov 2026 11:12:56 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/35] video: stm32: lvds: fix NULL pointer dereference
 on missing data-mapping
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>
CC: <michael@amarulasolutions.com>, <linux-amarula@amarulasolutions.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Raphael Gallais-Pou
 <raphael.gallais-pou@foss.st.com>, Tom Rini <trini@konsulko.com>, "Yannick
 Fertre" <yannick.fertre@foss.st.com>, <u-boot@lists.denx.de>,
 <u-boot@lists.u-boot-project.org>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
 <20261107143241.2236511-20-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20261107143241.2236511-20-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008BB:EE_|GV2PR10MB9802:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e8d7587-e9ac-4660-29b7-08df43ca6484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|260925021911599003|260925021311599003|260925022911599003|10067099003|11063799006|4143699003|56012099006|261021121427099003|261021123027099003|261009223027099003|261102123227099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3jHiiZNZRI2LD7bvkXT+HQsvQJwY50orbPJsCXbP+cfhWqt7S1GFcIWItLywIaCEH6ITmCdPscQ6hE4361WwHPVN+wiiHvIp2UrvABOgdXWJBFpNUoxofkdmVvJlBh8ZeFx7gLvehgWU/5zwD3v5e8HS4i6UCe6kblInv20I7XZJTY+3dS66lsUNnNlfEohjCp3Ep9q3LMxIcnKUoEMcXK3z4pdXkJyy2x+5aS5lXXuWZ5sJWT3Ssr7kj+/dIRGo0+Fbcrw8xW6Ca0AkYw9JpQjJ4JBfDMxc2MnijNkvQujEgqDLOws+P8exBjc0yh7+4cQ0urBggdfXOhjvJnGzAMOSDZcg07QoN5u2Svd2Rv004EFFuEoxN1NVIlarjDHk1yhNZ6iWuaXc9amjYg6PRt5vT1aE7TlilXy1HDQYH5vdmieXRxKY9UG33qD8gTrLK/FiTRN2y+bo/uovnXd8hWLd4Kta/P/ivut3Sfm3dtoVBfnAXicpiVCKp11A/GGR8xLEn3kGBqj7IYg6OQFYx+ed+Ck1xfJj8kSwqjbN1t7mHQjbYtYQYj+wSmJeZiXROuhJVjHU3m4iqKqLxtoCItcI0TLW1GYgQxbE80usBloxjoPm5Nq5OibWIft+IyOPDBcCEQmlSkBVniOG/ktYRtfCyHF9kRH/mMPVt5T3osCDEylBNhpS0nBIZpeRjgE6v3pHvQA79XcMi/c/7KSJtA==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(260925021911599003)(260925021311599003)(260925022911599003)(10067099003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ABHdD+r9rZbu4yIqufZceS0wRlMhK/nmbWGAUVT6PkBzA02Jip+9jH7qY6C/BX9xKiOHVyHGf/jz+J64pCGn037yJCau1Nq04ANcn1dQHFwyFqir56pIRukjMBDS9QRYnXLvu33KEK9cw9etHTnrZ+gLkmsjnImWrbYrQMFHYYs0XfN99cf8DI6Np6yscTyrIjiBxTd3+GRyMic9aYI+vHYYNNle+wvBMBWmH+yCfZakwgxyYEKLSulAL5JrNYLGP2FrP+QzU9JXfmzMWC13KFXANrcDwLrOAn8ri+BpRfxroP9yDL1L3BQ+3X0XUOGVBw9XubVfg8+JM3dDOvlPgANLMTc2MEjH2dJHzy5ZCKC8uZKfv4G2g6av4IWJugM9uraVUP8zU6hn+iXaRZjyg+7bHr5imjkfbfxKPwcrQW6bopOjWPTuFP/3hoiAOObK
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 10:14:25.6985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e8d7587-e9ac-4660-29b7-08df43ca6484
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008BB.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB9802
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
> The "data-mapping" property is only required by the panel-lvds binding,
> so ofnode_read_string() may return NULL. Avoid a NULL pointer
> dereference in this case by falling back to the VESA mapping, as for any
> value other than "jeida-24".
> 
> Fixes: 16cfbbbe2b51 ("video: stm32: STM32 driver support for LVDS")
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> 
> (no changes since v1)
> 
>  drivers/video/stm32/stm32_lvds.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/video/stm32/stm32_lvds.c b/drivers/video/stm32/stm32_lvds.c
> index bf1393c9e872..a16331296388 100644
> --- a/drivers/video/stm32/stm32_lvds.c
> +++ b/drivers/video/stm32/stm32_lvds.c
> @@ -614,9 +614,7 @@ static int stm32_lvds_of_to_plat(struct udevice *dev)
>  	}
>  
>  	data_mapping = ofnode_read_string(dev_ofnode(plat->panel), "data-mapping");
> -	if (!strcmp(data_mapping, "vesa-24"))
> -		priv->bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG;
> -	else if (!strcmp(data_mapping, "jeida-24"))
> +	if (data_mapping && !strcmp(data_mapping, "jeida-24"))
>  		priv->bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA;
>  	else
>  		priv->bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG;
Hi Dario

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
