Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0166C41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 10:55:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0657887831;
	Fri, 22 Dec 2023 11:55:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EScRFhqr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3621087845; Fri, 22 Dec 2023 11:55:43 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42009877CD
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 11:55:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-50e55f97606so2520438e87.1
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 02:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703242540; x=1703847340; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GZxQpTBXpMLj270/0g+e/diwctDGETsKiPtO+RUhCrM=;
 b=EScRFhqrRvFfJ1uE5RvV4rz+ZiALCgixCgN0y87tSq2E4bT8atOjJh2mLokTf5WbeI
 FIyCHzy1idjP0wqf9hTdrHT2vFQI17Sm1x6y4bYpVJoqeRuC2xSNsfVwMoBH81641dtB
 rH80Tnvq+yY/SsI7LiLe+Sru2/bx77eGo3qIvmEae/2B/gNwhOO/V2gxKIqNEYq9ahdC
 Fq1/q9s2RZruYPvo9bTNW9mLuVMXQpWR7IguvJf0E++RHNcDl373kEhm5VpFEaxM4eFd
 ohtVIPyzXpZvwMQAqEN1iq/Da9XsoXl+LpAEB7yRejrph2EQ5OsqzdSmiH5mm9JHxAO+
 RxFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703242540; x=1703847340;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GZxQpTBXpMLj270/0g+e/diwctDGETsKiPtO+RUhCrM=;
 b=JyErXXLsbAVBe0HPtWNLQnoW+QoZ79ARYOYQfXheHILQ8bEWBysmkfzrtn6Fhs/WIk
 puxRJXYYCqeIvaXPuk0XgpYGg4KFvQre7VMrx+IFfsR8I0/I+HQVHXOaWBocPJ4samMU
 kLx5eqjCSzaVxxZ7+8rlnWFQu5hmSbEm6S3jJzdVpY/JmyvxLUWmjx9Uy8GnrXQkJxxp
 I98v7lh5b9/gxeT3ALbUdwLwzMts95lEt2Jma8Jw/vp/4kftEZYs4HqXknNctwou8Fn0
 AXnOlBkorjiP0rGN7wGaIwtAtag0IEJYEczEb3t7D3mtmF/8uRe6Y1HIT89bNubvymEC
 c7+A==
X-Gm-Message-State: AOJu0YyNccriPytaL4FRgxZniBy8c4yJO/vX+BB88jCuXU83Ln8RF0YM
 CXYjVfy1I/vYOLFNCa9DBGgetCdmhrc9tDlh8mGFPUyb33wtKA==
X-Google-Smtp-Source: AGHT+IG4IQktbOmEmvjdsQDNPLVdJuaoRDOfC+onEhESsWMsqdiBqvVca+FjTb4dBu6C1AIZmpT3xKfJ4l4/EhA8MXE=
X-Received: by 2002:a05:6512:10c4:b0:50d:1b7d:26d2 with SMTP id
 k4-20020a05651210c400b0050d1b7d26d2mr858969lfg.91.1703242540439; Fri, 22 Dec
 2023 02:55:40 -0800 (PST)
MIME-Version: 1.0
References: <20231221004030.581388-1-raymond.mao@linaro.org>
 <20231221004030.581388-2-raymond.mao@linaro.org>
In-Reply-To: <20231221004030.581388-2-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 22 Dec 2023 12:55:04 +0200
Message-ID: <CAC_iWjJWOBcsnVqqPoLSVNAZH7qvLsQ576Xa2_JQFBjZmeBLTA@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] bloblist: add API to check the register conventions
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jwerner@chromium.org, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <sean.anderson@seco.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Baruch Siach <baruch@tkos.co.il>, Michal Simek <michal.simek@amd.com>,
 Stefan Roese <sr@denx.de>, Qu Wenruo <wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Raymond,

On Thu, 21 Dec 2023 at 02:40, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Add bloblist_check_reg_conv() to check whether the bloblist is compliant
> to the register conventions defined in Firmware Handoff specification.
> This API can be used for all Arm platforms.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Refactor of bloblist_check_reg_conv().
>
>  common/bloblist.c  | 13 +++++++++++++
>  include/bloblist.h | 12 ++++++++++++
>  2 files changed, 25 insertions(+)
>
> diff --git a/common/bloblist.c b/common/bloblist.c
> index 625e480f6b..193122a8af 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -542,3 +542,16 @@ int bloblist_maybe_init(void)
>
>         return 0;
>  }
> +
> +int bloblist_check_reg_conv(ulong rfdt, ulong rzero)
> +{
> +       if (!IS_ENABLED(CONFIG_OF_BOARD))
> +               return 0;
> +
> +       if (rzero || rfdt != (ulong)bloblist_find(BLOBLISTT_CONTROL_FDT, 0)) {
> +               gd->bloblist = NULL;  /* Reset the gd bloblist pointer */
> +               return -EIO;
> +       }
> +
> +       return 0;
> +}

The function looks correct, but the name is a bit off. There are no
registers conventions check AFAICT. We are just comparing 2 addresses.
Am I missing anything?

Thanks
/Ilias
> diff --git a/include/bloblist.h b/include/bloblist.h
> index 84fc943819..b5d0f147f6 100644
> --- a/include/bloblist.h
> +++ b/include/bloblist.h
> @@ -461,4 +461,16 @@ static inline int bloblist_maybe_init(void)
>  }
>  #endif /* BLOBLIST */
>
> +/**
> + * bloblist_check_reg_conv() - Check whether the bloblist is compliant to
> + *                            the register conventions according to the
> + *                            Firmware Handoff spec.
> + *
> + * @rfdt:  Register that holds the FDT base address.
> + * @rzero: Register that must be zero.
> + * Return: 0 if OK, -EIO if the bloblist is not compliant to the register
> + *        conventions.
> + */
> +int bloblist_check_reg_conv(ulong rfdt, ulong rzero);
> +
>  #endif /* __BLOBLIST_H */
> --
> 2.25.1
>
