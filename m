Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320C0CAC5B8
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 20:39:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA56D83DB6;
	Mon,  6 Oct 2025 22:38:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ccx1rbFQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2260983C46; Mon,  6 Oct 2025 22:38:46 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E57CB83DB6
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 22:38:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-62ec5f750f7so9140798a12.3
 for <u-boot@lists.denx.de>; Mon, 06 Oct 2025 13:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759783123; x=1760387923; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YlryFu0ghqUF0+KaGAbxzBNjRN9njO13vT+2YyOXL1U=;
 b=Ccx1rbFQZgbXc6U0LZr9y5HlyqWNYkkUdH+KZUAheGffJ3TRtXLCZFnk/EO3ghvoaT
 HUNeruD1nISedUeYTmyv/fV05Z6xtwTwRnasv+kMEw9TXm6QCVKc7x2+rOyl/L6Y0FkN
 Dcj7QnoKvtoO9CX4AbWGKKKO3H5mKl1LU8OnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759783123; x=1760387923;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YlryFu0ghqUF0+KaGAbxzBNjRN9njO13vT+2YyOXL1U=;
 b=D4FJ937FmaFK2bjTtEy7j4zy1rMxS0ToyQkc44lRmt6EEmnY93hwm5ZG2XJozB07wN
 CQUhS9UzOr0fiaU72+8QxPwm2xSkHnb6ml4BV89XAI5Fgstv5MoIWnDVkPhw1FRWybNf
 sIVpd8hGccbrNR0Xee59iNkoJqgAZ6yYwejsomBi/sHQY0Uz4lH1gwZZJQSBMfehMxJi
 vb0eZBwYm5wq872kPWNJiu0b8OXeJE+f3TcV6slB3F0LdPq+UVID4DxGAO4jEVKeTnBy
 S4mL09dojRuJlx8o3DofgGughw4ou7w1h6aYJ9R9bAM9BYrp5GX1X8WLAQuuWz53XYZo
 341g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWoyztDq5sfvKfZzoUxiR9F4q1Zzcs+8vVfrjEXc+kBsh8Nd+HTTdkl6e90Ft2AjF5XVZZeGY=@lists.denx.de
X-Gm-Message-State: AOJu0YyVWbJFfrebjiLRHknpBFtCa2DxAlIvqHgxlJsXZ5iQQO579Hn5
 1MlbpKChsXHVxIWJp7UIgjJ7F2R/qur4jABgp7TWtECM9NP9HTGVRZjb9vgR1Ehpp1oNcJPt2gj
 UV4sdWb4+DOXqjlS/GBJ6dVo4t+TtvT+mZylLq6M/
X-Gm-Gg: ASbGncswLr1M/isz4kAoQ1SkusJXFlRArfNVZ2G7YDWky3taF8Wk1rdxDZ9UJ+O6dI2
 ZSGGCKXyY9Yut7/AZkvDAA8XvtL2kSf56BiqNR46H4s0mLlaPpHEPHsyK6tn2xrVERgxf7A5RYK
 PggDkLqCamfvsw+0qFAb3JfX3BdrirkIoIeJPkzASUt9YcKBwXYxrw+HuLGtaS4CBpvcBrsjHV6
 03LDJ6a8dbcMZ+XQgr91MeCzcdDJp7xrQIkSrXkXRw=
X-Google-Smtp-Source: AGHT+IEzzAw9SVSf8Y98Sp6fr15gNg1ka0iUw6Aezr2H5UhcphxnBNBcBpOG5lqk7bl6310HHyBbqpFN80HL2z9XeWE=
X-Received: by 2002:a05:6402:34c6:b0:637:98a1:c7c4 with SMTP id
 4fb4d7f45d1cf-639348e6d10mr14492067a12.5.1759783123376; Mon, 06 Oct 2025
 13:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <20251003-feature_sysboot_extension_board-v1-0-458b8bf85325@bootlin.com>
In-Reply-To: <20251003-feature_sysboot_extension_board-v1-0-458b8bf85325@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 6 Oct 2025 14:38:21 -0600
X-Gm-Features: AS18NWCJm8UDRVgGKSzDt-QgQtk2hgim0x9hH-uim-Z9JB_u43goCNbLVF7jU5I
Message-ID: <CAFLszTgzaR6pYhJrXPNKUyWDtJepwb-GV6RSihosxtX7PnuX2g@mail.gmail.com>
Subject: Re: [PATCH 00/16] Convert extension support to UCLASS and adds its
 support to boot flows
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Hans de Goede <hdegoede@redhat.com>, 
 Mario Six <mario.six@gdsys.cc>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Kory,

On Fri, 3 Oct 2025 at 10:34, Kory Maincent <kory.maincent@bootlin.com> wrot=
e:
>
> This series converts the extension board framework to use UCLASS as
> requested by Simon Glass, then adds extension support to pxe_utils
> and bootmeth_efi (not tested) to enable extension boards devicetree load
> in the standard boot process.
>
> The UCLASS implementation provides one driver that manages all
> extension boards (alternative would be one U-Boot device per
> extension board). Simon is that what you would expect?

I believe that allowing board-specific drivers is better, since some
will want to check an EEPROM, some will use GPIO, etc.

Also, for testing, we should have a driver for sandbox.

Regards,
Simon


>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> Kory Maincent (16):
>       MAINTAINERS: Add maintainer for extension board support
>       boot: Move extension board support from cmd/ to boot/
>       boot: Add UCLASS support for extension boards
>       board: ti: Exclude cape detection from XPL builds
>       board: ti: Refactor cape detection code for readability
>       board: ti: Convert cape detection to use UCLASS framework
>       board: sunxi: Refactor CHIP board extension code
>       board: sunxi: Convert extension support to UCLASS framework
>       board: sandbox: Improve extension board scan implementation
>       board: sandbox: Convert extension support to UCLASS framework
>       board: compulab: Convert imx8mm-cl-iot-gate to UCLASS extension fra=
mework
>       boot: Remove legacy extension board support
>       boot: extension: Move overlay apply custom logic to command level
>       boot: pxe_utils: Add extension board devicetree overlay support
>       boot: bootmeth_efi: Refactor distro_efi_try_bootflow_files return l=
ogic
>       boot: bootmeth_efi: Add extension board devicetree overlay support
>
>  MAINTAINERS                                        |   9 +
>  .../imx8mm-cl-iot-gate/imx8mm-cl-iot-gate.c        |  60 ++++---
>  board/sandbox/sandbox.c                            |  22 ++-
>  board/sunxi/chip.c                                 |  33 ++--
>  board/ti/common/Makefile                           |   2 +
>  board/ti/common/cape_detect.c                      |  52 +++---
>  boot/Kconfig                                       |   3 +
>  boot/Makefile                                      |   1 +
>  boot/bootmeth_efi.c                                |  78 +++++++--
>  boot/extension-uclass.c                            | 138 +++++++++++++++=
+
>  boot/pxe_utils.c                                   |  90 ++++++++++
>  cmd/Kconfig                                        |   5 +-
>  cmd/extension_board.c                              | 183 ++++++++++-----=
------
>  doc/usage/cmd/extension.rst                        |  24 +--
>  include/dm/uclass-id.h                             |   1 +
>  include/extension_board.h                          |  71 ++++++--
>  16 files changed, 544 insertions(+), 228 deletions(-)
> ---
> base-commit: 9710d98e8942151fc0c62d54100d9d27e8263d04
> change-id: 20250916-feature_sysboot_extension_board-958dd0072565
>
> Best regards,
> --
> K=C3=B6ry Maincent, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com
>
