Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD6A3CF3944
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:15:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64C8189232;
	Thu, 19 Sep 2024 16:12:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YTkKEqwC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE207891DD; Thu, 19 Sep 2024 16:12:21 +0200 (CEST)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F16818921A
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:12:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-71923d87be4so656535b3a.0
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726755136; x=1727359936; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8pCE5+oRpoBemw81XFrnN/m9o0DPWaXGmYgVC9viNBQ=;
 b=YTkKEqwCvmQdx4jtVvhPq3CbDO7iBEAvpd24C9Iy4vU3ea/DrMnpkzQZrS6MJ3DeQc
 RPVwkY6uhzLU0JPn7mDZzSA0UbE2NaR4QbDJAvxaM8fEUl4qAFeuvlfSCl/t/vO2fjm7
 7xbo8XsGi5n827Z8QiCKX8UblKeFlpC9y+S1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726755136; x=1727359936;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8pCE5+oRpoBemw81XFrnN/m9o0DPWaXGmYgVC9viNBQ=;
 b=MW20oIcmuLM7tyS72Z932ITKNIgkI3ouZcNLSbVu0BlYn+oxUmTdDPN4wfBT+hyUEh
 v1AWmnUAn1e9Q2ytkaFS4Q3Gi3gseueqFKLwX2G4UkSqzOai/hokLoZCpmgPjVAlPTpi
 jS+5b3nXZ3cHYzFItG6gYcV6p+sp7/XRsL/p+uMNFWNvkamy/7awNb5x2zFuemEqVYip
 ofWzZBxSoMj9OVJYBB6GCYs7AQgb+AA1WzHBpXINFSsSCQqHKF6kk7b4bvZHoHwnjWZ4
 icniUy9QelL5wqdnW7862Lrb6OyPkedRxdG7LD8rG21XfLVSocCjzsonlTFiqOombqId
 2FvA==
X-Gm-Message-State: AOJu0YyHyljkc0+7t3fKTl+bZ3fT1icxKf5hpyoxAtjW9mPQZci5BuLh
 IHtoRMFqk12iBXuS2XPyw4eyo1sqCayZzKfBicHka8ccqGMDGaMIZc2ILVXg3PdBCqHlRWuRDus
 +Huw2CAhAr4nejYw4sAHB+vpEEbnWf8hQrGyu
X-Google-Smtp-Source: AGHT+IE6Qb4N2RWq4fO0vjW+fhVjhc5WDCiH+LNda/EkHudyixUbAIezS89x44wc/sLa5kj47f1rJoS+J2pyJ0muATc=
X-Received: by 2002:a05:6a20:c908:b0:1cf:3c60:b8dc with SMTP id
 adf61e73a8af0-1d112e8bf6bmr33562453637.34.1726755136571; Thu, 19 Sep 2024
 07:12:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
 <20240918152136.3395170-29-patrick.rudolph@9elements.com>
In-Reply-To: <20240918152136.3395170-29-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:11:52 +0200
Message-ID: <CAFLszTiwmZhAK+xGFTT-3nDeDHmv5tqA5_ZVc61NYa9-M-VsNQ@mail.gmail.com>
Subject: Re: [PATCH v4 28/35] arm: bcm283x: Generate ACPI tables
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
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

On Wed, 18 Sept 2024 at 17:22, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Generate SoC specific ACPI tables for BCM2711:
> - FADT
> - PPTT
> - GTDT
>
> Board specific tables like DSDT and SSDT are added in a separate patch.
>
> MADT is already properly generated from the FDT.
>
> When ACPI is enabled for a different SoC compliation will fail by
> design, indicating the required functions that needs to be implemented.
> When ACPI is not enabled the added code does nothing, keeping existing
> behaviour.
>
> TEST: Booted on RPi4 with only ACPI enabled, providing no FDT to the OS.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Matthias Brugger <mbrugger@suse.com>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> ---
> Changelog v2:
> - Drop duplicated code to generate ACPI tables. Is now part of efi loader.
> Changelog v4:
> - Drop acpi_fill_madt() as it's now generated by drivers
> ---
>  arch/arm/mach-bcm283x/Makefile       |   4 +
>  arch/arm/mach-bcm283x/bcm2711_acpi.c | 128 +++++++++++++++++++++++++++
>  2 files changed, 132 insertions(+)
>  create mode 100644 arch/arm/mach-bcm283x/bcm2711_acpi.c

Reviewed-by: Simon Glass <sjg@chromium.org>
