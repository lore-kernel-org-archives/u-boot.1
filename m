Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E64D13588
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 03:35:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 720CF8895E;
	Mon, 28 Oct 2024 04:35:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rn3p+WQU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1BE988AB2; Mon, 28 Oct 2024 04:35:06 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E881F885F4
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 04:35:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-53a0c160b94so4179805e87.2
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 20:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730086501; x=1730691301; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L9uQ/XDPVIvWq0DldVRRpWZCS8PVdgZM+UyAcuMbk/c=;
 b=Rn3p+WQUaYHxTDsSv2KgAt6F5sPLuWxrFIjW40kv4Sw6aR5sglS02BDmOuR9PACQlP
 gY5PXA4QGXTtv1A9P1EE1L8qEmrDUPvintUlVBRZtUBeTpEPu5xQDd6hraECH8yKaCz+
 o3sb5OqR3XSn5kMxF0rjkSdq2OeCPj0BorCwB3r9JqKLJObCcK/DGub3PGqkW/YiSfYj
 4KlPaedS5h7FrAl/aWfpu83w9E2EQGypZ7ftxmF4V2Ntj7P7Ki3TMlIlowuuveiJkvN9
 ED0GsBsMHLbTniMvub98NKXnXP55qRfDaJs+/X5K1tQxHhaRYDcQ9ZMbEgih1VQL9r2q
 nbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730086501; x=1730691301;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L9uQ/XDPVIvWq0DldVRRpWZCS8PVdgZM+UyAcuMbk/c=;
 b=BNyYgPhRnRq0Ozl501Ez3EdgUdssVrXdlz6n/5y3oWre/dgDtwtsKVGgZq15DP+G1y
 RJeLvSHCb/89kFkupZTPAWucBusgVYLCxHWVrEoSeMeDLw4X08CF5iJ/etutSGc8ubEB
 KdLB2VcbfHu+IhsSGajQVr0rBCJo3Vkn5IR8FRzWS4LXqdKh3pBkqWf56lwG4oWZWaKC
 yYBSJLEOY7jP6Y7slf8tJwHMvo71oDkXFfYI37n0S13uqph91XkryNBtBrkty5XZ/A+s
 45TGfRD4KAgjmJsb6wbzt9ZtkH/+bMD2+/FEBnyzoSx5tziPBmOjus1Vqh39xFzJJgwC
 Uj3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVh01cEhQnSxMBa+4bAbqE+n5hZp1SBPqp1ZwEHhVTLH3jkmIEBuXdOf2IW58Q3r2GXHMf5Ths=@lists.denx.de
X-Gm-Message-State: AOJu0YzaKxxkQW29chLAB28VrVXfOdlOWj5EMEile09wZHA/aYvtian4
 7C1kAorPNYq72dwb7Yco8aid+m0/vUyqEU0kppOjS6Q5HpugI1N6NBDaC+2bIhghmJ/3/F7oHmP
 +nE6ZoY1mpgGZXgJBeQfImAxYm2k=
X-Google-Smtp-Source: AGHT+IHOjzJe2RyMJUb1lp//LmfFLoZ/0WQizdLmJbjksFKEl7kbj4sHq9hMcXio/1GMhqXQh+E7DR6ovSFtyCXXnCo=
X-Received: by 2002:a05:6512:b90:b0:539:de03:d7a7 with SMTP id
 2adb3069b0e04-53b348cee56mr2623676e87.22.1730086500573; Sun, 27 Oct 2024
 20:35:00 -0700 (PDT)
MIME-Version: 1.0
References: <20241028015847.42344-1-hal.feng@starfivetech.com>
 <20241028015847.42344-10-hal.feng@starfivetech.com>
In-Reply-To: <20241028015847.42344-10-hal.feng@starfivetech.com>
From: E Shattow <lucent@gmail.com>
Date: Sun, 27 Oct 2024 20:34:48 -0700
Message-ID: <CANV2PTPvoLJS_zUNoFYbt+PndZEHccbJG0YBK9+0fMS__G4otw@mail.gmail.com>
Subject: Re: [PATCH v2 09/14] riscv: dts: jh7110: Add u-boot device tree for
 JH7110 based boards
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>, 
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Minda Chen <minda.chen@starfivetech.com>, u-boot@lists.denx.de
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

On Sun, Oct 27, 2024 at 6:59=E2=80=AFPM Hal Feng <hal.feng@starfivetech.com=
> wrote:
>
> To support the other JH7110 based boards, add u-boot
> device tree for them.
>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: H Bell <dmoo_dv@protonmail.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi          | 11 +++++++++++
>  arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi       |  6 ++++++
>  .../jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi    |  6 ++++++
>  3 files changed, 23 insertions(+)
>  create mode 100644 arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
>  create mode 100644 arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
>  create mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-b=
oot.dtsi
>
> diff --git a/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi b/arch/riscv/dt=
s/jh7110-milkv-mars-u-boot.dtsi
> new file mode 100644
> index 0000000000..2ad4068549
> --- /dev/null
> +++ b/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2024 StarFive Technology Co., Ltd.
> + */
> +
> +#include "jh7110-common-u-boot.dtsi"
> +
> +&phy0 {
> +       /delete-property/ motorcomm,tx-clk-10-inverted;
> +       rx-internal-delay-ps =3D <1900>;
> +};

For Heinrich, what is the origin of rx-internal-delay-ps 1900 value? Refer =
to:

https://patchwork.ozlabs.org/project/uboot/list/?series=3D429908 "
riscv64: dts: starfive: Mars ethernet0 phy delay values sync with
upstream Linux "

For Hal, I think we should not replace the rx-internal-delay-ps
property here and then the phy delay patch for Mars (as mentioned) is
not needed. Carrying this value from before OF_UPSTREAM creates work
for future, unless you prefer to avoid change in functionality
compared to before OF_UPSTREAM.

> diff --git a/arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi b/arch/riscv=
/dts/jh7110-pine64-star64-u-boot.dtsi
> new file mode 100644
> index 0000000000..9df1e5db55
> --- /dev/null
> +++ b/arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
> @@ -0,0 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2024 StarFive Technology Co., Ltd.
> + */
> +
> +#include "jh7110-common-u-boot.dtsi"

There is a same story here for Pine64 Star64 about delay values. Refer to:

https://patchwork.ozlabs.org/project/uboot/list/?series=3D429906
"riscv64: dts: starfive: Star64 ethernet0 phy delay values sync with
upstream Linux"
https://lore.kernel.org/lkml/20241023-guts-versus-1a2bcfdfbec2@spud/
"[PATCH] riscv: dts: starfive: Update ethernet phy0 delay parameter
values for Star64"

It is your choice if you want to duplicate the upstream patch here to
change the property nodes (or not) until the next dts sync from
upstream, or cherry-pick a dts sync (when that becomes possible after
upstream makes this available). The problem affects only ethernet0
which is well-known as "does not work, try a different network port"
and so it is not any trouble to just ignore the problem here, making
this fix now creates more work for us in the future. Star64 has a
working secondary network port ethernet1 and so no change is requested
from me.

The phy delay value patch for U-Boot and Star64 can be dropped in
favor of the OF_UPSTREAM series and any action or non-action you
decide for this.

> diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dts=
i b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi
> new file mode 100644
> index 0000000000..9df1e5db55
> --- /dev/null
> +++ b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi
> @@ -0,0 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2024 StarFive Technology Co., Ltd.
> + */
> +
> +#include "jh7110-common-u-boot.dtsi"
> --
> 2.43.2
>
