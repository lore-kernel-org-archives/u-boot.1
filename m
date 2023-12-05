Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A1AC4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 06:24:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 062D387832;
	Tue,  5 Dec 2023 07:24:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dwKZSDr/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFD8587832; Tue,  5 Dec 2023 07:24:02 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94CD587075
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 07:23:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-50bfe99b6edso1352222e87.1
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 22:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701757439; x=1702362239; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K81cwiJr35uxi3kp4id5cwO9UBM36BagkTHQbPhY58s=;
 b=dwKZSDr/1L6e7lvBHVBdUSuQLi1jy1QxNBnNIIGpZkuFi4mOiqsY2P9dOQ5tsFt6Mw
 AKAG+d0ePmbh9Is2HxYyeop3Rz2VMs9yH0DVEypQPpad1Ulp8/v0Q+z3v3U1DfqT9yrj
 cYLCbgASZCnFbvuR5gNE6cNMY5d/56WpokMg34R6EGhdUFhu+7LQ5No5X/re05yuz3Zg
 /PGi1oZZau8u3NevqUQLFqV0lZXz7T7tf2ZZdwgIVFl5fleMczN93oWY0vldYPqNMbYH
 Lnd9vG9puj/UKr8cnzGZ1dUYkOcR+TRdQ91flskbXZqsuKwtaCyRwZt/wnSyWOMPnugT
 rIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701757439; x=1702362239;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K81cwiJr35uxi3kp4id5cwO9UBM36BagkTHQbPhY58s=;
 b=aq5DoUIDUwVr7Kfh8Kl0srkhxZqFKnDn8+B5+ZWZoE9Si1KPzNKE7hHIMu6wHT+l5u
 UdOvWFHtfT3/p4I3dXWpZITdqduaRx3MHNePJ9dLsx370sDHouD+ZKmxlQAJQcugsJLt
 X2pSUR04b01hIc7w/THGJ6o4A1xqQ/9kqMlr9FU4/53CeN0FpzLXhVT2HueN/wNdwD5y
 AnuxzQWC066ZUDfnThWvujLVqkJnn/hbrROvPhhtr71XTNwBZ5AdKFWE1EDugwYkPOs8
 fx/U2oUefkqoKu8xdi071DKPy7V2o3tvZ9Yrd2C/xAuGyNyzn6D4TF6pWLPZTx2g6I1B
 o++A==
X-Gm-Message-State: AOJu0YzMZQB/yGvv33pmwvWvbI1vWMueN2Y2LMUR8YB5htWiwNbsKs5+
 Zdipn5bwGmfLuEY1DJMWj8/hc3crFYLKIj+ZHySo/g==
X-Google-Smtp-Source: AGHT+IEpujEf44aVoXtucPlZp5stqmPShIpw5DAyhbRRnTA7j2kAJOOsvOcFquUdcONxWWSE/n4h/8suTcNY3LJ6hOc=
X-Received: by 2002:ac2:5185:0:b0:50b:fb28:4524 with SMTP id
 u5-20020ac25185000000b0050bfb284524mr946459lfi.95.1701757438816; Mon, 04 Dec
 2023 22:23:58 -0800 (PST)
MIME-Version: 1.0
References: <20231205023751.61679-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231205023751.61679-1-heinrich.schuchardt@canonical.com>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Tue, 5 Dec 2023 15:23:47 +0900
Message-ID: <CADQ0-X9Euv7UwVS49N=DvQxN+O_+6fq_jJw=Jiqauau6TyLpUg@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: boot options should relate to the ESP
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

On Tue, 5 Dec 2023 at 11:38, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> * Only generate removable media entries for EFI system partitions.
> * Only offer EFI system partitions for boot options in the eficonfig
>   command.
>
> Fixes: c416f1c0bcab ("bootmenu: add removable media entries")
> Fixes: 87d791423ac6 ("eficonfig: menu-driven addition of UEFI boot option")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/eficonfig.c              | 6 ++++--
>  lib/efi_loader/efi_bootmgr.c | 3 ++-
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
> index 34a59cb15d..c066b28b6b 100644
> --- a/cmd/eficonfig.c
> +++ b/cmd/eficonfig.c
> @@ -626,8 +626,10 @@ static efi_status_t eficonfig_select_volume(struct eficonfig_select_file_info *f
>         efi_handle_t *volume_handles = NULL;
>         struct efi_simple_file_system_protocol *v;
>
> -       ret = efi_locate_handle_buffer_int(BY_PROTOCOL, &efi_simple_file_system_protocol_guid,
> -                                          NULL, &count, (efi_handle_t **)&volume_handles);
> +       /* Find all EFI system partitions */
> +       ret = efi_locate_handle_buffer_int(BY_PROTOCOL,
> +                                          &efi_system_partition_guid,
> +                                          NULL, &count, &volume_handles);

UEFI specification v2.10 section '3.5 Boot Mechanisms' says
"EFI can boot from a device using the EFI_SIMPLE_FILE_SYSTEM_PROTOCOL or the
EFI_LOAD_FILE_PROTOCOL."

So in my understanding of the UEFI spec, I think
efi_simple_file_system_protocol_guid
is correct here.

>         if (ret != EFI_SUCCESS) {
>                 eficonfig_print_msg("No block device found!");
>                 return ret;
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index 48153bd5ff..9e84391186 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -1047,8 +1047,9 @@ efi_status_t efi_bootmgr_update_media_device_boot_option(void)
>         efi_handle_t *volume_handles = NULL;
>         struct eficonfig_media_boot_option *opt = NULL;
>
> +       /* Find all EFI system partitions */
>         ret = efi_locate_handle_buffer_int(BY_PROTOCOL,
> -                                          &efi_simple_file_system_protocol_guid,
> +                                          &efi_system_partition_guid,

In EDK II reference implementation[0], it enumerates all
block_io_protocol devices
and eliminates logical partitions.
Should we do the same? If yes, I can prepare the patch on this.

[0] https://github.com/tianocore/edk2/blob/master/MdeModulePkg/Library/UefiBootManagerLib/BmBoot.c#L2220

Regards,
Masahisa Kojima

>                                            NULL, &count,
>                                            (efi_handle_t **)&volume_handles);
>         if (ret != EFI_SUCCESS)
> --
> 2.40.1
>
