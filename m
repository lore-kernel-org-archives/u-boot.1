Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC3DFF8875
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 21:17:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4022784934;
	Wed, 29 Apr 2026 23:15:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Fa+c+ZcS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 466B2848A9; Wed, 29 Apr 2026 16:22:40 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D208A8489E
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 16:22:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-67b32c695efso684035a12.1
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 07:22:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777472556; cv=none;
 d=google.com; s=arc-20240605;
 b=aRVKQJzNOJixS6IoRT6Zcp+uVVbzx5qdukMrPYU6PlivJaxzmugMelE9uXVdoLoFVC
 AlJx3k2PGOi9I+phI9z9qpkNQ2lAHthde4rZ0Uhy5WS4ubkVOH/bEjEaVBREd/jNN72+
 vmS3/EYRLmfFKo6JmP0H7Wb0YFfCHMEc4SfzPV6JKvEVUUYlQyYSMeT4SSkJFFiaVDae
 agMamsu1kBknZW3m5d5MBr/sBh39hPmED+UffjcPaj5IHMUpB+QZ1DqGZXPIQG3T8qIC
 64fV/lMYfMQnjp7zv/H7k4P9xP+O5IySinq/b8XQUB67slCV6q/yDpj2M9fDjLcSmYhL
 kaOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8+sLIDdcu6lXOkK82tMRbShyw4OC9gV6dGitGprffPI=;
 fh=CcNfW6dIjL9WUdVhhW/ZJ0mqXisjz2Ordk1F8mJ+6zw=;
 b=lMwyEEoe/TQ6p8hLYYcDbvB9IBGzpTe9RcLHBAsa+pYR+Jcb/geLd/jzXWIW6ZD7GX
 925WqJI9AVOJkz3JyRw7Z17Tcfr5m3JjcyiDknUDvVpm48H5Y1HdJHf/j+xqLE6xXHGr
 B/yZLWSVJRENMWr1ibcikzWqhyZH36LSupHOf9A0bLPsg+SbMNHPyE8DwVYaJDK6lKz/
 LtxiqJjE1NvE0t4tzOb7aUEPnLxX1vR4HG5+TnG4c6yDYpFU4xXlo7nPPgkXLAlv8xag
 ChdpUQ95sxSq47AL4Hj/d/TBDmYcqBR8xJ0TjCSkPHQr0WD9mhFEZaUmOKk+lYaQYpPr
 gYhQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777472556; x=1778077356; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8+sLIDdcu6lXOkK82tMRbShyw4OC9gV6dGitGprffPI=;
 b=Fa+c+ZcSVOn9PvMTSvFmxrsQHry8D2ANHdle58HV0F41PGDvwOeVeLAeW6xDk0fZSp
 NSaWBI7tg8FA5DWOzsjYvXE30Jh6RIwKdMjnJasm3952OFs5Q2wMaB6LQaOUj5/Oa4J6
 bZG+XwAzZeJsqSRPq1/dslUTcMlKPw67IaGtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777472556; x=1778077356;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8+sLIDdcu6lXOkK82tMRbShyw4OC9gV6dGitGprffPI=;
 b=HrAIACsUf9tKcyWTH7Q6QnkLsGP/r88gUGWOcEORcfFM1GrkkiLVwsVBM0LfWBv+dr
 ddeCCaZQrG0CBqvgIhcauwoOkWALQwYnjtfYSyqLAiZ4/haJG0qN41scHwNTISBtZJIB
 8UKJN0hwmcDRiCbZ/gE201xpJ9tcxxNVLnXcH3nD/v/j6cS1ozL+Ge9DC7Kfd0Xelksr
 ufKS94KZSS778eDLpOOyESAJnf+nzeMM/bU6pZTvZXXpuclHSy03uPdMIilUEWJTiH42
 OzTTwoNPQ6B28pOJPoTwGx4chfwf9F9DXBMc6RpZv4k9SosEfgNUTmhKRQQq2S81TuuB
 Jz2w==
X-Gm-Message-State: AOJu0YxRksV5AVDUHQQAW9edBbafXNe8IzsQnORV0GGYR2gZ0GrkaRyH
 GvNBZ1xreWmJ0f8PPlxP+mGSGkakkb6BEK5XVfAyTAOaiz2gCtMy9FOlRpoHW4vAkde6cDQhdfe
 D8qtETnInnWHVnxspQKLKxcx9L+59Z0omYd5rOU2s
X-Gm-Gg: AeBDiesvw6+D5eJv1kn1OG4hjoPsB38jhLM+CtlY/81wjB/7m+XCjjSPWtey4hcCkYZ
 IkLrsY17kzzZmW4v8Oecq22BRhR/x9a05MpeFk+UrgBRoTxexluIcVD8RX/aXvAiAAshP2je7k5
 xjxUQmQsZmqohiUY7RXMOBuqy5NWmWACGeVsh8q4jAgdGIx4XOTTbt4CB/Z3WsjMwss7AlfrGbP
 AaDTsy7ZVSF1X0gHdOfqxgUmIQyfNS3mBqPmY+URlYix8AxnhhY7avd+HFynWWaLZpJoXt3MGum
 8g1aAqbYGGb1eIoA
X-Received: by 2002:a17:907:80e:b0:ba3:7d65:c373 with SMTP id
 a640c23a62f3a-bb957ec5208mr205607466b.10.1777472556221; Wed, 29 Apr 2026
 07:22:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260426-qcom_spl-v4-0-8cf4133ff883@seznam.cz>
 <20260426-qcom_spl-v4-7-8cf4133ff883@seznam.cz>
In-Reply-To: <20260426-qcom_spl-v4-7-8cf4133ff883@seznam.cz>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Apr 2026 08:22:23 -0600
X-Gm-Features: AVHnY4KyUGJbYu4j_wuE9T331bGdMoHuqEaJDi6V7uMIksQJs2iQmqRDhxKTIhI
Message-ID: <CAFLszThQv6SoP941hy1mjZcP9_kKhiqPhEd4tbAgLM74bCAYFQ@mail.gmail.com>
Subject: Re: [PATCH v4 07/11] mach-snapdragon: Kconfig: changes / additions to
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
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 29 Apr 2026 23:15:47 +0200
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

On 2026-04-25T23:26:13, Michael Srba <michael.srba@seznam.cz> wrote:
> mach-snapdragon: Kconfig: changes / additions to support SPL
>
> An SoC to target has to be selected, e.g. TARGET_SDM845.
> This will enable the per-SoC boot0.h.
>
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
>
> arch/arm/Kconfig                 | 34 +++++++++++++++++++++++++++++++++-
>  arch/arm/mach-snapdragon/Kconfig | 31 ++++++++++++++++++++++++++++---
>  2 files changed, 61 insertions(+), 4 deletions(-)

> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
> @@ -42,4 +39,32 @@ config SYS_CONFIG_NAME
> +choice
> +     prompt "Qualcomm SoC select"
> +     default TARGET_NONE if !SPL
> +     help
> +       While U-Boot on Qualcomm platforms doesn't generally need compile-time
> +       adjustment based on the target SoC, there are a few exceptions to this.
> +       Currently this concerns boot0.h discrimination.
> +
> +config TARGET_NONE
> +     bool "Generic build"
> +     help
> +       Select this if you're not building SPL. U-Boot proper builds are currently
> +       generic across all SoCs.
> +
> +config TARGET_SDM845
> +     bool "SPL targeting the sdm845 SoC"
> +     help
> +       Select this if you are building u-boot SPL for sdm845.
> +       Currently this gates sdm845-specific boot0.h (only used in SPL).
> +
> +endchoice

A few things:

- TARGET_NONE only exists to give the choice a default for !SPL. Can
you instance make the choice 'optional' and drop TARGET_NONE, so a
U-Boot proper build simply has no SoC selected?
- Neither option is gated, so a user can pick TARGET_NONE with SPL=y
or TARGET_SDM845 with SPL=n, both of which contradict the help. So
TARGET_SDM845 should at least have 'depends on SPL'.
- TARGET_* is conventionally a board identifier (TARGET_RPI_4,
TARGET_SNOW, ...), not an SoC. SOC_SDM845 would match the existing
pattern and avoid colliding with a future SDM845 board target.

Also please expand the commit message to cover the choice mechanism,
why SYSRESET_PSCI is excluded for SPL (EL3 / no PSCI provider), and
why SUPPORT_SPL is now selected unconditionally.

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> @@ -1124,6 +1124,7 @@ config ARCH_SNAPDRAGON
>       bool "Qualcomm Snapdragon SoCs"
>       select ARM64
>       select DM
> +     select DM_EVENT if USB_DWC3_GENERIC || SPL_USB_DWC3_GENERIC

DM_EVENT is the U-Boot-proper symbol, so SPL_USB_DWC3_GENERIC will
pull it into U-Boot proper as well - the SPL side is already covered
by 'select SPL_EVENT if SPL_USB_DWC3_GENERIC' below. You should be
able to drop the SPL_USB_DWC3_GENERIC term here.

> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
> @@ -42,4 +39,32 @@ config SYS_CONFIG_NAME
> +config SPL_SHARES_INIT_SP_ADDR
> +     default n

'n' is already the default for a bool, so this is a no-op - please
drop it, or add a comment if the intent is to override the 'default y'
in common/spl/Kconfig.

Regards,
Simon
