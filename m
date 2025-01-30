Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F07C0218D
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 19:55:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8EA680F03;
	Thu, 30 Jan 2025 20:55:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hnJJGI+h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02FA980EED; Thu, 30 Jan 2025 20:55:16 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1A15820FE
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 20:55:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ab6f636d821so60885666b.1
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 11:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738266911; x=1738871711; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WcRpCJ8DzRMhcHk+sJjnnAeJC3ljehJNx0QbXjYfqHA=;
 b=hnJJGI+hDrmOfKSIFPYpbd8USLR65uaXABD88+L+nGwe1Vr3J+bcIO2v+ZPL4btA/+
 sE+sYC2tAn64vNVOtUw69re1Axu+dmxI3kjwM9LuDAOAPf1FLja/sec5PRkqZ6xjlEtN
 GAHtKGtg/nHzkQxXlHUrDhTO5F2bmHx2jpit0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738266911; x=1738871711;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WcRpCJ8DzRMhcHk+sJjnnAeJC3ljehJNx0QbXjYfqHA=;
 b=VT0QmWG20BOoSCqSZXG5WVcfJul9datg258Wm1rduX2IOcaoL9jHIajM0ZaRJZkZOf
 lfdXBhNGHY48bDdqq0v18lxUlo7TEl1/e/NJz8j4zvq5RobnZ+YWrvlKeo9zrWB/ComH
 9kQTqH+uI/AroKmlH0BxDw2k0+wJfoaSpGrakZSa5ZW2wQqmik39miNeYtR0DYucxBlg
 tgDd2fInESkDwLwgqOr1SgyaKPXqiPfePBDZqU2CDulZLv9l7Iqw+Glf9P8aChwXjeNz
 kF8ktI5HALzDS30CBr44XDe+A2SMEsTqVYbL9Vk2o47a/RfVS/Hl2oM6Xjcyw9tAWz4h
 qa6Q==
X-Gm-Message-State: AOJu0Yyzcc2QP3BnT1ehA5k1Y5LSx6Cs1VoyC8LNJVl2/f0kr5Jwa87c
 PPnoUPD0zcwa4jM5sqzR6Zsmqa29gybBgsEps9ZR+HaApMeIvB51Gm5YkJCPQ+Sv/eMGXGckIz9
 9u9mdfbUZKYGu40IhB2UEG/5f7ssfG2T8V9Qc0KEqifmuhlY=
X-Gm-Gg: ASbGnctRklE4FgaOtMU3OlGlC4dcJD9C69j5hEyWjcY+0zrGFsM6vYCOXMQiWXb9r8J
 ZiDUSXNrVjRZphnjt54RxbA3W3lVK8jmGsqfPlY5t9+NEzPllWHIvdQZJ9fQv+1EC3PO9kdemjg
 ==
X-Google-Smtp-Source: AGHT+IG1TFWchqjejciXzqnB7C0UhNZpk3yS7C7k97+0swq35sfZmmf6wQfu+MXOQ6/u7AhL9wqqKda0sX6hgs/I3m8=
X-Received: by 2002:a17:906:dc8b:b0:ab2:b72e:cf44 with SMTP id
 a640c23a62f3a-ab6cfc8730fmr889645766b.2.1738266910720; Thu, 30 Jan 2025
 11:55:10 -0800 (PST)
MIME-Version: 1.0
References: <20241220003447.2913443-1-sjg@chromium.org>
In-Reply-To: <20241220003447.2913443-1-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 30 Jan 2025 12:54:58 -0700
X-Gm-Features: AWEUYZlafKbesyC66jya54NnyS-t1TAwUyTH-sMlzDxU3_pB5R22RAegKlblsBE
Message-ID: <CAFLszThUo1u58Vwy77UEQZG79f7-BB2ysB5-oq-DHbP4c_ciRQ@mail.gmail.com>
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

We have hit rc1 now. Is there any interest in applying this series?

Regards,
Simon
