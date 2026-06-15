Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC67BCD98DE
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 08:18:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D0DB846A4;
	Mon, 15 Jun 2026 10:18:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="RrkLDGe9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 217BF846B0; Mon, 15 Jun 2026 10:18:39 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CEF183FEE
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 10:18:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-bf046d4da1fso271564366b.3
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 01:18:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781511516; cv=none;
 d=google.com; s=arc-20240605;
 b=inGc6kRzGiLEBNjSLHrg3wD5I3XtVRJ2aNCuSmzVEuCBlSlN0ZrKJylQzhPP1Lxhxp
 H9H/Wx6kBvz/uvZ7OYvPkEjyvCeoVrNuC9Os1n32olAjcBmvIUoIQj6D/cXr1wI5HawN
 sNVps9DuGWj7ZF3nSGQTP/+zYRY/UKKKL2rzH3jHlKi47ueto2qwGZ1kBUgULt1spCFD
 7zwugXh13zcAozs3c4b2I0g2JUoHjjsISwC3VTVGQ3DmKaB2gH0WPF92OsR/EyL861Dn
 geu1dv0+9SLZYhO7kF8s0/jJjXK/hPKwNc3A1sj4J9ZPEKPk4/kxhZM8ebTDi6WANixV
 XAhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DKRl+CQ1UWtJ3iH7nISi8QbcLAS3K1yiO/4G/eb+nW0=;
 fh=2cOBm/6QY2Q0y/jEmEv64EFYpRBPMbMlbbyNcp0MISM=;
 b=V8NQc5DG3XO4+iZRlu9H14NJLVB9jJ++WgKhNNd3IwbQI4kHBvuySk8Za5lO5/UhUH
 iXWgE4Ruil0LwOi+AD2l3C6Hw1Kyn2eiERdnuNfVs3z5IloIG2R/bnsadX1KTGohII43
 7mPAsj0hmyST8f4AF0QKuNKvXMn8481+1o5QWFZeM+6/7Hl1JS4NkJL5OW3pH5NeOTDq
 sMYoANfa+CE3AjXnxxiifrTVBOyd0wNqegpIZmmnIoqAgpAqR+cmrs13THi3gBDet01z
 Smse/LSIiVcQxibnrPe7V7n/OVYrkLDPNf/ou7hKfIZgFpBO6auonLhwPQ9eoYAkKt+u
 NiGg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1781511516; x=1782116316; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DKRl+CQ1UWtJ3iH7nISi8QbcLAS3K1yiO/4G/eb+nW0=;
 b=RrkLDGe9RYAkq+pO1B4lp/+D9nGkHfok1T3UY0/HmeI2LJ/wlxdi9KbtWbZPclH41s
 Wq5NoGPQN4V3Gdah/KXRCeXv+RmFdSRIxE5rGaU/UFkyDjy6YtmeOUzlsMq8sIS18Zvx
 7R74BE+/3nVH+5fr1MljAcCqAlKF1vJxfE6uCLUhm73LL0Cs4qxpHk82iw/1IYndHtnz
 WR4TxLtbs+7P7qmjr2dGEtZzeKOSjFkSPMVAZ4+IexnRv3qdvGQpDoZgezPZXvHuFaaq
 hwrKrGVqgOay0owkgcTTVeL9LB7WjAe8JENRjjlPRn1mDloY18EDvLe9epMwr0jibh5r
 t58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781511516; x=1782116316;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DKRl+CQ1UWtJ3iH7nISi8QbcLAS3K1yiO/4G/eb+nW0=;
 b=SZBLxUQ+xiBUP2/ZGkkyxBiwSONDIAO0Anq0CupWZ21MEs8TmJ2k3WQo2XKlYpO2xS
 rXDCWO0T/jZ46v8P0tgXOQsrsexM/yTbpUBZy1kW/L2fpUcQnJMRav3GLlukd0GHyOw1
 x3o05q+ELuPpKPHRrr5C+GH6Yd4c+utrMx4mh1P/bA9G5YT7NBTL41f4eeBChdPBHZeN
 7F8ZIwmfnA79AXM5MVbeEhfLjXi86/R+KnWuyDLYfWLCldajrLovNLdcXzW6GqiiDXui
 Q9CAN16ETZrYo6LJj8bi1dpUksP6ygqpeFMljZxIdd52HnLSgFSpQQtD3DIhgv/NduCq
 nOxA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9lfjCtKhhCipFdAcsNM5ki7Ksy+7I+Qq7mzrqcBzL7EjQUqRst5ljA43yBFEGwJQleqlbdhx8=@lists.denx.de
X-Gm-Message-State: AOJu0YwfSf4TAVB3ZLMm9sJvQ+A+qT84f7fOn9ZyiQsFrBYbTBLyQQ2W
 it1l46ds/FZIOhQ3qY2i085xHkoDbypM2xrG4lwbi24TBdW7GA3AOevOfnanx3XijVQAM8M2s76
 Gmd4/VL6IL99ocoiTXtYEqGfKypsndapGCgXJBWwABw==
X-Gm-Gg: Acq92OGlpED68Vz8teVOx9KWPcb5WpB/KVBky7IEAPbubYmIUakjlf+7ALEaZmwOJbx
 ZqKBGytalnn6ZNVEKv30UXLB98DeJNhERPeXWbITA7fPevwN/TSYn2FHvWPzxT+hKht4JhtGJPj
 LPDIBPW3CFhuOBAcrOjj4I69z8zESCqIpXZqcEYSVq7t9hN8pBQPHDspbmOdqKM21Nsh8lby7HB
 MHcZdUN8HJwzS5+WuMXMJZwIayyyRDiiEyg8vNoGl0XX92WN1M5QXQZOK4rJTdRjQkdwSKhvC5E
 GfKi8q2pgk/SdDmF7SGyRebrdfIF5lw8K2yE4/1qLigDf4Qv20zejPrPMqq2Yte0QYzxfLky2fk
 OsbptNEoBAb1z+TzVR/S4dywbeg==
X-Received: by 2002:a17:907:6d0c:b0:bd5:2cc7:d845 with SMTP id
 a640c23a62f3a-bff4bdfc1f2mr384979166b.30.1781511516025; Mon, 15 Jun 2026
 01:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260611-mtk-pick-dt-mt6359-unique-names-v1-1-601546be1210@baylibre.com>
In-Reply-To: <20260611-mtk-pick-dt-mt6359-unique-names-v1-1-601546be1210@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 15 Jun 2026 10:18:34 +0200
X-Gm-Features: AVVi8Cf2HK3ZyhRFEBedGAwXeEi4qHxpj0ABGY9g4RO2IeFQlfSRyyy34QyjooE
Message-ID: <CAEHHSvZ9QQ0gbkQv0qAxq33Q6i1ygcyL+wUZvJP2cONUErq-ag@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mediatek: mt6359: give regulators unique names
To: David Lechner <dlechner@baylibre.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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

Le ven. 12 juin 2026 =C3=A0 02:12, David Lechner <dlechner@baylibre.com> a =
=C3=A9crit :
>
> Change the regulator-name properties to be unique for all regulators.
> U-Boot cannot handle duplicate names.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
>
> [ upstream commit: d91639d0ab3223b61c00442021dc639c9ddc2b76 ]
>
> (cherry picked from commit 22ce1d7d45a696128b8ad2cb9fbc4f2073bcb4f6)
>
> ---
> This is one we've been waiting for since we added the MT6359 PMIC
> support to U-Boot recently.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  dts/upstream/src/arm64/mediatek/mt6359.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/dts/upstream/src/arm64/mediatek/mt6359.dtsi b/dts/upstream/s=
rc/arm64/mediatek/mt6359.dtsi
> index 467d8a4c2aa..45ad69ee49e 100644
> --- a/dts/upstream/src/arm64/mediatek/mt6359.dtsi
> +++ b/dts/upstream/src/arm64/mediatek/mt6359.dtsi
> @@ -205,7 +205,7 @@
>                                 regulator-max-microvolt =3D <1700000>;
>                         };
>                         mt6359_vrfck_1_ldo_reg: ldo_vrfck_1 {
> -                               regulator-name =3D "vrfck";
> +                               regulator-name =3D "vrfck_1";
>                                 regulator-min-microvolt =3D <1240000>;
>                                 regulator-max-microvolt =3D <1600000>;
>                         };
> @@ -227,7 +227,7 @@
>                                 regulator-max-microvolt =3D <3300000>;
>                         };
>                         mt6359_vemc_1_ldo_reg: ldo_vemc_1 {
> -                               regulator-name =3D "vemc";
> +                               regulator-name =3D "vemc_1";
>                                 regulator-min-microvolt =3D <2500000>;
>                                 regulator-max-microvolt =3D <3300000>;
>                         };
>
> ---
> base-commit: 3cdce049f90d77c3f9221f1eb73922384c8972c3
> change-id: 20260611-mtk-pick-dt-mt6359-unique-names-c3859afd513b
>
> Best regards,
> --
> David Lechner <dlechner@baylibre.com>
>

Hi David,

Reviewed-by: Julien Stephan <jstephan@baylibre.com>
