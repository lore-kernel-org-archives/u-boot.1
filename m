Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F9F6CD37B5
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 06:50:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97688847C6;
	Mon, 11 May 2026 08:50:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GZ47TsWS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DBC0847C7; Mon, 11 May 2026 08:50:36 +0200 (CEST)
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com
 [IPv6:2607:f8b0:4864:20::b12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACE97846CA
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 08:50:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-65c5361142fso4040118d50.0
 for <u-boot@lists.denx.de>; Sun, 10 May 2026 23:50:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778482231; cv=none;
 d=google.com; s=arc-20240605;
 b=VDu/M0g+0EN/1+ptujDDQU3zKeQZqPeHaDrPBeKXssHuqxQi14i/0sAt2kdiw7hR3o
 3KTxHwFhTYqVDj3ofWXp+59UJRhckj0SXUeayI5UKUbODr15Jm98nsU0ht0eXNLJE60v
 yrsfw/keIkgqGQj5G09OLprR64BiZHDmqwXM3er3Qun4ue81FzRo0i7RE7Tdl+wTyKo+
 E8CtphhNnSB70qnjZWHEC6JTpuJEN8EJQ39By/Xv82y92oy1Ndu4/YikSPL/oxrQ5bbC
 8q2873nLVY+ko5GgNQtGB9kzHXonVOau7vHvgLU6KiY1Ku7MclQrYgISYlWQRpfCjYWY
 dZpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2+9Kbzy/dkO9RaUnH+mGCU30ewE14lXmrqHzjkozq1g=;
 fh=b+5EN9h6A+M/DgVUqcLmKil7t6jN5CZ0jSWPWs/QfEg=;
 b=R8GiAB3sJywzUXCDMTSmoIKY6TCjfL9f9xTcAoeZ/NNDAvDbAsitiJf7GtDxFUtTEY
 QFnH27kG0ZuwR/bjgIiI+CJ6pGcM7BVEnfS2/HbYSDsY2UOUOJALoNKG6r42woerXUCw
 FfU5hLQS1z+VPJyWDhyOSSGiBxEjP+dNgqTZpyHodC8MTzC/NHBc5X0oTP4ViHxA/T6o
 x/LvC8nb/NnepYtx6D8sMaxGUohTwUTUhrzwJbPvBMJFpl2aB+3BTX0wb+Kusu/R6Knh
 CHb0sxXXdLmvAJn+Y/NSJ++QwclCg8m5ULDqeErXIaaq867sK+wfL5h6jqwRkeVcDpr3
 0iBg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778482231; x=1779087031; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2+9Kbzy/dkO9RaUnH+mGCU30ewE14lXmrqHzjkozq1g=;
 b=GZ47TsWSPbG5CddlxHCkohHYtfs1Urc4iSE3YiMUsHHMVV06YZh5D/lGqbJL4xNs4L
 V/ABU+Vq9QNUISb3EhoxrvWtQcw35n6vvTZyUEjQA4fo4fRx0S9kV9QUR6YlS6AOhaCd
 uRqijQuIw+6vFcJYD+W7SgTHd/Gb6Tk01n8/FyZsHhR9N/hxJEvIVJQQqgG5OfPDv6Jl
 rCKrep2k9yomshDn59B1S5NtCSAO/+AYgYB+RBjzrT4ux+4OPopMs+qgAGHqTHFdJr3h
 7DyQ1onZ3eNERjIFYiseesVVqKh7WzXi1gVGUNumaPm2ogH43UR1KGBjigTlAPk8jrlZ
 f8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778482231; x=1779087031;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2+9Kbzy/dkO9RaUnH+mGCU30ewE14lXmrqHzjkozq1g=;
 b=evEjJ6O+Gtdke5TI04wq0+wA6oYTpTKOEIqIGCG7t9EKnom9asqOTpCnkCqdm4sIks
 pfI7wrCcU6+X0n6Pqz6SC0NKEBL4rtKANZnRe282fYAU40LMZaFWMnAPqcL86CA7GVPm
 xNdGxrJU3sHDBjxhNDaRoGQoHgoUiGm3g5dSv7lbrpUPW2ytQdGTKGnxxO/lvnz7jNIZ
 R54w8sjSCjjFPFP6w7XcD2sGnM7ujES0wo0HDhDo4uV+PX5nFqoLTukmd5UWigUorA0j
 1n9qOgUf7sP7au2VsgcPC8TaKbZ9rOMQydp1TeGr0Heasc9xpuAfdFdxDmLiOspg45i/
 S+tQ==
X-Gm-Message-State: AOJu0YwacZkGrYypx7T0pQwF92esUxG8KNJt1xBniQJWDLPuEEO5Aa2h
 qX29Eery8jBSxDWIsGmPDuHnz/MIWGgIc10FntZXMGTiWMO220IKVOkfIyYNjrL7IjBFN4f4dpu
 Wv2f32rYMVlzI9qTEyBJKcqFc17j+H6H5fNQkCcfChcTvnL0z9va7Wq8=
X-Gm-Gg: Acq92OFtSh/NNxhc196zxaWoyPnxxXKprEGt9hWihdRKyIY4EskxhU09oXaOQOD/c0m
 cIBQ1cpAeo8si5IECamfR5p3WEKo/C2VkobhGKIdDn9xll2e1ilFnxCSQjD5ygszqYgCgFoiU6P
 wm8HC8YjFwMXF/nLb18uypIqmpFNztY4y4l/u/lF4ub0RtIt5SoA/iipBBoHt+iUqeZnIqHep1W
 TbV3S2iGKay2Eb2+9JvMAYNnC5nT21uI4Dq/pirhw7eyyYUOXJMXWW/O7UnSUh28/FVwCbf+rdB
 gK/GuKkKVMr3CoTlwnKhxQhIyz4KO//B/UwnShyzbXXR1L3NqCAyZMjtcEVaSxnwk6EInfs4FXY
 8RlRhZpf3BRqAtVWKVEuleWfv0sPYcOWycwXNeO2+p3dT2U0zJmdm/u2dNcbGkgJZQlwgZujDf0
 0Vhraa0AuACgsIo/eFip0SC0yUEJ3Hx9lVckevRbjTJblQ58Ug4hX/z9t3GEVqeE6irkWiCRN/s
 93BBRfRk/zf4vcYUK7dhPhev7Cm/W00hS3hZ3nCO/YIla9YrWWgAutq4QocjL/j/uTyCI5qC4wb
 IdM39LQOBd3+T9CsmN2cbfgf1sTcDALLZxN8ccHiFVGf1mWrJSKZ930x0BQYctaujV4tQL7jyKL
 oWjwNNQ==
X-Received: by 2002:a05:690e:1c20:b0:65c:6ffb:303d with SMTP id
 956f58d0204a3-65da855d38emr7570548d50.62.1778482231433; Sun, 10 May 2026
 23:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260509203136.46745-1-kettenis@openbsd.org>
In-Reply-To: <20260509203136.46745-1-kettenis@openbsd.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 11 May 2026 09:49:55 +0300
X-Gm-Features: AVHnY4I_LjiopH3p1pu1jB5P5rw7KRp0jQRYO8HWbNA3xnrkexgIlzI4t_Md8VE
Message-ID: <CAC_iWjJaVHmeuVo_SKE75ZU+c96iVj-YU+br_TCT+w_6rxmXRA@mail.gmail.com>
Subject: Re: [PATCH] smbios: Do not fall back on devicetree without valid
 mapping
To: Mark Kettenis <kettenis@openbsd.org>
Cc: u-boot@lists.denx.de, Raymond Mao <raymondmaoca@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Janne Grunau <j@jannau.net>
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

Thanks Mark,

On Sat, 9 May 2026 at 23:31, Mark Kettenis <kettenis@openbsd.org> wrote:
>
> The smbios_get_val_si() function may get called for a sysinfo
> property for which there is no mapping to a devicetree property.
> Avoid a NULL pointer dereference in this case by skipping the
> read of the mapped property from the device tree.
>
> Fixes: 83b28b55d74f ("smbios: add support for dynamic generation of Type 9 system slot tables")
> Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  lib/smbios.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/smbios.c b/lib/smbios.c
> index d5f18c8bd69..906d2753517 100644
> --- a/lib/smbios.c
> +++ b/lib/smbios.c
> @@ -292,7 +292,7 @@ static int smbios_get_val_si(struct smbios_ctx * __maybe_unused ctx,
>
>         /* If the node is still missing, try with the mapping values */
>         nprop = convert_sysinfo_to_dt(ctx->subnode_name, prop);
> -       if (!ofnode_read_u32(ofnode_root(), nprop->dt_str, &val))
> +       if (nprop && !ofnode_read_u32(ofnode_root(), nprop->dt_str, &val))
>                 return val;
>  #endif
>         return val_def;
> --
> 2.53.0
>
