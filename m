Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD01C4332F
	for <u-boot@archiver.kernel.org>; Mon, 30 Oct 2023 00:34:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F65B86FEC;
	Mon, 30 Oct 2023 01:34:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="R2JvIutO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E26687019; Mon, 30 Oct 2023 01:34:19 +0100 (CET)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0091286FEB
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 01:34:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6ba8eb7e581so961972b3a.0
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 17:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698626054; x=1699230854; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7CU0oDlxLucR/cRyb7DRhLDMUdOlzjV1S8+UqQuxX0k=;
 b=R2JvIutOlnVVgeTksC+n/lYesEZCmOb2tnlU96f5pwh05uqt3VMHrsxZPohQotXWoM
 hS/yiacIKGyKTENg9bq8WYEJuzksTNjO9iSAMWd6kPtnDqpvSI8bCIjuxiNMf1hA31ha
 3u1wSiSXvi5YEPEyTWq30Ic8y1Le279yWvtBIoj1Ky6WCDknCzLKmPBKOkpg386rnD2M
 noERHXEz0jApkSElZbOx/LDiKroM1vyN01WZoD7TOA1hZdd7HOUahh+TkwE8K2E/oZnU
 pdcrucAsiwbwkQIw+NIQZtC4NcBqYEsinCY2e2UgIfAVVuKi4UpdXDjcwH+1Sz/kLkuj
 FKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698626054; x=1699230854;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7CU0oDlxLucR/cRyb7DRhLDMUdOlzjV1S8+UqQuxX0k=;
 b=hovBs00nN7trQHo65Vzcd74zvNaVQfxuPKt5pifC8lVeyvU4VZfy0vksQ/DFEGTSDK
 2u8MdGDMpZ3Cj3u3DdaEDah4xEY4OqUWTTNI3H/PwfKUgS9e0YiN6i0z+DIBlKYoEcV5
 FVXT6z48nIOo1gukNgpxPTkQWI8fRIRv1ObblAA4NxJgX0Z4Mh7/9UcbD3d2GdzH6I3b
 AEr+qu+M+gxyE0nrAKvVTtArrnuz3ZSLrVpQVw9G2elh9xiF+sVEUhk1Bv9yWF01BVu7
 roO2ur73Jb/+4mLVsXsV/SEW1BkT+i7egJ5n/LhfAP9Yc794eQQ8Tf2wlHs1R7Y7ySFl
 XywA==
X-Gm-Message-State: AOJu0YztH6w470mE/eBHTUVwwg6JpdKh74v1z9Hfg/qaLQZf8VhlqTad
 jLnvZjMOoD9USGcbw85ZuC5XBg==
X-Google-Smtp-Source: AGHT+IGyioh08dL47Eqo166HYt4ImPEFdIaGWgs+aV2UVTB6r9PoH8n7pvNakS3G2pw8faQw7bY2zQ==
X-Received: by 2002:a05:6a20:5483:b0:17a:d292:25d1 with SMTP id
 i3-20020a056a20548300b0017ad29225d1mr12981387pzk.6.1698626053655; 
 Sun, 29 Oct 2023 17:34:13 -0700 (PDT)
Received: from octopus ([2400:4050:c3e1:100:ee18:6d74:390f:129e])
 by smtp.gmail.com with ESMTPSA id
 ep7-20020a17090ae64700b002802d9d4e96sm2506336pjb.54.2023.10.29.17.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Oct 2023 17:34:13 -0700 (PDT)
Date: Mon, 30 Oct 2023 09:34:09 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 jbx6244@gmail.com, u-boot@lists.denx.de, sjg@chromium.org
Subject: Re: [RFC 01/13] cmd: bootefi: unfold do_bootefi_image()
Message-ID: <ZT76AUr6gNEMqNM1@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, jbx6244@gmail.com,
 u-boot@lists.denx.de, sjg@chromium.org
References: <20231026053052.622453-1-takahiro.akashi@linaro.org>
 <20231026053052.622453-2-takahiro.akashi@linaro.org>
 <b6110e38-5a44-4fcf-8ae1-ad77f1b66390@gmx.de>
 <ZTsDiJUA9esxg9nb@octopus> <20231027010001.GR496310@bill-the-cat>
 <CAC_iWjJ5KA9H8=FcOLuScG7_wQ24G=qs61PAitqVCRvmcwNfFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_iWjJ5KA9H8=FcOLuScG7_wQ24G=qs61PAitqVCRvmcwNfFg@mail.gmail.com>
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

On Fri, Oct 27, 2023 at 03:23:07PM +0300, Ilias Apalodimas wrote:
> Akashi-san
> 
> On Fri, 27 Oct 2023 at 04:00, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Oct 27, 2023 at 09:25:44AM +0900, AKASHI Takahiro wrote:
> > > On Thu, Oct 26, 2023 at 01:01:52PM +0200, Heinrich Schuchardt wrote:
> > > > On 10/26/23 07:30, AKASHI Takahiro wrote:
> > > > > Unfold do_bootefi_image() into do_bootefi() for the sake of the succeeding
> > > > > refactor work.
> > > > >
> 
> I don't disagree with the patchset, but what the patch does is pretty
> obvious.

Yeah, that is what I tried to do in this patch series, i.e. each step
be as trivial as possible to ensure that the semantics is unchanged
while the code is being morphed.

> It would help a lot to briefly describe how the unfolding
> process helps the refactoring.

Not sure, but will add a few more words.

Thanks,
-Takahiro Akashi


> Thanks
> /Ilias
> > > > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > > > ---
> > > > >   cmd/bootefi.c | 101 ++++++++++++++++++--------------------------------
> > > > >   1 file changed, 37 insertions(+), 64 deletions(-)
> > > > >
> > > > > diff --git a/cmd/bootefi.c b/cmd/bootefi.c
> > > > > index 20e5c94a33a4..1b28bf5a318d 100644
> > > > > --- a/cmd/bootefi.c
> > > > > +++ b/cmd/bootefi.c
> > > > > @@ -425,58 +425,6 @@ static int do_efibootmgr(void)
> > > > >           return CMD_RET_SUCCESS;
> > > > >   }
> > > > >
> > > > > -/**
> > > > > - * do_bootefi_image() - execute EFI binary
> > > > > - *
> > > > > - * Set up memory image for the binary to be loaded, prepare device path, and
> > > > > - * then call do_bootefi_exec() to execute it.
> > > > > - *
> > > > > - * @image_opt:   string with image start address
> > > > > - * @size_opt:    string with image size or NULL
> > > > > - * Return:       status code
> > > > > - */
> > > > > -static int do_bootefi_image(const char *image_opt, const char *size_opt)
> > > > > -{
> > > > > - void *image_buf;
> > > > > - unsigned long addr, size;
> > > > > - efi_status_t ret;
> > > > > -
> > > > > -#ifdef CONFIG_CMD_BOOTEFI_HELLO
> > > > > - if (!strcmp(image_opt, "hello")) {
> > > > > -         image_buf = __efi_helloworld_begin;
> > > > > -         size = __efi_helloworld_end - __efi_helloworld_begin;
> > > > > -         efi_clear_bootdev();
> > > > > - } else
> > > > > -#endif
> > > > > - {
> > > > > -         addr = strtoul(image_opt, NULL, 16);
> > > > > -         /* Check that a numeric value was passed */
> > > > > -         if (!addr)
> > > > > -                 return CMD_RET_USAGE;
> > > > > -         image_buf = map_sysmem(addr, 0);
> > > > > -
> > > > > -         if (size_opt) {
> > > > > -                 size = strtoul(size_opt, NULL, 16);
> > > > > -                 if (!size)
> > > > > -                         return CMD_RET_USAGE;
> > > > > -                 efi_clear_bootdev();
> > > > > -         } else {
> > > > > -                 if (image_buf != image_addr) {
> > > > > -                         log_err("No UEFI binary known at %s\n",
> > > > > -                                 image_opt);
> > > > > -                         return CMD_RET_FAILURE;
> > > > > -                 }
> > > > > -                 size = image_size;
> > > > > -         }
> > > > > - }
> > > > > - ret = efi_run_image(image_buf, size);
> > > > > -
> > > > > - if (ret != EFI_SUCCESS)
> > > > > -         return CMD_RET_FAILURE;
> > > > > -
> > > > > - return CMD_RET_SUCCESS;
> > > > > -}
> > > > > -
> > > > >   /**
> > > > >    * efi_run_image() - run loaded UEFI image
> > > > >    *
> > > > > @@ -648,8 +596,9 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
> > > > >                         char *const argv[])
> > > > >   {
> > > > >           efi_status_t ret;
> > > > > - char *img_addr, *img_size, *str_copy, *pos;
> > > > > - void *fdt;
> > > > > + char *p;
> > > > > + void *fdt, *image_buf;
> > > > > + unsigned long addr, size;
> > > > >
> > > > >           if (argc < 2)
> > > > >                   return CMD_RET_USAGE;
> > > > > @@ -684,18 +633,42 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
> > > > >           if (!strcmp(argv[1], "selftest"))
> > > > >                   return do_efi_selftest();
> > > > >   #endif
> > > > > - str_copy = strdup(argv[1]);
> > > > > - if (!str_copy) {
> > > > > -         log_err("Out of memory\n");
> > > > > -         return CMD_RET_FAILURE;
> > > > > +
> > > > > +#ifdef CONFIG_CMD_BOOTEFI_HELLO
> > > >
> > > > I would prefer a normal if and let the linker sort it out.
> > >
> > > Here I focused on simply unfolding("moving") the function, keeping the code
> > > as same as possible. Any how the code is in a tentative form
> > > at this point and will be reshaped in later patches, using IS_ENABLED().
> > > Please look at the final code after applying the whole series.
> >
> > I also agree with this approach.
> >
> > --
> > Tom
