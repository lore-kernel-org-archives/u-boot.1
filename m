Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5295DCF8547
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 22:56:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CAFB88F99;
	Thu,  3 Oct 2024 00:55:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CslZ/aCm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 355EA88F7B; Thu,  3 Oct 2024 00:55:49 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D76988F5B
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 00:55:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6cb259e2eafso3484516d6.0
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 15:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727909746; x=1728514546; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rMRopE6krSnU6XvDHAl02/lCef9w2zRiY/FnA+aoU+8=;
 b=CslZ/aCmuJUQb+jqRQKc6E4xXjgYCaHFn8sweMBWxLKI3uGVFiYiY+s119qVEhUHPD
 b/4rtklGOeqK9dtsE/CkqQO2kQS+Ktnw/qDTvlKj+h04/TRmmJzEm1w4JTexD5CsfG/6
 95gC7vEFz1m8IR0p8XRb718MTUGFBvTU/Bfj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727909746; x=1728514546;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rMRopE6krSnU6XvDHAl02/lCef9w2zRiY/FnA+aoU+8=;
 b=n84r/uso51o5XUEQ4XtXEU+Va6HSheI3x8A6tFaDKEtAyBXua7VM4DuYfmFWSuNlSm
 3JmViHDGU8/4zkW6YunBqV2Kg6z4L1EoW/eWmcFoPMKg7RtphNxY0BGXTB/zUr+xjL56
 yOTT1A3h3FXJoXwvYrfTW8+qNL3vsqIGK/RHEUmUAhx7xOhm7IlU69ov/9flFHoL/74X
 gvyeE5RLUwaKhpt0eRzj62n+O+7m3RMSc/ehxHUNWZjB0P4E1cw3NWT/BVAK4yMrHTlB
 Nhg/H8MIlPiTnCtM3GLar9ipirpybVjMVSGRRI+f05rlvDMSIGA7ZI4yGvjmFFVf9g1r
 iNhg==
X-Gm-Message-State: AOJu0YzZG3Jjl8fe4Wt65RHv1Y+KRfgDKFjrHyuFyZDnX2w+HoIFI2qx
 sq8ig40RcI+8SqcBOULg8bgs6LdKgM7/bYAh6D1Xlhj+HufucAq78ncIdYdSjqFnaMMySyWhS5s
 EIr4vpIrCkyI3h+92lbevcb/Dzhyiif8ul/Yy
X-Google-Smtp-Source: AGHT+IEotBABRfhE3J2xBkU0aF0DYIwOIXmQEgeIWx1emwOSg1Mf1mEMoIy/GK5Y514nQIf2A/GTuNfA8ZSiQE+YCyY=
X-Received: by 2002:a05:6214:18ef:b0:6cb:3644:8bca with SMTP id
 6a1803df08f44-6cb9012325fmr22720156d6.14.1727909745944; Wed, 02 Oct 2024
 15:55:45 -0700 (PDT)
MIME-Version: 1.0
References: <20241002094832.24933-1-patrick.rudolph@9elements.com>
 <20241002094832.24933-31-patrick.rudolph@9elements.com>
In-Reply-To: <20241002094832.24933-31-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 2 Oct 2024 16:55:35 -0600
Message-ID: <CAFLszTh7hnvYWvyC-h1STbrdGc9CTb19021G_V0L2H7Wgnkh-w@mail.gmail.com>
Subject: Re: [PATCH v6 30/37] arm: cpu: Add ACPI parking protocol support
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

On Wed, 2 Oct 2024 at 03:52, Patrick Rudolph
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
> Changelog v6:
> - Update header order
>
> ---
>  arch/arm/cpu/armv8/Makefile       |   1 +
>  arch/arm/cpu/armv8/acpi_park_v8.S | 113 ++++++++++++++++++++++
>  arch/arm/include/asm/acpi_table.h |  32 +++++++
>  arch/arm/lib/acpi_table.c         | 149 ++++++++++++++++++++++++++++++
>  include/acpi/acpi_table.h         |  10 ++
>  include/bloblist.h                |   1 +
>  lib/Kconfig                       |  16 ++++
>  lib/acpi/acpi_table.c             |   4 +
>  8 files changed, 326 insertions(+)
>  create mode 100644 arch/arm/cpu/armv8/acpi_park_v8.S

Reviewed-by: Simon Glass <sjg@chromium.org>
