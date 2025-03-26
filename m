Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92DEEC36008
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 16:47:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C22681253;
	Wed, 26 Mar 2025 17:47:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DlmSwhrp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DD5281253; Wed, 26 Mar 2025 17:47:48 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0416810E8
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 17:47:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so510985e9.1
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 09:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743007660; x=1743612460; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jth3wZQtjWG9X/tIvk39KPzg6LrbzN+9O9nfrxDhl6U=;
 b=DlmSwhrpdc1vxenMOaaMHwgYbkXsYCqR6pPReAGhk5912x0rZnW4ZyAARjNaZrHVKU
 Ktz/nPLLcti1xi9V7kwGwMv5bcmcxNZlgbRG+W7m+Rly05i7gQO1L7AOxlmX5DzZCB0H
 AIEU1+WwZkvw9j8pKzTLocQc/WWh+pDJMv6u3obmkH8Rgh95IVF03KQ5XSKTFWi7N2Sj
 zORgg9Cxx5BJsO0vJoHNh4Rmv96SgxW8ZrpCQOIjCbT4jjyyw2bLCnM97BOmypQOSl4s
 MCafMucWzOY9CjU/yUhTspbPdWaEju6JEfPjAiX43iFAbhqzzrpYrX1CXCFzI9+CHZ9t
 vz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743007660; x=1743612460;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jth3wZQtjWG9X/tIvk39KPzg6LrbzN+9O9nfrxDhl6U=;
 b=WKIfG4TyjI1W/tBEK2GVI/ZxHJ1sCblmc9eCXrex29Zd4M/v1+RxcTmusHLgls8+kL
 tChIJGxWNxxXkf7yMl9P9u+ueN6eIWVuHYnnkjXPL6LN+05Rvc0OWfOW/+hLbD9HMl0c
 hana2ehUrx3LhiiC65wdLLoneAtYXP3lQiZszG7PzLjLwz4DWyy5NzTwO04za/lC2Qen
 g8jEvsCC6ynblrvaRsPYFkVLt3f+zci1dMUKubmVpCB12rNHAahnr99Tt6k9KdILwIIq
 h7bU/Voxj24zMyqWVgS4nF8kkwmaHZnyFsMHdCA/+jgj7oYeGNZdJbD4lBe/BtL3NsVA
 wuEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAS2urqzAUNMGzBkM6//ehBQTOD8spRv0KbF4rzLcynM0RmonvvliYfqWJfjW6TXPNkqsA1hw=@lists.denx.de
X-Gm-Message-State: AOJu0YwZxbqIADNt/NLbUBnDBO40qm9KZYstnRzmBk+INKFzNa7e9K7y
 0nIzB/R243bXbNDkrtHvPRIOB5LZE9tf+HhaIAV/UllDG1p5DRpmmoUY1F5juKzJOAkMMMremhi
 xxzZvwGmMx48Fge5FhuvJsEf8RZ0=
X-Gm-Gg: ASbGncveoL+eL+3Zj9np9OWZR6fFPefUSIKhhEoXG/dzlSEcPImxdcQsbkQXppXEHQz
 6FRiO4rXiQFF4/AgdPYfEpMnn9cI/2ThhUrU/5f9p6Ff7qdMlpGUrTIkj3mpYWEsPS5eOpcFdaI
 tLSE+FWuNhV6y36TCd6qWYjMvOgC8=
X-Google-Smtp-Source: AGHT+IHfPAm6jFfFBbc5ySCbl6cV0tJnC9zoNur11LRevl/sG+ykGG8sL+Q1j8YLLx/r6M1PLPSf5KO6pGrD/kNuo1g=
X-Received: by 2002:a05:6000:420c:b0:391:2f2f:818 with SMTP id
 ffacd0b85a97d-39ad1740a53mr154440f8f.9.1743007660230; Wed, 26 Mar 2025
 09:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250326-ge-mainline-display-support-v5-0-ea4bc3fc9bca@bootlin.com>
 <20250326-ge-mainline-display-support-v5-3-ea4bc3fc9bca@bootlin.com>
In-Reply-To: <20250326-ge-mainline-display-support-v5-3-ea4bc3fc9bca@bootlin.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 26 Mar 2025 18:47:29 +0200
X-Gm-Features: AQ5f1Jq80RNWqAGpFFKq1DfTMeDiXVc59rTwtF-R4Hbba7_SQA_Lfe2eQbKeXdA
Message-ID: <CAPVz0n2YYXQKNyXFFDZxm83n4egWd2DbeuiudZsLcBAZn8h4JQ@mail.gmail.com>
Subject: Re: [PATCH v5 03/12] dm: core: Add a helper to retrieve devices
 through graph endpoints
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Fabio Estevm <festevam@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Mario Six <mario.six@gdsys.cc>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

=D1=81=D1=80, 26 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 17:01 Miqu=
el Raynal <miquel.raynal@bootlin.com> =D0=BF=D0=B8=D1=88=D0=B5:
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
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/core/uclass.c | 19 +++++++++++++++++++
>  include/dm/uclass.h   | 24 ++++++++++++++++++++++++
>  2 files changed, 43 insertions(+)
>
> diff --git a/drivers/core/uclass.c b/drivers/core/uclass.c
> index f846a35d6b2537bab56bca158cedfb134b37f477..ce5e61bbaa63a181a1ea6781a=
d6a7f06be67c7e0 100644
> --- a/drivers/core/uclass.c
> +++ b/drivers/core/uclass.c
> @@ -16,6 +16,7 @@
>  #include <dm/device.h>
>  #include <dm/device-internal.h>
>  #include <dm/lists.h>
> +#include <dm/ofnode_graph.h>
>  #include <dm/uclass.h>
>  #include <dm/uclass-internal.h>
>  #include <dm/util.h>
> @@ -582,6 +583,24 @@ int uclass_get_device_by_phandle(enum uclass_id id, =
struct udevice *parent,
>         ret =3D uclass_find_device_by_phandle(id, parent, name, &dev);
>         return uclass_get_device_tail(dev, ret, devp);
>  }
> +
> +int uclass_get_device_by_endpoint(enum uclass_id class_id, struct udevic=
e *dev,
> +                                 int port_idx, int ep_idx, struct udevic=
e **devp)
> +{
> +       ofnode node_source =3D dev_ofnode(dev);
> +       ofnode node_dest =3D ofnode_graph_get_remote_node(node_source, po=
rt_idx, ep_idx);

You may use dev_ofnode(dev) directly instead of node_source if you
wish, but that is up to you.

> +       struct udevice *target =3D NULL;
> +       int ret;
> +
> +       if (!ofnode_valid(node_dest))
> +               return -EINVAL;
> +
> +       ret =3D uclass_find_device_by_ofnode(class_id, node_dest, &target=
);

You can use uclass_get_device_by_ofnode here and avoid using
uclass_get_device_tail later.

> +       if (ret)
> +               return -ENODEV;
> +
> +       return uclass_get_device_tail(target, 0, devp);
> +}
>  #endif
>
>  /*
> diff --git a/include/dm/uclass.h b/include/dm/uclass.h
> index c279304092352200d5297ad2d17f527173ec506b..8fdd72725119aae6ad2b62f4b=
0c38866a910389c 100644
> --- a/include/dm/uclass.h
> +++ b/include/dm/uclass.h
> @@ -333,6 +333,30 @@ int uclass_get_device_by_phandle(enum uclass_id id, =
struct udevice *parent,
>  int uclass_get_device_by_driver(enum uclass_id id, const struct driver *=
drv,
>                                 struct udevice **devp);
>
> +/**
> + * uclass_get_device_by_endpoint() - Get a uclass device for a remote en=
dpoint
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
> + * @port_idx: Index of the port to follow, -1 if there is a single 'port=
'
> + *            node without reg.
> + * @ep_idx: Index of the endpoint to follow, -1 if there is a single 'en=
dpoint'
> + *          node without reg.
> + * @target: Returns pointer to the first device matching the expected uc=
lass.
> + * Return: 0 if OK, -ve on error
> + */
> +int uclass_get_device_by_endpoint(enum uclass_id class_id, struct udevic=
e *dev,
> +                                 int port_idx, int ep_idx, struct udevic=
e **target);
> +
>  /**
>   * uclass_first_device() - Get the first device in a uclass
>   *
>
> --
> 2.48.1
>
