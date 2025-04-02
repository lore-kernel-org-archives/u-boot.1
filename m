Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD90C36018
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 22:03:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB9AA81E6C;
	Thu,  3 Apr 2025 00:03:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bCs7+icA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18DA681F0B; Thu,  3 Apr 2025 00:03:23 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A33578035B
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 00:03:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-6febf391132so3237607b3.1
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 15:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743631399; x=1744236199; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ov8EGziljxx4/Wgy2f8BCkc25sJhdbLSOkvWilf+e2I=;
 b=bCs7+icAlb1sBCdW4ivyUjImlQASSLOHB/Mg3Vc+x8QJ8UcBTuSu/tgFO+rqB11KVp
 pCQLr+6nin9eXjoLXeoaz9c05UFZsbpQyn0khMRfJOJF8X+glTwcQTNKUFXtvpjcxUH8
 2sHfggJiuTHNX+GyYa+bUAfzs2m64OaSVom3tlkOC6LlHtXiXSwiU3z/Q++8uyut2dkV
 Ji08XNp2Vj5tL55jeaWDmIkXuPuaS5vTKLZuk4+uEZlGOtmY5eFLe1swmseaARPYCcqF
 kSfYg6Jp+FR7kx9nSmVPpaOsRVV5R49sb0jVfqaXFyxaziYj6xMfhycP2hbKZCqnVduC
 aq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743631399; x=1744236199;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ov8EGziljxx4/Wgy2f8BCkc25sJhdbLSOkvWilf+e2I=;
 b=LUIateqbXis+FgXFV6A91Yz02isJTqhIk67SBXISEzVW7IPivuBDRLQSbIoGH9m+gv
 d/0ntqgdnrndmCQ5ygPI38SjPhwLbVmixIktr9YWMJNq++qZvuFhbw7y2pzP8JO5WSgJ
 ugt+eAJNc1bwLSDi8G/Li1XxdoEcxk8cqm9iGnqGbEf4X5G0tFuTgMX6pKBwJ60OSuPM
 msdg0kO6uhTg6HSbR19RqwFT6HVyxgkhn5is3bS2lYp6Fmnk/Zvv41CNeUVOaTvVyEvY
 PRI/uzhMBM/f3HDGrMW935YhMinP2Io3nl/EoWcs7wuosVdKfFd4BpllByMUWYoBldOy
 1qIQ==
X-Gm-Message-State: AOJu0Yz51NSefDDMR7ZBuaZPv+3XF0exseNiLYoZgC2EjnHEgqxY6pHM
 5EC//4F/L3v5OgmumrAfVRspPed3qs8v0vWGo4+fKWsRpPGfKr1fFxlDtzxXppIaYTDYGtYwOLH
 TloNfzHB7esIyCguNZ8ePmagqcZSDULOZGv1Whg==
X-Gm-Gg: ASbGncsF8Zcwh9AL4h2iIGSVpRrMBLDhim/UFq5kNvzcjcBJZ8VGH/cMrr0uxeQUJ4i
 lq6qSKo2ksupQN/iOoC6313HKCqJ2z4edEPf6eHM5az9+85/qxHOku/kosZSdgWaYHMRnzcOIvP
 U5sSnnA/O2GcKpigsiVTwsazZk
X-Google-Smtp-Source: AGHT+IH5mdLoBDaKGij92kzn7NHSV8ZKh2QIH2McPZF/z3Dem+ZnznpWKylvFxelBlK157hJAlpiNpR25OzxIB7CYaI=
X-Received: by 2002:a05:690c:640e:b0:6f6:cc1d:a6d with SMTP id
 00721157ae682-70257101efemr289291597b3.18.1743631399390; Wed, 02 Apr 2025
 15:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+HfNj+B-LmZx7tVXWPqvK6fZ9V_iHsJ19e9MUFGF=JTVu6Xg@mail.gmail.com>
 <CAC_iWjJyBjGnK6Wv0qXvZ-ujnZ9anc+bw_q-0qCRk-3XAGC4bw@mail.gmail.com>
 <CAJ+HfNjOfy5FVBhPV52gpPV1O_=F9KWDoYVeZVBjSOoCUACacw@mail.gmail.com>
In-Reply-To: <CAJ+HfNjOfy5FVBhPV52gpPV1O_=F9KWDoYVeZVBjSOoCUACacw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 3 Apr 2025 01:02:42 +0300
X-Gm-Features: AQ5f1JqV_K-8aZ18RKJxEaCZmlesCAXhDlkxIF35SvrvEK32BH-sX638PTQ_hQw
Message-ID: <CAC_iWjL+TGrH4NuzfFcwwWNeiKNUCOLG-5u8_ou30T6x0A0k6w@mail.gmail.com>
Subject: Re: RISC-V UEFI/ACPI on QEMU regression?
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, 2 Apr 2025 at 18:26, Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> wrote=
:
>
> Hey!
>
> On Wed, 2 Apr 2025 at 16:27, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hey Bjorn
> >
> > Long time, hope all is well!
>
> Too long! Maybe next Plumbers? ;-)

One can only hope!

>
> > I think it's a regression and I think what breaks it is commit cfb4aa2a=
754ed1
> >
> > Can you apply the diff below and see if it fixes it for you?
> >
> > diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
> > index 4422b31ac6a7..afa5eee85484 100644
> > --- a/lib/efi_loader/efi_acpi.c
> > +++ b/lib/efi_loader/efi_acpi.c
> > @@ -34,8 +34,8 @@ efi_status_t efi_acpi_register(void)
> >          * add_u_boot_and_runtime(). At some point that function could =
create a
> >          * more detailed map.
> >          */
> > -       if (IS_ENABLED(CONFIG_BLOBLIST_TABLES))
> > -               return EFI_SUCCESS;
> > +       //if (IS_ENABLED(CONFIG_BLOBLIST_TABLES))
> > +               ////return EFI_SUCCESS;
> >
> >         /* Mark space used for tables */
> >         start =3D ALIGN_DOWN(gd->arch.table_start, EFI_PAGE_MASK);
>
> Unfortunately, still the same with this patch:

Yea, I skimmed that too quickly ...

Can you try this though?

diff --git a/drivers/misc/qfw_acpi.c b/drivers/misc/qfw_acpi.c
index 0d0cf7646890..77cebae5e3fd 100644
--- a/drivers/misc/qfw_acpi.c
+++ b/drivers/misc/qfw_acpi.c
@@ -305,7 +305,7 @@ static int evt_write_acpi_tables(void)
        /* Generate ACPI tables */
        end =3D write_acpi_tables(addr);
        gd->arch.table_start =3D addr;
-       gd->arch.table_end =3D addr;
+       gd->arch.table_end =3D end;

        return 0;
 }

Thanks
/Ilias
>
> [    0.000000] efi:   0x00047eee3000-0x00047ef19fff [Boot Code   |   |
>  |  |  |  |  |  |  |  |  |   |WB|  |  |  ]
> [    0.000000] efi:   0x00047ef1a000-0x00047ef49fff [ACPI Reclaim|   |
>  |  |  |  |  |  |  |  |  |   |WB|  |  |  ]
> [    0.000000] ACPI: RSDP 0x000000047EED1000 000024 (v02 BOCHS )
>
> (RSDP resides in Boot Code)
>
>
> Bj=C3=B6rn
