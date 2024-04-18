Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 151B9C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 18:24:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 888BA8867D;
	Thu, 18 Apr 2024 20:24:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="fMuDWMHY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7230187D8F; Thu, 18 Apr 2024 20:24:18 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD34987E62
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 20:24:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a55323f2ef9so142397066b.1
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 11:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1713464654; x=1714069454; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=88JO4b2pmz2d3d6PDwXaNDt//OugoL/2kVwxx+v9d9c=;
 b=fMuDWMHYzC3yQpz8YB0wQ07RbLrhXDmRU2nRmhxW04C+PWXXcM/ggp5wy75upcLnaJ
 6q2tCGnCwsPFRx0mm5hDk6rQn7icAQokucug3Gf8GWsq/pgK5SzTNo9WXtCb2ToHkZpi
 GSXMpQZYdmn5ClPIVzY2lCVH9kTm4EyIWjzaR6IAbpm58G3KVWhCyzGrTeWhwYWspqRB
 XCW0J+nkjYl9uviuGyR5EC1k6xZv90w2L82G+gUsGHm61YPHfZdsLtEGzaf1+22JaEyE
 JiGeMeji9sFvTCuSAROA/r1ubXPwygq6tohOLNTGsfxOeI1Tw6vZUBbot42/+w5wXJ9k
 30nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713464654; x=1714069454;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=88JO4b2pmz2d3d6PDwXaNDt//OugoL/2kVwxx+v9d9c=;
 b=EbxU0wrjXGZIJ4yQNcxEzbxVFfXaXe5WH/L3PDgbKjmuLaV1rb33eD0L7CkR2Qh5GV
 bFK9IhHnnUo1/PqE61GKtZv9u3Y+ZoUDgZtCTwB7V83RCGUy0y5hiX5WNTjeH5Zh9yr7
 vh+Ma/c89X+PZ8ELFh+TwFeyNBCAbqHSVHOEtMO7/vf7AXeN+7RUpBN6y8lqyHCuruis
 wm5Mr55yc2xHrTRmUDd8ysCEhgbBipMfTTKPRRKmujrmrerfF1o47zb4e8z9hYJlolhv
 aAfoR//GLbHaGDzvphm1SKD2R75Tw5j7HHjXrMc1WtO7wpIOAENCjnnqBHxy7vxd4Hb7
 wQcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTHQ0N+bCrykpitvKdb0vJHMPennn0g0islupE4hTNslYlTMRx6Gg+IqSGSGNs0UJapv3BuIzi9qV6uYxFSHff6iZzBw==
X-Gm-Message-State: AOJu0YzzdDONpMndTC+gWezR3N9G7jI3E3ggX862G85v6Get3F3CDGan
 gFe34QJUh+nFSwtL21qjCiZUpXecawViAS52hA7JBaDohChAyhIdv8RXjZBNh6muVoPC03drhoM
 u/X+jX/qZ8l/CsWHic0kq8Ax9X59C8kmfH4bArw==
X-Google-Smtp-Source: AGHT+IERRmqK4nBxAPsTRWsxU0Uo5NXdVAG//Vb0AKlmO9pPyoYOmB3jzJ4/xXkzT+GTSIS4rbRuzCnkGe4oz3qsk2k=
X-Received: by 2002:a17:906:24da:b0:a52:4047:df5b with SMTP id
 f26-20020a17090624da00b00a524047df5bmr2115143ejb.73.1713464653994; Thu, 18
 Apr 2024 11:24:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240418175612.4068609-1-tharvey@gateworks.com>
 <b47af088-17e7-4a28-9d1d-dbbd0d4f5dca@denx.de>
In-Reply-To: <b47af088-17e7-4a28-9d1d-dbbd0d4f5dca@denx.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 18 Apr 2024 11:24:02 -0700
Message-ID: <CAJ+vNU1GQ3ZVNwO4Rc2C1sNKsQ=Y=gu86mCytcFoBKGuyy+Dbg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] clk: imx8mm: Add support for PCIe clocks
To: Marek Vasut <marex@denx.de>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Fabio Estevam <festevam@gmail.com>, 
 Martyn Welch <martyn.welch@collabora.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
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

On Thu, Apr 18, 2024 at 11:14=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> On 4/18/24 7:56 PM, Tim Harvey wrote:
> > Add support for PCIe clocks required to enable PCIe support on
> > iMX8MM SoC.
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > ---
> > v2: no changes
> > ---
> >   drivers/clk/imx/clk-imx8mm.c | 21 +++++++++++++++++++++
> >   1 file changed, 21 insertions(+)
> >
> > diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.=
c
> > index b5c253e49663..c2f01b385201 100644
> > --- a/drivers/clk/imx/clk-imx8mm.c
> > +++ b/drivers/clk/imx/clk-imx8mm.c
> > @@ -66,6 +66,15 @@ static const char *imx8mm_i2c3_sels[] =3D {"clock-os=
c-24m", "sys_pll1_160m", "sys_
> >   static const char *imx8mm_i2c4_sels[] =3D {"clock-osc-24m", "sys_pll1=
_160m", "sys_pll2_50m", "sys_pll3_out", "audio_pll1_out",
> >                                        "video_pll1_out", "audio_pll2_ou=
t", "sys_pll1_133m", };
> >
> > +static const char *imx8mm_pcie1_ctrl_sels[] =3D {"clock-osc-24m", "sys=
_pll2_250m", "sys_pll2_200m", "sys_pll1_266m",
> > +                                            "sys_pll1_800m", "sys_pll2=
_500m", "sys_pll2_333m", "sys_pll3_out", };
> > +
> > +static const char *imx8mm_pcie1_phy_sels[] =3D {"clock-osc-24m", "sys_=
pll2_100m", "sys_pll2_500m", "clk_ext1", "clk_ext2",
> > +                                           "clk_ext3", "clk_ext4", "sy=
s_pll1_400m", };
> > +
> > +static const char *imx8mm_pcie1_aux_sels[] =3D {"clock-osc-24m", "sys_=
pll2_200m", "sys_pll2_50m", "sys_pll3_out",
> > +                                           "sys_pll2_100m", "sys_pll1_=
80m", "sys_pll1_160m", "sys_pll1_200m", };
> > +
> >   #ifndef CONFIG_SPL_BUILD
> >   static const char *imx8mm_pwm1_sels[] =3D {"clock-osc-24m", "sys_pll2=
_100m", "sys_pll1_160m", "sys_pll1_40m",
> >                                        "sys_pll3_out", "clk_ext1", "sys=
_pll1_80m", "video_pll1_out", };
> > @@ -256,6 +265,15 @@ static int imx8mm_clk_probe(struct udevice *dev)
> >               imx8m_clk_composite("usb_bus", imx8mm_usb_bus_sels, base =
+ 0x8b80));
> >
> >       /* IP */
> > +     clk_dm(IMX8MM_CLK_PCIE1_CTRL,
> > +            imx8m_clk_composite("pcie1_ctrl", imx8mm_pcie1_ctrl_sels,
> > +                                base + 0xa300));
> > +     clk_dm(IMX8MM_CLK_PCIE1_PHY,
> > +            imx8m_clk_composite("pcie1_phy", imx8mm_pcie1_phy_sels,
> > +                                base + 0xa380));
> > +     clk_dm(IMX8MM_CLK_PCIE1_AUX,
> > +            imx8m_clk_composite("pcie1_aux", imx8mm_pcie1_aux_sels,
> > +                                base + 0xa400));
>
> Maybe this should be behind IS_ENABLED() like the SPI clock to avoid
> growth of SPL ?

Makes sense... I'll add that in a v3. Thanks for the review!

Best Regards,

Tim
