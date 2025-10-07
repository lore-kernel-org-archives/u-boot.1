Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF188CCA470
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 19:32:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E2288394E;
	Tue,  7 Oct 2025 21:32:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ek70TtaC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4882183959; Tue,  7 Oct 2025 21:32:31 +0200 (CEST)
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com
 [IPv6:2607:f8b0:4864:20::b131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D3B8838E7
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 21:32:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-6354a4b4871so8141113d50.2
 for <u-boot@lists.denx.de>; Tue, 07 Oct 2025 12:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759865547; x=1760470347; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rECr+qeb8j9ZlMdO8sxt5a1jpjxarnR0hQal7kSGUaA=;
 b=Ek70TtaCE8qWGMSk742s+CN2pSXqe49TdvKUme4csQx5jowtC+Xlvlgue3CHGUyibP
 YSklVo+ZCnt1zZ7ixXBu6CV1UbiWlsk5WEzgEMSQ+pSFjF9chzZxMgd1wp9btCN6K7/t
 qkAu1xlLufnxZ9XrRdQjr0TKISL0oitdOHhs9x9acttAzP3XvRObPzf62PCpYzOXdGYG
 gsQVTUpvuWSoG3nSUT3Zbsjg1RMTRaSlT5OoJxKnHXpMBGGVhteBLBtLxWxCingvqQ9l
 KHPcYwgF3yuS54dIGUoNr/CYnGOXlFBCsXnuK0K1nySethnshFn8dZpc4lNusexUuVxS
 igRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759865547; x=1760470347;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rECr+qeb8j9ZlMdO8sxt5a1jpjxarnR0hQal7kSGUaA=;
 b=E0cYinFIB1tBSnJXerwV63+OM2OzFFr9bT1dudn55LbeUQKm1UEd/DMcp7743pSi0r
 30KYsQ064Dq8nEa8kMU701gqnc2rCajrN7V1XZRrhX0q0+nIhH9USfKUWd9XQFg9fWGt
 tD2SLgjImnKp2dRnVVldQNSC9a9CfS+Nh6Id2NTSVZJ73ewLHelcD8ZJ+2pipJKLEKsQ
 ZMODV9GTWpVgm0hLEONo+Yo1z/kIR+r2AFg5wqkgkviOPYdOWE1p+AlmZ3D8aJsBjLUk
 s1oJaqKSW8LCdLqD0YHFTTRulo/loH2J5OVonwaNFJpdeo7MFjoKSq0pQrBiEiAtRYNs
 5zfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV91AsUNwKfZxr4xvQkyc2bdsya5rxmcVMg2Fw7+CPnkOT99Q4m5hOohqfnxAfiSVhXlSCHayw=@lists.denx.de
X-Gm-Message-State: AOJu0YwmuqJlPIhEPn+N+aGgF8IzaAYWE+XzwcfhZqTp8Ao54j6iiN3D
 yd4ninJ7qlLYDqAUf62Bw3NZoG2tlHYFNR2rlNcFJ5H3bqIpjYQN9VifyfVwJaCGngTJnZV6tw3
 k/bZ4c+j8pwpK7vnPU6mXglHyZZ0NQKk5e5WpiXCdng==
X-Gm-Gg: ASbGncvtlARirkE92sQaegMMCcdsNi7KOgTvua1JxSaV6ql6J6uPEIZUIJuLSdAaAWd
 dfU3X0fQVf+USTzxi3x8jJAOl+TLlMUgUZPMP3h/v4o041u9d7irkBCb0AjY4hSc+uWScOOtl98
 9AyQk0YaozFmNBtGvdado8Ap12HiLexKJs+xSADIWtS5MGuE13U0azeAMxOjdFDBnHSf8l1d4kj
 URlA8bfU0c5XrW8GWIyLIaM3RbA0zvEFg==
X-Google-Smtp-Source: AGHT+IFIOW5UAbfKNRz+CmOlIGLjm+z8if+Fmc7PHEWIh8RGgZnNfGWHRxvDyeg4zxYK8XCtZz7gau6tXMsHOGZtr0I=
X-Received: by 2002:a05:690e:154d:10b0:636:d230:7d82 with SMTP id
 956f58d0204a3-63ccb8ec1ccmr725651d50.26.1759865547131; Tue, 07 Oct 2025
 12:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <20251003222714.4921-1-semen.protsenko@linaro.org>
 <CAFLszTiic5c_ZwX4hWJEAx=VGXxR8KOsNw2AQwzh92G-PRncGA@mail.gmail.com>
In-Reply-To: <CAFLszTiic5c_ZwX4hWJEAx=VGXxR8KOsNw2AQwzh92G-PRncGA@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 7 Oct 2025 14:32:15 -0500
X-Gm-Features: AS18NWCD_08PLolBbCS_BeGTNDsD9XIORT5sdnKbak2hvlig-4MxsBZXJ7zD1xU
Message-ID: <CAPLW+4n_wCzhsyVYiz1AzA4R0Z32nkjOs31F8TDwZXpyUM-J4Q@mail.gmail.com>
Subject: Re: [PATCH] bootstd: Fix bootflow info for efi_mgr
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
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

Hi Simon,

On Mon, Oct 6, 2025 at 3:40=E2=80=AFPM Simon Glass <sjg@chromium.org> wrote=
:

[snip]

>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> If you like, you could an a test for this to bootflow_cmd_info()
>

I remember the last time when I tried running bootstd tests they were
broken. Are they functional now? Also, do we have some short
documentation on running bootstd tests? If so, could you please
reference it. I mean, I can add the test, but unfortunately don't have
enough time to fix the broken test suite (if it's still broken).

> Regards,
> Simon
