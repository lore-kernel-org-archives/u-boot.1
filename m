Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ABE4C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 13:54:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CAC287E23;
	Mon, 18 Dec 2023 14:54:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b4+gW7kG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9803C87E20; Mon, 18 Dec 2023 14:54:04 +0100 (CET)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A87E87E22
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 14:53:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rfried.dev@gmail.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5906988ab8dso1224303eaf.0
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 05:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702907638; x=1703512438; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I/wyw4b7rYnip7gPRdkfrBw65oHGpyOI8GqP8I3wbTc=;
 b=b4+gW7kGCMEfhRgR/3onJufcP0VcNJMUGSR9mPEATfws8cHGUJxHgRGXb2QmCV1FSf
 VdHuDJ6ThJQJG9KcmF0+49eabLvqfDaJF2F01jTYkTWVDJ3P5AIu+Y30TFIsgMU0rQas
 5fAnM4fbPKNY0D+W92yCVwpvTxNgRvs/4KvJlBwMqbkttl6SWCwelDV9K0XLenQxrgGd
 cWB0EboOAh0VmRknGSHjhWgc+I/jkSS/WtuisI4z245M6Oe92Ltn0nTjcVLRYM1/UqHN
 IPr4tpimpeKUD67YejJQt212O64WYdARPRxZHr3QZQzETU9OK8QdeXMPpXRDSQJKt5MQ
 WZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702907638; x=1703512438;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I/wyw4b7rYnip7gPRdkfrBw65oHGpyOI8GqP8I3wbTc=;
 b=ryPhykc7uAzp9iVtEPAIxRuj6KjwAKs19r9vIT9Wyq90u2dOpHYd3wag7LXv4DgNuI
 GB8X8bFTZ1J4+LhTQRtY80GH6FrUJA+HVBzRYB4Imj+40w32evOKoCwxRzqTRbQlb5Mx
 bZAIv0yER4Qpt1WF6+aQMgfM84E48spuvPM8ANDK0kgUvdfYzeX6RgybObaoSWs02lvt
 IAJRgrBKKUdERN8bmuRLIH17AZ0EGmQZhj07JtsgBo657mmnJjsIRdlpcqLZgzFDlZ06
 pVCmOl3lfefPgsv2HwmBK6FJMjMW8Pzit7wg89CGqiwttSykp0tQ4+h3rl54j6NG+fV5
 HcZg==
X-Gm-Message-State: AOJu0Ywc4ZSfn8vX7n+N/ctVxBCDIEPRAIzmv2pLPnAMmvt/1wpugExO
 bem+O9gQsnDt8SO3cWMnF2uVwnFVErp8bVm6n3c=
X-Google-Smtp-Source: AGHT+IG6EzkAbH1aY4nNsCFRK27x73uwk0r0zSQqGyXK1auWAb29qrudLzTOQ4ZIia99fjwGHvcR87WcEalAkQseF7I=
X-Received: by 2002:a4a:98c4:0:b0:58e:250f:7c25 with SMTP id
 b4-20020a4a98c4000000b0058e250f7c25mr5942417ooj.3.1702907637776; Mon, 18 Dec
 2023 05:53:57 -0800 (PST)
MIME-Version: 1.0
References: <20231218023842.281336-1-takahiro.akashi@linaro.org>
 <20231218023842.281336-4-takahiro.akashi@linaro.org>
In-Reply-To: <20231218023842.281336-4-takahiro.akashi@linaro.org>
From: Ramon Fried <rfried.dev@gmail.com>
Date: Mon, 18 Dec 2023 15:53:47 +0200
Message-ID: <CAGi-RULTO1p8zkZ274QgDLhp_jo7JOwJVFyjDur2c4cX3+5sRg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] net: tftp: remove explicit efi configuration
 dependency
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de, 
 ilias.apalodimas@linaro.org, u-boot@lists.denx.de
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

On Mon, Dec 18, 2023 at 5:17=E2=80=AFAM AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> Now it is clear that the feature actually depends on efi interfaces,
> not "bootefi" command. efi_set_bootdev() will automatically be nullified
> if necessary efi component is disabled.
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  net/tftp.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/net/tftp.c b/net/tftp.c
> index 88e71e67de35..2e335413492b 100644
> --- a/net/tftp.c
> +++ b/net/tftp.c
> @@ -302,12 +302,10 @@ static void tftp_complete(void)
>                         time_start * 1000, "/s");
>         }
>         puts("\ndone\n");
> -       if (IS_ENABLED(CONFIG_CMD_BOOTEFI)) {
> -               if (!tftp_put_active)
> -                       efi_set_bootdev("Net", "", tftp_filename,
> -                                       map_sysmem(tftp_load_addr, 0),
> -                                       net_boot_file_size);
> -       }
> +       if (!tftp_put_active)
> +               efi_set_bootdev("Net", "", tftp_filename,
> +                               map_sysmem(tftp_load_addr, 0),
> +                               net_boot_file_size);
>         net_set_state(NETLOOP_SUCCESS);
>  }
>
> --
> 2.34.1
>
Reviewed-by: Ramon Fried <rfried.dev@gmail.com>
