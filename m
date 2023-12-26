Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F79C46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:54:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C3A687972;
	Tue, 26 Dec 2023 10:50:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Fm/HO1J/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE98B8795C; Tue, 26 Dec 2023 10:50:36 +0100 (CET)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B95F8795E
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:50:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6d9b37f4804so748204b3a.1
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703584232; x=1704189032; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lYD5nTtqXXRc3ludjLtikO6HoJ28BNY9kbrcp4xg2v0=;
 b=Fm/HO1J/EDVT2I5qESfPmaiU3VF8+jUoXAnOH/dUs6TC9z2mLrr9vyGAtpkLo81E6J
 BCPZeHUXzpsvB+Eng99l8hHsuGx/0cOFfClCS5n4h2Zgh5KWVoP0yJyoCt4kVeywS4nW
 GPebCBPK98kE8OxjLUZVz8dNOjCkERuWzD2Wo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584232; x=1704189032;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lYD5nTtqXXRc3ludjLtikO6HoJ28BNY9kbrcp4xg2v0=;
 b=RuHvolzU31q8zkureAC4Yf91coveofMyp+rxB2zdoRbMDkhV/pnPd/cjnG6eFOPdRa
 j68aamCtnCmyBEXbLuNyehvLso6vI18H1hRepz8Qi71cDIYmgCWGPRc3/ggdW8b5MJc0
 pveckDjVTjyouxlRfU6Sz7DO1NEOB0QJLqTGihDtjW8d+D6XiYW7vF+FdNe2XdNteJvm
 gt9lT/AlKufAQJl9oRNZACnIur1DsNBohuvwfyXQD8OcN7cXwRLvQFzzFg6HePw5Mw9H
 Uf+OPO2i6U6Itk0cCVSIb/mgagPCrPwyKtMdL+KjzHch8oWpyS63QhPWM6J5MtTnN4zs
 T51Q==
X-Gm-Message-State: AOJu0YyrzVaWcCzyfJezggryvhHzzULFlrbYNCqSka7foeAlMwqmrhbX
 mB+5NwLP8CZ92GueOLRU6rfEz4wtUWmZ4b7CHSyqD7bSpIR5hh8SiJ0YlILoOg==
X-Google-Smtp-Source: AGHT+IE+oHqHTc/stMncMdPZY+NhG7hLM+q2tt5zMZBiTI860rjDvvAihoAwZvEB2yC3Zzp/PVZDql8jtt3ws5tbSso=
X-Received: by 2002:a05:6a20:3d1a:b0:18f:97c:384e with SMTP id
 y26-20020a056a203d1a00b0018f097c384emr8658778pzi.40.1703584232479; Tue, 26
 Dec 2023 01:50:32 -0800 (PST)
MIME-Version: 1.0
References: <20231225153929.8284-1-maxim.uvarov@linaro.org>
 <20231225153929.8284-10-maxim.uvarov@linaro.org>
In-Reply-To: <20231225153929.8284-10-maxim.uvarov@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:50:15 +0000
Message-ID: <CAFLszTjg2MTAfJZ17dQFe+Of0VTJVADemigh_gki8GSR07FEvQ@mail.gmail.com>
Subject: Re: [PATHv2 9/9] Makefile: add dtbs to clean
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, simon.k.r.goldschmidt@gmail.com, 
 tien.fong.chee@intel.com, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 bharat.gooty@broadcom.com, rayagonda.kokatanur@broadcom.com, 
 trini@konsulko.com
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

Hi Maxim,

On Mon, Dec 25, 2023 at 3:42=E2=80=AFPM Maxim Uvarov <maxim.uvarov@linaro.o=
rg> wrote:
>
> CI test checks that generated dtb has to be cleaned up.
>
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> ---
>  Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 220411a293..ab603191ad 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2165,7 +2165,8 @@ CLEAN_FILES +=3D include/autoconf.mk* include/bmp_l=
ogo.h include/bmp_logo_data.h \
>                mkimage-out.spl.mkimage mkimage.spl.mkimage imx-boot.map \
>                itb.fit.fit itb.fit.itb itb.map spl.map mkimage-out.rom.mk=
image \
>                mkimage.rom.mkimage mkimage-in-simple-bin* rom.map simple-=
bin* \
> -              idbloader-spi.img lib/efi_loader/helloworld_efi.S *.itb
> +              idbloader-spi.img lib/efi_loader/helloworld_efi.S *.itb \
> +              ./*/*.dtb *.dtb
>
>  # Directories & files removed with 'make mrproper'
>  MRPROPER_DIRS  +=3D include/config include/generated spl tpl vpl \
> --
> 2.30.2
>

Shouldn't this be handled with CLEAN_FILES in arch/xxx/dts ?

Regards,
Simon
