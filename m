Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 223DEE94114
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 20:31:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BA2A86E45;
	Fri,  6 Oct 2023 22:31:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nu/uknE+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B7C186E70; Fri,  6 Oct 2023 22:31:55 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04F0286ACF
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 22:31:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rfried.dev@gmail.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-57e3c2adbf0so1371435eaf.2
 for <u-boot@lists.denx.de>; Fri, 06 Oct 2023 13:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696624311; x=1697229111; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bj6anwmjp0NnOe5LaXD9O06QqxOr/gXLYVI+mbtrMmM=;
 b=Nu/uknE+0MlL4gHlma1jsyPEHH1Bw89Ly1rUCtTvCcAQvFXSCTDGKAPOEPV+QJ6yWW
 BsqhRG0jmIy6iNoeb7e4GslDiPf8vqCCUppDPNxjtE+SoJl5bT9YMDe3mZAVbagjwMwl
 KDyTCirTsDPkP25AWXyvgNzXtJZjXO1PSPPtPy2tIUNRI4Nbi80ZIBBIgV1lwIuzJ8aP
 srMuq4UHriQWTrID5tfNnoMRGIFwsYn/FNt2pQZ1n0kowbmknp4z55zxnI9EDxuwh/Wp
 isPSHqUGSf+zeSkrYW3fxYTpoXef2j9b+IfqHjKU8XyIBYlShxJFO00AlGt1JZaB6KX2
 9L4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696624311; x=1697229111;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bj6anwmjp0NnOe5LaXD9O06QqxOr/gXLYVI+mbtrMmM=;
 b=khUvZk5UXpyJ9LdG0QhFZe0x3VYyUGL0BTQsgNCsMBg9sbrUnXZ15y5pu20wLWx6rf
 yKIoANbU7pBGtpxLLo16SRLFfq0b2jkTt1NnPI1RJX1nVvGB4xnLJ4ePSdWk+pbGYvBV
 ckKxgkp8gQ79VGYG+UJ7+6KNF/g93G4WdcfIcFRXQEHO6UXQUnAegc47/UBE+mOggnun
 M6lONVC5Nd5vtIf7U9YXLJLNtyV5aXP89jAnzWRqRbYpksvPLH9N354N6dFYLBvax6S2
 bUXrl0Cn7LTGQiqghJXwZmjcjxskwfbDhWTKbDHkkUtKMY75qO14tqvraEzBNrZOY7Tp
 r+lQ==
X-Gm-Message-State: AOJu0YxpBi3dP+dOzNHMyuNu2Qt5pcuDcNctHlu3+wp4yJC745L9yrUn
 LrA3O20AXAYPF/Y5a71hUWuFgN/wfUUhEqdYByg=
X-Google-Smtp-Source: AGHT+IFngbvPhH1CYstLYInDV0qN2MoSMeNd9iBaqMnxg4ApgFNd8xjvxSDaN02GOSHfsqcXyybE2K4eWgnLLpTsxwQ=
X-Received: by 2002:a4a:300f:0:b0:57b:a346:167e with SMTP id
 q15-20020a4a300f000000b0057ba346167emr8772850oof.6.1696624311655; Fri, 06 Oct
 2023 13:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230727015814.3459990-1-dylan_hung@aspeedtech.com>
In-Reply-To: <20230727015814.3459990-1-dylan_hung@aspeedtech.com>
From: Ramon Fried <rfried.dev@gmail.com>
Date: Fri, 6 Oct 2023 23:31:40 +0300
Message-ID: <CAGi-RULN4KXhGg3FpJu4GC3EC0nzBDOGwx6CP1V=3b02-PN8sQ@mail.gmail.com>
Subject: Re: [PATCH] net: ftgmac100: Add reset control
To: Dylan Hung <kobedylan@gmail.com>
Cc: ryan_chen@aspeedtech.com, chiawei_wang@aspeedtech.com, 
 BMC-SW@aspeedtech.com, joel@jms.id.au, joe.hershberger@ni.com, 
 u-boot@lists.denx.de, Dylan Hung <dylan_hung@aspeedtech.com>
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

On Thu, Jul 27, 2023 at 4:58=E2=80=AFAM Dylan Hung <kobedylan@gmail.com> wr=
ote:
>
> Add optional reset control, especially for the Aspeed SOC. For the
> hardware without a reset line, the reset assertion/deassertion will be
> skipped.
>
> Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
> ---
>  drivers/net/ftgmac100.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/net/ftgmac100.c b/drivers/net/ftgmac100.c
> index a50cde338a..886b97119d 100644
> --- a/drivers/net/ftgmac100.c
> +++ b/drivers/net/ftgmac100.c
> @@ -13,6 +13,7 @@
>
>  #include <common.h>
>  #include <clk.h>
> +#include <reset.h>
>  #include <cpu_func.h>
>  #include <dm.h>
>  #include <log.h>
> @@ -90,6 +91,7 @@ struct ftgmac100_data {
>         u32 max_speed;
>
>         struct clk_bulk clks;
> +       struct reset_ctl *reset_ctl;
>
>         /* End of RX/TX ring buffer bits. Depend on model */
>         u32 rxdes0_edorr_mask;
> @@ -568,6 +570,8 @@ static int ftgmac100_of_to_plat(struct udevice *dev)
>                 priv->txdes0_edotr_mask =3D BIT(15);
>         }
>
> +       priv->reset_ctl =3D devm_reset_control_get_optional(dev, NULL);
> +
>         return clk_get_bulk(dev, &priv->clks);
>  }
>
> @@ -593,6 +597,12 @@ static int ftgmac100_probe(struct udevice *dev)
>         if (ret)
>                 goto out;
>
> +       if (priv->reset_ctl) {
> +               ret =3D reset_deassert(priv->reset_ctl);
> +               if (ret)
> +                       goto out;
> +       }
> +
>         /*
>          * If DM MDIO is enabled, the MDIO bus will be initialized later =
in
>          * dm_eth_phy_connect
> @@ -628,6 +638,8 @@ static int ftgmac100_remove(struct udevice *dev)
>         free(priv->phydev);
>         mdio_unregister(priv->bus);
>         mdio_free(priv->bus);
> +       if (priv->reset_ctl)
> +               reset_assert(priv->reset_ctl);
>         clk_release_bulk(&priv->clks);
>
>         return 0;
> --
> 2.25.1
>
Reviewed-by: Ramon Fried <rfried.dev@gmail.com>
