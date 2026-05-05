Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B91CD13DA
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 05:46:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1B2B846D5;
	Tue,  5 May 2026 07:46:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="exulbSsC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09C2E846E1; Tue,  5 May 2026 07:46:55 +0200 (CEST)
Received: from mail-yx1-xb12e.google.com (mail-yx1-xb12e.google.com
 [IPv6:2607:f8b0:4864:20::b12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D086184683
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 07:46:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-651c5d525f6so4435198d50.3
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 22:46:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777960011; cv=none;
 d=google.com; s=arc-20240605;
 b=kK68YVFV/KVAdRn1ovEuXNOei5js61rnKODwV2+vq0ymEr3ethJX/kIr1WCvYM3edI
 KvlNrU+aeko6VggA81hiXnimwuX+wg7oAhJ5Zg7sUDsNCAT/GkROvtTVrM/gtuRNlmWi
 zCYqo4MUXb9Ir/XXceM1BkkG6l7X8Eaa7UZ43Kw6467eXZrZ4TQADVueKgSejTHlQJcN
 k2zZy6m6lNtcP4pUnqmagGMiauDqVHhLU1XQiX/CkIuv7T3GPnQOCGdpa+IkC4fAuTew
 jZX12Y5No2KXAWFdlYBSK91/wilFrWgtGvmWqncc2P7v8qkdb2Qdkn4WKvxy276+0lPO
 O1XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6Sg0br5+P7ShIDmtiq1cvgbHZKEzXBRF1+kAyNmNGZw=;
 fh=Jg1GwjOEZ1S4lNqzrPlyRpppkKciiPaSkBs16SCT10U=;
 b=NrKtDRQo3YuzsiygsSEYUxg0FSqV3pGwOBtvEcEo+jVF0exe/iDIRpAILUWagUgZ4D
 Pp+AntaWjUvvX6P58k9Jb2MjPTohK4aRjTpZRmr/UIcH9ahJJgZ5ujxB+fj6xH8Acg8C
 paWw2TLXfOQ/EpZ2Lzo9p9g7oL4juxk/1WKqoWJ3OhAryr9iFuulOlHwtPF0NeRa9h7w
 ecCqGKnPz+od8db27Qfw38blCersNGGeTU6aMgn6acirsZRK9cHEafqx12BGbERAV66w
 DM/qAIh034OzXRbxwhGJ2U7bQS8lrcJNeZlvK3Hxj3ASIgDuuFC/2w5Ym6gFkqk22lGO
 m91g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777960011; x=1778564811; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6Sg0br5+P7ShIDmtiq1cvgbHZKEzXBRF1+kAyNmNGZw=;
 b=exulbSsChadTiBYeCEqWDNYJUK/0puFnfjrjchmRTqa1KJwzG0TMJcfBsEJxANg9S5
 5DOelZYYq6b18ape5dhkkqyYagOz2rG+zUKMS36QVwsjr/ldQCs8fGV+HfJHHRlHDn8k
 adAVdZ/AHKhle9xIktlEASlKa+dAsp5wGcjqdma1HzwBCes1KEYmRhz4dMdCZdM3cpaw
 TieLd04X1Oct/ODZ7ZWsxaLqlSXLY5/pLvnSgrvUBuEh1kJIsXezVvNqmp5RUMi0aTZw
 H1TiaPECntflspuEhBPubwi8QkLwJaSEBcB1FInZn9AtjYfSItTOn/vYm232yh8r7+vi
 9+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777960011; x=1778564811;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Sg0br5+P7ShIDmtiq1cvgbHZKEzXBRF1+kAyNmNGZw=;
 b=J9uqygcWh5G0HAPQj2Kqb8x7tg0fu+Tgcg4Qrttq7HsnFsQs4gR2SYYgG3xIBTVh67
 S7mI6w5zQnf4awJzv3x3PrpSYFOUSo/7D57Jik4HGgeGYYyem4jxwa43pnaFZp67Uz3c
 Mu0V3cIYx4Smn8VUXlPwQ34i4LDgn6P9N4Hh+BruewWvrtSruS+toPYhHrLOp9/WVH0b
 lPTKtU1yhGuf9HfMN0lqhMgNQxFBsX5IqEUVzjgzoUkrBFg8gghHVCi/A5CdHRSmHWOT
 4G4acD6D64YH3VMQis7/XCJ4xXQdY2575VOhEjcHfxAQHnxeKGe+j6vA21OZJ1M3AIEv
 71zQ==
X-Gm-Message-State: AOJu0YxKsemNJtPXdKvwVvwEaNdGEorGE5i/b7iGj95J3fDwN5pG4sOm
 6/5+Q7Dw8rbK4ZMVCKO6jdbisOUBGcOnifrU+OwRhKpjdB6LVawJvnXgEUslbAXq6yHLPRjCho5
 N/qzlFEt++nFJ0WHxUtDf9aryPEJoZhhMWanUz4SUJg==
X-Gm-Gg: AeBDietqdJx6uhFNKZzP4aa2YHv9E+b9FVxY1MosfKlgCMJJ/yIwQAkGDMQPfegwNHf
 iBiR2L5vfLZc4VYgcu25UPsQJ8YLg5hu/S0mY42dQdxmA0+hiZjvZ0CQDcSFtAWfb5Ipp4DLgEP
 blBRQEV7pC5ebldQOV43Og4lgAQZapF4QYA3Y9Eddl9DUYnKMo7wN6Wrw35rIcPSHLeoK7qT5OJ
 rxq+scXS3Qf58sRnQHR3RWFt1LaEKpKc5FArH1lNVsX9c3Y5Ved1sWmGtbxp97xN7Dr8mriD8uo
 lK0JIu1GlmD8dzYSfKYuCqwSCnb7W/mDOI6TJDOVXtqtxTzwBblcFF3bUnDq3d3THvUgOwlPmLd
 jontO0sEf4hqZkKt5Hxw9lvx0/s1JGwm68DuuMZJenezV2KC/dw26GIUHmK2OTnNF+2wNicThkc
 zLo1c9qTSxojTjTmEK8VwRNZCbbDBmEGoO65ekpGU2XaP12frKvyGji5sjcgwDqpqQDaxc4GDev
 vSL238QJ5R4MAKuI2dHGG/mtTrb7PqTImkV5jDbDhOEY/LEeR07tbfu/8GH8mL8r6+YM7pjm/bT
 pegIideo2peN585Qy/iDCseEV4d2+R6Rk5W/IkO/Z7iyRMmsf8AJOFwwkAeaxesk4PvX9kHFM3m
 SevhG+KsvT7m4zujh
X-Received: by 2002:a05:690e:b4d:b0:656:fc53:12e0 with SMTP id
 956f58d0204a3-65c3d9a39b5mr12202461d50.12.1777960011585; Mon, 04 May 2026
 22:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
 <20260504-extrawarn-sync-v1-9-b19301d1948a@cherry.de>
In-Reply-To: <20260504-extrawarn-sync-v1-9-b19301d1948a@cherry.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 5 May 2026 08:46:14 +0300
X-Gm-Features: AVHnY4KrzuREMV11kuMbCqEZsKaKYwTv_RTN2fG81o-eh5-ueqck3AI4vxJs5Hw
Message-ID: <CAC_iWjLEBWJFyO9-Z+CMiG8JvK7WwCroMkfY=oa7vwm0_YCS0g@mail.gmail.com>
Subject: Re: [PATCH RFC next 09/18] kbuild: support W=c and W=e shorthands for
 Kconfig
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <simon.glass@canonical.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Yao Zi <me@ziyao.cc>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Mon, 4 May 2026 at 16:20, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> [ Upstream commit c77d06e70d59cbc6e3c22bf644bb0b197a5fc182 ]
>
> Original commit log:
>
>   KCONFIG_WARN_UNKNOWN_SYMBOLS=1 and KCONFIG_WERROR=1 are descriptive
>   and suitable in scripting, but typing them from the command line can
>   be tedious.
>
>   Associate them with KBUILD_EXTRA_WARN (and the W= shorthand).
>
>   Support a new letter 'c' to enable extra checks in Kconfig. You can
>   still manage compiler warnings (W=1) and Kconfig warnings (W=c)
>   independently.
>
>   Reuse the letter 'e' to turn Kconfig warnings into errors.
>
>   As usual, you can combine multiple letters in KCONFIG_EXTRA_WARN.
>
>     $ KCONFIG_WARN_UNKNOWN_SYMBOLS=1 KCONFIG_WERROR=1 make defconfig
>
>   can be shortened to:
>
>     $ KBUILD_EXTRA_WARN=ce make defconfig
>
>   or, even shorter:
>
>     $ make W=ce defconfig
>
> [note that U-Boot currently doesn't make use of the KCONFIG_WERROR or
>  KCONFIG_WARN_UNKNOWN_SYMBOLS symbols as we're using an ancient version
>  of kconfig, so technically W=c won't do anything.]
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  Makefile                   | 10 ++++++++++
>  scripts/Makefile.extrawarn |  9 ---------
>  scripts/kconfig/Makefile   |  8 ++++++++
>  3 files changed, 18 insertions(+), 9 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index aed54cee4a4..bd33437fdfd 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -105,6 +105,15 @@ endif
>
>  export quiet Q KBUILD_VERBOSE
>
> +# backward compatibility
> +KBUILD_EXTRA_WARN ?= $(KBUILD_ENABLE_EXTRA_GCC_CHECKS)
> +
> +ifeq ("$(origin W)", "command line")
> +  KBUILD_EXTRA_WARN := $(W)
> +endif
> +
> +export KBUILD_EXTRA_WARN
> +
>  # Kbuild will save output files in the current working directory.
>  # This does not need to match to the root of the kernel source tree.
>  #
> @@ -2745,6 +2754,7 @@ help:
>         @echo  '                1: warnings which may be relevant and do not occur too often'
>         @echo  '                2: warnings which occur quite often but may still be relevant'
>         @echo  '                3: more obscure warnings, can most likely be ignored'
> +       @echo  '                c: extra checks in the configuration stage (Kconfig)'
>         @echo  '                e: warnings are being treated as errors'
>         @echo  '                Multiple levels can be combined with W=12 or W=123'
>         @echo  ''
> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> index 6bbba36c596..b1881d83e06 100644
> --- a/scripts/Makefile.extrawarn
> +++ b/scripts/Makefile.extrawarn
> @@ -8,15 +8,6 @@
>
>  KBUILD_CFLAGS += $(call cc-disable-warning, packed-not-aligned)
>
> -# backward compatibility
> -KBUILD_EXTRA_WARN ?= $(KBUILD_ENABLE_EXTRA_GCC_CHECKS)
> -
> -ifeq ("$(origin W)", "command line")
> -  KBUILD_EXTRA_WARN := $(W)
> -endif
> -
> -export KBUILD_EXTRA_WARN
> -
>  #
>  # W=1 - warnings which may be relevant and do not occur too often
>  #
> diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
> index abc34f60d15..f072772eba8 100644
> --- a/scripts/kconfig/Makefile
> +++ b/scripts/kconfig/Makefile
> @@ -22,6 +22,14 @@ ifeq ($(quiet),silent_)
>  silent := -s
>  endif
>
> +ifneq ($(findstring c, $(KBUILD_EXTRA_WARN)),)
> +export KCONFIG_WARN_UNKNOWN_SYMBOLS=1
> +endif
> +
> +ifneq ($(findstring e, $(KBUILD_EXTRA_WARN)),)
> +export KCONFIG_WERROR=1
> +endif
> +
>  # We need this, in case the user has it in its environment
>  unexport CONFIG_
>
>
> --
> 2.54.0
>
