Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 645E3C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 09:05:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E982B83AFD;
	Thu, 10 Apr 2025 11:05:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BUNtgE+v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73B7F83B21; Thu, 10 Apr 2025 11:05:40 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68B5D83AE9
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 11:05:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1E9696843D;
 Thu, 10 Apr 2025 09:05:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467D4C4CEDD;
 Thu, 10 Apr 2025 09:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744275936;
 bh=H8u5Y7xzROpE6X6KOyQKiqdqQIJu+UnHO8vt+o1DSq8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BUNtgE+vXlXcNG3JXdTPp6TFz6HF6+88PxhPCS9qOZTV7spFzhggGdaboBgytYqVL
 RNF8hjV6XEtDWH5n2iuURLHc/ioLq+m3N/V3gRosavL8IPB4Cg1gXmH2H9fGOrOPKa
 8zxF8WQUW+16WWx7N+CctYYBPch9Bw5xIQ5G7Boj28v+A46QIxfk4+MZPx2qH+5uIF
 y/qRlWoXTZZ8YSr3ZVay4AI5WMz860I8mut0Qhc1siw6/ZVCgjBeJKEAxMgtE7TeKr
 gvaxqesKl20bwXtSKFP296e9JC09Qeb05/YvB+AHJFhCGSBQ3ByCjKynyVEx6820CT
 znCWfFxk8HPig==
Date: Thu, 10 Apr 2025 14:35:31 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH 6/6] pinctrl: qcom: qcm2290: fix off by 1 in pin_count
Message-ID: <Z_eJ26slr5N2ka8j@sumit-X1>
References: <20250409-livetree-fixup-v1-0-76dfea80b07f@linaro.org>
 <20250409-livetree-fixup-v1-6-76dfea80b07f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409-livetree-fixup-v1-6-76dfea80b07f@linaro.org>
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

On Wed, Apr 09, 2025 at 07:17:29PM +0200, Caleb Connolly wrote:
> There are 134 pins not 133, oops! This fixes the sdcard on the RB1 as
> the pins now all get configured correctly.
> 
> Fixes: 0ecb8cfcb930 ("pinctrl: qcom: add qcm2290 pinctrl driver")
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-qcm2290.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Nice catch!

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> diff --git a/drivers/pinctrl/qcom/pinctrl-qcm2290.c b/drivers/pinctrl/qcom/pinctrl-qcm2290.c
> index 0c2222ce663e6d584d229e7521f88fedf8aa19da..84f76b63b93ad78182524661dba561672feb4c85 100644
> --- a/drivers/pinctrl/qcom/pinctrl-qcm2290.c
> +++ b/drivers/pinctrl/qcom/pinctrl-qcm2290.c
> @@ -44,9 +44,9 @@ static int qcm2290_get_function_mux(__maybe_unused unsigned int pin, unsigned in
>  }
>  
>  struct msm_pinctrl_data qcm2290_data = {
>  	.pin_data = {
> -		.pin_count = 133,
> +		.pin_count = 134,
>  		.special_pins_start = 127,
>  	},
>  	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
>  	.get_function_name = qcm2290_get_function_name,
> 
> -- 
> 2.49.0
> 
