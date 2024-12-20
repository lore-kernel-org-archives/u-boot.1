Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D75E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 17:37:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BE1580435;
	Fri, 20 Dec 2024 18:37:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bubXFpsN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E9148042A; Fri, 20 Dec 2024 18:37:42 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0FB280381
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 18:37:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a9a68480164so359155066b.3
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 09:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734716259; x=1735321059; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sSZjbEjvYXOJsT3hx1AYD3y8aDBcm2AEamspxeiuyAY=;
 b=bubXFpsNO6b0BK5IEA2vLooqG2loai2nw1BICNNtSNM7QRh+Iuy3YPybqyJfuTw0vB
 Kvjf5yq1uftHmdaYJwAq9EuT6FGjzygFg4/7gceCRcwypCeHkGY7QJdCoF5d+UXJqNqe
 s9TmGnmtvwgwd7gNzfeG8xlHGnpIGB66gXDhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734716259; x=1735321059;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sSZjbEjvYXOJsT3hx1AYD3y8aDBcm2AEamspxeiuyAY=;
 b=e55H7NAuiALtLNDtUH8M9omF8Av0fxCHZ+qFE9fRXabTHKnMvry9DFqgM/XGwHW/14
 NsVwh/dvRMC8gZERfocM3mz04Kkbwvj9v01zcEbRtDlPu7O3K//OE496U2Z8tdjaJYTu
 KaUX575uBNh6JbNm6Jes41Id7dPG0EzZzj0raAIEk+/6Cbcj1C2YiYsUCOINSWao0CXt
 lQAuRi/o76ihmlZe7c/a1nv82SsocTGV8CE2ziz2YmJEiqbgvoVuR6Oiir4WkiH1rAbg
 B8i1o3mwPJ7EIJ+Zm/AVyqKbn3K1THuSXkKH58/Pu8VxHqwUDLxZnUP4ZaN3ahPCW0nB
 BQoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUk+1ssfcg3O/YX+fxUvqvbVSbvJHEkus8WYsp/ZG8GG/u8OTTOeRkRJcz9BmB3SVlZHpyqM0k=@lists.denx.de
X-Gm-Message-State: AOJu0Yw8WOh+NBVROBWLV8ppxH90yQ36DkiH6nQTbsFuuuNO2vkPyCLe
 6m/qgW0FdHPP3qtMj1WYvxV4MLT8nLIFE5Hwn3YP0sN4Qr2W83RHY6R+Do07CCIlElU8rkC2GmI
 CC2zHDVYpWhl3dy1aSqXnaoQ13Zc5eFQCjg8c
X-Gm-Gg: ASbGncuShAjwu8rDsRf0GxVB8FbStYwS1ZVHRgrDMNSCyboPliWLy9lxKgHf2AR4Nkj
 vzAkgVp6bf7Sx4M/mIZai0vjqDMHqqw4emjZ9vjQ=
X-Google-Smtp-Source: AGHT+IGZN0fkStaTkxK2XpdrKGsEhnZNhw+xUqP9XI3ay3NU7knTm1yXc8RVV87FO8U8scgPXBJOJ1CmUJyaBCUZ0eE=
X-Received: by 2002:a17:906:c115:b0:aa6:6d2b:cbeb with SMTP id
 a640c23a62f3a-aac2d446f89mr314100466b.28.1734716259438; Fri, 20 Dec 2024
 09:37:39 -0800 (PST)
MIME-Version: 1.0
References: <20241202-sandbox_repair_of_embed-v1-0-05aff4b0ccf7@salutedevices.com>
 <20241202-sandbox_repair_of_embed-v1-5-05aff4b0ccf7@salutedevices.com>
 <CAFLszTj7psRzUuKfq+bMKeAsZS2xbox263sk=EAvOGKH+Z781A@mail.gmail.com>
 <fz4k34cnnoabukznehqthg4fk3tjavc54zveiepnecaz7nrmlg@xl4y44up2zrh>
In-Reply-To: <fz4k34cnnoabukznehqthg4fk3tjavc54zveiepnecaz7nrmlg@xl4y44up2zrh>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Dec 2024 10:37:26 -0700
Message-ID: <CAFLszThR7A8u49kJ49Xw8vyA=gBgqcZQdqFX1xEgb2J9E4hVAA@mail.gmail.com>
Subject: Re: [PATCH 5/5] sandbox: set retval early in board_fdt_blob_setup()
To: Evgeny Bachinin <eabachinin@salutedevices.com>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Levi Yun <yeoreum.yun@arm.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>, kernel@salutedevices.com,
 evgen89bachinin@gmail.com, u-boot@lists.denx.de
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

Hi Evgeny,

On Tue, 17 Dec 2024 at 01:59, Evgeny Bachinin
<eabachinin@salutedevices.com> wrote:
>
> Hi, Simon, see below
>
> On Fri, Dec 06, 2024 at 08:31:36AM -0700, Simon Glass wrote:
> > Hi Evgeny,
> >
> > On Mon, 2 Dec 2024 at 06:46, Evgeny Bachinin
> > <EABachinin@salutedevices.com> wrote:
> > >
> > > Bug:
> > > nobody sets 'ret' to non-error value inside board_fdt_blob_setup()
> > > in case, when gd->fdt_blob has been initialized before calling the
> > > board_fdt_blob_setup() (say, due to CONFIG_OF_EMBED=y)
> > >
> > > Reproduced with CONFIG_OF_EMBED=y && BLOBLIST=n.
> > >   ```
> > >     $ ./u-boot
> > >     initcall: 0000000000078e05 (relocated to 000061138d2c7e05)
> > >     initcall: 0000000000117b12 (relocated to 000061138d366b12)
> > >       fdtdec_setup():
> > >             gd->fdt_blob = dtb_dt_embedded()
> > >       fdtdec_setup():
> > >             gd->fdt_blob = board_fdt_blob_setup(&ret);
> > >
> > >         board_fdt_blob_setup():380 ret:-2 gd->fdt_blob:0x61138d4db310
> > >                 if (gd->fdt_blob)
> > >                         return (void *)gd->fdt_blob;
> > >
> > >     initcall failed at call 0000000000117b12 (err=-2: No such file \
> > >        or directory)
> > >     ### ERROR ### Please RESET the board ###
> > >   ```
> > >
> > > Patch moves code, zeroizing the 'ret', before checking the fdt_blob.
> > >
> > > Fixes: d8289e7dfe5 ("sandbox: fdt: Avoid overwriting an existing fdt")
> > > Signed-off-by: Evgeny Bachinin <EABachinin@salutedevices.com>
> > > ---
> > >  arch/sandbox/cpu/cpu.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/sandbox/cpu/cpu.c b/arch/sandbox/cpu/cpu.c
> > > index d1c4dcf0764fb37ec99585a3db16fa34c3a54dac..7e93377e87e75b0fb92a8cf139b4a731a88a6a7b 100644
> > > --- a/arch/sandbox/cpu/cpu.c
> > > +++ b/arch/sandbox/cpu/cpu.c
> > > @@ -377,10 +377,10 @@ void *board_fdt_blob_setup(int *ret)
> > >         int err;
> > >         int fd;
> > >
> > > +       *ret = 0;
> > >         if (gd->fdt_blob)
> > >                 return (void *)gd->fdt_blob;
> > >         blob = map_sysmem(CONFIG_SYS_FDT_LOAD_ADDR, 0);
> > > -       *ret = 0;
> > >         if (!state->fdt_fname) {
> > >                 err = setup_auto_tree(blob);
> > >                 if (!err)
> > >
> > > --
> > > 2.34.1
> > >
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > But note for the future we have:
> >
> > https://patchwork.ozlabs.org/project/uboot/patch/20241102174944.412088-2-sjg@chromium.org/
>
> Thanks for pointing me!
>
> Could you advise me?
> Should I abandon this patch from v2 patch-set?

I believe it should be fixed, but see what you think.

Regards,
Simon
