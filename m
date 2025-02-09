Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F75C0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 15:37:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CDB080A2A;
	Sun,  9 Feb 2025 16:37:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C6CI6KTP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2957580819; Sun,  9 Feb 2025 16:37:23 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B0E4808AF
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 16:37:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5de6e26db8eso1088666a12.2
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 07:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739115440; x=1739720240; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+U32O2VxVwVs5zfVpe4FcxWdNAxKfeg/Gz6v/XhkxLc=;
 b=C6CI6KTPR7+wdcWMPjY7KHG8SjnTofNwOM8TgDGSrNE3L0CabmObTnCicSQBc+jyve
 ThOsnzCzNHTtw4qNXsY2yEzcE/P1dPWb699nmIZMkcbjzarah/xMfbwXYGyLpEW9VlWU
 G7kH0m7HQtXo/jknjbjBkO3MfWJl3Jt+iY05g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739115440; x=1739720240;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+U32O2VxVwVs5zfVpe4FcxWdNAxKfeg/Gz6v/XhkxLc=;
 b=KPhMAKXXDqYsmSne4SnRVnuMqNrrq1lzT2irT2jDP++zrQ3dO2lC4pSQNlDAVLHJoo
 9Th8tUzCBdWpqv6mJ26HrYMNXOI25neD3JMUt12yL3XqQg9G8uxoQ6TL9gaMbujBAGce
 ihmVsZreiG9tFd92xJG7CwUITVbmKiFpHRMsi7TtJeLr2h9Mr+Z9ZHUxrgYDCH1E6SP6
 5n771+oLDgUiHQAtNfheyuYXHqugqb722p0tUixdhjUCLX/tJ/DaWIQymFlJmuafc2F5
 0yYbTVDd91bG+EGxhmbGw+nhZa1l3p2xoXRlT15YMagqbqn66tTaQeh5SEG/8jMUALX+
 MWLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+QrtzQDsMJFRFcoHRILDuDZpsXWrwnSmXLybFvPMkkJM3Sm/msMW7WftaH0hQ573V6cYl+1g=@lists.denx.de
X-Gm-Message-State: AOJu0YyILRoq/uR+HUFM1IOVlNWB0XlkTZJ0nSZkPEMZy7Tm9J6g18D7
 2wikq++1xQzwolOLs0pG5eunDv6EV0mfxa7gcDtLwlUTdS8lGfiQZOiiKNx7nMxHVhsGcAYg+fL
 a4WEc64iYPNuJWL11r33ZzTWsUzZuhPsFvhGm
X-Gm-Gg: ASbGncvwUw6i3GeyVUPo4E5v4ym9vDSbQuiUEsf9fWfM1CSYjUPFctpelK1XVsdilUw
 YqkFB+f3+6EOIsnej/HDPbmixcve89An8BMYfgPlUsU5h9TJ9F4Yf/+oGCZ1op/037gZ32OSm5g
 ==
X-Google-Smtp-Source: AGHT+IGMm8o01shKl8LIC5a+d65vZUrRr9Xods8VWPXRcLXyMSiuri+sIIOdDbIn+7XVjda/x+mzHdrGECQmAzFreHo=
X-Received: by 2002:a05:6402:5249:b0:5d0:e563:4475 with SMTP id
 4fb4d7f45d1cf-5de450e2185mr11470474a12.29.1739115440644; Sun, 09 Feb 2025
 07:37:20 -0800 (PST)
MIME-Version: 1.0
References: <20250209152329.187194-1-heinrich.schuchardt@canonical.com>
 <20250209152329.187194-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250209152329.187194-4-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 9 Feb 2025 08:37:08 -0700
X-Gm-Features: AWEUYZkmpPEoEGLXA2rDgfg8Ugm7dDx9N0kRA_bAwtBfga948h4ZhdiXWNCk4BQ
Message-ID: <CAFLszTi+o6Fg2opZQNZW3TNzhydCVnRJkW-4aSCygu6nz2MQ8w@mail.gmail.com>
Subject: Re: [PATCH 3/4] riscv: dts: starfive: remove duplicate itb entries
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Yu-Chien Peter Lin <peter.lin@sifive.com>, E Shattow <e@freeshell.de>,
 "E . Shattow" <lucent@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 "Leon M . Busch-George" <leon@georgemail.eu>, 
 H Bell <dmoo_dv@protonmail.com>, Lukas Funke <lukas.funke@weidmueller.com>, 
 Andreas Schwab <schwab@suse.de>, Nam Cao <namcao@linutronix.de>,
 u-boot@lists.denx.de
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

On Sun, 9 Feb 2025 at 08:23, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> As binman already creates nodes based on CONFIG_OF_LIST we don't need to
> add extra nodes.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  .../dts/starfive-visionfive2-binman.dtsi      | 76 -------------------
>  1 file changed, 76 deletions(-)

Thanks for the clean-up!

Reviewed-by: Simon Glass <sjg@chromium.org>
Tested-by: Simon Glass <sjg@chromium.org> # StarFIve VisionFive 2
