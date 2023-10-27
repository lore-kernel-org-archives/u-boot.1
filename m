Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FEB9C25B47
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 04:46:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B7F38768C;
	Fri, 27 Oct 2023 06:46:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CUMhfOSC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DA868768F; Fri, 27 Oct 2023 06:46:32 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5651B87689
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 06:46:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-50802148be9so2027941e87.2
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 21:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698381989; x=1698986789; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RbeCPqOG/R8X44n8SNG+nxMuSRYR4t/KSGbs6VGOx8U=;
 b=CUMhfOSCXmh2O9CJyJlBz9YIPurGtkH7BC+RXtZjgqBgzptd4HIpTXP51dNcxko3yE
 RZLB3K1nAfeYER+ZFYBYpYJVvnbb9yPjpgzvYmV/tcwtInESn3egAmE8yzylVpvgcnGv
 5rTYIqQnIBD+aMJ8+fWPqmTADDAhe8obsb3avyltTwkpLJn00+VmJj3HhrCzWm+ji83o
 cwM57IShnH7n8fRmWsIOe4F2mCBuuffkZ+rfmqduogbC552z53+BV2e3pxrPR53sUh6K
 eMZB299a+Qb7KX5qe/6DBj+yNZ3yHVcXAKARaOPRflfqR5v3eVnsPCiZwWYHCm9efo3J
 h1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698381989; x=1698986789;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RbeCPqOG/R8X44n8SNG+nxMuSRYR4t/KSGbs6VGOx8U=;
 b=TOq92IYgiHgqGA/oKaTdhjaSRcaSDoLVsnczJIgHXOm1B39cY47TaK+mar4xWa0C15
 HL3qvwl90FkouVvL2VDK4nj7e0ixABuFGtYXDihEX5dBrXagkClD0l8TLAO5TC4Mp9JQ
 zs9k0JzF/w90w0DaspBmLxMfrTlCR+PET3r35L90ncj3Vy/udopfeWjquX61rNgmPnU4
 FpjfH2tkX5grlxOYm7kxvBND0+F7Po75r1kZpzoRBRaZWKEH+jIWRDrjwo6/n2IcYA9t
 4HAVqzNNyKUyOU91hYZlkkp2vz8LNQGejkBBzgbeBF0qOlpsSNiutJk+7p9O4LidGuOo
 1/Jw==
X-Gm-Message-State: AOJu0Yw7l4UWzlFhs3Yc8ySattnIX5VfLz+tiWbjOgRMiovU+PbxF5v/
 BKd5GHUpwfRsLEkc/ZZKJYnvnY4z2T8P/f+laVewUg==
X-Google-Smtp-Source: AGHT+IG12uRzKRDhXF0VUHqKu9vrP46WJR0mB9BU8BGsBOSfjP0hg9F7apivPa0Eq0RmnnyhHFYnmGQffmtxzoxuGfg=
X-Received: by 2002:a19:8c0f:0:b0:503:1783:d5a9 with SMTP id
 o15-20020a198c0f000000b005031783d5a9mr792168lfd.3.1698381989512; Thu, 26 Oct
 2023 21:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231025065103.3101666-1-masahisa.kojima@linaro.org>
 <20231025065103.3101666-2-masahisa.kojima@linaro.org>
 <CAC_iWjJ2nNjLeJe201Nx1Uay2xqMgesZdzzsUOO8bpUe3_VXvw@mail.gmail.com>
 <CADQ0-X94TOt4xTaGPz7Bir2RWzMr8e_SB-cSAX0=PHvCp8Zceg@mail.gmail.com>
In-Reply-To: <CADQ0-X94TOt4xTaGPz7Bir2RWzMr8e_SB-cSAX0=PHvCp8Zceg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 27 Oct 2023 07:45:53 +0300
Message-ID: <CAC_iWj+52HRgqHy7i6j8dRhssaJNdW25+Uk5_xGzjK0jgJdMOg@mail.gmail.com>
Subject: Re: [PATCH 1/3] board: developerbox: remove obsolete NOR flash layout
 definition
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, jaswinder.singh@linaro.org, ryosuke.saito@linaro.org,
 sugimoto.yoshio@socionext.com
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

On Fri, 27 Oct 2023 at 03:21, Masahisa Kojima
<masahisa.kojima@linaro.org> wrote:
>
> Hi Ilias,
>
> On Fri, 27 Oct 2023 at 03:58, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > On Wed, 25 Oct 2023 at 09:52, Masahisa Kojima
> > <masahisa.kojima@linaro.org> wrote:
> > >
> > > There are two kinds of NOR flash layout for the Developerbox.
> > > Capsule update for the old layout is no longer available since
> > > it has small capacity for secure world images and can not
> > > house the TA such as fTPM.
> > > This commit removes the definition related to the obsolete
> > > NOR flash layout for the UEFI capsule update.
> > >
> > > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > > Acked-by: Jassi Brar <jaswinder.singh@linaro.org>
> > > ---
> > >  include/configs/synquacer.h | 19 -------------------
> > >  1 file changed, 19 deletions(-)
> > >
> > > diff --git a/include/configs/synquacer.h b/include/configs/synquacer.h
> > > index cd7359c2f8..e36e63e81e 100644
> > > --- a/include/configs/synquacer.h
> > > +++ b/include/configs/synquacer.h
> > > @@ -40,20 +40,6 @@
> > >
> > >  /* Since U-Boot 64bit PCIe support is limited, disable 64bit MMIO support */
> > >
> > > -#ifdef CONFIG_FWU_MULTI_BANK_UPDATE
> > > -#define DEFAULT_DFU_ALT_INFO
> > > -#else
> > > -#define DEFAULT_DFU_ALT_INFO "dfu_alt_info="                           \
> > > -                       "mtd nor1=u-boot.bin raw 200000 100000;"        \
> > > -                       "fip.bin raw 180000 78000;"                     \
> > > -                       "optee.bin raw 500000 100000\0"
> > > -#endif
> >
> > We don't need any of these because we use the .dfu_alt_string to
> > generate those right?
>
> You are correct. We can generate dfu_alt_info from .dfu_string.
>
> Thanks,
> Masahisa Kojima
>
> >
> > > -
> > > -/* GUIDs for capsule updatable firmware images */
> > > -#define DEVELOPERBOX_UBOOT_IMAGE_GUID \
> > > -       EFI_GUID(0x53a92e83, 0x4ef4, 0x473a, 0x8b, 0x0d, \
> > > -                0xb5, 0xd8, 0xc7, 0xb2, 0xd6, 0x00)
> > > -
> > >  #ifdef CONFIG_FWU_MULTI_BANK_UPDATE
> > >  #define DEVELOPERBOX_FIP_IMAGE_GUID \
> > >         EFI_GUID(0x7d6dc310, 0x52ca, 0x43b8, 0xb7, 0xb9, \
> > > @@ -64,10 +50,6 @@
> > >                  0x33, 0xe0, 0xb9, 0x16, 0xf3, 0x98)
> > >  #endif
> > >
> > > -#define DEVELOPERBOX_OPTEE_IMAGE_GUID \
> > > -       EFI_GUID(0xc1b629f1, 0xce0e, 0x4894, 0x82, 0xbf, \
> > > -                0xf0, 0xa3, 0x83, 0x87, 0xe6, 0x30)
> > > -
> > >  /* Distro boot settings */
> > >  #ifdef CONFIG_CMD_USB
> > >  #define BOOT_TARGET_DEVICE_USB(func)   func(USB, usb, 0)
> > > @@ -107,7 +89,6 @@
> > >         "ramdisk_addr_r=0xa0000000\0"           \
> > >         "scriptaddr=0x88000000\0"               \
> > >         "pxefile_addr_r=0x88100000\0"           \
> > > -       DEFAULT_DFU_ALT_INFO                    \
> > >         BOOTENV
> > >
> > >  #endif /* __CONFIG_H */
> > > --
> > > 2.34.1
> > >
> > Thanks
> > /Ilias

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
