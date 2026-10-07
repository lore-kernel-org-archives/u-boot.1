Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D71CA5FF1
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 08:08:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8395F406A3;
	Wed,  7 Oct 2026 08:08:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WyQgLmpGQDZl; Wed,  7 Oct 2026 08:08:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CE31D40562
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791360509;
	b=KlaJEAtSKcAwS1iID6h60qGydr/otRqT4mJjPNg1DJlOrj+OoDq4CwtkwMSpo1FOwMHS
	 tUo5LdvvzPm6JrEniTb6b/fd6kraZXVw9xwuoZJXHYqm1wHABAQjwqWjYc4+knvaGPimG
	 mZ9AEZhr1Cadhbe9TT7MwilFpscm6Wayly5b/hQrZSyJJEvx0midHq3P5G/qOFuVeCBN1
	 wbdRHfEaBFxTCFzqmQqUtX3K/SLuWHEH74ECyEiFdjZpOC7YDVDdE76tz/teU3QTDXDiw
	 I1rxS3joZ8TMh6ALX5nyh6navoQ5RQtr93jBY0KAZY7EIAGGxkRA5Z4iU+AR/RwO5dQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791360509;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RztC/lX8oY8GDWJ7Ax5oUxBuzSPX+CugMJAddS/dzx0=;
	b=kRMwaJTSbUtWUefT2Pjz/WxNOKwhUOg7e+Wo54tHRnYZez+/CXMbQlH5RhaIZ25ZMJAg
	 1IJ7V3mSHJhr/70oUfoo5b01CEF7ae3guL4RdRzdB+oBkzKldKcpudvnKva6veQ76cqKn
	 CI4X2o6UiMK5gm/crfHvFK3XMKXtOdeih/HxkATXs8LWlMbyZqtLP7HWStZsAECu3c548
	 BbYlrKTGM283kyMiwtwirHQk5UDs1polt3t3hfiyNCmZymz15gbOzUDhXxj0QsY65w0PX
	 pH3siz16dxeAFCYur74AsoCm5+Pguvuf7hcV7WJY6itaIoJfqxcgLeYgO5J0nZZvHpQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791360508;
	bh=RztC/lX8oY8GDWJ7Ax5oUxBuzSPX+CugMJAddS/dzx0=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ia1mA8eWTlCu3wi+TT68MvzC4I5D5np/CrVz1IqWneA7HOH5cnrWx05h/Tvtj+LNU
	 +rYpDrJEFozhshLiVPWQcfMCBRZ1I70+OQxlADQijRKsrlP+bLKX173TqKwFdgV8oS
	 2ynE2cB+uw1wX1yVKtgQYYSBdWTwymWF4ovyvgL7uKTRJl8W9TsoGPdS6wsJudGpPz
	 7S+VjPUx5KjD2HBtL04NCvfsrtGbtCRzfTHCx39LI7CZC3Dt6foJlYRDNYzk//0xC4
	 JM7TsjrviMtW4AulBXefzoYg696ma8GveD+KTc2P5zyYg3PBmSTJCcWcte8WBcXAS/
	 WBHPqScARHPOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE31D40562;
	Wed,  7 Oct 2026 08:08:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 92E6F341
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 07:58:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6D4E6400E5
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 07:58:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id raxXSwCP3agY for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 07:58:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 494D540070
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791359903;
 b=MCgVmhtU5YiSYyRadhdDHBbLlpY1yfwBj8FT1keqIslYldH0+EWrxkZ2vNR0Xr+TryGf
 7txiCDhKoblaO972BRN5oV3MDZ231oZjbB0ukle59hGQfXM3QhCN6dAJ7wFuo0WE3wJq7
 uWZ2265kuZm9s57ssNP9v6h1NcOBnbTlTu9v8ycmn4dCzx06Im8y8h9lojiqpKDVvyUIX
 P6R4OXwTlbuOahSE4bEdbQHcLxMFCifcuVHcuS/B0s5eG6aOYkH8dFbWIzVOZPAq2BI4a
 Q39sR02G7whE2ZHqgKIL/NOTQmCj3tkT4VnsiMO+aqVSXipSyAFVnnYqY4lWASh2N6w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791359903;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=RztC/lX8oY8GDWJ7Ax5oUxBuzSPX+CugMJAddS/dzx0=;
 b=pFm2vWAn+tGM+2gZx/0hBjMBrvtS9B9oqWvPHFeFDJ9i6o6OvTvlRFQe6RXJKQp2+ATs
 ZJsv8epCjlICKsJ5zgUEQ87CjUVR4NMoTwwKExxayY7Zr+JvHMc/+akyXuFB6MrKdTvQn
 xWAy+NX/DOpGtFazjw06c4e/Qr+ivXyP/AXstdHKnsco9vMhYOd0d6edr+ZBcTGwwFYFq
 iLLzK1xPUPDZEoqBt/aEyf/5j5W3cTnznHYPXmvz0ymIEHqwOEx++m3SLZEfQJyA2xh3l
 NdclW3ZJVcAYG1pJz7QfO5zGZItLqrbKoMLP4E+wScMm8MqPPsmSorGII5w1Q1b/mBQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=none header.from=kontron.de; 
 dkim=pass header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=ISbLcnel; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=frieder.schrempf@kontron.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=ISbLcnel
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 494D540070
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 07:58:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aWScSeN2mgo4JCkWgWxN04NRyLQKXlsRn43RX+IQnxyIjIj1ssfE8j80wsM7zXAgT2Yb826PN3cf1bIKKVLHF0VOYa9o14Krm6QUWY6iq8BXIDPElYzUWHY3B94v+mYICKzGz1uMG/UjtsVqumSxoal1rOCdDigUnakKK3u7xYswEa+6fZXgTGLu2c/TSxA6x8Ro0oKurxZoTOXLd37Ak2XlMtS5HC8/GVHGmfia5Aos96EjNJhNwQFcSWzWpoZIEwfTpKPRPsisvwg6WQtz1AHUpaEsokaEfKuEEw/fJu0xVXZrp4F5VqpFcUC/XN9kx17IddTxvfGq9sAMn9Of/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RztC/lX8oY8GDWJ7Ax5oUxBuzSPX+CugMJAddS/dzx0=;
 b=zJRzk/xEIFlKEa0ZBFqxq83dBTX7aAqP5XWVTDMPnSqLz5WYnxHRh2g8+XojFSsC0ML6fSj+YXk00z/sibSIANuLuhPwzI/491noAtBWLmWQRVvtu83uwukKaSDS5W+nt5l59VymsVQ0dzK/6E4ajtARwIIfoa6x9LIt6weKq9ZxuxlLzT9MzmODl5kuDaueNCPafXvJ0Eibt24bHl4YUwuKoIuCiTNcZunmYiZ0b0iOKdxj4+lvolxDyDDw8K5lYzVGnpSEhgWl1+PVfIb0tvetAus9KNsogkBGP54xjd8g1zYhDXQinJNiub7J7I1V/Rxuc6b7rHeCkZ0ESDNzhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RztC/lX8oY8GDWJ7Ax5oUxBuzSPX+CugMJAddS/dzx0=;
 b=ISbLcnelXs9HHhV1ZItJ4vmRtRIyfXiQFgO9XoNaU6P9KsFArcP+iV//n9+XqJqKwZDjEeTfg3X1xrwtWhoaOMsNz0E/Awb+8OcY18wEgO4A92orfXQnIxluYmC5Pc/ZiOQsUgaB1wfNWCCBt+idylergODlwmR/KqNKrm9H7KoMJ5S5aPAa8gD5awokdiH/quRoaJBxY+rqL9eLmtjVgHr4ezmA5+CBGASKZbgRzrBUDTTbK/wuvmnZqH0EA0fAOyrJrnkr9wbXkvM843uDvag+FELkq3ciGOByIxPLg4m9vyswYEF1LvxIQM2hOyhzq3jIl2I31M0mFrvw7YyBYw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM8PR10MB4273.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e4::18)
 by DB4PR10MB7421.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3f2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 07:58:15 +0000
Received: from AM8PR10MB4273.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fec3:eb34:f163:4536]) by AM8PR10MB4273.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fec3:eb34:f163:4536%6]) with mapi id 15.21.0472.016; Wed, 7 Oct 2026
 07:58:15 +0000
Message-ID: <ff78088e-83ed-4bae-b17c-938c8587dd24@kontron.de>
Date: Wed, 7 Oct 2026 09:58:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] mtd: nand: spi: sync spinand code with linux-7.3
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Vignesh R
 <vigneshr@ti.com>, Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Eugen Hristev
 <ehristev@kernel.org>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Mark Brown <broonie@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, u-boot@lists.u-boot-project.org
References: <20260927235716.1872707-1-mikhail.kshevetskiy@iopsys.eu>
 <20260927235716.1872707-6-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20260927235716.1872707-6-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::17) To AM8PR10MB4273.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1e4::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR10MB4273:EE_|DB4PR10MB7421:EE_
X-MS-Office365-Filtering-Correlation-Id: e5d25c9d-aa0a-4b1c-ac36-08df2448bd65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|7416014|921020|5023799004|4143699003|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3jAN2iPKZXCJIM7NPDotYtNPaBoGzP9zK27u2yj6faKXDjZ8DIRSC+nF+DiALILcfOC27wimhXF7TDNGWtqaRO7Fb8YaMUuStEGgYuN5rpFw1bIL+vSuNEk6spadQ1xn7a+DMfgqfgaQnO3u1gASpnZwccszHH3BYXNgz9apJIXhs+e1wueHk2NcgwgAF6zsvfZo8n5yh5kGvsmPPJCtznb92YIc/64+vqUzEbA2OsMbhriDC6Fvw3H39o57H891jgoidgQ4tbDzd+Fjokr9sWLAwI0UWbXd1yEfa/YfgDyn1K/VGs27WDr9dnzQnnQ3jGlwJxKOG32TJf6I/NXIbBOFx5CIXjAs/kVCCl37JUPfAlvOepQ+BrarUJY9kqWrCv98ZQWfoVFk6bQCph3Z5SkKab6aSVqUM4ftoVrHmidJn+xt6LzWH5VOQHGAanWI2tZR5inBg+PHJZm7cnIQ1lDhSeb0Cu8JR9eAndL5VXTuvIYGrsScm4EYuO50SfD6iHJufQTAN2NEqYyg9l1Iw0kQXtYoCGZNcmzdjz1ETme9H2/1UaVT2moTXPlZwu97faQpGGcjVHdrJIZDCHNDfFkZQqwlEPOnHWALSEAJrhZwLQ/CaJbpOERnnl2dv9haO2v0DsUxRRv6OGGz3W7/mOpbvzULNNFiBMwjvCzSoP6zX20ot5v8FAP5u5Y3IkZJ1CEEyTCBTJkGuSBiwG+/7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR10MB4273.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(7416014)(921020)(5023799004)(4143699003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmpwZ05xWDZlaW01SHQxQVl6Ny8ralRRc2Q4TVVnVUxtZks2MGhNTktEODgx?=
 =?utf-8?B?Y3V1RmFEcitJWDhRd2lFVDZwalpJUWNXdVhtQWVHM2N3ZnRmSjk2eGR3SWVU?=
 =?utf-8?B?eDhHTzJMamVWODRMYXJ0VUZaQlJicFVFdXVyZGNEcVhJUEJweXJ1dTNsY1Z4?=
 =?utf-8?B?L0RIN1d3aDRHYzR4Q3YwM2VPMzRxMjRWRlZXVko1STNIcWZiVkJBcUJqc2lo?=
 =?utf-8?B?RFVjNEpPd0lNdEtQellQR0RlTUtJRnk2UkxZZnZkK3JPcTVtdWpyUjBhcmww?=
 =?utf-8?B?SE9XcEk4dng5S2NmK2g3MnhDWUhLbFpTYWlqSlo4anhIdWxQVkYvY3d1NUlD?=
 =?utf-8?B?SWYyRFoyK3hFTTJaWHNBZ1F1MTQ1M0lGRGQwSXJLd2psOXNrOUZuODVsbUx5?=
 =?utf-8?B?RmdFaDc4WTc2UzQ5a090RkZrQUJmMlFxR1UzMXJEdVgrT0wvOS96RGROOTJ0?=
 =?utf-8?B?SURPZmFVczBsWWJ4N3JGQ1BXQ2trK2VqYSs3ZHIveVhNQnZLUkVCaTBVZjZy?=
 =?utf-8?B?Y040TFkzb3MyckJjYkM1QVpYL29VTGFoc1pRZ0l1NnhKYncxWHZHckJIWlRy?=
 =?utf-8?B?N01TQWQwRFdOZkkzWjJMcFRLTWVxcDJzZEJVTnB6YjVxNFJVekRqNldzWGFV?=
 =?utf-8?B?MXpqTHZOUnBRdUNuRjJMaGlHNWVVMzU0SGhCdXdlWUNZZ1FGQUxXOVk5WTUr?=
 =?utf-8?B?OXhLKzBhT29sblF3QWU3V0gvN2ZwdU1uR0NYbXZVTzhQRXN4OWlEeWlUN1F5?=
 =?utf-8?B?aWgzMmVHSnJKb2NJdG5veDl4QVRRbk1xLzNyckNqRFNFdXVlWmN0RmttQXVu?=
 =?utf-8?B?K1lIMldrYWd6WG0ydlNVUlN1eU9NcG81ZGhPcEI2ampvU1pESC9HZkx5cHN4?=
 =?utf-8?B?RDdTTVNZdzBOZU9tVlhkN0VKMHBBY1lJQTdwTHR4NHlaVG5vZHBOR3VrRGhI?=
 =?utf-8?B?QVB0S1poSGFiZnhuWjAzdS8ycW9ocVdmUjFyTnRJU25CaXRVSEdTT1JoM2dO?=
 =?utf-8?B?OG5FNlZYcHdOUDFtbEFMWXhFeEIvNUtSY0ZPSlg2NFAxckk1dmtQWFRvcFVD?=
 =?utf-8?B?NkhXdVcvcmJUb291blQ0T2RtaW9xRTlBTEcxdlZqelZGUXVEZDBjeEdwY0hT?=
 =?utf-8?B?VWp2WHlIMVlWcnc5MGpQLzdTSUcvVmdlWC9qRU1PSjhzOGVsMGQ5QUlyM2hO?=
 =?utf-8?B?b2NFMUk5cW0xZHpXQUxIMVg1L1RuT3U3NWFVUW5Wblo4emtQNVRUMDB3RTlV?=
 =?utf-8?B?Sm5xODZwQi83ZllYU0VYNkxCd01EcHFDaS9UOVpwNFdneG1YdjhlLzlwSEdD?=
 =?utf-8?B?UjRQWlU3d2tyWVRqY294QU9tdFlYV1FwcVhEbWY1Z0N5Z0NFZUZHbVFZZ2N6?=
 =?utf-8?B?NTFlQlgxRGN6QTcrRDlvdlJnMFN1VVhBRks4OW0xWndYTnBML1dadHhZenZQ?=
 =?utf-8?B?eC82LzFZSnU4aWtkbklKcG15dnBORklFZ3E1MFdnckVQWDJGUENGZ3JEZ0F3?=
 =?utf-8?B?RnVXUGdva2REVmxZcWsveUR2M1pocG52S2hqcHQ0QkNFTHVoZGZQd1BIekNN?=
 =?utf-8?B?czZiNGcyWGRUUFRjVGNMWGd3Q0FkVlNqMnNFKzNKRUNUaWlhdVN6TU9HK1JE?=
 =?utf-8?B?ZU1weGh1c3AzZ2tEcGh0SGFpU3EzV3BoTzVsTktCMHFvN3Z4RWFxVlgwMlJ2?=
 =?utf-8?B?SjZpR2UxTElSbXlHYWY2cW9aTFVmYnN4Vm96Tmh4bk1nZGlzWEQ0RkZoL3RH?=
 =?utf-8?B?c3dkaEtCMlRSMnpJdGlhMXBuV3JRZHFUSmhMcGUrV3ZPeWJXU1owZDNqOWlY?=
 =?utf-8?B?Y051alR5WmdLSmJGUEhsYzk3ZURBSWYwa2VuVEZ1UUY4TjYxUVlrektuOUF6?=
 =?utf-8?B?R0w2ZW8rd3p1Q2JpYk5QRExVUE9TL05ZNGtrRENscHNKek05Umlmc0lUY0I1?=
 =?utf-8?B?SW54RHltMjJMNi9RaTFKV1A1aVdmSVJvdkNVeHpPcSswdkYvOE1nOCtJa3lw?=
 =?utf-8?B?Ym5QSjIzM29CaFhaM1E1TFJ1d0xaSnNWeHROMnBmTkVMMFlDbFBFMHpkOHFI?=
 =?utf-8?B?UnI3b2NtQjVLOHZsM0srQUtkdW1YSlNBVk9YcmR3a3NHVUp0aE9ka3h5eHM1?=
 =?utf-8?B?UklWU1NKc1hBVE85eWFLUzIvR1pXMDI3VEZhai9ZdHpoakpJY0FPQ09Jb1dj?=
 =?utf-8?B?MFVQWi9YbG1uc3lKUDNucFN4WTdQdmY2S01abGhDZzcwNDN5QUEwRXV1eFpm?=
 =?utf-8?B?ekdITXltM3pWK3h2N3RKYmRGdUJqKzhFaWJTM0hSS1p6T296K1VDZ0NGZk1V?=
 =?utf-8?B?UlFwTnRmNlVmZi8xU0tDRGlIaXBPb3RLTzIzZlorcW1XeE9qaW5DbjhTWm14?=
 =?utf-8?Q?9HIHKEZrAIY8DtZ8=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d25c9d-aa0a-4b1c-ac36-08df2448bd65
X-MS-Exchange-CrossTenant-AuthSource: AM8PR10MB4273.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 07:58:14.8996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g3sEw0s1eEFUUi9nQBguuRMofJ95Q7hw+NTl+LbCOtRWLdSJJ3O/L4ZMS2dhnDoi7ylb4QnV1GvuThpGZ+CTQElFzTvkXgEgV7bv4dAKq74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7421
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 28.09.26 01:57, Mikhail Kshevetskiy wrote:
> Main changes:
>  * add support for spinand operations working in octal DTR mode
>  * randomizer support
>  * continuous mode improvements
>  * more flashes supported

The subject line mentions Linux 7.3 as the source of these changes.
Maybe you can make this a bit clearer by referencing v7.3-rc6.

Also this patch is really big and contains multiple squashed upstream
commits. Is there any way you could split this up, maybe even using the
original commits from Linux? The minimum would be to split the core
changes from the vendor driver updates.

> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  drivers/mtd/nand/spi/Makefile     |   5 +-
>  drivers/mtd/nand/spi/core.c       | 504 +++++++++++++++++++++++++-----
>  drivers/mtd/nand/spi/dosilicon.c  |  93 ++++++
>  drivers/mtd/nand/spi/esmt.c       |  30 +-
>  drivers/mtd/nand/spi/fmsh.c       | 175 +++++++++++
>  drivers/mtd/nand/spi/foresee.c    |  34 ++
>  drivers/mtd/nand/spi/gigadevice.c | 117 ++++++-
>  drivers/mtd/nand/spi/heyangtek.c  | 132 ++++++++
>  drivers/mtd/nand/spi/macronix.c   |  87 +++++-
>  drivers/mtd/nand/spi/micron.c     |   8 +-
>  drivers/mtd/nand/spi/toshiba.c    |   3 +-
>  drivers/mtd/nand/spi/winbond.c    | 466 +++++++++++++++++++++------
>  include/linux/mtd/spinand.h       | 198 ++++++++++--
>  13 files changed, 1639 insertions(+), 213 deletions(-)
>  create mode 100644 drivers/mtd/nand/spi/dosilicon.c
>  create mode 100644 drivers/mtd/nand/spi/heyangtek.c
> 

[...]

>  
> +static int spinand_randomizer_init(struct spinand_device *spinand)
> +{
> +	struct udevice *dev = spinand->slave->dev;
> +	bool enabled;
> +
> +	if (!spinand->set_randomizer)
> +		return 0;
> +
> +	enabled = dev_read_bool(dev, "nand-randomizer");

In Linux, we read this as u32 and leave the state unchanged if the
property is absent instead of disabling it. We should use dev_read_u32()
here and skip calling set_randomizer() if the property is absent.

> +
> +	return spinand->set_randomizer(spinand, enabled);
> +}
> +
>  static const struct nand_ops spinand_ops = {
>  	.erase = spinand_erase,
>  	.markbad = spinand_markbad,
> @@ -1226,10 +1366,13 @@ static const struct nand_ops spinand_ops = {
>  static const struct spinand_manufacturer *spinand_manufacturers[] = {
>  	&alliancememory_spinand_manufacturer,
>  	&ato_spinand_manufacturer,
> +	&dosilicon_spinand_manufacturer,
> +	&esmt_8c_spinand_manufacturer,
>  	&esmt_c8_spinand_manufacturer,
>  	&fmsh_spinand_manufacturer,
>  	&foresee_spinand_manufacturer,
>  	&gigadevice_spinand_manufacturer,
> +	&heyangtek_spinand_manufacturer,
>  	&macronix_spinand_manufacturer,
>  	&micron_spinand_manufacturer,
>  	&paragon_spinand_manufacturer,
[...]
