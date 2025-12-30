Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BCE3EE0218
	for <u-boot@archiver.kernel.org>; Tue, 30 Dec 2025 15:48:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB8B583F7D;
	Tue, 30 Dec 2025 16:48:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="12CfYiyp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5EBE83F7F; Tue, 30 Dec 2025 16:48:53 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C967683F6A
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 16:48:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b8018eba13cso1556839166b.1
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 07:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767109731; x=1767714531;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jYKyCI3OyUGHxkKyVo2hnaial7OcyYRBSgZhycM8A6U=;
 b=12CfYiyp8Ccw/SPgMw/NIgFAb9EeVaFVSY/7CXC5I2IELIiQAl0mHEabIqpTYJq1Ds
 uZqzCdxEZ+d0JMbF+4Xiig84ywH4mNRcvCO9DACPfDMjueGpB6NWaEHLrkLvS56WpqZJ
 Bxt97Zyt8vJRMLW7ehYr9Ky8q/mqz/hkUW7ExTatnJlsf4zmq61k20vrLJJpUleLdO7U
 u6iehE+77Ks/vSNC1CshJyZfiCl2BThjM/70qAncmOy+DtLtkfpEc1wOsLSZLsQStN4I
 uX4KShjUWQf6IPi8WbdhRWjUaY1xx77SNKlalLrx0o4r7eEHOiOb7HtPXWIsg/sa2cSZ
 yPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767109731; x=1767714531;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jYKyCI3OyUGHxkKyVo2hnaial7OcyYRBSgZhycM8A6U=;
 b=fbaGAdowHNbPACQ696Nd3lyMXm0Vy4aktq9xYfY/s4pMw+y7gnPXMnDMcwf6nTI2Hq
 zL4zXXNMphJko6Q+sgCGMepmqYzu76KMf7q9ihc02xUwDcKYk3Ds2VPQne54IKhbecyL
 WHI/iTQlbeFujsvcWbGAdd9GBUeg+oMi4VRGQfIxX/HUBbgUWBPrLffEQ1HKRNHj4TsN
 PlLH6OYcRfUw2SC40G8BgwAe8/u8Y8wYtCGniOWBAX1lB47xWTetXv9r/M2UxEEVKHep
 nP0kNVgIYTVvh4GlY/2B6EA4Bc3L+7UwSpUqBtn6uS/yFl5DrOz7wIpJueYCscewWyjC
 dCYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUvEmYSgXVyieUXq7iHrEB7izrxJRrdvFdl6hNT1ZlLuacNVBlKqvlsW0Z5g1RN5q/GKhdZaE=@lists.denx.de
X-Gm-Message-State: AOJu0YwVWE8oE9wbONSloDy8bR1u927w/IM1mdXdoWgnRgGnU+Pjbj9n
 PlFQJisrceN+l7i7mauVplir/D0Y4ZjUCTngyLqEaMDZkPzSYZx+0NI55zVaizwwF2L3djl6oq1
 Qd4AymqhgKws2ppBk2e9ZXl0x439XW3XQ+cuHIyOiaQ==
X-Gm-Gg: AY/fxX6nnIQS5mOHQIp8Tqn/W8JrNLGRMUw3EXsuMiFiotzJta4RcnMJliLngKxE/Rl
 4FGkguGCJUuNXdRAE2BAG5BfZVi3bq8/YiIgULOHYshpexhksO1CMmpr9TDBsVMc+AUrX1rRaWi
 oYBspKrP77p4sGD2/AtfN7/XW3mgGbXdwBPygRkAblTtjl3jqOae+/ELeNr6wVXcUU1DXPiqjJZ
 mm6xlNt26CjOlxeEuE47Er09OLpFFTrAHlzsXQAG9Teqiq2lz/Xng8immLbeRc02VsSvxEyzMXC
 ZxU3cNl+ooa2JjeCh2iHrsGuAPh9tx95Jn/0KyQ=
X-Google-Smtp-Source: AGHT+IEZtOX4ZYKCe15igZcW1Cwvi4alZTd/BV3uXWkd97loux47/EI/hvld9wMzCSgE4ah4vT7RM+s4CAFC/Fktprw=
X-Received: by 2002:a17:907:94ca:b0:b40:b54d:e687 with SMTP id
 a640c23a62f3a-b80371d1dd3mr3616301766b.47.1767109731177; Tue, 30 Dec 2025
 07:48:51 -0800 (PST)
MIME-Version: 1.0
References: <20251218-clk-mtk-mt8365-fixes-v1-0-4f8ff0de3268@baylibre.com>
 <20251218-clk-mtk-mt8365-fixes-v1-4-4f8ff0de3268@baylibre.com>
In-Reply-To: <20251218-clk-mtk-mt8365-fixes-v1-4-4f8ff0de3268@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 30 Dec 2025 16:48:41 +0100
X-Gm-Features: AQt7F2rVsfp9pochwDDqi5mqo9bU3Z55yx8m7ZU2hvHQWO0gEu4JdA18wuH8lKs
Message-ID: <CAEHHSvba7Lr0DvGu8Zd_nZvbsCyft7AZe+oqOahqR3WLNaMs3A@mail.gmail.com>
Subject: Re: [PATCH 4/9] clk: mediatek: fix fixed clock parents
To: David Lechner <dlechner@baylibre.com>
Cc: Julien Masson <jmasson@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.denx.de
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

Le ven. 19 d=C3=A9c. 2025 =C3=A0 00:24, David Lechner <dlechner@baylibre.co=
m> a =C3=A9crit :
>
> Add a flags field to struct mtk_fixed_clk to allow properly resolving
> the parent clock. All chip-specific clocks are updated to populate this
> field correctly.
>
> The parent is currently only used for printing debug information, so
> there are no functional bugs being fixed.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/clk/mediatek/clk-mt7622.c | 23 +++++++++++++----------
>  drivers/clk/mediatek/clk-mt7623.c | 33 ++++++++++++++++++---------------
>  drivers/clk/mediatek/clk-mt7629.c | 23 +++++++++++++----------
>  drivers/clk/mediatek/clk-mt7981.c | 21 ++++++++++++---------
>  drivers/clk/mediatek/clk-mt7986.c | 21 ++++++++++++---------
>  drivers/clk/mediatek/clk-mt7987.c | 19 +++++++++++--------
>  drivers/clk/mediatek/clk-mt7988.c | 29 ++++++++++++++++-------------
>  drivers/clk/mediatek/clk-mt8183.c | 12 +++++++++---
>  drivers/clk/mediatek/clk-mt8365.c | 16 +++++++++++-----
>  drivers/clk/mediatek/clk-mt8512.c |  7 +++++--
>  drivers/clk/mediatek/clk-mt8516.c | 12 +++++++++---
>  drivers/clk/mediatek/clk-mt8518.c | 14 ++++++++++----
>  drivers/clk/mediatek/clk-mtk.c    |  3 +--
>  drivers/clk/mediatek/clk-mtk.h    |  4 +++-
>  14 files changed, 143 insertions(+), 94 deletions(-)
>
> diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk=
-mt7622.c
> index 9621d5efe11..93e87ee399d 100644
> --- a/drivers/clk/mediatek/clk-mt7622.c
> +++ b/drivers/clk/mediatek/clk-mt7622.c
> @@ -85,6 +85,9 @@ static const struct mtk_gate apmixed_cgs[] =3D {
>  };
>
>  /* topckgen */
> +#define FIXED_CLK0(_id, _rate)                                 \
> +       FIXED_CLK(_id, CLK_XTAL, CLK_PARENT_XTAL _rate)
> +

Hi David,

There is a typo here: s/CLK_PARENT_XTAL _rate/CLK_PARENT_XTAL_, rate

>  #define FACTOR0(_id, _parent, _mult, _div)                     \
>         FACTOR(_id, _parent, _mult, _div, CLK_PARENT_APMIXED)
>
> @@ -95,16 +98,16 @@ static const struct mtk_gate apmixed_cgs[] =3D {
>         FACTOR(_id, _parent, _mult, _div, 0)
>
>  static const struct mtk_fixed_clk top_fixed_clks[] =3D {
> -       FIXED_CLK(CLK_TOP_TO_U2_PHY, CLK_XTAL, 31250000),
> -       FIXED_CLK(CLK_TOP_TO_U2_PHY_1P, CLK_XTAL, 31250000),
> -       FIXED_CLK(CLK_TOP_PCIE0_PIPE_EN, CLK_XTAL, 125000000),
> -       FIXED_CLK(CLK_TOP_PCIE1_PIPE_EN, CLK_XTAL, 125000000),
> -       FIXED_CLK(CLK_TOP_SSUSB_TX250M, CLK_XTAL, 250000000),
> -       FIXED_CLK(CLK_TOP_SSUSB_EQ_RX250M, CLK_XTAL, 250000000),
> -       FIXED_CLK(CLK_TOP_SSUSB_CDR_REF, CLK_XTAL, 33333333),
> -       FIXED_CLK(CLK_TOP_SSUSB_CDR_FB, CLK_XTAL, 50000000),
> -       FIXED_CLK(CLK_TOP_SATA_ASIC, CLK_XTAL, 50000000),
> -       FIXED_CLK(CLK_TOP_SATA_RBC, CLK_XTAL, 50000000),
> +       FIXED_CLK0(CLK_TOP_TO_U2_PHY, 31250000),
> +       FIXED_CLK0(CLK_TOP_TO_U2_PHY_1P, 31250000),
> +       FIXED_CLK0(CLK_TOP_PCIE0_PIPE_EN, 125000000),
> +       FIXED_CLK0(CLK_TOP_PCIE1_PIPE_EN, 125000000),
> +       FIXED_CLK0(CLK_TOP_SSUSB_TX250M, 250000000),
> +       FIXED_CLK0(CLK_TOP_SSUSB_EQ_RX250M, 250000000),
> +       FIXED_CLK0(CLK_TOP_SSUSB_CDR_REF, 33333333),
> +       FIXED_CLK0(CLK_TOP_SSUSB_CDR_FB, 50000000),
> +       FIXED_CLK0(CLK_TOP_SATA_ASIC, 50000000),
> +       FIXED_CLK0(CLK_TOP_SATA_RBC, 50000000),
>  };
>
>  static const struct mtk_fixed_factor top_fixed_divs[] =3D {
> diff --git a/drivers/clk/mediatek/clk-mt7623.c b/drivers/clk/mediatek/clk=
-mt7623.c
> index 3509ea67e7d..093577c4ee4 100644
> --- a/drivers/clk/mediatek/clk-mt7623.c
> +++ b/drivers/clk/mediatek/clk-mt7623.c
> @@ -259,6 +259,9 @@ static const int top_id_offs_map[CLK_TOP_NR + 1] =3D =
{
>         [CLK_TOP_AUD_I2S6_MCLK]                 =3D 158,
>  };
>
> +#define FIXED_CLK0(_id, _rate)                                 \
> +       FIXED_CLK(_id, CLK_XTAL, CLK_PARENT_XTAL _rate)
> +

same here.

Cheers
Julien
