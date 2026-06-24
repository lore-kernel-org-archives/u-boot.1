Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB80CDB479
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 15:36:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 261D1849D8;
	Wed, 24 Jun 2026 17:36:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="E/bqHvjv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C991849D2; Wed, 24 Jun 2026 17:36:06 +0200 (CEST)
Received: from mail-yx1-xb12b.google.com (mail-yx1-xb12b.google.com
 [IPv6:2607:f8b0:4864:20::b12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C02A849D8
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 17:36:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-6647bc8f900so334165d50.0
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 08:36:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782315361; cv=none;
 d=google.com; s=arc-20240605;
 b=ExC51KF6JoUIh5XR03E29uBPRIpV1SdiU+oCWew2xJ7wTxhtoNyjIvtGJsyrCUxmrc
 79DVWvhn0D0tfstjlx9tv/0ME561eGQKZ8TqH7CYhQoJatjJmmAU6CbWy6GIxgW2vUTX
 cS3ffudfBCDyqmpf1F03yCjPNxCXMEs4ukc9+L5sdTp8gEH7Am/Zwr7Cr5YeF9FMHH5t
 dKgFkxsW+hJhDUF5t1oLLEHk9vkfn3el9uZmkRRK3/ihWwDraXGdtFJdj70EAbQAuwsQ
 /eYlo354oktcpDVv71Qn2vOvD7BD9DhMDdqSJlg3nfzpjbC2aygCIY/RrDscLGn1Ro5N
 QO7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oEGU80ioXr3lMTXN0F2z5h0Avh9Wdu+KzZIcunP6Dkk=;
 fh=4q5C7hKOtTOGKSQ7kUBmqlGmZOdIMJKEMMNq7T/PWfc=;
 b=ELft6hIo6zfVmD6Acup+6EvWNgaqUiQsuK5JQilDJ4q6AsAbs8EVWaTd4/A89NXCLK
 QiE2Mxa5z0L63kR2luD6Er+yJ0Asvfzq/ldXoxBTVUsuiLnWzsVppch1yzDc2AMIkZ6g
 XprpJTZV1iFwBszqbU02M9kopO1pQ2c4G5u0wIkj/BdJshH1vJVv00s/xMgZGnU8dotK
 vxoKcFDr09G494f/hXomxOo/9IX+PeOqR6SDAaVOP2MXevebvDg0dotEfVW6xLag6V+C
 Oo0t07EpEfJZFvhHjbE+hmwesZRLWwgX5A7TMukEDhNu54ZL8rGW1iQ8uZCG3rOVW1xe
 aPGA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782315361; x=1782920161; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oEGU80ioXr3lMTXN0F2z5h0Avh9Wdu+KzZIcunP6Dkk=;
 b=E/bqHvjvD+RVxte5eNGAc9NaFQIHarNt2TMek5ZyMPm1mfJi1Xc90Ckav1latQ24tm
 hvQ34GtC60KuiosIJ13t7qRKv06TUn/bNWWK5IW6FjVLwGguIlqS7tavyUOJjsE2oRKu
 DhWn/hwbwSLvKEX9dAiDS6k9wYc8VNKceWGllsBeV0n7PZNvkJOE8B+AXB4gXcDkuE+W
 NvL+MztKOGdHPVTJElt2E1VPac+u8TRnQdGmWKhyj7/a7Wlt+MOI25OmUNZmO3LSp1QK
 q2MUUoQld8ReooJOpI0mRwNYQBmm4KakizEaIz7odwrUW7x9k1ZIZnp21Lz0+zVOn2Na
 syrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782315361; x=1782920161;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oEGU80ioXr3lMTXN0F2z5h0Avh9Wdu+KzZIcunP6Dkk=;
 b=I9FSoJtRax23pUIuXTFw0kv26+Ou1GH/soPX+JzX9Q33ddYim9px3a4vTNma74qchy
 STHLrr3o7ZWPh5Cnzkq+9vlD2y83Fhk6ucI298aGUqSZ/lQ430HMei4kh+AVVJqt5gQh
 5cy6EOZsB5xeaKLcYXhuIB4eoZE68QnsktoVKU4CMLUD6I7/DKWFeHxE3MyHRAYul/XD
 5QPrNYDoAUMH66KL/Xdg89g72X2ai2c8+GSFUubyhyY/ooOetVqKUilUzZyaG/5/o/E1
 m3XZVEmih6vDMO6dCugB8gB+2a10oUFEKVkTk89W7GzglmnAGLXFMt4Ai99n+sp+8sjr
 3g6g==
X-Gm-Message-State: AOJu0YwLbJ7tvVV5jPfW/pjHYyKEolheuhY8Yqkpe13PQ0zPUOhOqy4m
 Kh634C5lWvHwItzT99zcoRipSuy28dTPCcWIJnBiYrgUGolAAYg6NS3ZDhrqgF59WuvnoVxlpdw
 h72ya0v883VOsWU+IlPvCMpb8xsb4q67qHICWx5caDA==
X-Gm-Gg: AfdE7ckDpb2+d7+dyNlCReHTEu5EjbVITnmLlKk5bdXzTZmxBhMriU+ia+TTJ1tyiCX
 j1kegsrh+2oqVV9jONTweicpmWlwZT3qhNf3iOrLgs632MAe3N8F9KLMcZpV8Psia1bD+PWCZHm
 Ee4BBwKHGncG8QgLk6DLEPutnOuU5XO+ZsgHMKssuOkauAEVFTKtq95F9fLhx3sVCSO2pLIGXwd
 rcB8bhzocZtJDdFlUFgKQJkIPfznz5VzusxjenrrVuq7Qz4CDX5LurGYb7a+0oQHAldlDTVXR3g
 mLu5bG8E0C71S5YfjfqTQyvhkuMahZ0gdAuB1USVw6Dw+VmFjjodzEQGlqMgJZx9HWY5vJqV9Jx
 Wo/NVCDVOFjy7roPTy2p3+K/7fEYiuxaltx9im1ErL3flLaI6XJiRTI43sRXKkbsHkwKb+ga6d7
 l9hkBNf5hz+gEF2BHFK8lJfBFMlig8ms8ZdQHqxOkPemeCMNNYZbXDfwtqVmsQXAcjciFSnr6T7
 o6O56aclY0AsmFEPWlX1kBE2Qjds7Qqhb4YDNE710t0l+iH/LnWfsQ6rWeZqyQzmcWJJff65lTI
 4nkvFsfsK7kfIedt5bzlmGVkiTd9J0aGhkU9N5oTS7JphaWcvlBlzuK4aOXMAraCfN5UMVQ=
X-Received: by 2002:a05:690e:dc2:b0:662:f2d1:f42 with SMTP id
 956f58d0204a3-66359eeddddmr7200839d50.7.1782315360795; Wed, 24 Jun 2026
 08:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-7-harsimransingh.tungal@arm.com>
 <CAC_iWjLBc2sCTeO-voXRaJu34vft+cq4s2qbF=cpqNvNYxZc_w@mail.gmail.com>
 <178230332182.4122019.1939205928978533568.b4-reply@b4>
In-Reply-To: <178230332182.4122019.1939205928978533568.b4-reply@b4>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 24 Jun 2026 18:35:24 +0300
X-Gm-Features: AVVi8CecWycTqCpFoWgdznjF72VXvC8uSesVWIcYVyzrdFdgyN74jh9oRn1P5LA
Message-ID: <CAC_iWjKQu_7kTn3JUge7E9LJT_dya4-j1_7XJm1bqHg_pXBZ_A@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] efi_loader: move runtime variable read helpers
 to efi_variable.c
To: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Cc: u-boot@lists.denx.de, abdellatif.elkhlifi@arm.com, trini@konsulko.com, 
 xypron.glpk@gmx.de, hugues.kambampiana@arm.com, sjg@chromium.org
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

Hello Harsiman

[...]


> tus_t EFIAPI efi_query_variable_info(
> > >         return EFI_EXIT(ret);
> > >  }
> > >
> > > -efi_status_t __efi_runtime EFIAPI
> > > -efi_get_variable_runtime(u16 *variable_name, const efi_guid_t *guid,
> > > -                        u32 *attributes, efi_uintn_t *data_size, void
> *data)
> > > -{
> > > -       efi_status_t ret;
> > > -
> > > -       ret = efi_get_variable_mem(variable_name, guid, attributes,
> data_size,
> > > -                                  data, NULL,
> EFI_VARIABLE_RUNTIME_ACCESS);
> > > -
> > > -       /* Remove EFI_VARIABLE_READ_ONLY flag */
> > > -       if (attributes)
> > > -               *attributes &= EFI_VARIABLE_MASK;
> > > -
> > > -       return ret;
> > > -}
> > > -
> >
> > I think I mentioned this on the previous version as well.
> > The reason that we represent variables in memory at runtime, is that
> > it works for both secure and non secure world storage. In the secure
> > world case, Linux scans that OP-TEE can support variables at runtime
> > and swtiches get/setVariable to point in op-tee functions.
> > Due to the above we were less strict wth the API, since evenryone just
> > called the _mem variant for runtime calls and it saved us a function
> > call.
> >
> >  If we want to change this, the right fix would be to define _int
> > variants in the efi_variable.c and efi_variable_tee.c and call them
> > from efi_var_common.c. This basically boils down to calling the _int
> > version in efi_get_variable_runtime and efi_get_next_variable_runtime
> > on the common code.
> >
> > Thanks
> > /Ilias
> >
> >
> Hi Ilias,
> Thanks, that makes sense.
>
> Just to confirm the intended scope: should I apply this pattern only to
> efi_get_variable_runtime() and efi_get_next_variable_name_runtime(), since
> those are the helpers moved by this patch, or would you prefer the same
> common-wrapper plus backend-specific _int pattern for all four runtime
> variable service functions:
>
> efi_get_variable_runtime()
> efi_get_next_variable_name_runtime()
> efi_set_variable_runtime()
> efi_query_variable_info_runtime()


Apologies, I am going to backtrack on my previous response. Looking at it
again, I prefer a different approach. What I proposed is just going to make
us define duplicate runtimes in efi_variable.c and efi_variable_tee.c

Can we instead do this. Don't change efi_var_common.c Those are functions
that are currenlty used across file, SPI and OP-TEE implementations.
Instead define the runtime version you want in efi_variable_tee.c and
assign it efi_variables_boot_exit_notify(). You can then leave the optee
case unchanged, calling the memory backend and your own FF-A versions if
compiled with that.

Cheers
/Ilias



>
> I will make relevant changes as per your feedback in v3.
> Thanks
>
> Regards
> Harsimran Singh Tungal
>
> > > -efi_status_t __efi_runtime EFIAPI
> > > -efi_get_next_variable_name_runtime(efi_uintn_t *variable_name_size,
> > > -                                  u16 *variable_name, efi_guid_t
> *guid)
> > > -{
> > > -       return efi_get_next_variable_name_mem(variable_name_size,
> variable_name,
> > > -                                             guid,
> EFI_VARIABLE_RUNTIME_ACCESS);
> > > -}
> > > -
> > >  /**
> > >   * efi_set_secure_state - modify secure boot state variables
> > >   * @secure_boot:       value of SecureBoot
> > > diff --git a/lib/efi_loader/efi_variable.c
> b/lib/efi_loader/efi_variable.c
> > > index 9923936c1b5..f2e0e1ad4e2 100644
> > > --- a/lib/efi_loader/efi_variable.c
> > > +++ b/lib/efi_loader/efi_variable.c
> > > @@ -579,6 +579,30 @@ efi_set_variable_runtime(u16 *variable_name,
> const efi_guid_t *vendor,
> > >         return EFI_SUCCESS;
> > >  }
> > >
> > > +efi_status_t __efi_runtime EFIAPI
> > > +efi_get_variable_runtime(u16 *variable_name, const efi_guid_t *guid,
> > > +                        u32 *attributes, efi_uintn_t *data_size, void
> *data)
> > > +{
> > > +       efi_status_t ret;
> > > +
> > > +       ret = efi_get_variable_mem(variable_name, guid, attributes,
> data_size,
> > > +                                  data, NULL,
> EFI_VARIABLE_RUNTIME_ACCESS);
> > > +
> > > +       /* Remove EFI_VARIABLE_READ_ONLY flag */
> > > +       if (attributes)
> > > +               *attributes &= EFI_VARIABLE_MASK;
> > > +
> > > +       return ret;
> > > +}
> > > +
> > > +efi_status_t __efi_runtime EFIAPI
> > > +efi_get_next_variable_name_runtime(efi_uintn_t *variable_name_size,
> > > +                                  u16 *variable_name, efi_guid_t
> *guid)
> > > +{
> > > +       return efi_get_next_variable_name_mem(variable_name_size,
> variable_name,
> > > +                                             guid,
> EFI_VARIABLE_RUNTIME_ACCESS);
> > > +}
> > > +
> > >  /**
> > >   * efi_variables_boot_exit_notify() - notify ExitBootServices() is
> called
> > >   */
> > > --
> > > 2.34.1
> > >
> >
>
>
>
