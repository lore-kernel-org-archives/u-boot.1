Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811D1C369C9
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 21:37:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B4D183121;
	Thu, 17 Apr 2025 23:37:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="enPqEe7R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9EE0830B4; Thu, 17 Apr 2025 23:37:49 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB2AC82CF1
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 23:37:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-acb5ec407b1so193660466b.1
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 14:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744925867; x=1745530667; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tte8qfrSmLzvinR1RizWCIGPDjHUWXz6d9MUWRHv7zU=;
 b=enPqEe7R3VEFurXuh5E13P9FE+Vf+a9mER4atRSRCq0FlqNmfDJqjHUiRkzFulbiT7
 M97nXSzX36WEE8RbqSb517qW4cUEzQpdA7uf7mxL4UMSnl2yuLkUTVKODUJiRsu+QUDC
 v2YZsPHdixzWwSyC+sOIZF3mSdisRwTMkmoqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744925867; x=1745530667;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tte8qfrSmLzvinR1RizWCIGPDjHUWXz6d9MUWRHv7zU=;
 b=A7x3NNO5zNP1wValp9QpYJeJdGFzZ7ulO3LY0dHzFNTsMM8lo6sr2npwpQ59fOxW/U
 wvvKczyMqCk0B/ySLG0bxPKID3dkBRj8rFjn3BpmUXWvJFhMFU5hQ4mFf00dWVY7k8rr
 zA37/G5i8yXMgnYNsKbo7Nq//38GXHBO/JiqQqOm3RfnJiRkvPPPQOSj1WieszoydxPp
 AjNYhI+MOyQWbO0iYVo1fGZKTPolNljgH3JodInFukE+dlfTu4Vcd4LloFadAmICh1l7
 B7xvWHhl2HscY2cOPnJCXOOrRKft8TRqoQRNqeX1zZhduptOu54tBFVZZJ1aVTvZrvAa
 nkWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTXD0V7QqEOsVF1lRuZ8tLItsnrqgu3nuVGpGjBJ8Zz0Stz9lwzjWXDO984X6OlYb9/0r1pJU=@lists.denx.de
X-Gm-Message-State: AOJu0Yx9ZkL6D0m6qkwXBDQsSWoudZuGymCJPLv1PcIsr6dcgKmyLEeG
 pM9BulLWnjjaoSSxukyTsO1nvy2/9cftwdCl5JxRQlBe9FOnQ1NN8G/vs8EGtgufCzSFwkVatTC
 TFG4FOEbLE/K9FdxXAGv8miOaklrggKy47e/q
X-Gm-Gg: ASbGncvBme9ZRM6TTvpOEDBhfdGhaB5Npyb8MEpcuoY06ybPdu8nkM3NeFmEubjDV4M
 BNNhBTm8KLuLhKXojPv7Qlhc+Jwhrf4gGHCwgWmOR63mnm2Rb1qc/YbOEZwIzSQE/DFxfj9VpX1
 kWcCIifBABgS/F29gZg//Ye6Y=
X-Google-Smtp-Source: AGHT+IEbKhwLoQ750qrUpIiUFWjpC76X+Y79l0p4zysqLJszKIlN0TC+4HgCCin4wTbRyXfdtoazGwL4suM+MQYNYyg=
X-Received: by 2002:a17:907:da16:b0:aca:de0c:aebf with SMTP id
 a640c23a62f3a-acb74ac118amr32131366b.1.1744925867381; Thu, 17 Apr 2025
 14:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250416224032.144791-1-heinrich.schuchardt@canonical.com>
 <20250416224032.144791-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250416224032.144791-4-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 17 Apr 2025 15:37:29 -0600
X-Gm-Features: ATxdqUFtUxvHzPrpK_KV-9xq_VpFKQf5Hf_iqU85IcxNNSsaqQGJIVvT87oGL2U
Message-ID: <CAFLszTgxr8jYou-EvJCu3zDDdNNetqDPdx4wQ=Mehds+01jfjg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] buildman: unit test for configuration fragments
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Brandon Maier <brandon.maier@collins.com>, u-boot@lists.denx.de
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

On Wed, 16 Apr 2025 at 16:40, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Check that configuration fragments provided to buildman as comma
> separated list are passed on to the make command of the builder.
>
> In the %_defconfig: target of scripts/kconfig/Makefile the defconfig
> file and the fragments are combined via the gcc preprocessor.
> Modeling this step in the buildman testbench without invoking the actual
> Makefile would not provide better test coverage.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         new patch
> ---
>  tools/buildman/func_test.py | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
