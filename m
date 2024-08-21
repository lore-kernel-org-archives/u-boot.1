Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA1AC3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 02:12:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 028ED88B86;
	Wed, 21 Aug 2024 04:12:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZLkp+YxR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FB1788B89; Wed, 21 Aug 2024 04:12:57 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D108F88B6C
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 04:12:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6bf9db9740aso13608766d6.2
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 19:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724206374; x=1724811174; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Mrtk0rF/jYRaEuZwP/ZCX1s1thsj2Q8OTFo0xNmab4k=;
 b=ZLkp+YxRJDX8fQpzYUzbL8X79ujEpwasS4/Gg35bLf7J4jVzAR55qJMc70NaP+pLwJ
 pDeL9RLvNKKAwRgOaDVlJattRQyIM/URZ8h925VZuONgKKTvMmawYOqZ3Q+hdGJE8Ny8
 dMYGAgtN53yKIs2e0zQGJ9Q+6ePIBcFsTxBL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724206374; x=1724811174;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mrtk0rF/jYRaEuZwP/ZCX1s1thsj2Q8OTFo0xNmab4k=;
 b=RnrS15KSPUdLGA9YefUDjqIIL9R/Z0qufSxZf/15GFI1w00rYXeD02g6d13TUKKnU9
 Po75PF+ICIsUkG45K2aRWla64bM3jxvLcVLPh45CiWl27QZIBpspNkObtmHNRFjVqUxN
 ebqXh8uq6XVzrSTvE/vpFSU7JRVMpHgdzGZLReACphf5rVqxNbuQ/eVk02lmTh9byRG1
 iqMRMOCOhWYvFBinepT55CroFnq3q0RNvpaERhlTcAJ2DvAdacPBB7+R7Zd1gavh8fco
 ntryHWMjsQz8UuydcVvXmTnPpsqxxIAtO30tNun1wWOYkNiTLXQ1ibd4eOFq53+MWXiY
 9jqg==
X-Gm-Message-State: AOJu0YzwQWzGZKMS1GuqelFx1k4+uqDzMay55NTmDTMlMBae4jnQTA3f
 MY5mItTOH72cFtTg+Nx8Z+WQaLLLY0/55KpWGbW1MZEdbfyx2dKg6iDSrKnf5FtuISlBeU78dSt
 lFbBK9GE4CyQKEunyV4FXnwGh2vEeG5+ZQWNU
X-Google-Smtp-Source: AGHT+IEoarVbovV72atK3eCXH+RJPa7TkCe/q0X/tzDL10tfojE3SZNCEToELxvjMhBuWS+2yf3fyBOIj8JLMZtSFyk=
X-Received: by 2002:a05:6214:3bca:b0:6bd:7460:fedc with SMTP id
 6a1803df08f44-6c155de2610mr14995996d6.45.1724206373654; Tue, 20 Aug 2024
 19:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240815202424.766778-1-sjg@chromium.org>
 <20240815202424.766778-14-sjg@chromium.org>
 <20240816161311.GY1626301@bill-the-cat>
In-Reply-To: <20240816161311.GY1626301@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 20 Aug 2024 20:12:43 -0600
Message-ID: <CAFLszThGHKcxZ33pHaxCwq--OiR6sPgAK+ugYC18YByAiRKKyg@mail.gmail.com>
Subject: Re: [PATCH v4 13/14] test: efi: boot: Set up an image suitable for
 EFI testing
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Tom,

On Fri, 16 Aug 2024 at 10:13, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Aug 15, 2024 at 02:24:23PM -0600, Simon Glass wrote:
> > Create a new disk for use with tests, which contains the new 'testapp'
> > EFI app specifically intended for testing the EFI loader.
> >
> > Attach it to the USB device, since most testing is currently done with
> > mmc.
> >
> > Initially this image will be used to test the EFI bootmeth.
> >
> > Fix a stale comment in prep_mmc_bootdev() while we are here.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> [snip]
> > +    try:
> > +        loop = mount_image(cons, fname, mnt, 'ext4')
> > +        mounted = True
> > +        efi_dir = os.path.join(mnt, 'EFI')
> > +        mkdir_cond(efi_dir)
> > +        bootdir = os.path.join(efi_dir, 'BOOT')
> > +        mkdir_cond(bootdir)
> > +        efi_src = os.path.join(cons.config.build_dir,
> > +                               f'lib/efi_loader/testapp.efi')
> > +        efi_dst = os.path.join(bootdir, 'BOOTSBOX.EFI')
> > +        with open(efi_src, 'rb') as inf:
> > +            with open(efi_dst, 'wb') as outf:
> > +                outf.write(inf.read())
> > +    except ValueError as exc:
> > +        print(f'Falled to create image, failing back to prepared copy: {exc}')
> > +
> > +    finally:
> > +        if mounted:
> > +            u_boot_utils.run_and_log(cons, 'sudo umount --lazy %s' % mnt)
> > +        if loop:
> > +            u_boot_utils.run_and_log(cons, 'sudo losetup -d %s' % loop)
>
> Please see
> https://patchwork.ozlabs.org/project/uboot/patch/20240802093322.15240-1-richard@nod.at/
> for inspiration on making this not require sudo.

It's optional, hence the fallback, but I'll need to wait until that
stuff lands as we use common functions.

Regards,
Simon
