Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D220AC71153
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 16:51:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D37E1869B1;
	Mon,  4 Sep 2023 18:49:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lgwI02Nx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CED398694A; Mon,  4 Sep 2023 18:49:52 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9842486960
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 18:49:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5007c8308c3so2578174e87.0
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 09:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693846185; x=1694450985; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yOAr388YQN6Burw5V7PBW12v+fQ2a8fg+UrMplzitnw=;
 b=lgwI02Nxyh6wih9qBqnikofK4ItjpMyWLXBtXVwNB61l8HiaqggTBZBCAxr0QyMUxC
 PwFFXuFw+zSL9W+NLrRZowI353ZTRmKkbn1+q5wD7mpGSD2kB/qqNB2UMIW19MkiEl4B
 vuEaWcq1Qsty82g61dXhi7usvy9KYwhVQyXhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693846185; x=1694450985;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yOAr388YQN6Burw5V7PBW12v+fQ2a8fg+UrMplzitnw=;
 b=Fd7kMr2aXRgNEzTqvJyHP2ptPeOFeMi5HhFBqza4KYQE4V/uiR9scxHWtHqRyFqaVV
 Tep+wYmrlSMpRcqMiHVLyUaTtcllgHmuodhHM7/E4/G2i/9Z/8Tlqo1YVo7SrEQfq865
 d5Hv8cvXXYhJmDVi4UEnuMm6siXocOvRkRvINqUmNCkWPciDgJdGs0vucBwVRZ9QWdAA
 SI2p58cUzNizBNE+WMOHathjJFnP8kHlyiRcStk7e9l1GOc03OHtl5GKtXLsqZvGm8Qb
 FX864+2Cs18G0NG+iVWr4RCFm/TIUulkPiXfALeyzYfOVmZ7kTgdd2cL+IK/E5VHyxLI
 r7mw==
X-Gm-Message-State: AOJu0Yww2zGuCdJR4ZCoE/ShW6LPn8iWy0p0MaLBEyIeWgW9NMl2DCoK
 IPrgVkQ35DI4vVzyivrTgQL3fq9t9/DXErzqJx6pzw==
X-Google-Smtp-Source: AGHT+IH1+otA7sYqvlPf09mjCEC8YVAPjgq4LGfRjW9mSRarKAOF1QewCIlHmQxArjPALzb5h6zORzLnowX+htes7S4=
X-Received: by 2002:a05:6512:2016:b0:500:91c1:9642 with SMTP id
 a22-20020a056512201600b0050091c19642mr5590675lfb.21.1693846184542; Mon, 04
 Sep 2023 09:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_055CBAA884BC568E56211618940881653D0A@qq.com>
In-Reply-To: <tencent_055CBAA884BC568E56211618940881653D0A@qq.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 Sep 2023 10:48:49 -0600
Message-ID: <CAPnjgZ37OL8XjMu1eOYPYR8OdmEp52tMwbVfJ5+j8_fCE7WRig@mail.gmail.com>
Subject: Re: [PATCH] Adjust gitignore for /build
To: Rong Tao <rtoax@foxmail.com>
Cc: Maxim Cournoyer <maxim.cournoyer@gmail.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, Rong Tao <rongtao@cestc.cn>, 
 open list <u-boot@lists.denx.de>
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

Hi Rong,

On Sun, 3 Sept 2023 at 20:50, Rong Tao <rtoax@foxmail.com> wrote:
>
> From: Rong Tao <rongtao@cestc.cn>
>
> /build-* can't ignore /build.

How does that directory get created?

>
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>  .gitignore | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/.gitignore b/.gitignore
> index 002f95de4feb..9697f0088f80 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -35,7 +35,7 @@
>  *.tab.[ch]
>
>  # Build tree
> -/build-*
> +/build*
>
>  #
>  # Top-level generic files
> --
> 2.41.0
>

Regards,
Simon
