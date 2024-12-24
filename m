Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6213E77188
	for <u-boot@archiver.kernel.org>; Tue, 24 Dec 2024 05:32:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39FB780708;
	Tue, 24 Dec 2024 06:32:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KTVC+zW4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 261F380711; Tue, 24 Dec 2024 06:32:40 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AC65806FC
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 06:32:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-aa6b4cc7270so710227166b.0
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 21:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735018357; x=1735623157; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yyMAEQWzQQY3ORHEKW9r43Ipqkaql0Q2y248ck1wYxs=;
 b=KTVC+zW4rlwcCopLGcUBlqoDONLSm3Tx495TgDB2TW3/Qexnx3ry3bjRenuXLro8XS
 1qdQqULxyQQoRktfwdiSIR+QsGdNvZPcMZbWQnl78mNtDIzGPMLsnDgbB48rgUsmzVw2
 0rC+ajDCHGF55rXJGSKWewJlKrlANXImD3xq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735018357; x=1735623157;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yyMAEQWzQQY3ORHEKW9r43Ipqkaql0Q2y248ck1wYxs=;
 b=A8nty8ih3kEjsIvdgSfTxhEdP5vT8qQE62inzdNLMkF9YT2lNkLAKwV5imqXL4SC9i
 O/3zFGSeUE5ppK/r7GSglEVl+m9C4LN1azq6V1cRCb073WJLlC/+pUUpHSTyaDBDRQ4X
 3GpkMMLbM7OHNl8R+grU9Lph7s0LmWl18+5D6buQipxnu7sfekL0gKjAlky88jgrRsxu
 DazrrCsKvp+5x0F15bFyrQL/o4iQkeOjJ53Br+wGlLhee1ZXaqcirhSObo3z+ZyFQg81
 DYxkEiHx8T0LEFxoPdlNlpz/RvmONs71jlXykpHpCHwl9cAeG1blTvHZxZJPqoux4eZq
 dbhQ==
X-Gm-Message-State: AOJu0YwyaAo9h/iRz6r16guTtAyTfbIxRS6UyD+rQp9ibt58LQIggx1B
 10mYDwZK0l96+hDcrgVHf3rgpIQm3mgo+1k1NTl4no7WMRYviaNvtl+A/TbRkzY9jigUaC6Cnkm
 2n/7YJnYc7kjxJCs05wx/9HoDXg3rO854FSNz
X-Gm-Gg: ASbGnct8d84Gbx59aPFwniiCblCsOR0+WYmgcVzAsR0x+qullAEInLFN4UgTfuORlg5
 VgMDmTTvOd4r2QC0HPfOxmOqDWvSV7qI51rAC/hR7
X-Google-Smtp-Source: AGHT+IF6v/pqnzCC2gQwI3XWvA3P0ocbIbB02VrwxC/J9alFyezyZ7BdMHX+amhj/VybxfzqpYgVcfUYOJ1GocFC8a8=
X-Received: by 2002:a05:6402:5189:b0:5d0:81f5:a398 with SMTP id
 4fb4d7f45d1cf-5d81dd846ecmr33744607a12.1.1735018357010; Mon, 23 Dec 2024
 21:32:37 -0800 (PST)
MIME-Version: 1.0
References: <20241219023832.1098689-1-sjg@chromium.org>
 <20241219023832.1098689-4-sjg@chromium.org>
 <CAC_iWjJSXWDBjYNaCr-yBAD6NbK2Pph0t+ZmkP_BFJHq3S9Kug@mail.gmail.com>
In-Reply-To: <CAC_iWjJSXWDBjYNaCr-yBAD6NbK2Pph0t+ZmkP_BFJHq3S9Kug@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 24 Dec 2024 18:32:23 +1300
Message-ID: <CAFLszThWhF2+g2Z7cZCVRppnO+iG57aMn0BaGOiOJHxER1vAMQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] efi_loader: Update efi_run_image() to accept image
 and device path
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Adriano Cordova <adrianox@gmail.com>, Moritz Fischer <moritzf@google.com>, 
 Patrick Wildt <pwildt@google.com>
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

Hi Ilias,

On Sat, Dec 21, 2024, 21:44 Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Thu, 19 Dec 2024 at 04:39, Simon Glass <sjg@chromium.org> wrote:
> >
> > Provide these globals as parameters to this function, on the way to
> > making it possible to start an image without relying on the globals.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v2)
> >
> > Changes in v2:
> > - Adjust argument ordering for efi_run_image()
> >
> >  lib/efi_loader/efi_bootbin.c | 20 ++++++++++++--------
> >  1 file changed, 12 insertions(+), 8 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> > index 051d86ef993..b42ff3cb4e0 100644
> > --- a/lib/efi_loader/efi_bootbin.c
> > +++ b/lib/efi_loader/efi_bootbin.c
> > @@ -157,9 +157,13 @@ void efi_set_bootdev(const char *dev, const char *devnr, const char *path,
> >   *
> >   * @source_buffer:     memory address of the UEFI image
> >   * @source_size:       size of the UEFI image
> > + * @device:            EFI device-path
> > + * @image:             EFI image-path
> >   * Return:             status code
> >   */
> > -static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
> > +static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size,
> > +                                 struct efi_device_path *device,
> > +                                 struct efi_device_path *image)
> >  {
> >         efi_handle_t mem_handle = NULL, handle;
> >         struct efi_device_path *file_path = NULL;
> > @@ -167,7 +171,7 @@ static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
> >         efi_status_t ret;
> >         u16 *load_options;
> >
> > -       if (!bootefi_device_path || !bootefi_image_path) {
> > +       if (!device || !image) {
> >                 log_debug("Not loaded from disk\n");
> >                 /*
> >                  * Special case for efi payload not loaded from disk,
> > @@ -188,9 +192,8 @@ static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
> >                         goto out;
> >                 msg_path = file_path;
> >         } else {
> > -               file_path = efi_dp_concat(bootefi_device_path,
> > -                                         bootefi_image_path, 0);
> > -               msg_path = bootefi_image_path;
> > +               file_path = efi_dp_concat(device, image, 0);
> > +               msg_path = image;
> >                 log_debug("Loaded from disk\n");
> >         }
> >
> > @@ -227,7 +230,7 @@ out:
> >  /**
> >   * efi_binary_run() - run loaded UEFI image
> >   *
> > - * @image:     memory address of the UEFI image
> > + * @image_ptr: memory address of the UEFI image
> >   * @size:      size of the UEFI image
> >   * @fdt:       device-tree
> >   *
> > @@ -236,7 +239,7 @@ out:
> >   *
> >   * Return:     status code
> >   */
> > -efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
> > +efi_status_t efi_binary_run(void *image_ptr, size_t size, void *fdt)
> >  {
> >         efi_status_t ret;
> >
> > @@ -252,5 +255,6 @@ efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
> >         if (ret != EFI_SUCCESS)
> >                 return ret;
> >
> > -       return efi_run_image(image, size);
> > +       return efi_run_image(image_ptr, size, bootefi_device_path,
> > +                            bootefi_image_path);
> >  }
>
> https://lore.kernel.org/u-boot/CAC_iWj+5-uoXq9BanaOSxedVgbBYNFQ2AZVqka+J7iwMv=eC5w@mail.gmail.com/
>
> I thought you said the _ptr was dropped.
>
> Anyway
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> We can drop it later or in v3 if one is needed

Thanks. Yes I dropped it but then realized that the next patch needs
it. I replied on version 2 about this.

Regards,
Simon
