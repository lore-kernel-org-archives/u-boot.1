Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ABBBEE4996
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 16:50:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CC60864B3;
	Tue, 22 Aug 2023 18:50:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oEkGVEKc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8657864BD; Tue, 22 Aug 2023 18:50:07 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7EEF8648C
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 18:50:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cryosay@gmail.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6bcac140aaaso3679316a34.2
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 09:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692723002; x=1693327802;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=95UbAJw2p2/V3oWNC0ZWQHHRJ4JpgFFeCnzYV53g8iA=;
 b=oEkGVEKcjm1xOKMSvsOAcbakVkCB52sbq/tFHFAM/SAj7PaImW8Nvr5nxwoxXfOImC
 muzzisI7hgOggfbjQWxEx9POjxFiwjrCB7rT5P4W048cqkDZjlS7FMPkFTiTfqZ8eZf1
 4df1P+hz6K5bma+eUbAFHSqQ0V88R//mUIqbhb9IvGJ0FfdxYk3p4+8weKzHlnQk/qvn
 yQ+CI8ENJH7TKSmFTVKS8+Ndw/20Fgjpv9toD2XPsRBcJtlT1y9ioeZFBucYv20tG6Ju
 c9DZc1nVSFpOEWk3/oHtA+tcfFHl9n7eX5XxRMP4+QXyClwEVltVjltIutlBrx1quJy0
 Yr0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692723002; x=1693327802;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=95UbAJw2p2/V3oWNC0ZWQHHRJ4JpgFFeCnzYV53g8iA=;
 b=Ul4PvwoCG2EuKHuDY9hKp21rdotrgTw48+jTFWjTZtDklZMcjuynvcNVoWG2x3PyD+
 V+VIJT8mhyqlZijXDjPlnKMSQ3VxoD/hg+FBWTb9IYuo5OTzqkRmn2tBD2JDOwPG8U0O
 X5V2GvaOuhuwrRvzg+oSlSHnsF8erHSOYA3RLBlfBhVaLY9Obf1FIcaVhQJyyyy19a9/
 UGRzKij0n7cBVdMxo4zeBZPuX3poIw3m5Z8b/dTMn5cLmTXGxOkNtWdZQUSSnRwrsiBd
 I0kVsbmx6yxSN+ysjsURv3SqNdo6lJDmm1+/AQXEP3NAa0ml8tvDxo8zwpyLblRkRje7
 hKAg==
X-Gm-Message-State: AOJu0YwEbKxqbCdsKGUsouDX5n9gDkrsNWJWBbWVkpPmxUQ8O4HvIYDq
 b+ksJw/zrm0E5kXz6+bDYDMP8HeEZw+cHbNm7e4=
X-Google-Smtp-Source: AGHT+IF5ONcLoHwM9cKT7NLTaPidJ6jIWN4GLCUOtPFwMRPA/Hvq9N/AooQl/fjETAOSyEuMozvQ218vljGdTbs7ObI=
X-Received: by 2002:a9d:6188:0:b0:6bd:844:69d5 with SMTP id
 g8-20020a9d6188000000b006bd084469d5mr12995956otk.4.1692723002324; Tue, 22 Aug
 2023 09:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230822155312.53131-1-oleksandr.suvorov@foundries.io>
 <CAOMZO5BX1+_5FxjgSVna5i3A+uWANwjfqrtgftumpq5gGcEPbg@mail.gmail.com>
In-Reply-To: <CAOMZO5BX1+_5FxjgSVna5i3A+uWANwjfqrtgftumpq5gGcEPbg@mail.gmail.com>
From: Oleksandr Suvorov <cryosay@gmail.com>
Date: Tue, 22 Aug 2023 19:49:50 +0300
Message-ID: <CAGgjyvHR9C+VtKa0fFaDhKqoj+J9oP8u8VG003+dnnFBwP1KCw@mail.gmail.com>
Subject: Re: [PATCH] spl: watchdog: introduce SPL_HW_WATCHDOG
To: Fabio Estevam <festevam@gmail.com>
Cc: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, u-boot@lists.denx.de, 
 Igor Opaniuk <igor.opaniuk@foundries.io>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Claudiu Beznea <claudiu.beznea@microchip.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, Marek Vasut <marex@denx.de>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Michal Simek <michal.simek@amd.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Nikhil M Jain <n-jain1@ti.com>, 
 Paul Barker <paul.barker@sancloud.com>, Roger Quadros <rogerq@kernel.org>, 
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Stefano Babic <sbabic@denx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>
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

On Tue, Aug 22, 2023 at 7:28=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi Oleksandr,
>
> On Tue, Aug 22, 2023 at 12:53=E2=80=AFPM Oleksandr Suvorov
> <oleksandr.suvorov@foundries.io> wrote:
>
> >                 ddr-1d-imem-fw {
> > -                       filename =3D "lpddr4_pmu_train_1d_imem_202006.b=
in";
> > +                       filename =3D "lpddr4_pmu_train_1d_imem.bin";
> >                         type =3D "blob-ext";
> >                         align-end =3D <4>;
> >                 };
> >
> >                 ddr-1d-dmem-fw {
> > -                       filename =3D "lpddr4_pmu_train_1d_dmem_202006.b=
in";
> > +                       filename =3D "lpddr4_pmu_train_1d_dmem.bin";
> >                         type =3D "blob-ext";
> >                         align-end =3D <4>;
> >                 };
> >
> >                 ddr-2d-imem-fw {
> > -                       filename =3D "lpddr4_pmu_train_2d_imem_202006.b=
in";
> > +                       filename =3D "lpddr4_pmu_train_2d_imem.bin";
>
> Unrelated changes?

Oops, yes, sorry, I'll resend the fixed version soon.

--=20
Best regards
Oleksandr

Oleksandr Suvorov
cryosay@gmail.com
