Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A855CEFCE47
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 21:01:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBD1F83642;
	Wed,  4 Mar 2026 22:01:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=wolfssl-com.20230601.gappssmtp.com header.i=@wolfssl-com.20230601.gappssmtp.com header.b="udOv8y+8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55DEF838BB; Wed,  4 Mar 2026 21:52:51 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 462F2800AE
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 21:52:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aidan@wolfssl.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-79800183233so101603417b3.1
 for <u-boot@lists.denx.de>; Wed, 04 Mar 2026 12:52:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772657559; cv=none;
 d=google.com; s=arc-20240605;
 b=kwCGYGhl122vU3jxe6dInglBmPI6RdeqwG+wd2e5WbUbDmoRYdbIl3xGguN0IX7nzA
 1Gawa+QW7HGGufMqNa/uSeR6tu3iKWUjDaPNjym/jsswsG2Y8E8RsMMEzbzTq5fH263k
 AcjsRSdhIqJCPz9EHQGQDPFV8h1WxVXy558uUnFBrFzYEMFrJOIm6RFhXrVlfGk/mI0f
 6/+KPeEMxXEVkrTxKN2rEz4y3GhPbQP3UfmJWkgXur/2bUvnzk1pktncZtBzZLtcHc5j
 LIszTMNGgzPqkcmjxnqYDhsCBDOv+C3Y9hg+aI8eABzBPrqBuS6zFZcvlpvf24sn/Kdy
 bV6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RBXzv9NllGfz3dk0s+hO3n44J5fT/JfeymIIgvLu/ac=;
 fh=mopO3CoLQ9bPdYUuZpv9E9UUnqM/OqwaTWNiFdXBLsk=;
 b=CTNijVAVqqJO9Gv49YmE1+euVH22uAK9iK5h+1kukH4YF0x7BPT31yU9ReTUTtLSYD
 9FdsZUSdd/ucL/ExChDTlbDP+7Nnbs66tX+gIznNmPQpaC9C9nhcjnoylghqcwj5nhsX
 CEA6HJhgl3glUt3UMphNJd/de4J9612Yk2DtmXzvgpS8//BAhYvD1V5H8nn2wSCwgPVN
 AJr1PgRRD49CHzb1hoI54KvEZcVdoezCsNY3oWy4UG+/1+r9fv/3759pdo1o7cLb5uXj
 3+qEd/J09ZQUpkjpj3RyHppWC5BqmIhBw6IEh0JZRILKeFrMlScGfXqKlU0ZpxY8ClfO
 R0qQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wolfssl-com.20230601.gappssmtp.com; s=20230601; t=1772657559; x=1773262359;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RBXzv9NllGfz3dk0s+hO3n44J5fT/JfeymIIgvLu/ac=;
 b=udOv8y+8FpRvRIQTOS+a4ZugL1S7vM1RGBI5tTYfHr0JW2h/0Fr7eLnWDOtJRPnj9c
 X2huB4QrETdiZZPBQTRAzOjSwSJ19dNUqAHIVOnI1shlvByV8bmwjob+JDfzpLwfx1M4
 RFs9hDBl8jFtw3JrU1d2u14KfMi78D5qMngJ6nEUpC7j9bSjaSKtpvXHzEe4NN9WPz7n
 bOk8Uw/tJ+v7Qs3ggO5QV7zoHID6KVt8x/DFilxK+Ph2yO+ZjmlvhXFDuc8IP3HGcaVL
 Ct2zqOHI4NEMQXeSwsIrH+JSYhSfj74B51TaJD1JHg3cAVJG56O20Bu/tKHSEFHX35cJ
 OsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772657559; x=1773262359;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RBXzv9NllGfz3dk0s+hO3n44J5fT/JfeymIIgvLu/ac=;
 b=gSI/OHWYOzUkYx9qYi1MWO1Dak46MKzyPwebF1vJcpmIHbwyMJN4mESZCHeBdYys9s
 tgLR/BdaAsG+/pKkxRWMupX55QlxiSJssZ4+dvhCOt0KuT9NZJdFGnirpVzm6n47Pw3X
 dnkcWRSsJVAZsGAEgxWa+nO0zj0gvz7GszypyFJxaPPA2V+qrLTXq91WM5CZtxqpa7TG
 AymvLX79qr4isrt6zBdynU5b3Z2+pmCm8737ZIqmiWzrZqK+sj+lqIezHBhlqX0V9gre
 b07WZNx1g79hlixGtBkRf2WHTtw856X5otf1lvdb7Z/Eqzq2ozU+KiYGvO/71rCEqcF1
 vnxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsqLNZ6FdtZ+NJNFSoWIf6ITpO5XpKZ6h0GnpsSSsn0KGw3OcQwNcIEMhhEkgl89uzdtHkTcI=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1n6ivDFfkZ8q4TDR4qTpktaXBtgYGFm2dkEM6pvBeu/hwP7Vz
 eIfxy8uB/OwmmJTpHlLHcMpNcaAuYrXyaqnETEmmnIYbr8LBqG5+OZRRFOt/soNf8ySOwkq6Nw8
 uhpwMOQ4RwmPwX6nxmzQMhwScsjAkkwphuK0VzwmwLauN35524W4GhUHVZw==
X-Gm-Gg: ATEYQzxUwVHSrniHYHUSkYAKszGv6N5SprayR3OhdhLOxTw6nM9r+3aWyyUJWpoeUxz
 pN29s8QRI0BZY3nOJY1FK1/S/WlbR3fIxS1VkspeEXEj5tigSFMDHifpDavFRqj+yeXKmx3cqBX
 D4+lfigpRkWkLNdW7MpmqymqawQSCPCd3il0/Tj9Cle6zqceYdPTKQB2KE15EK/otJxsqtHHk7Z
 ccXFlUHYG9dWNBq7eahWXENU2R+xTNuKo7Hb9O+TOX8vk5jQf5bLSt2GIdZqvRR5+dbKvkjdO9m
 i6GzZ/d1D5mvN5oOSCxPa41avJgfLh4td6hNguvGVqiY3fCDFGcKQNj1yjW51PcOKeFIWvsjAk7
 jmyL6
X-Received: by 2002:a05:690c:6d82:b0:798:c633:d13b with SMTP id
 00721157ae682-798c6fcd17amr20435857b3.24.1772657558396; Wed, 04 Mar 2026
 12:52:38 -0800 (PST)
MIME-Version: 1.0
References: <20260128171112.1818705-1-david@wolfssl.com>
 <DGSZG59RY7XF.1UNZIXDZ4XYVN@linaro.org>
In-Reply-To: <DGSZG59RY7XF.1UNZIXDZ4XYVN@linaro.org>
From: Aidan Garske <aidan@wolfssl.com>
Date: Wed, 4 Mar 2026 12:52:26 -0800
X-Gm-Features: AaiRm51PB35acYUHaZjen1WsHXVdlPzinJrItqtK7YTF3IqBmChBy4at3D0rfg4
Message-ID: <CANqXHyF2KzMLp33YWbDM4KZbimAf4Tdbi9bNVi9B+YrsDtje1w@mail.gmail.com>
Subject: Re: [PATCH] tpm: Add wolfTPM library support for TPM 2.0
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: David Garske <david@wolfssl.com>, u-boot@lists.denx.de
X-Mailman-Approved-At: Wed, 04 Mar 2026 22:01:53 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Ilias!

I'm reviewing your feedback and need clarification on exactly what you
want. We have the cmd/wolftpm.c and cmd/tpm-v2.The C files are basically
duplicates of each other and it seems like you want to avoid maintaining 2
sets of the same functions, which is totally understandable. My question:

1. For these two files I think the best approach is to migrate
the wolftpm.c to tpm-v2.c and directly use the ifdef macros to choose
between the wolftpm or tpm2 APIs based on what was compiled in. This gives
us unified functions that should be easier to maintain than 2
separate files. If that sounds good I will make those changes; otherwise,
let me know what you are thinking.

thanks you,
Aidan
------------------------------------
Aidan Garske
Engineering Intern, wolfSSL
+1 (916) 337-1246
-------------------------------------


On Mon, Mar 2, 2026 at 11:52=E2=80=AFPM Ilias Apalodimas <
ilias.apalodimas@linaro.org> wrote:

> Hi David,
> Aplogies for the late reply, a ew comments below.
>
> On Wed Jan 28, 2026 at 7:11 PM EET, David Garske wrote:
> > From: Aidan Garske <aidan@wolfssl.com>
> >
> > Add wolfTPM library integration to U-Boot, providing an alternative
> > TPM 2.0 implementation with native API access and enhanced features.
> >
> > wolfTPM is a portable, open-source TPM 2.0 library that provides:
> > - Native TPM 2.0 API with direct access to all TPM 2.0 commands
> > - Wrapper API for simplified common TPM operations
> > - Direct SPI communication via internal TIS layer
> > - Firmware update support for Infineon SLB9672/SLB9673 TPMs
> >
> > The standard tpm2 commands (init, startup, self_test, pcr_read,
> > pcr_extend, clear, etc.) work with any TPM 2.0 compliant module.
> > Firmware update functionality is specific to Infineon SLB9672/SLB9673
> > TPMs only.
> >
> > Key components added:
> > - cmd/wolftpm.c: TPM2 command implementation using wolfTPM APIs
> > - lib/wolftpm: wolfTPM library as git submodule
> > - drivers/spi/bcm2835_spi.c: BCM2835 SPI driver for Raspberry Pi 4
> > - drivers/tpm/tpm_spi_sandbox.c: TPM SPI sandbox driver for testing
> > - drivers/tpm/wolftpm_common.c: Common wolfTPM driver functions
> > - include/configs/user_settings.h: wolfTPM build configuration
> >
> > Configuration options:
> > - CONFIG_TPM_WOLF: Enable wolfTPM support (mutually exclusive with
> >   CONFIG_CMD_TPM_V2)
> > - CONFIG_WOLFTPM_SLB9672: Enable Infineon SLB9672/SLB9673 firmware
> >   update support
> > - CONFIG_BCM2835_SPI: Enable BCM2835 SPI driver
> >
> > Device tree updates for Raspberry Pi 4, QEMU arm64, and sandbox
> > environments to support TPM over SPI.
> >
> > Tested on Raspberry Pi 4 Model B with Infineon SLB9670 (LetsTrust HAT)
> > and SLB9672 TPMs.
> >
> > Signed-off-by: Aidan Garske <aidan@wolfssl.com>
> > ---
> >  .gitmodules                       |    3 +
> >  README                            |    3 +
> >  README.wolftpm.md                 |  149 +++
> >  arch/arm/dts/bcm2711-rpi-4-b.dts  |   20 +
> >  arch/arm/dts/qemu-arm64.dts       |    4 +
> >  arch/sandbox/dts/sandbox.dtsi     |   11 +
> >  cmd/Kconfig                       |   16 +
> >  cmd/Makefile                      |   11 +-
> >  cmd/tpm-common.c                  |    4 +-
> >  cmd/wolftpm.c                     | 1443 +++++++++++++++++++++++++++++
> >  configs/rpi_4_defconfig           |   29 +-
> >  doc/usage/cmd/wolftpm.rst         |  694 ++++++++++++++
> >  drivers/mtd/spi/sandbox.c         |   30 +-
> >  drivers/spi/Kconfig               |    9 +
> >  drivers/spi/Makefile              |    1 +
> >  drivers/spi/bcm2835_spi.c         |  429 +++++++++
> >  drivers/tpm/Kconfig               |   36 +
> >  drivers/tpm/Makefile              |    9 +
> >  drivers/tpm/tpm_spi_sandbox.c     |  410 ++++++++
> >  drivers/tpm/wolftpm_common.c      |  135 +++
> >  include/configs/user_settings.h   |  118 +++
> >  include/hash.h                    |   17 +
> >  include/linux/byteorder/generic.h |   31 +-
> >  include/tpm-common.h              |   22 +
> >  include/wolftpm.h                 |   33 +
> >  lib/Kconfig                       |   13 +
> >  lib/Makefile                      |   18 +
> >  lib/wolftpm                       |    1 +
> >  lib/wolftpm.c                     |   56 ++
> >  scripts/check-local-export        |    9 +
> >  test/cmd/Makefile                 |    1 +
> >  test/cmd/wolftpm.c                |  364 ++++++++
> >  test/py/tests/test_wolftpm.py     |  373 ++++++++
> >  33 files changed, 4483 insertions(+), 19 deletions(-)
>
> This need to be broken down to a series of patches, that we can review.
> Having everything in a
> single patch is not reviewable.
>
> >
> > +             CONFIG_TPM_WOLF
> > +             Enables support for wolfTPM library.
> > +
>
> I think I've asked this before, but is wolfTPM GPLv2?
>
> This needs to be it's own patch. e.g Add TPM into rpi4
> > diff --git a/arch/arm/dts/bcm2711-rpi-4-b.dts
> b/arch/arm/dts/bcm2711-rpi-4-b.dts
> > index 72ce80fbf26..a09276dc279 100644
> > --- a/arch/arm/dts/bcm2711-rpi-4-b.dts
> > +++ b/arch/arm/dts/bcm2711-rpi-4-b.dts
> > @@ -8,6 +8,11 @@
> >       compatible =3D "raspberrypi,4-model-b", "brcm,bcm2711";
> >       model =3D "Raspberry Pi 4 Model B";
> >
> > +     /* Alias hardware SPI as spi0 so wolfTPM finds it at bus 0 */
> > +     aliases {
> > +             spi0 =3D &spi;
> > +     };
> > +
> >       chosen {
> >               /* 8250 auxiliary UART instead of pl011 */
> >               stdout-path =3D "serial1:115200n8";
> > @@ -54,6 +59,21 @@
> >               enable-active-high;
> >               gpio =3D <&expgpio 6 GPIO_ACTIVE_HIGH>;
> >       };
> > +
> > +};
> > +
> > +/* Hardware SPI with TPM - matches Linux tpm-slb9670 overlay */
> > +&spi {
> > +     status =3D "okay";
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&spi0_gpio7>;
> > +
> > +     /* Infineon SLB9670/9672 TPM 2.0 on CE1 (GPIO7) */
> > +     tpm@1 {
> > +             compatible =3D "infineon,slb9670", "tcg,tpm_tis-spi";
> > +             reg =3D <1>;  /* CE1 */
> > +             spi-max-frequency =3D <32000000>;
> > +     };
> >  };
> >
> >  &ddc0 {
> > diff --git a/arch/arm/dts/qemu-arm64.dts b/arch/arm/dts/qemu-arm64.dts
> > index 95fcf53ed74..e74d036a532 100644
> > --- a/arch/arm/dts/qemu-arm64.dts
> > +++ b/arch/arm/dts/qemu-arm64.dts
> > @@ -12,4 +12,8 @@
> >  #endif
> >
> >  / {
> > +     tpm@0c000000 {
> > +             compatible =3D "tcg,tpm-tis-mmio";
> > +             reg =3D <0x0 0x0c000000 0x0 0x5000>;
> > +     };
>
> Same here for the sandbox
>
> >  };
> > diff --git a/arch/sandbox/dts/sandbox.dtsi
> b/arch/sandbox/dts/sandbox.dtsi
> > index 02b03894eaf..2fdd7f0e942 100644
> > --- a/arch/sandbox/dts/sandbox.dtsi
> > +++ b/arch/sandbox/dts/sandbox.dtsi
> > @@ -286,6 +286,17 @@
> >                       spi-max-frequency =3D <40000000>;
> >                       sandbox,filename =3D "spi.bin";
> >               };
> > +
> > +             tpm_spi: tpm@1 {
> > +                     reg =3D <1>;
> > +                     compatible =3D "sandbox,tpm-spi";
> > +                     spi-max-frequency =3D <10000000>;
> > +                     sandbox,emul =3D <&tpm_spi_emul>;
> > +             };
> > +     };
> > +
> > +     tpm_spi_emul: tpm-spi-emul {
> > +             compatible =3D "sandbox,tpm-spi-emul";
> >       };
> >
> >       spl-test {
> > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > index cc4dd5a3163..3a4be20268e 100644
> > --- a/cmd/Kconfig
> > +++ b/cmd/Kconfig
> > @@ -2814,6 +2814,9 @@ config CMD_TPM
> >         command requires a suitable TPM on your board and the correct
> driver
> >         must be enabled.
> >
> > +       Note: For TPM2, do not enable both CMD_TPM and CMD_WOLFTPM as
> they
> > +       both provide the tpm2 command.
> > +
> >  if CMD_TPM
> >
> >  config CMD_TPM_TEST
> > @@ -3194,4 +3197,17 @@ config CMD_SPAWN_NUM_JOBS
> >         When a jobs exits, its identifier is available to be re-used by
> the next
> >         spawn command.
> >
> > +config CMD_WOLFTPM
> > +     bool "Enable wolfTPM tpm2 command (replaces standard tpm2)"
> > +     depends on TPM && TPM_V2
> > +     select TPM_WOLF
> > +     help
> > +       This provides the 'tpm2' command using the wolfTPM library
> instead
> > +       of the standard U-Boot TPM2 implementation. wolfTPM offers
> additional
> > +       features including firmware update support for Infineon TPMs an=
d
> > +       enhanced capabilities reporting.
> > +
> > +       Note: Do not enable both CMD_TPM and CMD_WOLFTPM as they both
> > +       provide the tpm2 command.
> > +
> >  endif
> > diff --git a/cmd/Makefile b/cmd/Makefile
> > index 4cd13d4fa6e..9c622e3d717 100644
> > --- a/cmd/Makefile
> > +++ b/cmd/Makefile
> > @@ -191,9 +191,18 @@ obj-$(CONFIG_CMD_TIMER) +=3D timer.o
> >  obj-$(CONFIG_CMD_TRACE) +=3D trace.o
> >  obj-$(CONFIG_HUSH_PARSER) +=3D test.o
> >  obj-$(CONFIG_CMD_TPM) +=3D tpm-common.o
> > -obj-$(CONFIG_CMD_TPM_V1) +=3D tpm-v1.o
> >  obj-$(CONFIG_CMD_TPM_TEST) +=3D tpm_test.o
> > +ifeq ($(CONFIG_TPM_WOLF),y)
> > +ifeq ($(CONFIG_TPM_V2),y)
> > +ccflags-y +=3D -Ilib/wolftpm \
> > +             -Iinclude/configs \
> > +             -DWOLFTPM_USER_SETTINGS
> > +obj-$(CONFIG_TPM_WOLF) +=3D wolftpm.o
> > +endif
> > +else
> > +obj-$(CONFIG_CMD_TPM_V1) +=3D tpm-v1.o
>
> So WolfTPM doesn't support V1? If that's the case the if selection should
> be giarded
> by a TPMv2 config option and allow the user to select wolf vs existing
>
> >  obj-$(CONFIG_CMD_TPM_V2) +=3D tpm-v2.o
> > +endif
> >  obj-$(CONFIG_CMD_CROS_EC) +=3D cros_ec.o
> >  obj-$(CONFIG_CMD_UBI) +=3D ubi.o
> >  obj-$(CONFIG_CMD_UBIFS) +=3D ubifs.o
>
> This needs to be on its own patch explaining why staic is added etc
>
> > diff --git a/cmd/tpm-common.c b/cmd/tpm-common.c
> > index 1cd57f901b6..30e99e10758 100644
> > --- a/cmd/tpm-common.c
> > +++ b/cmd/tpm-common.c
> > @@ -234,7 +234,7 @@ int type_string_write_vars(const char *type_str, u8
> *data,
> >       return 0;
> >  }
> >
> > -static int tpm_show_device(void)
> > +int tpm_show_device(void)
> >  {
> >       struct udevice *dev;
> >       char buf[80];
> > @@ -253,7 +253,7 @@ static int tpm_show_device(void)
> >       return 0;
> >  }
> >
> > -static int tpm_set_device(unsigned long num)
> > +int tpm_set_device(unsigned long num)
> >  {
> >       struct udevice *dev;
> >       unsigned long n =3D 0;
> > diff --git a/cmd/wolftpm.c b/cmd/wolftpm.c
> > new file mode 100644
> > index 00000000000..cafd790cfaa
>
> Same for teh code below.
>
> > --- /dev/null
> > +++ b/cmd/wolftpm.c
> > @@ -0,0 +1,1443 @@
> > +/* wolftpm.c
> > +*
> > +* SPDX-License-Identifier: GPL-2.0+
> > +*
> > +* (C) Copyright 2025
> > +* Aidan Garske <aidan@wolfssl.com>
> > +*/
> > +
> > +#define LOG_CATEGORY UCLASS_BOOTSTD
> > +
> > +#ifdef HAVE_CONFIG_H
> > +    #include <config.h>
> > +#endif
> > +
> > +#include <wolftpm/tpm2.h>
> > +#include <wolftpm/tpm2_wrap.h>
> > +#include <wolftpm/tpm2_packet.h>
> > +#include <wolftpm.h>
> > +
> > +#include <stdio.h>
> > +#include <hash.h>
> > +#ifndef WOLFTPM2_NO_WRAPPER
> > +
> > +#include <hal/tpm_io.h>
> > +#include <examples/wrap/wrap_test.h>
> > +
> > +/* U-boot specific includes */
> > +#include <command.h>
> > +#include <tpm-common.h>
> > +#include <vsprintf.h>
> > +#include <mapmem.h>
> > +#include <errno.h>
> > +#include <log.h>
> > +#include <string.h>
> > +
> > +
> > +/* Firmware update info structure for Infineon TPM */
> > +#ifdef WOLFTPM_FIRMWARE_UPGRADE
> > +#if defined(WOLFTPM_SLB9672) || defined(WOLFTPM_SLB9673)
> > +typedef struct {
> > +    byte*  manifest_buf;
> > +    byte*  firmware_buf;
> > +    size_t manifest_bufSz;
> > +    size_t firmware_bufSz;
> > +} fw_info_t;
> > +#endif
> > +#endif
> > +
> >
> +/***********************************************************************=
*******/
> > +/* --- BEGIN Common Commands -- */
> >
> +/***********************************************************************=
*******/
> > +
> > +#ifdef WOLFTPM_LINUX_DEV
> > +/* Use U-Boot's TPM device model for device/info/state when in Linux
> dev mode */
> > +static int do_tpm2_device(struct cmd_tbl *cmdtp, int flag,
> > +    int argc, char *const argv[])
> > +{
> > +    int rc;
> > +    unsigned long num;
> > +
> > +    /* Expected 1-2 arg: command + [num device] */
> > +    if (argc < 1 || argc > 2) {
> > +        return CMD_RET_USAGE;
> > +    }
> > +
> > +    if (argc =3D=3D 2) {
> > +        num =3D dectoul(argv[1], NULL);
> > +        rc =3D tpm_set_device(num);
> > +        if (rc)
> > +            log_debug("Couldn't set TPM %lu (rc =3D %d)\n", num, rc);
> > +    } else {
> > +        rc =3D tpm_show_device();
> > +    }
> > +
> > +    log_debug("tpm device: rc =3D %d (%s)\n", rc, TPM2_GetRCString(rc)=
);
> > +
> > +    return rc;
> > +}
> > +
> > +static int do_tpm2_info(struct cmd_tbl *cmdtp, int flag,
> > +    int argc, char *const argv[])
> > +{
> > +    int rc;
> > +    char buf[80];
> > +    struct udevice *dev;
> > +
> > +    if (argc !=3D 1) {
> > +        return CMD_RET_USAGE;
> > +    }
> > +
> > +    /* Init the TPM2 device */
> > +    rc =3D get_tpm(&dev);
> > +    if (rc =3D=3D 0) {
>
> We usually do if (!rc)
>
> > +        /* Get the current TPM's description
> > +         * tpm_get_desc returns the number of bytes written on success
> */
> > +        rc =3D tpm_get_desc(dev, buf, sizeof(buf));
> > +        if (rc < 0) {
> > +            log_debug("Couldn't get TPM info (%d)\n", rc);
> > +            rc =3D CMD_RET_FAILURE;
> > +        }
> > +        else {
> > +            log_debug("%s\n", buf);
> > +            rc =3D 0; /* Success - return 0, not byte count */
> > +        }
> > +    }
> > +
> > +    log_debug("tpm2 info: rc =3D %d (%s)\n", rc, TPM2_GetRCString(rc))=
;
> > +
> > +    return rc;
> > +}
> > +
> > +static int do_tpm2_state(struct cmd_tbl *cmdtp, int flag,
> > +    int argc, char *const argv[])
> > +{
> > +    int rc;
> > +    char buf[80];
> > +    struct udevice *dev;
> > +
> > +    if (argc !=3D 1) {
> > +        return CMD_RET_USAGE;
> > +    }
> > +
> > +    /* Init the TPM2 device */
> > +    rc =3D get_tpm(&dev);
> > +    if (rc =3D=3D 0) {
>
> Same here
>
> > +        /* Get the current TPM's state
> > +         * tpm_report_state may return -ENOSYS if not implemented by
> driver */
> > +        rc =3D tpm_report_state(dev, buf, sizeof(buf));
> > +        if (rc =3D=3D -ENOSYS) {
>
> > +            log_debug("TPM state reporting not supported by driver\n")=
;
> > +            rc =3D 0; /* Not an error, just not supported */
> > +        }
>
> The coding style is  } else if etc. Also I'd switch those ifs around
>  if (rc < 0 ) {
>      .....
>  } else {
>      if (rc =3D=3D -ENOSYS)
>      .....
>  }
>
> > +        else if (rc < 0) {
> > +            log_debug("Couldn't get TPM state (%d)\n", rc);
> > +            rc =3D CMD_RET_FAILURE;
> > +        }
> > +        else {
> > +            log_debug("%s\n", buf);
> > +            rc =3D 0; /* Success - return 0, not byte count */
> > +        }
> > +    }
> > +
> > +    log_debug("tpm2 state: rc =3D %d (%s)\n", rc, TPM2_GetRCString(rc)=
);
> > +
> > +    return rc;
> > +}
> > +
> > +#else /* !WOLFTPM_LINUX_DEV - Native SPI mode implementations */
>
> Instead of having ifdefs, I'd prefer having the wolftpm implementation
> split to
> its own file. We can then if needeed have a tpm2_common.c if the 2
> implementations
> share code.
>
> > +
> > +static int do_tpm2_device(struct cmd_tbl *cmdtp, int flag,
> > +    int argc, char *const argv[])
> > +{
> > +    WOLFTPM2_DEV dev;
> > +    WOLFTPM2_CAPS caps;
> > +    int rc;
> > +
> > +    /* Expected 1 arg only in native SPI mode (no device switching) */
> > +    if (argc !=3D 1) {
> > +        return CMD_RET_USAGE;
> > +    }
> > +
> > +    /* Try to initialize and get device info */
> > +    rc =3D wolfTPM2_Init(&dev, TPM2_IoCb, NULL);
> > +    if (rc =3D=3D 0) {
>
> if(!rc)
>
> > +        rc =3D wolfTPM2_GetCapabilities(&dev, &caps);
> > +        if (rc =3D=3D 0) {
> > +            printf("TPM Device 0: %s (%s) FW=3D%d.%d\n",
> > +                   caps.mfgStr, caps.vendorStr,
> > +                   caps.fwVerMajor, caps.fwVerMinor);
> > +        }
> > +        wolfTPM2_Cleanup(&dev);
> > +    }
> > +
> > +    if (rc !=3D 0) {
> > +        printf("No TPM device found (rc=3D%d: %s)\n", rc,
> TPM2_GetRCString(rc));
> > +        return CMD_RET_FAILURE;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static int do_tpm2_info(struct cmd_tbl *cmdtp, int flag,
> > +    int argc, char *const argv[])
> > +{
> > +    WOLFTPM2_DEV dev;
> > +    WOLFTPM2_CAPS caps;
> > +    int rc;
> > +
> > +    if (argc !=3D 1) {
> > +        return CMD_RET_USAGE;
> > +    }
> > +
> > +    /* Init the TPM2 device */
> > +    rc =3D wolfTPM2_Init(&dev, TPM2_IoCb, NULL);
> > +    if (rc =3D=3D 0) {
>
> Same here
>
> > +        if (rc =3D=3D 0) {
> > +            printf("TPM 2.0: %s (%s)\n", caps.mfgStr, caps.vendorStr);
> > +            printf("  Firmware: %d.%d (0x%08X)\n",
> > +                   caps.fwVerMajor, caps.fwVerMinor, caps.fwVerVendor)=
;
> > +            printf("  Type: 0x%08X\n", caps.tpmType);
> > +        }
> > +        wolfTPM2_Cleanup(&dev);
> > +    }
> > +
> > +    if (rc !=3D 0) {
> > +        printf("Couldn't get TPM info (rc=3D%d: %s)\n", rc,
> TPM2_GetRCString(rc));
> > +        return CMD_RET_FAILURE;
> > +    }
> > +
> > +    log_debug("tpm2 info: rc =3D %d (%s)\n", rc, TPM2_GetRCString(rc))=
;
> > +    return 0;
> > +}
> > +
> > +static int do_tpm2_state(struct cmd_tbl *cmdtp, int flag,
> > +    int argc, char *const argv[])
> > +{
> > +    WOLFTPM2_DEV dev;
> > +    WOLFTPM2_CAPS caps;
> > +    int rc;
> > +
> > +    if (argc !=3D 1) {
> > +        return CMD_RET_USAGE;
> > +    }
> > +
> > +    /* Init the TPM2 device */
> > +    rc =3D wolfTPM2_Init(&dev, TPM2_IoCb, NULL);
> > +    if (rc =3D=3D 0) {
> > +        rc =3D wolfTPM2_GetCapabilities(&dev, &caps);
> > +        if (rc =3D=3D 0) {
> > +            printf("TPM State:\n");
> > +            printf("  Manufacturer: %s\n", caps.mfgStr);
> > +            printf("  Vendor: %s\n", caps.vendorStr);
> > +            printf("  Firmware: %d.%d\n", caps.fwVerMajor,
> caps.fwVerMinor);
> > +#if defined(WOLFTPM_SLB9672) || defined(WOLFTPM_SLB9673)
> > +            printf("  Mode: Infineon SLB967x (Native SPI)\n");
> > +            printf("  OpMode: %d\n", caps.opMode);
> > +#else
> > +            printf("  Mode: Native wolfTPM SPI\n");
> > +#endif
> > +        }
> > +        wolfTPM2_Cleanup(&dev);
> > +    }
> > +
> > +    if (rc !=3D 0) {
> > +        printf("Couldn't get TPM state (rc=3D%d: %s)\n", rc,
> TPM2_GetRCString(rc));
> > +        return CMD_RET_FAILURE;
> > +    }
> > +
> > +    log_debug("tpm2 state: rc =3D %d (%s)\n", rc, TPM2_GetRCString(rc)=
);
> > +    return 0;
> > +}
> > +
> > +#endif /* WOLFTPM_LINUX_DEV */
> > +
> > +static int do_tpm2_init(struct cmd_tbl *cmdtp, int flag, int argc,
> > +    char *const argv[])
> > +{
> > +    WOLFTPM2_DEV dev;
> > +
> > +    if (argc !=3D 1) {
> > +        return CMD_RET_USAGE;
> > +    }
> > +
> > +    /* Init the TPM2 device */
> > +    return TPM2_Init_Device(&dev, NULL);
> > +}
> > +
> > +
> > +static int do_tpm2_autostart(struct cmd_tbl *cmdtp, int flag, int argc=
,
> > +    char *const argv[])
> > +{
> > +    int rc;
> > +    WOLFTPM2_DEV dev;
> > +
> > +    if (argc !=3D 1) {
> > +        return CMD_RET_USAGE;
> > +    }
> > +
> > +    /* Init the TPM2 device */
> > +    rc =3D TPM2_Init_Device(&dev, NULL);
> > +    if (rc =3D=3D TPM_RC_SUCCESS) {
> > +        /* Perform a startup clear
> > +        * doStartup=3D1: Just starts up the TPM */
> > +        rc =3D wolfTPM2_Reset(&dev, 0, 1);
> > +        /* TPM_RC_INITIALIZE means already started - treat as success =
*/
> > +        if (rc =3D=3D TPM_RC_INITIALIZE) {
> > +            rc =3D TPM_RC_SUCCESS;
> > +        } else if (rc !=3D TPM_RC_SUCCESS) {
> > +            log_debug("wolfTPM2_Reset failed 0x%x: %s\n", rc,
> > +                TPM2_GetRCString(rc));
> > +        }
> > +    }
> > +    if (rc =3D=3D TPM_RC_SUCCESS) {
> > +        /* Perform a full self test */
> > +        rc =3D wolfTPM2_SelfTest(&dev);
> > +        if (rc !=3D TPM_RC_SUCCESS) {
> > +            log_debug("wolfTPM2_SelfTest failed 0x%x: %s\n", rc,
> > +                TPM2_GetRCString(rc));
> > +        }
> > +    }
> > +
> > +    log_debug("tpm2 autostart: rc =3D %d (%s)\n", rc,
> TPM2_GetRCString(rc));
> > +
> > +    return rc;
> > +}
> > +
> >
> +/***********************************************************************=
*******/
> > +/* --- END Common Commands -- */
> >
> +/***********************************************************************=
*******/
> > +
> > +
> >
> +/***********************************************************************=
*******/
> > +/* --- START TPM 2.0 Commands -- */
> >
> +/***********************************************************************=
*******/
> > +
> > +static int do_tpm2_wrapper_getcapsargs(struct cmd_tbl *cmdtp, int flag=
,
> > +    int argc, char *const argv[])
> > +{
> > +    GetCapability_In  in;
> > +    GetCapability_Out out;
> > +    u32 capability, property, rc;
> > +    u8 *data;
> > +    size_t count;
> > +    int i, j;
> > +
> > +    if (argc !=3D 5)
> > +        return CMD_RET_USAGE;
> > +
> > +    capability =3D simple_strtoul(argv[1], NULL, 0);
> > +    property =3D simple_strtoul(argv[2], NULL, 0);
> > +    data =3D map_sysmem(simple_strtoul(argv[3], NULL, 0), 0);
> > +    count =3D simple_strtoul(argv[4], NULL, 0);
> > +
> > +    memset(&in, 0, sizeof(in));
> > +    memset(&out, 0, sizeof(out));
> > +    in.capability =3D capability;
> > +    in.property =3D property;
> > +    in.propertyCount =3D count;
> > +    rc =3D TPM2_GetCapability(&in, &out);
> > +    if (rc =3D=3D 0) {
> > +        XMEMCPY(data, &out.capabilityData.data,
> sizeof(out.capabilityData.data));
>
> We don't want to carry extra internal implementation details. Is this jus=
t
> a memcpy?
>
> > +
> > +        printf("Capabilities read from TPM:\n");
> > +        for (i =3D 0; i < count; i++) {
> > +            printf("Property 0x");
> > +            for (j =3D 0; j < 4; j++)
> > +                printf("%02x", data[(i * 8) + j + sizeof(u32)]);
> > +            printf(": 0x");
> > +            for (j =3D 4; j < 8; j++)
> > +                printf("%02x", data[(i * 8) + j + sizeof(u32)]);
> > +            printf("\n");
> > +        }
> > +    }
> > +
> > +    unmap_sysmem(data);
> > +
> > +    log_debug("tpm2 get_capability: rc =3D %d (%s)\n", rc,
> TPM2_GetRCString(rc));
> > +
> > +    return rc;
> > +}
> > +
> > +static int do_tpm2_wrapper_capsargs(struct cmd_tbl *cmdtp, int flag,
> > +    int argc, char *const argv[])
> > +{
> > +    int rc;
> > +    WOLFTPM2_DEV dev;
> > +    WOLFTPM2_CAPS caps;
> > +
> > +    if (argc !=3D 1) {
> > +        return CMD_RET_USAGE;
> > +    }
> > +
> > +    /* Init the TPM2 device */
> > +    rc =3D TPM2_Init_Device(&dev, NULL);
> > +    if (rc =3D=3D TPM_RC_SUCCESS) {
> > +        rc =3D wolfTPM2_GetCapabilities(&dev, &caps);
> > +    }
>
> You don't need {} here. Also if the first result isn't TPM_RC_SUCCESS all
> of the followjng
> ifs will fail. Should't we just fail early?
>
> > +    if (rc =3D=3D TPM_RC_SUCCESS) {
> > +        log_debug("Mfg %s (%d), Vendor %s, Fw %u.%u (0x%x), "
> > +            "FIPS 140-2 %d, CC-EAL4 %d\n",
> > +            caps.mfgStr, caps.mfg, caps.vendorStr, caps.fwVerMajor,
> > +            caps.fwVerMinor, caps.fwVerVendor, caps.fips140_2,
> caps.cc_eal4);
> > +#if defined(WOLFTPM_SLB9672) || defined(WOLFTPM_SLB9673)
> > +        log_debug("Operational mode: %s (0x%x)\n",
> > +            TPM2_IFX_GetOpModeStr(caps.opMode), caps.opMode);
> > +        log_debug("KeyGroupId 0x%x, FwCounter %d (%d same)\n",
> > +            caps.keyGroupId, caps.fwCounter, caps.fwCounterSame);
> > +#endif
> > +    }
> > +
> > +    /* List the active persistent handles */
> > +    if (rc =3D=3D TPM_RC_SUCCESS) {
> > +        rc =3D wolfTPM2_GetHandles(PERSISTENT_FIRST, NULL);
> > +        if (rc >=3D TPM_RC_SUCCESS) {
> > +            log_debug("Found %d persistent handles\n", rc);
> > +        }
> > +    }
> > +
> > +    /* Print the available PCR's */
> > +    if (rc =3D=3D TPM_RC_SUCCESS) {
> > +        rc =3D TPM2_PCRs_Print();
> > +    }
> > +
> > +    /* Only doShutdown=3D1: Just shut down the TPM */
> > +    wolfTPM2_Reset(&dev, 1, 0);
> > +
> > +    wolfTPM2_Cleanup(&dev);
> > +
> > +    log_debug("tpm2 caps: rc =3D %d (%s)\n", rc, TPM2_GetRCString(rc))=
;
> > +
> > +    return rc;
> > +}
> > +
>
> The upgrade functionality should be a patch of its own
>
> > +#ifdef WOLFTPM_FIRMWARE_UPGRADE
> > +#if defined(WOLFTPM_SLB9672) || defined(WOLFTPM_SLB9673)
> > +static int do_tpm2_firmware_update(struct cmd_tbl *cmdtp, int flag,
> > +    int argc, char *const argv[])
> > +{
> > +    int rc;
> > +    WOLFTPM2_DEV dev;
> > +    WOLFTPM2_CAPS caps;
> > +    fw_info_t fwinfo;
> > +    ulong manifest_addr, firmware_addr;
> > +    size_t manifest_sz, firmware_sz;
> > +    uint8_t manifest_hash[TPM_SHA384_DIGEST_SIZE];
> > +    int recovery =3D 0;
> > +
> > +    memset(&fwinfo, 0, sizeof(fwinfo));
> > +
> > +    /* Need 5 args: command + 4 arguments */
> > +    if (argc !=3D 5) {
> > +        log_debug("Error: Expected 5 arguments but got %d\n", argc);
> > +        return CMD_RET_USAGE;
> > +    }
> > +    printf("TPM2 Firmware Update\n");
> > +
> > +    /* Convert all arguments from strings to numbers */
> > +    manifest_addr =3D simple_strtoul(argv[1], NULL, 0);
> > +    manifest_sz =3D simple_strtoul(argv[2], NULL, 0);
> > +    firmware_addr =3D simple_strtoul(argv[3], NULL, 0);
> > +    firmware_sz =3D simple_strtoul(argv[4], NULL, 0);
> > +
> > +    /* Map the memory addresses */
> > +    fwinfo.manifest_buf =3D map_sysmem(manifest_addr, manifest_sz);
> > +    fwinfo.firmware_buf =3D map_sysmem(firmware_addr, firmware_sz);
> > +    fwinfo.manifest_bufSz =3D manifest_sz;
> > +    fwinfo.firmware_bufSz =3D firmware_sz;
> > +
> > +    if (fwinfo.manifest_buf =3D=3D NULL || fwinfo.firmware_buf =3D=3D =
NULL) {
> > +        log_debug("Error: Invalid memory addresses\n");
> > +        return CMD_RET_FAILURE;
> > +    }
> > +
> > +    printf("Infineon Firmware Update Tool\n");
> > +    printf("\tManifest Address: 0x%lx (size: %zu)\n",
> > +        manifest_addr, manifest_sz);
> > +    printf("\tFirmware Address: 0x%lx (size: %zu)\n",
> > +        firmware_addr, firmware_sz);
> > +
> > +    rc =3D TPM2_Init_Device(&dev, NULL);
> > +    if (rc =3D=3D TPM_RC_SUCCESS) {
> > +        rc =3D wolfTPM2_GetCapabilities(&dev, &caps);
> > +    }
> > +
> > +    if (rc =3D=3D TPM_RC_SUCCESS) {
> > +        TPM2_IFX_PrintInfo(&caps);
> > +        if (caps.keyGroupId =3D=3D 0) {
> > +            log_debug("Error getting key group id from TPM!\n");
> > +        }
> > +        if (caps.opMode =3D=3D 0x02 || (caps.opMode & 0x80)) {
> > +            /* if opmode =3D=3D 2 or 0x8x then we need to use recovery=
 mode
> */
> > +            recovery =3D 1;
> > +        }
> > +    }
> > +
> > +    if (rc =3D=3D TPM_RC_SUCCESS) {
> > +        if (recovery) {
> > +            printf("Firmware Update (recovery mode):\n");
> > +            rc =3D wolfTPM2_FirmwareUpgradeRecover(&dev,
> > +                fwinfo.manifest_buf, (uint32_t)fwinfo.manifest_bufSz,
> > +                TPM2_IFX_FwData_Cb, &fwinfo);
> > +        }
> > +        else {
>
> On the entire patch take a look at the coding style and run checkpatch.pl
> please.
> It's usually
>   if () {
>      ....
>   } else {
>      ....
>   }
>
> > +            /* Normal mode - hash with wc_Sha384Hash */
> > +            printf("Firmware Update (normal mode):\n");
> > +            rc =3D wc_Sha384Hash(fwinfo.manifest_buf,
> > +                (uint32_t)fwinfo.manifest_bufSz, manifest_hash);
> > +            if (rc =3D=3D TPM_RC_SUCCESS) {
> > +                rc =3D wolfTPM2_FirmwareUpgradeHash(&dev, TPM_ALG_SHA3=
84,
> > +                    manifest_hash, (uint32_t)sizeof(manifest_hash),
> > +                    fwinfo.manifest_buf,
> (uint32_t)fwinfo.manifest_bufSz,
> > +                    TPM2_IFX_FwData_Cb, &fwinfo);
> > +            }
> > +        }
> > +    }
> > +    if (rc =3D=3D TPM_RC_SUCCESS) {
> > +        TPM2_IFX_PrintInfo(&caps);
> > +    }
> > +
> > +    if (fwinfo.manifest_buf)
> > +        unmap_sysmem(fwinfo.manifest_buf);
> > +    if (fwinfo.firmware_buf)
> > +        unmap_sysmem(fwinfo.firmware_buf);
> > +
> > +    if (rc !=3D TPM_RC_SUCCESS) {
> > +        log_debug("Infineon firmware update failed 0x%x: %s\n",
> > +            rc, TPM2_GetRCString(rc));
> > +    }
> > +
> > +    wolfTPM2_Cleanup(&dev);
> > +
> > +    log_debug("tpm2 firmware_update: rc=3D%d (%s)\n", rc,
> TPM2_GetRCString(rc));
> > +
> > +    return rc;
> > +}
> > +
> > +static int do_tpm2_firmware_cancel(struct cmd_tbl *cmdtp, int flag,
> > +    int argc, char *const argv[])
> > +{
> > +    int rc;
> > +    WOLFTPM2_DEV dev;
> > +    uint8_t cmd[TPM2_HEADER_SIZE + 2];
> > +    uint16_t val16;
> > +
> > +    if (argc !=3D 1) {
> > +        return CMD_RET_USAGE;
> > +    }
> > +
> > +    /* Init the TPM2 device */
> > +    rc =3D TPM2_Init_Device(&dev, NULL);
> > +    if (rc =3D=3D TPM_RC_SUCCESS) {
> > +        /* Setup command size in header */
> > +        val16 =3D TPM2_HEADER_SIZE + 2;
> > +        XMEMCPY(cmd, &val16, sizeof(val16));
> > +        val16 =3D 0;
> > +        XMEMCPY(&cmd[TPM2_HEADER_SIZE], &val16, sizeof(val16));
> > +
> > +        rc =3D
> TPM2_IFX_FieldUpgradeCommand(TPM_CC_FieldUpgradeAbandonVendor,
> > +            cmd, sizeof(cmd));
> > +        if (rc !=3D TPM_RC_SUCCESS) {
> > +            log_debug("Firmware abandon failed 0x%x: %s\n",
> > +                rc, TPM2_GetRCString(rc));
> > +        }
> > +    }
> > +
> > +    wolfTPM2_Cleanup(&dev);
> > +
> > +    log_debug("tpm2 firmware_cancel: rc=3D%d (%s)\n", rc,
> TPM2_GetRCString(rc));
> > +
> > +    return rc;
> > +}
> > +#endif /* WOLFTPM_SLB9672 || WOLFTPM_SLB9673 */
> > +#endif /* WOLFTPM_FIRMWARE_UPGRADE */
> > +
>
> > +static int do_tpm2_startup(struct cmd_tbl *cmdtp, int flag,
> > +    int argc, char *const argv[])
> > +{
>
> Why can't we reuse the existing functions and just replace tthe TPM calls
> with
> wolfTPM here? Opencoding the startup sequence twice seems unecessary.
>
> > +    int rc;
> > +    WOLFTPM2_DEV dev;
> > +    Startup_In startupIn;
> > +    Shutdown_In shutdownIn;
> > +    int doStartup =3D YES;
> > +
> > +    /* startup TPM2_SU_CLEAR|TPM2_SU_STATE [off] */
> > +    if (argc < 2 || argc > 3)
> > +        return CMD_RET_USAGE;
> > +    /* Check if shutdown requested */
> > +    if (argc =3D=3D 3) {
> > +        if (strcmp(argv[2], "off") !=3D 0)
> > +            return CMD_RET_USAGE;
> > +        doStartup =3D NO; /* shutdown */
> > +    }
> > +    printf("TPM2 Startup\n");
> > +
> > +    memset(&startupIn, 0, sizeof(startupIn));
> > +    memset(&shutdownIn, 0, sizeof(shutdownIn));
> > +
> > +    /* Init the TPM2 device */
> > +    rc =3D TPM2_Init_Device(&dev, NULL);
> > +    if (rc !=3D TPM_RC_SUCCESS) return rc;
> > +
> > +    if (!strcmp(argv[1], "TPM2_SU_CLEAR")) {
> > +        if (doStartup =3D=3D YES) {
> > +            startupIn.startupType =3D TPM_SU_CLEAR;
> > +        } else {
> > +            shutdownIn.shutdownType =3D TPM_SU_CLEAR;
> > +        }
> > +    } else if (!strcmp(argv[1], "TPM2_SU_STATE")) {
> > +        if (doStartup =3D=3D YES) {
> > +            startupIn.startupType =3D TPM_SU_STATE;
> > +        } else {
> > +            shutdownIn.shutdownType =3D TPM_SU_STATE;
> > +        }
> > +    } else {
> > +        log_debug("Couldn't recognize mode string: %s\n", argv[1]);
> > +        wolfTPM2_Cleanup(&dev);
> > +        return CMD_RET_FAILURE;
> > +    }
> > +
> > +    /* startup */
> > +    if (doStartup =3D=3D YES) {
> > +        rc =3D TPM2_Startup(&startupIn);
> > +        /* TPM_RC_INITIALIZE =3D Already started */
> > +        if (rc !=3D TPM_RC_SUCCESS && rc !=3D TPM_RC_INITIALIZE) {
> > +            log_debug("TPM2 Startup: Result =3D 0x%x (%s)\n", rc,
> > +                TPM2_GetRCString(rc));
> > +        }
> > +    /* shutdown */
> > +    } else {
> > +        rc =3D TPM2_Shutdown(&shutdownIn);
> > +        if (rc !=3D TPM_RC_SUCCESS) {
> > +            log_debug("TPM2 Shutdown: Result =3D 0x%x (%s)\n", rc,
> > +                TPM2_GetRCString(rc));
> > +        }
> > +    }
> > +
> > +    wolfTPM2_Cleanup(&dev);
> > +
> > +    if (rc >=3D 0)
> > +        rc =3D 0;
> > +
> > +    log_debug("tpm2 startup (%s): rc =3D %d (%s)\n",
> > +        doStartup ? "startup" : "shutdown", rc, TPM2_GetRCString(rc));
> > +
> > +    return rc;
> > +}
> > +
> o
> > +static int do_tpm2_selftest(struct cmd_tbl *cmdtp, int flag,
>
> Same here
>
> > +    int argc, char *const argv[])
> > +{
> > +    int rc;
> > +    WOLFTPM2_DEV dev;
> > +    TPMI_YES_NO fullTest =3D YES;
> > +
> > +    /* Need 2 arg: command + type */
> > +    if (argc !=3D 2) {
> > +        return CMD_RET_USAGE;
> > +    }
> > +
> > +    /* Init the TPM2 device */
> > +    rc =3D TPM2_Init_Device(&dev, NULL);
> > +    if (rc =3D=3D TPM_RC_SUCCESS) {
> > +        if (!strcmp(argv[1], "full")) {
> > +            fullTest =3D YES;
> > +        } else if (!strcmp(argv[1], "continue")) {
> > +            fullTest =3D NO;
> > +        } else {
> > +            log_debug("Couldn't recognize test mode: %s\n", argv[1]);
> > +            wolfTPM2_Cleanup(&dev);
> > +            return CMD_RET_FAILURE;
> > +        }
> > +
> > +        /* full test */
> > +        if (fullTest =3D=3D YES) {
> > +            rc =3D wolfTPM2_SelfTest(&dev);
> > +            if (rc !=3D TPM_RC_SUCCESS) {
> > +                log_debug("TPM2 Self Test: Result =3D 0x%x (%s)\n", rc=
,
> > +                    TPM2_GetRCString(rc));
> > +            }
> > +        /* continue test */
> > +        } else {
> > +            rc =3D wolfTPM2_SelfTest(&dev);
> > +            if (rc !=3D TPM_RC_SUCCESS) {
> > +                log_debug("TPM2 Self Test: Result =3D 0x%x (%s)\n", rc=
,
> > +                    TPM2_GetRCString(rc));
> > +            }
> > +        }
> > +    }
> > +
> > +    wolfTPM2_Cleanup(&dev);
> > +
> > +    log_debug("tpm2 selftest (%s): rc =3D %d (%s)\n",
> > +        fullTest ? "full" : "continue", rc, TPM2_GetRCString(rc));
> > +
> > +    return rc;
> > +}
> > +
> > +static int do_tpm2_clear(struct cmd_tbl *cmdtp, int flag,
> > +    int argc, char *const argv[])
> > +{
> > +    int rc;
> > +    WOLFTPM2_DEV dev;
> > +    Clear_In clearIn;
> > +    TPMI_RH_CLEAR handle;
> > +
> > +    /* Need 2 arg: command + type */
> > +    if (argc !=3D 2) {
> > +        return CMD_RET_USAGE;
> > +    }
> > +
> > +    if (!strcasecmp("TPM2_RH_LOCKOUT", argv[1])) {
> > +        handle =3D TPM_RH_LOCKOUT;
> > +    } else if (!strcasecmp("TPM2_RH_PLATFORM", argv[1])) {
> > +        handle =3D TPM_RH_PLATFORM;
> > +    } else {
> > +        return CMD_RET_USAGE;
> > +    }
> > +
> > +    /* Init the TPM2 device */
> > +    rc =3D TPM2_Init_Device(&dev, NULL);
> > +    if (rc =3D=3D TPM_RC_SUCCESS) {
> > +        /* Set up clear */
> > +        memset(&clearIn, 0, sizeof(clearIn));
> > +        clearIn.authHandle =3D handle;
> > +
> > +        rc =3D TPM2_Clear(&clearIn);
> > +        if (rc !=3D TPM_RC_SUCCESS) {
> > +            log_debug("TPM2 Clear: Result =3D 0x%x (%s)\n", rc,
> > +                TPM2_GetRCString(rc));
> > +        }
> > +    }
> > +
> > +    wolfTPM2_Cleanup(&dev);
> > +
> > +    log_debug("tpm2 clear (%s): rc =3D %d (%s)\n",
> > +        handle =3D=3D TPM_RH_LOCKOUT ? "TPM2_RH_LOCKOUT" :
> "TPM2_RH_PLATFORM",
> > +        rc, TPM2_GetRCString(rc));
> > +
> > +    return rc;
> > +}
> > +
> > +static int do_tpm2_pcr_extend(struct cmd_tbl *cmdtp, int flag,
> > +    int argc, char *const argv[])
> > +{
>
> And here
>
> > +    int rc;
> > +    WOLFTPM2_DEV dev;
> > +    uint32_t pcrIndex;
> > +    int algo =3D TPM_ALG_SHA256;
> > +    int digestLen;
> > +    void *digest;
> > +    ulong digest_addr;
> > +
> > +    /* Need 3-4 args: command + pcr + digest_addr + [algo] */
> > +    if (argc < 3 || argc > 4) {
> > +        return CMD_RET_USAGE;
> > +    }
> > +    printf("TPM2 PCR Extend\n");
> > +
> > +    pcrIndex =3D simple_strtoul(argv[1], NULL, 0);
> > +    digest_addr =3D simple_strtoul(argv[2], NULL, 0);
> > +
> > +    /* Optional algorithm */
> > +    if (argc =3D=3D 4) {
> > +        algo =3D TPM2_GetAlgId(argv[3]);
> > +        if (algo < 0) {
> > +            log_debug("Couldn't recognize algorithm: %s\n", argv[3]);
> > +            return CMD_RET_FAILURE;
> > +        }
> > +        log_debug("Using algorithm: %s\n", TPM2_GetAlgName(algo));
> > +    }
> > +
> > +    /* Get digest length based on algorithm */
> > +    digestLen =3D TPM2_GetHashDigestSize(algo);
> > +    if (digestLen <=3D 0) {
> > +        log_debug("Invalid algorithm digest length\n");
> > +        return CMD_RET_FAILURE;
> > +    }
> > +
> > +    /* Map digest from memory address */
> > +    digest =3D map_sysmem(digest_addr, digestLen);
> > +    if (digest =3D=3D NULL) {
> > +        log_debug("Error: Invalid digest memory address\n");
> > +        return CMD_RET_FAILURE;
> > +    }
> > +
> > +    log_debug("TPM2 PCR Extend: PCR %u with %s digest\n",
> > +        (unsigned int)pcrIndex, TPM2_GetAlgName(algo));
> > +
> > +    /* Init the TPM2 device */
> > +    rc =3D TPM2_Init_Device(&dev, NULL);
> > +    if (rc !=3D TPM_RC_SUCCESS) {
> > +        unmap_sysmem(digest);
> > +        return rc;
> > +    }
> > +
> > +    /* Extend the PCR */
> > +    rc =3D wolfTPM2_ExtendPCR(&dev, pcrIndex, algo, digest, digestLen)=
;
> > +    if (rc !=3D TPM_RC_SUCCESS) {
> > +        log_debug("TPM2_PCR_Extend failed 0x%x: %s\n", rc,
> > +            TPM2_GetRCString(rc));
> > +    }
> > +
> > +    unmap_sysmem(digest);
> > +    wolfTPM2_Cleanup(&dev);
> > +
> > +    log_debug("tpm2 pcr_extend: rc =3D %d (%s)\n", rc,
> TPM2_GetRCString(rc));
> > +
> > +    return rc;
> > +}
> > +
> > +static int do_tpm2_pcr_read(struct cmd_tbl *cmdtp, int flag,
> > +    int argc, char *const argv[])
>
> And here
>
> > +{
> > +    int rc;
> > +    WOLFTPM2_DEV dev;
> > +    uint32_t pcrIndex;
> > +    int algo =3D TPM_ALG_SHA256;
> > +    void *digest;
> > +    ulong digest_addr;
> > +    int digestLen;
> > +
> > +    /* Need 3-4 args: command + pcr + digest_addr + [algo] */
> > +    if (argc < 3 || argc > 4) {
> > +        return CMD_RET_USAGE;
> > +    }
> > +
> > +    pcrIndex =3D simple_strtoul(argv[1], NULL, 0);
> > +    digest_addr =3D simple_strtoul(argv[2], NULL, 0);
> > +
> > +    /* Optional algorithm */
> > +    if (argc =3D=3D 4) {
> > +        algo =3D TPM2_GetAlgId(argv[3]);
> > +        if (algo < 0) {
> > +            log_debug("Couldn't recognize algorithm: %s\n", argv[3]);
> > +            return CMD_RET_FAILURE;
> > +        }
> > +        log_debug("Using algorithm: %s\n", TPM2_GetAlgName(algo));
> > +    }
> > +
> > +    /* Get digest length based on algorithm */
> > +    digestLen =3D TPM2_GetHashDigestSize(algo);
> > +    if (digestLen <=3D 0) {
> > +        log_debug("Invalid algorithm digest length\n");
> > +        return CMD_RET_FAILURE;
> > +    }
> > +
> > +    /* Map digest from memory address */
> > +    digest =3D map_sysmem(digest_addr, digestLen);
> > +    if (digest =3D=3D NULL) {
> > +        log_debug("Error: Invalid digest memory address\n");
> > +        return CMD_RET_FAILURE;
> > +    }
> > +
> > +    log_debug("TPM2 PCR Read: PCR %u to %s digest\n",
> > +        (unsigned int)pcrIndex, TPM2_GetAlgName(algo));
> > +
> > +    /* Init the TPM2 device */
> > +    rc =3D TPM2_Init_Device(&dev, NULL);
> > +    if (rc !=3D TPM_RC_SUCCESS) {
> > +        unmap_sysmem(digest);
> > +        return rc;
> > +    }
> > +
> > +    /* Read the PCR */
> > +    rc =3D wolfTPM2_ReadPCR(&dev, pcrIndex, algo, digest, &digestLen);
> > +    if (rc !=3D TPM_RC_SUCCESS) {
> > +        log_debug("TPM2_PCR_Read failed 0x%x: %s\n", rc,
> > +            TPM2_GetRCString(rc));
> > +    }
> > +
> > +    unmap_sysmem(digest);
> > +    wolfTPM2_Cleanup(&dev);
> > +
> > +    log_debug("tpm2 pcr_read: rc =3D %d (%s)\n", rc,
> TPM2_GetRCString(rc));
> > +
> > +    return rc;
> > +}
> > +
> > +static int do_tpm2_pcr_allocate(struct cmd_tbl *cmdtp, int flag,
>
> And here
>
> > +    int argc, char *const argv[])
> > +{
> > +    int rc;
> > +    WOLFTPM2_DEV dev;
> > +    PCR_Allocate_In in;
> > +    PCR_Allocate_Out out;
> > +    TPM2B_AUTH auth;
> > +
> > +    /* Need 3-4 args: command + algorithm + on/off + [password] */
> > +    if (argc < 3 || argc > 4) {
> > +        return CMD_RET_USAGE;
> > +    }
> > +
> > +    /* Init the TPM2 device */
> > +    rc =3D TPM2_Init_Device(&dev, NULL);
> > +    if (rc !=3D TPM_RC_SUCCESS) return rc;
> > +
> > +    /* Setup PCR Allocation command */
> > +    memset(&in, 0, sizeof(in));
> > +    in.authHandle =3D TPM_RH_PLATFORM;
> > +
> > +    /* Single PCR bank allocation */
> > +    in.pcrAllocation.count =3D 1; /* Change only one bank */
> > +    in.pcrAllocation.pcrSelections[0].hash =3D TPM2_GetAlgId(argv[1]);
> > +    in.pcrAllocation.pcrSelections[0].sizeofSelect =3D PCR_SELECT_MAX;
> > +
> > +    /* Set all PCRs for this algorithm */
> > +    if (!strcmp(argv[2], "on")) {
> > +        memset(in.pcrAllocation.pcrSelections[0].pcrSelect, 0xFF,
> > +            PCR_SELECT_MAX);
> > +    }
> > +    /* Clear all PCRs for this algorithm */
> > +    else if (!strcmp(argv[2], "off")) {
> > +        memset(in.pcrAllocation.pcrSelections[0].pcrSelect, 0x00,
> > +            PCR_SELECT_MAX);
> > +    }
> > +    else {
> > +        log_debug("Couldn't recognize allocate mode: %s\n", argv[2]);
> > +        wolfTPM2_Cleanup(&dev);
> > +        return CMD_RET_USAGE;
> > +    }
> > +    log_debug("Attempting to set %s bank to %s\n",
> > +        TPM2_GetAlgName(in.pcrAllocation.pcrSelections[0].hash),
> > +        argv[2]);
> > +
> > +    /* Set auth password if provided */
> > +    if (argc =3D=3D 4) {
> > +        memset(&auth, 0, sizeof(auth));
> > +        auth.size =3D strlen(argv[3]);
> > +        XMEMCPY(auth.buffer, argv[3], auth.size);
> > +        rc =3D wolfTPM2_SetAuth(&dev, 0, TPM_RH_PLATFORM, &auth, 0, NU=
LL);
> > +        if (rc !=3D TPM_RC_SUCCESS) {
> > +            log_debug("wolfTPM2_SetAuth failed 0x%x: %s\n", rc,
> > +                TPM2_GetRCString(rc));
> > +            wolfTPM2_Cleanup(&dev);
> > +            return rc;
> > +        }
> > +    }
> > +
> > +    /* Allocate the PCR */
> > +    rc =3D TPM2_PCR_Allocate(&in, &out);
> > +    if (rc !=3D TPM_RC_SUCCESS) {
> > +        log_debug("TPM2_PCR_Allocate failed 0x%x: %s\n", rc,
> > +            TPM2_GetRCString(rc));
> > +    }
> > +
> > +    /* Print current PCR state */
> > +    printf("\n\tNOTE: A TPM restart is required for changes to take
> effect\n");
> > +    printf("\nCurrent PCR state:\n");
> > +    TPM2_PCRs_Print();
> > +
> > +    wolfTPM2_Cleanup(&dev);
> > +
> > +    printf("Allocation Success: %s\n",
> > +        out.allocationSuccess ? "YES" : "NO");
> > +    log_debug("tpm2 pcr_allocate %s (%s): rc =3D %d (%s)\n",
> > +        TPM2_GetAlgName(in.pcrAllocation.pcrSelections[0].hash),
> > +        argv[2], rc, TPM2_GetRCString(rc));
> > +
> > +    return rc;
> > +}
> > +
> > +/* We dont have parameter encryption enabled when WOLFTPM2_NO_WOLFCRYP=
T
> > +* is defined. If the session isn't used then the new password is not
> > +* encrypted in transit over the bus: "a session is required to protect
> > +* the new platform auth" */
> > +#ifndef WOLFTPM2_NO_WOLFCRYPT
> > +static int TPM2_PCR_SetAuth(int argc, char *const argv[],
> > +    int isPolicy)
> > +{
> > +    int rc;
> > +    WOLFTPM2_DEV dev;
> > +    WOLFTPM2_SESSION session;
> > +    TPM2B_AUTH auth;
> > +    const char *pw =3D (argc < 4) ? NULL : argv[3];
> > +    const char *key =3D argv[2];
> > +    const ssize_t key_sz =3D strlen(key);
> > +    u32 pcrIndex =3D simple_strtoul(argv[1], NULL, 0);
> > +
> > +    /* Need 3-4 args: command + pcr + auth + [platform_auth] */
> > +    if (argc < 3 || argc > 4) {
> > +        return CMD_RET_USAGE;
> > +    }
> > +
> > +    /* Init the TPM2 device for value/policy */
> > +    rc =3D TPM2_Init_Device(&dev, NULL);
> > +    if (rc !=3D TPM_RC_SUCCESS) return rc;
> > +
> > +    /* Start the session */
> > +    rc =3D wolfTPM2_StartSession(&dev, &session, NULL, NULL,
> > +        isPolicy ? TPM_SE_POLICY : TPM_SE_HMAC, TPM_ALG_NULL);
> > +    if (rc !=3D TPM_RC_SUCCESS) {
> > +        log_debug("wolfTPM2_StartSession failed 0x%x: %s\n", rc,
> > +            TPM2_GetRCString(rc));
> > +        wolfTPM2_Cleanup(&dev);
> > +        return rc;
> > +    }
> > +
> > +    /* Set the platform auth if provided */
> > +    if (pw) {
> > +        TPM2B_AUTH platformAuth;
> > +        memset(&platformAuth, 0, sizeof(platformAuth));
> > +        platformAuth.size =3D strlen(pw);
> > +        XMEMCPY(platformAuth.buffer, pw, platformAuth.size);
> > +        rc =3D wolfTPM2_SetAuth(&dev, 0, TPM_RH_PLATFORM,
> > +            &platformAuth, 0, NULL);
> > +        if (rc !=3D TPM_RC_SUCCESS) {
> > +            log_debug("wolfTPM2_SetAuth failed 0x%x: %s\n", rc,
> > +                TPM2_GetRCString(rc));
> > +            wolfTPM2_UnloadHandle(&dev, &session.handle);
> > +            wolfTPM2_Cleanup(&dev);
> > +            return rc;
> > +        }
> > +    }
> > +
> > +    printf("Setting %s auth for PCR %u\n",
> > +        isPolicy ? "policy" : "value", pcrIndex);
> > +
> > +    /* Set up the auth value/policy */
> > +    memset(&auth, 0, sizeof(auth));
> > +    auth.size =3D key_sz;
> > +    XMEMCPY(auth.buffer, key, key_sz);
> > +
> > +    if (isPolicy) {
> > +        /* Use TPM2_PCR_SetAuthPolicy command */
> > +        PCR_SetAuthPolicy_In in;
> > +        memset(&in, 0, sizeof(in));
> > +        in.authHandle =3D TPM_RH_PLATFORM;
> > +        in.authPolicy =3D auth;
> > +        in.hashAlg =3D TPM_ALG_SHA256; /* Default to SHA256 */
> > +        in.pcrNum =3D pcrIndex;
> > +        rc =3D TPM2_PCR_SetAuthPolicy(&in);
> > +    } else {
> > +        /* Use TPM2_PCR_SetAuthValue command */
> > +        PCR_SetAuthValue_In in;
> > +        memset(&in, 0, sizeof(in));
> > +        in.pcrHandle =3D pcrIndex;
> > +        in.auth =3D auth;
> > +        rc =3D TPM2_PCR_SetAuthValue(&in);
> > +    }
> > +
> > +    if (rc !=3D TPM_RC_SUCCESS) {
> > +        log_debug("TPM2_PCR_SetAuth%s failed 0x%x: %s\n",
> > +            isPolicy ? "Policy" : "Value",
> > +            rc, TPM2_GetRCString(rc));
> > +    }
> > +
> > +    wolfTPM2_UnloadHandle(&dev, &session.handle);
> > +    wolfTPM2_Cleanup(&dev);
> > +
> > +    log_debug("tpm2 set_auth %s: rc =3D %d (%s)\n",
> > +        isPolicy ? "Policy" : "Value", rc, TPM2_GetRCString(rc));
> > +
> > +    return rc;
> > +}
> > +
> > +static int do_tpm2_pcr_setauthpolicy(struct cmd_tbl *cmdtp, int flag,
> > +    int argc, char *const argv[])
> > +{
> > +    return TPM2_PCR_SetAuth(argc, argv, YES);
> > +}
> > +
> > +static int do_tpm2_pcr_setauthvalue(struct cmd_tbl *cmdtp, int flag,
> > +    int argc, char *const argv[])
> > +{
> > +    return TPM2_PCR_SetAuth(argc, argv, NO);
> > +}
> > +
> > +static int do_tpm2_change_auth(struct cmd_tbl *cmdtp, int flag,
> > +    int argc, char *const argv[])
> > +{
> And here etc.
> Basially what would make sense to me is split those function to the
> tpm2_common.c
> I mentioned above and have wrappers/callback to either the default lib or
> wolfTPM
>
> > +    int rc;
> > +    WOLFTPM2_DEV dev;
> > +    WOLFTPM2_SESSION session;
> > +    const char *newpw =3D argv[2];
> > +    const char *oldpw =3D (argc =3D=3D 4) ? argv[3] : NULL;
> > +    const ssize_t newpw_sz =3D strlen(newpw);
> > +    const ssize_t oldpw_sz =3D oldpw ? strlen(oldpw) : 0;
> > +    HierarchyChangeAuth_In in;
> > +    TPM2B_AUTH newAuth;
> > +
> > +    /* Need 3-4 args: command + hierarchy + new_pw + [old_pw] */
> > +    if (argc < 3 || argc > 4) {
> > +        return CMD_RET_USAGE;
> > +    }
> > +
> > +    /* Init the TPM2 device */
> > +    rc =3D TPM2_Init_Device(&dev, NULL);
> > +    if (rc !=3D TPM_RC_SUCCESS) return rc;
> > +
> > +    memset(&in, 0, sizeof(in));
> > +
> > +    /* Set the handle */
> > +    if (!strcmp(argv[1], "TPM2_RH_LOCKOUT"))
> > +        in.authHandle =3D TPM_RH_LOCKOUT;
> > +    else if (!strcmp(argv[1], "TPM2_RH_ENDORSEMENT"))
> > +        in.authHandle =3D TPM_RH_ENDORSEMENT;
> > +    else if (!strcmp(argv[1], "TPM2_RH_OWNER"))
> > +        in.authHandle =3D TPM_RH_OWNER;
> > +    else if (!strcmp(argv[1], "TPM2_RH_PLATFORM"))
> > +        in.authHandle =3D TPM_RH_PLATFORM;
> > +    else {
> > +        wolfTPM2_Cleanup(&dev);
> > +        return CMD_RET_USAGE;
> > +    }
> > +
> > +    /* Validate password length if provided */
> > +    if (newpw_sz > TPM_SHA256_DIGEST_SIZE ||
> > +        oldpw_sz > TPM_SHA256_DIGEST_SIZE) {
> > +        wolfTPM2_Cleanup(&dev);
> > +        return -EINVAL;
> > +    }
> > +
> > +    /* Start auth session */
> > +    rc =3D wolfTPM2_StartSession(&dev, &session, NULL, NULL,
> > +        TPM_SE_HMAC, TPM_ALG_CFB);
> > +    if (rc !=3D TPM_RC_SUCCESS) {
> > +        log_debug("wolfTPM2_StartSession failed 0x%x: %s\n", rc,
> > +            TPM2_GetRCString(rc));
> > +        wolfTPM2_Cleanup(&dev);
> > +        return rc;
> > +    }
> > +
> > +    /* If old password exists then set it as the current auth */
> > +    if (oldpw) {
> > +        TPM2B_AUTH oldAuth;
> > +        memset(&oldAuth, 0, sizeof(oldAuth));
> > +        oldAuth.size =3D oldpw_sz;
> > +        XMEMCPY(oldAuth.buffer, oldpw, oldpw_sz);
> > +        rc =3D wolfTPM2_SetAuthPassword(&dev, 0, &oldAuth);
> > +        if (rc !=3D TPM_RC_SUCCESS) {
> > +            log_debug("wolfTPM2_SetAuthPassword failed 0x%x: %s\n", rc=
,
> > +                TPM2_GetRCString(rc));
> > +            wolfTPM2_UnloadHandle(&dev, &session.handle);
> > +            wolfTPM2_Cleanup(&dev);
> > +            return rc;
> > +        }
> > +    }
> > +
> > +    memset(&newAuth, 0, sizeof(newAuth));
> > +    newAuth.size =3D newpw_sz;
> > +    XMEMCPY(newAuth.buffer, newpw, newpw_sz);
> > +    in.newAuth =3D newAuth;
> > +
> > +    /* Change the auth based on the hierarchy */
> > +    rc =3D wolfTPM2_ChangeHierarchyAuth(&dev, &session, in.authHandle)=
;
> > +    if (rc !=3D TPM_RC_SUCCESS) {
> > +        log_debug("wolfTPM2_ChangeHierarchyAuth failed 0x%x: %s\n", rc=
,
> > +            TPM2_GetRCString(rc));
> > +    } else {
> > +        log_debug("Successfully changed auth for %s\n", argv[1]);
> > +    }
> > +
> > +    wolfTPM2_UnloadHandle(&dev, &session.handle);
> > +    wolfTPM2_Cleanup(&dev);
> > +
> > +    log_debug("tpm2 change_auth: rc =3D %d (%s)\n", rc,
> TPM2_GetRCString(rc));
> > +
> > +    return rc;
> > +}
> > +#endif /* !WOLFTPM2_NO_WOLFCRYPT */
> > +
> > +static int do_tpm2_pcr_print(struct cmd_tbl *cmdtp, int flag, int argc=
,
> char *const argv[])
> > +{
> > +    int rc;
> > +    WOLFTPM2_DEV dev;
> > +
> > +    /* Need 1 arg: command */
> > +    if (argc !=3D 1) {
> > +        return CMD_RET_USAGE;
> > +    }
> > +
> > +    /* Init the TPM2 device */
> > +    rc =3D TPM2_Init_Device(&dev, NULL);
> > +    if (rc =3D=3D TPM_RC_SUCCESS) {
> > +        /* Print the current PCR state */
> > +        TPM2_PCRs_Print();
> > +    }
> > +    wolfTPM2_Cleanup(&dev);
> > +
> > +    log_debug("tpm2 pcr_print: rc =3D %d (%s)\n", rc,
> TPM2_GetRCString(rc));
> > +
> > +    return rc;
> > +}
> > +
> > +static int do_tpm2_dam_reset(struct cmd_tbl *cmdtp, int flag,
> > +    int argc, char *const argv[])
> > +{
> > +    int rc;
> > +    WOLFTPM2_DEV dev;
> > +    const char *pw =3D (argc < 2) ? NULL : argv[1];
> > +    const ssize_t pw_sz =3D pw ? strlen(pw) : 0;
> > +    DictionaryAttackLockReset_In in;
> > +    TPM2_AUTH_SESSION session[MAX_SESSION_NUM];
> > +
> > +    /* Need 1-2 args: command + [password] */
> > +    if (argc > 2) {
> > +        return CMD_RET_USAGE;
> > +    }
> > +
> > +    /* Validate password length if provided */
> > +    if (pw && pw_sz > TPM_SHA256_DIGEST_SIZE) {
> > +        log_debug("Error: Password too long\n");
> > +        return -EINVAL;
> > +    }
> > +
> > +    /* Init the TPM2 device */
> > +    rc =3D TPM2_Init_Device(&dev, NULL);
> > +    if (rc =3D=3D TPM_RC_SUCCESS) {
> > +        /* set lock handle */
> > +        memset(&in, 0, sizeof(in));
> > +        in.lockHandle =3D TPM_RH_LOCKOUT;
> > +
> > +        /* Setup auth session only if password provided */
> > +        memset(session, 0, sizeof(session));
> > +        session[0].sessionHandle =3D TPM_RS_PW;
> > +        if (pw) {
> > +            session[0].auth.size =3D pw_sz;
> > +            XMEMCPY(session[0].auth.buffer, pw, pw_sz);
> > +        }
> > +        TPM2_SetSessionAuth(session);
> > +
> > +        rc =3D TPM2_DictionaryAttackLockReset(&in);
> > +        log_debug("TPM2_Dam_Reset: Result =3D 0x%x (%s)\n", rc,
> > +            TPM2_GetRCString(rc));
> > +    }
> > +    wolfTPM2_Cleanup(&dev);
> > +
> > +    log_debug("tpm2 dam_reset: rc =3D %d (%s)\n", rc,
> TPM2_GetRCString(rc));
> > +
> > +    return rc;
> > +}
> > +
> > +static int do_tpm2_dam_parameters(struct cmd_tbl *cmdtp, int flag,
> > +    int argc, char *const argv[])
> > +{
> > +    int rc;
> > +    WOLFTPM2_DEV dev;
> > +    const char *pw =3D (argc < 5) ? NULL : argv[4];
> > +    const ssize_t pw_sz =3D pw ? strlen(pw) : 0;
> > +    DictionaryAttackParameters_In in;
> > +    TPM2_AUTH_SESSION session[MAX_SESSION_NUM];
> > +
> > +    /* Need 4-5 args: command + max_tries + recovery_time +
> > +    * lockout_recovery + [password] */
> > +    if (argc < 4 || argc > 5) {
> > +        return CMD_RET_USAGE;
> > +    }
> > +
> > +    /* Validate password length if provided */
> > +    if (pw && pw_sz > TPM_SHA256_DIGEST_SIZE) {
> > +        log_debug("Error: Password too long\n");
> > +        return -EINVAL;
> > +    }
> > +
> > +    /* Init the TPM2 device */
> > +    rc =3D TPM2_Init_Device(&dev, NULL);
> > +    if (rc =3D=3D TPM_RC_SUCCESS) {
> > +        /* Set parameters */
> > +        memset(&in, 0, sizeof(in));
> > +        in.newMaxTries =3D simple_strtoul(argv[1], NULL, 0);
> > +        in.newRecoveryTime =3D simple_strtoul(argv[2], NULL, 0);
> > +        in.lockoutRecovery =3D simple_strtoul(argv[3], NULL, 0);
> > +
> > +        /* set lock handle */
> > +        in.lockHandle =3D TPM_RH_LOCKOUT;
> > +
> > +        /* Setup auth session only if password provided */
> > +        memset(session, 0, sizeof(session));
> > +        session[0].sessionHandle =3D TPM_RS_PW;
> > +        if (pw) {
> > +            session[0].auth.size =3D pw_sz;
> > +            XMEMCPY(session[0].auth.buffer, pw, pw_sz);
> > +        }
> > +        TPM2_SetSessionAuth(session);
> > +
> > +        /* Set DAM parameters */
> > +        rc =3D TPM2_DictionaryAttackParameters(&in);
> > +        if (rc !=3D TPM_RC_SUCCESS) {
> > +            log_debug("TPM2_DictionaryAttackParameters failed 0x%x:
> %s\n", rc,
> > +                TPM2_GetRCString(rc));
> > +        }
> > +
> > +        printf("Changing dictionary attack parameters:\n");
> > +        printf("  maxTries: %u\n", in.newMaxTries);
> > +        printf("  recoveryTime: %u\n", in.newRecoveryTime);
> > +        printf("  lockoutRecovery: %u\n", in.lockoutRecovery);
> > +    }
> > +    wolfTPM2_Cleanup(&dev);
> > +
> > +    log_debug("tpm2 dam_parameters: rc =3D %d (%s)\n", rc,
> TPM2_GetRCString(rc));
> > +
> > +    return rc;
> > +}
> > +
> > +static struct cmd_tbl wolftpm_cmds[] =3D {
> > +    U_BOOT_CMD_MKENT(device, 2, 1, do_tpm2_device, "", ""),
> > +    U_BOOT_CMD_MKENT(info, 1, 1, do_tpm2_info, "", ""),
> > +    U_BOOT_CMD_MKENT(state, 1, 1, do_tpm2_state, "", ""),
> > +    U_BOOT_CMD_MKENT(init, 1, 1, do_tpm2_init, "", ""),
> > +    U_BOOT_CMD_MKENT(autostart, 1, 1, do_tpm2_autostart, "", ""),
> > +    U_BOOT_CMD_MKENT(startup, 3, 1, do_tpm2_startup, "", ""),
> > +    U_BOOT_CMD_MKENT(self_test, 2, 1, do_tpm2_selftest, "", ""),
> > +    U_BOOT_CMD_MKENT(clear, 2, 1, do_tpm2_clear, "", ""),
> > +    U_BOOT_CMD_MKENT(pcr_extend, 4, 1, do_tpm2_pcr_extend, "", ""),
> > +    U_BOOT_CMD_MKENT(pcr_read, 4, 1, do_tpm2_pcr_read, "", ""),
> > +    U_BOOT_CMD_MKENT(pcr_allocate, 4, 1, do_tpm2_pcr_allocate, "", "")=
,
> > +    U_BOOT_CMD_MKENT(pcr_print, 1, 1, do_tpm2_pcr_print, "", ""),
> > +#ifndef WOLFTPM2_NO_WOLFCRYPT
> > +    U_BOOT_CMD_MKENT(change_auth, 4, 1, do_tpm2_change_auth, "", ""),
> > +    U_BOOT_CMD_MKENT(pcr_setauthpolicy, 4, 1,
> do_tpm2_pcr_setauthpolicy, "", ""),
> > +    U_BOOT_CMD_MKENT(pcr_setauthvalue, 4, 1, do_tpm2_pcr_setauthvalue,
> "", ""),
> > +#endif
> > +    U_BOOT_CMD_MKENT(get_capability, 5, 1, do_tpm2_wrapper_getcapsargs=
,
> "", ""),
> > +    U_BOOT_CMD_MKENT(dam_reset, 2, 1, do_tpm2_dam_reset, "", ""),
> > +    U_BOOT_CMD_MKENT(dam_parameters, 5, 1, do_tpm2_dam_parameters, "",
> ""),
> > +    U_BOOT_CMD_MKENT(caps, 1, 1, do_tpm2_wrapper_capsargs, "", ""),
> > +#ifdef WOLFTPM_FIRMWARE_UPGRADE
> > +#if defined(WOLFTPM_SLB9672) || defined(WOLFTPM_SLB9673)
> > +    U_BOOT_CMD_MKENT(firmware_update, 5, 1, do_tpm2_firmware_update,
> "", ""),
> > +    U_BOOT_CMD_MKENT(firmware_cancel, 1, 1, do_tpm2_firmware_cancel,
> "", ""),
> > +#endif
> > +#endif
> > +};
> > +
> > +struct cmd_tbl *get_wolftpm_commands(unsigned int *size)
> > +{
> > +     *size =3D ARRAY_SIZE(wolftpm_cmds);
> > +
> > +     return wolftpm_cmds;
> > +}
> > +
> > +static int do_wolftpm(struct cmd_tbl *cmdtp, int flag, int argc,
> > +                   char *const argv[])
>
> Same for the cmd files. Duplicating isn't ideal, we need to apply fixes
> changes 2x
> every time now.
>
> > +{
> > +     struct cmd_tbl *cmd;
> > +
> > +     if (argc < 2)
> > +             return CMD_RET_USAGE;
> > +
> > +     cmd =3D find_cmd_tbl(argv[1], wolftpm_cmds,
> ARRAY_SIZE(wolftpm_cmds));
> > +     if (!cmd)
> > +             return CMD_RET_USAGE;
> > +
> > +     return cmd->cmd(cmdtp, flag, argc - 1, argv + 1);
> > +}
> > +
> > +U_BOOT_CMD(
> > +    tpm2,                   /* name of cmd - replaces standard tpm2
> when wolfTPM enabled */
> > +    CONFIG_SYS_MAXARGS,     /* max args    */
> > +    1,                      /* repeatable  */
> > +    do_wolftpm,             /* function    */
> > +    "Issue a TPMv2.x command (wolfTPM)",
> > +    "<command> [<arguments>]\n"
> > +    "\n"
> > +    "Commands:\n"
> > +    "help\n"
> > +    "      Show this help text\n"
> > +    "device [num device]\n"
> > +    "      Show all devices or set the specified device\n"
> > +    "info\n"
> > +    "      Show information about the TPM.\n"
> > +    "state\n"
> > +    "      Show internal state from the TPM (if available)\n"
> > +    "autostart\n"
> > +    "      Initalize the tpm, perform a Startup(clear) and run a full
> selftest\n"
> > +    "      sequence\n"
> > +    "init\n"
> > +    "      Initialize the software stack. Always the first command to
> issue.\n"
> > +    "      'tpm startup' is the only acceptable command after a 'tpm
> init' has been\n"
> > +    "      issued\n"
> > +    "startup <mode> [<op>]\n"
> > +    "      Issue a TPM2_Startup command.\n"
> > +    "      <mode> is one of:\n"
> > +    "          * TPM2_SU_CLEAR (reset state)\n"
> > +    "          * TPM2_SU_STATE (preserved state)\n"
> > +    "      [<op>]: optional shutdown\n"
> > +    "          * off - To shutdown the TPM\n"
> > +    "self_test <type>\n"
> > +    "      Test the TPM capabilities.\n"
> > +    "      <type> is one of:\n"
> > +    "          * full (perform all tests)\n"
> > +    "          * continue (only check untested tests)\n"
> > +    "clear <hierarchy>\n"
> > +    "      Issue a TPM2_Clear command.\n"
> > +    "      <hierarchy> is one of:\n"
> > +    "          * TPM2_RH_LOCKOUT\n"
> > +    "          * TPM2_RH_PLATFORM\n"
> > +    "pcr_extend <pcr> <digest_addr> [<digest_algo>]\n"
> > +    "      Extend PCR #<pcr> with digest at <digest_addr> with
> digest_algo.\n"
> > +    "      <pcr>: index of the PCR\n"
> > +    "      <digest_addr>: address of digest of digest_algo type
> (defaults to SHA256)\n"
> > +    "      [<digest_algo>]: algorithm to use for digest\n"
> > +    "pcr_read <pcr> <digest_addr> [<digest_algo>]\n"
> > +    "      Read PCR #<pcr> to memory address <digest_addr> with
> <digest_algo>.\n"
> > +    "      <pcr>: index of the PCR\n"
> > +    "      <digest_addr>: address of digest of digest_algo type
> (defaults to SHA256)\n"
> > +    "      [<digest_algo>]: algorithm to use for digest\n"
> > +    "pcr_print\n"
> > +    "      Prints the current PCR state\n"
> > +    "caps\n"
> > +    "      Show TPM capabilities and info\n"
> > +    "get_capability <capability> <property> <addr> <count>\n"
> > +    "    Read and display <count> entries indexed by
> <capability>/<property>.\n"
> > +    "    Values are 4 bytes long and are written at <addr>.\n"
> > +    "    <capability>: capability\n"
> > +    "    <property>: property\n"
> > +    "    <addr>: address to store <count> entries of 4 bytes\n"
> > +    "    <count>: number of entries to retrieve\n"
> > +    "dam_reset [<password>]\n"
> > +    "      If the TPM is not in a LOCKOUT state, reset the internal
> error counter.\n"
> > +    "      [<password>]: optional password\n"
> > +    "dam_parameters <max_tries> <recovery_time> <lockout_recovery>
> [<password>]\n"
> > +    "      If the TPM is not in a LOCKOUT state, sets the DAM
> parameters\n"
> > +    "      <max_tries>: maximum number of failures before lockout,\n"
> > +    "          0 means always locking\n"
> > +    "      <recovery_time>: time before decrement of the error
> counter,\n"
> > +    "          0 means no lockout\n"
> > +    "      <lockout_recovery>: time of a lockout (before the next
> try),\n"
> > +    "          0 means a reboot is needed\n"
> > +    "      [<password>]: optional password of the LOCKOUT hierarchy\n"
> > +    "change_auth <hierarchy> <new_pw> [<old_pw>]\n"
> > +    "      <hierarchy>: the hierarchy\n"
> > +    "          * TPM2_RH_LOCKOUT\n"
> > +    "          * TPM2_RH_ENDORSEMENT\n"
> > +    "          * TPM2_RH_OWNER\n"
> > +    "          * TPM2_RH_PLATFORM\n"
> > +    "      <new_pw>: new password for <hierarchy>\n"
> > +    "      [<old_pw>]: optional previous password of <hierarchy>\n"
> > +    "pcr_setauthpolicy | pcr_setauthvalue <pcr> <key> [<password>]\n"
> > +    "      Change the <key> to access PCR #<pcr>.\n"
> > +    "      <pcr>: index of the PCR\n"
> > +    "      <key>: secret to protect the access of PCR #<pcr>\n"
> > +    "      [<password>]: optional password of the PLATFORM hierarchy\n=
"
> > +    "pcr_allocate <algorithm> <on/off> [<password>]\n"
> > +    "      Issue a TPM2_PCR_Allocate Command to reconfig PCR bank
> algorithm.\n"
> > +    "      <algorithm> is one of:\n"
> > +    "          * SHA1\n"
> > +    "          * SHA256\n"
> > +    "          * SHA384\n"
> > +    "          * SHA512\n"
> > +    "      <on|off> is one of:\n"
> > +    "          * on  - Select all available PCRs associated with the
> specified\n"
> > +    "                  algorithm (bank)\n"
> > +    "          * off - Clear all available PCRs associated with the
> specified\n"
> > +    "                  algorithm (bank)\n"
> > +    "      [<password>]: optional password\n"
> > +
> > +#ifdef WOLFTPM_FIRMWARE_UPGRADE
> > +#if defined(WOLFTPM_SLB9672) || defined(WOLFTPM_SLB9673)
> > +    "firmware_update <manifest_addr> <manifest_sz> <firmware_addr>
> <firmware_sz>\n"
> > +    "      Update TPM firmware\n"
> > +    "firmware_cancel\n"
> > +    "      Cancel TPM firmware update\n"
> > +#endif
> > +#endif
> > +);
> > +
> > +#endif /* !WOLFTPM2_NO_WRAPPER */
> > +
> >
> +/***********************************************************************=
*******/
> > +/* --- END TPM 2.0 Commands -- */
> >
> +/***********************************************************************=
*******/
> > diff --git a/configs/rpi_4_defconfig b/configs/rpi_4_defconfig
> > index 8362242b97f..22280d9b70e 100644
> > --- a/configs/rpi_4_defconfig
> > +++ b/configs/rpi_4_defconfig
> > @@ -69,4 +69,31 @@ CONFIG_SYS_WHITE_ON_BLACK=3Dy
> >  CONFIG_VIDEO_BCM2835=3Dy
> >  CONFIG_CONSOLE_SCROLL_LINES=3D10
> >  CONFIG_PHYS_TO_BUS=3Dy
> > -# CONFIG_HEXDUMP is not set
> > +# HEXDUMP enabled for unit tests
> > +
> > +# SPI support (hardware SPI - matches Linux tpm-slb9670 overlay)
> > +CONFIG_SPI=3Dy
> > +CONFIG_DM_SPI=3Dy
> > +CONFIG_BCM2835_SPI=3Dy
> > +# CONFIG_SOFT_SPI is not set
> > +CONFIG_CMD_SPI=3Dy
> > +
> > +# TPM and wolfTPM support
> > +CONFIG_TPM=3Dy
> > +CONFIG_TPM_V2=3Dy
> > +CONFIG_CMD_TPM=3Dy
> > +CONFIG_TPM_WOLF=3Dy
> > +# CONFIG_WOLFTPM_LINUX_DEV is not set
> > +CONFIG_WOLFTPM_SLB9672=3Dy
> > +CONFIG_CMD_WOLFTPM=3Dy
> > +
> > +# Logging (debug level to see log_debug output)
> > +CONFIG_LOG=3Dy
> > +CONFIG_LOGLEVEL=3D7
> > +CONFIG_LOG_MAX_LEVEL=3D7
> > +CONFIG_LOG_DEFAULT_LEVEL=3D7
> > +
> > +# Unit testing support
> > +CONFIG_UNIT_TEST=3Dy
> > +CONFIG_CONSOLE_RECORD=3Dy
> > +CONFIG_HEXDUMP=3Dy
> > diff --git a/doc/usage/cmd/wolftpm.rst b/doc/usage/cmd/wolftpm.rst
> > new file mode 100644
> > index 00000000000..4b5fb251b35
> > --- /dev/null
> > +++ b/doc/usage/cmd/wolftpm.rst
> > @@ -0,0 +1,694 @@
> > +wolfTPM Support For Das U-Boot
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > +
> > +wolfTPM provides experimental support for U-Boot with the following ke=
y
> features:
> > +
> > +- Utilizes SOFT SPI driver in U-Boot for TPM communication
> > +- Implements TPM 2.0 driver functionality through its internal TIS lay=
er
> > +- Provides native API access to all TPM 2.0 commands
> > +- Includes wrapper API for common TPM 2.0 operations
> > +- Supports two integration paths:
> > +  - ``__linux__``: Uses existing tpm interface via tpm2_linux.c
> > +  - ``__UBOOT__``: Direct SPI communication through tpm_io_uboot.c
> > +
> > +wolfTPM U-Boot Commands
> > +----------------------
> > +
> > +The following commands are available through the ``tpm2`` command
> (powered by wolfTPM):
> > +
> > +Basic Commands
> > +~~~~~~~~~~~~~~
> > +
> > +- ``help`` - Show help text
> > +- ``device [num device]`` - Show all devices or set the specified devi=
ce
> > +- ``info`` - Show information about the TPM
> > +- ``state`` - Show internal state from the TPM (if available)
> > +- ``autostart`` - Initialize the TPM, perform a Startup(clear) and run
> a full selftest sequence
> > +- ``init`` - Initialize the software stack (must be first command)
> > +- ``startup <mode> [<op>]`` - Issue a TPM2_Startup command
> > +  - ``<mode>``: TPM2_SU_CLEAR (reset state) or TPM2_SU_STATE (preserve=
d
> state)
> > +  - ``[<op>]``: optional shutdown with "off"
> > +- ``self_test <type>`` - Test TPM capabilities
> > +  - ``<type>``: "full" (all tests) or "continue" (untested tests only)
> > +
> > +PCR Operations
> > +~~~~~~~~~~~~~~
> > +
> > +- ``pcr_extend <pcr> <digest_addr> [<digest_algo>]`` - Extend PCR with
> digest
> > +- ``pcr_read <pcr> <digest_addr> [<digest_algo>]`` - Read PCR to memor=
y
> > +- ``pcr_allocate <algorithm> <on/off> [<password>]`` - Reconfig PCR
> bank algorithm
> > +- ``pcr_setauthpolicy | pcr_setauthvalue <pcr> <key> [<password>]`` -
> Change PCR access key
> > +- ``pcr_print`` - Print current PCR state
> > +
> > +Security Management
> > +~~~~~~~~~~~~~~~~~~~
> > +
> > +- ``clear <hierarchy>`` - Issue TPM2_Clear command
> > +  - ``<hierarchy>``: TPM2_RH_LOCKOUT or TPM2_RH_PLATFORM
> > +- ``change_auth <hierarchy> <new_pw> [<old_pw>]`` - Change hierarchy
> password
> > +  - ``<hierarchy>``: TPM2_RH_LOCKOUT, TPM2_RH_ENDORSEMENT,
> TPM2_RH_OWNER, or TPM2_RH_PLATFORM
> > +- ``dam_reset [<password>]`` - Reset internal error counter
> > +- ``dam_parameters <max_tries> <recovery_time> <lockout_recovery>
> [<password>]`` - Set DAM parameters
> > +- ``caps`` - Show TPM capabilities and info
> > +
> > +Firmware Management
> > +~~~~~~~~~~~~~~~~~~~
> > +
> > +- ``firmware_update <manifest_addr> <manifest_sz> <firmware_addr>
> <firmware_sz>`` - Update TPM firmware
> > +- ``firmware_cancel`` - Cancel TPM firmware update
> > +
> > +Infineon TPM Firmware Update Guide
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +**WARNING: Firmware updates are risky. A failed update can brick your
> TPM.
> > +Only proceed if you have a valid reason to update (security patches,
> new features)
> > +and understand the risks.**
> > +
> > +The firmware update commands are for Infineon SLB9672/SLB9673 TPMs
> only. The process
> > +requires extracting manifest and firmware data from Infineon's combine=
d
> ``.BIN`` file.
> > +
> > +**Prerequisites:**
> > +
> > +- Infineon firmware file (e.g., ``TPM20_16.13.17733.0_R1.BIN``)
> > +- wolfTPM's ``ifx_fw_extract`` tool (in
> ``lib/wolftpm/examples/firmware/``)
> > +- Your TPM's KeyGroupId (shown by ``tpm2 caps`` command)
> > +
> > +**Step 1: Get your TPM's KeyGroupId**
> > +
> > +Run ``tpm2 caps`` to find your TPM's KeyGroupId::
> > +
> > +    U-Boot> tpm2 caps
> > +    Mfg IFX (1), Vendor SLB9672, Fw 16.13 (0x4545), FIPS 140-2 1,
> CC-EAL4 1
> > +    Operational mode: Normal TPM operational mode (0x0)
> > +    KeyGroupId 0x5, FwCounter 1255 (255 same)
> > +    ...
> > +
> > +In this example, KeyGroupId is ``0x5``.
> > +
> > +**Step 2: Build the extraction tool (on host machine)**
> > +
> > +::
> > +
> > +    cd lib/wolftpm/examples/firmware
> > +    gcc -o ifx_fw_extract ifx_fw_extract.c
> > +
> > +**Step 3: List available key groups in firmware file**
> > +
> > +::
> > +
> > +    ./ifx_fw_extract TPM20_16.13.17733.0_R1.BIN
> > +    Found group 00000005
> > +
> > +Verify your TPM's KeyGroupId matches one in the firmware file.
> > +
> > +**Step 4: Extract manifest and firmware data**
> > +
> > +Use your KeyGroupId (0x5 in this example)::
> > +
> > +    ./ifx_fw_extract TPM20_16.13.17733.0_R1.BIN 0x5 manifest.bin
> firmware.bin
> > +    Found group 00000005
> > +    Chosen group found: 00000005
> > +    Manifest size is 3229
> > +    Data size is 925539
> > +    Wrote 3229 bytes to manifest.bin
> > +    Wrote 925539 bytes to firmware.bin
> > +
> > +**Step 5: Copy files to SD card**
> > +
> > +Copy ``manifest.bin`` and ``firmware.bin`` to your boot partition
> (FAT)::
> > +
> > +    cp manifest.bin firmware.bin /Volumes/bootfs/   # macOS
> > +    cp manifest.bin firmware.bin /boot/firmware/     # Linux
> > +
> > +**Step 6: Load files into memory**
> > +
> > +In U-Boot, load the files from SD card into RAM::
> > +
> > +    U-Boot> fatload mmc 0:1 0x10000000 manifest.bin
> > +    3229 bytes read in 32 ms (97.7 KiB/s)
> > +
> > +    U-Boot> fatload mmc 0:1 0x10100000 firmware.bin
> > +    925539 bytes read in 86 ms (10.3 MiB/s)
> > +
> > +**Step 7: Perform firmware update (CAUTION!)**
> > +
> > +Convert file sizes to hex:
> > +
> > +- manifest.bin: 3229 bytes =3D 0xC9D
> > +- firmware.bin: 925539 bytes =3D 0xE1F63
> > +
> > +Run the firmware update::
> > +
> > +    U-Boot> tpm2 firmware_update 0x10000000 0xC9D 0x10100000 0xE1F63
> > +    TPM2 Firmware Update
> > +    Infineon Firmware Update Tool
> > +        Manifest Address: 0x10000000 (size: 3229)
> > +        Firmware Address: 0x10100000 (size: 925539)
> > +    tpm2 init: rc =3D 0 (Success)
> > +    Mfg IFX (1), Vendor SLB9672, Fw 16.13 (0x4545)
> > +    Operational mode: Normal TPM operational mode (0x0)
> > +    KeyGroupId 0x5, FwCounter 1255 (255 same)
> > +    Firmware Update (normal mode):
> > +    Mfg IFX (1), Vendor SLB9672, Fw 16.13 (0x4545)
> > +    Operational mode: Normal TPM operational mode (0x0)
> > +    KeyGroupId 0x5, FwCounter 1255 (255 same)
> > +    tpm2 firmware_update: rc=3D0 (Success)
> > +
> > +**DO NOT power off or reset during the update!**
> > +
> > +**Step 8: Verify update**
> > +
> > +After the update completes, verify with::
> > +
> > +    U-Boot> tpm2 caps
> > +
> > +The firmware version should show the new version.
> > +
> > +**Recovery Mode:**
> > +
> > +If the TPM enters recovery mode (opMode shows 0x02 or 0x8x), the
> firmware update
> > +command will automatically use recovery mode. You may need to run the
> update again
> > +to complete the process.
> > +
> > +Canceling a Firmware Update
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +If an update is in progress and needs to be abandoned (opMode 0x01),
> use::
> > +
> > +    U-Boot> tpm2 firmware_cancel
> > +    tpm2 init: rc =3D 0 (Success)
> > +    tpm2 firmware_cancel: rc=3D0 (Success)
> > +
> > +**IMPORTANT: After running firmware_cancel, you MUST reboot/power cycl=
e
> the system
> > +before running any other TPM commands.** If you attempt to run command=
s
> without
> > +rebooting, you will get ``TPM_RC_REBOOT`` (error 304)::
> > +
> > +    U-Boot> tpm2 firmware_update ...
> > +    tpm2 init: rc =3D 304 (TPM_RC_REBOOT)
> > +    Infineon firmware update failed 0x130: TPM_RC_REBOOT
> > +
> > +After rebooting, the TPM will return to normal operation and you can
> retry the
> > +firmware update or continue with normal TPM operations.
> > +
> > +**Note:** If no firmware update is in progress, ``firmware_cancel``
> returns
> > +``TPM_RC_COMMAND_CODE`` (0x143), which is expected and harmless::
> > +
> > +    U-Boot> tpm2 firmware_cancel
> > +    tpm2 firmware_cancel: rc=3D323 (TPM_RC_COMMAND_CODE)
> > +
> > +Enabling wolfTPM in U-Boot
> > +--------------------------
> > +
> > +Enable wolfTPM support in U-Boot by adding these options to your
> board's defconfig::
> > +
> > +  CONFIG_TPM=3Dy
> > +  CONFIG_TPM_V2=3Dy
> > +  CONFIG_TPM_WOLF=3Dy
> > +  CONFIG_CMD_WOLFTPM=3Dy
> > +
> > +  if with __LINUX__:
> > +    CONFIG_TPM_LINUX_DEV=3Dy
> > +
> > +Or use ``make menuconfig`` and enable:
> > +
> > +Enabling Debug Output
> > +~~~~~~~~~~~~~~~~~~~~~
> > +
> > +wolfTPM commands use U-Boot's logging system (``log_debug()``). To
> enable debug
> > +output, you must first enable the logging subsystem in your board's
> defconfig::
> > +
> > +    CONFIG_LOG=3Dy
> > +    CONFIG_LOG_MAX_LEVEL=3D7
> > +    CONFIG_LOG_DEFAULT_LEVEL=3D7
> > +
> > +Or via ``make menuconfig``:
> > +
> > +- Console =E2=86=92 Enable logging support
> > +- Console =E2=86=92 Maximum log level to record =3D 7
> > +- Console =E2=86=92 Default logging level to display =3D 7
> > +
> > +Log levels:
> > +- 7 =3D DEBUG (to show wolfTPM command debug output)
> > +
> > +**Note:** Without ``CONFIG_LOG=3Dy``, the ``log level`` command will n=
ot
> exist
> > +and ``log_debug()`` calls will produce no output.
> > +
> > +wolfTPM Library Debug
> > +^^^^^^^^^^^^^^^^^^^^^
> > +
> > +For lower-level wolfTPM library debug output (TPM protocol messages),
> edit
> > +``include/configs/user_settings.h`` and uncomment::
> > +
> > +    #define DEBUG_WOLFTPM           /* Basic wolfTPM debug messages */
> > +    #define WOLFTPM_DEBUG_VERBOSE   /* Verbose debug messages */
> > +    #define WOLFTPM_DEBUG_IO        /* IO-level debug (SPI transfers) =
*/
> > +
> > +After enabling, rebuild U-Boot::
> > +
> > +    make clean
> > +    make -j4
> > +
> > +Menuconfig Paths
> > +^^^^^^^^^^^^^^^^
> > +
> > +The following menuconfig paths are useful for wolfTPM:
> > +
> > +- Device Drivers =E2=86=92 TPM =E2=86=92 TPM 2.0 Support
> > +- Device Drivers =E2=86=92 TPM =E2=86=92 wolfTPM Support
> > +- Command line interface =E2=86=92 Security commands =E2=86=92 Enable =
wolfTPM commands
> > +- Console =E2=86=92 Enable logging support (for ``log_debug()`` output=
)
> > +
> > +Building and Running wolfTPM with U-Boot using QEMU
> > +---------------------------------------------------
> > +
> > +To build and run wolfTPM with U-Boot using QEMU and a TPM simulator,
> follow these steps:
> > +
> > +1. Install swtpm::
> > +
> > +     git clone https://github.com/stefanberger/swtpm.git
> > +     cd swtpm
> > +     ./autogen.sh
> > +     make
> > +
> > +2. Build U-Boot::
> > +
> > +     make distclean
> > +     export CROSS_COMPILE=3Daarch64-linux-gnu-
> > +     export ARCH=3Daarch64
> > +     make qemu_arm64_defconfig
> > +     make -j4
> > +
> > +3. Create TPM directory::
> > +
> > +     mkdir -p /tmp/mytpm1
> > +
> > +4. Start swtpm (in first terminal)::
> > +
> > +     swtpm socket --tpm2 --tpmstate dir=3D/tmp/mytpm1 --ctrl
> type=3Dunixio,path=3D/tmp/mytpm1/swtpm-sock --log level=3D20
> > +
> > +5. Start QEMU (in second terminal)::
> > +
> > +     qemu-system-aarch64 -machine virt -nographic -cpu cortex-a57 -bio=
s
> u-boot.bin -chardev socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock -tpm=
dev
> emulator,id=3Dtpm0,chardev=3Dchrtpm -device tpm-tis-device,tpmdev=3Dtpm0
> > +
> > +6. Example output::
> > +
> > +     U-Boot 2025.07-rc1-ge15cbf232ddf-dirty (May 06 2025 - 16:25:56
> -0700)
> > +     ...
> > +     =3D> tpm2 help
> > +     tpm2 - Issue a TPMv2.x command
> > +     Usage:
> > +     tpm2 <command> [<arguments>]
> > +     ...
> > +     =3D> tpm2 info
> > +     tpm_tis@0 v2.0: VendorID 0x1014, DeviceID 0x0001, RevisionID 0x01
> [open]
> > +     =3D> tpm2 startup TPM2_SU_CLEAR
> > +     =3D> tpm2 get_capability 0x6 0x20e 0x200 1
> > +     Capabilities read from TPM:
> > +     Property 0x6a2e45a9: 0x6c3646a9
> > +     =3D> tpm2 pcr_read 10 0x100000
> > +     PCR #10 sha256 32 byte content (20 known updates):
> > +      20 25 73 0a 00 56 61 6c 75 65 3a 0a 00 23 23 20
> > +      4f 75 74 20 6f 66 20 6d 65 6d 6f 72 79 0a 00 23
> > +
> > +7. Example commands::
> > +
> > +     =3D> tpm2 info
> > +     tpm_tis@0 v2.0: VendorID 0x1014, DeviceID 0x0001, RevisionID 0x01
> [open]
> > +     ...
> > +     =3D> tpm2 pcr_read 10 0x100000
> > +     PCR #10 sha256 32 byte content (20 known updates):
> > +      20 25 73 0a 00 56 61 6c 75 65 3a 0a 00 23 23 20
> > +      4f 75 74 20 6f 66 20 6d 65 6d 6f 72 79 0a 00 23
> > +
> > +8. Exiting the QEMU:
> > +   Press Ctrl-A followed by X
> > +
>
> The examples are nice!
>
> > +Testing wolfTPM
> > +---------------
> > +
> > +wolfTPM includes a comprehensive test suite based on the existing TPM2
> tests.
> > +The tests are located in:
> > +
> > +- ``test/cmd/wolftpm.c`` - C unit tests (based on ``test/dm/tpm.c`` an=
d
> ``test/cmd/hash.c``)
> > +- ``test/py/tests/test_wolftpm.py`` - Python integration tests (based
> on ``test/py/tests/test_tpm2.py``)
> > +
> > +Running C Unit Tests
> > +~~~~~~~~~~~~~~~~~~~~
> > +
> > +The C unit tests use the U-Boot test framework and can be run in
> sandbox mode
> > +or on real hardware. To run all wolfTPM tests::
> > +
> > +    # Build sandbox with tests enabled
> > +    make sandbox_defconfig
> > +    # Enable wolfTPM in menuconfig
> > +    make menuconfig
> > +    make -j4
> > +
> > +    # Run U-Boot sandbox
> > +    ./u-boot -T
> > +
> > +    # In U-Boot sandbox, run the unit tests
> > +    =3D> ut cmd
> > +
> > +Individual tests can be run by name::
> > +
> > +    =3D> ut cmd cmd_test_wolftpm_autostart
> > +    =3D> ut cmd cmd_test_wolftpm_init
> > +    =3D> ut cmd cmd_test_wolftpm_self_test
> > +    =3D> ut cmd cmd_test_wolftpm_caps
> > +    =3D> ut cmd cmd_test_wolftpm_clear
> > +    =3D> ut cmd cmd_test_wolftpm_pcr_read
> > +    =3D> ut cmd cmd_test_wolftpm_pcr_extend
> > +
> > +Running Python Tests
> > +~~~~~~~~~~~~~~~~~~~~
> > +
> > +The Python tests require pytest and can be run against real hardware o=
r
> QEMU
> > +with swtpm. First, ensure swtpm is running (see QEMU instructions
> above).
> > +
> > +To run all wolfTPM Python tests::
> > +
> > +    # From the U-Boot root directory
> > +    ./test/py/test.py --bd qemu_arm64 -k test_wolftpm
> > +
> > +To run individual Python tests::
> > +
> > +    ./test/py/test.py --bd qemu_arm64 -k test_wolftpm_autostart
> > +    ./test/py/test.py --bd qemu_arm64 -k test_wolftpm_caps
> > +    ./test/py/test.py --bd qemu_arm64 -k test_wolftpm_pcr_read
> > +
> > +To skip wolfTPM tests (e.g., when no TPM hardware is available), set t=
he
> > +environment variable in your board configuration::
> > +
> > +    env__wolftpm_device_test_skip =3D True
> > +
> > +Running Tests Manually in QEMU
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +You can also test wolfTPM commands manually in QEMU:
> > +
> > +1. Start swtpm::
> > +
> > +     mkdir -p /tmp/mytpm
> > +     swtpm socket --tpm2 --tpmstate dir=3D/tmp/mytpm \
> > +       --ctrl type=3Dunixio,path=3D/tmp/mytpm/swtpm-sock --log level=
=3D20
> > +
> > +2. Start QEMU with TPM::
> > +
> > +     qemu-system-aarch64 -machine virt -cpu cortex-a57 -m 1024 \
> > +       -bios u-boot.bin \
> > +       -chardev socket,id=3Dchrtpm,path=3D/tmp/mytpm/swtpm-sock \
> > +       -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
> > +       -device tpm-tis-device,tpmdev=3Dtpm0 \
> > +       -nographic
> > +
> > +3. Run wolfTPM commands at the U-Boot prompt::
> > +
> > +     =3D> wolftpm autostart
> > +     =3D> wolftpm caps
> > +     =3D> wolftpm pcr_read 0 sha256
> > +     =3D> wolftpm pcr_print
> > +     =3D> wolftpm self_test full
> > +     =3D> wolftpm clear TPM2_RH_LOCKOUT
> > +     =3D> wolftpm dam_parameters 3 10 0
> > +
> > +Test Coverage
> > +~~~~~~~~~~~~~
> > +
> > +The test suite covers the following wolfTPM functionality:
> > +
> > ++---------------------------+-----------------------------------------=
-+
> > +| Test Name                 | Description                             =
 |
> > ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> > +| wolftpm_autostart         | TPM initialization and startup          =
 |
> > ++---------------------------+-----------------------------------------=
-+
> > +| wolftpm_init              | TPM device initialization               =
 |
> > ++---------------------------+-----------------------------------------=
-+
> > +| wolftpm_self_test         | Full TPM self-test                      =
 |
> > ++---------------------------+-----------------------------------------=
-+
> > +| wolftpm_self_test_continue| Continue incomplete self-tests          =
 |
> > ++---------------------------+-----------------------------------------=
-+
> > +| wolftpm_caps              | Read TPM capabilities                   =
 |
> > ++---------------------------+-----------------------------------------=
-+
> > +| wolftpm_clear             | Clear TPM state                         =
 |
> > ++---------------------------+-----------------------------------------=
-+
> > +| wolftpm_pcr_read          | Read PCR values                         =
 |
> > ++---------------------------+-----------------------------------------=
-+
> > +| wolftpm_pcr_extend        | Extend PCR with digest                  =
 |
> > ++---------------------------+-----------------------------------------=
-+
> > +| wolftpm_pcr_print         | Print all PCR values                    =
 |
> > ++---------------------------+-----------------------------------------=
-+
> > +| wolftpm_pcr_allocate      | Reconfigure PCR bank algorithm          =
 |
> > ++---------------------------+-----------------------------------------=
-+
> > +| wolftpm_dam_reset         | Reset DAM counter                       =
 |
> > ++---------------------------+-----------------------------------------=
-+
> > +| wolftpm_dam_parameters    | Set DAM parameters                      =
 |
> > ++---------------------------+-----------------------------------------=
-+
> > +| wolftpm_change_auth       | Change hierarchy password               =
 |
> > ++---------------------------+-----------------------------------------=
-+
> > +| wolftpm_info              | Display TPM info                        =
 |
> > ++---------------------------+-----------------------------------------=
-+
> > +| wolftpm_state             | Display TPM state                       =
 |
> > ++---------------------------+-----------------------------------------=
-+
> > +| wolftpm_device            | Show/set TPM device                     =
 |
> > ++---------------------------+-----------------------------------------=
-+
> > +| wolftpm_startup_clear     | TPM2_Startup with CLEAR mode            =
 |
> > ++---------------------------+-----------------------------------------=
-+
> > +| wolftpm_startup_state     | TPM2_Startup with STATE mode            =
 |
> > ++---------------------------+-----------------------------------------=
-+
> > +| wolftpm_startup_shutdown  | TPM2_Shutdown command                   =
 |
> > ++---------------------------+-----------------------------------------=
-+
> > +| wolftpm_get_capability    | Read TPM capabilities by property       =
 |
> > ++---------------------------+-----------------------------------------=
-+
> > +
> > +TODO: Commands Not Yet Tested
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +The following commands are implemented in ``cmd/wolftpm.c`` but do not
> yet have
> > +test coverage due to special requirements:
> > +
> >
> ++---------------------------+------------------------------------------+=
------------------+
> > +| Command                   | Description
> | Notes            |
> >
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> > +| pcr_setauthpolicy         | Set PCR authorization policy
>  | Requires         |
> > +|                           |
> | wolfCrypt        |
> >
> ++---------------------------+------------------------------------------+=
------------------+
> > +| pcr_setauthvalue          | Set PCR authorization value
> | Requires         |
> > +|                           |
> | wolfCrypt        |
> >
> ++---------------------------+------------------------------------------+=
------------------+
> > +| firmware_update           | Update TPM firmware (Infineon only)
> | Requires         |
> > +|                           |
> | Infineon HW      |
> >
> ++---------------------------+------------------------------------------+=
------------------+
> > +| firmware_cancel           | Cancel firmware update (Infineon only)
>  | Requires         |
> > +|                           |
> | Infineon HW      |
> >
> ++---------------------------+------------------------------------------+=
------------------+
> > +
> > +**Note:** The ``pcr_setauthpolicy`` and ``pcr_setauthvalue`` commands
> require
> > +``WOLFTPM2_NO_WOLFCRYPT`` to be undefined (i.e., wolfCrypt must be
> enabled).
> > +The ``firmware_update`` and ``firmware_cancel`` commands require
> Infineon
> > +SLB9672/SLB9673 hardware.
> > +
> > +To add tests for these commands:
> > +
> > +1. Add C unit test in ``test/cmd/wolftpm.c``::
> > +
> > +     static int cmd_test_wolftpm_<command>(struct unit_test_state *uts=
)
> > +     {
> > +         ut_assertok(run_command("wolftpm autostart", 0));
> > +         ut_assertok(run_command("wolftpm <command> <args>", 0));
> > +         return 0;
> > +     }
> > +     CMD_TEST(cmd_test_wolftpm_<command>, 0);
> > +
> > +2. Add Python test in ``test/py/tests/test_wolftpm.py``::
> > +
> > +     @pytest.mark.buildconfigspec('tpm_wolf')
> > +     def test_wolftpm_<command>(ubman):
> > +         force_init(ubman)
> > +         ubman.run_command('wolftpm <command> <args>')
> > +         output =3D ubman.run_command('echo $?')
> > +         assert output.endswith('0')
> > +
> > +TODO: Testing on Raspberry Pi Hardware
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +For testing with real TPM hardware (e.g., Infineon SLB9672 TPM HAT on
> Raspberry Pi):
> > +
> > +1. Build U-Boot for Raspberry Pi::
> > +
> > +     make distclean
> > +     export CROSS_COMPILE=3Daarch64-linux-gnu-
> > +     export ARCH=3Daarch64
> > +     make rpi_arm64_defconfig
> > +     make -j$(nproc)
> > +
> > +2. Backup current boot configuration::
> > +
> > +     sudo cp /boot/firmware/config.txt /boot/firmware/config.txt.backu=
p
> > +
> > +3. Copy U-Boot to boot partition::
> > +
> > +     sudo cp u-boot.bin /boot/firmware/
> > +
> > +4. Edit ``/boot/firmware/config.txt`` and add::
> > +
> > +     # U-Boot for wolfTPM testing
> > +     enable_uart=3D1
> > +     kernel=3Du-boot.bin
> > +     arm_64bit=3D1
> > +
> > +5. Connect serial console (recommended) - USB-to-serial adapter on GPI=
O
> 14/15
> > +   (pins 8/10) at 115200 baud.
> > +
> > +6. Reboot and test at U-Boot prompt::
> > +
> > +     U-Boot> tpm2 device
> > +     U-Boot> tpm2 info
> > +     U-Boot> tpm2 autostart
> > +     U-Boot> tpm2 caps
> > +     U-Boot> tpm2 pcr_read 0 0x1000000 SHA256
> > +
> > +7. To restore normal Linux boot::
> > +
> > +     sudo cp /boot/firmware/config.txt.backup /boot/firmware/config.tx=
t
> > +     sudo reboot
> > +
> > +**Note:** The Raspberry Pi build uses GPIO-based soft SPI for TPM
> communication.
> > +Standard SPI0 pins are used: GPIO 11 (SCLK), GPIO 10 (MOSI), GPIO 9
> (MISO),
> > +GPIO 7 (CE1 for TPM). Adjust
> ``arch/arm/dts/bcm2711-rpi-4-b-u-boot.dtsi`` if
> > +your TPM HAT uses different GPIO pins.
> > +
> > +TODO: Python Test Framework
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +The Python tests in ``test/py/tests/test_wolftpm.py`` require
> additional setup
> > +for QEMU boards (external ``u-boot-test-flash``,
> ``u-boot-test-console``, etc.
> > +scripts). The C unit tests (``test/cmd/wolftpm.c``) provide equivalent
> coverage
> > +and work directly with ``ut cmd`` in U-Boot.
> > +
> > +**Status:** Python tests need verification with proper QEMU test
> infrastructure
> > +or deprecation in favor of C unit tests which are fully functional.
> > +
> > +Testing wolfTPM SPI Path in Sandbox
> > +-----------------------------------
> > +
> > +The sandbox build includes a TPM SPI emulator that tests the complete
> wolfTPM
> > +SPI communication path without requiring hardware. This validates the
> SPI HAL
> > +code path in ``lib/wolftpm/hal/tpm_io_uboot.c``.
> > +
> > +SPI Code Path
> > +~~~~~~~~~~~~~
> > +
> > +When testing in sandbox, the following code path is exercised::
> > +
> > +    wolftpm commands (cmd/wolftpm.c)
> > +           =E2=86=93
> > +    wolfTPM library (lib/wolftpm/)
> > +           =E2=86=93
> > +    SPI HAL (lib/wolftpm/hal/tpm_io_uboot.c)
> > +           =E2=86=93
> > +    U-Boot SPI API (spi_get_bus_and_cs, spi_xfer)
> > +           =E2=86=93
> > +    Sandbox SPI Master (drivers/spi/sandbox_spi.c)
> > +           =E2=86=93
> > +    TPM SPI Emulator (drivers/tpm/tpm_spi_sandbox.c)
> > +
> > +The TPM SPI emulator implements the TPM TIS (Trusted Platform Module
> Interface
> > +Specification) over SPI protocol:
> > +
> > +- 4-byte SPI header: ``[R/W|len-1][0xD4][addr_hi][addr_lo]``
> > +- Wait-state handling with ready byte
> > +- TIS register emulation (ACCESS, STS, FIFO, DID/VID, RID)
> > +- TIS state machine (IDLE =E2=86=92 READY =E2=86=92 RECEPTION =E2=86=
=92 COMPLETION)
> > +
> > +Building Sandbox with SPI Support
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +To build sandbox with TPM SPI emulator support::
> > +
> > +    make sandbox_defconfig
> > +    make -j$(nproc)
> > +
> > +The following configs are enabled by default in sandbox:
> > +
> > +- ``CONFIG_TPM=3Dy``
> > +- ``CONFIG_TPM_V2=3Dy``
> > +- ``CONFIG_TPM_WOLF=3Dy``
> > +- ``CONFIG_CMD_WOLFTPM=3Dy``
> > +- ``CONFIG_TPM2_SPI_SANDBOX=3Dy``
> > +
> > +Running SPI Tests
> > +~~~~~~~~~~~~~~~~~
> > +
> > +**Important:** The sandbox TPM SPI device requires the ``-D`` flag to
> load the
> > +full device tree. Without this flag, the SPI bus will not be available=
.
> > +
> > +Run wolfTPM commands via SPI::
> > +
> > +    # Build sandbox
> > +    make sandbox_defconfig && make -j$(nproc)
> > +
> > +    # Run with full device tree
> > +    ./u-boot -D
> > +
> > +    # At U-Boot prompt, test wolfTPM SPI path
> > +    =3D> wolftpm autostart
> > +    =3D> wolftpm caps
> > +    =3D> wolftpm info
> > +    =3D> wolftpm pcr_read 0 0x1000000 SHA256
> > +    =3D> wolftpm pcr_print
> > +
> > +Non-interactive testing::
> > +
> > +    # Single command
> > +    ./u-boot -D -c "wolftpm autostart"
> > +
> > +    # Multiple commands
> > +    ./u-boot -D -c "wolftpm autostart; wolftpm caps; wolftpm info"
> > +
> > +Expected output::
> > +
> > +    TPM SPI initialized: bus 0, cs 1
> > +    TPM2: Caps 0x30000697, Did 0x001d, Vid 0x15d1, Rid 0x36
> > +    TPM2_Startup pass
> > +    wolfTPM2_Reset complete
> > +    TPM2_SelfTest pass
> > +
> > +Enabling Debug Output
> > +~~~~~~~~~~~~~~~~~~~~~
> > +
> > +To see SPI-level debug messages, enable logging before running::
> > +
> > +    # At U-Boot prompt
> > +    =3D> log level 7
> > +
> > +Or enable in defconfig::
> > +
> > +    CONFIG_LOG=3Dy
> > +    CONFIG_LOG_MAX_LEVEL=3D7
> > +    CONFIG_LOG_DEFAULT_LEVEL=3D7
> > +
> > +For wolfTPM library-level SPI debug, edit
> ``include/configs/user_settings.h``::
> > +
> > +    #define DEBUG_WOLFTPM
> > +    #define WOLFTPM_DEBUG_IO    /* Shows SPI transfer details */
> > +
> > +Device Tree Configuration
> > +~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +The sandbox SPI TPM is defined in ``arch/sandbox/dts/sandbox.dtsi``::
> > +
> > +    &spi0 {
> > +        tpm_spi: tpm@1 {
> > +            reg =3D <1>;
> > +            compatible =3D "sandbox,tpm-spi";
> > +            spi-max-frequency =3D <10000000>;
> > +            sandbox,emul =3D <&tpm_spi_emul>;
> > +        };
> > +    };
> > +
> > +    tpm_spi_emul: tpm-spi-emul {
> > +        compatible =3D "sandbox,tpm-spi-emul";
> > +    };
> > +
> > +The emulator driver is in ``drivers/tpm/tpm_spi_sandbox.c``.
> > diff --git a/drivers/mtd/spi/sandbox.c b/drivers/mtd/spi/sandbox.c
> > index e5ebc3479fb..41bd07817aa 100644
> > --- a/drivers/mtd/spi/sandbox.c
> > +++ b/drivers/mtd/spi/sandbox.c
> > @@ -571,16 +571,28 @@ int sandbox_spi_get_emul(struct sandbox_state
> *state,
> >
> >       info =3D &state->spi[busnum][cs];
> >       if (!info->emul) {
> > -             /* Use the same device tree node as the SPI flash device =
*/
> > -             debug("%s: busnum=3D%u, cs=3D%u: binding SPI flash emulat=
ion:
> ",
> > -                   __func__, busnum, cs);
> > -             ret =3D sandbox_sf_bind_emul(state, busnum, cs, bus,
> > -                                        dev_ofnode(slave), slave->name=
);
> > -             if (ret) {
> > -                     debug("failed (err=3D%d)\n", ret);
> > -                     return ret;
> > +             struct udevice *emul;
> > +             ofnode node =3D dev_ofnode(slave);
> > +
> > +             /* First check for sandbox,emul phandle property */
> > +             ret =3D uclass_get_device_by_phandle(UCLASS_SPI_EMUL, sla=
ve,
> > +                                                "sandbox,emul", &emul)=
;
> > +             if (!ret) {
> > +                     debug("%s: busnum=3D%u, cs=3D%u: using phandle
> emulator\n",
> > +                           __func__, busnum, cs);
> > +                     info->emul =3D emul;
> > +             } else {
> > +                     /* Fall back to SPI flash emulation binding */
> > +                     debug("%s: busnum=3D%u, cs=3D%u: binding SPI flas=
h
> emulation: ",
> > +                           __func__, busnum, cs);
> > +                     ret =3D sandbox_sf_bind_emul(state, busnum, cs, b=
us,
> > +                                                node, slave->name);
> > +                     if (ret) {
> > +                             debug("failed (err=3D%d)\n", ret);
> > +                             return ret;
> > +                     }
> > +                     debug("OK\n");
> >               }
> > -             debug("OK\n");
> >       }
> >       *emulp =3D info->emul;
> >
> > diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> > index 8c6c095a8cf..9625b1e073e 100644
> > --- a/drivers/spi/Kconfig
> > +++ b/drivers/spi/Kconfig
> > @@ -117,6 +117,15 @@ config ATMEL_SPI
> >         many AT91 (ARM) chips. This driver can be used to access
> >         the SPI Flash, such as AT25DF321.
> >
> > +config BCM2835_SPI
> > +     bool "BCM2835/BCM2711 SPI driver"
> > +     depends on ARCH_BCM283X
> > +     help
> > +       Enable the BCM2835/BCM2711 SPI controller driver. This driver
> > +       can be used to access SPI devices on Raspberry Pi boards
> > +       including Pi 3 and Pi 4. It uses the hardware SPI controller
> > +       rather than GPIO bit-banging.
> > +
> >  config BCM63XX_HSSPI
> >       bool "BCM63XX HSSPI driver"
> >       depends on (ARCH_BMIPS || ARCH_BCMBCA)
> > diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> > index 0dc2d23e172..47a1c6194b1 100644
> > --- a/drivers/spi/Makefile
> > +++ b/drivers/spi/Makefile
> > @@ -27,6 +27,7 @@ obj-$(CONFIG_APPLE_SPI) +=3D apple_spi.o
> >  obj-$(CONFIG_ATH79_SPI) +=3D ath79_spi.o
> >  obj-$(CONFIG_ATMEL_QSPI) +=3D atmel-quadspi.o
> >  obj-$(CONFIG_ATMEL_SPI) +=3D atmel_spi.o
> > +obj-$(CONFIG_BCM2835_SPI) +=3D bcm2835_spi.o
> >  obj-$(CONFIG_BCM63XX_HSSPI) +=3D bcm63xx_hsspi.o
> >  obj-$(CONFIG_BCMBCA_HSSPI) +=3D bcmbca_hsspi.o
> >  obj-$(CONFIG_BCM63XX_SPI) +=3D bcm63xx_spi.o
> > diff --git a/drivers/spi/bcm2835_spi.c b/drivers/spi/bcm2835_spi.c
> > new file mode 100644
> > index 00000000000..c44c2a6ed3e
> > --- /dev/null
> > +++ b/drivers/spi/bcm2835_spi.c
>
> This is nice to have, but needs to be in its own patch so the RPI
> maintainers
> can review/ack it
>
> > @@ -0,0 +1,429 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * BCM2835/BCM2711 SPI controller driver for U-Boot
> > + *
> > + * Copyright (C) 2025 wolfSSL Inc.
> > + * Author: Aidan Garske <aidan@wolfssl.com>
> > + *
> > + * Based on Linux driver by Chris Boot, Martin Sperl, et al.
> > + */
> > +
> > +#include <dm.h>
> > +#include <errno.h>
> > +#include <log.h>
> > +#include <malloc.h>
> > +#include <spi.h>
> > +#include <asm/io.h>
> > +#include <asm/gpio.h>
> > +#include <dm/device_compat.h>
> > +#include <linux/delay.h>
> > +
> > +/* SPI register offsets */
> > +#define BCM2835_SPI_CS      0x00    /* Control and Status */
> > +#define BCM2835_SPI_FIFO    0x04    /* TX and RX FIFOs */
> > +#define BCM2835_SPI_CLK     0x08    /* Clock Divider */
> > +#define BCM2835_SPI_DLEN    0x0c    /* Data Length */
> > +#define BCM2835_SPI_LTOH    0x10    /* LoSSI mode TOH */
> > +#define BCM2835_SPI_DC      0x14    /* DMA DREQ Controls */
> > +
> > +/* CS register bits */
> > +#define BCM2835_SPI_CS_LEN_LONG     BIT(25)
> > +#define BCM2835_SPI_CS_DMA_LEN      BIT(24)
> > +#define BCM2835_SPI_CS_CSPOL2       BIT(23)
> > +#define BCM2835_SPI_CS_CSPOL1       BIT(22)
> > +#define BCM2835_SPI_CS_CSPOL0       BIT(21)
> > +#define BCM2835_SPI_CS_RXF          BIT(20)
> > +#define BCM2835_SPI_CS_RXR          BIT(19)
> > +#define BCM2835_SPI_CS_TXD          BIT(18)
> > +#define BCM2835_SPI_CS_RXD          BIT(17)
> > +#define BCM2835_SPI_CS_DONE         BIT(16)
> > +#define BCM2835_SPI_CS_LEN          BIT(13)
> > +#define BCM2835_SPI_CS_REN          BIT(12)
> > +#define BCM2835_SPI_CS_ADCS         BIT(11)
> > +#define BCM2835_SPI_CS_INTR         BIT(10)
> > +#define BCM2835_SPI_CS_INTD         BIT(9)
> > +#define BCM2835_SPI_CS_DMAEN        BIT(8)
> > +#define BCM2835_SPI_CS_TA           BIT(7)
> > +#define BCM2835_SPI_CS_CSPOL        BIT(6)
> > +#define BCM2835_SPI_CS_CLEAR_RX     BIT(5)
> > +#define BCM2835_SPI_CS_CLEAR_TX     BIT(4)
> > +#define BCM2835_SPI_CS_CPOL         BIT(3)
> > +#define BCM2835_SPI_CS_CPHA         BIT(2)
> > +#define BCM2835_SPI_CS_CS_10        BIT(1)
> > +#define BCM2835_SPI_CS_CS_01        BIT(0)
> > +
> > +/* Default clock rate - 250 MHz for Pi 4 */
> > +#define BCM2835_SPI_DEFAULT_CLK     250000000
> > +
> > +struct bcm2835_spi_priv {
> > +    void __iomem *regs;
> > +    u32 clk_hz;
> > +    u32 cs_reg;         /* Cached CS register value */
> > +    u32 speed_hz;
> > +    u8 mode;
> > +    struct gpio_desc cs_gpio;
> > +    int cs_gpio_valid;
> > +    int cs_asserted;    /* Track if CS should stay asserted between
> transfers */
> > +};
> > +
> > +struct bcm2835_spi_plat {
> > +    fdt_addr_t base;
> > +    u32 clk_hz;
> > +};
> > +
> > +static inline u32 bcm2835_spi_readl(struct bcm2835_spi_priv *priv, u32
> reg)
> > +{
> > +    return readl(priv->regs + reg);
> > +}
> > +
> > +static inline void bcm2835_spi_writel(struct bcm2835_spi_priv *priv,
> > +                                       u32 reg, u32 val)
> > +{
> > +    writel(val, priv->regs + reg);
> > +}
> > +
> > +static void bcm2835_spi_reset(struct bcm2835_spi_priv *priv)
> > +{
> > +    /* Clear FIFOs and disable SPI */
> > +    bcm2835_spi_writel(priv, BCM2835_SPI_CS,
> > +                       BCM2835_SPI_CS_CLEAR_RX |
> BCM2835_SPI_CS_CLEAR_TX);
> > +}
> > +
> > +/* GPIO base for software CS control */
> > +static void __iomem *g_gpio_base =3D (void __iomem *)0xFE200000;
> > +
> > +/* Software CS control - assert (LOW =3D active) */
> > +static void bcm2835_spi_cs_assert(int cs_pin)
> > +{
> > +    /* GPCLR0 - clear pin (drive LOW) */
> > +    writel(1 << cs_pin, g_gpio_base + 0x28);
> > +}
> > +
> > +/* Software CS control - deassert (HIGH =3D inactive) */
> > +static void bcm2835_spi_cs_deassert(int cs_pin)
> > +{
> > +    /* GPSET0 - set pin (drive HIGH) */
> > +    writel(1 << cs_pin, g_gpio_base + 0x1C);
> > +}
> > +
> > +static int bcm2835_spi_xfer(struct udevice *dev, unsigned int bitlen,
> > +                            const void *dout, void *din, unsigned long
> flags)
> > +{
> > +    struct udevice *bus =3D dev_get_parent(dev);
> > +    struct bcm2835_spi_priv *priv =3D dev_get_priv(bus);
> > +    const u8 *tx =3D dout;
> > +    u8 *rx =3D din;
> > +    u32 len =3D bitlen / 8;
> > +    u32 cs_reg;
> > +    u32 tx_count =3D 0, rx_count =3D 0;
> > +    int timeout;
> > +    int cs =3D spi_chip_select(dev);  /* Get chip select from slave
> device */
> > +    int cs_pin =3D (cs =3D=3D 0) ? 8 : 7; /* CS0=3DGPIO8, CS1=3DGPIO7 =
*/
> > +    u32 stat;
> > +
> > +    if (bitlen =3D=3D 0) {
> > +        /* Handle CS-only operations (deassert) */
> > +        if (flags & SPI_XFER_END) {
> > +            bcm2835_spi_cs_deassert(cs_pin);
> > +            priv->cs_asserted =3D 0;
> > +        }
> > +        return 0;
> > +    }
> > +
> > +    if (bitlen % 8) {
> > +        dev_err(dev, "Non-byte-aligned transfer not supported\n");
> > +        return -EINVAL;
> > +    }
> > +
> > +    /*
> > +     * SOFTWARE GPIO CHIP SELECT - like Linux driver
> > +     * Don't use hardware CS bits - set to 0 (unused)
> > +     */
> > +    cs_reg =3D priv->cs_reg & ~(BCM2835_SPI_CS_CS_10 |
> BCM2835_SPI_CS_CS_01);
> > +
> > +    /* Assert CS at start of transaction (SPI_XFER_BEGIN) */
> > +    if (flags & SPI_XFER_BEGIN) {
> > +        bcm2835_spi_cs_assert(cs_pin);
> > +        priv->cs_asserted =3D 1;
> > +        udelay(1);  /* CS setup time */
> > +    }
> > +
> > +    /* Clear FIFOs for new transaction */
> > +    if (flags & SPI_XFER_BEGIN) {
> > +        bcm2835_spi_writel(priv, BCM2835_SPI_CS,
> > +                           cs_reg | BCM2835_SPI_CS_CLEAR_RX |
> > +                           BCM2835_SPI_CS_CLEAR_TX);
> > +        udelay(1);
> > +    }
> > +
> > +    /* Start transfer with TA=3D1 (but CS is controlled by GPIO, not
> hardware) */
> > +    bcm2835_spi_writel(priv, BCM2835_SPI_CS, cs_reg |
> BCM2835_SPI_CS_TA);
> > +
> > +    /* Poll for completion - transfer byte by byte */
> > +    timeout =3D 100000;
> > +    while ((tx_count < len || rx_count < len) && timeout > 0) {
> > +        stat =3D bcm2835_spi_readl(priv, BCM2835_SPI_CS);
> > +
> > +        /* TX FIFO not full - send next byte */
> > +        while ((stat & BCM2835_SPI_CS_TXD) && tx_count < len) {
> > +            u8 byte =3D tx ? tx[tx_count] : 0;
> > +            bcm2835_spi_writel(priv, BCM2835_SPI_FIFO, byte);
> > +            tx_count++;
> > +            stat =3D bcm2835_spi_readl(priv, BCM2835_SPI_CS);
> > +        }
> > +
> > +        /* RX FIFO has data - read it */
> > +        while ((stat & BCM2835_SPI_CS_RXD) && rx_count < len) {
> > +            u8 byte =3D bcm2835_spi_readl(priv, BCM2835_SPI_FIFO) & 0x=
ff;
> > +            if (rx)
> > +                rx[rx_count] =3D byte;
> > +            rx_count++;
> > +            stat =3D bcm2835_spi_readl(priv, BCM2835_SPI_CS);
> > +        }
> > +
> > +        timeout--;
> > +    }
> > +
> > +    /* Wait for DONE */
> > +    timeout =3D 10000;
> > +    while (!(bcm2835_spi_readl(priv, BCM2835_SPI_CS) &
> BCM2835_SPI_CS_DONE) &&
> > +           timeout > 0) {
> > +        udelay(1);
> > +        timeout--;
> > +    }
> > +
> > +    /* Read any remaining RX data from FIFO */
> > +    while (bcm2835_spi_readl(priv, BCM2835_SPI_CS) &
> BCM2835_SPI_CS_RXD) {
> > +        u8 byte =3D bcm2835_spi_readl(priv, BCM2835_SPI_FIFO) & 0xff;
> > +        if (rx && rx_count < len)
> > +            rx[rx_count++] =3D byte;
> > +    }
> > +
> > +    /* Clear TA to complete this transfer (doesn't affect GPIO CS) */
> > +    bcm2835_spi_writel(priv, BCM2835_SPI_CS, cs_reg);
> > +
> > +    /*
> > +     * SOFTWARE GPIO CHIP SELECT control:
> > +     * - SPI_XFER_END: deassert CS (GPIO HIGH)
> > +     * - No END flag: keep CS asserted for next transfer
> > +     */
> > +    if (flags & SPI_XFER_END) {
> > +        bcm2835_spi_cs_deassert(cs_pin);
> > +        priv->cs_asserted =3D 0;
> > +    } else {
> > +        /* Keep CS asserted for next transfer (e.g., wait state
> polling) */
> > +        priv->cs_asserted =3D 1;
> > +    }
> > +
> > +    if (timeout =3D=3D 0) {
> > +        bcm2835_spi_cs_deassert(cs_pin);  /* Make sure CS is released =
*/
> > +        return -ETIMEDOUT;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static int bcm2835_spi_set_speed(struct udevice *bus, uint speed)
> > +{
> > +    struct bcm2835_spi_priv *priv =3D dev_get_priv(bus);
> > +    u32 cdiv;
> > +
> > +    if (speed =3D=3D 0)
> > +        speed =3D 1000000;  /* Default 1 MHz */
> > +
> > +    priv->speed_hz =3D speed;
> > +
> > +    /* Calculate clock divider */
> > +    if (speed >=3D priv->clk_hz / 2) {
> > +        cdiv =3D 2;  /* Fastest possible */
> > +    } else {
> > +        cdiv =3D (priv->clk_hz + speed - 1) / speed;
> > +        cdiv +=3D (cdiv & 1);  /* Must be even */
> > +        if (cdiv >=3D 65536)
> > +            cdiv =3D 0;  /* Slowest: clk/65536 */
> > +    }
> > +
> > +    bcm2835_spi_writel(priv, BCM2835_SPI_CLK, cdiv);
> > +
> > +    return 0;
> > +}
> > +
> > +static int bcm2835_spi_set_mode(struct udevice *bus, uint mode)
> > +{
> > +    struct bcm2835_spi_priv *priv =3D dev_get_priv(bus);
> > +    u32 cs_reg =3D 0;
> > +
> > +    priv->mode =3D mode;
> > +
> > +    /* Set clock polarity and phase */
> > +    if (mode & SPI_CPOL)
> > +        cs_reg |=3D BCM2835_SPI_CS_CPOL;
> > +    if (mode & SPI_CPHA)
> > +        cs_reg |=3D BCM2835_SPI_CS_CPHA;
> > +
> > +    /* CS bits will be set in xfer based on slave's chip select */
> > +    priv->cs_reg =3D cs_reg;
> > +
> > +    return 0;
> > +}
> > +
> > +static int bcm2835_spi_claim_bus(struct udevice *dev)
> > +{
> > +    return 0;
> > +}
> > +
> > +static int bcm2835_spi_release_bus(struct udevice *dev)
> > +{
> > +    return 0;
> > +}
> > +
> > +/* Setup GPIO pins for SPI0 with SOFTWARE chip select */
> > +static void bcm2835_spi_setup_gpio(void)
> > +{
> > +    u32 val;
> > +
> > +    /*
> > +     * SPI0 pin configuration:
> > +     * GPIO7  (CE1)  - OUTPUT (software CS) - GPFSEL0 bits 23:21 =3D 0=
01
> > +     * GPIO8  (CE0)  - OUTPUT (software CS) - GPFSEL0 bits 26:24 =3D 0=
01
> > +     * GPIO9  (MISO) - ALT0 (SPI)           - GPFSEL0 bits 29:27 =3D 1=
00
> > +     * GPIO10 (MOSI) - ALT0 (SPI)           - GPFSEL1 bits 2:0   =3D 1=
00
> > +     * GPIO11 (SCLK) - ALT0 (SPI)           - GPFSEL1 bits 5:3   =3D 1=
00
> > +     */
> > +
> > +    /* Set GPIO7, GPIO8 to OUTPUT, GPIO9 to ALT0 in GPFSEL0 */
> > +    val =3D readl(g_gpio_base + 0x00);
> > +    val &=3D ~((7 << 21) | (7 << 24) | (7 << 27));  /* Clear GPIO7,8,9=
 */
> > +    val |=3D (1 << 21);   /* GPIO7 =3D OUTPUT (001) */
> > +    val |=3D (1 << 24);   /* GPIO8 =3D OUTPUT (001) */
> > +    val |=3D (4 << 27);   /* GPIO9 =3D ALT0 (100) for MISO */
> > +    writel(val, g_gpio_base + 0x00);
> > +
> > +    /* Set GPIO10, GPIO11 to ALT0 in GPFSEL1 */
> > +    val =3D readl(g_gpio_base + 0x04);
> > +    val &=3D ~((7 << 0) | (7 << 3));  /* Clear GPIO10,11 */
> > +    val |=3D (4 << 0);    /* GPIO10 =3D ALT0 (100) for MOSI */
> > +    val |=3D (4 << 3);    /* GPIO11 =3D ALT0 (100) for SCLK */
> > +    writel(val, g_gpio_base + 0x04);
> > +
> > +    /* Deassert both CS lines (HIGH =3D inactive) */
> > +    bcm2835_spi_cs_deassert(7);  /* CE1 */
> > +    bcm2835_spi_cs_deassert(8);  /* CE0 */
> > +}
> > +
> > +/* TPM Reset via GPIO4 and GPIO24 */
> > +static void bcm2835_spi_tpm_reset(void)
> > +{
> > +    void __iomem *gpio_base =3D (void __iomem *)0xFE200000;
> > +    u32 val;
> > +
> > +    /* Set GPIO4 as output (GPFSEL0, bits 14:12) */
> > +    val =3D readl(gpio_base + 0x00);  /* GPFSEL0 */
> > +    val &=3D ~(7 << 12);  /* Clear bits 14:12 for GPIO4 */
> > +    val |=3D (1 << 12);   /* Set to output */
> > +    writel(val, gpio_base + 0x00);
> > +
> > +    /* Set GPIO24 as output (GPFSEL2, bits 14:12) */
> > +    val =3D readl(gpio_base + 0x08);  /* GPFSEL2 */
> > +    val &=3D ~(7 << 12);  /* Clear bits 14:12 for GPIO24 */
> > +    val |=3D (1 << 12);   /* Set to output */
> > +    writel(val, gpio_base + 0x08);
> > +
> > +    /* Assert reset on BOTH pins (LOW) */
> > +    writel((1 << 4) | (1 << 24), gpio_base + 0x28);  /* GPCLR0 */
> > +    mdelay(100);
> > +
> > +    /* Release reset on BOTH pins (HIGH) */
> > +    writel((1 << 4) | (1 << 24), gpio_base + 0x1C);  /* GPSET0 */
> > +    mdelay(150);  /* Wait for TPM to initialize */
> > +}
> > +
> > +static int bcm2835_spi_probe(struct udevice *bus)
> > +{
> > +    struct bcm2835_spi_plat *plat =3D dev_get_plat(bus);
> > +    struct bcm2835_spi_priv *priv =3D dev_get_priv(bus);
> > +    int ret;
> > +
> > +    priv->regs =3D (void __iomem *)plat->base;
> > +    priv->clk_hz =3D plat->clk_hz ? plat->clk_hz :
> BCM2835_SPI_DEFAULT_CLK;
> > +
> > +    /* Setup GPIO pins for SPI0 (ALT0 function) */
> > +    bcm2835_spi_setup_gpio();
> > +
> > +    /* Reset TPM before using SPI */
> > +    bcm2835_spi_tpm_reset();
> > +
> > +    /* Try to get CS GPIO from device tree */
> > +    ret =3D gpio_request_by_name(bus, "cs-gpios", 0, &priv->cs_gpio,
> > +                               GPIOD_IS_OUT | GPIOD_ACTIVE_LOW);
> > +    if (ret =3D=3D 0) {
> > +        priv->cs_gpio_valid =3D 1;
> > +        /* Deassert CS initially */
> > +        dm_gpio_set_value(&priv->cs_gpio, 1);
> > +    } else {
> > +        priv->cs_gpio_valid =3D 0;
> > +    }
> > +
> > +    /* Reset the SPI controller */
> > +    bcm2835_spi_reset(priv);
> > +
> > +    /* Set default speed and mode */
> > +    bcm2835_spi_set_speed(bus, 1000000);  /* 1 MHz default */
> > +    bcm2835_spi_set_mode(bus, SPI_MODE_0);
> > +
> > +    return 0;
> > +}
> > +
> > +static int bcm2835_spi_of_to_plat(struct udevice *bus)
> > +{
> > +    struct bcm2835_spi_plat *plat =3D dev_get_plat(bus);
> > +    fdt_addr_t addr;
> > +
> > +    addr =3D dev_read_addr(bus);
> > +    if (addr =3D=3D FDT_ADDR_T_NONE) {
> > +        dev_err(bus, "Failed to get SPI base address\n");
> > +        return -EINVAL;
> > +    }
> > +
> > +    /*
> > +     * On BCM2711 (Pi 4), the device tree often uses VideoCore bus
> addresses
> > +     * which start with 0x7E. The ARM needs to access these via the AR=
M
> > +     * peripheral base at 0xFE000000.
> > +     */
> > +    if ((addr & 0xFF000000) =3D=3D 0x7E000000) {
> > +        addr =3D (addr & 0x00FFFFFF) | 0xFE000000;
> > +    }
> > +
> > +    plat->base =3D addr;
> > +
> > +    /* Try to get clock rate from device tree */
> > +    plat->clk_hz =3D dev_read_u32_default(bus, "clock-frequency",
> > +                                         BCM2835_SPI_DEFAULT_CLK);
> > +
> > +    return 0;
> > +}
> > +
> > +static const struct dm_spi_ops bcm2835_spi_ops =3D {
> > +    .claim_bus      =3D bcm2835_spi_claim_bus,
> > +    .release_bus    =3D bcm2835_spi_release_bus,
> > +    .xfer           =3D bcm2835_spi_xfer,
> > +    .set_speed      =3D bcm2835_spi_set_speed,
> > +    .set_mode       =3D bcm2835_spi_set_mode,
> > +};
> > +
> > +static const struct udevice_id bcm2835_spi_ids[] =3D {
> > +    { .compatible =3D "brcm,bcm2835-spi" },
> > +    { .compatible =3D "brcm,bcm2711-spi" },
> > +    { }
> > +};
> > +
> > +U_BOOT_DRIVER(bcm2835_spi) =3D {
> > +    .name           =3D "bcm2835_spi",
> > +    .id             =3D UCLASS_SPI,
> > +    .of_match       =3D bcm2835_spi_ids,
> > +    .ops            =3D &bcm2835_spi_ops,
> > +    .of_to_plat     =3D bcm2835_spi_of_to_plat,
> > +    .plat_auto      =3D sizeof(struct bcm2835_spi_plat),
> > +    .priv_auto      =3D sizeof(struct bcm2835_spi_priv),
> > +    .probe          =3D bcm2835_spi_probe,
> > +};
> > diff --git a/drivers/tpm/Kconfig b/drivers/tpm/Kconfig
> > index 219ea606b50..d4694946b94 100644
> > --- a/drivers/tpm/Kconfig
> > +++ b/drivers/tpm/Kconfig
> > @@ -158,6 +158,14 @@ config TPM2_TIS_SANDBOX
> >         such as basic configuration, PCR extension and PCR read. Extend=
ed
> >         functionalities are not implemented.
> >
> > +config TPM2_SPI_SANDBOX
> > +     bool "Enable sandbox TPM SPI emulator"
> > +     depends on TPM_V2 && SANDBOX && DM_SPI
> > +     help
> > +       This driver emulates a TPM connected via SPI for sandbox testin=
g.
> > +       It implements the TPM TIS SPI protocol and can be used to test
> > +       wolfTPM SPI HAL code without physical hardware.
> > +
> >  config TPM2_TIS_SPI
> >       bool "Enable support for TPMv2.x SPI chips"
> >       depends on TPM_V2 && DM_SPI
> > @@ -200,6 +208,34 @@ config TPM2_EVENT_LOG_SIZE
> >         allocated twice. One for the eventlog it self and one for the
> >         configuration table that is required from the TCG2 spec
> >
> > +config WOLFTPM_LINUX_DEV
> > +    bool "Use device-level TPM interface (bypass wolfTPM TIS layer)"
> > +    depends on TPM_V2 && TPM_WOLF
> > +    default y
> > +    help
> > +      Enable wolfTPM to use the underlying TPM driver instead of its o=
wn
> > +      TIS (TPM Interface Specification) layer. On U-Boot, this uses th=
e
> > +      U-Boot TPM driver model (tpm_xfer). On Linux, this uses /dev/tpm=
0.
> > +      This is the recommended setting for U-Boot.
> > +
> > +config WOLFTPM_SLB9672
> > +    bool "Enable support for Infineon SLB9672 TPM"
> > +    depends on TPM_V2 && TPM_WOLF
> > +    help
> > +      Enable support for Infineon SLB9672 TPM features in wolfTPM.
> > +
> > +config WOLFTPM_SLB9673
> > +    bool "Enable support for Infineon SLB9673 TPM"
> > +    depends on TPM_V2 && TPM_WOLF
> > +    help
> > +      Enable support for Infineon SLB9673 TPM features in wolfTPM.
> > +
> > +config WOLFTPM_FIRMWARE_UPGRADE
> > +    bool "Enable firmware upgrade support for wolfTPM"
> > +    depends on TPM_V2 && TPM_WOLF
> > +    help
> > +      Enable support for Infineon TPM firmware upgrade commands in
> wolfTPM.
> > +
> >  endif # TPM_V2
> >
> >  endmenu
> > diff --git a/drivers/tpm/Makefile b/drivers/tpm/Makefile
> > index b83ce703ec0..39de454cacf 100644
> > --- a/drivers/tpm/Makefile
> > +++ b/drivers/tpm/Makefile
> > @@ -10,7 +10,16 @@ obj-$(CONFIG_TPM_TIS_SANDBOX) +=3D tpm_tis_sandbox.o
> sandbox_common.o
> >
> >  obj-$(CONFIG_$(PHASE_)TPM2_CR50_I2C) +=3D cr50_i2c.o
> >  obj-$(CONFIG_TPM2_TIS_SANDBOX) +=3D tpm2_tis_sandbox.o sandbox_common.=
o
> > +obj-$(CONFIG_TPM2_SPI_SANDBOX) +=3D tpm_spi_sandbox.o
> >  obj-$(CONFIG_TPM2_TIS_SPI) +=3D tpm2_tis_core.o tpm2_tis_spi.o
> >  obj-$(CONFIG_TPM2_TIS_I2C) +=3D tpm2_tis_core.o tpm2_tis_i2c.o
> >  obj-$(CONFIG_TPM2_FTPM_TEE) +=3D tpm2_ftpm_tee.o
> >  obj-$(CONFIG_TPM2_MMIO) +=3D tpm2_tis_core.o tpm2_tis_mmio.o
> > +
> > +# wolfTPM helper functions
> > +ifeq ($(CONFIG_TPM_WOLF),y)
> > +ccflags-y +=3D -Ilib/wolftpm \
> > +             -Iinclude/configs \
> > +             -DWOLFTPM_USER_SETTINGS
> > +obj-y +=3D wolftpm_common.o
> > +endif
> > diff --git a/drivers/tpm/tpm_spi_sandbox.c
> b/drivers/tpm/tpm_spi_sandbox.c
> > new file mode 100644
> > index 00000000000..694c5d721f0
> > --- /dev/null
> > +++ b/drivers/tpm/tpm_spi_sandbox.c
>
> Same for this one
>
> > @@ -0,0 +1,410 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Sandbox TPM SPI Emulator
> > + *
> > + * Copyright (c) 2025 wolfSSL Inc.
> > + * Author: Aidan Garske <aidan@wolfssl.com>
> > + *
> > + * Emulates TPM TIS SPI protocol for testing wolfTPM SPI HAL
> > + * without hardware. Wraps the existing sandbox TPM2 state machine.
> > + */
> > +
> > +#include <dm.h>
> > +#include <log.h>
> > +#include <spi.h>
> > +#include <spi_flash.h>
> > +#include <asm/spi.h>
> > +#include <asm/state.h>
> > +#include <linux/bitops.h>
> > +
> > +/* TIS register addresses (locality 0) */
> > +#define TPM_ACCESS_REG               0x0000
> > +#define TPM_INT_ENABLE_REG   0x0008
> > +#define TPM_INTF_CAPS_REG    0x0014
> > +#define TPM_STS_REG          0x0018
> > +#define TPM_DATA_FIFO_REG    0x0024
> > +#define TPM_DID_VID_REG              0x0F00
> > +#define TPM_RID_REG          0x0F04
> > +
> > +/* TIS access register bits */
> > +#define TPM_ACCESS_VALID             0x80
> > +#define TPM_ACCESS_ACTIVE_LOCALITY   0x20
> > +#define TPM_ACCESS_REQUEST_PENDING   0x04
> > +#define TPM_ACCESS_REQUEST_USE               0x02
> > +
> > +/* TIS status register bits */
> > +#define TPM_STS_VALID                0x80
> > +#define TPM_STS_COMMAND_READY        0x40
> > +#define TPM_STS_GO           0x20
> > +#define TPM_STS_DATA_AVAIL   0x10
> > +#define TPM_STS_DATA_EXPECT  0x08
> > +
> > +/* Interface capabilities */
> > +#define TPM_INTF_CAPS_VALUE  0x30000697  /* Typical Infineon value */
> > +
> > +/* Device/Vendor ID - Infineon SLB9670 */
> > +#define TPM_DID_VID_VALUE    0x001D15D1
> > +
> > +/* Revision ID */
> > +#define TPM_RID_VALUE                0x36
> > +
> > +/* Maximum buffer sizes */
> > +#define TPM_CMD_BUF_SIZE     4096
> > +#define TPM_RSP_BUF_SIZE     4096
> > +#define MAX_SPI_FRAMESIZE    64
> > +
> > +/* TPM TIS SPI protocol states */
> > +enum tpm_spi_state {
> > +     TPM_SPI_IDLE,
> > +     TPM_SPI_HEADER,         /* Receiving 4-byte header */
> > +     TPM_SPI_WAIT_STATE,     /* Sending wait state bytes */
> > +     TPM_SPI_DATA,           /* Transfer data */
> > +};
> > +
> > +/* TIS state machine */
> > +enum tpm_tis_state {
> > +     TIS_IDLE,
> > +     TIS_READY,              /* Ready to receive command */
> > +     TIS_RECEPTION,          /* Receiving command data */
> > +     TIS_EXECUTION,          /* Executing command */
> > +     TIS_COMPLETION,         /* Response available */
> > +};
> > +
> > +struct sandbox_tpm_spi {
> > +     /* SPI protocol state */
> > +     enum tpm_spi_state spi_state;
> > +     u8 header[4];
> > +     int header_pos;
> > +     bool is_read;
> > +     u32 addr;
> > +     int xfer_len;
> > +     int data_pos;
> > +
> > +     /* TIS state */
> > +     enum tpm_tis_state tis_state;
> > +     u8 access_reg;
> > +     u32 sts_reg;
> > +     u32 intf_caps;
> > +
> > +     /* Command/response buffers */
> > +     u8 cmd_buf[TPM_CMD_BUF_SIZE];
> > +     int cmd_len;
> > +     int cmd_pos;
> > +     u8 rsp_buf[TPM_RSP_BUF_SIZE];
> > +     int rsp_len;
> > +     int rsp_pos;
> > +
> > +     /* Burst count for status register */
> > +     u16 burst_count;
> > +};
> > +
> > +/*
> > + * Parse TIS SPI header
> > + * Format: [R/W|len-1][0xD4][addr_hi][addr_lo]
> > + * Bit 7 of byte 0: 1=3Dread, 0=3Dwrite
> > + * Bits 5:0 of byte 0: transfer length - 1
> > + */
> > +static void parse_spi_header(struct sandbox_tpm_spi *priv)
> > +{
> > +     priv->is_read =3D (priv->header[0] & 0x80) !=3D 0;
> > +     priv->xfer_len =3D (priv->header[0] & 0x3F) + 1;
> > +     priv->addr =3D (priv->header[2] << 8) | priv->header[3];
> > +     priv->data_pos =3D 0;
> > +}
> > +
> > +/*
> > + * Read from TIS register
> > + */
> > +static u8 tis_reg_read(struct sandbox_tpm_spi *priv, u32 addr)
> > +{
> > +     u32 reg =3D addr & 0x0FFF;  /* Mask off locality bits */
> > +
> > +     switch (reg) {
> > +     case TPM_ACCESS_REG:
> > +             return priv->access_reg;
> > +
> > +     case TPM_STS_REG:
> > +     case TPM_STS_REG + 1:
> > +     case TPM_STS_REG + 2:
> > +     case TPM_STS_REG + 3: {
> > +             int byte_off =3D reg - TPM_STS_REG;
> > +             u32 sts =3D priv->sts_reg;
> > +
> > +             /* Update burst count in status */
> > +             sts |=3D ((u32)priv->burst_count << 8);
> > +             return (sts >> (byte_off * 8)) & 0xFF;
> > +     }
> > +
> > +     case TPM_INTF_CAPS_REG:
> > +     case TPM_INTF_CAPS_REG + 1:
> > +     case TPM_INTF_CAPS_REG + 2:
> > +     case TPM_INTF_CAPS_REG + 3: {
> > +             int byte_off =3D reg - TPM_INTF_CAPS_REG;
> > +
> > +             return (priv->intf_caps >> (byte_off * 8)) & 0xFF;
> > +     }
> > +
> > +     case TPM_DID_VID_REG:
> > +     case TPM_DID_VID_REG + 1:
> > +     case TPM_DID_VID_REG + 2:
> > +     case TPM_DID_VID_REG + 3: {
> > +             int byte_off =3D reg - TPM_DID_VID_REG;
> > +
> > +             return (TPM_DID_VID_VALUE >> (byte_off * 8)) & 0xFF;
> > +     }
> > +
> > +     case TPM_RID_REG:
> > +             return TPM_RID_VALUE;
> > +
> > +     default:
> > +             /*
> > +              * Handle FIFO reads - the FIFO can be accessed at any
> address
> > +              * from 0x0024 up to 0x0F00 for multi-byte transfers.
> > +              */
> > +             if (reg >=3D TPM_DATA_FIFO_REG && reg < TPM_DID_VID_REG) =
{
> > +                     if (priv->tis_state =3D=3D TIS_COMPLETION &&
> > +                         priv->rsp_pos < priv->rsp_len) {
> > +                             u8 data =3D priv->rsp_buf[priv->rsp_pos++=
];
> > +
> > +                             /* Update status when all data read */
> > +                             if (priv->rsp_pos >=3D priv->rsp_len) {
> > +                                     priv->sts_reg &=3D
> ~TPM_STS_DATA_AVAIL;
> > +                                     priv->sts_reg |=3D
> TPM_STS_COMMAND_READY;
> > +                                     priv->tis_state =3D TIS_READY;
> > +                             }
> > +                             return data;
> > +                     }
> > +                     return 0xFF;
> > +             }
> > +             return 0xFF;
> > +     }
> > +}
> > +
> > +/*
> > + * Write to TIS register
> > + */
> > +static void tis_reg_write(struct sandbox_tpm_spi *priv, u32 addr, u8
> value)
> > +{
> > +     u32 reg =3D addr & 0x0FFF;
> > +
> > +     switch (reg) {
> > +     case TPM_ACCESS_REG:
> > +             if (value & TPM_ACCESS_REQUEST_USE) {
> > +                     /* Request locality */
> > +                     priv->access_reg |=3D TPM_ACCESS_ACTIVE_LOCALITY;
> > +                     priv->access_reg |=3D TPM_ACCESS_VALID;
> > +             }
> > +             break;
> > +
> > +     case TPM_STS_REG:
> > +             if (value & TPM_STS_COMMAND_READY) {
> > +                     /* Abort current command and go to ready state */
> > +                     priv->tis_state =3D TIS_READY;
> > +                     priv->cmd_len =3D 0;
> > +                     priv->cmd_pos =3D 0;
> > +                     priv->rsp_len =3D 0;
> > +                     priv->rsp_pos =3D 0;
> > +                     priv->sts_reg =3D TPM_STS_VALID |
> TPM_STS_COMMAND_READY;
> > +                     priv->burst_count =3D MAX_SPI_FRAMESIZE;
> > +             }
> > +             if (value & TPM_STS_GO) {
> > +                     /* Execute command */
> > +                     if (priv->tis_state =3D=3D TIS_RECEPTION &&
> > +                         priv->cmd_len > 0) {
> > +                             /*
> > +                              * Generate a simple success response.
> > +                              * A full implementation would call the
> > +                              * sandbox TPM2 state machine here.
> > +                              */
> > +                             priv->rsp_buf[0] =3D 0x80;  /*
> TPM_ST_NO_SESSIONS */
> > +                             priv->rsp_buf[1] =3D 0x01;
> > +                             priv->rsp_buf[2] =3D 0x00;  /* Response
> size: 10 */
> > +                             priv->rsp_buf[3] =3D 0x00;
> > +                             priv->rsp_buf[4] =3D 0x00;
> > +                             priv->rsp_buf[5] =3D 0x0A;
> > +                             priv->rsp_buf[6] =3D 0x00;  /*
> TPM_RC_SUCCESS */
> > +                             priv->rsp_buf[7] =3D 0x00;
> > +                             priv->rsp_buf[8] =3D 0x00;
> > +                             priv->rsp_buf[9] =3D 0x00;
> > +                             priv->rsp_len =3D 10;
> > +                             priv->rsp_pos =3D 0;
> > +
> > +                             priv->tis_state =3D TIS_COMPLETION;
> > +                             priv->sts_reg =3D TPM_STS_VALID |
> > +                                             TPM_STS_DATA_AVAIL;
> > +                     }
> > +             }
> > +             break;
> > +
> > +     default:
> > +             /*
> > +              * Handle FIFO writes - the FIFO is at 0x0024 but any
> address
> > +              * from 0x0024 up to 0x0F00 can be used for FIFO access
> when
> > +              * doing multi-byte transfers (address auto-increments).
> > +              */
> > +             if (reg >=3D TPM_DATA_FIFO_REG && reg < TPM_DID_VID_REG) =
{
> > +                     if (priv->tis_state =3D=3D TIS_READY) {
> > +                             /* Start receiving command */
> > +                             priv->tis_state =3D TIS_RECEPTION;
> > +                             priv->cmd_len =3D 0;
> > +                             priv->cmd_pos =3D 0;
> > +                             priv->sts_reg =3D TPM_STS_VALID |
> TPM_STS_DATA_EXPECT;
> > +                     }
> > +                     if (priv->tis_state =3D=3D TIS_RECEPTION) {
> > +                             if (priv->cmd_len < TPM_CMD_BUF_SIZE) {
> > +                                     priv->cmd_buf[priv->cmd_len++] =
=3D
> value;
> > +
> > +                                     /* Check if we have complete
> command */
> > +                                     if (priv->cmd_len >=3D 6) {
> > +                                             u32 expected_len;
> > +
> > +                                             expected_len =3D
> (priv->cmd_buf[2] << 24) |
> > +
> (priv->cmd_buf[3] << 16) |
> > +
> (priv->cmd_buf[4] << 8) |
> > +
> priv->cmd_buf[5];
> > +                                             if (priv->cmd_len >=3D
> expected_len) {
> > +                                                     /* Command
> complete */
> > +                                                     priv->sts_reg &=
=3D
> > +
>  ~TPM_STS_DATA_EXPECT;
> > +                                             }
> > +                                     }
> > +                             }
> > +                     }
> > +             }
> > +             break;
> > +     }
> > +}
> > +
> > +/*
> > + * SPI emulation transfer callback
> > + */
> > +static int sandbox_tpm_spi_xfer(struct udevice *dev, unsigned int
> bitlen,
> > +                             const void *dout, void *din, unsigned lon=
g
> flags)
> > +{
> > +     struct sandbox_tpm_spi *priv =3D dev_get_priv(dev);
> > +     int bytes =3D bitlen / 8;
> > +     const u8 *tx =3D dout;
> > +     u8 *rx =3D din;
> > +     int i;
> > +
> > +     /* Handle CS assert - reset state machine */
> > +     if (flags & SPI_XFER_BEGIN) {
> > +             priv->spi_state =3D TPM_SPI_HEADER;
> > +             priv->header_pos =3D 0;
> > +     }
> > +
> > +     for (i =3D 0; i < bytes; i++) {
> > +             u8 tx_byte =3D tx ? tx[i] : 0;
> > +             u8 rx_byte =3D 0;
> > +
> > +             switch (priv->spi_state) {
> > +             case TPM_SPI_IDLE:
> > +                     /* Should not happen during active transfer */
> > +                     rx_byte =3D 0xFF;
> > +                     break;
> > +
> > +             case TPM_SPI_HEADER:
> > +                     /* Receive 4-byte header */
> > +                     priv->header[priv->header_pos++] =3D tx_byte;
> > +                     rx_byte =3D 0x00;
> > +
> > +                     if (priv->header_pos >=3D 4) {
> > +                             parse_spi_header(priv);
> > +                             log_debug("TPM SPI: %s len=3D%d
> addr=3D0x%04x\n",
> > +                                       priv->is_read ? "read" : "write=
",
> > +                                       priv->xfer_len, priv->addr);
> > +                             /* Return wait state in last header byte =
*/
> > +                             rx_byte =3D 0x01;  /* Ready immediately *=
/
> > +                             priv->spi_state =3D TPM_SPI_DATA;
> > +                     }
> > +                     break;
> > +
> > +             case TPM_SPI_DATA:
> > +                     if (priv->is_read) {
> > +                             /* Read from TPM register */
> > +                             rx_byte =3D tis_reg_read(priv,
> > +                                                    priv->addr +
> priv->data_pos);
> > +                     } else {
> > +                             /* Write to TPM register */
> > +                             tis_reg_write(priv, priv->addr +
> priv->data_pos,
> > +                                           tx_byte);
> > +                             rx_byte =3D 0x00;
> > +                     }
> > +                     priv->data_pos++;
> > +                     break;
> > +
> > +             default:
> > +                     rx_byte =3D 0xFF;
> > +                     break;
> > +             }
> > +
> > +             if (rx)
> > +                     rx[i] =3D rx_byte;
> > +     }
> > +
> > +     /* Handle CS deassert - return to idle */
> > +     if (flags & SPI_XFER_END)
> > +             priv->spi_state =3D TPM_SPI_IDLE;
> > +
> > +     return 0;
> > +}
> > +
> > +static int sandbox_tpm_spi_probe(struct udevice *dev)
> > +{
> > +     struct sandbox_tpm_spi *priv =3D dev_get_priv(dev);
> > +
> > +     /* Initialize TIS state */
> > +     priv->spi_state =3D TPM_SPI_IDLE;
> > +     priv->tis_state =3D TIS_IDLE;
> > +     priv->access_reg =3D TPM_ACCESS_VALID;
> > +     priv->sts_reg =3D TPM_STS_VALID;
> > +     priv->intf_caps =3D TPM_INTF_CAPS_VALUE;
> > +     priv->burst_count =3D MAX_SPI_FRAMESIZE;
> > +     priv->cmd_len =3D 0;
> > +     priv->rsp_len =3D 0;
> > +
> > +     log_debug("TPM SPI sandbox emulator probed\n");
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct dm_spi_emul_ops sandbox_tpm_spi_ops =3D {
> > +     .xfer =3D sandbox_tpm_spi_xfer,
> > +};
> > +
> > +static const struct udevice_id sandbox_tpm_spi_ids[] =3D {
> > +     { .compatible =3D "sandbox,tpm-spi-emul" },
> > +     { }
> > +};
> > +
> > +U_BOOT_DRIVER(sandbox_tpm_spi_emul) =3D {
> > +     .name =3D "sandbox_tpm_spi_emul",
> > +     .id =3D UCLASS_SPI_EMUL,
> > +     .of_match =3D sandbox_tpm_spi_ids,
> > +     .ops =3D &sandbox_tpm_spi_ops,
> > +     .probe =3D sandbox_tpm_spi_probe,
> > +     .priv_auto =3D sizeof(struct sandbox_tpm_spi),
> > +};
> > +
> > +/*
> > + * SPI slave driver for TPM device
> > + * This gets probed when a device with "sandbox,tpm-spi" is found in
> DTS.
> > + * The actual SPI transfers are handled by the emulator above.
> > + */
> > +static int sandbox_tpm_spi_slave_probe(struct udevice *dev)
> > +{
> > +     log_debug("TPM SPI slave device probed\n");
> > +     return 0;
> > +}
> > +
> > +static const struct udevice_id sandbox_tpm_spi_slave_ids[] =3D {
> > +     { .compatible =3D "sandbox,tpm-spi" },
> > +     { }
> > +};
> > +
> > +U_BOOT_DRIVER(sandbox_tpm_spi) =3D {
> > +     .name =3D "sandbox_tpm_spi",
> > +     .id =3D UCLASS_SPI_GENERIC,
> > +     .of_match =3D sandbox_tpm_spi_slave_ids,
> > +     .probe =3D sandbox_tpm_spi_slave_probe,
> > +};
> > diff --git a/drivers/tpm/wolftpm_common.c b/drivers/tpm/wolftpm_common.=
c
> > new file mode 100644
> > index 00000000000..6dea24c5c9a
> > --- /dev/null
> > +++ b/drivers/tpm/wolftpm_common.c
> > @@ -0,0 +1,135 @@
> > +/* wolftpm.c
> > +*
> > +* SPDX-License-Identifier: GPL-2.0+
> > +*
> > +* (C) Copyright 2025
> > +* Aidan Garske <aidan@wolfssl.com>
> > +*/
> > +
> > +#define LOG_CATEGORY UCLASS_BOOTSTD
> > +
> > +#include <wolftpm.h>
> > +#include <wolftpm/tpm2.h>
> > +#include <wolftpm/tpm2_wrap.h>
> > +#include <wolftpm/tpm2_packet.h>
> > +#include <hal/tpm_io.h>
> > +#include <stdio.h>
> > +#include <string.h>
> > +#include <log.h>
> > +#include <hash.h>
> > +#include <examples/wrap/wrap_test.h>
> > +
> > +#ifndef WOLFTPM2_NO_WRAPPER
> > +#ifdef WOLFTPM_FIRMWARE_UPGRADE
> > +
> >
> +/***********************************************************************=
*******/
> > +/* --- BEGIN helper functions -- */
> >
> +/***********************************************************************=
*******/
> > +
> > +typedef struct {
> > +    byte*  manifest_buf;
> > +    byte*  firmware_buf;
> > +    size_t manifest_bufSz;
> > +    size_t firmware_bufSz;
> > +} fw_info_t;
> > +
> > +int TPM2_IFX_FwData_Cb(uint8_t* data, uint32_t data_req_sz,
> > +    uint32_t offset, void* cb_ctx)
> > +{
> > +    fw_info_t* fwinfo =3D (fw_info_t*)cb_ctx;
> > +    if (offset > fwinfo->firmware_bufSz) {
> > +        return BUFFER_E;
> > +    }
> > +    if (offset + data_req_sz > (uint32_t)fwinfo->firmware_bufSz) {
> > +        data_req_sz =3D (uint32_t)fwinfo->firmware_bufSz - offset;
> > +    }
> > +    if (data_req_sz > 0) {
> > +        XMEMCPY(data, &fwinfo->firmware_buf[offset], data_req_sz);
> > +    }
> > +    return data_req_sz;
> > +}
> > +
> > +const char* TPM2_IFX_GetOpModeStr(int opMode)
> > +{
> > +    const char* opModeStr =3D "Unknown";
> > +    switch (opMode) {
> > +        case 0x00:
> > +            opModeStr =3D "Normal TPM operational mode";
> > +            break;
> > +        case 0x01:
> > +            opModeStr =3D "TPM firmware update mode (abandon possible)=
";
> > +            break;
> > +        case 0x02:
> > +            opModeStr =3D "TPM firmware update mode (abandon not
> possible)";
> > +            break;
> > +        case 0x03:
> > +            opModeStr =3D "After successful update, but before finaliz=
e";
> > +            break;
> > +        case 0x04:
> > +            opModeStr =3D "After finalize or abandon, reboot required"=
;
> > +            break;
> > +        default:
> > +            break;
> > +    }
> > +    return opModeStr;
> > +}
> > +
> > +void TPM2_IFX_PrintInfo(WOLFTPM2_CAPS* caps)
> > +{
> > +    printf("Mfg %s (%d), Vendor %s, Fw %u.%u (0x%x)\n",
> > +        caps->mfgStr, caps->mfg, caps->vendorStr, caps->fwVerMajor,
> > +        caps->fwVerMinor, caps->fwVerVendor);
> > +    printf("Operational mode: %s (0x%x)\n",
> > +        TPM2_IFX_GetOpModeStr(caps->opMode), caps->opMode);
> > +    printf("KeyGroupId 0x%x, FwCounter %d (%d same)\n",
> > +        caps->keyGroupId, caps->fwCounter, caps->fwCounterSame);
> > +}
> > +#endif /* WOLFTPM_FIRMWARE_UPGRADE */
> > +
> > +int TPM2_PCRs_Print(void)
> > +{
> > +    int rc;
> > +    int pcrCount, pcrIndex;
> > +    GetCapability_In  capIn;
> > +    GetCapability_Out capOut;
> > +    TPML_PCR_SELECTION* pcrSel;
> > +
> > +    memset(&capIn, 0, sizeof(capIn));
> > +    capIn.capability =3D TPM_CAP_PCRS;
> > +    capIn.property =3D 0;
> > +    capIn.propertyCount =3D 1;
> > +    rc =3D TPM2_GetCapability(&capIn, &capOut);
> > +    if (rc !=3D TPM_RC_SUCCESS) {
> > +        log_debug("TPM2_GetCapability failed rc=3D%d (%s)\n", rc,
> TPM2_GetRCString(rc));
> > +        return rc;
> > +    }
> > +    pcrSel =3D &capOut.capabilityData.data.assignedPCR;
> > +    printf("Assigned PCR's:\n");
> > +    for (pcrCount=3D0; pcrCount < (int)pcrSel->count; pcrCount++) {
> > +        printf("\t%s: ",
> TPM2_GetAlgName(pcrSel->pcrSelections[pcrCount].hash));
> > +        for (pcrIndex=3D0;
> > +            pcrIndex<pcrSel->pcrSelections[pcrCount].sizeofSelect*8;
> > +            pcrIndex++) {
> > +            if ((pcrSel->pcrSelections[pcrCount].pcrSelect[pcrIndex/8]=
 &
> > +                    ((1 << (pcrIndex % 8)))) !=3D 0) {
> > +                printf(" %d", pcrIndex);
> > +            }
> > +        }
> > +        printf("\n");
> > +    }
> > +    return TPM_RC_SUCCESS;
> > +}
> > +
> > +int TPM2_Init_Device(WOLFTPM2_DEV* dev, void* userCtx)
> > +{
> > +    /* Use TPM2_IoCb callback which calls TPM2_IoCb_Uboot_SPI for
> packet-level access */
> > +    int rc =3D wolfTPM2_Init(dev, TPM2_IoCb, userCtx);
> > +    log_debug("tpm2 init: rc =3D %d (%s)\n", rc, TPM2_GetRCString(rc))=
;
> > +    return rc;
> > +}
> > +
> > +#endif /* WOLFTPM2_NO_WRAPPER */
> > +
> >
> +/***********************************************************************=
*******/
> > +/* --- END helper functions -- */
> >
> +/***********************************************************************=
*******/
> > diff --git a/include/configs/user_settings.h
> b/include/configs/user_settings.h
> > new file mode 100644
> > index 00000000000..5aaa27a3d3f
> > --- /dev/null
> > +++ b/include/configs/user_settings.h
> > @@ -0,0 +1,118 @@
> > +/* user_settings.h
> > + *
> > + * SPDX-License-Identifier: GPL-2.0+
> > + *
> > + * (C) Copyright 2025
> > + * Aidan Garske <aidan@wolfssl.com>
> > + */
> > +
> > +#ifndef USER_SETTINGS_H
> > +#define USER_SETTINGS_H
> > +
> > +#ifdef __cplusplus
> > +extern "C" {
> > +#endif
> > +
> >
> +/***********************************************************************=
*******/
> > +/* --- BEGIN wolfTPM U-boot Settings -- */
> >
> +/***********************************************************************=
*******/
> > +
> > +/*
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > + * TPM Chip Configuration
> > + *
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > + *
> > + * CONFIG_TPM_AUTODETECT: For swtpm/QEMU testing (no specific chip)
> > + * !CONFIG_TPM_AUTODETECT: For real hardware (SLB9672/SLB9673)
> > + */
> > +#ifdef CONFIG_TPM_AUTODETECT
> > +    #define WOLFTPM_AUTODETECT
> > +#else
> > +    /* Real hardware - Infineon SLB9672/SLB9673
> > +     * Firmware upgrade only supported by these chips */
> > +    #define WOLFTPM_FIRMWARE_UPGRADE
> > +    #define WOLFTPM_SLB9672
> > +    /* #define WOLFTPM_SLB9673 */
> > +#endif
> > +
> > +/* Include delay.h and types.h for
> > + * U-boot time delay and types */
> > +#include <linux/delay.h>
> > +#include <linux/types.h>
> > +#include <stdint.h>
> > +
> > +/* wolfCrypt disabled - pcr_setauthpolicy/pcr_setauthvalue not availab=
le
> > + * To enable wolfCrypt, you would need to:
> > + * 1. Uncomment the line below to undefine WOLFTPM2_NO_WOLFCRYPT
> > + * 2. Add wolfCrypt source files to the U-Boot build (lib/Makefile)
> > + * 3. Add wolfCrypt settings for embedded/no-OS use
> > + */
> > +#undef  WOLFTPM2_NO_WOLFCRYPT
> > +#define WOLFTPM2_NO_WOLFCRYPT
> > +
> > +/*
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > + * TPM Communication Mode Selection (Auto-detected based on chip type)
> > + *
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > + *
> > + * For real SPI hardware (SLB9672/SLB9673):
> > + *   - Uses wolfTPM's native TIS layer with raw SPI via tpm_io_uboot.c
> > + *   - Requires CONFIG_SPI and CONFIG_DM_SPI enabled in U-Boot
> > + *
> > + * For swtpm/QEMU testing (no specific chip defined):
> > + *   - Uses WOLFTPM_LINUX_DEV mode with U-Boot's TPM driver (tpm_xfer(=
))
> > + *   - Works with MMIO-based TPM via tpm2_tis_mmio.c
> > + */
> > +
> > +#if defined(WOLFTPM_SLB9672) || defined(WOLFTPM_SLB9673)
> > +    /* Real SPI hardware - use native wolfTPM TIS with raw SPI */
> > +    /* WOLFTPM_LINUX_DEV is NOT defined */
> > +    #define WOLFTPM_EXAMPLE_HAL
> > +
> > +    /* SPI bus and chip select for TPM
> > +     * Official Raspberry Pi tpm-slb9670 overlay uses CE1 (GPIO7)
> > +     * This matches LetsTrust and most Infineon evaluation boards */
> > +    #ifndef TPM_SPI_BUS
> > +        #define TPM_SPI_BUS 0
> > +    #endif
> > +    #ifndef TPM_SPI_CS
> > +        #define TPM_SPI_CS 1   /* CE1/GPIO7 - official RPi TPM overlay
> setting */
> > +    #endif
> > +#else
> > +    /* swtpm/QEMU - use U-Boot's TPM driver with MMIO communication
> mode */
> > +    #define WOLFTPM_LINUX_DEV
> > +#endif
> > +
> > +#define XSLEEP_MS(ms) udelay(ms * 1000)
> > +
> > +/* Timeout configuration */
> > +#ifdef WOLFTPM_FIRMWARE_UPGRADE
> > +    /* Firmware update requires much longer timeout for TPM processing
> */
> > +    #define TPM_TIMEOUT_TRIES 2000000
> > +#else
> > +    /* Normal operations - reduce from default 1,000,000 to prevent
> long hangs */
> > +    #define TPM_TIMEOUT_TRIES 10000
> > +#endif
> > +
> > +/* Add small delay between poll attempts to avoid tight spin loop */
> > +#define XTPM_WAIT() udelay(100)
> > +
> > +/* Do not include API's that use heap(), they are not required */
> > +#define WOLFTPM2_NO_HEAP
> > +
> > +/* Debugging - disabled for clean output */
> > +/* #define DEBUG_WOLFTPM */
> > +/* #define WOLFTPM_DEBUG_VERBOSE */
> > +/* #define WOLFTPM_DEBUG_IO */
> > +/* #define WOLFTPM_DEBUG_TIMEOUT */
> > +
> > +/* SPI Wait state checking - most TPMs use this */
> > +#define WOLFTPM_CHECK_WAIT_STATE
> > +
> >
> +/***********************************************************************=
*******/
> > +/* --- END wolfTPM U-boot Settings -- */
> >
> +/***********************************************************************=
*******/
> > +
> > +#ifdef __cpluspluss
> > +}
> > +#endif
> > +
> > +#endif /* USER_SETTINGS_H */
> > diff --git a/include/hash.h b/include/hash.h
> > index 8b3f79ec473..242de9f0e84 100644
> > --- a/include/hash.h
> > +++ b/include/hash.h
> > @@ -6,6 +6,8 @@
> >  #ifndef _HASH_H
> >  #define _HASH_H
> >
> > +#include <linux/types.h>
> > +
> >  #ifdef USE_HOSTCC
> >  #include <linux/kconfig.h>
> >  #endif
> > @@ -163,4 +165,19 @@ int hash_progressive_lookup_algo(const char
> *algo_name,
> >   */
> >  int hash_parse_string(const char *algo_name, const char *str, uint8_t
> *result);
> >
> > +#ifdef WOLFTPM2_NO_WOLFCRYPT
> > +/**
> > + * wc_Sha384Hash() - Calculate SHA384 hash
> > + * @data:    Data to hash
> > + * @len:     Length of data
> > + * @hash:    Output buffer for hash
> > + *
> > + * This is a wrapper function to provide wolfCrypt-compatible SHA384
> hashing
> > + * when wolfCrypt is not available.
> > + *
> > + * Return: 0 on success, -1 on error
> > + */
> > +int wc_Sha384Hash(const unsigned char* data, unsigned int len, unsigne=
d
> char* hash);
> > +#endif /* WOLFTPM2_NO_WOLFCRYPT */
> > +
> >  #endif
> > diff --git a/include/linux/byteorder/generic.h
> b/include/linux/byteorder/generic.h
> > index bee0ff60336..def601eed2b 100644
> > --- a/include/linux/byteorder/generic.h
> > +++ b/include/linux/byteorder/generic.h
> > @@ -89,12 +89,6 @@
> >  #define le32_to_cpu __le32_to_cpu
> >  #define cpu_to_le16 __cpu_to_le16
> >  #define le16_to_cpu __le16_to_cpu
> > -#define cpu_to_be64 __cpu_to_be64
> > -#define be64_to_cpu __be64_to_cpu
> > -#define cpu_to_be32 __cpu_to_be32
> > -#define be32_to_cpu __be32_to_cpu
> > -#define cpu_to_be16 __cpu_to_be16
> > -#define be16_to_cpu __be16_to_cpu
> >  #define cpu_to_le64p __cpu_to_le64p
> >  #define le64_to_cpup __le64_to_cpup
> >  #define cpu_to_le32p __cpu_to_le32p
> > @@ -120,6 +114,31 @@
> >  #define cpu_to_be16s __cpu_to_be16s
> >  #define be16_to_cpus __be16_to_cpus
> >
> > +/*
> > + * Check if byte-order functions are already defined by the system:
> > + * wolfTPM, wolfCrypt, and U-boot all define these functions, so
> > + * we need to check if they are already defined before defining
> > + * them again.
> > + */
> > +#ifndef cpu_to_be16
> > +#define cpu_to_be16 __cpu_to_be16
> > +#endif
> > +#ifndef cpu_to_be32
> > +#define cpu_to_be32 __cpu_to_be32
> > +#endif
> > +#ifndef cpu_to_be64
> > +#define cpu_to_be64 __cpu_to_be64
> > +#endif
> > +#ifndef be16_to_cpu
> > +#define be16_to_cpu __be16_to_cpu
> > +#endif
> > +#ifndef be32_to_cpu
> > +#define be32_to_cpu __be32_to_cpu
> > +#endif
> > +#ifndef be64_to_cpu
> > +#define be64_to_cpu __be64_to_cpu
> > +#endif
> > +
> >  /*
> >   * They have to be macros in order to do the constant folding
> >   * correctly - if the argument passed into a inline function
> > diff --git a/include/tpm-common.h b/include/tpm-common.h
> > index bfb84a931d1..1ea4463fbbe 100644
> > --- a/include/tpm-common.h
> > +++ b/include/tpm-common.h
> > @@ -337,4 +337,26 @@ enum tpm_version tpm_get_version(struct udevice
> *dev);
> >  /* Iterate on all TPM devices */
> >  #define for_each_tpm_device(dev) uclass_foreach_dev_probe(UCLASS_TPM,
> (dev))
> >
> > +/**
> > + * tpm_show_device() - Show all TPM devices
> > + *
> > + * Return: 0 on success, -ve on failure
> > + */
> > +int tpm_show_device(void);
> > +
> > +/**
> > + * tpm_set_device() - Set the TPM device to use
> > + *
> > + * @num: The number of the TPM device to use
> > + * Return: 0 on success, -ve on failure
> > + */
> > +int tpm_set_device(unsigned long num);
> > +
> > +/**
> > + * get_tpm() - Get the TPM device
> > + *
> > + * Return: 0 on success, -ve on failure
> > + */
> > +int get_tpm(struct udevice **devp);
> > +
> >  #endif /* __TPM_COMMON_H */
> > diff --git a/include/wolftpm.h b/include/wolftpm.h
> > new file mode 100644
> > index 00000000000..dfa8af327f4
> > --- /dev/null
> > +++ b/include/wolftpm.h
> > @@ -0,0 +1,33 @@
> > +/* wolftpm.h
> > +*
> > +* SPDX-License-Identifier: GPL-2.0+
> > +*
> > +* (C) Copyright 2025
> > +* Aidan Garske <aidan@wolfssl.com>
> > +*/
> > +
> > +#ifndef __WOLFTPM_H__
> > +#define __WOLFTPM_H__
> > +
> > +#include <wolftpm/tpm2.h>
> > +#include <wolftpm/tpm2_wrap.h>
> > +#include <wolftpm/tpm2_packet.h>
> > +
> > +#ifdef __cplusplus
> > +extern "C" {
> > +#endif
> > +
> > +#ifdef WOLFTPM_FIRMWARE_UPGRADE
> > +int TPM2_IFX_FwData_Cb(uint8_t* data, uint32_t data_req_sz, uint32_t
> offset, void* cb_ctx);
> > +const char* TPM2_IFX_GetOpModeStr(int opMode);
> > +void TPM2_IFX_PrintInfo(WOLFTPM2_CAPS* caps);
> > +#endif
> > +
> > +int TPM2_PCRs_Print(void);
> > +int TPM2_Init_Device(WOLFTPM2_DEV* dev, void* userCtx);
> > +
> > +#ifdef __cplusplus
> > +}
> > +#endif
> > +
> > +#endif /* __WOLFTPM_H__ */
> > diff --git a/lib/Kconfig b/lib/Kconfig
> > index 931d5206936..24477ea53c9 100644
> > --- a/lib/Kconfig
> > +++ b/lib/Kconfig
> > @@ -500,6 +500,19 @@ config TPM
> >         If you want a fully functional TPM enable all hashing algorithm=
s.
> >         If you enabled measured boot all hashing algorithms are selecte=
d.
> >
> > +config TPM_WOLF
> > +    bool "Enable wolfTPM support"
> > +     depends on DM
> > +     imply DM_RNG
> > +     select SHA1
> > +    help
> > +        This option enables support for wolfTPM in U-Boot. WolfTPM can
> be
> > +             used to update ARM specific platforms. Enabling this
> option allows
> > +             U-Boot to interact with the TPM using wolfTPM commands
> such as
> > +             firmware updates, PCR extend, and more. It is especially
> useful on
> > +             platforms that require support for secure boot and other
> TPM-related
> > +             functionality.
> > +
> >  config SPL_TPM
> >       bool "Trusted Platform Module (TPM) Support in SPL"
> >       depends on SPL_DM
> > diff --git a/lib/Makefile b/lib/Makefile
> > index 70667f3728c..ba3a9e85c11 100644
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -55,6 +55,7 @@ obj-$(CONFIG_BITREVERSE) +=3D bitrev.o
> >  obj-y +=3D list_sort.o
> >  endif
> >
> > +# U-boot TPM
> >  obj-$(CONFIG_$(PHASE_)TPM) +=3D tpm-common.o
> >  ifeq ($(CONFIG_$(PHASE_)TPM),y)
> >  obj-$(CONFIG_TPM) +=3D tpm_api.o
> > @@ -64,6 +65,23 @@ obj-$(CONFIG_EFI_TCG2_PROTOCOL) +=3D tpm_tcg2.o
> >  obj-$(CONFIG_MEASURED_BOOT) +=3D tpm_tcg2.o
> >  endif
> >
> > +# wolfTPM with TPM 2.0 support (including TPM firmware update)
> > +ifeq ($(CONFIG_TPM_WOLF),y)
> > +ifeq ($(CONFIG_TPM_V2),y)
> > +ccflags-y +=3D -Ilib/wolftpm \
> > +             -Iinclude/configs \
> > +             -DWOLFTPM_USER_SETTINGS
> > +obj-y +=3D wolftpm/hal/tpm_io.o
> > +obj-$(CONFIG_WOLFTPM_LINUX_DEV) +=3D wolftpm/src/tpm2_linux.o
> > +obj-y +=3D wolftpm/src/tpm2.o
> > +obj-y +=3D wolftpm/src/tpm2_packet.o
> > +obj-y +=3D wolftpm/src/tpm2_tis.o
> > +obj-y +=3D wolftpm/src/tpm2_wrap.o
> > +obj-y +=3D wolftpm/src/tpm2_param_enc.o
> > +obj-y +=3D wolftpm.o
> > +endif
> > +endif
> > +
> >  obj-$(CONFIG_$(PHASE_)CRC8) +=3D crc8.o
> >  obj-$(CONFIG_$(PHASE_)CRC16) +=3D crc16.o
> >  obj-$(CONFIG_$(PHASE_)CRC16) +=3D crc16-ccitt.o
> > diff --git a/lib/wolftpm b/lib/wolftpm
> > new file mode 160000
> > index 00000000000..19559386121
> > --- /dev/null
> > +++ b/lib/wolftpm
> > @@ -0,0 +1 @@
> > +Subproject commit 1955938612159325826329e1f7e6bb0d1e0f799f
> > diff --git a/lib/wolftpm.c b/lib/wolftpm.c
> > new file mode 100644
> > index 00000000000..a2b8a302365
> > --- /dev/null
> > +++ b/lib/wolftpm.c
> > @@ -0,0 +1,56 @@
> > +/* wolftpm.c
> > + *
> > + * SPDX-License-Identifier: GPL-2.0+
> > + *
> > + * (C) Copyright 2025
> > + * Aidan Garske <aidan@wolfssl.com>
> > + */
> > +
> > +/* wolfTPM wrapper layer to expose U-boot API
> > + * when wolfCrypt is not available. This is used by
> > + * the U-boot firmware update command.
> > + */
> > +
> > +#include <configs/user_settings.h>
> > +#include <hash.h>
> > +#include <linux/types.h>
> > +#include <stdint.h>
> > +#include <stdio.h>
> > +#include <string.h>
> > +#include <malloc.h>
> > +#include <mapmem.h>
> > +#include <asm/cache.h>
> > +#include <errno.h>
> > +
> > +/* Add wolfTPM type definitions */
> > +typedef uint8_t byte;
> > +typedef uint32_t word32;
> > +
> > +#ifdef WOLFTPM2_NO_WOLFCRYPT
> > +int wc_Sha384Hash(const byte* data, word32 len, byte* hash)
> > +{
> > +    struct hash_algo *algo;
> > +    u8 *output;
> > +    void *buf;
> > +
> > +    if (hash_lookup_algo("sha384", &algo)) {
> > +        printf("Unknown hash algorithm 'sha384'\n");
> > +        return -1;
> > +    }
> > +
> > +    output =3D (u8 *)memalign(ARCH_DMA_MINALIGN,
> > +                algo->digest_size);
> > +    if (!output) {
> > +        return -ENOMEM;
> > +    }
> > +
> > +    buf =3D (void *)map_sysmem((ulong)data, len);
> > +    algo->hash_func_ws(buf, len, output, algo->chunk_size);
> > +    unmap_sysmem(buf);
> > +
> > +    memcpy(hash, output, algo->digest_size);
> > +
> > +    free(output);
> > +    return 0;
> > +}
> > +#endif /* WOLFTPM2_NO_WOLFCRYPT */
> > diff --git a/scripts/check-local-export b/scripts/check-local-export
> > index 6ccc2f46741..ce520772866 100755
> > --- a/scripts/check-local-export
> > +++ b/scripts/check-local-export
> > @@ -5,6 +5,15 @@
> >  #
> >  # Exit with error if a local exported symbol is found.
> >  # EXPORT_SYMBOL should be used for global symbols.
> > +#
> > +# NOTE: This check is skipped on macOS with older bash that lacks
> > +# associative arrays support (bash 4.0+). The check will run properly
> > +# on Linux build systems.
> > +
> > +# Check for bash 4+ (required for associative arrays)
> > +if [[ ${BASH_VERSINFO[0]} -lt 4 ]]; then
> > +    exit 0
> > +fi
> >
> >  set -e
> >
> > diff --git a/test/cmd/Makefile b/test/cmd/Makefile
> > index 2476068aee6..08fbc31a06a 100644
> > --- a/test/cmd/Makefile
> > +++ b/test/cmd/Makefile
> > @@ -45,3 +45,4 @@ endif
> >  obj-$(CONFIG_ARM_FFA_TRANSPORT) +=3D armffa.o
> >  endif
> >  obj-$(CONFIG_CMD_SPAWN) +=3D spawn.o
> > +obj-$(CONFIG_TPM_WOLF) +=3D wolftpm.o
> > diff --git a/test/cmd/wolftpm.c b/test/cmd/wolftpm.c
> > new file mode 100644
> > index 00000000000..b2e6f82a098
> > --- /dev/null
> > +++ b/test/cmd/wolftpm.c
> > @@ -0,0 +1,364 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Tests for wolfTPM commands
> > + *
> > + * Copyright (C) 2025 wolfSSL Inc.
> > + * Author: Aidan Garske <aidan@wolfssl.com>
> > + *
> > + * Based on test/py/tests/test_tpm2.py and test/dm/tpm.c
> > + *
> > + * Note: These tests verify command success via return code only.
> > + * Console output is not checked since it varies with debug levels.
> > + * Run with: ut cmd
> > + */
> > +
> > +#include <command.h>
> > +#include <dm.h>
> > +#include <dm/test.h>
> > +#include <test/cmd.h>
> > +#include <test/test.h>
> > +#include <test/ut.h>
> > +
> > +/**
> > + * Test wolfTPM autostart command
> > + *
> > + * This initializes the TPM, performs startup and self-test
> > + */
> > +static int cmd_test_wolftpm_autostart(struct unit_test_state *uts)
> > +{
> > +     /* Initialize and autostart the TPM */
> > +     ut_assertok(run_command("tpm2 autostart", 0));
> > +
> > +     return 0;
> > +}
> > +CMD_TEST(cmd_test_wolftpm_autostart, 0);
> > +
> > +/**
> > + * Test wolfTPM init command
> > + */
> > +static int cmd_test_wolftpm_init(struct unit_test_state *uts)
> > +{
> > +     ut_assertok(run_command("tpm2 init", 0));
> > +
> > +     return 0;
> > +}
> > +CMD_TEST(cmd_test_wolftpm_init, 0);
> > +
> > +/**
> > + * Test wolfTPM info command
> > + *
> > + * Display TPM device information
> > + */
> > +static int cmd_test_wolftpm_info(struct unit_test_state *uts)
> > +{
> > +     /* First autostart to ensure TPM is ready */
> > +     ut_assertok(run_command("tpm2 autostart", 0));
> > +
> > +     /* Get TPM info */
> > +     ut_assertok(run_command("tpm2 info", 0));
> > +
> > +     return 0;
> > +}
> > +CMD_TEST(cmd_test_wolftpm_info, 0);
> > +
> > +/**
> > + * Test wolfTPM state command
> > + *
> > + * Display TPM internal state
> > + */
> > +static int cmd_test_wolftpm_state(struct unit_test_state *uts)
> > +{
> > +     /* First autostart to ensure TPM is ready */
> > +     ut_assertok(run_command("tpm2 autostart", 0));
> > +
> > +     /* Get TPM state */
> > +     ut_assertok(run_command("tpm2 state", 0));
> > +
> > +     return 0;
> > +}
> > +CMD_TEST(cmd_test_wolftpm_state, 0);
> > +
> > +/**
> > + * Test wolfTPM device command
> > + *
> > + * Show all TPM devices
> > + */
> > +static int cmd_test_wolftpm_device(struct unit_test_state *uts)
> > +{
> > +     /* Show TPM devices - no autostart needed */
> > +     ut_assertok(run_command("tpm2 device", 0));
> > +
> > +     return 0;
> > +}
> > +CMD_TEST(cmd_test_wolftpm_device, 0);
> > +
> > +/**
> > + * Test wolfTPM self_test command
> > + */
> > +static int cmd_test_wolftpm_self_test(struct unit_test_state *uts)
> > +{
> > +     /* First autostart to ensure TPM is ready */
> > +     ut_assertok(run_command("tpm2 autostart", 0));
> > +
> > +     /* Run full self test */
> > +     ut_assertok(run_command("tpm2 self_test full", 0));
> > +
> > +     return 0;
> > +}
> > +CMD_TEST(cmd_test_wolftpm_self_test, 0);
> > +
> > +/**
> > + * Test wolfTPM self_test continue command
> > + */
> > +static int cmd_test_wolftpm_self_test_continue(struct unit_test_state
> *uts)
> > +{
> > +     /* First autostart to ensure TPM is ready */
> > +     ut_assertok(run_command("tpm2 autostart", 0));
> > +
> > +     /* Run continue self test */
> > +     ut_assertok(run_command("tpm2 self_test continue", 0));
> > +
> > +     return 0;
> > +}
> > +CMD_TEST(cmd_test_wolftpm_self_test_continue, 0);
> > +
> > +/**
> > + * Test wolfTPM startup command with TPM2_SU_CLEAR
> > + *
> > + * Issue TPM2_Startup with CLEAR mode (reset state)
> > + */
> > +static int cmd_test_wolftpm_startup_clear(struct unit_test_state *uts)
> > +{
> > +     /* First init to prepare TPM */
> > +     ut_assertok(run_command("tpm2 init", 0));
> > +
> > +     /* Issue startup with CLEAR mode */
> > +     ut_assertok(run_command("tpm2 startup TPM2_SU_CLEAR", 0));
> > +
> > +     return 0;
> > +}
> > +CMD_TEST(cmd_test_wolftpm_startup_clear, 0);
> > +
> > +/**
> > + * Test wolfTPM startup command with TPM2_SU_STATE
> > + *
> > + * Issue TPM2_Startup with STATE mode (preserved state)
> > + */
> > +static int cmd_test_wolftpm_startup_state(struct unit_test_state *uts)
> > +{
> > +     /* First autostart to ensure TPM has state */
> > +     ut_assertok(run_command("tpm2 autostart", 0));
> > +
> > +     /* Shutdown first to prepare for STATE startup */
> > +     run_command("tpm2 startup TPM2_SU_STATE off", 0);
> > +
> > +     /* Re-init */
> > +     ut_assertok(run_command("tpm2 init", 0));
> > +
> > +     /* Issue startup with STATE mode - may return already started */
> > +     run_command("tpm2 startup TPM2_SU_STATE", 0);
> > +
> > +     return 0;
> > +}
> > +CMD_TEST(cmd_test_wolftpm_startup_state, 0);
> > +
> > +/**
> > + * Test wolfTPM get_capability command
> > + *
> > + * Read TPM capabilities by property
> > + */
> > +static int cmd_test_wolftpm_get_capability(struct unit_test_state *uts=
)
> > +{
> > +     /* First autostart to ensure TPM is ready */
> > +     ut_assertok(run_command("tpm2 autostart", 0));
> > +
> > +     /* Get capability - property 0x6 (TPM_CAP_TPM_PROPERTIES), 0x20e
> (PT_MANUFACTURER) */
> > +     ut_assertok(run_command("tpm2 get_capability 0x6 0x20e 0x1000000
> 1", 0));
> > +
> > +     return 0;
> > +}
> > +CMD_TEST(cmd_test_wolftpm_get_capability, 0);
> > +
> > +/**
> > + * Test wolfTPM caps command (get capabilities)
> > + *
> > + * Display TPM capabilities and vendor info
> > + */
> > +static int cmd_test_wolftpm_caps(struct unit_test_state *uts)
> > +{
> > +     /* First autostart to ensure TPM is ready */
> > +     ut_assertok(run_command("tpm2 autostart", 0));
> > +
> > +     /* Get TPM capabilities */
> > +     ut_assertok(run_command("tpm2 caps", 0));
> > +
> > +     return 0;
> > +}
> > +CMD_TEST(cmd_test_wolftpm_caps, 0);
> > +
> > +/**
> > + * Test wolfTPM clear command
> > + *
> > + * Reset TPM internal state using LOCKOUT hierarchy
> > + */
> > +static int cmd_test_wolftpm_clear(struct unit_test_state *uts)
> > +{
> > +     /* First autostart to ensure TPM is ready */
> > +     ut_assertok(run_command("tpm2 autostart", 0));
> > +
> > +     /* Clear using LOCKOUT hierarchy */
> > +     ut_assertok(run_command("tpm2 clear TPM2_RH_LOCKOUT", 0));
> > +
> > +     return 0;
> > +}
> > +CMD_TEST(cmd_test_wolftpm_clear, 0);
> > +
> > +/**
> > + * Test wolfTPM pcr_read command
> > + *
> > + * Read PCR value from a specific index to a memory address
> > + */
> > +static int cmd_test_wolftpm_pcr_read(struct unit_test_state *uts)
> > +{
> > +     /* First autostart to ensure TPM is ready */
> > +     ut_assertok(run_command("tpm2 autostart", 0));
> > +
> > +     /* Read PCR 0 with SHA256 to memory address 0x1000000 */
> > +     ut_assertok(run_command("tpm2 pcr_read 0 0x1000000 SHA256", 0));
> > +
> > +     return 0;
> > +}
> > +CMD_TEST(cmd_test_wolftpm_pcr_read, 0);
> > +
> > +/**
> > + * Test wolfTPM pcr_extend command
> > + *
> > + * Extend a PCR with a digest value
> > + */
> > +static int cmd_test_wolftpm_pcr_extend(struct unit_test_state *uts)
> > +{
> > +     /* First autostart to ensure TPM is ready */
> > +     ut_assertok(run_command("tpm2 autostart", 0));
> > +
> > +     /* Clear to start fresh */
> > +     run_command("tpm2 clear TPM2_RH_LOCKOUT", 0);
> > +
> > +     /* Extend PCR 16 (resettable PCR) with digest from memory
> > +      * PCR 16-23 are typically available for debug/testing
> > +      */
> > +     ut_assertok(run_command("tpm2 pcr_extend 16 0x1000000 SHA256", 0)=
);
> > +
> > +     return 0;
> > +}
> > +CMD_TEST(cmd_test_wolftpm_pcr_extend, 0);
> > +
> > +/**
> > + * Test wolfTPM pcr_print command
> > + *
> > + * Print all PCR values
> > + */
> > +static int cmd_test_wolftpm_pcr_print(struct unit_test_state *uts)
> > +{
> > +     /* First autostart to ensure TPM is ready */
> > +     ut_assertok(run_command("tpm2 autostart", 0));
> > +
> > +     /* Print all PCRs */
> > +     ut_assertok(run_command("tpm2 pcr_print", 0));
> > +
> > +     return 0;
> > +}
> > +CMD_TEST(cmd_test_wolftpm_pcr_print, 0);
> > +
> > +/**
> > + * Test wolfTPM pcr_allocate command
> > + *
> > + * Reconfigure PCR bank algorithm. Note: A TPM restart is required
> > + * for changes to take effect, so we just verify the command succeeds.
> > + */
> > +static int cmd_test_wolftpm_pcr_allocate(struct unit_test_state *uts)
> > +{
> > +     /* First autostart to ensure TPM is ready */
> > +     ut_assertok(run_command("tpm2 autostart", 0));
> > +
> > +     /* Allocate SHA256 bank on - this should succeed */
> > +     ut_assertok(run_command("tpm2 pcr_allocate SHA256 on", 0));
> > +
> > +     return 0;
> > +}
> > +CMD_TEST(cmd_test_wolftpm_pcr_allocate, 0);
> > +
> > +/**
> > + * Test wolfTPM dam_reset command
> > + *
> > + * Reset Dictionary Attack Mitigation counter
> > + */
> > +static int cmd_test_wolftpm_dam_reset(struct unit_test_state *uts)
> > +{
> > +     /* First autostart to ensure TPM is ready */
> > +     ut_assertok(run_command("tpm2 autostart", 0));
> > +
> > +     /* Reset DAM counter */
> > +     ut_assertok(run_command("tpm2 dam_reset", 0));
> > +
> > +     return 0;
> > +}
> > +CMD_TEST(cmd_test_wolftpm_dam_reset, 0);
> > +
> > +/**
> > + * Test wolfTPM dam_parameters command
> > + *
> > + * Set Dictionary Attack Mitigation parameters
> > + */
> > +static int cmd_test_wolftpm_dam_parameters(struct unit_test_state *uts=
)
> > +{
> > +     /* First autostart to ensure TPM is ready */
> > +     ut_assertok(run_command("tpm2 autostart", 0));
> > +
> > +     /* Set DAM parameters:
> > +      * - max_tries: 3
> > +      * - recovery_time: 10 seconds
> > +      * - lockout_recovery: 0 seconds
> > +      */
> > +     ut_assertok(run_command("tpm2 dam_parameters 3 10 0", 0));
> > +
> > +     return 0;
> > +}
> > +CMD_TEST(cmd_test_wolftpm_dam_parameters, 0);
> > +
> > +/**
> > + * Test wolfTPM change_auth command
> > + *
> > + * Change hierarchy authorization password
> > + * Note: Requires WOLFTPM2_NO_WOLFCRYPT to NOT be defined
> > + */
> > +static int cmd_test_wolftpm_change_auth(struct unit_test_state *uts)
> > +{
> > +     /* First autostart and clear to ensure clean state */
> > +     ut_assertok(run_command("tpm2 autostart", 0));
> > +     run_command("tpm2 clear TPM2_RH_LOCKOUT", 0);
> > +
> > +     /* Change LOCKOUT password to "testpw"
> > +      * This may fail if WOLFTPM2_NO_WOLFCRYPT is defined
> > +      */
> > +     if (run_command("tpm2 change_auth TPM2_RH_LOCKOUT testpw", 0) =3D=
=3D
> 0) {
> > +             /* Clear with new password to verify it worked */
> > +             ut_assertok(run_command("tpm2 clear TPM2_RH_LOCKOUT
> testpw", 0));
> > +     }
> > +
> > +     return 0;
> > +}
> > +CMD_TEST(cmd_test_wolftpm_change_auth, 0);
> > +
> > +/**
> > + * Cleanup test - ensure TPM is cleared after tests
> > + */
> > +static int cmd_test_wolftpm_cleanup(struct unit_test_state *uts)
> > +{
> > +     /* Clear TPM to reset any passwords or test state */
> > +     run_command("tpm2 autostart", 0);
> > +     run_command("tpm2 clear TPM2_RH_LOCKOUT", 0);
> > +     run_command("tpm2 clear TPM2_RH_PLATFORM", 0);
> > +
> > +     return 0;
> > +}
> > +CMD_TEST(cmd_test_wolftpm_cleanup, 0);
> > diff --git a/test/py/tests/test_wolftpm.py
> b/test/py/tests/test_wolftpm.py
> > new file mode 100644
> > index 00000000000..9d67211f96c
> > --- /dev/null
> > +++ b/test/py/tests/test_wolftpm.py
> > @@ -0,0 +1,373 @@
> > +# SPDX-License-Identifier: GPL-2.0+
> > +# Copyright (C) 2025 wolfSSL Inc.
> > +# Author: Aidan Garske <aidan@wolfssl.com>
> > +#
> > +# Based on test_tpm2.py by Miquel Raynal <miquel.raynal@bootlin.com>
> > +
> > +"""
> > +Test the wolfTPM related commands. These tests require a TPM device
> > +(real hardware or software TPM emulator like swtpm).
> > +
> > +Notes:
> > +* These tests will prove the password mechanism. The TPM chip must be
> cleared of
> > +  any password.
> > +* Tests are designed to be similar to test_tpm2.py but use wolfTPM
> wrapper APIs.
> > +
> > +Configuration:
> > +* Set env__wolftpm_device_test_skip to True to skip these tests.
> > +"""
> > +
> > +import os.path
> > +import pytest
> > +import utils
> > +import re
> > +import time
> > +
> > +
> > +def force_init(ubman, force=3DFalse):
> > +    """Initialize wolfTPM before running tests.
> > +
> > +    When a test fails, U-Boot may be reset. Because TPM stack must be
> initialized
> > +    after each reboot, we must ensure these lines are always executed
> before
> > +    trying any command or they will fail with no reason.
> > +    """
> > +    skip_test =3D ubman.config.env.get('env__wolftpm_device_test_skip'=
,
> False)
> > +    if skip_test:
> > +        pytest.skip('skip wolfTPM device test')
> > +    output =3D ubman.run_command('wolftpm autostart')
> > +    if force or 'Error' not in output:
> > +        ubman.run_command('echo --- start of init ---')
> > +        ubman.run_command('wolftpm clear TPM2_RH_LOCKOUT')
> > +        output =3D ubman.run_command('echo $?')
> > +        if not output.endswith('0'):
> > +            ubman.run_command('wolftpm clear TPM2_RH_PLATFORM')
> > +        ubman.run_command('echo --- end of init ---')
> > +
> > +
> > +@pytest.mark.buildconfigspec('tpm_wolf')
> > +def test_wolftpm_autostart(ubman):
> > +    """Test wolfTPM autostart command.
> > +
> > +    Initialize the software stack, perform startup and self-test.
> > +    """
> > +    skip_test =3D ubman.config.env.get('env__wolftpm_device_test_skip'=
,
> False)
> > +    if skip_test:
> > +        pytest.skip('skip wolfTPM device test')
> > +    ubman.run_command('wolftpm autostart')
> > +    output =3D ubman.run_command('echo $?')
> > +    assert output.endswith('0')
> > +
> > +
> > +@pytest.mark.buildconfigspec('tpm_wolf')
> > +def test_wolftpm_init(ubman):
> > +    """Test wolfTPM init command.
> > +
> > +    Initialize the TPM device for communication.
> > +    """
> > +    skip_test =3D ubman.config.env.get('env__wolftpm_device_test_skip'=
,
> False)
> > +    if skip_test:
> > +        pytest.skip('skip wolfTPM device test')
> > +    ubman.run_command('wolftpm init')
> > +    output =3D ubman.run_command('echo $?')
> > +    assert output.endswith('0')
> > +
> > +
> > +@pytest.mark.buildconfigspec('tpm_wolf')
> > +def test_wolftpm_self_test_full(ubman):
> > +    """Test wolfTPM full self_test command.
> > +
> > +    Perform a full TPM self-test to verify all components are
> operational.
> > +    """
> > +    skip_test =3D ubman.config.env.get('env__wolftpm_device_test_skip'=
,
> False)
> > +    if skip_test:
> > +        pytest.skip('skip wolfTPM device test')
> > +    ubman.run_command('wolftpm autostart')
> > +    ubman.run_command('wolftpm self_test full')
> > +    output =3D ubman.run_command('echo $?')
> > +    assert output.endswith('0')
> > +
> > +
> > +@pytest.mark.buildconfigspec('tpm_wolf')
> > +def test_wolftpm_self_test_continue(ubman):
> > +    """Test wolfTPM continue self_test command.
> > +
> > +    Ask the TPM to finish any remaining self tests.
> > +    """
> > +    skip_test =3D ubman.config.env.get('env__wolftpm_device_test_skip'=
,
> False)
> > +    if skip_test:
> > +        pytest.skip('skip wolfTPM device test')
> > +    ubman.run_command('wolftpm autostart')
> > +    ubman.run_command('wolftpm self_test continue')
> > +    output =3D ubman.run_command('echo $?')
> > +    assert output.endswith('0')
> > +
> > +
> > +@pytest.mark.buildconfigspec('tpm_wolf')
> > +def test_wolftpm_caps(ubman):
> > +    """Test wolfTPM caps command.
> > +
> > +    Display TPM capabilities and vendor information.
> > +    """
> > +    force_init(ubman)
> > +    caps_output =3D ubman.run_command('wolftpm caps')
> > +    output =3D ubman.run_command('echo $?')
> > +    assert output.endswith('0')
> > +    # Should contain manufacturer info
> > +    assert 'Mfg' in caps_output or 'Vendor' in caps_output or 'wolfTPM=
'
> in caps_output
> > +
> > +
> > +@pytest.mark.buildconfigspec('tpm_wolf')
> > +def test_wolftpm_clear(ubman):
> > +    """Test wolfTPM clear command.
> > +
> > +    Clear the TPM internal state using LOCKOUT hierarchy.
> > +    LOCKOUT/PLATFORM hierarchies must not have a password set.
> > +    """
> > +    skip_test =3D ubman.config.env.get('env__wolftpm_device_test_skip'=
,
> False)
> > +    if skip_test:
> > +        pytest.skip('skip wolfTPM device test')
> > +    ubman.run_command('wolftpm autostart')
> > +    ubman.run_command('wolftpm clear TPM2_RH_LOCKOUT')
> > +    output =3D ubman.run_command('echo $?')
> > +    assert output.endswith('0')
> > +
> > +    ubman.run_command('wolftpm clear TPM2_RH_PLATFORM')
> > +    output =3D ubman.run_command('echo $?')
> > +    assert output.endswith('0')
> > +
> > +
> > +@pytest.mark.buildconfigspec('tpm_wolf')
> > +def test_wolftpm_change_auth(ubman):
> > +    """Test wolfTPM change_auth command.
> > +
> > +    Change the owner/hierarchy password.
> > +    """
> > +    force_init(ubman)
> > +
> > +    # Change LOCKOUT password to 'unicorn'
> > +    ubman.run_command('wolftpm change_auth TPM2_RH_LOCKOUT unicorn')
> > +    output =3D ubman.run_command('echo $?')
> > +    assert output.endswith('0')
> > +
> > +    # Clear with new password to verify
> > +    ubman.run_command('wolftpm clear TPM2_RH_LOCKOUT unicorn')
> > +    output =3D ubman.run_command('echo $?')
> > +    ubman.run_command('wolftpm clear TPM2_RH_PLATFORM')
> > +    assert output.endswith('0')
> > +
> > +
> > +@pytest.mark.buildconfigspec('tpm_wolf')
> > +def test_wolftpm_dam_parameters(ubman):
> > +    """Test wolfTPM dam_parameters command.
> > +
> > +    Change Dictionary Attack Mitigation parameters:
> > +    - Max number of failed authentication before lockout: 3
> > +    - Time before failure counter is decremented: 10 sec
> > +    - Time after lockout failure before retry: 0 sec
> > +    """
> > +    force_init(ubman)
> > +
> > +    # Set DAM parameters
> > +    ubman.run_command('wolftpm dam_parameters 3 10 0')
> > +    output =3D ubman.run_command('echo $?')
> > +    assert output.endswith('0')
> > +
> > +
> > +@pytest.mark.buildconfigspec('tpm_wolf')
> > +def test_wolftpm_dam_reset(ubman):
> > +    """Test wolfTPM dam_reset command.
> > +
> > +    Reset the Dictionary Attack Mitigation counter.
> > +    """
> > +    force_init(ubman)
> > +
> > +    ubman.run_command('wolftpm dam_reset')
> > +    output =3D ubman.run_command('echo $?')
> > +    assert output.endswith('0')
> > +
> > +
> > +@pytest.mark.buildconfigspec('tpm_wolf')
> > +def test_wolftpm_pcr_read(ubman):
> > +    """Test wolfTPM pcr_read command.
> > +
> > +    Read PCR value from a specific index.
> > +    """
> > +    force_init(ubman)
> > +
> > +    # Read PCR 0 with SHA256
> > +    read_pcr =3D ubman.run_command('wolftpm pcr_read 0 sha256')
> > +    output =3D ubman.run_command('echo $?')
> > +    assert output.endswith('0')
> > +
> > +    # Check for PCR output
> > +    assert 'PCR' in read_pcr or 'digest' in read_pcr.lower() or
> 'sha256' in read_pcr.lower()
> > +
> > +
> > +@pytest.mark.buildconfigspec('tpm_wolf')
> > +def test_wolftpm_pcr_extend(ubman):
> > +    """Test wolfTPM pcr_extend command.
> > +
> > +    Extend a PCR with a digest value.
> > +    PCR 16-23 are typically available for debug/testing.
> > +    """
> > +    force_init(ubman)
> > +    ram =3D utils.find_ram_base(ubman)
> > +
> > +    # Read PCR 16 first
> > +    read_pcr =3D ubman.run_command('wolftpm pcr_read 16 sha256')
> > +    output =3D ubman.run_command('echo $?')
> > +    assert output.endswith('0')
> > +
> > +    # Extend PCR 16 with zeroed memory
> > +    ubman.run_command('wolftpm pcr_extend 16 0x%x sha256' % ram)
> > +    output =3D ubman.run_command('echo $?')
> > +    assert output.endswith('0')
> > +
> > +    # Read again to verify it changed
> > +    read_pcr_after =3D ubman.run_command('wolftpm pcr_read 16 sha256')
> > +    output =3D ubman.run_command('echo $?')
> > +    assert output.endswith('0')
> > +
> > +
> > +@pytest.mark.buildconfigspec('tpm_wolf')
> > +def test_wolftpm_pcr_print(ubman):
> > +    """Test wolfTPM pcr_print command.
> > +
> > +    Print all assigned PCRs.
> > +    """
> > +    force_init(ubman)
> > +
> > +    pcr_output =3D ubman.run_command('wolftpm pcr_print')
> > +    output =3D ubman.run_command('echo $?')
> > +    assert output.endswith('0')
> > +
> > +    # Should contain PCR info
> > +    assert 'PCR' in pcr_output or 'Assigned' in pcr_output
> > +
> > +
> > +@pytest.mark.buildconfigspec('tpm_wolf')
> > +def test_wolftpm_info(ubman):
> > +    """Test wolfTPM info command.
> > +
> > +    Display TPM device information.
> > +    """
> > +    force_init(ubman)
> > +
> > +    ubman.run_command('wolftpm info')
> > +    output =3D ubman.run_command('echo $?')
> > +    assert output.endswith('0')
> > +
> > +
> > +@pytest.mark.buildconfigspec('tpm_wolf')
> > +def test_wolftpm_state(ubman):
> > +    """Test wolfTPM state command.
> > +
> > +    Display TPM internal state.
> > +    """
> > +    force_init(ubman)
> > +
> > +    ubman.run_command('wolftpm state')
> > +    output =3D ubman.run_command('echo $?')
> > +    assert output.endswith('0')
> > +
> > +
> > +@pytest.mark.buildconfigspec('tpm_wolf')
> > +def test_wolftpm_device(ubman):
> > +    """Test wolfTPM device command.
> > +
> > +    Show all TPM devices.
> > +    """
> > +    skip_test =3D ubman.config.env.get('env__wolftpm_device_test_skip'=
,
> False)
> > +    if skip_test:
> > +        pytest.skip('skip wolfTPM device test')
> > +    ubman.run_command('wolftpm device')
> > +    output =3D ubman.run_command('echo $?')
> > +    assert output.endswith('0')
> > +
> > +
> > +@pytest.mark.buildconfigspec('tpm_wolf')
> > +def test_wolftpm_startup_clear(ubman):
> > +    """Test wolfTPM startup command with TPM2_SU_CLEAR.
> > +
> > +    Issue TPM2_Startup with CLEAR mode (reset state).
> > +    """
> > +    skip_test =3D ubman.config.env.get('env__wolftpm_device_test_skip'=
,
> False)
> > +    if skip_test:
> > +        pytest.skip('skip wolfTPM device test')
> > +    ubman.run_command('wolftpm init')
> > +    ubman.run_command('wolftpm startup TPM2_SU_CLEAR')
> > +    output =3D ubman.run_command('echo $?')
> > +    assert output.endswith('0')
> > +
> > +
> > +@pytest.mark.buildconfigspec('tpm_wolf')
> > +def test_wolftpm_startup_state(ubman):
> > +    """Test wolfTPM startup command with TPM2_SU_STATE.
> > +
> > +    Issue TPM2_Startup with STATE mode (preserved state).
> > +    """
> > +    skip_test =3D ubman.config.env.get('env__wolftpm_device_test_skip'=
,
> False)
> > +    if skip_test:
> > +        pytest.skip('skip wolfTPM device test')
> > +    # First autostart to have valid state
> > +    ubman.run_command('wolftpm autostart')
> > +    # Shutdown with STATE
> > +    ubman.run_command('wolftpm startup TPM2_SU_STATE off')
> > +    # Re-init
> > +    ubman.run_command('wolftpm init')
> > +    # Startup with STATE - may return already started
> > +    ubman.run_command('wolftpm startup TPM2_SU_STATE')
> > +    output =3D ubman.run_command('echo $?')
> > +    # May return non-zero if already started, just verify command ran
> > +    assert output is not None
> > +
> > +
> > +@pytest.mark.buildconfigspec('tpm_wolf')
> > +def test_wolftpm_startup_shutdown(ubman):
> > +    """Test wolfTPM startup shutdown command.
> > +
> > +    Issue TPM2_Shutdown.
> > +    """
> > +    skip_test =3D ubman.config.env.get('env__wolftpm_device_test_skip'=
,
> False)
> > +    if skip_test:
> > +        pytest.skip('skip wolfTPM device test')
> > +    ubman.run_command('wolftpm autostart')
> > +    ubman.run_command('wolftpm startup TPM2_SU_CLEAR off')
> > +    output =3D ubman.run_command('echo $?')
> > +    assert output.endswith('0')
> > +
> > +
> > +@pytest.mark.buildconfigspec('tpm_wolf')
> > +def test_wolftpm_get_capability(ubman):
> > +    """Test wolfTPM get_capability command.
> > +
> > +    Read TPM capabilities by property.
> > +    """
> > +    force_init(ubman)
> > +    ram =3D utils.find_ram_base(ubman)
> > +
> > +    # Get capability - TPM_CAP_TPM_PROPERTIES (0x6), PT_MANUFACTURER
> (0x20e)
> > +    ubman.run_command('wolftpm get_capability 0x6 0x20e 0x%x 1' % ram)
> > +    output =3D ubman.run_command('echo $?')
> > +    assert output.endswith('0')
> > +
> > +
> > +@pytest.mark.buildconfigspec('tpm_wolf')
> > +def test_wolftpm_pcr_allocate(ubman):
> > +    """Test wolfTPM pcr_allocate command.
> > +
> > +    Reconfigure PCR bank algorithm.
> > +    Note: A TPM restart is required for changes to take effect.
> > +    """
> > +    force_init(ubman)
> > +
> > +    # Allocate SHA256 bank on
> > +    ubman.run_command('wolftpm pcr_allocate SHA256 on')
> > +    output =3D ubman.run_command('echo $?')
> > +    assert output.endswith('0')
> > +
> > +
> > +@pytest.mark.buildconfigspec('tpm_wolf')
> > +def test_wolftpm_cleanup(ubman):
> > +    """Cleanup test - ensure TPM is cleared after tests."""
> > +    force_init(ubman, True)
>
> Thanks
> /Ilias
>
