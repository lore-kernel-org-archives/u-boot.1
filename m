Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E80B7C27C4F
	for <u-boot@archiver.kernel.org>; Sat, 15 Jun 2024 06:58:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0DC487BF4;
	Sat, 15 Jun 2024 08:58:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JzKsiV/L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE0DD8796B; Sat, 15 Jun 2024 08:58:33 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41B178796B
 for <u-boot@lists.denx.de>; Sat, 15 Jun 2024 08:58:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2c2ecd25e5aso2340442a91.2
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 23:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718434710; x=1719039510; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QGIBd9beJy0rDLpAZ1l3K7Bd9SwUMtQdMsEaak48N/0=;
 b=JzKsiV/LwYpcAfvMt3brasb7LUfxVopK2pOJOEpO5hsKkS5TRrzo7nHw30KEptfTu1
 19WuH8Cfi3MlAAjsN/kGKL66fGsuy7w9ttAlNMme5fxjidfx/O9gyvifkuFs2oGBPQfB
 q8Srp9v7DUDV6GtMJqnbAaVM7kBCv7l0yceVhpr3PVonUimiuXJYezpM87p90Qrt/CEh
 4VV6s1y6aO6gZhqwf7UOUh5bwdQnKrOUPZXR57Vepm5qqWLkfVaAvWNVNkY3cILNOpnP
 yf5y2zZ8LKz9CVVWPV1UWNrZOLDGZS4LHElu19nGr+ZvwyU76/r+PAsqhHkqzd85wUo/
 ljAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718434710; x=1719039510;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QGIBd9beJy0rDLpAZ1l3K7Bd9SwUMtQdMsEaak48N/0=;
 b=aDBtoA0ZG8zR/5D4RDZActiiqmuLSu0UDMHL4mpz/Ewgt82Ou6qifW5Sgvrni9vT9t
 O/tvr7LRxQqGWFopIAmmXFbCZFhjtOOYRVSZm+o7A7rq+3nDMYOw0csfiUHd114fpJaS
 pLsRcwAF4msN+x+LPGIZYVc1mJyph4w5LGdle5kaTuygQWGtVFWggBXt602fYeE3EULZ
 BbhZRS4UtwuX9l8mk4QNR+j80SVLxTDKyszDqINwRFADqEiHfTgMwO7HLTYBZKE/SG81
 JIHQ1OQVP3v0+kz38eYRw613y9a7y5qrnIvvuwVq8NXH2r9B+00s4gckx7Loow/9upTQ
 Rmxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvqK7b5rvEuncKSOefiP75jJ7qo4Y4phqli3MXObPvIz0mLx0C7KZEfCpwW17kfIqrtU76KCpc4u/QMIgaQq2I3IKC2Q==
X-Gm-Message-State: AOJu0YzsFccCfayY431obxJG/bA5BbEKsBLC+EBJRtkpwUae1BN6pNnG
 a22I0EVCaFHO1WH4IJm0+7xYlJWvF0YayA54SYR7YqT8JrVBh42L5UZvAwN1eZCyXWsXPb7Sgoc
 DjL7rYNB1KuOjA+zUgvmWniZ08QDR6zFJ0+Z+Iw==
X-Google-Smtp-Source: AGHT+IHFPRORJF5d0YKxImqH+GV1w7yf3KXn3YDOrsjQ1Gv0YzWFO4BIyM0sBGqIlRt3c7yieSp7/o7GZ5oin281bzg=
X-Received: by 2002:a17:90a:d805:b0:2c2:ce08:d0e4 with SMTP id
 98e67ed59e1d1-2c4db44b5acmr5160384a91.23.1718434709572; Fri, 14 Jun 2024
 23:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240614120951.16158-1-ilias.apalodimas@linaro.org>
 <8b18f131-4e9d-4706-9a43-9ceb35f14d51@linux.ibm.com>
In-Reply-To: <8b18f131-4e9d-4706-9a43-9ceb35f14d51@linux.ibm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 15 Jun 2024 09:57:53 +0300
Message-ID: <CAC_iWjJ0S5pZUfffop5dS_daopb-kpOWNeNF_pbOQLW-vPwtPg@mail.gmail.com>
Subject: Re: [PATCH] tpm: measure DTB in PCR1 instead of PCR0
To: Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
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

Thanks Eddie,

On Sat, 15 Jun 2024 at 00:31, Eddie James <eajames@linux.ibm.com> wrote:
>
>
> On 6/14/24 07:09, Ilias Apalodimas wrote:
> > The PC client spec [0], doesn't describe measurements for DTBs. It does
> > describe what do to for ACPI tables though.
> >
> > There is a description for ACPI in 3.3.4.1 PCR[0] =E2=80=93 SRTM, POST =
BIOS,
> > and Embedded Drivers and they explicitly mention ACPI in there. There's
> > no mention of ACPI in 3.3.4.2 PCR[1] =E2=80=93 Host Platform Configurat=
ion.
> >
> > However, in Figure 6 --  PCR Mapping of UEFI Components ACPI is shown
> > in PCR1. The general description also mentions PCR0 is for code and PCR=
1
> > is for data such as ACPI and SMBIOS.
>
>
> Thanks, looks correct.
>
> Reviewed-by: Eddie James <eajames@linux.ibm.com>

Heinrich, do you want to carry this on the EFI tree, or shall I send a
PR via the TPM tree?

Thanks
/Ilias
>
>
> >
> > So let's switch over the DTB measurements to PCR1 which seems a better
> > fit.
> >
> > [0] https://trustedcomputinggroup.org/resource/pc-client-specific-platf=
orm-firmware-profile-specification
> >
> > Reported-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >   boot/bootm.c              | 2 +-
> >   lib/efi_loader/efi_tcg2.c | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/boot/bootm.c b/boot/bootm.c
> > index 6fa8edab021e..3de87eb185d7 100644
> > --- a/boot/bootm.c
> > +++ b/boot/bootm.c
> > @@ -963,7 +963,7 @@ int bootm_measure(struct bootm_headers *images)
> >                       goto unmap_initrd;
> >
> >               if (IS_ENABLED(CONFIG_MEASURE_DEVICETREE)) {
> > -                     ret =3D tcg2_measure_data(dev, &elog, 0, images->=
ft_len,
> > +                     ret =3D tcg2_measure_data(dev, &elog, 1, images->=
ft_len,
> >                                               (u8 *)images->ft_addr,
> >                                               EV_TABLE_OF_DEVICES,
> >                                               strlen("dts") + 1,
> > diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
> > index 51264c1b998c..a8a54c9f131d 100644
> > --- a/lib/efi_loader/efi_tcg2.c
> > +++ b/lib/efi_loader/efi_tcg2.c
> > @@ -1328,7 +1328,7 @@ efi_status_t efi_tcg2_measure_dtb(void *dtb)
> >       sha256_update(&hash_ctx, (u8 *)dtb + fdt_off_mem_rsvmap(dtb), rsv=
map_size);
> >       sha256_finish(&hash_ctx, blob->data + blob->blob_description_size=
);
> >
> > -     ret =3D measure_event(dev, 0, EV_POST_CODE, event_size, (u8 *)blo=
b);
> > +     ret =3D measure_event(dev, 1, EV_POST_CODE, event_size, (u8 *)blo=
b);
> >
> >       free(blob);
> >       return ret;
> > --
> > 2.45.1
> >
