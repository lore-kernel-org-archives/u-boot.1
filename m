Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE44C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 08:04:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB4A2870A8;
	Thu,  9 Nov 2023 09:04:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RoZP5uwl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBEE7870BB; Thu,  9 Nov 2023 09:04:12 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC49486F55
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 09:04:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5079f3f3d7aso720943e87.1
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 00:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699517050; x=1700121850; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8rO1Xg7nuvnYQARZFFjzk85LDoEuvAvKC6BVUWTiyoc=;
 b=RoZP5uwlcKCy3DF0uu8VAma5NsHsHzy/DiO7K66bvxrbfISt1nsjAWrQhnzMGOPCaB
 brQ8kgw9cSf9bq8IzBmbleZE8vnWKoPYHSqU+2I07XMeaqPRxZcXfiTBlV8ih+IkIRLA
 jevjlWRRT9HfUHaPRLHgN8eqz1APTODj4dB8wgBW/nmDsJRiGOhUNRJFIJjaxnk5EeIo
 3uCSghMuWLHsRy7mqsI6x0lH4/JTGcPxGjnB8GXNe671g4/AI3KN8HyOYfNv5HPIf69t
 K29B8/zI8wVuM3BXBkap4NH5Mt61ZmoJQzCr4BMQ2d6hm+KfZBcL2dv9QIsx+KCrkFTQ
 FmvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699517050; x=1700121850;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8rO1Xg7nuvnYQARZFFjzk85LDoEuvAvKC6BVUWTiyoc=;
 b=QUTzxby6tHUE7uBtxQpc54idZvHah89Z/VKkCKEEIMEtCcULm4Po8UYw820xexenkI
 njZKTTBDS6cDZAJOrLkGvrpqUNJjfVb8LHO0MHqZ77NcnHhDAV4wYXyoSND6X8XFIKb/
 gg1vz3YmkPFMxoKlxzhsu6RMM0yW9V4fnJW1DL16YV88PmuiXczLiT6FKtDyfnlq6f6/
 FZZNSVtBNlO7Gmxk8GLe1aH0FdWNVUo2OL/tet6jjPk3Kt4cN1eeqpwtGqJxKgshILSE
 hceHMhHSvBavbOjAI2Uld0Sw0bY+OL4tst0RtcmZw8JE5FBMpYXM0O5XLneVCNWyn99q
 fwyA==
X-Gm-Message-State: AOJu0Yz3OcBRiWqo71Tfwh7Sp5FT6W8oLbcP6r5+1eboVc8QWVvbxMFn
 poT+k77KRwmiSqOJ0XN0+aVsMowjeZ6PFGASKVUTDg==
X-Google-Smtp-Source: AGHT+IFRcu9moqMOQJT7d7oLQ98CdfDce65RZOMTAsr3DWeoVfjik83IdwxdnMzOGWlNCyg1QkzGmY1BQgXzg5G96PU=
X-Received: by 2002:ac2:46ee:0:b0:507:975f:6ccb with SMTP id
 q14-20020ac246ee000000b00507975f6ccbmr705837lfo.2.1699517050111; Thu, 09 Nov
 2023 00:04:10 -0800 (PST)
MIME-Version: 1.0
References: <20231108110637.3691441-1-masahisa.kojima@linaro.org>
 <20231108110637.3691441-8-masahisa.kojima@linaro.org>
In-Reply-To: <20231108110637.3691441-8-masahisa.kojima@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 9 Nov 2023 10:03:34 +0200
Message-ID: <CAC_iWjKXOvOa5AmVB7doqvKvx8_iEFs8cMEz+3ZrEO6RYoc1eA@mail.gmail.com>
Subject: Re: [PATCH v11 7/9] efi_loader: support boot from URI device path
To: Masahisa Kojima <masahisa.kojima@linaro.org>
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

Kojima-san

On Wed, 8 Nov 2023 at 13:08, Masahisa Kojima <masahisa.kojima@linaro.org> wrote:
>
> This supports to boot from the URI device path.
> When user selects the URI device path, bootmgr downloads
> the file using wget into the address specified by loadaddr
> env variable.
> If the file is .iso or .img file, mount the image with blkmap
> then try to boot with the default file(e.g. EFI/BOOT/BOOTAA64.EFI).
> Since boot option indicating the default file is automatically
> created when new disk is detected, system can boot by selecting
> the automatically created blkmap boot option.
> If the file is PE-COFF file, load and start the downloaded file.
>
> The buffer used to download the ISO image file must be
> reserved to avoid the unintended access to the image and
> expose the ramdisk to the OS.
> For PE-COFF file case, this memory reservation is done
> in LoadImage Boot Service.
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
>  lib/efi_loader/Kconfig       |   9 +
>  lib/efi_loader/efi_bootmgr.c | 376 +++++++++++++++++++++++++++++++++++
>  2 files changed, 385 insertions(+)
>
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index d20aaab6db..5d99206dc3 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -479,4 +479,13 @@ config EFI_RISCV_BOOT_PROTOCOL
>           replace the transfer via the device-tree. The latter is not
>           possible on systems using ACPI.
>
> +config EFI_HTTP_BOOT
> +       bool "EFI HTTP Boot support"
> +       depends on CMD_DNS
> +       depends on CMD_WGET
> +       depends on BLKMAP
> +       help
> +         Enabling this option adds EFI HTTP Boot support. It allows to
> +         directly boot from network.
> +
>  endif

Since we depend on all these, I think it would be easier to 'select'
instead of 'depends on', otherwise enabling EFI_HTTP_BOOT will be very
tricky.




> + */
> +static efi_status_t search_default_file(struct udevice *dev,
> +                                       struct efi_device_path **loaded_dp)
> +{
> +       efi_status_t ret;
> +       efi_handle_t handle;
> +       u16 *default_file_name = NULL;
> +       struct efi_file_handle *root, *f;
> +       struct efi_device_path *dp = NULL, *fp = NULL;
> +       struct efi_simple_file_system_protocol *file_system;
> +       struct efi_device_path *device_path, *full_path = NULL;
> +
> +       if (dev_tag_get_ptr(dev, DM_TAG_EFI, (void **)&handle)) {
> +               log_warning("DM_TAG_EFI not found\n");
> +               return EFI_INVALID_PARAMETER;
> +       }
> +
> +       ret = EFI_CALL(bs->open_protocol(handle, &efi_simple_file_system_protocol_guid,
> +                                        (void **)&file_system, efi_root, NULL,
> +                                        EFI_OPEN_PROTOCOL_GET_PROTOCOL));
> +       if (ret != EFI_SUCCESS)
> +               return ret;
> +
> +       ret = EFI_CALL(file_system->open_volume(file_system, &root));
> +       if (ret != EFI_SUCCESS)
> +               return ret;
> +
> +       ret = EFI_CALL(bs->open_protocol(handle, &efi_guid_device_path,
> +                                        (void **)&device_path, efi_root, NULL,
> +                                        EFI_OPEN_PROTOCOL_GET_PROTOCOL));
> +       if (ret != EFI_SUCCESS)
> +               return ret;
> +
> +       full_path = expand_media_path(device_path);
> +       ret = efi_dp_split_file_path(full_path, &dp, &fp);
> +       if (ret != EFI_SUCCESS)
> +               goto err;
> +
> +       default_file_name = efi_dp_str(fp);
> +       efi_free_pool(dp);
> +       efi_free_pool(fp);
> +       if (!default_file_name) {
> +               ret = EFI_OUT_OF_RESOURCES;
> +               goto err;
> +       }
> +
> +       ret = EFI_CALL(root->open(root, &f, default_file_name,
> +                                 EFI_FILE_MODE_READ, 0));
> +       efi_free_pool(default_file_name);
> +       if (ret != EFI_SUCCESS)
> +               goto err;
> +
> +       EFI_CALL(f->close(f));\

This closes the file correctly, but the volume is still open. Don't we need
EFI_CALL(root->close(root) as well?

[...]

With the above fixed
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
