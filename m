Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3502C0218A
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 13:03:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39E138129F;
	Mon, 27 Jan 2025 14:02:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IfQyqOU1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81AE08111F; Mon, 27 Jan 2025 11:24:40 +0100 (CET)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E64CC81115
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 11:24:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e3990f53d30so669394276.1
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 02:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737973476; x=1738578276; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hKbMyZgLMAKk6h8evcBPSMcwtYwF8NvtbtvLgFJd34E=;
 b=IfQyqOU1Y2S7QGCAIOeDeMhds+UphaFAUwIeV6WJsSif8rCmO9ZMD+D1jOK7TyUOIR
 P55v7/2gOij8Kj9muiGD/lNn80kfjTzHrY004yPTJz/QK9nJVXYvzh98GSIvfTWyu3fB
 Vkc0JuUeajHR77j5g/iD3I8R3v0cKHQNQ3NmRV55TrBfKlqkT5g+nfXpWJ5j14eL09FK
 E92mLVIoVoNdnieiuijtpxAfRXKtfXTwWhyppV6jk+uVW433jqaXDzY3HReZVBiIBGpD
 58zHCudgNk/Ll4POGGBa9QGVfYCMfNWj7Wy26e88z94HEonxsy2mRuH2WKl4fCdIgTes
 5OSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737973476; x=1738578276;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hKbMyZgLMAKk6h8evcBPSMcwtYwF8NvtbtvLgFJd34E=;
 b=oGAo+KS6P9tRJYtz5ZFvR15Afq0/88bkkkMTwGJC5DEhVj2RROJQkYSwTNLaGDcdAl
 pj175UufN1MsjpQ0zCCq3x16y0N9HHMBcz+jTC61KojpWY6pU+N9+rEDcGaugEhru3/H
 3nfPg2aSrNzRy0rI4loR4ewtkv3MzFbV02o6FEPVHs2VRMOcGBiru2P8DMBq/tryofU9
 2aih2f8qejzKWtUgTCctIOEr8XZ76e7UAJblJydbJ0lTKsXFbBKyBLmwj3oJ06tdl/+k
 kbrjNO4GuFrEJf6PoPLqmId+OMMi/tImXWA1xPuwjqTBLvtWsU88+ZCW6VYi4qB4tVRL
 Kyaw==
X-Gm-Message-State: AOJu0YyN64aiwJyoS9RC1yRu1tBgNIqytH1KW1o2I/xVw4N7hEywIfqR
 khFqOnimakQauwJT9svIC3g0nC2ZZ3cx4E07nRYavtseya9eI3d6qJ91fhRLR+g3u9cMuPUX1I+
 /8sWf6OUQaFvJlycO8DGdMslCjnI=
X-Gm-Gg: ASbGncudOnn9Bc4iD7p5y4dqEOyW953v7S1ptoJL+I3WLkGZlzm/E+vWb5HCbyfLsRa
 KKb3qLrQfUp6Tx4yf3aCppA9n+5OpVY0Hv+qvh6CRupjHMyBZUpkADZS3rl0jTOdsAexI1i6K
X-Google-Smtp-Source: AGHT+IH2PuJq0OYbcLwaWoMX+6xkQ7xTAxPz9YyZ3SAm4HwJOjdK0CfFQqDc6zGdXNo0ruhjG6tTPYcLIv/bZU9UZyo=
X-Received: by 2002:a05:6902:2b09:b0:e4a:ea18:b45c with SMTP id
 3f1490d57ef6-e57b13607d1mr12381728276.8.1737973476620; Mon, 27 Jan 2025
 02:24:36 -0800 (PST)
MIME-Version: 1.0
References: <20241026155220.26300-1-l.rubusch@gmail.com>
 <20241026155220.26300-4-l.rubusch@gmail.com>
 <DM8PR11MB5592B8B7BEB3B45165FD8EECD2E62@DM8PR11MB5592.namprd11.prod.outlook.com>
In-Reply-To: <DM8PR11MB5592B8B7BEB3B45165FD8EECD2E62@DM8PR11MB5592.namprd11.prod.outlook.com>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Mon, 27 Jan 2025 11:24:00 +0100
X-Gm-Features: AWEUYZlfn0dzQO3np8dzXIE8PcrUMwJsKe6UTO04gVBoKmNgBxb8hnPDzP1fUWc
Message-ID: <CAFXKEHYGUodqYn0WaVy=b_i+U00qp+isDv_6xu1nWWNGKxbaQg@mail.gmail.com>
Subject: Re: [PATCH v4 03/11] ARM: dts: socfpga: add Mercury+ AA1 for u-boot
 dts
To: "Chee, Tien Fong" <tien.fong.chee@intel.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "trini@konsulko.com" <trini@konsulko.com>, 
 "marex@denx.de" <marex@denx.de>, 
 "simon.k.r.goldschmidt@gmail.com" <simon.k.r.goldschmidt@gmail.com>, 
 "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
 "sjg@chromium.org" <sjg@chromium.org>, 
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>,
 "michal.simek@amd.com" <michal.simek@amd.com>, 
 "Lim, Jit Loon" <jit.loon.lim@intel.com>,
 "barnas@google.com" <barnas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 27 Jan 2025 14:02:41 +0100
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

On Tue, Jan 21, 2025 at 11:03=E2=80=AFAM Chee, Tien Fong
<tien.fong.chee@intel.com> wrote:
>
> Hi,
>

Dear Tien Fong Chee,

> -----Original Message-----
> From: Lothar Rubusch <l.rubusch@gmail.com>
> Sent: Saturday, October 26, 2024 11:52 PM
> To: u-boot@lists.denx.de; trini@konsulko.com; marex@denx.de; simon.k.r.go=
ldschmidt@gmail.com; Chee, Tien Fong <tien.fong.chee@intel.com>; sumit.garg=
@linaro.org
> Cc: sjg@chromium.org; xypron.glpk@gmx.de; michal.simek@amd.com; Lim, Jit =
Loon <jit.loon.lim@intel.com>; barnas@google.com; l.rubusch@gmail.com
> Subject: [PATCH v4 03/11] ARM: dts: socfpga: add Mercury+ AA1 for u-boot =
dts
>
> Introduce u-boot specific device-tree files for Enclustra Mercury+ AA1 So=
Ms (Intel/arria10).
>
> Generic device-tree fragments for linux and U-boot shall be provided in d=
ts/upstream. The selection of the generic device-tree fragments depends on =
a selected boot-mode and a selected carrier board.
>
> On Intel/Arria10 a handoff setup is needed for initialization of various =
clock / pinmux / DRAM settings only used by U-Boot provided by the current =
patch.
>
> Signed-off-by: Andreas Buerkler <andreas.buerkler@enclustra.com>
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  ..._arria10_enclustra_mercury_aa1-u-boot.dtsi |  45 +++  .../socfpga_arr=
ia10_enclustra_mercury_aa1.dts |  45 +++
>  .../socfpga_arria10_mercury_aa1-u-boot.dtsi   |  19 ++
>  .../dts/socfpga_arria10_mercury_aa1_handoff.h | 305 ++++++++++++++++++
>  board/enclustra/mercury_aa1/Kconfig           |  37 +++
>  board/enclustra/mercury_aa1/MAINTAINERS       |   2 +
>  6 files changed, 453 insertions(+)
>  create mode 100644 arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1-u-=
boot.dtsi
>  create mode 100644 arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1.dt=
s
>  create mode 100644 arch/arm/dts/socfpga_arria10_mercury_aa1_handoff.h
>
> diff --git a/arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1-u-boot.dt=
si b/arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1-u-boot.dtsi
> new file mode 100644
> index 0000000000..6e38286572
> --- /dev/null
> +++ b/arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1-u-boot.dtsi
> @@ -0,0 +1,45 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +/*
> + * Copyright (C) 2024 Lothar Rubusch <l.rubusch@gmail.com>  */
> +
> +/* Arria10 handoff (u-boot) */
> +#include "socfpga_arria10_mercury_aa1_handoff.h"
> +#include "socfpga_arria10-handoff.dtsi"
> +#include "socfpga_arria10_handoff_u-boot.dtsi"
> +#include "socfpga_arria10_mercury_aa1-u-boot.dtsi"
> +
> +/* Specific boot-mode (u-boot) */
> +#if IS_ENABLED(CONFIG_ENCLUSTRA_SDMMC) ||
> +IS_ENABLED(CONFIG_ENCLUSTRA_EMMC)
> +
> +/ {
> +       fs_loader0: fs-loader {
> +               bootph-all;
> +               compatible =3D "u-boot,fs-loader";
> +               phandlepart =3D <&mmc 1>;
> +       };
> +};
> +
> +&fpga_mgr {
> +       bootph-all;
> +       firmware-loader =3D <&fs_loader0>;
> +       altr,bitstream =3D "fpga.itb";
> +};
> +
> +#elif IS_ENABLED(CONFIG_ENCLUSTRA_QSPI)
> +
> +/ {
> +       fs_loader0: fs-loader {
> +               bootph-all;
> +               compatible =3D "u-boot,fs-loader";
> +               sfconfig =3D <0 0 50000000 3>;
>
> The RAW read implementation in fs_loader is not upstream yet, I afraid th=
is might not working, you want help to upstream?
>

Thank you so much for coming back to me! The TL;DR answer is, yes.
Pls, start by fixing Intel platform maintenance in the Linux kernel
for old Intel/socfpga.

For the long story, there are several points here which are probably
not quite transparent just on u-boot ML. Let me clarify. Personally, I
have access to some Enclustra hardware and was curious what it would
take to upstream it. This was/is driven mainly by my private interest,
since the company gives a ...does not care about open source. As you
will easily spot those Intel platforms are not the most recent Intel
products either. I picked them a bit on purpose, since I did not want
to "mess it up" for that company with my personal upstream in the
first approach. If it went upstream, it could be the basis for further
Enclustra Hardware i.e. Xilinx/AMD, Microchip and more recent Intel.
That's a bit the background and intention.

So, when I started last summer, u-boot community stared with dts
upstream. Means, my DTS material needed to be prepared and split up
into a linux kernel part and a u-boot part. Due to the bitstream
handling and early initialization of registers, also, the u-boot DTS
went partly into dts-upstream, and partly into the classic DTS places
for he intel/socfpga platform. I managed to implement a dynamically
adjusted Enclustra DTS, based kconfig option. At the end of the day,
this all resulted in the dependency to have DTS material upstream in
the linux kernel repo.

Both patchsets were actually prepared and presented on the MLs. For
u-boot, you will find all communication concerning the u-boot patches
here on this ML. Where for the kernel patches, I got the more general
patches ACK'd. But the Intel maintainer Dinh Nguyen did not manage to
give feedback. I was even able to contact Dinh directly, and he gave
me back that he plans on doing. This was in fall 2024. No update since
then. - Here is, IMHO, where you Intel guys could really help work on
solving this situation: Either help out Dinh for the kernel stuff, or
organize replacement. Don't get me wrong, this is not meant to be
personal. I'm sure he will have good reasons if he cannot carry out
this job currently. Means put up someone who will (co-)maintain the
old Intel platforms in the Linux kernel. Also, the Intel/socfpga
dt-bindings need to be written in YAML, AFAIR. That's why e.g. Rob's
DT-check bot will almost blast you with errors with the comment "can
be accepted if the specific platform maintainer is willing to".
Platform maintainer does not answer, and I'm not willing writing the
YAML dt-bindings for ye olde Intel, when there is no maintainer
eventually accepting it.. Hence, accepting the Enclustra Intel DTS,
would mean to accept them w/o the updated and checked dt-bindings.

For the (technical) rest: I have full access to the hardware, i.e. 3
different Arria10 SOMs of Enclustra, as 2 further Cyclone5 SOMs. All
can be combined with 3 different carrier boards of Enclustra. The
setups are booting in different boot modes (SD, eMMC and some from
QSPI flash). After the DTS separation, (re)implementing the
mini-drivers based on u-boot DM, I needed to migrate the setup using
binman. Building, flashing and booting into a functional u-boot, is
verified for all setups. As you mentioned, parts in the u-boot API
are/were still under development, though, but Marek kept me in the
loop here (also on ML).

I appreciate your patience, for reading this all. In a conclusion, the
products are still sold. Yes, they are a bit ancient.. what eventually
blocked it, is IMHO rather kenel maintenance for old Intel platforms
which seems orphaned. For me personally, it already paid off a lot
from what I could learn! - Yes, I'd love to see the stuff upstream.
There seems to be less love by Intel, though, for its socfpga
platforms on Linux. ;)

Best,
L


> [...]
>
> Best regards,
> TF
