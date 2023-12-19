Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D27EC41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 13:41:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D40668755C;
	Tue, 19 Dec 2023 14:41:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mVaxKDFY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0680871CC; Tue, 19 Dec 2023 14:41:14 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FEDA8755C
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 14:41:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-50e2ce4fb22so4332470e87.1
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 05:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702993270; x=1703598070; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CgVEcH5HFfJ3rQ+xzrx0xM3V5+HGrxMreS2l5VVWoo4=;
 b=mVaxKDFYfXcZjyHLGQGHefyeufSodQ7tE/Rbwjnv5jt0L4f0Rwzi205lSyGAWdueYA
 9y+yp+Stl22vabaTNkqmvNraOQZUPjbvgkbgghtEfwflgAioYO0A8GTjhtXC/Nr8Pn0a
 +18/LQv31j5aVimH4iDI6H4wtkBJwvMJhbvYjwkgrnShMN0YpDTDiXH8RCGuBB9/eq/o
 MjNygm3mCJRXXKMOp6hrfZXvSYV4DOTGqDEYEm410Agfi3QJuW16WUCoHT78sXDUnX/+
 nfDMR1KmjMxRX7kPf36dQsMiu2cpftN/rtP7NlNezpQbUIhIVD7OKwpyvtqcBLDl9Tct
 hesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702993270; x=1703598070;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CgVEcH5HFfJ3rQ+xzrx0xM3V5+HGrxMreS2l5VVWoo4=;
 b=uuaqRjqFXovChGMFE9FxKIa8oy1odXVc5umhB0dzgmlSO/DTEFHZ2J7W/+ndSvmpkR
 BpvEBCoJpk4pKPhjdqpgmMrZvTTzZCGJ623Y2roBPtjB2giOEIkE51fyI1nK2LUNRTBG
 wV2JznoEfhwP15sSjZgJz74iVReYk/C1fGwpALJvjvuJF0FvXkgCnJVT/TuQQP9qoSQ5
 3YUFP1OdWjrwGZiRmWQnEw7U3lYWQ+xz6jKelnIpdLKCajess5IynAtccsd9VZ/lSBPg
 Uicge0xMvCXhcFUY0UtOnpzbvDba1tEM/P7EKid8WMxvJceNUTlrYHnBByD5vJEoD1Pm
 e2yw==
X-Gm-Message-State: AOJu0YwbYtPFzrI+e64+MrzuBxRFmPyn/3EZLeqzfNcdcCuzh/knc7Kg
 I785wNpjRjKDXIicRVtUOnmEdwQw8sDmG3N36Co=
X-Google-Smtp-Source: AGHT+IGgWuaaQM9/aTjDbzamjGVgVb5TrL2vCrRiLgdzNx9cmIF5Yjg/QZI+mfPspa5HyC/dJQJ50bH8Rkluek0PvDo=
X-Received: by 2002:a05:6512:39d4:b0:50e:3ce2:9264 with SMTP id
 k20-20020a05651239d400b0050e3ce29264mr1672233lfu.26.1702993270103; Tue, 19
 Dec 2023 05:41:10 -0800 (PST)
MIME-Version: 1.0
References: <20231219122439.31983-1-heinrich.schuchardt@canonical.com>
 <20231219122439.31983-9-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231219122439.31983-9-heinrich.schuchardt@canonical.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 19 Dec 2023 21:41:04 +0800
Message-ID: <CAEUhbmV9zSOPaB-avSSGXq_uTAJ+JEiZ2P-5mjz04BWv3SN_jg@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] configs: qemu: add config fragment for ACPI
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

Hi Heinrich,

On Tue, Dec 19, 2023 at 8:25=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Provide a configuration fragment to enable ACPI on QEMU.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> v3:
>         no change
> v2:
>         no change
> ---
>  MAINTAINERS                         |  1 +
>  board/emulation/configs/acpi.config |  3 +++
>  doc/board/emulation/acpi.rst        | 23 +++++++++++++++++++++++
>  doc/board/emulation/index.rst       |  1 +
>  4 files changed, 28 insertions(+)
>  create mode 100644 board/emulation/configs/acpi.config
>  create mode 100644 doc/board/emulation/acpi.rst
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 25f2bb80de..bf437b253b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -53,6 +53,7 @@ Maintainers List (try to look for most precise areas fi=
rst)
>  ACPI:
>  M:     Simon Glass <sjg@chromium.org>
>  S:     Maintained
> +F:     board/emulation/configs/acpi.config
>  F:     cmd/acpi.c
>  F:     lib/acpi/
>
> diff --git a/board/emulation/configs/acpi.config b/board/emulation/config=
s/acpi.config
> new file mode 100644
> index 0000000000..b7ed811e33
> --- /dev/null
> +++ b/board/emulation/configs/acpi.config
> @@ -0,0 +1,3 @@
> +CONFIG_CMD_QFW=3Dy
> +CONFIG_ACPI=3Dy
> +CONFIG_GENERATE_ACPI_TABLE=3Dy
> diff --git a/doc/board/emulation/acpi.rst b/doc/board/emulation/acpi.rst
> new file mode 100644
> index 0000000000..e1208ca51e
> --- /dev/null
> +++ b/doc/board/emulation/acpi.rst
> @@ -0,0 +1,23 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +ACPI on QEMU
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +QEMU can provide ACPI tables on ARM, RISC-V, and x86.

ACPI support on RISC-V landed on QEMU in a pretty recent version.
Would you mind documenting its version?

I haven't checked QEMU yet. Is ACPI default on in QEMU for Arm and
RISC-V virt? If not, we should document QEMU commands to enable ACPI.

> +
> +The following settings are needed::
> +
> +    CONFIG_CMD_QFW=3Dy
> +    CONFIG_ACPI=3Dy
> +    CONFIG_GENERATE_ACPI_TABLE=3Dy
> +
> +On x86 these settings are already included in the defconfig files. ARM a=
nd
> +RISC-V default to use device-trees.
> +
> +Instead of updating the configuration manually you can add the configura=
tion
> +fragment `acpi.config` to the make command for initializing the configur=
ation.
> +E.g.
> +
> +.. code-block:: bash
> +
> +    make qemu-riscv64_smode_defconfig acpi.config
> diff --git a/doc/board/emulation/index.rst b/doc/board/emulation/index.rs=
t
> index 932c65adeb..d3d6b8f3d8 100644
> --- a/doc/board/emulation/index.rst
> +++ b/doc/board/emulation/index.rst
> @@ -6,6 +6,7 @@ Emulation
>  .. toctree::
>     :maxdepth: 1
>
> +   acpi
>     blkdev
>     ../../usage/semihosting
>     qemu-arm
> --

Regards,
Bin
