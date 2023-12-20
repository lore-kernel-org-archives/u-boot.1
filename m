Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A334CC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 04:48:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E0B2876D5;
	Wed, 20 Dec 2023 05:47:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="exe13yb1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D41E87530; Wed, 20 Dec 2023 05:47:35 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32D2C876C1
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 05:47:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a2696852965so16381566b.0
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 20:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703047652; x=1703652452; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hG8sMVI/wdZ9EHHXo86q9ig2COrLrf7M/uzPy/hBW1s=;
 b=exe13yb108NqkHFLIRNGON4ljkvvjLkVr0WMA9f5+2POpoI2NAJazd3UD0P2JZ7feF
 40Mv3dgk6cS6C2AsBxPciHY96F0aTDxLLAki/6Q8CVj7SzInMkVDOjKvZllEblNG0hNg
 RoH/6U1nn3FIPurxt4BiZdHtxeTu/nM15ABr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703047652; x=1703652452;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hG8sMVI/wdZ9EHHXo86q9ig2COrLrf7M/uzPy/hBW1s=;
 b=DKuob2y7cblruRPvJdkafOe5Zhfj0xMV6j6W8doH32dsbUBLShIq3AVFHvQ/cckZRh
 iO95WP0cvOalxPeNwkJThQbO1dfPmXo1J0Ifl9HEYYzdZ9AlacGSMPAZfAziGGit3DDv
 6sBZo61x1u3xuZ7cVUoc6L+u4x6IuOKTxGjr5ciVKPTgWsjetHE1TK5yuiMAGwReTli5
 072F0z66O8Ryq4WwRKKjqFFTiMXDaq856/KUC7MxfjgXax2KjNGQTD72B1lvJSFdxwPq
 6GKzY6U4iwxkf3gVhmjcl1ukVCpu9idoDLceFrhtma3VQQG1xXi6Bp/4F3aAd2mTaZf5
 cOYw==
X-Gm-Message-State: AOJu0YzbeZ4Une967Fnr15+FthpOlzzVCLlbppK3HzY3SmuP7kiSvBPi
 QPUsHEtgh0uzEoEPQtV8fy7HofOHhVYvy5/YDl9TzcphfUF3
X-Google-Smtp-Source: AGHT+IFOMoRnR0hdj977q053KH7ahcLOhq38ncIR8qu8M7KdteRl/xBMSHyXTvFNJKyAdPVBvKetgXn43zG+tcIRxc0=
X-Received: by 2002:a17:907:a2cd:b0:a23:75fa:c16c with SMTP id
 re13-20020a170907a2cd00b00a2375fac16cmr2420702ejc.34.1703047652706; Tue, 19
 Dec 2023 20:47:32 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <20231214135103.1606605-7-sumit.garg@linaro.org>
In-Reply-To: <20231214135103.1606605-7-sumit.garg@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 Dec 2023 21:47:20 -0700
Message-ID: <CAPnjgZ2d4P4gtAFVYqAhuuZyt5+ryqadpHHxjEbpyxGaCKiGLA@mail.gmail.com>
Subject: Re: [PATCH 6/8] MAINTAINERS: Add myself as devicetree-rebasing
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
 rfried.dev@gmail.com, marex@denx.de
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

On Thu, 14 Dec 2023 at 06:52, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
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

Reviewed-by: Simon Glass <sjg@chromium.org>
