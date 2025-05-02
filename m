Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1FCC3ABA9
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 06:02:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B36138070C;
	Fri,  2 May 2025 08:02:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TGDkkMbl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A135F80FDE; Fri,  2 May 2025 08:02:54 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64E38803CC
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 08:02:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 371C343F89;
 Fri,  2 May 2025 06:02:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F32C4CEE4;
 Fri,  2 May 2025 06:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746165770;
 bh=wyvSk7zgJwWDyFVGip4zqNkXkN7jHJXZExJD4Xelp1s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TGDkkMblIHIUwPDJ8Lhq//TNjgP11hQIrxjBY2X/wgZmEzwabzfMmXWPY3x3DkkSl
 5LAVxpaOnjBXUF7zFALGJQ6NEXtjHirwPPMupacYRtq5fTZ9prS4Gwx8o6cuOCJHyr
 uqVbWUUe8d7qrB1cDHmF1BKvb640gCwQ6k98RXIx+VIWKY37EhShMUQO1G/sWT27Qq
 zYOBSXPNfg2/Pa0V1E+qH8scc9golvwhOYJepEorppCKmjz1xFnMepef9wz41BLk62
 3/yAdinMA1CsCQWbP7d+PdbO4er7nnTrrWJfKO0XEQ6MY0wf4yw6rjnb3LPreZr/J+
 DWX48aMw2GHhg==
Date: Fri, 2 May 2025 11:32:44 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v2 8/8] pinctrl: qcom: qcm2290: fix off by 1 in pin_count
Message-ID: <aBRgBFq-CPhOlxp-@sumit-X1>
References: <20250411-livetree-fixup-v2-0-1236823377bb@linaro.org>
 <20250411-livetree-fixup-v2-8-1236823377bb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411-livetree-fixup-v2-8-1236823377bb@linaro.org>
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

Hi Casey,

On Fri, Apr 11, 2025 at 02:47:45PM +0200, Caleb Connolly wrote:
> There are 134 pins not 133, oops! This fixes the sdcard on the RB1 as
> the pins now all get configured correctly.
> 
> Fixes: 0ecb8cfcb930 ("pinctrl: qcom: add qcm2290 pinctrl driver")
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Tested-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-qcm2290.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

I think this is an independent fix for SD card to work on RB1. Can you
queue it for v2025.07?

Also, I am not sure if you are planning this complete series for
v2025.07. If not then can we atleast have a DT override for USB DR mode
to make it work on RB1 in v2025.07?

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
