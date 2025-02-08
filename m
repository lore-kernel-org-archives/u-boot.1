Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01872C02198
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 05:10:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15973807F1;
	Sat,  8 Feb 2025 06:10:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ANVdGdWe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 038D9807FB; Sat,  8 Feb 2025 06:10:34 +0100 (CET)
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com
 [IPv6:2607:f8b0:4864:20::92e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EA2180756
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 06:10:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-8670d630d2dso274359241.1
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 21:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738991430; x=1739596230; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vAxDz/01sr2DjSv7eZzus36n3K2AwCvlWqwHgZM/bZQ=;
 b=ANVdGdWezWBOMaidLE1RJO387wqV9HrMK7qqnyOOj+Hf8EbyFxK/D6Pvy6QF3qBYeW
 fZO0moWZdl1K8ZHP1KujwjiLqJ9VQ+BGNmCE4t5TuGqOBV468BKTeUZrQ1j3lymDU3+r
 TlfIzIEPbr7g8giWjrN5jH7V/hJCMzZVlECL9TIXA6Ip6a0hYcUmWlaNwieETQQ4wfh9
 r52dbUGvPvy8RMY4ToATOGdzH4m3j7P6ZAFUB9Nu/ZtjKJqvl4TA/aoxoFmKjVH8pA5m
 thRZ9QipmR/zz7e2NU/QaEBH3BAH+djEyWOikvgTmS2ocFVUF1p2qlH8WZ1TGD3NwxXk
 CTrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738991430; x=1739596230;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vAxDz/01sr2DjSv7eZzus36n3K2AwCvlWqwHgZM/bZQ=;
 b=URP+Et/AHoWnNJvARHp3ahgZuxjyanJlOEpP8CwHr4pE5/yyxBavX8C8HVW3hCmTF2
 8CS0mlirLVWdWRelKHT3RymGO3GbN/YqBcMpf6IxTQWqKJwICMpG0j22uKzLBKzIgxlw
 t29JDC36UTrNaIluQFzx3HiRqyCJpmK15BFA6nC9bB/ESJdNgmZnDX4EJr/wHQ/Lzx+g
 X9gfqqeIjWUTslKw0VX1JsSfeT+ab9UA+L9e9CYOHS5Ak4Vk8pxFdpx60UEhwR03gMsb
 FMIGYL6DAW+eXq6t9Q0gnayxLMeIMngFaKVAS/hRtW8xXV1NET5Q9SUkfMFopprjyPpo
 kYCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUL7Q2TnZKv0E/dXTh7oLVmyO9J0A+9RQ+nFnOXvJTDEZRXWeVgqYA6PcZSXjwiwStJhbL1MN8=@lists.denx.de
X-Gm-Message-State: AOJu0YyXLo2c3ciGnjdp2y7QNw3QLzHkVEwLRahPX2cgiUe+BeLV7brU
 /vL5wPWPprWHZ54Y6jiFyGHB2FOL2+lTDRw4byXw/V8uB2mT7ssGHiS+AzbIOv9dzw18d+CNZo/
 cUyJHJ4OW8Fy9blllR0EaXX1f4ZAcYDqeunD77g==
X-Gm-Gg: ASbGnctA1Abl6XNFMtkc+/x0dDpy0JVBaJGd9ytE7o4Np0bn2etXNYPRVPN3nLb7wuz
 Yd4w6ExjLiAUkZU98FAL07f7txzQnenLCBzaCTwXcyPrGiXR5MlOHfnjUrCYCaSUMejjb44cSEg
 ==
X-Google-Smtp-Source: AGHT+IF1OePhpixY8MExnlZAYYu5hQelOH6CP/pigybe7MWvnwey3sa270dXhI7lfXomATUvHbz0Y6i29kNNPGWFp1s=
X-Received: by 2002:a05:6102:5689:b0:4b2:48ba:9943 with SMTP id
 ada2fe7eead31-4ba85f75f88mr6246610137.24.1738991430400; Fri, 07 Feb 2025
 21:10:30 -0800 (PST)
MIME-Version: 1.0
References: <20250207172116.117749-1-heinrich.schuchardt@canonical.com>
 <20250207172116.117749-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250207172116.117749-2-heinrich.schuchardt@canonical.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Sat, 8 Feb 2025 10:40:19 +0530
X-Gm-Features: AWEUYZlCPAFWOZ4bbm9Nf89NFkhF0hN5V3qs5nMXGQjhIf343N4yr2eQ9GL6wUk
Message-ID: <CAFA6WYP3gmth8BOSkHMjjk=2mBFQ3P=Rg3+s1DZgpCqZp6Wxzg@mail.gmail.com>
Subject: Re: [PATCH 1/6] configs: add jh7110-deepcomputing-fml13v01 to VF2
 defconfig
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

On Fri, 7 Feb 2025 at 22:52, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The DeepComputing Framework motherboard is a JH7110 device support by the
> upstream kernel. Add its device-tree to the list of device-trees to be
> included into the starfive_visionfive_defconfig.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  configs/starfive_visionfive2_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
> index c3f2142ae1b..821aea9c236 100644
> --- a/configs/starfive_visionfive2_defconfig
> +++ b/configs/starfive_visionfive2_defconfig
> @@ -78,7 +78,7 @@ CONFIG_CMD_WDT=y
>  CONFIG_CMD_TFTPPUT=y
>  CONFIG_CMD_BOOTSTAGE=y
>  CONFIG_OF_BOARD=y
> -CONFIG_OF_LIST="starfive/jh7110-milkv-mars starfive/jh7110-pine64-star64 starfive/jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-starfive-visionfive-2-v1.3b"
> +CONFIG_OF_LIST="starfive/jh7110-deepcomputing-fml13v01 starfive/jh7110-milkv-mars starfive/jh7110-pine64-star64 starfive/jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-starfive-visionfive-2-v1.3b"
>  CONFIG_MULTI_DTB_FIT=y
>  CONFIG_ENV_OVERWRITE=y
>  CONFIG_ENV_IS_IN_SPI_FLASH=y
> --
> 2.47.1
>
