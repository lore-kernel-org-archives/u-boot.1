Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9049ED2E9E4
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 13:03:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B05E89386;
	Mon, 11 Nov 2024 14:03:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KNkE3jz9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A990589365; Mon, 11 Nov 2024 14:03:43 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3CD888F41
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 14:03:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a9a0c7abaa6so588657066b.2
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 05:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731330221; x=1731935021; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oQtfyBlinmi5xGwk/HSWIfDw0s8hF5dSF6JcLORr2Pk=;
 b=KNkE3jz9DaiBNIMFflxYPNeZN1MZfXsIRTSPgsu0chL/DTuo+9YYiRIKFkUGCbETMZ
 c7GKZGfA8ZRUakWYmD1YtWzIB06rjFy6Px6Zbq6MIdeurYCWvhmEAhauk2A433qLmTRB
 GzERWkGHBN7U/nbB8OZa9vQWNyX8mUMtH9Uko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731330221; x=1731935021;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oQtfyBlinmi5xGwk/HSWIfDw0s8hF5dSF6JcLORr2Pk=;
 b=wTGAvhEZ7vguuoNnH1G8siIbvKYvO/QUM79vZBZFRyeo2LsKyYwMNrlZp6Ic/fAZGU
 gAWeH2zLb2HaTeFsuqYTZs9ADftddL2d7FlUFhEMxA6vSSZenZ0fzN/MxUijKx6PeT0n
 AFxHHh0vIJh23oUDP+YNKZJUqrI7OInt+ln7yyiq81N85yrCPv7rjXx2lFF/l8CSAtvI
 XJEaMAqZn2Ex07wxX/ZbeffExd7GtTF3mdcJkjK8kntMqtqVIKqbBz1+jazQKZwWhuM0
 eV+eX//tQyYFaFZ4FI1ox1zWXHufVIzW7wZnHSS0qVHhK4QvoE1nUsio6o9JiAUfO7HE
 t4Ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaGaeNArXXMkTc67SJuAJGGfi7CPaxJ5LgToe7XtiVQWqw+pNYU0F4XbIXH8OatRp4RymxTr0=@lists.denx.de
X-Gm-Message-State: AOJu0Yx+PLrJQreMETBrnqzgFgJB4GJr0qysIZ1FbICsQGh5uLdXsjFH
 Ic3rGKrBiEV2KxPH+GV8RZW8dj/oQ+oJxHT9VZfbSnjZC+ZDbEoXS9YMfLfNjGAd5IkPoED3R0G
 aFoAyL4N9A2aggiwXa6u5qKREzSBH7IgBAXyS
X-Google-Smtp-Source: AGHT+IGcJ7jEHthO8gJ28wkihQctvCJlGRa518kzACjWPB/vx2XIeyPqqvjA5zpWuz3I58l/5YI5kQRoqmA/1rs2/Yk=
X-Received: by 2002:a17:906:6a20:b0:a9e:26ad:d0a with SMTP id
 a640c23a62f3a-a9ef001973cmr1330862466b.58.1731330221094; Mon, 11 Nov 2024
 05:03:41 -0800 (PST)
MIME-Version: 1.0
References: <20241110083017.367565-1-ilias.apalodimas@linaro.org>
 <20241110083017.367565-5-ilias.apalodimas@linaro.org>
In-Reply-To: <20241110083017.367565-5-ilias.apalodimas@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 Nov 2024 06:03:27 -0700
Message-ID: <CAFLszThNpU2cNNvU4uT2vkgFKJr7ss=j_UYfXTFXA_b4=LnurA@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] net: lwip: Enable https:// support for wget
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: jerome.forissier@linaro.org, Anton.Antonov@arm.com, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Jonathan Humphreys <j-humphreys@ti.com>,
 Wei Ming Chen <jj251510319013@gmail.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
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

On Sun, 10 Nov 2024 at 01:32, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> With the recent changes of lwip & mbedTLS we can now download from
> https:// urls instead of just http://.
> Adjust our wget lwip version parsing to support both URLs.
> While at it adjust the default TCP window for QEMU since https seems to
> require at least 16384
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  cmd/Kconfig      | 19 +++++++++++
>  net/lwip/Kconfig |  2 +-
>  net/lwip/wget.c  | 86 +++++++++++++++++++++++++++++++++++++++++++-----
>  3 files changed, 97 insertions(+), 10 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Some nits / questions

I am not sure what mbedtls_hardware_poll() is, but if @len is too
short, would it be acceptable to return an error? How many bytes is it
requesting in the https case?

uclass_first_device() if you want the first device, not uclass_get_device(...0)

Regards,
Simon
