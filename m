Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12885C47077
	for <u-boot@archiver.kernel.org>; Sun, 14 Jan 2024 21:27:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1233187978;
	Sun, 14 Jan 2024 22:27:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="K0m7optX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 069D0879A3; Sun, 14 Jan 2024 22:27:34 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03F1E8785E
 for <u-boot@lists.denx.de>; Sun, 14 Jan 2024 22:27:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1705267640; x=1705872440; i=xypron.glpk@gmx.de;
 bh=ZUvMxOmRsMWwSlUQlqdOIhawmd64Rw0QHsRI5WeCWfU=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=K0m7optXAeuwOK4qL9BOH7O4WDxY/b4m58IhkxOB8PHuBkDlfBEXfodD+o5lGx3g
 nDFpWaJJafvi8a9n3S2Qn+tZiAGLGFyAe4/avXQTo+CF3MCAnFUaLantTRZZWMi8g
 408y4K3IgfsnBmBlE08A/ZeEYkRt0QE1WgYHXn0HvfgdaqYVdI541BTzBTJeUuGpw
 UEG9GWf38H0qCkTOs7cVzxPJ0byx4Oh3sLpPKWFMuNN2ey7VaN7npgTaLvfK0cRJq
 qz39gBf0LmjTRmEgiRUBKYgiOrj9vhwCrTg6JnZ4wDY+ha/1+iwR6ZOUHyqoeTflj
 ROA54an7ASZuknO4MA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7sDg-1rU3xF3FWk-0053vj; Sun, 14
 Jan 2024 22:27:19 +0100
Message-ID: <fd037cd9-176f-49e3-bb78-9cc54371ed26@gmx.de>
Date: Sun, 14 Jan 2024 22:27:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] doc: sophgo: milkv_duo: document Milk-V Duo board
To: Kongyang Liu <seashell11234455@gmail.com>
Cc: Chris Morgan <macromorgan@hotmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Tim Harvey <tharvey@gateworks.com>, Wei Fu <wefu@redhat.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>, Yannic Moog
 <y.moog@phytec.de>, Yixun Lan <dlan@gentoo.org>, u-boot@lists.denx.de
References: <20240114180741.2114-1-seashell11234455@gmail.com>
 <20240114180741.2114-4-seashell11234455@gmail.com>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240114180741.2114-4-seashell11234455@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n3bxURPVucIpf4t/wzxzOljzGEj6IYvp6x0vr1vjDpoFc6wU50I
 5JBnCUj87j0VtXhnwUBpxS3OICc0SWVF/M73Fpu8XF8GUyaC7+9far2GrPo+jeFm/H1ZsWQ
 /Qn5TAJnyc4VZfyGVM0Andhw+osUeLHJcP4hx8RXxyo3onLpBHUb30UZ4e7lP+XtX8f63pc
 U6j3X2yh+beDbtsK1bhqA==
UI-OutboundReport: notjunk:1;M01:P0:9PNPAe/zNww=;SRI384Zo/p+B/F+8OqCLulXeUvf
 fqwg3Ka2qhBtUoNRar2HFWYOCdhAmdZWYUSvNmI//FYDm0oLyBfwZUCjwdk4/BcZizNIRrywu
 apbRV9y/dB2g3uKSI8MAqoAHiSJnP4bgN+Q1dfHKcNzeRZDCnNssYsgvo2nt0dLywUnnrVDt1
 43/InnIGARdGtKThnOD9lFcI8IFbmxCroplcKRPjX8HQCH+dI1F0oCAX3yfm2PeZbbtnQMbcN
 ZNMvL1SCPLx5JFzmluQFP7UyZ9LCYNCWu9nmm3U0Z3Rz/AQiloQ9Ov8C7pDZb3KPRfSCrWa/V
 0yuokgdzLlcw/tMQ68vr8MMEmtDQpcmauyAaXCodUYFK7s1pWquJYzFxwr1vzqJj+RcfZemma
 K6l9qtABoy+0gr9Fo0OjPcKOd684TBO07lpl+lY5VUMb7vviU7LShOQaFRU8BshCo5L14hyPc
 kl8Ec5pPe26Tl5yr2C4fy+tu6znmEE1R5nWyymqC93j7yE9CeduybpRw0rEkjZg4fG8Xq9i9I
 cXzaN6YyFl8oa6IfiOhs6FSiueXSEzu5g9HAGz5wORMbsmv6X1eVxsv0ktqVfg0mNJ3E2kYrA
 MLKF2Bvz0qVjCqSEri8+74ER8UnbRB8gYCNzZsN2PoBShqgDpIEp3qD6hgDvcWzdgYp4miyoT
 WIDKM+koxCbUuy07+sFXFqIbR/6s/qoUZOByzYb5TVZ2P/qxhmSeSBXPjH9lY1P9U95UEh/7x
 CGotrU+pVPepsW1m6/IAI1l74XfMlL9jDzDlzmaLe6Dy/IjvsPLmpFyzQo5Sy9ow32fV+IsR0
 gCYrK549Q7PSr8DKQ1mWxJs9bNxPd7Jr3CqIoo/uNXeWnklinAdSXEd1cX0ApePI8MwkO9QD3
 f/LE1m4HHBrRGHt06dHh0exOZvrkm4nmVXrZ6fHLjJD23RBUGBZxq4NAu+NM8KNKIPVfiySO/
 aLXTgWtHj3b3XTLLe3f+DqTkgc0=
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

On 1/14/24 19:07, Kongyang Liu wrote:
> Add document for Milk-V Duo board which based on Sophgo's CV1800B SoC.
>
> Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> ---
>
> (no changes since v1)
>
>   doc/board/index.rst            |  1 +
>   doc/board/sophgo/index.rst     |  8 ++++++
>   doc/board/sophgo/milkv_duo.rst | 50 ++++++++++++++++++++++++++++++++++
>   3 files changed, 59 insertions(+)
>   create mode 100644 doc/board/sophgo/index.rst
>   create mode 100644 doc/board/sophgo/milkv_duo.rst
>
> diff --git a/doc/board/index.rst b/doc/board/index.rst
> index 531e547e7e..a0bd534742 100644
> --- a/doc/board/index.rst
> +++ b/doc/board/index.rst
> @@ -45,6 +45,7 @@ Board-specific doc
>      sifive/index
>      sipeed/index
>      socionext/index
> +   sophgo/index
>      st/index
>      starfive/index
>      ste/index
> diff --git a/doc/board/sophgo/index.rst b/doc/board/sophgo/index.rst
> new file mode 100644
> index 0000000000..e097afdac6
> --- /dev/null
> +++ b/doc/board/sophgo/index.rst
> @@ -0,0 +1,8 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +Sophgo
> +=3D=3D=3D=3D=3D=3D
> +.. toctree::
> +   :maxdepth: 1
> +
> +   milkv_duo
> diff --git a/doc/board/sophgo/milkv_duo.rst b/doc/board/sophgo/milkv_duo=
.rst
> new file mode 100644
> index 0000000000..b63304b510
> --- /dev/null
> +++ b/doc/board/sophgo/milkv_duo.rst
> @@ -0,0 +1,50 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +Milk-V Duo
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +CV1800B RISC-V SoC
> +------------------
> +The CV1800B is a high-performance, low-power 1+1 64-bit RISC-V SoC from=
 Sophgo.
> +
> +Mainline support
> +----------------
> +The support for following drivers are already enabled:
> +1. ns16550 UART Driver.
> +
> +Building
> +~~~~~~~~
> +1. Add the RISC-V toolchain to your PATH.
> +2. Setup ARCH & cross compilation environment variable:
> +
> +.. code-block:: console
> +
> +   export CROSS_COMPILE=3D<riscv64 toolchain prefix>
> +   cd <U-Boot-dir>
> +   make milkv_duo_defconfig
> +   make
> +
> +This will generate u-boot-dtb.bin
> +
> +Booting
> +~~~~~~~
> +Currently, we rely on vendor FSBL(First Stage Boot Loader) to initializ=
e the
> +clock and load the u-boot image, then bootup from it.

Thank you for providing documentation for the board.

Could you please, additionally describe the procedure to run
u-boot-dtb.bin on top of FSBL.

Best regards

Heinrich

> +
> +Sample boot log from Milk-V Duo board
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +.. code-block:: none
> +
> +   U-Boot 2024.01-rc5-00010-g51965baa36 (Dec 28 2023 - 13:15:53 +0800)m=
ilkv_duo
> +
> +   DRAM:  63.3 MiB
> +   Core:  10 devices, 8 uclasses, devicetree: separate
> +   Loading Environment from nowhere... OK
> +   In:    serial@4140000
> +   Out:   serial@4140000
> +   Err:   serial@4140000
> +   Net:   No ethernet found.
> +   milkv_duo# cpu detail
> +     0: cpu@0      rv64imafdc
> +      ID =3D 0, freq =3D 0 Hz: L1 cache, MMU
> +   milkv_duo#

