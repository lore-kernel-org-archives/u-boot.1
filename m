Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A7AEE644D
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 06:17:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3C8388DDF;
	Thu, 12 Sep 2024 08:17:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="PT7yvfMA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3992888DDF; Thu, 12 Sep 2024 08:17:26 +0200 (CEST)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E95D588D85
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 08:17:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e1a7d43a226so590886276.3
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 23:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726121843; x=1726726643; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QNGTNojmxv5+U4EWjndLIRwNbTjheIoglKQ1X1BMKfo=;
 b=PT7yvfMAEF0+eitiVrFg2ZYqitHAvqiblHnhpeq19mkhbDtJVTdtuB8hDOd8T2Ai+R
 YHbT/68I7auuXfrx+x2LmnR7fxfQKV+fYtGbq6jhD28dHUwq9HXpSwWtwdSdtaHQpuvH
 JkvYL5/ledj19HEyXMnMRRTGHLW2yHyPnagOteK6YDClRaJI1lR+fMd4zcMeesDdqALs
 y5KPmWxxE2MCvv7UkP2QWoypH+YtvpNyT3SCNOIOPGUb5VIbB7ZOXQ78U4NO+Lx3Mohs
 vyE/lB+Mhm85NTtJQhgqu4r959iJ0GzvsZnvkn8abBANw+yQ62v9ZKLUv0zlWy0g4puC
 kRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726121843; x=1726726643;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QNGTNojmxv5+U4EWjndLIRwNbTjheIoglKQ1X1BMKfo=;
 b=WroPF8Eu3niPS/uAFCNYdVFhhq5+V9EYdwPhFzbDZdAd8+6Z7GOq5lWcvo84OBUqjF
 2AybS5nEszdVUxziuliUt/rCa7AlEaxk9vXsP4fnDhe4PHL3WicDsgCrDf2q8yG1Dsnx
 GOYluaGwCMjXiJFcerlEGQdbbD0mMEIv9+GUc4v+yhwXCZsZC1ktXSBbt1RjyfRTxlaG
 YqEuBhPkEbi4Y3PewGzl3dPSFKoPdYL1x6TcRgFdmsal0rMRaNMa5JMo70KqtBPJ8Lqi
 yH1MSaG5IW2OUxF/rdwsAMCaTDB6QFx3qM62818jpDIvGiAxvf4jMcfQAi8zqyKNpp3E
 LeVA==
X-Gm-Message-State: AOJu0YwayYyZ1USmV9B6dHkffSoVmgq+v24H3c4AW2RnrEFa5zu4+8dh
 Uy0ac2a6Uj9BRdENdGz9wPd4LfCUJ8vL7sJ1ljq6ETM598hg9ikCQfZ3wDqkpgcZteZtRaupUQB
 yR2FMtz8dvk30UCJRdD4olkJNl/5sqIiR9/CFfQ==
X-Google-Smtp-Source: AGHT+IGAfDSSH/WyLKMmt99Th6kuKVBL/cgBYFooOBOcbtUKrclcDQo9RL2fwWWvCE4VbP0mliVhfmOxyQQp9A2XX3k=
X-Received: by 2002:a05:6902:cc1:b0:e1b:dc38:1a8c with SMTP id
 3f1490d57ef6-e1d9dc3cb25mr1339297276.43.1726121842741; Wed, 11 Sep 2024
 23:17:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-14-patrick.rudolph@9elements.com>
 <CALeDE9O6fbvfjyqcd32vo6SYBy9OUm+xfz9DV7akiGRS9jGNCg@mail.gmail.com>
In-Reply-To: <CALeDE9O6fbvfjyqcd32vo6SYBy9OUm+xfz9DV7akiGRS9jGNCg@mail.gmail.com>
From: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Thu, 12 Sep 2024 08:17:11 +0200
Message-ID: <CALNFmy1JyAgvrozo3Cw7i5a_0SitvOSyTxWeCNC4as3Ts1ZQQQ@mail.gmail.com>
Subject: Re: [PATCH v3 13/30] acpi: acpi_table: Support ACPI 2.0 platforms
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
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

On Wed, Sep 11, 2024 at 11:46=E2=80=AFAM Peter Robinson <pbrobinson@gmail.c=
om> wrote:
>
> > On platforms that do not have usable DRAM below 4GiB, like QEMU sbsa,
> > the RSDT cannot be used. Allow both RSDT and XSDT to be null and only
> > fill those tables that are present in acpi_add_table().
>
> I'm not sure what ACPI 2.0 from the subject has to do with the above,
> eg ACPI only started supporting aarch64 with ACPI 5.1
>
The change is unrelated to the architecture. ACPI 2.0 made XSDT mandatory a=
nd
RSDT optional. Since x86 is backwards compatible and always had memory belo=
w
4GiB, tables would always fit into RSDT and XSDT, but on platforms where ta=
bles
are stored above 4GiB the address would not fit into RSDT, only in XSDT.

I'll update the commit message to better explain why this change was done.

> > Fixes a crash on QEMU sbsa.
> >
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > Cc: Simon Glass <sjg@chromium.org>
> > Cc: Tom Rini <trini@konsulko.com>
> > ---
> >  lib/acpi/acpi_table.c | 95 ++++++++++++++++++++++++++-----------------
> >  1 file changed, 57 insertions(+), 38 deletions(-)
> >
> > diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
> > index 4f5cfe522c..8aab41212a 100644
> > --- a/lib/acpi/acpi_table.c
> > +++ b/lib/acpi/acpi_table.c
> > @@ -157,51 +157,70 @@ int acpi_add_table(struct acpi_ctx *ctx, void *ta=
ble)
> >         struct acpi_rsdt *rsdt;
> >         struct acpi_xsdt *xsdt;
> >
> > -       /* The RSDT is mandatory while the XSDT is not */
> > -       rsdt =3D ctx->rsdt;
> > -
> > -       /* This should always be MAX_ACPI_TABLES */
> > -       entries_num =3D ARRAY_SIZE(rsdt->entry);
> > -
> > -       for (i =3D 0; i < entries_num; i++) {
> > -               if (rsdt->entry[i] =3D=3D 0)
> > -                       break;
> > -       }
> > -
> > -       if (i >=3D entries_num) {
> > -               log_err("ACPI: Error: too many tables\n");
> > -               return -E2BIG;
> > -       }
> > +       /* On legacy x86 platforms the RSDT is mandatory while the XSDT=
 is not.
> > +        * On other platforms there might be no memory below 4GiB, thus=
 RSDT is NULL.
> > +        */
> > +       if (ctx->rsdt) {
> > +               rsdt =3D ctx->rsdt;
> >
> > -       /* Add table to the RSDT */
> > -       rsdt->entry[i] =3D nomap_to_sysmem(table);
> > +               /* This should always be MAX_ACPI_TABLES */
> > +               entries_num =3D ARRAY_SIZE(rsdt->entry);
> >
> > -       /* Fix RSDT length or the kernel will assume invalid entries */
> > -       rsdt->header.length =3D sizeof(struct acpi_table_header) +
> > -                               (sizeof(u32) * (i + 1));
> > +               for (i =3D 0; i < entries_num; i++) {
> > +                       if (rsdt->entry[i] =3D=3D 0)
> > +                               break;
> > +               }
> >
> > -       /* Re-calculate checksum */
> > -       rsdt->header.checksum =3D 0;
> > -       rsdt->header.checksum =3D table_compute_checksum((u8 *)rsdt,
> > -                                                      rsdt->header.len=
gth);
> > +               if (i >=3D entries_num) {
> > +                       log_err("ACPI: Error: too many tables\n");
> > +                       return -E2BIG;
> > +               }
> >
> > -       /*
> > -        * And now the same thing for the XSDT. We use the same index a=
s for
> > -        * now we want the XSDT and RSDT to always be in sync in U-Boot
> > -        */
> > -       xsdt =3D ctx->xsdt;
> > +               /* Add table to the RSDT */
> > +               rsdt->entry[i] =3D nomap_to_sysmem(table);
> >
> > -       /* Add table to the XSDT */
> > -       xsdt->entry[i] =3D nomap_to_sysmem(table);
> > +               /* Fix RSDT length or the kernel will assume invalid en=
tries */
> > +               rsdt->header.length =3D sizeof(struct acpi_table_header=
) +
> > +                                       (sizeof(u32) * (i + 1));
> >
> > -       /* Fix XSDT length */
> > -       xsdt->header.length =3D sizeof(struct acpi_table_header) +
> > -                               (sizeof(u64) * (i + 1));
> > +               /* Re-calculate checksum */
> > +               rsdt->header.checksum =3D 0;
> > +               rsdt->header.checksum =3D table_compute_checksum((u8 *)=
rsdt,
> > +                                                              rsdt->he=
ader.length);
> > +       }
> >
> > -       /* Re-calculate checksum */
> > -       xsdt->header.checksum =3D 0;
> > -       xsdt->header.checksum =3D table_compute_checksum((u8 *)xsdt,
> > -                                                      xsdt->header.len=
gth);
> > +       if (ctx->xsdt) {
> > +               /*
> > +                * And now the same thing for the XSDT. We use the same=
 index as for
> > +                * now we want the XSDT and RSDT to always be in sync i=
n U-Boot
> > +                */
> > +               xsdt =3D ctx->xsdt;
> > +
> > +               /* This should always be MAX_ACPI_TABLES */
> > +               entries_num =3D ARRAY_SIZE(xsdt->entry);
> > +
> > +               for (i =3D 0; i < entries_num; i++) {
> > +                       if (xsdt->entry[i] =3D=3D 0)
> > +                               break;
> > +               }
> > +
> > +               if (i >=3D entries_num) {
> > +                       log_err("ACPI: Error: too many tables\n");
> > +                       return -E2BIG;
> > +               }
> > +
> > +               /* Add table to the XSDT */
> > +               xsdt->entry[i] =3D nomap_to_sysmem(table);
> > +
> > +               /* Fix XSDT length */
> > +               xsdt->header.length =3D sizeof(struct acpi_table_header=
) +
> > +                                       (sizeof(u64) * (i + 1));
> > +
> > +               /* Re-calculate checksum */
> > +               xsdt->header.checksum =3D 0;
> > +               xsdt->header.checksum =3D table_compute_checksum((u8 *)=
xsdt,
> > +                                                              xsdt->he=
ader.length);
> > +       }
> >
> >         return 0;
> >  }
> > --
> > 2.46.0
> >
