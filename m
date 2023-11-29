Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA762C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 06:46:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D0C2875C6;
	Wed, 29 Nov 2023 07:46:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ODLzmQqv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D3EA875C6; Wed, 29 Nov 2023 07:46:02 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A54A2870A2
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 07:45:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2c887d1fb8fso79354101fa.0
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 22:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701240359; x=1701845159; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1aH3obipbU9eopAbfcOGR86BoBgE2LBUYeFqbG/E02s=;
 b=ODLzmQqvhada39nzKLxcNs+cDqXQ46zxSWk+ShDQaKXuGECPuWxaAnTyxAaq5f8r8D
 jsZ5WZZiuSHT60cawNkeDPnYic50wCzgXzfxW4wGxKpgdSzTdCIp2jrTxVMO5AF75YoV
 ZvdmATDvDXi1yDPfDxF/mQtkujgFQRP1MHtP5QsUAV5kBi+qDZlegovMIhOUyZiwCOix
 b2AqAOGlh0WLqoIaYJwaCIredxPqD1n7ks6BDclJd0wYl3VvUMCXtbTbqYkTy/dgygXp
 CBTcRsFCxCvjsJPFH3Sdhd87AVnsRDsS6hJAQRJbyg8W1KrP/adWagVF19qR1TJBWCyQ
 nRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701240359; x=1701845159;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1aH3obipbU9eopAbfcOGR86BoBgE2LBUYeFqbG/E02s=;
 b=cHb4srlmX57OoBPc2z9u7lbeu7lsm6faVPrROCokOPoyuq+47fCKnW9B4qMFUIKcKV
 s2EiAcKLX5vstcAaTKVpHodwQ9uIt/Sat9VXdJwBDDMTPG4QQdZ2eXLc9mvHgZFpeLWj
 fektw0M+27fq4jkssiypbSYkOPGeNuy7Vl2DHb22mwiqhSKJ21F5MTOCTftUlvhktJCX
 SC72LnLnZ72a1ExCrRVqvtepK57xrLwxXAQPottj5aUjeASL0TdMK/mqTbZyQVk4l35x
 RZEtxym//IYxsIJM331OQd4xNlgxBx/e8Lv3LemZ5iuQz5sRGFvSBWtwomioIjbH3bqB
 YC2g==
X-Gm-Message-State: AOJu0YzotI/7NCJtK3ji9W5AqGuWry/l3h2Ga0pHSpLb7G+69ldIvvhn
 jjsG93ddI8s9xs4BM9rfVPcCDRIOZ5YrHZSGpVO1mw==
X-Google-Smtp-Source: AGHT+IG5avF0PsrCsOTdF80OFHzcGQWi4fAyhbIC5fHM2NjxaBKtzciI9peJrKWwl/i5DUb2ot62Bj2I9IOeXWkzM/A=
X-Received: by 2002:a2e:9610:0:b0:2c9:b809:5890 with SMTP id
 v16-20020a2e9610000000b002c9b8095890mr2291900ljh.35.1701240358705; Tue, 28
 Nov 2023 22:45:58 -0800 (PST)
MIME-Version: 1.0
References: <20231128191031.467222-1-ilias.apalodimas@linaro.org>
 <e68eab24-0927-4d8b-9bed-6f1278dc3292@gmx.de>
In-Reply-To: <e68eab24-0927-4d8b-9bed-6f1278dc3292@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 29 Nov 2023 08:45:22 +0200
Message-ID: <CAC_iWjKVTWYRz6EG062F=f2Vwi3o=tw6dErd1YgON20mnMNXWg@mail.gmail.com>
Subject: Re: [PATCH v2] efi_loader: Make DisconnectController follow the EFI
 spec
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: masahisa.kojima@linaro.org, ryosuke.saito@linaro.org, u-boot@lists.denx.de
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

Hi Heinrich,

On Wed, 29 Nov 2023 at 03:26, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 11/28/23 20:10, Ilias Apalodimas wrote:
> > commit 239d59a65e20 ("efi_loader: reconnect drivers on failure")
> > tried to fix the UninstallProtocol interface which must reconnect
> > any controllers it disconnected by calling ConnectController()
> > in case of failure. However, the reconnect functionality was wired in
> > efi_disconnect_all_drivers() instead of efi_uninstall_protocol().
> >
> > As a result some SCT tests started failing.
> > Specifically, BBTestOpenProtocolInterfaceTest333CheckPoint3() test
> >   - Calls ConnectController for DriverImageHandle1
> >   - Calls DisconnectController for DriverImageHandle1 which will
> >     disconnect everything apart from TestProtocol4. That will remain
> >     open on purpose.
> >   - Calls ConnectController for DriverImageHandle2. TestProtocol4
> >     which was explicitly preserved was installed wth BY_DRIVER attributes.
> >     The new protocol will call DisconnectController since its attributes
> >     are BY_DRIVER|EXCLUSIVE, but TestProtocol4 will not be removed. The
> >     test expects EFI_ACCESS_DENIED which works fine.
> >
> >     The problem is that DisconnectController, will eventually call
> >     EFI_DRIVER_BINDING_PROTOCOL.Stop(). But on the aforementioned test
> >     this will call CloseProtocol -- the binding protocol is defined in
> >     'DBindingDriver3.c' and the .Stop function uses CloseProtocol.
> >     If that close protocol call fails with EFI_NOT_FOUND, the current code
> >     will try to mistakenly reconnect all drivers and the subsequent tests
> >     that rely on the device being disconnected will fail.
> >
> > Move the reconnection in efi_uninstall_protocol() were it belongs.
> >
> > Fixes: commit 239d59a65e20 ("efi_loader: reconnect drivers on failure")
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> > Apologies for the fast resend, but since Heinrich reviewed it and
> > we want it in 2024.01 resending
> > Changes since v1:
> > - return ret instead of (ret != EFI_SUCCESS ? ret : EFI_SUCCESS) which does the
> >    same thing...
> > - Add a comment about reconnecting all controllers
> >   lib/efi_loader/efi_boottime.c | 27 ++++++++++-----------------
> >   1 file changed, 10 insertions(+), 17 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
> > index 0b7579cb5af1..ea711919630b 100644
> > --- a/lib/efi_loader/efi_boottime.c
> > +++ b/lib/efi_loader/efi_boottime.c
> > @@ -1339,7 +1339,7 @@ static efi_status_t efi_disconnect_all_drivers
> >                                const efi_guid_t *protocol,
> >                                efi_handle_t child_handle)
> >   {
> > -     efi_uintn_t number_of_drivers, tmp;
> > +     efi_uintn_t number_of_drivers;
> >       efi_handle_t *driver_handle_buffer;
> >       efi_status_t r, ret;
> >
> > @@ -1350,27 +1350,13 @@ static efi_status_t efi_disconnect_all_drivers
> >       if (!number_of_drivers)
> >               return EFI_SUCCESS;
> >
> > -     tmp = number_of_drivers;
> >       while (number_of_drivers) {
>
> You assume here that drivers can be removed in reverse order.
>
> Please, have a look at CoreDisconnectControllersUsingProtocolInterface()
> in EDK II.
>
> Here the code continues iterating over all connected controllers while
> at least one controller can be removed in each round.
>
> Reverse order is more promising than forward order. But maybe we should
> combine this with retrying like in EDK II.

There are some SCT tests that fail on ConnectController and I was
going to have a look.
But the current patch basically reverts this function as it was prior
to commit 239d59a65e20.
Do we have time to rewrite this before the release? Or should we merge
this and plan to refactor it for 2024.04?

Thanks
/Ilias
>
> Best regards
>
> Heinrich
>
> > -             ret = EFI_CALL(efi_disconnect_controller(
> > +             r = EFI_CALL(efi_disconnect_controller(
> >                               handle,
> >                               driver_handle_buffer[--number_of_drivers],
> >                               child_handle));
> > -             if (ret != EFI_SUCCESS)
> > -                     goto reconnect;
> > -     }
> > -
> > -     free(driver_handle_buffer);
> > -     return ret;
> > -
> > -reconnect:
> > -     /* Reconnect all disconnected drivers */
> > -     for (; number_of_drivers < tmp; number_of_drivers++) {
> > -             r = EFI_CALL(efi_connect_controller(handle,
> > -                                                 &driver_handle_buffer[number_of_drivers],
> > -                                                 NULL, true));
> >               if (r != EFI_SUCCESS)
> > -                     EFI_PRINT("Failed to reconnect controller\n");
> > +                     ret = r;
> >       }
> >
> >       free(driver_handle_buffer);
> > @@ -1409,6 +1395,13 @@ static efi_status_t efi_uninstall_protocol
> >       r = efi_disconnect_all_drivers(handle, protocol, NULL);
> >       if (r != EFI_SUCCESS) {
> >               r = EFI_ACCESS_DENIED;
> > +             /*
> > +              * This will reconnect all controllers of the handle, even ones
> > +              * that were not connected before. This can be done better
> > +              * but we are following the EDKII implementation on this for
> > +              * now
> > +              */
> > +             EFI_CALL(efi_connect_controller(handle, NULL, NULL, true));
> >               goto out;
> >       }
> >       /* Close protocol */
> > --
> > 2.37.2
> >
>
