Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA12C47258
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 16:28:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8FAE86FC9;
	Mon, 15 Jan 2024 17:28:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="Qehf9Q+A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 124EB86F9F; Mon, 15 Jan 2024 17:28:24 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2FB38751B
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 17:28:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-50ea8fbf261so10403038e87.2
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 08:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1705336100; x=1705940900; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V01kjKK96ZMF1+fOIzrFK0neCpAdj9CUvAfWAZRohSk=;
 b=Qehf9Q+As4Tuj3NAuJyutF+IOnCarw0D4BhSecG6ix8q2BzmwFVoCK43IKf0vcIRX7
 MWtS/t+fZhelFPOL2Bkf9ogS2zEpA9UTtAPkEJrbvCTKmq+CHpr9CrPqfVvMMD361fup
 Ado/+xciY9Ycfvu/ACrbTAtkzmZzoKoFqLEdJU5Cc+5T+A/Cu9+Ed13bcC0MeliJeq1d
 628NJjZDEPNR82K1icC0NJG0zB+pXkdH0Bno+Ekeqheeq7Qc4cowwEW/veugJ+gD368l
 4DfZw3k10Hm0rE67TIofq4EdORjyV9zez7JvET1MvpJBxpgvDyfzcK04Xspi8eIT1JT0
 3BUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705336100; x=1705940900;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V01kjKK96ZMF1+fOIzrFK0neCpAdj9CUvAfWAZRohSk=;
 b=LYwZC74jXAPptGAyjpwn3vsEcSPOXqWLEZ8eEupU98vAnpTCVnKmBLaXQ1YuYZIfaP
 1CqF9Z+0lm+1OSSOsI20fbtEVNJLTakHJvi4yGM4ugtCyvDMfYai0KUcx3JeKDLcmeUf
 uvmv/UdZG74gvI/MjUkuO6je9f4ziU27Igv8NgXJqJP2YkbFLPf6/R35i4ukdPwU7Qh7
 4xzpxC3nJglUycj/ndupFC/Fi1iufiqxSyh8DCnCPlJPM9GDqKxJqYe7kPJbudgbOAEL
 iwECvfXvYxVnHgYGLu52CXze/6Xap5c93uhhHdO9b3Vln3cBINn2ScYkEaZk7uDCML00
 RygQ==
X-Gm-Message-State: AOJu0Yz+yUuEz9j1A83fF0hkt5e3utHVor67tKElY0eOyBLVXoXxZ0El
 9yNtgy+nWJCFnXQrYE2kQFQ+HDNQ8iPXbHd1hNgzpqKGVdwalg==
X-Google-Smtp-Source: AGHT+IG/WCyndla7OkxfwIFAcL1PZ60F+aRfBxchDLfbHLivAHEVfnb0ZXby6NVEfN7r1sgb+YfZjz470uz4PNte7wk=
X-Received: by 2002:a05:6512:1247:b0:50e:7be0:3c38 with SMTP id
 fb7-20020a056512124700b0050e7be03c38mr3157290lfb.98.1705336100068; Mon, 15
 Jan 2024 08:28:20 -0800 (PST)
MIME-Version: 1.0
References: <20240115124657.39109-1-patrick.delaunay@foss.st.com>
 <20240115134642.4.I81fedd3d2ff9635b3738dd1ef349c936bc9b433d@changeid>
In-Reply-To: <20240115134642.4.I81fedd3d2ff9635b3738dd1ef349c936bc9b433d@changeid>
From: Igor Opaniuk <igor.opaniuk@foundries.io>
Date: Mon, 15 Jan 2024 17:28:08 +0100
Message-ID: <CAL6CDMFjDCUw=594CjYqK6Qs+M_k+KAkkN9QeYSSPECUr3z-0Q@mail.gmail.com>
Subject: Re: [PATCH 04/12] stm32mp: bsec: add support of stm32mp25
To: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass <sjg@chromium.org>, 
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>
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

On Mon, Jan 15, 2024 at 1:47=E2=80=AFPM Patrick Delaunay
<patrick.delaunay@foss.st.com> wrote:
>
> Add support of BSEC for STM32MP25x family to access OTP.
>
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> ---
>
>  arch/arm/mach-stm32mp/bsec.c               | 7 +++++++
>  arch/arm/mach-stm32mp/include/mach/stm32.h | 3 ++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-stm32mp/bsec.c b/arch/arm/mach-stm32mp/bsec.c
> index 705c994d9307..5b869017ec1a 100644
> --- a/arch/arm/mach-stm32mp/bsec.c
> +++ b/arch/arm/mach-stm32mp/bsec.c
> @@ -784,9 +784,16 @@ static const struct stm32mp_bsec_drvdata stm32mp15_d=
ata =3D {
>         .size =3D 96,
>         .ta =3D false,
>  };
> +
> +static const struct stm32mp_bsec_drvdata stm32mp25_data =3D {
> +       .size =3D 368, /* 384 but no access to HWKEY and STM32PRVKEY */
> +       .ta =3D true,
> +};
> +
>  static const struct udevice_id stm32mp_bsec_ids[] =3D {
>         { .compatible =3D "st,stm32mp13-bsec", .data =3D (ulong)&stm32mp1=
3_data},
>         { .compatible =3D "st,stm32mp15-bsec", .data =3D (ulong)&stm32mp1=
5_data},
> +       { .compatible =3D "st,stm32mp25-bsec", .data =3D (ulong)&stm32mp2=
5_data},
>         {}
>  };
>
> diff --git a/arch/arm/mach-stm32mp/include/mach/stm32.h b/arch/arm/mach-s=
tm32mp/include/mach/stm32.h
> index 46d469881b32..45c929aa605d 100644
> --- a/arch/arm/mach-stm32mp/include/mach/stm32.h
> +++ b/arch/arm/mach-stm32mp/include/mach/stm32.h
> @@ -197,7 +197,8 @@ enum forced_boot_mode {
>  #ifdef CONFIG_STM32MP25X
>  #define BSEC_OTP_SERIAL        5
>  #define BSEC_OTP_RPN   9
> -#define BSEC_OTP_PKG   246
> +#define BSEC_OTP_PKG   122
> +#define BSEC_OTP_MAC   247
>  #endif
>
>  #ifndef __ASSEMBLY__
> --
> 2.25.1
>

Reviewed-by: Igor Opaniuk <igor.opaniuk@foundries.io>

--=20
Best regards - Freundliche Gr=C3=BCsse - Meilleures salutations

Igor Opaniuk
Embedded Software Engineer
T:  +380 938364067
E: igor.opaniuk@foundries.io
W: www.foundries.io
