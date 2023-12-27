Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99AEFC46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 02:38:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A157887705;
	Wed, 27 Dec 2023 03:38:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RD4NB1em";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5B0F87708; Wed, 27 Dec 2023 03:38:39 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DF72876E5
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 03:38:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-28c05f68d1cso531843a91.1
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 18:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703644713; x=1704249513; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3UrZwONBeRkR81cnZod9m3wPBH/XfckZsW+72fbjmSE=;
 b=RD4NB1emrZEZXitVP83cNO7h9u2nSVP1cBuFFIL7I9SCxw6fXhMSCgZxEKNnU4Zntq
 vHhrQIQpr6RNqZT8HbdGXIuFGLPcNSA6ApZde22o8HiZBhgkbWAbiid7FT1RHuNzh1S1
 QI9+y7I4e9+0i5vsiSyAesW0JzCiIDCNuy3iL1JSe3YubOh5frVgqOrf0cFmqmLPrniM
 7MubmJGiuRlSk6bFl0waLXgkujNE3PJ++Ed4H2Lf9S1pFOtKhuVAeqhqQbsE+4VTZt4a
 1qXeZ6rgUm6p7P9DjzCt+9jCfMGvshpJpsSA72NucrmoFVMBzZiBeCDKzjev6iBrJQri
 BmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703644713; x=1704249513;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3UrZwONBeRkR81cnZod9m3wPBH/XfckZsW+72fbjmSE=;
 b=e7xnQHBQC4DhOT/ErDs7BlYKG5Mi77Q+8K2Q35jQMieHP+Fq7rvqk0C60alKEnvNNm
 2ujdremYiBSe3xjQTSVjrN4b1WI82LZWIA0WZHy52gBUACCyfckiBGUq+j+twyWz3InN
 isjBL2eeo8snHsoBLSar7BfF2pK6uWOOAOk2o83U6rBN2BtpSOC477YUuO+9YexKvxzo
 5R6Ju/sxqbbSY1yTjdh0uIMUvdwp8LJCudv9AcqnX4JHHr8a/ks32YREjGDfMENeqExt
 tHbmfdJtIeRPpATj6U3qrmFLde9C0qSzJjGyJt98vyeleCADcGryrNlfZ6jW7V1WvjTf
 ddQA==
X-Gm-Message-State: AOJu0YwZ5JdH/Co4kjlIwENtdnOeDVBMY7tmF7sM3TJtuEAvTnS4LSwu
 rXf9pPv4ynL/kOogEexL8mOzFsjW1mvvyA==
X-Google-Smtp-Source: AGHT+IE75ez+liQmju3hise4j6vjmh/EzvWoLZ+HT0coXadgJkNV8JLe3LwIe3BPX4qn97JE++eKjg==
X-Received: by 2002:a05:6a00:1d13:b0:6d9:b7b8:133f with SMTP id
 a19-20020a056a001d1300b006d9b7b8133fmr8858690pfx.1.1703644712625; 
 Tue, 26 Dec 2023 18:38:32 -0800 (PST)
Received: from octopus ([2400:4050:c3e1:100:4ad3:47d:9b95:93a5])
 by smtp.gmail.com with ESMTPSA id
 kr15-20020a056a004b4f00b006cc02a6d18asm4997254pfb.61.2023.12.26.18.38.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 18:38:32 -0800 (PST)
Date: Wed, 27 Dec 2023 11:38:28 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, trini@konsulko.com,
 ilias.apalodimas@linaro.org, u-boot@lists.denx.de
Subject: Re: [PATCH v3 3/4] net: tftp: remove explicit efi configuration
 dependency
Message-ID: <ZYuOJKao6Dij9vvS@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, trini@konsulko.com,
 ilias.apalodimas@linaro.org, u-boot@lists.denx.de
References: <20231218023842.281336-1-takahiro.akashi@linaro.org>
 <20231218023842.281336-4-takahiro.akashi@linaro.org>
 <CAPnjgZ0qw7j3TCMN+xH6ONaWvUyRvkWpsZJd2PQWHYBhZkTD6g@mail.gmail.com>
 <ZYDhClYupQxNJ++a@octopus>
 <CAPnjgZ222JWVWws04Tk93QommHXY6=qJFfiQfosYs5FG4JVGrA@mail.gmail.com>
 <CD73D0D7-1040-4AD9-B5CD-741146DE0C34@gmx.de>
 <CAFLszTi2k3CyfbybPuNCKTFZoVUiZy++Ma0BoUrYTj5dUWFh_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTi2k3CyfbybPuNCKTFZoVUiZy++Ma0BoUrYTj5dUWFh_w@mail.gmail.com>
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

On Tue, Dec 26, 2023 at 09:47:03AM +0000, Simon Glass wrote:
> Hi Heinrich,
> 
> On Wed, Dec 20, 2023 at 9:17???AM Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> >
> >
> > Am 20. Dezember 2023 05:46:16 MEZ schrieb Simon Glass <sjg@chromium.org>:
> > >Hi,
> > >
> > >On Mon, 18 Dec 2023 at 17:17, AKASHI Takahiro
> > ><takahiro.akashi@linaro.org> wrote:
> > >>
> > >> Hi Simon,
> > >>
> > >> On Mon, Dec 18, 2023 at 08:01:46AM -0700, Simon Glass wrote:
> > >> > Hi AKASHI,
> > >> >
> > >> > On Sun, 17 Dec 2023 at 19:39, AKASHI Takahiro
> > >> > <takahiro.akashi@linaro.org> wrote:
> > >> > >
> > >> > > Now it is clear that the feature actually depends on efi interfaces,
> > >> > > not "bootefi" command. efi_set_bootdev() will automatically be nullified
> > >> > > if necessary efi component is disabled.
> > >> > >
> > >> > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > >> > > ---
> > >> > >  net/tftp.c | 10 ++++------
> > >> > >  1 file changed, 4 insertions(+), 6 deletions(-)
> > >> > >
> > >> >
> > >> > I have the same comment here as the 'fs' patch.
> > >> >
> > >> > > diff --git a/net/tftp.c b/net/tftp.c
> > >> > > index 88e71e67de35..2e335413492b 100644
> > >> > > --- a/net/tftp.c
> > >> > > +++ b/net/tftp.c
> > >> > > @@ -302,12 +302,10 @@ static void tftp_complete(void)
> > >> > >                         time_start * 1000, "/s");
> > >> > >         }
> > >> > >         puts("\ndone\n");
> > >> > > -       if (IS_ENABLED(CONFIG_CMD_BOOTEFI)) {
> > >> >
> > >> > Shouldn't this depend on your new CONFIG? What happens if EFI_LOADER
> > >> > is not enabled?
> > >>
> > >> The trick is in efi_loader.h.
> > >> If EFI_LOADER (more specifically CONFIG_EFI_BINARY_EXEC) is not defined,
> > >> this function gets voided.  See patch#1 in this version.
> > >>
> > >> I took this approach in order not to make users much worried about
> > >> what config be used as they are not familiar with UEFI implementation.
> > >
> > >OK, but we really need to delete this function, so what is the plan
> > >for that? The info that EFI needs should be passed to the bootefi()
> > >function, not set in a global.
> >
> > Hello Simon,
> >
> > Bootstd is not the only way to boot. Please, do not forget the shell.
> >
> > The user loads a file with tftpboot. At some later moment the user executes bootefi.
> >
> > We need a place where we store the device from which the image was loaded.
> 
> Yes, agreed. See my other reply on that.
> 
> >
> > In future we might have a register of loaded files. But that is beyond the scope of this patch series.
> 
> I believe we could just record the device and partition number (which
> is itself a device these days, I suppose). Then for EFI can do the
> translation at the start of the bootm cmd if not using bootstd.

Then, what is the difference between "record the device and partition
number (strictly it's not accurate because we also support tftp and others.)
and "call efi_set_bootdev()"?

The latter does the translation on the fly and saves the info
in bootefi_image_path and bootefi_device_path local variables.

I believe that both are essentially the same.

> Reviewed-by: Simon Glass <sjg@chromium.org>

Always thank you for your review.

-Takahiro Akashi

> 
> >
> > Best regards
> >
> > Heinrich
> >
> > >
> > >
> > >>
> > >> -Takahiro Akashi
> > >>
> > >> > > -               if (!tftp_put_active)
> > >> > > -                       efi_set_bootdev("Net", "", tftp_filename,
> > >> > > -                                       map_sysmem(tftp_load_addr, 0),
> > >> > > -                                       net_boot_file_size);
> > >> > > -       }
> > >> > > +       if (!tftp_put_active)
> > >> > > +               efi_set_bootdev("Net", "", tftp_filename,
> > >> > > +                               map_sysmem(tftp_load_addr, 0),
> > >> > > +                               net_boot_file_size);
> > >> > >         net_set_state(NETLOOP_SUCCESS);
> > >> > >  }
> > >> > >
> > >> > > --
> > >> > > 2.34.1
> > >
> > >Regards,
> 
> Regards,
> Simon
