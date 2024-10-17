Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D6ED3C538
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:19:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49ADE891CF;
	Fri, 18 Oct 2024 01:18:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Xkprbc7x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDB38891D6; Fri, 18 Oct 2024 01:18:27 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1702891D0
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:18:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7b149ef910eso131839685a.3
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207104; x=1729811904; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+VpXJAf2olBDFPk9Ir/MUxsakvNXZ/Zf72BuNsr2h2c=;
 b=Xkprbc7xVPFd4G2txVBmfffJ1gZYOEGTxFfK/caqRFcaSdC4FWm88Nh/LAlpGbhxLT
 D94AUelj7kL62I9qBw/Zwidnq5U7EXiMIH58LJhw//hDrxTvSG9j09xWCVIApLMUVoHS
 f9VgfjBqAUI14J6WD21OnSDAsKdxonM0DgmcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207104; x=1729811904;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+VpXJAf2olBDFPk9Ir/MUxsakvNXZ/Zf72BuNsr2h2c=;
 b=NRv08LmOpcqGlS/dVW/vxlMnTKaqglJXvHBfE13N3flJSGQFQtbapGRGWhnunrdixF
 PEmS8x8SETC186iJXIIRLFenej0ND4C6l5+t2wyzeWgNanmOLrnGnHg2zMxQArUlonFX
 OHQTSrDRF+78LlcWAF3JZ3tK8I3grlsonWXdqIGYXB9KcBB18Bg17nIWWamlI02KUIPy
 HWxvk07uPL3MJzbuMQCbaSrLaaBSWolR89LTODHNY4+H3Ys6BWCb7DGtt6fixTh6fioq
 CTIjJfAK9eXFThmI/Qo9YIibsn82DFYjPt9J3vO2WIH/dOrti2GRh6YNxOP9RzNp30YY
 ueUQ==
X-Gm-Message-State: AOJu0YysbfT48Uvh7VIzlOGrWRY+/UL3W9/ZqWlnE+S0I87oBo3OZUxv
 0bjFzknOZqYXm0lvbs3emxqfo0GRTWzYVT0LzAFMYTz3e7YnE3OsosO6ZKxGL+ECXWw7qo4jJiL
 2TDM55RkqbP3n+VbNHD2Gr8w5X2ogKRHmhmEX
X-Google-Smtp-Source: AGHT+IFlcT18PpG7PbQBBxk4kaBXmBEniYmtijnljhBO0tJhynvzZsx+At5V0CNT65CoBpfag2zkyKZ9vgH+3VcF37o=
X-Received: by 2002:a05:6214:4a04:b0:6cc:1fe2:18f9 with SMTP id
 6a1803df08f44-6cde14d7f62mr9077796d6.14.1729207103747; Thu, 17 Oct 2024
 16:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <20241016060523.888804-1-patrick.rudolph@9elements.com>
 <20241016060523.888804-22-patrick.rudolph@9elements.com>
In-Reply-To: <20241016060523.888804-22-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 17 Oct 2024 17:18:13 -0600
Message-ID: <CAFLszTjCXpA3JzjruoOpXP-MXaW-6_AVZ3gjX0sQYadUug_Y6g@mail.gmail.com>
Subject: Re: [PATCH v9 21/37] arm: lib: Add GICV2 driver
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
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

On Wed, 16 Oct 2024 at 00:16, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Add a generic GICV2 driver that:
> - parses the DT and generates the ACPI MADT subtables
> - implement of_xlate() and allows irq_get_by_index() to return the
>   correct interrupt mappings
>
> Map DT interrupts to ARM GIC interrupts as follows:
>
> - Interrupt numbers ID32-ID1019 are used for SPIs
> - ID0-ID15 are used for SGIs
> - ID16-ID31 are used for PPIs
>
> TEST: Booted on QEMU raspb4 using GICV2 driver model generated MADT.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> ---
> Changelog v6:
> - Update header order
> Changelog v9:
> - Map SPI interrupts to ID32+
> - Map PPI interrupts to ID16+
> ---
>  arch/arm/Kconfig      |  7 ++++
>  arch/arm/lib/Makefile |  1 +
>  arch/arm/lib/gic-v2.c | 89 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 97 insertions(+)
>  create mode 100644 arch/arm/lib/gic-v2.c

Reviewed-by: Simon Glass <sjg@chromium.org>
