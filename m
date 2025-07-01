Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D14AC7EE30
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 08:24:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDD5882ADA;
	Tue,  1 Jul 2025 10:24:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="K1v5E562";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1986082B18; Tue,  1 Jul 2025 10:24:24 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C586581FEE
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 10:24:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7d40874b399so265039985a.2
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 01:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751358252; x=1751963052; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PWaLRU0tFMvNKuKayqsMQw58pBRrIrDq4xaRMcVKVQ0=;
 b=K1v5E562/tejgdx1nxXraIkQCRh/B+bGkd4zuY2/mHIXqL5k46/wRHOh2I2gJwHQHH
 R25CBZqaJ1Ho+uXwM3/LBc+idvUQHFO9AZ/VDxtTTGLR3OuT0qEs09zvV8JFkc0n11Ur
 6b/E9ODRczXUQApM/cHcw4zcML3iPgtTRxt2nsij35EUezuWFL16lVVg+cQuHKffB5GW
 23muaHiRguDYYmx71ZylbHuqtpAdVq+28Hai1z11T5pJ8sqJkEfo4XBrbuj5J8zPikPr
 J6WIOdQ8LDIFS9M5ag/n5mTXipZMP/pRVg8J0eZnG9+5GMrztP5A9OnAss6+OTEb56qg
 SASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751358252; x=1751963052;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PWaLRU0tFMvNKuKayqsMQw58pBRrIrDq4xaRMcVKVQ0=;
 b=iBQMCwZfqNqFMlBjQ8DTX9hKVjeaaOoHJqaHjRQ+Ai7PVaerRf0WRFo4PRKDYd6T5i
 G02vr23QjOpX3Sz2BhRvcUlCfsE+64/OQDXEICPjzLs9eFbDcOJdnVq9tVs6pKcY4l+A
 Z06DZtmk416qa06h8oT+aqygPFeyBkK1yqjoPEoP0Ddtuhx+DAntoSDLNO7chuhEvYvl
 EnucbRsLyaio+ZNapbaw1cy97iEaFLEboDb59TD2OD9kLco8eXMQxj0m2I1Z9ROz7aSE
 vrKFIWEXjENjvFY/gyIFOtWNNVsxeRQSo2ZTDT2Rs3ftJRqM/agq46hUhO0qaWs18ek0
 W1qg==
X-Gm-Message-State: AOJu0YxMSLHnK36Dx7BrbDQ79GZkqKHWc1KGp45xuXsvZCl7k7UQQLwM
 tKiavWGiD+XEU0L5m0kkiEbQpSakz8fDWEdjMGt0pxifGrZ9MFTmymrVboqDndnaIQcMzBn0VtE
 Tz3bm6MqDE1VPrHI0gl8B7t8EEfQJhp3InAo1LEwnNA==
X-Gm-Gg: ASbGnctC3XgNeCqZ9t5DXuKd+eu//bOClruWTfhgGxftOlWDpUKBoxtV+3bSbTRyHdL
 qRPzpUxSmhbatAFIg2NCvJZ27NS1YOtsaR7w2lHRfdyTs6QrBYpXtRMW7cYE7Zrd7FHzwlE0ih0
 JxgSiXI+XQ3AXAskdWJ+zTNlzNTVj0huAInrJ7cSw2vSk9en9T6a79Mtc=
X-Google-Smtp-Source: AGHT+IHNbJB4Z8HqXKMRAvur8CSB2DIQRLGVT7XWOhDCqv9htGmcAYTKQIA7fSXagqmgWUBUcrLcxPCQeJVnG19/WZg=
X-Received: by 2002:a05:620a:4507:b0:7d0:998a:2e64 with SMTP id
 af79cd13be357-7d4439c75f2mr2486007585a.56.1751358252248; Tue, 01 Jul 2025
 01:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250627112509.264221-1-sughosh.ganu@linaro.org>
 <20250627112509.264221-2-sughosh.ganu@linaro.org>
 <CAC_iWj+9WBOxjciXBTVa945qgse8nuet85YEeksS+tmg5k+RzQ@mail.gmail.com>
In-Reply-To: <CAC_iWj+9WBOxjciXBTVa945qgse8nuet85YEeksS+tmg5k+RzQ@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 1 Jul 2025 13:54:01 +0530
X-Gm-Features: Ac12FXy-2OWnNCirmAGQKmkpHLWeTpeCS72AEtkFJm4n9EdgqXd3onFSd7DsFO0
Message-ID: <CADg8p95Gf1EczWFYxQMRZPJCSzE_=e+74dZ+yPWbY-uo+CUSuw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] cmd: eficonfig: add support for URI device path
 based boot options
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
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

On Tue, 1 Jul 2025 at 13:21, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Sughosh
>
> [...]
>
> > +
> >  static struct eficonfig_item select_file_menu_items[] = {
> >         {"Select File", eficonfig_process_select_file},
> >         {"Clear", eficonfig_process_clear_file_selection},
> > @@ -1042,16 +1101,30 @@ static struct eficonfig_item select_file_menu_items[] = {
> >  efi_status_t eficonfig_process_show_file_option(void *data)
> >  {
> >         efi_status_t ret;
> > +       unsigned int menu_count;
> >         struct efimenu *efi_menu;
> > +       struct eficonfig_item *menu_items;
> > +       struct eficonfig_select_file_info *file_info = data;
> > +
> > +       menu_items = file_info->boot_file_option ? select_boot_file_menu_items :
> > +               select_file_menu_items;
>
> Why do we need boot_file_option? Won't the len of the URI be 0 if it's a file?

This is to determine if the menu shows the URI option, or not. The
same function, eficonfig_process_show_file_option() gets called for
selection of the boot file, initrd file and the fdt file. The URI
option only needs to be shown in the first case and not the other two.
The URI string will get populated at a later stage, only after the
user has input the string, after selecting the menu option.

>
> [...]
>
> >
> > +/**
> > + * fill_dp_uri() - copy the URI string in the device path
> > + * @dp:                pointer to the URI device path
> > + * @uri_str:   URI string to be copied
> > + *
> > + * Copy the passed URI string to the URI device path. This
> > + * requires utf8_utf16_strcpy() to copy the u16 string to
> > + * the u8 array in the device path structure.
> > + *
> > + * Return: None
> > + */
> > +static void fill_dp_uri(struct efi_device_path *dp, u16 **uri_str)
> > +{
> > +       u16 *p = *uri_str;
> > +       struct efi_device_path_uri *uridp;
> > +
> > +       uridp = (struct efi_device_path_uri *)dp;
> > +
> > +       utf8_utf16_strcpy(&p, uridp->uri);
> > +}
> > +
> >  /**
> >   * fill_file_info() - fill the file info from efi_device_path structure
> >   *
> > @@ -1392,10 +1486,13 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
> >         size_t len;
> >         efi_status_t ret;
> >         char *tmp = NULL, *p;
> > +       u16 *current_path = NULL;
> >         struct efi_load_option lo = {0};
> >         efi_uintn_t dp_size;
> >         struct efi_device_path *dp = NULL;
> >         efi_uintn_t size = load_option_size;
> > +       struct efi_device_path *dp_volume = NULL;
> > +       struct efi_device_path *uri_dp = NULL;
> >         struct efi_device_path *device_dp = NULL;
> >         struct efi_device_path *initrd_dp = NULL;
> >         struct efi_device_path *fdt_dp = NULL;
> > @@ -1464,6 +1561,14 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
> >                 goto out;
> >         }
> >
> > +       bo->file_info.uri = calloc(1, EFICONFIG_URI_MAX * sizeof(u16));
> > +       if (!bo->file_info.uri) {
> > +               ret =  EFI_OUT_OF_RESOURCES;
> > +               goto out;
> > +       }
> > +
> > +       bo->file_info.boot_file_option = true;
> > +
> >         /* copy the preset value */
> >         if (load_option) {
> >                 ret = efi_deserialize_load_option(&lo, load_option, &size);
> > @@ -1481,7 +1586,10 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
> >                 u16_strcpy(bo->description, lo.label);
> >
> >                 /* EFI image file path is a first instance */
> > -               if (lo.file_path)
> > +               if (lo.file_path && EFI_DP_TYPE(lo.file_path, MESSAGING_DEVICE,
> > +                                               MSG_URI))
> > +                       fill_dp_uri(lo.file_path, &bo->file_info.uri);
> > +               else
>
> This else does something different now. Shouldn't it be else if (lo.file_path)>

Yes. The else needs to be modified accordingly. A null lo.file_path
does not cause a crash, but it is better to put that check to avoid
unnecessary function calls. Thanks.

-sughosh

>
> >                         fill_file_info(lo.file_path, &bo->file_info, device_dp);
> >
>
> [...]
>
> Thanks
> /Ilias
