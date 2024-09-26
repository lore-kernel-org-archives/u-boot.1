Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18196CDE038
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 21:29:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34A7C88E1F;
	Thu, 26 Sep 2024 23:29:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kcHdkB/G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F5B088DB6; Thu, 26 Sep 2024 23:29:05 +0200 (CEST)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAAC188E1A
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 23:29:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-457cfc2106aso10332761cf.2
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 14:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727386142; x=1727990942; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G6B43CByv+MXscbytOIPxSjb2mJIX2EbQ7EayfBSe0c=;
 b=kcHdkB/GGaQoxsUj0WIWGN9zWSzcJs5iLIujSpYtxlnA0Eg8azgC2ZuRlprIJaV9H6
 IeYrM/M5eeLZnHihzlPELRnBzOSWJkJDc8Nukxq++XUYQcWrUSR7YBvjkwQ7J+ODAHvh
 4CMr2K1JS65P4ICOgkST/PAfqkvdxhgWJi5tE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727386142; x=1727990942;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G6B43CByv+MXscbytOIPxSjb2mJIX2EbQ7EayfBSe0c=;
 b=loKTzg1YXzFdvPLa4ukM51/VbyBOr7/cTauUBg221jfrDU9pWc0/jqMWoGauupyEOz
 8XQgX181RiqZZ5GZ9fxnnsVd0ng0LRbNJYHjuYFQhwX5FwIiw3l2pm9p0bwqqjQeq5Ut
 d/gNmP8Ej5HIQiGEw8BMdxHlsHq+KXsgVfj/Dkf8NRc/Gia7mTpiTgoPByzdihb4Cme0
 xsvl2Xdi2PjwUIOOOcQQdbv2eMTNxP3ZJHRGL3WLLdNu1JtCqVHiKsSpui9hltxkMPdj
 EXGiT0LkaxMN4x5lKC+cQnVsZ+397oyXjtO89hkst7FhgCFoCaI+cijZDR3HPSaG3vLT
 jb8Q==
X-Gm-Message-State: AOJu0YxpNgL41AQ5HAyV6XcNPGVmCwEui5hiW9rUEvv2+2fF492SE/JH
 M6qqAvGB8DtbiXLPRAJvTF8vP2fvkz6O3iQUR/jsAtJ54vrOYrdoEWEaPtc0grtcTTvY3yHHjtd
 WhynmCMzIEz2dAbT0lpyBcerOn+zhfqU69WVc
X-Google-Smtp-Source: AGHT+IEjoCydw+F+PoogY+2Zl2bhaaYXDW+qDdjaeJQ8TvBGHmQZ89K6dDRZDanpnMW+4ChnE/2HQuC5YKDJPN/If78=
X-Received: by 2002:a05:6214:4a88:b0:6cb:2143:9033 with SMTP id
 6a1803df08f44-6cb3b5dedfemr21531236d6.13.1727386141762; Thu, 26 Sep 2024
 14:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240926080021.148031-1-patrick.rudolph@9elements.com>
 <20240926080021.148031-31-patrick.rudolph@9elements.com>
In-Reply-To: <20240926080021.148031-31-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 26 Sep 2024 23:28:50 +0200
Message-ID: <CAFLszTjMPD2ea-VUpJzufVDMBWqdLC8UfZayCORk7U2UiMdaxA@mail.gmail.com>
Subject: Re: [PATCH v5 30/36] arm: cpu: Add ACPI parking protocol support
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

On Thu, 26 Sept 2024 at 10:03, Patrick Rudolph
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
>

Reviewed-by: Simon Glass <sjg@chromium.org>
