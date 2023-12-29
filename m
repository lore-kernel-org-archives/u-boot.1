Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A82C46CD3
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 14:31:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7291C87A3B;
	Fri, 29 Dec 2023 15:31:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O+NE8bD/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2579A87A54; Fri, 29 Dec 2023 15:31:40 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC4CC879F6
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 15:31:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3b9f727d94cso2602211b6e.1
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 06:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703860295; x=1704465095; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P4lN6vsyG0ehQpxJjVVUPds4M++1yaNJOuruVuqywiw=;
 b=O+NE8bD/y1qKamWL7TmPnB85V4ncG17UFQCU8TdOGwFDTXYC3rHvh8NwTjAjwFemTV
 +h7/W7A1lkHl7NTXkORwy7eUL/i8G1pTct4vZFPrvdyrHysgvPqW8sWPQh9wvka8TXzi
 UTWcbzLD9IuWXgxIrturrjRPlh/xZPt8w3WdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703860295; x=1704465095;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P4lN6vsyG0ehQpxJjVVUPds4M++1yaNJOuruVuqywiw=;
 b=ZqjtM6XCHmssxRs97yHmGmBosGyY1rY4PayfujjPZCAfrq+VAFMh0RC1l1w5CCzMgs
 uGHA4PgIvAOpLQ1e2RsI5h4yFEPLHRyfHN5pI2RTGmd9CtCJ/ExrzOdxZErU24ufomlG
 zEvh+87MaJSQ77y84kErkLvd2I3HjqI5WCkRa42pT2QdbK3nV2kxILx7izMubKkk8yeg
 CuZec12UWcVv2Y57NyJIHDaihMv+hX4vXyT0iDjOGwWepmT0kyIW9kgv4LU+/vfGOvxP
 fZAihUFb2Dvw6UmY+B5EFayBVTYofHbYYpP5qWoLvRyDlnvBtwRPyVCZGormu6wYKy8C
 OFLg==
X-Gm-Message-State: AOJu0Yy3AR+xJC7cCpxNIkeMXhPhJqG6YL1JdieUTTq7XJTr1H1Bs0T+
 K0dhsOaxvragDvkVEmZHfTDSFJM/HE+I0XVtz0jM32y+ddtV
X-Google-Smtp-Source: AGHT+IGgSBX3wJFU337Y71KXYWdETtsiVZJl10notW2m0pgklmvIzi8YO5dBlgxeEMtk18s9hXInMTCiQYB5PbEHBuk=
X-Received: by 2002:a05:6808:152c:b0:3b8:b063:8938 with SMTP id
 u44-20020a056808152c00b003b8b0638938mr6762495oiw.70.1703860295410; Fri, 29
 Dec 2023 06:31:35 -0800 (PST)
MIME-Version: 1.0
References: <9f681497-d13c-4ccc-9209-7a8b33e3195c@gmx.de>
 <CAFLszThsThxhWCgP+UHmA5BxRUUBfDP7SDahtAm5WOrHoT0xhQ@mail.gmail.com>
 <e9a835ea-ea99-4db2-b5ad-ba7742397d46@gmx.de>
 <CAFLszTg17_xPGWMDG=1X+q2UTdJ_kO2pUshmDLt+cv9uPPcgJg@mail.gmail.com>
 <08e7b3cc-9588-46ab-844e-6edbe1154e43@gmx.de>
In-Reply-To: <08e7b3cc-9588-46ab-844e-6edbe1154e43@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 29 Dec 2023 14:31:24 +0000
Message-ID: <CAFLszTj1npgL8F0H2prS_iBS-Kj2p+-Ena_ccQSe4dXPLGAM7w@mail.gmail.com>
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

On Fri, Dec 29, 2023 at 11:14=E2=80=AFAM Heinrich Schuchardt <xypron.glpk@g=
mx.de> wrote:
>
> On 12/29/23 09:26, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Tue, Dec 26, 2023 at 10:03=E2=80=AFAM Heinrich Schuchardt <xypron.gl=
pk@gmx.de> wrote:
> >>
> >> On 12/26/23 10:50, Simon Glass wrote:
> >>> Hi Heinrich,
> >>>
> >>> On Tue, Dec 26, 2023 at 8:56=E2=80=AFAM Heinrich Schuchardt <xypron.g=
lpk@gmx.de> wrote:
> >>>>
> >>>> Hello Simon,
> >>>>
> >>>> currently we use sandbox virtual addresses in all ACPI tables. This
> >>>> means that an application started by the U-Boot sandbox consuming th=
ese
> >>>> tables will crash due to accessing invalid addresses.
> >>>>
> >>>> Shouldn't the ACPI tables be migrated to use valid pointers?
> >>>
> >>> The confusion arises due to the difference between addresses and
> >>> pointers. If we store addresses in the ACPI tables, then things shoul=
d
> >>> work.
> >>>
> >>> My approach has been to avoid using casts, but instead use
> >>> map_sysmem() and mem_to_sysmem().
> >>>
> >>> Which particular piece of code is wrong in this case?
> >>
> >> Tables DSDT, XSDT, RSDP, FADT in the sandbox contain sandbox virtual
> >> addresses instead of pointers to real host memory.
> >>
> >> All code referring to these tables should be changed.433:             =
               *gnvs =3D map_to_sysmem(ctx->current);
> >
> > I'm still not quite clear on this...can you point to functions or
> > lines of code? When I look at acpi_add_table() it does use memmap, but
> > perhaps some parts are wrong?
> >
> > Regards,
> > Simon
>
> Here are some examples where the wrong values are set. We must get rid
> of all map_to_sysmem() calls where writing ACPI tables.
>
> lib/acpi/acpi_table.c:
> 170         rsdt->entry[i] =3D map_to_sysmem(table);
> 188         xsdt->entry[i] =3D map_to_sysmem(table);
>
> lib/acpi/base.c:
> 27:             rsdp->rsdt_address =3D map_to_sysmem(rsdt);
> 30:             rsdp->xsdt_address =3D map_to_sysmem(xsdt);
>
> arch/x86/cpu/baytrail/acpi.c:
> 81:     fadt->x_firmware_ctrl =3D map_to_sysmem(ctx->facs);
> 82:     fadt->x_dsdt =3D map_to_sysmem(ctx->dsdt);
>
> arch/x86/cpu/quark/acpi.c:
> 76:     fadt->x_firmware_ctrl =3D map_to_sysmem(ctx->facs);
> 77:     fadt->x_dsdt =3D map_to_sysmem(ctx->dsdt);
>
> arch/x86/cpu/tangier/acpi.c:
> 47:     fadt->x_firmware_ctrl =3D map_to_sysmem(ctx->facs);
> 48:     fadt->x_dsdt =3D map_to_sysmem(ctx->dsdt);
>
> arch/x86/lib/acpi_table.c:
> 200:    tcpa->lasa =3D map_to_sysmem(log);
> 271:    tpm2->lasa =3D map_to_sysmem(lasa);
> 433:                            *gnvs =3D map_to_sysmem(ctx->current);
> 575:    fadt->x_firmware_ctrl =3D map_to_sysmem(facs);
> 576:    fadt->x_dsdt =3D map_to_sysmem(dsdt);

OK, I see. But at least within sandbox, the address is what we want to
store, not the pointer. Are you worried about what an EFI app will do
in that case, when we run an app from sandbox? If so, then yes it is
definitely a problem.

Regards,
Simon
