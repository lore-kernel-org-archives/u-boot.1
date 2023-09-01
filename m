Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 969E5CA0FE6
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 07:18:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F08A78669D;
	Fri,  1 Sep 2023 09:18:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="3ENcSvYh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CB9686564; Fri,  1 Sep 2023 09:18:38 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8A9F8669D
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 09:18:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-59231a1ca9eso17998077b3.1
 for <u-boot@lists.denx.de>; Fri, 01 Sep 2023 00:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1693552713; x=1694157513;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SWmJ7IeDVtUBT0dWvkGOjYkZvj73SZob5aDZ2zXamsE=;
 b=3ENcSvYhAnDomMI+7bsar4x03j54UnFHDpAslOd5X2Yo+yaulC39jyk6D0Gtyso0fu
 TFWj3rik8OUnsSoi915cxgJismE0Zj7k7Ure4szCGoNf8ri+G/qtt1krbNFwDimXLJzi
 oM+PQQc4SjtQnF3F/FTOsUscVYp6mFPHxqTRgRyBhMvK/SMHYd5zxsYKZ2+y3ZqUOFab
 N3DIS238D6Z4d2UbVxleli/o7HIIPOfmmQH4wP8/apX2Mcd/1cXqWw4PUHW83rHbU0+O
 4HrBHC96lqcYslJ8tbHITSdAoainCmVlVchhFsN84MLOx/N4lIfldv6C+mJxRSW9xiva
 zQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693552713; x=1694157513;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SWmJ7IeDVtUBT0dWvkGOjYkZvj73SZob5aDZ2zXamsE=;
 b=DnyNLaNVJnhYBDCxZJxxcWPh53pzMcRavX+BlciLf1XyU/PLCh2Dv9tzSYvnvsdNPH
 Ed9KsGs4wjfYCv6IfFzZWTjb57LdO0VZrLrTS7qydhDMJMbB44VEfDLMaXcHSUzkpkyl
 aFAmpBOlv9dG2aSo4x0loKoYTzObT+mFjrS1vGJo2mMXKe2IdYymy8Jb78lmMFoheeD9
 B5iNHvbmREN41T+BEcpsKDYCgOyaTv5UuxJ+CKSy0S9NcIcn8kcsOrCQ8dUxFVxo9hAu
 EQRHX0D6Z5W9grW9iJMNZcNuDPKxEPMdAnhFmcG8fCfWijMFCA/FxnUJhHYCOxd8gffv
 jwHg==
X-Gm-Message-State: AOJu0YwS+ECCvjbX/PRPebTIUn6j+AKgPMNo9y2gv/i8Rq1KhkqHGdU/
 P1+j/xVIVMjLrEdbzRO8t0wGruGXJp3Ljta2N17p2g==
X-Google-Smtp-Source: AGHT+IGeyi4C19VmkjShNrTGjsCxBZJs7QJ09bKyRCKdvEKAOI2LO4xY0SCyB+HN7emvlv/556EZmou7HK1YK29fdqw=
X-Received: by 2002:a25:3751:0:b0:d7e:8175:4fa9 with SMTP id
 e78-20020a253751000000b00d7e81754fa9mr716015yba.4.1693552713463; Fri, 01 Sep
 2023 00:18:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230830140349.10801-1-lists@steffen.cc>
 <20230830140349.10801-3-lists@steffen.cc>
In-Reply-To: <20230830140349.10801-3-lists@steffen.cc>
From: Michal Simek <monstr@monstr.eu>
Date: Fri, 1 Sep 2023 09:18:22 +0200
Message-ID: <CAHTX3dKJ-F5au0bo2FgWQGRcKQnenyMpUWvXD2v0pfCvnVrQJg@mail.gmail.com>
Subject: Re: [PATCH 2/5] drivers/usb/dwc3: zynqmp: only free reset gpio if we
 have one
To: Steffen Dirkwinkel <lists@steffen.cc>
Cc: u-boot@lists.denx.de, Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Marek Vasut <marex@denx.de>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
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

st 30. 8. 2023 v 20:16 odes=C3=ADlatel Steffen Dirkwinkel <lists@steffen.cc=
> napsal:
>
> From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
>
> This gpio is optional so undonditionally freeing it will crash.
>
> Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> ---
>
>  drivers/usb/dwc3/dwc3-generic.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-gene=
ric.c
> index 7f0af05855..dcc342ed04 100644
> --- a/drivers/usb/dwc3/dwc3-generic.c
> +++ b/drivers/usb/dwc3/dwc3-generic.c
> @@ -149,7 +149,9 @@ static int dwc3_generic_remove(struct udevice *dev,
>             priv->ulpi_reset) {
>                 struct gpio_desc *ulpi_reset =3D priv->ulpi_reset;
>
> -               dm_gpio_free(ulpi_reset->dev, ulpi_reset);
> +               if (priv->ulpi_reset) {
> +                       dm_gpio_free(ulpi_reset->dev, ulpi_reset);
> +               }
>         }
>
>         dwc3_remove(dwc3);
> --
> 2.42.0
>

Already fixed by:
https://lore.kernel.org/all/20230809033350.5718-1-venkatesh.abbarapu@amd.co=
m/

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
