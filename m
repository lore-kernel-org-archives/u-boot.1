Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139ECC25B47
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 12:23:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1693887707;
	Fri, 27 Oct 2023 14:23:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="y0CpazC/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF8F18770F; Fri, 27 Oct 2023 14:23:46 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C0DC8757B
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 14:23:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-507b9408c61so2831161e87.0
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 05:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698409424; x=1699014224; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ti31zauheh7l86H3U7JFSfgHygK/k3tv/6j7wzOhYdQ=;
 b=y0CpazC/iZWp20wpl9weWWTv7envp5RyDspRdrPm8316pnQsL9zd9cGSVPxTG+J8Bd
 riVb+z7le4Da6gCJ+KHxhzQUkZZqYPMciQNRLqaBRNtS2X6MRFtluxmMi28sPzktfzLf
 K/okTAy+x2AvmbqiPsKGSPDn3ZTBf1JjScYz6VKmeUeoX81X4Wnycz5faVjXQOD1uJCe
 pNGE/vr9WtUO5Tiw1ZF1sajLNFk6TQnP4IgdxRlakeIGMxkndQlLTFyn1nBnlMiCJ6bP
 W/7/lFNd0kG0Kk7FEB5+9htJjW+cRk0x3fa1FqDFWO0T2RIb7kB0w+am/xmHKXmn3S3o
 HgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698409424; x=1699014224;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ti31zauheh7l86H3U7JFSfgHygK/k3tv/6j7wzOhYdQ=;
 b=XRNic6oykCPt9qe8KPBFcN6tyQ1qjp1mt9Hn920FeEw+b7zqmNmWdYes8VVZq9gXBt
 5FtQF5+zFiVxvyAJbuKHf2LKn04GDyknr2zPCgERN46MFziMZQSx6Q8oqly/JPkDo4wp
 Vfhil6CkIEn1yRONapduhauWRRLv930RI3FCnNnUT7GzSP0PHh/LGXpiQlwDqged9vek
 exY/NVy7/sn9y0Qh1HMjC5fE6Ms8zW4ObiyRoNKOR4CxT0kvx48YjEISyV7Lve6BnsJW
 euW7LjXpRbEQdWsN9pm5EMrYMwl0aP63vhhrdeiGHPqIXF2z9u462ykE7GV6Sbi+e6gM
 5x+Q==
X-Gm-Message-State: AOJu0Yw+Ny26YWOOVeSe+yauEFf20YvL9QfET/LZsBFivPP+OdO0rgz5
 GFV/nA7JJ7Kke7P3FSF+TpTYib6KBgbth1UjQQavEw==
X-Google-Smtp-Source: AGHT+IGXJu9Gib8qSLpFhwuwq+ZdZa2emQhq+GjFqIcoAUVJJtEosxOY5oWIxoJeFz8LAbwM8CsGrfxP65EWAWY69HQ=
X-Received: by 2002:a05:6512:405:b0:503:1722:bf3a with SMTP id
 u5-20020a056512040500b005031722bf3amr1732362lfk.1.1698409423754; Fri, 27 Oct
 2023 05:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <20231026053052.622453-1-takahiro.akashi@linaro.org>
 <20231026053052.622453-2-takahiro.akashi@linaro.org>
 <b6110e38-5a44-4fcf-8ae1-ad77f1b66390@gmx.de>
 <ZTsDiJUA9esxg9nb@octopus> <20231027010001.GR496310@bill-the-cat>
In-Reply-To: <20231027010001.GR496310@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 27 Oct 2023 15:23:07 +0300
Message-ID: <CAC_iWjJ5KA9H8=FcOLuScG7_wQ24G=qs61PAitqVCRvmcwNfFg@mail.gmail.com>
Subject: Re: [RFC 01/13] cmd: bootefi: unfold do_bootefi_image()
To: Tom Rini <trini@konsulko.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, jbx6244@gmail.com, 
 u-boot@lists.denx.de, sjg@chromium.org
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

Akashi-san

On Fri, 27 Oct 2023 at 04:00, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Oct 27, 2023 at 09:25:44AM +0900, AKASHI Takahiro wrote:
> > On Thu, Oct 26, 2023 at 01:01:52PM +0200, Heinrich Schuchardt wrote:
> > > On 10/26/23 07:30, AKASHI Takahiro wrote:
> > > > Unfold do_bootefi_image() into do_bootefi() for the sake of the succeeding
> > > > refactor work.
> > > >

I don't disagree with the patchset, but what the patch does is pretty
obvious.  It would help a lot to briefly describe how the unfolding
process helps the refactoring.

Thanks
/Ilias
> > > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > > ---
> > > >   cmd/bootefi.c | 101 ++++++++++++++++++--------------------------------
> > > >   1 file changed, 37 insertions(+), 64 deletions(-)
> > > >
> > > > diff --git a/cmd/bootefi.c b/cmd/bootefi.c
> > > > index 20e5c94a33a4..1b28bf5a318d 100644
> > > > --- a/cmd/bootefi.c
> > > > +++ b/cmd/bootefi.c
> > > > @@ -425,58 +425,6 @@ static int do_efibootmgr(void)
> > > >           return CMD_RET_SUCCESS;
> > > >   }
> > > >
> > > > -/**
> > > > - * do_bootefi_image() - execute EFI binary
> > > > - *
> > > > - * Set up memory image for the binary to be loaded, prepare device path, and
> > > > - * then call do_bootefi_exec() to execute it.
> > > > - *
> > > > - * @image_opt:   string with image start address
> > > > - * @size_opt:    string with image size or NULL
> > > > - * Return:       status code
> > > > - */
> > > > -static int do_bootefi_image(const char *image_opt, const char *size_opt)
> > > > -{
> > > > - void *image_buf;
> > > > - unsigned long addr, size;
> > > > - efi_status_t ret;
> > > > -
> > > > -#ifdef CONFIG_CMD_BOOTEFI_HELLO
> > > > - if (!strcmp(image_opt, "hello")) {
> > > > -         image_buf = __efi_helloworld_begin;
> > > > -         size = __efi_helloworld_end - __efi_helloworld_begin;
> > > > -         efi_clear_bootdev();
> > > > - } else
> > > > -#endif
> > > > - {
> > > > -         addr = strtoul(image_opt, NULL, 16);
> > > > -         /* Check that a numeric value was passed */
> > > > -         if (!addr)
> > > > -                 return CMD_RET_USAGE;
> > > > -         image_buf = map_sysmem(addr, 0);
> > > > -
> > > > -         if (size_opt) {
> > > > -                 size = strtoul(size_opt, NULL, 16);
> > > > -                 if (!size)
> > > > -                         return CMD_RET_USAGE;
> > > > -                 efi_clear_bootdev();
> > > > -         } else {
> > > > -                 if (image_buf != image_addr) {
> > > > -                         log_err("No UEFI binary known at %s\n",
> > > > -                                 image_opt);
> > > > -                         return CMD_RET_FAILURE;
> > > > -                 }
> > > > -                 size = image_size;
> > > > -         }
> > > > - }
> > > > - ret = efi_run_image(image_buf, size);
> > > > -
> > > > - if (ret != EFI_SUCCESS)
> > > > -         return CMD_RET_FAILURE;
> > > > -
> > > > - return CMD_RET_SUCCESS;
> > > > -}
> > > > -
> > > >   /**
> > > >    * efi_run_image() - run loaded UEFI image
> > > >    *
> > > > @@ -648,8 +596,9 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
> > > >                         char *const argv[])
> > > >   {
> > > >           efi_status_t ret;
> > > > - char *img_addr, *img_size, *str_copy, *pos;
> > > > - void *fdt;
> > > > + char *p;
> > > > + void *fdt, *image_buf;
> > > > + unsigned long addr, size;
> > > >
> > > >           if (argc < 2)
> > > >                   return CMD_RET_USAGE;
> > > > @@ -684,18 +633,42 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
> > > >           if (!strcmp(argv[1], "selftest"))
> > > >                   return do_efi_selftest();
> > > >   #endif
> > > > - str_copy = strdup(argv[1]);
> > > > - if (!str_copy) {
> > > > -         log_err("Out of memory\n");
> > > > -         return CMD_RET_FAILURE;
> > > > +
> > > > +#ifdef CONFIG_CMD_BOOTEFI_HELLO
> > >
> > > I would prefer a normal if and let the linker sort it out.
> >
> > Here I focused on simply unfolding("moving") the function, keeping the code
> > as same as possible. Any how the code is in a tentative form
> > at this point and will be reshaped in later patches, using IS_ENABLED().
> > Please look at the final code after applying the whole series.
>
> I also agree with this approach.
>
> --
> Tom
