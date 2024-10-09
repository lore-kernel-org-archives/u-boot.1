Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 026C3CF042B
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:56:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42EED890D5;
	Wed,  9 Oct 2024 03:55:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="diS5Lb7v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7CEB890A9; Wed,  9 Oct 2024 03:55:50 +0200 (CEST)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6354890F3
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:55:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7e9f8d67df9so2560193a12.1
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728438945; x=1729043745; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VLaTh7jOM3JKspE7a/n+hb/l5+aep67p/dSLDIsP70s=;
 b=diS5Lb7v4n7cybkHlci2wYT+2pcKjgRoau3CzS/TXvvXwlsqu0TIGnp0jnaL+ascEE
 DrStv3oLztku37pzz/vQxxSo50BGUfBC0i1u1OwpQC9WxgHKIMtOGOiC2Xj8+TETbnvm
 Ob6eWqmyno2+hTERYWZc11/qotdpSvveH6hH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728438945; x=1729043745;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VLaTh7jOM3JKspE7a/n+hb/l5+aep67p/dSLDIsP70s=;
 b=Hyf6n1eK+/oNg7vtx5pmqfHCqeu5rRdjLR2J/sDhqiqmZeIpo5aRpq8q3HVRecLJx8
 Zi2mFRdTcHmpxDsNU7m04JvKW4DfDLb+5T2U22TUoKf+r7n2bWqWZ6jAJUKx8q0iKj5p
 ih8fDUuLZwpjMrpZ1ScSTwX6UBWUY9196ZBNeSlfrhF7qVNB29K+9fH8X07/CuWkovtJ
 6cXK7rzOR24LZUlpjGgJuorjvll7cIRA2wH7i8set9dz4SgIIS+cKpIOYEiHs2o5eJZU
 JJc25U/dWyK9pOWIV3zCBNJN/Y5DMlbBcxQz9btezTVCYS/X5QaFwLDzLcVg9sYHdLvA
 7Fqg==
X-Gm-Message-State: AOJu0Yz+QG4w3Fmx018QQptMQsPLc4Yfe7vXHRlP6X2dNF6eFU8H5CvB
 5x592ji9BIZfIwuF+Sg4nruSLdkHU1mdS6GkJ97n0apf6BJ2bn5k8hEBf5/cT+WR4FYEXEDAPU3
 vOdLKJ5hLm2xK4UYazSQgqIaHqc76isMxQcIG
X-Google-Smtp-Source: AGHT+IF9v4wyLC0oR8kHSj1/XkUmrRscuY0qsSDxacPez23tdgPqMdYT5BiVV4SyLIN2U0y3KCKLlzWSe69lMsGuWFQ=
X-Received: by 2002:a05:6a20:d046:b0:1cf:e5e4:d225 with SMTP id
 adf61e73a8af0-1d8a3c3b55bmr1156253637.37.1728438945554; Tue, 08 Oct 2024
 18:55:45 -0700 (PDT)
MIME-Version: 1.0
References: <20241004225916.361000-1-marex@denx.de>
 <20241004225916.361000-3-marex@denx.de>
In-Reply-To: <20241004225916.361000-3-marex@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:55:29 -0600
Message-ID: <CAFLszTgyKe1penWB-TYm8y73=OWw6BuZdxJ4maRobgz37EF=3g@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: stm32: Generate u-boot.itb using binman on
 DH STM32 DHSOM
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com, 
 uboot-stm32@st-md-mailman.stormreply.com
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

On Fri, 4 Oct 2024 at 16:59, Marek Vasut <marex@denx.de> wrote:
>
> Describe the u-boot.its generation in stm32mp15xx-dhsom-u-boot.dtsi
> binman {} DT node as a replacement for current CONFIG_SPL_FIT_SOURCE
> use, dispose of both u-boot-dhcom.its and u-boot-dhcor.its.
>
> Use fdt-SEQ/config-SEQ to generate a list of fdt-N fitImage images {} and
> matching configuration {} node entries. The configuration node entry names
> no longer encode _somrevN_boardrevN suffix, which was never really used, so
> drop this functionality by default. Rework board_fit_config_name_match() to
> match on the new configuration node entry names.
>
> Users who do need the match on _somrevN_boardrevN can either replace the
> fdt-SEQ/config-SEQ with fixed fdt-N/config-N nodes which each encode the
> matching 'description = "NAME_somrevN_boardrevN"' to restore the old
> behavior verbatim, or better use SPL DT overlays for U-Boot control DT
> the same way e.g. i.MX8MP DHCOM does to support multiple SoM and board
> variants.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Sean Anderson <seanga2@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@dh-electronics.com
> Cc: u-boot@lists.denx.de
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
>  arch/arm/dts/stm32mp15xx-dhcom-u-boot.dtsi    |  1 +
>  arch/arm/dts/stm32mp15xx-dhcor-u-boot.dtsi    |  1 +
>  arch/arm/dts/stm32mp15xx-dhsom-u-boot.dtsi    | 53 +++++++++++
>  board/dhelectronics/dh_stm32mp1/board.c       | 19 +++-
>  .../dh_stm32mp1/u-boot-dhcom.its              | 91 -------------------
>  .../dh_stm32mp1/u-boot-dhcor.its              | 70 --------------
>  configs/stm32mp15_dhcom_basic_defconfig       |  2 -
>  configs/stm32mp15_dhcor_basic_defconfig       |  2 -
>  8 files changed, 70 insertions(+), 169 deletions(-)
>  create mode 100644 arch/arm/dts/stm32mp15xx-dhsom-u-boot.dtsi
>  delete mode 100644 board/dhelectronics/dh_stm32mp1/u-boot-dhcom.its
>  delete mode 100644 board/dhelectronics/dh_stm32mp1/u-boot-dhcor.its

For the use of Binman:

Reviewed-by: Simon Glass <sjg@chromium.org>
