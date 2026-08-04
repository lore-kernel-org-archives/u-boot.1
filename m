Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CBDC55172
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 08:52:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 325A34070B;
	Tue,  4 Aug 2026 08:52:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NG5fjugqcLBZ; Tue,  4 Aug 2026 08:52:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8B0A9406A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785833533;
	bh=0sB6HifPjZb8aR37oJnpZjtcMxblBqBzHGZHxGjIYTQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W7wODBBFo+DgALzPrrX2/jkxRk3/isVrsM8HxYdW4HOvpLeGR6jvGMdTqcs6iFHL2
	 BJSafGf2OiXPx2ChskZ12+nCBbXWCwMvw+z43Be8B0dl54586eiKfnB1e3O8RdphrB
	 wO1IYfkvNL9dv2/OIXkoEgz/oJn8nyXvQzwxfz7uNFNiTuwaok8XslMR2TvWQ7qFtE
	 idr1CVchx7DQtnKL4sglyhNDN3KKoaJJCWhg8mYWH+czNPmtpFjCJxAlGSDiGAMQFq
	 EZV75cXJSCO7PqqRa4AVag/jVX9VH0q1b0HmzeGNHzwfUO1ullZPGCFKPSPmHuh5c2
	 20B1JaV9uzpZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B0A9406A0;
	Tue,  4 Aug 2026 08:52:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8ABE326C
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 08:52:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 746E26066D
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 08:52:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P0YXe3HVeGQA for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 08:52:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b131; helo=mail-yx1-xb131.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org CD6F360655
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CD6F360655
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com
 [IPv6:2607:f8b0:4864:20::b131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CD6F360655
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 08:52:10 +0000 (UTC)
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-664b05d408bso3782830d50.1
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 01:52:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785833529; cv=none;
 d=google.com; s=arc-20260327;
 b=A9Vx3KBxUWjlJNFU79FsSRTgX15TKySlH9DMvqTXDuv5UbyaH7hYOwvv2RRB6C3PUz
 XaLUyjzyhRJPpLHwuMQ82EY7zpQ+Z5aKJE4vuqwU904fU7Mta1wWtRt/jvGPtt1lHogG
 fSAdYdwcp8jQJyScQo/k5FLVdj5RF5AezQaQwsPX470av9saM706jD1O8HcTJtr2a+Za
 z44NHhZ/HFOjw0wC/B9VEunCQaEIcM6Etxkr5RYFg0+OIFfYHBo7Xs53lWZcxVJc7Xnx
 mW7KJvbcukCX6viLAcobdiiaxl1lEBtnE9rVokKpcQpSDQ65LzoW+AY2b0uQ2K9K+OiT
 g9xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0sB6HifPjZb8aR37oJnpZjtcMxblBqBzHGZHxGjIYTQ=;
 fh=ljxBvtK9pKLqimmAAFMeBw6hsHidow9/hJ3Jbv7MK0s=;
 b=MsqRIaIwDoU72spUOa/9oBnnKB8bKHz5KfuIAnx/iPTWGTFFXFoW1FE+QB5untvXVy
 IxjrxcWfp4941ea+Abkb8B/aoVHXT8+erqAk5E68HlpTRNAykgl0kS+byp7dqUVjwM7q
 voC0GrSAl2glapZbmtxD/myKsk/IDIE6R6gmHraPsu8DG+DH/xGiggSDzlxh8jXAggaR
 W5xz0qXDhYmWKNkKj3ie7lypq0+qgY5hy9nknLGQa4YEr1D44OgSPidkujTZDLckfSuU
 DCP5q8vFSI3itGpDIeEvVnKrc8DCbPwyxI5H6rKfu/xw8Gpl7+zjs9V24FJuqxBGw6/m
 ZGqQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785833529; x=1786438329;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0sB6HifPjZb8aR37oJnpZjtcMxblBqBzHGZHxGjIYTQ=;
 b=kvPKVhKOJcsrX6eiUzdbkVP82d1i2VMNnF5l/53l5wFguwi9fVtKLaibludG4K93m9
 bOdRf6MM+Vq5Z4UFpTKG3MN2U16Vb+htxRDfCy/SSBDRyuX1xX91h/THdAr2kfhxYEIh
 AvsIrz4vEPJ/hwurkS5XbL0qgRq+xoy8LF8qgGykFfJEOnc93U2vQCYrZmj/3VXsvjAI
 J8jZv+jWujDEQauLicSOboKaMrX9fkrQQZNaEBv9ZVLv+6M/kjqijj3aW/hPuj+qKm8O
 ZvnF8YVMs6S1mk34WAPl/NSvNJ7DzIxw8r2IhnR4wBPE/oO5ejlsQ5BOZDeMGkdRrjth
 0k8A==
X-Gm-Message-State: AOJu0YzgWbl/iYP4j2ymJZJl6JofaKAyL/kkSkRAnTow2gX7yGd1BeX0
 5fiM3jcTKNr8O36dNPRE1zc3ssMfacxGBySZ+UxUc+cfahI3dkFySUkyOaW5/R/D+1K0PIeAAV5
 +lpAo01o3A+s4UJF8ylb09h61RFMP/wxsXTJ337w4fw==
X-Gm-Gg: AR+sD122SHAG7wxLFIPlNm86i2CwkLXNn5tZoQy8GzQXettYlq6p4OVuddOphwOccHh
 uZv/V8T5GSqPm3K8SbnQlhBb7mYnc5SGVAebzqJv6EvwmbraqBgUqqokw1F9sIfk5QkaZPCQ3Dd
 KLslln4d4c19Xruoczm+tXCrPBcKXTtpQI6tpGuz5B+6OmlhZ/G2yuX5BWpYSpZlGRGAqvez4j+
 +k5EjDwEeRDtrLnaFIsjlyl0M9jDdRc4Jys71MlNqrq7ssYXeuDXvPkaIC3l4gpkHGluyE+SLZ8
 PIrmRMN6d5kemlNeTqFbXrLFUMRg72pH0vFpfsU9vI5ohcGNxYocOWt3v4r2bW5r1vs+LKYBGuI
 TPlmnB/kDewP7OTKPCh6b812TJGBsTStf+BYI2mN8ZBHGlOeEveAtiQGDv7wd4AsuxYbgFMEkfQ
 XFb28KBdZfC/kJR31GZVLeZ7b2sM1XyUeYw1KhMAkT/u/JtM2DFqDHruxirn+mbDNbifsWku7UI
 MRCVNo6UVIIi4bPiRGbUeoScTq0SUUiXA4/Rm/SkUHW/xRZ4OYS7fGPHijj7Tj6i5yQC1TOkxZP
 T5vt8zq0b2knlT5KKBdh8HAu1jkMsMus4VfWNuo3mHOtFF9NwRyuUkEoHp6zbFB0ZTNK5i0hPZT
 paspc4sVtAQ5mj22LnC+8yXbco5gqCAC/KUCeiJsUNFnN0+ozUdjFuw==
X-Received: by 2002:a05:690e:2144:b0:668:96a9:e60 with SMTP id
 956f58d0204a3-6694f1bebf3mr12113100d50.40.1785833529193; Tue, 04 Aug 2026
 01:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260728-ccaione-upstream-ebbr-v2-0-4efb529140d6@baylibre.com>
 <20260728-ccaione-upstream-ebbr-v2-1-4efb529140d6@baylibre.com>
In-Reply-To: <20260728-ccaione-upstream-ebbr-v2-1-4efb529140d6@baylibre.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 4 Aug 2026 11:51:32 +0300
X-Gm-Features: AUfX_mx8gYD6-hiF98oVJ_0GD3iVYIs2NHTQQqzmJ5SGL4WTN3bjDhzvSGx355s
Message-ID: <CAC_iWjLBoAJfkBspBKiyiGQkXB0=7evZ1k2AtEo58Yf8WrR8JA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] efi_loader: bootmgr: preserve a passed devicetree
To: Carlo Caione <ccaione@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, Ahmad Fatoum <a.fatoum@barebox.org>, 
 David Lechner <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Johan Jonker <jbx6244@gmail.com>,
 Randolph Sapp <rs@ti.com>, Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>, 
 Peng Fan <peng.fan@nxp.com>, Vincent Jardin <vjardin@free.fr>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785833529; x=1786438329;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0sB6HifPjZb8aR37oJnpZjtcMxblBqBzHGZHxGjIYTQ=;
 b=SbU/61i25dmVYmc7DdxTaU+H5vOUJciAgASqmG0VtFJHkScSlZ3Cm3DHFEGWAJqlvn
 8hI/Gg/JFn68hppUNR4EuhVGGZ1R9iszbDHBpbYzGL+N/HvGuJv2YRvIOVKUFUki5/yE
 66sR20N8ZqQgU4KkgqlHcSCeSlvingL3/tNYuLiHl4mg6WyYglP35UQnhj7EmAhYK2fU
 MQ7MMmxRPlrzJ5GWT+aeGEJFLGen9RBzy8e6+fo7UXR7oMGavW/at/7lumdfCO4LdPrZ
 pByzQIZWs/F9vz7a5sAL4e4CdX3QNUHBQEVnqNL5IU5CiOP99OfJZo0y9ws2a7Ch4Kj+
 bFew==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=SbU/61i2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Tue, 28 Jul 2026 at 16:20, Carlo Caione <ccaione@baylibre.com> wrote:
>
> An FDT explicitly passed to efi_bootmgr_run() is currently replaced by
> the FDT referenced by the selected Boot#### load option. This makes an
> operator-supplied devicetree ineffective whenever the boot option carries
> one.
>
> Only consult the load-option FDT when no FDT was passed. Document the
> resulting precedence so the explicit call argument remains the
> highest-priority source.
>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  lib/efi_loader/efi_bootmgr.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index 8c9a9b5eb56..785484abf23 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -1294,9 +1294,9 @@ out:
>   * efi_bootmgr_run() - execute EFI boot manager
>   * @fdt:       Flat device tree
>   *
> - * Invoke EFI boot manager and execute a binary depending on
> - * boot options. If @fdt is not NULL, it will be passed to
> - * the executed binary.
> + * Invoke the EFI boot manager and execute a binary according to its boot
> + * options. The devicetree precedence, from highest to lowest, is an FDT
> + * passed in @fdt, the Boot#### load-option FDT, then the distro/ESP FDT.
>   *
>   * Return:     status code
>   */
> @@ -1305,7 +1305,7 @@ efi_status_t efi_bootmgr_run(void *fdt)
>         efi_handle_t handle;
>         void *load_options;
>         efi_status_t ret;
> -       void *fdt_lo, *fdt_distro = NULL;
> +       void *fdt_lo = NULL, *fdt_distro = NULL;
>         efi_uintn_t fdt_size;
>
>         /* Initialize EFI drivers */
> @@ -1320,11 +1320,13 @@ efi_status_t efi_bootmgr_run(void *fdt)
>         }
>
>         if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE)) {
> -               ret = load_fdt_from_load_option(&fdt_lo);
> -               if (ret != EFI_SUCCESS)
> -                       return ret;
> -               if (fdt_lo)
> -                       fdt = fdt_lo;
> +               if (!fdt) {
> +                       ret = load_fdt_from_load_option(&fdt_lo);
> +                       if (ret != EFI_SUCCESS)
> +                               return ret;
> +                       if (fdt_lo)
> +                               fdt = fdt_lo;
> +               }
>                 if (!fdt) {
>                         efi_load_distro_fdt(handle, &fdt_distro, &fdt_size);
>                         fdt = fdt_distro;
>
> --
> 2.55.0
>
