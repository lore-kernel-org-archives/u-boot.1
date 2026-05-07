Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC410CD3427
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 08:34:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DCAA8468B;
	Thu,  7 May 2026 10:34:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="GYOVmkTz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96C028470B; Thu,  7 May 2026 10:34:37 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D18D84687
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 10:34:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-bc23bebd345so105310066b.1
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 01:34:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778142875; cv=none;
 d=google.com; s=arc-20240605;
 b=Z5UkktoD9xvp7ZAhQ9nSrSoYFW/xaAjX2QmI1zEsRvXSDEft2oraS5r+5FmK9yD+LT
 WWoBZPyeLkWPOkwsXcyqNdwFHislRu+YhwN/7/0mBbdHGhVh5Pw8bvyTa46f7zQcASMO
 +Cp8DwLlHb7H4stnhpH+9lLBbkLQparptnmvcNEfrKD8teXnNbdNiDF7rYywZjwh2UeV
 e4PrsyQglla75z8IangjcQzjVYwzUnI16DmnyF5bRbvOIGJ4SR8qfJjP5H2lo9NZmN9N
 1AOOwERg8bg+CsdbfnMcqXB3DTyDn5JMD4znOhNupYTuNCNregu3C4uUN7UWVBbOcbrx
 WBvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=E6/ONhPobXZaNA6igkYmKy+m1QG+eEKWxg/Jq1q71vY=;
 fh=UXp/EUO74pqMB+5HT3XpWdbPS1TOvKi3CAK6N3sl4iA=;
 b=VDp2zE551ExJpeJ8BBSxHwQrGJU4P89wpd+EoRioH8wbxrU4NVkgPF64Ovygos965M
 MvDUJ510MejhCjj/KJO8HnSkxpSPFuHtZiVJpx7e8kh5oaJ4ho6cOj9Xwz9mfiOACPhF
 peyakv/OJEz+YQabXNiHsc+HA4oEOFnMJetCifTlZi5ddN4QYKZS1X/3Lph75JNTD3dk
 OF+Cnm9wnlPCsX0VjgD4vcZ1QdbYTbuSpUJGYQzFVjYh1LDg9MMb+bUnHK7ItxosygaE
 NX3FB/aFPpYJ8woj+q0T5QPHj9eVD7VuNiDB3Kio/7sh8h9TG0TYb71khV7mYogNZZNe
 MoqQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778142875; x=1778747675;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E6/ONhPobXZaNA6igkYmKy+m1QG+eEKWxg/Jq1q71vY=;
 b=GYOVmkTzbvLZWqf5/LXziBIOelUJChVkuYNPCwN0EVUsO0tT6qfH7Pa0ipLl071wvS
 5gVrtyds19XL+RO7kGzyFG9nJxHJ3Rw0J05zKdPehvWf0u0uaNvHNNK/83GbpRhDPh02
 Jh4KKgus6121lXo2cgEo741tGx71wWQJb1D1Zi6/4q0Ov+YuII1w68xUj5A7LCxmJk0C
 6lySMTl86ehsvMgd4P0Bhfr7MNYsUluGH5/9QQssgXsGRAwlaboFUbbr3qEz/J2ki3BX
 Ee4HHuo74d04laJohkdC4DMu9wzrJSR0Qtn3M/Mamv6Wyx3S7KDjsNRVx/JUaa45K+fR
 Cyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778142875; x=1778747675;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E6/ONhPobXZaNA6igkYmKy+m1QG+eEKWxg/Jq1q71vY=;
 b=Ao6YzwJ8GOJncyeh55PyP6lhyibbaasgnzq7euPSB3R8nH3wqR3Xlc0pS+Of6BL9R8
 5Iq9rp8XFWru+t7QxN3V2HG4UHtLieGkgXRR0P5xKRQ0u4qctine2O+cvdZEedExEG4E
 68P6GubRqfhn7RspvU2uaFByJUoyjmp+h37l5CVu2cg86le4YUy7Vw4+RBsQ1ybaaC2D
 iwGt5N6gXHPle3eledhD4j/7okDuS1gIQGNqI3mqHUpSHVxAC+dJmDLqAbhRKXrfLhuX
 vBJA3yK6ABkPwL9N4gBVvBcLniGdaBMXWhkw8FNXBm9gSPwc3Sn3fl/yVRq8NeEtlacU
 Feug==
X-Forwarded-Encrypted: i=1;
 AFNElJ/zgzJ39Twz0wxaoxh6zrhzV/tKV9+w6RlRoPeuL7Sx0KaHqojG7f21xfYDjbxTLdWJPKkFzUo=@lists.denx.de
X-Gm-Message-State: AOJu0YxxTuSTT9YuNS2N7+1UcA9fDjx/eP2nb2us9vbKvSn0jhd4rFtG
 ie7jJzix4xkoj3Bl6JLuiAGIecb2r8GmeapQBqgX6VxcLjskxxNA7D03hjs5SBgrj8K1zLwC628
 o3MlUzOjm6m2yp7smnm/Axg5mzdtxikNeYCAM9XUQjQ==
X-Gm-Gg: AeBDiesuy5m5Dt5bDIb22nMlkQ/kmuwHDrElWOFUcE2opqRkPn58O0G1yxfEWcjzg94
 uYFQ/UfKOSH4Lq5U2RslPOwUCqwjP3xC174ns8u7Xstao/dyqfq99yhV54yLZNfiVgPCDUQhcT1
 badCqCRdnOPc97WTzdzoC8Gpj1ynW56WXykK2+oQzusGE78jCCIgfCJQiUvefAXyoLoH18zlCs+
 TYbZL/W6CsBV/9vOkqDiGhIRvCgEyZrL0ftgbqOgqLceMbB9LVUTv8z75Zo4WIWCMGmPs7wsrjX
 eUDjCYNLUcvaDt5DwKGiVfK7qD2+7P/yTpMTaQNDkOgjKHBuWhesbdRDEiL3dd74SSw0COYbSks
 yNtxqES3Doj45Zybge2B0zJy/dpySxWg4OvSUBA==
X-Received: by 2002:a17:907:7b9d:b0:bba:1743:33ce with SMTP id
 a640c23a62f3a-bc84d58c2b2mr89505366b.14.1778142874849; Thu, 07 May 2026
 01:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260506-mtk-pinctrl-fix-scnprintf-v1-1-56b99d5809db@baylibre.com>
In-Reply-To: <20260506-mtk-pinctrl-fix-scnprintf-v1-1-56b99d5809db@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 7 May 2026 10:34:22 +0200
X-Gm-Features: AVHnY4LJHL3paJZxF8Z1jK3HFa_qVf8VFNz3DBpjG6zwPHDK_0TaTtTWxx2BnHs
Message-ID: <CAEHHSvZ+Un2e12ppBmjZcvN=P2QTofZ16g5otond0ds9teogOA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mediatek: use scnprintf() instead of snprintf()
To: David Lechner <dlechner@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, u-boot@lists.denx.de
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

Le jeu. 7 mai 2026 =C3=A0 01:05, David Lechner <dlechner@baylibre.com> a =
=C3=A9crit :
>
> Replace snprintf() with scnprintf() in the MediaTek pinctrl driver.
>
> snprintf() returns the number of characters that _would_ have been
> written if the buffer were large enough, while scnprintf() returns the
> number of characters actually written to the buffer. Since we use the
> return value to advance the buffer pointer, we need to use scnprintf()
> to have the correct pointer arithmetic.
>
> Fixes: 76da7482cf39 ("pinctrl: mediatek: print bias info along with pinmu=
x")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinc=
trl/mediatek/pinctrl-mtk-common.c
> index cfffbaeef84..01f67f09407 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> @@ -251,7 +251,7 @@ static int mtk_pinconf_get(struct udevice *dev, u32 p=
in, char *buf, size_t size)
>         if (mtk_get_pin_io_type(dev, pin, &io_type))
>                 return 0;
>
> -       pos =3D snprintf(buf, size, " (%s)", io_type.name);
> +       pos =3D scnprintf(buf, size, " (%s)", io_type.name);
>         if (pos >=3D size)
>                 return pos;
>
> @@ -306,7 +306,7 @@ static int mtk_get_pin_muxing(struct udevice *dev, un=
signed int selector,
>         if (err)
>                 return err;
>
> -       pos =3D snprintf(buf, size, "Aux Func.%d", val);
> +       pos =3D scnprintf(buf, size, "Aux Func.%d", val);
>         if (pos >=3D size)
>                 return 0;
>
> @@ -721,7 +721,7 @@ int mtk_pinconf_get_pu_pd(struct udevice *dev, u32 pi=
n, char *buf, size_t size)
>         if (err)
>                 return err;
>
> -       return snprintf(buf, size, " PU:%d PD:%d", pu, pd);
> +       return scnprintf(buf, size, " PU:%d PD:%d", pu, pd);
>  }
>
>  int mtk_pinconf_get_pupd_r1_r0(struct udevice *dev, u32 pin, char *buf, =
size_t size)
> @@ -740,7 +740,7 @@ int mtk_pinconf_get_pupd_r1_r0(struct udevice *dev, u=
32 pin, char *buf, size_t s
>         if (err)
>                 return err;
>
> -       return snprintf(buf, size, " PUPD:%d R1:%d R0:%d", pupd, r1, r0);
> +       return scnprintf(buf, size, " PUPD:%d R1:%d R0:%d", pupd, r1, r0)=
;
>  }
>
>  int mtk_pinconf_get_pu_pd_rsel(struct udevice *dev, u32 pin, char *buf, =
size_t size)
> @@ -755,7 +755,7 @@ int mtk_pinconf_get_pu_pd_rsel(struct udevice *dev, u=
32 pin, char *buf, size_t s
>         if (err)
>                 return err;
>
> -       return pos + snprintf(buf + pos, size - pos, " RSEL:%d", rsel);
> +       return pos + scnprintf(buf + pos, size - pos, " RSEL:%d", rsel);
>  }
>  #endif
>
>
> ---
> base-commit: e08877916e24cf97d3afc67aee65ed2204790f48
> change-id: 20260506-mtk-pinctrl-fix-scnprintf-b5bfd1a31ed2
>
> Best regards,
> --
> David Lechner <dlechner@baylibre.com>
>

Hi David,

LGTM

Reviewed-by: Julien Stephan <jstephan@baylibre.com>
