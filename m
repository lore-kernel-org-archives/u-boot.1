Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4009C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 14:09:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D91A8060C;
	Wed, 15 Jan 2025 15:09:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aJeDm+xw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDAD180657; Wed, 15 Jan 2025 15:09:53 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC88480269
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 15:09:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ab2bb0822a4so1361404466b.3
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 06:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736950191; x=1737554991; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0H7BezpcJA29i+ZtxhsgBJ8vndZeAPlKY5BapMfJJ7w=;
 b=aJeDm+xwudaGYDO5fpbVROOfhG6C9plutoqGyT0p/ksmrEXLKqyLnTQnOM+YDXIOat
 1RASV2pgxQ0lq3SkMEPnDDKIEaQNABoV4K4EOCZO4rittD/kETszQr/eQOc1CTjsKhg0
 Ktut5Bja07HJi9+iYlShtYzCNUXmBvhsfXOrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736950191; x=1737554991;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0H7BezpcJA29i+ZtxhsgBJ8vndZeAPlKY5BapMfJJ7w=;
 b=TGzYMKfUCbjGl7ArQ6gJIGetNftZQeyCPjVgWhbR5OmJxB7fSXQcfiv/KYQLqJpEhx
 6e1XNr35iowJeb1/eFwgM3Beb7/YVpI5raL0vK+uzPg4o94i0ECtha77sKfj0KBNPTyL
 e+gCwFaNJwxrtDuyY5sLMTNBaOZM8X7Uw/zKrEVT7SZFOnnI7aNIPIul0lPQT8PxZH4A
 4/h4gLUNzvp4kIjlWYDadICXLveicgGmnPljnmzPAMGWjbT9E3QAktX0MtQf3a5wvhIF
 No6pEzbfWkYBGAsPW8Hlvop5K+JTiwe3Hv3MYLpaUu3kFfRQ/VXj6WFBi9/Xc6vD4e/i
 TFdQ==
X-Gm-Message-State: AOJu0Yx7krTHle0tKkZHIi/+PZEwvU5HjyLln9JKG77xMjDJSCVaubE4
 Ixlg7vJykCUPoFrbo7uTm0lsa9ph4UFrwcWSBRfbMiU6tWVppJJRR5lQo8z4t31O5uxjaa8og4M
 AMi2bzyEDrPuMATBGx4+Acnfvne0nXfq6qKhn5cicPqMhtFI+4Q==
X-Gm-Gg: ASbGncsRHvDJxjuIWj0Y+IlUl7SicT4qk7cTWVzFfQHrZzlVf5xtwWr2dVlXnklBaTp
 pWHko87ZZ4ic+gV8XihqRVNFEZmqHlFMQvEIqN5k=
X-Google-Smtp-Source: AGHT+IFU8ky4c4IgjCQKPOezK6A0ifDn99/wK7BQzVSCKQebKsQNS4/F7OtMqm/twilH+QIRvTC8KSg/j8rERErB6o0=
X-Received: by 2002:a17:907:7f1e:b0:ab2:f8e9:723c with SMTP id
 a640c23a62f3a-ab2f8e977e9mr1543993166b.5.1736950190768; Wed, 15 Jan 2025
 06:09:50 -0800 (PST)
MIME-Version: 1.0
References: <20241220003447.2913443-1-sjg@chromium.org>
In-Reply-To: <20241220003447.2913443-1-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 15 Jan 2025 07:09:39 -0700
X-Gm-Features: AbW1kvYMaTW-zb3weBIK_J8t-othf7pyYtVS3VH3RCJN7AHz2peocZk-X3Vo8vg
Message-ID: <CAFLszTjvATq3mCkOmgnAGKtm7K9GNDV+9iSAUNto1xvAyREjAg@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] rpi: Tidy up booting
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Stephen Warren <swarren@nvidia.com>,
 Matthias Brugger <mbrugger@suse.com>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Francois Berder <fberder@outlook.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Ivan T. Ivanov" <iivanov@suse.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Robert Marko <robert.marko@sartura.hr>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
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

Hi,

On Thu, 19 Dec 2024 at 17:34, Simon Glass <sjg@chromium.org> wrote:
>
> This series allows rpi to boot a compressed Ubuntu kernel with ~100MB
> ramdisk, by expanding the available space.
>
> It also tidies up some strange behaviour with the provided FDT, where a
> separate pointer is maintained to it, even though U-Boot has copied it
> and placed it in its own space. This avoids strange bugs where it
> accidentally gets overwritten when loading a file into memory.
>
> The patch to expand the devicetree was dropped, meaning that people
> should be careful to unset fdt_addr in the environment.
>
> In version 2, it incorporates some changes to fdt_addr, etc. suggested
> by Tom, as well as adding myself as a maintainer.
>
> Changes in v4:
> - Expand the comment on set_fdt_addr()
> - Update the commit message to talk in terms of my testing
>
> Changes in v3:
> - Add to the existing comment block
> - Update the comment block with the new values, including compression
>
> Changes in v2:
> - Add new patch to make myself an rpi maintainer
> - Add new patch to set bootm_size
> - Add new patch to drop fdt_high and initrd_high
> - Drop patch to allow expanding the devicetree during relocation
>
> Simon Glass (5):
>   rpi: Add myself to the list of maintainers
>   rpi: Set bootm_size to 512MB
>   rpi: Drop fdt_high and initrd_high
>   rpi: Update environment to support booti and large initrd
>   rpi: Use the U-Boot control FDT for fdt_addr
>
>  MAINTAINERS                   |  1 +
>  board/raspberrypi/rpi/rpi.c   | 20 +++++++++----------
>  board/raspberrypi/rpi/rpi.env | 37 +++++++++++++++++++----------------
>  3 files changed, 31 insertions(+), 27 deletions(-)
>
> --
> 2.34.1
>

Are there any comments on this series, or can it be applied?

Regards,
Simon
