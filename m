Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1834CE7A95
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 15:50:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B7EB86B58;
	Mon, 25 Sep 2023 17:50:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pkb58qDa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D87F886B82; Mon, 25 Sep 2023 17:50:34 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D44D86B3A
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 17:50:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-27755cfa666so521014a91.0
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 08:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695657031; x=1696261831; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lD6Z4ol59P8+COgkQJZw2O/dPkYkBzFhwn7siM8dG+o=;
 b=Pkb58qDaMwqpdanbrqBNgLa/vFCdmcVpEo9tYZVrGvGmZ/IAlKPOITPfb9WUV32ezU
 dgX8ahX2hr36KST282C3b2VY5VIXx9RnXXSVpT7zr5Em9rcuxPpkxU9eU1U0EHZQAjaA
 45WGCGg6SES3TvXkhb8dFzyLBbMbb+xtQw1cJUIQegVQfDe4yo+ETu9NOU2dblitvfHA
 73Bx8PpUkG60EKhO5s9ES3fAObfrBG+EEwG2g+UB0KIGziOFd/S1JtfOzFMYmistkRmL
 goiPWJ8lkRT+bOHscquk2LhG4Vhy2ZbEuJjyygDjvZo2iqGoMupyPZGbb0Zm9okWAg2O
 AHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695657031; x=1696261831;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lD6Z4ol59P8+COgkQJZw2O/dPkYkBzFhwn7siM8dG+o=;
 b=nEUUJOyDJrN0XBK+yNR94FNmQ128yAGvLm9SDahSdA1ALQ6xh+K7xGWPizN+kA3oCE
 UPi+OxGcNlSvszAixyLW+JlM9btAwQIBhs5Q/059iMFmNSVx+zgR+knTZ1t+gHxuXHwW
 2/4RyL72Ena39ThTfJN0XKq96PSkNxVaiohfMa2tHQSh2ifONQRlRrtOpYz2pYK+W74F
 8FoRp7ehM5JGtTGiiHVwinDOu8aiMN3uJr2tnkMAX8BDcBB9FPBe9y+zktiwSWtBFo1U
 NOaizA6ZzegTQc7/5PLqh1fWRJNdH1KakXST9UXwQjimyc/QxzW16jEyXW++1JAejIM2
 8vCg==
X-Gm-Message-State: AOJu0YxQ/CkdGTw4dgKH+jH7hpIXfgABM+DpWTyGcX8mhb47uFlym0Ap
 9sujj7dhSBLHSck2CbCz8QHXTuTM0HB6oOeEQbX8H+A5CN0=
X-Google-Smtp-Source: AGHT+IFM+eNaI6ALyA8o7cfidgmG0uWZwSAE6optyptkBZtxLbNJ+oaPJ8RVf1/ysFq2XEzoDnIc1KFlmUxG6ssB8Is=
X-Received: by 2002:a17:90a:6fc2:b0:273:e4a7:ce72 with SMTP id
 e60-20020a17090a6fc200b00273e4a7ce72mr6106440pjk.3.1695657030512; Mon, 25 Sep
 2023 08:50:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAOYdKdjW6Ut3QCMWpu8W7TKuuv9OfehC7tdW7-vkdcN8ZbK3Jg@mail.gmail.com>
 <CAOMZO5BtN6xQJ9j35Wz4wH9p5Q=JoC2Ffb1aN-yrTzUeb0AvYQ@mail.gmail.com>
 <CAOYdKdjnVpt=YOrAzjKiaAZomB7=hgAHe1TE+7MM8PK3g+WjRQ@mail.gmail.com>
 <CAOYdKdirq-H+ZaBmy0sT05sL=C=cJWLixgJLsA5ES9PcwZrXyw@mail.gmail.com>
 <CAOMZO5CTG8bqNoP2XO=6VXXquutg-MFqBTbi9Y2q4Dcg0Mfftw@mail.gmail.com>
 <CAOMZO5ArFiQO=BWvDbR91XhADJ0ks4JTe45zOb+z3aaiED2gkg@mail.gmail.com>
 <CAOMZO5CYnkCC5pmG35+8qHqeCaEJwM3Z3eyoJaTrOMMWj5AWWg@mail.gmail.com>
 <CAOYdKdgLaAx8krbBZV=yaUGTwtf6cbgaTU3=+pRKJ4-w_V3_Sg@mail.gmail.com>
 <CAOMZO5DqKS2w1G3iKKGPS_piXx8JcGoWCFOqCQOoB524O9KyOQ@mail.gmail.com>
 <CAOYdKdjPrRT7F_LFf8YeafX1MWep_p91CFdwc-SH8+diCu+2sw@mail.gmail.com>
 <CAOMZO5BzrfvLDrtqBk1dmLqb9-GxzZs8nRVY7GxqCRY34pKg4w@mail.gmail.com>
 <CAOYdKdgyXi5g9zPNOCBtsrA8KV0L1O0Oyh4Ne-Q79Z=EgGs=zw@mail.gmail.com>
 <CAOYdKdhvKEaeyv5zhXiswuF-Kd6ee8FmdN8MoMS9=5VTWVgMXA@mail.gmail.com>
 <CAOMZO5DS2VHPKvVioSW=7fWfnrP63A6wdga6pFmFuSK2QF8gSA@mail.gmail.com>
 <CAOYdKdjALruh9v6HBO-MSjzZM0whYhbA5YLJxbKk7yQk7cznGw@mail.gmail.com>
 <CAOMZO5AVuBxGFF_itcxvdG=W9JoRtyzzeeC+wji__uUOQirwZg@mail.gmail.com>
 <CAOYdKdingLtAvEnth8mSnazQ2fZ_kCsM_2P_dX7tbL2xe9wyVw@mail.gmail.com>
In-Reply-To: <CAOYdKdingLtAvEnth8mSnazQ2fZ_kCsM_2P_dX7tbL2xe9wyVw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 25 Sep 2023 12:50:18 -0300
Message-ID: <CAOMZO5ALK_O-648FaHFrjJc9EiU3J=nvv1rYDiLOGqhjt3mmkA@mail.gmail.com>
Subject: Re: Trying to boot custom kernel on Wink Hub (i.MX28)
To: Rogan Dawes <rogan@dawes.za.net>
Cc: u-boot@lists.denx.de
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

On Mon, Sep 25, 2023 at 11:00=E2=80=AFAM Rogan Dawes <rogan@dawes.za.net> w=
rote:

> I see absolutely nothing in the console.
>
> I=E2=80=99m wondering whether I can possibly execute the vendor SPL with =
a modern u-boot?

The old U-Boot vendor does not use SPL. It uses an old mechanism
called bootlets.

I suggest that we start from scratch with this imx28-wink-hub support
that I have just added:
https://github.com/fabioestevam/u-boot/commits/wink

To build it:

make imx28-wink-hub_defconfig
make u-boot.sb

Then try to load u-boot.sb via mxsldr.

If it still fails, then I suspect that the power management unit (PMU)
may be incorrectly configured causing the board to not power up.

Try playing with the CONFIG_SPL_MXS_PMU_ options.

From configs/imx28_xea_defconfig, for example:

CONFIG_SPL_MXS_PMU_MINIMAL_VDD5V_CURRENT=3Dy
CONFIG_SPL_MXS_PMU_DISABLE_BATT_CHARGE=3Dy
# CONFIG_SPL_MXS_PMU_ENABLE_4P2_LINEAR_REGULATOR is not set
