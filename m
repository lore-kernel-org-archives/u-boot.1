Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1232ACA0ECC
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 01:06:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14A1A88D25;
	Fri, 30 Aug 2024 03:06:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Zh0gL4EA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7457D88D4F; Fri, 30 Aug 2024 03:06:24 +0200 (CEST)
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com
 [IPv6:2607:f8b0:4864:20::a36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33DE788D31
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 03:06:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-4fee7fa19c8so382945e0c.0
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 18:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724979981; x=1725584781; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kyC1GC5ZQ1P4cnWmoS6M27s5JHVQqkw94ml6aJo0hOY=;
 b=Zh0gL4EAXeLAwdwt56FmGBN6g0E4rPpOIfZnwy4+oLcLKZeiI8erq8ZDj5yQz9ZmKI
 4QM4whoWj3BfsvVRvweiMjbShx72FxzcTXZaT6v9aXPrUGBIyS5Fq7dea5PHqenbHKUy
 I+P4GtufLytPuum+o0z/agQUXWSYc5ecvDZZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724979981; x=1725584781;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kyC1GC5ZQ1P4cnWmoS6M27s5JHVQqkw94ml6aJo0hOY=;
 b=GSQCobsHB3fvvOdh0lYYaMlXNhAeygAxZDN9tnnjcLJ1DmjSHDhJfxD+HM3Kg6QAIC
 WJGTydDLNh1JmP6YUpCcUJ2pQe7rwY5vELzYBljk9nHkHruLEJmo21jrLEza2GetkU8/
 pqy/eMbyjfOvHrIh1EF73nBDQWNn+/5UyK7pMnbRYo54/axOKOG7Ny7UOEBfuqBk3Nk3
 vCwma7ZA89OisDS6285ZqlCwFEIFnjulyzcuDQitVbC10cbq+4cBcDnyW5GHBWm60Ukm
 XETa1lvOXD1CBEf6xX2G5Uv7PQkxPN+hPNJ5ZlHcK4TjA3ZR6EuzNeDFU/lTewAHDGQ9
 fbDg==
X-Gm-Message-State: AOJu0YxRMs1aK9H8wfVruuX9dJ+7eJ8GoU378hBHlIHDo9EKrwh+muHs
 9i/wMKiS9D+CM43fF+lIeHZiyR496CXGLw1LZZm2FZb7u/YlnJdrizMrNg3BA7EapV/ZF09ZbHi
 g21p00XKo4OW0yeOYQW7Rn3pAGH3GQicePIyJ
X-Google-Smtp-Source: AGHT+IEju0GZkJrzW10pdrxY9PVDp84mssI7rdceGurMhGFHme7fnUuHT517fqc/dib+maQ/3NTzeISOK2xoep6gTqo=
X-Received: by 2002:a05:6122:3190:b0:4f5:1978:d226 with SMTP id
 71dfb90a1353d-4ffe4a59000mr4934063e0c.3.1724979980991; Thu, 29 Aug 2024
 18:06:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240829185620.3179866-1-trini@konsulko.com>
In-Reply-To: <20240829185620.3179866-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 29 Aug 2024 19:06:10 -0600
Message-ID: <CAFLszTgaYBh-YGf2my1s=eTNbFmdV9-Yq+zNB6YUd5YfVfwcYQ@mail.gmail.com>
Subject: Re: [u-boot-test-hooks][PATCH] labgrid: Add wrapper scripts around
 using labgrid-client for device control
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Edi Feschiyan <edi.feschiyan@konsulko.com>
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

On Thu, 29 Aug 2024 at 12:56, Tom Rini <trini@konsulko.com> wrote:
>
> From: Edi Feschiyan <edi.feschiyan@konsulko.com>
>
> General usage for these hooks is documented in the README.md file. In
> terms of implementation, To start with, we add a common file to ensure
> that all required environment variables are set. Next, we add a console
> script which calls labgrid-console. We also add a reset script that
> behaves similarly. For writing files a wrapper around using
> labgrid-client sd-mux is provided and then both Raspberry Pi an TI K3
> platforms have writers provided. Sample board conf files can be found in
> the bin/konsulko-labgrid directory.
>
> Co-developed-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Edi Feschiyan <edi.feschiyan@konsulko.com>
> ---
>  README.md                                     | 13 ++++++
>  bin/common.labgrid                            | 35 ++++++++++++++
>  bin/console.labgrid                           | 24 ++++++++++
>  bin/flash.labgrid.sd-mux                      | 31 +++++++++++++
>  .../conf.am62x_beagleplay_a53_na              | 30 ++++++++++++
>  bin/konsulko-labgrid/conf.am64x_evm_a53_na    | 30 ++++++++++++
>  bin/konsulko-labgrid/conf.rpi_4_32b_na        |  1 +
>  bin/konsulko-labgrid/conf.rpi_4_na            |  1 +
>  bin/konsulko-labgrid/conf.rpi_arm64_na        | 25 ++++++++++
>  bin/reset.labgrid                             | 24 ++++++++++
>  bin/writer.labgrid.rpi                        | 46 +++++++++++++++++++
>  bin/writer.labgrid.ti-k3                      | 35 ++++++++++++++
>  12 files changed, 295 insertions(+)
>  create mode 100644 bin/common.labgrid
>  create mode 100755 bin/console.labgrid
>  create mode 100644 bin/flash.labgrid.sd-mux
>  create mode 100644 bin/konsulko-labgrid/conf.am62x_beagleplay_a53_na
>  create mode 100644 bin/konsulko-labgrid/conf.am64x_evm_a53_na
>  create mode 120000 bin/konsulko-labgrid/conf.rpi_4_32b_na
>  create mode 120000 bin/konsulko-labgrid/conf.rpi_4_na
>  create mode 100644 bin/konsulko-labgrid/conf.rpi_arm64_na
>  create mode 100755 bin/reset.labgrid
>  create mode 100644 bin/writer.labgrid.rpi
>  create mode 100644 bin/writer.labgrid.ti-k3
>

Reviewed-by: Simon Glass <sjg@chromium.org>
