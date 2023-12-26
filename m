Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89117C47072
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:51:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8874987943;
	Tue, 26 Dec 2023 10:48:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e5MUcW7W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57DA18792B; Tue, 26 Dec 2023 10:48:28 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F46E8787E
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:48:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-1f5bd86ceb3so3235447fac.2
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703584104; x=1704188904; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tRvG/QelpNKSqWsli3qKs09x1XqxDzvN3oTAcBQkbSA=;
 b=e5MUcW7Wx+lC5n7EmmPg7KQC5WN5PEfn+3V2cmA04ygP0U0+/kY9BCsgTidQOt1dCH
 hjg92gndM1uecKYyFTLBoYp9DDSNA7YdVapilTWhyN/cUZpKn/PvQqbD3zd5OVeIROdJ
 gUqGzW88DF58qQhkHXHM2MyC1KjBn32tdVW+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584104; x=1704188904;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tRvG/QelpNKSqWsli3qKs09x1XqxDzvN3oTAcBQkbSA=;
 b=XBzbe+lle3nkM0mMk0hQXOlIfEt7qIkGvsW+xo8T9ClGdrGsVGBTsauZ6t5rWFr1qB
 d1kzjvWw6dgulir49uM2wVDUEBHollfUJTZ2p9Ems+1OibrtIU1GaTasLdqCFuIzsTax
 vY2nJJu1Tf2faeWiqJWu3UgkYI80pcTsufYhiAqkESCP00d65ALHJSYFNqHq7YwoDaPe
 B9ObtHxbW7Hg/r3Q6bq3vD90VNptyRakZOkJBNqH0qRoWxwa4s3MsQGzI7ZeFogJ7NdY
 jVS9m44L0GoYvwp8ge9WcPqCf39qu8qwxhPFBMChgpg9cq7Nxwb8cSxiKzFGpXdowhYo
 x7kw==
X-Gm-Message-State: AOJu0YytjbBu/zvwfMhXPkQp8UH4Z3qZrBbZIsj4VXyhGexZPmMWDUp1
 a8gj5nwIb+UiSg7kRbGPo70+c3ZPkwV7UiwOEISRuMXHqMGR
X-Google-Smtp-Source: AGHT+IGKZZ0tXKYrtov2ta0HxekcQbCYLpwBnQkSKXVax/J+MZEeaTztW+dwMw/GgpdeMUKHx0kdKFjZ02vbeaOBHFc=
X-Received: by 2002:a05:6358:c111:b0:170:6eb2:783 with SMTP id
 fh17-20020a056358c11100b001706eb20783mr6850080rwb.28.1703584104741; Tue, 26
 Dec 2023 01:48:24 -0800 (PST)
MIME-Version: 1.0
References: <20231222213110.660402-1-raymond.mao@linaro.org>
 <20231222213110.660402-2-raymond.mao@linaro.org>
In-Reply-To: <20231222213110.660402-2-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:47:44 +0000
Message-ID: <CAFLszTh7f2oy_Aw5Oq1m0Eo4h496dZenhBeYrW9DbB_FxnFADA@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] bloblist: add API to check the register conventions
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, jwerner@chromium.org, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>, 
 Shiji Yang <yangshiji66@outlook.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sean Anderson <sean.anderson@seco.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Baruch Siach <baruch@tkos.co.il>, Michal Simek <michal.simek@amd.com>,
 Stefan Roese <sr@denx.de>, Qu Wenruo <wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Dec 22, 2023 at 9:31=E2=80=AFPM Raymond Mao <raymond.mao@linaro.org=
> wrote:
>
> Add bloblist_check_reg_conv() to check whether the bloblist is compliant
> to the register conventions defined in Firmware Handoff specification.
> This API can be used for all Arm platforms.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Refactor of bloblist_check_reg_conv().
> Changes in v3
> - bloblist_check_reg_conv() returns -ENOENT if OF_BOARD is disabled.
>
>  common/bloblist.c  | 13 +++++++++++++
>  include/bloblist.h | 12 ++++++++++++
>  2 files changed, 25 insertions(+)
>
> diff --git a/common/bloblist.c b/common/bloblist.c
> index 625e480f6b..ba17dd851a 100644
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
> +               return -ENOENT;
> +
> +       if (rzero || rfdt !=3D (ulong)bloblist_find(BLOBLISTT_CONTROL_FDT=
, 0)) {
> +               gd->bloblist =3D NULL;  /* Reset the gd bloblist pointer =
*/
> +               return -EIO;
> +       }

Where does the magic 4a0fb10b value get checked?

> +
> +       return 0;
> +}
> diff --git a/include/bloblist.h b/include/bloblist.h
> index 84fc943819..bd32e38a06 100644
> --- a/include/bloblist.h
> +++ b/include/bloblist.h
> @@ -461,4 +461,16 @@ static inline int bloblist_maybe_init(void)
>  }
>  #endif /* BLOBLIST */
>
> +/**
> + * bloblist_check_reg_conv() - Check whether the bloblist is compliant t=
o
> + *                            the register conventions according to the
> + *                            Firmware Handoff spec.
> + *
> + * @rfdt:  Register that holds the FDT base address.
> + * @rzero: Register that must be zero.
> + * Return: 0 if OK, -EIO if the bloblist is not compliant to the registe=
r
> + *        conventions, -ENOENT if OF_BOARD is disabled.
> + */
> +int bloblist_check_reg_conv(ulong rfdt, ulong rzero);
> +
>  #endif /* __BLOBLIST_H */
> --
> 2.25.1
>

Regards,
Simon
