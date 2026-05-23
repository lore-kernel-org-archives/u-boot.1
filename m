Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61191CD5BB1
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 05:47:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AF1A83C2B;
	Sat, 23 May 2026 07:47:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qY9Et3Be";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67967844CF; Sat, 23 May 2026 07:47:31 +0200 (CEST)
Received: from mail-yx1-xb132.google.com (mail-yx1-xb132.google.com
 [IPv6:2607:f8b0:4864:20::b132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A747F805D7
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 07:47:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-65c37eafcbeso8523501d50.1
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 22:47:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779515247; cv=none;
 d=google.com; s=arc-20240605;
 b=izBOS0kIlXHFVoAsxkDL4zyC+SklfhxmSGIZm9fnfiVEhvC7HNkEeZrd9viTWvhBO7
 GJ8RickCW72lE2o1mlefm8+p7/JpRyAOhXXSq1408eTco5ODB4fNZHRV/kDsX1iyltXl
 ubJkUvVko36w82rAF85HPFJFNSqTFUwR2ciR64QnmpFnaTFaeMiEZKNFSmtygdNkfvVH
 LrSlOpiW29DLhLiV3yVMH3xrLmiNWH8oua9ShNWZg2ZUpy99hfIBVWRp5Iz1KhwuuN11
 x4ZyzkqefBL+0sPAK4MHN+Hu7v+iCEhlL5GHvyGzINiTGNr2e2tM7yBfKqjdAXwbT5lA
 S8nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eCU04VJ4pOc8oNJkfdnQueaXjoi6NQSn6o7/QILVIRk=;
 fh=3cGkqt4Xgv2w9dTeeIJFEJ5AO4AvGobPArcY4WlS1wc=;
 b=IYMrdg4tV+oNxwXmDpaUOMSiEepIR3MgE/zElYwxLXqR4TgpCUySobSVnMsiOqLmLE
 8Rnu5a+pzFpeKpeXuC6/IjJkpKjVm713tFDHagq0dcJNPpup+zyD9o0IUgx4y954jA/Z
 myo6hwYYoBdzof+ciX5obXWbQmULNmxt8spnMBl2gFDb5qsevr0hjoGdSLO5R4A3BXWO
 fh/kTkqp0dmjwI+9+NXByjNS6GCZrT3yKIg+1ECZrScADqNLuCRdOPkZDDGnmZy4ud78
 JD7gCv0kZSQF37NBffadnBGF0j6nXboD9Z1ueLofdoPL4khaGBgy02791SmZgo03hgQm
 bG8Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779515247; x=1780120047; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eCU04VJ4pOc8oNJkfdnQueaXjoi6NQSn6o7/QILVIRk=;
 b=qY9Et3BeOqNfLZlD8qoLEbcFMoCQE8RzZbcRpuXkMwkFZ0r3BOrKE3LlCKiwZr4b+b
 xphDuDU7MIxRvq4kZhMmNdQg+4ZgSbA8eW0gyuiej2RculNlbluX6AzBnKcpbUthPlNv
 FP3Rr9aJW1aiZEogMlHPNvhH5ujLH/9VFdaDg5GvJMK+UYdJo+hk8gVufAf7h/+id7RY
 ZkGF1ukHgcbu94y0gc+MJsRVvvgr9w/r0/6S7HFNAvW51QGvZf/721JksCfdYG5RKd4Y
 RvV4fdWOQ3Zos0E8Yy2ShMeHnw1RKNR0zHNIYJXuCf+n2dOh8jqQ4LpT22CLqJgbYXoi
 gLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779515247; x=1780120047;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eCU04VJ4pOc8oNJkfdnQueaXjoi6NQSn6o7/QILVIRk=;
 b=F1gm+VlNzBF4uv808xodvMwOaSTiWcOF2Eo6KLcXVw3hvoY4Ni8LtFLaYF3yYxy7Mt
 ekBA68EdJ0CVTIniVxB145Mar9a5DXRCXiNmZi9C9d3oa1jXqe6LdYQv//q83EoG3wTa
 3I7j3idO4xo2deji6U/wqVzN+Njq8XOfkdsQyLATB9sGZBbfpPl9k0Y3zdK7oDDN5xoh
 j/kx96onA423DhaEh5YojbiyU4Dnq9WczKFgo8C8JwOiBTagQ314QQ1fCWblNDL0MlJ7
 I8dcbZ9Zte2gauSMmDi7F+gVlcQekQdrHTy0JfwqYtWgIwC5LwEzvbPR/buekwYaEAXS
 CP8g==
X-Gm-Message-State: AOJu0YxEO0BNCpl2ed2ooSZk2KuFxmxXmevPurLbqj85acUGYzJK888j
 oiHlyRSRUrbDY2Va5NrJLNlRSXNGbfopfPcRFXMkaQnZc+MuELyJfdNw1pMW4xPBc4o8VqHG4hR
 KuSWv8ypqQBbQdGo0eMAKEKz7zXWNqpY=
X-Gm-Gg: Acq92OEpY+JfR9XT0STBz0QrPzOyrNuf0/up6m23e2eVv0c3MbaAZj3IwoyYZ1/2Rpo
 zPIMBbsXDzRWEiuXX79o/zG3Hhkoj0LmQ414eCzygPqNQLzLnZTK2xgFhosS42/knh6ENZ1HFkm
 BzCUMzRYk2R22+VWxxxLZnig1u00va1mHa2LyOZz6cGRIX4+33HKVea7Mn6TzC6b6ac6C3feDYv
 o7ab+mOLEvzoIqld1xxcM10+cmYKrMMnYiFo5QVjgKK+2RrudTp13qMJ1vtwYiqODlkAwWCDAKd
 eozpdiDo
X-Received: by 2002:a05:690c:6004:b0:7bd:577d:7828 with SMTP id
 00721157ae682-7d3379ab234mr72269597b3.31.1779515247300; Fri, 22 May 2026
 22:47:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260522235838.2536318-1-trini@konsulko.com>
In-Reply-To: <20260522235838.2536318-1-trini@konsulko.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Fri, 22 May 2026 22:47:15 -0700
X-Gm-Features: AVHnY4LEPDG6_s8iOrcYIxKUnsvYiza7NOlUJpy9ZNb3bfO_4KV0PNCFxght3as
Message-ID: <CAJaLiFz=bnnojhQyVabTH6=rC0AmkErgsMiYDo=UFmWfD5bWgA@mail.gmail.com>
Subject: Re: [PATCH] global: Update URL for U-Boot project
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

Thanks Tom!

On Fri, May 22, 2026 at 5:08=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> Our official domain is now u-boot-project.org, so update all in-tree
> references to use the correct domain.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
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
> +W:     https://docs.u-boot-project.org/en/latest/develop/uefi/u-boot_on_=
efi.html
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
>  The official U-Boot repository is located at https://source.denx.de/u-bo=
ot/u-boot
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
> @@ -40,7 +40,7 @@ The *htmldocs* target is used to build the HTML documen=
tation. It uses the
>      # Display the documentation in a graphical web browser
>      x-www-browser doc/output/index.html
>
> -The HTML documentation is published at https://docs.u-boot.org. The buil=
d
> +The HTML documentation is published at https://docs.u-boot-project.org. =
The build
>  process for that site is controlled by the file *.readthedocs.yml*.
>
>  Infodoc documentation
> diff --git a/doc/device-tree-bindings/bootcount-syscon.txt b/doc/device-t=
ree-bindings/bootcount-syscon.txt
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
> -         More information: https://docs.u-boot.org/en/latest/api/bootcou=
nt.html
> +         More information: https://docs.u-boot-project.org/en/latest/api=
/bootcount.html
>
>  if BOOTCOUNT_LIMIT
>
> diff --git a/tools/binman/etype/atf_fip.py b/tools/binman/etype/atf_fip.p=
y
> index 636e073afc84..681b79006823 100644
> --- a/tools/binman/etype/atf_fip.py
> +++ b/tools/binman/etype/atf_fip.py
> @@ -163,7 +163,7 @@ class Entry_atf_fip(Entry_section):
>
>      .. _FIP: https://trustedfirmware-a.readthedocs.io/en/latest/design/f=
irmware-design.html#firmware-image-package-fip
>      .. _`TF-A source tree`: https://git.trustedfirmware.org/TF-A/trusted=
-firmware-a.git
> -    .. _`send a patch`: https://docs.u-boot.org/en/latest/develop/sendin=
g_patches.html
> +    .. _`send a patch`: https://docs.u-boot-project.org/en/latest/develo=
p/sending_patches.html
>      """
>      def __init__(self, section, etype, node):
>          # Put this here to allow entry-docs and help to work without lib=
fdt
> diff --git a/tools/binman/missing-blob-help b/tools/binman/missing-blob-h=
elp
> index d2ed35bef4d0..27dc620bd359 100644
> --- a/tools/binman/missing-blob-help
> +++ b/tools/binman/missing-blob-help
> @@ -55,7 +55,7 @@ HS-FS and HS-SE parts will not boot without this certif=
icate.
>  Have a look at your board's documentation to find and include the latest
>  TIFS certificate blobs and how to include them in the build.
>
> -    https://docs.u-boot.org/en/latest/board/ti/k3.html
> +    https://docs.u-boot-project.org/en/latest/board/ti/k3.html
>
>  tee-os:
>  See the documentation for your board. You may need to build Open Portabl=
e
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
>  Have a look at your board's documentation to find the latest version of =
the
>  TIFS firmware binary and how to include them in the build.
>
> -    https://docs.u-boot.org/en/latest/board/ti/k3.html
> +    https://docs.u-boot-project.org/en/latest/board/ti/k3.html
> diff --git a/tools/binman/pyproject.toml b/tools/binman/pyproject.toml
> index 7c9ab0f2a27e..2f17588e9df4 100644
> --- a/tools/binman/pyproject.toml
> +++ b/tools/binman/pyproject.toml
> @@ -19,7 +19,7 @@ classifiers =3D [
>  ]
>
>  [project.urls]
> -"Homepage" =3D "https://docs.u-boot.org/en/latest/develop/package/index.=
html"
> +"Homepage" =3D "https://docs.u-boot-project.org/en/latest/develop/packag=
e/index.html"
>  "Bug Tracker" =3D "https://source.denx.de/groups/u-boot/-/issues"
>
>  [project.scripts]
> diff --git a/tools/buildman/pyproject.toml b/tools/buildman/pyproject.tom=
l
> index 274042df1553..5f5c405afbf0 100644
> --- a/tools/buildman/pyproject.toml
> +++ b/tools/buildman/pyproject.toml
> @@ -23,7 +23,7 @@ classifiers =3D [
>  ]
>
>  [project.urls]
> -"Homepage" =3D "https://docs.u-boot.org/en/latest/build/buildman.html"
> +"Homepage" =3D "https://docs.u-boot-project.org/en/latest/build/buildman=
.html"
>  "Bug Tracker" =3D "https://source.denx.de/groups/u-boot/-/issues"
>
>  [project.scripts]
> diff --git a/tools/dtoc/pyproject.toml b/tools/dtoc/pyproject.toml
> index cc96cf784c66..53b09dba8859 100644
> --- a/tools/dtoc/pyproject.toml
> +++ b/tools/dtoc/pyproject.toml
> @@ -19,7 +19,7 @@ classifiers =3D [
>  ]
>
>  [project.urls]
> -"Homepage" =3D "https://docs.u-boot.org/en/latest/develop/driver-model/o=
f-plat.html"
> +"Homepage" =3D "https://docs.u-boot-project.org/en/latest/develop/driver=
-model/of-plat.html"
>  "Bug Tracker" =3D "https://source.denx.de/groups/u-boot/-/issues"
>
>  [project.scripts]
> diff --git a/tools/patman/pyproject.toml b/tools/patman/pyproject.toml
> index 91802c8cc277..0fc4b7d4ecda 100644
> --- a/tools/patman/pyproject.toml
> +++ b/tools/patman/pyproject.toml
> @@ -19,7 +19,7 @@ classifiers =3D [
>  ]
>
>  [project.urls]
> -"Homepage" =3D "https://docs.u-boot.org/en/latest/develop/patman.html"
> +"Homepage" =3D "https://docs.u-boot-project.org/en/latest/develop/patman=
.html"
>  "Bug Tracker" =3D "https://source.denx.de/groups/u-boot/-/issues"
>
>  [project.scripts]
> diff --git a/tools/u_boot_pylib/pyproject.toml b/tools/u_boot_pylib/pypro=
ject.toml
> index ed04d956b4e6..1c6a023ee4b3 100644
> --- a/tools/u_boot_pylib/pyproject.toml
> +++ b/tools/u_boot_pylib/pyproject.toml
> @@ -18,7 +18,7 @@ classifiers =3D [
>  ]
>
>  [project.urls]
> -"Homepage" =3D "https://docs.u-boot.org"
> +"Homepage" =3D "https://docs.u-boot-project.org"
>  "Bug Tracker" =3D "https://source.denx.de/groups/u-boot/-/issues"
>
>  [tool.setuptools]
> --
> 2.43.0
>
Reviewed-by: Tony Dinh <mibodhi@gmail.com>
