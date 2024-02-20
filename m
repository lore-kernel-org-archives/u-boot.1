Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79BA0C5475B
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 14:02:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CFEB87F9F;
	Tue, 20 Feb 2024 15:02:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="v3a9mPDO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D37EC87FA7; Tue, 20 Feb 2024 15:02:22 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9374587F6E
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 15:02:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3c1404d05bfso3761378b6e.3
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 06:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708437720; x=1709042520; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UzNgNaNVbaKZcEFHsUFELaWBXUGdD8IbDft5Luvq6yg=;
 b=v3a9mPDOb+iVNJBAAxXr9DTJIGRnvjsE3pwYeiG58EjoN3vOnaeNWyBgUjch19XVnZ
 jKLM9/IWKsiHBUW6z0cMWoYqH0EzueRzFvEm+hjtYkuEWOcWE0johcqKFka7tJcwUwM4
 AJBQczqtsQVSKJtHl+UG0RC44ZwdoAntmLYYfHvDOy1S53YSNR8+/PP471UHVn6ZMqPO
 W+b1p2BjO+x+w0YpixT5scbAoezBaGQmhPO9xLtKc+HsDZEmupYpnIgvW4N/0vDxjYek
 HNRmCttmLfJH9gVwsGIT8umK884ujlokzRHFLpvE4JDuguJmG3UqOu5GdKd+qh6r0ZbP
 I8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708437720; x=1709042520;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UzNgNaNVbaKZcEFHsUFELaWBXUGdD8IbDft5Luvq6yg=;
 b=oT+EzyQWHPYvGfMJbDlzPHzwsPlJCr9BUF7swrcFhlSOdTXy8e3OU9iWt9HFbawaR8
 Tp70liA/ntzui/aSEbxs3RHdc/FJ4pCaqBKT4QxysqjTXkA6hJtfT1aOQ0IHAXtozYks
 Mq31emnkAgDFTnaUEEtCLEGLFWRvGMZLqWi5pCZXrtH24YonfDbuCzG4IH6IyuGLNoGF
 WaUyIgzyyDlkMVREvAWRRiHlyeU8giuM2OhpQHx/ZbfBWBPoK88H7VsdOcIU/Fb2erPx
 kfs2NqmRdtrkAsZo4i1WHbbjSAwt+95Aue9UW/lIUv1aq8gxJpd4vs+tZD6ucvq09xA/
 s+mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdRIFuw4q8QDzleCKkMhVd0X0Jnb1Q+lh4RJrjkJ3S0sPwDdcjVII/SAKfXFeD7AtATOWqft9r+C5nHA5N2BH2f1AQkg==
X-Gm-Message-State: AOJu0Yzl8toyIelTTQ0yZHl14TAs0e//qYQuizXTIIfzhU7wd1s6B75x
 CDts6FLNpIxImomKQnB6nttc2hAYKXsjwT2Jyr+4Fyyt57/VR0DYdGPU11gWQiICl2jCvX/ymgG
 9FW9KN4AgGa26MgFNdiyug/fhA3D2HJZWCYG7Ig==
X-Google-Smtp-Source: AGHT+IG8jEAhmBpvJ1Hqt4RX6yyIsgQ7OY0MGIZ5uE5kB0T9daOzuqunWOMwEQMLh/X9uxthK5fVPfU1RvhqIzTIkEI=
X-Received: by 2002:a05:6808:10d4:b0:3c1:67f7:bd60 with SMTP id
 s20-20020a05680810d400b003c167f7bd60mr1360638ois.11.1708437719289; Tue, 20
 Feb 2024 06:01:59 -0800 (PST)
MIME-Version: 1.0
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
 <20240215-b4-qcom-common-target-v4-26-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-26-ed06355c634a@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 20 Feb 2024 19:31:48 +0530
Message-ID: <CAFA6WYM4G4BemGQN+FMmKTN=fYhsBDYZb+a7a=Q-HMN1a0c_SA@mail.gmail.com>
Subject: Re: [PATCH v4 26/39] doc: board/qualcomm: link to APQ8016 TRM
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
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

On Fri, 16 Feb 2024 at 02:22, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> The MSM8916/APQ8016 Technical Reference Manual is publicly available and
> contains a lot of useful register maps for many core parts of the SoC.
> Include an archive.org link to it in the dragonboard410c documentation.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  doc/board/qualcomm/dragonboard410c.rst | 2 ++
>  1 file changed, 2 insertions(+)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/doc/board/qualcomm/dragonboard410c.rst b/doc/board/qualcomm/dragonboard410c.rst
> index d0de9dbcbc9a..34629241110c 100644
> --- a/doc/board/qualcomm/dragonboard410c.rst
> +++ b/doc/board/qualcomm/dragonboard410c.rst
> @@ -14,6 +14,8 @@ through LK. This is no longer the case, now U-Boot can replace LK entirely.
>
>  .. _96Boards product page: https://www.96boards.org/product/dragonboard410c/
>
> +.. _MSM8916/SD410/APQ8016 Technical Reference Manual: https://web.archive.org/web/20210525022203/https://developer.qualcomm.com/qfile/35259/lm80-p0436-100_d_snapdragon_410e_apq8016e_tech_reference_manual_revd.pdf
> +
>  Installation
>  ------------
>  First, setup ``CROSS_COMPILE`` for aarch64. Then, build U-Boot for ``dragonboard410c``::
>
> --
> 2.43.1
>
