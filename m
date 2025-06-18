Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9DEC7115B
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 09:26:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54B6E82C2F;
	Wed, 18 Jun 2025 11:26:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BLV1Oius";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5CCD82C55; Wed, 18 Jun 2025 11:26:38 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76F2A82B18
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 11:26:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-711d4689084so15546327b3.0
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 02:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750238795; x=1750843595; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HbFrYXFwxtRJkBgEsMn6ywNYaqaNHAl6VB4BqAg9FkU=;
 b=BLV1Oius9jfV7VZPtKttD0kU8T4hzqETMwLWRnwncitlImD4HhoTQ7btnkT+oTtGcB
 hpeHYmAO9LWSmEKFyAu95Kvxjlu7Lk/uUpFeoRVsynVpfM0a+XEMtwfNUA7Dos2C4FNl
 8XngeIHQbQP4W4lKfWLNPiVRoRnQc5pCsCyZ2rQdKp9BgUyqlOk8r+gowRVyDp5hFBJd
 MJfMTtek3hSzuMnTBpv+DOTVV1+ZPXX3AWzBN9EIWOCQiQJx1BkmCj2eOywXfHjyRbGY
 859B30jNimA2jMw3iHNghnpy+rxTqZ0Vi7mkhxYD8oYLm6tuy8m75lPOzO7ATBDpk1Yn
 arnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750238795; x=1750843595;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HbFrYXFwxtRJkBgEsMn6ywNYaqaNHAl6VB4BqAg9FkU=;
 b=fWYc8ODMgL5i5OEz1Ebuh9oS8rqjiZpf4EoCgkatZ9QsCwNLf2ygHBuO66UgM/I7Bp
 kRQuEukmj/Hb71/LRf6HhRgaVfarelUGwLh6jqIsAuP1TX6ecInVXHnDZ4FF/uTnATiv
 mzCXJlDyiEVeY9oqdABOQFFDmu5MUUU7GR8z664i8uB9AmQuUdT+ZwsF3YGDXaI+0Ju0
 Enk8VurTQR1g//Kw07tkLy8m77syKKL7g6zptPOP+6EE1QNe2RXRXVKkheciw0HOS3Vh
 w/592BLO173BnEg9vtsFiTFfTgmykMg+7QtiZqcBeN1Gyo44EkIruJsP1ClmW+9onCOl
 TkPg==
X-Gm-Message-State: AOJu0YzbRTyJ7D7TG67CcdTEef5bc+4IuE8f5ZHedrqQN7oSUQFsNO09
 upSnDxF4mIC20fAV+yAMeXwJUJziNsaw+XwFbuvixdtid4t+v0sRF7dbVTFb7TwtfgP+YI0W9OI
 2+QSzdrh2ppbRDL9WvNd9qWAaeF3rZdqXxHt0xqhn1Q==
X-Gm-Gg: ASbGncuqU1eRAO34CpjR45b0FXab52oKnCFFfTJiSlp9syl5wRnFusnZgcY+lKYPMXI
 AdBwyFerY3RafjPP4SKndGO9F3Z0K1l703TI3sp7Wn74nQj/RJHnyoCX3ts8jf+RwzsGq59j+KT
 ZP8+pz5KgyOFwIEt4iYUtJHPrRrvWdXyr59PEQtLKcUcfJ
X-Google-Smtp-Source: AGHT+IGzqlEmZveTVXx9lRn4FyT5lpwliLQVCpjQA7Df6oZAcF81WlJJdjUD8oh4Tq7OSiAp5Qn5vtdexjIUKmo81CI=
X-Received: by 2002:a05:690c:6:b0:70b:6651:b3e2 with SMTP id
 00721157ae682-71175384ed3mr236421697b3.6.1750238795308; Wed, 18 Jun 2025
 02:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250618080056.1973311-1-javierm@redhat.com>
 <20250618080056.1973311-5-javierm@redhat.com>
In-Reply-To: <20250618080056.1973311-5-javierm@redhat.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 18 Jun 2025 12:25:58 +0300
X-Gm-Features: AX0GCFtttelC_wAik4JrJi8m46XWZx9bhUfVqZHetWopKcyEWSN5QQ29GxH6hcw
Message-ID: <CAC_iWj+cV73RRritmVcvgx15teBZBMwQW-97MYMXhezG8ds5Wg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] efi_selftest: Add basic partition info check to
 block io test
To: Javier Martinez Canillas <javierm@redhat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, mripard@redhat.com, Tom Rini <trini@konsulko.com>, 
 alexl@redhat.com, mkorpers@redhat.com, eballetb@redhat.com, 
 mskrivan@redhat.com
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

Hi Heinrich

This looks reasonable to be, but a bit limited since we only check for
MBR. However, this is not a patch limitation since the image we create
on the fly is based on MBR.
I think this is a good start and we can extend it by creating a GPT
based image as well?

On Wed, 18 Jun 2025 at 11:01, Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> Test the EFI_PARTITION_INFO_PROTOCOL in the existing EFI_BLOCK_IO_PROTOCOL
> unit test. It is fairly basic, since it only checks that the values of the
> struct efi_partition_info .revision, .type and .system fields are correct.
>
> It doesn't check the MBR partition record information, because that's not
> supported by the EFI_PARTITION_INFO_PROTOCOL implementation yet. The test
> can be extended once the support is implemented, or if the in-memory disk
> image used for the test is modified to have a GPT partition type instead.
>
> Suggested-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> Changes in v2:
> - Add a test for the EFI partition information protocol (Tom Rini).
>
>  lib/efi_selftest/efi_selftest_block_device.c | 29 ++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/lib/efi_selftest/efi_selftest_block_device.c b/lib/efi_selftest/efi_selftest_block_device.c
> index a367e8b89d17..0ee909da87d6 100644
> --- a/lib/efi_selftest/efi_selftest_block_device.c
> +++ b/lib/efi_selftest/efi_selftest_block_device.c
> @@ -29,6 +29,7 @@ static struct efi_boot_services *boottime;
>
>  static const efi_guid_t block_io_protocol_guid = EFI_BLOCK_IO_PROTOCOL_GUID;
>  static const efi_guid_t guid_device_path = EFI_DEVICE_PATH_PROTOCOL_GUID;
> +static const efi_guid_t partition_info_guid = EFI_PARTITION_INFO_PROTOCOL_GUID;
>  static const efi_guid_t guid_simple_file_system_protocol =
>                                         EFI_SIMPLE_FILE_SYSTEM_PROTOCOL_GUID;
>  static const efi_guid_t guid_file_system_info = EFI_FILE_SYSTEM_INFO_GUID;
> @@ -310,6 +311,7 @@ static int execute(void)
>                 struct efi_file_system_info info;
>                 u16 label[12];
>         } system_info;
> +       struct efi_partition_info *part_info;
>         efi_uintn_t buf_size;
>         char buf[16] __aligned(ARCH_DMA_MINALIGN);
>         u32 part1_size;
> @@ -375,6 +377,33 @@ static int execute(void)
>                              part1_size - 1);
>                 return EFI_ST_FAILURE;
>         }
> +
> +       /* Open the partition information protocol  */
> +       ret = boottime->open_protocol(handle_partition,
> +                                     &partition_info_guid,
> +                                     (void **)&part_info, NULL, NULL,
> +                                     EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> +       if (ret != EFI_SUCCESS) {
> +               efi_st_error("Failed to open partition information protocol\n");
> +               return EFI_ST_FAILURE;
> +       }
> +       /* Check that cached partition information is the expected */
> +       if (part_info->revision != EFI_PARTITION_INFO_PROTOCOL_REVISION) {
> +               efi_st_error("Partition info revision %x, expected %x\n",
> +                            part_info->revision, EFI_PARTITION_INFO_PROTOCOL_REVISION);
> +               return EFI_ST_FAILURE;
> +       }
> +       if (part_info->type != PARTITION_TYPE_MBR) {
> +               efi_st_error("Partition info type %x, expected %x\n",
> +                            part_info->type, PARTITION_TYPE_MBR);
> +               return EFI_ST_FAILURE;
> +       }
> +       if (part_info->system != 0) {
> +               efi_st_error("Partition info system %x, expected 0\n",
> +                            part_info->system);
> +               return EFI_ST_FAILURE;
> +       }
> +
>         /* Open the simple file system protocol */
>         ret = boottime->open_protocol(handle_partition,
>                                       &guid_simple_file_system_protocol,
> --
> 2.49.0
>
