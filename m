Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D37CD13D3
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 06:59:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1CDB83FB5;
	Thu, 30 Apr 2026 08:59:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="ECj2PER0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B571684198; Thu, 30 Apr 2026 08:58:59 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97F8E80433
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 08:58:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwckFtcftoYJpBbs5t9o+zl66sSd9aVKhGtQgMrmx/3CRrTO6p9+L2imLSv/NfuXceT0tkyGDds5gDYLclcjNg4UIxkS3rXtsCMIjTNdWHgsO3FhRvnHXHhDobbeg3XfE9L2LXoJ/1XCA7/6jZpZOj84mmWX2zCgnpGSLIl8UWxQfz8GvT1zYvOFxYpnVkW99u5Rb0lvI3HKS+tVU/WJdtn0o3mKttwMM88JLaKc+Q2c6lo8qUGr3xgbib1U9MUQM+D8U0D1f/NyihXAu4fbP7aaj5Pwq4EpW0QUWJ4KDAXM7sK68Mt3uId44+ZxUVXggUuikcrvlFM0bH2GsupDBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZ0nIVbg+F8fii6M8uJ9RmV53XevAbunDeT69B42PZM=;
 b=xQnyjs3MDARO+SW5vBvaAVhKqwhOe3+FZ0ZqqLFCpsvdJldHTpQptip5ljEY+t9anszm+dWR0pJvb7WtcyNmrU4gXX3QIXADCyzKsDcMhQE8a7E6K2ymVgB17spfoUxOc19YJMvvJ1Nqtl+ROaHiqhVER05lRaVtO1SUalFBQQxn83LjAXb3qw2sUE/PMSdVA9bdnWJ3Qb0uYUW+wnhysOvA/qPKxpLISYBTb7LYw0An+B4FwMx7xpKfaaBxU/WE0Ytd8or9I8BWWYLQeqa7roX5lAp6aCSYdaY5i2SrFSdVFFPodM41ZYtrvkuovh3lRjVWHp3Vucz1zedmuYdumw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZ0nIVbg+F8fii6M8uJ9RmV53XevAbunDeT69B42PZM=;
 b=ECj2PER0BlYw6ZBMVPWVgKLP8UlDg6Y8pb+p7BeAVVeoTXZG5HuvKhjB+5A7DFaNu3jk1NmQPC6lqI72gjWg2CM07lyfULQhcAp/rP7R/Wo9/Zyqx3UEvkIzl2hH6RRKXOQMQxkuaoYDWY9homZGVqn76YJG0t59TaN0PFcO3O3mkyDoSkUTRQ+YuavyQllM6djdjtRiVs8DQRoL9ijQxX5waFDV6188aBz0pGzi+ivGK+49W3JtmKcYmRJLs5y1etCxrtaXXPzaxTeVlaYMIP9pLvykYkY2/7QBHohwQp5zpoZI7mwMSeVeIWuO8hjP2ZR+vDD1enHhj4NnMTYhTQ==
Received: from DU6P191CA0022.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::13)
 by VI1PR10MB3215.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:12f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 06:58:51 +0000
Received: from DB3PEPF00008860.eurprd02.prod.outlook.com
 (2603:10a6:10:540:cafe::b7) by DU6P191CA0022.outlook.office365.com
 (2603:10a6:10:540::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 06:58:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB3PEPF00008860.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 06:58:51 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 30 Apr
 2026 09:02:03 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 30 Apr
 2026 08:58:50 +0200
Message-ID: <fbc2d28f-7ad3-4e18-9229-f83fc54a05d6@foss.st.com>
Date: Thu, 30 Apr 2026 08:58:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Uboot-stm32] [PATCH] board: stm32pm1: Fix board_check_usb_power()
To: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Tom Rini
 <trini@konsulko.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, "Kory
 Maincent" <kory.maincent@bootlin.com>
References: <20260414-fix_usb_adc_meausurement-v1-1-8cdbd4c10dd8@foss.st.com>
 <255b4c39-eff9-46cd-9e18-8e1b47ecabac@gmail.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <255b4c39-eff9-46cd-9e18-8e1b47ecabac@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF00008860:EE_|VI1PR10MB3215:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f32b7a6-8845-4e7c-639c-08dea685ef79
X-LD-Processed: 75e027c9-20d5-47d5-b82f-77d7cd041e8f,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: FmknOh93KM7FnT2dk5yZS/G+GI65x2mFieibPx1YnoDfCsJ3GY5wGR1KzB79wM1U5eoSg0dwbglTRzOkUk5QVdPo+qxDG4L4YachyhHQPy7t5wnZIRCCuVWPepLsqx7NeBMOpwmBJ7Qua0JALtfsrjgo7mAHC/ylCX3/LlKQguXDttSU05rmYKy2c6QJwEFkmW9XCh9VM3SS5dvyydkXokK/JUEA9SAZDL1D89e3iSZNF/qwdXnd0bRI1U02keEbDMlkXvidFbwwazCB/Otk7LI4Ihhk8R5GfkkJeeHCQKAQvi06n7oENqQltqOt3QK0gAzOuGmtsF5HacmynVgE8Pv3g/JAK1ZsM6CAEwdH/9tfJ/S92c/hV/zKZsGKqehyrfjmrMEtlUzGWdQK/6wU6/GnSld1YxqU8XrDvSJFsLwf8gRHFXDQOWJJBy+lbt+HX3p+TXEMhr047QsjlpfhBeK7rjIaay6IQ4dpdEe4gXTQg0WgQQrPr/yxvI1Msdk5sBbvnd7WBeq7EQgObMlbgNqwYt2I375EiR3X4sff7z0VDoWZtYHRTvBtbXUhm/6Qiyzl192VeyV0FfAm348xTnsQXBszzJeaNkj8xvEwOQ6SN+NaBF0TBFSBOzfZyNuwvmYhW0z+r1EgbpWR7USgX3Io79oh5O/VMIsMDNoMG8iLrMNgE9aTKQ61qHRenAR+6JJ6uz/lfBKjLzt5emen3d1rAzGm3elZdfNChlxJM4D9i59pnkMqGllo97HIakC3YwnqQ2OPT61/QZFyN0prBQ==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yiWBmhc7FaHXA1u1KWUx7DlyvCwP+8aHAH4kAkpQ+ykO8vLPT3iNSHbdq1UCMEatHLh60ntwZh8GSvA3mvtsfpCKr0P/Y6SRcP8IaihLCYuzItiyFxLEZhmtbisS9GzTrAp4A3vs0IYujOD/DcstKd2oh68wCjDSYCkMPulZrAK+0oQhtPKxxSHsJeQ5nb+vHMRwTm8DPVNGu/RKX1TeS/s6+cCx9FrWxA52MAM+7iE6lOFe9FPAP+p5x6TEfO2KOskUSLCHKoaF4Tn8kSE06eAQOrBgLKsiYdtrQXDKtG4rFg/0WFZsNeCHgK5XohtHHQQ5jBVBdICnCHCx3vwurykCNfJMByUTMq4iiqYnXamAunek89/TJ0hOJTinDGbq8p60h++zF+XFyW2yoi+egJwvbunzIb2ltXbi59lTEffL3HM5tMZF9ygo3mZRt7XR
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 06:58:51.0647 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f32b7a6-8845-4e7c-639c-08dea685ef79
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF00008860.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3215
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean



On 4/29/26 11:12, Raphaël Gallais-Pou wrote:
> 
> 
> On 4/14/26 11:06, Patrice Chotard wrote:
>> Depending of plugged power source (computer, wall charger, ...) it can
>> happen that we got the following message:
>>
>> "****************************************************"
>> "*      USB TYPE-C charger not compliant with       *"
>> "*                   specification                  *"
>> "****************************************************"
>> ""
>> "### ERROR ### Please RESET the board ###"
>>
>> This issue has been detected on STM32MP135f-DK board.
>>
>> It's due to max_uV and min_uV value are initialized at beginning of
>> board_check_usb_power() and can then be used for the 2 iteration of
>> adc_measurement().
>> max_uV/min_uV values issued of the first adc_measurement() iteration
>> are used as input of the second adc_measurement() iteration, which
>> can lead to incoherent pair of min_uV/max_uV values.
>>
>> To ensure that adc_measurement() returns coherent value for max_uV and
>> min_uV, initialize max_uV and min_uV at each loop start.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
> 
> Hi Patrice,
> 
> Reviewed-by: Raphaël Gallais-Pou <rgallaispou@gmail.com>
> 
> Best regards,
> Raph
> 
Applied to u-boot-stm32/master

Thanks
Patrice
