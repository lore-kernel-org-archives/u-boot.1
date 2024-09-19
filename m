Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87FA7CF3941
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:11:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA122891BE;
	Thu, 19 Sep 2024 16:10:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EG3GCpkX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32DEB891C7; Thu, 19 Sep 2024 16:10:06 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C73F891BE
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:10:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6c54a5fbceeso6456916d6.2
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726755003; x=1727359803; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NChGShmu/A2FFo9w9p27EZY1uREvTdNv88+MNztbS5o=;
 b=EG3GCpkX5pAAd8c0xdiONIEdY6GwBqKJ6kJNQHGRHCM4h23PCkNpv5nY5/9knGWF9m
 o++e2C6CXUK7K7bDkhuXNOrvBlQk9EvG36Oq6PGIZAdkfLpe4AetCYQbjJcfMtybtmmc
 UgH4qbDJzOZaaxZaDAUYHKdXz3sclmyIwnh+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726755003; x=1727359803;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NChGShmu/A2FFo9w9p27EZY1uREvTdNv88+MNztbS5o=;
 b=UC//9wYh88dFX4zj6w/5yJrrucExyGamxjo3KCKny1wNqSNezvN7SXi1MygiR9p8he
 /pEaPJZXr7BNWr9RlJseHAB3X+ygPvjIT4Zljw8WEJYoCa7U5JzZTXVZvVFbqEclEu3+
 gpfFxoYUrnryT9AltlhTr++bPOT6pdS9MtwkP1sG1g+ZzMuOXy1C08r2bUbFGGSRL0X/
 d09zlIzEBBnuLDNy/CaX5KZW9FyyQL3FZbon4CQZQ685av3FKePRwtkJXgYIx3LOsgVf
 mFqAvrFkuE4i4yGp7eu20p0DCRAKpezFKW/irFoPlh/LCaBKkp3oIXBZkYckl+qLZkEJ
 9zWg==
X-Gm-Message-State: AOJu0YwPbCyShjbo3COoonc+VU+RD7FbmoJ21aJz79WUSyzNyIbq+UCM
 3U8yufTdjEXhIILB6AQbb9oLAnqyvFNErU86D6yRaVHriwdDQ4/Jn/uNUy+/fP2Yeu1Ouobzi0q
 Mk6VPhFCoW+uYE+REiH6g3Fz1DiTf+A1FMy3u
X-Google-Smtp-Source: AGHT+IFK1tgtdbQ0YRwAA0XigHbB1+9JueK0tJ+8LKCJRAeASOrptA6a4tgi1fTAWUlyUCcT/WZYNa+6LVuxG2baft4=
X-Received: by 2002:a05:6214:419e:b0:6c1:7d85:d151 with SMTP id
 6a1803df08f44-6c57dfa2882mr326966066d6.15.1726755002992; Thu, 19 Sep 2024
 07:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
 <20240918152136.3395170-25-patrick.rudolph@9elements.com>
In-Reply-To: <20240918152136.3395170-25-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:09:52 +0200
Message-ID: <CAFLszTjsoN36dOa8NKfCvcvxFKkzOQRVs85-AfDRZ-waOJNr7w@mail.gmail.com>
Subject: Re: [PATCH v4 24/35] common: Enable BLOBLIST_TABLES on arm
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, 
 Tom Rini <trini@konsulko.com>
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

On Wed, 18 Sept 2024 at 17:26, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Allow to use BLOBLIST_TABLES on arm to store ACPI or other tables.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>  common/Kconfig |  1 +
>  lib/Kconfig    | 15 +++++++++------
>  2 files changed, 10 insertions(+), 6 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/common/Kconfig b/common/Kconfig
> index e1b8557e0c..09ead61817 100644
> --- a/common/Kconfig
> +++ b/common/Kconfig
> @@ -1076,6 +1076,7 @@ config BLOBLIST_SIZE_RELOC
>         hex "Size of bloblist after relocation"
>         default BLOBLIST_SIZE if BLOBLIST_FIXED || BLOBLIST_ALLOC
>         default 0x0 if BLOBLIST_PASSAGE
> +       default 0x20000 if (ARM && EFI_LOADER && GENERATE_ACPI_TABLE)
>         help
>           Sets the size of the bloblist in bytes after relocation. Since U-Boot
>           has a lot more memory available then, it is possible to use a larger
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 2059219a12..ea444354eb 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -983,12 +983,15 @@ menu "System tables"
>
>  config BLOBLIST_TABLES
>         bool "Put tables in a bloblist"
> -       depends on X86 && BLOBLIST
> -       help
> -         Normally tables are placed at address 0xf0000 and can be up to 64KB
> -         long. With this option, tables are instead placed in the bloblist
> -         with a pointer from 0xf0000. The size can then be larger and the
> -         tables can be placed high in memory.
> +       depends on BLOBLIST
> +       default y if (ARM && EFI_LOADER && GENERATE_ACPI_TABLE)
> +       default n
> +       help
> +         On x86 normally tables are placed at address 0xf0000 and can be up
> +         to 64KB long. With this option, tables are instead placed in the
> +         bloblist with a pointer from 0xf0000. The size can then be larger
> +         and the tables can be placed high in memory.
> +         On other architectures the tables are always placed in high memory.
>
>  config GENERATE_SMBIOS_TABLE
>         bool "Generate an SMBIOS (System Management BIOS) table"
> --
> 2.46.0
>
