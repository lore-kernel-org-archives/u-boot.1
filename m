Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD10EC02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 19:18:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48F5E8033D;
	Thu, 16 Jan 2025 20:18:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JuZucHsE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E227C8069D; Thu, 16 Jan 2025 20:18:30 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC6BB8022B
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 20:18:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5d9b6b034easo2689387a12.3
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 11:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737055108; x=1737659908; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RDKz4G73T65Smcj0BBwMduqjwgvT6fxl8wDsjC3qEek=;
 b=JuZucHsESIvmfNpg1Q894sv9Jf0sqTHMoRlsx9nu3MGQANpFNQScHJZVXz0bqMoaiv
 rkz06a76gdralPLrKBW6cHREXTGtMasz3Z0S5G6tm6/hMBDB+bJbyrnF1o1cMMSiwAV2
 9IQM38owSV09CeRyQ+87yrqKENkbeAvMS8nO8lXbnFxJVt9dDfXbfdzwFYLk1mSI0jsv
 b+mP4jxOR4Wt2M0bgJFnLYBnJrA0hqsekRbYK1xiJTZ6VpuL12l7pAbcFS9KX5mTfS66
 od22fLERB9b29hw3QmQxicWNrLui4AGU85HTz7IO/pb8Rsf3u8F0me+3TvN36Ha4hJy+
 q9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737055108; x=1737659908;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RDKz4G73T65Smcj0BBwMduqjwgvT6fxl8wDsjC3qEek=;
 b=saztWGBS2Vvs6mmtE8ResjE3xGwXyrJhfHg8/qGZdNDwq5/a8ld6LD1JHek0e9QFTm
 Sz1YMhIy0SlKNXCUJ1SG3jVT78w/krAMPQvfo3l/qMkK0cbWlGm0mD5wtwWJXQ7Reoo+
 8Vyo86Th7b4Qd3BYuLZmLK8OESW7P6SfLxpp6mwEcoxi9/0tXE+ACBsMFg9PO5rGvTGR
 dp2o7fZPw4AC60EmcRX7FsHaUbo0fCLw+dDSi9THdZ8Vyixh2zXC14l8niA08TNrIiYg
 jqqlXZ2KHxG7Q/mMKEKqqh44lfbQ+qhIAJG/28l3sNKbK/5ZEIh0aCde3dlyBXS74VfD
 u2/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUp7VotznkmG6Dk2HirPJ6yqvZenFd3/hkDfTsWKnO/u1t95OcPshwjtVF5wBXZXwuECePYWZo=@lists.denx.de
X-Gm-Message-State: AOJu0YzRBXoCP+z1QmYqGLTun9T/YhFBdig9OMLd2YlFPVBIo8xSLvcj
 R9oSzmF9mIOoT5wBg8gYQQtcaZU4Vfgd7zBzb6vcBdhDK1QCB1WBp7VOWG8pIgEzRCQouc0WLJY
 ITJl/y8y44TL2/8upBklZoaNds54=
X-Gm-Gg: ASbGncu/0SqnyFwLFLFV7nZXM6dgZ3ptoO9hGw/oSXQraTv2wciMM14SiN5FDvQqq7a
 AjqusOR662lsUWLNtIkPYTJCZGaNdg6rLSwPViQ==
X-Google-Smtp-Source: AGHT+IEvJChNkJmpWnrKsTWGJBl2v5zjejIFUpgIMce/A003RpeDE9gLdLQgiP2PJIIUhupUtH35cD7Wl5Fy/o152KQ=
X-Received: by 2002:a05:6402:4306:b0:5d9:a62:32b with SMTP id
 4fb4d7f45d1cf-5d972dfb28amr32812972a12.7.1737055107964; Thu, 16 Jan 2025
 11:18:27 -0800 (PST)
MIME-Version: 1.0
References: <20250116034534.91513-1-hal.feng@starfivetech.com>
In-Reply-To: <20250116034534.91513-1-hal.feng@starfivetech.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 17 Jan 2025 00:48:12 +0530
X-Gm-Features: AbW1kvakkZdioTKFKpoa0VJYXFbpKPPhN0w2KsTCPS-Of-bHv2eaqyd3mV31frw
Message-ID: <CANAwSgSOtLREfrHf-eBC1BWNnQCB-Us5bQJrwDTwUnnyssojMg@mail.gmail.com>
Subject: Re: [PATCH v1] pinctrl: starfive: Correct driver declaration for
 starfive_gpio
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
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

Hi Hal Feng,

On Thu, 16 Jan 2025 at 18:37, Hal Feng <hal.feng@starfivetech.com> wrote:
>
> Use the driver macros so that the driver appears in the
> linker list.
>
> Reported-by: Simon Glass <sjg@chromium.org>
> Fixes: 732f01aabf53 ("pinctrl: starfive: Add StarFive JH7110 driver")
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  drivers/pinctrl/starfive/pinctrl-starfive.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pinctrl/starfive/pinctrl-starfive.c b/drivers/pinctrl/starfive/pinctrl-starfive.c
> index 95b1a752de2..1b942e6f045 100644
> --- a/drivers/pinctrl/starfive/pinctrl-starfive.c
> +++ b/drivers/pinctrl/starfive/pinctrl-starfive.c
> @@ -348,7 +348,7 @@ static const struct dm_gpio_ops starfive_gpio_ops = {
>         .set_value = starfive_gpio_set_value,
>  };
>
> -static struct driver starfive_gpio_driver = {
> +U_BOOT_DRIVER(starfive_gpio) = {
>         .name = "starfive_gpio",
>         .id = UCLASS_GPIO,
>         .probe = starfive_gpio_probe,
> @@ -367,7 +367,7 @@ static int starfive_gpiochip_register(struct udevice *parent)
>                 return -ENOENT;
>
>         node = dev_ofnode(parent);
> -       ret = device_bind_with_driver_data(parent, &starfive_gpio_driver,
> +       ret = device_bind_with_driver_data(parent, DM_DRIVER_REF(starfive_gpio),
>                                            "starfive_gpio", 0, node, &dev);
>
>         return (ret == 0) ? 0 : ret;
>

Reviewed-by: Anand Moon <linux.amoon@gmail.com>

Thanks
-Anand

> base-commit: 178f6ecb21fe12ada74a9a1a08093c812b15eea5

> --
> 2.43.2
>
