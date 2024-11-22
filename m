Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F088BE65D0A
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 00:28:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ADBA896EC;
	Fri, 22 Nov 2024 01:28:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jt30GIVU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FAE7896F6; Fri, 22 Nov 2024 01:28:39 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2AF2896EC
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 01:28:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2ff550d37a6so18756581fa.0
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 16:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732235316; x=1732840116; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sjjVEl2I7XhzBPOoXO2Y19/4Z9GkVa1hOL6lxlMcXYg=;
 b=jt30GIVUo4Waa76h1/yNXj/iDEOooT91yg7qavpd6jegs/x8dpibprKf1ieWxFbr6r
 AXyW2BLfDA0Lt+7PySonRv/hlO2kMUx96Wnn3A/I3QA4hbGhD4of3B4wQTperSgkolHd
 BwyHUjzvykHQSKm22P9wgwqQ/HJgA3TP4uFyHtlrB77iX/668zHOWMF9xgetMbFxuul1
 +WYPvvfYigKsuyRW8Z3X9dN3xgpNsPnbpmDbHNPl/A+Ox1KqzxACoAafrVLJy+LIFIjt
 m68PO3kKtj0vWaYPcgh6+64uaWyGWA3UDm+nSahPgvFDRGtoWG+XOVWi5/KW9YIBGHU2
 12oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732235316; x=1732840116;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sjjVEl2I7XhzBPOoXO2Y19/4Z9GkVa1hOL6lxlMcXYg=;
 b=JhlcuxfxCG4wxiOfn2L0eBl3MPAvpaevd0J7Wy/c65TRT4IS1IOUW1mov+dgzHkkNa
 YucAfhqJjK6hVzVrvw16XvfTvvG6YGWI+JBY4Wa0vGHT88F8Mhc8KP3P5iMWWn1yLg7i
 TaL9/BBv2qJestUDDqgB4NlophrFpzm5tXWIM+1sr3+9CHrRzyZ8eEI5P/8Ul4WfoMcr
 AsKK00rEmvanugJOhQPn6zc9pkEPZFaLASguzh4A+uSsrvmHFQR9S+bDath25Tspvtf2
 CWHRKI61RnD8Z2wf3XOEhRx70u/F6QXpfcJL9B+XkTuxo/fEyUnxfiUXJxo1X/HkDr1n
 o74A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVH+euzvnL+O5+kGoAgypxjFt+ElLsPNAvGZNS/CEEZFGMub7iqstDa/d13c634Urr3JcyAda4=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+y9/gq0c1vtioe+rzpmCLfFKZ6bEeBML1bDWA1U5UqCsid8+3
 eEoucbb642UMQJGWSNd6qUKGLdWCyGMjTq9PpIcexnuRXe3u1jj3HaM3suAs2aO6dloUOjlylFf
 8+dWtaRqoIGKMW80MRqQtQbvGYao=
X-Gm-Gg: ASbGncs529+0kx3b/SXgfH4D8SJQgF3MF+4elD/qlmVtXwxuUxUK38febKOwcbApT8D
 rBcuIkWm3RkBJfSgjJ9bGvQBIoFr3aZiSem/sqpCfXpIYl094t74dEoeYXfkvG70T4A==
X-Google-Smtp-Source: AGHT+IFnP3NIeHcXYwXAqdMGiz0Jsfc4ro90P1O7jFDLV26Mvbx7/WqgIHRGad001xYEHPJ75kPP/ZgZs2NrDOB2EIg=
X-Received: by 2002:a2e:a903:0:b0:2fb:4ddd:a8f0 with SMTP id
 38308e7fff4ca-2ffa7174afdmr2589461fa.15.1732235315886; Thu, 21 Nov 2024
 16:28:35 -0800 (PST)
MIME-Version: 1.0
References: <20241119020425.51989-1-hal.feng@starfivetech.com>
 <20241119020425.51989-6-hal.feng@starfivetech.com>
In-Reply-To: <20241119020425.51989-6-hal.feng@starfivetech.com>
From: E Shattow <lucent@gmail.com>
Date: Thu, 21 Nov 2024 16:28:24 -0800
Message-ID: <CANV2PTOK2QSWtCFzPX7tSLj+xcs6zc0mn4UafBYcZCjyN6BsTg@mail.gmail.com>
Subject: Re: [PATCH v5 05/11] riscv: dts: jh7110: Add u-boot device tree for
 JH7110 based boards
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Nam Cao <namcao@linutronix.de>, 
 Bo Gan <ganboing@gmail.com>, 
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

On Mon, Nov 18, 2024 at 6:06=E2=80=AFPM Hal Feng <hal.feng@starfivetech.com=
> wrote:
>
> To support the other JH7110 based boards, add u-boot
> device tree for them.
>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: H Bell <dmoo_dv@protonmail.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi           | 10 ++++++++++
>  arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi        |  6 ++++++
>  .../dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi |  6 ++++++
>  3 files changed, 22 insertions(+)
>  create mode 100644 arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
>  create mode 100644 arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
>  create mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-b=
oot.dtsi
>
> diff --git a/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi b/arch/riscv/dt=
s/jh7110-milkv-mars-u-boot.dtsi
> new file mode 100644
> index 0000000000..cf4f0d4c06
> --- /dev/null
> +++ b/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
> @@ -0,0 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2024 StarFive Technology Co., Ltd.
> + */
> +
> +#include "jh7110-common-u-boot.dtsi"
> +
> +&phy0 {
> +       /delete-property/ motorcomm,tx-clk-10-inverted;
> +};

Why delete this property?

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

Reviewed-by: E Shattow <lucent@gmail.com>
