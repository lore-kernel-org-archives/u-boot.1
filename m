Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D731C624C6
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 09:16:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E5E6880886;
	Tue,  1 Sep 2026 09:16:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zmHMYLaaSgWN; Tue,  1 Sep 2026 09:16:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788254178;
	bh=gUJfpeuzcaU1zMZUPF1paCOTsE8EJNKiZIejp7a6FwA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OjmN8SoBenNu68tP4GkGfvSLXMbM5ogD8nK1bLYXPZJ5wEMC7IzT1z13mXEyWKZum
	 kyvYoMnLV/6fAo/tYix2CotcTGWFVdfPmkq0bpMaDybgR3/1wmnlbb3bAwKemGycQ+
	 j3d0SuM97qbu2k9/xI78UuT2SJBBS+CrcfouoFYXJXXugO+FW6Ue7uxOs5CyoyBt2A
	 fclELGlvmfBM6HHKWDfj/VkEGZtJwuLN+5Y3YOr0RDrVRoUo6Hux+h3PSKGzOobq3z
	 IxrcM5uJv+nFNQ6tsiTACBmpZOskFNUtKk7ZnMklhDV3YTi+mo/mnyWIyyJWbyCMkO
	 B7Q6ljynyNkQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 175F180879;
	Tue,  1 Sep 2026 09:16:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B18B3105
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:16:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 938CD60740
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:16:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IlCJL9Yzuk-D for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 09:16:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=nF3uqX1Q
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7898A6073F
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:16:12 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c1670dad7a8so109604466b.3
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 02:16:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788254171; cv=none;
 d=google.com; s=arc-20260327;
 b=m4pREgsIC+mElNNoJx5/PWetraEDbQXd6uduPMkELUZJDwV5OKjXnA9t/b9QBS5Qp3
 912eiHv0MU4d9FDUbRnWf2OPfF40J+7T3KmzyyHNNozCLHTn3S0/sbZV4YktglrQwCTc
 ASkpm+AykDzgv9X9fffCKWxgalKecXJWfBLsJXKMZTKPGf+WjJ0Ui2/f0v46M1u9h3iI
 4RUsoGWP2OqYd7N4dHk5NWSaNNqcrp0uDMjCteGYJsq06Z2CAxwy1iiuSwexlhMYNsaM
 KLuNU4wbo8vpVoZzSS8ZctHHY2cYOkmPmLH1a5R42fkkBivy75nOw9nuEB4y9XxWN0JQ
 mrMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gUJfpeuzcaU1zMZUPF1paCOTsE8EJNKiZIejp7a6FwA=;
 fh=W2FTHLDAT09M4QX/wi+3rwdbsN9A74o2EJTsyNLLaHk=;
 b=pwrtiErU3+RJq2mkF8EDX4djEklXJgtDzalKhke+PJXvGBSkz5cNuQPnWJiN/vp2LO
 uJYiLGQMcg39n0PCingKevsjFVVHcL97Yjj+tEQ0UbbpM+XkWqDayU0psro34ny3QZ3W
 a1JGBAcp85hmNkacD27aBJDlI06WD2Ercg4ETTN4F+Wa9bIk/UjE2a63UUrkXw6baHiD
 CPadTveeeIaMSxYKEer16BIdaWQT0wqAC/hKetY0QCcHsjTpe0NRrTdT93SOJuJQIuMq
 v+jinhdlTYZid+bXzDqQ/1h851ATNlsL91mnmw+xo9XO7AQzlHWwWopPRulugS9Kl9sD
 xJfg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788254171; x=1788858971;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gUJfpeuzcaU1zMZUPF1paCOTsE8EJNKiZIejp7a6FwA=;
 b=nF3uqX1Qh9NNAI9hxgxdpyUiExG7JpoHM2G9o9dzA9COfz+//6Io1M2dAeXMUpiTwF
 2tm+zvxc/dUwsMa/1RRdMqtAUBpJt8lX0vPN4cNG9H8F/YZYmROGSbwKRTYHObAbA5dh
 1QUkWUjJ95jPN39WnsKoMLReziQrmWn0k7o61w8l8KH0oTZHNsMeVbJeHC3pA8NCgLjK
 Ue4+IIk6PvvXNWoYAsIq3c0sukN6A27ibdKJbiDgLmWu8ShCsmSyg3HSHnoeg0uelRbc
 azPEGws7SAoEtQxz7U1yzpp23PKfMwmxV+6nwALHVIccj8UPj8cbmu3A1aTEMJ3sZfcL
 q7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788254171; x=1788858971;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gUJfpeuzcaU1zMZUPF1paCOTsE8EJNKiZIejp7a6FwA=;
 b=ccsEGGIts9ycH01gHQhPJ3CZkJE/At8ytBg0CJVXonKZ+eKerKIicRe0/AsB0okaUg
 Efz6Yua6T0SBPbr+TKC40zqiPpA3tGcBulD6Fm7Q3MZD7YrJCRremQve3iWIJL1DiMSW
 pdbckWK6Ln6tDEkfH+s9WDAtYt2P8hzKXGIow949FtiGIqeio22/vsf6QjN9ZnJLyVkx
 px8lp/j1YJKSIssSeg31/stq77pCYSzg0u/UEnHp8CF6xxLcCvl5WRx5Lmb3QcUKko6y
 AFBkesaPLyS+sE2LHe4ibnDv8IeRJbtV3/hEY3xJ35jajazrJ6q5I52wnxF1tKO9SJ1e
 fBOg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoBtKEBgBjHOxumQVkW+566spljVwDN9YmeEWSFiiIRcUEFox0dnP3UKF8zJRXfAcEVa9DLl34=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nIO8XZ4J1c1RKA5sbcHguiUDhDoGCUCIbACLfKAAZMk99JEuBl
 cxQ0YQkCWoc2IypyLats4p5uP2E7Nz5iKUmQ7Hj2tqjB/TP85CMR+w4vW2VEsDijXJ2j9HwPpta
 +MI2QA1NS4Bmc3SOpCuQF3zL37Kcr5Ar4BCsI/EI/Hb5cJ6lPIW6+/NY=
X-Gm-Gg: AR+sD130qDssjeKvvxbj8NKmksS0Vqi9YVGaPDQ0pg6Go4kgQhRYfRlLEGLUTaD7rQ6
 zFktEpOUcRdH8UXnuMgEXfWNcF/5oT2PxTREWVevHKLXuUTFbsXXLK6ybC/mzTL9xBw7MvZtg0I
 UO5GU4pkbeDltyjuj/LP7eIFIVWY7b1sGzURkp4gpkXqWtecd3bUYxwal9V5qW69OkqSuq/PH0L
 Li8Qs17MP35GXW2UQJE5UeSe8i63ygZ26uSWwiMjRILeHOqbVkzhrbVwyMHfItR7X5Y/oCoLsT2
 xFL+fmxpXKmnNBlbh3LIepFf9FIvpM14iEKsKyjset4a/kguEiU8X7drbTBMAirPMXrTnqZ0e3i
 7VTF9KHIG4FV358vfvfzKjQgHsdwUeP8GjCZ31nyo0s8FaN854KdnAlEPc5zZpcGjWeG9+BkdCu
 o=
X-Received: by 2002:a17:907:3e04:b0:c1c:2173:d412 with SMTP id
 a640c23a62f3a-c2556fe9307mr1967106566b.1.1788254170516; Tue, 01 Sep 2026
 02:16:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260901-fix-build-with-config-video-but-config-video-logo-disabled-v1-0-9dc80d307790@baylibre.com>
In-Reply-To: <20260901-fix-build-with-config-video-but-config-video-logo-disabled-v1-0-9dc80d307790@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 1 Sep 2026 11:16:00 +0200
X-Gm-Features: AcwNN1UoSRyOAANmHW1vDxBFEB1F_ln_uqMzKnZe8CqVgqD59DIdobOEs6cFX3o
Message-ID: <CAEHHSvb3pYcDaqPgJ7UN=58yhJOhm0LYcfDdD7um63htYivmtg@mail.gmail.com>
Subject: Re: [PATCH 0/2] video: fix build with VIDEO && !VIDEO_LOGO
To: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, dlechner@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

I messed up the u-boot list, removing the old one, adding the new one.
Sorry for the noise

Le mar. 1 sept. 2026 =C3=A0 10:52, Julien Stephan <jstephan@baylibre.com> a=
 =C3=A9crit :
>
> While enabling a splash screen I enabled SPLASH_SCREEN which
> automatically disable CONFIG_VIDEO_LOGO (while keeping CONFIG_VIDEO))
> and hit a link failure:
>
>   video-uclass.o: in function `video_get_u_boot_logo':
>   video-uclass.c:593: undefined reference to `__splash_u_boot_logo_begin'
>
> The __splash_u_boot_logo_begin/_end symbols come from u_boot_logo.bmp.o,
> which is only built when CONFIG_VIDEO_LOGO is set, but the splash helpers
> reference them unconditionally.
>
> Downstream just worked around this by unsetting EXPO, which is the only
> caller of video_get_u_boot_logo, but that's not a real fix, so patch 2
> guards the splash code (and adds a NULL-returning stub for
> video_get_u_boot_logo()) so VIDEO without VIDEO_LOGO builds.
>
> While at it, patch 1 makes show_splash() actually return the
> video_bmp_display() result instead of discarding it and returning 0.
> This has the side effect of actually making the whole video device fail
> to probe (no display), where before the console came up fine minus the
> logo.
>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
> Julien Stephan (2):
>       video: propagate show_splash() return value
>       video: fix build with CONFIG_VIDEO && !CONFIG_VIDEO_LOGO
>
>  drivers/video/video-uclass.c | 12 ++++++------
>  include/video.h              |  9 ++++++++-
>  2 files changed, 14 insertions(+), 7 deletions(-)
> ---
> base-commit: a18265f1ccb7a272721ed4286ed3b5a6182ff424
> change-id: 20260901-fix-build-with-config-video-but-config-video-logo-dis=
abled-f56fffc664eb
>
> Best regards,
> --
> Julien Stephan <jstephan@baylibre.com>
>
