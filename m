Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E946C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 10:50:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CC7A88305;
	Thu,  2 May 2024 12:50:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PtJe2bmL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E81B388C07; Thu,  2 May 2024 12:50:26 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3D84882DA
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 12:50:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-51bae805c56so8972439e87.0
 for <u-boot@lists.denx.de>; Thu, 02 May 2024 03:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714647024; x=1715251824; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rI0mgMyBlFYATSebN6EOnnNm2GMsBfoicWWw8PT6yn0=;
 b=PtJe2bmL6rwch629jgRIPROeWbOZP3aRyrKDW7D/lJfSqfYfNvMgoylouE8mNFeD4I
 fOYZvjjOzv6QzC4b+wBl9SlYbYp10gT5v7MiBiClFxRW2DQtEi6c2m5FXbtPqIX1JcZO
 oAgF7AGRemyZ9co5HSmLUAqpna16bGq4XeuVHt3Yw7yDqPrrI6qavKAd/a8G+iDpmFz4
 xRDfmaCKUJdZ7dKevSN6I24V+ObGX28lRgor/tP+2xRmbU7+Fg3i16hEV0CPm6yjc5Zo
 PFI+GUpSjIgA5Zepp3zmOxs9jZJU98J+hXuH8AUWjKSJoKsMmRblklTVKkoshOYkLvGN
 B71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714647024; x=1715251824;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rI0mgMyBlFYATSebN6EOnnNm2GMsBfoicWWw8PT6yn0=;
 b=mxuROAJXSjctdWQ17RTtTqgMpo6RDbdxg+UcbC/VIfndr0g5xdyBdCXuBYDTTx4dj1
 d7ObbIc3QwPUEFHt9RSMMSGgkRXaCZBZsCa8MYPy5uewUIAncl8raOhWPIoY6hXZnsKb
 gWI/T+I5LjyakbpjIhtBV5LfNx6IRw38QPgiruK1YSq7NYHFHTNZ48T8QdvYfmYRCnpO
 f1+xmyMsvmvJ/LZCRE0ycIK4iQ+FqDWMnWC5xc1XP/7J030I5IamFai6wRYbdaZkW5bx
 hvPngBs1J1moSvkZubjB8n0LFRN2XENwfM4J5gGxhq57yPr6XenByO6zgzEhznMYGLwy
 8V9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPCIDGaOtZ3NIfAZ30/YFx6XTFeQz2FeahS02/13DRoKrRzdYkg8VhNUVpdrWo5Her6vzMhwAuxNBYfeqfxWFyDLZnlA==
X-Gm-Message-State: AOJu0YwSSfk0CyCLnZcYPmXpWUEz+iww3rz/p0LAGryqLC1wUlfsjD3q
 Lh+9VNAs5Hq2dkpkpHjMBmd9OoRnXqgDKa433o7xc7VuuqjDF1x7xNHrr1e8MFCVbhFm/ToM67V
 wkcifi5Ve3/VoIXUWEvRXkJ/oD3k=
X-Google-Smtp-Source: AGHT+IGOPuXuXBW5Prsydo0Y6l0U0AzBcOLQMxvMIgEBCHZBQwmxPhD+aaLmDP8k8KaVNpO65Xbd8z+Q89pPeY3RJCY=
X-Received: by 2002:a19:3810:0:b0:51d:9818:33fa with SMTP id
 f16-20020a193810000000b0051d981833famr955201lfa.68.1714647023916; Thu, 02 May
 2024 03:50:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240501162308.875193-1-jonas@kwiboo.se>
 <20240501162308.875193-23-jonas@kwiboo.se>
In-Reply-To: <20240501162308.875193-23-jonas@kwiboo.se>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 2 May 2024 11:50:12 +0100
Message-ID: <CALeDE9N85xFu1fLLBJ7Vsh5A1tT12YHyLJMhZkh17R-tdtGn9Q@mail.gmail.com>
Subject: Re: [PATCH v2 22/22] rockchip: rk3399: Drop ethernet0 alias from SoC
 u-boot.dtsi
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Dragan Simic <dsimic@manjaro.org>, 
 Christopher Obbard <chris.obbard@collabora.com>, u-boot@lists.denx.de
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

On Wed, 1 May 2024 at 17:25, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Remove the obsolete ethernet0 alias now that all board device tree files
> have been fully synced with Linux kernel v6.8.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> ---
> v2: New patch
> ---
>  arch/arm/dts/rk3399-u-boot.dtsi | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u-boot.dtsi
> index 6af9621ac3d0..b6b43271172e 100644
> --- a/arch/arm/dts/rk3399-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-u-boot.dtsi
> @@ -6,7 +6,6 @@
>
>  / {
>         aliases {
> -               ethernet0 = &gmac;
>                 mmc0 = &sdhci;
>                 mmc1 = &sdmmc;
>                 pci0 = &pcie0;
> --
> 2.43.2
>
