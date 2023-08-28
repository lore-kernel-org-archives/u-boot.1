Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D517C71153
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 15:33:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08F34864C4;
	Mon, 28 Aug 2023 17:33:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.b="nhQ/YX74";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1BF7846B8; Mon, 28 Aug 2023 17:33:42 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E77E586526
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 17:33:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fe4cdb72b9so32834055e9.0
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 08:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1693236819; x=1693841619; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BzWnVF2yxYEcccSQHMj+HJoGKyfzKVcBYYs9UzS1ObA=;
 b=nhQ/YX74XqTgIhafrN3Kuw2wGs9er7VoStO1BpE4VbNe2LrvCkjtGcoF1xS13UVJhL
 p6lYNvyIni1wrP31sF8gr/1ooxkiQEDhsM1UPJxIeZMoG9ynZG5A+gACN2bKuC/euTo2
 8sgXzwMnOJODFyyY92BRYLzZqljCPwmoQuu0I9sGxXmImWeStqpa680gp7CcPsqWDhTg
 gZcjnknMZXGblaEfzTJ75iFrKDeX8N4OtR4AcgT6wwUMSRg7fEQyHBHG+w9voNvw7ZMb
 oZ/Ynnx2j8ynfB5dFnpv/5D4+VJ6YEcEf1DGEUIfl9npYJb0I5Dbv6xh3q8NACjLq3WL
 2BqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693236819; x=1693841619;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BzWnVF2yxYEcccSQHMj+HJoGKyfzKVcBYYs9UzS1ObA=;
 b=eKVBN+SRq9VtoG2t9AEirtbVH7veRTqGADsBzbwz4HLQBzosjX1hAJH9xe8d0+UELH
 PbELb+FSmKEmEOtQ51+4YPAT7U5VVQCriWbeG2VHlAxCjVPbvYgjsKo1DFjvqS7UnzP9
 q6G/8cXXDRZaK2bsm3E5WodzqrWVFFk93nvjrpZYiX/sEALY1k9AEya94XTfaG9Od8+U
 ipiClFFW41IeteDfbhoubyOSi8aD4mhz6Ptkty4Lro/icVxk4WqbPswLWKDlqdIfhchJ
 sDxzrSl5mPA3ltAvE7W1tr/E5vahkOU8cqNK3zguV/9+eWo7U5JOkcTtt7gOQ94qIiq+
 tNIg==
X-Gm-Message-State: AOJu0YwoEqg9cxhl8XZymKdyiiJRenRImWl12KUEc79VgQQAmyVVFT4x
 4Z40tCKZ99QUWLRLy48w4KwKTw==
X-Google-Smtp-Source: AGHT+IHTooo/LWaenc8HagneQ5Ps6YBw1L9fhXgV5V6GOEAqoPa57i4HHuwZSpRD/PM/2W9FZZaiPA==
X-Received: by 2002:a1c:7407:0:b0:401:c338:ab96 with SMTP id
 p7-20020a1c7407000000b00401c338ab96mr4031847wmc.34.1693236819384; 
 Mon, 28 Aug 2023 08:33:39 -0700 (PDT)
Received: from localhost ([2a01:cb19:8704:be00:4f55:bd9d:611a:6c8e])
 by smtp.gmail.com with ESMTPSA id
 f12-20020adff44c000000b00319779ee691sm10899617wrp.28.2023.08.28.08.33.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 08:33:39 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Neha Francis <n-francis@ti.com>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@google.com>
Cc: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Jan
 Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V6 11/20] board: ti: am62x: am62x.env: Use default findfdt
In-Reply-To: <20230825180305.69515-12-nm@ti.com>
References: <20230825180305.69515-1-nm@ti.com>
 <20230825180305.69515-12-nm@ti.com>
Date: Mon, 28 Aug 2023 17:33:38 +0200
Message-ID: <87y1hvuqp9.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

On ven., ao=C3=BBt 25, 2023 at 13:02, Nishanth Menon <nm@ti.com> wrote:

> Use the default findfdt using CONFIG_DEFAULT_DEVICE_TREE
>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> No change that picking up Review, tested by and using new include file.
>
> V5: https://lore.kernel.org/r/20230824031101.3460411-10-nm@ti.com
>  board/ti/am62x/am62x.env | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/board/ti/am62x/am62x.env b/board/ti/am62x/am62x.env
> index 1ef948df83d7..3b79ae1b3f0d 100644
> --- a/board/ti/am62x/am62x.env
> +++ b/board/ti/am62x/am62x.env
> @@ -1,10 +1,7 @@
>  #include <env/ti/ti_common.env>
> +#include <env/ti/default_findfdt.env>
>  #include <env/ti/mmc.env>
>=20=20
> -default_device_tree=3Dti/k3-am625-sk.dtb
> -findfdt=3D
> -	setenv name_fdt ${default_device_tree};
> -	setenv fdtfile ${name_fdt}
>  name_kern=3DImage
>  console=3DttyS2,115200n8
>  args_all=3Dsetenv optargs ${optargs} earlycon=3Dns16550a,mmio32,0x028000=
00
> --=20
> 2.40.0
