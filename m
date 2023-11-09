Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0462C0018C
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 10:27:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB7F087120;
	Thu,  9 Nov 2023 11:27:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mHSq8ARV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D28428719B; Thu,  9 Nov 2023 11:27:07 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 055B4870BE
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 11:27:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9d224dca585so114949066b.1
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 02:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699525623; x=1700130423; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Lx5SIuo3GcmrBmqnPGemWe6NcoBilqt+qy3pkGQR0cs=;
 b=mHSq8ARVlbCEMNv9OkxuQj8bbP7hkZxGaJU4SKJuuRavqjMfq41ddoToz8yDO9XorM
 bSfOUAYoqeBQKpDI5MvDqnNO1P8xSP+Ndfqc5Qjs7CLg2w2U81B7F83EYyPfD/bOzXwk
 d4zfAlJ5AKUowPzCBmumxvMdau3Jh9wobTiJQmgNLgoGzKeMn33JYiM9XzCJRYvrnccE
 n3ITq9JnsE6rodYNbA1da8o2t2g5hcNZ4XL/dJ8U6C/pXJ+2GB3p5OflZWdOuqmfla68
 2D2bqu7efwSc7+3e1vOitv2Nqf6DvPNuewIshS87tjd4phj9clNm6lVytz/4BHfev3tZ
 6PQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699525623; x=1700130423;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Lx5SIuo3GcmrBmqnPGemWe6NcoBilqt+qy3pkGQR0cs=;
 b=XDL/SMqzLVxA5EXZ9leiMRAjXDMYQAcT3gTqi4pCKFMRyvqvABfbKEhU3UUCJmh1yK
 PonseXiyLYlni/KCUXNlFxvuZm5Gu+yol2GywnAPbUp64+E8MYaonyYcOhU9gTUuDV3M
 DvIhIR6v3brSneChkSTukCGICdEaj84vTkwCgCipPnZb4K2eo0wPl/T73pxauYWWS3Ar
 gwEg7LwSw/25LJTVTGZ3YjFzOevmVh8v4LOGkziA4oEnH1dltvqhKVtlxt8m043OBowm
 P6tu7Aa9TpkCIMlmXItFRpdaoOSID+trSXWQkORdPlV2qOsZSq+lZj/P65+tFilDqcY7
 OYeg==
X-Gm-Message-State: AOJu0Yy7XP2EVk8jw0e+zqsLftYwBy290aQl83ZvxpCiN8Tg2sTX2q96
 fX9umHnz4Ii8O1QpjrbyWaTnBwKtRdwcGWZMoeYHpQ==
X-Google-Smtp-Source: AGHT+IH7fCD4Iz1b5Dh5zeqWe1GlXfOzRGK9Z/qlfQ5hsSm7BxcObFzDxCKflciubsjZnXKTL1TtFvjwwqP7b9zwkPY=
X-Received: by 2002:a17:907:2da5:b0:9bd:b8d0:c096 with SMTP id
 gt37-20020a1709072da500b009bdb8d0c096mr4191615ejc.21.1699525623485; Thu, 09
 Nov 2023 02:27:03 -0800 (PST)
MIME-Version: 1.0
References: <20231108110637.3691441-1-masahisa.kojima@linaro.org>
 <20231108110637.3691441-8-masahisa.kojima@linaro.org>
 <CAC_iWjKXOvOa5AmVB7doqvKvx8_iEFs8cMEz+3ZrEO6RYoc1eA@mail.gmail.com>
In-Reply-To: <CAC_iWjKXOvOa5AmVB7doqvKvx8_iEFs8cMEz+3ZrEO6RYoc1eA@mail.gmail.com>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Thu, 9 Nov 2023 19:26:52 +0900
Message-ID: <CADQ0-X-vwKG4H9ugNKPrG8dYWExfH8JYWZre3F1v4tZv+pV3rQ@mail.gmail.com>
Subject: Re: [PATCH v11 7/9] efi_loader: support boot from URI device path
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Takahiro Akashi <takahiro.akashi@linaro.org>, 
 Michal Simek <michal.simek@amd.com>
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

On Thu, 9 Nov 2023 at 17:04, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Kojima-san
>
> On Wed, 8 Nov 2023 at 13:08, Masahisa Kojima <masahisa.kojima@linaro.org> wrote:
> >
> > This supports to boot from the URI device path.
> > When user selects the URI device path, bootmgr downloads
> > the file using wget into the address specified by loadaddr
> > env variable.
> > If the file is .iso or .img file, mount the image with blkmap
> > then try to boot with the default file(e.g. EFI/BOOT/BOOTAA64.EFI).
> > Since boot option indicating the default file is automatically
> > created when new disk is detected, system can boot by selecting
> > the automatically created blkmap boot option.
> > If the file is PE-COFF file, load and start the downloaded file.
> >
> > The buffer used to download the ISO image file must be
> > reserved to avoid the unintended access to the image and
> > expose the ramdisk to the OS.
> > For PE-COFF file case, this memory reservation is done
> > in LoadImage Boot Service.
> >
> > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > ---
> >  lib/efi_loader/Kconfig       |   9 +
> >  lib/efi_loader/efi_bootmgr.c | 376 +++++++++++++++++++++++++++++++++++
> >  2 files changed, 385 insertions(+)
> >
> > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > index d20aaab6db..5d99206dc3 100644
> > --- a/lib/efi_loader/Kconfig
> > +++ b/lib/efi_loader/Kconfig
> > @@ -479,4 +479,13 @@ config EFI_RISCV_BOOT_PROTOCOL
> >           replace the transfer via the device-tree. The latter is not
> >           possible on systems using ACPI.
> >
> > +config EFI_HTTP_BOOT
> > +       bool "EFI HTTP Boot support"
> > +       depends on CMD_DNS
> > +       depends on CMD_WGET
> > +       depends on BLKMAP
> > +       help
> > +         Enabling this option adds EFI HTTP Boot support. It allows to
> > +         directly boot from network.
> > +
> >  endif
>
> Since we depend on all these, I think it would be easier to 'select'
> instead of 'depends on', otherwise enabling EFI_HTTP_BOOT will be very
> tricky.

Yes, I agree.

>
>
>
>
> > + */
> > +static efi_status_t search_default_file(struct udevice *dev,
> > +                                       struct efi_device_path **loaded_dp)
> > +{
> > +       efi_status_t ret;
> > +       efi_handle_t handle;
> > +       u16 *default_file_name = NULL;
> > +       struct efi_file_handle *root, *f;
> > +       struct efi_device_path *dp = NULL, *fp = NULL;
> > +       struct efi_simple_file_system_protocol *file_system;
> > +       struct efi_device_path *device_path, *full_path = NULL;
> > +
> > +       if (dev_tag_get_ptr(dev, DM_TAG_EFI, (void **)&handle)) {
> > +               log_warning("DM_TAG_EFI not found\n");
> > +               return EFI_INVALID_PARAMETER;
> > +       }
> > +
> > +       ret = EFI_CALL(bs->open_protocol(handle, &efi_simple_file_system_protocol_guid,
> > +                                        (void **)&file_system, efi_root, NULL,
> > +                                        EFI_OPEN_PROTOCOL_GET_PROTOCOL));
> > +       if (ret != EFI_SUCCESS)
> > +               return ret;
> > +
> > +       ret = EFI_CALL(file_system->open_volume(file_system, &root));
> > +       if (ret != EFI_SUCCESS)
> > +               return ret;
> > +
> > +       ret = EFI_CALL(bs->open_protocol(handle, &efi_guid_device_path,
> > +                                        (void **)&device_path, efi_root, NULL,
> > +                                        EFI_OPEN_PROTOCOL_GET_PROTOCOL));
> > +       if (ret != EFI_SUCCESS)
> > +               return ret;
> > +
> > +       full_path = expand_media_path(device_path);
> > +       ret = efi_dp_split_file_path(full_path, &dp, &fp);
> > +       if (ret != EFI_SUCCESS)
> > +               goto err;
> > +
> > +       default_file_name = efi_dp_str(fp);
> > +       efi_free_pool(dp);
> > +       efi_free_pool(fp);
> > +       if (!default_file_name) {
> > +               ret = EFI_OUT_OF_RESOURCES;
> > +               goto err;
> > +       }
> > +
> > +       ret = EFI_CALL(root->open(root, &f, default_file_name,
> > +                                 EFI_FILE_MODE_READ, 0));
> > +       efi_free_pool(default_file_name);
> > +       if (ret != EFI_SUCCESS)
> > +               goto err;
> > +
> > +       EFI_CALL(f->close(f));\
>
> This closes the file correctly, but the volume is still open. Don't we need
> EFI_CALL(root->close(root) as well?

Thank you for pointing it out.
I will fix it.

>
> [...]
>
> With the above fixed
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Thanks,
Masahisa Kojima
