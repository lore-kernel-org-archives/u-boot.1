Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3385FD6ACCA
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 13:07:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B78B9897D9;
	Wed, 27 Nov 2024 14:07:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZjhQDgOQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13616897DC; Wed, 27 Nov 2024 14:07:41 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D781B897D6
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 14:07:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aa51d32fa69so718281566b.2
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 05:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732712858; x=1733317658; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3xR7PyXjrgdPdMyedQvbGSsrD/lq4lZMdW+e9PCl4N0=;
 b=ZjhQDgOQMKT6th3QM0+LqEJGQqYxkGErIbzIPcH9/5LMfzTWYVDxCY2gdO+BgJ8QHw
 U0639R/omRf249csnwwAqggx9/HSV0bqJkEbF0M96BiwLm+CFNatCrln8wMisYf3Bz4n
 /HBAD9HY0SdNWARKDn/Fv19ZvE11v/Q8QGooY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732712858; x=1733317658;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3xR7PyXjrgdPdMyedQvbGSsrD/lq4lZMdW+e9PCl4N0=;
 b=koOMLHmGFxYDD5qn73r2xTQZ0e+j1q1rgRraQWmZLOqx7sf6079qlAyj9mDi4IR6uj
 QbYDc3/jknO01Bmco31gy3ADQRtyo736kTERw61b2SldMjNBPwJ2LqmPk+t4tLhSDCE4
 pA688ypIEG2sXGyK1J9pYBnB1qF38bAMAQj2xedyJmNhGk73Fm7Xod8gayk7hZylh2fG
 yKovNcS4l7g90s8cCuaia9D/P8nflmoV23LsOCyXzmzJzIapl4VljoKFsgQRrOiM1SV2
 v0ib5CVPGmib0xvyDSJbTVR/dJ+ihQYR3+DC/ANNRU5irpsMXY14RTim/44lmqndgsNa
 2FMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuMX3O43BnwXFlHlqaANC74VZ2+ls2MmU97T/dLhTxEBqh7Hgq452TvmDlNOabTjypA8dnlJw=@lists.denx.de
X-Gm-Message-State: AOJu0YxxrBz6ZHsr1+Te/fHLr0dBXnf0c/4q5fEKkP/SyB0PIOAwyl8a
 mkXwlIvjjjEWIsknBrxBEuEZbHVYgROqMsqNluQzbN2/+xviYckoOPXFHWTJ2mSgzpc03s3kGNK
 wRa+sKApayr3rXzCLStOvY0OuqQ3WkrUaz7Ee
X-Gm-Gg: ASbGncvSRn40k3OblVPU4RWkJICFhFzkaoIs7wxm6GQYelIZihRFOpvM/GSZWBGYrtA
 WiCJb5OQUC7gCHF14BTQ9+9fxZbasAEo=
X-Google-Smtp-Source: AGHT+IEvb/PTsvys8D3z2UiZyeljcZ9ZUZlJ+Ad7EtLZi9CwEjMjIuu4d2XJiqvgRtECYgMKblKjOOBMlCo0NhgnGNs=
X-Received: by 2002:a17:906:30ce:b0:aa5:3591:4208 with SMTP id
 a640c23a62f3a-aa580ed0a58mr173303966b.12.1732712858193; Wed, 27 Nov 2024
 05:07:38 -0800 (PST)
MIME-Version: 1.0
References: <20241127070631.16412-1-heinrich.schuchardt@canonical.com>
 <20241127070631.16412-5-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241127070631.16412-5-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 27 Nov 2024 06:07:25 -0700
Message-ID: <CAFLszTjWzN0xmyCeMQEirNuhUQvAAjYUz+SaPTozy-+FFQJ_1w@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] net: eth_bootdev_hunt() should not run DHCP
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>, Weijie Gao <weijie.gao@mediatek.com>, 
 Daniel Golle <daniel@makrotopia.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>, u-boot@lists.denx.de
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

Hi Heinrich,

On Wed, 27 Nov 2024 at 00:07, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Currently when booting dhcp_run() may be executed multiple times:
> once in eth_bootdev_hunt() and once in the network booting bootmeth.
>
> We need to call eth_bootdev_hunt() when setting up the EFI sub-system to
> supply the simple network protocol. We don't need an IP address set up.
>
> We can reduce the bootime by not executing dhcp_run() in
> eth_bootdev_hunt().
>
> Furthermore eth_bootdev_hunt() with autostart=yes leads on the legacy
> network statck leads to downloading a file via TFTP and to booting the

spelling

> downloaded file.

I have now found the feature you're referring to - the calls to
env_get_autostart(). Perhaps we can remove this feature? It seems
pretty old and I don't see boards using it.

That feature stops bootstd working properly.

But if we don't remove it, we need to disable autostart in dhcp_run(),
since in that case it does not behave correctly. I can do a patch for
that if needed.

>
> Instead of running dchp_run() just check that there is a network device
> in eth_bootdev_hunt().
>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         reword the commit message
> ---
>  net/eth_bootdev.c | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)
>
> diff --git a/net/eth_bootdev.c b/net/eth_bootdev.c
> index 6ee54e3c790..b0fca6e8313 100644
> --- a/net/eth_bootdev.c
> +++ b/net/eth_bootdev.c
> @@ -64,9 +64,23 @@ static int eth_bootdev_bind(struct udevice *dev)
>         return 0;
>  }
>
> +/**
> + * eth_bootdev_hunt() - probe all network devices
> + *
> + * Network devices can also come from USB, but that is a higher
> + * priority (BOOTDEVP_5_SCAN_SLOW) than network, so it should have been
> + * enumerated already. If something like 'bootflow scan dhcp' is used,
> + * then the user will need to run 'usb start' first.
> + *
> + * @info:      info structure describing this hunter
> + * @show:      true to show information from the hunter
> + *
> + * Return:     0 if device found, -EINVAL otherwise
> + */
>  static int eth_bootdev_hunt(struct bootdev_hunter *info, bool show)
>  {
>         int ret;
> +       struct udevice *dev = NULL;
>
>         if (!test_eth_enabled())
>                 return 0;
> @@ -78,19 +92,11 @@ static int eth_bootdev_hunt(struct bootdev_hunter *info, bool show)
>                         log_warning("Failed to init PCI (%dE)\n", ret);
>         }
>
> -       /*
> -        * Ethernet devices can also come from USB, but that is a higher
> -        * priority (BOOTDEVP_5_SCAN_SLOW) than ethernet, so it should have been
> -        * enumerated already. If something like 'bootflow scan dhcp' is used
> -        * then the user will need to run 'usb start' first.
> -        */

Please keep this comment

> -       if (IS_ENABLED(CONFIG_CMD_DHCP)) {
> -               ret = dhcp_run(0, NULL, false);
> -               if (ret)
> -                       return -EINVAL;
> -       }
> +       ret = -EINVAL;
> +       uclass_foreach_dev_probe(UCLASS_ETH, dev)
> +               ret = 0;

There is a uclass_probe_all() function.

My suggestion from the original series was to just do the dhcp once.

How does probing the ethernet devices actually help EFI? It is not
needed for bootstd, since it probes any devices it uses.

>
> -       return 0;
> +       return ret;
>  }
>
>  struct bootdev_ops eth_bootdev_ops = {
> --
> 2.45.2
>

Regards,
Simon
