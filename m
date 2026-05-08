Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF3A4CD3447
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 10:52:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DCD984B56;
	Fri,  8 May 2026 12:52:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qTVzvI6k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4652984BDC; Fri,  8 May 2026 12:52:31 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC95F84AE9
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 12:52:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-44985f4ab0fso1081658f8f.0
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 03:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778237547; x=1778842347; darn=lists.denx.de;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HBb1jvv2pVav1yW444DzewwwkerX/F2LoSaXMIqm3Ms=;
 b=qTVzvI6ku64I5vYLFUO0S3CDDpmDhfmE0djuwND17mBPzBSawIr4TK23BAQQZltRce
 mTofv5PWspiczk9yOw4wb6pJTCh4IBTgTuGI2kgpizn8st/l5bbnOje9VaLAEDCPciGb
 UYqhjgM03a0JqQ5EFPicjzp0H+O+Yrv4QSSc/oJqvqM9xHJBX7fR1aYLKorOXS3v5zKD
 +cY4J7TlWrUYW+BUfJc1jxeHMR5830AwSzlOTwjNDhp/53Rcy8NDeIyl3vKLl0dd4y6/
 5Hh3gLfoALuMw2GgFbdEZy8H/fdhtWHuNY4b4wh8ss887XDqZqk4h7GH/YIF3IC537EG
 aI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778237547; x=1778842347;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HBb1jvv2pVav1yW444DzewwwkerX/F2LoSaXMIqm3Ms=;
 b=V/7ic45kPDNkz4aNPOe7dUeYkySibIIAfp/qzVhlC2hz15XTtBPMK+oElS2XXqf7b1
 kMOzb9SLCNt8C6oPgm5/dHLcvXzEG4ko3JX6OLd3ZOE4+wofR9QlAtgz18i3yk+/U+jt
 j8KfjK7ARBtdaboAflMBlsNo6OWPK83cMQs12XRlM+tKd9IZWuyXqs/gnmRE4NfaZWD2
 CEN5fRjPoNaoDSQf0nRtiIkR4/OBWS7Qc8dvW+G+lcMercapu0VedbwJegZjgtOf/ylu
 rlBonPksu5E6+KALtExvIEJAgVMqWO0ven643Pa95kX3PqpK/ynJNz9Inm2kNk8MEkf3
 fXLg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8JxMg+T2158Vj4DEjEBynbnzLU966b5DQZRHjvNqbG+LJ198qi8oOhaIRNOT1SLixBlDWq0yo=@lists.denx.de
X-Gm-Message-State: AOJu0YzuBx8YcxZAhpoH3shzG+zjswzGnaKrBegh7N+eQBIM8Fncq4nA
 /i6v9WrFZRsQ3m670kATQXyEo+qWvvv1l8N4UXFLCsf/XOCCtI9IapdhW7CHMTU5GvyJa8LyCMP
 eJdOw
X-Gm-Gg: Acq92OF8ujXG3ePFE+t6yPseIL9Uu8zzDILe/q0BRiZFqY/D0bFK6vVnTMpyBu8hwO4
 mmgbw3ZRHNX2CagWxNKMyI4CeYs/U6+dwKJaYAP3kRzP+5RZpCjhAPWYQ7wsVMNnMHtIFl19jyE
 l9FOF/dYxrsH+bKfgkVY/NWoEwPi89Y5aNlakKJnGNqCkH3KOvipv7onroCQvtLF/pR1FZZfd6x
 z/YanDavVz2L6osEuI9/qFI/k/8Wr6ALf6r2sOFHBZhXjrG7n72aCK5U3+FX6T7itMpfDibrlQE
 HuCpZO4c/sRs6FDFVCfYfZ/GtkvOP8JRsyo+IewvfL9LajyUi+VtM9IeezrGoWaQ39IcyWZ36fr
 vqjuHZbZoxYzLFuYjC22p7j/frH8+tqxQJ4+TWXaWFVJF5T/Fv7vrghqFa1hkQTatXJC78nuDGi
 QymsKAtdZHjJX3XQxu/A/J140K6YZwhyuJE3LgzcMfwdL9vB3qSsEJj/Wr0I2jF9nNWLsGRkrDc
 IMef7yYXlORWXHsSYR15Bb7yJ5/0F6+vJXIHwyP+c99WyC6+aKRvr9TTU3Hj1Xl5LG/wBg1ab8v
 iClvh52ul8hEV/2PDiAtRbrMVZ9hQZGbKoQ0MET3mzb/peWjEPQeOV/k9qbmqKoVq3AN2gzV8Wu
 o2ThOau+NifJpqfVnz1F+/5G+MZN/lt4Rw5LSSjfJ6ZhfcB6G8TGW0uRUcKk5bfqTvoyW6q2iSg
 mB9IDArjVNrI099obr0/tJha+YZWZiY5Dev4qfjNkrRMbWsm/l5S4PRqhhMNN327iIE+4brI+cA
 UfV0MA+4mISCXSL11CLZ3Anc4HGdyNY
X-Received: by 2002:a05:6000:3110:b0:449:acdb:3009 with SMTP id
 ffacd0b85a97d-4515b057246mr18397334f8f.6.1778237546902; 
 Fri, 08 May 2026 03:52:26 -0700 (PDT)
Received: from localhost ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45491304505sm3585616f8f.22.2026.05.08.03.52.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 03:52:26 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 08 May 2026 13:52:25 +0300
Message-Id: <DID8LMS3SAQS.28ZX1CRKLP3D6@linaro.org>
Subject: Re: [[PATCH v2] tpm: Add wolfTPM library support for TPM 2.0 00/12]
 *** SUBJECT HERE ***
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
To: "David Garske" <david@wolfssl.com>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0
References: <20260316181447.2986278-1-david@wolfssl.com>
In-Reply-To: <20260316181447.2986278-1-david@wolfssl.com>
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

Hi David,

Apologies for the very late reply, but I am overloaded and this is going so=
me time to review.

For starters the CI failed to pass the docs. Please have a look and update
them properly

https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/30029

Cheers
/Ilias
On Mon Mar 16, 2026 at 8:14 PM EET, David Garske wrote:
> *** BLURB HERE ***
>
> Aidan (12):
>   tpm: export tpm_show_device, tpm_set_device, and get_tpm
>   include: add byteorder macro guards and SHA384 hash wrapper
>   spi: add BCM2835/BCM2711 hardware SPI controller driver
>   dts: add TPM device tree nodes for RPi4, QEMU, and sandbox
>   tpm: add wolfTPM library as git submodule
>   tpm: add wolfTPM headers and SHA384 glue code
>   tpm: add wolfTPM driver helpers and Kconfig options
>   cmd: refactor tpm2 command into frontend/backend architecture
>   tpm: add sandbox TPM SPI emulator
>   test: add wolfTPM C unit tests and Python integration tests
>   doc: add wolfTPM documentation
>   configs: enable wolfTPM in rpi_4_defconfig
>
>  .gitmodules                              |    3 +
>  README                                   |    3 +
>  README.wolftpm.md                        |  154 +++
>  arch/arm/dts/bcm2711-rpi-4-b-u-boot.dtsi |   54 +
>  arch/arm/dts/bcm2711-rpi-4-b.dts         |   20 +
>  arch/arm/dts/qemu-arm64.dts              |    4 +
>  arch/sandbox/dts/sandbox.dtsi            |   11 +
>  cmd/Kconfig                              |   11 +
>  cmd/Makefile                             |   10 +-
>  cmd/native_tpm2.c                        |  516 ++++++++++
>  cmd/tpm-common.c                         |    4 +-
>  cmd/tpm-v2.c                             |  559 ++---------
>  cmd/tpm2-backend.h                       |   66 ++
>  cmd/wolftpm.c                            | 1170 ++++++++++++++++++++++
>  configs/rpi_4_defconfig                  |   29 +-
>  doc/usage/cmd/wolftpm.rst                |  635 ++++++++++++
>  drivers/mtd/spi/sandbox.c                |   30 +-
>  drivers/spi/Kconfig                      |    9 +
>  drivers/spi/Makefile                     |    1 +
>  drivers/spi/bcm2835_spi.c                |  431 ++++++++
>  drivers/tpm/Kconfig                      |   44 +
>  drivers/tpm/Makefile                     |    9 +
>  drivers/tpm/tpm_spi_sandbox.c            |  410 ++++++++
>  drivers/tpm/wolftpm_common.c             |  137 +++
>  include/configs/user_settings.h          |  118 +++
>  include/hash.h                           |   18 +
>  include/linux/byteorder/generic.h        |   31 +-
>  include/tpm-common.h                     |   22 +
>  include/wolftpm.h                        |   34 +
>  lib/Kconfig                              |   13 +
>  lib/Makefile                             |   18 +
>  lib/wolftpm                              |    1 +
>  lib/wolftpm.c                            |   56 ++
>  test/cmd/Makefile                        |    1 +
>  test/cmd/wolftpm.c                       |  364 +++++++
>  test/py/tests/test_wolftpm.py            |  375 +++++++
>  36 files changed, 4861 insertions(+), 510 deletions(-)
>  create mode 100644 .gitmodules
>  create mode 100644 README.wolftpm.md
>  create mode 100644 arch/arm/dts/bcm2711-rpi-4-b-u-boot.dtsi
>  create mode 100644 cmd/native_tpm2.c
>  create mode 100644 cmd/tpm2-backend.h
>  create mode 100644 cmd/wolftpm.c
>  create mode 100644 doc/usage/cmd/wolftpm.rst
>  create mode 100644 drivers/spi/bcm2835_spi.c
>  create mode 100644 drivers/tpm/tpm_spi_sandbox.c
>  create mode 100644 drivers/tpm/wolftpm_common.c
>  create mode 100644 include/configs/user_settings.h
>  create mode 100644 include/wolftpm.h
>  create mode 160000 lib/wolftpm
>  create mode 100644 lib/wolftpm.c
>  create mode 100644 test/cmd/wolftpm.c
>  create mode 100644 test/py/tests/test_wolftpm.py

