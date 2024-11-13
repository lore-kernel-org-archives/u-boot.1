Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA16D597B0
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 13:39:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1311588FED;
	Wed, 13 Nov 2024 14:39:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ERBV0qfk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFF8289023; Wed, 13 Nov 2024 14:39:27 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3457B88FC8
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 14:39:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-aa1e87afd31so196627466b.3
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 05:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731505165; x=1732109965; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QM2ZklF9FFa2T4Rhcg6mZzEgwDSytXj6GZXfjZ2SAZA=;
 b=ERBV0qfk6tqPfqayWx2pSxbcysJo+Bm0xukA9EeZ1lXqiF4rUby2EcqBUoYSCdvL4z
 44Y3IGfa44OfHkc1qYJLabMTl69jXFZAKbibUMHGz7lk6UMsVeZPO4ufe+zI57Sog3xi
 RGZuuygmfs659w9ebwb24/PsCMsH1h65h+YVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731505165; x=1732109965;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QM2ZklF9FFa2T4Rhcg6mZzEgwDSytXj6GZXfjZ2SAZA=;
 b=jOGvQ/EXeElsV9mTyUhCZMWr/OghrxakTSXIaI4fxu2EJrzjNw2W7t5W0Kjq0bToWA
 bZ4q9Bu3u52zXaNDtdlf3UCvvjfQZCA7HJy+63KnCF9e69qDtSCMMjOEF3PxhtoTNHzq
 Uqu4uAHm00cNagkIOlizjE5qPio/7ftnRvi/O4TtEHweG9zdZzFI0ClacyOeKxrbhpQ+
 SAAurYSK22wRNXE40t/MkbJJmdZlfjS44N7JsY758rD2GgWk4+GJddz9cwRh++PqZwU+
 BvXgt9IgiYrP6/efUWjMQfppXqSsyaBdz/QFy4sjwSrtuLeRCmDot0WSd7Tv5j94WNQm
 IM9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRB2AuJUBMJhl2UGDb/KdKiGPpD7gePRl/+DYDSidzHJ4OJniDtGOL5Yr1KiqYBRDC15OZgW4=@lists.denx.de
X-Gm-Message-State: AOJu0YzikIvxFm9gTRZUBYuypxiG5fOFUkrP2eUjjrBmmJ4dR/qevWK9
 sP01yZzRCzQF6XAwWyg3H04picp1sl7NiqDHoqoNN3bhyJCQ5wZCS5gPD7Y/oZmJvdwdx2ri/sH
 7Nna6E3k8ie85JeU6qjt5e6dKrWpqSIUPR1LP
X-Google-Smtp-Source: AGHT+IHwx6Wa+H0G1SAurjqA6+SPRYPpOed3/db3f648Du2HoJDKW4mGJa3PHln12ZapGVoXcnFGIshJPFM3aOVl8DU=
X-Received: by 2002:a17:906:2788:b0:aa1:e04f:e339 with SMTP id
 a640c23a62f3a-aa1e04fe5eemr455357266b.7.1731505164590; Wed, 13 Nov 2024
 05:39:24 -0800 (PST)
MIME-Version: 1.0
References: <20241113042536.1792150-2-caleb.connolly@linaro.org>
In-Reply-To: <20241113042536.1792150-2-caleb.connolly@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Nov 2024 06:39:12 -0700
Message-ID: <CAFLszTiQcXU-UBJtnj5FsHziGg81J3iSX_W9zVuMQkw247cOtw@mail.gmail.com>
Subject: Re: [PATCH v2] cmd: add a fetch utility
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>,
 u-boot@lists.denx.de
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

On Tue, 12 Nov 2024 at 21:26, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Add a small utility for displaying some information about U-Boot and the
> hardware it's running on in a similar fashion to the popular neofetch
> tool for Linux [1].
>
> While the output is meant to be useful, it should also be pleasing to
> look at and perhaps entertaining. The ufetch command aims to bring this
> to U-Boot, featuring a colorful ASCII art version of the U-Boot logo.
>
> [1]: https://en.wikipedia.org/wiki/Neofetch
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> Ephemeral screenshot: https://0x0.st/XkQU.png
>
> Changes since v1:
>  * Rework storage info to be more dynamic
>  * use print_size() helper everywhere
>  * manually walk RAM banks to report memory size correctly
>  * minor formatting changes and fixes
>  * MAINTAINERS entry
>  * V1: https://lore.kernel.org/u-boot/20240808163153.2069650-1-caleb.connolly@linaro.org
> ---
>  MAINTAINERS  |   5 ++
>  cmd/Kconfig  |   7 ++
>  cmd/Makefile |   1 +
>  cmd/ufetch.c | 224 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 237 insertions(+)
>  create mode 100644 cmd/ufetch.c

Reviewed-by: Simon Glass <sjg@chromium.org>
