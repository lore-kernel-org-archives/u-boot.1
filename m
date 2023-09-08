Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFBAEE8015
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 16:01:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C479C86A23;
	Fri,  8 Sep 2023 18:01:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IlwlUAdJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E580286A9F; Fri,  8 Sep 2023 18:01:07 +0200 (CEST)
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com
 [IPv6:2607:f8b0:4864:20::a33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF30986A04
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 18:01:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robertcnelson@gmail.com
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-493639d6173so816349e0c.3
 for <u-boot@lists.denx.de>; Fri, 08 Sep 2023 09:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694188863; x=1694793663; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=30OsZ1HiqbkS5dhuYzEbwAnsGp4/M7Q0cJdPeAZUKHU=;
 b=IlwlUAdJ9rJvxfoO0TqlMgczH1MyGzme/xFnm6AmeAMQ8rbq5Lq0+VSawhQhv7dExJ
 FlIv0IwznNckWzaTBtpL+AS2nV1d2WsWmIvWZWTCe+a2mLAfr8yX+udC5/AdGYl0cKmS
 X0e+Ma+MEeGTzYZLmo7F38hDNuWeE1ToJYBTuX50jmTcJvFr1tXr5DeVYrLsqXYecvOa
 0fMxQgmpm2lNC+0050m2Q79rXBgDft38voHER/ccqIkyvwSH/tSNh13QHJvq4KDpSMFr
 UEPTh2tloIB7OTs0pD9BmlzpuURuCz10dToPXc7yvlYAse5BWU54/80Yy+O/kK7/7O2L
 XkQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694188863; x=1694793663;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=30OsZ1HiqbkS5dhuYzEbwAnsGp4/M7Q0cJdPeAZUKHU=;
 b=HK1EMpFE0EynB7QK2JkG5BfnrqqztKkpAHfOaH3+RXW47jRFJOq6/+eZ9c9fyFs91j
 GfB8xAFrHUXC71bvB67pAkmX4/57CRar9vIkbrXB8JsP4jKctDBQPrBwFYLFdDbjyn9W
 mMZLidTBTpz/dUQOJwaIFpk9bIYR3duPe2dEm4tzWeQexHg4lYME+dcJISInY8Y6YnTx
 sBlQGFeaK40U5IWT+rtAC34XDlAZK7ru6FIk9fqS4a7cS3A+ZCTdyo2hX5SOm3oiEwIZ
 XlVgsYE7Ouqj6zIo/4mtB/otB8XT/HSYxBco+R5TEc9qOGNsQOmiJH9ooBPS3Xlz9z2i
 mbCA==
X-Gm-Message-State: AOJu0Yyz+IoH/u69yp8RKqdxAoe/HCbeoCk7SpADiN5DnlSE+Jv+g5Rd
 XOibv9VAiAOcdXChKz3QEB/gy0m9pSQB2G9NFvI=
X-Google-Smtp-Source: AGHT+IEjP9VkFz2brwhIsbLSp1XyNjsGWlERm9Fm/qCyurglgxaw+LAXChc1P16MpizyEkwF1eXKILU7wUuN0VRStoQ=
X-Received: by 2002:a1f:c547:0:b0:48d:5af8:b9d0 with SMTP id
 v68-20020a1fc547000000b0048d5af8b9d0mr3294234vkf.6.1694188863186; Fri, 08 Sep
 2023 09:01:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230830152553.15465-1-twoerner@gmail.com>
In-Reply-To: <20230830152553.15465-1-twoerner@gmail.com>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Fri, 8 Sep 2023 11:00:37 -0500
Message-ID: <CAOCHtYiuf9sZ-_LFUsxCe+oJO0pQ=SBAtse2n78Q1MjMPCS0Bw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: am335x-pocketbeagle: choose tick-timer
To: Trevor Woerner <twoerner@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Pierre Lebleu <pierre.lebleu@pile-engineering.com>, Andrew Davis <afd@ti.com>
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

On Wed, Aug 30, 2023 at 10:26=E2=80=AFAM Trevor Woerner <twoerner@gmail.com=
> wrote:
>
> Commit 4b2be78ab66c ("time: Fix get_ticks being non-monotonic")
> requires '/chosen/tick-timer' in device-tree. Otherwise we get:
>
>         U-Boot 2023.07.02 (Jul 11 2023 - 15:20:44 +0000)
>
>         CPU  : AM335X-GP rev 2.1
>         Model: TI AM335x PocketBeagle
>         DRAM:  512 MiB
>         Core:  154 devices, 16 uclasses, devicetree: separate
>         Could not initialize timer (err -19)
>
>         resetting ...
>
> Suggested-by: Pierre Lebleu <pierre.lebleu@pile-engineering.com>
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>

Tested-by: Robert Nelson <robertcnelson@gmail.com>

> ---
>  arch/arm/dts/am335x-pocketbeagle.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/dts/am335x-pocketbeagle.dts b/arch/arm/dts/am335x-p=
ocketbeagle.dts
> index b379e3a5570d..02e3aac56064 100644
> --- a/arch/arm/dts/am335x-pocketbeagle.dts
> +++ b/arch/arm/dts/am335x-pocketbeagle.dts
> @@ -15,6 +15,7 @@
>
>         chosen {
>                 stdout-path =3D &uart0;
> +               tick-timer =3D &timer2;
>         };
>
>         leds {
> --
> 2.41.0.327.gaa9166bcc0ba

Thanks for posting this Trevor, I'm also running with this change..

Regards,

--=20
Robert Nelson
https://rcn-ee.com/
