Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F90C27C75
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 12:08:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF99488962;
	Fri, 14 Jun 2024 14:08:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="alfZ+sk/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F675880F5; Fri, 14 Jun 2024 14:08:52 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90D4E88983
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 14:08:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6895721e93=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45EBKDIL015576;
 Fri, 14 Jun 2024 14:08:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 XGZez/gfgnZUChu5yFmMWK5vF0iTnvtClEUeCB9iPUU=; b=alfZ+sk/l1jTV+Bo
 SfCDRI7iZzE4UxoyOwVtBSEgWL1M/M8JU+erag7H2cb4L2FxrEZuB3yYlfrXB0bR
 NiuQNzWHnBafGdJJ2q7FVfUpMcBXNJtZfzgzjTTclQWggA+x/xfwMTPtK98Diy+1
 KZvoF5nKVf5vCjW5jALwLFftFCy3qG+4srH4uA2CqrB17NsdWU/QoqbhW1KWj7F0
 RmQ+CjDkDzGnXlH/gpn04ZakHoGtOpEqTEgNebpFrX0GqhMtoSlap6dJf27R6f9B
 i34JLWD6aXbpLNT6yU68wjeUaNlDw0VIecdNGzNSZk2qNMEAwOkD9Um3sqwlemPj
 iPhHDg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ypub3mn04-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jun 2024 14:08:48 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 783634002D;
 Fri, 14 Jun 2024 14:08:44 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 261A42138D5;
 Fri, 14 Jun 2024 14:08:35 +0200 (CEST)
Received: from [10.252.18.60] (10.252.18.60) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 14 Jun
 2024 14:08:34 +0200
Message-ID: <acb7deb4-edd4-4cb0-850a-95bd734d566c@foss.st.com>
Date: Fri, 14 Jun 2024 14:08:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] dts: stm32mp157c-odyssey: fix incorrect PHY address
To: Heesub Shin <heesub@gmail.com>, <u-boot@lists.denx.de>
References: <20240428142406.28445-1-heesub@gmail.com>
 <20240428142406.28445-3-heesub@gmail.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240428142406.28445-3-heesub@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.18.60]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-14_09,2024-06-14_03,2024-05-17_01
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



On 4/28/24 16:24, Heesub Shin wrote:
> In Odyssey board, KSZ9031 is at the PHY address 0x7, not 0x0. This
> commit fixes it.
> 
> Signed-off-by: Heesub Shin <heesub@gmail.com>
> ---
>  arch/arm/dts/stm32mp157c-odyssey.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/dts/stm32mp157c-odyssey.dts b/arch/arm/dts/stm32mp157c-odyssey.dts
> index 53ba018197..b6210cf8b2 100644
> --- a/arch/arm/dts/stm32mp157c-odyssey.dts
> +++ b/arch/arm/dts/stm32mp157c-odyssey.dts
> @@ -81,8 +81,8 @@
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  		compatible = "snps,dwmac-mdio";
> -		phy0: ethernet-phy@0 {
> -			reg = <0>;
> +		phy0: ethernet-phy@7 {
> +			reg = <7>;
>  		};
>  	};
>  };
Applied to u-boot-stm32/next

Thanks
Patrice
