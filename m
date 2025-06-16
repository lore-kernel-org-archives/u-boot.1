Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D38C71155
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 13:01:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A45E80C93;
	Mon, 16 Jun 2025 15:01:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="R7M8VaFs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E172E81760; Mon, 16 Jun 2025 15:01:09 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B3018070C
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 15:01:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-70e77831d68so41841137b3.2
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 06:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750078866; x=1750683666; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E0/WQp4hmYDCb87iMfYRygFyFbngNzxd1oCOn4JhsdY=;
 b=R7M8VaFsYegUo2P8/qLA0PtK3B9GnVu2t8jB5vTdt3T3b0/4molAGrdVNu+AdSke7y
 JItJUmEdc1tyKNC2yjODHKhj8hUe61PoGweLQDMXdvYg282QknbzgjvojKLUanJnr5mc
 BYKN6wmDRTfHdYxOjOE+SlDSf2mYiVZvMYxR1FwrS3xF3BSeyWe+Sy3Bsn1dTdKwuo1A
 pG/2YciMnIr5eJiYVodrcR/qISD+iODcj7TggupkcDWdyLpKB31AH8Gn1skLvOocUJvk
 Mm6cB3D557gqRRETdvV4EG9gPo+J9syt0bybz1rV4CA0nC1ST52fJHiH5OpS2KJ0N4Bp
 ErZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750078866; x=1750683666;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E0/WQp4hmYDCb87iMfYRygFyFbngNzxd1oCOn4JhsdY=;
 b=peRp7YMsqNy6mvV8IW0DMtBtIkw9Qh0T+Jxc4kEHdL82wSQ7VnTCdNJuY9EBdqTsx5
 T06g6xmvsR7fbdZ2v+IR0mffG1vii3uCLA7arGNbS54pODnrb9UC6TVxJLBnXbDg+Zk6
 FudPi4drByggWjg2WEf0mtaiNGnsqidsJpw7Nv27ScbIpGoIRVzJpEpxUVa1Gw9j98zR
 QASV0AjatzGjJ21MzTbKUO0oLTKhCsDQOMorwbTDjMm8/OtQg0GPVgU+taeWmBsDxehc
 nYZiHy/J6IpRNOSXZ8QHlIp7Z/VZe4PzZ2zI4Q3+LWUpQOIiVMVg1c99TuKs6bUBNx1j
 /iQQ==
X-Gm-Message-State: AOJu0YxPC59qnNADmX5ELmV9LcJgR168A/0cskz7IovUtOgtgLhr3ETB
 8BMTXORwVs70WhMro8MyUYpO3T1cWSKZxwK9Rqaf7ATo6zmfwishLGzaSv0KrnKSo2q356gU9Vl
 c0lkR8QieolOE5+bNbYoeik7GVNJ2R06QnFEAGcubwQ==
X-Gm-Gg: ASbGnct0UseUF4WJBE/gu3dd7YXaV2yAmsrcoBVzyhVVSINTBveaEA/SEsb6j84FAsU
 R8JGNemQ/3kV94zmHyxuZiWXhrIqCSqd83bHtpY15M1Xl0aH6pyyKcSOuBb0br4bmDDoCXTfmXD
 z8MEvO0bFcgOobUWIOKq3oSKm4Yi5Gk9XbRLWxtUFsjjy4
X-Google-Smtp-Source: AGHT+IH1vErkaTMY+Z72VkYssx2jEZcF7aDQKjAOJPTbFkxp8Cq4OuXNJhN7XshrP36kINtaun2JvWw1FCLdi/DLbOQ=
X-Received: by 2002:a05:690c:1c:b0:70d:f892:2dca with SMTP id
 00721157ae682-7117545869amr136008517b3.32.1750078865474; Mon, 16 Jun 2025
 06:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250611050844.210384-1-paulliu@debian.org>
 <20250611050844.210384-2-paulliu@debian.org>
In-Reply-To: <20250611050844.210384-2-paulliu@debian.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 16 Jun 2025 16:00:29 +0300
X-Gm-Features: AX0GCFs5ZPgIVHODL4Hue4dczpz-DxPcN4eWWdMkVUu105l06eHCR_jFWOAtUZA
Message-ID: <CAC_iWjJDgUtQON1EBrqcaQ91tM6PUR65rPSQ07zhJOz8HsDzEw@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] efi: add EFI_SYSTEM_TABLE_POINTER for debug
To: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
Cc: u-boot@lists.denx.de, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Peter Robinson <pbrobinson@gmail.com>,
 Simon Glass <sjg@chromium.org>
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

Thanks Paul


On Wed, 11 Jun 2025 at 08:08, Ying-Chun Liu (PaulLiu)
<paulliu@debian.org> wrote:
>
> From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
>
> Add EFI_SYSTEM_TABLE_POINTER structure for remote debugger to locate
> the address of EFI_SYSTEM_TABLE.
>
> This feature is described in UEFI SPEC version 2.10. Section 18.4.2.
> The implementation ensures support for hardware-assisted debugging and
> provides a standardized mechanism for debuggers to discover the EFI
> system table.
>
> Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

A nit below

[...]

> +{
> +       const int size_4MB = 0x00400000;

We already have macros for these

Thanks
/Ilias

> +       uintptr_t addr;
> +       u32 crc32_value;
> +
> +       /* Allocate configuration table array */
> +       addr = (uintptr_t)efi_alloc_aligned_pages(sizeof(struct efi_system_table_pointer),
> +                                                 EFI_RUNTIME_SERVICES_DATA,
> +                                                 size_4MB);
> +
> +       if (!addr) {
> +               log_err("Installing EFI system table pointer failed\n");
> +               return EFI_OUT_OF_RESOURCES;
> +       }
> +
> +       systab_pointer = (struct efi_system_table_pointer *)addr;
> +       memset(systab_pointer, 0, sizeof(struct efi_system_table_pointer));
> +
> +       systab_pointer->signature = EFI_SYSTEM_TABLE_SIGNATURE;
> +       systab_pointer->efi_system_table_base = (efi_physical_addr_t)&systab;
> +
> +       crc32_value = crc32(0,
> +                           (const unsigned char *)systab_pointer,
> +                           sizeof(struct efi_system_table_pointer));
> +       systab_pointer->crc32 = crc32_value;
> +
> +       return EFI_SUCCESS;
> +}
> diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> index 48f91da5df7..6193b9f6d0c 100644
> --- a/lib/efi_loader/efi_setup.c
> +++ b/lib/efi_loader/efi_setup.c
> @@ -278,6 +278,14 @@ efi_status_t efi_init_obj_list(void)
>         if (ret != EFI_SUCCESS)
>                 goto out;
>
> +       /* Initialize system table pointer */
> +       if (IS_ENABLED(CONFIG_EFI_DEBUG_SUPPORT)) {
> +               ret = efi_initialize_system_table_pointer();
> +               if (ret != EFI_SUCCESS) {
> +                       goto out;
> +               }
> +       }
> +
>         if (IS_ENABLED(CONFIG_EFI_ECPT)) {
>                 ret = efi_ecpt_register();
>                 if (ret != EFI_SUCCESS)
> --
> 2.39.5
>
