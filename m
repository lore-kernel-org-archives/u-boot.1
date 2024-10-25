Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1766FD0C600
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 11:20:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C6A488ED2;
	Fri, 25 Oct 2024 13:20:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Sh0Kk6nw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6CCD88FE4; Fri, 25 Oct 2024 13:20:32 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EB4E88DFE
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 13:20:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2fb51e00c05so29970101fa.0
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 04:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729855222; x=1730460022; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vyyma5Jk6JThDCMq3d9E6wHSy+krktLU1KLenlI1TFE=;
 b=Sh0Kk6nwXxAGQtajCK5wwOmVCvbt8rTBipnCo0t1pItvvtlNKuesAF/74zJhr1dlN5
 piMIiRY14hzm78y+EME4NXRQ4PMbtfEuGnVkx7e9jiv5AHbaC3B2Zcr10i0YkAZzvgZG
 LYNpHUodtcJ1LJjlnccHmCBe3499yXbfSSu8oejX54Ew4VP5oReCD1CkiwMENtzjzdSy
 usO7irnxFQy3+KpVGAEiEQXFh2MnhAUBsyyDHWiGraV1pawOlwd0O2LWZFn/YP4NSceN
 nhp4s/X+LsGqCDZFFbBttE/YpecEYxoYwgKVlEtRBKcWgSvnJv1AODJ2DmyQpaAIpfg8
 DefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729855222; x=1730460022;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vyyma5Jk6JThDCMq3d9E6wHSy+krktLU1KLenlI1TFE=;
 b=jeIslqOlz1yb/0zo8jzhcKlOZVGShB4bEW+8Fql+pUDAErsMWaARqb3IzLHVd4GRWe
 YGsyfB68dUHsXC0lDte5OBZ3YniP9QrUokKz4Tbbc3vIL/born3jfL/njlpdKLtV/IZe
 KqBrerqWYQkVei47XRdVP4Dk498zsLt6YxJBbbOu0cpqBq1osAT3J99ATieZlEt0R+5B
 zAfEcwidppPyEwxSSaNDMhgni4PDkV//FzRE97Uh2ohBPlM5k0wHy4nc5W3Du6/Z9FCO
 LTePZJFsmsYbmQDUjjDmbse47yr36kJeYAGlrO62C61hKVwLhR3fbvndqakwx6Ik2KcM
 B+1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4js3tmvcVj32hXAW2iVMIlm8jo8uyQrtlIi5+/YZB96GviTAwhRgTB7VRr/ZldCaK7G5rdH0=@lists.denx.de
X-Gm-Message-State: AOJu0YwRI7MpemwVb5QdSx4xBo+qVyz2kTgrf++xMOcIa+HWa3tkKBID
 XJN36KBt8uP+SveI7jmkTPu9aIXOdmo3fYa/e3P1hTpcjWjNokV1PRHNjDzaJX8lwSdiTwvDuUF
 lhNgdbJJdmqMycTRvTF7cxyqt4dcRK2gp
X-Google-Smtp-Source: AGHT+IFqHUjG64q0tD2/oUfzcfHJD8xClHI9DdGpjuHCoao42ypI+TjI2SvSa8JaWo0z0V3GFunroq71L2W+G6AAFAg=
X-Received: by 2002:a2e:71a:0:b0:2fb:510c:7237 with SMTP id
 38308e7fff4ca-2fc9d580d75mr62920121fa.41.1729855221989; Fri, 25 Oct 2024
 04:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <20241025004411.585310-1-gilles.talis@gmail.com>
In-Reply-To: <20241025004411.585310-1-gilles.talis@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 25 Oct 2024 08:20:09 -0300
Message-ID: <CAOMZO5BQoZ=MvRqmcZW8GsAGjfJsnev8dUwgLE1EOnO43c5ybQ@mail.gmail.com>
Subject: Re: [PATCH v2] board: emcraft: Add support for Emcraft Systems NavQ+
To: Gilles Talis <gilles.talis@gmail.com>
Cc: peng.fan@nxp.com, u-boot@lists.denx.de, uboot-imx@nxp.com
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

Hi Gilles,

On Thu, Oct 24, 2024 at 9:44=E2=80=AFPM Gilles Talis <gilles.talis@gmail.co=
m> wrote:
>
> The Emcraft Systems NavQ+ kit is a mobile robotics platform
> based on NXP i.MX8 MPlus SoC.
>
> The following interfaces and devices are enabled:
> - eMMC
> - Gigabit Ethernet (through eQOS interface)
> - SD-Card
> - UART console
>
> The device tree file is taken from upstream Linux Kernel
> through OF_UPSTREAM
>
> Signed-off-by: Gilles Talis <gilles.talis@gmail.com>
> ---
> Changes v1 --> v2:
> - Removed unused usdhc properties from dtsi
> - Moved to correct ethernet PHY driver (REALTEK -> ATHEROS)
> - Removed empty board_late_init() function
> - Moved env variables to an env file

This version looks better, thanks.

CI reports an error.

Warning, treated as error:
142/builds/u-boot/custodians/u-boot-imx/doc/board/emcraft/index.rst:6:toctr=
ee
contains reference to nonexisting document
'board/emcraft/imx8mp-navqp'
143make[1]: *** [doc/Makefile:70: htmldocs] Error 2
144make: *** [Makefile:2445: htmldocs] Error 2

Please fix and resend.

> +#include <miiphy.h>
> +
> +#if CONFIG_IS_ENABLED(NET) || CONFIG_IS_ENABLED(NET_LWIP)
> +int board_phy_config(struct phy_device *phydev)
> +{
> +       if (phydev->drv->config)
> +               phydev->drv->config(phydev);
> +
> +       return 0;

Can't board_phy_config() be removed now?

> diff --git a/board/emcraft/imx8mp_navqp/imx8mp_navqp.env b/board/emcraft/=
imx8mp_navqp/imx8mp_navqp.env
> new file mode 100644
> index 0000000000..a8b76574b4
> --- /dev/null
> +++ b/board/emcraft/imx8mp_navqp/imx8mp_navqp.env
> @@ -0,0 +1,13 @@

SPDX header is missing for this file.

> +int board_fit_config_name_match(const char *name)
> +{
> +       if (is_imx8mp() &&
> +           !strcmp(name, "imx8mp-navqp"))
> +               return 0;
> +
> +       return -1;

return -EINVAL;

> +#if defined(CONFIG_CMD_NET)
> +#define CFG_FEC_MXC_PHYADDR          1

With DM, this is no longer used, right?
