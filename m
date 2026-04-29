Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6CBFF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 14:14:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F255A846BA;
	Wed, 29 Apr 2026 16:14:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EqzOJ6eU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 933E584894; Wed, 29 Apr 2026 16:14:06 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CB1284658
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 16:14:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ba67b332bbaso1544326566b.0
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 07:14:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777472044; cv=none;
 d=google.com; s=arc-20240605;
 b=k6aEPBD1R/zbyKkbctN4tB3jZIJvuqppd89Hc1YyGuAZFSghRiNAhhbYgh56lfjGFr
 KWqxJm8CdRg45phAsBMCTyHh8x3Uc25u8igU7ngq6Q5MFBRk0IUPb7eifNa9yWLVdBAL
 JVu5B8mYJTko2oW1mwQTswLB4MggoYdPim6/r7EjuTpT2dKH12zEEmh7mjsFpqmpvUj3
 RXoxlSoF9qCXH0Op1NBbMFa3bimBcejHNM4jZswXulrPWZN3M7MQxjtMG2zFfdyOUr4j
 PuleG01xQJ7+uFSoGfKL0+naPcJhiVQ6zN2822ot3he82HY7Tf/25hfvGW/iBXwm0coc
 7ANg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=iz+LftIWeghlqd1jI5NcM/nIih2dGG5bVP0TaB6YI8I=;
 fh=OF00omt3W5XkTWoy8yz+VALjHs5aNJpNm30/GdQrL1I=;
 b=KVpXf5gxJbtIFdl2/AYko64AyuqsZZvJ/3b38vnCPTuayrpWmgTGbraqmkKoon+E6v
 0jJDNkL/Ct2ewsXRGWJuZqlGVUSItOMBy6lMbH8j9mVGojxlwGf8s090c1Tx7jbJs7p4
 fehn5MfPHDa+42uN9qoshiayTvH3WEWojYlgE5gWoB9sNeLA+HBY+23Y8X551DFDic2R
 eE2dwRQJhOPncrgbgTIbxp1YfHkzwA8K+fRJmqC78lU9tUxUXcyPM55FKgbyjvp8zfcq
 auRQAwFL+HB9/S8XDQsKktIt63CFcPfqoFd4Joh/XIDorxAR6R/nxvdu6eKUlIX9hoUD
 OzSg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777472044; x=1778076844; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iz+LftIWeghlqd1jI5NcM/nIih2dGG5bVP0TaB6YI8I=;
 b=EqzOJ6eUt4S9uLoNATydEU2IJ7A3XZ92CyT8AFURUR5owTZK4rxt7LEX1J4NIizcq2
 /hZuWXxrTXzwWgfF0G6JUEF5UXFPH9hX/m7KEJqdTPjvxSsCSukXUDJIisjMz7kh2x7X
 TQUF7dbV/ofwsA/EKoU/95N0HcmkXbgh28ECg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777472044; x=1778076844;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iz+LftIWeghlqd1jI5NcM/nIih2dGG5bVP0TaB6YI8I=;
 b=XNu+GNEWOXbEht3psiJGaMtxFiPU27qSHUJPeCHn4KjnI19fnAJKYO92y+i9SP4SPx
 Grt+m2U2UhJ+y4FlBSj9kbYYVbY683WTjQhRF2x6Fj+/2A/FCjsV983y3e1E7JU8AtcW
 Ax+s6iUrGDQyzimeWwAV+WB2os078HDDOyROvi6HjISlk9jAn3v0d2y1OITLk70f4I+O
 tom5xwRybicu5Lm9kkoS4cOpNKjdDjEUo+cXHPMF9f7cNUs8XQzRL6h9DbIi19PvizPc
 YILWsoCFn72oL9Ntx0mLCO5cK3ALni3S3Io9XD5BOFpMDzh8Z8wybIUsi27C8mHNGD5D
 K17Q==
X-Gm-Message-State: AOJu0Yy8HDZMHuZLnwY+N+vPxUMsqoHASxLPy60K00kvqV+fccsQHDbf
 PO90ggnnIexpF/5r5D+hC2zXJPRCvpfjknApcZ9xACuG1Y+q0E19/yAapDHmU1ufZxm4ZGb+8z0
 amEEyBCLoBVo5Jh7nyl4DgFhP5wkpifo9DcEv5uod
X-Gm-Gg: AeBDiev2i8Qyc0I9wabG2fJMiTvBetdQ6YUD5SuDHn7tfg49C2+oy9fRjdPuaAHBEAZ
 JgciquruYwv721vHitdjfVx0jE+5AZIO87uLMTxRkMerd4xPO3l40pLekrvIoowNFWMeTi3aNwU
 CJ8+mwvuaIvG9C0nX8IrF743iDhIbRyvi3ob2DLAlcjIlwPi0qLEwSDZUsalEc5FjWNSLzw3OYs
 Q4f3y17Z75+NHi9rYdb+FCnlTdYS7BwOYe3nlaKFZTdK1PN5G72R1Rci6sgFHqnC6OAhmtwumrf
 Jqr3DEpN749LKLF+
X-Received: by 2002:a17:907:1c29:b0:ba3:cacd:b9f6 with SMTP id
 a640c23a62f3a-bb93c4a30e4mr284468466b.7.1777472043930; Wed, 29 Apr 2026
 07:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776954004.git.jcethrid@gmail.com>
 <5d645926dd3c38d172b6bf28b4ee7ff8981ad865.1776954004.git.jcethrid@gmail.com>
In-Reply-To: <5d645926dd3c38d172b6bf28b4ee7ff8981ad865.1776954004.git.jcethrid@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Apr 2026 08:13:52 -0600
X-Gm-Features: AVHnY4LcQae-H8HUQgpvSOqKAUQcgzCdNH8EPY5pAMjJNAUI_N9BV4Atzx_Dfn0
Message-ID: <CAFLszTjUJrBzOkBr=pKrxZz2s4RU5SWnS8wpLJZFyNrFxfULUw@mail.gmail.com>
Subject: Re: [PATCH v5 11/15] configs: sc5xx: Set default bootcmd to SPI boot
To: jcethrid@gmail.com
Cc: u-boot@lists.denx.de, malysagreg@gmail.com, trini@konsulko.com, 
 linux@analog.com, philip@philipmolloy.com, sjg@chromium.org, 
 Caleb Ethridge <caleb.ethridge@analog.com>
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

Hi Caleb,

On 2026-04-23T14:24:50, Caleb Ethridge <jcethrid@gmail.com> wrote:
> configs: sc5xx: Set default bootcmd to SPI boot
>
> Align configs to use the same default bootcommand.
>
> Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
>
> configs/sc589-ezkit_defconfig          | 2 +-
>  configs/sc589-mini_defconfig           | 2 +-
>  configs/sc594-som-ezkit-spl_defconfig  | 2 +-
>  configs/sc594-som-ezlite-spl_defconfig | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)

> diff --git a/configs/sc589-ezkit_defconfig b/configs/sc589-ezkit_defconfig
> @@ -22,7 +22,7 @@ CONFIG_FIT=y
> -CONFIG_BOOTCOMMAND="run ramboot"
> +CONFIG_BOOTCOMMAND="run spiboot"

The commit message says "Align configs to use the same default
bootcommand", but after this patch sc573-ezlite and sc584-ezkit still
have CONFIG_BOOTCOMMAND="run ramboot". Both define USE_SPI, so spiboot
is available there too. Please update those defconfigs as well, or
mention this in the commit message.

Also worth noting the motivation, that with the environment no longer
stored in SPI (patch 1) and the new SPI partitioning from patch 3, SPI
is now the intended default boot medium.

> diff --git a/configs/sc594-som-ezkit-spl_defconfig b/configs/sc594-som-ezkit-spl_defconfig
> @@ -15,7 +15,7 @@ CONFIG_FIT=y
> -CONFIG_BOOTCOMMAND="run ospiboot"
> +CONFIG_BOOTCOMMAND="run spiboot"

Just to check - patch 3 keeps a distinct ospiboot target (with its own
ospiargs setting sfdev to the OSPI bus/SSEL), so switching the sc594
SOM boards from ospiboot to spiboot now points them at the SPI bus
instead of OSPI. Is that intentional on these OSPI-equipped SOMs, or
should the bootcmd remain "run ospiboot"? Please spell this out in the
commit message.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
