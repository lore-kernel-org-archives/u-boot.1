Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6072EC25B74
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 09:30:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B19C4886C9;
	Thu, 30 May 2024 11:30:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O5GcDOx/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D560D886DB; Thu, 30 May 2024 11:30:49 +0200 (CEST)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com
 [IPv6:2607:f8b0:4864:20::92d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C723588684
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 11:30:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eballetbo@gmail.com
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-80acd145929so171753241.3
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 02:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717061446; x=1717666246; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fdxT+EXkKZ4ki4Yf1H1avIH1nXMJqx4aB48RXADYzCI=;
 b=O5GcDOx/QkUxL82fxt9bTUx5Sy80X5r2fzN3lHyZP55AO56Dm/oKH0HzFmEVXEGZCR
 iJfDfs3KATXEb3c9cEoh/ZeoLSJ3iKeLi09pFhuSfkVARvhjlC5ebMr+GO4grvAacSWN
 oj4rzwBTdSI9idhWwJvtejCEXo+6ih7AWaSXK5yPOsnbJzeotWGUBvpk7NMPiaP9phXE
 Bd+VM7YDjqAyLrTgtFEYAQ337T7Fw2+jVm9nZCAdJqlSFzyEB3TZQHxm2vxInMvhgW0f
 iMmjU0Yv/86dSCse2XkHEBYHTy5xvUCcYqbGy7g9I1kuydNNe9N/tjPb47GQy8cpsTLt
 jONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717061446; x=1717666246;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fdxT+EXkKZ4ki4Yf1H1avIH1nXMJqx4aB48RXADYzCI=;
 b=vTAHfm00LG6OIkGVR/NLbFkEXcvxpcjX5FSnqukcTa5HZBbNdFNjcOSNxfKCbsvLPD
 rUiJQZvDOEJz4RPy4BkRo8prP3S9+1XWNhkwgpxM8JXUEm8hgoLSrHl/MMb3N/upkCgd
 h7OGSdPreUyH425Pjh4azARxoqwtbe4V9/1EOYspzkRYcL3BbovD7YCa2hWMT1FiI2Zl
 Y1Mcp5+JHiHKYIb9lyI9tXokXVlUWbMKP2frlmneBmkMgTl0zuekwxwAgNjsQM5T8Ker
 vf4KqL6OMU1YPk8RIlhkY1Ch+TXvpnMqUEUhJNS0pUskTG5R3Fgn3RXOalQq7gv5n6yz
 IFgA==
X-Gm-Message-State: AOJu0YysyjT40la18dR4ZGgvGEpiCGuFMJT2uSuc4fKp0wz0l1AqSr7m
 F3pHT0x0guZUmqQdee1SzYfj6voirwuKnb7TamT1AyjHCSO7IGdRaFPgMZrHW2DbUCvkZ6kGlIS
 4d8dchXO/lEPcqID/T+teAIaxGM8=
X-Google-Smtp-Source: AGHT+IGnESqrN2aQamRLoVVRi0cyb1moFHQStWRtKczYKoKHWCSuDuwHl7vEyKAVE+Ej0Y5gytt9uFvhfB8+gg9tfis=
X-Received: by 2002:a67:ad0f:0:b0:48b:ae5b:b356 with SMTP id
 ada2fe7eead31-48baea188bbmr1562841137.15.1717061446543; Thu, 30 May 2024
 02:30:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240518130622.219031-1-javier@dowhile0.org>
 <20240518130622.219031-3-javier@dowhile0.org>
In-Reply-To: <20240518130622.219031-3-javier@dowhile0.org>
From: Enric Balletbo Serra <eballetbo@gmail.com>
Date: Thu, 30 May 2024 11:30:35 +0200
Message-ID: <CAFqH_510wFu+AT2tDAYDHU2kuwRfgoW8Oieo5C3ctqE1qyCUew@mail.gmail.com>
Subject: Re: [RESEND PATCH 2/4] omap3: igep0x00: Drop unused SPI support
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: u-boot@lists.denx.de, Javier Martinez Canillas <javierm@redhat.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>
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

Hi Javier,

Missatge de Javier Martinez Canillas <javier@dowhile0.org> del dia
ds., 18 de maig 2024 a les 15:06:
>
> From: Javier Martinez Canillas <javierm@redhat.com>
>
> There are no SPI peripherals in neither the IGEPv2 board nor the IGEP COM
> Module, so there's no reason to have this enabled in the boards defconfig.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Reviewed-by: Enric Balletbo i Serra <eballetbo@gmail.com>

> ---
>
>  configs/igep00x0_defconfig | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/configs/igep00x0_defconfig b/configs/igep00x0_defconfig
> index e4d25556e3f3..6df6c33e25ab 100644
> --- a/configs/igep00x0_defconfig
> +++ b/configs/igep00x0_defconfig
> @@ -82,7 +82,4 @@ CONFIG_SYS_NAND_OOBSIZE=0x40
>  CONFIG_SYS_NAND_BUSWIDTH_16BIT=y
>  CONFIG_MTD_UBI_FASTMAP=y
>  CONFIG_CONS_INDEX=3
> -CONFIG_SPI=y
> -CONFIG_DM_SPI=y
> -CONFIG_OMAP3_SPI=y
>  CONFIG_BCH=y
> --
> 2.45.0
>
