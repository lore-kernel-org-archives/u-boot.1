Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74FAFC021B2
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 01:53:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77172806FE;
	Fri, 21 Feb 2025 02:53:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m+biTmsE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BC56801DE; Fri, 21 Feb 2025 02:53:19 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D01BD8004F
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 02:53:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-abbac134a19so260491466b.0
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 17:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740102796; x=1740707596; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OLdl3eL+F3lZ1t+UqlA+b+4Ir1EfKRkDqfMvujjMGKM=;
 b=m+biTmsEYEt2qXuSNwJsIC8ZKCH/R2t9NHd7LddbgkUUW7zVjCrLTBpgsm0POf7pXb
 qI7JTuHd3O8UcFdPCAMSTuwI06jFDwWergqcS7thSC3wUKqEezRFDEV1QElVh/mimG/h
 /w+06AUlhLzBG+yTUB+kREq9N7DyKMR6OstVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740102796; x=1740707596;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OLdl3eL+F3lZ1t+UqlA+b+4Ir1EfKRkDqfMvujjMGKM=;
 b=vWFVxCsyOfrKMbhE3CZD68nUaxo9Ni1JS3MWpWIkP7MY3/TLUAH0DAgf5VGHyK0npm
 5zQDx/FXpaNj1RTUg+dSS84+MFmLvP4WjBMJ7CD4GOTAZH763RgIy88sKTAhHJvcnuBp
 Ccj9zaUfX/WUG1DhI4z5V44CGVAazIFaxUA8i5bDcrcKbiv26nL0dhNbhWRaD5PxDTsb
 jPzBFz17LqZZ4IZe8FuY3J13pktP6jgKRRAPuUmmqrdGnTipezW1la4PoVJcb9FdgcmP
 l77glKVk3xqoY0hl3LhPi3WVRTbMky7pGWojbmIZo3PBpIewYwnE1Y+Pa35DyUXWEN7E
 aRIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3eruEPCT5Qx7E28ydARDxgm1n68DU2HaNxuxQ1sONbg/qim8ngAvFmUKlvcYocsxU7W76dRw=@lists.denx.de
X-Gm-Message-State: AOJu0YzrFwaZMZaBajaCXJfOFsOVOgpzO8nOUpNA5meCQeyiy1Xyqp7+
 vKPy3eEdUjXr8uZ4BjB5GXVZNGhxySo7Jefsup06XhKam+rxW63KafPpKbHbUcg62cJqAUsBFHV
 UF/TZ5Z1B4b6oYhwtcRlZC9344etfudBXlA54
X-Gm-Gg: ASbGnct8sEGAHDXKsj2radJ2U0X9KBvse3H2E378766drF6jyAA96Pt4ieU0pDwtBCE
 fUZ7//xBu3JIsyFT25WpJRbYthGpsY3KyuulvhyOnYLgjNRnU6RODbshQnwy64gOQ8bdpoewvZp
 H2Hj40gjcs
X-Google-Smtp-Source: AGHT+IGzeIhWJYBJo1jq1BQUMrjJ1is/7yNBgzcHAJKqIeVP5r7R6Itk7xIzgx9JBNGzABY8X52wkYFjlTFRgy4NgyY=
X-Received: by 2002:a17:906:31cc:b0:ab7:bcc0:906a with SMTP id
 a640c23a62f3a-abc09a808c3mr99298166b.20.1740102796293; Thu, 20 Feb 2025
 17:53:16 -0800 (PST)
MIME-Version: 1.0
References: <20250220-has_rom-u-boot-rockchip-spi-bin-v2-0-d1768ee87808@cherry.de>
 <20250220-has_rom-u-boot-rockchip-spi-bin-v2-1-d1768ee87808@cherry.de>
In-Reply-To: <20250220-has_rom-u-boot-rockchip-spi-bin-v2-1-d1768ee87808@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 20 Feb 2025 18:53:04 -0700
X-Gm-Features: AWEUYZn7RtTbvFfcPMEESr2QjCHkVXYC60hkpDCybDXWPCqASBweSBeAkY8fpv4
Message-ID: <CAFLszThOtUj1YxOHMu8V46PTPcXjn_oQvRDkRhqQU0hDLMDaRw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rockchip: rk3399: do not generate u-boot.rom
 anymore
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>, FUKAUMI Naoki <naoki@radxa.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
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

On Thu, 20 Feb 2025 at 09:56, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> This was only used on RK3399 Gru Chromebooks and their maintainer
> (Simon) agreed[1] to its removal on the basis that the generic
> u-boot-rockchip-spi.bin is now enough, so let's do that.
>
> At the same time, remove HAS_ROM symbol from the Gru Chromebooks config
> since they were used only for that.
>
> Make sure u-boot-rockchip-spi.bin has the same size of u-boot.rom for
> Chromebooks as that seems to be important.
>
> [1] https://lore.kernel.org/u-boot/CAFLszTh-SewFod8dEOF3+e-wCE1qFF0CyxxR8CbQwy3BRW3k6w@mail.gmail.com/
>
> Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  arch/arm/dts/rk3399-gru-u-boot.dtsi   |  4 +++-
>  arch/arm/dts/rk3399-u-boot.dtsi       | 35 -----------------------------------
>  arch/arm/mach-rockchip/rk3399/Kconfig |  2 --
>  3 files changed, 3 insertions(+), 38 deletions(-)

Tested-by: Simon Glass <sjg@chromium.org>  # chromebook-kevin
Tested-by: Simon Glass <sjg@chromium.org>  # chromebook-bob
