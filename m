Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99EDC4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 15:14:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC7E0869F7;
	Tue,  5 Dec 2023 16:14:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FBNY0TCL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BF3486E42; Tue,  5 Dec 2023 16:14:53 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 346C6869F6
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 16:14:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-67acdcb3ccdso11152046d6.1
 for <u-boot@lists.denx.de>; Tue, 05 Dec 2023 07:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701789290; x=1702394090; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eA/tVCnFsygjwn9WA4Jnez9PPm5nrpD/FOocXsJB6js=;
 b=FBNY0TCL3dW61b3Ge8Gk6T0gWv/TlVmryPXkznVcUlW617rNrflgd1AFYdulNtgpzZ
 nsfP3CCmuMouBewL2C4OmgT2O/mEiRX+Lm9eMRIFWCMdDuT3OaaP+J04wgaYEQqS0qoA
 98ZUVBAr+II/IdnvUmPHiA9sCGX8lxeFXaig4VeiBwYgunvIp2yPAsPfm3Hxas/mYvfP
 5bAy+nN/GT3zfMHXEyZSUKQJzS2AAaYoOAo146UiVon0NDcq02ZYtRwhI/FM/rMWWI1b
 +EmnKhn4HdMLKYufAotEWtKvgxbkxcysK3XN+vzmeLhcXRhZKBOY6z7tshQLNrh0pHvM
 Rw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701789290; x=1702394090;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eA/tVCnFsygjwn9WA4Jnez9PPm5nrpD/FOocXsJB6js=;
 b=kFtIcTNEKQ6r2+iCsdZsSs/mWrOxbz3dvis2nCy1cs6OgUFY7cJ9MhkWprToR6LAkq
 NOIfpQJnXWjPlhtJu4fJ2XxlY6uckEO8/85oJYaalrhdBdKR1iL9M6HSLeosHRniSgMB
 ZT9MP4m64bMYCo+CTNxc/nSh34LhJDYA9WTefaQ0hcdmTXxofJkhl8m7BqDbunyg2/dv
 y7zr0Z4vZ8ZOB2I/WxLO6qCTrlHqK1kMkXlrZvhzhUbClun/1IK5FXcSXJkt27WfmT4h
 /lakbEt+692Lp22e58C2sTZ68N9uLY9gBJuL+/J6RKes2dzyU8JWG5ECPfIb9R6EDngS
 WE8w==
X-Gm-Message-State: AOJu0YyiXtNf+3VFzdKXe3RNoTT9yQ2+hx/rT/WsuuJDrW236R/AsF8I
 q4MO5+CSyOD/hpvXsIIjV+nA3FGSHKICcz+7USSCgmqehjtlO4Xx84Q=
X-Google-Smtp-Source: AGHT+IF5ZQ5YOFlH9UpQDy4D2rJhNFZvLPiNLSLORShSqTYMXa+80Qh5e+emhl5/388BTTyMLRuYdkdsmzps5U73PWQ=
X-Received: by 2002:a05:6214:5e81:b0:67a:c268:22db with SMTP id
 mm1-20020a0562145e8100b0067ac26822dbmr1517705qvb.40.1701789289939; Tue, 05
 Dec 2023 07:14:49 -0800 (PST)
MIME-Version: 1.0
References: <20231129123753.1906956-1-etienne.carriere@foss.st.com>
In-Reply-To: <20231129123753.1906956-1-etienne.carriere@foss.st.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Tue, 5 Dec 2023 16:14:38 +0100
Message-ID: <CAHUa44F=i2nz0VbuFhSY+wBzX7QrXUL5aaqeULnUrzVRHThQjw@mail.gmail.com>
Subject: Re: [PATCH 1/2] tee: optee: don't fail on services enumeration failure
To: Etienne Carriere <etienne.carriere@foss.st.com>
Cc: u-boot@lists.denx.de, Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
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

On Wed, Nov 29, 2023 at 1:37=E2=80=AFPM Etienne Carriere
<etienne.carriere@foss.st.com> wrote:
>
> Change optee probe function to only warn when service enumeration
> sequence fails instead of reporting an optee driver probe failure.
> Indeed U-Boot can still use OP-TEE even if some OP-TEE services are
> not discovered.
>
> Fixes: 94ccfb78a4d6 ("drivers: tee: optee: discover OP-TEE services")
> Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
> ---
>  drivers/tee/optee/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index 9a9b697e91..5308dd58ce 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -841,7 +841,7 @@ static int optee_probe(struct udevice *dev)
>         if (IS_ENABLED(CONFIG_OPTEE_SERVICE_DISCOVERY)) {
>                 ret =3D bind_service_drivers(dev);
>                 if (ret)
> -                       return ret;
> +                       dev_warn(dev, "optee service enumeration failed: =
%d\n", ret);
>         } else if (IS_ENABLED(CONFIG_RNG_OPTEE)) {
>                 /*
>                  * Discovery of TAs on the TEE bus is not supported in U-=
Boot:
> --
> 2.25.1
>

Looks good.
Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>

Thanks,
Jens
