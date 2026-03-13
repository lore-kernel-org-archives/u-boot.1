Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A94105F7A7
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 12:53:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5CBB84242;
	Fri, 13 Mar 2026 13:53:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zMqh/+cM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E24D84253; Fri, 13 Mar 2026 13:53:14 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B78F8423D
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 13:53:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b9358dd7f79so338803466b.1
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 05:53:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773406392; cv=none;
 d=google.com; s=arc-20240605;
 b=eATIV0qlHgouUn2OzeMad29SZ77+zEOPum46MZJpLh4IdH10vFuXD4XfQhsBNcNJ1e
 5B1qqdbubGePJMHwJ2u4NM1GMfHEHtVZHVXVlxUhm8utInp7O5cTLLggFEWx2KFs8LIk
 d8wQ5OIEXqMezE8UoO349ruWYWRKrIFABPHPyuCj0nECMkfj3VgWPBo4yFWV5kjb3dCE
 +zEgnjKW0Iwg3TBNpnZ78s6EFsASEFMmViJ57+4qeJYDsi7XKdPpBoGbvZOt6fVlzoRZ
 r8/m2VTfnxb2ZHSe0r3i2X4TMRPM5HYsMMyE1YhCG1EK0XuVBQqYQqelwpf6EaAnFG71
 7dFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WeOHvd+X9vvu6dHcf0/eMIgGzFg7R5KSTAbH74EmTdQ=;
 fh=yCNh+yOKOSk7rPQCgKnewzT+vtTZ61Cd0TJmluNSsvE=;
 b=CKw3THl5zRlYR1VdmGac+SaD2HvQQfJPJu7YJUd07PZpZ5Df+qFRLCey2E/d43pidI
 MEJb6gXAYeq6j1f4MKqh8TR+rbeqbKzulQNGP+srmsUgfxVoaOp0Y6brYu7gTKlfbCq7
 vULdJsBbZQe148fMB3HvI+xAk1BKl3NJoQkbj8UULygb9W3xqGO2ffhhytr/lj6zXFuk
 FFcxC03DKaFXXEm7qpLSv2/k/57FMx+WnxCLkM2FqQm/xO4FWjgRaF+6TotU9WXfMJ8b
 DF/AQrpK4BOIP9vKYF10sO0vPTFLiSDaLxOl7Zd3etEqZwxxQt7xKEIyKLaAnMxUgDnj
 cv7w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773406392; x=1774011192;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WeOHvd+X9vvu6dHcf0/eMIgGzFg7R5KSTAbH74EmTdQ=;
 b=zMqh/+cMiwctgrKxwDpxQ9deh/c7WcB8hdF1bwO/rbXGUhPB8LbvE5zlA4qi8FouiC
 O6hluNF3ys77Uau5i6MdJGQ8rkF4c+6YypUNpPEWKTWDRY358ykKEqDBngzdH91dz/RX
 1zvdUmVUxuN8E40F4E3oh6yHN4N5TVSFET3JoBJl33dkYnJabcbCjU9UmJwxtnON1y6v
 waU0P/4Sdze+kdjcc5l3y4oHJxnYowcqludQDkfwX6xzs9hGIjjXIFdm0CFrnDoWDxzZ
 91FE2tZT9bczlHKvmNXrnGBRkgIWmC9DRNwUVUKAxhTDyjhZ4QdxEZy66XGy+K6e7qDq
 SG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773406392; x=1774011192;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WeOHvd+X9vvu6dHcf0/eMIgGzFg7R5KSTAbH74EmTdQ=;
 b=BsqLQS+0va+vQueAK+7YZiGsMmCQ2DoWvLm7ITFSbDcKVZsLupmeh7XSXMslslhNWR
 lMWUPXEMZ5i8Hm12czUHXTH0LfNwCUugKFLDpJ+elYyomWOx1IFxbtNyD6l6RsQIC+4e
 J9D8IuIMtrzQD/m+J4T0Hw77kH4r0Ye2rqNWu/sXiIK/tOS8A+hVEcHZguM0LQP0tXuG
 PkQtMpQMpJgT+k5w1SlsS8SOrHL0KZr7oW/wjvBP+iVK8Io16xMr3aIUfC1vmKj/Ly9q
 GVd0ANk7PsWDbLVEpswuyitDEfAWngpWWJJQl6nace10t6/p/mvLEbBAenT6svUQyYYd
 f57A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGhuC0vSjZjz0mUe4tP1MCr2MHvWTPGhD1YGDM94rJqvepN0s4VkNzyWV6Crt+bLPQvOiHaRE=@lists.denx.de
X-Gm-Message-State: AOJu0YyUMH3qaQ2X+gQt0l73sF66kqSUxWtb6gTxjrqmv7YYI/ln7L8x
 jXES4rHMOmSJHXt1osMOEhJKgHx+qcOW9XUFIt4SiYvbn9m4KEyx9q7rDDTAkVKzu21mPouWciG
 jPFSDmpHZeGE7vIEP9iEEQH/8K97onJIdgO24Ar+DwjTrcEcqBe2LPEZSSQ==
X-Gm-Gg: ATEYQzwNaJkNoQ+IqPb/E7GECKVHJDfUGkKyfHTlW4ouX6PsSDW6QhFpfYPamsI35FJ
 sC22xLgpNEFgk2ci2Y+oSg6Vf4zPNGtv82+83HLD4z/umrWeRJ3+NDaTNT7LvgI78r5maebHFrx
 QO1Ai+KMknb/FbBDR9JHbf2q8vZadYJ7JaUV0SjCT+rXprHEhsd3jHEQpsej8GajJjIpZwnl9MM
 u1tIgzCAZTfcfY4h7cRrLUCcxmElWYIJWafmxs7a5GXFRH8H8DF+9oa1izG6kcWUSn/qPjBuHAp
 lnOuHH9ZiKTIgKO2KxAhM6ziI+lHNAmuBYkDUinUOPxOio7d2eym0t79zG6WZGhEfMfYyI6wpVE
 UdztgCwqyd43GzkNP8xEtkWvXWg==
X-Received: by 2002:a17:906:3bd2:b0:b96:e05c:a7a8 with SMTP id
 a640c23a62f3a-b9764fc945amr139258066b.16.1773406391523; Fri, 13 Mar 2026
 05:53:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260303-mtk-mt8189-clocks-v4-0-ee85f8dd2f0d@baylibre.com>
 <20260303-mtk-mt8189-clocks-v4-1-ee85f8dd2f0d@baylibre.com>
In-Reply-To: <20260303-mtk-mt8189-clocks-v4-1-ee85f8dd2f0d@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 13 Mar 2026 13:53:03 +0100
X-Gm-Features: AaiRm53HNtS9BOq39W8AMWHsWPT-mDwBG21tjBolqUvdkoBcr5xPJCIGmLh--p0
Message-ID: <CAEHHSvYMiCZ4jAXp6jEhg6AhZ5Dv3_Ak-8H1mT7S2FPD3_X7dw@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] clk: mediatek: use correct struct type for
 infrasys clocks
To: David Lechner <dlechner@baylibre.com>
Cc: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Le mar. 3 mars 2026 =C3=A0 20:55, David Lechner <dlechner@baylibre.com> a =
=C3=A9crit :
>
> Fix the private data type struct type in a couple of infrasys clock
> functions.
>
> struct mtk_cg_priv is a superset of struct mtk_clk_priv and has the same
> layout at the beginning so there was no compile errors or runtime bugs.
> This could only be found by inspecting the code.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/clk/mediatek/clk-mtk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mt=
k.c
> index b4de38719e1..b3f05bf5a21 100644
> --- a/drivers/clk/mediatek/clk-mtk.c
> +++ b/drivers/clk/mediatek/clk-mtk.c
> @@ -933,7 +933,7 @@ static const int mtk_infrasys_of_xlate(struct clk *cl=
k,
>
>  static int mtk_clk_infrasys_enable(struct clk *clk)
>  {
> -       struct mtk_cg_priv *priv =3D dev_get_priv(clk->dev);
> +       struct mtk_clk_priv *priv =3D dev_get_priv(clk->dev);
>         const struct mtk_gate *gate;
>
>         /* MUX handling */
> @@ -946,7 +946,7 @@ static int mtk_clk_infrasys_enable(struct clk *clk)
>
>  static int mtk_clk_infrasys_disable(struct clk *clk)
>  {
> -       struct mtk_cg_priv *priv =3D dev_get_priv(clk->dev);
> +       struct mtk_clk_priv *priv =3D dev_get_priv(clk->dev);
>         const struct mtk_gate *gate;
>

Hi David,

I guess we should also update priv_auto definition of mtk_clk_pericfg
in clk-mt7623.c ?

Julien

>         /* MUX handling */
>
> --
> 2.43.0
>
