Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9932CAC5AC
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 00:13:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A37188D6A;
	Wed, 18 Sep 2024 02:13:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="isKu2Ho8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D42188BB6; Wed, 18 Sep 2024 02:13:21 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D72988D6A
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 02:13:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-53567b4c3f4so6138845e87.2
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 17:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726618398; x=1727223198; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5k4P26UGBSdpw4iwazbN3wzlINO4r/d3um8zYkC0RIs=;
 b=isKu2Ho8zXmRKWCXmnhKCqp+2CumWI0Rk9CdwYeW8NQZEwjSVhpgMtWp1+we2vNQc7
 Yr7RbwzyjSLq6qHB/o94LOepKXgCN7ws1ViDt7i7RDZuRuMVgjC8DoOC5N4UekKHAuGN
 CSfskUKkvcAgY87Yry06DHwQ1u3VvpEWyWCA0XqlsJthcJsdm4MDdIOnArEfaxEkptxu
 yGeCCLQVIvyRQ5BrIVm72fUvINIVudSk3sVhGuxmsy5sMGyd5zUMZCPs8HYrxvRGRYG0
 6p0phNnd8R8alYOFV+iFDng/IVvkA3WhxkUxmb9KueMCTwXeLT+TDb7BQxwKAHhh3ywk
 Tg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726618398; x=1727223198;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5k4P26UGBSdpw4iwazbN3wzlINO4r/d3um8zYkC0RIs=;
 b=v0lK25ARN9RQbwjhC/AbPLcAmiqxOfydzdS60mhyATft4XfnLxaUERKfS0H30add+t
 O9j/gVpGbAWBeQsKHsaZEnD+wC18qTpqUjkxpxispHPHTr1KKv6qRP1RbPl41cSZLM7S
 QpVepGvopArBAsWadXrD0jSY5EV5aQ4vlr5XdrvjSZKQhoDAKw5CF10cHreR51XLS4dz
 mB246p96ov2L5KhJhp+9tf/vwtyGy2MXbqLtZ5rbSDX17URpY7dHUlAs2XHcmLx2Jbj/
 0y7voATCrrt5qraMmHisE+ekb/lywL450YzqgpKgioSBa7QpUoNbNh/fwddsrsPidzj2
 +qOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhM5uOvUDgVsdEkv+2jao3Pxc8+2Swo4cnLCLs0O/Kt/0ye8KoggBITRfEImMiPxOE8GwwTqI=@lists.denx.de
X-Gm-Message-State: AOJu0Yz1oGSB+A4KBk5K2kSv4EkrlNLxKWMzCsqkosnDfyo+XPAW3v4x
 vsJPD/KMmUBwZSqEzYdtNg890QXLkmQtQ+ooSTfi7CsSEvHzkZs1yhUKy3vxOyNx8yM+SXBLVRl
 IU5r7ca0FlsrPKhQD1T3+zV1hj9nwMQ==
X-Google-Smtp-Source: AGHT+IHVKmBbLjnuXSVU+H73rQtipZn+vFdUZuksGO6auxGl59cN0XE2Y0FKFDEOeWxpIjMSZDJLtKRN7pi51pbRWic=
X-Received: by 2002:a05:6512:1254:b0:533:483f:957b with SMTP id
 2adb3069b0e04-53678ff88e8mr8924767e87.61.1726618397079; Tue, 17 Sep 2024
 17:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240917-imx9-update-v1-0-4fe8effc937e@nxp.com>
 <20240917-imx9-update-v1-21-4fe8effc937e@nxp.com>
In-Reply-To: <20240917-imx9-update-v1-21-4fe8effc937e@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 17 Sep 2024 21:13:05 -0300
Message-ID: <CAOMZO5BzLSCTOpOz7vvp-uGfPQAjViuoCP-fyV3BZ3KnxeZm9Q@mail.gmail.com>
Subject: Re: [PATCH 21/21] imx93_evk: Enable M.2 VPCIe_3V3 and deassert
 SD3_nRST
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
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

Hi Peng,

On Mon, Sep 16, 2024 at 11:31=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.c=
om> wrote:

> +       /* Enable EXT1_PWREN for PCIE_3.3V */
> +       ret =3D dm_gpio_lookup_name("gpio@22_13", &desc);
> +       if (ret)
> +               return;
> +
> +       ret =3D dm_gpio_request(&desc, "EXT1_PWREN");
> +       if (ret)
> +               return;
> +
> +       dm_gpio_set_dir_flags(&desc, GPIOD_IS_OUT);
> +       dm_gpio_set_value(&desc, 1);
> +
> +       /* Deassert SD3_nRST */
> +       ret =3D dm_gpio_lookup_name("gpio@22_12", &desc);
> +       if (ret)
> +               return;
> +
> +       ret =3D dm_gpio_request(&desc, "SD3_nRST");
> +       if (ret)
> +               return;
> +
> +       dm_gpio_set_dir_flags(&desc, GPIOD_IS_OUT);
> +       dm_gpio_set_value(&desc, 1);

Why do we need all this board code? This should be properly described
in the devicetree.

How does Linux deal with it?
