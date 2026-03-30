Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AEC91061B09
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 14:51:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C421C83DBF;
	Mon, 30 Mar 2026 16:51:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZuMVmqDh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D79483E7A; Mon, 30 Mar 2026 16:51:30 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDE0383D17
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 16:51:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b9825ba7f9dso849099166b.0
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 07:51:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774882287; cv=none;
 d=google.com; s=arc-20240605;
 b=LGuf87sGUPOU7XLAwiQypxyAbC5k7dulZ+MdjvpOWIrIGqO6KNqpQ9O2QWktJ0IBKt
 xAZHIG0/eSxguKx8/Mb4/x1DaMM3EWFA5VocWk9VurkQWXfeMkQJZka6bUe3v/yKyjw+
 ktB3Tc2YAWLotsdyqw65PgvVsG8U43J7kx0rq5aO9+ZItpYsJIb1YmaFbVc9zl8JAcPT
 7pKsLQ5w9Zd0M5xr5cf0aMvS4h1/rCNg52lgoIjmZu9gftMMZTRnnTCgt8sWKFbuvDPO
 Uhvw+OVaqjZiYrTzHUyDDq/nCPzLQxgu6xXiHiwFeWat5Ze4GSSTKYQhKmukrclgpS1V
 PCgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AQCsYnZi3DY9TiTI4P85l3reeCn4vOLQ8iWaWKtFgHw=;
 fh=QO1XR8SRSRxsH7/K1KblRUUI/AW5w76MzEzab2Cv1gE=;
 b=QLj+R5Byu6LGyp5S+eULsmY0ELG5p2DccnKPbHqC2YtbVcvvx5kQizoFo6U81Mw2u7
 Ic0BG3HZfZsoPs3k+1x7Wb39BeWUatZuLxE8H9vKTec/wHuxg5oL10KS0YIPA0UWkf5t
 nDvppF3qj/NqA43J1cG3gcEWakX3+KnCdEbWW7bknQUIxS1Ru6STjP7+cp8QlRLSryJK
 m1ofHvdrsn11CukxJQJfxh5vNYn10KkfMmKoGoHXX9x/pZDUw6oBkwo3FgZTP5O1vAQN
 tVVpG7wnEbxuPSrsdMx/sTolxX3irDUG478DI9Hp/vUQfVT8OHy31mVU3gSIyLk9v7uy
 fEvA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774882287; x=1775487087;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AQCsYnZi3DY9TiTI4P85l3reeCn4vOLQ8iWaWKtFgHw=;
 b=ZuMVmqDhqZeWm8brg5kecxbh5bsZ+tZ69UiZJ2PZCrXz9UqVGqrXV+XzHHV4XF85MH
 D1AZU50ooteEXwYvoo7rfI7piX6Y8BXrDsFfIw0GEJ5+TbqRqe+Bg3b+KV38j4PrJIVv
 bJNZo+YcjoVJ6uRbMrRNIPsUghsmk3fFJR32km+RwZvF89N4ZgoveJzyjZ8pUW6dh4yb
 9xKDw2SLhg7X7Hx4RJ8ye6zAlOwRmg+jQN11SE7vDqDzK78A33+iMQb1jv4EyhKJrjCC
 lcgSZo+EmTaHK1NCAHZ1FE6R/AICwTd9VJmk1k2SOw4jc1fbzWECu5He8r5fUy3EO1qn
 lArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774882287; x=1775487087;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AQCsYnZi3DY9TiTI4P85l3reeCn4vOLQ8iWaWKtFgHw=;
 b=j+FbDHBwzXrq2UJmcQjHKTn0ZPrKbYbZYm/wvrS//GXOrqbn+yNpbulXiJGQRz25W1
 XKg3QUFr1w+QdHPyYh30h37cBzQhg0/6S7csud+z+oXAFhgY36MvQAoUyXk5BY//2Kah
 9wCFmoaqfQKm8W4Gxkcv5+sOG8+v7qOB2WHHRvn3xf0k1OzmimDNE7J5z+QKfuQMCfei
 5rKqua5DlR0wAMkUB22eWHjE9Z29eJT9mJVNxyARgYUWcNPDdv2ynWKk0sncpYzR+zxW
 6YIACz3D4M6D6QmGlsv72gIEYmySUN6K4je2pO98WyVI3PZvkBHh5oiPYjLkqwCUHTND
 dSnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXErj8ea6u68+YzIrlAspZ1n0Czt9eMlScEbx1gnPiNV4CeachDCLwUoeDWlbfwS4C3DugrxKQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyEQmZqjoYVw0oEVvPRFzfZvTOhleRPFFO348+KqqCYJhcH/bc1
 7Y/GULAdLi7eSHEbFc2PK+tb11KAMLzpJGRto1eOI97b4yKrRkXvk5/JWyI4h6IjkPPxYFgsc8T
 Z6UCxp/WFEPbCm1X+36HKKi+9ggOSjb+3gUgLyv08Ew==
X-Gm-Gg: ATEYQzxAb7DCua/8xncM4QlTP70FQKM4a7ieLPGZybbT5biRxiLhM8zEjaoUiUc1UCQ
 E4e/OW8Ejh3lAHXlr5WvfaznKkL+OHbRg36OMGf0x9fqBfKTU3FlYpue29K8+1l7aBq2yfjMMoP
 ejwsvYkUUhqCR2NSxo+1j6mEA6B2SXLcNQJNZhkq9/kPCKxHB3KTwkOfx+/WI7s/yVYyOhrM5pw
 WtGiyabwZBse0BV22/jedN3zXzCXTo3lof+JdX/1Ft/P8nilChxUxcGk+ZhpIQieTxB3qkV5vGI
 0NVlzoESY56BZ8VWvgu8BxZcIE5X13jxkN38OsQrefaUMGrK/l+foJR5/a2ZXqgwUvGZEUwD8S4
 LwQ9niHHnnpaQb+Vo89+aNgUXqw==
X-Received: by 2002:a17:906:3c42:b0:b9b:51ac:cc1f with SMTP id
 a640c23a62f3a-b9b51acd1cemr542762866b.19.1774882287233; Mon, 30 Mar 2026
 07:51:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260313-pinctrl-mtk-fix-mt8189-v1-0-607dd37fde37@baylibre.com>
 <20260313-pinctrl-mtk-fix-mt8189-v1-3-607dd37fde37@baylibre.com>
In-Reply-To: <20260313-pinctrl-mtk-fix-mt8189-v1-3-607dd37fde37@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 30 Mar 2026 16:51:20 +0200
X-Gm-Features: AQROBzApDShQOr6zp6y1dWmCMXr_DephGfY4eoShb5Ikmv3H8PgAhUp2F3sOHWc
Message-ID: <CAEHHSvbnYRXEgO3SZpgFO6njwfbEx-ocSeB-izotqVyQBBx2dw@mail.gmail.com>
Subject: Re: [PATCH 3/4] pinctrl: mediatek: print bias info along with pinmux
To: David Lechner <dlechner@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Le ven. 13 mars 2026 =C3=A0 22:56, David Lechner <dlechner@baylibre.com> a =
=C3=A9crit :
>
> Add functionality to be able to print pin bias settings along with the
> pinmux setting.
>
> This can be useful to debug why pins might not be working correctly.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 96 +++++++++++++++++++++=
+++++-
>  drivers/pinctrl/mediatek/pinctrl-mtk-common.h |  4 ++
>  2 files changed, 98 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinc=
trl/mediatek/pinctrl-mtk-common.c
> index 1028b8a93f5..ef4acc946a8 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> @@ -237,9 +237,39 @@ static int mtk_get_pin_io_type(struct udevice *dev, =
int pin,
>         io_type->bias_set =3D priv->soc->io_type[io_n].bias_set;
>         io_type->drive_set =3D priv->soc->io_type[io_n].drive_set;
>         io_type->input_enable =3D priv->soc->io_type[io_n].input_enable;
> +       io_type->get_pinconf =3D priv->soc->io_type[io_n].get_pinconf;
>
>         return 0;
>  }
> +
> +static int mtk_pinconf_get(struct udevice *dev, u32 pin, char *buf, size=
_t size)
> +{
> +       struct mtk_io_type_desc io_type;
> +       int err, pos =3D 0;
> +
> +       if (!mtk_get_pin_io_type(dev, pin, &io_type)) {
> +               pos +=3D snprintf(buf + pos, size - pos, " (%s)", io_type=
.name);

why +=3D ? pos is initialized to 0.  Same why buf +pos? and  size - pos?

> +               if (pos >=3D size)
> +                       return pos;
> +
> +               if (io_type.get_pinconf) {
> +                       err =3D io_type.get_pinconf(dev, pin, buf + pos, =
size - pos);
> +                       if (err < 0)
> +                               return err;
> +
> +                       pos +=3D err;
> +                       if (pos >=3D size)
> +                               return pos;

Can't this be removed?

> +               }
> +       }
> +
> +       return pos;
> +}
> +#else
> +static int mtk_pinconf_get(struct udevice *dev, u32 pin, char *buf, size=
_t size)
> +{
> +       return 0;
> +}
>  #endif
>
>  static int mtk_get_groups_count(struct udevice *dev)
> @@ -270,12 +300,22 @@ static int mtk_get_pins_count(struct udevice *dev)
>  static int mtk_get_pin_muxing(struct udevice *dev, unsigned int selector=
,
>                               char *buf, int size)
>  {
> -       int val, err;
> +       int val, err, pos;
> +
>         err =3D mtk_hw_get_value(dev, selector, PINCTRL_PIN_REG_MODE, &va=
l);
>         if (err)
>                 return err;
>
> -       snprintf(buf, size, "Aux Func.%d", val);
> +       pos =3D snprintf(buf, size, "Aux Func.%d", val);
> +       if (pos >=3D size)
> +               return 0;
> +
> +       if (CONFIG_IS_ENABLED(PINCONF)) {

You can drop this if, since you already define an empty
mtk_pinconf_get() if PINCONF is not enabled


> +               err =3D mtk_pinconf_get(dev, selector, buf + pos, size - =
pos);
> +               if (err < 0)
> +                       return err;
> +       }
> +
>         return 0;
>  }
>
> @@ -670,6 +710,58 @@ static int mtk_pinconf_group_set(struct udevice *dev=
,
>
>         return 0;
>  }
> +
> +int mtk_pinconf_get_pu_pd(struct udevice *dev, u32 pin, char *buf, size_=
t size)
> +{
> +       int err, pu, pd;
> +
> +       err =3D mtk_hw_get_value(dev, pin, PINCTRL_PIN_REG_PU, &pu);
> +       if (err)
> +               return err;
> +
> +       err =3D mtk_hw_get_value(dev, pin, PINCTRL_PIN_REG_PD, &pd);
> +       if (err)
> +               return err;
> +
> +       return snprintf(buf, size, " PU:%d PD:%d", pu, pd);
> +}
> +
> +int mtk_pinconf_get_pupd_r1_r0(struct udevice *dev, u32 pin, char *buf, =
size_t size)
> +{
> +       int err, r0, r1, pupd;
> +
> +       err =3D mtk_hw_get_value(dev, pin, PINCTRL_PIN_REG_PUPD, &pupd);
> +       if (err)
> +               return err;
> +
> +       err =3D mtk_hw_get_value(dev, pin, PINCTRL_PIN_REG_R1, &r1);
> +       if (err)
> +               return err;
> +
> +       err =3D mtk_hw_get_value(dev, pin, PINCTRL_PIN_REG_R0, &r0);
> +       if (err)
> +               return err;
> +
> +       return snprintf(buf, size, " PUPD:%d R1:%d R0:%d", pupd, r1, r0);
> +}
> +
> +int mtk_pinconf_get_pu_pd_rsel(struct udevice *dev, u32 pin, char *buf, =
size_t size)
> +{
> +       int pos, err, rsel;
> +
> +       pos =3D mtk_pinconf_get_pu_pd(dev, pin, buf, size);
> +       if (pos < 0)
> +               return pos;
> +
> +       if (pos >=3D size)
> +               return pos;

nit: Can we merge this with previous if() ?
Or use intermediate err value as you do in  mtk_pinconf_get() ?

> +
> +       err =3D mtk_hw_get_value(dev, pin, PINCTRL_PIN_REG_RSEL, &rsel);
> +       if (err)
> +               return err;
> +
> +       return pos + snprintf(buf + pos, size - pos, " RSEL:%d", rsel);
> +}
>  #endif
>
>  static int mtk_pinctrl_pinmux_property_set(struct udevice *dev, u32 pinm=
ux_group)
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h b/drivers/pinc=
trl/mediatek/pinctrl-mtk-common.h
> index 1215fb7094b..bd17964090a 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
> @@ -204,6 +204,7 @@ struct mtk_io_type_desc {
>                         bool pullup, u32 val);
>         int (*drive_set)(struct udevice *dev, u32 pin, u32 arg);
>         int (*input_enable)(struct udevice *dev, u32 pin, u32 arg);
> +       int (*get_pinconf)(struct udevice *dev, u32 pin, char *buf, size_=
t size);
>  #endif
>  };
>
> @@ -263,6 +264,9 @@ int mtk_pinconf_bias_set_v1(struct udevice *dev, u32 =
pin, bool disable,
>  int mtk_pinconf_input_enable_v1(struct udevice *dev, u32 pin, u32 arg);
>  int mtk_pinconf_drive_set_v0(struct udevice *dev, u32 pin, u32 arg);
>  int mtk_pinconf_drive_set_v1(struct udevice *dev, u32 pin, u32 arg);
> +int mtk_pinconf_get_pu_pd(struct udevice *dev, u32 pin, char *buf, size_=
t size);
> +int mtk_pinconf_get_pupd_r1_r0(struct udevice *dev, u32 pin, char *buf, =
size_t size);
> +int mtk_pinconf_get_pu_pd_rsel(struct udevice *dev, u32 pin, char *buf, =
size_t size);
>
>  #endif
>
>
> --
> 2.43.0
>
