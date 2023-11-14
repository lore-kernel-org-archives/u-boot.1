Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47AC1C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 07:49:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1D538719F;
	Tue, 14 Nov 2023 08:49:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="otFh7vXn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8735871A4; Tue, 14 Nov 2023 08:49:53 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7414987129
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 08:49:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-9d242846194so772476066b.1
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 23:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1699948191; x=1700552991;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=giCPqrMaviis8rbvgCiHaE1NVywV+SaWX/jkefzcI3A=;
 b=otFh7vXnES7KL+DlZrUe4dIcBeNxnX97+czT+8eac69KDwASL1UyRnSkLj7XJ88e34
 x+aSQSa687gnqn5sx4kX0a7rwxpF8BIKPJiYnWq5/vZ13lIYHMEuhLkdZnWt3xtvDZOy
 baOrhVt/Rj/nx9PJwtvIp9ZiUoOpPvWPkAJK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699948191; x=1700552991;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=giCPqrMaviis8rbvgCiHaE1NVywV+SaWX/jkefzcI3A=;
 b=aV3DhKcQzMLM4SXMxL88NPo5EKPGuyfVLJcbKXKuPp+1XMo+kNetUZoPjxZpBpnOW9
 KRfiErwZGMu31YEObCqw3THT9w+kNgYAVFJYnQVfsKOliYiOxM7iwGXS942XzejIATFl
 KgRYGBQqFRJLftnUGtEkghAr2DP7W86ErSH3T6+PVbF8grMZUc0rg6yHIRRZjEDEWKCm
 CIX7GIRyKIpEW9pQrYXAyGplROEq1cxAzCeSt+16c5FXdsoP1d2B4IGmoAxILGM3BuZC
 QoEpjzjZGTbKlCB+ilstfbu9MhvCTJQuPzR+2TDx5P1qJyYqDYV5CBt5RKtK7A0bl9SF
 qTHg==
X-Gm-Message-State: AOJu0YylYuKRrH1n+I2VWSGnSI/mWBG1wpLwxQ9w7UMGOonL8p1fHEjd
 qljCzt3N3BRO/USDNBUY5HvrcG4WHZtjGW5TiVBUkg==
X-Google-Smtp-Source: AGHT+IGvVphHAi83gqUJvlm/LvgqRgKzRWp/rYi+pVzlN8zP/TLF4pYJHwy3g+CNgNG1fluUxh0oYcRsua44H7X+RGQ=
X-Received: by 2002:a17:907:76d0:b0:9ae:7502:7d30 with SMTP id
 kf16-20020a17090776d000b009ae75027d30mr5154317ejc.57.1699948190823; Mon, 13
 Nov 2023 23:49:50 -0800 (PST)
MIME-Version: 1.0
References: <20231114074838.3534552-1-hs@denx.de>
In-Reply-To: <20231114074838.3534552-1-hs@denx.de>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Tue, 14 Nov 2023 08:49:39 +0100
Message-ID: <CAOf5uwkh7N9c1z1utAa=LQgh3+YG04y=31bTS9LhBcgMBd86sA@mail.gmail.com>
Subject: Re: [PATCH] mtd: rawnand: omap_gpmc: remove unneeded variable
To: Heiko Schocher <hs@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
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

On Tue, Nov 14, 2023 at 8:48=E2=80=AFAM Heiko Schocher <hs@denx.de> wrote:
>
> remove unneeded variable ecc_flag in omap_correct_data_bch
>
> Signed-off-by: Heiko Schocher <hs@denx.de>
> ---
> azure build is fine with this patch:
>
> https://dev.azure.com/hs0298/hs/_build/results?buildId=3D110&view=3Dresul=
ts
>
>  drivers/mtd/nand/raw/omap_gpmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/omap_gpmc.c b/drivers/mtd/nand/raw/omap=
_gpmc.c
> index 1a5ed0de31..1fe8b1671e 100644
> --- a/drivers/mtd/nand/raw/omap_gpmc.c
> +++ b/drivers/mtd/nand/raw/omap_gpmc.c
> @@ -637,13 +637,13 @@ static int omap_correct_data_bch(struct mtd_info *m=
td, uint8_t *dat,
>         uint32_t error_count =3D 0, error_max;
>         uint32_t error_loc[ELM_MAX_ERROR_COUNT];
>         enum bch_level bch_type;
> -       uint32_t i, ecc_flag =3D 0;
> +       uint32_t i;
>         uint8_t count;
>         uint32_t byte_pos, bit_pos;
>         int err =3D 0;
>
>         /* check calculated ecc */
> -       for (i =3D 0; i < ecc->bytes && !ecc_flag; i++) {
> +       for (i =3D 0; i < ecc->bytes; i++) {
>                 if (calc_ecc[i] !=3D 0x00)
>                         goto not_ecc_match;
>         }
> --
> 2.37.3
>

Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
