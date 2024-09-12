Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB31EE57F6
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 01:00:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B2FC88D39;
	Thu, 12 Sep 2024 02:59:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L8MCGhvZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A9E688D69; Thu, 12 Sep 2024 02:59:02 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57E1488CFA
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 02:59:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-718816be6cbso295737b3a.1
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 17:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102739; x=1726707539; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LUuu1BY8JmxPtncoicyXpBDLumXc43JkYXU1jQBJeqA=;
 b=L8MCGhvZD4pmHX28dXNPeY40p0iSJINasEBje0yr0XzmIp4F86c6vALfE6WbRn0XKv
 gAxLrF3BXPlppU3k3FtD813d7ofjvKpZo/TIVtRsWzZogjlog1jwSUUK4g/i7EP4UuD+
 d8kpe9iwasg31onL45ZWxqqcN8KMyAai628LQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102739; x=1726707539;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LUuu1BY8JmxPtncoicyXpBDLumXc43JkYXU1jQBJeqA=;
 b=TltpnhG6cgKJdWEK8s9lBl/7zRGj5jOHs/GeCNGQakn6Y8EXeGrES30dC0awNbopuX
 vLWBYPkRz3OibWYM6oPxVc0EgDkTb6ZSIPdj5vQwiIDO2xV7CotlSUzfvlUISmggIBfo
 h4Tbz5mtSMl22uKMNAb+6KKgmbr+SAueha4wS7HYrrrq/DykTn7p3pJfHUwdJQEv72SJ
 sNY00nQsnLle4A+RWMJFTLpKreczEFBI6Ug1tQvXhS3cX5PB9Zyt2kk2crPg1HJ8UbeR
 RMbEHB2TipVVdcv+ogsuiUgBOccmpKYlLBZxEYYNBv8Iv7RtTtEO1n2jJItITGe7BcUF
 CCXA==
X-Gm-Message-State: AOJu0Yw+bCiNsRBXg9PGKh1pPE43R2ihGNkdJWwFRqt2Fkd9hifSleng
 0oZDXoUxeOChD/LY3uSBLQjjicyqI3QeOFxkKcYbTS/RVy1ft9vPy8vG19OddIabAMHkVlIJ5X4
 gEnqzIJR57EnvfahJGMUu83Z5659yMSnMMOjk
X-Google-Smtp-Source: AGHT+IHjPKhktcqnObUnkBvf1pi5sfq33bsr27s+nh4MlMe+2yDHjbdVbafJDgxivmPqWxbwK6p52CuqSoUpYH9AebI=
X-Received: by 2002:a05:6a00:4b52:b0:717:9754:4ade with SMTP id
 d2e1a72fcca58-719261edaaemr1821400b3a.22.1726102738842; Wed, 11 Sep 2024
 17:58:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-22-patrick.rudolph@9elements.com>
In-Reply-To: <20240911062511.494855-22-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 18:58:27 -0600
Message-ID: <CAFLszTgBSBu=p0MxhdrXi-=zd=0cXFqGVZM-R7Q6tJeWLPGm-A@mail.gmail.com>
Subject: Re: [PATCH v3 21/30] common: Enable BLOBLIST_TABLES on arm
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

On Wed, 11 Sept 2024 at 00:29, Patrick Rudolph
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

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/common/Kconfig b/common/Kconfig
> index 83c81edac2..a864e24508 100644
> --- a/common/Kconfig
> +++ b/common/Kconfig
> @@ -1075,6 +1075,7 @@ config BLOBLIST_SIZE_RELOC
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

Since you are changing this, you might as well drop the 0x here as it
is implied in U-Boot.

> +         and the tables can be placed high in memory.
> +         On other architectures the tables are always placed in high memory.
>
>  config GENERATE_SMBIOS_TABLE
>         bool "Generate an SMBIOS (System Management BIOS) table"
> --
> 2.46.0
>

Regards,
Simon
