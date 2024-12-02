Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F368D78336
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 16:24:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7D9A88E3F;
	Mon,  2 Dec 2024 17:24:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fCXQGvWC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 562EB88E63; Mon,  2 Dec 2024 17:24:00 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B3A888DE6
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 17:23:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hiagofranco@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-211fb27cc6bso35313725ad.0
 for <u-boot@lists.denx.de>; Mon, 02 Dec 2024 08:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733156636; x=1733761436; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/WshIuQOPdNWZ4TAstBuIE+bSeZD+gVkrPtgGToDeSY=;
 b=fCXQGvWC8AyRVAmzhLilRVbm/tECc0rnP0KawkC9CbYELRw7KcIVoMnMnjazMO4nRo
 aV7Ivyzc92Ra6MCKkYr+rs6kJ327NTbZIaqSPMyj086uXthpYjP9Mxn5ed6K2HVTTe79
 rPcWEzu4YhcEwPYpXkAwzgQgDY1c0hOJqi04bMbmZEytu53aNIkQ5DJ2ry4FpUIPsgd4
 T02PaGiELW/ejftWHNhFLQtC3tTlZn/bsiaWVoQENNrQF8qqkKhbaXBSq7K+LzQDHkYh
 aamMGMb1kCxB+8/dvafCh2H5hqJqCp9V6VDuHq12xj5YzE87r3HrmDeZLs7MuNFn/MOY
 WCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733156636; x=1733761436;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/WshIuQOPdNWZ4TAstBuIE+bSeZD+gVkrPtgGToDeSY=;
 b=TVmlfyoI83pcXa5tdgEO0oX7k/YtLSgE7Y2e99S1BqbMKzzFg00eT3yaHZsiccYwF+
 rjeR4fMHnw7szmdZxIW88RwHvlv13kErK3PvVP3UBNQDz6PMYJqNoAZ1HuhW+6qGI7lp
 ItVntHxcZdZTd/KiTxbSBsjc22DQuesYbUmb6soT9r23fcUv4LXarcY7cxlsQZt8M6C+
 Rq7lUV02omTZlsyJbPLWkiNn2Q/a9P/AUmimhvO8SqmO1zAp95bynM1W/8J39sQ5BMTf
 RyjDNFGvQR9zppTURog+R/4XBfzXEsb1hoAtmm6K0sF0eDgvwqhNMn0gE3Ct7YHl+QDS
 pBRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHc6onFdEKT5801dQlZSTEU+ZdIhMV78lvpGIXj6K/7++DtOs7TcrZVjPvu2wabbTGDkZC53k=@lists.denx.de
X-Gm-Message-State: AOJu0YyMuqjzu3/q9d9bbtlC/gWMg53uSyAPgNfnmvOnIJp1FQoZKoWn
 u0hvfANKjELUqXSW8yju4X0He5UT3q5Bb2FbgQ8oSpAJ8YqaniVg
X-Gm-Gg: ASbGncv73s0zU0i5DCGL2YCpuKCSU4b2r10sIaYAj5ZXxdAslaKQozWqy7rzH6LW4h6
 pi/QPL5A9tLYLNtTYAu6jDZ8GwH/r8M9OdLUcnUo0oWlDoy4ZH9w4Gk05DJwwPFR1OFLQXSTo+N
 gDRsl9zVfs+UK2VLSd1d7Kui3u5ckSOmknZfJiHHLKF/QVpTnfQbjBLrgVxFPKQVKWV+OdZvwNJ
 UqPsibY36bOcfzXf1OIm+dZAkovQKmzlpqqyG0LxJSl6PWX
X-Google-Smtp-Source: AGHT+IHHF57Tot60y0hhRb+WfLHNilx5uoAtpd0ytrFNYKyEN2KQ9tb6DUV2dlRjD0F087rLlFHhbA==
X-Received: by 2002:a17:902:d4c7:b0:215:86c2:3fe0 with SMTP id
 d9443c01a7336-21586c242f4mr77051525ad.38.1733156636404; 
 Mon, 02 Dec 2024 08:23:56 -0800 (PST)
Received: from hiago-nb ([67.159.246.222]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215219c2e31sm79342545ad.251.2024.12.02.08.23.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 08:23:55 -0800 (PST)
Date: Mon, 2 Dec 2024 13:23:52 -0300
From: Hiago De Franco <hiagofranco@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de,
 Hiago De Franco <hiago.franco@toradex.com>
Subject: Re: [PATCH] verdin-am62: fix FASTBOOT_BUF_ADDR and FASTBOOT_BUF_SIZE
Message-ID: <20241202162352.adgpgpxlegpypq72@hiago-nb>
References: <20241129151257.90607-1-hiagofranco@gmail.com>
 <20241129160925.GL3600562@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129160925.GL3600562@bill-the-cat>
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

On Fri, Nov 29, 2024 at 10:09:25AM -0600, Tom Rini wrote:
> On Fri, Nov 29, 2024 at 12:12:57PM -0300, Hiago De Franco wrote:
> 
> > From: Hiago De Franco <hiago.franco@toradex.com>
> > 
> > The current value of CONFIG_FASTBOOT_BUF_ADDR is incorrect for hardware
> > with 512MB and 1GB of RAM. The RAM address ranges for these devices are:
> > 
> > - 512MB:
> >   - Start: 0x80000000
> >   - End:   0xA0000000
> > - 1GB:
> >   - Start: 0x80000000
> >   - End:   0xC0000000
> > 
> > The current buffer address makes fastboot downloads work only on
> > hardware with 2GB of RAM.
> > 
> > To fix this issue:
> > 1. Lower CONFIG_FASTBOOT_BUF_ADDR to 0x80080000. This places the buffer
> >    near the beginning of RAM with a 512KB offset, as starting at exactly
> >    0x80000000 conflicts with the ATF load address. Following
> >    K3_ATF_LOAD_ADDR configuration, ATF is loaded at 0x80000000:
> > 
> >   config K3_ATF_LOAD_ADDR
> >     hex "Load address of ATF image"
> >     default 0x80000000 if (SOC_K3_AM625 || SOC_K3_AM62A7 || SOC_K3_AM62P5 || SOC_K3_J722S)
> >     default 0x70000000
> >     help
> >       The load address for the ATF image. This value is used to build the
> >       FIT image header that places ATF in memory where it will run.
> > 
> > 2. Reduce the size of the download buffer to 128MB, avoiding overlaps
> >    with RAMDISK_ADDR_R. This is a good enough value for individual
> >    downloads.
> > 
> > Theses changes make fastboot downloads work with 512MB and 1GB devices.
> > 
> > Fixes: defe30a78b76 ("verdin-am62: add DFU, USB and UUU fastboot support")
> > Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
> > ---
> >  configs/verdin-am62_a53_defconfig | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/configs/verdin-am62_a53_defconfig b/configs/verdin-am62_a53_defconfig
> > index 49fb9790e295..6fa1a9d2c552 100644
> > --- a/configs/verdin-am62_a53_defconfig
> > +++ b/configs/verdin-am62_a53_defconfig
> > @@ -122,8 +122,8 @@ CONFIG_SYS_DFU_MAX_FILE_SIZE=0x800000
> >  CONFIG_DMA_CHANNELS=y
> >  CONFIG_TI_K3_NAVSS_UDMA=y
> >  CONFIG_USB_FUNCTION_FASTBOOT=y
> > -CONFIG_FASTBOOT_BUF_ADDR=0xC0000000
> > -CONFIG_FASTBOOT_BUF_SIZE=0x2F000000
> > +CONFIG_FASTBOOT_BUF_ADDR=0x80080000
> > +CONFIG_FASTBOOT_BUF_SIZE=0x8000000
> >  CONFIG_FASTBOOT_UUU_SUPPORT=y
> >  CONFIG_TI_SCI_PROTOCOL=y
> >  CONFIG_GPIO_HOG=y
> 
> Why not 0x88200000 which is what CONFIG_SYS_LOAD_ADDR is?

We were downloading a file at this address, that is why we decided to
not use it. However it is better to use SYS_LOAD_ADDR and then download
this file to a different value.

Thanks Tom, I will send a v2.

> 
> -- 
> Tom

Cheers,

Hiago.
