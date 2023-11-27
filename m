Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A78C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 09:31:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60E8587519;
	Mon, 27 Nov 2023 10:31:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="Nehb+gnM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43E1086C89; Mon, 27 Nov 2023 10:31:14 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3211587523
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 10:31:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a00a9c6f1e9so566717066b.3
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 01:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1701077471; x=1701682271;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gUCO/m9uNJfNBTz0iWr7CpPD7ZJOMJmtXxrsLOGYdBQ=;
 b=Nehb+gnMW6OWOLmDJ6nLLR5Molelp8Bhr+CHfk6bZU7bJtfW5z5tMtu1Vyu/37C/S+
 Ro/4cjej6tkMkvYTYtq8fkTiu1B96/eCxHW7G0/d8T7cJKDvJCgIHG1YcAI/GJXXAn4m
 dPvTKLfkeaUgRgSOWvtNYj8L+EpUJPADMmF2vwxvYbtPCauIHliH/Girla+cpeC7ASn8
 KZ4j5Z5bayXifgrhIvnDrCVRYDQczCcO/Lr8e54wQ/TI3UdeI9tsEaePQ+1eh9h7KVLf
 6oBJSbijQQJPmjOMASh7To6Qssc8TW+MMoxpjRwZcOu4uHQFU3sTtBS4vGeVPyWOdrIj
 NLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701077471; x=1701682271;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gUCO/m9uNJfNBTz0iWr7CpPD7ZJOMJmtXxrsLOGYdBQ=;
 b=twrnV+RW3xN+9ghitIEmJ8O35eT04es4nlUv+Ydfbx0u2m0F65FQIOcY8fq102AN0j
 19Nyb8kuFu6teN+SY+Xy9dmrBk1l3J25t5xz8u6+Y82nKPoKklxcpmdbJIBGNXxRIE4z
 3AlkqM+l2mabuG5SPfEA3wgjQSJOwwh1ot537o7YOGxKzWbFt+2NPCTyz7F2VjUFxvui
 hoo6hrd3vjlFgYg5JICAC+QDWe7tlAzZ32WeMVIN0G4K5WTi9dJ2nNGAAg+yH3ph+r3/
 J19Rkj4iXOgHv21nGoL523GuYp+Jyh8omxYMux+SOM3bHM7VcWqgamPOzri5DKA196Oi
 rOig==
X-Gm-Message-State: AOJu0Yx0RSKhRgxBh4olP5ZIG0LCxDrc3yOhK3SbFk/dv7Zhc6qeYH1f
 i8lxoUBZYO2Qd/BQAjMNoJkuD1lnzk2ocZ9/Meyr8A==
X-Google-Smtp-Source: AGHT+IE/OtKIUFEo28yRTOld2M1BOk694EwjpoiSUylgGWA28zJf+Kj11hA95hdcOUrr3BT4dtRbmw==
X-Received: by 2002:a17:906:6d48:b0:a00:4866:4f90 with SMTP id
 a8-20020a1709066d4800b00a0048664f90mr8436882ejt.22.1701077470991; 
 Mon, 27 Nov 2023 01:31:10 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com.
 [209.85.208.50]) by smtp.gmail.com with ESMTPSA id
 s16-20020a170906455000b009fd7bcd9054sm850222ejq.147.2023.11.27.01.31.10
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Nov 2023 01:31:10 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-54b1812ae1fso2361711a12.1
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 01:31:10 -0800 (PST)
X-Received: by 2002:a50:ab57:0:b0:543:90d4:6132 with SMTP id
 t23-20020a50ab57000000b0054390d46132mr9134881edc.16.1701077469874; Mon, 27
 Nov 2023 01:31:09 -0800 (PST)
MIME-Version: 1.0
References: <20231121235713.1530289-1-i@shantur.com>
 <20231121235713.1530289-3-i@shantur.com>
 <CAC_iWjKxyRWd+bf==mO0tLQEG843J631xNQRo0_ueGXpdNCokg@mail.gmail.com>
 <CAHc5_t3bfArFaiWGg_1EdnkhUeaLXc75SRo7TB8LfjGr1AzFJw@mail.gmail.com>
 <CAC_iWjJkQocU5T_wnM0kve1g1Fvu2vj4KQqyz+NBBKbsjcejBw@mail.gmail.com>
In-Reply-To: <CAC_iWjJkQocU5T_wnM0kve1g1Fvu2vj4KQqyz+NBBKbsjcejBw@mail.gmail.com>
From: Shantur Rathore <i@shantur.com>
Date: Mon, 27 Nov 2023 09:30:58 +0000
X-Gmail-Original-Message-ID: <CAHc5_t1MDs6PYHu8q9zBLAa6Tv5tBOaqDYBMU=W+57t7pkpgOg@mail.gmail.com>
Message-ID: <CAHc5_t1MDs6PYHu8q9zBLAa6Tv5tBOaqDYBMU=W+57t7pkpgOg@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] efi_vars: Implement SPI Flash store
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Ilias,

On Mon, Nov 27, 2023 at 7:09=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Shantur
>
> Please don't send a v2 unless the v1 discussion has settled. It just
> makes life harder. I'll ignore v2 for now and respond here.
>

Sure, I'm still learning the ways around here.

> [...]
>
> >
> > >
> > > > +       if (ret)
> > > > +               goto error;
> > > > +
> > > > +       ret =3D spi_flash_erase_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OF=
FSET, EFI_VAR_BUF_SIZE);
> > > > +       debug("%s - Erased SPI Flash offset %lx\n", __func__, CONFI=
G_EFI_VARIABLE_SF_OFFSET);
> > > > +       if (ret)
> > > > +               goto error;
> > > > +
> > > > +       ret =3D spi_flash_write_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OF=
FSET, len, buf);
> > > > +       debug("%s - Wrote buffer to SPI Flash : %ld\n", __func__, r=
et);
> > > > +
> > > > +       if (ret)
> > > > +               goto error;
> > > > +
> > > > +       ret =3D EFI_SUCCESS;
> > > > +error:
> > > > +       if (ret)
> > > > +               log_err("Failed to persist EFI variables in SF\n");
> > > > +       free(buf);
> > > > +       return ret;
> > > > +}
> > > > +
> > > > +efi_status_t efi_var_from_sf(void)
> > > > +{
> > > > +       struct efi_var_file *buf;
> > > > +       efi_status_t ret;
> > > > +       struct udevice *sfdev;
> > > > +
> > > > +       buf =3D calloc(1, EFI_VAR_BUF_SIZE);
> > > > +       if (!buf) {
> > > > +               log_err("Out of memory\n");
> > > > +               return EFI_OUT_OF_RESOURCES;
> > > > +       }
> > >
> > > You don't want normal memory for the variables.  Instead, you want EF=
I
> > > memory which is marked for EFI runtime services data. U-Boot already
> > > has code to support Get/GetNextvariableRT, you just need to use
> > > efi_var_mem_init().
> > > If you need hints have a look at lib/efi_loader/efi_variable_tee.c
> > > which implements variables stored in an RPMB, but still uses the
> > > memory backend for runtime services.
> > >
> >
> > I believe EFI Runtime stuff is handled by efi_variable.c functions.
>
> Yes, they are, but there is a subtle difference here.
> efi_variable.c and efi_variable_tee.c have their own version of
> runtime service implementation. The functions that can be shared
> across the two are in efi_var_common.c.
> What your patch does is shoehorn an SPI backend storage to the
> existing implementation for storing variables to a file. Depending on
> what we decide for runtime calls that can end up being messy.
>
> efi_variable.c -> deals with variables on a file
> efi_variable_tee.c -> deals with variables hidden behind the secure world
>
> I think it would be cleaner to add efi_variable_sf.c and move the
> common functions you need from efi_variable.c -> efi_var_common.c
> Heinrich, do you have a preference for that?

I agree, the v1 patch was not implementing it cleanly.
Based on Akashi's comments I made these changes for v2 ( v3 with some
compiler warning fixes )

- Moved common stuff out of efi_var_file.c to efi_var_common.c
- Added efi_var_sf.c to handle writing vars to SPI Flash as
efi_var_file.c does for File

Happy to change things if needed.

Kind regards,
Shantur
