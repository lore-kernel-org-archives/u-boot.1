Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F13CDB479
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 15:28:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 287AC84704;
	Thu, 25 Jun 2026 17:28:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UrPf4OkW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 214D584979; Thu, 25 Jun 2026 17:28:26 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABDD08460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 17:28:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c106f737b5bso10916366b.1
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 08:28:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782401302; cv=none;
 d=google.com; s=arc-20260327;
 b=NKgYfzIm54dJG/Pepdoj2G9i0U8INlplZxSWI7jd6He3a9OtWPzKnBSsyGsQjpsFIU
 Hh6Qqf1LiuBO+MRCBOXt+EY6fAvtH8Dlzb50qQlZ1CPKC7EJicV7QVhdBR1DkHnrJ0CH
 3fmJBejcv88dLuAEG7x1ALkPRE8btPK0g4TGVVVmXGX17uQcsfe1bIuNuKPSU1wIWJrv
 H2zduSnt1urB+jd63fG5+Xr5iKzNEUpLTd7qItvvNDPTsirvgPvhd/DdRoumNWmftjfJ
 jEYWcc6fGp0AkE2AQ2Rv4t0YY3+6UAw0z7B+xJmGtIz39tKmhIXUCfW6yzDsV/QiOz5H
 pGgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KQOeV+2rJNZ6GO5P+5xTkNWHRpvlf13HoJ//dDH2Bw8=;
 fh=pqQDfe3LJMDmm+c9NDum1Jzf1ll4C62eeHhIID4fPOY=;
 b=imL45zID5+d5rmQZyMRSRTlBZtSBCoaelJQT6mIm9gaudFVaiDCOZER0g3p2pd2lfW
 bYHk1/1ivGAmVnBJLnzPKGGMKBCwu3XFOiVLbn9GWTbsIyUoCaudENDIaJyfbzD4yBdL
 YxPoD4RKLsJhRdPWYbRSU5UY4cHukPPTh9xpTLTRpS3mL8NdEkO8AycTPYBHLc3JW2qu
 Yg1j95clnq5miXmFOoovj572sH9Lu7oRTqf6+RJu6eMgkxgeUF2dXy3f8VAnIIaQuOpS
 dsKYJePanT3uJeosjYL7iOO14nsv+PgrIpqt0FkjtGPAA60SfRHUNgQOQhz0D6jaLG3j
 osxQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782401302; x=1783006102; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KQOeV+2rJNZ6GO5P+5xTkNWHRpvlf13HoJ//dDH2Bw8=;
 b=UrPf4OkWNBAhmi7bw3HuTWyey2jZXtl5W3q3/aXx9IUOS0h7PbRDPgk1gTnGwq7orT
 DB6Z8fmiR66hNE5iGzgX6oSXc/bWTWbt7weQuwG8AKtqHfLm9rGArB3362eMwmDMsRjc
 ieAg9EH0q3So5V9LxjJrRtVntlJmYKrvHVLy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782401302; x=1783006102;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KQOeV+2rJNZ6GO5P+5xTkNWHRpvlf13HoJ//dDH2Bw8=;
 b=odTBzWyAX6OemSlcG+C6aQld6g3LCjq4XRKqNODq0m4DXUmMj0KCSjxzvhdMP+Pxhw
 lEKRQpkr96El2+s7J08TXJkUcnrBqMEk0uPBGDTzF0aYOLSw4SkMWsjBVsefTL0FNeeD
 ha+FXW1F2GONwci23B+LS9PaFzSiZIGTxoQ4F6dtS8yc/Ql+6LInMKOwc6mVXSrDh6QG
 OrMoOGgjAQpNW35J13H+x35ihkAAQqSGAhOrPy1U11t13+dn7FGJzKBWi5enQejC162F
 qDHj6Im5sSh117WlL1jU1WXAyMln6N40mdJPZLO5eevGcFgB0m+nNl3oTKC5mJvpTJyq
 0V9A==
X-Gm-Message-State: AOJu0YwwYDTuSzbhBWopA5mga4fc0yJoGdiq2C0BFppYeivdqddDjiqT
 ZaPF+lu0Q/w8ifQCya6EmtDtRitXdcJyonoEX5IJCA79HQcECzkzJywlyMDXw5tHElup3tsfkWN
 a2YW3Nhf3MZ8tgFmSRcwXpRbSxVCl9aNgMQXVhdmh
X-Gm-Gg: AfdE7ck25B148W0h0pucUAwSGA1iDsthwCXImltdDJIO7dNGOnG9SSdkoaYanyx2Aq0
 dpcG6EuKxpMmszkoDoJRQpQo2SqkUXndVH9XsfIiaWbT/jPVVdyMNMUXh14sQ1Fw7weF0zi4u5a
 t86Dz5b+wipbe+iAZZm8k9jqmlLoJJfEXxs7rgxOWmCnJ3j+ZAVJzJ9vYxlVYBzBzeMMcAsNSdP
 dz9wVffpnTGWrfPmyj7n38yODE6qZL/wZDpCjhLDyiyVvalyYywIi4jFsCxoOpeasCpAKol/EAI
 Kdn66yah
X-Received: by 2002:a17:907:9485:b0:c07:5ee3:cedf with SMTP id
 a640c23a62f3a-c1205f35027mr210179366b.38.1782401302208; Thu, 25 Jun 2026
 08:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260604-bls-v1-0-4ce6d1ee4711@flipper.net>
 <20260604-bls-v1-1-4ce6d1ee4711@flipper.net>
In-Reply-To: <20260604-bls-v1-1-4ce6d1ee4711@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jun 2026 16:28:10 +0100
X-Gm-Features: AVVi8CfbQi7JTJBHklOHc56SyK94JXqQ4gK734_8x0l8Y-_p2x4Ef_u4074Y6i4
Message-ID: <CAFLszTjk9=BywphX1BrZwR0UOC4V=-7PZzw1L2D6q-tqen0peQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] pxe_utils: fix W=1 kernel-doc warnings
To: alchark@flipper.net
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Simon Glass <sjg@chromium.org>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Martin Schwan <m.schwan@phytec.de>, Daniel Golle <daniel@makrotopia.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
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

On 2026-06-04T15:31:05, Alexey Charkov <alchark@flipper.net> wrote:
> pxe_utils: fix W=1 kernel-doc warnings
>
> Add the missing parameter and enum value descriptions reported by
> scripts/kernel-doc when building with W=1:
>
>   - get_relfile():           document @type
>   - get_pxelinux_path():     document @pxefile_addr_r
>   - enum lex_state:          document L_NORMAL, L_KEYWORD, L_SLITERAL
>   - get_token():             document @t and @state
>
> No functional change.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
> boot/pxe_utils.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
