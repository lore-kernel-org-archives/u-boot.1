Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8771BCD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 13:42:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0301F8394E;
	Mon, 11 May 2026 15:42:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cXZwdPEL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 052AB83A91; Mon, 11 May 2026 15:42:15 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B1E98341A
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 15:42:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b79f8f7ea43so684008566b.2
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 06:42:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778506932; cv=none;
 d=google.com; s=arc-20240605;
 b=T/PkPXm0a0s7fvWC85yy356dzCnf0QdFo8QdDnVkUpoxR4pfZE6Y6QlpI8Db1buYC7
 MPTq1cBf8aTxxAnW091B1jRAwK0JLGF5EAem5sYhLiLftwQQ6+99AJ/gte7Z9lRosv9b
 xiiEWIRU4YvQXXQbTYB6GN6Ompowl2F0gREPNbReADfitLg+ijCTz/cuLFLyOoCYEP3U
 BxpvEiAEYkTwIVPWD3e5UTmDwG/cjhIcD00mqt3dosu6K2ImGlDSL1CDEA7gdcAadT4J
 BP/OJteT0HHqJEPuMK1BbC8Q2ek1UW1lnlid4CRZXQfGlNZYjBONFzPj6xHw206OXdFw
 iZYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5Iwtaafb85c8jenn3dHN1MSuLi5ODebrufhEVWZKwiY=;
 fh=j6i5ZvfNiHM/kHwTWtt4q7FhEz36924nugl6KwsTz8A=;
 b=bznISmBINNoR41BPCf0XnSeKFZL5le8qjIPKYDSwcze4kWymQrUq5cAIve9hucXjTr
 +IxoZEC3D+i+1Axvaa5IMCawY7s20hXaEZWtNmpdnhSYL3+tdoZuXVAs/I3ZdMC/IV4u
 aFXjXepHgnENy7a3fJM51GZMCcAYP/8Z1GhhW7QLtDxH8gob+n5+AfTGCsNmm6UtqgHv
 3865V/0SyhAOy2F1RUWDYnjIOI1fz+j2N0QGgIGXxtaufu0bmgQMaCGeRX1jygvnP/nZ
 pw2ckWUPy2Vq7NzSRAblCLpIkwONFeQhjl1mHBRwtSiRggH/xUfQmiZsvujnuy3kuo1a
 LXBw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778506932; x=1779111732; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5Iwtaafb85c8jenn3dHN1MSuLi5ODebrufhEVWZKwiY=;
 b=cXZwdPEL9bCCr/vKKlvLjgtUvaFx/ZbHQOA0gyhgRcU4qwLMPWMBfloUCBMfxLuxaf
 p2P2tMunMQjpAv/gWt7Cn0rMpxxYH3NSkUUWJg+tHHAiK48+1zNEl8zBMQhPvGyLDRYr
 LOvrjHTCl0whDnN6eCOP6MVlQEGW3UAhY0zMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778506932; x=1779111732;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Iwtaafb85c8jenn3dHN1MSuLi5ODebrufhEVWZKwiY=;
 b=YVFMI0y1PywrkwfE2y1Q6InPoxYNNnjW8wQ/raPc6t1YKO2upljr4LQEcC7qBo5UWV
 WJ+mRle4R+4RKdMAejoHoGSgZiNLbUjDHNA1EqbTUc04CwnGRhVZOJsJ3sYhkXeDpUy0
 guXsP9bf+vYK6MEoObzDn648mb3hYfRPM1Smlym4becVCHRSZ8WZh7Nx3oygFvpIVfsC
 96VjvzYmiqpZ65e02lBmq2i2yl7CN2pX2Hmlpk9/jqPeyTGdShmYX+HCb/Lt2fUMdC2U
 NpoeC4/V/n3VLmcxiEPkpoFc/kvWXuEGG3rB56HszdB23/pgLVGtCz1mapuc5P98A6XB
 CeEw==
X-Gm-Message-State: AOJu0YzA1+eKBCWKkK0J4EYP8bvUUBAZ9HHznsvrpMonPX4+w8O6gHQS
 UC1z9/X9k0D3la3ZdSAXoBI/Eo1lxcfXR7G2l0vp7cZ5Eise/bj6Q07bR51NYYaHFzcVKFyHTAS
 OwqgMjpdzHnwQaBuhpqPL190bmMjhdTg4KPGU6fSD
X-Gm-Gg: Acq92OFTRY7Vs+EkoeJSbvdn+mSaW6TuqLsXJUq+2G7+uois6P6UZc3b4k24miBjhj1
 oJbex6RTRm9JS7oQ5R6Wmgy8RgqaKf9bEPmJrZSMZGYjPAGsBDO/I7eZhRl3bXeHO6tZeVYp0DH
 0GlRWJeweAOjZhDLcKAFIMpvGczKMw2jexK///TIBrqOzjA/6BDSELQm39E62RL2dDwyYC/WxMj
 Z5Q31C/q0jM3AQrOOwddYlPZgmBlM6JHNchICEAA2gTmI8hAs8jpWWsmPMa4sAODgw9j6yM3T44
 OOJ01SZbxOonWdhT
X-Received: by 2002:a17:907:9802:b0:bc2:9733:9ecc with SMTP id
 a640c23a62f3a-bc56cd2ed45mr1486728566b.32.1778506932410; Mon, 11 May 2026
 06:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260509230147.1308308-1-james.hilliard1@gmail.com>
In-Reply-To: <20260509230147.1308308-1-james.hilliard1@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 May 2026 07:41:59 -0600
X-Gm-Features: AVHnY4LL-XCkk_rgqwRlciuKcIIKe29pOySEmrIvvwgsSULjJ_Y85cou-S1CErk
Message-ID: <CAFLszTjq_zp_qge4QugAFFymMBMuuuFnfYRmv0Mbz4gUYtvwuw@mail.gmail.com>
Subject: Re: [PATCH] env: add Kconfig option for static flags list
To: james.hilliard1@gmail.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Heiko Schocher <hs@nabladev.com>, 
 Walter Schweizer <walter.schweizer@siemens.com>,
 Sumit Garg <sumit.garg@kernel.org>, 
 Matthias Winker <matthias.winker@de.bosch.com>,
 Philip Oberfichtner <pro@denx.de>, Le Jin <le.jin@siemens.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Daniel Golle <daniel@makrotopia.org>, Philip Molloy <philip.molloy@analog.com>,
 David Lechner <dlechner@baylibre.com>, Michael Walle <mwalle@kernel.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, Peng Fan <peng.fan@nxp.com>, 
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Benjamin ROBIN <dev@benjarobin.fr>
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

On 2026-05-09T23:01:44, James Hilliard <james.hilliard1@gmail.com> wrote:
> env: add Kconfig option for static flags list
>
> Environment callbacks can already be configured from Kconfig with
> CONFIG_ENV_CALLBACK_LIST_STATIC, but static environment flags still
> require board headers to define CFG_ENV_FLAGS_LIST_STATIC.
>
> Add CONFIG_ENV_FLAGS_LIST_STATIC and append it to ENV_FLAGS_LIST_STATIC
> after the legacy CFG_ENV_FLAGS_LIST_STATIC value. Normalize existing
> CFG_ENV_FLAGS_LIST_STATIC definitions to end with a comma so the Kconfig
> list can be concatenated directly.
>
> This lets boards configure writeable-list policy and type validation
> from defconfig without adding a config header solely for env flags.
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>
> README                             |  6 ++++++
>  env/Kconfig                        | 13 +++++++++++++
>  include/configs/capricorn-common.h |  2 +-
>  include/configs/hmibsc.h           |  2 +-
>  include/configs/imx6q-bosch-acc.h  |  2 +-
>  include/configs/iot2050.h          |  2 +-
>  include/configs/socrates.h         |  2 +-
>  include/env_flags.h                |  3 ++-
>  8 files changed, 26 insertions(+), 6 deletions(-)

We are trying to migrate away from the README, so would it be possible
to move the docs to one of these files instead:

doc/develop/environment.rst
doc/usage/environment.rst

> diff --git a/include/env_flags.h b/include/env_flags.h
> @@ -89,7 +89,8 @@ enum env_flags_varaccess {
>       NET_FLAGS \
>       NET6_FLAGS \
>       SERIAL_FLAGS \
> -     CFG_ENV_FLAGS_LIST_STATIC
> +     CFG_ENV_FLAGS_LIST_STATIC \
> +     CONFIG_ENV_FLAGS_LIST_STATIC

In include/configs/aristainetos2.h

   #define CFG_ENV_FLAGS_LIST_STATIC 'ethaddr:mw,serial#:sw,board_type:sw,' \
                   'sysnum:dw,panel:sw,ipaddr:iw,serverip:iw'

No trailing comma, so setting both will run serverip:iw into the first
Kconfig entry. Please normalise this one too.

> diff --git a/env/Kconfig b/env/Kconfig
> @@ -34,6 +34,19 @@ config ENV_CALLBACK_LIST_STATIC
> +config ENV_FLAGS_LIST_STATIC
> +     string "Static flags list"
> +     default ""
> +     help
> +       The environment flags are associated with variables in a static
> +       list. Define this list in the same format as
> +       CFG_ENV_FLAGS_LIST_STATIC.

I agree with Quentin, There are only five remaining users of
CFG_ENV_FLAGS_LIST_STATIC, so you should consider converting each to a
defconfig setting of CONFIG_ENV_FLAGS_LIST_STATIC and dropping
CFG_ENV_FLAGS_LIST_STATIC entirely. Carrying two parallel mechanisms
plus the trailing-comma rule seems more confusing than finishing the
move.

> diff --git a/env/Kconfig b/env/Kconfig
> @@ -34,6 +34,19 @@ config ENV_CALLBACK_LIST_STATIC
> +       When CONFIG_ENV_WRITEABLE_LIST is enabled, the 'w' access attribute
> +       can be used to mark variables as writable.

Regards,
Simon
