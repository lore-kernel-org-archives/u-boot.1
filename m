Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B731DCCF9E3
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 11:58:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54FC983A47;
	Mon, 10 Nov 2025 12:58:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aEGCZPLw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 454A883A48; Mon, 10 Nov 2025 12:58:06 +0100 (CET)
Received: from mail-yx1-xb132.google.com (mail-yx1-xb132.google.com
 [IPv6:2607:f8b0:4864:20::b132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29C2683980
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 12:58:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-640c9c85255so3369883d50.3
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 03:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762775883; x=1763380683; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wUBXU4grlh9Qm+YmmfkUzxppKDZrrNDaPb6pVh/3nUE=;
 b=aEGCZPLwbU6HcKAD/boRaN9/ph5aAe1PtmqXHhxtK86qstaRF5PkuOM1XJy+J1N6Rv
 +8u5IA88TEOraD9InE3dpWqSqJHX9Iu16ra4PCv7bqlnodxd7HMyZiHo/Msgb0qg3LE0
 f4UZMBN+sSdW1sZJT6QjDtfGbKQODurbJJ2vLrAWnuON1imH8yjO/Gu/fqgTyjjn+Fl3
 7wU/oyLKkoB+P5FekE9FI1nGR1M6idxpB2asw3kUGnucC7XMdWIhaADZbiWmVFQXJBQL
 316DSQ3y8WKuKjaOaHNNqcsvTUIEx+zo7ifJD4Lz/IWtKD0ySCgVliTNFoUEnV9m8n/g
 cp0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762775883; x=1763380683;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wUBXU4grlh9Qm+YmmfkUzxppKDZrrNDaPb6pVh/3nUE=;
 b=OnEuDFzF3FeSEavyB6Lgd6rWIVVK5UfnNfOPXiALr7yf7jI/MJ51VJwcidkBnDcq4a
 ZMqMtM4ixGHvT5ma2Yr6nPfA52p4sAg2zmBiHzZB3aRE9dPPGT3uMHozY2Fk3nGRtACU
 5C5F85+H7TNdv4TP2V2C7X+YWsAAGYedZpAR7FA5WSXWigY67G9uTT6j2xVZ5uAvtLHK
 euwNtYdKNpa6Jdg6s1oGFw1XFNNtfQTpC1heY80FZqbkM1VtS1SEkcDotEzYdEhQemPm
 P7j9QqT0MO1GJ7OaOtXUv8v7uAT81dtck9l3IXyO2Q3Tb1S7kzHfhxm2Pcb4HoDXPym0
 GYTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFyma9ahqN4lKXY37mCsmWigvBr/Wy5zdhiYz2AwGULRsZPjq9IWuPoyPWFxfVDxb9bE410QE=@lists.denx.de
X-Gm-Message-State: AOJu0YymRI9ePFLb0H6BqKd4udAjZZl8GbsiFu/ZLw4fH13+mPxbYADz
 +zTiBVZFgxu5i72EpLnfH/Q+26kPn0ZNi7KI3QhCxNLIGk2cPMzTCaNE+umo4XfmSuf9Bg4gDAC
 rzUxsA1nQm07EN+IPMKFWPrgYAGGA03O0fuEWQc3Aiw==
X-Gm-Gg: ASbGncv+1EoBZWZhnBwfKhjDYC4N/9VxdOibNqgTD+peQNjmidG5Dpa1tCHP0HBoJOR
 JqQOhOEqvrSW7l0V3ZG+Ci5X2pyvtzunCYV0PYGwlai3lLXffyIO0GSmuOnQBsLKXMUB4643nqu
 /GdBrbV/VTTjc0vq9Bm+2EZbSt0oX/9EN+eMuac9OsR+/eAFir0ot0i2iHJaUA4W5QoT5nOrbhV
 XR9iyKfohBWWQLekbrR9864ILWZXu7nQUceaHcBeATvtflVBy5b9C6C4JvIFNQ6Kd+rzfQ27FJ4
 mRmkHecyy3w/k8F2/0udhcn3RlxcdH/kMBRIMU1p
X-Google-Smtp-Source: AGHT+IFGh6Jg5aRwKDDQTlFo1RZHVcZF7RkrMGbhAX8/hxajC/tyVgl3sj6MTTtJdDZUCJdAGtL7GCK6VUvqOXP+cmA=
X-Received: by 2002:a05:690e:259a:b0:63f:7c91:51eb with SMTP id
 956f58d0204a3-640d45e7ed0mr6456082d50.66.1762775882994; Mon, 10 Nov 2025
 03:58:02 -0800 (PST)
MIME-Version: 1.0
References: <20251105013045.11283-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251105013045.11283-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 10 Nov 2025 13:57:26 +0200
X-Gm-Features: AWmQ_bnAQv-dr5yYUC3hsG2lQOdhS9tTFiOa72843TjPl8F38syGDN1X77Km2tk
Message-ID: <CAC_iWj+Q27HaEn5f3h_ike75KcCSN7Nmqfgo-37m3aE_-qjCrQ@mail.gmail.com>
Subject: Re: [PATCH v2] efi_driver: typo 'to be write'
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
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

On Wed, 5 Nov 2025 at 03:30, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> %s/to be write/to write/
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
> v2:
>         use 'to write' to match blkcnt description
> ---
>  lib/efi_driver/efi_block_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_driver/efi_block_device.c b/lib/efi_driver/efi_block_device.c
> index 070747de515..c389b1920a8 100644
> --- a/lib/efi_driver/efi_block_device.c
> +++ b/lib/efi_driver/efi_block_device.c
> @@ -84,7 +84,7 @@ static ulong efi_bl_read(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
>   * efi_bl_write() - write to block device
>   *
>   * @dev:       device
> - * @blknr:     first block to be write
> + * @blknr:     first block to write
>   * @blkcnt:    number of blocks to write
>   * @buffer:    input buffer
>   * Return:     number of blocks transferred
> --
> 2.51.0
>
