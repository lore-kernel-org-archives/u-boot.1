Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F811E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 22:17:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF2BB801B0;
	Thu, 12 Dec 2024 23:17:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="r+UOPh5K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E52EC801BA; Thu, 12 Dec 2024 23:17:51 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DA80801A9
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 23:17:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-6ef60e500d7so9309537b3.0
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 14:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734041868; x=1734646668; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mq6B5NpseQcG8mANyqg7pam/QqDZcpalQoNUgNFXthE=;
 b=r+UOPh5K+eE/yECSFyGUcD4ap3wiVzfj0vWTF/m5fkQRD8GW+PezPWvqLQMPFRPjRi
 ESB0Btb2oscfmEFoiX+G4IcTWRD8CfRTmNGuUc4jdg62iHD6PU3uiTFHbw3p5Lmy1EL/
 /oxv/SmIB4ocHKCHfOlBxwnM4x7+nXO9w3DDswev2ywYtOAut701PPb8ENT+IVfwefcN
 wivUphvHHqrF+kEz4WPm1GqwrN+8BTE2OG75Ndi8pIkktoKBpgXf08fSMr2R1blLAtDq
 vAFDj4/L855QTNKIr8iycIIFlOOwkewvzVMOaUak3Uh+XrL84TbFieHZyVLwTM/oG44M
 /Kjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734041868; x=1734646668;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mq6B5NpseQcG8mANyqg7pam/QqDZcpalQoNUgNFXthE=;
 b=D6QHccLrJi130pQZwfaR3juhQdCfiwTFuXkdYoU9PAEo7Dhq4QGsb3q9YfhLxYMU75
 WK9EKvn1e0D1NtcRQDQMqshm4lBYUldb7s6S94ljhv9QkiBL/DXJsvrJqXkP0KnN7Zhv
 M2ft2RicXkM1BsvpA2KwMjj3vKpvY0n4gbKxSTmKwzBgx4+QkhgOny1UwlTqObuCqfB5
 /0lvl/+Z22zgSBBcRU/66+69JbmkNuRma7kfMAFfsKy6yhQXjbS8Y89JKh4TRKiWXtBu
 xgjqciv8F2vAjS1hIRcaGkE7MPaJ27Fk+M3FWDgdPP4ZUokuAO9XJbFYbEHsX5CEX0LQ
 Jz/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgS++RgZ8OeGx/nqUws0+smOTSDVrNY8t2L5eoB9S0P6e72h4yLMJ1mvsZgD5dDarzd3Y6bxA=@lists.denx.de
X-Gm-Message-State: AOJu0Yz05dWJzEdfF2niQdfgs3Fs45x2YPghS9A3u4zROyHCCyXGU17H
 mjCV/IIFtWRJ3NyG2C8N5jsq7amfVX1vHAFCDA4OpLfUS7/0yJsNZONhNV1WEehebVmkoQ910V3
 oFjOtxq1K6yWKdzTkq+Fqh+1Qt1jThKG9grnT8A==
X-Gm-Gg: ASbGnct05LoEQyqwGnfR8SwFHuuGhZ36ndWiuN3llY8ZXpUvCIoVD4ncNlTxKxSUuOq
 aRT2LA90OK89QyooN0gscl31JqpsCwVP3j51gHg==
X-Google-Smtp-Source: AGHT+IG/QZdgqJmjMyuZQQXN2GWkj3DUr9SFmfwGScEeTTxKMrM3eaYJ7cYmiWPYWOEZqdqfedDgQaBHuIXW5Nd4vgg=
X-Received: by 2002:a05:690c:f95:b0:6e5:9d3c:f9d3 with SMTP id
 00721157ae682-6f279b8e54emr3805917b3.41.1734041868484; Thu, 12 Dec 2024
 14:17:48 -0800 (PST)
MIME-Version: 1.0
References: <20241211105504.453234-1-ilias.apalodimas@linaro.org>
 <20241211105504.453234-6-ilias.apalodimas@linaro.org>
In-Reply-To: <20241211105504.453234-6-ilias.apalodimas@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 12 Dec 2024 16:17:36 -0600
Message-ID: <CAPLW+4kUOQqeQ3M3GD9+Wi-d9q6_dzsnBMn+G5XqYF4ZkevgEg@mail.gmail.com>
Subject: Re: [PATCH v1 5/8] lmb: Remove lmb_add_region()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, trini@konsulko.com, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Korsgaard <peter@korsgaard.com>, 
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Nam Cao <namcao@linutronix.de>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Janne Grunau <j@jannau.net>, Caleb Connolly <caleb.connolly@linaro.org>,
 u-boot@lists.denx.de
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

On Wed, Dec 11, 2024 at 4:55=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> There's no point defining a function that's called only once just to
> avoid passing the flags. Remove the wrapper and just call
> lmb_add_region_flags().
>
> Acked-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  lib/lmb.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/lib/lmb.c b/lib/lmb.c
> index da960e422ada..659581f13f20 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -632,19 +632,13 @@ void lmb_add_memory(void)
>         }
>  }
>
> -static long lmb_add_region(struct alist *lmb_rgn_lst, phys_addr_t base,
> -                          phys_size_t size)
> -{
> -       return lmb_add_region_flags(lmb_rgn_lst, base, size, LMB_NONE);
> -}
> -
>  /* This routine may be called with relocation disabled. */
>  long lmb_add(phys_addr_t base, phys_size_t size)
>  {
>         long ret;
>         struct alist *lmb_rgn_lst =3D &lmb.available_mem;
>
> -       ret =3D lmb_add_region(lmb_rgn_lst, base, size);
> +       ret =3D lmb_add_region_flags(lmb_rgn_lst, base, size, LMB_NONE);
>         if (ret)
>                 return ret;
>
> --
> 2.45.2
>
