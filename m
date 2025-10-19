Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A30CCD184
	for <u-boot@archiver.kernel.org>; Sun, 19 Oct 2025 13:06:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECBDC82BA7;
	Sun, 19 Oct 2025 15:06:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fHR1GrZa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 612EF82E34; Sun, 19 Oct 2025 15:06:06 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21D938206E
 for <u-boot@lists.denx.de>; Sun, 19 Oct 2025 15:06:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-637e9f9f9fbso6495256a12.0
 for <u-boot@lists.denx.de>; Sun, 19 Oct 2025 06:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760879163; x=1761483963; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OPoImI8fU6GZWcQKVNWjgTuK5uB6PzKrrWAVZihqDPI=;
 b=fHR1GrZaUD4FcBWDym1Sznw5jEQNq7pjaoIL+qPaJsh1ghM4BrFMLPEYjhmDMVdxxT
 4D/A7D7IMbZF+knbAMSABuQzc2Ci24+EmGYUajAQ94U103p3Lnb+quAz6yhNgmrDkI9A
 47mx7OAaKZkbTa4qaKZOp/mtIT/TI/phWZ52E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760879163; x=1761483963;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OPoImI8fU6GZWcQKVNWjgTuK5uB6PzKrrWAVZihqDPI=;
 b=ig8cMC0Do69snEgWi7QWb6YORhtrGvCPwQdruDvh9yuu7T2QubRSbzEb2+7z6CrY7g
 CVuY/IIy+m3/0iFxwI4b4bGux0qMHxcweXBY/OmZ840xCuSV6qSrEIWwcO4dw6jjvhgQ
 t3Mop3LXSJABlniY04l59q09UcMxKnhpBvlTBVFCKZ2hOu4VcAom0MfvoiYiQZzJt+nF
 K3waIy6G3Vsj4A5tKDhBRCfDiv4lEOvC7VFKGWr1eIg+gDlTDV3aKWS3X4q7CrFOVP8i
 KZJJ1U+xfy7/aCk9SHSKC/EN9f1mRMTnfXQ+F/ne60l0RrC60YxmcH2att8SFtu6Up/T
 6OSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6DJAztwowBgIhgMQueDEj/WY4+wWamXViD2WqH2fJZ8+uRrxPY8HbMYlJaZ2WrFuRPKR9lbc=@lists.denx.de
X-Gm-Message-State: AOJu0YxNp9UvDVGcX17tJyfFrc2I0GaMMStLLhENBULxNe+qCfRAnORh
 F1dediX0gUthI+5Wioe3ShU7PXOYEu2QIY0YySmRpePJSDkDLV621GkPmdzF731jsxACDt+ohrd
 4uTF7kLJ4aU2e6HwZmSq0FJUKaLBNV3D3wXf8OZTs
X-Gm-Gg: ASbGncu6VMhC2m8QqdnFfXLM/3cZAeUBs8CFNGZfG5hkqD3UhCtqd/QNNLRKM4JIz0h
 m1qRgp6RyDNJKkLImhswGsybi5qffmAe6uW2MhBwEmliUQUH3NjcECOCA2xsGHLfAw95uy2Wql1
 cC7lKu0q2cfn9yvYVrXN/9RtssGUyP44kBwvMce7loWH2BhdIhtocVIAtzVled36VCYwcd3yNOq
 uAMGQ2uBFPAv5SES4EtvM9Q+4GcVc3rfmuzjY5AIbTfhEyp3iJ2rs2Z6f1Mm6S+LIxHEKTrurpY
 MT53
X-Google-Smtp-Source: AGHT+IELcRV+oWoF0crWaq+SpeyL3D2Z3TxedQ5M9WEM9uQPXvDqNz7bac87P+eQX6Y9VlJAxsGH/i/gCg8wYB0zXEA=
X-Received: by 2002:a05:6402:280a:b0:63b:f4b4:a005 with SMTP id
 4fb4d7f45d1cf-63c1f6419c0mr10600879a12.10.1760879163538; Sun, 19 Oct 2025
 06:06:03 -0700 (PDT)
MIME-Version: 1.0
References: <20251013-feature_sysboot_extension_board-v3-0-04067b7422a5@bootlin.com>
In-Reply-To: <20251013-feature_sysboot_extension_board-v3-0-04067b7422a5@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 19 Oct 2025 14:05:51 +0100
X-Gm-Features: AS18NWDxXgub_wnOM4TkDBFjIfJspkwbcXsJMz4NjkVoFaly3eSvHBwE8trPLIc
Message-ID: <CAFLszThGVL1powrtDa+niBuxU-b_3YDs6TQ96igx-cj-PGvf=g@mail.gmail.com>
Subject: Re: [PATCH v3 00/20] Convert extension support to UCLASS and adds its
 support to boot flows
To: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Hans de Goede <hdegoede@redhat.com>, 
 Mario Six <mario.six@gdsys.cc>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
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

On Mon, 13 Oct 2025 at 14:32, Kory Maincent (TI.com)
<kory.maincent@bootlin.com> wrote:
>
> This series converts the extension board framework to use UCLASS as
> requested by Simon Glass, then adds extension support to pxe_utils
> and bootmeth_efi (not tested) to enable extension boards devicetree load
> in the standard boot process.
>
> I can't test the imx8 extension scan enabled by the
> imx8mm-cl-iot-gate_defconfig as I don't have this board.
> I also can't test the efi bootmeth change as I don't have such board.

You can test this with sandbox, using one of the bootmeth tests,
perhaps. Let me know if you need help with this.

>
> Changes in v3:
> - Reorder the patches inside the series as several config were broken
>   in the middle of the series.
> - Use U_BOOT_DRVINFO macro instead of manually bind the drivers.
> - Use uclass_first_device_err instead of extension_get_dev function.
> - Made few fixes in documentation and Kconfig dependency.
> - Made few changes of error value returned.
> - Add a patch to document the extension structure.
> - Add a patch to fix CAPE_EEPROM_BUS_NUM Kconfig dependency
>
> Changes in v2:
> - Fixes few build errors.
> - Add patches to move the extension support and board scan out of XPL
>   images build.
>
> Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
> ---
> Kory Maincent (TI.com) (20):
>       MAINTAINERS: Add maintainer for extension board support
>       board: ti: Exclude cape detection from XPL builds
>       board: ti: Fix CAPE_EEPROM_BUS_NUM Kconfig dependency
>       board: sunxi: Exclude DIP detection from XPL builds
>       board: compulab: Exclude compulab extension board detection from XP=
L builds
>       include: extension_board: Document the extension structure
>       boot: Move extension board support from cmd/ to boot/
>       boot: Add UCLASS support for extension boards
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
>  .../imx8mm-cl-iot-gate/imx8mm-cl-iot-gate.c        |  70 ++++----
>  board/sandbox/sandbox.c                            |  26 ++-
>  board/sunxi/Makefile                               |   2 +-
>  board/sunxi/chip.c                                 |  36 ++--
>  board/ti/common/Kconfig                            |   2 +-
>  board/ti/common/Makefile                           |   2 +-
>  board/ti/common/cape_detect.c                      |  56 ++++---
>  boot/Kconfig                                       |   4 +
>  boot/Makefile                                      |   1 +
>  boot/bootmeth_efi.c                                |  79 +++++++--
>  boot/extension-uclass.c                            |  93 +++++++++++
>  boot/pxe_utils.c                                   |  92 +++++++++++
>  cmd/Kconfig                                        |   3 -
>  cmd/extension_board.c                              | 183 ++++++++++-----=
------
>  doc/usage/cmd/extension.rst                        |  29 ++--
>  include/dm/uclass-id.h                             |   1 +
>  include/extension_board.h                          |  85 ++++++++--
>  18 files changed, 541 insertions(+), 232 deletions(-)
> ---
> base-commit: 8e7f8c1248e8adfb525a2a4ea56ebf7e54ff5d7a
> change-id: 20250916-feature_sysboot_extension_board-958dd0072565
>
> Best regards,
> --
> K=C3=B6ry Maincent, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com
>

Regards,
Simon
