Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D91AC77B7F
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 06:37:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB87F88966;
	Thu, 29 Aug 2024 08:37:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oHbYWi9C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E36A3889D2; Thu, 29 Aug 2024 08:37:08 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E854D871C9
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 08:37:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5befe420fc2so237949a12.3
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 23:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724913426; x=1725518226; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RWvHx1fFjfqOkmC7953iV8t9j0G8Rh1vPuY/GStPbyU=;
 b=oHbYWi9Cq//dGhMSMfZUb/+sQddhiYDnHv8TxfRuV9VgQ8l1l0w/B54gvh9zzfPSKT
 kH14yijVsie4eAfJvx6E6fmkLtSSwPLsz+T1UgImE8rIFx4muxUCVs5FDKaVpsbRs26r
 glL9UqrtvYCsgSKFsqCDPdQc9TeBp1iFLIhFNtkmVDOYyePQ4CH4/raxAxKQKKKVz+/Y
 ctm7b8PtGG+iN2Cz3AHM1JBVYDdlxnF3T5lZfWHk6Ud1Xv2aCsIkfK40pdfrPd+JR3Ao
 P3QW2qybXU9zRoqMkYXBRZ+A/2Pw9WlzNY5wFnlSNi+bMjEaoVfoNqgTfBMB+33zeMld
 OAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724913426; x=1725518226;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RWvHx1fFjfqOkmC7953iV8t9j0G8Rh1vPuY/GStPbyU=;
 b=Lia3/DrodEb3DtWmNAVUEvZXpewmruBpgDWKsbnyyTt8YzrNjXEm5lP6kZbCSxF3l8
 lUZxQp7neMfWrjnkvhCY26fVFeX/0+Y4OJ57QpjdhLvhPYezQbNa81I3r1267rtlT2pj
 GJa1DweuZam66YmcWo4cljRvh3zKl8YsLPTiJUq46C1hqYMpKmkvAqwBsSpw0V94qKd5
 Ms/Zv1QGvPY7ZuFSx/y65zZ2HLQ5gfnGAxqFkdZSp60egIvKmZd+C1yI9IlII4EnH9T6
 QeS2akKItTZSJTir650tQRcxZVBnXCQk+4QpurJf671PcsjAhHlBzBPn+VQPR3T3Dm3R
 ar4w==
X-Gm-Message-State: AOJu0YxezAyT0VGL+677Av9GEzHrlpBrZ74HVl1vBRFrOGmbgwiUpH5h
 Z0IqMetDLhlrAH440Zk+EHwJ5ffOCamlN083xWKm5pQxVYC1VwljGrowBRjVjz0iqS14+CUJg6N
 oMGdWAgHYF8vH6g+JZ4Q4kWSV09jedeWt+9JQiw==
X-Google-Smtp-Source: AGHT+IHdWLD4ezmp68bqB75Gm2qZ9fAEhzqfVDFpC6t62/2WihUK0Re9AwtLK5nTbEJ7luHg5peD/tzi9OPhqH93CmI=
X-Received: by 2002:a05:6402:2686:b0:5be:edf7:5b84 with SMTP id
 4fb4d7f45d1cf-5c21ed8529cmr1168946a12.24.1724913426116; Wed, 28 Aug 2024
 23:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240828014538.3322013-1-sjg@chromium.org>
 <20240828014538.3322013-18-sjg@chromium.org>
In-Reply-To: <20240828014538.3322013-18-sjg@chromium.org>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Thu, 29 Aug 2024 12:06:54 +0530
Message-ID: <CADg8p965sE+-9JD6FVOPowxqkA8u9bNye67Frf-ehYyRLa4--g@mail.gmail.com>
Subject: Re: [PATCH 17/18] rockchip: mmc: Fix a missing colon
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Dragan Simic <dsimic@manjaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>, 
 huang lin <hl@rock-chips.com>
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

On Wed, 28 Aug 2024 at 07:18, Simon Glass <sjg@chromium.org> wrote:
>
> Add a missing colon in rk3399_emmc_get_phy().
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---

The change seems to be adding a newline, and not a colon as the commit
message is suggesting.

-sughosh

>
>  drivers/mmc/rockchip_sdhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/rockchip_sdhci.c b/drivers/mmc/rockchip_sdhci.c
> index 15b4a39770a..6c5c8781c3e 100644
> --- a/drivers/mmc/rockchip_sdhci.c
> +++ b/drivers/mmc/rockchip_sdhci.c
> @@ -230,7 +230,7 @@ static int rk3399_emmc_get_phy(struct udevice *dev)
>
>         grf_base = syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
>         if (IS_ERR_OR_NULL(grf_base)) {
> -               printf("%s Get syscon grf failed", __func__);
> +               printf("%s Get syscon grf failed\n", __func__);
>                 return -ENODEV;
>         }
>         grf_phy_offset = ofnode_read_u32_default(phy_node, "reg", 0);
> --
> 2.34.1
>
