Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C953C4828F
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 13:35:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9A5787E42;
	Thu,  8 Feb 2024 14:35:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SpD5me/K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C97B87E42; Thu,  8 Feb 2024 14:35:23 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0887D87E45
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 14:35:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5116063585aso2291364e87.1
 for <u-boot@lists.denx.de>; Thu, 08 Feb 2024 05:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707399320; x=1708004120;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dY3jIy2yJhCwYnrv8vCmAsgIB/YJ0iOn95mglAHZYQk=;
 b=SpD5me/KEfdnDD5CwqUiHH3SM53PKswgukBkx2cvVL5peZsKHgVmGUcOT5Wr/IQSar
 iKdzFqWRFaq6FEa5wa5RKDtx7Qp3wET1TdKKtuzt+D6PHVfcikFku9OdNRh+8MonCiVS
 8kDyc6r2mrKCLBK7VqDhrd+gzTOfXVAvhz/e7cxlZKP8UPPct4EelTe/OZ5EuirYtMVO
 bDosa11IC5JoiuM8dJCpQeeVfjQB66RM16osCUiatM+UAM7FA1v4eAnRWF/x+MSO4ooq
 UBppmPXm5cUX6GvjpCk60jHows1Wof7c1ENf83M4stpkeexsTgxOoFbfsHH/TvGi1t5L
 Zm+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707399320; x=1708004120;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dY3jIy2yJhCwYnrv8vCmAsgIB/YJ0iOn95mglAHZYQk=;
 b=QFKeXckGwDJhGup/5zvzJZYocf7adkakfQBAJrzX4KUu23SkC8GTucE0lfIRz8L7Dl
 95Fy5MYk5Z4pgqYNEIhz1JKZ4ocHM0hrn+bFt9i9wa7tqRzOmY2eYmh4jXaFg2isBGiR
 UZNnfFfWKRaEw5c4mW/637cM+xS73y6C0Fn9NMxgtFqnLZUtGQ0sAFwro8tGDeV+k0x6
 y3Rs3fjncxLMAMMTyImz0o0O/uBi6ddyiiCJVj7a7EXtsb5Pu7jLDYlERkeeRz8iw7b8
 PCUcKy8Sz+T35G2zi0oErckungnJGoZEI0916nozB48Dlo0BSjrrg0vuVE9gCdmJPZ3w
 VkKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJ+oZrUoiQ7+wHFbR9mHVqJ514PzI1yYLE12yUy0Y8X7btZPDkTsBWbEzELpXS5wp6FNcjmKUcdr6BhPNjsx6GfuNw3A==
X-Gm-Message-State: AOJu0YxUpgJf3nDebMYpr3295lasrBnB0Lk0uNQx0XMMqngKxmpq9aaJ
 VVtLuZFwk1mH9OmPeTVAA3zctAkw1Lfo5RuVmj/vGAKgivK6kMZsc3ZyEKgFrGs=
X-Google-Smtp-Source: AGHT+IF0up9kxpqRsnEvknSkHime5KWC2001vN5MmB0McWtimE0xXREnk88FUjl7g3tDxWKqCn4pZw==
X-Received: by 2002:ac2:4e92:0:b0:511:51ec:8684 with SMTP id
 o18-20020ac24e92000000b0051151ec8684mr6041331lfr.50.1707399320150; 
 Thu, 08 Feb 2024 05:35:20 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVyDik+SC9JqOhCQqvuiI558+QI878trks9Y9Bf7BEnxtxAJTQ56RhYnHjCWzmj5X03H+NxkXXqCyM0d0KUn6E6v3dEk+yBctjMqyJ3gyaL+N7M3h2+w9G3wQ/jeEvKC/5e8FGIlLFS/8+Hmvnq39PxGSc/2/WUhkQkr8599ei24+50m7nFPy+QflbkxuRY
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 l20-20020a05600c1d1400b004101543e843sm1685433wms.10.2024.02.08.05.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Feb 2024 05:35:19 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@foundries.io>, u-boot@lists.denx.de
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, Ivan Khoronzhuk
 <ivan.khoronzhuk@gmail.com>, Jens Wiklander <jens.wiklander@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v1 1/7] common: avb_verify: don't call mmc_switch_part
 for SD
In-Reply-To: <20240206223153.3060433-2-igor.opaniuk@foundries.io>
References: <20240206223153.3060433-1-igor.opaniuk@foundries.io>
 <20240206223153.3060433-2-igor.opaniuk@foundries.io>
Date: Thu, 08 Feb 2024 14:35:18 +0100
Message-ID: <87eddnjcyx.fsf@baylibre.com>
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

Hi Igor,

Thank you for the patch.

On mar., f=C3=A9vr. 06, 2024 at 23:31, Igor Opaniuk <igor.opaniuk@foundries=
.io> wrote:

> From: Igor Opaniuk <igor.opaniuk@gmail.com>
>
> mmc_switch_part() is used for switching between hw partitions
> on eMMC (boot0, boot1, user, rpmb).
> There is no need to do that for SD card.
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
>  common/avb_verify.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/common/avb_verify.c b/common/avb_verify.c
> index 48ba8db51e5..59f2c25e0de 100644
> --- a/common/avb_verify.c
> +++ b/common/avb_verify.c
> @@ -358,9 +358,11 @@ static struct mmc_part *get_partition(AvbOps *ops, c=
onst char *partition)
>  		goto err;
>  	}
>=20=20
> -	ret =3D mmc_switch_part(part->mmc, part_num);
> -	if (ret)
> -		goto err;
> +	if (IS_MMC(part->mmc)) {
> +		ret =3D mmc_switch_part(part->mmc, part_num);
> +		if (ret)
> +			goto err;
> +	}
>=20=20
>  	mmc_blk =3D mmc_get_blk_desc(part->mmc);
>  	if (!mmc_blk) {
> --=20
> 2.34.1
