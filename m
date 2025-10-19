Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26ED1CCD184
	for <u-boot@archiver.kernel.org>; Sun, 19 Oct 2025 13:06:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4277E83631;
	Sun, 19 Oct 2025 15:06:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ARhp+qaQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8316D8382E; Sun, 19 Oct 2025 15:06:13 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DA988206E
 for <u-boot@lists.denx.de>; Sun, 19 Oct 2025 15:06:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b3ee18913c0so645151466b.3
 for <u-boot@lists.denx.de>; Sun, 19 Oct 2025 06:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760879171; x=1761483971; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EMWTlIbIuiAlLs/oEDTX2+V0L6ppHRpFmNFoRCxdu48=;
 b=ARhp+qaQe3WkGlnD79qn6n9C5pDGnJwlDABMx+nN6b3VvFENSuXtJwVvQlRJACrTGx
 Qc56zUZdbs/lxKGNRja0Ci8hxjnSX+LMrbwstcn5SY3NAULyqMRKfZPvAHmYWweNJPmd
 YnFC8thioGu7KuL554wc8gTGEV5BNWM4oLtnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760879171; x=1761483971;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EMWTlIbIuiAlLs/oEDTX2+V0L6ppHRpFmNFoRCxdu48=;
 b=KmIQxFtJVNf0YBf8yKs6dCyI8J4NC7JCBrN85vaFo2I69AD8fQUuIpF/oxHsPUhgLc
 Ny5q+nW96UN5ji8s6hGBdBJthpglBMYlimpVgvzCT9c6kMsVKRlilC83RMZmJsL4VOcb
 oSctq4ca4sn/+kkOLB3CXu30V0n3bhrbC0VYEB9h3ENYp7Hk3B96ZkbcmiO69ZbCBJIg
 29R+vbZ8E3O67qmXoH/2Jg/V9/QtakybNa2tj0DXnvfJgy31279UKk2LQbW9qyA9mWWq
 cqDRFBFGLL4sglhDjruMKveiVS8p+v9mZvzCPHX66B55wl6D8Q/eaLppPTzR5pwCG2ez
 tmgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeJe+TLUyNRojJ6YKjvwRKVWPtlVa6cSpzLZj3DiQgiw6MBkUjHLsK9zPcMi19xpeQNM3/t4c=@lists.denx.de
X-Gm-Message-State: AOJu0Yw5mxyYO5QQohppBZ7NPbK7FO0rm5bTPZFuDEoWu8ViwljCcu0e
 /Rv0kPdWNeWTto3plvfAY85v1SHSyWntQraZN7REEWl4MWymThUhhxxKAcaCyNbRTujLA2OsNYB
 xQOweq1+va6NhRABwoTPdLxF1HN6HZoOtOJd+BCfn
X-Gm-Gg: ASbGncv4puSXGGVKjHW2gI0vVoXCFanlls9jC2EVzPrD5pLcHre4R8+BmB/gS9HiY5k
 2SHe6ZvaaMfX5Wj7wRAdvlXyzP28r2He/gbGZ53ZJZX1bmif0f3VsjWGbuAJ+REZiP+u6fABRj/
 +Ux+P6Ma7Fj0ep0/MndL9sg+VzOJKpHq84G8PWdGkhsvIzzyxVBIutElR8jAxgh61aNThnb8owU
 s5e83E1rPlsfy/Vf2TufifxLnP0JjrAjaX0GyeI9wFT27ZqJn96Cmz+xPg=
X-Google-Smtp-Source: AGHT+IH8LArPJ9kLzkqF4rGiJbDPPkjA4XwbzYXOy5HDSAzX7kyJijxq6cKYWQ7NjolIdtymKcToR8A82I0CMySd13M=
X-Received: by 2002:a17:906:26c5:b0:b64:8474:2992 with SMTP id
 a640c23a62f3a-b64847429b8mr949139966b.56.1760879171020; Sun, 19 Oct 2025
 06:06:11 -0700 (PDT)
MIME-Version: 1.0
References: <20251013-feature_sysboot_extension_board-v3-0-04067b7422a5@bootlin.com>
 <20251013-feature_sysboot_extension_board-v3-8-04067b7422a5@bootlin.com>
In-Reply-To: <20251013-feature_sysboot_extension_board-v3-8-04067b7422a5@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 19 Oct 2025 14:05:57 +0100
X-Gm-Features: AS18NWCUg6z4gEQAd9zNxB2VywGQSiZWt4UoRqHO7XsQJFcv7shAcXBMBzuPcIg
Message-ID: <CAFLszThXWkby4kUwRiaoauh44d3hT1AAhMP9w2ECK_o0Vd5YSw@mail.gmail.com>
Subject: Re: [PATCH v3 08/20] boot: Add UCLASS support for extension boards
To: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Hans de Goede <hdegoede@redhat.com>, 
 Mario Six <mario.six@gdsys.cc>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
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

On Mon, 13 Oct 2025 at 14:32, Kory Maincent (TI.com)
<kory.maincent@bootlin.com> wrote:
>
> Introduce UCLASS-based extension board support to enable more
> standardized and automatic loading of extension board device tree
> overlays in preparation for integration with bootstd and pxe_utils.
>
> Several #if CONFIG_IS_ENABLED are used in cmd/extension_board.c to ease the
> development but don't worry they are removed later in the series.
>
> Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
> ---
>
> Change in v3:
> - Add OF_LIBFDT_OVERLAY config dependency.
> - Update several return errors value following Simon review.
> - Use uclass_first_device_err instead of extension_get_dev function.
> - Remove the manual bind of extension driver. Use U_BOOT_DRVINFO instead.
> - Update documentation.
> - Add a helper to get extension ops.
> ---
>  MAINTAINERS                 |   1 +
>  boot/Kconfig                |   4 ++
>  boot/Makefile               |   1 +
>  boot/extension-uclass.c     | 151 ++++++++++++++++++++++++++++++++++++++++++++
>  cmd/Kconfig                 |   2 +-
>  cmd/extension_board.c       |  50 ++++++++++++++-
>  doc/usage/cmd/extension.rst |  29 +++++----
>  include/dm/uclass-id.h      |   1 +
>  include/extension_board.h   |  70 ++++++++++++++++++++
>  9 files changed, 293 insertions(+), 16 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
