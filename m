Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E51EE20A4
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 14:06:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4295383AA7;
	Fri,  6 Feb 2026 15:06:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FjPdyjgp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA3B883B86; Fri,  6 Feb 2026 15:06:41 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59FC48352B
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 15:06:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b884cb1e717so6333866b.0
 for <u-boot@lists.denx.de>; Fri, 06 Feb 2026 06:06:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770386799; cv=none;
 d=google.com; s=arc-20240605;
 b=M03BewPONblYQJcofveYlDMLvyv1t6BsPnV/3U8IHGtMU0NFjyUTN/DGvHocQZud6Q
 E12NJjgXlGYVO7Y90lpFBo6e4x9TGZECQszekw9h3l6J4hR2LIE3KqDwDRwESkL03U/Y
 2TfGnZyjEYWjnXwsBa33U295k5Pn8SptJ82wCdBLVlbxgVPI7eq0wL4y2BU4S3hc+hfD
 lNC7B1/p+3cF4t5rfORU2aaCoYf/6Ix+YE7NqexIYHR3W6TSpj608VVzIxwltr8Hb+I3
 NqP96lCK/xEm2pCd82fwSL2TLWZkMITHEuq7sJJDu4LTi3N6eSdPbnuK8qRgMb+3CNET
 MyOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XT6Bc4H1FRtjCja4t3AUEPg+6PVpj/4FGg7krbQ1J/U=;
 fh=f7Mt8k3GftPJGKdA3yAUTW5EpiolUO51I7HQVS50uW4=;
 b=UxyYiSR+kfywqzZGL5HEAuhx5G2WSbUZ/rdq2RHOoogKDH57xxld4RSn5qfsndlfBf
 Wfk9JfhbIu51NYt55dijrlctT1oeh2T6K5xjJP9bai+yR5Cz8LYCgrI2ERcjamMtir5Q
 RHmiIsj4hHtHWQpIwmK6AnjxHpSRFXQB+lp5toU3xAVtB4v+S415H7C+1MdvZ9280ext
 TPcA0GDnSxNrcvcjaUvCZDYKq13Iif4xsG7TmT0aQtWzuhFz4kHx5mluq4PYYBypYXHA
 jpgG2hhcD46qUcmY26H2V710QfR4ZoRj0i78miSBWHlw7625tn2SEfzVGZFZotIQvccp
 6ZsQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770386799; x=1770991599;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XT6Bc4H1FRtjCja4t3AUEPg+6PVpj/4FGg7krbQ1J/U=;
 b=FjPdyjgphcPMYpVnhJxTr/1VqgDmLT7ALVflXkmFiuLutBf7NDd2xq9T4PQPnG6n9f
 J8JbqXsE0tMrgQjzJxyYOf3fnRCLXKO2210TACTGCG72Bp5oHfURdbv0uJ7Re0ycQN74
 +RA8WlUgVND4+nvXqyn1qo3HW4H/pBQ6hla5EjY4gwglu0aHEp7RqlxxTJkPf11VUolB
 3H1L6shoBoR4DB+ESSOMnPEOD5lxjP/meRl5Lr3LdslKJS2hVQdkf8HNEuEaKttcfLIA
 niE9PlVrNSbWVeQiNDlZZ51z7aqQDxtvbngy+WyupEXnGYzWOBc+Yi3L2WeNXAVMWvuu
 /b2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770386799; x=1770991599;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XT6Bc4H1FRtjCja4t3AUEPg+6PVpj/4FGg7krbQ1J/U=;
 b=LU8/KkwKzYHFAuh+Q8Or72FMbYv2uoUYYbMqWBkG/DHoSXiHoyye7OuJ0DjTOaiteX
 sbrM+h1swjUrqOEXDRogTpLd9v0MCfR+rEoxKs9pn22EmExCJ7Ny1629Ti3lGr6pJCNG
 KjkNV18fazXoM+huQVYDHzBPKpEhmU7xlm/ZyEijDNRw8VXDeDZFilr7wMdbrH3eM4cU
 gQ2/JDf6rORdfzwoNL4vp+pICBXuA8hdPsgVnDhLuTROq6ibXIumIM4Hks7XHu/b3dk/
 SNDLF0MhTmh3uyIBzgb11bgnB63gbBaXi7r9ZHQpNH8j+Ehpi3gZq3HKYmdCBhTvV5PH
 DTHQ==
X-Gm-Message-State: AOJu0Yxzq2efUm6Z2VlWRrPJk0/iGv8LgkQUHYfNAZWZSWiwFiuza+n5
 5cFNtTXjqW/+xwqIj7/pYEsDAgfxjhImJXvDlfvqkHGboK0jHUoHQ0IxxZ9Hw+ovDxb8FGKnH0R
 xv+Xr2H+KONvGXTPuqxoife0if3GqLDiWibKolnf2cA==
X-Gm-Gg: AZuq6aIvFp+C1Ub8d58jeq9O3iJK7zXAH47SqLqV+QSAka/ex8+hEZXbEz5ZUPqK+nq
 7bD96FvvKWDxEx06UWuroST+ar8v3ZXeJpZeUbbYkUgKKA335039E3El7snxdG9LlehtHqpZJvT
 09mj5gi/625901q8gMhmsOuxs+abT8yiuT5xzsN/Xe6wqoxVByKzeooXgnUdwU22706aEZT45SK
 xmIho3Umd8uwYU52Q1uye/onTB/v24+8dT6e7hb0RZWrm7rTg47Qq5qaAmPUjwq4uaATLB7xWzR
 R28F0dF9sYjXPsfO6gcmwXvVw1FO
X-Received: by 2002:a17:907:db03:b0:b87:cf6d:8ea with SMTP id
 a640c23a62f3a-b8eba27684bmr376857566b.27.1770386798653; Fri, 06 Feb 2026
 06:06:38 -0800 (PST)
MIME-Version: 1.0
References: <20260206-add-mt8370-evk-board-v2-1-105c606f80dc@baylibre.com>
 <20260206140108.GR2603314@bill-the-cat>
In-Reply-To: <20260206140108.GR2603314@bill-the-cat>
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 6 Feb 2026 15:06:26 +0100
X-Gm-Features: AZwV_QgA2nBXuMMZs1RoeumhyhQUFE8JfaQUYZplVkJ2x4DxFKFr2aNP6aRzfdQ
Message-ID: <CAEHHSvYz0wW+AeOytE8FBr24Oz3J_BN0eF8jwFX6W1LdkCO_yg@mail.gmail.com>
Subject: Re: [PATCH v2] board: mediatek: add MT8370 EVK board support
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Julien Masson <jmasson@baylibre.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 David Lechner <dlechner@baylibre.com>
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

Le ven. 6 f=C3=A9vr. 2026 =C3=A0 15:01, Tom Rini <trini@konsulko.com> a =C3=
=A9crit :
>
> On Fri, Feb 06, 2026 at 01:50:31PM +0100, Julien Stephan wrote:
> > This adds support for the MT8370 EVK board with the following
> > features enabled/tested: Boot, UART, Watchdog and MMC.
> >
> > MT8370 is based on MT8188.
> >
> > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > ---
> > This series depends on [1] for several cleanups such as memory map.
> >
> > The new defconfig file added here is not yet part of any MAINTAINERS
> > file, waiting for comment on [1] to be addressed.
> > ---
> > Changes in v2:
> > - Add defconfig file, missing on v1
> > - Add dependency to [1], for memory map cleanup
> > - Remove board/mediatek/mt8370_evk
> > - Link to v1: https://lore.kernel.org/r/20260204-add-mt8370-evk-board-v=
1-1-3132f953d845@baylibre.com
> >
> > [1]: https://lore.kernel.org/all/20260205-mtk-mach-clean-up-duplicates-=
v1-0-b7d4a43c18eb@baylibre.com/
> > ---
> >  configs/mt8370_evk_defconfig | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
>
> To be clear over here too, defconfig without MAINTAINERS fails CI. This
> will need to be added to the new MAINTAINERS file I just suggested.
>

Understood! I just saw your message on the other thread, I'll wait on
a new version of David's series and then add the mt8370 board to the
new MAINTAINERS file.

Thanks

> --
> Tom
