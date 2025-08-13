Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57AD9CA0EC4
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 00:24:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 354F882F03;
	Wed, 13 Aug 2025 02:24:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nqv271IA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A7D282F5E; Wed, 13 Aug 2025 02:24:25 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EBAF82E34
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 02:24:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cn.liweihao@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-61868d83059so854870a12.0
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 17:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755044663; x=1755649463; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zK7Q/xxR5WvgW0vKheG1nlaffEHnGCjGQ0xLxLHhwKQ=;
 b=nqv271IACmfmxL3NHwG2QdFmHKDcPB15xwSZC5bek8fWoChCAWIKXhu4IAXo/dH/7W
 qrSnjMcPVoWx6WRjIoq45LLaxjywduyIfYgT/IW4ZruOU436KJITjS+Ambwkn14PGxT5
 km64W5gN55xY9ZS2O5X7oYdJSuaof55XEnPvfQoAnrN4kZnuNn7KoL2/lFG3Mxqbc+Dq
 mfh3ln7FCx1RhuJhqiDQyOjr2UCmxK2PRXwPSjPqkeGYy+36K3zXVoyIVICpu+OBJNYR
 iKCzC3gNqY0426pDD0WR6Z+b1CbatKglRxTExEu5Z6EQFg1mTH1h0ULYl8V5+IR2lCOg
 a2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755044663; x=1755649463;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zK7Q/xxR5WvgW0vKheG1nlaffEHnGCjGQ0xLxLHhwKQ=;
 b=JM5JKVXXgsu0ftZrkZv2Fhu277ss8nuu2WrG0SE+NCGvmtNSwaPKA1HXnvPJKOSphN
 49AZaLOV7ZqVeeu5YCi+xJCoMF+Nn8OZBBbw/TWfh1GFnqJjvCTrX71aFRbm4diV7NC4
 LGOc0H/Gf2Kkj6+o3vvHkFV7qrLey0hWUhNd/ctsEfyc691VoUpLqqdXOC28yS/8ZBoL
 4atJIPf9UMcJPsHa6OnVAke5GgHwC/+rKpO5AwzbyJt0juf6a/+VxKT3VwLEW5ieMRz9
 74LzBdsel3tNC0/WlFGenHvfT9KPBybgwzRy93h+DVGpwybsh+rSsFaWMoesSSEZos7M
 7lJA==
X-Gm-Message-State: AOJu0Yzic996vWu7p2nZQckgyNESPeE0Ne+odX4DqdNG5fE8+6Tr8S17
 W327f22Krj+1H9zPNfxHSXdtCP0JjlV1ma4KGc8WpOZg7vXBvZZHrBG8eUO/DXuqv4ZE6Ke045k
 BfObiIY5qbH9BQZ9iXpkDOxWks3PpM1I=
X-Gm-Gg: ASbGnctq9lNjoST2m5dR5Bp4u3OW6BQCVcbvvRMK3xj7yRCpOjZcN/8SNT9xLbpHSoZ
 c/uxllx1MIuYG9PGmorgBb2TbreWgtnsGpauY/nXYIrtjGSSyscAWEv1bJOghHHpgyAiQvPI7br
 RWeWinDmzVdUF8KNLBU6g+ESU7wpm4+po3XRfG9lE6JQWwKCslLW3alI2jCVJ4qIbeMTpO+qir0
 /60CXBowKqLFAjkjGL35QoH
X-Google-Smtp-Source: AGHT+IGAPHQWDApYDiFN+rh2laaIbuESd1Em2/KLfhfB9fJvwTLNi9jJghMMIuJ/cts3nwuTRgkbUbeipcOB9fNslCY=
X-Received: by 2002:a17:907:9712:b0:af5:5d76:3fbd with SMTP id
 a640c23a62f3a-afca83aa910mr49005266b.11.1755044662552; Tue, 12 Aug 2025
 17:24:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250807074419.336752-1-cn.liweihao@gmail.com>
 <20250807074419.336752-3-cn.liweihao@gmail.com>
 <9f234367-9ee0-4656-a222-d1c461a49c3d@kwiboo.se>
In-Reply-To: <9f234367-9ee0-4656-a222-d1c461a49c3d@kwiboo.se>
From: =?UTF-8?B?5p2O57u06LGq?= <cn.liweihao@gmail.com>
Date: Wed, 13 Aug 2025 08:24:10 +0800
X-Gm-Features: Ac12FXxbKBXh-pwvRJEq7z6Uy2ZO-f2E7oKj8wflcp2QzzWEN7H9A9IcvA8XiH0
Message-ID: <CAPEOAkT4b2upydjPwamavCUbYYm_z_4Atf6Xvemha4HjDNyz=w@mail.gmail.com>
Subject: Re: [PATCH 02/10] mmc: rockchip: fix clock get wrong index
To: jonas@kwiboo.se
Cc: u-boot@lists.denx.de, antonio.borneo@foss.st.com, mk7.kang@samsung.com, 
 gregkh@linuxfoundation.org, semen.protsenko@linaro.org, 
 mikhail.kshevetskiy@iopsys.eu, bb@ti.com, justin.swartz@risingedge.co.za, 
 lukasz.czechowski@thaumatec.com, robh@kernel.org, tharvey@gateworks.com, 
 clement.legoffic@foss.st.com, marek.vasut@mailbox.org, 
 dinesh.maniyam@altera.com, patrice.chotard@foss.st.com, festevam@gmail.com, 
 jerome.forissier@linaro.org, quentin.schulz@cherry.de, 
 andrew.goodbody@linaro.org, sumit.garg@kernel.org, ag.dev.uboot@gmail.com, 
 rfried.dev@gmail.com, joe.hershberger@ni.com, jh80.chung@samsung.com, 
 peng.fan@nxp.com, seanga2@gmail.com, lukma@denx.de, kever.yang@rock-chips.com, 
 philipp.tomsich@vrull.eu, sjg@chromium.org, trini@konsulko.com, 
 WeiHao Li <ieiao@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 13 Aug 2025 02:24:48 +0200
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

Hi Jonas,

Thanks for your review.

Jonas Karlman <jonas@kwiboo.se> =E4=BA=8E2025=E5=B9=B48=E6=9C=8813=E6=97=A5=
=E5=91=A8=E4=B8=89 01:50=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> On 8/7/2025 9:44 AM, WeiHao Li wrote:
> > Signed-off-by: WeiHao Li <ieiao@outlook.com>
> > ---
> >  drivers/mmc/rockchip_dw_mmc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/rockchip_dw_mmc.c b/drivers/mmc/rockchip_dw_mm=
c.c
> > index 7a72abaa38..a3f001d7e7 100644
> > --- a/drivers/mmc/rockchip_dw_mmc.c
> > +++ b/drivers/mmc/rockchip_dw_mmc.c
> > @@ -132,7 +132,7 @@ static int rockchip_dwmmc_probe(struct udevice *dev=
)
> >
> >       ret =3D clk_get_by_phandle(dev, &dtplat->clocks[1], &priv->clk);
> >  #else
> > -     ret =3D clk_get_by_index(dev, 1, &priv->clk);
> > +     ret =3D clk_get_by_index(dev, 0, &priv->clk);
>
> Index 1 is the ciu clk and matches the linux driver and u-boot driver
> usage of the clock.
>
> Please explain why you think this should use index 0?
>
> Could it be the device tree that is using "wrong" clock order?,
> the dt-binding define following order: biu, ciu, ciu-drive, ciu-sample.
>
> Or possible an issue in the rk3368 u-boot clk driver?
>
> Also if this is wrong then &dtplat->clocks[1] should also be changed.

I'm also a little confused about this part, so I rechecking this part
last night.

I saw the rockchip downstream uboot driver uses index 0 at first and it wor=
ks.
But I noticed upstream driver commit history switch index between 0 and 1
multi times, and stay 1 at then end.

Then I looked rockchip other SOC's clock driver like RK3399 and RK3288, bot=
h
of these drivers are support HCLK_EMMC&SCLK_EMMC and its have exactly
same logic.

Because of that, I think the best solution is add SCLK_EMMC clock for RK336=
8,
I'll add and test it later.

Please ignore this patch, I think it's inappropriate.

>
> Regards,
> Jonas
>
> >  #endif
> >       if (ret < 0 && ret !=3D -ENOSYS)
> >               return log_msg_ret("clk", ret);
>

Best regards,
WeiHao
