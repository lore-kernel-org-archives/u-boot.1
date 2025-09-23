Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB7ACAC5A7
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 06:47:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3354F80050;
	Tue, 23 Sep 2025 08:47:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VoOXZym7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0545B83390; Tue, 23 Sep 2025 08:47:08 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBD358004F
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 08:47:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-71d603acc23so39598017b3.1
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 23:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758610024; x=1759214824; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TW+qv2vjnis6AGH6qu1hK148eJQ8oScjPNoDvN5n/2k=;
 b=VoOXZym7vipxlIA4sDlWNPrZ15GVnuyWjWfiPyhR0xcCR5Weq7gxzAnJkEYLWL4lTu
 DAqRD7M7+NUJEdrdSr3di1PWb3quJ1bS8jkGySJx0NovOx4xsZqQfaahCBz7ZPxVu+2q
 vMej/mnB/8vowr9NWFsizhCCG198TM8QH4OwcVGh0tU++1veqkUnqKeDVjB157WeRnVh
 egklAXwvQgrHrsFj3Fet9ksPYIrtgcLcmA7HxMJ/h7ZG66A2JztjzDyV0NJWojs4jl6n
 IRIKgqFjaj21A+1/IsmhqaBAg36mPoyo1zZcrckgHiEDgFo/kpctv/SJR48bjQyJ9qfH
 9Ptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758610024; x=1759214824;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TW+qv2vjnis6AGH6qu1hK148eJQ8oScjPNoDvN5n/2k=;
 b=CkERHWxOCxe9HYyGHtR3MKXTtNmtM5N7Fz2mcGT3tGpoe5ugTUVEDmdz2WyMYU4iWq
 L9VAg8IReN7vWqas/JTiyQlzK5x87mkd3Yv/aQTKoUEzqb2mQBtpbgf0PU+Ia7byIpNQ
 c3TXpLRyHAkIbghaNueaWPUv4E5J2QDhbzSrjfSaqOT/DbYw6nJ2ykbbphjEEayS9iCa
 o+h9VHaLQJ8/WjpKsWmX8jyitlivVWwR9qBj0oz+Y5Vph/htN6k5DbocWBwS64GpiF+5
 pgXqhOUkD8BrI25ZuD9KNkeAIJR7qdlra/lX8Du8IGJCV2zh/H9wxDZmD5RFSwXOYpsR
 qkIA==
X-Gm-Message-State: AOJu0YyFWSPOGC/zajQ4BvawQO/b5cT4D0zI5xx4LnwajUuU2O2MrFSR
 rnGWD0Epj1bEjlkjHPe+7dNxuSaYKVBko6rtPA4Ci/oA+7/IJI/mjZL7RM7EaCAuHZ81CxBQM6B
 pIkqH7pdghXgPndb5Q8JK4DS78LXNh44maBpK8ltVoQ==
X-Gm-Gg: ASbGnctjNmE8BvuXs9CtXBGKwQn3i6UdkEsZIIbJ+nJ/OipdEKMwMyfNfT9c0PcKGb5
 fQED2If7gv2FP5X4u/6V6LKc3jsw0FBAA3zs8KiXiV74vAmx1rVEi+0TvaSTVEIsFVedCAe6p2B
 mIGqS/yCb8FMsmFH5MoHbAq1BPGwpZ68RgvZq1xDCNwiMLeoBJ0eyY7hp46ktomviOTyWnLsVer
 jfMG/k=
X-Google-Smtp-Source: AGHT+IGAaq29cOyK1hDSD80xw5oOmaPjTOGXDTGDuDLlH2UpOBoSTTlr/RU8ks3+eJIHW+xfEaK3NpFxU7F/3uSymZQ=
X-Received: by 2002:a05:690c:670e:b0:746:66db:f7ce with SMTP id
 00721157ae682-758a4cd45c1mr11161827b3.45.1758610024526; Mon, 22 Sep 2025
 23:47:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250919210457.291632-1-raymond.mao@linaro.org>
In-Reply-To: <20250919210457.291632-1-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 23 Sep 2025 09:46:28 +0300
X-Gm-Features: AS18NWBwq5Z-v8ssTx5sw7IluKGvaMLNZQAZDX5wdP-Mew2bQxp4dWisliuzuUY
Message-ID: <CAC_iWjKL9hBKKhnTE6w3wn=KSK00mMN6S_MyME2JvfCMtV=sCA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add myself into the list for MbedTLS
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, Greg Malysa <malysagreg@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Simon Glass <sjg@chromium.org>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, Yao Zi <ziyao@disroot.org>,
 Stefan Roese <stefan.roese@mailbox.org>, Heiko Schocher <hs@nabladev.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Mark Kettenis <kettenis@openbsd.org>,
 Baocheng Su <baocheng.su@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Li Hua Qian <huaqian.li@siemens.com>, Peng Fan <peng.fan@nxp.com>, 
 Samuel Holland <samuel.holland@sifive.com>
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

On Sat, 20 Sept 2025 at 00:05, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Add myself into the list for MbedTLS.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  MAINTAINERS | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3fb163aa1db..cbb1d9c3e77 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1292,6 +1292,11 @@ T:       git git://github.com/ARM-software/u-boot.git
>  F:     drivers/video/mali_dp.c
>  F:     drivers/i2c/i2c-versatile.c
>
> +MBEDTLS
> +M:     Raymond Mao <raymond.mao@linaro.org>
> +S:     Maintained
> +F:     lib/mbedtls/
> +
>  MEMBUF
>  M:     Simon Glass <sjg@chromium.org>
>  S:     Maintained
> --
> 2.25.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
