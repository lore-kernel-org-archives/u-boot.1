Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4465C54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 12:25:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3232B87EFA;
	Wed, 20 Mar 2024 13:25:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="VlTBxlB2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A412687F64; Wed, 20 Mar 2024 13:25:42 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5662B87D83
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 13:25:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a468004667aso736224266b.2
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 05:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1710937540; x=1711542340;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yFwx3Wy4jBsRyZjtw88bTesVfcenCLvrrdoK2z/I6Bs=;
 b=VlTBxlB2GjbKrWxyEuiWLRWili9Nznr4ycSQmQoTOE19fMdLR9zzCvt5dj55O/hzLo
 SEdsgSAdnqWH6cusjBBv8qjVAxr940FZn4Nm2c0dF8gQklsHR71mIanjU0M4WUW+PxYR
 HSOI7/AJ0Gem2UnjuBj8k6PWPUU0BjmNQCgCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710937540; x=1711542340;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yFwx3Wy4jBsRyZjtw88bTesVfcenCLvrrdoK2z/I6Bs=;
 b=P2czmKPdLLDLlSbnrrW5KrYOJe13HHkERe0w+jv65NV2sTR7/e9ufNjB0RlwWIh9Bj
 UtXV7lOfuBX+EOZgXhEmrXcJ+6N43jv92KJMkLga4M2wy+rrh+f830vFSsswgAiUlwPK
 pIq7WC/QsM5UwbNeT1Q9HrE7EnBLfpDYbay+HjkkAEKCd4nJSlPqBHgSgkO+6x9XvdGM
 4WkHvWSL7nkyc3Z24xQ8RhcazQbqib3p0H9Vx6dyLJQc7E9K2caPmBWvdqqWnzt7KxMY
 59m7r9NsMIzNXNZ4xcSUeeNJb7Mzzk4x35nndlrsGu2KvsgGh5X7tn2C2h0LGLZwdOq+
 WEhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUq4QR6ius7OZ/n8MvBKhmtD5CHPDAVajc4HGr7zjcjqoegLQl5TlOgozuN3zw1MxMVflVuhNVkpLPhBUL3POWdJetfcg==
X-Gm-Message-State: AOJu0YyvHfJKdlbL/hGPQobOwSZoz9CkrgySVVRpGm5pSwUtUeAo65pP
 u8S2mGaKOAs6YBMkb8N1O5AVNM0Mm4mStEz/hk90sE2Pvo6BOLAzlW9qeuue0F9Jru0oJ6SN9pH
 0H9ntbt3EA4K6A9NmhmTk8Y96YiA9DNXJiVx0mw==
X-Google-Smtp-Source: AGHT+IFgZIMqNsJkqrGG3M1+LdRENx5O0oZto7BxLBFqVAwaWLkbXT+nteE71oWPN3EVdJCVV+kM/SZD0zkQgX3lfSE=
X-Received: by 2002:a17:906:fc09:b0:a44:7209:4c93 with SMTP id
 ov9-20020a170906fc0900b00a4472094c93mr10843433ejb.32.1710937539771; Wed, 20
 Mar 2024 05:25:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240320090214.40465-1-ada@thorsis.com>
 <20240320090214.40465-6-ada@thorsis.com>
In-Reply-To: <20240320090214.40465-6-ada@thorsis.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 20 Mar 2024 13:25:28 +0100
Message-ID: <CAOf5uwk6EF6xcQtYnjemy=LKNtO8efeitM8yBxud09zB1-pzQg@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] mtd: nand: raw: atmel: Fix comment in timings
 preparation
To: Alexander Dahl <ada@thorsis.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>, 
 Eugen Hristev <eugen.hristev@collabora.com>,
 Mihai Sain <mihai.sain@microchip.com>, 
 Li Bin <bin.li@microchip.com>, u-boot@lists.denx.de
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

On Wed, Mar 20, 2024 at 10:02=E2=80=AFAM Alexander Dahl <ada@thorsis.com> w=
rote:
>
> Introduced with commit 6a8dfd57220d ("nand: atmel: Add DM based NAND
> driver") when driver was initially ported from Linux.  The context
> around this and especially the code itself suggests 'read' is meant
> instead of write.
>
> The fix is the same as accepted in Linux already with mainline Linux
> kernel commit 1c60e027ffde ("mtd: nand: raw: atmel: Fix comment in
> timings preparation").
>
> Link: https://lore.kernel.org/linux-mtd/20240307172835.3453880-1-miquel.r=
aynal@bootlin.com/T/#t
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> ---
>
> Notes:
>     v2:
>     - initial patch version (not present in v1)
>
>  drivers/mtd/nand/raw/atmel/nand-controller.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/n=
and/raw/atmel/nand-controller.c
> index 75da15c157b..bbafc88e44c 100644
> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
> @@ -1271,7 +1271,7 @@ static int atmel_smc_nand_prepare_smcconf(struct at=
mel_nand *nand,
>                 return ret;
>
>         /*
> -        * The write cycle timing is directly matching tWC, but is also
> +        * The read cycle timing is directly matching tRC, but is also
>          * dependent on the setup and hold timings we calculated earlier,
>          * which gives:
>          *
> --

Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>

> 2.39.2
>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
