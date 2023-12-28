Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B22C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 13:39:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4377187A62;
	Thu, 28 Dec 2023 14:37:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oI3bRcti";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B84787A51; Thu, 28 Dec 2023 14:37:47 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE37887A71
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 14:37:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d3dee5f534so46509715ad.1
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 05:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703770663; x=1704375463; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uy84thRsphcaIQxe/QfNnfX2G1q2+y/VW1q+OS51VcI=;
 b=oI3bRctiryQ4o4EJFLIR6gb6wjDE3qIYpsgUpO/zvJrb9CwGzrIYBdfjBfhiZD/aUr
 MfO5APZSfNUQkRDhKc0o6GBKeTOvLz0/KBaODzY1D77dl2Adl/rM3Nl2WYRtOndnddVv
 ltSO6HBaajwOuE5+xPxsI2CWyXYhgUc/0Or+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703770663; x=1704375463;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uy84thRsphcaIQxe/QfNnfX2G1q2+y/VW1q+OS51VcI=;
 b=LENt8Ut/s97hh3R2AUPQIMSGrxgxPhvb8b0S9bbT6yUptW3q7ceYF8BB/gvW9gXK0m
 iy/9re0G3VoLaRwox1lGJLvBhbZO2vfSRXKOQTbK8B3YsLa/FQoSHqeLv93KAxm1V3Nn
 iEU14i0QDi2CPKGfAi7fgmq5NuWxhBIMnzlOOsEy/o8i+Ya2q+Ys2uc61GaUTd/GuLJL
 rxsIC96aUTR2Z2mKjERf/dBWwkgNfXBCNvFQuXwQ10BU8axJ+cqYrV9ijM5jM7eMf9Zm
 nOconzbTH/v5cWP8FpSvV6DRZftze942xAXoqtLhUHGjFwX8Ttp48ayBZbZGkjqpGN5I
 axMQ==
X-Gm-Message-State: AOJu0YxByaIDIF73v7AThfBJ3FTbXjX4qkn7V1/gcLYTy+P5z+a6vvoP
 P8wC0R/+FjXssPdSdiAcLhZKZYTjPfpL6eZoTwYAS1QEkLyQ
X-Google-Smtp-Source: AGHT+IFf1Vv8Be804vdB8DOuJBlD3TbwNqBsdpaZD2pEpVGoF03u+veiLHPfctGlB+7ADpPNfj48lYm7klQqcYO3dGA=
X-Received: by 2002:a17:90a:d2c4:b0:28c:3620:b5ee with SMTP id
 dj4-20020a17090ad2c400b0028c3620b5eemr9908325pjb.28.1703770663297; Thu, 28
 Dec 2023 05:37:43 -0800 (PST)
MIME-Version: 1.0
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-7-sumit.garg@linaro.org>
In-Reply-To: <20231228115804.3626579-7-sumit.garg@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Dec 2023 13:37:11 +0000
Message-ID: <CAFLszTiLyy6GNOnvYa_8OsAC0mN1p63QWQtf2-toA0AJFhm3EA@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] MAINTAINERS: Add myself as devicetree-rebasing
 maintainer
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, trini@konsulko.com, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
 rfried.dev@gmail.com, marex@denx.de, mibodhi@gmail.com
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

Hi Sumit,

On Thu, Dec 28, 2023 at 11:59=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org>=
 wrote:
>

Please can you add a commit message?

> Reviewed-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>
> Changes in v3:
> --------------
> - Picked up review tag

BTW 'patman status' does this for you.

>
> Changes in v2:
> --------------
> - Picked up review tag
>
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 969514468cb..253092c345c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -951,6 +951,12 @@ F: cmd/cyclic.c
>  F:     common/cyclic.c
>  F:     include/cyclic.h
>
> +DEVICETREE REBASING SUBTREE
> +M:     Sumit Garg <sumit.garg@linaro.org>
> +S:     Maintained
> +F:     devicetree-rebasing/
> +F:     dts/arch/
> +
>  DFU
>  M:     Lukasz Majewski <lukma@denx.de>
>  M:     Mattijs Korpershoek <mkorpershoek@baylibre.com>
> --
> 2.34.1
>

Regards,
Simon
