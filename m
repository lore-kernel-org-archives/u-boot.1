Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F71BFC5903
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 07:56:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EB1D83C54;
	Thu, 26 Feb 2026 08:56:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="FObqrqVK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67DDF83D1A; Thu, 26 Feb 2026 08:56:38 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D24283AA9
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 08:56:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ImLktxZlFi+houn+8GwXgHQCYmWV4ZtDUCy+lHSlZqo7dRNxNmkZqQhuOtTAIsOQ+lBXaaFKPBSKrY0hacPoZYrZlW+d5ZvfcxiOcuHyupr+7jtg2fSqjzIItdsWJdUAvW2WLrrmIwk/VW76wwG3H+mGVKWgO0jKOfoDFcmuMqbVoO0YhjxhZIj9ot4CQ0TbZNhaINE7YWUiJ5NKfm1s1M7xGSsrhwgyBF8jReJDodnX9UrQxIRwFzQd6/fXF/m8SGO/cLqf8RYRa6UeIOCX5nf7B9HRc6oHunz3vypwE1cwvuPC7VDP5FfytSzWLdgJ0IH+1dibPZ02fMEVm1gSSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OW4krvh+ErdGSXicAnnRmRONaOsCc7DQQUx8t4S6UYA=;
 b=K+15w+OMZySldvDm0cMdy5Xy12Nl/eKMjT7vPUyspqWL/8AXt2ozDntZD1AXkP3OlgSGy7/G8giqcuriDqna0ypLOxDbrvh54eOUE5k1+P4BYCthtVSLgTcfQRXnQcMotMoZ7ipREywsUsDMmldso4Phicjha0GegYop4zG3K6VOaCXx7yko0SawKn0OeiRWuV0tjLyUkScu5w8XarrT4iskFzekcN5+8sZJAM3P8wfey/q9Z8V5+TWJrog8OvYPpKzApbHuS6jMwIR0mrrAjk5X85GpLYrxYEhihXYQ94k0r3H0z7QfYtBanSaERTJVSdDnoS4/wjAnGMmcbfpKiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=amarulasolutions.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OW4krvh+ErdGSXicAnnRmRONaOsCc7DQQUx8t4S6UYA=;
 b=FObqrqVKzYWCiJf5lbnH6nEzFf3nNvPnwlPEaehZRWu3xpJLbyrZBKuQU+4OAQVWfKCj6YRSe9TFLrIyt1ng1vooYMgGx0BRd5/7w8QRTSPmczK4LynPxFF9qfWM8T1wZ4ThVLg2Gyd0uwi7hQTP+xyjmtbFFAW+J9F02itBxRlDHd3hkUttDaLhQbczBH8he07VvmtxZ4WRkrjHsyJb+/8PCIaHn4Sj5+9ShtxntL54XP7ttN6M8i1dxk/rZsAjXn5g50lj+d70PATHzipidFqcBwUBF/l5yATMygIOfGWvXSlqWbBVxI1yADk2ZESszWOdRptE+OFN7nGMWnRLWA==
Received: from AS4P189CA0042.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5dd::20)
 by VI1PR10MB3328.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:135::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 07:56:32 +0000
Received: from AMS0EPF000001AA.eurprd05.prod.outlook.com
 (2603:10a6:20b:5dd:cafe::8a) by AS4P189CA0042.outlook.office365.com
 (2603:10a6:20b:5dd::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.25 via Frontend Transport; Thu,
 26 Feb 2026 07:56:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS0EPF000001AA.mail.protection.outlook.com (10.167.16.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 07:56:32 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 26 Feb
 2026 08:58:50 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 26 Feb
 2026 08:56:31 +0100
Message-ID: <00271afb-8dd1-4e12-8499-19fec0c7fb9c@foss.st.com>
Date: Thu, 26 Feb 2026 08:56:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] spi: stm32: add stm32_spi_is_enabled() helper
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 <u-boot@lists.denx.de>
CC: <linux-amarula@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Jagan Teki <jagan@amarulasolutions.com>, "Tom
 Rini" <trini@konsulko.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20260225161851.2475274-1-dario.binacchi@amarulasolutions.com>
 <20260225161851.2475274-7-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20260225161851.2475274-7-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AA:EE_|VI1PR10MB3328:EE_
X-MS-Office365-Filtering-Correlation-Id: 8770dcd4-09c7-4d85-1772-08de750c8e86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: HfdSaw79o1gVL8wAtzUWmRpULFe0izXTosWjUFfk0hjwvYtV1vqAMOp+JF0vawAKvI9E7TbtKf8fuQYQckHeiZ87Asjsatb3Ug/3t/1vCNZe/RaubUXDNu6qoSeydnZTZoPHXQYY8ElQtILD9M4i8icoNj9wieoba1y6fBRrIg291fCKx7PiAIDNQ7pIj8iqb+c1+2sTsnHmomFRnqs4CrQ2PqUdrSRZrms4arons+XQyCXrVpNriFj2mR91uKrlSqaH+hlzXRkZyucIcMqiSLLbP7C6/wjiVHhpZzul+lVxIlpG3TEvg/WwmY3gAjg0v0Kn/7jJrfer/H7d6ntvQNoAn7B1CFhVChQ4rhcBRIvYF0ONHnPhefMmz8oy2GeMVHSC6wgPO00QkvApWJdRGun2D9TCEyipGNbnmNN6DIlhnd+PADt8Y2cMucTlkxBLqxPwgBwcuqAerCDZKjcqeMOyKkzZbLIruGsxFwj1SfK2+cHimegIDEzTllNEG7nAoR7PYEansLmt0UAPAhXRUJqcQ629fxV28zBSzBgxm+Yd6A3XGMqMA4mQq+proR1/QYY8Kt7Vy3MOgZEFZFlY+7EIfer5SsHcnv9q0FUSwxVZfZdchBVOT4tB14rGu8uEouhE4Qj5hkfokwdq/bGahtSo4XZH7Lzo5U1L2lCOoELkiHWCBdJlkE2xMlpgDm13f8nBeXIvtpAEeHIKHEya9z2IeZNUCqhFLy7gHQlduHwOjI9CQrgCwD0nxYFlpbsiGuI9/k7WEdT9waHY01/SUyp1WdTA6G4gLJV1yz6D8jXHsISnni0mqZtsbAbDHvW9slqHnrSOhjt86e4gp9+uHA==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8wMSkPth7x79uCzotdGvnezT+wP3+E/yG9HPrsBurcXSjjxL5CXurXNlrRrN3OGkVQsuHy9nNYQ0gnaJnxo8TAJcigWocdM7EUkgOGNmzsi7jXfwQoviWestJ9cgNNcqaqkALaeRa6floxsqWbqsj7ZXO1CentFFw+hAEUsYzdvntAeE2W9VM8YRfxkCrOg0ttClsYvJH9Mm3Jh29RjPDD6TVeIPhQj0601ceX8vpMaSwV9INb3S86rN/qpt0qU+epEM1J1eV0wIzE57VbwxoIgcTqklRgrxjxqvd8ii0C8hKWtcEKv5GSx+tjEnf4LQZh5MiYhXNc5VHiNYwswfAyYBlf3Sn/gd56of61F2SF9ygstiCJDIfL1imBMvxld4/bpP1rpOcCkYhNakxQI0bMSVBTlEP03HGJcQDF7dFtBkHR0LN/4abRG1qdAKAa4Y
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 07:56:32.3589 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8770dcd4-09c7-4d85-1772-08de750c8e86
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001AA.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3328
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



On 2/25/26 17:16, Dario Binacchi wrote:
> Add a helper to check the SPE (SPI Enable) bit and replace the
> open-coded bitwise check in stm32_spi_stopxfer() with this helper to
> improve readability and consistency.
> 
> This is also a preparatory step for future driver updates that require
> checking the SPI enable state across different code paths.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> 
> (Added in v3)
> 
>  drivers/spi/stm32_spi.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/stm32_spi.c b/drivers/spi/stm32_spi.c
> index adba97915cd3..70eb8735e03d 100644
> --- a/drivers/spi/stm32_spi.c
> +++ b/drivers/spi/stm32_spi.c
> @@ -192,6 +192,11 @@ static void stm32_spi_read_rxfifo(struct udevice *bus)
>  	log_debug("%d bytes left\n", priv->rx_len);
>  }
>  
> +static bool stm32_spi_is_enabled(void __iomem *base)
> +{
> +	return !!(readl(base + STM32_SPI_CR1) & SPI_CR1_SPE);
> +}
> +
>  static int stm32_spi_enable(void __iomem *base)
>  {
>  	log_debug("\n");
> @@ -245,9 +250,7 @@ static void stm32_spi_stopxfer(struct udevice *dev)
>  
>  	dev_dbg(dev, "\n");
>  
> -	cr1 = readl(base + STM32_SPI_CR1);
> -
> -	if (!(cr1 & SPI_CR1_SPE))
> +	if (!stm32_spi_is_enabled(base))
>  		return;
>  
>  	/* Wait on EOT or suspend the flow */

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
