Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C240E77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 06:51:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0F9C88DFE;
	Sun,  8 Dec 2024 07:51:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZHY5Dlwz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D7FB88DF4; Sun,  8 Dec 2024 07:51:38 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9BA388DFE
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 07:51:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-6ef7640e484so36588127b3.3
 for <u-boot@lists.denx.de>; Sat, 07 Dec 2024 22:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733640694; x=1734245494; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eyFqjAR9lEFUAFDoGKTkCEysfdv5dVAuFqiMbMRoK6c=;
 b=ZHY5Dlwz8QnpO8iWbV4z90pghJC+kLH1BumQWc/DU+ebuUMEXYaSSbWM1i9y+RDf0f
 gnyK8QUWwcUwc5AxLbmLDalal0B+d4nbPQu1/bghvt9rEmAGmfTSV/yLseCius72tSK2
 Wkkp1DyZ73mbSVj0wpCMfQsk5iRKjGx/TUTnEXoZLhUZtgzHCHXrrbg9Y+lJk287Zqpb
 Ucoy+5cKj8XNsnYlWdXxsLjlqrPwwtES0AJu289b8hGWsnW37inRogMl/WRb5rkrptng
 8rruTNWLI5pGCPJu8eCnp5Pml3ArjNzhlf/N75nS2Su1LPAlx5sAI4gWitoKf+Lyv4Es
 UfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733640694; x=1734245494;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eyFqjAR9lEFUAFDoGKTkCEysfdv5dVAuFqiMbMRoK6c=;
 b=hbrpB/Y3dKocxUIOwxkpyHzdAU2IeMl20uhh3lgmE6Lm3ZCaDNdeJVThLIKL0eo2so
 +7pZhdGl1Fv2SW7jGHjSvpOQSjzXWbrBv9SS/KPXeJjVtomNZeKNMihXPHbzgf1AltJW
 Nh++BAin5GsY+fdYRP1CchFs/vFE070uHcNEn5uOiILyU85aakXuzex95hMbo/pVsXTd
 ypOx/6QTkSDK1DrWPIMgCnbnsRlNehuWv9BNYkwre5cEBwSJMW55DS8Nfst3irVvNYPX
 DhSQH9+wZ2Av302fFIFvhTUfeiTdcr2S1LP9XjYSOTErNAXWnQuqqmaTI49VRuXnbs9Y
 96/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZGrYtK3Ub9zApY7ndbQuTkuCVXcQ/Jfw1K+AGrDHq9qI+v8SlgLW5QqbckUm+IjabcbqOrb4=@lists.denx.de
X-Gm-Message-State: AOJu0YyNClLRTH1ryvucbTvoT/+yHD3GymO/opN03FAP60wee/7SRbt7
 JfWRu/drD0AmstAmlrNPJzb1gwJVxKSLioDZi+8UGHGoR4ZXS8E7F6AbO/5919ysrS+p+wSg+yc
 qAT7aHsqM6bHMid9pQn9WSdoQCkhtYzVlStK+VQ==
X-Gm-Gg: ASbGnctN6vx6FhjFA+l0wB+S1TcYdlxNBqnBlUBjOylOmYOmvtllmagd1DSFr1MFOgE
 S9XvzKQ3/6G4izW8eNtaGTIEdCSWhySU=
X-Google-Smtp-Source: AGHT+IGnrcQAZkBjVmJB3KZyzfYcKGPiXam6iLUI+4WwhMPNSLLIRq7bo3RoETABZbeEtF4OJ+ixOhMHUz2otg49i2E=
X-Received: by 2002:a05:690c:6a07:b0:6ef:4696:f1cc with SMTP id
 00721157ae682-6efe3c0da35mr81697927b3.22.1733640694657; Sat, 07 Dec 2024
 22:51:34 -0800 (PST)
MIME-Version: 1.0
References: <20241208002121.31887-1-semen.protsenko@linaro.org>
 <20241208002121.31887-4-semen.protsenko@linaro.org>
In-Reply-To: <20241208002121.31887-4-semen.protsenko@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 8 Dec 2024 08:50:58 +0200
Message-ID: <CAC_iWj+WpMSTHTwVdqZac_Ko9hx3X0RvyB12zcCktXM9SFe4+Q@mail.gmail.com>
Subject: Re: [PATCH 3/6] lmb: Make const flag_str[] in lmb_print_region_flags()
 more const
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
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

On Sun, 8 Dec 2024 at 02:21, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> flag_str[] is a pointer to const. Make it also a const pointer. Improve
> a style a bit while a it, to make this line fit 80 characters limit.
>
> No functional change.
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  lib/lmb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/lmb.c b/lib/lmb.c
> index ce0dc49345fb..1642ce48bbbd 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -482,7 +482,8 @@ static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size, u8 op,
>
>  static void lmb_print_region_flags(enum lmb_flags flags)
>  {
> -       const char *flag_str[] = { "none", "no-map", "no-overwrite", "no-notify" };
> +       const char * const flag_str[] = { "none", "no-map", "no-overwrite",
> +                                         "no-notify" };
>         unsigned int pflags = flags &
>                               (LMB_NOMAP | LMB_NOOVERWRITE | LMB_NONOTIFY);
>
> --
> 2.39.5
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
