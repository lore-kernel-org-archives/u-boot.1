Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B57C3DA41
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 13:34:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CA248862E;
	Wed, 10 Jul 2024 15:34:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HklREROn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D30188702; Wed, 10 Jul 2024 15:34:11 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 264D788606
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 15:34:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2ee9bca8652so4328501fa.3
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 06:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720618448; x=1721223248; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oMI4ZD3HTslCEekqBLhMu5pLb68wiQbtAFvRN/oF1lA=;
 b=HklREROnsJCDxNNhJ6SXtBod/WR7q0LU07DWmLuVavFBJPZlVaDcKcPsdYKxDozXAl
 0hX4j4IFAmWJ08jMeA7sT6q/LFZvdbR8859BWC54+HoKZ15PsUjdIYBuCVCv3VUujl+B
 M65fSNqOxDYakJWhY7nZ6iliqW8rBUhxYrQK8EipIKMoMZs0RGBE9hA67lGUArUm82ax
 ZftfoLte/CupnsF+FuMOAq3C/zAiTQBHgYn4ne3YVLrQJCt4UlIkLCqqMdFATkrGM/7p
 YCfXVpZjBxustFgZSFXYFu2/hQSn/Lcfc20Pwu/+dmif01PL/VdOuVgcy/D/2afric9k
 S4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720618448; x=1721223248;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oMI4ZD3HTslCEekqBLhMu5pLb68wiQbtAFvRN/oF1lA=;
 b=S2PErmBQUInnGph0liBlCEfgY//5Vk3P3T/xcEqgwt3JE0jbpYLtorA/5ju4rk/yt7
 wW+3olIxcELhXDktMvCU/3avKzDJxF1ZG3j8zO4J89Lc8hlbOWS2Zs6G3Gp155oaMOnB
 wO3GJLtJYN2W1WWU5b864hrqG5+LhZv1plx0t5PhFz0hd2RYV50aF8R3dOSbBa7WsQS+
 sOIavLukhGNLDAaEratkOylpqnC4JlomhagUwypi6I+o5wXBQKsD2KrH/wPi68ZRF0fp
 k/Tej9umJBUvcjoy6kQmd5toehW2xx1D+oAPc7Mym0i29ppg/823zHcs3YPW69IiRSr2
 zt/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCzeY3oYaRVV65HgLwFiOoOi4vyPujgi/Sr3gy6ewN9ATLF5XB5Dpvm/AjU6dod57oMWr2gin4ScFXYNfDF+XuefWZWg==
X-Gm-Message-State: AOJu0YwhdIpQ5TS+2BrsazDH6/b10MWQNDsC1fBBlh/Oc/zRW7nJkgq4
 9TWxxeUlouffRwpcIw0PGorOaQ+Sm8XOI6gPtVIsGTh/yGO2u9cbTQciTAjq8GtFVC2G8BDZDgE
 L9qPpYnFUKzHTp1/sKMWfvNOMbwQ=
X-Google-Smtp-Source: AGHT+IGqj9sP1LriNxj95SmiNjyQBN5/LI+nYNAGBxmYrIQWohR7pc64LCp1XrGTsrKQXDW+PztNOlGJj8bHnSnq6F8=
X-Received: by 2002:a2e:9643:0:b0:2ee:8d03:9127 with SMTP id
 38308e7fff4ca-2eeb31bc80amr24960801fa.5.1720618448076; Wed, 10 Jul 2024
 06:34:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240707082001.20746-1-michael@amarulasolutions.com>
 <20240707082001.20746-2-michael@amarulasolutions.com>
In-Reply-To: <20240707082001.20746-2-michael@amarulasolutions.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 10 Jul 2024 10:33:55 -0300
Message-ID: <CAOMZO5Ddm_2rerosTctkCzcd_+ku7VfsrxfXOEU1NynEOgoQbA@mail.gmail.com>
Subject: Re: [PATCH 1/4] clk: imx: clk-imx8mn Fix nand and spi clock parent
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, 
 linux-amarula@amarulasolutions.com, u-boot@lists.denx.de, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marek Vasut <marex@denx.de>
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

Hi Michael,

On Sun, Jul 7, 2024 at 5:20=E2=80=AFAM Michael Trimarchi
<michael@amarulasolutions.com> wrote:

> -static const char *imx8mn_ecspi1_sels[] =3D {"osc_24m", "sys_pll2_200m",=
 "sys_pll1_40m",
> +static const char *imx8mn_ecspi1_sels[] =3D {"clock-osc-24m", "sys_pll2_=
200m", "sys_pll1_40m",

The kernel uses osc_24m. Why does U-Boot need to be different?
