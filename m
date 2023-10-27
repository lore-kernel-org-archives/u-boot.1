Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE5DFC25B48
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 00:25:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7140B8764D;
	Fri, 27 Oct 2023 02:25:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="T7nTSHSt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D666286E1C; Fri, 27 Oct 2023 02:25:53 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D1BE87BB6
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 02:25:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6bcbfecf314so354520b3a.1
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 17:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698366348; x=1698971148; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ed9cO+yLRYNQJjXrpz7uL5WtJLb5sd/elB7w5cKj3pY=;
 b=T7nTSHStQOgyGXnFYvo+7HbbfAqYGIuiU6DOnyzACYb/eX1dFozucpTi3W9E/g61Am
 fXyU6vQBkfD5kXuH78Y1oX65GVhe4K98jVAeLnae2djMtXl5i1cyEV2gs/CfNvFFGQpL
 yw8xxyl/b+sgE6mEC+UKRa+vHqgQDwSVlFHrO2VBnNtIquszeRNMhZC3ja+5lM392HQw
 zQWTe5MhPKehIzHhDU3XSss2BmAn2AxzjnWGQnBVcdwms/CS65aVqisqqDnF2ZYNrEHh
 KVdI4/xMhEVnsdWCyKBaBtJrkxS3EiiFOMQS4Z+EqoolmeEgDYj+hg42cKFvPyr5TbUK
 mQzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698366348; x=1698971148;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ed9cO+yLRYNQJjXrpz7uL5WtJLb5sd/elB7w5cKj3pY=;
 b=nKksRinzwjXrya7oHD7Rd3WRAcyPgmRI4JSagr7okhFF9h04ciY3bWdFjH1SlqqNCc
 Gc6jGlGu85y5gT1JOYNgBxxC86/shF5IaTcynKLgaYHml+EnqEO5k/4VphD8t5dyMHpw
 XJPHD7vTDfeMWUm+nb8s0mj9jxQU8WTKMamvebZTnOfqKDf59WQdHDA+4a+lTs853g78
 a0GMeoJY0QB8YYri2F8n3MWsBFt6W9Ky2YQHaKwE/4GrUZDL49Bc8bNQGcYiCwuyJ8Rk
 xY3HPjj1ew6h+lut/q969zA8WTr0acb4VhoU2A1DJCA8C5/39p2yp35XihoAx2VNqJ7K
 XjmA==
X-Gm-Message-State: AOJu0Yxr/4siRn4dWpS7d6JGqxThauYgklmCeBy4u45aLFLgAqcxMSnl
 3QnQtnEnuB6FHkc8dIe2cL2I8Q==
X-Google-Smtp-Source: AGHT+IH6py2wS3qULjsLCx/bcYrFHO0QA4Z30E9WnlXpaGTilUEofZdJMTtDhhnLcdl4QHzM12i2zQ==
X-Received: by 2002:a05:6a00:4a14:b0:68e:2fd4:288a with SMTP id
 do20-20020a056a004a1400b0068e2fd4288amr1155490pfb.3.1698366348235; 
 Thu, 26 Oct 2023 17:25:48 -0700 (PDT)
Received: from octopus ([2400:4050:c3e1:100:6429:7b83:d86b:e393])
 by smtp.gmail.com with ESMTPSA id
 n20-20020a056a000d5400b006bddd1ee5f0sm188664pfv.5.2023.10.26.17.25.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 17:25:47 -0700 (PDT)
Date: Fri, 27 Oct 2023 09:25:44 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: jbx6244@gmail.com, u-boot@lists.denx.de, trini@konsulko.com,
 sjg@chromium.org, ilias.apalodimas@linaro.org
Subject: Re: [RFC 01/13] cmd: bootefi: unfold do_bootefi_image()
Message-ID: <ZTsDiJUA9esxg9nb@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, jbx6244@gmail.com,
 u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org,
 ilias.apalodimas@linaro.org
References: <20231026053052.622453-1-takahiro.akashi@linaro.org>
 <20231026053052.622453-2-takahiro.akashi@linaro.org>
 <b6110e38-5a44-4fcf-8ae1-ad77f1b66390@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6110e38-5a44-4fcf-8ae1-ad77f1b66390@gmx.de>
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

On Thu, Oct 26, 2023 at 01:01:52PM +0200, Heinrich Schuchardt wrote:
> On 10/26/23 07:30, AKASHI Takahiro wrote:
> > Unfold do_bootefi_image() into do_bootefi() for the sake of the succeeding
> > refactor work.
> > 
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >   cmd/bootefi.c | 101 ++++++++++++++++++--------------------------------
> >   1 file changed, 37 insertions(+), 64 deletions(-)
> > 
> > diff --git a/cmd/bootefi.c b/cmd/bootefi.c
> > index 20e5c94a33a4..1b28bf5a318d 100644
> > --- a/cmd/bootefi.c
> > +++ b/cmd/bootefi.c
> > @@ -425,58 +425,6 @@ static int do_efibootmgr(void)
> >   	return CMD_RET_SUCCESS;
> >   }
> > 
> > -/**
> > - * do_bootefi_image() - execute EFI binary
> > - *
> > - * Set up memory image for the binary to be loaded, prepare device path, and
> > - * then call do_bootefi_exec() to execute it.
> > - *
> > - * @image_opt:	string with image start address
> > - * @size_opt:	string with image size or NULL
> > - * Return:	status code
> > - */
> > -static int do_bootefi_image(const char *image_opt, const char *size_opt)
> > -{
> > -	void *image_buf;
> > -	unsigned long addr, size;
> > -	efi_status_t ret;
> > -
> > -#ifdef CONFIG_CMD_BOOTEFI_HELLO
> > -	if (!strcmp(image_opt, "hello")) {
> > -		image_buf = __efi_helloworld_begin;
> > -		size = __efi_helloworld_end - __efi_helloworld_begin;
> > -		efi_clear_bootdev();
> > -	} else
> > -#endif
> > -	{
> > -		addr = strtoul(image_opt, NULL, 16);
> > -		/* Check that a numeric value was passed */
> > -		if (!addr)
> > -			return CMD_RET_USAGE;
> > -		image_buf = map_sysmem(addr, 0);
> > -
> > -		if (size_opt) {
> > -			size = strtoul(size_opt, NULL, 16);
> > -			if (!size)
> > -				return CMD_RET_USAGE;
> > -			efi_clear_bootdev();
> > -		} else {
> > -			if (image_buf != image_addr) {
> > -				log_err("No UEFI binary known at %s\n",
> > -					image_opt);
> > -				return CMD_RET_FAILURE;
> > -			}
> > -			size = image_size;
> > -		}
> > -	}
> > -	ret = efi_run_image(image_buf, size);
> > -
> > -	if (ret != EFI_SUCCESS)
> > -		return CMD_RET_FAILURE;
> > -
> > -	return CMD_RET_SUCCESS;
> > -}
> > -
> >   /**
> >    * efi_run_image() - run loaded UEFI image
> >    *
> > @@ -648,8 +596,9 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
> >   		      char *const argv[])
> >   {
> >   	efi_status_t ret;
> > -	char *img_addr, *img_size, *str_copy, *pos;
> > -	void *fdt;
> > +	char *p;
> > +	void *fdt, *image_buf;
> > +	unsigned long addr, size;
> > 
> >   	if (argc < 2)
> >   		return CMD_RET_USAGE;
> > @@ -684,18 +633,42 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
> >   	if (!strcmp(argv[1], "selftest"))
> >   		return do_efi_selftest();
> >   #endif
> > -	str_copy = strdup(argv[1]);
> > -	if (!str_copy) {
> > -		log_err("Out of memory\n");
> > -		return CMD_RET_FAILURE;
> > +
> > +#ifdef CONFIG_CMD_BOOTEFI_HELLO
> 
> I would prefer a normal if and let the linker sort it out.

Here I focused on simply unfolding("moving") the function, keeping the code
as same as possible. Any how the code is in a tentative form 
at this point and will be reshaped in later patches, using IS_ENABLED().
Please look at the final code after applying the whole series.

-Takahiro Akashi


> Otherwise looks good to me.
> 
> Best regards
> 
> Heinrich
> 
> > +	if (!strcmp(argv[1], "hello")) {
> > +		image_buf = __efi_helloworld_begin;
> > +		size = __efi_helloworld_end - __efi_helloworld_begin;
> > +		efi_clear_bootdev();
> > +	} else
> > +#endif
> > +	{
> > +		addr = strtoul(argv[1], NULL, 16);
> > +		/* Check that a numeric value was passed */
> > +		if (!addr)
> > +			return CMD_RET_USAGE;
> > +		image_buf = map_sysmem(addr, 0);
> > +
> > +		p  = strchr(argv[1], ':');
> > +		if (p) {
> > +			size = strtoul(++p, NULL, 16);
> > +			if (!size)
> > +				return CMD_RET_USAGE;
> > +			efi_clear_bootdev();
> > +		} else {
> > +			if (image_buf != image_addr) {
> > +				log_err("No UEFI binary known at %s\n",
> > +					argv[1]);
> > +				return CMD_RET_FAILURE;
> > +			}
> > +			size = image_size;
> > +		}
> >   	}
> > -	pos = str_copy;
> > -	img_addr = strsep(&pos, ":");
> > -	img_size = strsep(&pos, ":");
> > -	ret = do_bootefi_image(img_addr, img_size);
> > -	free(str_copy);
> > +	ret = efi_run_image(image_buf, size);
> > 
> > -	return ret;
> > +	if (ret != EFI_SUCCESS)
> > +		return CMD_RET_FAILURE;
> > +
> > +	return CMD_RET_SUCCESS;
> >   }
> > 
> >   U_BOOT_LONGHELP(bootefi,
> 
