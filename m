Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E054BC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 18:25:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BFA48144A;
	Fri, 28 Mar 2025 19:25:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ey1GpU6C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C3E881951; Fri, 28 Mar 2025 19:25:34 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C9D880F0E
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 19:25:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5e6f4b3ebe5so4579294a12.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 11:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743186331; x=1743791131; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hylD0Wd3LK8lErzvWpQdj7s5xCxGy8qVR/al9bZ3EYk=;
 b=ey1GpU6CZNtt7KPOkV+qJ0jWVXZXbPv6hkm487JiKA61KYl6vtkRultvPLORDnhFhY
 IrsqpNEw7SmqvYxXyxm+Xn9/8V1Ds0w7JI+knSpWJPcpLKBq8HnvTOLYEXiaU7+wF9tw
 rD6yernjjMdVOWxclpTG2HBVfhCWd3MFfeivw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743186331; x=1743791131;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hylD0Wd3LK8lErzvWpQdj7s5xCxGy8qVR/al9bZ3EYk=;
 b=hL3M16zvsrN/fE+pr2kwCBQDbCfq+fnZ6OvJZWZtOHakFjG7tWpfjNK9YbUO/6QU4S
 bT1oZ+JyDxiuuAg2yHGcjIu0qPMZUvu7suLSwJhW6p89BH3jlJRzJ18BsYGgU621SWw7
 zGHuBtGFPi0n4uYoAkjeoX1b5SZRVgbFnixeef/bwYQB6XZ4+WSkxKoIpisot2uAEHJr
 OdDq33GtgZj2RJQemVoj9dAVyWFeu5uWkLFDOu27VzaCOTuu9rZrxyUpvW7Ebqro3s5G
 6fK4crP9GMfeRs+CCbzVe5g1U5egzEmSkIAq3qlMSsRdMf6OZiWur43jyJRoel+5jEDa
 R3pw==
X-Gm-Message-State: AOJu0Yy5Fh1mJJgZ/vZml40ljlVp06/F/IzeZUvkk4lcYt4q52RHgbqS
 Qqj2tPL7klgk9WGnGlv3BnE9NcXsIz+Kyv1xxSWzY9VpCA4gMoAnQzlJn8Bq8hiPpjDLrrXDwQG
 Gi1GSpU7Stq2LFFeSixQWoJ6zQC2/FaZEmxsNYzAlc04Ytx0=
X-Gm-Gg: ASbGncsDbZebGyug7wsczHd/zelf6DcgghxIoAIA4R1JZ17q65Z/tIGJNk662ysfp/A
 5v9vM/HMBndW05lJtBY6nExmE1VNdFV+lxf4cuwKdhSPLwxNqdEf9PLTb5kfocBAUUYPVC3/K8c
 oHeNm+0BN0gXY6J3uN2QZ9H0pCdqQ=
X-Google-Smtp-Source: AGHT+IGwk1aJDCukdtYc2018+CVAgk6eNkiyk2J7tCm/s/rxIYTJ4WS6UmlYi9I2Ec6w5JLxucPKUdO6mAjo3Yf1JHo=
X-Received: by 2002:a17:906:f5a2:b0:ac3:e9bb:deab with SMTP id
 a640c23a62f3a-ac738975f41mr14299766b.1.1743186331404; Fri, 28 Mar 2025
 11:25:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250328153522.3555472-1-sjg@chromium.org>
 <20250328153522.3555472-11-sjg@chromium.org>
 <47763569-3b7b-4707-b517-b0e41a499069@kwiboo.se>
In-Reply-To: <47763569-3b7b-4707-b517-b0e41a499069@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 28 Mar 2025 12:25:19 -0600
X-Gm-Features: AQ5f1JqNcFQnV5ZpP_378a2oUMxyHn1guFjE_FhnfbrRM2WR0UWBsKdseFxMyVk
Message-ID: <CAFLszTiei=CbYZzuqSoz6+-bO0So8ibL+K_0nh=WWeHZukOnzw@mail.gmail.com>
Subject: Re: [PATCH v3 10/31] rockchip: dts: Use the new binman template for
 the SPI image too
To: Jonas Karlman <jonas@kwiboo.se>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Tom Rini <trini@konsulko.com>, huang lin <hl@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 28 Mar 2025 at 12:19, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> Patch 05 to 10 should still be split out to a separate series.
>
> They help fix an issue that already have a different conflicting patch
> on mailing list [1].
>
> The request to split these patches out was to help/ease work for other
> U-Boot developers such as myself. I have a follow up patch to split out
> HASH and to add support for using crc32 as hash algo, for an upcoming
> RK3506 series. And I have already send a separate series to add RAM boot
> that depends on the fit-template added in patch 08, see [2].
>
> Still keeping these rockchip: dts: patches that are ready to be merged
> in a series that in v3 still does not apply to master or next is
> disappointing. And because it is not possible to apply this series, a
> proper review and testing has not yet been done, something that is just
> delaying your work more than it has to.
>
> I can send these patches as a separate series if you do not have time to
> split these patches out to a separate series, and would also include my
> HASH crc32 patch.

Yes, please go ahead and thank you. You might also consider the
skip-at-start patches at the end.

I have several rockchip boards in my lab, so I'm pretty confident
about the general changes. But perhaps one board is different from the
others. I doubt anyone has all boards.

Regards,
SImon

>
> [1] http://lore.kernel.org/r/20250220-has_rom-u-boot-rockchip-spi-bin-v2-3-d1768ee87808@cherry.de
> [2] http://lore.kernel.org/r/20250220231358.432367-3-jonas@kwiboo.se
>
> Regards,
> Jonas
>
> On 2025-03-28 16:34, Simon Glass wrote:
> > At present simple-bin-spi relies on the u-boot.itb file created by the
> > simple-bin image. Use the template to avoid this, since Binman may
> > change to process images in parallel in the future.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
> > Suggested-by: Jonas Karlman <jonas@kwiboo.se>
> > ---
> >
> > Changes in v3:
> > - Keep the filename for the SPI FIT
> >
> >  arch/arm/dts/rockchip-u-boot.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> > index 1e4d6f71123..fb304540787 100644
> > --- a/arch/arm/dts/rockchip-u-boot.dtsi
> > +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> > @@ -207,8 +207,8 @@
> >
> >  #ifdef HAS_FIT
> >               fit {
> > -                     type = "blob";
> >                       filename = "u-boot.itb";
> > +                     insert-template = <&common_part>;
> >  #else
> >               u-boot-img {
> >  #endif
>
