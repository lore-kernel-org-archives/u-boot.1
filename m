Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FABDC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 14:59:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D61E2849BA;
	Wed,  8 Jul 2026 16:59:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="Vk31L33n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25C17849D2; Wed,  8 Jul 2026 16:59:34 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0999384994
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 16:59:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c15d111ca99so72998266b.0
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 07:59:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783522771; cv=none;
 d=google.com; s=arc-20260327;
 b=mOQr+v5tXKADpE5j7G4EIcxAjKqhQWHSjGy0Pr0+98wsz0HInCFNRhUjaDrjALLZWm
 B+5Lw3IcOlsTg/uLkb2LT+Wn9Y4lr+wf2fnhUsTrkuBykfM+7SsR5aiVXZM//QWZGT/l
 LuwiQN6zbZZqMtO1w4+7nOF7vllURVHhUVoPCw983rD4zlyycPvye3ifPK1yDCiv4skH
 pdZSHN8wFYE2iHGj+ztwYnwunQazCpdFXjcny+3n8pHIbK/n0h0FZPqnhDk31FkDXeZS
 2iORcyHYSEbvLCIIlM99Kn8o6uXDg5jkiAVf2C8x6OiI24FKgKLeXzQILT6VqOSy48nK
 9Xnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Rk5MaRMd/JZK3UdKJjVa71/+zSDAJC0wIigLwFeFH+Q=;
 fh=YtvdrCwg44W3uHLkje5fCnL4Zh73A6UOghHe2XVb/x4=;
 b=m6x4OPn0UgGwoSKLrOoSZ0oYLJmZADXHqdsn9y3F5QHolAMmNQlKj3khE5xsC3ZtzE
 e/C0zjT3xtVSxZTohPyYCO3v5NmwHKVi1NQP5Ct0bQ3Pzvpnk0DwPuP7UbmNdqD04FJp
 cKhx1KnVVpVdFK+Ec2S6TKg0vr5nT+94teZ0isI79mE7V65VoktQjx4DABJHCWM9TnbF
 pCOWEdW2NCDDamhat+yFnF+rwRi/AahaEIQQzfuF6q8jlAi+1wriolNdGN1zoyC36deh
 ODwFA75SfEWYtTKPTy/hv0amVIm7bhOC8bFE5nnyOSa1EyhhmYBf9XVl6EUrYkay0cTd
 fPGQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783522771; x=1784127571; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Rk5MaRMd/JZK3UdKJjVa71/+zSDAJC0wIigLwFeFH+Q=;
 b=Vk31L33ntJ/+H8GOxKbzyN2SNHOz4XswHh3s0iwcbJhG0zpj3XkMVlF+bP+p664yTb
 XHFndW6NFEX1095ojCF9LVjV19nVSiWzfkL7TsdyEvBV0u0JjyQ6VjhfJJRhRqkrwVQq
 abueUor9H6gtUH/fY/SgkWkd3xzK9a+jV65107DM1N1HEZGXJaB+J1ZB3lvXdb5XTV6e
 8p/8qjxovjdXop9BcV4FBdw1VxLXyzd+Qc3RFiUWk79SvtYnov6bslQwftJ1xHq7h1DP
 mp2Ex7ZP+OLUwA98pi/vmDZAqF8PuN1lygepJPHB5ewmSKf/j2X24xpTYPxhyAFiplp/
 8qOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783522771; x=1784127571;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Rk5MaRMd/JZK3UdKJjVa71/+zSDAJC0wIigLwFeFH+Q=;
 b=DOOqDmeD+Jw26HjrpJwmdEzt2S2z2hWwZwqtJ4pafWEmM2u5TwM7bpVB9xVDOXX/e8
 DdZVoG8IEKYAG9j0E2wy6gbD4/m8EyqfFV12Utkum0GeYTGGU84TrzJIGpx9GagqzQl2
 SKiNflC4tSVdwB+ABzf2ip5EYc2G3LaJ3QeuIr7XSn+dqWaotglTHFgVAG2jt3nOSsJ7
 kqp+ANVKeIg3HD/k1iz6uxVFfJws1vhzu0tJ5evwMDQfk/MBtPEFW+o+cQz7tHx5Xl/H
 8HNfz//HvjJahH83tWmJzOfJpWeFTciMd7fexfSaPPenunzXYxjN5mOA35aVUdmzcC7E
 VELQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpwCxeTgJLNYd+58SjDOB4MzPWW0rv+TZUaWpKKQYYvBu0otYShho3CsikHtVYoAOZUVYfjYoY=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0QyZJ4iq/Ei3nTa0chcPYoEcqAuRCS+6e49O12xmTO0bj9Oiq
 hXEetTrbhDleOHTUQAj2WanmyDhgetTYLtOZnqSC5mjnJ6rEWY2X+fHlwuVjdx64OAwI+T3CodB
 BHk+mDjjpQxQYMT5nw7jFql7qGQhyA47okV0e3MfyWA==
X-Gm-Gg: AfdE7cmQYHwpxq3cjXr54dzRsgPcmJ+KWuJQAnKt+uhjMzW1BonefqSUWoNsnnXWMzJ
 B032GEego5CZLASVglV0NBl6XP6+Z/vi+6PEsmpxsWcElUzFWqujwo+DvgUo6fCLf90mfTa9ucn
 Lxvv1rHO82I/i9MPa/eHDRWPBKRS8eY/LTEm5Bi/RJAaIqT5RMn2ofCocnrMkVrYVgptQ3VAu+b
 ODBQDeX7lkWILf3R9BmX9+8GrOuMzdegfrwc10jStAIagDzf1QCncopN8msJcyaf2AKpSlZJvlG
 dZmCyypFCrZlgWaQG//zhIWueZ3ZigOxl7Wd7AVZu8W5eShWSS9CatZbadpcqKy9qqlNZ8Ordxm
 wDmgX+GFSPr/4sAo=
X-Received: by 2002:a17:907:9620:b0:c12:528a:94f4 with SMTP id
 a640c23a62f3a-c15ce162362mr130591066b.60.1783522771391; Wed, 08 Jul 2026
 07:59:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260707-mtk-clk-parent-lookup-improvements-v1-0-65d24cc0d569@baylibre.com>
 <20260707-mtk-clk-parent-lookup-improvements-v1-19-65d24cc0d569@baylibre.com>
In-Reply-To: <20260707-mtk-clk-parent-lookup-improvements-v1-19-65d24cc0d569@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 8 Jul 2026 16:59:31 +0200
X-Gm-Features: AVVi8Cevxupf2i0lktCdgmwnG5nP4FSjI4LDriOnevAEJm4CZIKT6vsv-1PMOjI
Message-ID: <CAEHHSvatOuqzids0w1=OD29vYO4U1j_rypL3YVTNpMkEuxZVuQ@mail.gmail.com>
Subject: Re: [PATCH 19/24] clk: mediatek: drop parent udevice field
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

Le mar. 7 juil. 2026 =C3=A0 17:10, David Lechner <dlechner@baylibre.com> a =
=C3=A9crit :
>
> Remove the parent field from the mediatek clock private data structures.
> This was no longer used other than debug prints.
>

Hi David,

Looks like this commit is breaking mmc on me Genio 700 board.

  Card did not respond to voltage select! : -5

And then it fails to boot.
clk dump output is equivalent to what I used to have on my Genio 700
(without the parent debug print)

One more minor comment inline below

Cheers
Julien

> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/clk/mediatek/clk-mtk.c | 47 ++----------------------------------=
------
>  drivers/clk/mediatek/clk-mtk.h |  2 --
>  2 files changed, 2 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mt=
k.c
> index d1cfa70e5a6..0afd94ed4ef 100644
> --- a/drivers/clk/mediatek/clk-mtk.c
> +++ b/drivers/clk/mediatek/clk-mtk.c
> @@ -320,11 +320,6 @@ static int mtk_clk_mux_set_parent(void __iomem *base=
, u32 parent,
>  }
>
>  #if CONFIG_IS_ENABLED(CMD_CLK)
> -static void mtk_clk_print_dev_parent(struct udevice *parent)
> -{
> -       printf("Parent device: %s %s\n", parent->driver->name, parent->na=
me);
> -}
> -
>  static void mtk_clk_print_mapped_id(int unmapped_id, int mapped_id, bool=
 has_map)
>  {
>         /*
> @@ -677,8 +672,6 @@ static void mtk_apmixedsys_dump(struct udevice *dev)
>         const struct mtk_clk_tree *tree =3D priv->tree;
>         u32 i;
>
> -       mtk_clk_print_dev_parent(priv->parent);
> -
>         for (i =3D 0; i < tree->num_plls; i++) {
>                 const struct mtk_pll_data *pll =3D &tree->plls[i];
>
> @@ -883,8 +876,6 @@ static void mtk_topckgen_dump(struct udevice *dev)
>         const struct mtk_clk_tree *tree =3D priv->tree;
>         u32 i;
>
> -       mtk_clk_print_dev_parent(priv->parent);
> -
>         for (i =3D 0; i < tree->num_fclks; i++) {
>                 const struct mtk_fixed_clk *fclk =3D &tree->fclks[i];
>
> @@ -1019,8 +1010,6 @@ static void mtk_infrasys_dump(struct udevice *dev)
>         const struct mtk_clk_tree *tree =3D priv->tree;
>         u32 i;
>
> -       mtk_clk_print_dev_parent(priv->parent);
> -
>         for (i =3D 0; i < tree->num_fdivs; i++) {
>                 const struct mtk_fixed_factor *fdiv =3D &tree->fdivs[i];
>
> @@ -1122,8 +1111,6 @@ static void mtk_clk_gate_dump(struct udevice *dev)
>         const struct mtk_clk_tree *tree =3D priv->tree;
>         u32 i;
>
> -       mtk_clk_print_dev_parent(priv->parent);
> -
>         for (i =3D 0; i < priv->num_gates; i++) {
>                 const struct mtk_gate *gate =3D &priv->gates[i];
>
> @@ -1189,43 +1176,24 @@ const struct clk_ops mtk_clk_gate_ops =3D {
>  #endif
>  };
>
> -static int mtk_common_clk_init_drv(struct udevice *dev,
> -                                  const struct mtk_clk_tree *tree,
> -                                  const struct driver *drv)
> +int mtk_common_clk_init(struct udevice *dev, const struct mtk_clk_tree *=
tree)
>  {
>         struct mtk_clk_priv *priv =3D dev_get_priv(dev);
> -       struct udevice *parent;
>         int ret;

ret is now unused

>
>         priv->base =3D dev_read_addr_ptr(dev);
>         if (!priv->base)
>                 return -ENOENT;
>
> -       ret =3D uclass_get_device_by_phandle(UCLASS_CLK, dev, "clock-pare=
nt", &parent);
> -       if (ret || !parent) {
> -               ret =3D uclass_get_device_by_driver(UCLASS_CLK, drv, &par=
ent);
> -               if (ret || !parent)
> -                       return -ENOENT;
> -       }
> -
> -       priv->parent =3D parent;
>         priv->tree =3D tree;
>
>         return mtk_clk_tree_register_provider(dev, tree);
>  }
>
> -int mtk_common_clk_init(struct udevice *dev,
> -                       const struct mtk_clk_tree *tree)
> -{
> -       return mtk_common_clk_init_drv(dev, tree,
> -                                      DM_DRIVER_GET(mtk_clk_apmixedsys))=
;
> -}
> -
>  int mtk_common_clk_infrasys_init(struct udevice *dev,
>                                  const struct mtk_clk_tree *tree)
>  {
> -       return mtk_common_clk_init_drv(dev, tree,
> -                                      DM_DRIVER_GET(mtk_clk_topckgen));
> +       return mtk_common_clk_init(dev, tree);
>  }
>
>  int mtk_common_clk_gate_init(struct udevice *dev,
> @@ -1234,22 +1202,11 @@ int mtk_common_clk_gate_init(struct udevice *dev,
>                              int gates_offs)
>  {
>         struct mtk_cg_priv *priv =3D dev_get_priv(dev);
> -       struct udevice *parent;
> -       int ret;
>
>         priv->base =3D dev_read_addr_ptr(dev);
>         if (!priv->base)
>                 return -ENOENT;
>
> -       ret =3D uclass_get_device_by_phandle(UCLASS_CLK, dev, "clock-pare=
nt", &parent);
> -       if (ret || !parent) {
> -               ret =3D uclass_get_device_by_driver(UCLASS_CLK,
> -                               DM_DRIVER_GET(mtk_clk_topckgen), &parent)=
;
> -               if (ret || !parent)
> -                       return -ENOENT;
> -       }
> -
> -       priv->parent =3D parent;
>         priv->tree =3D tree;
>         priv->gates =3D gates;
>         priv->num_gates =3D num_gates;
> diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mt=
k.h
> index 10df7571c9f..b9b9360b4bd 100644
> --- a/drivers/clk/mediatek/clk-mtk.h
> +++ b/drivers/clk/mediatek/clk-mtk.h
> @@ -275,13 +275,11 @@ struct mtk_clk_tree {
>  };
>
>  struct mtk_clk_priv {
> -       struct udevice *parent;
>         void __iomem *base;
>         const struct mtk_clk_tree *tree;
>  };
>
>  struct mtk_cg_priv {
> -       struct udevice *parent;
>         void __iomem *base;
>         const struct mtk_clk_tree *tree;
>         const struct mtk_gate *gates;
>
> --
> 2.43.0
>
