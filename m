Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DFA7104BEC7
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 10:13:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB77183F9A;
	Wed, 11 Mar 2026 11:13:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m+OWIef7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A85F83FB6; Wed, 11 Mar 2026 11:13:02 +0100 (CET)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0087983F93
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 11:12:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@gmail.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-506251815a3so124501411cf.0
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 03:12:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773223979; cv=none;
 d=google.com; s=arc-20240605;
 b=GfdPoBAVL39RBoEkVP+JVyctBLNTq797yE4/lWFgezNUdbvzjaf3ff8PS3V6jpxa2e
 UVdfR5Db4oejX7qmewRSXclwhOhA0OuU4tCEQhKy8XnCQr13i+y2b3Wr8ENu5OCW1plZ
 Dl4ZbE2yWjPBH+DK4AEmqLZ1HpTc4WJ4eWwK9Wn4L4xNea9+GAvvpmMMslNF9NOIFnGq
 NVB2QOc+TC5/kFtzkY23AwU8gJsz0OTKfb7kPa+8AUkyJUGaqK7LyWdKbJfS6d70evmt
 o3vpSxp7Z9NN6g1PvGKzRhw70GdACmPXSUzf19c2E46cw1g7zksn5yvSQBsWnW8dj5F1
 CpPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6MXoCqadqPRENvY3rgNrm0nRdtzl4tjYMVaBGuU1/HQ=;
 fh=ZKoXxWT1zrdGbyPP6j0D3r0LDjDGQfeFIN/aQl6ytsQ=;
 b=V19mXzJhS+xFwWHouSHpeg7r3MSCucH3fFYqGgCmMiJL28e28EEdQ6ggg0npMlDP+M
 IVtutGIEmxKxQJcVhSdYhEvru04NvY97AgjLx6S8eaw2EXi2Od7pPVMpikkOu/mKWxMq
 TK5SzjyC8I9sfn53IMqPzcYPvFuEB4WlrPv41Wj38JucFQ27rytr8bmtNRpeDJInPpBx
 zE7aSiRjQ8phnhnwX+PRMqLWnnbbXTS5h9GU/jrvtnsaPNhH3VBDJ3EWdcsGQ69Tzo0i
 pzMR9th3KMbmJENPR3Vm/4V4v+7Iz/JSlsmfdQ16n5gxTpkr/F8gIamqGBh6WWGlOp3u
 0Ifw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773223979; x=1773828779; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6MXoCqadqPRENvY3rgNrm0nRdtzl4tjYMVaBGuU1/HQ=;
 b=m+OWIef7b6JoQsvF/A0PAufuCJf/dylBkAiM7rSppwE9MLjKqoOVPsrTpcFVndWDlV
 Ly8nFwFBU2/20KaA5Ypg5WlnyVy5pF9h66nKv6BNSXIcQC5qPVffwIpK4t3UBpUnoViB
 V3KTEx2ChU/jdH0x6nSULrVv4XS5YFUbgr84w9hBRahjfJK5bXyVBYz3VbfAeoXFeDXi
 4EfhqBegoCdeMAtqjjSHEMURQKDaFrUYIXgZkPf1xcgIakp8ccMihn/jUp7cqyIoM/UH
 hDDFTZdy3ewSX62oU5U1nOi7bHIY3SpxvquK6doSPtZePh7mXaWc53Hd8I5oWLH7Oj0L
 L3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773223979; x=1773828779;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6MXoCqadqPRENvY3rgNrm0nRdtzl4tjYMVaBGuU1/HQ=;
 b=AYpbG6eMDBosgFIb9tJirSikx4tHY7aYMLUAPSOMz0YapFe/4mG8+NOls6HdEpXeKl
 KPyZCHtq4dK/fXD7Q8vwqmg9sOxLHowojIuDobuiUQdR1ye+45NfQEdUMMdByA24Fzb0
 lf2zUP5dUsmJp2RW95QyNfkeQzV03A/qY9uRziXNQObJjdpx7cMr8f3sSzVlzl5d+Ge8
 XrlSPXikjcjpbIWY0P1r9G4PGXXhKw+n7DNpQk5rGvlbgDnIrvqFe0isguM0QNTxj8dK
 TMc7Vb6keGNbz7BtStpVdKhGpHqr4v0gzHtP88TWq8NqbSkXhJhFzTA7vjoKWWkW9Ily
 4iCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXy/ZWdZfkRrvgF2fOszmZdcKmLRsTbOCa00BfwKnxTh5GNlC/jTmbfyMGVx2pnRfwZ+p2zpCo=@lists.denx.de
X-Gm-Message-State: AOJu0YyfKhA7O0Lpy4avgFKHqGj7GCFbExdEQD/LbIlbmZAV3wfx/lCz
 FJ+19cC5wucyDyn9N+mp6OdA8MHzr2Ruw2axIfwxBKJS2nAOqGyO9SIOGjaY8dLujNtznbkjre1
 5HuV4P80+vliMCu7vhasG7Wsyb+r1gz5n2L2y
X-Gm-Gg: ATEYQzx18cRteZ3wmMAQI4FIo4cv7BYp89xfBZV07O/9Oldr9cxZur4iybI4eC3T2cB
 ts2wdVDJIO5TvY8p7E9G4dzun+mpaKUI7p1Y8SL6Y+uWsB5ZhaUKMtef3uWsgHdczJvUNvTqR3I
 GXCfUm+++14L7SyUj15S64erGxiavE1ZykClXBDyEp5sWpSFpVTNnsrOF277aMnS/f4qOC/e6rG
 hTXhQuwOcb9q7WJ5OOJvd33K1ylLO/BVz2WDPhukwYyv2fTGAmIlDvq+64X05em7aTdjBU+nObG
 G3srB7A=
X-Received: by 2002:a05:622a:1a8d:b0:509:2d50:978b with SMTP id
 d75a77b69052e-5093a16f5a1mr22036991cf.38.1773223978767; Wed, 11 Mar 2026
 03:12:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260120-rk3576-ufs-v5-0-0edb61b301b7@gmail.com>
 <20260120-rk3576-ufs-v5-4-0edb61b301b7@gmail.com>
 <b65b484c-8d1d-4efb-97e7-d6337e087a26@kwiboo.se>
In-Reply-To: <b65b484c-8d1d-4efb-97e7-d6337e087a26@kwiboo.se>
From: Alexey Charkov <alchark@gmail.com>
Date: Wed, 11 Mar 2026 14:12:49 +0400
X-Gm-Features: AaiRm50r3CxPm7HfBBmIDqQqO3wOm6GCz4XDxH5P6AHNxZMAYzcJCZAKN72f9i8
Message-ID: <CABjd4Ywkuzf8whEESSftX9YqD+OKUx_xSWjPD5iXUXsEQG23-Q@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] rockchip: spl: Add support for booting from UFS
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Shawn Lin <shawn.lin@rock-chips.com>, u-boot@lists.denx.de
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

On Wed, Mar 11, 2026 at 3:18=E2=80=AFAM Jonas Karlman <jonas@kwiboo.se> wro=
te:
>
> Hi Alexey,
>
> On 1/20/2026 7:09 PM, Alexey Charkov wrote:
> > Add the required architecture-specific lookups to enable U-boot SPL to
> > load images from UFS storage devices on Rockchip RK3576, which has a
> > boot ROM capable of loading the SPL image from UFS.
> >
> > Signed-off-by: Alexey Charkov <alchark@gmail.com>
> > ---
> >  arch/arm/dts/rk3576-u-boot.dtsi              | 16 +++++++++++++++-
> >  arch/arm/include/asm/arch-rockchip/bootrom.h |  1 +
> >  arch/arm/mach-rockchip/rk3576/rk3576.c       |  1 +
> >  arch/arm/mach-rockchip/spl-boot-order.c      | 14 ++++++++++++++
> >  4 files changed, 31 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/dts/rk3576-u-boot.dtsi b/arch/arm/dts/rk3576-u-bo=
ot.dtsi
> > index dc3771b556a3..e442e94f7132 100644
> > --- a/arch/arm/dts/rk3576-u-boot.dtsi
> > +++ b/arch/arm/dts/rk3576-u-boot.dtsi
> > @@ -12,7 +12,7 @@
> >       };
> >
> >       chosen {
> > -             u-boot,spl-boot-order =3D "same-as-spl", &sdmmc, &sdhci;
> > +             u-boot,spl-boot-order =3D "same-as-spl", &sdmmc, &sdhci, =
&ufshc;
> >       };
> >
> >       dmc {
> > @@ -81,6 +81,15 @@
> >       bootph-some-ram;
> >  };
> >
> > +&gpio4 {
> > +     /* This is specifically for GPIO4_D0, which is the only 1.2V capa=
ble
> > +      * pin on RK3576 available for use as the UFS device reset, thus
> > +      * &gpio4 is required for booting from UFS on RK3576.
> > +      */
> > +     bootph-pre-ram;
> > +     bootph-some-ram;
> > +};
>
> Please wrap this in a #ifdef CONFIG_SPL_UFS_SUPPORT or similar, we only
> need to include gpio4 in spl/u-boot-spl.dtb when SPL_UFS_SUPPORT is
> enabled.
>
> > +
> >  &ioc_grf {
> >       bootph-all;
> >  };
>
> Please add following UFS related pinconf node to SPL, it is referenced
> by ufs_rstgpio:
>
> &pcfg_pull_down {
>         bootph-pre-ram;
>         bootph-some-ram;
> };
>
> > @@ -176,6 +185,11 @@
> >       bootph-pre-ram;
> >  };
> >
> > +&ufshc {
> > +     bootph-pre-ram;
> > +     bootph-some-ram;
> > +};
>
> Please add following UFS related pinctrl nodes to SPL:
>
> &ufs_refclk {
>         bootph-pre-ram;
>         bootph-some-ram;
> };
>
> &ufs_rstgpio {
>         bootph-pre-ram;
>         bootph-some-ram;
> };
>
> Above changes depends on the 438f1fe833e0 from devicetree-rebasing,
> please pick and include that in a v6.
>
> With above fixed this is:
>
> Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
>
> Also feel free to pick "rockchip: rk3576-rock-4d: Enable UFS support"
> from my rk3576 branch [1] in a v6. That branch also include FIXUPs
> with the changes I have requested and tested on a ROCK 4D.
>
> [1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/rk=
3576

Thanks a lot Jonas! Applied the above (and your suggested fix from the
other thread). Will also cherry-pick the DTS change enabling UFSHC on
NanoPi M5 and add the respective defconfig change for completeness,
then resend this without the two patches which Neil has already
applied to his tree, so that Kever could pull the remainder.

Best regards,
Alexey
