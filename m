Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2A7606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 18:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tbt9lxfB;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=G5XYp88T
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F803810BB;
	Fri,  6 Nov 2026 18:39:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oeyYVyWSd5kM; Fri,  6 Nov 2026 18:39:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 498848109E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793990342;
	b=k2jvBOvFezed4ocmS2atOij9COXyUxpi3IqjB7cxuUu+Yut/367lEzobvebzFL+aT88I
	 1NY7bbYYcmrgCU3/jDdDtM71g5E+bU3dBg0ylGIyRrz753pXpUenZSYIX1qLY++8GRSl2
	 knj8qLD5J15wG6Mb64y0uqJfLAGTj1+Wpv3q4X8LItpCkGV53iyBGdYN9ZB3OFhX9BRKP
	 Nu9NAo0t9vMvs1eTvKdGq7zmEV90TcG/Uo3nf49dzz2Yat+TBbfVfPIHJ6jVOQertau4k
	 zj6j6UGf/SFRR/9k9Om6wD/3FyGw1ywfHKlxJk0KINIbb1g4Xdm5DWiUKXb+PTKSaKw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793990342;
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
	bh=u51FGcrp9zUTgjag5awm5zdPYX8gr0q+nusA8tM+Dc8=;
	b=BYTT4+l9gHQuHu25VeAhS5zEzOF8S0kogI2k2F1SqN/UNjMxz8LapWZM7Bl5UpYXDJeH
	 aIQtrmkaE6AGQlMhLOTkxegFnJT/H669eF50hNU3cVyt/49+f6fM/nY/nxgRMBRceK2pG
	 b8mzTf4Ql1K6QbfVxtlsuuM7N/CBhkBX2Oz0R2Ep4vvUKXDue6XT4mvZ3MGMdsvwrSZ9U
	 hBMZ39QpnKBP/omHVzkBvZg5q34ORqD/0mfhbO+k3dyKEP1b83nxNcQVqUtQGZMUIWRix
	 NVCJcPs8MSEVW0oNqU8+eHtOjIA0KHhm5ZS74STXc0gIdENbzBY/2jjWzFXv6t7xHHg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793990342;
	bh=u51FGcrp9zUTgjag5awm5zdPYX8gr0q+nusA8tM+Dc8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tbt9lxfBdKlqqX5t+hSpuX91CWJE0s2I0+3l2NbaAV0aq+ctaIqIrASMsxW/34Xsg
	 xK+J/TPSUVuc8mkav1xC82pUSVibVOI+xCELBoZMVyVLocBwkkghibb9m8CKqN7/dH
	 6IeLKeWe5U+yQpptNFr3vxfESA8EVm/v3a4/IO1UuwRe2cVkD66ANrnFhMeTVdRUOJ
	 znWpSeGPop7pvzJj8ECEpnPswdZnUWLG0BtI/A6ltrFwnQapHToJlX5nEtW8VCzZiJ
	 H8II79vBBbr149CtSl56klNwQiiTcZjrx91Ijc3lJnRgFYxyMPsIj74x2WTUYdiuHS
	 KyzAEyl44IooA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 498848109E;
	Fri,  6 Nov 2026 18:39:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7213B4B8
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:39:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 57F9960744
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:39:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8I7IM6eWB0GD for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 18:38:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B314760771
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=patrick.delaunay@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=G5XYp88T
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B314760771
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u51FGcrp9zUTgjag5awm5zdPYX8gr0q+nusA8tM+Dc8=;
 b=G5XYp88TS9xXVB1+MjlGvanZBPLOEAld2dLXn/D3obkq8s87oZIfMK2LpjL22uBNpWbl7xxCL8LJMX00xxLxlQ5LuA5w3o7T8PR6lGaj2ESb1rHuxioCbaT7qfAnBsF0qsQ5VJEqHmeG5gAd/Ix5VrPVdNNvSWkZymdD7mYA6bTqdtr6jvj9K6REzMLtIbw1kLnHRaER4qaQA5JrQ0Ao3mHc5cP4embDpaxHQ1Aksf1OoHCzEPfO87J0/wwxHr9OH/9jAXCnWIJHouYTyoYAWMvRJyjvdmA9rbNjERAGk7dlYaOpyXPTlzlh0qx8114McLwoH92dO2GWjhSujMUDkg==
Received: from AS4P190CA0017.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d0::7)
 by AS8PR10MB7206.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:61a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.4; Fri, 6 Nov 2026
 18:38:53 +0000
Received: from AMS1EPF00000091.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d0:cafe::97) by AS4P190CA0017.outlook.office365.com
 (2603:10a6:20b:5d0::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 18:38:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS1EPF00000091.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 18:38:53 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 19:39:23 +0100
Received: from [10.48.87.100] (10.48.87.100) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 19:38:52 +0100
Message-ID: <3ec3c6d4-1495-4d63-b471-75b549ff5a53@foss.st.com>
Date: Fri, 6 Nov 2026 19:38:53 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] clk: stm32mp1: add support for IWDG1
To: Antonio Borneo <antonio.borneo@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Tom Rini <trini@konsulko.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Lukasz Majewski
 <lukma@nabladev.com>
CC: Thomas Bourgoin <thomas.bourgoin@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.u-boot-project.org>
References: <20261105165253.587809-1-antonio.borneo@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20261105165253.587809-1-antonio.borneo@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000091:EE_|AS8PR10MB7206:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dbb68b8-352d-4557-7f4f-08df3c35354a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|22082099003|18002099003|10067099003|56012099006|11063799006|261026121527099003|261021123027099003|261009223027099003|261021121427099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: /NomP0jy/XfLzoplYLLJGoaBG5fEjm9bYW3zlqLFgHlkyd8/eSuWEf+ONXxYKd8/HWJh8qNP1/ELvPkbxYD9dZkWDkLl9hoMw8zlK0qZ/ENzMq/13BmQDBg2aHQrCleAXiBZb+VFMH8BOSYUX4+wZRGzvVXD47lS8WIR1Tav6X0SYi30ZkV2Dj1/7BQGoBNS/H/ibyxj1fHE26kRyxOsIKvMVrJOMKK0ILLqhwWhyr+jkIeXr8F9fDZk9XcYHc5w4LLaOcw+3uqQ/i20RomigLgU0qWrgDw1OBfIca9LJKb4YwHzUJ3ob6rcZ1j1coDcAm22g7ZshzhWZ9yuCSFRhAs7KCuXuUazUNHc24JyJTHqP+Lw7xPoWyyh2QjDEUjOQ2G5xzIDGZEEM1x5QciIoLxm0Zo9XK2Qg68g0aVfSg0H71We3paFWVPJgzL57xmNcI5we9STII+dEqoOxFI54mSP4dfG0AG9T9iYEKJr/rDU/InZ6MYABFADnatLJUiIcH6PBjEyMaGlGQ2PPmffjqPHbYWsoEfl5PEt8tcJbb9SFbAnZMFkjtghssVrx9wJe6TP4k2Nnuk3ofhUSvI2LMgIgRyMPSpXu/vA12VskGhI9ewRdS/TW1+b2qve6WN+CLBaCKr1XCyOTiby2sQ6pjh+3HoBlkFB/PvGyg+HTCzwwAQsXeI8v+V9zWpwNX8y5mwuHYu6lNxcsMl9gOT41Q==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(261026121527099003)(261021123027099003)(261009223027099003)(261021121427099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IzeEHwb/b4jqR+eRlEdWeVZzWuz848oqfKWN/QuzsFGacLdnLI8wG98ygVfIWjs55MaM3C8+CpdytfSSZJoAqvCEaMumwWPqd9zFEWYwnOiICBgQx0Y0NykrXrwODgnuT4P4f+H7VGzmPDwWpPXZgJEhCf4TQ1UE8/9KAnNXx0DsbMSBHXRKXb0+CmvmbBMpt4zgyurABetBjMuuDcSoQVD7dZZsc6vsALhkEdw2VgDf5Q3BGc1ZqnMz/e+mjQkJhSuTwjo7F5hXN8Vt1AmsaNoWAKy7+z6Q/kdZmeXvQM7CO5uf6WvJNgmAHexKz/KTfYOMpn6tG+91ZEMd3oqsOQQtW/4u2s98T+TvKUQRc7+CNK6SwYYjBS++eeNQXMi/lsciG8xySlL4zr9xVdOjNgUwWQSjoOQjxyHusj8srKIffCaS/VOooGAERhZmYZN2
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 18:38:53.4030 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dbb68b8-352d-4557-7f4f-08df3c35354a
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000091.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7206
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

On 11/5/26 17:52, Antonio Borneo wrote:
> From: Thomas Bourgoin <thomas.bourgoin@foss.st.com>
>
> Add the missing IWDG1 peripheral clock, controlled by the
> IWDG1APBEN bit (at position 15) in RCC_MP_APB5ENSETR.
>
> This allows SPL or U-Boot to ping IWDG1 if it was started
> by the hardware or by an earlier boot stage.
>
> Signed-off-by: Thomas Bourgoin <thomas.bourgoin@foss.st.com>
> Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
> ---
>   drivers/clk/stm32/clk-stm32mp1.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/clk/stm32/clk-stm32mp1.c b/drivers/clk/stm32/clk-stm32mp1.c
> index 823ce132d0b..04087cabc14 100644
> --- a/drivers/clk/stm32/clk-stm32mp1.c
> +++ b/drivers/clk/stm32/clk-stm32mp1.c
> @@ -561,6 +561,7 @@ static const struct stm32mp1_clk_gate stm32mp1_clk_gate[] = {
>   	STM32MP1_CLK_SET_CLR(RCC_MP_APB5ENSETR, 3, I2C6_K, _I2C46_SEL),
>   	STM32MP1_CLK_SET_CLR(RCC_MP_APB5ENSETR, 4, USART1_K, _UART1_SEL),
>   	STM32MP1_CLK_SET_CLR(RCC_MP_APB5ENSETR, 8, RTCAPB, _PCLK5),
> +	STM32MP1_CLK_SET_CLR(RCC_MP_APB5ENSETR, 15, IWDG1, _UNKNOWN_SEL),
>   	STM32MP1_CLK_SET_CLR(RCC_MP_APB5ENSETR, 16, BSEC, _UNKNOWN_SEL),
>   	STM32MP1_CLK_SET_CLR(RCC_MP_APB5ENSETR, 20, STGEN_K, _STGEN_SEL),
>   
>
> base-commit: dfcfc4c9f78d1743f490a497082a4ec8e058aae8


Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>


a missing clocks, as IWDG1 wasn't activated in non-secure until now

but no reason to don't support this use-case for basic boot weth SPL

or to have a special behavior for this APB5 clock


PS: for trusted boot: OP-TEE use the IWDG1 and when RCC is secured with 
TZEN=1

      then all clocks in RCC_MP_APB5ENSETR are secured

Thanks
Patrick

