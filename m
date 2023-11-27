Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC504C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 10:35:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08F0D8752C;
	Mon, 27 Nov 2023 11:35:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LNMwADwq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 558E48752F; Mon, 27 Nov 2023 11:35:49 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C33B287515
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 11:35:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2c5071165d5so6847751fa.0
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 02:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701081346; x=1701686146; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GjuDocDBDs0UWKjiGdUN+Qf5uJGsEIngG4aDa5fhiq4=;
 b=LNMwADwqmWdutIDSV5JTJjh91IELhxOfhkDI8r5xKWK6is8Lw041M8zpB8ZlUZf9Bu
 CBGokUO/45YrKXmcTHH47WcDbtyHDWec90lOcX47fzHoUcoqO4kN5G0mBz7bwkeNevLY
 CdyiLSPSUc8bB02asMRAulU1WE7VsK38UEGK+uIUIWg+/HYnz1OZfJIlOiW+l+C2CGHn
 5xSXP8RaU0txdqcalVvim6AZ0dRJJs8kMOlgF/DqJk30FaMesvKl310z0snxNqtEoYs9
 PQVHxa8+4iU9asIiWg2lgnhPfI73l2CyBhT6Xx9v7O4e/GKfAwqHRKxalObkF4p+xGMU
 nTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701081346; x=1701686146;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GjuDocDBDs0UWKjiGdUN+Qf5uJGsEIngG4aDa5fhiq4=;
 b=aSNfSujz1Oz4DaX2KuF36yySsrEb5Xg0EUWsu9gerAalFJS8MlEdKNX8v2XH6bW1cJ
 YfkFxXUIFnHFi2aClU3anCIx09spLppOICGT50YrOkbbXLuH8ZsSKZTSITD2vMY4pL8y
 sMTUQ9ycSAj6ZYD9W+9rwI9LOMRMEa3O7EEs6JZ3NRtdE7irxD/N56HBXsI7BU3UJQyL
 rrY5WV84PYltgU2n0m6/rGeNZV1Al5pgDR0tK4jc2vamOUgydeXKdY/rzWGKgCR0me74
 CDjCTqP6ItTtCD+7YS/wfCzhK0WvKm4jolGyDdVcbxYg38Fj+td3z81WOXXBGbLia5SD
 turQ==
X-Gm-Message-State: AOJu0YxEPuPXsm2nZ5BtxsFf+JUxTVj7bV0Yk8rQnFDDwhc/fp1q2Bkg
 S5aQXpbtO6ofVKryGyHFt8EHtN8qY61Tvpn6dXlqVg==
X-Google-Smtp-Source: AGHT+IHv2lroun5aVaRu+/Vo/i/3ybdr18SzSl1+iKKJqZJufsBpYdiSuLQz+LOkL7d0xkTZKgc+76SSSOT7j4aKVhk=
X-Received: by 2002:a2e:a493:0:b0:2c9:a20b:c524 with SMTP id
 h19-20020a2ea493000000b002c9a20bc524mr1868451lji.39.1701081346067; Mon, 27
 Nov 2023 02:35:46 -0800 (PST)
MIME-Version: 1.0
References: <20231121235713.1530289-1-i@shantur.com>
 <20231121235713.1530289-3-i@shantur.com>
 <CAC_iWjKxyRWd+bf==mO0tLQEG843J631xNQRo0_ueGXpdNCokg@mail.gmail.com>
 <CAHc5_t3bfArFaiWGg_1EdnkhUeaLXc75SRo7TB8LfjGr1AzFJw@mail.gmail.com>
 <CAC_iWjJkQocU5T_wnM0kve1g1Fvu2vj4KQqyz+NBBKbsjcejBw@mail.gmail.com>
 <CAHc5_t1MDs6PYHu8q9zBLAa6Tv5tBOaqDYBMU=W+57t7pkpgOg@mail.gmail.com>
In-Reply-To: <CAHc5_t1MDs6PYHu8q9zBLAa6Tv5tBOaqDYBMU=W+57t7pkpgOg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 27 Nov 2023 12:35:09 +0200
Message-ID: <CAC_iWjJJmm8nBtGGLJVCnA+=BS79Nuw2AV6fc=U7-axwLq_o-A@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] efi_vars: Implement SPI Flash store
To: Shantur Rathore <i@shantur.com>
Cc: takahiro.akashi@linaro.org, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Mon, 27 Nov 2023 at 11:31, Shantur Rathore <i@shantur.com> wrote:
>
> Hi Ilias,
>
> On Mon, Nov 27, 2023 at 7:09=E2=80=AFAM Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Shantur
> >
> > Please don't send a v2 unless the v1 discussion has settled. It just
> > makes life harder. I'll ignore v2 for now and respond here.
> >
>
> Sure, I'm still learning the ways around here.

No worries -- we've all been there.

>
> > [...]
> >
> > >
> > > >
> > > > > +       if (ret)
> > > > > +               goto error;
> > > > > +
> > > > > +       ret =3D spi_flash_erase_dm(sfdev, CONFIG_EFI_VARIABLE_SF_=
OFFSET, EFI_VAR_BUF_SIZE);
> > > > > +       debug("%s - Erased SPI Flash offset %lx\n", __func__, CON=
FIG_EFI_VARIABLE_SF_OFFSET);
> > > > > +       if (ret)
> > > > > +               goto error;
> > > > > +
> > > > > +       ret =3D spi_flash_write_dm(sfdev, CONFIG_EFI_VARIABLE_SF_=
OFFSET, len, buf);
> > > > > +       debug("%s - Wrote buffer to SPI Flash : %ld\n", __func__,=
 ret);
> > > > > +
> > > > > +       if (ret)
> > > > > +               goto error;
> > > > > +
> > > > > +       ret =3D EFI_SUCCESS;
> > > > > +error:
> > > > > +       if (ret)
> > > > > +               log_err("Failed to persist EFI variables in SF\n"=
);
> > > > > +       free(buf);
> > > > > +       return ret;
> > > > > +}
> > > > > +
> > > > > +efi_status_t efi_var_from_sf(void)
> > > > > +{
> > > > > +       struct efi_var_file *buf;
> > > > > +       efi_status_t ret;
> > > > > +       struct udevice *sfdev;
> > > > > +
> > > > > +       buf =3D calloc(1, EFI_VAR_BUF_SIZE);
> > > > > +       if (!buf) {
> > > > > +               log_err("Out of memory\n");
> > > > > +               return EFI_OUT_OF_RESOURCES;
> > > > > +       }
> > > >
> > > > You don't want normal memory for the variables.  Instead, you want =
EFI
> > > > memory which is marked for EFI runtime services data. U-Boot alread=
y
> > > > has code to support Get/GetNextvariableRT, you just need to use
> > > > efi_var_mem_init().
> > > > If you need hints have a look at lib/efi_loader/efi_variable_tee.c
> > > > which implements variables stored in an RPMB, but still uses the
> > > > memory backend for runtime services.
> > > >
> > >
> > > I believe EFI Runtime stuff is handled by efi_variable.c functions.
> >
> > Yes, they are, but there is a subtle difference here.
> > efi_variable.c and efi_variable_tee.c have their own version of
> > runtime service implementation. The functions that can be shared
> > across the two are in efi_var_common.c.
> > What your patch does is shoehorn an SPI backend storage to the
> > existing implementation for storing variables to a file. Depending on
> > what we decide for runtime calls that can end up being messy.
> >
> > efi_variable.c -> deals with variables on a file
> > efi_variable_tee.c -> deals with variables hidden behind the secure wor=
ld
> >
> > I think it would be cleaner to add efi_variable_sf.c and move the
> > common functions you need from efi_variable.c -> efi_var_common.c
> > Heinrich, do you have a preference for that?
>
> I agree, the v1 patch was not implementing it cleanly.
> Based on Akashi's comments I made these changes for v2 ( v3 with some
> compiler warning fixes )
>
> - Moved common stuff out of efi_var_file.c to efi_var_common.c
> - Added efi_var_sf.c to handle writing vars to SPI Flash as
> efi_var_file.c does for File
>
> Happy to change things if needed.

Great, I'll have a look at v3 then

Thanks
/Ilias
>
> Kind regards,
> Shantur
