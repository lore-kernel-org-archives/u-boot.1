Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57943CF0444
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 05:34:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 978EE890DF;
	Wed,  9 Oct 2024 07:34:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="o6IUx1oD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75EF4890A4; Wed,  9 Oct 2024 07:34:43 +0200 (CEST)
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com
 [IPv6:2607:f8b0:4864:20::92f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E67688905E
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 07:34:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-84fbee98881so44321241.2
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 22:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728452079; x=1729056879; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=q2Q0rKfNYdWw1CWT/IRZfvyW2qPY7QmZjaF+XLZm7lw=;
 b=o6IUx1oDSQr+ZRcuN6kwhwzDy93JhjNoag5W44Zkacrk6S3UP1UvtGDBNecfeN7nAm
 JCnVE63ar14UW+yZXahzqstsX8s7A5kYYupt7FKj8ft696wuwc8v2joFb1eQ+o18hqM9
 9sgFu15ctXmDCDiibg24zO//h2ZgMFRIWeGRG9CD/n2SkzcVtxl0Orj/VzrdCrHxQd4A
 NYpfJyUyWX8Du2D6Zxr147U/Iw0GeXJjnnIxCZatdlLUdDa3EECMsFywZiMkTSPzIBd9
 gnagHi94diYSufr6/bv1CPIDs3OfJS7sA7ue72a/E1heketZ/krhm6UBc4L6UoemHm39
 UQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728452079; x=1729056879;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q2Q0rKfNYdWw1CWT/IRZfvyW2qPY7QmZjaF+XLZm7lw=;
 b=nYa6XfQQeum+/8P0aHzSyNa8oa8ebVJGdvOX9tE9I5dpUmkuVr7rkkhUBP+B7wptlF
 uguLx/FrZyRMPSNgnmZ+fNXiU43iCIO6w+JFU/GR3KUYj12tXlq0bKqejYxYWm79SMAy
 3tcGfZiUfOigSMW9dPbieDpwbdRN8I37GFsz98e6yHB8EeA/P6xXY8jBysDr8f0MH0ev
 pfVZrD20rnSMbHnWlRv0Fym4KiJjgsmRYzyu6K2HaGyQ4Kiq/XtFLfDgQhwA9PR82tIL
 uEwNnXClETt2pKtcPDP+jFE8AxxDQeWHvvLfk+Cg52JaFp9XR9ZGu13u+w4unMsbLwjY
 4SVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXh4bJplpuW17MPbD4zgmVtLS12/r0bUrmIlqmTDCayemgaPlPYdODBazcaB77s/kzlpAX7RVQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwPWuFJIyQPfZby33Csggeh61ZK5OGGzxSwqtN6w5m/li/gdE6I
 tvllL/myimBSXQfi8AAIng/ecZ7cN7XMiaX0D3tR5GdLpt0GYU1LXe4xA6GTWAF94DLWyPMX1Xh
 wKkXTpo2Snq/9ah4ZB9LeNIZwaJao8YvZxjhNMQ==
X-Google-Smtp-Source: AGHT+IF0nIVYwv100m4LwRHyK0MlO9EQnJVUeoIg7DPjGz9rYpwpDTLlkHBOuFMcmbdsHQH/UbWJn46I9czY3siPEIs=
X-Received: by 2002:a05:6102:50aa:b0:4a3:c3cf:42b1 with SMTP id
 ada2fe7eead31-4a448e3dbb2mr1121487137.26.1728452079482; Tue, 08 Oct 2024
 22:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <20241008200641.2203023-1-jonas@kwiboo.se>
 <20241008200641.2203023-2-jonas@kwiboo.se>
In-Reply-To: <20241008200641.2203023-2-jonas@kwiboo.se>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 9 Oct 2024 11:04:28 +0530
Message-ID: <CAFA6WYObEtwQg5QUFRH1EEc+XT=LjVn=S+8pRMfTGQP3abM4Eg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] arm64: dts: rockchip: Correct vendor prefix for
 Hardkernel ODROID-M1
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, 
 Aurelien Jarno <aurelien@aurel32.net>, Heiko Stuebner <heiko@sntech.de>
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

On Wed, 9 Oct 2024 at 01:36, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> The vendor prefix for Hardkernel ODROID-M1 is incorrectly listed as
> rockchip. Use the proper hardkernel vendor prefix for this board, while
> at it also drop the redundant soc prefix.
>
> Fixes: fd3583267703 ("arm64: dts: rockchip: Add Hardkernel ODROID-M1 board")
> Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Link: https://lore.kernel.org/r/20240827211825.1419820-3-jonas@kwiboo.se
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: 735065e774dcfc62e38df01a535862138b6c92ed ]
>
> (cherry picked from commit e7259a2c4a6f2ebdfc96b8bbffc77fe67604b11f)
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v2: No change
> ---
>  dts/upstream/src/arm64/rockchip/rk3568-odroid-m1.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Acked-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/dts/upstream/src/arm64/rockchip/rk3568-odroid-m1.dts b/dts/upstream/src/arm64/rockchip/rk3568-odroid-m1.dts
> index a337f547caf5..6a02db4f073f 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3568-odroid-m1.dts
> +++ b/dts/upstream/src/arm64/rockchip/rk3568-odroid-m1.dts
> @@ -13,7 +13,7 @@
>
>  / {
>         model = "Hardkernel ODROID-M1";
> -       compatible = "rockchip,rk3568-odroid-m1", "rockchip,rk3568";
> +       compatible = "hardkernel,odroid-m1", "rockchip,rk3568";
>
>         aliases {
>                 ethernet0 = &gmac0;
> --
> 2.46.2
>
