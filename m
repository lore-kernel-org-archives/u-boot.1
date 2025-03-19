Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3067C35FFB
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 03:32:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D46D8141E;
	Wed, 19 Mar 2025 04:32:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742355134;
	bh=q7hIZeiWxUhncJiV6qNPdiWhXSVEm/OfM+dRH6hehss=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lq1LK5XznNENeF5hCtJGixy/2nyzuTx6jO/FWVqq/vGjtmt7xk6kkWA+VBGMTa2UP
	 kpqBDKmabimx/KbbFjaUtdtvxV9H5tkJszDdyxCAJIX93hTL/4NYuuCO82oP6fZuPi
	 2luEa79oLAzgcXWqEf0scY5c2RQnA/ULJd+9yU5IY4sFw9h48qI7ad4TuOFCdv2RBr
	 lX8Ggk5ExOxAsPOqJCRhe53p0NgCYI01Zt7DzKa1CSIrq+cY3uRwb2645Acb7bvkNQ
	 JxQ9H15KQnWeiNscKRMKNVlyPaifelO/Vee9QBFR54uoT+qJwWXFyiMc1milbCViKS
	 lVURYpFhc6OSg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FBA1819B1; Wed, 19 Mar 2025 04:32:13 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24CC68129F
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 04:32:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="C/Rn+M8h"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id F26DA101E91C2; Wed, 19 Mar 2025 04:32:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742355130; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=q7hIZeiWxUhncJiV6qNPdiWhXSVEm/OfM+dRH6hehss=;
 b=C/Rn+M8hJ18d5PrfHacvrY90/ilfZVRisnIj6SEaGghKRWWqbiwgIcJUq7z8gmQfJY0rxS
 KhJIau5KuZ8Vjdq9f68BrrZQ4/cLkLlZj9IRQ6j8dgAIDwhrrqXK8EmgusPjHHGQFhPdzv
 wGhxXeN1sXEiuDakWW2Db73d32H9X7c9T+02ovBkIhseXVuLqvcYN1tQh79fXOpqK+PLW0
 riOgjoTykyQgXygA2y9qYCnCKT6bHksxtYl007zjq/Zno/p71pRzHdR8Ikn145G1ZzaX3C
 f6ikT7HvCrvGnYWzSGEBcBzGPACAfocb0PYH66JHieBjCgBF4t75yt4zvSM1Fg==
Message-ID: <c13805fe-5379-46ef-ad13-e371c71376ac@denx.de>
Date: Wed, 19 Mar 2025 04:31:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: imx8mp: Gracefully handle disabled
 ENV_IS_IN_SPI_FLASH
To: u-boot@lists.denx.de, Fabio Estevam <festevam@gmail.com>,
 Fabio Estevam <festevam@denx.de>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Tom Rini
 <trini@konsulko.com>, u-boot@dh-electronics.com
References: <20250319032828.249156-1-marex@denx.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250319032828.249156-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 3/19/25 4:28 AM, Marek Vasut wrote:
> In case ENV_IS_IN_SPI_FLASH is disabled, returning ENVL_SPI_FLASH
> leads to failure to find environment driver on start up. Fix this
> by testing whether ENV_IS_IN_SPI_FLASH is enabled and if not, then
> return ENVL_NOWHERE instead.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@dh-electronics.com
> Cc: u-boot@lists.denx.de
> ---
>   board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c b/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
> index 4af3cbe9fe2..4275436b128 100644
> --- a/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
> +++ b/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
> @@ -186,5 +186,7 @@ int board_late_init(void)
>   
>   enum env_location env_get_location(enum env_operation op, int prio)
>   {
> -	return prio ? ENVL_UNKNOWN : ENVL_SPI_FLASH;
> +	return prio ? ENVL_UNKNOWN : CONFIG_IS_ENABLED(ENV_IS_IN_SPI_FLASH,
> +						       (ENVL_SPI_FLASH),
> +						       (ENVL_NOWHERE));
>   }

+CC Fabio too ... hmmm, get maintainers is acting up a bit today.
