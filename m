Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2071FF46442
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 09:59:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8359C84006;
	Mon, 16 Mar 2026 10:59:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vWXZoetJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A4C28400F; Mon, 16 Mar 2026 10:59:55 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E08F83FFF
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 10:59:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b9382e59c0eso722064266b.0
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 02:59:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773655192; cv=none;
 d=google.com; s=arc-20240605;
 b=LUH/kiuFjaWT3RqxmuMQ7wXigZyplnKqwZ2S5Yd4fzQHCdCIfaQKVjBsE2KNZN4SSI
 jhm127eTXNcYf0mkKNUOxVlAlhZB41WfS5VJ79aJYANyMT95JBWO/g74YV0sWgeqdLJG
 5kqwaYouEmvybxLHP2tE4uThlJ5AOOb55vdRQTClwjFfDFp79BvmxzvV+DBgMU2BoqQN
 ZfLX1IEjm0jrymFjxFxsGoz6FE/QiBmAi0rehgAOOBsdQk1r50+zEArAtm71jnsCkM5y
 Pvn2owYqc5b20K7eIjLYk7zBcHCUcQlCfuNyLf06TMLwIvQ8blS8hLt1/iJqwAEz/HNq
 rbNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EKYu1oHhMaD4No0LaPm2XQF3iz5GYRvqyXBLpdJaxl4=;
 fh=G/rdBhGV8pEss0Q+FX2itn+LnclDUbSrEVEuheKhx5k=;
 b=MacY99XFASf78NOJlblTYC/cAbEr9s/KY+r11wLGg3cdjQ3eyi2jyRUMOAlGB6m4z+
 EVRILIeO2gME0DL5DA2a6XTdpNWEW9GyRSWG9TBCoYjjNJKsSlLThSHqlac+aZsDvkxO
 0Jm4ub3PRCwDR+WRoP3PrJQuLglcJ8tY9/hBtFl9gLi5lEraZut/YlhK4F7gid9Ux5lt
 +tErjSZcezF2OLB1BGE/tKrHyMBTI8qu5RRSAJfuW22OkXVLP8ZqI6WhjNZ23zc1rgbt
 RI7ImBikwLSj9pQGMpNRvCQ2dzSCv22OoUAJhEnSd/lGa+O3N0C7fK6kmddOEo+RebHj
 c+qg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773655192; x=1774259992;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EKYu1oHhMaD4No0LaPm2XQF3iz5GYRvqyXBLpdJaxl4=;
 b=vWXZoetJ0oq4dvW6NG8eUFvTBLXB8v4jFvC5n4mq3ksv8kHYlywEQ76rSyDVn/Q2v0
 SRw5MuAq+2q4yUH3QWCg/5XwpBsfrgCUpJLCKnOYlY03AIK3UjHS2ohDMzLYCiKZD94F
 Ndiu0T6B4N5cm1Y18mjDHNQ3aerBsiE4SqV0+p7lrPLfg0NmXq+rKt69qIUb05m8osYn
 FLgUu/ZT+j2Ws500x9sJWfeuflFi7JwMOHCg3OpxFQaw4oiV4bSkFOKWDqYWFhvn+puZ
 LVF9g8SBrnJyGFmv+X/MM+X7VsfU1JuhFU9AGQm9oidIjWtuw+7drUAjKZKXeHnVt1S6
 Mxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773655192; x=1774259992;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EKYu1oHhMaD4No0LaPm2XQF3iz5GYRvqyXBLpdJaxl4=;
 b=d1VNLyZvnAzI/Xk/1cr9tzu6Y8/9pqEyDXD/0EUe8ds2P1edFq9P9BgaKoUIeowGe+
 P3dwAEBiligUgoW82cX3tvQ35R47Cq2aIuCYg8zW5X6jJcHU4oXK0RcVLEkdVV4c+80k
 bgkKhefwyFV3q76VuJaxazf6UdXlYjYzAg0zEY1zsT9c1ZbTfRxoFHs0GARFicDZwaWm
 rcYkhgKlhIRHdHm7LHnxKtR6bED+Lr07FBJLo7MKmVluaU+t3rRoAuTtG0SnvmyMVRu4
 PwxJJIQMxhiri59sgTb1Ej5W4dxBiCFtJAi1dXB55PmDPO36QRWtFDCvhRBb71GY2kvA
 EtUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWG4eYEHPE02WcTlk9B8FqUj1lGpLxuV9Yv/U+iMGHwsw4v/PeQu/fQEWvMMJhJhScapvjYmQg=@lists.denx.de
X-Gm-Message-State: AOJu0YzlP2YII5C5yrdWcxy3TAhY3f7uPlfk7m37mIP5uJFFfhSY8Ekt
 1tvY2zIqO+OkdIB01+aK9+nsv9s+tQkFu8WnPmZXfzcH+r/auABmjRqn+Jx/YnNew1rxwbZSEIs
 f9k2Y/6DXkI1Sw74946ibNdUiBrfvdMEnTOwb48xUJA==
X-Gm-Gg: ATEYQzwZ99ipqjV16ftpG4jtTI7lFlEGdxldmCYbTuB6sgE2kZpzWUt5KeaSmGRI+EP
 TwOyKnuoHsFb6OPQbCPoLvc0pPw3hrT8wKhaBCukYcW4Cl/E5o8SMlBgir3D84T+udRyWWaImCV
 fMlk31EnIDaBX/Mdn0ryIWPYFbdcrkvgCamfCBGx1GUlCQDAh5eLlwEwToD4LIO4WhpphqGO6X0
 zy//yGTA3R17Jg2xhybEGTGlpGkhxHlnLgKGBculTdqbKqu5nyVO9pRCdLDx8jyZiQrXElzg5+F
 AC3YUC4NxoN5lJd2tWu8Go+smckIh28QfSfZHBCV48u4ztmUEk+zyajMAq3Rm0AMJwZe8DsoSvn
 Y8Dl34jKmh3PO+XGQ/q62YITAA9dsxIz7ABvt
X-Received: by 2002:a17:906:f5aa:b0:b97:a68c:878f with SMTP id
 a640c23a62f3a-b97a68c8ce6mr277238966b.44.1773655192480; Mon, 16 Mar 2026
 02:59:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260309-clk-mtk-unify-mux-parents-v2-0-b084ea74b99d@baylibre.com>
In-Reply-To: <20260309-clk-mtk-unify-mux-parents-v2-0-b084ea74b99d@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 16 Mar 2026 10:59:45 +0100
X-Gm-Features: AaiRm53gigkmPbGwFKb5Qfmknr-lqtM-KWaLOS27NotwEjaOHqIuZFZryCwG2gc
Message-ID: <CAEHHSvZ5=-wm7J0e5RHsw3zx9KSQJEHZXa+ypuVuhQXWiNjoFA@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] clk: mediatek: unify mux clocks
To: David Lechner <dlechner@baylibre.com>
Cc: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de, Macpaul Lin <macpaul.lin@mediatek.com>
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

Le lun. 9 mars 2026 =C3=A0 22:29, David Lechner <dlechner@baylibre.com> a =
=C3=A9crit :
>
> The MediaTek clock driver currently have two ways to indicate the parent
> tree that contains the parent clock. This adds to code complexity and
> makes it more difficult to know the "right thing" to do in new drivers.
>
> The plan here is to convert all mux clocks to use the more robust option
> of using struct mtk_parent to specify parent clocks. Then we can remove
> dead and duplicate code and macros.
>
> The conversion to the static const struct mtk_parent arrays was done
> by script to minimize the chance of error (and save time).
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> Changes in v2:
> - Rebased on updated dependencies.
> - Link to v1: https://lore.kernel.org/r/20260302-clk-mtk-unify-mux-parent=
s-v1-0-32f45085f4d0@baylibre.com
>
> ---
> David Lechner (13):
>       clk: mediatek: mt7622: convert to struct mtk_parent

Hello David,

Is there a reason to have 2 different series to convert to struct mtk_paren=
t?
You are already doing this kind of cleanup in [1]. Can we merge into
one single series? Specifically we end up doing this cleanup into two
commits for mt7622..

[1]: https://patchwork.ozlabs.org/project/uboot/cover/20260306-clk-mtk-remo=
ve-clk-bypass-xtal-flag-v2-0-b253b49f17b2@baylibre.com/

Thanks
Julien
>       clk: mediatek: mt7981: convert to struct mtk_parent
>       clk: mediatek: mt7987: convert to struct mtk_parent
>       clk: mediatek: mt7988: convert to struct mtk_parent
>       clk: mediatek: mt8183: convert to struct mtk_parent
>       clk: mediatek: mt8188: convert to struct mtk_parent
>       clk: mediatek: mt8195: convert to struct mtk_parent
>       clk: mediatek: mt8365: convert to struct mtk_parent
>       clk: mediatek: mt8512: convert to struct mtk_parent
>       clk: mediatek: mt8516: convert to struct mtk_parent
>       clk: mediatek: mt8518: convert to struct mtk_parent
>       clk: mediatek: remove CLK_PARENT_MIXED flag
>       clk: mediatek: refactor duplicate *_mux_get_rate()
>
>  drivers/clk/mediatek/clk-mt7622.c |   88 +-
>  drivers/clk/mediatek/clk-mt7623.c |  147 ++-
>  drivers/clk/mediatek/clk-mt7629.c |   71 +-
>  drivers/clk/mediatek/clk-mt7981.c |  231 ++--
>  drivers/clk/mediatek/clk-mt7986.c |   10 +-
>  drivers/clk/mediatek/clk-mt7987.c |   75 +-
>  drivers/clk/mediatek/clk-mt7988.c |   79 +-
>  drivers/clk/mediatek/clk-mt8183.c |  584 +++++------
>  drivers/clk/mediatek/clk-mt8188.c | 1522 +++++++++++++--------------
>  drivers/clk/mediatek/clk-mt8189.c |   12 +-
>  drivers/clk/mediatek/clk-mt8195.c | 1349 ++++++++++++------------
>  drivers/clk/mediatek/clk-mt8365.c |  450 ++++----
>  drivers/clk/mediatek/clk-mt8512.c |  620 +++++------
>  drivers/clk/mediatek/clk-mt8516.c |  704 ++++++-------
>  drivers/clk/mediatek/clk-mt8518.c | 2088 ++++++++++++++++++-------------=
------
>  drivers/clk/mediatek/clk-mtk.c    |  104 +-
>  drivers/clk/mediatek/clk-mtk.h    |   62 +-
>  17 files changed, 4106 insertions(+), 4090 deletions(-)
> ---
> base-commit: 36add050eea439f0b2a15e4ea0d3a8e21216f159
> change-id: 20260302-clk-mtk-unify-mux-parents-1bf35aeabf00
> prerequisite-message-id: <20260303-mtk-mt8189-clocks-v4-0-ee85f8dd2f0d@ba=
ylibre.com>
> prerequisite-patch-id: 81f2dd4fd7c1632736c08180d6b9f6aef5fe1e7f
> prerequisite-patch-id: 60f0509a5f36c2828316fa3e27dfd8f4d218eb27
> prerequisite-patch-id: 237c548edf19f9cf734b1ac3b9252a4f06d8cf29
> prerequisite-patch-id: 22de64f70e8d1ba5e17f8b31f461118b35e54f30
> prerequisite-patch-id: 3d5661f9e55292a30f57617848a7b10e67844402
> prerequisite-patch-id: ccbc73b2bc1dc41beb295604088d63773cea15ef
> prerequisite-patch-id: aa76b6b028374f20551955eafe56a1e0c1daa75d
> prerequisite-message-id: <20260306-clk-mtk-remove-clk-bypass-xtal-flag-v2=
-0-b253b49f17b2@baylibre.com>
> prerequisite-patch-id: 15ac11765ddddcf378e0e227a9fb5876636aa8e6
> prerequisite-patch-id: 90b4781a99ea5eb40eb6c943dee86dd8a9fabe06
> prerequisite-patch-id: 150153a03fa40f8f9d790526512f7341a7d95eba
> prerequisite-patch-id: bdc28e831956d0a487c62e11d1442a51b9548c25
> prerequisite-patch-id: 08b3b97b5870fa4c5eb435f5b19762481a94c058
> prerequisite-patch-id: 291f87bf8033440b0c79a03055cec7e1317216e2
> prerequisite-patch-id: d3ff487de22ca508a65613bebf8cbe0e61005a31
> prerequisite-patch-id: f0e2edcbe17f6bea4bd4e6ceea49cbf73b7568d7
> prerequisite-patch-id: 0700411359ab89ebd24c4c3d17a5864e41289547
>
> Best regards,
> --
> David Lechner <dlechner@baylibre.com>
>
