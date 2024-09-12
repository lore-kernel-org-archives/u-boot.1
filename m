Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C1EEE57FB
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 01:04:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16C6088E56;
	Thu, 12 Sep 2024 03:01:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CZXiCW41";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 006BB88DE4; Thu, 12 Sep 2024 03:01:31 +0200 (CEST)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B405C88DCF
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 03:01:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7db1f13b14aso397930a12.1
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 18:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102888; x=1726707688; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0l9E6HqXMbnQ+VPbP7IHNu1nhXkBzzdLCsSYSohGiCQ=;
 b=CZXiCW4165hK89/5bxe9xx8QHGZierGz9IcyqLVGHAQHtCD6/hwBuxwYrQ3IUncSAU
 9QAAZXta82yQ/IYdgeCp3QzsENXG1++qs5cKvRJXfdBQJl6ZPQRD7+jJ+T6yOaoN406s
 O48bMFNdp8Hw9JqTqsIvw1EouuANiwdN2l72o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102888; x=1726707688;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0l9E6HqXMbnQ+VPbP7IHNu1nhXkBzzdLCsSYSohGiCQ=;
 b=doiYBl5plsbP83P9suUrL3n/eeKoq7dDh7K6XL3KdOsnhE9k/q65ymoyx3eS2Dj1HO
 DOB6Ph3YhwYhosiOkEBGcgxut9lhrqYcEVkepwvKrNsvg9FNkM9Rhe3MtXFI73EMONMu
 wBIvblUfoSyRztZkxUuTutOuSjGuledhtLToGSW3HvvGSGntMF1S0A4ThS2v1FzJkJLR
 FZFTFyH38Qd2WVe0+3OaXMzpuG7gRmIltazkBaxSK8QdPW4KiNvsi0zMDg6pcP5UzRe1
 xDVrvH3WKMUN8JiM8eg7Qbo8ORSh3xtrOpSXv7abjIZIs2bYczYo3q7J/HiWXTe2zAue
 MQCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/WbCEJQr1Wj7y0qtdLnMMBE+h1kjmlhexdWFwAPYf4mKms1CxDFa07jbMGFy1YZQJWairidw=@lists.denx.de
X-Gm-Message-State: AOJu0YwFkxSqrR8PhEHCmkKXpUBGgYrHTn8VnMQW79orkFft15ia59dl
 v0pzNgldQxeCmstzUCzu0zrbZaKjP/UvEXq7fBBkBJSDEQT+kG80gGf9SrmTQFcDXhMZzk6nnTP
 y/omp4nacUlBE7x21r0WUSE21zlLDBUj+yeYR
X-Google-Smtp-Source: AGHT+IEyWkXtdry7qSeZAzuu0gVCMCeDpxQQbA38Rbu2uGJsnkAyBaFlJNKN0s6s++B8ksx308M9YxIWu3K3a7+DrHg=
X-Received: by 2002:a05:6a21:2d8b:b0:1cf:4569:ffb0 with SMTP id
 adf61e73a8af0-1cf756c9c09mr1699026637.0.1726102887934; Wed, 11 Sep 2024
 18:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240910101344.110633-1-miquel.raynal@bootlin.com>
 <20240910101344.110633-2-miquel.raynal@bootlin.com>
In-Reply-To: <20240910101344.110633-2-miquel.raynal@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 19:01:07 -0600
Message-ID: <CAFLszTgVY2+6NHucq5GdHmTQe5uArZf8RAJWPYFoo3A90GECpw@mail.gmail.com>
Subject: Re: [PATCH 1/8] dm: core: Add a helper to retrieve devices through
 graph endpoints
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Ian Ray <ian.ray@gehealthcare.com>, Marek Vasut <marek.vasut@gmail.com>
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

Hi Miquel,

On Tue, 10 Sept 2024 at 04:13, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> There are already several helpers to find a udevice based on its
> position in a device tree, like getting a child or a node pointed by a
> phandle, but there was no support for graph endpoints, which are very
> common in display pipelines.
>
> Add a new helper, named uclass_get_device_by_endpoint() which enters the
> child graph reprensentation, looks for a specific port, then follows the
> remote endpoint, and finally retrieves the first parent of the given
> uclass_id.
>
> This is a very handy and straightforward way to get a bridge or a panel
> handle.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/core/uclass.c | 62 +++++++++++++++++++++++++++++++++++++++++++
>  include/dm/uclass.h   | 21 +++++++++++++++
>  2 files changed, 83 insertions(+)

This is fine, but please add a test when changing driver model.

Perhaps it is in another patch? I don't seem to have the series so I
wonder if I have been unsubscribed again...

>
> diff --git a/drivers/core/uclass.c b/drivers/core/uclass.c
> index e46d5717aa6..5803fd51986 100644
> --- a/drivers/core/uclass.c
> +++ b/drivers/core/uclass.c
> @@ -572,6 +572,68 @@ int uclass_get_device_by_phandle(enum uclass_id id, struct udevice *parent,
>         ret = uclass_find_device_by_phandle(id, parent, name, &dev);
>         return uclass_get_device_tail(dev, ret, devp);
>  }
> +
> +int uclass_get_device_by_endpoint(enum uclass_id class_id, struct udevice *dev,
> +                                 u32 ep_idx, struct udevice **devp)
> +{
> +       ofnode port = ofnode_null(), ep, remote_ep;
> +       struct udevice **target;
> +       u32 remote_phandle;
> +       int ret;
> +
> +       if (!ep_idx)
> +               port = dev_read_subnode(dev, "port");
> +
> +       if (!ofnode_valid(port)) {
> +               char port_name[32];
> +
> +               port = dev_read_subnode(dev, "ports");
> +               if (!ofnode_valid(port)) {
> +                       debug("%s: no 'port'/'ports' subnode\n",
> +                             dev_read_name(dev));
> +                       return -EINVAL;
> +               }
> +
> +               snprintf(port_name, sizeof(port_name), "port@%x", ep_idx);
> +               port = ofnode_find_subnode(port, port_name);
> +               if (!ofnode_valid(port)) {
> +                       debug("%s: no 'port@%x' subnode\n",
> +                             dev_read_name(dev), ep_idx);
> +                       return -EINVAL;
> +               }
> +       }
> +
> +       ep = ofnode_find_subnode(port, "endpoint");
> +       if (!ofnode_valid(ep)) {
> +               debug("%s: no 'endpoint' in %s subnode\n",
> +                     ofnode_get_name(port), dev_read_name(dev));
> +               return -EINVAL;
> +       }
> +
> +       ret = ofnode_read_u32(ep, "remote-endpoint", &remote_phandle);
> +       if (ret)
> +               return ret;
> +
> +       remote_ep = ofnode_get_by_phandle(remote_phandle);
> +       if (!ofnode_valid(remote_ep))
> +               return -EINVAL;
> +
> +       while (ofnode_valid(remote_ep)) {
> +               remote_ep = ofnode_get_parent(remote_ep);
> +               debug("trying subnode: %s\n", ofnode_get_name(remote_ep));
> +               if (!ofnode_valid(remote_ep)) {
> +                       debug("%s: no more remote devices\n",
> +                             ofnode_get_name(remote_ep));
> +                       return -EINVAL;
> +               }
> +
> +               ret = uclass_find_device_by_ofnode(class_id, remote_ep, target);
> +               if (!ret)
> +                       break;
> +       };
> +
> +       return uclass_get_device_tail(*target, ret, devp);
> +}
>  #endif
>
>  /*
> diff --git a/include/dm/uclass.h b/include/dm/uclass.h
> index 456eef7f2f3..1194174ca9b 100644
> --- a/include/dm/uclass.h
> +++ b/include/dm/uclass.h
> @@ -333,6 +333,27 @@ int uclass_get_device_by_phandle(enum uclass_id id, struct udevice *parent,
>  int uclass_get_device_by_driver(enum uclass_id id, const struct driver *drv,
>                                 struct udevice **devp);
>
> +/**
> + * uclass_get_device_by_endpoint() - Get a uclass device for a remote endpoint
> + *
> + * This searches through the parents of the specified remote endpoint
> + * for the first device matching the uclass. Said otherwise, this helper
> + * goes through the graph (endpoint) representation and searches for
> + * matching devices. Endpoints can be subnodes of the "port" node or
> + * subnodes of ports identified with a reg property, themselves in a
> + * "ports" container.
> + *
> + * The device is probed to activate it ready for use.
> + *
> + * @class_id: uclass ID to look up
> + * @dev: Device to start from
> + * @ep_idx: Index of the endpoint to follow, 0 if there is none.
> + * @target: Returns pointer to the first device matching the expected uclass.
> + * Return: 0 if OK, -ve on error
> + */
> +int uclass_get_device_by_endpoint(enum uclass_id class_id, struct udevice *dev,
> +                                 u32 ep_idx, struct udevice **target);
> +
>  /**
>   * uclass_first_device() - Get the first device in a uclass
>   *
> --
> 2.43.0
>

Regards,
SImon
