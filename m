Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C25CC36018
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 11:32:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78EF8820AA;
	Tue,  1 Apr 2025 13:32:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CgcrKMlb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B5AC820B0; Tue,  1 Apr 2025 13:32:38 +0200 (CEST)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F06EF8209F
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 13:32:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e63a159525bso3838063276.2
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 04:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743507154; x=1744111954; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rcIgWxuOR9KxJvlIq2xOttyInmVamZIJH6BuqX5650A=;
 b=CgcrKMlbq6GTNYWJUf3GzNV+sNWzpzh+cfGF8SwpNLAejci+575I1b6WH11XvZKTDR
 HpYWdf33I7BGfB+5LVfeSsYazR3zn/e/3YNm+Latysq5RoA1I96FFcwRHCdZ9O8Fc9/L
 0q93hGXzlBqUcCEiEfl8M6hYzaOGiCH1WWiz+SNel1YAP52vEy/lhUOd/w8xzMlHoV4d
 NwZJu+FXpVpa1o87H8tg2qpAunYCzJ/aCi0wPf5d92DcWgO4AjIXX7KzewWNPKrNugYS
 uCCBQF32CdC019y52qsRnelTmuvzYBzeWctLDpeTUEtRHZJgHnCoiIS0w3UDxgnoNSJ6
 tFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743507154; x=1744111954;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rcIgWxuOR9KxJvlIq2xOttyInmVamZIJH6BuqX5650A=;
 b=PAIkAjX1vQpPrtN/UQuXJIzvjIQjqShsQ0CcU5mKrqBijbiv7eqt3Yeqb8tnaIu5iK
 BUZ+ZBlHf4EVuRhwEZBqQxB4GckFLV0sxCM+jAp76UXvtE8PiiuhJA8pY7EoLyF9oN02
 UUGSFqE8Jhs2+Sj2AGUnwcvzkeRTQYXQseVKj/FeOYUfATvjQ8xSaUroYgA88jWRKY/M
 69kuXs+Zm9dgvZbRnTQjU4h1RyGKvQTT3YGY1slV9ir3kmQD1j3VETgmnOBd8AjZiCvR
 deNm8E1sahzHmPYlnpNq2kxLVW6HnUXYGnnNFucWrJGowFw01KB4n3obZUnNKpPG81nc
 C5Tg==
X-Gm-Message-State: AOJu0YzB/obYH9U4WXl/bZQ7x2P5ouOF0ea0oycTfqP+ZtpItaFAY1ek
 6yAiaxJLn7oLg3U/7Wx2YGQw0Pgj3ogcx4TYmaSiWD4727Zu/gCHSwSDvECSyqGX1CGO0/9GCmF
 pZtV/9kVhA6XxAEgzZ8wqiBZjmg3qLtSWWVM/2g==
X-Gm-Gg: ASbGncu3s6/4TiLoo9hMLvaDqN2vaGfGA4WzTjcB8jeLkSOs5audGoq81ZxOlao5ogP
 QW5OyLSbKshpcOLHmoYBXjFsu659c69WRPF322EzlIIIMRnrY1tD/y804/joNFti4jnMtkZzCxG
 zbrlqDG1lAgsAA07zNCNANoPLH
X-Google-Smtp-Source: AGHT+IEqIv4gJmPUYYfkO9OSR396Dl25QsQmq7Hj25rUA0Y14Zb4ueXPi2L71xrwJbl7DeOfmVfORVf/KmYUxMgjZKg=
X-Received: by 2002:a05:6902:114f:b0:e65:91f5:d455 with SMTP id
 3f1490d57ef6-e6b83ab9ca4mr14089109276.48.1743507154667; Tue, 01 Apr 2025
 04:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250401111500.3422368-1-vincent.stehle@arm.com>
In-Reply-To: <20250401111500.3422368-1-vincent.stehle@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 1 Apr 2025 14:31:58 +0300
X-Gm-Features: AQ5f1Jo6o7deDVR_G2M7TawDmffd4ZB9N_QUqhoVF1yEeeX1R_8BKqdhUiv4Hxc
Message-ID: <CAC_iWjJkErbMM+O1njoQzmaCybm-+eBMs7fq_dV1eg5EUEF71A@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: handle malloc() errors
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, 1 Apr 2025 at 14:15, Vincent Stehl=C3=A9 <vincent.stehle@arm.com> w=
rote:
>
> The new_packagelist() function of the HII Protocols implementation is
> calling malloc() without checking its return code; fix this.
>
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>  lib/efi_loader/efi_hii.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/lib/efi_loader/efi_hii.c b/lib/efi_loader/efi_hii.c
> index 44235970a7c..330d7c5830b 100644
> --- a/lib/efi_loader/efi_hii.c
> +++ b/lib/efi_loader/efi_hii.c
> @@ -343,6 +343,9 @@ static struct efi_hii_packagelist *new_packagelist(vo=
id)
>         struct efi_hii_packagelist *hii;
>
>         hii =3D malloc(sizeof(*hii));
> +       if (!hii)
> +               return NULL;
> +
>         list_add_tail(&hii->link, &efi_package_lists);
>         hii->max_string_id =3D 0;
>         INIT_LIST_HEAD(&hii->string_tables);
> --
> 2.47.2
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
