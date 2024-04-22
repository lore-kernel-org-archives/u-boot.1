Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A801C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 09:51:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9DF8883C9;
	Mon, 22 Apr 2024 11:51:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nEatQq2i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EEA988379; Mon, 22 Apr 2024 11:51:09 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A05688356
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 11:51:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6eb7a0b3fe7so2504840a34.2
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 02:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713779466; x=1714384266; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oNvCLqOIAuVR5zV5boDljqotyarc+cqB+vXgG62eo3E=;
 b=nEatQq2iCS2YYHksPDSvmJzjKk7Vl+Hu+qghWxV4sYXEGUV30Piu0lGvTuWs0Bb6Nc
 7iwif/uBE0gJh+a/8mT3BbesZwI1XxWKh2wOeoqEX24lwrf4DnM2Pa439cJ8YAT8msZB
 UEohXcpzZv6bRd4KPYrTcquTeZkI8eSqbrmIKBHjTM3AQ2apBnMxltjUnStG72xHTURE
 cP7MHGTSuUe9G7oI8wXfQ5RqVYFWoGecN/Y0+ZxTp6uLFyhdCb+p70NU94ppr/KIEVWK
 CvkI653mM8UoRMJsgosGoJfpageg+GS9/QflVOLRAKnJPYWcchE4NlPrbsoe2l8vT5Ox
 7hTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713779466; x=1714384266;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oNvCLqOIAuVR5zV5boDljqotyarc+cqB+vXgG62eo3E=;
 b=vYf51M0VNckRZRHLNR6XreTwtJZfwhaR/QhPVIonzAanKfykmnuiwLxeorHQ5RXIWH
 7bhy5ET5gXzNoGAr/WOoB0LivmF8Wp3QsQhnjqidBLrOsX/DZAaqOAh9jYG0b72lxEcK
 qwZFMSLqz2gP3e8YehfXrzhef1r0F8N156E3B9Djb4KXBQyQSBDVnbxJcJhydLA0F11y
 +cz/qC1u9Apd2sro6VcmMHLyMuE3kOGzZ2PjNX3ON9SwRyZwWrqgCpWWKWSAVsVLVXq9
 G/AkuvRDRskZBMLBFBa0H0yZSy+Kt9AxEzfCwkhJD+f7RlR1SifUM3wwymAVHEo/HDHb
 TzPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCULnRDH1oN8zLmskEfUe4Nb3JckgE9seyf7diCqVzComHKw81hx5s0Z8NyksKkXRUtCGAZpyWFjjUjdsluiCG7t2/O0JQ==
X-Gm-Message-State: AOJu0YyPkjOeeb0gPF1uPcZ9ypmv+/mVrH1r0s6/QXq3h5nmiUIIdIhb
 77tFtr5DIXRP3xKX3ms4ptPDiLmva1mUNZWMGskSFECXOa7tDBgepotuKRgwTLEF3xwZFDmJ0+1
 TOPkwv+NdOvrqzZJC5EEGTn911i/z6uCAW+/r7w==
X-Google-Smtp-Source: AGHT+IEnHGcdo8Z0g1lSmxRWDVovoG1U+nhJueDFjyj+501IgQB4bbf2+ECd4L0xXReXT9Hr2mMysIX+qquk2Wg7vKw=
X-Received: by 2002:a05:6358:d395:b0:183:b879:389d with SMTP id
 mp21-20020a056358d39500b00183b879389dmr11443760rwb.11.1713779465799; Mon, 22
 Apr 2024 02:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240418-b4-qcom-rbx-fixes-v1-0-e524eb29ae86@linaro.org>
In-Reply-To: <20240418-b4-qcom-rbx-fixes-v1-0-e524eb29ae86@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 22 Apr 2024 02:50:48 -0700
Message-ID: <CAFA6WYNXF9pVT0asf68vEXr1g8MRmzda7VXvf882H5C7jJEaMw@mail.gmail.com>
Subject: Re: [PATCH 0/3] qcom: switch to OF_UPSTREAM
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@denx.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Ramon Fried <rfried.dev@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 u-boot-qcom@groups.io, u-boot@lists.denx.de
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

On Thu, 18 Apr 2024 at 10:24, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> This series does the initial switch to OF_UPSTREAM for Qualcomm
> platforms. The DT files we have in U-Boot are outdated by now, so drop
> them and move to upstream.
>
> Patch 2 drops all the Qualcomm dts files that are now provided in
> dts/upstream. As some of the files exceed the 100k size limit by
> themselves I thought it would be easier to just lump them together
> rather than trying to split them up.
>
> The associated qcom headers will be cleaned up in future patches.
>
> ---
> Caleb Connolly (3):
>       mach-snapdragon: use OF_UPSTREAM
>       arm: dts: drop qcom dts files
>       qcom_defconfig: set SYS_INIT_SP_BSS_OFFSET
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

>  MAINTAINERS                                 |    4 -
>  arch/arm/Kconfig                            |    1 +
>  arch/arm/dts/apq8016-sbc.dts                |  729 ----
>  arch/arm/dts/apq8096-db820c.dts             | 1137 ------
>  arch/arm/dts/msm8916-pm8916.dtsi            |  157 -
>  arch/arm/dts/msm8916.dtsi                   | 2702 -------------
>  arch/arm/dts/msm8996.dtsi                   | 3884 ------------------
>  arch/arm/dts/pm8916.dtsi                    |  178 -
>  arch/arm/dts/pm8994.dtsi                    |  152 -
>  arch/arm/dts/pm8998.dtsi                    |  130 -
>  arch/arm/dts/pmi8994.dtsi                   |   65 -
>  arch/arm/dts/pmi8998.dtsi                   |   98 -
>  arch/arm/dts/pms405.dtsi                    |  149 -
>  arch/arm/dts/qcs404-evb-4000.dts            |   96 -
>  arch/arm/dts/qcs404-evb.dtsi                |  389 --
>  arch/arm/dts/qcs404.dtsi                    | 1829 ---------
>  arch/arm/dts/sdm845-db845c.dts              | 1190 ------
>  arch/arm/dts/sdm845-samsung-starqltechn.dts |  460 ---
>  arch/arm/dts/sdm845-wcd9340.dtsi            |   86 -
>  arch/arm/dts/sdm845.dtsi                    | 5752 ---------------------------
>  configs/dragonboard410c_defconfig           |    2 +-
>  configs/dragonboard820c_defconfig           |    2 +-
>  configs/qcom_defconfig                      |    3 +-
>  23 files changed, 5 insertions(+), 19190 deletions(-)
> ---
> base-commit: d5460b082cd6afd0e07c0ec0e5a82d1af8dc09f7
>
> // Caleb (they/them)
>
