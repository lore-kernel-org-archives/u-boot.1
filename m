Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC56C7EE30
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 08:43:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 606C082ADA;
	Tue,  1 Jul 2025 10:43:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ihwaCD6c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6952282B18; Tue,  1 Jul 2025 10:43:48 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3031C81FEE
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 10:43:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-4a589b7dd5fso94379121cf.0
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 01:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751359420; x=1751964220; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IrpRvCOp/1okvnbP60byAhX2/uRS4f+uueMMI44UE/4=;
 b=ihwaCD6cnEnI/+dhe3Ez+IQvX+nuCDuHcUOTZacPBouhllc/lIsREe2F8XybM6XsBg
 wE40uBlG+MELEvAMc2w6qcFOb0BHS5F1XnYgUfhzN74Rtkm79sSP05aPK0It0Rjh7Tpw
 5GxgqlKk/cFPQW9vNM9Od7yGSyMvcUZGqM6Ezv8ITWNMr38zYC3tp2uzvuWu0ZsEIdAK
 YLGKa4sorq1MsyEYu1QKU6dcEZ2m86Qb/NdDQ0pXnr7L6uPwuJp/L2TzaYPX7CTAfrp/
 kz0OfffBH1HwDRdHy7M7zF+sgeyHfT1FFjwO5npIU7m3h7q8+KyDUpdWnt7ZQgZnHbZe
 Y+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751359420; x=1751964220;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IrpRvCOp/1okvnbP60byAhX2/uRS4f+uueMMI44UE/4=;
 b=u976Awo1rvBhFnaS/jiNO+WHpUNjssDcqJmIh8mYy4OWEKZFongWESATDD3hfqeIFN
 lr6HmTc+TszT0YwXCBYCPBVCNnjEfKN+2AwyxcYLihKmcbKeeamQuySNh0yK5myQGDRa
 +TG0SWcCfNlQ17EgFExRJ6lAuGEq0pzmhQnYGmsmSNxWzucvoHvOeEYzRrn+gxZhOmw8
 srKEmnAZaZS3FrZOxWM5R1P5222OAkwYt5VHgLVs80pCZP+XbwvpCm8N7hP5BSD2G0ho
 17gJqfJR1DZhxvzu9IvtUo1Niixd7xvc8WeG6gLL5eYlhVqoIeDP7tbAcSB5qaS4okeB
 E3XQ==
X-Gm-Message-State: AOJu0Yw+M8AG4BRha4S2b3dv7MoNHuFcM28ngJ3PEx20FCEkApreLr7S
 ELc81uSqmy3OKHTV2ORSKivh5AD8PCz8v7/w/uTzaexefaSNMoky1jBNuPpsMxe+nQxl2XAFC6S
 oKXDwelIuNpDiDfPn1fMX+HJ13SqK8fSh1f2NCIUX0w==
X-Gm-Gg: ASbGncvAaLcAovTCsx1RRoVQQSKTVC2RFPXNOv8O62QuJZaRDJQd+WY8MqaDD52FgAc
 qONm+eWWEeQuyBZyNfOCmVRREmRHNUm8D+n5F5Vjx1dqCJun0GxcTSKQvvO2lczDfZbKvy9dxtP
 Ef8iWmAGFVQCELzi7uE7TJtGtpqq/vVQLE/vaMYr304GSn
X-Google-Smtp-Source: AGHT+IELLSFzbJ6fjmvH5gPCZDIM0MblxaQS99B8+TDZkrMOLz7oQZjo4CSVeIAlM1KfZvNJfYG7E3wtc5GLRDRQCZ8=
X-Received: by 2002:a05:622a:588:b0:48b:4f9b:fcfc with SMTP id
 d75a77b69052e-4a7fca4dcd7mr267962971cf.22.1751359419911; Tue, 01 Jul 2025
 01:43:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250627112509.264221-1-sughosh.ganu@linaro.org>
 <20250627112509.264221-2-sughosh.ganu@linaro.org>
 <CAC_iWj+9WBOxjciXBTVa945qgse8nuet85YEeksS+tmg5k+RzQ@mail.gmail.com>
 <CADg8p95Gf1EczWFYxQMRZPJCSzE_=e+74dZ+yPWbY-uo+CUSuw@mail.gmail.com>
In-Reply-To: <CADg8p95Gf1EczWFYxQMRZPJCSzE_=e+74dZ+yPWbY-uo+CUSuw@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 1 Jul 2025 14:13:28 +0530
X-Gm-Features: Ac12FXzGN_xd6VoG3wEz1VXSflQVxIjRMCyojIakyVhKEqGfZHOxSbePux8Zr2s
Message-ID: <CADg8p95Zomt_OrymFGOjQGWKDkjp-y1R_3Xg_JYmSRhUdQXsVQ@mail.gmail.com>
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

On Tue, 1 Jul 2025 at 13:54, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Tue, 1 Jul 2025 at 13:21, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Sughosh
> >
> > [...]
> >
> > > +
> > >  static struct eficonfig_item select_file_menu_items[] = {
> > >         {"Select File", eficonfig_process_select_file},
> > >         {"Clear", eficonfig_process_clear_file_selection},
> > > @@ -1042,16 +1101,30 @@ static struct eficonfig_item select_file_menu_items[] = {
> > >  efi_status_t eficonfig_process_show_file_option(void *data)
> > >  {
> > >         efi_status_t ret;
> > > +       unsigned int menu_count;
> > >         struct efimenu *efi_menu;
> > > +       struct eficonfig_item *menu_items;
> > > +       struct eficonfig_select_file_info *file_info = data;
> > > +
> > > +       menu_items = file_info->boot_file_option ? select_boot_file_menu_items :
> > > +               select_file_menu_items;
> >
> > Why do we need boot_file_option? Won't the len of the URI be 0 if it's a file?
>
> This is to determine if the menu shows the URI option, or not. The
> same function, eficonfig_process_show_file_option() gets called for
> selection of the boot file, initrd file and the fdt file. The URI
> option only needs to be shown in the first case and not the other two.
> The URI string will get populated at a later stage, only after the
> user has input the string, after selecting the menu option.

What you are suggesting can be done.  We need to check if the uri
pointer is non NULL instead, as the pointer will get allocated only
for the file_info member of struct eficonfig_boot_option. So it is
indeed possible to do away with the bool member being added. Thanks.

-sughosh

>
> >
> > [...]
> >
> > >
> > > +/**
> > > + * fill_dp_uri() - copy the URI string in the device path
> > > + * @dp:                pointer to the URI device path
> > > + * @uri_str:   URI string to be copied
> > > + *
> > > + * Copy the passed URI string to the URI device path. This
> > > + * requires utf8_utf16_strcpy() to copy the u16 string to
> > > + * the u8 array in the device path structure.
> > > + *
> > > + * Return: None
> > > + */
> > > +static void fill_dp_uri(struct efi_device_path *dp, u16 **uri_str)
> > > +{
> > > +       u16 *p = *uri_str;
> > > +       struct efi_device_path_uri *uridp;
> > > +
> > > +       uridp = (struct efi_device_path_uri *)dp;
> > > +
> > > +       utf8_utf16_strcpy(&p, uridp->uri);
> > > +}
> > > +
> > >  /**
> > >   * fill_file_info() - fill the file info from efi_device_path structure
> > >   *
> > > @@ -1392,10 +1486,13 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
> > >         size_t len;
> > >         efi_status_t ret;
> > >         char *tmp = NULL, *p;
> > > +       u16 *current_path = NULL;
> > >         struct efi_load_option lo = {0};
> > >         efi_uintn_t dp_size;
> > >         struct efi_device_path *dp = NULL;
> > >         efi_uintn_t size = load_option_size;
> > > +       struct efi_device_path *dp_volume = NULL;
> > > +       struct efi_device_path *uri_dp = NULL;
> > >         struct efi_device_path *device_dp = NULL;
> > >         struct efi_device_path *initrd_dp = NULL;
> > >         struct efi_device_path *fdt_dp = NULL;
> > > @@ -1464,6 +1561,14 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
> > >                 goto out;
> > >         }
> > >
> > > +       bo->file_info.uri = calloc(1, EFICONFIG_URI_MAX * sizeof(u16));
> > > +       if (!bo->file_info.uri) {
> > > +               ret =  EFI_OUT_OF_RESOURCES;
> > > +               goto out;
> > > +       }
> > > +
> > > +       bo->file_info.boot_file_option = true;
> > > +
> > >         /* copy the preset value */
> > >         if (load_option) {
> > >                 ret = efi_deserialize_load_option(&lo, load_option, &size);
> > > @@ -1481,7 +1586,10 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
> > >                 u16_strcpy(bo->description, lo.label);
> > >
> > >                 /* EFI image file path is a first instance */
> > > -               if (lo.file_path)
> > > +               if (lo.file_path && EFI_DP_TYPE(lo.file_path, MESSAGING_DEVICE,
> > > +                                               MSG_URI))
> > > +                       fill_dp_uri(lo.file_path, &bo->file_info.uri);
> > > +               else
> >
> > This else does something different now. Shouldn't it be else if (lo.file_path)>
>
> Yes. The else needs to be modified accordingly. A null lo.file_path
> does not cause a crash, but it is better to put that check to avoid
> unnecessary function calls. Thanks.
>
> -sughosh
>
> >
> > >                         fill_file_info(lo.file_path, &bo->file_info, device_dp);
> > >
> >
> > [...]
> >
> > Thanks
> > /Ilias
