Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 628CDEE49A5
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 23:16:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D043864B4;
	Wed, 23 Aug 2023 01:16:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hTyH/l0e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EC30864B1; Wed, 23 Aug 2023 01:16:28 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74744864A1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 01:16:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fee17aebc8so35809995e9.0
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 16:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692746185; x=1693350985;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k7SBkvAWjj1h4eAknTNy0oKLR7FCIOEpIOUxnH3+02w=;
 b=hTyH/l0ezI4pyUBcIPLn54OadGIQz/HFnNBR4ueI5H9rijDi5QK+Dbs6zhX4pYXrq/
 cr2vkmD2caI5F1NGBE8q8i4uEg3oSq8t+QOQH2cRMwupyY1+O00BSUg+NyM5zApQywPh
 YPsLyQD+JzifwNkynXPiuHby/4kjOGmXayqNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692746185; x=1693350985;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k7SBkvAWjj1h4eAknTNy0oKLR7FCIOEpIOUxnH3+02w=;
 b=EYjXnj7QHpP6Y1PT/rzyqRg1B8TfKWKm50mcO701wqzO/Hbokeh2oSumNN8OdW6kD3
 Sii8nLLub6ZrkjPa1Wq6TKpUQgVTB38xnfABwMPKFcKTFbt0Q945pslnzl74sE1OEzqJ
 6KJ3Hs5dm+fTZWvWRgzfciPWH3M13I3tl0FK9LvJOlyjWUwT8HJyZGsJSILwT7d6gZdH
 TzJ4fxQRKnORyh50xG/N3kB/u/Pri5MLyoaTy75d7ZsM1EO84eKsxzTfnr3liWN7+mtk
 Dz6SmQdSgP8Bc6Jr1tYhGkqVAW7aOgJtpaRnfTV+wu53vpbOmumjtkt/LgAsg6TCc6iA
 bnDQ==
X-Gm-Message-State: AOJu0YxMKuB3KmdxSc66Mqhd0zwLq89/cH21GCeWZcffLQO6tPMTpYJH
 exsRN8gHnQ7a2YgI10r8tIn1IkZGnGAP/s1sRnvGikfbKgkoRKlBVeQ=
X-Google-Smtp-Source: AGHT+IHgS1+Nrsf4zdQcApPQAu8ZdKzyYJXqqxsSiPVqjLXXzXSCwESRo2aRpHUl/ri1iZZb6FFOjSTgW1B8bnZoL/M=
X-Received: by 2002:adf:e4ce:0:b0:31c:6697:6947 with SMTP id
 v14-20020adfe4ce000000b0031c66976947mr1400295wrm.69.1692746184759; Tue, 22
 Aug 2023 16:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230822185359.366677-1-paul.barker.ct@bp.renesas.com>
 <20230822185359.366677-2-paul.barker.ct@bp.renesas.com>
In-Reply-To: <20230822185359.366677-2-paul.barker.ct@bp.renesas.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 22 Aug 2023 17:16:12 -0600
Message-ID: <CAPnjgZ0mzu5fduzi=L5zp9iDyAp-XQdZRkdhFmJ0wVtop6r_xA@mail.gmail.com>
Subject: Re: [PATCH 2/2] doc: Highlight the most relevant u-boot talks
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: u-boot@lists.denx.de
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

On Tue, 22 Aug 2023 at 12:54, Paul Barker <paul.barker.ct@bp.renesas.com> wrote:
>
> The list of u-boot talks on elinux.org is quite long, so let's highlight
> the talks which are likely most relevant for newcomers.
>
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> ---
>  doc/learn/talks.rst | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
