Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D68CA1061B0A
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 15:06:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3A7A83EB3;
	Mon, 30 Mar 2026 17:06:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Nxw3xklp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB19B83E7A; Mon, 30 Mar 2026 17:06:13 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB8F683D17
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 17:06:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b8f97c626aaso859031566b.2
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 08:06:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774883170; cv=none;
 d=google.com; s=arc-20240605;
 b=M6Fgbmcl8vE75WtTNDNm0CpPVZd0/+X7bpdmldOfwSUbExgNxc3hwlMIjrrFUIySLQ
 iYUJi8YxBcQWrqHEtDmWdyawgspLiFWkBClF3ZoUVVfxsgXm80VHaDySgcUeNuTk6Ov0
 xrGydlJhuEraC7y2QIerDPbp7siW3WmMqdLZ7rj9KBy1OG5CuCPmQY9Sx1XdxmnpV8zx
 hM48BWbwwAoKaTSQXLJWOEQVM/JSlJ6oSwMJ1TJIZarRsSwTSYXX01jHWmdSWKH6Pnbx
 7FTjPO1vMngx3UZGUAdR3UXjcT+sHpBmzJWu5c6Pi1MXss6kKjOYdXVcLMBSifr6xTyO
 ehag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FUbx4LSyTjvuPuep6OECF+ZucEwoKPEaKqekDYnfvsU=;
 fh=/5TWuP5RrK1jirdRlr6ENPzDsDlypL6CuIEYowf9Sn0=;
 b=B+zRa8NyHPBgheqKWqMA2wayX9Vm+sHqsoA+eKEZ3B9Pesu/jrB340yHqJ/2uY/C5G
 1tIbgLs73YikOUa9nBRIEm33onwh+SV1rifdrrQFVVOJuiZdNogetYjsBu468ckYgGDh
 Z1S3KTfKKiuoBwNd0/AsifuAJJCkIiu0Do9swhwakSSMNK0pmwFyUBdyAUsYvGC1Hzja
 g/bulX5n0OPQ6jQDptOIEV/tXloWP14Qx4AgbORKqgVX399WbYYOjlg5Xg/S9Vv9p64X
 +zDZj3jp3vfP4CLQwpEGkwsXkKtDvKaZ6VHJ6B0V/QU9ehkKvm4+0cB9dA+yd4F34D1F
 8syw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774883170; x=1775487970;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FUbx4LSyTjvuPuep6OECF+ZucEwoKPEaKqekDYnfvsU=;
 b=Nxw3xklpqoS4uu498LzD8GvD3Hl6U+VX4PZLhu1/OYIM1g6020YvSZBRyvCcAc0isg
 ebzH0VOGePh11lZ39zGF0wyOODv4m8mdkzCDqYqyLLmc1iAamlFta/mXxUAuy+Z2akeI
 lbFr+2zbhObWB6GY8Aw0sG+RiejV8T/txtWiXMo0gXSxuPp5ZSQfS9lyI2oXNVBjSNaa
 KupEeWYdA8q2EaI1VHnZO/bpB6NB2Y9iUjW48Pi3vvqZtHowJPNBSK9BhGnPB2fNW8cR
 3xFxwvMidID3wvenGdJ89h0gODeSGWxxB2IoeA1MSMnq+I5nwL7w9Z36MZd+Xyvmtwpo
 9dLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774883170; x=1775487970;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FUbx4LSyTjvuPuep6OECF+ZucEwoKPEaKqekDYnfvsU=;
 b=fyRi1pXPHlOvMOqTs6b6yJxV2bzk48hi8WEgOooLFd/m+u/FFhVuzaUeK0ICF2rg8C
 cjlh6NTL3iNziuHQXyjfceB/2nmQ2XZOWIKVxmhBV1c1MrvhewvaSO5t47w+MHNInuKf
 a5MYLxcytEZI3bNd6xdPY0j2JTN2uMkpCxceMlrsJz/ww+Zdako1KK5ZvS5Kmn4U6qlR
 7caIewZa/scK++ws8BUTykssF2Xi87W/Dh9Me6qmltTvB6K9/g6Jg9pwqUmj1wyY4eT+
 9Bz3gN1EmW0o7ilbPHyeqsrZC0cdY1j28Opuo9jPZrnfF3TpZXqmAsU2hlDG9d6h1lMy
 6H/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5nzHY/FyiIjEMrA/1u23PUfjl2znLAz/PBwMujMdRS/1PjkazODTzBn0bJVA0lu0Z9Yc5ZCQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yy2x6kJ2KHzLUnmMfiPBC50pMNkk4Oxuxo481s42HiSdTZnRyzk
 Crkp79YICtzATVEVhXmyRboEeEnFKUU0es9YU7YRCCLlZj5ouW+e3OuVeCNiGHUhDycWFa05+gL
 uOD1YH6fxoDwiDJ4nXCjDYFTTdTKd3fIpzon5HXLizw==
X-Gm-Gg: ATEYQzyu71qujHE4lOkUB1SYnK+V1mZ14Vi1M6y8Iuv7whicH3yjkQ/iKh42CQVlNkd
 JvG1gsk1/8O7eru/DOq8cydKTwRRthIz7aIKX0ooLOcEMTyf5VuDDZ0KYNlJp6asdgk7GGbNGZI
 +7kvznSajMt2Fe96XmEYTZJwscxVMN94gpVX7jRuCBHSPTVpRMPuyUIt/FHU4167rbAtFLQQjLr
 Djr7fn06JOBn7jYDFqnkmjGZ0EhU6wWgLimDZeKXShxDcgmKH5EtwIr3lSeyxZCuxkGNoTdFiRI
 aJRJqKDTXb8RM4Uj4Yb4/99QnPKOHAbTXvkLmIOG9Rwff+CP188nYVSSoZ9wMrzKHMeyLnvujqE
 f8OVScNoYKIaFAO5+m1isUv05RvmHMHTqK+Pv
X-Received: by 2002:a17:907:7212:b0:b96:eb7e:bc55 with SMTP id
 a640c23a62f3a-b9b50175831mr750974366b.10.1774883170005; Mon, 30 Mar 2026
 08:06:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260316-mtk-ext-mmc-boot-v1-0-1aae51a44705@baylibre.com>
In-Reply-To: <20260316-mtk-ext-mmc-boot-v1-0-1aae51a44705@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 30 Mar 2026 17:06:02 +0200
X-Gm-Features: AQROBzBeznvYuvf8P0DmBKJu8CnIOXp47XBEPmEjBfuanR95wOUcr2O-mnygreQ
Message-ID: <CAEHHSvbkEkSVO4S=3a_z6-SH8ne5ineV-EhkJkeXKevrMLyjbg@mail.gmail.com>
Subject: Re: [PATCH 0/3] boards: mediatek: add Genio 520/720 SD card support
To: David Lechner <dlechner@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, u-boot@lists.denx.de
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

Le lun. 16 mars 2026 =C3=A0 22:55, David Lechner <dlechner@baylibre.com> a =
=C3=A9crit :
>
> Add required devicetree and defconfig changes to get SD card support
> working out of the box on Genio 520/720 EVKs.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> David Lechner (3):
>       arm: dts: mt8371: add SD card nodes
>       arm: dts: add U-Boot overrides for Genio 520 and 720 SD card
>       configs: mt8189: enable GPIO support
>
>  arch/arm/dts/mt8189.dtsi                      | 12 +++++
>  arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi |  3 ++
>  arch/arm/dts/mt8371-genio-common-u-boot.dtsi  | 28 +++++++++++
>  arch/arm/dts/mt8371-genio-common.dtsi         | 67 +++++++++++++++++++++=
++++++
>  arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi |  3 ++
>  board/mediatek/MAINTAINERS                    |  3 ++
>  configs/mt8189.config                         |  2 +
>  7 files changed, 118 insertions(+)
> ---
> base-commit: a27980786cfb3c430aa1c05da8e79180c584d221
> change-id: 20260312-mtk-ext-mmc-boot-aa67a77835ad
> prerequisite-message-id: <20260310-mtk-mt8391-initial-support-v2-0-1dc862=
d58532@baylibre.com>
> prerequisite-patch-id: 0a3f0badfacd3b6aac95fd6eecdb52a06f6b2862
> prerequisite-patch-id: f5bc405061da27bf21302c1e91d1f7764d4c52c2
> prerequisite-patch-id: 127eaeb5c641928088383c6fa468ef0a15d88306
> prerequisite-patch-id: 8bc3f4284773a4e83ffc94e9e4aad43956073ab6
> prerequisite-patch-id: ee4692f65c9b54d9b599b13bd965581318a3f372
> prerequisite-patch-id: 02919217d9a44bc91036b6e8a2c0dc4f54a0fb3c
>
> Best regards,
> --
> David Lechner <dlechner@baylibre.com>
>

Reviewed-by: Julien Stephan <jstephan@baylibre.com>

Thanks
Julien
