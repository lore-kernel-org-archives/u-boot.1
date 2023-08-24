Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E98C3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 14:06:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B584B86433;
	Thu, 24 Aug 2023 16:06:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OvmTYvdT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFDDA86481; Thu, 24 Aug 2023 16:06:34 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2962A863E9
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 16:06:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4ffae5bdc9aso8409745e87.1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 07:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692885991; x=1693490791;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mrzuoWRukIgAPeLIbNX53GuFkWHw/Tuz1fcp6XgfxOU=;
 b=OvmTYvdT/5vZ70sV8uTiEZRINSRWYXtyMJpoKen4wmJeiD9wXWdXiSCXARRxaczHnT
 VxuoPsY+47bv5I480cUXjlLUV+9cSnRy1qUE+XvsIUI2n7zKqWr03AhQi2cd5z53HMbh
 FntEEupJA07nssvkabiHs1WB+94uiEK8b5/pbW2r3s1XeKbdjoaIgTwmCCXjC+3PfppW
 aF6M3thEBnHLi1weqh2gTMz14SyveKMq69xao6O8cXE+r6IXey2kIKlvmWUMBHTB/5Aq
 D4LAd+fCXzGFGKCsk3AM1mGYazkORt2bC9R0T+UNAn8BfY+kzWuD+ApDWdvKuQma3Eqa
 Za+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692885991; x=1693490791;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mrzuoWRukIgAPeLIbNX53GuFkWHw/Tuz1fcp6XgfxOU=;
 b=FlNJsLyVl3sAd6lk3HNB0eUcadfv+ZWm/MjaKe1NpYDE3U32B9bDBsvjESMRGsrvXZ
 MV3Q7RR+nqKcpx6Mj40BKLZEjnPKeWpakRw9QJxJ2bfcqngPhBqfiSwSG+MGH72bkDFx
 0f8TZ9ainnfataEHdprIQ1I0GuUFYfM9hEAyvL0yFJBgvm4o/AgFBjU3/HCUzSlKx++l
 KhhcC+u4w4xbuMlKwLpV/vse8URJ3YbCfnLdA2PU2+Fc7Xqs3DkLSnzW0e8jBk6HZOys
 9JmR/jyRFKSjDoInT0o3mG20kOrErsCdfUpZ4dCWOumjxm5dpGmOaoqpgDJnml9kWQ+F
 CsQg==
X-Gm-Message-State: AOJu0YxqzB+o+LLGZjjQy8ggKSXo+7yphm4GGp5Xlc7oup9qyWsjAilc
 ho5M9Ls9U7RF08UN14Y4dEQUgr+k1mPbDdaqKb/aXQ==
X-Google-Smtp-Source: AGHT+IFSQu0mt3+kkHwKBOYGABZb9QAYlA9f0HdK/8S/RzqojW9Gs3SymN2bsIK72GhXq+roVa4qrpX4XZ+mC2TmVzQ=
X-Received: by 2002:ac2:4e95:0:b0:500:7dcc:621 with SMTP id
 o21-20020ac24e95000000b005007dcc0621mr7911386lfr.31.1692885991270; Thu, 24
 Aug 2023 07:06:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230824115500.2388636-1-ilias.apalodimas@linaro.org>
 <b84b35df-c146-5255-f9b6-427688cd7eeb@gmx.de>
 <CAC_iWjLUFe=tBAZTndrzusDLpuFExSFRjjRxgzeZ1iL=_y57Kg@mail.gmail.com>
 <4b0ee7eb-0d8f-3a83-791a-e4bef539fd8a@gmx.de>
In-Reply-To: <4b0ee7eb-0d8f-3a83-791a-e4bef539fd8a@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 24 Aug 2023 17:05:55 +0300
Message-ID: <CAC_iWjJ9MAoqh=c2xaSuibw=Sph-AtMDOLS0OW6NPQFApBN-mg@mail.gmail.com>
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

On Thu, 24 Aug 2023 at 17:02, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 24.08.23 15:06, Ilias Apalodimas wrote:
> > Hi Henrich
> >
> >
> >>>
> >>> +/**
> >>> + * efi_purge_handle() - Clean the deleted handle from the various lists
> >>> + * @handle: handle to remove
> >>> + *
> >>> + * Return: status code
> >>> + */
> >>> +static efi_status_t efi_purge_handle(efi_handle_t handle)
> >>> +{
> >>> +     struct efi_register_notify_event *item, *next;
> >>> +
> >>> +     if (!list_empty(&handle->protocols))
> >>> +             return EFI_ACCESS_DENIED;
> >>> +     /* The handle is about to be freed. Remove it from events */
> >>> +     list_for_each_entry_safe(item, next, &efi_register_notify_events, link) {
> >>
> >> You are not deleting from efi_register_notify_events.
> >
> > I am not sure I understand this.  I am not trying to delete the event
> > here, but the handle on which the notified protocol was installed.
> >
> >>   Why do you use the safe version of the iterator?
> >
> > No particular reason, I just tend to prefer it over the unsafe one.
> > The latter is perfectly fine here.
>
> The save version is only needed if you delete the current item or insert
> in the current position.

Ok, I'll change that on v2

>
> >
> > [...]
> >
> >>>
> >>> -     /* If the last protocol has been removed, delete the handle. */
> >>> -     if (list_empty(&handle->protocols)) {
> >>
> >>>        size_t i = 0;
> >>> @@ -2795,25 +2827,25 @@ efi_uninstall_multiple_protocol_interfaces_int(efi_handle_t handle,
> >>>                return EFI_INVALID_PARAMETER;
> >>>
> >>>        efi_va_copy(argptr_copy, argptr);
> >>> +     protocol = efi_va_arg(argptr, efi_guid_t*);
> >>>        for (;;) {
> >>> -             protocol = efi_va_arg(argptr, efi_guid_t*);
> >>> +             bool preserve = true;
> >>> +
> >>>                if (!protocol)
> >>>                        break;
> >>>                protocol_interface = efi_va_arg(argptr, void*);
> >>> +             next_protocol = efi_va_arg(argptr, efi_guid_t*);
> >>> +             if (!next_protocol)
> >>> +                     preserve = false;
> >>
> >> Is your idea that if 5 protocols are to be removed but only the first 3
> >> are installed your want to reinstall the first 3?
> >
> > Not only that. Image you install 2 protocols and then someone tries to
> > uninstall 3. If the invalid guid/protocol is at the beginning or the
> > middle of the list you'll be fine.  The current code will reinstall
> > the previously removed protocols.
> > However, if the invalid protocol is last, you will have removed 2
> > valid protocols and the handle will be empty.  In that case, we will
> > delete the handle before trying to reinstall the uninstalled
> > protocols.
>
> This is just what I meant.

Ok, I'll just adjust my explanation and add it as a comment in v2

Thanks
/Ilias
>
> Best regards
>
> Heirnich
>
> >
> >>
> >> Can we have some code comment describing what the function should do? In
> >> 5 years nobody will remember why the code was implemented this way.
> >>
> >
> > Of course
> >
> > [...]
> >
> > Cheers
> > /Ilias
>
