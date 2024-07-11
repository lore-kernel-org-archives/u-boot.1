Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 646A1C3DA41
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 03:34:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E72588626;
	Thu, 11 Jul 2024 05:34:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PBBRWz+y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A68FE88703; Thu, 11 Jul 2024 05:33:59 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C353488606
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 05:33:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-58c947a6692so566948a12.0
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 20:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720668837; x=1721273637; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8mBpAWKCbLhblfEAFuwpj5MXiMPJCDmQjFH7slg5nPA=;
 b=PBBRWz+yruoEUz6n3kbOQ6bHe3IOfPpand9KZgKUOmTJGvV8wHxvCryu4Tkh5Jy6xk
 UuksfzOXNaVbF2biicIqOXj2lZ9AsRpvqkp0QXqN8BbQ36mNM05xuwzj0WbqJEOpwNFn
 +VdrEkqZ0+K0xcpmIehryqI22TJ00Y11/LJAY56QgXDcr2dm3n2YiJYeflcmoGDeOXpp
 THXQYXqEEcu3wvFBv8malvhfxasKoWKp9zfIUTzqvzkofrLNev3XvHHOK0CdHCUaU5Vm
 FOMmuCUmukitPp9H0v17ZeCCHXQkSIh8lQU6mOjZhviUjpnqX3Zq1VM6g60BtefyluHS
 wfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720668837; x=1721273637;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8mBpAWKCbLhblfEAFuwpj5MXiMPJCDmQjFH7slg5nPA=;
 b=wP8IFdt8j4QFoHwU1bfmbwD824TcNpb3YkOqIK6mXzD56oiMo/QPTgH1TG44661++b
 SX4hJN6BKdrPCYHV87R99VNbNq6bwSsXQbVhaRtQ4f+vj8iAPhKqSfXV9T1DxNl2twVV
 gTQ/Oa7V2dgbk+g2zyZBCeNwFQf9FKv1XhiVsInEhp5jNt/UiNf4z4lHmk8goD169VHG
 Pq1zy+5G1oNd53aZWA0J8M55Cx86LgAiBDn3KW5B0iy/sz/tuW/fhZEgq6Wh9A1Y9pZq
 yq5fHYe11m4x6W18bNkOBaRLV4BAjzKgS2rbNa/aUlql/cnFUlMkwnUm85JHI9dD4Z68
 SdkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVU/n+56egpcVHjYxRWlBS/4zpo2V5c0AzbIt3Olftq+1mHXr9RaaPaQbXgFN5CHtGG2+kROAaibkK5OEjCC6ckcsY6uw==
X-Gm-Message-State: AOJu0YyqUtrpzrcSJEfC6d6N+VkTFPClB8/Ht+j5QZvwITBmH9dl6bRt
 LS0vPwZMST2L+HVfOBWXklMYnMnR9HPIqmNc/04c7j7ho++m4Q37APrWPgQdE8tFs4sAKNzM+Nn
 pcyXYVkykXtZb5/V2TpIU4t1nprM=
X-Google-Smtp-Source: AGHT+IHHUqNw12g8xClDWF6CYmnBIvYJMKWBAO/NtIx50A8gZQA34KrYip2SkBuoXm0oR4JJnMB3jfToRtLlyUTnMpg=
X-Received: by 2002:aa7:c384:0:b0:57c:5874:4f74 with SMTP id
 4fb4d7f45d1cf-594bb869f32mr3909465a12.28.1720668836333; Wed, 10 Jul 2024
 20:33:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240709162309.1531981-1-leo.yan@arm.com>
In-Reply-To: <20240709162309.1531981-1-leo.yan@arm.com>
From: Weizhao Ouyang <o451686892@gmail.com>
Date: Thu, 11 Jul 2024 11:33:45 +0800
Message-ID: <CAHk0HosoO4FXXuH3Fke8FHDoOQC=GV7QUi+pRjCH8EKNOcxURg@mail.gmail.com>
Subject: Re: [PATCH] driver: rng: Do not check ARM_SMCCC_TRNG_VERSION
To: Leo Yan <leo.yan@arm.com>
Cc: Etienne Carriere <etienne.carriere@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

On Wed, Jul 10, 2024 at 12:23=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> As described in the document SMC Calling Convention (ARM DEN 0028 1.5 F),
> section 7 "Arm Architecture Calls", the SMC call SMCCC_ARCH_FEATURES is
> not expected to support the function ID ARM_SMCCC_TRNG_VERSION. Trusted
> Firmware-A follows up the specification in its implementation.
>
> This commit removes the invocation to avoid the failure - which is a
> wrong calling in U-boot. The later code invokes ARM_SMCCC_TRNG_VERSION
> for retrieving the TRNG version, except it can read back the version
> number, it also can be used to detect whether the TRNG is supported or
> not.

LGTM.
Reviewed-by: Weizhao Ouyang <o451686892@gmail.com>

BR,
Weizhao

>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  drivers/rng/smccc_trng.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/rng/smccc_trng.c b/drivers/rng/smccc_trng.c
> index f59b80666b..1da1affd8e 100644
> --- a/drivers/rng/smccc_trng.c
> +++ b/drivers/rng/smccc_trng.c
> @@ -135,10 +135,6 @@ static bool smccc_trng_is_supported(void (*invoke_fn=
)(unsigned long a0, unsigned
>  {
>         struct arm_smccc_res res;
>
> -       (*invoke_fn)(ARM_SMCCC_ARCH_FEATURES, ARM_SMCCC_TRNG_VERSION, 0, =
0, 0, 0, 0, 0, &res);
> -       if (res.a0 =3D=3D ARM_SMCCC_RET_NOT_SUPPORTED)
> -               return false;
> -
>         (*invoke_fn)(ARM_SMCCC_TRNG_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
>         if (res.a0 & BIT(31))
>                 return false;
> --
> 2.34.1
>
