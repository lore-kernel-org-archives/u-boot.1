Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE00C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 07:09:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FF218750C;
	Mon, 27 Nov 2023 08:09:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HNUYqorM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CB5987515; Mon, 27 Nov 2023 08:09:47 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BBFA87508
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 08:09:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-50aab3bf71fso5233774e87.3
 for <u-boot@lists.denx.de>; Sun, 26 Nov 2023 23:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701068984; x=1701673784; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F7rsfU4e5XushfxVX3v3KMicN7u2fya/dbkcoOKwRPQ=;
 b=HNUYqorMMVpKWE5QbJD9Qm2cN31w82MgylpFypbI/FUBhCu9kOb3hpuiQvxLUsGb4Y
 LtJCXxy3T5h38HAN0wK/uhARVFEj510irPQrWVZOJCH8DtPM6Zv8TQFBvzS+eOfu9CQU
 YmErjQe6Ua733BrQN992Vp0nOYTpORTvFhAMvuXsDdkfICrmzFKVCYuNl4YsbMRUXzpC
 ZVxuCmbBAc7JvM6SDnuvaAFjqofSm/NLNifa3/+q0lycm+vyLeJHdYk2ICQlHL/R7mDQ
 vLxU4Jh6Sz0YPxctsYKaiMkyGVED7igaHrfW/xpBOwtThhimOQ6cimMwMRvMDpWoqr5V
 edMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701068984; x=1701673784;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F7rsfU4e5XushfxVX3v3KMicN7u2fya/dbkcoOKwRPQ=;
 b=FzIDGsabCDkdRV1AXZfZHlPCUzMIgAjyD5RdvWFiPw4kuIKagIb4CJiIEEEBf+zCHT
 vAfTjknL/YdWbKgMjwIoJcUoog1wLzwzVkFA7E2E7UCi6eMvIMwUWgOAc/6+MtwQh+mq
 H8QKqZN6OqtpSKGL0oPPOEzXLOlu+eqyO+HFA7HbKWASfZn9PTlW43yDeetHUYIjOaQi
 5whRbIA3f0BHfz4sZI506sQBWm4fZ1dkof8LVPTh/1k7MYstERc9UbDCRybho20wO00N
 cHHlGvekjHpihIrBicMdy8FbuaPmW4VpbslpGnVu1vsYmGnLGVsMc9oCiSG6WWf74Cnv
 xxIw==
X-Gm-Message-State: AOJu0YxkGzjBBX4KbSAYvoNrAs1QH4rkTbQ03aHc7EEqHOIDGX+CUc4k
 S4+XHEOIwc2et5AONBEux21VBeIhCDw6+CXK2BGndQ==
X-Google-Smtp-Source: AGHT+IEtbFjqeOX6P03G51jnGQ3WRnBIHPWG8zZMt8kG9bJBoR3Pq8klcoXFxmX7AgVH5WIyzd7ui0h1Woe0A3HuFzI=
X-Received: by 2002:a05:6512:376a:b0:509:860e:debf with SMTP id
 z10-20020a056512376a00b00509860edebfmr5725724lft.27.1701068984566; Sun, 26
 Nov 2023 23:09:44 -0800 (PST)
MIME-Version: 1.0
References: <20231121235713.1530289-1-i@shantur.com>
 <20231121235713.1530289-3-i@shantur.com>
 <CAC_iWjKxyRWd+bf==mO0tLQEG843J631xNQRo0_ueGXpdNCokg@mail.gmail.com>
 <CAHc5_t3bfArFaiWGg_1EdnkhUeaLXc75SRo7TB8LfjGr1AzFJw@mail.gmail.com>
In-Reply-To: <CAHc5_t3bfArFaiWGg_1EdnkhUeaLXc75SRo7TB8LfjGr1AzFJw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 27 Nov 2023 09:09:08 +0200
Message-ID: <CAC_iWjJkQocU5T_wnM0kve1g1Fvu2vj4KQqyz+NBBKbsjcejBw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] efi_vars: Implement SPI Flash store
To: Shantur Rathore <i@shantur.com>
Cc: takahiro.akashi@linaro.org, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Shantur

Please don't send a v2 unless the v1 discussion has settled. It just
makes life harder. I'll ignore v2 for now and respond here.

[...]

>
> >
> > > +       if (ret)
> > > +               goto error;
> > > +
> > > +       ret = spi_flash_erase_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET, EFI_VAR_BUF_SIZE);
> > > +       debug("%s - Erased SPI Flash offset %lx\n", __func__, CONFIG_EFI_VARIABLE_SF_OFFSET);
> > > +       if (ret)
> > > +               goto error;
> > > +
> > > +       ret = spi_flash_write_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET, len, buf);
> > > +       debug("%s - Wrote buffer to SPI Flash : %ld\n", __func__, ret);
> > > +
> > > +       if (ret)
> > > +               goto error;
> > > +
> > > +       ret = EFI_SUCCESS;
> > > +error:
> > > +       if (ret)
> > > +               log_err("Failed to persist EFI variables in SF\n");
> > > +       free(buf);
> > > +       return ret;
> > > +}
> > > +
> > > +efi_status_t efi_var_from_sf(void)
> > > +{
> > > +       struct efi_var_file *buf;
> > > +       efi_status_t ret;
> > > +       struct udevice *sfdev;
> > > +
> > > +       buf = calloc(1, EFI_VAR_BUF_SIZE);
> > > +       if (!buf) {
> > > +               log_err("Out of memory\n");
> > > +               return EFI_OUT_OF_RESOURCES;
> > > +       }
> >
> > You don't want normal memory for the variables.  Instead, you want EFI
> > memory which is marked for EFI runtime services data. U-Boot already
> > has code to support Get/GetNextvariableRT, you just need to use
> > efi_var_mem_init().
> > If you need hints have a look at lib/efi_loader/efi_variable_tee.c
> > which implements variables stored in an RPMB, but still uses the
> > memory backend for runtime services.
> >
>
> I believe EFI Runtime stuff is handled by efi_variable.c functions.

Yes, they are, but there is a subtle difference here.
efi_variable.c and efi_variable_tee.c have their own version of
runtime service implementation. The functions that can be shared
across the two are in efi_var_common.c.
What your patch does is shoehorn an SPI backend storage to the
existing implementation for storing variables to a file. Depending on
what we decide for runtime calls that can end up being messy.

efi_variable.c -> deals with variables on a file
efi_variable_tee.c -> deals with variables hidden behind the secure world

I think it would be cleaner to add efi_variable_sf.c and move the
common functions you need from efi_variable.c -> efi_var_common.c
Heinrich, do you have a preference for that?

Thanks
/Ilias
> This code is run while we are still in U-boot to initialise the memory backed.
> As of now, we don't have the SetVariableRT so I guess this won't be a problem.
> I took the code from efi_var_file.c and just replaced file storage
> with SPI Flash.
>
> I will have to look deeper once I get to implement SetVariableRT which will
> be a separate patch series once I get this in.
>
> I have submitted V2 of the patch, can you kindly review them.
>
> Kind regards,
> Shantur
