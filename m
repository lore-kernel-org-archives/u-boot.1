Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A01C3ABA9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 14:19:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AE5B82B39;
	Wed, 30 Apr 2025 16:19:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EwS6UK5P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 113F2820E2; Wed, 30 Apr 2025 16:19:47 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD2688210E
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 16:19:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-707d02aca67so60818157b3.2
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 07:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746022782; x=1746627582; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k8QxU6TfXSi2Tzp11BpCybSOtIvf+LwBTkN8kEczzAw=;
 b=EwS6UK5PK6iRxxCktJ1kJ5ioXRacSVToieWHFrkHhIgBeg+1cRGgesnvcZPkGjnwl5
 brxu04IqS4tubfsUfvKOxWipp/q/U1DSnB6hRPtIk9rxtqmCbNKlsnFgD02wko1lFhAN
 LkVeU5cO4OQiDtTpGG/wrW8Fn0kVTB3BY9QDVLcTVJqE2sTXmszWOeRtB8vA795vx/a4
 zrSGV2hTRddHncvtHOx6voT3h2ECDXCTZaTkZmV2styLDzQzfnEkeEFnj/IXVe3rZhTp
 M/KIArVMcZrmQqeb/omW1jiFRdGre2gd5XgLbxp/SJQG1W+qO5QzotFv0CoijaT5qtjz
 dsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746022782; x=1746627582;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k8QxU6TfXSi2Tzp11BpCybSOtIvf+LwBTkN8kEczzAw=;
 b=dzxjNRpw6HkIi3VE4gpQV5hfkVR73sLlJovUiHWX0vfqRNIVBQ2TM0SszFHYKRCLGU
 yWimmPsva2j21DlpOkDlYZOfdSQV82mhwr4Caj6FIlF+evaN088fEoLdJp5rS3xrTP3S
 tYiaWUGhv/bLuFLJC+VRAhSTk5EM7EGRNguQ/hLmG9rWyUSTSJBTd0lvrwAx36x+oxBF
 AJKqZlbtjvEnHfk+ZX+6+FM+eO6gXqX+eXPK5aPk+fz/ReNFblD+2JkhRDmZhGWVyxkQ
 i37Pexc93ZGEkh/Sjv/cOOgp91ZpmcbLSgFdI9MMgXx07e9sDhZOcEeRLGeSW16P18G9
 4Hpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxCLnQPf9KpE4cOa75k1UAIDf6fbJruj7IqdWGZGxUX0K5qLheV79D4/wnQo/66u5mNS33f2Q=@lists.denx.de
X-Gm-Message-State: AOJu0YxQB8Mx2pRgdvx8ip+sjNvBFBi9uWaRl/D4TFRx7GAwUf3TCnO7
 k8wCHImHy9ZQBEqFlxDA29uKfqhaBGvElis7M9sEGKssslatRcnRkMhigu6HZfipxhy0LCQTylC
 amW8wJlfO0/JPs0eMr9tyNJZV1O9nirGyf11cow==
X-Gm-Gg: ASbGnctquz5GLGMJE8WLbdkz0XUy2nVgnZmMMeMCah7pFwoZT7AqZDToSNKBnb2HjaT
 Ohh4j1H6PoYbK29qjMpgqHhflmfIAOfH1H3tGKFByyodcq+mu+HfcGwxvXISYFmcarL6JhAkRNb
 usYqT1RHQc7u4doBcpW32IU4E=
X-Google-Smtp-Source: AGHT+IGrPF9NbMFlORBMX4E1LFsHehOcCU1kr6y6KxGA1qMMFK/OeZY1TeW3/0gdjTMKMQLfAATQgFUhN3lrFJtYbIE=
X-Received: by 2002:a05:690c:700b:b0:708:73bc:abdc with SMTP id
 00721157ae682-708abdac21fmr49338257b3.22.1746022782658; Wed, 30 Apr 2025
 07:19:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250430073405.14396-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250430073405.14396-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 30 Apr 2025 17:19:06 +0300
X-Gm-Features: ATxdqUEjD1G66B3uHaB_7yS5AJAVPDR9cD2BFCxmWlaDX2KovQMOpSzhERocGW8
Message-ID: <CAC_iWjKmMACf4P8_iQGsu95bSqeF1E+6gG3KcfGX1By=Y0HuMw@mail.gmail.com>
Subject: Re: [PATCH 1/1] boot: let BOOTSTAGE_RECORD_COUNT default to 50
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Peter Robinson <pbrobinson@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
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

On Wed, 30 Apr 2025 at 10:34, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> BOOTSTAGE_RECORD_COUNT=30 is too small to record booting a FIT image
> with EFI kernel, initrd, dtb as seen on the StarFive VisionFive 2
> board.
>
> Increase the default for BOOTSTAGE_RECORD_COUNT to 50.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  boot/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index fb37d912bc9..2456856a572 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -1170,7 +1170,7 @@ config BOOTSTAGE_REPORT
>  config BOOTSTAGE_RECORD_COUNT
>         int "Number of boot stage records to store"
>         depends on BOOTSTAGE
> -       default 30
> +       default 50
>         help
>           This is the size of the bootstage record list and is the maximum
>           number of bootstage records that can be recorded.
> --
> 2.48.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
