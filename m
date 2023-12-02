Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192BDC4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 23:12:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85CEC8770A;
	Sun,  3 Dec 2023 00:12:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="UDBjjRbk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F328F8777B; Sun,  3 Dec 2023 00:12:42 +0100 (CET)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DC52876E6
 for <u-boot@lists.denx.de>; Sun,  3 Dec 2023 00:12:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2c9c149848fso42462051fa.2
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 15:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1701558760; x=1702163560;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P8wqhpMZk6oiQVFpSmSIhUSDRR2Zn2C8dwfgAjc5YEU=;
 b=UDBjjRbk1MnBQ1SNo2unRoYpEqpGIVPdQ/vjqyi+eqSkCsd4ClbUActmVOt64yHPAg
 RfGiW4vZBIv9l2tJlFYoyema2nNYyfQifKGrgfLF2q/ncEmA6Ocpm2vJwwJahLx3cvhC
 k4IEE7GuQSFxIZMxTw3ruF/6Sj08f7596yCAWu2OypTsuljnWURXwHBsZVMf9OeiJWNj
 DktyClo+gm6XL3bqStIecnAAJ45bK5kYpBU/UBjLQbjBuPwwUak2Q9Q/bTIKQQF5Esxu
 J3XBiksc26cUXBeevtH9cFRfc7V/alpTvVzoqSc2a2lTbawXPU+FoleDwcIXc8atd9C9
 hXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701558760; x=1702163560;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P8wqhpMZk6oiQVFpSmSIhUSDRR2Zn2C8dwfgAjc5YEU=;
 b=BECk5iTMMD4rbLCgvXueRFmsdAqmB/NxeSkOdi39fRTbUr12Im13W4Qj03dLmAP3X8
 o/gRjXCw7eIBRQ5XDJ6G/GuqiW1abYo9c5FCbssJjTpmbu4QHBZc0yObzI/u7dRC7tDb
 Wdq+V/9A/DoADbnSTSce4qpMHSjB2SdIDTy5zfEObCMbQfEAVo9FNvtSlmwIswPiyS2g
 3KevKYCmjYezubnUszU0346wipcrLZdK/W0UO00EDMrSE2GWWpb25xyG30qssiVEi4xB
 RBg8cEd7vubjQ1j1c3W2/xXgq1I9Zhn4+oA+0TOHvWt1PZfCLvvfa1qbMCjdhZnV2UPL
 GYDQ==
X-Gm-Message-State: AOJu0Yxq/S07nP4vV4NP8V5YMh3TuY4Fygvzh03pvz9EXklZo425aA4q
 Rscgn7SRUZjaR8e9SpIfpIDEjG32xCVyUQ0dnZ3F5g==
X-Google-Smtp-Source: AGHT+IFKYREUf9rTfkXkA5RNwiwipF9aFbsJ86d8PGHMfDHAsZuy4HR3CSE1jVDUDGGQ7q7Zdf2UWQ==
X-Received: by 2002:a2e:99d8:0:b0:2c9:d873:5c2f with SMTP id
 l24-20020a2e99d8000000b002c9d8735c2fmr2102005ljj.65.1701558759967; 
 Sat, 02 Dec 2023 15:12:39 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com.
 [209.85.167.54]) by smtp.gmail.com with ESMTPSA id
 z5-20020a2e9645000000b002c9c21d01c2sm790871ljh.101.2023.12.02.15.12.39
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Dec 2023 15:12:39 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id
 2adb3069b0e04-50bd928b13cso2578284e87.2
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 15:12:39 -0800 (PST)
X-Received: by 2002:ac2:5213:0:b0:50b:f268:8593 with SMTP id
 a19-20020ac25213000000b0050bf2688593mr53839lfl.7.1701558758864; Sat, 02 Dec
 2023 15:12:38 -0800 (PST)
MIME-Version: 1.0
References: <20231126220836.374956-1-i@shantur.com>
 <20231126220836.374956-4-i@shantur.com>
 <CAPnjgZ2W2maVN14usKHHdyTKyzriP_=iJYpYBvycRxR5zDZW2g@mail.gmail.com>
In-Reply-To: <CAPnjgZ2W2maVN14usKHHdyTKyzriP_=iJYpYBvycRxR5zDZW2g@mail.gmail.com>
From: Shantur Rathore <i@shantur.com>
Date: Sat, 2 Dec 2023 23:12:27 +0000
X-Gmail-Original-Message-ID: <CAHc5_t3fMFntuQ+VLOb9RQ7CBCy7mtsEFEKZ1bWzDAu3mCVEHw@mail.gmail.com>
Message-ID: <CAHc5_t3fMFntuQ+VLOb9RQ7CBCy7mtsEFEKZ1bWzDAu3mCVEHw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] defconfig: rockpro64: Enable SF EFI var store
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>
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

Hi Simon,

On Fri, Dec 1, 2023 at 6:44=E2=80=AFPM Simon Glass <sjg@chromium.org> wrote=
:
>
> Hi Shantur,
>
> On Sun, 26 Nov 2023 at 15:09, Shantur Rathore <i@shantur.com> wrote:
> >
> > RockPro64 uses SPI Flash for storing env, also use it store
> > EFI variables.
> >
> > Signed-off-by: Shantur Rathore <i@shantur.com>
> > ---
> >
> >  configs/rockpro64-rk3399_defconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64-rk3=
399_defconfig
> > index 4cd6b76665..f550f2ae43 100644
> > --- a/configs/rockpro64-rk3399_defconfig
> > +++ b/configs/rockpro64-rk3399_defconfig
> > @@ -8,6 +8,8 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> >  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x300000
> >  CONFIG_ENV_SIZE=3D0x8000
> >  CONFIG_ENV_OFFSET=3D0x3F8000
> > +CONFIG_EFI_VARIABLE_SF_STORE=3Dy
> > +CONFIG_EFI_VARIABLE_SF_OFFSET=3D0x7D0000
>
> Can we use this offset in binman when creating the SPI-flash image?

Unless I missed something, binman is used when something is bundled
with a u-boot image.
This is similar to ENV_OFFSET letting u-boot know where it can write
the EFI variables.
I didn't see ENV_OFFSET referred in rk3399-u-boot.dtsi or
rk3399-rockpro64-u-boot.dtsi

Please correct me if I am wrong.

Kind regards,
Shantur
