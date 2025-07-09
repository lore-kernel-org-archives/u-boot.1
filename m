Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E566C83F0A
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 17:06:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 692F8834BC;
	Wed,  9 Jul 2025 19:06:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lCO2KfsX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABFCC83535; Wed,  9 Jul 2025 19:06:01 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31C3B8349B
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 19:05:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e7dc89108bfso25791276.3
 for <u-boot@lists.denx.de>; Wed, 09 Jul 2025 10:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752080758; x=1752685558; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lpFsbtMAnutnf/r+q89awCrJLcVPQzl+J1+BSGdzT24=;
 b=lCO2KfsXihSHFiz/prb5v1CGWJsydbux18Z2pgLa6svV/mxyZo2mhbOEJmOGpJF8TL
 w335gsfi0yS1h/jGZ24dKKTy30MpTU5SmLDsOVejZC2+q59MTXNrQSzXjTkbOg9iHyGp
 p4MdfyiZE3mnfJZ39m3FXvhXejjd56gTvwDlAG+yr+6ODzrZpO0bTFxgEtL8gPFsTBbJ
 UBNfGNoeBA4MsSrK87QVGNYo8vS+/Zj41ZKw57bCEh6mmQ+GyAUnxQRDIjvZ1MmuSaxn
 R+X7SP6xSaWUx6qZwA2+pPcic52OL/Id0fpAqJmyU5aTAqMCvuga6vKlEg2V9/Qup1eh
 XMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752080758; x=1752685558;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lpFsbtMAnutnf/r+q89awCrJLcVPQzl+J1+BSGdzT24=;
 b=ZHuGMgu7VBHcYy/QuOn+C20YgFYpuwrGq2DroVsjGEmkJg/fszljS65i8YQrfSuNvm
 DxXOpS2MdbMDllwQnCjsiT6TQMAH0lMgo7hNgXXGL6kGYMW59ivGD4B+2m2cSQt3QmI3
 pxukeWQDZWScch42IwSOlHQVG4r9sQgzzMBpsupJOD/OTNphJg56+gWJp5eSS4vo7xbL
 z5TewLPxI7k90pG4U6i0LX0vQ6EtKbBKIOye09skxt+YvkjiT6/3LWbkNoj8ggL8upDa
 66wFeiWZMY0GjqoH2YIAJE9hpkM5AdS8i3vd/8GrH7aD/CsKqy1B9iH6w4kpih8HLHXZ
 uaTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUF4XivODzu2pD1BL3q5Pyq0lSq5ZsRnxB9a0zRKMTCaOJntb1osbOUrYq1BddjZl0NIR9Cjj8=@lists.denx.de
X-Gm-Message-State: AOJu0Yy6HAAKyu4/lbWSAqX4D9WQWYrz73DCo64R3MTDBU9PLnxer7WU
 q+4yIT+dLW6ClGkQKDz3FSVA0nOrAFp9p8elImrK323ZC6N+4PuvsMz8XVUxabuQ2CWYEZL56A0
 2Us0QPLo3FJe1zqDONhkDpC3Pw5qh8WRQzlMjEokzbQ==
X-Gm-Gg: ASbGncv9Ep/Cvw5Y2X4qHOLfbCM6p6FD74ySEQrn5dzyfYslHekj5GRPAmuztrANDta
 UMMFzPRx9Qz7kRQeAawOTFomlNhQcnPMXTgL6+FlcS//0KgmU++dqmPlMxZDHzJIJbxyO3MvKMC
 C4x4M2Ndzjnuk8LbpW6Dti6eRKpFW7bkf4WNUmcUTMxMU=
X-Google-Smtp-Source: AGHT+IGNAiFaYDpXtN5dwveVctE5asAujIDt0jyL9WshoKeiHEdMhoA7INDbKGwI7NGBqArwZm7unyGLiOk5aYK+45w=
X-Received: by 2002:a05:690c:46c3:b0:70e:7638:a3a9 with SMTP id
 00721157ae682-717b19cdcdemr50067197b3.18.1752080757658; Wed, 09 Jul 2025
 10:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250529150213.27149-1-richard@nod.at>
 <174976652550.365589.4489095631856636528.b4-ty@konsulko.com>
 <CAPLW+4kSGfyhd_Bxr+cn=PJV1Zvi2Du5+jLSZSxhqBPZ=PvFow@mail.gmail.com>
 <1752760284.mgMEAqHVhB@nailgun>
In-Reply-To: <1752760284.mgMEAqHVhB@nailgun>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 9 Jul 2025 12:05:46 -0500
X-Gm-Features: Ac12FXznckRzgr39VpvpjK8cU-DZoqwsC__CVw-ngqwH3YAP3KVQIygkW4ZHzGM
Message-ID: <CAPLW+4nz81kT=uTofbf86sqQnGZYB2d4A=mr5P3zT0kOstRKQA@mail.gmail.com>
Subject: Re: [RFC, PATCH] fdt: Make sure there is no stale initrd left
To: Richard Weinberger <richard@sigma-star.at>
Cc: Tom Rini <trini@konsulko.com>, Richard Weinberger <richard@nod.at>,
 upstream@sigma-star.at, 
 u-boot@lists.denx.de, ddrokosov@salutedevices.com, sjg@chromium.org, 
 tharvey@gateworks.com, ilias.apalodimas@linaro.org, 
 kojima.masahisa@socionext.com, upstream+uboot@sigma-star.at
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

On Wed, Jul 9, 2025 at 1:24=E2=80=AFAM Richard Weinberger <richard@sigma-st=
ar.at> wrote:
>
> On Mittwoch, 9. Juli 2025 00:58 Sam Protsenko wrote:
> > fdt_initrd() function (where initrd dts properties are removed) is
> > called two times:
> >
> > 1. First it's called by EFI boot manager (e.g. as a part of U-Boot
> > Standard Boot mechanism) when it's installing FDT:
> >
> >     fdt_initrd
> >     image_setup_libfdt
> >     efi_install_fdt
> >     efi_bootmgr_run
> >     efi_mgr_boot
> >
> > It's already enough for EFI app to malfunction. But then it's also
> > called second time:
> >
> > 2. From the EFI app, via EFI DT fixup protocol:
> >
> >     fdt_initrd
> >     image_setup_libfdt
> >     efi_dt_fixup
> >     struct efi_dt_fixup_protocol efi_dt_fixup_prot =3D {
> >         .fixup =3D efi_dt_fixup
> >     };
> >
> > See [2] for specific GBL code which sets those fdt properties and then
> > runs DT fixup protocol callback.
> >
> > I don't see any way for U-Boot to know if those initrd properties are
> > going to be set later by other EFI apps or not. So arguably this patch
> > should be reverted. But I might be missing something and maybe there
> > are better options to fix that?
>
> I think we need to distinguish two cases:
> 1. The caller explicitly does not want to have an initramfs. e.g. you run=
  "bootm addr1 - addr3".

Yes, so fdt_delprop() lines should be probably moved to appropriate
users, e.g. image_setup_linux(). Can you take care of this? I'm in the
middle of something else right now and can't spend too much time on
this. Or we can just revert this patch for now, to fix EFI apps
breakage.

> 2. The caller does not care. Your case.
>
> Thanks,
> //richard
>
> --
> sigma star gmbh | Eduard-Bodem-Gasse 6, 6020 Innsbruck, AUT UID/VAT Nr:
> ATU 66964118 | FN: 374287y
>
>
