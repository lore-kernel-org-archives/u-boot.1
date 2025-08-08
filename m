Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC48C87FD3
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 13:00:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72BDA84725;
	Fri,  8 Aug 2025 15:00:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iXRI/zhh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6A2984726; Fri,  8 Aug 2025 15:00:01 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEEC1846F0
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 14:59:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-32ce1b2188dso23597451fa.3
 for <u-boot@lists.denx.de>; Fri, 08 Aug 2025 05:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754657999; x=1755262799; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HOzR53teIBTMWuELc7jqugg5zniQ5WaSdxMluq6ZntM=;
 b=iXRI/zhhJn2lA+d2qLwNY7GU1O+NXlVUcdL2eyHDN7CBYMQWrIhIXb5QcXNsZVWnqS
 5iG3TT6KMF7EnkIfKtXpS+trA37nHxowyUqPJ4E2PLrCOc8t3et+SLnKzSj+17yxwvCt
 IrdRgrfUeUP+eFFrAbtivgKQuS1+VYZNz9B9Srp085uFI1VQCAA6a60mt29iGJx7ETxx
 Mt9knFwU1xGmKOyHE5DDOGqouraCKLQ8DUW+4ymasVy09JJQ1bzu7OzbM2UXeIFHKP+l
 JXxQj3+Aa1B8MXyOg5x9wpphFKBj8uwri1Y0Zvz5FfZWOYuM1B13DU2H0KzgmS/rJRp0
 8dPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754657999; x=1755262799;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HOzR53teIBTMWuELc7jqugg5zniQ5WaSdxMluq6ZntM=;
 b=eS6rcG18LPTMNLHwVO61k/eg9hvuXhAsj8/LC1ZC9ae1bMlJeelskIPIIQ3jJ0WL29
 SvkciefUR+Xqd2bwbTBv9AjQEeF06RV4KMTrX6x73O8ocEYZLA9Mo9YNb8eGGhcd7VAD
 0M7+TISBNg7W1Or8uYD9p01/udiSWjbhWKAf12DLQklGBIMfpMsCMaGDz9tyhSU3FVs5
 Huc0+v6nJ7VPjsKua7UejMFgC/dtfyX7ZUimMMnjn/yZ8Co3tYRYHqv5XYQACpTJi0pX
 aj/t6qCr3zti+yh21Ds5X32yr+CcaFx0d1jQah9XHM4HGUcmdy1q7qUsb/npj5hFocqL
 XpSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWi4gGC10u8v1BdQ4Y0o8B9kOBPOgbwW0NF58Uk/IniSqUtG7zrOgAs/k+GYcHEmCD5Y6tDqTY=@lists.denx.de
X-Gm-Message-State: AOJu0Yy8BsHmRc71sZRGojOXsqx8pQZGKVbXh/jiALyYtvpwtvRpyCDZ
 Z7Kmb01t2Ge0lgdFCGGbzj2owSHG+0xPW6f0UaDcK3N6jTV09ODHSWx7CSPs04R2c+Q6EIEyiO+
 yrMgKSg52x/rdX+Fsz1InlqVMd+dUNAE=
X-Gm-Gg: ASbGncu2zGZqWqGuOTry+Tt22FAWz3BU7bBP/QkENjKflN87F1Bqb8FCEhnynQkP4Ak
 bhCBkUxCE5RiPmK9mLcd/tGveAHVRYZ3bDxFh0oZTGal6ZwP0xMZVa3RNpcXSg8b5WasOnAdDhO
 /C/4WdSe8utaDewxuclVFjHQ5dcFf+NHFvXtZQeVPhiUTsV4MJuMe89tev4mgnJpnxu6kroGhxM
 dPJVU7AWbwUqGAYOQAjPHyP1ZZWAnhMG+yj4tVSNjZOvy/n
X-Google-Smtp-Source: AGHT+IFOFLjj267Ts2lkIkmc5/4u6470eeG4Nk0FZw4iMPACxlUgrZmdiaMQ07xzuastJMlndvMvdynLpwoYyluqJTQ=
X-Received: by 2002:a05:651c:10c6:b0:32b:9652:2c32 with SMTP id
 38308e7fff4ca-333a221e09bmr6755111fa.33.1754657998816; Fri, 08 Aug 2025
 05:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250806-imx8m-optional-optee-v2-1-5878e6e7cca7@phytec.de>
In-Reply-To: <20250806-imx8m-optional-optee-v2-1-5878e6e7cca7@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 8 Aug 2025 09:59:46 -0300
X-Gm-Features: Ac12FXxtCgQXHLcC2SdY9SaJycIPD82tRIdMojB2z5_3aMdW8gCqbg5fKRRVfqE
Message-ID: <CAOMZO5CV_tF9HTF1wJc6ahsKiDewidiaURs4-_cG7A=8QL6TyQ@mail.gmail.com>
Subject: Re: [PATCH v2] dts: imx8m{m,n,p,q}: Make optee packaging optional
To: Yannic Moog <y.moog@phytec.de>
Cc: Stefano Babic <sbabic@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Tim Harvey <tharvey@gateworks.com>,
 u-boot@lists.denx.de, upstream@lists.phytec.de
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

On Wed, Aug 6, 2025 at 9:45=E2=80=AFAM Yannic Moog <y.moog@phytec.de> wrote=
:
>
> binman can omit packaging an optional blob when it is missing.
> This allows us to not bother with config options.
> The core challenge is the interaction between tf-a and OP-TEE where
> U-Boot/binman does not know whether tf-a was built with SPD=3Dopteed or
> without. This is important because tf-a might jump into the void when no
> optee_os is present, leading to boot failure. Thus by marking it
> optional, user is prompted to recheck (due to the warning message)
> whether they really have the right combination of tf-a and optee.
>
> Due to a bug in binman, we had to guard binman tee.bin with OPTEE config
> as builds would error when tee.bin was not present in path; Even though
> optee_os was marked as optional in the binman tree. Since the bug has
> been resolved in
> commit d4f61eae2ab7 ("Merge patch series "Fix handling of optional blobs =
in binman"")
> we can mark it optional again without getting build errors.
>
> Note that after this commit a warning will be printed when optee is not
> present for a binman build.
>
> Image 'image' is missing optional external blobs but is still functional:=
 tee-os
>
> /binman/section/fit/images/tee/tee-os (tee.bin):
>    See the documentation for your board. You may need to build Open Porta=
ble
>    Trusted Execution Environment (OP-TEE) and build with TEE=3D/path/to/t=
ee.bin
>
> Signed-off-by: Yannic Moog <y.moog@phytec.de>

Applied, thanks.
