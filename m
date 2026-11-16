Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5026B606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=S5wDi8WD;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=bzh/D/0S
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 260EC80F82;
	Mon, 16 Nov 2026 16:25:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9RggqocD76XH; Mon, 16 Nov 2026 16:25:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BD86380F56
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794846316;
	b=NY64EhaDWRf7QKQjxq8lXkMGa+IqJgppvKk+hkSAKBjRrRrfvl2VAKfMrNWkIfj0EQ59
	 7+rng4jU4WFXy2C4kvM0ISgz0zRf2veb4kzuhQSStVV+JJAtiiBCj6SYMsTVUmPMTTyIe
	 WQ6SVpmRPhcBR45IRTr5kv/Kd0ZjDzQyLL1mEauklPASibxuvzt1O2P3GjuEaJ7nBXfUP
	 KuJwS3UPJDxRZ0FN+5OVorQI7CxVzJIC/vRAPysQ/AO5qhykSegBGSSQZOz2MGSWjgdO9
	 InbzqBgJxIiR/pt59QgB/5rs6ae1T+dhcEsIsFc4bfEroiYGm48vH4ruu84+pgLOa3Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794846316;
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
	bh=3Fd9lzhu6JkI4gXZMQk1zedopXfOekVlU3cv1BtiK30=;
	b=VLek4yWAgjIvIwkis7bTbBnPxcUMdpZuHI58wWQ+ZOxUvR36FTPoAOpgVrA8FlxnyZnZ
	 YfKUt5tWlGJqwpeJdq8G+XUFrHcI3PY9U0rhX/KrfFOsAsv4wDUhgdfx5z3khvZWjBpbw
	 E3Z2nUV9pTG6FSHxuKcIu+tWBJq7UfROGouIDHiPykTEqB+IkhzZ0Y2Nv6znIOzIDsUoj
	 i7hIdkx/aof9W2Edht6HHcoeaZF1fv+VgvGHoS/HyfeSkeJt7sSxPxsSLbVTJAVytvg+Q
	 bdhPjRZCeugnYed4SGRc7/8DVgJl836CmEM5bY8jXO38xr48wvu5s8E7a/KhjF3mF+Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794846316;
	bh=3Fd9lzhu6JkI4gXZMQk1zedopXfOekVlU3cv1BtiK30=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S5wDi8WDqWvXhsVXrJtTuKNDxTlZ/RFTIIdn1lLi04t8pNIHV1Xv31riVIosiXVx1
	 qJv4II4NQNPfmsN8Oi2bqNlyYEV0+NsGYnz1GGbUM43CG7/vYXROEOqC9U4pe+1A6D
	 GhDRs7gJ/xmYYNDWU86RgXNmceT8o5UgINn5//wXjn0bfyp9I20WNb2yWGawLZ/1as
	 dGGpVmaJJyrcM2Bqy1wL+IHirQwje5qw4HzIma4LymPvuQHsh4JTRyF4lVxW0Irc26
	 wzyxuSFmeMzR7T/TCa+pemiF7qSpDjwlyK3fO2gPgUg8I2m0i9xgdzmaf4kuLPAsuQ
	 gdGL9tt1TeudA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD86380F56;
	Mon, 16 Nov 2026 16:25:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B26E92FE
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:25:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A3C9B40588
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:25:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UFt1iqKJQtzA for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 16:25:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D80074057B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=bzh/D/0S
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D80074057B
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Fd9lzhu6JkI4gXZMQk1zedopXfOekVlU3cv1BtiK30=;
 b=bzh/D/0SJUuFEPHzWeY/goPlQDc3KRTGdSWATDPAU2u8DcaIbwEhafoePpZIcxmDjaFZT7XL8g6JlFmctyrj7R+u7/OHa0iiNdJliKVByXbwwKHms5nm4Zt4WFa5DlNFX6+6vAxwl1ybMfHCw4uejFa2fR2kZdmQh1XT/Ovetj7wK2kcCJsFrDgnLRpcued0i/a11GzqlHN4tG+J9Ozq06Wi7aNOpDW9KSZLQpCvqyXWlWMFGuimU7YTry/MZpNkjlb4TjXjfC+wnwygv4GC9wi7RaJuzNordfu6V8qjVIJgX3pyigR3cHC9ayjqBUdhdVMStlieRou6EfwwC3u2lg==
Received: from PAZP264CA0179.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:236::27)
 by BR2PR10MB992311.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:2c8:9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Mon, 16 Nov
 2026 16:25:09 +0000
Received: from MI3PEPF0000847F.eurprd02.prod.outlook.com
 (2603:10a6:102:236:cafe::1a) by PAZP264CA0179.outlook.office365.com
 (2603:10a6:102:236::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Mon,
 16 Nov 2026 16:25:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MI3PEPF0000847F.mail.protection.outlook.com (10.167.240.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 16:25:08 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 17:25:46 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 17:25:01 +0100
Message-ID: <de606684-63e9-4e29-ad62-673d37f6701a@foss.st.com>
Date: Mon, 16 Nov 2026 17:25:00 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 32/35] board: engicam: stm32mp2: add
 MicroGEA-STM32MP257D-RMM board
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>
CC: <michael@amarulasolutions.com>, <linux-amarula@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, <u-boot@lists.u-boot-project.org>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
 <20261107143241.2236511-33-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20261107143241.2236511-33-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF0000847F:EE_|BR2PR10MB992311:EE_
X-MS-Office365-Filtering-Correlation-Id: a24a692b-3dfc-4897-592c-08df43fe2e4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|18002099003|22082099003|6133799003|4143699003|11063799006|56012099006|10067099003|261026140227099003|261026121527099003|261022105027099003|261028144727099003|261022075727099003|261021123027099003|261021121427099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: UiHCzPzUxpjmv2TzOsbWP5uCty0UuRBVCxn+eltdwef9VWiszQK0hiY0AsW40Zh2V3dB6DfXhoosXKvdceA/S8CfWNvtwK6bDBHrX3hf0JEVKMr+p3jwhx65YXTchjz9JeLB25VKFGVah2GcoOs2XYfYuvCopaZq0fnbWrFJYD4o8EX6dykIqbGDdaFozAaQLaUGG11KbHFfQOK50thlAiTkmlKzQR+ThhQ6C430dBotkLeVUtxD80HuyIlNiYAylHGHB30wz9wWCTIQo4sCuOWoSlWITiv/bCjjMk0hCA2waRWO8xJY95ediWgELriztLER0iS2z+G8jKSDY648N7fxb3ZWMkLawGu07cTc74+yYJ8kjnCNA5z3nXvo8JlCM+tT6fckCHWDMTxM+HPmbucUZiNA5ZQDCPxO4AMgauiTka6vRP9N4fHSuE7VVum8AVWt0qEiJy3/r49t5MfXoyhYjhCh1dOBh+w6k2wULMXrPVJ7BkSBBCerG8BYKczRxHJxY/lppDFQPlYrPID5fvCCBJH+z/IP0eYyE+m/kP9jboGMHn1HpdQ5Jy15EdTEDj6y1ZILMoCX1ttaaGuKu6T+h+2uv9I9ir/vaSgUy4RTEqFPInl6Lzd12UvxlWqOth0LcwTJ/g59s/HZaFMFdIBwjilzUvtHlON2esPDkEMIwolwqvuKnNT5kTw6kcvzInte94wUFR9LQfmusKgzFA==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(6133799003)(4143699003)(11063799006)(56012099006)(10067099003)(261026140227099003)(261026121527099003)(261022105027099003)(261028144727099003)(261022075727099003)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: O9AGbsBi+xTwUcox8QniEDuQZz1XsjblBui5OzpLwhQy8ETN9lCIT13UxDBr/f2RokuMfnjhEhGtWmQuV3n4J3pNDi8PfR2l0CIHe8iZt5Q+PP1elhOtxM3IwkFGvF9ab4sP7uXhPHSBaxirF/k9Xq6I/KD8TXQ2CUQORE1VRp1xKgGXidRgQTyVs6l8U5wAozYDOesBN+vQ13pT7Vly3Ei6OJ/xwhjh3MlckTfnCSJjqAOqlFQ95OSGstg/Gcqetq2prpD/IMaW+ZfnejHgKFiIAiB3mHNNBs4jShgU+3vRDDGR/zByzktYAv6ep1fCmn8JmaPfNVzz25TqQPlCBA2Ljxi0loaumR/qHolLKepyJetG7MCAhTLZs+DDsq9U3iUIF1CoapxxoDK27dJXGeX4d7wa5NhJyw2cgRrfs1wJEU6IhU6GwLDuwN8qxNpK
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 16:25:08.6812 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a24a692b-3dfc-4897-592c-08df43fe2e4d
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF0000847F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR2PR10MB992311
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
> Add support for the Engicam MicroGEA-STM32MP257D-RMM board, based on
> the Engicam MicroGEA-STM32MP257 SoM.
> 
> General features:
> - STM32MP257D SoC
> - 2GB of RAM
> - eMMC
> - microSD slot
> - CAN
> - Audio codec (SGTL5000)
> - PWM backlight and buzzer
> - 5" RGB or 10.1" LVDS display
> 
> As for the Engicam STM32MP1 SoMs, add a dedicated target for the SoM,
> so that the carrier boards are handled by the devicetree.
> 
> The display can't be detected, so it is selected by the "display"
> environment variable, which defaults to the RGB one. The board
> registers an extension driver reporting the matching Linux devicetree
> overlay, which the extlinux and EFI boot methods apply to the kernel
> devicetree.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 
> ---
> 
> Changes in v2:
> - Simplify the comments
> 
>  ...m32mp257d-engicam-microgea-rmm-u-boot.dtsi |  27 +++++
>  arch/arm/mach-stm32mp/Kconfig.25x             |  17 +++
>  board/engicam/stm32mp2/Kconfig                |  12 ++
>  board/engicam/stm32mp2/MAINTAINERS            |   7 ++
>  board/engicam/stm32mp2/Makefile               |   7 ++
>  board/engicam/stm32mp2/microgea-stm32mp2.env  |   9 ++
>  board/engicam/stm32mp2/stm32mp2.c             | 104 +++++++++++++++++
>  configs/stm32mp25-microgea-rmm_defconfig      | 105 ++++++++++++++++++
>  8 files changed, 288 insertions(+)
>  create mode 100644 arch/arm/dts/stm32mp257d-engicam-microgea-rmm-u-boot.dtsi
>  create mode 100644 board/engicam/stm32mp2/Kconfig
>  create mode 100644 board/engicam/stm32mp2/MAINTAINERS
>  create mode 100644 board/engicam/stm32mp2/Makefile
>  create mode 100644 board/engicam/stm32mp2/microgea-stm32mp2.env
>  create mode 100644 board/engicam/stm32mp2/stm32mp2.c
>  create mode 100644 configs/stm32mp25-microgea-rmm_defconfig
> 
> diff --git a/arch/arm/dts/stm32mp257d-engicam-microgea-rmm-u-boot.dtsi b/arch/arm/dts/stm32mp257d-engicam-microgea-rmm-u-boot.dtsi
> new file mode 100644
> index 000000000000..4cc0d47e999d
> --- /dev/null
> +++ b/arch/arm/dts/stm32mp257d-engicam-microgea-rmm-u-boot.dtsi
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
> +/*
> + * Copyright (C) 2026 Amarula Solutions, Dario Binacchi <dario.binacchi@amarulasolutions.com>
> + * Copyright (C) 2026 Engicam srl
> + */
> +
> +#include "stm32mp25-u-boot.dtsi"
> +
> +/ {
> +	config {
> +		u-boot,mmc-env-partition = "u-boot-env";
> +	};
> +};
> +
> +&usart2 {
> +	bootph-all;
> +};
> +
> +&usart2_pins_a {
> +	bootph-all;
> +	pins1 {
> +		bootph-all;
> +	};
> +	pins2 {
> +		bootph-all;
> +	};
> +};
> diff --git a/arch/arm/mach-stm32mp/Kconfig.25x b/arch/arm/mach-stm32mp/Kconfig.25x
> index 7d2d8171845b..cfd746b82c2c 100644
> --- a/arch/arm/mach-stm32mp/Kconfig.25x
> +++ b/arch/arm/mach-stm32mp/Kconfig.25x
> @@ -13,6 +13,22 @@ config TARGET_ST_STM32MP25X
>  		managed by board/st/stm32mp2
>  		The difference between board are managed with devicetree
>  
> +config TARGET_MICROGEA_STM32MP257
> +	bool "Engicam MicroGEA STM32MP257 SOM"
> +	select SUPPORT_EXTENSION_SCAN
> +	imply BOOTSTAGE
> +	imply CMD_BOOTSTAGE
> +	help
> +		MicroGEA STM32MP257 is a System-on-Module (SoM) from Engicam
> +		based on the STM32MP257 SoC, with 2GB of RAM and eMMC.
> +
> +		The carrier boards supported are managed with devicetree:
> +		* MicroGEA STM32MP257D RMM
> +
> +		The display fitted on the carrier board is described by a
> +		devicetree overlay, selected through the "display" environment
> +		variable and applied to the kernel devicetree at boot.
> +
>  endchoice
>  
>  config TEXT_BASE
> @@ -35,6 +51,7 @@ config DEBUG_UART_BASE
>  
>  endif
>  
> +source "board/engicam/stm32mp2/Kconfig"
>  source "board/st/stm32mp2/Kconfig"
>  
>  endif
> diff --git a/board/engicam/stm32mp2/Kconfig b/board/engicam/stm32mp2/Kconfig
> new file mode 100644
> index 000000000000..a4d590d161f4
> --- /dev/null
> +++ b/board/engicam/stm32mp2/Kconfig
> @@ -0,0 +1,12 @@
> +if TARGET_MICROGEA_STM32MP257
> +
> +config SYS_BOARD
> +	default "stm32mp2"
> +
> +config SYS_VENDOR
> +	default "engicam"
> +
> +config SYS_CONFIG_NAME
> +	default "stm32mp25_common"
> +
> +endif
> diff --git a/board/engicam/stm32mp2/MAINTAINERS b/board/engicam/stm32mp2/MAINTAINERS
> new file mode 100644
> index 000000000000..680b083aca2b
> --- /dev/null
> +++ b/board/engicam/stm32mp2/MAINTAINERS
> @@ -0,0 +1,7 @@
> +MicroGEA-STM32MP257D-RMM
> +M:	Dario Binacchi <dario.binacchi@amarulasolutions.com>
> +M:	Michael Trimarchi <michael@amarulasolutions.com>
> +S:	Maintained
> +F:	arch/arm/dts/stm32mp257d-engicam-microgea-rmm*
> +F:	board/engicam/stm32mp2/
> +F:	configs/stm32mp25-microgea-rmm_defconfig
> diff --git a/board/engicam/stm32mp2/Makefile b/board/engicam/stm32mp2/Makefile
> new file mode 100644
> index 000000000000..e86afc9c9e34
> --- /dev/null
> +++ b/board/engicam/stm32mp2/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
> +#
> +# Copyright (C) 2026 Amarula Solutions, Dario Binacchi <dario.binacchi@amarulasolutions.com>
> +# Copyright (C) 2026 Engicam srl
> +#
> +
> +obj-y += stm32mp2.o
> diff --git a/board/engicam/stm32mp2/microgea-stm32mp2.env b/board/engicam/stm32mp2/microgea-stm32mp2.env
> new file mode 100644
> index 000000000000..1f50f68d4972
> --- /dev/null
> +++ b/board/engicam/stm32mp2/microgea-stm32mp2.env
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause */
> +/*
> + * Copyright (C) 2026 Amarula Solutions, Dario Binacchi <dario.binacchi@amarulasolutions.com>
> + * Copyright (C) 2026 Engicam srl
> + */
> +
> +/* Default display of the carrier board */
> +display=rk050hr345-ct106a
> +extension_overlay_addr=0x90300000
> diff --git a/board/engicam/stm32mp2/stm32mp2.c b/board/engicam/stm32mp2/stm32mp2.c
> new file mode 100644
> index 000000000000..5f3afd877a11
> --- /dev/null
> +++ b/board/engicam/stm32mp2/stm32mp2.c
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
> +/*
> + * Copyright (C) 2026 Amarula Solutions, Dario Binacchi <dario.binacchi@amarulasolutions.com>
> + * Copyright (C) 2026 Engicam srl
> + */
> +
> +#define LOG_CATEGORY LOGC_BOARD
> +
> +#include <alist.h>
> +#include <config.h>
> +#include <env.h>
> +#include <extension_board.h>
> +#include <log.h>
> +#include <dm/ofnode.h>
> +#include <linux/string.h>
> +
> +int checkboard(void)
> +{
> +	const char *fdt_compat;
> +	int fdt_compat_len;
> +
> +	fdt_compat = ofnode_get_property(ofnode_root(), "compatible",
> +					 &fdt_compat_len);
> +
> +	log_info("Board: stm32mp2 (%s)\n",
> +		 fdt_compat && fdt_compat_len ? fdt_compat : "");
> +
> +	return 0;
> +}
> +
> +static const char *microgea_get_display(void)
> +{
> +	const char *display = env_get("display");
> +
> +	if (!display || !*display)
> +		display = env_get_default("display");
> +
> +	return display;
> +}
> +
> +int board_late_init(void)
> +{
> +	const char *fdt_compat;
> +	int fdt_compat_len;
> +
> +	if (IS_ENABLED(CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG)) {
> +		fdt_compat = ofnode_get_property(ofnode_root(), "compatible",
> +						 &fdt_compat_len);
> +		if (fdt_compat && fdt_compat_len)
> +			env_set("board_name", fdt_compat);
> +	}
> +
> +	if (!env_get("fdtfile"))
> +		env_set("fdtfile", CONFIG_DEFAULT_DEVICE_TREE ".dtb");
> +
> +	return 0;
> +}
> +
> +/*
> + * The display is described by the Linux devicetree overlay
> + * <fdtfile without .dtb>-overlay-<display>.dtbo
> + */
> +static int microgea_extension_board_scan(struct udevice *dev,
> +					 struct alist *extension_list)
> +{
> +	struct extension display = {0};
> +	const char *fdtfile, *name;
> +	int len, ret;
> +
> +	name = microgea_get_display();
> +	if (!name || !*name)
> +		return 0;
> +
> +	fdtfile = env_get("fdtfile");
> +	if (!fdtfile) {
> +		log_err("fdtfile not set, cannot select the display overlay\n");
> +		return -ENOENT;
> +	}
> +
> +	len = strlen(fdtfile);
> +	if (len > 4 && !strcmp(fdtfile + len - 4, ".dtb"))
> +		len -= 4;
> +
> +	ret = snprintf(display.overlay, sizeof(display.overlay),
> +		       "%.*s-overlay-%s.dtbo", len, fdtfile, name);
> +	if (ret >= sizeof(display.overlay)) {
> +		log_err("display overlay name too long\n");
> +		return -ENAMETOOLONG;
> +	}
> +
> +	strlcpy(display.name, name, sizeof(display.name));
> +	strlcpy(display.owner, "Engicam", sizeof(display.owner));
> +	strlcpy(display.other, "Display", sizeof(display.other));
> +	if (!alist_add(extension_list, display))
> +		return -ENOMEM;
> +
> +	return 1;
> +}
> +
> +U_BOOT_EXTENSION(microgea_extension, microgea_extension_board_scan);
> +
> +U_BOOT_DRVINFO(microgea_extension) = {
> +	.name = "microgea_extension",
> +};
> diff --git a/configs/stm32mp25-microgea-rmm_defconfig b/configs/stm32mp25-microgea-rmm_defconfig
> new file mode 100644
> index 000000000000..34933f1e7e41
> --- /dev/null
> +++ b/configs/stm32mp25-microgea-rmm_defconfig
> @@ -0,0 +1,105 @@
> +CONFIG_ARM=y
> +CONFIG_ARCH_STM32MP=y
> +CONFIG_SYS_MALLOC_F_LEN=0x600000
> +CONFIG_ENV_SOURCE_FILE="microgea-stm32mp2"
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x90000000
> +CONFIG_ENV_OFFSET=0x900000
> +CONFIG_ENV_SECT_SIZE=0x40000
> +CONFIG_DEFAULT_DEVICE_TREE="st/stm32mp257d-engicam-microgea-rmm"
> +CONFIG_SYS_BOOTM_LEN=0x2000000
> +CONFIG_SYS_LOAD_ADDR=0x84000000
> +CONFIG_STM32MP25X=y
> +CONFIG_DDR_CACHEABLE_SIZE=0x10000000
> +CONFIG_CMD_STM32KEY=y
> +CONFIG_MFD_STM32_TIMERS=y
> +CONFIG_ENV_OFFSET_REDUND=0x940000
> +CONFIG_TARGET_MICROGEA_STM32MP257=y
> +CONFIG_SYS_MEMTEST_START=0x84000000
> +CONFIG_SYS_MEMTEST_END=0x88000000
> +CONFIG_API=y
> +CONFIG_SYS_MMC_MAX_DEVICE=3
> +CONFIG_FIT=y
> +CONFIG_DISTRO_DEFAULTS=y
> +CONFIG_BOOTDELAY=1
> +CONFIG_BOOTCOMMAND="run bootcmd_stm32mp"
> +# CONFIG_BOARD_INIT is not set
> +CONFIG_SYS_PROMPT="STM32MP> "
> +# CONFIG_CMD_BDI is not set
> +CONFIG_CMD_BOOTZ=y
> +CONFIG_CMD_ADTIMG=y
> +# CONFIG_CMD_ELF is not set
> +CONFIG_CMD_EXTENSION=y
> +CONFIG_CMD_MEMINFO=y
> +CONFIG_CMD_MEMTEST=y
> +CONFIG_CMD_CLK=y
> +CONFIG_CMD_FUSE=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_PWM=y
> +# CONFIG_CMD_LOADB is not set
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_MTD=y
> +CONFIG_CMD_CACHE=y
> +CONFIG_CMD_TIME=y
> +CONFIG_CMD_RNG=y
> +CONFIG_CMD_TIMER=y
> +CONFIG_CMD_REGULATOR=y
> +CONFIG_CMD_LOG=y
> +CONFIG_CMD_UBI=y
> +CONFIG_OF_LIVE=y
> +CONFIG_OF_UPSTREAM_BUILD_VENDOR=y
> +CONFIG_OF_UPSTREAM_VENDOR="st"
> +CONFIG_ENV_IS_NOWHERE=y
> +CONFIG_ENV_IS_IN_MMC=y
> +CONFIG_ENV_IS_IN_SPI_FLASH=y
> +CONFIG_ENV_IS_IN_UBI=y
> +CONFIG_ENV_REDUNDANT=y
> +CONFIG_ENV_UBI_PART="UBI"
> +CONFIG_ENV_UBI_VOLUME="uboot_config"
> +CONFIG_ENV_UBI_VOLUME_REDUND="uboot_config_r"
> +CONFIG_ENV_MMC_DEVICE_INDEX=-1
> +CONFIG_NO_NET=y
> +CONFIG_SYS_64BIT_LBA=y
> +CONFIG_BUTTON=y
> +CONFIG_BUTTON_GPIO=y
> +CONFIG_SCMI_FIRMWARE=y
> +CONFIG_GPIO_HOG=y
> +CONFIG_DM_I2C=y
> +CONFIG_SYS_I2C_STM32F7=y
> +CONFIG_LED=y
> +CONFIG_LED_BOOT=y
> +CONFIG_LED_GPIO=y
> +CONFIG_STM32_OMM=y
> +CONFIG_SUPPORT_EMMC_BOOT=y
> +CONFIG_STM32_SDMMC2=y
> +CONFIG_MTD=y
> +CONFIG_DM_MTD=y
> +CONFIG_USE_SYS_MAX_FLASH_BANKS=y
> +CONFIG_MTD_SPI_NAND=y
> +CONFIG_DM_SPI_FLASH=y
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
> +CONFIG_SPI_FLASH_SOFT_RESET=y
> +CONFIG_SPI_FLASH_MACRONIX=y
> +CONFIG_SPI_FLASH_SPANSION=y
> +CONFIG_SPI_FLASH_STMICRO=y
> +CONFIG_SPI_FLASH_WINBOND=y
> +# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
> +CONFIG_SPI_FLASH_MTD=y
> +CONFIG_PINCONF=y
> +CONFIG_DM_REGULATOR_FIXED=y
> +CONFIG_DM_REGULATOR_GPIO=y
> +CONFIG_DM_PWM=y
> +CONFIG_PWM_STM32=y
> +CONFIG_RAM=y
> +# CONFIG_STM32MP1_DDR is not set
> +CONFIG_DM_RNG=y
> +CONFIG_SERIAL_RX_BUFFER=y
> +CONFIG_SPI=y
> +CONFIG_DM_SPI=y
> +CONFIG_STM32_OSPI=y
> +CONFIG_STM32_SPI=y
> +# CONFIG_OPTEE_TA_AVB is not set
> +CONFIG_WDT=y
> +CONFIG_WDT_STM32MP=y
> +CONFIG_WDT_ARM_SMC=y
> +# CONFIG_UBIFS_SILENCE_DEBUG_DUMP is not set
> +CONFIG_ERRNO_STR=y

Hi Dario

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
