Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECEA9E81815
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 03:11:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C79286AF7;
	Tue, 26 Sep 2023 05:11:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="u9Rzg/sw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D41FD86BA8; Tue, 26 Sep 2023 05:11:27 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E5F886A88
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 05:11:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5780040cb81so6080507a12.1
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 20:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695697884; x=1696302684; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TugMCzYh24P+vJib3HaQJTrOQAheN8THsjV3CnUSjIA=;
 b=u9Rzg/swnuCaL6Z9eKR0+e54k+PMTgNzmSHkhxR0tECkzkdDM13NHw8eri0T9VyVmZ
 ntAIOQZv4Pm6ePnA/DSd5/kb2r9i/1koqtNHyx5hvkB1q9SlJLNvfg92rFjNDu++kx+t
 zX5cei2FeAmHsdkTZswuwUZsnxcIU384z5+84nzTHFUGwJtOzwkUzrZsl9JLgOUdlWiQ
 h3Pad5Ffjgf059FwaRXgWEG+asJLsMogpVCbCkb4XlAC1sQrT0cixO+qjo6O5SmBtk6q
 A/zQanltuUd8n2owRP/L0jY8agrTJ5bxaEkqzyqHnuZUmEBqh1oDh3xABGQXEKiN+5ht
 X9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695697884; x=1696302684;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TugMCzYh24P+vJib3HaQJTrOQAheN8THsjV3CnUSjIA=;
 b=te0ZkoUw8SfjhBTSEFGoc89Arz5FGh004qTy+UxId85KwgKzuvmZojwir4XNeAcUrL
 65VghX7UZw7J6JYnA3O2uBopfUzqJE//YF/xNLFFi3eUP5K/ftzHTxu+JkdAaM/wc5G4
 K2Nx10vI+CZTZ4v6NbAUWKsVvogQRmoRdqNoYq1l6o2aezx9MP/87chtcgsD9fQU1UYP
 GKr87uk3wj+z6h67lc42t4rPCzMafNniobONStEBBgUmNs/LMeDnOHMJlQUbcjE6F841
 Uc205Ig2f738s8bh7PLVbXSYRYGFuQi09aMF1/RCUmu8j4uvUhFCmPwgDlpDXtcfk6X2
 3qoA==
X-Gm-Message-State: AOJu0YxEUpudqUTk6oZeOWaS7Ew5+erK5PUoywDlBvksZra4idD/bzR4
 bv7ux2IJ6lDIKZn1foU45EVNpumLk1EXH9V+o2Elsw==
X-Google-Smtp-Source: AGHT+IEr/sPz693ftE73NDOwczcGFDpCE5uis258omicH/tx4yPM7GpDdKG1JdR4k056wwkg7BSlvRhR/oudaEhxSv8=
X-Received: by 2002:a05:6a20:7488:b0:15e:7323:5c0f with SMTP id
 p8-20020a056a20748800b0015e73235c0fmr8399217pzd.16.1695697883982; Mon, 25 Sep
 2023 20:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230922071119.1439482-1-masahisa.kojima@linaro.org>
 <20230922071119.1439482-6-masahisa.kojima@linaro.org> <ZRGBE9HUjLB8f7lS@hera>
In-Reply-To: <ZRGBE9HUjLB8f7lS@hera>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Tue, 26 Sep 2023 12:11:12 +0900
Message-ID: <CADQ0-X9T92mgWjqdzr25ZuQEKb68gK+-KLmPYabhwE5D13dkag@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] efi_loader: set EFI HTTP Boot download buffer as
 reserved
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Takahiro Akashi <takahiro.akashi@linaro.org>
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

Hi Ilias,

On Mon, 25 Sept 2023 at 21:46, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Kojima-san,
>
> [...]
> >  /* Carve out DT reserved memory ranges */
> >  void efi_carve_out_dt_rsv(void *fdt);
> >  /* Purge unused kaslr-seed */
> > diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> > index 605be5041e..4991056946 100644
> > --- a/lib/efi_loader/efi_bootmgr.c
> > +++ b/lib/efi_loader/efi_bootmgr.c
> > @@ -326,6 +326,11 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
> >                       return EFI_INVALID_PARAMETER;
> >
> >               ret = load_default_file_from_blk_dev(blk, handle);
> > +             if (ret != EFI_SUCCESS)
> > +                     return ret;
> > +
> > +             /* whole ramdisk must be reserved */
> > +             efi_reserve_memory(image_addr, image_size, true);
>
> Why is this a different patch though?

No special reason, I will merge this into #4 "efi_loader: support boot
from URI device path" patch.

> My concern is code duplication when we add similar functionality in
> eficonfig.  Isn't there a better place to handle the memory reservation?

I think eficonfig will only provide add/edit/delete URI boot option,
efibootmgr is
responsible for handling the URI device path and reserving the memory.
So there will not be code duplication.

Thanks,
Masahisa Kojima

>
> [...]
>
> Thanks
> /Ilias
>
