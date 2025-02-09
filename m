Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2693FC02199
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 14:29:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B66580A0A;
	Sun,  9 Feb 2025 15:29:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KLLZbXNk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EC0B80A35; Sun,  9 Feb 2025 15:29:27 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 044C780B98
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 15:29:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21c2f1b610dso87388215ad.0
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 06:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739111363; x=1739716163; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j75NKr1e/5JL48HBw6Yq7uPjxhcEIr1sTpSIoCRLVzk=;
 b=KLLZbXNkW2lNGiUs/wKtn9kmTebstTulCtw8C4D+kUE1Slu7f23IYRWyl56JHtcCuw
 5YWkQqyvwFZkYEA8m2FT8YhelZL2fU9wePl8vc3zGSHkhIF1a8k8a7QMI8zoE6fNLS2X
 FocHXNBl1WWsuP9yXYAEZlv9YVTI9P1rGsFW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739111363; x=1739716163;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j75NKr1e/5JL48HBw6Yq7uPjxhcEIr1sTpSIoCRLVzk=;
 b=p2hTwjpxV4J8+qMNA7cb/Anht+80x5dLcW+QiLYHRDtB3rzHAMEGTmaH7qMk/vuW9T
 u10EkHVO3uOBzJc1H2NgCCeBdwxCm/st26fZ6XadIPtCC6j9xfDbg+fcnGJm89R5gm0j
 O4bET3LAqbkEklXylJMfeinVaenHe1bgpc3+d5LC8yKVym+SKH35Edsf3KyCHYWKyi7r
 YCiuoeImxNZr3dOedADbAjSLbHfJ2CQCteU8wEDk/FhwkJn4iL5+vO2yOj0b/J+6twEF
 r4wjGFassTq+MI/Ip8vcjoeqMECdA6HmbaLlFNbb5hnm04BwLdVP0eznxaQpmsJoezdO
 bm8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUy/aZ3Iaqj5u+U094ellDVWgeprXa4xo2kxkaYRybHwvEHj1MkXzhRQkG5gjgSXPaa8xMEb8=@lists.denx.de
X-Gm-Message-State: AOJu0YymU0d71fzO6a7ytXmP2y7wUiiiyYOOL8sBMEl5qp4V9kVEdr6a
 fKrgH+ACZ7FtycXX45MO+/haueTu91XZTBt4aMZhwtzqDDX6ZEdplDlilwquo9yOdopn+UKuhtj
 QCWCzYg8gYFKwhToPz2rV1NwyPvdEuOUO92s6
X-Gm-Gg: ASbGncuHqF6Ug1amvwUkeeRKGwnhUdnJV2PdTjTZTo9tF/OKlc5r22kAZ5F4WCPPz9p
 wc5SS3XzVy68GxK1pfTSZtQjex9bMExBsIMiEPtfSMTDsVc2kC6wbHLT8GSLj8A+ZFFh0f7IyQQ
 ==
X-Google-Smtp-Source: AGHT+IF7g4k2bWIFx1FctWT+oI+rUOfRYP1c0r7ZQn6Qa2iFEC4lgJ3jfMWnq579nKBgzNCGCeow00oBC5yKtUONkaY=
X-Received: by 2002:a17:903:2309:b0:21f:3e2d:7d41 with SMTP id
 d9443c01a7336-21f4e6ce7b4mr173282745ad.11.1739111363516; Sun, 09 Feb 2025
 06:29:23 -0800 (PST)
MIME-Version: 1.0
References: <20250209115217.85250-1-heinrich.schuchardt@canonical.com>
 <20250209115217.85250-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250209115217.85250-2-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 9 Feb 2025 07:29:06 -0700
X-Gm-Features: AWEUYZn4mTOyOACcETZU6JjaiVPzmc4j2MsLeXT2c6bUr7Lgz6UXBp3fS9s0Yso
Message-ID: <CAFLszTirNaX-6KfMPJ1LNHe3iU_QzATy0s1dHnfKbUw22NCP-A@mail.gmail.com>
Subject: Re: [PATCH 1/2] boot: continue in fit_find_config_node()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Jean-Jacques Hiblot <jjhiblot@ti.com>, 
 "Franklin Cooper Jr ." <fcooper@ti.com>, u-boot@lists.denx.de
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

Hi Heinrich,

On Sun, 9 Feb 2025 at 04:52, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> If a single configuration node lacks a description, this does not rule out
> that another node with a description matches. Anyway we have the default
> configuration as a fallback.
>
> So continue if a description is missing.
>

That field is mandatory, so we should really fail if it is missing.

What problem are you trying to solve here?

Regards,
Simon

> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  boot/common_fit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/boot/common_fit.c b/boot/common_fit.c
> index a2f9b8d83c3..4c134e0e86f 100644
> --- a/boot/common_fit.c
> +++ b/boot/common_fit.c
> @@ -57,7 +57,7 @@ int fit_find_config_node(const void *fdt)
>                         printf("%s: Missing FDT description in DTB\n",
>                                __func__);
>  #endif
> -                       return -EINVAL;
> +                       continue;
>                 }
>
>                 if (dflt_conf_name) {
> --
> 2.47.1
>

[1] https://fitspec.osfw.foundation/#configuration-nodes
