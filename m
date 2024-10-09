Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED431CF042D
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:52:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C043C89045;
	Wed,  9 Oct 2024 03:51:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JQbyR/mk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AFBE89041; Wed,  9 Oct 2024 03:51:29 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3F298902F
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:51:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-71df2b0a2f7so3150495b3a.3
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728438685; x=1729043485; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NJ5cDL4miaJjjv6S00TmgFKZzM/J8OYIsLSlnVrl3V0=;
 b=JQbyR/mk1BDxsRqADiQ95cOyinTirg+hG4WUp5ire14FPQbVBPOiIbbTdjdSfYzQFH
 NgxMj8fdYc8PMGYX+6EIFvgthqx4nnPy49dP679xoGUB1XzpdjMRU+iQ/JKmP+GHXWsD
 ZJqtKQk4iOXPruj3WQx9L4Pc2qCdaaKyW6bK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728438685; x=1729043485;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NJ5cDL4miaJjjv6S00TmgFKZzM/J8OYIsLSlnVrl3V0=;
 b=vDKUSgWueirPq3NFw7hEBRKv6u2SHd3LgL/Rga4L6p3fG5LcFffq1WCpPO6mIxkGI/
 OH0GweLe84NYCXEtiz8O/hsrZhFJ98dSeMuhw0zUJyocHYn7zFM94MCWMJK9yKi9MMtD
 Q9nmCV8ZZcpnPxBUIsSZl23h7YkUz54v52qkI4k0WnjoC3hAJlJTQ+feixlk/4xn4NNW
 yqHd/sMGPckCvs7wWJ9J7szeYrABYJTIv2e/9LwRDVKgQCIiVU5IA+y3Etaly4xl+G8R
 /GXDjTRlYjg1UzQ3wCHapVyiZA9zxlTJWyNBAC3D4R7SihkOE/GsnARk8sW7OaLrb69N
 Q0Pw==
X-Gm-Message-State: AOJu0YxI5tyYKEz+LPzLY+M5/kQWB/HVivqLD7mbJiMTksg5ym7WaaAU
 V72IehktVfw8dqeEuCKspgX+4p6SgVW2XrengqmF8Gigimx/3nfOMvjI53LSuVYB/65MmKeG1/s
 rXUPjMwfotSz/Hmlq0LSTH5Se+t2fGQ77Nqlm
X-Google-Smtp-Source: AGHT+IGQSVFgY/MrtvqtOC6t1nAU9N+8sIx0Z896YFCRedLDdyPeqcaPXsUyvU38gTz+mqfXMnRrba8I6TbhUapsB1I=
X-Received: by 2002:a05:6a00:22c6:b0:71d:fb83:62ef with SMTP id
 d2e1a72fcca58-71e1db88990mr1367100b3a.14.1728438685430; Tue, 08 Oct 2024
 18:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1727968902.git.jerome.forissier@linaro.org>
 <ec9e9d1eff4404d2615e825d2f35af0720c29a92.1727968902.git.jerome.forissier@linaro.org>
In-Reply-To: <ec9e9d1eff4404d2615e825d2f35af0720c29a92.1727968902.git.jerome.forissier@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:51:09 -0600
Message-ID: <CAFLszTjdoSzuttwotYwB3Km-fvd_FHuLmzkCay88hTWWFCiR6w@mail.gmail.com>
Subject: Re: [PATCH v11 05/29] test: boot: fix bootdev_test_any for when
 DSA_SANDBOX is disabled
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>, 
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>, 
 Anton Antonov <Anton.Antonov@arm.com>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
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

On Thu, 3 Oct 2024 at 09:23, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> When DSA_SANDBOX is not set, the sandbox tests fail as follows:
>
>  $ ./test/py/test.py --build-dir=$(pwd) -k bootdev_test_any
>  [...]
>  Test: bootdev_test_any: bootdev.c
>  test/boot/bootdev.c:156, bootdev_test_any(): "mmc2" = media->name: Expected "mmc2", got "mmc0"
>  [...]
>
> This is due to the device list containing two less entries than
> expected. Therefore, adjust the expected index to be two less when
> DSA_SANDBOX is disabled.
>
> The actual use case is NET_LWIP=y (to be introduced in later patches)
> which implies DSA_SANDBOX=n for the time being.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  test/boot/bootdev.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
> index c635d06ec25..369105ca4cf 100644
> --- a/test/boot/bootdev.c
> +++ b/test/boot/bootdev.c
> @@ -128,6 +128,7 @@ BOOTSTD_TEST(bootdev_test_labels, UTF_DM | UTF_SCAN_FDT | UTF_ETH_BOOTDEV);
>  static int bootdev_test_any(struct unit_test_state *uts)
>  {
>         struct udevice *dev, *media;
> +       char *seq;
>         int mflags;
>
>         /*
> @@ -147,8 +148,16 @@ static int bootdev_test_any(struct unit_test_state *uts)
>          * 8   [   ]      OK  mmc       mmc2.bootdev
>          * 9   [ + ]      OK  mmc       mmc1.bootdev
>          * a   [   ]      OK  mmc       mmc0.bootdev
> +        *
> +        * However if DSA_SANDBOX is disabled the dsa-test@{0,1} devices
> +        * are not there.
>          */
> -       ut_assertok(bootdev_find_by_any("8", &dev, &mflags));
> +       if (CONFIG_IS_ENABLED(DSA_SANDBOX))
> +               seq = "8";
> +       else
> +               seq = "6";
> +
> +       ut_assertok(bootdev_find_by_any(seq, &dev, &mflags));
>         ut_asserteq(UCLASS_BOOTDEV, device_get_uclass_id(dev));
>         ut_asserteq(BOOTFLOW_METHF_SINGLE_DEV, mflags);
>         media = dev_get_parent(dev);
> --
> 2.40.1
>
