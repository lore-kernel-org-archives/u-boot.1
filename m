Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB356CD37BE
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 18:09:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E994A81E18;
	Mon, 11 May 2026 20:09:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gBA2luQJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 763EC83C51; Mon, 11 May 2026 20:09:47 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50D4D803C6
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 20:09:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6763cc8775cso10148058a12.0
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 11:09:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778522985; cv=none;
 d=google.com; s=arc-20240605;
 b=b9iQjxFhjbdMRloLXJBeDOEpAjFlYui7/S9NjwWXAbJtKnOBeUILVbD+CPpQybqRNp
 p8Tw/gsIFzvSLYAgrV6RZTpoNXkkaD7hWbwCIRwDTdMwjwexQku77hk2kc9RCait0c7t
 uTBgvfA44WMyNZ9G1Pv/5a4kNCi2QmQk9/TkvXnu0+VtNrzhPpvQqzZdszAiWhL0742i
 FSNtQoi77TqiidUOEx3KdMCIQn6YtZtbxQbmlBbJdqsHtJI6m0lXnZHt2tp1ZHuMeWOD
 HO37Le0SV94oKZv7NAxUcBuKh4cK5uuUMF1m8jlb0l7loC042f8G3khsrMxIqvQZmdFj
 Ejng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3QJ+n6LFmtQngkqKzz7OhqEXTj+DRKIlEcv9LNK9OQY=;
 fh=Fv1NBrAS/1Q4rbYEPYqcwev7z9YmzvTvXaAau1zA4q4=;
 b=K9mWQKZ0aPaR2O5U82erIGWU+BFbcvBp/vJxD64r0FG/BTfqAjMhngbUvupv+5s8sa
 hTi6VrjT9R9WRtTfpGuf2icMiCL/nKLqlYu21QIm7gmP5KgyzQdSHk6Evn5sG9VEE9cd
 kwKkG+wYvnybCM+eHPmrn89d1QtXd+LaU4BnynZwd8Fl2G/xrIAo32386r08iv/rPnTG
 RP2cm5/neDfKIODP7w8enbXVzm4V2olPEdzQqh/krNQvEkvVo9Jg2mkFVCrxQgnM2xDL
 ftwef46VhUpPJr/b4nrnc1cJOuuedDMuQoMgOICCAmSIB19BceuMW5NgZ0C0cLF6/E03
 jY5w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778522985; x=1779127785; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3QJ+n6LFmtQngkqKzz7OhqEXTj+DRKIlEcv9LNK9OQY=;
 b=gBA2luQJA5mFZVqLC3mT+m1DbGyMDZodJ6CFI2oYL29a7GFPFon5CgoFVD0hGfgUJc
 DYhD7Szh4cO51JqqvxZYyHoD1eOwI8PlUmA9QVZcl9+pBhwyxGYcPZsRaI5acE21HIxI
 dpY8biB+RqNtHUgdZOovzfZ0kBqMYzzb+MnL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778522985; x=1779127785;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3QJ+n6LFmtQngkqKzz7OhqEXTj+DRKIlEcv9LNK9OQY=;
 b=cgkmS3X6IBDEkNQ24yOH0iFfG9EA6h2oauiloWXPURR7jgrjWY5DOmRDiMw9++rDJi
 /O7qjPDWXkvidibYIMkqVIhMRjStflOy85hbJvPT94dBMDtRc53aBwmHKDTfYTFcJoVA
 Nn1aZpVwyKOtwAmCcgi3Pnr1Oo5QYSKnBYZIiyCR77Grfghkl+G78fYNDf4/Sh3gvA/C
 rItKYjDX/DP/hZhzUuU95O4JtdUdGc4vuNpwEM/a28Yk0NR1IV7eCZXQfyX9fUElD4x1
 Ij070Ph8aknsCreO01slfGBqexc9I8vnRCHV+cdppIBpoknFMiywFh8RJcyDlbF7HN1O
 7VIQ==
X-Gm-Message-State: AOJu0YwFt8/+H6KJlS5EzIiswbsRV0u8mUhOsD2uMwSxoEMvcbdripWv
 pU9unH8iCIFhbOmP+QZnYr9L+dLA0G4f21YH4zLWaxslOvgmeoGvkFZajTih9Fkz0o8jDOKamGl
 CXqQBHzCG4Ee7XbElFKgC0d4M4qMs83IzkJGxOJe3
X-Gm-Gg: Acq92OEIV962OtMqZFs2Uj5nwB5Gp+cUoIqWxAsd1Az0KozwRQPPh2dBK/Aqpj/jxFn
 Op/nu4xvnY0HE246ltfNM5tNsktM4HWHUlDC7UAW2fp0xC3Tmn2GXgFlwNYFUf5lEz8kYeKd2UK
 SdlmHJQwY+0naw3vykt4kY8iSwhML/wMF20a3iNr+G1h4hKG6W0+U44hFaxMbdlQGaH2tOx69cg
 HWhBMiQwwIknK1HpbFQ51rWlr3X7ayxwCJnjtZE1Hc9/dcqQ9VDGeiYJ9Izs7SsBTRIaTuVNXe2
 r751AQ==
X-Received: by 2002:a17:907:1c10:b0:bce:7860:5161 with SMTP id
 a640c23a62f3a-bd23ae166ddmr43222866b.9.1778522984705; Mon, 11 May 2026
 11:09:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260511144437.46645-1-james.hilliard1@gmail.com>
In-Reply-To: <20260511144437.46645-1-james.hilliard1@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 May 2026 12:09:32 -0600
X-Gm-Features: AVHnY4JATEaUosxOQgaDpSgPhytOjENNfLsP7dCY9o1JHqpuwdRG3cx-1IQA57A
Message-ID: <CAFLszTijOgGA=9=LV+z7-MiHLHZje64vBw8G8JWvp+eY3Yv-yA@mail.gmail.com>
Subject: Re: [PATCH v2] env: migrate static flags list to Kconfig
To: james.hilliard1@gmail.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heiko Schocher <hs@nabladev.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Matthias Winker <matthias.winker@de.bosch.com>,
 Philip Oberfichtner <pro@denx.de>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Walter Schweizer <walter.schweizer@siemens.com>,
 Fabio Estevam <festevam@denx.de>, 
 Le Jin <le.jin@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Daniel Golle <daniel@makrotopia.org>, 
 Philip Molloy <philip.molloy@analog.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peng Fan <peng.fan@nxp.com>, Adrian Freihofer <adrian.freihofer@siemens.com>, 
 David Lechner <dlechner@baylibre.com>, Michael Walle <mwalle@kernel.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, Benjamin ROBIN <dev@benjarobin.fr>
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

Hi James,

On 2026-05-11T14:44:31, James Hilliard <james.hilliard1@gmail.com> wrote:
> env: migrate static flags list to Kconfig
>
> Environment callbacks can already be configured from Kconfig with
> CONFIG_ENV_CALLBACK_LIST_STATIC, but static environment flags still
> require board headers to define CFG_ENV_FLAGS_LIST_STATIC.
>
> Add CONFIG_ENV_FLAGS_LIST_STATIC and use it as the only board-provided
> static environment flags list. Convert the remaining default-config users
> from CFG_ENV_FLAGS_LIST_STATIC to defconfig settings and drop the legacy
> header macro from ENV_FLAGS_LIST_STATIC.
>
> Move the environment flags format documentation out of README and into
> the developer environment documentation. Include the format in the
> Kconfig help as well.
>
> This lets boards configure writeable-list policy and type validation
> from defconfig without adding a config header solely for env flags.
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
> README                               | 45 +-----------------------------------
>  configs/aristainetos2c_defconfig     |  1 +
>  configs/aristainetos2ccslb_defconfig |  1 +
>  configs/hmibsc_defconfig             |  1 +
>  configs/imx6q_bosch_acc_defconfig    |  1 +
>  configs/imx8qxp_capricorn.config     |  1 +
>  configs/smegw01_defconfig            |  1 +
>  configs/socrates_defconfig           |  1 +
>  doc/develop/environment.rst          | 40 ++++++++++++++++++++++++++++++++
>  env/Kconfig                          | 23 ++++++++++++++++++
>  include/configs/aristainetos2.h      |  3 ---
>  include/configs/capricorn-common.h   | 13 -----------
>  include/configs/hmibsc.h             |  4 ----
>  include/configs/imx6q-bosch-acc.h    | 12 ----------
>  include/configs/iot2050.h            |  8 -------
>  include/configs/smegw01.h            | 15 ------------
>  include/configs/socrates.h           |  2 --
>  include/env_flags.h                  |  6 +----
>  18 files changed, 72 insertions(+), 106 deletions(-)

> diff --git a/include/configs/iot2050.h b/include/configs/iot2050.h
> @@ -38,12 +38,4 @@
>         func(MMC, mmc, 0) \
>         BOOT_TARGET_USB(func)
>
> -#ifdef CONFIG_ENV_WRITEABLE_LIST
> -#define CFG_ENV_FLAGS_LIST_STATIC                                    \
> -     "board_uuid:sw,board_name:sw,board_serial:sw,board_a5e:sw,"     \
> -     'mlfb:sw,fw_version:sw,seboot_version:sw,'                      \
> -     'm2_manual_config:sw,'                                          \
> -     "eth1addr:mw,eth2addr:mw,watchdog_timeout_ms:dw,boot_targets:sw"
> -#endif
> -

Thanks for the clean-up!

This one is being silently dropped, i.e. no matching
CONFIG_ENV_FLAGS_LIST_STATIC is added to iot2050_defconfig

The original commit (08cba536eff 'iot2050: Add
CFG_ENV_FLAGS_LIST_STATIC') notes the list "will be needed when
CONFIG_ENV_WRITEABLE_LIST is enabled", so it is waiting for the
writeable-list to be turned on. You could carry the list over like the
other boards, or make a note in the commit message about this, as I
suppose the board maintainers can deal with it when needed.

> diff --git a/include/configs/smegw01.h b/include/configs/smegw01.h
> @@ -22,21 +22,6 @@
>  #define EXTRA_BOOTPARAMS
>  #endif
>
> -#ifdef CONFIG_SYS_BOOT_LOCKED
> -#define EXTRA_ENV_FLAGS
> -#else
> -#define EXTRA_ENV_FLAGS 'mmcdev:dw,'
> -#endif
> -
> -#define CFG_ENV_FLAGS_LIST_STATIC \
> -     'mmcpart:dw,' \
> -     'mmcpart_committed:dw,' \
> -     'ustate:dw,' \
> -     'bootcount:dw,' \
> -     'bootlimit:dw,' \
> -     'upgrade_available:dw,' \
> -     EXTRA_ENV_FLAGS

This only captures the CONFIG_SYS_BOOT_LOCKED=y case (the defconfig
default). For SYS_BOOT_LOCKED=n the old code added mmcdev:dw, so
turning lockdown off via menuconfig silently loses write access to
mmcdev under ENV_WRITEABLE_LIST.

For now you could just note in the commit message that the unlocked
case is no longer supported, perhaps with a follow-up to move the
SYS_BOOT_LOCKED dependency to Kconfig (e.g. defaulting
CONFIG_ENV_FLAGS_LIST_STATIC on SYS_BOOT_LOCKED).

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
