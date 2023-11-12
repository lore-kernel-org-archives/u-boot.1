Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 955B2C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 21:23:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC471871D7;
	Sun, 12 Nov 2023 22:23:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MhNW9zLK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71B75871DE; Sun, 12 Nov 2023 22:23:36 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95D75871CF
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 22:23:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9de7a43bd1aso545046266b.3
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 13:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699824214; x=1700429014; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5GXwIF4XRYw+xUTiClQ+eEnVJwG/sKT4tclD15nPtS0=;
 b=MhNW9zLKZ6FyD+P5tqM6QkBnEBlFeip6SlpfZF+rnk2q9VuqZ05RQQNoepqK57TfXd
 DNsIyMpzen4k2DdGDwS+xuKoyLDrrsCImLtTxz+QcTHG4aBpWRFvoTT+jyWjSNkj+3t6
 Zxt2y5Msv4+TH7d1ZMo/uG2TfngbyZaG+b/Yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699824214; x=1700429014;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5GXwIF4XRYw+xUTiClQ+eEnVJwG/sKT4tclD15nPtS0=;
 b=BVIWp/P7G3ZsspqJxQ7bytOUA+jGEeOT+wzwdwzFPg/whW1qPevmY2BiEWDWTl2MOO
 kZHNkwZsiyPPU6qvaxANGVn1R4rphTdj3aILE8zrIyngr1DngtUgZ6ma+ZsdGFdKWwRQ
 Tl1ik0wRsQAneeArz15W1yEyui9KxMBl5RRzFAx1oswTyqJbN9FwO8PdUWxyDvp5CIYq
 kC3N75VwRMzoyAuY2mIJ0Zu2qqGr7rGCOKBLiQAXi49ccX0W/v9osV0kYN1DxhmUQ8X/
 NoxCHbAqZcdieeQstrhD1788ArnfNGJAaFdQNmIxseF2VtyD9GPxQmCD2FW23j4RHzqh
 PL8A==
X-Gm-Message-State: AOJu0YzaHi5BgTZZUquCmYHqrtni5Vxwyeou3WIbz6fPTCXRxXou70Fr
 Pvmvr/Bta9nSlJ53lYRKnSe2EXZDd4i8OxHvS8k9My449L3m7KXo6LQ=
X-Google-Smtp-Source: AGHT+IGuREFY9WPfaFzA4ISRlrWacv8REpnCtAn0VSgl0x3LO1cgAKERT0e3oY71leHroHd81rs1+R/GOvrIRmwA3M4=
X-Received: by 2002:a17:906:2587:b0:9dd:7133:881 with SMTP id
 m7-20020a170906258700b009dd71330881mr3865582ejb.40.1699824213925; Sun, 12 Nov
 2023 13:23:33 -0800 (PST)
MIME-Version: 1.0
References: <20231111142846.180442-1-heinrich.schuchardt@canonical.com>
 <CAPnjgZ0J+HDnEh+pHJCZNsqqhwP33Xi+8=rUOJPG1m1WBXU+9g@mail.gmail.com>
 <CAM=mAOmhuBM-uN=ioZXP5TmAhMnO4Y80koxKYm0CF9nxfbWBhA@mail.gmail.com>
In-Reply-To: <CAM=mAOmhuBM-uN=ioZXP5TmAhMnO4Y80koxKYm0CF9nxfbWBhA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 12 Nov 2023 14:23:22 -0700
Message-ID: <CAPnjgZ1MTt=SkPshR22HW9HFAk4xmtE7tg=p08yNg+WFU=A7UQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] acpi: cannot have RSDT above 4 GiB
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Sun, 12 Nov 2023 at 13:16, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
>
>
> Simon Glass <sjg@chromium.org> schrieb am So., 12. Nov. 2023, 21:03:
>>
>> Hi Heinrich,
>>
>> On Sat, 11 Nov 2023 at 07:28, Heinrich Schuchardt
>> <heinrich.schuchardt@canonical.com> wrote:
>> >
>> > The field RsdtAddress has only 32 bit. The RSDT table cannot be located
>> > beyond 4 GiB.
>> >
>> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> > ---
>> >  lib/acpi/base.c | 26 +++++++++++++++++++-------
>> >  1 file changed, 19 insertions(+), 7 deletions(-)
>>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>
>> nits / question below
>>
>> >
>> > diff --git a/lib/acpi/base.c b/lib/acpi/base.c
>> > index 2057bd2bef..128a76ad39 100644
>> > --- a/lib/acpi/base.c
>> > +++ b/lib/acpi/base.c
>> > @@ -21,10 +21,17 @@ void acpi_write_rsdp(struct acpi_rsdp *rsdp, struct acpi_rsdt *rsdt,
>> >         memcpy(rsdp->signature, RSDP_SIG, 8);
>> >         memcpy(rsdp->oem_id, OEM_ID, 6);
>> >
>> > -       rsdp->length = sizeof(struct acpi_rsdp);
>> > -       rsdp->rsdt_address = map_to_sysmem(rsdt);
>> > +       if (rsdt)
>> > +               rsdp->rsdt_address = map_to_sysmem(rsdt);
>> > +       else
>> > +               rsdp->rsdt_address = 0;
>>
>> There is a memset() at the top so this line (and the one below) should
>> not be needed.
>>
>> > +
>> > +       if (xsdt)
>> > +               rsdp->xsdt_address = map_to_sysmem(xsdt);
>> > +       else
>> > +               rsdp->xsdt_address = 0;
>> >
>> > -       rsdp->xsdt_address = map_to_sysmem(xsdt);
>> > +       rsdp->length = sizeof(struct acpi_rsdp);
>> >         rsdp->revision = ACPI_RSDP_REV_ACPI_2_0;
>> >
>> >         /* Calculate checksums */
>> > @@ -68,11 +75,15 @@ static void acpi_write_xsdt(struct acpi_xsdt *xsdt)
>> >  static int acpi_write_base(struct acpi_ctx *ctx,
>> >                            const struct acpi_writer *entry)
>> >  {
>> > -       /* We need at least an RSDP and an RSDT Table */
>> > +       /* We need at least an RSDP and an XSDT Table */
>> >         ctx->rsdp = ctx->current;
>> >         acpi_inc_align(ctx, sizeof(struct acpi_rsdp));
>> > -       ctx->rsdt = ctx->current;
>> > -       acpi_inc_align(ctx, sizeof(struct acpi_rsdt));
>> > +       if (map_to_sysmem(ctx->current) < UINT_MAX - 0x10000) {
>>
>> Won't that do something different on 64-bit machines? It seems that
>> you want to check against SZ_4G ?
>
>
> For gcc int is 32bit on 64bit systems, so is UINT_MAX. Using SZ_4G could make this code clearer.

Oh I didn't know that...I just assumed that uint would be 64-bit on a
64-machine machine, since it is the natural reg size! Yes, that is
very very confusing. I vaguely recall some compiler setting for that
and that Linux did it a particular way.

>
> Best regards
>
> Heinrich
>
>
>>
>> > +               ctx->rsdt = ctx->current;
>> > +               acpi_inc_align(ctx, sizeof(struct acpi_rsdt));
>> > +       } else {
>> > +               ctx->rsdt = 0;
>> > +       }
>> >         ctx->xsdt = ctx->current;
>> >         acpi_inc_align(ctx, sizeof(struct acpi_xsdt));
>> >
>> > @@ -80,7 +91,8 @@ static int acpi_write_base(struct acpi_ctx *ctx,
>> >         memset(ctx->base, '\0', ctx->current - ctx->base);
>> >
>> >         acpi_write_rsdp(ctx->rsdp, ctx->rsdt, ctx->xsdt);
>> > -       acpi_write_rsdt(ctx->rsdt);
>> > +       if (ctx->rsdt)
>> > +               acpi_write_rsdt(ctx->rsdt);
>> >         acpi_write_xsdt(ctx->xsdt);
>> >
>> >         return 0;
>> > --
>> > 2.40.1
>> >
>>
>> Regards,
>> Simon
