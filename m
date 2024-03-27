Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38098C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 06:02:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6506A88063;
	Wed, 27 Mar 2024 07:02:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E53xq6oa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33BA488049; Wed, 27 Mar 2024 07:02:52 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6C8388063
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 07:02:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-515b3077d09so1951960e87.1
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 23:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711519369; x=1712124169; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lE039o6qpZHoXojLO8bIgdBY7EY9MhrHyNvLYZVz8fY=;
 b=E53xq6oaw5P/+xvJZDg6Ydy1Y3F4heqgp5KO6eHgyD01KUknM+pRl/qp3GOh0yux/F
 n46tBpNb+dkBbb5v1hnz9eFokBMMBJ1/oY4IgNTY26vH/ruTpVOoH0kYu/tjjd7al+9d
 puRg7HZh2omwiM7jMshemRLH0FpJCGTfvqB0B0W3eDPsdVMkMhY87hf04b1NvjtZ9tpu
 KZ36+6PdZfAAzySIlniC/pNtvg0d9DRUY4WujZ0iC9DNngs6WxwnKvSSPIN7NwCp9Nw/
 Fnj0tuz4z4/mjdKeOIIsCVbP8ShzJlOZU8C5uM+ZMLXbhvVbsMz5CDjMkqZ/tEc2CZRv
 YvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711519369; x=1712124169;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lE039o6qpZHoXojLO8bIgdBY7EY9MhrHyNvLYZVz8fY=;
 b=Kb+KedNagnK60uuJahYVda6XirlwORoN5SSZ8Q4qgDR+AQcshdQurMpOn7rgRQ1xZG
 kszPt7tkUKaVOI+CJuqmIcxlDTRwD0Ebvw+Y+qP7T6Y5KxC+215HXv/9x1cyelQqbBlc
 lrzC5DznA1qSJEdMSU4de4wXwR1/3Rwqm9rk9YKM6+W2V2hpXjSf8d2aQID+zForsFWw
 75jidEIPspGzH1gye583SFYjvCLzLbKRnO1Jkq6irm7dAXbcovROkKp7CgnZJDbYgL5E
 vKSEdghR/uxgGye/pZkG1i71jZYcLTFvwpuL3hsfjx4EtiU7Fd8ljYq2qFsVpv6m23HC
 r5Dw==
X-Gm-Message-State: AOJu0Yxj44LpCM2L610Zul6hdPMdB0mLkrdchwHCqyp0rlXkr4AUXobt
 xkeviI/5UsgxCfqOJhkNw00Y+zSMqEtNLuKYIdnh1XODGejib3ELsLzQoc5QrbUIww6vWXLdJPi
 lRyGEjhpbjH4MP4YK/qGyxmizBrI=
X-Google-Smtp-Source: AGHT+IEfLF1DrDYkOrIumcir7EVpVrxdgeYCk1H/KScN7SAuLfqTRBDAZBPX38k/vO8aKTt4lyp29SoaXRPa6/DxoxY=
X-Received: by 2002:ac2:5dd8:0:b0:515:99f6:2ca4 with SMTP id
 x24-20020ac25dd8000000b0051599f62ca4mr139862lfq.36.1711519368865; Tue, 26 Mar
 2024 23:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240322021747.14873-1-mibodhi@gmail.com>
 <CAFA6WYMaHyqf1KOn05synhqAHr_oTKtqv-DHs4-07zgS+np0XQ@mail.gmail.com>
In-Reply-To: <CAFA6WYMaHyqf1KOn05synhqAHr_oTKtqv-DHs4-07zgS+np0XQ@mail.gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Tue, 26 Mar 2024 23:02:37 -0700
Message-ID: <CAJaLiFzLRR=YHcODV+wu-W9_p2gS7Gx6s42M_gp32gjZ6EWoew@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: kirkwood: Enable upstream DT on Kirkwood boards
To: Sumit Garg <sumit.garg@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Stefan Roese <sr@denx.de>,
 Michael Walle <michael@walle.cc>, Tom Rini <trini@konsulko.com>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>, 
 Dave Purdy <david.c.purdy@gmail.com>, Evgeni Dobrev <evgeni@studio-punkt.com>, 
 Luka Perkov <luka@openwrt.org>, Siddarth Gore <gores@marvell.com>, 
 Simon Guinot <simon.guinot@sequanux.org>, 
 Stefan Herbrechtsmeier <stefan@herbrechtsmeier.net>, 
 This contributor prefers not to receive mails <noreply@example.com>,
 Walter Schweizer <swwa@users.sourceforge.net>
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

Hi Sumit,

On Tue, Mar 26, 2024 at 9:21=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> Hi Tony,
>
> On Fri, 22 Mar 2024 at 07:48, Tony Dinh <mibodhi@gmail.com> wrote:
> >
> > Enable OF_UPSTREAM to use upstream DT and add marvell/ prefix to the
> > DEFAULT_DEVICE_TREE for Kirkwood boards. And so we can directly build
> > DTBs from dts/upstream/src/arm/marvell, and including *-u-boot.dtsi
> > files from arch/arm/dts/ directory.
> >
> > Background:
> >
> > Hi Stefan,
> > Hi Michael,
> >
> > I did a survey and we currently have 28 Kirkwood boards. Using some
> > commands and filters, here are the finding.
> >
> > git grep -li arch_kirkwood configs | xargs grep DEVICE_TREE | cut -d '"=
' -f2 | xargs -n1 sh -c 'diff -qs  arch/arm/dts/$1.dts dts/upstream/src/arm=
/marvell/$1.dts' sh | grep differ
> >
> > diff: dts/upstream/src/arm/marvell/kirkwood-atl-sbx81lifkw.dts: No such=
 file or directory
> > diff: dts/upstream/src/arm/marvell/kirkwood-atl-sbx81lifxcat.dts: No su=
ch file or directory
> >
> > Files arch/arm/dts/kirkwood-dockstar.dts and dts/upstream/src/arm/marve=
ll/kirkwood-dockstar.dts differ
> > Files arch/arm/dts/kirkwood-dreamplug.dts and dts/upstream/src/arm/marv=
ell/kirkwood-dreamplug.dts differ
> > Files arch/arm/dts/kirkwood-goflexnet.dts and dts/upstream/src/arm/marv=
ell/kirkwood-goflexnet.dts differ
> > Files arch/arm/dts/kirkwood-guruplug-server-plus.dts and dts/upstream/s=
rc/arm/marvell/kirkwood-guruplug-server-plus.dts differ
> > Files arch/arm/dts/kirkwood-iconnect.dts and dts/upstream/src/arm/marve=
ll/kirkwood-iconnect.dts differ
> > Files arch/arm/dts/kirkwood-net2big.dts and dts/upstream/src/arm/marvel=
l/kirkwood-net2big.dts differ
> > Files arch/arm/dts/kirkwood-ns2max.dts and dts/upstream/src/arm/marvell=
/kirkwood-ns2max.dts differ
> > Files arch/arm/dts/kirkwood-ns2mini.dts and dts/upstream/src/arm/marvel=
l/kirkwood-ns2mini.dts differ
> > Files arch/arm/dts/kirkwood-nsa310s.dts and dts/upstream/src/arm/marvel=
l/kirkwood-nsa310s.dts differ
> > Files arch/arm/dts/kirkwood-nsa325.dts and dts/upstream/src/arm/marvell=
/kirkwood-nsa325.dts differ
> > Files arch/arm/dts/kirkwood-openrd-client.dts and dts/upstream/src/arm/=
marvell/kirkwood-openrd-client.dts differ
> >
> > diff -qrbu arch/arm/dts/ dts/upstream/src/arm/marvell/ | grep kirkwood =
| grep ".dtsi "
> >
> > Files arch/arm/dts/kirkwood-6192.dtsi and dts/upstream/src/arm/marvell/=
kirkwood-6192.dtsi differ
> > Files arch/arm/dts/kirkwood-6281.dtsi and dts/upstream/src/arm/marvell/=
kirkwood-6281.dtsi differ
> > Files arch/arm/dts/kirkwood-98dx4122.dtsi and dts/upstream/src/arm/marv=
ell/kirkwood-98dx4122.dtsi differ
> > Files arch/arm/dts/kirkwood-dnskw.dtsi and dts/upstream/src/arm/marvell=
/kirkwood-dnskw.dtsi differ
> > Files arch/arm/dts/kirkwood.dtsi and dts/upstream/src/arm/marvell/kirkw=
ood.dtsi differ
> > Files arch/arm/dts/kirkwood-lsxl.dtsi and dts/upstream/src/arm/marvell/=
kirkwood-lsxl.dtsi differ
> > Files arch/arm/dts/kirkwood-nsa3x0-common.dtsi and dts/upstream/src/arm=
/marvell/kirkwood-nsa3x0-common.dtsi differ
> > Files arch/arm/dts/kirkwood-synology.dtsi and dts/upstream/src/arm/marv=
ell/kirkwood-synology.dtsi differ
> >
> > And after reviewing these differences, the following are my observation=
.
> >
> > OF_LIST is not used in these Kirkwood boards.
> >
> > 1. Boards that have only u-boot DTS that should be opt-out for now with=
 "#CONFIG_OF_UPSTREAM is not set"
> >
> > diff: dts/upstream/src/arm/marvell/kirkwood-atl-sbx81lifkw.dts: No such=
 file or directory
> > diff: dts/upstream/src/arm/marvell/kirkwood-atl-sbx81lifxcat.dts: No su=
ch file or directory
> >
> > 2. DTS and DTSI files that have only cosmetic, style, or binding change=
s (safe to take)
> >
> > Files arch/arm/dts/kirkwood-dockstar.dts and dts/upstream/src/arm/marve=
ll/kirkwood-dockstar.dts differ
> > Files arch/arm/dts/kirkwood-goflexnet.dts and dts/upstream/src/arm/marv=
ell/kirkwood-goflexnet.dts differ
> > Files arch/arm/dts/kirkwood-guruplug-server-plus.dts and dts/upstream/s=
rc/arm/marvell/kirkwood-guruplug-server-plus.dts differ
> > Files arch/arm/dts/kirkwood-iconnect.dts and dts/upstream/src/arm/marve=
ll/kirkwood-iconnect.dts differ
> > Files arch/arm/dts/kirkwood-net2big.dts and dts/upstream/src/arm/marvel=
l/kirkwood-net2big.dts differ
> > Files arch/arm/dts/kirkwood-ns2max.dts and dts/upstream/src/arm/marvell=
/kirkwood-ns2max.dts differ
> > Files arch/arm/dts/kirkwood-ns2mini.dts and dts/upstream/src/arm/marvel=
l/kirkwood-ns2mini.dts differ
> > Files arch/arm/dts/kirkwood-nsa325.dts and dts/upstream/src/arm/marvell=
/kirkwood-nsa325.dts differ
> > Files arch/arm/dts/kirkwood-openrd-client.dts and dts/upstream/src/arm/=
marvell/kirkwood-openrd-client.dts differ
> >
> > Files arch/arm/dts/kirkwood-dnskw.dtsi and dts/upstream/src/arm/marvell=
/kirkwood-dnskw.dtsi differ
> > Files arch/arm/dts/kirkwood.dtsi and dts/upstream/src/arm/marvell/kirkw=
ood.dtsi differ
> > Files arch/arm/dts/kirkwood-synology.dtsi and dts/upstream/src/arm/marv=
ell/kirkwood-synology.dtsi differ
> >
> > 3. DTS files that are newer in upstream (safe to take with regression t=
est)
> >
> > Files arch/arm/dts/kirkwood-nsa310s.dts and dts/upstream/src/arm/marvel=
l/kirkwood-nsa310s.dts differ
> >
> > 4. DTSI files that have additional PCI-related bindings in upstream (sa=
fe to take with regression test)
> >
> > Files arch/arm/dts/kirkwood-6192.dtsi and dts/upstream/src/arm/marvell/=
kirkwood-6192.dtsi differ
> > Files arch/arm/dts/kirkwood-6281.dtsi and dts/upstream/src/arm/marvell/=
kirkwood-6281.dtsi differ
> > Files arch/arm/dts/kirkwood-98dx4122.dtsi and dts/upstream/src/arm/marv=
ell/kirkwood-98dx4122.dtsi differ
> >
> > 5. DTSI files that will need new or modified -u-boot.dtsi
> >
> > Files arch/arm/dts/kirkwood-dreamplug.dts and dts/upstream/src/arm/marv=
ell/kirkwood-dreamplug.dts differ
> > Files arch/arm/dts/kirkwood-lsxl.dtsi and dts/upstream/src/arm/marvell/=
kirkwood-lsxl.dtsi differ
> > Files arch/arm/dts/kirkwood-nsa3x0-common.dtsi and dts/upstream/src/arm=
/marvell/kirkwood-nsa3x0-common.dtsi differ
> >
> > So these u-boot.dtsi files need to be created/modified so we can use up=
stream DTS/DTSI:
> >
> >         modified:   arch/arm/dts/kirkwood-lschlv2-u-boot.dtsi
> >         modified:   arch/arm/dts/kirkwood-lsxhl-u-boot.dtsi
> >
> >         new file:   arch/arm/dts/kirkwood-dreamplug-u-boot.dtsi
> >         new file:   arch/arm/dts/kirkwood-nsa325-u-boot.dtsi
> >
> > I've regression tested this patch with the Zyxel NSA325 (Kirkwood 88F62=
82)
> > and Zyxel NSA310S (Kirkwood 88F6281). The Zyxel NSA325 board has a
> > USB 3.0 controller attached to the PCIe bus. And the Zyxel NSA310S
> > has an extensive overhaul in bindings and styles in upstream DTS versio=
n.
> >
> > Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> > ---
> >
> >  arch/arm/dts/kirkwood-dreamplug-u-boot.dtsi | 7 +++++++
> >  arch/arm/dts/kirkwood-lschlv2-u-boot.dtsi   | 6 ++++--
> >  arch/arm/dts/kirkwood-lsxhl-u-boot.dtsi     | 6 ++++--
> >  arch/arm/dts/kirkwood-nsa325-u-boot.dtsi    | 7 +++++++
> >  arch/arm/mach-kirkwood/Kconfig              | 4 ++++
> >  configs/SBx81LIFKW_defconfig                | 1 +
> >  configs/SBx81LIFXCAT_defconfig              | 1 +
> >  configs/d2net_v2_defconfig                  | 2 +-
> >  configs/dns325_defconfig                    | 2 +-
> >  configs/dockstar_defconfig                  | 2 +-
> >  configs/dreamplug_defconfig                 | 2 +-
> >  configs/ds109_defconfig                     | 2 +-
> >  configs/goflexhome_defconfig                | 2 +-
> >  configs/guruplug_defconfig                  | 2 +-
> >  configs/ib62x0_defconfig                    | 2 +-
> >  configs/iconnect_defconfig                  | 2 +-
> >  configs/inetspace_v2_defconfig              | 2 +-
> >  configs/lschlv2_defconfig                   | 2 +-
> >  configs/lsxhl_defconfig                     | 2 +-
> >  configs/nas220_defconfig                    | 2 +-
> >  configs/net2big_v2_defconfig                | 2 +-
> >  configs/netspace_lite_v2_defconfig          | 2 +-
> >  configs/netspace_max_v2_defconfig           | 2 +-
> >  configs/netspace_mini_v2_defconfig          | 2 +-
> >  configs/netspace_v2_defconfig               | 2 +-
> >  configs/nsa310s_defconfig                   | 2 +-
> >  configs/nsa325_defconfig                    | 2 +-
> >  configs/openrd_base_defconfig               | 2 +-
> >  configs/openrd_client_defconfig             | 2 +-
> >  configs/openrd_ultimate_defconfig           | 2 +-
> >  configs/pogo_e02_defconfig                  | 2 +-
> >  configs/pogo_v4_defconfig                   | 2 +-
> >  configs/sheevaplug_defconfig                | 2 +-
> >  33 files changed, 54 insertions(+), 30 deletions(-)
> >  create mode 100644 arch/arm/dts/kirkwood-dreamplug-u-boot.dtsi
> >  create mode 100644 arch/arm/dts/kirkwood-nsa325-u-boot.dtsi
> >
> > diff --git a/arch/arm/dts/kirkwood-dreamplug-u-boot.dtsi b/arch/arm/dts=
/kirkwood-dreamplug-u-boot.dtsi
> > new file mode 100644
> > index 0000000000..59f19a211f
> > --- /dev/null
> > +++ b/arch/arm/dts/kirkwood-dreamplug-u-boot.dtsi
> > @@ -0,0 +1,7 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +
> > +/ {
> > +       aliases {
> > +               spi0 =3D &spi0;
> > +       };
> > +};
> > diff --git a/arch/arm/dts/kirkwood-lschlv2-u-boot.dtsi b/arch/arm/dts/k=
irkwood-lschlv2-u-boot.dtsi
> > index 7fc2d7d3b4..cf33ff822e 100644
> > --- a/arch/arm/dts/kirkwood-lschlv2-u-boot.dtsi
> > +++ b/arch/arm/dts/kirkwood-lschlv2-u-boot.dtsi
> > @@ -1,7 +1,9 @@
> >  // SPDX-License-Identifier: GPL-2.0+
> >
> > -&eth0 {
> > -       status =3D "disabled";
> > +/ {
> > +       aliases {
> > +               spi0 =3D &spi0;
> > +       };
> >  };
> >
> >  &hdd_power {
> > diff --git a/arch/arm/dts/kirkwood-lsxhl-u-boot.dtsi b/arch/arm/dts/kir=
kwood-lsxhl-u-boot.dtsi
> > index 7fc2d7d3b4..cf33ff822e 100644
> > --- a/arch/arm/dts/kirkwood-lsxhl-u-boot.dtsi
> > +++ b/arch/arm/dts/kirkwood-lsxhl-u-boot.dtsi
> > @@ -1,7 +1,9 @@
> >  // SPDX-License-Identifier: GPL-2.0+
> >
> > -&eth0 {
> > -       status =3D "disabled";
> > +/ {
> > +       aliases {
> > +               spi0 =3D &spi0;
> > +       };
> >  };
> >
> >  &hdd_power {
> > diff --git a/arch/arm/dts/kirkwood-nsa325-u-boot.dtsi b/arch/arm/dts/ki=
rkwood-nsa325-u-boot.dtsi
> > new file mode 100644
> > index 0000000000..dec27b2a87
> > --- /dev/null
> > +++ b/arch/arm/dts/kirkwood-nsa325-u-boot.dtsi
> > @@ -0,0 +1,7 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +
> > +&nand {
> > +       partition@0 {
> > +               /delete-property/ read-only;
> > +       };
> > +};
> > diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kc=
onfig
> > index c2fff84a68..39593c83d0 100644
> > --- a/arch/arm/mach-kirkwood/Kconfig
> > +++ b/arch/arm/mach-kirkwood/Kconfig
> > @@ -28,6 +28,10 @@ config CUSTOM_SYS_INIT_SP_ADDR
> >          depends on HAS_CUSTOM_SYS_INIT_SP_ADDR
> >          default 0x5ff000
> >
> > +config OF_UPSTREAM
> > +       bool "Use upstream DTS for Kirkwood boards"
> > +       default y
>
> You don't have to create a new config option here, just add "imply
> OF_UPSTREAM" for the SoC which you want to switch, something like:
>
> diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kcon=
fig
> index c2fff84a686..031d4e5ecd3 100644
> --- a/arch/arm/mach-kirkwood/Kconfig
> +++ b/arch/arm/mach-kirkwood/Kconfig
> @@ -6,10 +6,12 @@ config FEROCEON_88FR131
>  config KW88F6192
>         bool
>         select ARCH_VERY_EARLY_INIT
> +       imply OF_UPSTREAM
>
>  config KW88F6281
>         bool
>         select ARCH_VERY_EARLY_INIT
> +       imply OF_UPSTREAM
>
>  config SHEEVA_88SV131
>         bool

Thanks! That's a better way indeed. I'll send v2.

All the best,
Tony

>
> -Sumit
