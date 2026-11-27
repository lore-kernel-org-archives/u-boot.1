Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F724606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 10:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QBrPXekN;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=PY6gKBtq
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8695C80EA2;
	Fri, 27 Nov 2026 10:28:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LchWqC4i6lSO; Fri, 27 Nov 2026 10:28:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A63C280C88
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795775300;
	b=RURet2s78aSAPTgMMBOFNIE84lqF0LqbWm5ivBRwmmyXVEE9YWnBN/gDVYUdzVrK+81l
	 xhVEV2EhtLV7IR+ALvKto3ndnJ7V9MnVwaRgfUovQ4FYoTU4zsI4CTFsS+F/NeB9zbPyz
	 nleHUz+3pfMvWqk5LoxZdAxmsdpxRjZ6tRKEcquTPmcgWs39lCKq9gl5dLDBY6xABenRx
	 YbZM3UJlYpb5ivVhVaabtm7ML7SSY+tAzpXDi2y7U8m8CcfWrDJ/GM2fLakoXKiAgkaH0
	 POqC+HUbu/yiDsjfawVcf1lGGsQEup3oyzcb51p8c6MPmS+KVIzgS4YjuwcriioTbrw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795775300;
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
	bh=dlaK0YWpe0EB/5W9gbHhdLyur4VkhNQiZHs5WyZVNXQ=;
	b=IV8EgjqE/4/M4OmdKLRsl9ONpnn5Hg4yBT846785LLop0DzgSZSdZxBDrGS7LFo8GBnr
	 JHd6TPTSCAoF2WKQ0R+e5Yy4/P/XCnswg+JVfrm02CWoPlovzs1r/X06Itl0e+KM4iXJ9
	 0tnoUY7MuwoiCbjj1olqyApQWVgU8ZlPEI5RcY62sSyo35FekTAQdUOUQKtXaTT8FmhiI
	 If4HhO08O6Rhav+0pVrdOUmx5H3PZRidnc6l327nW/sgc0nG+fuDrQQXNylhoDlcUInNX
	 yTq2oSW6vvYyywnnR8DOsUHa7YZpZIvxFd/KK7+j7erYrjUYgx32n57Hgqh/RJ880Sw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795775300;
	bh=dlaK0YWpe0EB/5W9gbHhdLyur4VkhNQiZHs5WyZVNXQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QBrPXekN5uWfFktMC6LYdqKCazbztQhfqBVhr+QC50AIWxfEWRronRsRUdnDu6HLb
	 KhlFVzr6tqhCHRL5D3SOXKKKc4l1v8+PbnS6WBG8T+j6JedggmVv75HrUSgqI5ugBY
	 hzG65UvPThN2gOIQ6nV72CsTHr1wl/OYLQIIk5rC8bSs11KKu5v2r5bVKA6qvMc0nJ
	 gzB/GhgboggcTLviKuQ3f/N5f/AJq66/72q0fIVwRVFDgCJb2N3c8bdFpfDRPWRwqW
	 SxO2/dkfKFk6FYnQzu2unszl+H3M3zWRCm8m20Mny9Sv6QtITLdx8z8f35h2G7+MI9
	 HlMRYNhhzLHOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A63C280C88;
	Fri, 27 Nov 2026 10:28:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D6F2373
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:28:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 73C1060AC4
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:28:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FL7DSJyptvLc for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 10:28:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 89D7560AAA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=yannick.fertre@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=PY6gKBtq
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 89D7560AAA
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dlaK0YWpe0EB/5W9gbHhdLyur4VkhNQiZHs5WyZVNXQ=;
 b=PY6gKBtqwIDspBIj+sje0jIQIqFSJiMRx2jCapBfc5qaAA6g+zskSOIM6uEnC+ha4THXNwMqZcfY/SwRePXRkazyVmx43kbQ/oBHt5TW2n1AarA5NlxDdC6n9dxItD7BAdnUHh0bN3wvKPxI9hHUmqDWp+g30bsi0hxR/qfzHzX6n2dG4SdKfj2zMxxYwowjdL2lfhV5qbHPlBfegH2vEEZxea7yB9tIkMygsi2HxD3hNmh58YuMlXHFVqI8pIZ/ncqBYEAl5VNaLSv5b+43KlUZ1Apr4UuOmc/zRik7VxIrXptGoT/yK9Z8rXmlrm/Nq1Bc3ZryFixFcB/9/xdgXQ==
Received: from DU7P191CA0024.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::16)
 by PAXPR10MB5518.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:23c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.688.5; Fri, 27 Nov
 2026 10:28:11 +0000
Received: from DU2PEPF00028D0A.eurprd03.prod.outlook.com
 (2603:10a6:10:54e:cafe::1f) by DU7P191CA0024.outlook.office365.com
 (2603:10a6:10:54e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.10 via Frontend Transport; Fri,
 27 Nov 2026 10:28:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DU2PEPF00028D0A.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 10:28:10 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 11:29:13 +0100
Received: from [10.48.87.178] (10.48.87.178) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 11:28:06 +0100
Message-ID: <7dfedbc8-8ae3-4c1d-a1ec-8c07d784496e@foss.st.com>
Date: Fri, 27 Nov 2026 11:28:06 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 29/35] video: stm32: ltdc: select the pixel clock
 source on STM32MP25
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>
CC: <michael@amarulasolutions.com>, <linux-amarula@amarulasolutions.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.denx.de>, <u-boot@lists.u-boot-project.org>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
 <20261107143241.2236511-30-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Yannick FERTRE <yannick.fertre@foss.st.com>
In-Reply-To: <20261107143241.2236511-30-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0A:EE_|PAXPR10MB5518:EE_
X-MS-Office365-Filtering-Correlation-Id: ebba0ed6-f7dd-40ad-d484-08df4c7122c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|10067099003|56012099006|11063799006|5023799004|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261102123227099003|261009223027099003|18002099003|22082099003|4143699003|3023799007;
X-Microsoft-Antispam-Message-Info: 7LKrAqz7XkbHL7cZpgGOWVdaT5K28qlgdq3pX4mTPIDVX1trSpF1yMipLrpedcqckaeZItdtrzGO68HIe9GW33uwcSjCHX9nZcQyNZPxD4hRstPM0i+ztgD1uJ1wRxAoXdY+/uat7sEbtRRT/MRIt9Wr99TlR78eKM9Eccppojgc6OEg0AIpYE5FE4Z1hExu97OR+ZSqLjjj4O3N3TBp1viyck5J63hUyC+VuFMHdFgS/keSDdPyyZcR0x2qcw/4gcpUaxD8r24ktUhqSXss+5oeZggbVKX24H4r//y9jJdS34YZq1g0M+Ps8NJvMEiLBbeTgCeww9OGK5c1A0mJJH5GMCcb+SAcRS4TKGtvqsTOq5C9dNuNaM/OoM8GHgtfcDO4HBrV0SvUbVEC7w9drMLOZ+MoF+hT2krGrI12PpDvIVmhM+kvDdekSmthNKDCEyWmrx1dTPooPQaDVEeQGCP8n6r8kXB3LVr3fzmHVmP8ed7JUvo5m5JKvotWqKUDHL+ZwnesLak1IMZefURRiopMNH7RnAULPrgaL0gj9d89NbbpAFyvHdb6EpB2GCK9ixoJRv846LuGb3bLm27qzWPwQZcWgRWGKu/PzLbgEc5gkPnUHyQckdEs1tYfde/Kx31JkuWShdmAvSvL4wRiofmUu5BEjnJq3nP6KZYlNvGDyUySkdsXof3jRO3kPz/Qzh//a9vqhJpTqLL/Ejk1mA==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(10067099003)(56012099006)(11063799006)(5023799004)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(4143699003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VAVrqQfBolmBkPsSLQIGeIZyWVm5nJGX3r58/x7UGq9hsHlsGqKyxztk9ZSbZb0BwZvCF8+GOdKoRYqgmP9tXGWc8GGIjD9epmjHwNrUUes+qWTnbSNTBUFGYA/X9hAIdMAR1kTWFyXCZx5fO772hlaSIECe18I3wlwXO7Fb0bnm7X5zWU0wZWqLzb/D2Ib7QAFvUs0st2jApJSHcWGI7DsGabE8N/uLEPq1j90zYahw7C2YdBb9NG4ndp4PL32iQ9DEaAvo4uhrpkPTqP6rV+TXzPhBG4MghdnRvHBdU3JybTe9do4t7/mcgH6xPVGbIo2Z/DiyuhcqT0+DT7yhL1qhy9dYWCUOmqgHOf5H/Yby+CCm47MBYdlH/PapjowTypxvJrIOAjkPh4jWo7m0Otp9yRJDAXPH225S7vOglOaMPZT5w6XtHoxDhyiZaF8/
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 10:28:10.7190 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebba0ed6-f7dd-40ad-d484-08df4c7122c7
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D0A.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5518
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

Hi Dario,

the LVDS is available only on stm32mp255 and stm32mp257.
This patch depends on  compatible.

Add some lines like this:

     if (ofnode_device_is_compatible(dev_ofnode(dev), 
"st,stm32mp255-ltdc")) {

	ret = stm32_ltdc_set_pixel_clock_source(dev);

Best regards

On 11/7/26 15:32, Dario Binacchi wrote:

> On STM32MP25 the LTDC pixel clock is selected by the SYSCFG DISPLAYCLKCR
> mux, referenced by the "ref" clock of the LTDC, whose reset value is the
> LVDS PHY clock. As nothing programs it, a panel connected directly to
> the LTDC gets no pixel clock.
>
> Select the LTDC kernel clock when a panel is connected directly to the
> LTDC, and the LVDS PHY clock when the LTDC feeds the LVDS bridge.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
>
> (no changes since v1)
>
>   drivers/video/stm32/stm32_ltdc.c | 52 ++++++++++++++++++++++++++++++++
>   1 file changed, 52 insertions(+)
>
> diff --git a/drivers/video/stm32/stm32_ltdc.c b/drivers/video/stm32/stm32_ltdc.c
> index da580a78a5db..997042233171 100644
> --- a/drivers/video/stm32/stm32_ltdc.c
> +++ b/drivers/video/stm32/stm32_ltdc.c
> @@ -12,7 +12,9 @@
>   #include <dm.h>
>   #include <log.h>
>   #include <panel.h>
> +#include <regmap.h>
>   #include <reset.h>
> +#include <syscon.h>
>   #include <video.h>
>   #include <video_bridge.h>
>   #include <asm/io.h>
> @@ -275,6 +277,12 @@ static const u32 layer_regs_a2[] = {
>   #define HWVER_40100 0x040100
>   #define HWVER_40101 0x040101
>   
> +/* STM32MP25 SYSCFG pixel clock mux, described by the "ref" clock */
> +#define SYSCFG_DISPLAYCLKCR		0x5000
> +#define DISPLAYCLKCR_DPIVSLVDS		GENMASK(1, 0)
> +#define DISPLAYCLKCR_LVDS		1
> +#define DISPLAYCLKCR_DPI		2
> +
>   enum stm32_ltdc_pix_fmt {
>   	PF_ARGB8888 = 0,	/* ARGB [32 bits] */
>   	PF_ABGR8888,		/* ABGR [32 bits] */
> @@ -709,6 +717,44 @@ static int stm32_ltdc_of_to_plat(struct udevice *dev)
>   	return ret;
>   }
>   
> +/*
> + * On STM32MP25 the LTDC pixel clock is selected in SYSCFG_DISPLAYCLKCR
> + * among the DSI byte lane clock, the LVDS PHY pixel clock (reset value)
> + * and the LTDC kernel clock, which is used with the RGB output. Select
> + * it according to the device connected to the LTDC.
> + */
> +static int stm32_ltdc_set_pixel_clock_source(struct udevice *dev)
> +{
> +	struct stm32_ltdc_plat *plat = dev_get_plat(dev);
> +	struct ofnode_phandle_args args;
> +	struct regmap *regmap;
> +	int index, ret;
> +	u32 src;
> +
> +	index = dev_read_stringlist_search(dev, "clock-names", "ref");
> +	if (index < 0)
> +		return 0;
> +
> +	if (!plat->bridge)
> +		src = DISPLAYCLKCR_DPI;
> +	else if (device_is_compatible(plat->bridge, "st,stm32mp25-lvds"))
> +		src = DISPLAYCLKCR_LVDS;
> +	else
> +		return 0;
> +
> +	ret = dev_read_phandle_with_args(dev, "clocks", "#clock-cells", 0,
> +					 index, &args);
> +	if (ret)
> +		return ret;
> +
> +	regmap = syscon_node_to_regmap(args.node);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	return regmap_update_bits(regmap, SYSCFG_DISPLAYCLKCR,
> +				  DISPLAYCLKCR_DPIVSLVDS, src);
> +}
> +
>   static int stm32_ltdc_probe(struct udevice *dev)
>   {
>   	struct video_uc_plat *uc_plat = dev_get_uclass_plat(dev);
> @@ -719,6 +765,12 @@ static int stm32_ltdc_probe(struct udevice *dev)
>   	ulong rate;
>   	int ret;
>   
> +	ret = stm32_ltdc_set_pixel_clock_source(dev);
> +	if (ret) {
> +		dev_err(dev, "pixel clock source selection error %d\n", ret);
> +		return ret;
> +	}
> +
>   	ret = clk_enable(&plat->bclk);
>   	if (ret) {
>   		dev_err(dev, "bus clock enable error %d\n", ret);
