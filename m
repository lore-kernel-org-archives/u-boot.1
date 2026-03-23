Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2638AEC01A4
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 08:36:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62A6C83DB6;
	Mon, 23 Mar 2026 09:36:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dnc1qVM1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D271983FAF; Mon, 23 Mar 2026 09:36:35 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 806B483BE1
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 09:36:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b982a80317fso321955366b.1
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 01:36:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774254993; cv=none;
 d=google.com; s=arc-20240605;
 b=ZiI8Gd/NSvI3ajam9UwdM2yLBb32HIBz3T8ZtKnr9rlZtle2g909FP8XAdVhoneKgl
 6Ima9Hdp0Ip7Mx3S/nHWNLiN+yTJ1XJn/tO6Eb6reUXWenTA8r/di0Wd/HdhsEarb86R
 MWjz1/AAHK6h5E1zovDH/ZR3Nl7Az6aajG3WQqs9+XBmQxdHiv8QYWp/yRTGu8YyA9FB
 Ns+0CQ1XWtNH6id4Th8H3iySmEXnZdGRS1vlIpaqxVobhzsON3VXguffsUDhnLfFUFJz
 MkTxh9nDg0zO9eLyjM+vpcrd9hkiHLaXTsYqwaI2QJf715KjIBAnlYfUYcgAWHeuhfOB
 kLkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=azwb/ClmOETJ8C4G2JFVM6hCPjaLoUiksg/HWe8BFac=;
 fh=QYlt14pcNm5uAcw1vKFTAUKEwdSMRn61eunrphEZcSA=;
 b=V8VOzroGIysaqmHN0NSI0AzuYg31efy9BU63kdJd69ZW6rVTAS86GMnKwwdqORi9oR
 Gn8bBGAwGG/OolAim1dlQ40DGV0IkH5jw3xPCekH6BjTyCMih4ieNkz8uu1Pm6gJ2J8W
 g9vlOH7ycFmFK5a0ggquqZtwO/TmKZTfm+8UWNuKTBEDeHBmC1DIJjtTr+PMuyFOhE3k
 TmnDKriDINcmGeheM4ZXYyJZ0J++45vRCvK6idJPYmdjBTzo8VOEkigp2yhhqvtiWzFv
 x5Xw/3T//s2b48EtxKsNpR2pJ+w7ofobVCnE7InIH4NtVNmwA9+14WQU+lZJUpfBociM
 0uhQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774254993; x=1774859793;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=azwb/ClmOETJ8C4G2JFVM6hCPjaLoUiksg/HWe8BFac=;
 b=dnc1qVM1ZGOUF0HnyuARJJyMuZZfYjJfr5fvUtuI7Ws+yoB0NcJZmsboT9jzvAfebn
 +xBT+Vhb/0DaoAjmj5uGuHPxFXqMGaxdowPuseipmsHkJuh8Qn1v+ckng+99lBrVqRLu
 dOJhEdB2oGD80UE88DGAmCC6jJkI0RKvG8NWu/j5Fm4TWeiJPsRbIxfhXS4HTLiCYIe1
 4jjLkh0l91EOiN+zIzTAhB5iTt25JlzW512Sm53kgwB/YHV17rM6cFAqQ574OTsJCv6u
 KasaUh5HCEMfEECH5YLLSz+TJtscF9WJkxFrM1ulYga7P7mKeR7fjS4r3+/mCcU0R45v
 5tIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774254993; x=1774859793;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=azwb/ClmOETJ8C4G2JFVM6hCPjaLoUiksg/HWe8BFac=;
 b=IlnlTmCCib3fc9ROl6xT0qtj4+YbgB5DIy3W/tkL4zSE5KbCS24L5D+PSceYvwrVQP
 K66P9zDa3AoBT1DqQlt2za5hYG3WWETiK0SKPa0vgehNF03roA6ktWVNHouuV1pAQ+fw
 /p31YpAkxJ8uGqRxKW6L4MZeRXHlbjFFO1mBcWc5inq8L/nYd63eNfvdNvA1p/X3XUob
 RUK3DXLu+US/9zogdwWD42G91MA4RYCnnyod9FvjF0agkIkhd1xalXkl85/tlCkwOePo
 /BbnclEMEyJO+528ehgwmKk9rlTmN08V3YaPBoFrmLAccit9e9Y4rDW69zksY6A2gj7B
 9r/Q==
X-Gm-Message-State: AOJu0YwuooNtIix0TleZ84HyAozJmkrgqtFLwlepZeBVTT81j4KOJ01f
 BdHV55Q9LC/h6sCHLYBkK3qAXP9cx0Zs1Ns9eQ7zSo7KLkPKMAQBYA81bQsWLHd1YA8aEstAHXB
 FNuBHjDOS2Z+2V0eELSH9mNG+5KUIy2Uw9HsNerKC1g==
X-Gm-Gg: ATEYQzwOWCsVrPNnbbITiA1mexsOgkZm9LcZrMwUwumYmA7h1qIZORqrCKNuQfGwT3u
 ZPZczzG5EQqsp8GCNkmr/bgtLfFe9Rjz7lC6s4OG11bLFI1dwc1NOLhKzaBMcdcwbcNT4P99enB
 GKtov7pvSgyelyDRDs5Qk+V/c48wd23Ax46ufo9xJWWTLyizRcNCdIf4d6CFsQLP3ydUFLM2vuP
 nf/Enufx+TA5k0vkZeI5IUXwD75POOOFUXYHIwiSAIUUadTR+3RjuGaaH5uGX8UWWtuaNJFoZwn
 o1Jp07dKO+JD9SkSMsIizo9qEX8OOkNLAOXxndOGZyElxWL6/4R1cEyr+fO4hXB1jWxGJ4cfSJg
 GvYNvPMP/SWE6SfLAlQRwR0rbQg==
X-Received: by 2002:a17:906:4786:b0:b97:bd5d:36fb with SMTP id
 a640c23a62f3a-b98594ed1e0mr366654066b.57.1774254992896; Mon, 23 Mar 2026
 01:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260318-rename-genio-defconfigs-v2-0-1f77580d72f3@baylibre.com>
 <9060e287-9b77-4051-b378-c68ddba4fa65@baylibre.com>
In-Reply-To: <9060e287-9b77-4051-b378-c68ddba4fa65@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 23 Mar 2026 09:36:24 +0100
X-Gm-Features: AaiRm51zT6pLviNfJ_wREo2q-UQ-PP_m8Dgt7S-glaNNRiE_PXeq8H4c8pbVLeg
Message-ID: <CAEHHSvaFcOzyz1-WkunbYELGOwP11w0z9ZtNOLTGFm5G9qRCHg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] configs: mediatek: rename genio boards defconfigs
 to match the device tree name
To: David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tom Rini <trini@konsulko.com>, Macpaul Lin <Macpaul.Lin@mediatek.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Julien Masson <jmasson@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>
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

Le ven. 20 mars 2026 =C3=A0 22:33, David Lechner <dlechner@baylibre.com> a =
=C3=A9crit :
>
> On 3/18/26 11:45 AM, Julien Stephan wrote:
> > Rename the defconfig file for various genio board to match the name of
> > the device tree. While at it, do some cleanup:
> > - introduce mt8188.config to factor genio-510/genio-700
> > - remove useless SYS_BOARD_CONFIG for genio-700
> > - set myself as maintainer
> >
> > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > ---
> > Changes in v2:
> > - Split the initial commit into several commits as requested by Mattijs
> > - Link to v1: https://lore.kernel.org/r/20260318-rename-genio-defconfig=
s-v1-1-1440312442f0@baylibre.com
> >
> > ---
> > Julien Stephan (6):
> >       configs: mt8390_evk: remove useless CONFIG_SYS_BOARD
> >       configs: mt8395_evk: rename to mt8395_genio_1200_evk_defconfig
> >       configs: mt8370_evk: rename to mt8370_genio_510_evk_defconfig
> >       configs: mt8390_evk: rename to mt8390_genio_700_evk_defconfig
> >       configs: mt8370/mt8390: introduce mt8188.config to avoid duplicat=
ion
> >       configs: mt8370/mt8390/mt8395 add myself as maintainer
> >
> >  board/mediatek/MAINTAINERS                         | 18 +++++++-------
> >  configs/{mt8390_evk_defconfig =3D> mt8188.config}    |  3 ---
> >  configs/mt8370_evk_defconfig                       | 28 --------------=
--------
> >  configs/mt8370_genio_510_evk_defconfig             |  5 ++++
> >  configs/mt8390_genio_700_evk_defconfig             |  4 ++++
> >  ...k_defconfig =3D> mt8395_genio_1200_evk_defconfig} |  2 +-
>
> How about also including _emmc_ in the name, like:
>
>         mt8370_genio_510_evk_emmc_defconfig.
>
> Since we will be adding a _ufs_ variant for all of these, similar to [1],
> then it will be more obvious which one you should pick when booting from
> eMMC vs UFS.

But then the name of the defconfig will not match the device tree name
anymore .. which was the point of this series.
Personally, both are fine for me, so I can update to use _emmc_ if
this is a strong requirements for you. Let me know.


>
> [1]: https://lore.kernel.org/u-boot/20260318-mt8195-add-ufs-support-v2-9-=
f18eeeeb0e72@baylibre.com/
>
>
>
> >  6 files changed, 18 insertions(+), 42 deletions(-)
> > ---
> > base-commit: 142c805d470cd02470146d6d70aa9c522d4da16c
> > change-id: 20260318-rename-genio-defconfigs-bc4070c90e9e
> >
> > Best regards,
>
