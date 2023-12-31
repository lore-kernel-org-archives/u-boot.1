Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3678CC3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 31 Dec 2023 12:45:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75852877FE;
	Sun, 31 Dec 2023 13:45:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YN2IcdiN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94F6D877DA; Sun, 31 Dec 2023 13:45:40 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1595187721
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 13:45:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-680496bc3aaso24783576d6.0
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 04:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704026733; x=1704631533; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=djLeK27zGatrLpbmptkI+SBmsrTn1oZJNCojjUX61D4=;
 b=YN2IcdiNGKcPxIS4PrVYe3HUTaAnRFduT2jMN4jQnOh05/OqPLoCMwR655R17qfQl1
 jKDrsr7Tl0oVm0CnDwFFwTFMJWAiuRNwaBedzmZGHjU6vDNZWlp28Il9JXubNyOZypBB
 erxTL+6bW1DUFccH8EEDnyzyLub7+fuASQ3g8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704026733; x=1704631533;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=djLeK27zGatrLpbmptkI+SBmsrTn1oZJNCojjUX61D4=;
 b=fUugInHRRnBzRTO80i8ff1ECIG1vqXGWS3/QZDled2X/QERRNxZ2yvc0oGDQeF+Io3
 EMAzBpNefHHU+e+fUAsigULPnmiT5Dl0VIQry6fG2dqQV0pkhmu8/Ckrk6dzin4AL1rg
 D6UOdLNNh/iWhuqJ1hHKnEeAnesGR7AGv9oqsdGmIx5H9ZT+uuvobIqxMkdpa+plyTWt
 d9FSt/tzDJSvy1tU9IQSzMvz1DBC02BoTx+gRY+J8kWgYlqbFCaViZ7L6cccZBYPcw99
 ybgFiySb4359wK4qxprZUiJnFYrnXA5R4uZYcTRJ0j0sk1D11+RHFDATe1aCw6eBQO3P
 UHww==
X-Gm-Message-State: AOJu0Yy1d7j3KQ7zJSiJUtOYpC5SxliwsPfByBDqZiSLZPkOymuOs77P
 gN1/gr2pdhH0lVfqKS8Dg9Qu/gibPMVBknILULsA7GIOKXzM
X-Google-Smtp-Source: AGHT+IHBejiekGxkzsshRgfaPuK5bK2ElZcozrQIEjzjqK83heIAeShw3qJbkJUdVgO+i78v/OTmR6XcPL1wGR/HiCI=
X-Received: by 2002:a05:6214:2aa9:b0:67f:2c33:3aca with SMTP id
 js9-20020a0562142aa900b0067f2c333acamr20809357qvb.78.1704026732913; Sun, 31
 Dec 2023 04:45:32 -0800 (PST)
MIME-Version: 1.0
References: <9f681497-d13c-4ccc-9209-7a8b33e3195c@gmx.de>
 <CAFLszThsThxhWCgP+UHmA5BxRUUBfDP7SDahtAm5WOrHoT0xhQ@mail.gmail.com>
 <e9a835ea-ea99-4db2-b5ad-ba7742397d46@gmx.de>
 <CAFLszTg17_xPGWMDG=1X+q2UTdJ_kO2pUshmDLt+cv9uPPcgJg@mail.gmail.com>
 <08e7b3cc-9588-46ab-844e-6edbe1154e43@gmx.de>
 <CAFLszTj1npgL8F0H2prS_iBS-Kj2p+-Ena_ccQSe4dXPLGAM7w@mail.gmail.com>
 <AA53366A-42EF-4F81-B1BC-C4408ED066B6@gmx.de>
In-Reply-To: <AA53366A-42EF-4F81-B1BC-C4408ED066B6@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 31 Dec 2023 05:45:22 -0700
Message-ID: <CAFLszTjgo4Dpor82ak-K3HmW8Of8GXxG5pxitCerguCkoQ0xfg@mail.gmail.com>
Subject: Re: ACPI: usage of sandbox virtual addresses
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Heinrich,

On Fri, Dec 29, 2023 at 8:58=E2=80=AFAM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
>
>
> Am 29. Dezember 2023 15:31:24 MEZ schrieb Simon Glass <sjg@chromium.org>:
> >Hi Heinrich,
> >
> >On Fri, Dec 29, 2023 at 11:14=E2=80=AFAM Heinrich Schuchardt <xypron.glp=
k@gmx.de> wrote:
> >>
> >> On 12/29/23 09:26, Simon Glass wrote:
> >> > Hi Heinrich,
> >> >
> >> > On Tue, Dec 26, 2023 at 10:03=E2=80=AFAM Heinrich Schuchardt <xypron=
.glpk@gmx.de> wrote:
> >> >>
> >> >> On 12/26/23 10:50, Simon Glass wrote:
> >> >>> Hi Heinrich,
> >> >>>
> >> >>> On Tue, Dec 26, 2023 at 8:56=E2=80=AFAM Heinrich Schuchardt <xypro=
n.glpk@gmx.de> wrote:
> >> >>>>
> >> >>>> Hello Simon,
> >> >>>>
> >> >>>> currently we use sandbox virtual addresses in all ACPI tables. Th=
is
> >> >>>> means that an application started by the U-Boot sandbox consuming=
 these
> >> >>>> tables will crash due to accessing invalid addresses.
> >> >>>>
> >> >>>> Shouldn't the ACPI tables be migrated to use valid pointers?
> >> >>>
> >> >>> The confusion arises due to the difference between addresses and
> >> >>> pointers. If we store addresses in the ACPI tables, then things sh=
ould
> >> >>> work.
> >> >>>
> >> >>> My approach has been to avoid using casts, but instead use
> >> >>> map_sysmem() and mem_to_sysmem().
> >> >>>
> >> >>> Which particular piece of code is wrong in this case?
> >> >>
> >> >> Tables DSDT, XSDT, RSDP, FADT in the sandbox contain sandbox virtua=
l
> >> >> addresses instead of pointers to real host memory.
> >> >>
> >> >> All code referring to these tables should be changed.433:          =
                  *gnvs =3D map_to_sysmem(ctx->current);
> >> >
> >> > I'm still not quite clear on this...can you point to functions or
> >> > lines of code? When I look at acpi_add_table() it does use memmap, b=
ut
> >> > perhaps some parts are wrong?
> >> >
> >> > Regards,
> >> > Simon
> >>
> >> Here are some examples where the wrong values are set. We must get rid
> >> of all map_to_sysmem() calls where writing ACPI tables.
> >>
> >> lib/acpi/acpi_table.c:
> >> 170         rsdt->entry[i] =3D map_to_sysmem(table);
> >> 188         xsdt->entry[i] =3D map_to_sysmem(table);
> >>
> >> lib/acpi/base.c:
> >> 27:             rsdp->rsdt_address =3D map_to_sysmem(rsdt);
> >> 30:             rsdp->xsdt_address =3D map_to_sysmem(xsdt);
> >>
> >> arch/x86/cpu/baytrail/acpi.c:
> >> 81:     fadt->x_firmware_ctrl =3D map_to_sysmem(ctx->facs);
> >> 82:     fadt->x_dsdt =3D map_to_sysmem(ctx->dsdt);
> >>
> >> arch/x86/cpu/quark/acpi.c:
> >> 76:     fadt->x_firmware_ctrl =3D map_to_sysmem(ctx->facs);
> >> 77:     fadt->x_dsdt =3D map_to_sysmem(ctx->dsdt);
> >>
> >> arch/x86/cpu/tangier/acpi.c:
> >> 47:     fadt->x_firmware_ctrl =3D map_to_sysmem(ctx->facs);
> >> 48:     fadt->x_dsdt =3D map_to_sysmem(ctx->dsdt);
> >>
> >> arch/x86/lib/acpi_table.c:
> >> 200:    tcpa->lasa =3D map_to_sysmem(log);
> >> 271:    tpm2->lasa =3D map_to_sysmem(lasa);
> >> 433:                            *gnvs =3D map_to_sysmem(ctx->current);
> >> 575:    fadt->x_firmware_ctrl =3D map_to_sysmem(facs);
> >> 576:    fadt->x_dsdt =3D map_to_sysmem(dsdt);
> >
> >OK, I see. But at least within sandbox, the address is what we want to
> >store, not the pointer. Are you worried about what an EFI app will do
> >in that case, when we run an app from sandbox? If so, then yes it is
> >definitely a problem.
> >
> >Regards,
> >Simon
>
> The sandbox is an environment to run EFI binaries inside an OS. So the AC=
PI tables must contain pointers.
>
> The acpi command should display sandbox virtual addresses. All conversion=
s should be moved to the command.

OK, it makes sense to me. For sandbox we want addresses, but in this
case (with an external program using the addresses) we are going to
have to use pointers cast to addresses.

Regards,
Simon
