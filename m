Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76CA7C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 17:07:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA274876D5;
	Wed, 20 Dec 2023 18:06:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="J8w37cOn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDA77876FF; Wed, 20 Dec 2023 18:06:58 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED493875FE
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 18:06:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40c60dfa5bfso69022855e9.0
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 09:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1703092016; x=1703696816;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Hw5G1KcHB1ZICBjkwbPXFo0TUZvdPlZ00SINsnvLNGo=;
 b=J8w37cOnSivsxrDAOvKfOh1YGb8kFgw/5E46kqiwPtaLU764O3MudSe7zTsKzGMldL
 76znBAbCUEqP2M5tRCHhtqU2T0MRdqt2arYiRzhJwrj5lxl8TV5hEQ+v0uSI04XFAQZO
 InI1hoHhzlsvUkz0LhE85hVDS2n1Lsp3hMJY1hR8wJxB9uV63H72/UGEPlkM6hY+/sUp
 r8+HTA3edCWWOpJEqPqx18bW3WH5MsOzXh/yjjdNF7mn5nCt6jNhZlGYoBoc/aBI7c+L
 urQ5GbgQZMcWcxAfZ0gs/8A4FaKCMEp0vAUESGqRRwNpWqr+2aq5tNkqZpmiXN1ryyts
 Ib3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703092016; x=1703696816;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hw5G1KcHB1ZICBjkwbPXFo0TUZvdPlZ00SINsnvLNGo=;
 b=puy6lkxNuM3foSgdI8BHQgCK/SdtH96Wklu3BQvijadXnRaKOcka1h3GGZzfn8cv4M
 SII9JQsgGflUQRtdvXDNExwOZKpn7Cy4fYZiAUrUyHbx6R7OeemwTRjwMnCI1WCH9gud
 gwx5T1FKw3JwLO8mpRBTX8auj+DePe9ghf3Bsmg30/l2ITHMS+EgjWAjHxIF0vhxlcAc
 cZfxHnDVIK82GDWPeiT2faiqNxXlgkTU5EjaIY1A+rImOxQ1g69Q1Wksduabd3Ia/4D/
 u80m0QuHhlFgjelRtEeoxp4UBCulk1NZ7QgxeyjgpucatsyMN+qmQnj0piqN0romjjLL
 IMMg==
X-Gm-Message-State: AOJu0YwC8dOIhh7VQOBOIy62R4vADVhR3h9dzTTsbNcnJncf0ywxLeWk
 E5SmkktNYgo5ybi+dpWnXQj9Yg==
X-Google-Smtp-Source: AGHT+IEHxG70xMqa5V++INmlrISFSnfdCj7pJtMSjYlPpr0d0CF22lLi0nz9+X53yi+pSrAvaZzQlQ==
X-Received: by 2002:a05:600c:4e8d:b0:40c:3e98:5309 with SMTP id
 f13-20020a05600c4e8d00b0040c3e985309mr5145wmq.98.1703092015976; 
 Wed, 20 Dec 2023 09:06:55 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 iw11-20020a05600c54cb00b0040b3515cdf8sm267771wmb.7.2023.12.20.09.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 09:06:55 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>, trini@konsulko.com,
 m-chawdhry@ti.com, bmeng.cn@gmail.com, sjg@chromium.org, afd@ti.com,
 n-francis@ti.com, nm@ti.com
Cc: u-boot@lists.denx.de, vigneshr@ti.com, srk@ti.com, s-vadapalli@ti.com
Subject: Re: [PATCH] include: env: ti: ti_common: Run
 main_cpsw0_qsgmii_phyinit conditionally
In-Reply-To: <20231211104209.1078892-1-s-vadapalli@ti.com>
References: <20231211104209.1078892-1-s-vadapalli@ti.com>
Date: Wed, 20 Dec 2023 18:06:54 +0100
Message-ID: <87plz0247l.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Mon, Dec 11, 2023 at 16:12, Siddharth Vadapalli <s-vadapalli@ti.com> wrote:

> From: Manorit Chawdhry <m-chawdhry@ti.com>
>
> The main_cpsw0_qsgmii_phyinit command is defined only for certain TI
> SoCs which have the do_main_cpsw0_qsgmii_phyinit variable set.
>
> Add a check to ensure that the main_cpsw0_qsgmii_phyinit command is run
> only for such SoCs.
>
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
> Hello,
>
> This patch is based on commit
> 65eed68772 test/py: Disable error E0611 in two cases for pylint
>
> Regards,
> Siddharth.
>
>  include/env/ti/ti_common.env | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/include/env/ti/ti_common.env b/include/env/ti/ti_common.env
> index f5d84216e3..f0f89a2287 100644
> --- a/include/env/ti/ti_common.env
> +++ b/include/env/ti/ti_common.env
> @@ -25,7 +25,10 @@ run_fit=run get_fit_config; bootm ${addr_fit}#${name_fit_config}${overlaystring}
>  bootcmd_ti_mmc=
>  	run findfdt; run init_${boot};
>  #if CONFIG_CMD_REMOTEPROC
> -	run main_cpsw0_qsgmii_phyinit; run boot_rprocs;
> +	if test ${do_main_cpsw0_qsgmii_phyinit} -eq 1;
> +		then run main_cpsw0_qsgmii_phyinit;
> +	fi
> +	run boot_rprocs;
>  #endif
>  	if test ${boot_fit} -eq 1;
>  		then run get_fit_${boot}; run get_fit_overlaystring; run run_fit;
> -- 
> 2.34.1
