Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F214CD5BAC
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 11:57:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7001C844CF;
	Sat, 23 May 2026 13:57:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BNITOWM/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D8648469F; Sat, 23 May 2026 13:56:58 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F01F83E81
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 13:56:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-68914995e35so452884a12.1
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 04:56:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779537415; cv=none;
 d=google.com; s=arc-20240605;
 b=jLWEDeAEq988A9wRJds6Cj2a61ll7waZy3lDKgFLR1ICP4rxkX5MYf+dS7PgQk+BMh
 UB2pzWEUy/yAkFHCHy67ThhtlwpvgzBZFh5ayo4EmqPOLxtPMz9L4XXIUs9gbFkRuhYK
 XKU7Q7omDxpqeEiq1+p18sxG96waelYQQMwoM11qbV1kFGQsAvjxPEqda4lLIHlV/QQY
 ro6tVOI3eOpizW0AK/VoYAGTbnBJgj7Bqv0ErDPitOVt1jXJK2kBvkPn6xUARfzYKXDJ
 SEDWD4xW3dJbYtrM160Inf8OECIRCboMXIlFNFRUKPy+PEST3uZehSrgIZeV+NFtSfDi
 di6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=346lZ++P3pWPWJEDAoZ2xRpS6mY6UtaNzD5mIgwmAWw=;
 fh=3cGkqt4Xgv2w9dTeeIJFEJ5AO4AvGobPArcY4WlS1wc=;
 b=eNcOa050YWo0iZOhKWOr+PzzcdhVPHTKtdRo5xVR/48FQKz9uKfwj9upzlhEPLhCE4
 Y4YG6LYlh7yaRiY2zxAJcM3QaBL+8yPw57IGO0SV8zkmUrfYGJcMbQk9NoKqN0NN3WFJ
 FQl89mNzVBbKkrSISQCjXz5dP4Q3SgdTgCEaPDIQ13lvFNomLhqhj/ZLBEigElGqRa1T
 edQFuWbAIgg7+hI/QVwf6QXekozuOsln9ueocUjaUtn3WscVW0TN4ikxlznr8BAOPCM4
 NmD0pC4dFxLYi/EXXhmkOn4+iVObQhOz8uq7lEp+yaQ/rIllwHQA8/ciIz/kBWVnfD4B
 0lKA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779537415; x=1780142215; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=346lZ++P3pWPWJEDAoZ2xRpS6mY6UtaNzD5mIgwmAWw=;
 b=BNITOWM/2KyTy1VIYmJ0BLRHcAQYW7IsTZ9uFSE42iZashbbmr5dOeO1K4FuOabLz9
 BqA7nHDfLsrJ7K0/+r8BdMIlJdRfL7ijP0r443BWiJqVQO2OSgDByztHYRvVDB6KPPXb
 EX5g0zg6gulTy8QRhHacsKeGRgBqTM2fql32ayhbZckaOS1R7uQiPE/wuRVnq6KiiJZy
 4qOM7by4hda7e85iuhrEn/EZG5TNYUa95mST0OKsddiVJ2/EuBLaX0g9bPA56bINcH59
 Ju1urMGc6iBkM6xUWUlxCPAn+DYlv363IhhtdK9ivyN/AtD9YdjfloxaWJ8r+cTjiZGG
 RTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779537415; x=1780142215;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=346lZ++P3pWPWJEDAoZ2xRpS6mY6UtaNzD5mIgwmAWw=;
 b=sT9VARhJOECGW26m5aVpA8m9B3gPVvRt0iutERkPbOKEwp0gs00C59/tYZcEMMZ+sc
 k+JMG2PqHYOl9xRf9G8ivTxG4bDUk2h/Iec1udeQzRM0wm6Lf+etcb/8pvHrVnQ0OS2f
 cyGaLVsg0sfJ/8fmPiS4B1zAwFsjtIdavQ+S0YdLn8cTHza++0RX+kz9xlC3GiDVohbj
 aPH/UvVP6M0qMoX+GRTZMYTRphwxSrveMQ8IHgR2RTKqHPKfBxa1rGfHGUWar84yqTpt
 X2lGtFoTXMWm/tk8WlpPjZq4rk2MvELNiMhzhtiEruSuLyGRiuypl9th87fW4ylIRrqs
 aWug==
X-Gm-Message-State: AOJu0Ywk2T+ynbhbQ/BWollEdaHAnISHG7PuxKNmrK605Ta5f/kEFMcp
 XR0l6PplslIxOWOCwfzHeU54HlstsEnlPLF12SZjOKruA97fXCpyfIYbd1e/XR+vpR6BJFLVByS
 zSlwRg09jFgR96NJztduD16QZNXn+tr8=
X-Gm-Gg: Acq92OEn4b2DnDzDl0sLAZZ/TjQhAdhoMpMwnw5x2XeoBfdMb02xpkbw8R6EglGU/fo
 G6EZzPVPgb9zef0jU7WnVnBREW3sp50yzMEBMwS5nsFlLNxg25pPiy33Cnjp3g8guJNW1EVJ/yh
 Q7vVrTWZc6NE3KM0icLT8UGwLPzPBvexxB4Aw5WAr+Q2N2+vFVVfFJ754MG6QMRDzg1+LvCZAt4
 qNwk4ioBAB52s7CjZyxsFcBcBL0ITPwSQQ/QVmxiSJm53q5EHUv+jwSyWV4zewgXS9xURrsK9Vf
 kvHu2HXM6r0FN3SIr5KXQ7btjGofMf04IL9IOEx315YzzxF5iDKsNNlZp+O25lIwHUroFKnLk5F
 yPJNZOckpOaGo9hQrYHuUbgTDqMXN4BkIvuot/NfypFgcKA20m8UVKzbK6Zkc5r43Y0xi4rTPLC
 85+VQ9ow1tH9o=
X-Received: by 2002:a05:6402:390c:b0:683:6206:86f0 with SMTP id
 4fb4d7f45d1cf-6889c94cc10mr3705166a12.17.1779537414557; Sat, 23 May 2026
 04:56:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260522235838.2536318-1-trini@konsulko.com>
In-Reply-To: <20260522235838.2536318-1-trini@konsulko.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sat, 23 May 2026 12:56:42 +0100
X-Gm-Features: AVHnY4KUr7SNPrV61XOCI80VvfUXmBSoiVDUtwHv1PdijVF0GC1WWdANUCgFJhA
Message-ID: <CALeDE9NvncF2GoLphtKOrraMU9otAWBg97PLaCcuGgvsgijm7g@mail.gmail.com>
Subject: Re: [PATCH] global: Update URL for U-Boot project
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Sat, 23 May 2026 at 01:08, Tom Rini <trini@konsulko.com> wrote:
>
> Our official domain is now u-boot-project.org, so update all in-tree
> references to use the correct domain.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  MAINTAINERS                                   | 2 +-
>  README                                        | 2 +-
>  doc/CONTRIBUTE.rst                            | 2 +-
>  doc/build/documentation.rst                   | 2 +-
>  doc/device-tree-bindings/bootcount-syscon.txt | 2 +-
>  doc/mkeficapsule.1                            | 2 +-
>  drivers/bootcount/Kconfig                     | 2 +-
>  tools/binman/etype/atf_fip.py                 | 2 +-
>  tools/binman/missing-blob-help                | 6 +++---
>  tools/binman/pyproject.toml                   | 2 +-
>  tools/buildman/pyproject.toml                 | 2 +-
>  tools/dtoc/pyproject.toml                     | 2 +-
>  tools/patman/pyproject.toml                   | 2 +-
>  tools/u_boot_pylib/pyproject.toml             | 2 +-
>  14 files changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2613929cdf5f..571af1964654 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1116,7 +1116,7 @@ EFI CLIENT
>  M:     Simon Glass <sjg@chromium.org>
>  M:     Heinrich Schuchardt <xypron.glpk@gmx.de>
>  S:     Maintained
> -W:     https://docs.u-boot.org/en/latest/develop/uefi/u-boot_on_efi.html
> +W:     https://docs.u-boot-project.org/en/latest/develop/uefi/u-boot_on_efi.html
>  F:     board/efi/efi-x86_app
>  F:     configs/efi-x86_app*
>  F:     doc/develop/uefi/u-boot_on_efi.rst
> diff --git a/README b/README
> index f0bad144360a..5653f687e820 100644
> --- a/README
> +++ b/README
> @@ -2281,5 +2281,5 @@ Contributing
>
>  The U-Boot projects depends on contributions from the user community.
>  If you want to participate, please, have a look at the 'General'
> -section of https://docs.u-boot.org/en/latest/develop/index.html
> +section of https://docs.u-boot-project.org/en/latest/develop/index.html
>  where we describe coding standards and the patch submission process.
> diff --git a/doc/CONTRIBUTE.rst b/doc/CONTRIBUTE.rst
> index a47dfdca2216..a6e1cd1fb68a 100644
> --- a/doc/CONTRIBUTE.rst
> +++ b/doc/CONTRIBUTE.rst
> @@ -22,7 +22,7 @@ Repository
>  The official U-Boot repository is located at https://source.denx.de/u-boot/u-boot
>
>  Further more detailed documentation can be found at the following link:
> -https://docs.u-boot.org/en/latest/index.html
> +https://docs.u-boot-project.org/en/latest/index.html
>
>  Contributions
>  -------------
> diff --git a/doc/build/documentation.rst b/doc/build/documentation.rst
> index b55a46666431..65f767440bd5 100644
> --- a/doc/build/documentation.rst
> +++ b/doc/build/documentation.rst
> @@ -40,7 +40,7 @@ The *htmldocs* target is used to build the HTML documentation. It uses the
>      # Display the documentation in a graphical web browser
>      x-www-browser doc/output/index.html
>
> -The HTML documentation is published at https://docs.u-boot.org. The build
> +The HTML documentation is published at https://docs.u-boot-project.org. The build
>  process for that site is controlled by the file *.readthedocs.yml*.
>
>  Infodoc documentation
> diff --git a/doc/device-tree-bindings/bootcount-syscon.txt b/doc/device-tree-bindings/bootcount-syscon.txt
> index ea27b246c8a4..8e6060a711e6 100644
> --- a/doc/device-tree-bindings/bootcount-syscon.txt
> +++ b/doc/device-tree-bindings/bootcount-syscon.txt
> @@ -1,6 +1,6 @@
>  Bootcount Configuration
>  This is the implementation of the feature as described in
> -https://docs.u-boot.org/en/latest/api/bootcount.html
> +https://docs.u-boot-project.org/en/latest/api/bootcount.html
>
>  Required Properties:
>  - compatible: must be "u-boot,bootcount-syscon".
> diff --git a/doc/mkeficapsule.1 b/doc/mkeficapsule.1
> index d6653ec42472..ed296730eeb9 100644
> --- a/doc/mkeficapsule.1
> +++ b/doc/mkeficapsule.1
> @@ -153,4 +153,4 @@ The directory in which all capsule files be placed
>  Written by AKASHI Takahiro <takahiro.akashi@linaro.org>
>
>  .SH HOMEPAGE
> -http://www.u-boot.org/
> +http://www.u-boot-project.org/
> diff --git a/drivers/bootcount/Kconfig b/drivers/bootcount/Kconfig
> index 99b6c7534fda..4c0c8d89bb40 100644
> --- a/drivers/bootcount/Kconfig
> +++ b/drivers/bootcount/Kconfig
> @@ -6,7 +6,7 @@ menuconfig BOOTCOUNT_LIMIT
>         bool "Enable support for checking boot count limit"
>         help
>           Enable checking for exceeding the boot count limit.
> -         More information: https://docs.u-boot.org/en/latest/api/bootcount.html
> +         More information: https://docs.u-boot-project.org/en/latest/api/bootcount.html
>
>  if BOOTCOUNT_LIMIT
>
> diff --git a/tools/binman/etype/atf_fip.py b/tools/binman/etype/atf_fip.py
> index 636e073afc84..681b79006823 100644
> --- a/tools/binman/etype/atf_fip.py
> +++ b/tools/binman/etype/atf_fip.py
> @@ -163,7 +163,7 @@ class Entry_atf_fip(Entry_section):
>
>      .. _FIP: https://trustedfirmware-a.readthedocs.io/en/latest/design/firmware-design.html#firmware-image-package-fip
>      .. _`TF-A source tree`: https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
> -    .. _`send a patch`: https://docs.u-boot.org/en/latest/develop/sending_patches.html
> +    .. _`send a patch`: https://docs.u-boot-project.org/en/latest/develop/sending_patches.html
>      """
>      def __init__(self, section, etype, node):
>          # Put this here to allow entry-docs and help to work without libfdt
> diff --git a/tools/binman/missing-blob-help b/tools/binman/missing-blob-help
> index d2ed35bef4d0..27dc620bd359 100644
> --- a/tools/binman/missing-blob-help
> +++ b/tools/binman/missing-blob-help
> @@ -55,7 +55,7 @@ HS-FS and HS-SE parts will not boot without this certificate.
>  Have a look at your board's documentation to find and include the latest
>  TIFS certificate blobs and how to include them in the build.
>
> -    https://docs.u-boot.org/en/latest/board/ti/k3.html
> +    https://docs.u-boot-project.org/en/latest/board/ti/k3.html
>
>  tee-os:
>  See the documentation for your board. You may need to build Open Portable
> @@ -69,7 +69,7 @@ will not boot without this firmware.
>  Have a look at your board's documentation to find the latest version of
>  the DM firmware binary and how to include it in the build.
>
> -    https://docs.u-boot.org/en/latest/board/ti/k3.html
> +    https://docs.u-boot-project.org/en/latest/board/ti/k3.html
>
>  ti-fs-enc.bin:
>  You are missing TI's Foundational Security (TIFS) firmware which is
> @@ -80,4 +80,4 @@ this firmware.
>  Have a look at your board's documentation to find the latest version of the
>  TIFS firmware binary and how to include them in the build.
>
> -    https://docs.u-boot.org/en/latest/board/ti/k3.html
> +    https://docs.u-boot-project.org/en/latest/board/ti/k3.html
> diff --git a/tools/binman/pyproject.toml b/tools/binman/pyproject.toml
> index 7c9ab0f2a27e..2f17588e9df4 100644
> --- a/tools/binman/pyproject.toml
> +++ b/tools/binman/pyproject.toml
> @@ -19,7 +19,7 @@ classifiers = [
>  ]
>
>  [project.urls]
> -"Homepage" = "https://docs.u-boot.org/en/latest/develop/package/index.html"
> +"Homepage" = "https://docs.u-boot-project.org/en/latest/develop/package/index.html"
>  "Bug Tracker" = "https://source.denx.de/groups/u-boot/-/issues"
>
>  [project.scripts]
> diff --git a/tools/buildman/pyproject.toml b/tools/buildman/pyproject.toml
> index 274042df1553..5f5c405afbf0 100644
> --- a/tools/buildman/pyproject.toml
> +++ b/tools/buildman/pyproject.toml
> @@ -23,7 +23,7 @@ classifiers = [
>  ]
>
>  [project.urls]
> -"Homepage" = "https://docs.u-boot.org/en/latest/build/buildman.html"
> +"Homepage" = "https://docs.u-boot-project.org/en/latest/build/buildman.html"
>  "Bug Tracker" = "https://source.denx.de/groups/u-boot/-/issues"
>
>  [project.scripts]
> diff --git a/tools/dtoc/pyproject.toml b/tools/dtoc/pyproject.toml
> index cc96cf784c66..53b09dba8859 100644
> --- a/tools/dtoc/pyproject.toml
> +++ b/tools/dtoc/pyproject.toml
> @@ -19,7 +19,7 @@ classifiers = [
>  ]
>
>  [project.urls]
> -"Homepage" = "https://docs.u-boot.org/en/latest/develop/driver-model/of-plat.html"
> +"Homepage" = "https://docs.u-boot-project.org/en/latest/develop/driver-model/of-plat.html"
>  "Bug Tracker" = "https://source.denx.de/groups/u-boot/-/issues"
>
>  [project.scripts]
> diff --git a/tools/patman/pyproject.toml b/tools/patman/pyproject.toml
> index 91802c8cc277..0fc4b7d4ecda 100644
> --- a/tools/patman/pyproject.toml
> +++ b/tools/patman/pyproject.toml
> @@ -19,7 +19,7 @@ classifiers = [
>  ]
>
>  [project.urls]
> -"Homepage" = "https://docs.u-boot.org/en/latest/develop/patman.html"
> +"Homepage" = "https://docs.u-boot-project.org/en/latest/develop/patman.html"
>  "Bug Tracker" = "https://source.denx.de/groups/u-boot/-/issues"
>
>  [project.scripts]
> diff --git a/tools/u_boot_pylib/pyproject.toml b/tools/u_boot_pylib/pyproject.toml
> index ed04d956b4e6..1c6a023ee4b3 100644
> --- a/tools/u_boot_pylib/pyproject.toml
> +++ b/tools/u_boot_pylib/pyproject.toml
> @@ -18,7 +18,7 @@ classifiers = [
>  ]
>
>  [project.urls]
> -"Homepage" = "https://docs.u-boot.org"
> +"Homepage" = "https://docs.u-boot-project.org"
>  "Bug Tracker" = "https://source.denx.de/groups/u-boot/-/issues"
>
>  [tool.setuptools]
> --
> 2.43.0
>
