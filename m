Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84771C46CD8
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 10:28:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E78B287831;
	Fri, 22 Dec 2023 11:28:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="W+YE+NtN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF16E87823; Fri, 22 Dec 2023 11:28:12 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0702E87831
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 11:28:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-50e3c6f1c10so2163132e87.1
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 02:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703240890; x=1703845690; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bNQSf35Uj0jVMffITW9x0jZR5ohcxhRLq/4/n0zt/DM=;
 b=W+YE+NtN1LIZadQT3aqmvKgtvaV1H1L71kxly2rxlDpLemVojNgCml4b691GMZ3vXJ
 FIVc6LWq1uMFWDKeSEkX+gIlt3Um2lotzzWHm4IlJizHSoHMlYijOIoCv61/xdFIipJ4
 EA5+KPLcHMeb4fhI8jjLq1XKgdGNjfeDLGvHxTxyfb1nS2COc7HblzuX9vd4v5dZawZV
 ZIlUcpz0DClOEeLBskY/Aw5ywpfwVYuCFNXQo0kgeEMhSFTs0PcAF6n49QejFlRwrzlV
 MHUWv2OGDw5zc84/CXqV4VasNrUSFYXW2ohtPgYh2nD6cCCn+kOLd3FYhAeJZcmhq7sT
 /tuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703240890; x=1703845690;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bNQSf35Uj0jVMffITW9x0jZR5ohcxhRLq/4/n0zt/DM=;
 b=H9DRMepKDQKHoWTmfxfaN/ASw3ldipmVnEcAAbXUKUChTc7rM3A/4U4hVtAat5sYpt
 dctGhcfPHUTGBRFi6HskLBBT8odcdBGxX5jNt8ji2kA+Avj1r/lo9WxT/EgFylZP0wYe
 T7ArnWXoKv63gK/PoRxifOomCjCDnTi2kGa385luvZ4xmu4ThYGE9wRxalNWj3djb8VZ
 UIpwSwy0WgkTVHosIeAv8+duupvmLD1ylqx017X/gHAMjKcaHxgX/eL6xylj17k3lJIs
 mQ4rH83eFW/9iUazEXoPwK26wKQMk4z2OBRoi8vw/qkHgZdz+9VEf+CqCkNZwpgbxfy3
 W+6A==
X-Gm-Message-State: AOJu0YzvNtgieBYkQFzI2cXHoVW1mrfDB+Xw+5rCWpD3Sfl3mkVjleZ6
 a6h0RHc0SV9tri7ZxtdQ8UZ+gSpAO7ibOiyL4APyNxYfgx6mrA==
X-Google-Smtp-Source: AGHT+IHnyfu5MkdbT3AaFeM2Xu5iC0nst/uTImuDNSxUiV/mzPEuERpbeRE2zm1SALcL0QSNpn+oKdzJSNSnbJ4b+ck=
X-Received: by 2002:ac2:4156:0:b0:50e:364c:3087 with SMTP id
 c22-20020ac24156000000b0050e364c3087mr278214lfi.109.1703240890108; Fri, 22
 Dec 2023 02:28:10 -0800 (PST)
MIME-Version: 1.0
References: <20231222061208.3009970-1-sumit.garg@linaro.org>
 <20231222061208.3009970-7-sumit.garg@linaro.org>
In-Reply-To: <20231222061208.3009970-7-sumit.garg@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 22 Dec 2023 12:27:34 +0200
Message-ID: <CAC_iWj+JPDjGe1Tj=GFXFkXBjBo5DjKNrhKUZFnwONdeMsfN3Q@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] MAINTAINERS: Add myself as devicetree-rebasing
 maintainer
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
 maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de, 
 michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk, 
 peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de
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

On Fri, 22 Dec 2023 at 08:13, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
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

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
