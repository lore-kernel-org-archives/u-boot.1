Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B1A0E937E3
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 13:01:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E4498352B;
	Sun, 12 Apr 2026 15:00:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NQ6bO9x+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 176ED8416F; Sat, 11 Apr 2026 17:40:50 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28C8380077
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 17:40:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b980b35534eso418778866b.1
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 08:40:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775922047; cv=none;
 d=google.com; s=arc-20240605;
 b=Jp31O8fIxPhv50nbf6/DeagpHhHxBE3gHbLsP1SgQ91FO4XURl2hvj9DJXwxi9ZDBS
 swiZsT545WJfCqZ73bLMlg/9wt0G5Oel37q7Ozu2V2IPr8aG8TZSScLLBX1fYDcZqWOy
 EuLz9Fioa1cn17jdxaepkTXFfJhiPQd8VKPWQnGdtJJ3zV4Aj9no00Emi0+ZKWr3UofT
 ZEjdTs/MCk2VUiXxPHmkFmYYP9GWHc964B8J0g4N7Fxy6yCi9htoMsKOM8mXnNPL2Wkf
 Pn71UI/3ttQb8ZRbtwPr7mt5CB8Ua7+XKGFd1A581WRYmH9Enp9UfncPvBUcZBSIkoZL
 bIlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CJx+yrr5C0buVQJEkIgdM3pKZ9xk+9nnvxbKVjbEwOI=;
 fh=pKV29h6PBf5SbuSFTM/GZF+KoVG4OaOclZXc+5Qi1tM=;
 b=MQDyuFdqtm11cJB93foLdF618r1DS78Oax4KaJiS2KEggyXs9N0HZLXTt0NUMXEM7I
 zHAkjumi+nufftCaY3hqW8KKbSydtXkQiHgqmchqCb//RUGMx/S14i43a9SIfa5d093x
 fFvTPWXCBNGeuKxxvcNR3MjTYtrfQg94LLCxN4kmVymwLSf5pldGscuYorD9pOD0cT+q
 fhS4iq11/hhTTDXHLOEWd10SpSBdC0ZEcEihTaYO+VsIrjYR6x3ocm6WrkdDsikEq2cR
 tD8u/9Con2QftldwFqDa59GIQtIIoYgVGNz5Cj/VRKVH+wxdaTOOOrw/rAWsjqmhOt3D
 jS7A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775922047; x=1776526847; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CJx+yrr5C0buVQJEkIgdM3pKZ9xk+9nnvxbKVjbEwOI=;
 b=NQ6bO9x+wg3ffwZEcObSKRfqzAeTLXLCY6mczSefowUjNsZOriQ/iyrymF6hjh+Jzh
 zfDf/R/7U7WO9rGt8iR69C7KLfobl/DRGrtPznd9ibOzb8cri+iSB8vSkeM+hWK+oGn7
 0zmTSEqznz+Yg71Lu+f+T55p1XubOUEOb6KC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775922047; x=1776526847;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CJx+yrr5C0buVQJEkIgdM3pKZ9xk+9nnvxbKVjbEwOI=;
 b=VgEdNAI44H7leT0TQrS9eahvRuL0e9Nqf8Bfe7F79ueqZrkPlal1Bmj75q5e214a7W
 PnL1/8T4FMgYwrwTWeTCUXFpjHtz2G/m7KuMhEN+yPmhJNfR/dPXb8/9IqbCnHuDOO/+
 XfFBIdK5j4+CjBGvF4Sryz+kbM3gVKi6rQnfP23grerw0BHftFOBjOumTW43XYdZHkk6
 EJbTcfzcyvKR1cVLxONmjD5A9qz3TtAU2zBkLzUlQh66FdRMVtRA+qPtB52A6W6jc4Ej
 80NQG/c9kssme0SBgLDfUMUdJ0euFqdw2lfXUBDEJgPitvhv8M/zV1kbxR/TtWUdjI8r
 kRBw==
X-Gm-Message-State: AOJu0YxxD+hAaeBGcS4zfY9dRWLOU9yAeHeNgO5XDac+ebxXPjSA/fFi
 bnzz8qBugIF5Px6RCWpcIlkOIdlc3Pyi3TzjSDyJGebMjM9Lu2gRZOjHIA8Tzb1quS9k3YipVCT
 hzyMQgFqmqupIciH02LhRdOXYVSn3kQ55Mr+oArlt
X-Gm-Gg: AeBDietUIgH3HHYBxQ4MM1VfttJS4VTV5xnBF555uHVSw9HQ5U7xEW/VX3MGgR4RrZU
 U1ixXtBpj0erVtIZhE5eZZZhBQQh5QphOWV+WBJyhn5RgFVHqDShy2PMbEea/3w1zdKK1l9atok
 JofuM+vZgxqkj1A+RF0iv8faFqIwbdvqxfLti2K6+sK2kFR2zxmBfQm4on7F/jkQc+jTSxZPDED
 Hzk/DdLMrwmM3boC8AN88pftHXdHV3laiFDktA3k3rYqoF1gWKsVBfOeczEkSGrSsWeXJDck7nl
 gvdXjg==
X-Received: by 2002:a17:906:3655:b0:b9d:7b9d:df02 with SMTP id
 a640c23a62f3a-b9d7b9e0c43mr243266266b.17.1775922047520; Sat, 11 Apr 2026
 08:40:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260411-qcom_spl-v2-0-9609557cf562@seznam.cz>
 <20260411-qcom_spl-v2-6-9609557cf562@seznam.cz>
In-Reply-To: <20260411-qcom_spl-v2-6-9609557cf562@seznam.cz>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 09:40:32 -0600
X-Gm-Features: AQROBzBZj6vCsv0qTzXw741r25ZNmKezRuYj0UNb5xvQSKopsYb10KjgT8ndNSg
Message-ID: <CAFLszTijP2=bNNgn5hu-MqYvFxmS8vvYD6+GsqNT=WNMe_B_oQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] mach-snapdragon: Kconfig: changes / additions to
 support SPL
To: michael.srba@seznam.cz
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Anshul Dalal <anshuld@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Ye Li <ye.li@nxp.com>, Andre Przywara <andre.przywara@arm.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heiko Schocher <hs@nabladev.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, 
 Yao Zi <me@ziyao.cc>, Peter Korsgaard <peter@korsgaard.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Alice Guo <alice.guo@nxp.com>, 
 George Chan <gchan9527@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sun, 12 Apr 2026 15:00:19 +0200
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

Hi Michael,

On 2026-04-11T00:00:12, Michael Srba <michael.srba@seznam.cz> wrote:
> mach-snapdragon: Kconfig: changes / additions to support SPL
>
> An SoC to target has to be selected, e.g. SPL_TARGET_SDM845.
> This will select reasonable defaults and enable per-SoC linker
> script (if required).
>
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
>
> arch/arm/Kconfig                 | 31 +++++++++++++++++++++++++++-
>  arch/arm/mach-snapdragon/Kconfig | 44 ++++++++++++++++++++++++++++++++++------
>  2 files changed, 68 insertions(+), 7 deletions(-)

> diff --git a/arch/arm/mach-snapdragon/Kconfig
> @@ -11,18 +11,12 @@ config SYS_VENDOR
> -config SYS_MALLOC_LEN
> -     default 0x10000000

You are removing a duplicate SYS_MALLOC_LEN definition (0x10000000 vs
0x800000). Please can you split this fix into a separate preparatory
patch, since it is a bug fix unrelated to adding SPL support?

> diff --git a/arch/arm/mach-snapdragon/Kconfig
> +config SPL_TARGET_SDM845
> +     bool "Set reasonable default values for running SPL in SRAM on sdm845 devices"

This is missing a help text. Please add one explaining what this
enables, perhaps referencing doc/board/qualcomm/spl.rst. Also, this
should probably have 'depends on SPL'

> diff --git a/arch/arm/Kconfig
> +     select SPL_MMC if SPL

Just to check - is SPL_MMC really needed for all Snapdragon SPL
builds? The defconfig and documentation suggest only USB DFU is
currently supported. If MMC is not actually used yet, maybe use imply
rather than select

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
