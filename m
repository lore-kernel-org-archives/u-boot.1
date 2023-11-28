Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55222C4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 17:40:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A110E876D0;
	Tue, 28 Nov 2023 18:40:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zh//RUka";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72A6D87630; Tue, 28 Nov 2023 18:40:51 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 016C187630
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 18:40:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-50bc22c836bso439096e87.0
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 09:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701193248; x=1701798048; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fdZa8TDggzLl0mTG7CRYD2YU2dt/3CXciOKRBiHaKro=;
 b=zh//RUkaDCJzpV9hOWLwiYguQvg44bS5OUwepuOFozV2rAmS9qnbJLfHFSpGBng3lh
 fTQMWFTQHy41syQU+4T+ThUWT5ZvJTD8j3NE6Y59XsolYU94fxbjXhHADeZaHrR4q7Vh
 AgWq6gonPA550JHPGYooCvi3QaHpoccZtSb8W61e6GBFi3JHxR9mtLhz6p5aIkZDG2W1
 aPE5rqJ15d2BhM2BhmSkgJwniRTQVSJutVEvyx0RGAuL6ykuLTKTjZLdH20FISKfOrxb
 RmCIWyXjOW60xDR+sUnDTjInaKepiSzIKetQuEekwpau6wqPnGfEZifRyh5nq1DJyc1J
 HZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701193248; x=1701798048;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fdZa8TDggzLl0mTG7CRYD2YU2dt/3CXciOKRBiHaKro=;
 b=sASeKKw7SuR+0qbn6b3IRrXAc/CUrmlFTN3hqgYsX/p1nH2rGlCjb4H+7hl6dvC197
 AExo/WcjaOTOoPxPb/yBg1vsybhhfmxdMMK2LFOPAVzRYJXYRNmB9aRJQH/m5T5gBHgT
 I4SAEO5hv6s9dJ3mzWXqLmPAypguVI3aZqsep5DlcmVrD3xZYyjOsuu6SUCFGId5KiTK
 q2emqrthBSAas44xL/DuLFbGbtTh77LnH3UBV7RgjJBWg/HHjrdAC4b7r6qoBqYOhI9r
 1lWMhMxir95yKO6muTU3Gbg0HxbKw5S2PhYDch58uIIMMO0lGuNns0QXDBF3sF88gycD
 jnBg==
X-Gm-Message-State: AOJu0Yy/1sbaEvRi8KOAU2/Sw9ZSq689M+NHrfiOTPyqXlBIx9m/xXNV
 ayH86VVB0cEcaJLYPRSWxXOrvWTFaJ36pQcskngnlA==
X-Google-Smtp-Source: AGHT+IFLdkoV2e0i2NwYtUcz6jbHQWOkYRF35/Xoe4f1DozeU7sBmECazW494TnlMGz/LHARzc3muiLLiF/NQO9vTB0=
X-Received: by 2002:a05:6512:108f:b0:507:97ca:ec60 with SMTP id
 j15-20020a056512108f00b0050797caec60mr13227275lfg.3.1701193248140; Tue, 28
 Nov 2023 09:40:48 -0800 (PST)
MIME-Version: 1.0
References: <20231128154508.465171-1-ilias.apalodimas@linaro.org>
 <e27e8bc1-6d8e-4eeb-bc82-66bead193ae5@gmx.de>
In-Reply-To: <e27e8bc1-6d8e-4eeb-bc82-66bead193ae5@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 28 Nov 2023 19:40:11 +0200
Message-ID: <CAC_iWjKBWOpLkLi=+nKAzUWzYzOG20VQ-Zyxhhhd6_568TZ0WA@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: Make DisconnectController follow the EFI spec
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

Hi Heinrich

On Tue, 28 Nov 2023 at 18:30, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 28.11.23 16:45, Ilias Apalodimas wrote:
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
>
>
>
> >
> > Move the reconnection in efi_uninstall_protocol() were it belongs.
> >
> > Fixes: commit 239d59a65e20 ("efi_loader: reconnect drivers on failure")
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> > Heinrich this is critical. Although it doesn't break anything on our normal
> > use cases it does break the ACS testing for SystemReady-IR and I prefer
> > landing it in -master before the 2024.01 release
>
> Ok
>
> >
> >   lib/efi_loader/efi_boottime.c | 23 +++++------------------
> >   1 file changed, 5 insertions(+), 18 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
> > index 0b7579cb5af1..370eaee8ce1a 100644
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
> > @@ -1350,31 +1350,17 @@ static efi_status_t efi_disconnect_all_drivers
> >       if (!number_of_drivers)
> >               return EFI_SUCCESS;
> >
> > -     tmp = number_of_drivers;
> >       while (number_of_drivers) {
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
> > -     return ret;
> > +     return (ret != EFI_SUCCESS ? ret : EFI_SUCCESS);
>
> This will always return ret. Did you want to return another value?

No just ret

> >   }
> >
> >   /**
> > @@ -1409,6 +1395,7 @@ static efi_status_t efi_uninstall_protocol
> >       r = efi_disconnect_all_drivers(handle, protocol, NULL);
> >       if (r != EFI_SUCCESS) {
> >               r = EFI_ACCESS_DENIED;
> > +             EFI_CALL(efi_connect_controller(handle, NULL, NULL, true));
>
> Chapter "EFI_BOOT_SERVICES.UninstallProtocolInterface()" of the EFI
> specification says: " In addition, all of the drivers that were
> disconnected with the boot service DisconnectController() earlier, are
> reconnected with the boot service
> EFI_BOOT_SERVICES.ConnectController()." What makes you think that
> ConnectController() should be called with DriverImageHandle = NULL? I
> cannot derive this from the specification.

EDK2 does this as well to reconnect all controllers. Don't  we have
the same functionality?

>
> EDK2's CoreDisconnectControllersUsingProtocolInterface() does so. But
> shouldn't such behavior be defined in the specification?

This is what confused me in the first place and I added the reconnect
code in disconnect_controller. But if you look more closely they also
have CoreDisconnectController() which *is* the EFI protocol they
expose.

CoreDisconnectControllersUsingProtocolInterface is just a wrapper they
use on UninstallProtocol()

>
> We have 4 places where we use EFI_CALL to call efi_connect_controller.
> Should we provide an internal function?

Sure, but not for 2024.01

>
> Best regards
>
> Heinrich

Thanks
/Ilias
>
> >               goto out;
> >       }
> >       /* Close protocol */
> > --
> > 2.37.2
> >
>
