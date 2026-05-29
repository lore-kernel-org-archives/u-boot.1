Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D49AECD5BD2
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 07:01:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDBC5844CF;
	Fri, 29 May 2026 09:01:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SeVDSz6A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C5A6846B4; Fri, 29 May 2026 09:01:04 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F49283FF5
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 09:01:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-bce386d5b85so2035466366b.1
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 00:01:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780038061; cv=none;
 d=google.com; s=arc-20240605;
 b=T0Gk+iI2EMaJAveoHtVXn74bKkiRUqLgf625s63Ri20Y/VHai2QpzdSSmpJ2lqlcbX
 N2llFIQtQs3itayS+N7oR7QZBcOTV4N3EdpgOmRnEH0Hg9tx9Whs06QN08Ajd52cDYKF
 yMEfQXbgFLjpqhRlpAjjsOxZ/QyN7QLdUT3lQ61tfmmx9yIX4t5EyucQZI9thp0Tln++
 FSqCVZ2XX1VgAcn9dD/XJUGcW34hCVYHuJfUUofYmr/SvISyz9ArXhJvZXm6ziy8+TS6
 J9kq4mV/q9Rd/HsgcSBVCfOHGqtGJxBfs5lJ8xfycQ+VnpOYP6t0mfPJR4WQeGMc4rdK
 pGxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rsWvv30Z0EOnNNyi1t8233qvMRRiY69N/XaOJWBvcWE=;
 fh=gfM/jS9kVTLkLMDfHgxTWGohb1DAjlzr0LcjND49VtU=;
 b=N7TvBSm9MwI0oMZiw92wsMsYuWZWnhQGLp4R6bCVJLmPr1lHeOZAzrNkjLvb8FKfBG
 ee3dte3JQskzeMtfZblk+0hcUaFj2jFPH7w98P1N6BuYqvdd3smmHqHQi29tlFhCoe7P
 5+GbdWH6x3lYraNXI4pUC6bhVbJXC3LhchjPqHWpw7lGuMagrouHgjGTrzzFtV5hKWGd
 JfA1+fX7ePdgLg7eqWF0MHfGijq9ECt8k41m2zUUi40VCfqTr73HwQv7gOD6WYF3l0B4
 1pqihQWfiypsXEuc3WT6dsKFHqQXIc7jYhFuQ8EErHgAPAbcUx2yjsvM0Fe5Qf6IyMMq
 XvYw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780038061; x=1780642861; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rsWvv30Z0EOnNNyi1t8233qvMRRiY69N/XaOJWBvcWE=;
 b=SeVDSz6ApsmnZ7imZRi/vbk3Veoj6XCx2yUrGacgMqeb0o0OloDrzu1+G1EOdSI5d2
 AUWsNNtB9+7vuJylZNPWi3kWe/ENTg7/Kh/xMGrs0sBlAGJEowqOTjEupFouOeGt9/X0
 7rxaEAAm1GQMPiqh5Z6VWVV1+kozZzf2yXDEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780038061; x=1780642861;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rsWvv30Z0EOnNNyi1t8233qvMRRiY69N/XaOJWBvcWE=;
 b=IBogUYKhWd5GYF48AP+u4YJehPYWuzRer89QRhEOOkkNYGkQiWQJUNYEFUu8+ibkHY
 d7mw8pQyvuSdl5MgQxBG0eWBdJFxBMfexmCnCEE1vx4qJcO/ZSWm9l7Cdagt9XTS1FLy
 LULZ9whCZ9vEsbsgOqJ6HHNiBbXH+aEylMVnv5WgaVWWW3qxaJdH7ueeXUOu3veufms0
 hpBC8vnZS5dlobGe4azQUVQNTDz1XHrDwmxqOLYzKA6LgxzW3L/uuIxPwC1j/+zD+FM2
 3QgReKCbi/6C4d8bKhfoo5qOMersbY9FTb0uFyvFi75+T1p0PIQVZt2Jx2lcK+YLQwJd
 I4MA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/pLNPIpe3U16KYWg0p4IOSnJBSwUIciTKfm8c1Jwcqs714w9el5G6NqzdFybVVU92PNaLCJjQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwEPPY0ySwUuPDeTHyvJQsuuG93KkVs882Votq04PBWSxN0XMNZ
 scCw6oYGMFhz9a/9t834yxG0XujG6LhbX4bIM93hIMEN8j3ZMGLLGI54MIqAQWWXRUQI4F/MRy6
 IkwPSM/WxdvqSlC92lfZN2RtqSyNP8qBsO+0T8Czs
X-Gm-Gg: Acq92OHmJqWud6mDTsHMMEXn8HWKaaY4LBK43GtYtZYaMl7mpqaz9awCt6S9MRcku5r
 ORaH99XPvowUMoYj+fOhAe8vZjOACczYcX4Yjy79dz7nGPYlI1vNaQHfrAeK9fBMuBqA697gaOC
 5jrlSnm1ZMzyQRB6zyWsOnMtzkvp6C3yyTzltZQ+jIFS42taMQfgm96T7dNCe8uiyKrrZxvoxjb
 c+/co766+8yHbAr2aOVeUyJiGw/qsxEWlCpsIHveZlorDld9d5NUYzHf/bCTmVNc2rl+C4DWdzS
 HVuRqUGz0LmGYQZ4JFG+Oxe7MPP/8Q==
X-Received: by 2002:a17:906:c10e:b0:bad:255d:b5bc with SMTP id
 a640c23a62f3a-be9cfc86a4bmr67360566b.39.1780038061102; Fri, 29 May 2026
 00:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260527-devfdt-spi-v1-0-37db1f6c168a@nxp.com>
 <20260527-devfdt-spi-v1-5-37db1f6c168a@nxp.com>
In-Reply-To: <20260527-devfdt-spi-v1-5-37db1f6c168a@nxp.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 29 May 2026 02:00:47 -0500
X-Gm-Features: AVHnY4LJ4KifaEmXbU2Mqccly4LfAT8gI0280IvHwuE9tOjuB7sWaiXESJ59rlQ
Message-ID: <CAFLszTjJLv7wWRRPWB6+0FcJ7LuFuB4GNsm==YyDAhsMp0yHuw@mail.gmail.com>
Subject: Re: [PATCH 5/5] spi: ti_qspi: Use device APIs
To: peng.fan@oss.nxp.com
Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, 
 Naman Trivedi <naman.trivedimanojbhai@amd.com>,
 Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Julien Stephan <jstephan@baylibre.com>, 
 "Noah.Shen" <noah.shen@mediatek.com>, Meiker Gao <ot_meiker.gao@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Ye Li <ye.li@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
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

Hi Peng,

On 2026-05-27T02:35:23, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
> spi: ti_qspi: Use device APIs
>
> Convert the driver to use driver model APIs for phandle parsing and address
> handling instead of legacy FDT interfaces.
>
> Replace fdt_getprop() parsing of 'syscon-chipselects' with
> dev_read_phandle_with_args(), and switch address-related helpers
> from devfdt_*() to dev_read_*() variants.
>
> Also update 'num-cs' handling to use dev_read_u32_default().
>
> Remove direct dependencies on gd->fdt_blob and simplify the code while
> keeping the existing behavior.
>
> No functional changes.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>
> drivers/spi/ti_qspi.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)

> diff --git a/drivers/spi/ti_qspi.c b/drivers/spi/ti_qspi.c
> @@ -437,17 +437,16 @@ static void *map_syscon_chipselects(struct udevice *bus)
>               return NULL;
>       }
>
> -     cell = fdt_getprop(gd->fdt_blob, dev_of_offset(bus),
> -                        'syscon-chipselects', &len);
> -     if (len < 2*sizeof(fdt32_t)) {
> +     err = dev_read_phandle_with_args(bus, 'syscon-chipselects', NULL, 0, 0, &args);
> +     if (err || args.args_count < 1) {
>               debug("%s: offset not available\n", __func__);
>               return NULL;
>       }
>
> -     return fdtdec_get_number(cell + 1, 1) + regmap_get_range(regmap, 0);
> +     return args.args[0] + regmap_get_range(regmap, 0);

My reading is that passing cell_count=0 with cells_name=NULL tells the
parser there are no argument cells after the phandle, so
args.args_count comes back as 0 and the args.args_count < 1 check
always fails.  Doesn't this need cell_count=1 ?:

   err = dev_read_phandle_with_args(bus, 'syscon-chipselects', NULL,
1, 0, &args);

Also can you wrap to 80 columns?

Regards,
Simon
