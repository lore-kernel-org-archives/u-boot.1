Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745B2CF3943
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:10:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CC1A891C8;
	Thu, 19 Sep 2024 16:10:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hZ9aBSrE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3899E891B5; Thu, 19 Sep 2024 16:10:00 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBC77891B5
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:09:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6c35334dfb1so4949096d6.0
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726754996; x=1727359796; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ls64rPHq4YMWdS5F4T9ZBo4QlTnF+LxNudm5oNyebCM=;
 b=hZ9aBSrE22iWdtkp85p00RJyD0RJKqX/zXIa8PEUzdq1qjUTOQrzYX4rBJCK9SNYs7
 j8p1WK0Liq0JWYqH72F5zt9psh9PCufiQdEuqbrHuY9h8hM8NeMMOMT8qVp7tdKWgAp9
 18axJeVfrUu7G1Cb88PFcCoe/FZbjC+/bHZ7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726754996; x=1727359796;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ls64rPHq4YMWdS5F4T9ZBo4QlTnF+LxNudm5oNyebCM=;
 b=Fy7kB813quetamxZXxrM8NN3LuPqqh8/OhUPWgLM5qRQn3oO+W0DvBZlbQWk39UlqO
 6zRRshtDRIgd+gW8OhfC8jm02BOkLKpMPyATD+klB19+9QXasHmf8tE/6lWi9FWkPHFJ
 QqVQzcuxphILmxW7GODrGXEr7tPZfUSQopGfLeP8uv0G/k3/F7EwpLguyEdaktgZpOkL
 KJq9/56y+NCvGgM3OuO9AlUkC4awqoDI2vuxZ9MNOkkoH7tpo4Xi9bVKzuCKpqB1t/9t
 RWc3MQKiPggPKtMXekMrOBrNwezWoSy1GyrQsNZ2s+PY9CLSlrFlHkDJ7WGzyFLM3dBC
 432g==
X-Gm-Message-State: AOJu0Yw7Bbtd7jtYLeNrmsaRV5xejBAU+04mG1Jif2KvzAKPgZ7m7t0T
 ooJ/TG9u1vYI0mMSYISFTgdzoFfONLyKDxtYMO1njqV94WbJBCW1cepGwN7qN8fKiPDWZm89R3U
 7TS7ox/XnmEttL2pdprsOMzE4R6TV50qYg6tM
X-Google-Smtp-Source: AGHT+IGwDa1XMhEkPB7FXm9ylHiTihlUz6O/YQl8F3QiSbviRdNUdLZamE6HABu/g0wyr2uPR15S4AYwvB+OL0md2SQ=
X-Received: by 2002:a05:6214:460a:b0:6c5:a2ca:38b7 with SMTP id
 6a1803df08f44-6c5a2ca39a4mr208503916d6.27.1726754995083; Thu, 19 Sep 2024
 07:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
 <20240918152136.3395170-31-patrick.rudolph@9elements.com>
In-Reply-To: <20240918152136.3395170-31-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:09:44 +0200
Message-ID: <CAFLszTgQstN5GvJtMf0vXLzvBFxqZFmFRXRGprG-ZcSEAXy=+Q@mail.gmail.com>
Subject: Re: [PATCH v4 30/35] arm: cpu: Add ACPI parking protocol support
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On Wed, 18 Sept 2024 at 17:23, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> On Arm platforms that use ACPI they cannot rely on the "spin-table"
> CPU bringup usually defined in the FDT. Thus implement the
> 'ACPI Multi-processor Startup for ARM Platforms', also referred to as
> 'ACPI parking protocol'.
>
> The ACPI parking protocol works similar to the spin-table mechanism, but
> the specification also covers lots of shortcomings of the spin-table
> implementations.
>
> Every CPU defined in the ACPI MADT table has it's own 4K page where the
> spinloop code and the OS mailbox resides. When selected the U-Boot board
> code must make sure that the secondary CPUs enter u-boot after relocation
> as well, so that they can enter the spinloop code residing in the ACPI
> parking protocol pages.
>
> The OS will then write to the mailbox and generate an IPI to release the
> CPUs from the spinloop code.
>
> For now it's only implemented on ARMv8, but can easily be extended to
> other platforms, like ARMv7.
>
> TEST: Boots all CPUs on qemu-system-aarch64 -machine raspi4b
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---
> Changelog v2:
> - Use shorter function names
> - Drop the use of atomics, they do not work on real hardware
> - Rewrite code and verify on real hardware that CPUs are spinning
>   inside their parking protocol spin-loop code
> Changelog v4:
> - Shorten names
> - Fix coding style
> - Drop extern from the headers
> ---
>  arch/arm/cpu/armv8/Makefile       |   1 +
>  arch/arm/cpu/armv8/acpi_park_v8.S | 113 ++++++++++++++++++++++
>  arch/arm/include/asm/acpi_table.h |  32 +++++++
>  arch/arm/lib/acpi_table.c         | 149 ++++++++++++++++++++++++++++++
>  include/acpi/acpi_table.h         |  10 ++
>  include/bloblist.h                |   1 +
>  lib/Kconfig                       |  16 ++++
>  lib/acpi/acpi_table.c             |   4 +
