Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4501AC021B3
	for <u-boot@archiver.kernel.org>; Sun, 23 Feb 2025 12:46:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB50080F67;
	Sun, 23 Feb 2025 13:46:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HeaOdkh4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0550880FBD; Sun, 23 Feb 2025 13:46:26 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1202F80F56
 for <u-boot@lists.denx.de>; Sun, 23 Feb 2025 13:46:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-38a8b17d7a7so1904405f8f.2
 for <u-boot@lists.denx.de>; Sun, 23 Feb 2025 04:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740314783; x=1740919583; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kpjJAn9UayRS/hmuq7Ky5iOWovLueD8nEwfXHZLz4s8=;
 b=HeaOdkh42v1pU1jG+ZFIodpTdc4s2OeC41quz9NfFyJce9eByKqwt9b5xS6sWNr4LH
 TOma0CpmPGEB+4k/gAwmSxwkR2nvCze8Wb4gtutKxlrehlz3Wl2JzGJsYz3gwzHFkEow
 HYXgDyBmHPA3jDc/MAxm+lHNN6QniTTk3XMQcMh8wdVsFtA0SLnmQiNNQVQTKeK1WLwd
 Az/FgyrHgFZe1qZBxT6ucE+Ocj6qM4O2sMY9z00rri7lD2rq4Dj4KAF/qxUiFkJKO+0T
 pqVJHvO2om42BFWVSx8usPonukviRosRzAlMO2wgQ5WgVDUfsYAkoWoDk5mNqeiSaF61
 IdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740314783; x=1740919583;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kpjJAn9UayRS/hmuq7Ky5iOWovLueD8nEwfXHZLz4s8=;
 b=JUWf38XRq4/Pzreo6VvWTBmuYH/kFjR9ASKY5gkf2SLShRdakyH4PFrYq/4RiknyVf
 KOmXGdktuvUumveopcVjAGIGjYYa2dP4e4JUayWFvSGqA8VZr6I0uyrgrV+OnDID9dX6
 cn91q/PVAOSJTKqyBNy7u9ajx6fBdAwL1IY9tyDMBjpSe7+FZWb1ZIYE6YYUTrNeB5dh
 7vx8Lpxhuk2OkwRpBZHbA3/vt3gQ76ODv0NbgoOK50Ov7J++NN0UreQ4onymAgeJGY51
 Hguo3ML47CyKt/sa2zHEatjq1dTzIPuf3z4LAqh5E5elRqGO531p1Yi+57RDZFZ2W4vS
 FoMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4N9s9seULE163fAdZ9GobrTZmhsFoCzzbtrlz4AmkFBCJS9i0RRhWR8Fkq4c5OVo0mCCCQIA=@lists.denx.de
X-Gm-Message-State: AOJu0YxEoTCPrCkrKnJkWdqquW73NB1FCfLopjS3sOfBQfja1CDBaX7k
 Aca/LXd4tsMPcYo3CFiEgCnhXcppAcKxLu8OxDYBGgdfLjq3j+i/EO9iLAc+MXkA2PBxBSR2Gc0
 TF40BYYf3ifiB5md6ND/LkdRq05k=
X-Gm-Gg: ASbGncuaSrOTtuD0rkCc4f1pRXuAYJIVmVPy7u7bD5tIraVMO1V7SMrxvjCQSPcN91V
 cmqWfTbT91I1cDNqmCXzVqDYQyIJyO0NgSjtZ0XH7nMVr3aNTXvT8EkjRHWSLPlwWgbev6oFIB7
 9ASzuoxW7y
X-Google-Smtp-Source: AGHT+IH5ASKehMRlzUXBm4WZPc6S1qQnhNHe1y3Lv4ia9dd4VSACv1/MxYGFho/A2t2Xiyfp2wAmgWMyn6Yqb75SWCY=
X-Received: by 2002:a05:6000:1845:b0:38f:260f:b319 with SMTP id
 ffacd0b85a97d-38f6f0b27femr8021127f8f.44.1740314783487; Sun, 23 Feb 2025
 04:46:23 -0800 (PST)
MIME-Version: 1.0
References: <20250223-vop2-pt2-v2-0-71350e482970@riseup.net>
 <20250223-vop2-pt2-v2-3-71350e482970@riseup.net>
In-Reply-To: <20250223-vop2-pt2-v2-3-71350e482970@riseup.net>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 23 Feb 2025 14:46:12 +0200
X-Gm-Features: AWEUYZkANgECFxfHLmu80uEFdc5zGwM5ys4YBecE1pTPGmqIN8TE7F5B2stEapA
Message-ID: <CAPVz0n1_Va2bhqtCwfnv2=0zJeY3TC6PuMUDwtNkW+hdxGgQ_w@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] video: rockchip: dw_mipi_dsi: Proceed when
 external PHY is not defined
To: Dang Huynh <danct12@riseup.net>
Cc: Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Ondrej Jirman <megi@xff.cz>,
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
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

=D0=BD=D0=B4, 23 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 14:14 Dang=
 Huynh <danct12@riseup.net> =D0=BF=D0=B8=D1=88=D0=B5:
>
> From: Ondrej Jirman <megi@xff.cz>
>
> In this case the DM returns ENOENT, not ENODATA.
>
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Dang Huynh <danct12@riseup.net>
> ---
>  drivers/video/rockchip/dw_mipi_dsi_rockchip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/rockchip/dw_mipi_dsi_rockchip.c b/drivers/vide=
o/rockchip/dw_mipi_dsi_rockchip.c
> index c47992dfb133cda029eba82e842ac824ceead64b..95e825eb3d6de7ef2836fa029=
927034394486e9c 100644
> --- a/drivers/video/rockchip/dw_mipi_dsi_rockchip.c
> +++ b/drivers/video/rockchip/dw_mipi_dsi_rockchip.c
> @@ -839,7 +839,7 @@ static int dw_mipi_dsi_rockchip_probe(struct udevice =
*dev)
>          * NULL if it's not initialized.
>          */
>         ret =3D generic_phy_get_by_name(dev, "dphy", &priv->phy);
> -       if (ret && ret !=3D -ENODATA) {
> +       if (ret && ret !=3D -ENOENT) {
>                 dev_err(dev, "failed to get mipi dphy: %d\n", ret);
>                 return ret;
>         }
>
> --
> 2.48.1
>

Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
