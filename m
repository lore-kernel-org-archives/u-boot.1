Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202EEEE57F9
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 00:59:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8937888D13;
	Thu, 12 Sep 2024 02:58:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k8PWLeOk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF1B988D52; Thu, 12 Sep 2024 02:58:48 +0200 (CEST)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AB8088A43
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 02:58:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-718d606726cso217947b3a.3
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 17:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102723; x=1726707523; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=shqVvtwfqisC68tkusOFx9PToUyx7bNEpQ7SFFdAoTo=;
 b=k8PWLeOk232kNuKwpaaM1lzkZTOdwMHshm1aoryjv43O6fFQOj1q4JyKkyNarIVMRP
 HK/slv5kfoUad3YUWDa3ylRkq62TK1dZJhxCAPIk9KmVY8rikO1j+gffnHwpwgQP8uLo
 CsizVbfDwzY/nLiIy64evXsuGNhZKwCdNZi6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102723; x=1726707523;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=shqVvtwfqisC68tkusOFx9PToUyx7bNEpQ7SFFdAoTo=;
 b=jIC4pGIb9qMCqNJtNPp1YhtEqbCo0Ahh+Xz6IJUh2bD4dnPrUlhVvLRTOCM5JyMFtf
 yswTFCqHTui2jvwbJnMzB+C5YnzfUENdYoYNvI8YDnu4BjADHbd1k7X/8cJW8+Ured1z
 CH0jbZYou/4Ds9BgQkmGG6Wu/BNVDmQKw0vOUvDlGutHUGsfx2qMBWNbwC9Iy0RD+7IO
 aRsK1+bQtrou+eq+x99WDGVV5Tf4SDSXiiQDEholG/Rb1NfHplXAhAlmGeBQBb9yqzYk
 u9NfvAMhDr1g39Zl7CUTuk83017I9oFz/ICuKyqeLxrEu0lGkoPcFTJ1W07k50rU84mL
 xi6Q==
X-Gm-Message-State: AOJu0YxrjfjCy1KudCVkp5vUol/nlsJXnhsCYxnxVDGwCK7ZEMoiRDda
 ve2odJBBAKH/dg2pVuzydSEvT4EPRjUQ4vrnbLy5bxOeEkzqmm3URWZGdu/JNTeqIS4H+q4F/dS
 9VpkowBfl0Vnw/NEZmg7ZkHayMIuvV8Suib3rPN/FcGBaUls=
X-Google-Smtp-Source: AGHT+IE4yMAHQ+WKH6adYr+d5AnUxg5ZR8/xOpaN6yJ6rzW/xqXyDvP5dPDveGIj2XJwUMVXjSq1euVEcsqTEnxQGG4=
X-Received: by 2002:a05:6a00:9a0:b0:710:6f54:bc9c with SMTP id
 d2e1a72fcca58-7192606564cmr1762809b3a.2.1726102722863; Wed, 11 Sep 2024
 17:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-21-patrick.rudolph@9elements.com>
In-Reply-To: <20240911062511.494855-21-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 18:58:21 -0600
Message-ID: <CAFLszTgYrEk=UBd6zgesphC+rLPtkOG4fjBOYaGRQXYLNUomyA@mail.gmail.com>
Subject: Re: [PATCH v3 20/30] drivers/arm: Implement acpi_fill_madt
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

Hi Patrick,

On Wed, 11 Sept 2024 at 00:25, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Fill the MADT table in the GIC driver and armv8 CPU driver to
> drop SoC specific code. While the GIC only needs devicetree
> data, the CPU driver needs additional information stored in
> the cpu_plat struct.
>
> While on it update the only board making use of the existing
> drivers and writing ACPI MADT in mainboard code.
>
> TEST: Booted on QEMU sbsa using driver model generated MADT.
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  arch/arm/lib/acpi_table.c |  1 +
>  arch/arm/lib/gic-v3-its.c | 89 ++++++++++++++++++++++++++++++++++++++-
>  drivers/cpu/armv8_cpu.c   | 27 ++++++++++++
>  include/cpu.h             | 27 +++++++++++-
>  4 files changed, 141 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Are the GIC values available by probing, or are they just 'known', and
dependent on the compatible string?

Regards,
Simon
