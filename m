Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 154D7C0219E
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 05:10:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DBC180812;
	Sat,  8 Feb 2025 06:10:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YTA46HYv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C719D80819; Sat,  8 Feb 2025 06:10:55 +0100 (CET)
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com
 [IPv6:2607:f8b0:4864:20::e33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96AE780756
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 06:10:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe33.google.com with SMTP id
 ada2fe7eead31-4b6398d477fso755855137.0
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 21:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738991452; x=1739596252; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vdS7ndhWDl/QAeB1kkeqKuz8PSABjFs1iCcaFpGDQ44=;
 b=YTA46HYvQxJ1jXd3HCIyleNHAowjaczrgoW/I03CXkshRVtnzk2UwUo9fQvjUKSP9h
 eSbjkHOElk8PiE52vxyyBIk9WVyBwQPLzMitsOY1BkLQfziTp0DRnx7j+2UfUeEb+gts
 GZC728Q1a/W9Wp//0sB7byjCFFrjss7lVORG8EjXg0erLylvUYDRNLO4dFmVyCYZ44WR
 YeiEtIym0mjqficW24juBZARzfJBnf44hHfmqNx6TuaZRCS/sXit1agfDtyT0oVMt10e
 fKbDH+znFhRi9XqKJ9s44aJ8oPlo7/1uHDcdSnVagF8Q1D5T0Phlv7cpsHjTVRVnEQL8
 jIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738991452; x=1739596252;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vdS7ndhWDl/QAeB1kkeqKuz8PSABjFs1iCcaFpGDQ44=;
 b=S2PP+a5Gvu0oH86zeE8a2PvSWKWXwFzaU8UViXE+aKhn+4j8C5JMWzxb3+24wRr6ER
 HGix8Y2w5/r2F5D5OzVhoFC/vUUx+77aD4omGOIuNzETDWvhtKLxhPRPQaac6fP6M+qC
 BYPtAouKav2HXw2Px7KctFWQPNkih5PE76MKDE3EEVNFUZmGJRrdW7EEQxRKw7o7Rjhs
 QI+93EEkHnJ5LitpNH5HOohxX7JSf1snEYyPZZc7BTtxffhiJOoNtAn3hgh7aoJ83sOs
 O3TgnRvylCap0YSY2fUZDeFpdJwRH4/zI8wmrYXN7p67iZc6Ik5vL579eisfr5w8rXzn
 CNHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVN1gaYItdOl8jq5AS48rq4OhVTsIDII1wditrZ0maDCXje7XfWE59uovPCaix9ghrggUZDstE=@lists.denx.de
X-Gm-Message-State: AOJu0YxR73kmlDI3XwPbaQNd6E7HJBEt2P0o8q9ZKliUHoibHGwClO6w
 qOMmJjFoRDi76lLhViMa1h0VVOmhNtmchPYx4ixBEzcj51kcWZbzwnDTGGyb2eIgkvkOn/E1zkP
 U+2DrvZa3B1+OwmGWc9cWCGVafZ1jz6+5JSyA4Q==
X-Gm-Gg: ASbGncujejiPGcGm4jnB3ye/bttPgFMgyNz8pBZXmtVhWbKGzoM3ACqccE/tZE7z1iB
 va8FVZsUbYGOwms81lV26/z6PllQ+KjuIgNU09Cc4SdU3FQE+wWrTJPT9JpRN2/qGsB/TATbs6w
 ==
X-Google-Smtp-Source: AGHT+IEHr53qO1tB2boyz1Uq/258Wk/VIbtRonUafMy3THr7llU4uFpxOkTTpU2lmjjpY6LUtJFO/nVZ111sACWKEjs=
X-Received: by 2002:a05:6102:32c3:b0:4af:a216:c0d0 with SMTP id
 ada2fe7eead31-4ba85bebd39mr6128207137.0.1738991452461; Fri, 07 Feb 2025
 21:10:52 -0800 (PST)
MIME-Version: 1.0
References: <20250207172116.117749-1-heinrich.schuchardt@canonical.com>
 <20250207172116.117749-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250207172116.117749-4-heinrich.schuchardt@canonical.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Sat, 8 Feb 2025 10:40:41 +0530
X-Gm-Features: AWEUYZkqi641bT4YC60t3aml6wRAkFD-jmtf7NuDLLnkbfFZJ9lpl_TVpVilJik
Message-ID: <CAFA6WYM_LZme4dRgZw7J3LjpHmr6B=xzPoiAwevqUSnoVEvKGA@mail.gmail.com>
Subject: Re: [PATCH 3/6] riscv: dts: jh7110: add DeepComputing FML13V01
 device-tree
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Hal Feng <hal.feng@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>, 
 Sandie Cao <sandie.cao@deepcomputing.io>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, E Shattow <e@freeshell.de>,
 "E . Shattow" <lucent@gmail.com>, 
 "Leon M . Busch-George" <leon@georgemail.eu>, H Bell <dmoo_dv@protonmail.com>, 
 Lukas Funke <lukas.funke@weidmueller.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Matthias Brugger <mbrugger@suse.com>, Simon Glass <sjg@chromium.org>,
 Andreas Schwab <schwab@suse.de>, 
 Nam Cao <namcao@linutronix.de>, u-boot@lists.denx.de
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

On Fri, 7 Feb 2025 at 22:53, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Add the u-boot device-tree include needed to support the
> DeepComputing Framework motherboard (FML13V01).
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>  create mode 100644 arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi b/arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi
> new file mode 100644
> index 00000000000..ab882d07f6f
> --- /dev/null
> +++ b/arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi
> @@ -0,0 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2024 StarFive Technology Co., Ltd.
> + */
> +
> +#include "jh7110-common-u-boot.dtsi"
> +#include "starfive-visionfive2-binman.dtsi"
> --
> 2.47.1
>
