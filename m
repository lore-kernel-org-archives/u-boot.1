Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97CC9C83F1D
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 10:59:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97C87835B6;
	Thu, 10 Jul 2025 12:59:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OUvRAOe/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4D7A835C0; Thu, 10 Jul 2025 12:59:46 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3E0583599
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 12:59:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-553b60de463so745037e87.3
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 03:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752145184; x=1752749984; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0PzRNefiTm6GRt7/zRzMiNZ1/FlW1Ggy23CaT2hqL80=;
 b=OUvRAOe/aYOuhpcx5vY6EUglWyCPS8nEdBmNfQiGHx/E1J9AZvJYq7iixMcOSyNTf6
 CcLYKMLSkYSedkOABVT7UVmsXBCWFTyBCONEj6oTmB/a5nGqr43a4WpmCize3xqC2a9v
 GVRs2efq1eWoVxR5dhTpVFIR0QWbS+dUXqUqBqg7Ng8gI/8Vy/BX1U+jyJLsW0e32DPh
 NhpqpqykSILufrmjlg4eB314o4ysGWP5Kq54LBD28s1bPtFf+xEbv8wm/9cVHObaPGon
 ChZ34tg7VL8VmJblecEe6EN7R+inSnoCTDinGpHUpik5wU7syFZlhjvDcMttOXiDfGmw
 Gekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752145184; x=1752749984;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0PzRNefiTm6GRt7/zRzMiNZ1/FlW1Ggy23CaT2hqL80=;
 b=X1uUiBP5sO+wpYRgAefVDGiGpzMzeYEDPn7ngxzzQE8a5naR5qVsE12QZ6hxAEe0Y0
 J5JMrpVr5sQuypnuPiVDnp7M1Hq/1Oq+6D7dHaohQdlhr3KCABfr4jKzJ1cfiZOyrgFz
 6mWXBfcitFt7+lMuBv0X/kB4Rq3CfQWqm9c8uDNtovAlcHXp/NuyT2o+BIHozeeaz9Tj
 1xsiziNnUPFw9v33HY2b4ucEEXC9Wa2MAD18gvBy6YrEizRHJa4mbT3m4diggozE84an
 GEnoGUfIymRSx7BJLQev4hO+zpIIYdVWIT2h5bj1LiAXDJeOmBDjbS3C9is1zc4KU4wg
 C3ZQ==
X-Gm-Message-State: AOJu0YxZQC/G5Co6GljBGazDFxalwwrbOjz82aJVxYFPxsTnPpIaMAwE
 UH25vIDXN4GAga4ubRMdpMH6brTjWj4tghs/3JfTi7N5FW3EsDF+xyhYl+O9csUIhqpj5TS0k5g
 y+MASDC6ZiFXB7jz82utnLFz+F20n6LM=
X-Gm-Gg: ASbGncsqTy0eWYJc7ZEFQTGUiT4UFEvVgYR67Ahzjfzts8wjmV7LA9sxlUAgTpzP/J2
 HghShj8rinUglfEZ6fg0pQaG/3h44yE7Q0uoxEMZbb/ZVoP0CnpHG2++2LkH119nr3HXKlomTks
 oHXzmcF6oPezUpnGbxtTULYesROzl9jGAK7qtMF8Nq2BCTuSllaAgKrrhUYJQxzAuE4j/0IV9C9
 K8=
X-Google-Smtp-Source: AGHT+IFuDpHIAJZzprK1X1l5Ypxt0xqnrTyiB+8xctQm+Z2I2g+M7FkLYQBWAmV6+lFPTVi/mdDLMMCC0hRe7Oos2UY=
X-Received: by 2002:a05:6512:3986:b0:553:3073:c38b with SMTP id
 2adb3069b0e04-559000423b6mr1038152e87.1.1752145183782; Thu, 10 Jul 2025
 03:59:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250709234918.140919-1-davidzangcs@gmail.com>
In-Reply-To: <20250709234918.140919-1-davidzangcs@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 10 Jul 2025 07:59:32 -0300
X-Gm-Features: Ac12FXzexNrWOTMxjaOkR0odjJu7UKR5dWcMUfRnSFvakQmiebvMtx9XXg-nYag
Message-ID: <CAOMZO5D1d=Y9i9E+Pcm0sbyKE+M=zUj_9Rs_QHbaE5DPvWFA=w@mail.gmail.com>
Subject: Re: [PATCH] soc: imx8ulp: Add celsius unit for temperature
To: David Zang <davidzangcs@gmail.com>
Cc: u-boot@lists.denx.de, uboot-imx@nxp.com
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

Hi David,

On Wed, Jul 9, 2025 at 9:44=E2=80=AFPM David Zang <davidzangcs@gmail.com> w=
rote:
>
> Signed-off-by: David Zang <davidzangcs@gmail.com>
> ---
>  arch/arm/mach-imx/imx8ulp/soc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-imx/imx8ulp/soc.c b/arch/arm/mach-imx/imx8ulp/=
soc.c
> index bbcd862caa3..5de15b59b96 100644
> --- a/arch/arm/mach-imx/imx8ulp/soc.c
> +++ b/arch/arm/mach-imx/imx8ulp/soc.c
> @@ -400,7 +400,7 @@ int print_cpuinfo(void)
>         if (!ret) {
>                 ret =3D thermal_get_temp(udev, &temp);
>                 if (!ret)
> -                       printf("CPU current temperature: %d\n", temp);
> +                       printf("CPU current temperature: %dC\n", temp);

Your change looks good, but please add a short commit log and send a v2.

Thanks
