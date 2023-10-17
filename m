Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5709ECDB482
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 09:50:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC55286D4D;
	Tue, 17 Oct 2023 11:50:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VSUexrZv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93FD586D56; Tue, 17 Oct 2023 11:50:13 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3422D865A2
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 11:50:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-507be298d2aso658520e87.1
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 02:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697536210; x=1698141010; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YQC9f7oo1l5EKysQSHsvPofTOp/iLwRbF/SOHgBVG7A=;
 b=VSUexrZvOafuaHmOfebFpI5ovRmSLe1iEJAAybqEcfdCTfczoq8BwLfAm/LGb5CJCI
 09OfPLrmhKmaJTrxJt8sjQD8rVkfKSwcsm4ZsobINeXpomnPl3XVu9sI/E4wBUSiA6Yn
 HdKdgDSJNTMZu10P+SAslWIWbvICGjKiQQoeLigtRAWgIXq6SSnAZDC+6TkLf7TJHF57
 VI3bjlHLXUfPxHa7f7EPfi6UdyUm6xd/Ni5PXwnETLmRjccIhKBoO8rzgp4Kcw6mdj/w
 gi9du7EsnbHsz/UmAWWb7TRD8enYSIdLN+qJaoFrTPmTks+dh7jN0rzS4yogxm3HKCPx
 moaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697536210; x=1698141010;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YQC9f7oo1l5EKysQSHsvPofTOp/iLwRbF/SOHgBVG7A=;
 b=QYC2W5etCj6aZt2f7f6238fAb2QVkMHwC5UekOr3PpS/SW5Vzst+Usku1ZHM7mVGIs
 TL8XvMS4z3CC+y3Tsdm7NWWoZO0AkGqp0nGrHwv3xiMyL7oGmrNQwY8ALmxOPDdKLWyq
 lHBtNaGGBLKET23VlPCllMiJdASHnUX7TjsRLIyHuw4XVPOQezMscHB6d0A5xQHXCTSZ
 cWdb73Sh7kKg1Kv5QQcL03iBc+BSSwKnclc5Sf4UV1CEPen+zb6hS5oZIXt2rySYPT1r
 cc9ylftSkZBbLhvh8to6KGJVEgrasZiBPjkcJSEdUjuqd0Kl1AzgMxUoh99ZxAQkpzB7
 wrOQ==
X-Gm-Message-State: AOJu0YxkvoiReZN4r9Owt74C5LtOur0FLBdk1mV0ZFjNHvL9lfRyRINU
 ejQhem/9RFHlMF6XdAmYV31grgxz9LxNmWLs7pE2fk6Smbp9CSd+HSo=
X-Google-Smtp-Source: AGHT+IGfpPjgoYAp07dPLXV1gp2cz/DLhPDWV1/Bxy2IIpDxjjpO5DI//VILAtVbd8FIKmO75bn2PSGBe9twMPiH6mU=
X-Received: by 2002:ac2:560c:0:b0:4fe:8ba9:4c4 with SMTP id
 v12-20020ac2560c000000b004fe8ba904c4mr1412720lfd.59.1697536210413; Tue, 17
 Oct 2023 02:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <20231017085507.12094-1-heinrich.schuchardt@canonical.com>
 <CAC_iWjLgt0USVOQxp6WE_1edxMYMdGzfhvEFM67e91m-_iYn-A@mail.gmail.com>
 <cf0e5002-223e-4777-ab6f-654747c516b1@canonical.com>
In-Reply-To: <cf0e5002-223e-4777-ab6f-654747c516b1@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 17 Oct 2023 12:49:34 +0300
Message-ID: <CAC_iWjJ41LUzR-1GV4MCvgBADqB9Ba-hHT+7M2BEsQC_uz3-Lg@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: expose the device-tree file name
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Tue, 17 Oct 2023 at 12:23, Heinrich Schuchardt <
heinrich.schuchardt@canonical.com> wrote:

> On 17.10.23 11:14, Ilias Apalodimas wrote:
> > Hi Heinrich,
> >
> > On Tue, 17 Oct 2023 at 11:55, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com
> > <mailto:heinrich.schuchardt@canonical.com>> wrote:
> >
> >     Forward and backward compatibility of Linux kernel device-trees is
> >     sometimes missing. One solution approach is to load a kernel specific
> >     device-tree. This can either be done via a U-Boot scripts (like the
> one
> >     generated by Debian package flash-kernel or by a boot loader like
> GRUB.
> >     The boot loader approach currently requires to know the device-tree
> name
> >     before first boot which makes it unusable for generic images.
> >
> >     Expose the device-tree file name as EFI variable FdtFile.
> >     This will allow bootloaders to load a kernel specific device-tree.
> >
> >     Signed-off-by: Heinrich Schuchardt
> >     <heinrich.schuchardt@canonical.com
> >     <mailto:heinrich.schuchardt@canonical.com>>
> >     ---
> >       lib/efi_loader/efi_setup.c | 26 ++++++++++++++++++++++++++
> >       1 file changed, 26 insertions(+)
> >
> >     diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> >     index e6de685e87..b24feb94dc 100644
> >     --- a/lib/efi_loader/efi_setup.c
> >     +++ b/lib/efi_loader/efi_setup.c
> >     @@ -26,6 +26,27 @@ void __weak allow_unaligned(void)
> >       {
> >       }
> >
> >     +/**
> >     + * efi_init_fdtfile() - set EFI variable FdtFile
> >     + *
> >     + * Return:     status code
> >     + */
> >     +static efi_status_t efi_init_fdtfile(void)
> >     +{
> >     +       char *val;
> >     +
> >     +       val = env_get("fdtfile");
> >     +       if (!val)
> >     +               return EFI_SUCCESS;
> >     +
> >     +       return efi_set_variable_int(u"FdtFile",
> >     +                                   &efi_u_boot_guid,
> >     +                                   EFI_VARIABLE_BOOTSERVICE_ACCESS |
> >     +                                   EFI_VARIABLE_RUNTIME_ACCESS |
> >
> >
> > Why is runtime access needed?  Wouldn't the choice be done before
> > ExitBootServices?
>
>
> Having runtime access will allow to use the content of the variable to
> write a devicetree command to grub.cfg or to copy the relevant
> device-tree to a predefined location.
>
> As GRUB cannot read EFI variables, yet, this would be the easiest
> short-term approach.
>
> Do you mean to write EFI variables?  If you want GRUB to be able to do
that, wouldn't it be better to use a generic GUID instead of the U-Boot one?

Regards
/Ilias

> Best regards
>
> Heinrich
>
>
> >
> > [...]
> >
> >
> > Thanks
> > /Ilias
>
>
