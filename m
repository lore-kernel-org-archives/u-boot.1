Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C63C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 04:46:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FA46875E9;
	Wed, 20 Dec 2023 05:46:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mBmYl3tm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63F62875E9; Wed, 20 Dec 2023 05:46:30 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71AEF875F0
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 05:46:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a2339262835so411383166b.3
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 20:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703047588; x=1703652388; darn=lists.denx.de;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O/5t34SFBrCPoNLpnEkQXt2qR0rXllkXJmpXVFchzGM=;
 b=mBmYl3tmYVEURbrJW80iGuFad2x4Jdf12bEh5AhErlv8roLi/wTv3ZblqjeqARMWXB
 iHsEbL9u5Qv4QRewZ+CsZxRej7bHYpWRsUbgfxDP0Ld+RApy1eE00LTz2eJWb5Uy8En2
 G5Awl4DwePJ+paV9/33/b0wED8hBFnczMVzBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703047588; x=1703652388;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O/5t34SFBrCPoNLpnEkQXt2qR0rXllkXJmpXVFchzGM=;
 b=ZESTuo/Vp3Q6jncBpvGkbvuPwagDjR1+S4P+eILIspFm0EVuQTZLHheThrzCEFSDUL
 dw9bJ92sPq2r0vZKTB/riqsgLpFh4XyqxQOch3Yy0E3eBffabZKQuNCrlAjrwAL2Ac5a
 Ndm3GLi/96nYebWYMYidCJ3NR+x5ZP+xRUeL+9XSdzyJPe9x/65peL3q6vwar2pjh9+T
 6dOMjR4qZX4q+GwnCp/AQCusONNVtdUTP8E4GNbKvmhAZa4k/F8Ad969ok1FuFcRKgES
 iaioLMf/C1R//ceafvS1FkHAlpCumHRAeC69UeXsF556wNFc9YClz6shr+LzNynIO+xf
 7P4A==
X-Gm-Message-State: AOJu0Yzus5zCcQB4zT/fagemv4yYe5fqoDW6nOmcOxA3UHpHXcxwglGq
 71zjOq/5XM1jNL0GANnRGFdsX49GsYgRxH1204q+yA==
X-Google-Smtp-Source: AGHT+IGA9+IRaozVG2mshywzo4TX//tkJiEeV8CXe9ujGhK1K0uWaiJGGPhagaIUOWCCMi9wMKIz4LAqhIMCTNZe6z8=
X-Received: by 2002:a17:907:90c3:b0:a26:894f:133 with SMTP id
 gk3-20020a17090790c300b00a26894f0133mr467191ejb.86.1703047587802; Tue, 19 Dec
 2023 20:46:27 -0800 (PST)
MIME-Version: 1.0
References: <20231218023842.281336-1-takahiro.akashi@linaro.org>
 <20231218023842.281336-4-takahiro.akashi@linaro.org>
 <CAPnjgZ0qw7j3TCMN+xH6ONaWvUyRvkWpsZJd2PQWHYBhZkTD6g@mail.gmail.com>
 <ZYDhClYupQxNJ++a@octopus>
In-Reply-To: <ZYDhClYupQxNJ++a@octopus>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 Dec 2023 21:46:16 -0700
Message-ID: <CAPnjgZ222JWVWws04Tk93QommHXY6=qJFfiQfosYs5FG4JVGrA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] net: tftp: remove explicit efi configuration
 dependency
To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Simon Glass <sjg@chromium.org>, trini@konsulko.com, 
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, u-boot@lists.denx.de
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

Hi,

On Mon, 18 Dec 2023 at 17:17, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> Hi Simon,
>
> On Mon, Dec 18, 2023 at 08:01:46AM -0700, Simon Glass wrote:
> > Hi AKASHI,
> >
> > On Sun, 17 Dec 2023 at 19:39, AKASHI Takahiro
> > <takahiro.akashi@linaro.org> wrote:
> > >
> > > Now it is clear that the feature actually depends on efi interfaces,
> > > not "bootefi" command. efi_set_bootdev() will automatically be nullified
> > > if necessary efi component is disabled.
> > >
> > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > ---
> > >  net/tftp.c | 10 ++++------
> > >  1 file changed, 4 insertions(+), 6 deletions(-)
> > >
> >
> > I have the same comment here as the 'fs' patch.
> >
> > > diff --git a/net/tftp.c b/net/tftp.c
> > > index 88e71e67de35..2e335413492b 100644
> > > --- a/net/tftp.c
> > > +++ b/net/tftp.c
> > > @@ -302,12 +302,10 @@ static void tftp_complete(void)
> > >                         time_start * 1000, "/s");
> > >         }
> > >         puts("\ndone\n");
> > > -       if (IS_ENABLED(CONFIG_CMD_BOOTEFI)) {
> >
> > Shouldn't this depend on your new CONFIG? What happens if EFI_LOADER
> > is not enabled?
>
> The trick is in efi_loader.h.
> If EFI_LOADER (more specifically CONFIG_EFI_BINARY_EXEC) is not defined,
> this function gets voided.  See patch#1 in this version.
>
> I took this approach in order not to make users much worried about
> what config be used as they are not familiar with UEFI implementation.

OK, but we really need to delete this function, so what is the plan
for that? The info that EFI needs should be passed to the bootefi()
function, not set in a global.


>
> -Takahiro Akashi
>
> > > -               if (!tftp_put_active)
> > > -                       efi_set_bootdev("Net", "", tftp_filename,
> > > -                                       map_sysmem(tftp_load_addr, 0),
> > > -                                       net_boot_file_size);
> > > -       }
> > > +       if (!tftp_put_active)
> > > +               efi_set_bootdev("Net", "", tftp_filename,
> > > +                               map_sysmem(tftp_load_addr, 0),
> > > +                               net_boot_file_size);
> > >         net_set_state(NETLOOP_SUCCESS);
> > >  }
> > >
> > > --
> > > 2.34.1

Regards,
Simon
