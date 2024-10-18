Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F5AD30011
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 14:54:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3850A88C60;
	Fri, 18 Oct 2024 16:54:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gGe/9Nof";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 167CC88CC1; Fri, 18 Oct 2024 16:54:49 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD95588C4D
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 16:54:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7b1418058bbso155234285a.3
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 07:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729263286; x=1729868086; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fx50mgbaGLDWJFJa1m9oMXLzSprYCVhgBl1FRbPpXKo=;
 b=gGe/9NofvgtvdbT2bKq2YULZiLHNdocKntjMguKqryModvmf8EJg/65CnPxWZOwzbP
 UQcupeVaXV8+M9um6MMiUxM3wGlCjfJ/MHMlQGyDgrXFNd8P/vs1rI85EKOciekahhKW
 qcmiXHM1rRKVOUnheEvEMFS0eEGKmaaM+O7bI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729263286; x=1729868086;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fx50mgbaGLDWJFJa1m9oMXLzSprYCVhgBl1FRbPpXKo=;
 b=MQmb9/E4vJIY3RQ8BECIp+LsG2Y3Er9nTNZ9HrDP0ycQnbLs2/z5b4n3vKQAXnDmDc
 VoWY+SMkqJtJ0qv6kjxoOuUpYx5qomS7JsoCUnnBzeAN/9+8wnVBn720mVbGTN0eunkA
 623Fr2y3b2V2th5QAsaUwEd0hY30sd8FBsrYxFAbtcuW2hNyCExR7c58He2W+xKjf6Ql
 /cqzp/EqVibzHbxqEr08bxCh81L+pI53gvr1Et58q7smdzdo/KuFftrE7AZACX2fe1bY
 PxMmCFj2y6kxDZJbxttGMcGvQUA2JiNK0kYex0VDFh9RgYOwkMRTcAVozcUQTNKvlaf1
 /23g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuMm7Bt4cmsdbyWVgujCAqfUCAMIctHP7OD/M12clTm301IWO7/oHeHUz7O+1JeuhFC5TCn8s=@lists.denx.de
X-Gm-Message-State: AOJu0YzqZZhGfEMaAfUWeLO0BZK41lEU7UB8SxjNO707qcCevrymgT9Y
 oBRgB+ASQGqQEEUdgNbKJgolYoyytwOeD4dvSgSjtxEnOu436YhNl8m6yKJHzVwlbjZtycvY/Ey
 wg/st5sKN9yGfFs4b20VmT61FLgn0HYMkzlLo
X-Google-Smtp-Source: AGHT+IFIqWD9rmCbB3NCxnl3sg19hgtSPHZWEUx/mEUEbur4obge2G7mEz1GywHOEhfCAsEnF1CD986Ey0R7/G1IGz8=
X-Received: by 2002:a05:6214:5b08:b0:6cb:e603:1c3a with SMTP id
 6a1803df08f44-6cde155e574mr29669086d6.25.1729263285654; Fri, 18 Oct 2024
 07:54:45 -0700 (PDT)
MIME-Version: 1.0
References: <20241017181306.6615-1-heinrich.schuchardt@canonical.com>
 <CAC_iWjKsSgN=LTAvpdvwDVtMQN17FxWifJSqucaKcY5bp864sw@mail.gmail.com>
In-Reply-To: <CAC_iWjKsSgN=LTAvpdvwDVtMQN17FxWifJSqucaKcY5bp864sw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Oct 2024 08:54:35 -0600
Message-ID: <CAFLszTit50FXKZGWc71cK1j37Oe5itHeY=F_-3rACoXZU3KpJg@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: remove ERROR:,
 WARNING: prefixes in messages
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
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

On Thu, 17 Oct 2024 at 12:19, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Thu, 17 Oct 2024 at 21:13, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > We should not write "ERROR:" or "WARNING:" when using log_err() or
> > log_warning(). These prefixed don't provide additional information.
> >
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> >  lib/efi_loader/efi_helper.c | 20 ++++++++++----------
> >  1 file changed, 10 insertions(+), 10 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> > index a481eb4b7e3..00167bd2a10 100644
> > --- a/lib/efi_loader/efi_helper.c
> > +++ b/lib/efi_loader/efi_helper.c
> > @@ -412,7 +412,7 @@ static efi_status_t copy_fdt(void **fdtp)
> >                                  EFI_ACPI_RECLAIM_MEMORY, fdt_pages,
> >                                  &new_fdt_addr);
> >         if (ret != EFI_SUCCESS) {
> > -               log_err("ERROR: Failed to reserve space for FDT\n");
> > +               log_err("Failed to reserve space for FDT\n");
> >                 goto done;
> >         }
> >         new_fdt = (void *)(uintptr_t)new_fdt_addr;
> > @@ -468,7 +468,7 @@ efi_status_t efi_install_fdt(void *fdt)
> >          * but not both.
> >          */
> >         if (CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE) && fdt)
> > -               log_warning("WARNING: Can't have ACPI table and device tree - ignoring DT.\n");
> > +               log_warning("Can't have ACPI table and device tree - ignoring DT.\n");
> >
> >         if (fdt == EFI_FDT_USE_INTERNAL) {
> >                 const char *fdt_opt;
> > @@ -483,13 +483,13 @@ efi_status_t efi_install_fdt(void *fdt)
> >                 if (!fdt_opt) {
> >                         fdt_opt = env_get("fdtcontroladdr");
> >                         if (!fdt_opt) {
> > -                               log_err("ERROR: need device tree\n");
> > +                               log_err("need device tree\n");
> >                                 return EFI_NOT_FOUND;
> >                         }
> >                 }
> >                 fdt_addr = hextoul(fdt_opt, NULL);
> >                 if (!fdt_addr) {
> > -                       log_err("ERROR: invalid $fdt_addr or $fdtcontroladdr\n");
> > +                       log_err("invalid $fdt_addr or $fdtcontroladdr\n");
> >                         return EFI_LOAD_ERROR;
> >                 }
> >                 fdt = map_sysmem(fdt_addr, 0);
> > @@ -497,7 +497,7 @@ efi_status_t efi_install_fdt(void *fdt)
> >
> >         /* Install device tree */
> >         if (fdt_check_header(fdt)) {
> > -               log_err("ERROR: invalid device tree\n");
> > +               log_err("invalid device tree\n");
> >                 return EFI_LOAD_ERROR;
> >         }
> >
> > @@ -510,12 +510,12 @@ efi_status_t efi_install_fdt(void *fdt)
> >         /* Prepare device tree for payload */
> >         ret = copy_fdt(&fdt);
> >         if (ret) {
> > -               log_err("ERROR: out of memory\n");
> > +               log_err("out of memory\n");
> >                 return EFI_OUT_OF_RESOURCES;
> >         }
> >
> >         if (image_setup_libfdt(&img, fdt, false)) {
> > -               log_err("ERROR: failed to process device tree\n");
> > +               log_err("failed to process device tree\n");
> >                 return EFI_LOAD_ERROR;
> >         }
> >
> > @@ -527,7 +527,7 @@ efi_status_t efi_install_fdt(void *fdt)
> >         if (CONFIG_IS_ENABLED(EFI_TCG2_PROTOCOL_MEASURE_DTB)) {
> >                 ret = efi_tcg2_measure_dtb(fdt);
> >                 if (ret == EFI_SECURITY_VIOLATION) {
> > -                       log_err("ERROR: failed to measure DTB\n");
> > +                       log_err("failed to measure DTB\n");
> >                         return ret;
> >                 }
> >         }
> > @@ -535,7 +535,7 @@ efi_status_t efi_install_fdt(void *fdt)
> >         /* Install device tree as UEFI table */
> >         ret = efi_install_configuration_table(&efi_guid_fdt, fdt);
> >         if (ret != EFI_SUCCESS) {
> > -               log_err("ERROR: failed to install device tree\n");
> > +               log_err("failed to install device tree\n");
> >                 return ret;
> >         }
> >
> > @@ -574,7 +574,7 @@ efi_status_t do_bootefi_exec(efi_handle_t handle, void *load_options)
> >          */
> >         ret = efi_set_watchdog(300);
> >         if (ret != EFI_SUCCESS) {
> > -               log_err("ERROR: Failed to set watchdog timer\n");
> > +               log_err("failed to set watchdog timer\n");
> >                 goto out;
> >         }
> >
> > --
> > 2.45.2
> >
>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Reviewed-by: Simon Glass <sjg@chromium.org>
