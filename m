Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E3EFCA0FF2
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 10:34:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4683C833BF;
	Wed,  3 Sep 2025 12:34:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ISWvbcT5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62128833C6; Wed,  3 Sep 2025 12:34:07 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D6F383390
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 12:34:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-337e5daf5f5so6921651fa.0
 for <u-boot@lists.denx.de>; Wed, 03 Sep 2025 03:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756895644; x=1757500444; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vmgpjr/CtZa+4IRvXXm62bX7Xt8ucE0+FLK7ni4OAEA=;
 b=ISWvbcT5CuOla1VYnwf9sxAMg922JNAC2OMV1U2OTWJNCYH9z0LDgKi/dDNFJvqw1i
 +MhZbflgsnGUMJ2+AX6JbvzKj3WMm+tk66zKqGT81ko9Ke6oKRGTM1CLYbrxnr1kqz+t
 wq2nyUdXnJIMkU+LBNV9ihm5gTHls1iuhg/SDesfZnS79UFTcBlsEDfV5pXOScZ56d8R
 M9rrKuxSkr4Nrj3xEpEs/j3YNc0zVBE351P2JvSoLg738xlZDnl6XskQZqOV9o8hy8z6
 57X9feqeYanGBBDEi13YwIa9nxM2wrdrq5+uXkVDkSv0mu+SFO57aJeE0aoYxnvHyh77
 NGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756895644; x=1757500444;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vmgpjr/CtZa+4IRvXXm62bX7Xt8ucE0+FLK7ni4OAEA=;
 b=FnFkyGdUEcjb+CitEM4xKQmfxZxMhmy4F34lTMRItRuapQflY3niT0LzBnKQYUBhUA
 OdJHMpYHV9cMHnRl9v0lSrLCHpTH8fB0hgHWsbHr8liL2CR6/FZC4pRw+rE2AuC5jk1Q
 1q7BUy2CsOMSge6DfBF2NrUgvxO+HJOHMjAmbz6IfATvBDQAvozIwJWnCpsnGN7s2mtx
 kS8CzGbSzVweFIfUrmXk93BvQO1Yb9KOBSdzf6TNumuNh4I/qRMCCw5KouE89BMXj8GH
 6aImJMJf9/Jb7rAZt7hLMJt4Oj1gQrcIbQT0tfq5PTiSzFEb5Wxf8KzaFsovglHIknH7
 qvIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpWFzQMbcmFCf+nrMd+PQYyk25y/nmy0YTzYvzur1kyN/3RCB7PhTQzQxYkcrnPRjV921dnXI=@lists.denx.de
X-Gm-Message-State: AOJu0YyPCCkQqUOGOE3iXq1bemgO81WieyrvIeLfy+ytzIqmTjLMz6YB
 HFam8t74VhTeh9A6IsvkS3JzYoz4OZpmg0VtZphpr8idvoyEU9Fedsbi3YWlR08V+FHLkW/I5Ip
 oLh7blzSL5hUldnyAGH6ukSCrwNT94rU=
X-Gm-Gg: ASbGncvtWRZekvxQPVpNuLM+YPmVkorUT8vw3MgJw47Z2EMFwGcdH4POS3zz+MrrlJ3
 STBJl1nyIYEKhZFSBMSh0G9hywM/ekwXe+xxsGOiblYNO63rswnl4TzeuBtCsJnXe37e8JcZM3R
 cc0JOY+RO6g+TCIdKchsrONMrY6tnBGd0WGJPsRUiMCKce9NG861CmI8w1hcpx+L+fKpicOqYPR
 wiZcCNeGeEkgh2Hk2gGGJYLdNK4XDlofCxJ/++p
X-Google-Smtp-Source: AGHT+IF3DOoscRT+bEsWufoGr3Qsw0lx27UWY1Qr52xHxiKdyl4TbG8AVElzCiDIt0rrlS1bquB3KRnr6qjIK4mMfIg=
X-Received: by 2002:a2e:b887:0:b0:337:e2c3:c080 with SMTP id
 38308e7fff4ca-337e2c3cca3mr30609591fa.16.1756895643291; Wed, 03 Sep 2025
 03:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250812-exynos_spi-v2-1-b467d4b75167@linaro.org>
In-Reply-To: <20250812-exynos_spi-v2-1-b467d4b75167@linaro.org>
From: Minkyu Kang <promsoft@gmail.com>
Date: Wed, 3 Sep 2025 19:33:51 +0900
X-Gm-Features: Ac12FXy1UOyv_4TJEcqx0vF4n1fF8BIf9Sfz_Iptxtvw1l7NuuR9pphgtZbsSdA
Message-ID: <CALrBrZ1vkpb-F_EdEc+vFpy5VBe69b0cwRSMHZL0+T6mtF3ZwA@mail.gmail.com>
Subject: Re: [PATCH v2] spi: exynos: Remove extra term from test
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi

2025=EB=85=84 9=EC=9B=94 2=EC=9D=BC (=ED=99=94) 00:23, Andrew Goodbody <and=
rew.goodbody@linaro.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> In spi_rx_tx there comes a test for execution of a code block that
> allows execution if rxp is not NULL or stopping is true. However all the
> code in this block relies on rxp being valid so allowing entry just if
> stopping is true does not make sense. So remove this from the test
> expression leaving just a NULL check for rxp.
>
> This issue was found by Smatch.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
> Changes in v2:
> - Remove the stopping variable which is now not useful
> - Link to v1:
> https://lore.kernel.org/r/20250812-exynos_spi-v1-1-bd0813ff6593@linaro.or=
g
> ---
>  drivers/spi/exynos_spi.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/spi/exynos_spi.c b/drivers/spi/exynos_spi.c
> index 1b9bf004b7c..7f2965f8321 100644
> --- a/drivers/spi/exynos_spi.c
> +++ b/drivers/spi/exynos_spi.c
> @@ -105,14 +105,10 @@ static int spi_rx_tx(struct exynos_spi_priv *priv,
> int todo,
>         uint out_bytes, in_bytes;
>         int toread;
>         unsigned start =3D get_timer(0);
> -       int stopping;
>         int step;
>
>         out_bytes =3D in_bytes =3D todo;
>
> -       stopping =3D priv->skip_preamble && (flags & SPI_XFER_END) &&
> -                                       !(priv->mode & SPI_SLAVE);
> -
>         /*
>          * Try to transfer words if we can. This helps read performance a=
t
>          * SPI clock speeds above about 20MHz.
> @@ -161,12 +157,10 @@ static int spi_rx_tx(struct exynos_spi_priv *priv,
> int todo,
>                         while (rx_lvl >=3D step) {
>                                 temp =3D readl(&regs->rx_data);
>                                 if (priv->skip_preamble) {
> -                                       if (temp =3D=3D SPI_PREAMBLE_END_=
BYTE)
> {
> +                                       if (temp =3D=3D SPI_PREAMBLE_END_=
BYTE)
>                                                 priv->skip_preamble =3D 0=
;
> -                                               stopping =3D 0;
> -                                       }
>                                 } else {
> -                                       if (rxp || stopping) {
> +                                       if (rxp) {
>                                                 if (step =3D=3D 4)
>                                                         *(uint32_t *)rxp =
=3D
> temp;
>                                                 else
>
> ---
> base-commit: 7807ed921314cd7af83fd88162d0b8c6fb20a9ca
> change-id: 20250812-exynos_spi-8172ecb31a83
>
> Best regards,
> --
> Andrew Goodbody <andrew.goodbody@linaro.org>
>

applied to u-boot-samsung.

Thanks.
Minkyu Kang.


>
