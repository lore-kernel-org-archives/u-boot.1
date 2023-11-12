Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DCBBC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 03:09:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82DB786FED;
	Sun, 12 Nov 2023 04:08:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S0QSiEFj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98A1F86FD0; Sun, 12 Nov 2023 04:08:49 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7C2B86FED
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 04:08:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9e8b36e36e0so10859466b.2
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 19:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699758527; x=1700363327; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fZCNrMviYD8RBukElvLYm/vkJS252L6D1RNFuwfTqh0=;
 b=S0QSiEFjvSIrMYc9owaZ19+xtv+0OogZ3Gj0/W4nZspOogjcJ/izQJQLKy9IPRfdID
 SWeYOUFfrv97dEzVDxqgSYNYF31DFlnrCZRtUq0DvzI2wajohCPiL28xuuuKSjPkbdp/
 2Li5F2qFPtRfVBuen3fIMCSwzwyFJyhSHXN8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699758527; x=1700363327;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fZCNrMviYD8RBukElvLYm/vkJS252L6D1RNFuwfTqh0=;
 b=pYY7nyktSTo3Q0SX2QKik8uwg3QuhFYWqyF8CSZp/rStLx1fgMsrImiHO3yDI4MY9p
 vFWSOAhYM4YI9rYAMO5oxtmaxDWAIKD06I9KdHJNJ/HfoW3LRLxl1XQexDL91kw1Kz05
 ZC1eyZOoS1URZUO2tfU71+e9WpBeyIvzYa9a80Mr+EF4nICdZnAcyO6qKJZ7y9sVFuKn
 y3hfin3QdeECtkUx+td4Tcj0PjClYe7BMCjl/wwT36Rnt28JXfsK3s0BhRmJrRyThomM
 fBcZud0ETXItfAIAxsYBR+0rwtjCiIRBlf5iyOwcF27RiptXy8yN+p9wTU0CarZg5DCI
 lWBg==
X-Gm-Message-State: AOJu0YyBi7bNK6yGUYwPpn51kmX8Bjk355acClZPbMc2GmiZkw/rJr49
 21I9KfkuJl9DLRiapYjtXUJAtBJlPLPzxy6KO7PS0Q==
X-Google-Smtp-Source: AGHT+IEnv/khBCDVDe1RuoYjaXPk5sPjF8SGhU/HEtwD1FCkuCTtCdIXnpat1BOKW4YXPIiJx/J4OsnmpLg693hqGRo=
X-Received: by 2002:a17:906:350b:b0:9e0:2319:16d4 with SMTP id
 r11-20020a170906350b00b009e0231916d4mr2439770eja.40.1699758527129; Sat, 11
 Nov 2023 19:08:47 -0800 (PST)
MIME-Version: 1.0
References: <20231111001329.537704-1-i@shantur.com>
In-Reply-To: <20231111001329.537704-1-i@shantur.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Nov 2023 20:08:35 -0700
Message-ID: <CAPnjgZ152z25UYzuwyeVh1xE6rgqaxJu4AKRBw1+wermHW5wVw@mail.gmail.com>
Subject: Re: [PATCH] configs: rockpro64: Enable SPI command and full BOOTSTD
To: Shantur Rathore <i@shantur.com>
Cc: u-boot@lists.denx.de, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com
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

Hi Shantur,

On Fri, 10 Nov 2023 at 17:14, Shantur Rathore <i@shantur.com> wrote:
>
> RockPro64 has a 16MB onboard SPI chip and current u-boot takes
> around 2MB, we can enable more features.

What takes 2MB? I have never seen U-Boot get close to that large!

Regards,
Simon


> Updating config to enable SPI commands and full BootSTD support.
> ---
>  configs/rockpro64-rk3399_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64-rk3399_defconfig
> index 4cd6b76665..cad0b8a5d7 100644
> --- a/configs/rockpro64-rk3399_defconfig
> +++ b/configs/rockpro64-rk3399_defconfig
> @@ -46,10 +46,12 @@ CONFIG_CMD_BOOTZ=y
>  CONFIG_CMD_GPT=y
>  CONFIG_CMD_MMC=y
>  CONFIG_CMD_PCI=y
> +CONFIG_CMD_SPI=y
>  CONFIG_CMD_USB=y
>  # CONFIG_CMD_SETEXPR is not set
>  CONFIG_CMD_TIME=y
>  CONFIG_CMD_BOOTSTAGE=y
> +CONFIG_BOOTSTD_FULL=y
>  CONFIG_SPL_OF_CONTROL=y
>  CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>  CONFIG_ENV_IS_IN_SPI_FLASH=y
> --
> 2.40.1
>
