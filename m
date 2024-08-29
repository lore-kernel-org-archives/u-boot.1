Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 908D7C83F2D
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 14:25:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 099EA88C35;
	Thu, 29 Aug 2024 16:25:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qFZ9DK4y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8B9788C39; Thu, 29 Aug 2024 16:25:32 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4366288B88
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 16:25:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7093d565310so598982a34.2
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 07:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1724941529; x=1725546329;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=euW7zubb7mEKcnCEznURmxsPKVG/wJNrsIishYFovig=;
 b=qFZ9DK4yE4jztGbKtQtFxMsityx6OYTeSiBoaCVXjV8JWuVtfzLRE0lhU5xhJI7YZW
 zHALNNCfKIfE/gcAPbhJ2tAFAdLeu8b6THbshSLSWUWfpwfbOdcGdH6mQYDbUHSWJfmS
 gBpN4OfT0aotMQiwd8IOxWMe4yfLMH8zLEXdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724941529; x=1725546329;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=euW7zubb7mEKcnCEznURmxsPKVG/wJNrsIishYFovig=;
 b=Qxv9JsVNyJKR5tZF29GxLF10Zb5xdW2lfJlwo4r5uwZN/VQHo2rQVNFxU4v85Vf9E9
 aIu9Pp7cCwdTyt2PFBSkseePcQG71tX1eocWMnzlvNxdskXuvid66cfHtQC13WUv8Ln4
 Ud7AnXYIP+jHDF+bdurMcx2CpVZdzJ7p9IcJKhTHxqsKwJjxbEPuKp9JiiLa64G6HTDk
 OUJgOfnLDvPl2NbR6wmVpQh/duP3Ii7EH/jxn5QUJPx9Ab4SpLbESWv7dkgWxkCN+JeT
 Qhvgz/rx326CAODZhgozgZKPR+Js3QX3W2fzauCnzeDskcjfopJ0KJjvVenOaMckrr/o
 2dmg==
X-Gm-Message-State: AOJu0YzfQrkEkDtqxLPgbO/FkBO9ZwqhmBDczMDsfE5DLaE8/uv9njn1
 McuYbY8IXUiI6VyeiYoQXEbQjdz1V8ebFFoQyRaueb58TcjAunKeLLZdENvOvwyVjG35Kk+YMWP
 7u8jNXznnJHVGIgXbKS5pVQH8rr8CVNSujT1aWeu5WGe8/5eKaxdSSg==
X-Google-Smtp-Source: AGHT+IEZQ9iIUf8/+gxHBHxvGYkc7NrnFYuXUQp6OiEbb5KjlbwFVQlAlZV/uSSGhXoYWbsHLtV5AZv2el49iHgr2MQ=
X-Received: by 2002:a05:6830:4123:b0:709:4829:47bd with SMTP id
 46e09a7af769-70f5c3d97b2mr2775000a34.22.1724941529011; Thu, 29 Aug 2024
 07:25:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240825122617.3708982-1-dario.binacchi@amarulasolutions.com>
 <20240825122617.3708982-2-dario.binacchi@amarulasolutions.com>
 <CAFLszTgN=GWbrJAmtBrb95i2ovAhfE1BPco5p3whnL-oCAhbKw@mail.gmail.com>
In-Reply-To: <CAFLszTgN=GWbrJAmtBrb95i2ovAhfE1BPco5p3whnL-oCAhbKw@mail.gmail.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Thu, 29 Aug 2024 16:25:18 +0200
Message-ID: <CABGWkvpfiduptB9H_5zK3SwKwXjuQN1u1YPGukypviDstuZoEg@mail.gmail.com>
Subject: Re: [PATCH 2/2] cmd: booti: adjust the print format
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, linux-amarula@amarulasolutions.com, 
 Eddie James <eajames@linux.ibm.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
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

Hi Simon,

On Thu, Aug 29, 2024 at 4:05=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Dario,
>
> On Sun, 25 Aug 2024 at 06:26, Dario Binacchi
> <dario.binacchi@amarulasolutions.com> wrote:
> >
> > All three addresses printed are in hexadecimal format, but only the
> > first two have the "0x" prefix. The patch aligns the format of the
> > "end" address with the other two by adding the "0x" prefix.
> >
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> >
> > ---
> >
> >  cmd/booti.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/cmd/booti.c b/cmd/booti.c
> > index 62b19e834366..ea811244a0a9 100644
> > --- a/cmd/booti.c
> > +++ b/cmd/booti.c
> > @@ -78,7 +78,7 @@ static int booti_start(struct bootm_info *bmi)
> >
> >         /* Handle BOOTM_STATE_LOADOS */
> >         if (relocated_addr !=3D ld) {
> > -               printf("Moving Image from 0x%lx to 0x%lx, end=3D%lx\n",=
 ld,
> > +               printf("Moving Image from 0x%lx to 0x%lx, end=3D0x%lx\n=
", ld,
> >                        relocated_addr, relocated_addr + image_size);
> >                 memmove((void *)relocated_addr, (void *)ld, image_size)=
;
> >         }
> > --
> > 2.43.0
> >
>
> I really don't like this...numbers are hex in U-Boot and this just
> adds confusion.

Sorry, but I'm quite confused.
Doesn't printing 3 numbers in hexadecimal format with different
formatting (two with `0x` and
 one without) create more confusion?
At least we should ensure formatting consistency.
Also, it seems to me that this patch:
https://patchwork.ozlabs.org/project/uboot/patch/20240825122617.3708982-1-d=
ario.binacchi@amarulasolutions.com/
has been considered correct.

Thanks and regards,
Dario
>
> Regards,
> Simon



--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
