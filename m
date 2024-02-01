Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DCA8C4828D
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 14:41:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC7DD87CDF;
	Thu,  1 Feb 2024 15:41:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="iREbFyFP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91529871C0; Thu,  1 Feb 2024 15:41:43 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 666A187CDF
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 15:41:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2d073b54359so10640191fa.0
 for <u-boot@lists.denx.de>; Thu, 01 Feb 2024 06:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1706798499; x=1707403299; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=orqhr0KqiZCUT5CfOvFZhFNknWWKoqulX3dS0Rcot8c=;
 b=iREbFyFPYuLahSW3AoKSE9ZX5kWHuRrKwPNlsbXiZURtHGFR9xQvsu7DgBylCTVl1B
 5vKE7HfNWIjGgr8WhQWHfeF3OHMf0mnYYX1rxN8jRSpIc1mJXp5lDCSj8pegA+JAqR+m
 j9j9cZKRF19U/3zZFrgxVJNLJ9iy6wbhZbNtk0CmfP6VysZNTXqt4uBJcrMZZjdCt1CP
 T+7H5nDUg7MHtdqWDbMykTOunVCkw99Cnvk7jBKeZDnNVLcYK8HSoMKDGq2hEb3iViIo
 RRZG+Ig8jyCHZxsVDj5/gLN93Diyvoa8kYoxIqJ+hk8oSCiIUc+kQQ+HcLHeNiQ6suKQ
 pDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706798500; x=1707403300;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=orqhr0KqiZCUT5CfOvFZhFNknWWKoqulX3dS0Rcot8c=;
 b=eaI82XAhHSEsBDksc4RDHtbJysDLU5sXNTW/yuEP2fcUKnv15Zsid8LIgcmoTKtDCA
 3uvTsN+zCb/nQg5TuvpVEOhSVz9gDSoqXtEufs4q0nl7481+zBNeyvBdzyN1RNykPKn7
 izhicKsYdU2cc3KaQ6yEB5vtyQmI/VISOrOPalUdKBH50iOQ4ad2VcZNuhjF8k3eRfdw
 vmiz3qf1yiyWUVE1WLrWdWehRlUFmhraeJj0aB3G7ypfGfOdS6hGvP68eTIOUHRZHpAX
 7w624Y7FXBX277SA50u3yUGZY6RqDLWSwUY3inuhW84cH5JA0HppT062dGNy8D6BnNtx
 tzDw==
X-Gm-Message-State: AOJu0YwKz+M4VaKCynPDz2d42Tmwc751c/7rUHj2/w/J1XFskKx4X7l5
 Wmcu6v6g+Qs7mQyAjHHCAOZA5UCG3UZpRawX36AYi3E/zn2GCzAlYup5Lw32JyECoplzDcdURaV
 uqKFR9L4DVcbiOXoMLapqAkz1fbo1s+3MzUJl8A==
X-Google-Smtp-Source: AGHT+IGbcGrb0QtkOIKzgyEQIqWTfLhwTaU4ULp1rY2v4wEYo4J+PMffJfZkB4lZdfB5X6tR8d4f6FIp1RpVmjh59UU=
X-Received: by 2002:a05:651c:1242:b0:2cf:4e53:7c38 with SMTP id
 h2-20020a05651c124200b002cf4e537c38mr3370082ljh.22.1706798499710; Thu, 01 Feb
 2024 06:41:39 -0800 (PST)
MIME-Version: 1.0
References: <20240201030634.1120963-16-bb@ti.com>
 <20240201030634.1120963-18-bb@ti.com>
In-Reply-To: <20240201030634.1120963-18-bb@ti.com>
From: Igor Opaniuk <igor.opaniuk@foundries.io>
Date: Thu, 1 Feb 2024 15:41:27 +0100
Message-ID: <CAL6CDMFCjErnrwVbyLHGnmj0OSesOxE-BNrEqY8ZW=Ej+YGxiA@mail.gmail.com>
Subject: Re: [PATCH v2 01/13] soc: add info to identify the am62p SoC family
To: Bryan Brattlof <bb@ti.com>
Cc: Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Hari Nagalla <hnagalla@ti.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Nishanth Menon <nm@ti.com>,
 Andrew Davis <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 UBoot Mailing List <u-boot@lists.denx.de>
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

On Thu, Feb 1, 2024 at 4:07=E2=80=AFAM Bryan Brattlof <bb@ti.com> wrote:
>
> Include the part number for TI's am62px family of SoCs so we can
> properly identify it during boot
>
> Signed-off-by: Bryan Brattlof <bb@ti.com>
Reviewed-by: Igor Opaniuk <igor.opaniuk@foundries.io>

> ---
>  arch/arm/mach-k3/include/mach/hardware.h | 2 ++
>  drivers/soc/soc_ti_k3.c                  | 3 +++
>  2 files changed, 5 insertions(+)
>
> diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/=
include/mach/hardware.h
> index a1a9dfbde66c8..040288150b12f 100644
> --- a/arch/arm/mach-k3/include/mach/hardware.h
> +++ b/arch/arm/mach-k3/include/mach/hardware.h
> @@ -46,6 +46,7 @@
>  #define JTAG_ID_PARTNO_J721S2  0xbb75
>  #define JTAG_ID_PARTNO_AM62X   0xbb7e
>  #define JTAG_ID_PARTNO_AM62AX   0xbb8d
> +#define JTAG_ID_PARTNO_AM62PX  0xbb9d
>
>  #define K3_SOC_ID(id, ID) \
>  static inline bool soc_is_##id(void) \
> @@ -61,6 +62,7 @@ K3_SOC_ID(am64x, AM64X)
>  K3_SOC_ID(j721s2, J721S2)
>  K3_SOC_ID(am62x, AM62X)
>  K3_SOC_ID(am62ax, AM62AX)
> +K3_SOC_ID(am62px, AM62PX)
>
>  #define K3_SEC_MGR_SYS_STATUS          0x44234100
>  #define SYS_STATUS_DEV_TYPE_SHIFT      0
> diff --git a/drivers/soc/soc_ti_k3.c b/drivers/soc/soc_ti_k3.c
> index 355a5368dd45a..d7d0152b115fa 100644
> --- a/drivers/soc/soc_ti_k3.c
> +++ b/drivers/soc/soc_ti_k3.c
> @@ -45,6 +45,9 @@ static const char *get_family_string(u32 idreg)
>         case JTAG_ID_PARTNO_AM62AX:
>                 family =3D "AM62AX";
>                 break;
> +       case JTAG_ID_PARTNO_AM62PX:
> +               family =3D "AM62PX";
> +               break;
>         default:
>                 family =3D "Unknown Silicon";
>         };
> --
> 2.43.0
>


--=20
Best regards - Freundliche Gr=C3=BCsse - Meilleures salutations

Igor Opaniuk
Senior Software Engineer, Embedded & Security
E: igor.opaniuk@foundries.io
W: www.foundries.io
