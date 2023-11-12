Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B62C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 20:16:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09978870F2;
	Sun, 12 Nov 2023 21:16:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="GKEdVYDf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1C3F87103; Sun, 12 Nov 2023 21:16:43 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBB8D87006
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 21:16:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 568383FADA
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 20:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1699820201;
 bh=Iu27ZMzWfGHgC55JKxtcLcEZtLtbi55MOvAb99Vs88A=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=GKEdVYDfCrbl7ujo3PBuwGKEmUbYQU6GzFJ5OtMiEdpxhjhVO2SThX750GfW3Td4J
 nAn9/XZsAtN9usxaGrrov8YXq+ZkmglxFVqmSW5DL9fprCTH38iIMdLDYnPFAtin/m
 NGi2JHnEOv0B2HMJ8moGreEL2dY2xKruVNj94Sx1FTUfMdDIYeqa3K2Yhs5NHCPUUz
 y/mejj9lwfThiROGNVimGjGG27z8hPFf3cwteIvGShQoMV94Mpm4Rfy5t8Dy2vSTe6
 VlR3L4KVo4oRJwviWCHxdJ5F52DfCPMoqPakEgfNWSr1KI2WBXxGspQr+DamHyvunZ
 hypOvu2UY7RmA==
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-7baaa38761bso1132281241.3
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 12:16:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699820200; x=1700425000;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Iu27ZMzWfGHgC55JKxtcLcEZtLtbi55MOvAb99Vs88A=;
 b=W3y6ZDNTej5I+7tufMHE6uINEHuenrvyDsCtbcN+tegCpOLKllQtMLXnCpsEHrJzOK
 fbK9lXuufg0mq2A1gdoX13K52qAaHTDsztvQZwh1ST9fuT3KRIxFaqQJ9CyBdCAJq+1P
 5HSV9LduP1WX0WsalxEEb/Hayh6un/XFRKZnB1UUZkwTUnwBfv+xVmiD6LBPxYSI30DW
 AOIt5dgTha5TnImFQyJBZHc1WCSNuQMVwG64rgW9ninjkun8ZJbU3cLzy8kKqInYahtj
 pg/IIg0SiNJkjudDFJpnn/sjMBSKV9IQx6GxtjRDeW0G1tI/zBDIhpuEKo4cKtmyGKW5
 wKeQ==
X-Gm-Message-State: AOJu0YxVPygO6f3ReOg3gv7moWsfy3AcjConOpqlZtZDhtBdBvIAmCpE
 9z5bwwXaqgaQ8QaWpJ8YwouakzmpQGLuvZ3RbeXPkSeOjN2Tkzyi2oh1q7oSL4L5xVVccOPe3ae
 TF86lBXk2LuEfX1tvV6/Abm/zhOkNkTiDEc/TV8stONHpSSQ=
X-Received: by 2002:a05:6102:298a:b0:45f:a41:b405 with SMTP id
 dl10-20020a056102298a00b0045f0a41b405mr4040242vsb.21.1699820200112; 
 Sun, 12 Nov 2023 12:16:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzcXL5/gcE2g74QXm9QvM5uIFfFU8rPjqnaAE5dM06lrTrqLcRKLE9pWeuly+EQemsgarRum4jIeBd90hi4N0=
X-Received: by 2002:a05:6102:298a:b0:45f:a41:b405 with SMTP id
 dl10-20020a056102298a00b0045f0a41b405mr4040238vsb.21.1699820199837; Sun, 12
 Nov 2023 12:16:39 -0800 (PST)
MIME-Version: 1.0
References: <20231111142846.180442-1-heinrich.schuchardt@canonical.com>
 <CAPnjgZ0J+HDnEh+pHJCZNsqqhwP33Xi+8=rUOJPG1m1WBXU+9g@mail.gmail.com>
In-Reply-To: <CAPnjgZ0J+HDnEh+pHJCZNsqqhwP33Xi+8=rUOJPG1m1WBXU+9g@mail.gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Date: Sun, 12 Nov 2023 21:16:28 +0100
Message-ID: <CAM=mAOmhuBM-uN=ioZXP5TmAhMnO4Y80koxKYm0CF9nxfbWBhA@mail.gmail.com>
Subject: Re: [PATCH 1/1] acpi: cannot have RSDT above 4 GiB
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Simon Glass <sjg@chromium.org> schrieb am So., 12. Nov. 2023, 21:03:

> Hi Heinrich,
>
> On Sat, 11 Nov 2023 at 07:28, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > The field RsdtAddress has only 32 bit. The RSDT table cannot be located
> > beyond 4 GiB.
> >
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> >  lib/acpi/base.c | 26 +++++++++++++++++++-------
> >  1 file changed, 19 insertions(+), 7 deletions(-)
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> nits / question below
>
> >
> > diff --git a/lib/acpi/base.c b/lib/acpi/base.c
> > index 2057bd2bef..128a76ad39 100644
> > --- a/lib/acpi/base.c
> > +++ b/lib/acpi/base.c
> > @@ -21,10 +21,17 @@ void acpi_write_rsdp(struct acpi_rsdp *rsdp, struct
> acpi_rsdt *rsdt,
> >         memcpy(rsdp->signature, RSDP_SIG, 8);
> >         memcpy(rsdp->oem_id, OEM_ID, 6);
> >
> > -       rsdp->length = sizeof(struct acpi_rsdp);
> > -       rsdp->rsdt_address = map_to_sysmem(rsdt);
> > +       if (rsdt)
> > +               rsdp->rsdt_address = map_to_sysmem(rsdt);
> > +       else
> > +               rsdp->rsdt_address = 0;
>
> There is a memset() at the top so this line (and the one below) should
> not be needed.
>
> > +
> > +       if (xsdt)
> > +               rsdp->xsdt_address = map_to_sysmem(xsdt);
> > +       else
> > +               rsdp->xsdt_address = 0;
> >
> > -       rsdp->xsdt_address = map_to_sysmem(xsdt);
> > +       rsdp->length = sizeof(struct acpi_rsdp);
> >         rsdp->revision = ACPI_RSDP_REV_ACPI_2_0;
> >
> >         /* Calculate checksums */
> > @@ -68,11 +75,15 @@ static void acpi_write_xsdt(struct acpi_xsdt *xsdt)
> >  static int acpi_write_base(struct acpi_ctx *ctx,
> >                            const struct acpi_writer *entry)
> >  {
> > -       /* We need at least an RSDP and an RSDT Table */
> > +       /* We need at least an RSDP and an XSDT Table */
> >         ctx->rsdp = ctx->current;
> >         acpi_inc_align(ctx, sizeof(struct acpi_rsdp));
> > -       ctx->rsdt = ctx->current;
> > -       acpi_inc_align(ctx, sizeof(struct acpi_rsdt));
> > +       if (map_to_sysmem(ctx->current) < UINT_MAX - 0x10000) {
>
> Won't that do something different on 64-bit machines? It seems that
> you want to check against SZ_4G ?
>

For gcc int is 32bit on 64bit systems, so is UINT_MAX. Using SZ_4G could
make this code clearer.

Best regards

Heinrich



> > +               ctx->rsdt = ctx->current;
> > +               acpi_inc_align(ctx, sizeof(struct acpi_rsdt));
> > +       } else {
> > +               ctx->rsdt = 0;
> > +       }
> >         ctx->xsdt = ctx->current;
> >         acpi_inc_align(ctx, sizeof(struct acpi_xsdt));
> >
> > @@ -80,7 +91,8 @@ static int acpi_write_base(struct acpi_ctx *ctx,
> >         memset(ctx->base, '\0', ctx->current - ctx->base);
> >
> >         acpi_write_rsdp(ctx->rsdp, ctx->rsdt, ctx->xsdt);
> > -       acpi_write_rsdt(ctx->rsdt);
> > +       if (ctx->rsdt)
> > +               acpi_write_rsdt(ctx->rsdt);
> >         acpi_write_xsdt(ctx->xsdt);
> >
> >         return 0;
> > --
> > 2.40.1
> >
>
> Regards,
> Simon
>
