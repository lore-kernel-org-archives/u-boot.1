Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8BBCCD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 15:27:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66A0A848BB;
	Mon, 25 May 2026 17:27:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SN/2k3Fg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4875848C6; Mon, 25 May 2026 17:27:48 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B70C484859
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 17:27:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-bd8f9889a8cso1112600666b.1
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:27:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779722866; cv=none;
 d=google.com; s=arc-20240605;
 b=BiFaqpMzyK3x22GdLnOKwJaZNGcOcM0PZMaoEaA+lzfKBk2KRjJ9KTzOekOR/PwTq8
 8+bfS+096rS6nAtjr9yPIurA+fFY845PWWbqCAjllM9GGf5pdoRa9qbwvRbuMoSQycP3
 hY99H58kN8WoauwG66d9YgFEp9vhmWlm0lpxEs71nGBh3YkpDISQn1L7M3EcPQ+uBkZm
 vKVxephzyfE5PR375DZg1mgvgmrS8J8JrxjV6JzrXdzuHo88FEff62yKkIRP0WMkQttB
 94Hm/+PA4ceOatmKzMoW7uSUkrKtlKnmPgKEn5zToG71QhtXvPFHXi/nzZGgItV9+xdJ
 SgWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Fisb6XgN7FGX6kX8ZMpSA+bJdNtnXUDZpU7MdvV+krA=;
 fh=uHnctjfjo81NP+4b9H5aVwcI8F1nm2RvYATNLKEK624=;
 b=gw6nzQeb74RCTbjYpgQgti/rRm1QffPAcaFZJ/bgLHCK5T0CB2/lraY6Iq53GvoDoN
 Fl0VsfWdu+LpgvsfAHtucVMQoGQeiFeF1ayw9YYa1IJkwbi4l/AcJuCDGkB3VtcvmY7q
 1A+GSQ1V71++eae4FX3OlWgziL+ZR26nNM5Pmcy9Bdtq/7FC/OEy8wwHMug6rffVau/f
 rKyLZNJPTWKZQ20ZB/IwUKt9mqe6RHiwtiv1lOiTtcThh5+tb2UBmn5Ym251O2i6eRCO
 MFBQYbYJ4N56iFq8+pwerjcBeTY+RLBMrFd6txAIr1KYR8vLmFmNG9D8zAoY9jQ2YOp3
 XQzA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779722866; x=1780327666; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Fisb6XgN7FGX6kX8ZMpSA+bJdNtnXUDZpU7MdvV+krA=;
 b=SN/2k3Fgu+NdK7uCcoJQIarL4FCwxcGFDwEW8iz22U0+u8Dpj5Ejc2Figx41EZaxhJ
 h2MOmZNhZoGUCp+kZPl7ztUU/gb65Jf9VAlHP679LI272grBgpUSJAzJws9KS5z+WmGe
 f9Ib4t3DY3wIjStpufmNm6O/e89cwa53UfGeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779722866; x=1780327666;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fisb6XgN7FGX6kX8ZMpSA+bJdNtnXUDZpU7MdvV+krA=;
 b=Bk0tO882ryzNOGwlkd+NMIKiXI4lImKsMMz9xpk2erb8LnKTa+fZVF3582MKishxR2
 eswD+HdwLQk3gH2mwYbCgnYeV9idxO79kWK4VxBctuLSe7FHgtcXNUg5ya2FJ6ASGxs/
 +lxqMEC97NByPQP5Q4qoZlbIZ6p/naxkmOqwyPoD1GmcnD5vlnO27uKZ4E+J5vAwI46y
 x+c1fbAp5RZzZWd/bAJ2KYSU8fFrF8d+cezHqM7D5LUAbgxQcE4b+AnbRatNvonviNWh
 gpxszl6kWC79rTjaFJFuZjd2DI3ZLbNJIgt6n99wAI3KoBL25wdo47dzhU8qAAiwfeND
 blIQ==
X-Gm-Message-State: AOJu0YyAYQLsOxhBF8kqC7FwG7IxkheQBs+7CC6LnLa4Nw/r3RTcCN55
 6rktax0fB7c/GZHvLzHEffnZmeMQHVZpbuILW3JIKS9MFHtRKZO/d/KQqbZa+vPVWMfXLhv0LQj
 GLpEbpV7iYLyXrGTxDHnYqE1uKw9McegvAzURNyYc
X-Gm-Gg: Acq92OGgp5dPA6cHng9PN1O6g08B8iIS5XyGl8uB4n2xdm0yjzk+OOa+CpuT2+5QeRZ
 vBlVPZ6s9RZiY4ofETxFrZsA/9PVds0jLlBFhNM8sEV81tKD5gtjudIUUcrn+MSHnNdCSQgNxHr
 +PZK83vzp5NB7F3o44Jway7lzaXUE+QOriAtZrhMpU/s01KujY0C9Wzl6LDZLYe9eZcdscvB+B3
 j1gX15r0/QNoSIMpBMYj93gySDY+uWpn/HHdjju39vORYKQO0WYl/Ry8SzKrJchy3//meLtUJWS
 VPWpag==
X-Received: by 2002:a17:907:eb10:b0:be2:7f13:8e33 with SMTP id
 a640c23a62f3a-be27f1394f2mr29661866b.45.1779722866094; Mon, 25 May 2026
 08:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260519225458.5587-1-ravi@prevas.dk>
 <20260519225458.5587-2-ravi@prevas.dk>
In-Reply-To: <20260519225458.5587-2-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 May 2026 09:27:34 -0600
X-Gm-Features: AVHnY4LVGCLqrXNDTk4J7d4RMQQiSNzqcTtkFcBDNqRAGaE2Spq0WGww2lx1rpk
Message-ID: <CAFLszTijyoJ2H1kG+6T3wAccHyXFj+M+Mf1w13RU1kVc0Pweag@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] image-fit.c: introduce CONTROL_DTB_AS_FIT config
 knob
To: ravi@prevas.dk
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>
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

Hi Rasmus,

On 2026-05-19T22:54:57, Rasmus Villemoes <ravi@prevas.dk> wrote:
> image-fit.c: introduce CONTROL_DTB_AS_FIT config knob
>
> Having scripts embedded one way or the other in the U-Boot binary
> means they are automatically verified/trusted by whatever mechanism
> verifies U-Boot.
>
> Writing those scripts in the built-in environment leads to
> backslatitis and missing or wrong quoting and is generally not very
> readable or maintainable.
>
> Maintaining scripts in external files allows one
> to have both syntax highlighting and to some extent apply shellcheck
> on it (though U-Boot's shell is of course not quite POSIX sh, so some
> '#shellcheck disable' directives are needed). Getting those into the
> U-Boot binary is then a matter of having a suitable .dtsi file such as
>
> / {
>         images {
>                 default = 'boot';
>                 boot {
> [...]
>
> boot/Kconfig     | 9 +++++++++
>  boot/image-fit.c | 5 +++++
>  2 files changed, 14 insertions(+)

> diff --git a/boot/image-fit.c b/boot/image-fit.c
> @@ -1676,6 +1676,10 @@ int fit_check_format(const void *fit, ulong size)
>               return -ENOEXEC;
>       }
>
> +     /* For the control DTB to act as a FIT image, we only require an /images node. */
> +     if (CONFIG_IS_ENABLED(CONTROL_DTB_AS_FIT) && fit == gd_fdt_blob())
> +             goto check_images_node;
> +

I wonder if you could avoid the goto by using a bool? E.g.

   /* control DTB is trusted */
   bool as_control = CONFIG_IS_ENABLED(CONTROL_DTB_AS_FIT) &&
                     fit == gd_fdt_blob();

   if (!as_control && CONFIG_IS_ENABLED(FIT_FULL_CHECK)) {
           ...
   }
  ...

> diff --git a/boot/Kconfig b/boot/Kconfig
> @@ -103,6 +103,15 @@ config FIT_FULL_CHECK
> +config CONTROL_DTB_AS_FIT
> +     bool "Allow U-Boot's control DTB to act as FIT image"
> +     help
> +       Enable this to exempt U-Boot's control DTB from the sanity
> +       checks done to ensure FIT images are valid. This can for
> +       example be used to embed whole scripts in the control DTB,
> +       that can then be invoked using 'source ${fdtcontroladdr}'.
> +       See doc/develop/devicetree/control.rst for details.

Please note in the help that this is safe because the control DTB is
necessarily trusted (any verification covering U-Boot also covers it),
and that only the address matching gd->fdt_blob is exempted - not
arbitrary FIT loads.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
