Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92683C54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 21:19:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0312880BE;
	Wed, 20 Mar 2024 22:19:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OguD05o0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31433880D8; Wed, 20 Mar 2024 22:19:19 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3628788076
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 22:19:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-512b3b04995so253698e87.3
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 14:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710969556; x=1711574356; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=D5/Wg2ILySyylV+vFMus6jOH2wXGFX/eTs7Oslw6N8w=;
 b=OguD05o0iQ9U8noIcAEI9TwRvtuKgw20TMyInibeq6WOkFw2CdJvlhRNgh+9IwVpbz
 51gXV5jveuObXaOHe8Jz3N/WyOA4QZOrmcDJP1Tmkkkckcz5ihpArrM36d+IWB0WaCF0
 1D3Q8FObzk9taUgTDC7BtqS9ravsWK0nyVTUcCbZvCsPIQZWHZ0ATJGkTzyP6dzMEO/+
 /oRXAPAGGeZEc7OrwavdH62GMvH3KVIQBc0rD0NgVsbxbtIOd2JBL5N5v/jTW5deFIeD
 zv/4y++JdKQCWolxlX7b1MAeK+40vhzXQ1LMUbjZYgFmFRh7levAoiI6i5AfK++PNom9
 1A4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710969556; x=1711574356;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D5/Wg2ILySyylV+vFMus6jOH2wXGFX/eTs7Oslw6N8w=;
 b=lMRafxqnc2fDajiw87mm+S+Meog0VtNpdLMWoQwfi/r3KkauX9QttA3KTpw6GPZJ62
 uJiw9o3cmYcPgUgPW72vgt4/oQzWBCF1c5JTtqCw2YqUipOFDTP7a7ZBZjCGSIq+zara
 XhKoF/Suz2RQqSLLGPqs3E5RKbmiRuihhK4FTRFBfFz6q4ao9fzDj73ahomj4+NKV3Mb
 Rxoch/Ye8y92yGZXXgQTL9mWQZoH1ustzNbkEIejmduji1cQ4DrijJ043Q6G8vhpNKdO
 +5sylMPsBbH0eq761Rq6Jv2vlLCmxSWMOC1H0kkJ1Tc7fEuqYA6Q9jX3pnM8sfsJH3XO
 6ZTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUvNuA+9l214rR+XfyWrAz8+yMUUqgcHPoFJDAOlRkb8pD7lqVvvgK2tTplrV3kh5LngTwcYih29xFiZuos+iFMG/AMg==
X-Gm-Message-State: AOJu0Ywe0PX7dUqsBr0YbwTTV2wTUbEePvcIihpSGHMBBPbC5w1P31mY
 eemRQAnblT20/V1wRcWHsRlvJqP1UzCLGtTHeC1zOOnejBi7O49+5rniECGb39wP2/rMImjlV3C
 8O9DC1Hyha0IbncXALOQkN4kiGB6uPcEYn/sAJKenzGnZRarxHj8=
X-Google-Smtp-Source: AGHT+IGi29BHpPvxBUI3dRcyfBId/Ljk5WVihmyIS5sn50woiu2rlg+slZc4MxrR7rrD3jTbw6K1IldPDsNIfyXMm2E=
X-Received: by 2002:a05:651c:39e:b0:2d2:b146:d42b with SMTP id
 e30-20020a05651c039e00b002d2b146d42bmr1993238ljp.52.1710969556660; Wed, 20
 Mar 2024 14:19:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240316093644.54869-1-heinrich.schuchardt@canonical.com>
 <20240316093644.54869-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240316093644.54869-4-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 20 Mar 2024 23:18:40 +0200
Message-ID: <CAC_iWjLFw5jF3_GEKF4Yhp4mkfi==VF7B8jG2eZn5RFN6i26AQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] cmd: bootefi: error handling bootefi selftest
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, u-boot@lists.denx.de
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

On Sat, 16 Mar 2024 at 11:37, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> If bootefi selftest is executed and a problem with the device-tree
> installation occurs, efi_install_fdt() writes sensible error messages.
> It never returns EFI_INVALID_PARAMETER. It neither makes sense to check
> for EFI_INVALID_PARAMETER nor to show the usage help for the bootefi
> command in this case.
>
> Fixes: 296faf4f7ef1 ("cmd: bootefi: re-organize do_bootefi()")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/bootefi.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/cmd/bootefi.c b/cmd/bootefi.c
> index b509440cde0..578dbb19a7e 100644
> --- a/cmd/bootefi.c
> +++ b/cmd/bootefi.c
> @@ -171,9 +171,7 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
>                 }
>
>                 ret = efi_install_fdt(fdt);
> -               if (ret == EFI_INVALID_PARAMETER)
> -                       return CMD_RET_USAGE;
> -               else if (ret != EFI_SUCCESS)
> +               if (ret != EFI_SUCCESS)
>                         return CMD_RET_FAILURE;
>
>                 return do_efi_selftest();
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
