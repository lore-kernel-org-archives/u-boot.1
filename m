Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818F0D59D85
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 00:32:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91E7A892DE;
	Tue, 26 Nov 2024 01:32:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dPt7pDNM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC1DF8922D; Tue, 26 Nov 2024 01:32:15 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C93E89328
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 01:32:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3822ec43fb0so3922538f8f.3
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 16:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732581132; x=1733185932; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A4wzS5UMrOJSPhalFTWKlXp2uSglxyZyh9XiuBGdw9E=;
 b=dPt7pDNMMGNw42bzZ2cq76e/noV+9xbgUgH+Hh9F0lloefvTXaiDn3CtdiKuQdHVcI
 1W4A4d5OaamEUEqSSzxwUntweVkV/z9kia/hdD5Db8xk8GECZX+peuYLBtamVYf2Ok2A
 W4RkYZet0oguia2F7rh1BOL/CfpLJQ+XbVnVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732581132; x=1733185932;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A4wzS5UMrOJSPhalFTWKlXp2uSglxyZyh9XiuBGdw9E=;
 b=F6fMcM9i2d1LYNaGd3BVawHYB5Z8JjcZBHma1nqUcMg6iiazm/Yf+bg0WCUECogrAr
 1PSVl5zTZeBFvDML16DM9Aj3mS0P4I7l6pb5NK7pTTxcckXzZf9x5kSuUO2U0MFtGBQ9
 q3Pdwh8kJ1Q1xaosop/f+xURNbeb6EVhj20xPRBH5LUL8118X9cfJ8pPx+f3qemFgjpY
 SYZPoFxAcUmIA7TeoCKFVsYndW9jdi600nfCz4tBlAcuopyGDhBap72ULGgep64DLGJr
 m+aEr4z+Zg34/H56gIqEuGAYzja4oCQcmoIP9kVY7ezgZUg7jSh45xWgRW6ykU9aLz1i
 Hihw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEvITc5I0bqV85G2t+pdJ1/9V75DVgcXg6UeAZ+bs/9LOe5V21KZJzdsL1wuY9EHOcWjdcAZQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yys76sKFy+rUh7QIQEtTSOs2WOZDKvGtipCMSS05crQYz2VPQwK
 BXzEXs1/CG75NBUWFMQgRu45AVJCluoefTFlH24hwn95Df9eoi4O7ely0rJzzttJPDDxB2Ajrgs
 9ZGyb7WiME3mqMjECY5iN3bi6Jxx82VLTY0hA
X-Gm-Gg: ASbGncuF8uPB+WfZwZvPflU2t35k8pHnk+oEN5TGyRu+gQT/NYmYsjnYKEzdWbgo9wl
 iTSDEAmT+0XAskQy2bXoFiNSHyyTszTU=
X-Google-Smtp-Source: AGHT+IHAhtZNTk7sQY9VicH0gQeQ+BoCfE2eEFhC1Vt7OoO7jKOUy/DXi0TeEjdYl26v2TcW4ep+7v1eDsEfDLnJR4c=
X-Received: by 2002:a05:6000:2807:b0:382:45c9:e34f with SMTP id
 ffacd0b85a97d-38260b59713mr8351050f8f.18.1732581131905; Mon, 25 Nov 2024
 16:32:11 -0800 (PST)
MIME-Version: 1.0
References: <20241123214554.305285-1-heinrich.schuchardt@canonical.com>
 <20241123214554.305285-5-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241123214554.305285-5-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 Nov 2024 17:32:00 -0700
Message-ID: <CAFLszTgNguURurFAnX4W4mw8_Fokj2iCQOw15MCnFtT_zea6hw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] net: eth_bootdev_hunt() must not try to boot
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Daniel Golle <daniel@makrotopia.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Raymond Mao <raymond.mao@linaro.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, 
 T Karthik Reddy <t.karthik.reddy@xilinx.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
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

On Sat, 23 Nov 2024 at 14:46, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> eth_bootdev_hunt() should not execute dhcp_run() as this itself would load
> a file and boot it if autostart=yes.
>
> Instead just check that there is a network device.

If you look at dhcp_run() you will see an 'autoload' parameter. This
is 'false' in this code, so it never loads a file.

Regards,
Simon


>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         new patch
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
> -       if (IS_ENABLED(CONFIG_CMD_DHCP)) {
> -               ret = dhcp_run(0, NULL, false);
> -               if (ret)
> -                       return -EINVAL;
> -       }
> +       ret = -EINVAL;
> +       uclass_foreach_dev_probe(UCLASS_ETH, dev)
> +               ret = 0;
>
> -       return 0;
> +       return ret;
>  }
>
>  struct bootdev_ops eth_bootdev_ops = {
> --
> 2.45.2
>
