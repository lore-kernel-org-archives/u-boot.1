Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56423C54E58
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 16:48:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 545EC880E1;
	Thu, 21 Mar 2024 17:48:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uQoBiio1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 609BD880AA; Thu, 21 Mar 2024 17:48:46 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9806880E1
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 17:48:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-414612cfd82so8409015e9.2
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 09:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711039723; x=1711644523;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Qy2bFKuT1tQOxDQGLm4+KbzX4gLTsH9ywtsuk/mXdFM=;
 b=uQoBiio1rhoHpZHllAUzKRZluqng17NRweIEZVT7LvhCX54TeAKwIptm6I3NdzBS6y
 KfNpo4hkgMT9jIA2JU8m3blIJTcVGdNYIrHcuuexLs/fCoogk97RaVWRk13eMMt/JzNS
 SogJOmf63xS9XWM8QD0LiJK8qjI9ut4orJF9TFsh3KWatkSW7OILbl8a54Q/72gIkHUb
 MCcNryyjIIkKI4TCb6YjlYDF6Up+RDruSrIpfBbSS1trpt3jINT3L2Ob+QgTHMwmUycj
 +Kwrcc6BsmxOHZK6RBwWUZ+mNYpmv8MlIdg7Uw36Yh05N2XpqLtzCEE5uWw/IA6tQJJ9
 /+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711039723; x=1711644523;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qy2bFKuT1tQOxDQGLm4+KbzX4gLTsH9ywtsuk/mXdFM=;
 b=kpOuxPnm0qYrYxpiCoIQeIUFCVFriIGRxQmQF8Peo9oXfLTSswfBi5KlBBcOqBtxEO
 W6uX09/vTHn4HNCvf2QdarSMN3FLjJjjQaBZldgncDDCovBfQY3ZyBa95xBXr9TkipK8
 rKpu2egpD+UAJ8Ks6RRwL8zHxqp2uIJbAf535vrOXw8z2z9AyJC8BLCgaRhGGbynCUd/
 j22P2CrAe1ozII+yzJmG2KkT50TzDOlNC9sjKpOVbWoEx8u6HODTyfw/j2l9hpVGjwDS
 0pIBAgcku7UVhf9R8+hKuWwe6WFuw/DYmK8/UY0FKiBaAPPY8Pe7RCjOz6w7bzY4yH7U
 CnSw==
X-Gm-Message-State: AOJu0YzLz7ut8TXmza/ofPGDKwWFR9iLUmYiTfvEYX3NsO0praN753dv
 vRCJY8RChElEa56heC8VrZ1Ht3kfpipx3UBoD2sd97tg+SSiJysAxOgad7uSXdY=
X-Google-Smtp-Source: AGHT+IGnuBRAwykgJ2rTmA7+JAYF/q5D14MikjiZLeZErBNJiodtF17+z0BD/IkPvfip2YkqoUG6VA==
X-Received: by 2002:a05:600c:283:b0:412:dcab:7c79 with SMTP id
 3-20020a05600c028300b00412dcab7c79mr6392726wmk.10.1711039723080; 
 Thu, 21 Mar 2024 09:48:43 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 fm5-20020a05600c0c0500b004146c769c79sm5811686wmb.0.2024.03.21.09.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 09:48:42 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Caleb Connolly <caleb.connolly@linaro.org>, Caleb Connolly
 <caleb.connolly@linaro.org>, Lukasz Majewski <lukma@denx.de>, Marek Vasut
 <marex@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] usb: gadget: UMS: fix 64-bit division on ARM32
In-Reply-To: <20240321153004.709994-2-caleb.connolly@linaro.org>
References: <20240321153004.709994-2-caleb.connolly@linaro.org>
Date: Thu, 21 Mar 2024 17:48:41 +0100
Message-ID: <87frwjedjq.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Caleb,

Thank you for the patch.

On jeu., mars 21, 2024 at 15:28, Caleb Connolly <caleb.connolly@linaro.org> wrote:

> The patch introducing support for dynamic sector sizes changed the types
> used in some divisions, resulting in the compiler attempting to use
> libgcc helpers (__aeabi_ldivmod). Replace these divisions with calls to
> lldiv() to handle this correctly.
>
> Fixes: 74e56e0c5065 ("usb: gadget: UMS: support multiple sector sizes")
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Would it be okay if I squashed this into
commit 74e56e0c5065 ("usb: gadget: UMS: support multiple sector sizes")
?

I'd like to not (intentionally) send any patches that don't compile to Tom.


> ---
> Hi Mattijs,
>
> Sorry for not catching that sooner! I compile tested this locally and a

No worries, thanks a lot for the quick fix.

> CI pipeline is running here: https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/pipelines/20029

I can see from the above pipeline that some other failures are ongoing,
but they are not related to lldiv().

arm-linux-gnueabi-ld.bfd: common/dfu.o: in function `run_usb_dnl_gadget':
common/dfu.c:82:(.text.run_usb_dnl_gadget+0xd8): undefined reference to `dm_usb_gadget_handle_interrupts'
arm-linux-gnueabi-ld.bfd: common/dfu.c:108:(.text.run_usb_dnl_gadget+0x11c): undefined reference to `dm_usb_gadget_handle_interrupts'
make[1]: *** [Makefile:1793: u-boot] Error

See: https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/jobs/802759#L470

I suspect that this is related to:
https://lore.kernel.org/r/all/20240225152715.1821613-1-jonas@kwiboo.se/


>
> Regards,
> Caleb
> ---
>  drivers/usb/gadget/f_mass_storage.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mass_storage.c
> index d880928044f4..ef90c7ec7fb5 100644
> --- a/drivers/usb/gadget/f_mass_storage.c
> +++ b/drivers/usb/gadget/f_mass_storage.c
> @@ -239,8 +239,9 @@
>  /* #define VERBOSE_DEBUG */
>  /* #define DUMP_MSGS */
>  
>  #include <config.h>
> +#include <div64.h>
>  #include <hexdump.h>
>  #include <log.h>
>  #include <malloc.h>
>  #include <common.h>
> @@ -768,10 +769,10 @@ static int do_read(struct fsg_common *common)
>  		}
>  
>  		/* Perform the read */
>  		rc = ums[common->lun].read_sector(&ums[common->lun],
> -				      file_offset / curlun->blksize,
> -				      amount / curlun->blksize,
> +				      lldiv(file_offset, curlun->blksize),
> +				      lldiv(amount, curlun->blksize),
>  				      (char __user *)bh->buf);
>  		if (!rc)
>  			return -EIO;
>  
> @@ -942,10 +943,10 @@ static int do_write(struct fsg_common *common)
>  			amount = bh->outreq->actual;
>  
>  			/* Perform the write */
>  			rc = ums[common->lun].write_sector(&ums[common->lun],
> -					       file_offset / curlun->blksize,
> -					       amount / curlun->blksize,
> +					       lldiv(file_offset, curlun->blksize),
> +					       lldiv(amount, curlun->blksize),
>  					       (char __user *)bh->buf);
>  			if (!rc)
>  				return -EIO;
>  			nwritten = rc * curlun->blksize;
> @@ -1058,10 +1059,10 @@ static int do_verify(struct fsg_common *common)
>  		}
>  
>  		/* Perform the read */
>  		rc = ums[common->lun].read_sector(&ums[common->lun],
> -				      file_offset / curlun->blksize,
> -				      amount / curlun->blksize,
> +				      lldiv(file_offset, curlun->blksize),
> +				      lldiv(amount, curlun->blksize),
>  				      (char __user *)bh->buf);
>  		if (!rc)
>  			return -EIO;
>  		nread = rc * curlun->blksize;
> -- 
> 2.44.0
