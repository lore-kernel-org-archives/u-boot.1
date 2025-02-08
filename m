Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 304E9C02198
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 17:16:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC0FC80836;
	Sat,  8 Feb 2025 18:16:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JDkl0wKp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC3FB8083F; Sat,  8 Feb 2025 18:16:24 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD4DA8082A
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 18:16:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5dcea56d6e2so5610159a12.1
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 09:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739034982; x=1739639782; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T+7zwMyN9NXHmkd6Dih6on53fS/+BbMxUAN4rI0TYkQ=;
 b=JDkl0wKpl+BmGiSKndNhnk4R/2CALDl3R39Uh2GoziZnQ1NCWGfLYUVDjrDZxsdKt+
 4iyF7OFBLhGxSkRil5h2EeOopN3d/RanfM9O/VVBQMrz2AZR+7Dw5uYXhiq98HhqbT9k
 LbsCsZNBG7I1mBCJy8R6gebbIhHWz1uWLI86s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739034982; x=1739639782;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T+7zwMyN9NXHmkd6Dih6on53fS/+BbMxUAN4rI0TYkQ=;
 b=F+iqF975/7gzLhdQ4UcTxOQiSqb8lTsT7QzLM1HQB0Z1bB/Afoe/GJ9d4nUygY8KLV
 DKLC3FYUMw/eTplpxTPi2awv0TaC1focSweNEFzN4n3Dt+iLgYIPRZOiV17S5LPyTS0K
 dRMRsR9h177p3aT950ZNdVbzSqPL5ypYCzoiCKQ2qy7a3INVCEI/2PxyPXrUgrNDxqlv
 8vUpYq+EtPwH307mdw/mxw3xpwLthco6o1BUjRtXELMiJWPU9z180Tx1dBLO/fBBLzUD
 xJBRRM1zZMKG40rfufVCMyX1VbQI5SbGkMxeQapUZhOx8+MCBbI4Sk6R1xMVVA93Dhbq
 tJEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz8C8ZCEjWFZTUq95qYc1FErhtjSaVlZKcIT1PWWjq8mJ9fRNKLMlygk7L4D/t7c5mhWrUm48=@lists.denx.de
X-Gm-Message-State: AOJu0YxRWnN4iFflESfnQaJp7cKJI/SQnbIyfGOj4ziNB4iBXfs284jD
 JJEiYCJXhxQRm8FzzTdQ3xgFyfiL+6R++sytKJsC60U4QcnXUxTMHQqIuwbX5wD0yPLdaF83BGN
 gEWl+kJ1vmg11iWmIwAgEoBsYy7wFchc+avzo
X-Gm-Gg: ASbGncv7W2HCVQW3jFv2wC9mdQpmXOSSu0vrTTUeSV2z4J1uWLze5lln9P6Qo43+MX/
 Yle9VXN18dPtI8ZPAuVS6J3Wb9K+WolV+TDkBWBkyMXeTBCk7phrTd6XI9Ac9VJd1iNcxkCcXBw
 ==
X-Google-Smtp-Source: AGHT+IEBENa6Mijd73+KU/8v3c+OUwwiYLUpUsyoLE7euERAMwbLeogROSLTz+7e9YsdsLaU+bsawNlbe/DB5+k/pz8=
X-Received: by 2002:a05:6402:2383:b0:5dc:7fbe:7313 with SMTP id
 4fb4d7f45d1cf-5de44feb7bfmr9533545a12.6.1739034982152; Sat, 08 Feb 2025
 09:16:22 -0800 (PST)
MIME-Version: 1.0
References: <20250207172116.117749-1-heinrich.schuchardt@canonical.com>
 <20250207172116.117749-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250207172116.117749-3-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 8 Feb 2025 10:16:09 -0700
X-Gm-Features: AWEUYZnXZziEcKMllzNuy-gPGGVH2LAbk0Vplbue0o5u5mFSBcmeuNTGoLlofDs
Message-ID: <CAFLszTiDkiMmAaNq1KuJ-hRonJhg2-Qis2V-EZhEyamFBfuAAg@mail.gmail.com>
Subject: Re: [PATCH 2/6] riscv: dts: starfive: DeepComputing FML13V01 binman
 config
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Hal Feng <hal.feng@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>, 
 Sandie Cao <sandie.cao@deepcomputing.io>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, E Shattow <e@freeshell.de>,
 "E . Shattow" <lucent@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 "Leon M . Busch-George" <leon@georgemail.eu>, 
 H Bell <dmoo_dv@protonmail.com>, Lukas Funke <lukas.funke@weidmueller.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Matthias Brugger <mbrugger@suse.com>, 
 Andreas Schwab <schwab@suse.de>, Nam Cao <namcao@linutronix.de>,
 u-boot@lists.denx.de
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

Hi Heinrich,

On Fri, 7 Feb 2025 at 10:23, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Add the DeepComputing Framework motherboard (FML13V01) to the binman
> include for the starfive_visionfive2_defconfig.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  arch/riscv/dts/starfive-visionfive2-binman.dtsi | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/arch/riscv/dts/starfive-visionfive2-binman.dtsi b/arch/riscv/dts/starfive-visionfive2-binman.dtsi
> index 4cce001e80d..63289405fbb 100644
> --- a/arch/riscv/dts/starfive-visionfive2-binman.dtsi
> +++ b/arch/riscv/dts/starfive-visionfive2-binman.dtsi
> @@ -16,6 +16,16 @@
>         itb {
>                 fit {
>                         images {
> +                               fdt-jh7110-deepcomputing-fml13v01 {

fdt-1 is better than repeating all this information multiple times

> +                                       description = "jh7110-deepcomputing-fml13v01";

That should be a description of the board, e.g. its marketing name.

> +                                       load = <0x40400000>;
> +                                       compression = "none";
> +
> +                                       blob-ext {
> +                                               filename = "dts/upstream/src/riscv/starfive/jh7110-deepcomputing-fml13v01.dtb";

This should not be blob-ext. It should be using the normal:

   u-boot-dtb {
   };

> +                                       };
> +                               };
> +
>                                 fdt-jh7110-milkv-mars {
>                                         description = "jh7110-milkv-mars";
>                                         load = <0x40400000>;
> @@ -58,6 +68,13 @@
>                         };
>
>                         configurations {
> +                               conf-jh7110-deepcomputing-fml13v01 {
> +                                       description = "jh7110-deepcomputing-fml13v01";
> +                                       firmware = "opensbi";
> +                                       loadables = "uboot";
> +                                       fdt = "fdt-jh7110-deepcomputing-fml13v01";
> +                               };
> +
>                                 conf-jh7110-milkv-mars {
>                                         description = "jh7110-milkv-mars";
>                                         firmware = "opensbi";
> --
> 2.47.1
>

Regards,
Simon
