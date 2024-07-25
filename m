Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A10C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 23:34:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53586886DB;
	Fri, 26 Jul 2024 01:32:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XRbgGunS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6115C884CA; Fri, 26 Jul 2024 01:32:50 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 062E98851E
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 01:32:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5d5846f7985so231067eaf.0
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 16:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721950364; x=1722555164; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QuIH7m7cDNCf6c7QyMdMtHgi9fE3LnoRLofF0JMfo5A=;
 b=XRbgGunSE9+t4Ym3bznJZQVlkzP04xz0+QH7Im3pB/p6tCiyUx8KCO+vYr/CfmfkyF
 20tqJbFDadm26ta9xGiG8dJc5ml2ommIAEjFDfqv9MtZWQzaZVdUlAXcIma/zRafmLW4
 GgBVSd7WJ8H+hH1wVxwoAIHLI7o+8JldZCk3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721950364; x=1722555164;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QuIH7m7cDNCf6c7QyMdMtHgi9fE3LnoRLofF0JMfo5A=;
 b=oOS0YKm5UCxAqStQXX8o4Vn02bCq9zlzq7+EclFAIAfx7JMOXdxHKdp7cMnpWM/pUM
 P8NF/p0w2nKV8pGhqXisP2hwyE7+iG0hWGzDirzq0vXNVESdcrXm5vGqhH/QfK1OVsWb
 7FVFYi+y7A4WEI0Hg74wcWR5Y5JD1sIee5CgXM/AXoISKwzo7g/FihYmPydtFvd7Sks6
 7WJwMyBdh+xNixEy8ICEdupkdotGnM9MU/WzliWPj+CrWpTf430FBJNOwXS//mvflldP
 edb1uiBlUAIEaezZ7d9DFTjQYNsHx5jrSIhMqGVy5d+eRqct0dJWAnJwZrNy86ZFk9JP
 pv9w==
X-Gm-Message-State: AOJu0YykamYHwL+XsB8GKnvbCXoGaVaKPQXvz2jT8VSdtUMoMPokZGEe
 58x3/xi+NowNYjV5wX1oyabkVo1kcPFbxGG3by0NbXbrb6vUtdlSeT9KDFtzV6wMXbzMBZKSF0s
 NdjKKlHKxVlhaD9tFw1VNHKpo12OFK/CayYYW
X-Google-Smtp-Source: AGHT+IHjWVSQ5PsuGotLwMlmfeLlQ/1UBAUTXweig5dRgiQp9knR3SkzOd4DnioDgqYu1/xwpO1lj5pvMABMr/8X+GA=
X-Received: by 2002:a05:6358:3a13:b0:1aa:bc42:eb01 with SMTP id
 e5c5f4694b2df-1acf886fcb1mr514620655d.7.1721950363669; Thu, 25 Jul 2024
 16:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-26-sughosh.ganu@linaro.org>
In-Reply-To: <20240724060224.3071065-26-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jul 2024 17:32:32 -0600
Message-ID: <CAFLszTg+5teQs4m++hX2wEDh1O7wTjPSK-2ogceFv1R=N_dz-A@mail.gmail.com>
Subject: Re: [PATCH 25/40] sandbox: move the TCG event log to the start of ram
 memory
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

Hi Sughosh,

On Wed, 24 Jul 2024 at 00:04, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The TCG event log buffer is being set at the end of ram memory. This
> region of memory is to be reserved as LMB_NOMAP memory in the LMB
> memory map. The current location of this buffer overlaps with the
> memory region reserved for the U-Boot image, which is at the top of
> the usable memory. This worked earlier as the LMB memory map was not
> global but caller specific, but fails now because of the overlap. Move
> the TCG event log buffer to the start of the ram memory region
> instead.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since rfc: New patch
>
>  arch/sandbox/dts/test.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> index 5fb5eac862..1e1e9eaeb5 100644
> --- a/arch/sandbox/dts/test.dts
> +++ b/arch/sandbox/dts/test.dts
> @@ -78,7 +78,7 @@
>
>                 event_log: tcg_event_log {
>                         no-map;
> -                       reg = <(CFG_SYS_SDRAM_SIZE - 0x2000) 0x2000>;
> +                       reg = <(CFG_SYS_SDRAM_BASE + 0x1000) 0x2000>;
>                 };
>         };
>
> --
> 2.34.1
>

It looks like this will conflict.

Please check and update the memory map at the end of
doc/arch/sandbox/sandbox.rst

Separate from this patch, I really think the TCG event log should go
in a bloblist. I can have a crack at that if you like.

Regards,
Simon
