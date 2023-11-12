Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C89DDC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 20:06:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2D46874CA;
	Sun, 12 Nov 2023 21:03:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MSxAxnI5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 713018748C; Sun, 12 Nov 2023 21:03:39 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7190A870EE
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 21:03:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5a7d9d357faso41847347b3.0
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 12:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699819413; x=1700424213; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uq8ICsSbp/Qhjg2H40XVHrHCtvP3ejOutjHjXDWlhiw=;
 b=MSxAxnI5VaBiEwa2MZ20Qj5jnUxMi5ORGkmHiBJXtyiDpcWifWP+4qMk5f2DIjz4ox
 ixwJFiMuv+Zopa6rApMkj0Q5/vFnDbAB2BFeu/8C6GRq5lC2KG3xQ1JiTLwcXvViLPAA
 51tyQplmw/QglGBPrGQcBTJts8uKXlFRofMug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699819413; x=1700424213;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uq8ICsSbp/Qhjg2H40XVHrHCtvP3ejOutjHjXDWlhiw=;
 b=baqVF94eZT05OvsHdksGghHBXT0BKkcI3rwYGgzVV6dS5GZx0TYb1PIytpB8uA6JCv
 BoC41BlDoOXGLePdgpKX8xwR2phoEjo/Ed7Pd0EBRKu9RvFNnSavxPO03ua++/9t0B7E
 T45heDRsUrYRNAga1xSwv9Csq4JoHklDnRK53CvFd/F+Yrm6PW848KlVM0NaWu7xPq2w
 +1G18LyPHqaOxFaCpJvaVbWiu4BRZ8fT9QhFlu9/7QD+ITY8VbpjBs9GXqyTkfTRAYWd
 ydVHvu7+46hgx5zLfSC0mpcgI8aqLHRyXjWlECC48QUCFV0D7DBFpG+2npqGU4nnPRUy
 A06A==
X-Gm-Message-State: AOJu0YwMYMy+3/JRfEKp8G0CKLDreIawZcqLBqHRWu9cRYgVYFyVRiue
 JvQa6s3dd5qdUDTc6xnS1TJBMhBS8FOsvRzk+XQ5azmksyhwcNbGXFA=
X-Google-Smtp-Source: AGHT+IEKIm4vCLyPoZeUaKoNBL4VbnC8VjZqIQGTAz93Al+ac1Lvyle5HsZ2Q92ZJKYfkGRYOfP1349cimU2isQl7hU=
X-Received: by 2002:a81:a1d7:0:b0:5b3:b17d:190f with SMTP id
 y206-20020a81a1d7000000b005b3b17d190fmr5395112ywg.29.1699819413060; Sun, 12
 Nov 2023 12:03:33 -0800 (PST)
MIME-Version: 1.0
References: <20231111142846.180442-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231111142846.180442-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 12 Nov 2023 13:01:32 -0700
Message-ID: <CAPnjgZ0J+HDnEh+pHJCZNsqqhwP33Xi+8=rUOJPG1m1WBXU+9g@mail.gmail.com>
Subject: Re: [PATCH 1/1] acpi: cannot have RSDT above 4 GiB
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
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

On Sat, 11 Nov 2023 at 07:28, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The field RsdtAddress has only 32 bit. The RSDT table cannot be located
> beyond 4 GiB.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/acpi/base.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

nits / question below

>
> diff --git a/lib/acpi/base.c b/lib/acpi/base.c
> index 2057bd2bef..128a76ad39 100644
> --- a/lib/acpi/base.c
> +++ b/lib/acpi/base.c
> @@ -21,10 +21,17 @@ void acpi_write_rsdp(struct acpi_rsdp *rsdp, struct acpi_rsdt *rsdt,
>         memcpy(rsdp->signature, RSDP_SIG, 8);
>         memcpy(rsdp->oem_id, OEM_ID, 6);
>
> -       rsdp->length = sizeof(struct acpi_rsdp);
> -       rsdp->rsdt_address = map_to_sysmem(rsdt);
> +       if (rsdt)
> +               rsdp->rsdt_address = map_to_sysmem(rsdt);
> +       else
> +               rsdp->rsdt_address = 0;

There is a memset() at the top so this line (and the one below) should
not be needed.

> +
> +       if (xsdt)
> +               rsdp->xsdt_address = map_to_sysmem(xsdt);
> +       else
> +               rsdp->xsdt_address = 0;
>
> -       rsdp->xsdt_address = map_to_sysmem(xsdt);
> +       rsdp->length = sizeof(struct acpi_rsdp);
>         rsdp->revision = ACPI_RSDP_REV_ACPI_2_0;
>
>         /* Calculate checksums */
> @@ -68,11 +75,15 @@ static void acpi_write_xsdt(struct acpi_xsdt *xsdt)
>  static int acpi_write_base(struct acpi_ctx *ctx,
>                            const struct acpi_writer *entry)
>  {
> -       /* We need at least an RSDP and an RSDT Table */
> +       /* We need at least an RSDP and an XSDT Table */
>         ctx->rsdp = ctx->current;
>         acpi_inc_align(ctx, sizeof(struct acpi_rsdp));
> -       ctx->rsdt = ctx->current;
> -       acpi_inc_align(ctx, sizeof(struct acpi_rsdt));
> +       if (map_to_sysmem(ctx->current) < UINT_MAX - 0x10000) {

Won't that do something different on 64-bit machines? It seems that
you want to check against SZ_4G ?

> +               ctx->rsdt = ctx->current;
> +               acpi_inc_align(ctx, sizeof(struct acpi_rsdt));
> +       } else {
> +               ctx->rsdt = 0;
> +       }
>         ctx->xsdt = ctx->current;
>         acpi_inc_align(ctx, sizeof(struct acpi_xsdt));
>
> @@ -80,7 +91,8 @@ static int acpi_write_base(struct acpi_ctx *ctx,
>         memset(ctx->base, '\0', ctx->current - ctx->base);
>
>         acpi_write_rsdp(ctx->rsdp, ctx->rsdt, ctx->xsdt);
> -       acpi_write_rsdt(ctx->rsdt);
> +       if (ctx->rsdt)
> +               acpi_write_rsdt(ctx->rsdt);
>         acpi_write_xsdt(ctx->xsdt);
>
>         return 0;
> --
> 2.40.1
>

Regards,
Simon
