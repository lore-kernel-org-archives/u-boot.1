Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7449DC6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 13:07:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E15B88642B;
	Thu, 24 Aug 2023 15:07:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CWwQvNqb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 449FA864AA; Thu, 24 Aug 2023 15:07:16 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 916DE86418
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 15:07:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-4fe15bfb1adso10253871e87.0
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 06:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692882433; x=1693487233;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eDIuv22Y+ImSkPeU75ov3NYeSl7oYOQq4umDqV7tGZ4=;
 b=CWwQvNqbwWJBAQM12AtLQISK3/yLqyrQRAYh9f1cP7xZkBSzpqMqCfiTUbOrUNR/d6
 h2adtD7SzEDamm1i7bDKLWMa7BQUA30fNCMyEBt285vBps5H0g38RXaZllWEpMc/NTYU
 vyo1r03TjQZeF9xCrvjmSgNkFe+qUTZeU4gRxUn0kr23gRBTva5AJ6pXOXMuNVSFjPfP
 27FQUfvZhhWgGcKjfCGhx8nHmDGoU4EHQLcjbkh5HvXFp0MkXI97ykLpLn3dAVKMl1kw
 7ZPyoR8VXvvOySpv915UdQRlT9zoWa2/jgpmy/o86q3SyQeeH0n+g1nzzyls2hSFWOjI
 FVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692882433; x=1693487233;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eDIuv22Y+ImSkPeU75ov3NYeSl7oYOQq4umDqV7tGZ4=;
 b=B7zRHGnmXG35wwwU0Ih5Ld1+KW831sYpqXr/xjwGIdC8cGW/r775wl/MNEtPTNSw2U
 Vn4rDl+blnKY1R4qU4TNCH+5hxdp4qqESMVI/mSa7QEwn+RraYS1VOgx1RjdTk/1S7ZR
 8DoFVRXSLoEYtVEcgTNYnhgxRl6GIIHKCodmZ4Sgif7t6zIolFZOBZ2Mcazkz4sZ6Owq
 Z/XUx7M3IwATPwQH2tcEiC8Hc6uePmy8G8yMCJLx6G9Zq+uP2KiVFxnBEAr/uOCnx1Bv
 983OYjd30EkBkOez+MCYAGYpDcCDxqIH9oYtPsgVkNSABhzmrwccoMlttaUHeuZE+NMH
 jC+Q==
X-Gm-Message-State: AOJu0YzdYN3WK35JHUB91DK3Lt16qEWOsTZS24e2NNhptDEhs67fUbjN
 MlbvO7+o1fnEZYdE/6/pNflEemSMlpy1ABd7W57gPA==
X-Google-Smtp-Source: AGHT+IHjL/gUTrRuccWf4GUEMLF8kLo1UZSJ/GbrnoySSNpcohiKsHAOQvTgex9dx62q8/B3wQecWSls3TmbgCl5MOE=
X-Received: by 2002:a05:6512:6c3:b0:4f8:7614:48a5 with SMTP id
 u3-20020a05651206c300b004f8761448a5mr13826842lff.66.1692882432802; Thu, 24
 Aug 2023 06:07:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230824115500.2388636-1-ilias.apalodimas@linaro.org>
 <b84b35df-c146-5255-f9b6-427688cd7eeb@gmx.de>
In-Reply-To: <b84b35df-c146-5255-f9b6-427688cd7eeb@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 24 Aug 2023 16:06:36 +0300
Message-ID: <CAC_iWjLUFe=tBAZTndrzusDLpuFExSFRjjRxgzeZ1iL=_y57Kg@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: delete handle from events when a protocol is
 uninstalled
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
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

Hi Henrich


> >
> > +/**
> > + * efi_purge_handle() - Clean the deleted handle from the various lists
> > + * @handle: handle to remove
> > + *
> > + * Return: status code
> > + */
> > +static efi_status_t efi_purge_handle(efi_handle_t handle)
> > +{
> > +     struct efi_register_notify_event *item, *next;
> > +
> > +     if (!list_empty(&handle->protocols))
> > +             return EFI_ACCESS_DENIED;
> > +     /* The handle is about to be freed. Remove it from events */
> > +     list_for_each_entry_safe(item, next, &efi_register_notify_events, link) {
>
> You are not deleting from efi_register_notify_events.

I am not sure I understand this.  I am not trying to delete the event
here, but the handle on which the notified protocol was installed.

>  Why do you use the safe version of the iterator?

No particular reason, I just tend to prefer it over the unsafe one.
The latter is perfectly fine here.

[...]

> >
> > -     /* If the last protocol has been removed, delete the handle. */
> > -     if (list_empty(&handle->protocols)) {
>
> >       size_t i = 0;
> > @@ -2795,25 +2827,25 @@ efi_uninstall_multiple_protocol_interfaces_int(efi_handle_t handle,
> >               return EFI_INVALID_PARAMETER;
> >
> >       efi_va_copy(argptr_copy, argptr);
> > +     protocol = efi_va_arg(argptr, efi_guid_t*);
> >       for (;;) {
> > -             protocol = efi_va_arg(argptr, efi_guid_t*);
> > +             bool preserve = true;
> > +
> >               if (!protocol)
> >                       break;
> >               protocol_interface = efi_va_arg(argptr, void*);
> > +             next_protocol = efi_va_arg(argptr, efi_guid_t*);
> > +             if (!next_protocol)
> > +                     preserve = false;
>
> Is your idea that if 5 protocols are to be removed but only the first 3
> are installed your want to reinstall the first 3?

Not only that. Image you install 2 protocols and then someone tries to
uninstall 3. If the invalid guid/protocol is at the beginning or the
middle of the list you'll be fine.  The current code will reinstall
the previously removed protocols.
However, if the invalid protocol is last, you will have removed 2
valid protocols and the handle will be empty.  In that case, we will
delete the handle before trying to reinstall the uninstalled
protocols.

>
> Can we have some code comment describing what the function should do? In
> 5 years nobody will remember why the code was implemented this way.
>

Of course

[...]

Cheers
/Ilias
