Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B44C54FB9
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 05:00:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB2698720A;
	Tue, 21 Nov 2023 06:00:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QJI+6FcC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86867870F8; Tue, 21 Nov 2023 06:00:25 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C017A8744B
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 06:00:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1cc28719cb0so9120715ad.0
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 21:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700542821; x=1701147621; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k+cpgU+aBGNJ3v4PH4Wp/jZVvawmxWsyemz3wTzFW8g=;
 b=QJI+6FcC/315CiKL42xm0WDzcFaKhIIGTsQ9VNr1G2bjtKQZ48miUTdx85ug6j93S7
 mM53kUzxkfRo3E41DbptX0GcjlDZoPgxpWWyJ47FWktSM8z0LIw6Te5RpbMvmyADvoKh
 RHRAes3rJ1mGlUfj9qcvL2YfMDWNoM6NRX28Wj1wB4stivthtoEtKY1SuM6A3W1hcAaC
 +LhyrL9i7vqgIMlG9iNmSlwn7HT1yhYEQMJf10JtpofC88G7PtRHhTeHUDfVOu+sR2Lr
 t9dRCJNwgnZasNncYVIYkHNUEE2cxhD6ArFx6epj3Q9Cz3qSkNeD7SSG004ltK27IIQs
 WXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700542821; x=1701147621;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k+cpgU+aBGNJ3v4PH4Wp/jZVvawmxWsyemz3wTzFW8g=;
 b=LJvE5buX+P4HErLrg3/ElMOVrHfNml42w5s8tsXX7E/Mf5NFg148EQSHlSNu/iDE4R
 AqHi8KBuaHZpY9wycRm6+o3Duq9+pjphzy8VCUBH/1/d/fUtf0nKqtl0lUxRVx7JieqM
 wpkASqn5ncoFG31yMpLNjE0pKmJ99wBVQF5npzpWPxtm08MrH+PUH41qwhqCTjsB9OUl
 Q8Dc7k4TP8Jgklt/bW2XWaHSM9tkZClxBP+nc5Y/ZtDyY/YCk5RPdikBhqYnXMJaIaQF
 zW1j28E11U4pzRdNpuVoo/WfxEN66wilcax4sPT52OfSVLRYsKqowtuxVZ3G3SWDZKK7
 DfhA==
X-Gm-Message-State: AOJu0YziJBaZ7LWNF0i/kc6YeunGukuek8Z6oq9Mhhn/WZSvufcD7Cuc
 3oBqbLmxD9MiRBjZBcFX3Vos9A==
X-Google-Smtp-Source: AGHT+IFvxmdHp5vHKVud0JmGo4fxAAn/4n8MhopevQqCQbcwlkduMFj1cCYWoK22Q4KUTjU08+sIig==
X-Received: by 2002:a17:903:22c1:b0:1cf:5806:5634 with SMTP id
 y1-20020a17090322c100b001cf58065634mr8630949plg.1.1700542820950; 
 Mon, 20 Nov 2023 21:00:20 -0800 (PST)
Received: from octopus ([2400:4050:c3e1:100:f6af:a59c:7ca:897f])
 by smtp.gmail.com with ESMTPSA id
 ij26-20020a170902ab5a00b001cc1f504082sm7120150plb.56.2023.11.20.21.00.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 21:00:20 -0800 (PST)
Date: Tue, 21 Nov 2023 14:00:16 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org,
 ilias.apalodimas@linaro.org
Subject: Re: [PATCH v2 03/12] cmd: bootefi: carve out EFI boot manager
 interface
Message-ID: <ZVw5YCx83nn3RgHW@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 trini@konsulko.com, sjg@chromium.org, ilias.apalodimas@linaro.org
References: <20231121012950.156539-1-takahiro.akashi@linaro.org>
 <20231121012950.156539-4-takahiro.akashi@linaro.org>
 <fffc514b-a986-482c-a468-6d52598a046e@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fffc514b-a986-482c-a468-6d52598a046e@gmx.de>
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

On Tue, Nov 21, 2023 at 04:38:12AM +0100, Heinrich Schuchardt wrote:
> On 11/21/23 02:29, AKASHI Takahiro wrote:
> > Carve EFI boot manager related code out of do_bootefi_image() in order
> > to move boot manager specific code into library directory in the later
> > commit.
> > 
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >   cmd/bootefi.c | 43 ++++++++++++++++++++++++-------------------
> >   1 file changed, 24 insertions(+), 19 deletions(-)
> > 
> > diff --git a/cmd/bootefi.c b/cmd/bootefi.c
> > index e9e5ab67a1f5..87910c42333a 100644
> > --- a/cmd/bootefi.c
> > +++ b/cmd/bootefi.c
> > @@ -413,28 +413,40 @@ out:
> >   }
> > 
> >   /**
> > - * do_efibootmgr() - execute EFI boot manager
> > + * efi_bootmgr_run() - execute EFI boot manager
> > + * fdt:	Flat device tree
> > + *
> > + * Invoke EFI boot manager and execute a binary depending on
> > + * boot options. If @fdt is not NULL, it will be passed to
> > + * the executed binary.
> 
> How about the fallback to the control device-tree?

efi_install_fdt() will take care of that if fdt == EFI_FDT_INTERNAL_USE.
I didn't change any semantics.
I will add some description here to clarify it.

> How about booting with ACPI?

Not sure what is your concern, but
I didn't change any semantics in bootmgr use-case.

-Takahiro Akashi

> 
> Best regards
> 
> Heinrich
> 
> >    *
> >    * Return:	status code
> >    */
> > -static int do_efibootmgr(void)
> > +static efi_status_t efi_bootmgr_run(void *fdt)
> >   {
> >   	efi_handle_t handle;
> > -	efi_status_t ret;
> >   	void *load_options;
> > +	efi_status_t ret;
> > 
> > -	ret = efi_bootmgr_load(&handle, &load_options);
> > +	/* Initialize EFI drivers */
> > +	ret = efi_init_obj_list();
> >   	if (ret != EFI_SUCCESS) {
> > -		log_notice("EFI boot manager: Cannot load any image\n");
> > +		log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
> > +			ret & ~EFI_ERROR_MASK);
> >   		return CMD_RET_FAILURE;
> >   	}
> > 
> > -	ret = do_bootefi_exec(handle, load_options);
> > -
> > +	ret = efi_install_fdt(fdt);
> >   	if (ret != EFI_SUCCESS)
> > -		return CMD_RET_FAILURE;
> > +		return ret;
> > 
> > -	return CMD_RET_SUCCESS;
> > +	ret = efi_bootmgr_load(&handle, &load_options);
> > +	if (ret != EFI_SUCCESS) {
> > +		log_notice("EFI boot manager: Cannot load any image\n");
> > +		return ret;
> > +	}
> > +
> > +	return do_bootefi_exec(handle, load_options);
> >   }
> > 
> >   /**
> > @@ -624,21 +636,14 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
> > 
> >   	if (IS_ENABLED(CONFIG_CMD_BOOTEFI_BOOTMGR) &&
> >   	    !strcmp(argv[1], "bootmgr")) {
> > -		/* Initialize EFI drivers */
> > -		ret = efi_init_obj_list();
> > -		if (ret != EFI_SUCCESS) {
> > -			log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
> > -				ret & ~EFI_ERROR_MASK);
> > -			return CMD_RET_FAILURE;
> > -		}
> > +		ret = efi_bootmgr_run(fdt);
> > 
> > -		ret = efi_install_fdt(fdt);
> >   		if (ret == EFI_INVALID_PARAMETER)
> >   			return CMD_RET_USAGE;
> > -		else if (ret != EFI_SUCCESS)
> > +		else if (ret)
> >   			return CMD_RET_FAILURE;
> > 
> > -		return do_efibootmgr();
> > +		return CMD_RET_SUCCESS;
> >   	}
> > 
> >   	if (IS_ENABLED(CONFIG_CMD_BOOTEFI_SELFTEST) &&
> 
