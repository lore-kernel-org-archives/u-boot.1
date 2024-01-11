Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28368C4707B
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 02:41:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 613618771B;
	Thu, 11 Jan 2024 03:41:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="x2GBRaLR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAF048751F; Thu, 11 Jan 2024 03:41:05 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA73D87823
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 03:41:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3bbd6e37af4so3915331b6e.1
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 18:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704940861; x=1705545661; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uVBP5MYSmvntzMxjqonIs/+v5G9jdAgfAcAi2AcoVeE=;
 b=x2GBRaLRxXjw7VzdlSza1CjY4bOw+/AHeAU/uFpFT2AUQxri6sfeA9NYvi4Zd3/pHs
 38bANVa232c8J2SYazsyKzOie3T0c2s7dhf2/iiKe7E1oZKuxZcZ9mvodeLc3kjzenN+
 YBnGClxioW8Z49TYDKXRKasDvEiO9nTF6j0UuXna8ymX8hJVEbLIjU41huQsAiPdhhAs
 edEvSwVtA/MbUPGiTX9zQ8t1wYFxf+A7t7PBuwG3WU/uEy93hPhRvZftOl2bMvYWZP8i
 cjrh3veO8ziYQCBkyLSpISwC38gcKfcd1xbEUgdmkhq661HqMN13Z6b0653wrGvITfzt
 lyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704940861; x=1705545661;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uVBP5MYSmvntzMxjqonIs/+v5G9jdAgfAcAi2AcoVeE=;
 b=VMkVFoPkZk1eCHKp0D8NV6LVa1hm34moPH+2Wq2m23FpMydZyvWggZ0zRmz1f4dDPw
 muxXKaCJ+a+eS1iKGAbMVCIJjHIMo9xLpOiFPnJOaFa+5BS2Er2TYq1MQEAc0pQE22km
 3TOTFlWp1OJsi4jq/8N7KJ4YGPEk1KNvxt1xHvQpoXtS4mkMr9EHt2iAapG2aWNjopoW
 P2i111QgBa0MrhlXknmYq/lwblfM7QjM1uqgrpd1DzRYGC5h7QA9430LRmFMC7c/3V9P
 TV1GNsMRBJWSf51RPOM39R20Uhr//WyRVgzFaapO7SPTqY+ufKGAdf12z8QTgx5xfxth
 shgA==
X-Gm-Message-State: AOJu0YwmJB5uJmZWk1ID+jlMmGU6IO6XSqcolFScay1XYClgcbWbGicN
 KMZ6w5KC/ymW1Fnmg++aRzISQTSXhtNNVyGipqqSjFEpbu94aQ==
X-Google-Smtp-Source: AGHT+IGxQPnIRu+APXE4t6ZMaPPKq1VPW4frTXHOofxF8YTOo8tetETGso49tmBER5ZS3aXLcgDbEkfoclCPJ9PVeKU=
X-Received: by 2002:a05:6808:1902:b0:3bd:37ad:dba2 with SMTP id
 bf2-20020a056808190200b003bd37addba2mr616018oib.70.1704940861259; Wed, 10 Jan
 2024 18:41:01 -0800 (PST)
MIME-Version: 1.0
References: <20231213031646.28828-1-semen.protsenko@linaro.org>
 <CGME20231213031832epcas2p17caec6a1a70ecdfcef2a359fb732dcb2@epcas2p1.samsung.com>
 <20231213031646.28828-8-semen.protsenko@linaro.org>
 <006e01da326f$f07ea040$d17be0c0$@samsung.com>
In-Reply-To: <006e01da326f$f07ea040$d17be0c0$@samsung.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 10 Jan 2024 20:40:48 -0600
Message-ID: <CAPLW+4mKQOse6pmJskeMOka-KKmKxE4kRZkD4kJsu3G3U4YwfQ@mail.gmail.com>
Subject: Re: [PATCH 07/13] clk: exynos: Add Samsung clock framework
To: Chanho Park <chanho61.park@samsung.com>
Cc: Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
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

On Tue, Dec 19, 2023 at 5:38=E2=80=AFAM Chanho Park <chanho61.park@samsung.=
com> wrote:
>

[snip]

> > diff --git a/drivers/clk/exynos/clk-pll.c b/drivers/clk/exynos/clk-pll.=
c
> > new file mode 100644
> > index 000000000000..9e496ff83aaf
> > --- /dev/null
> > +++ b/drivers/clk/exynos/clk-pll.c
> > @@ -0,0 +1,167 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (C) 2016 Samsung Electronics
> > + * Copyright (C) 2023 Linaro Ltd.
> > + *
> > + * Authors:
> > + *   Thomas Abraham <thomas.ab@exynos.com>
>
> Need to correct Thomas's email to samsung.com if you want to keep his
> original credit even though his e-mail was already stale since he left th=
e
> company.
>

Thanks for the review, will do in v2!

[snip]

> > + *
> > + * Authors:
> > + *   Thomas Abraham <thomas.ab@exynos.com>
>
> Ditto.
>
> Othewise,
> Reviewed-by: Chanho Park <chanho61.park@samsung.com>
>
