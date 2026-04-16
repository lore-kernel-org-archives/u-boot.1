Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30826F8DFC1
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 21:09:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75A8C840AB;
	Thu, 16 Apr 2026 23:09:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CqUKEgfs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AA2E84214; Thu, 16 Apr 2026 23:09:13 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC6A583FC0
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 23:09:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2b2ea1b3962so33151985ad.0
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 14:09:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776373749; cv=none;
 d=google.com; s=arc-20240605;
 b=gkuIL3i9I9ZYXHJ7xfav9M+FCHS5Ql5HxnUHVjC5bw+HalK2x6tvDSyt7j5OU+rbvn
 QPsb6jMogb0pEaozZJZB5wf3vDcNf6zJ9lqoKxoVRCA+ohEwEd8+38o2HDkoEgmDBD+V
 URCYbW9QQsZbnZ+1zNR9BIHoouaiHiush2jBmUIl/xN7437e073n2qQjfL+AqvyOSd1C
 qOMFCI+e4wM/Bru2VotZCynNPAvSO0/w4YInCcjOqnA0RLHjCs0DBoSgSqri5TNRE5Xm
 IkJQEGDJkADkJFIIzavnskZu7AlEGKU4k7YFQLbo92u5HFEovecmW++eQJD7o0i2PusQ
 Q8JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lpXJaoOet4salwBKU+Xsei1yUHB+jMCTPtfFhFuTNTw=;
 fh=xzHwBz7YVwVTzOkq5RbqDBAwkzxy5sD4Lvb4Det1Qb4=;
 b=KZ6nYOQLqRcPGQurmgj422occItUjjgONMxrhLBxOHfVog5mJMDby66N2p5if3ZGMU
 We5ZjHy7+fL/BrUS3O7V1JNJGDjvAtafMp8kuLTXHFWhS/mydyJbJxkHSG0whZpHGsPg
 SEs0chTnqCUW9TuhCPNxIC1oBoxkAOILVaXLTC4UCpZu7wev9MqDpt5GPd8VYWkf50aE
 R7R0Y5nf3ULoxNVsXHt2QevqLitKbOrNhuYPlXlSJX9AUiyP/GHROAwg2VwCozs+N1r8
 BPQIwsOAmzI7IuzEEyqwi0teEdbpkXXBlQApMQBAzvsTL+fNx1qexWA8OwhnNnEzuMII
 hT6A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776373749; x=1776978549; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lpXJaoOet4salwBKU+Xsei1yUHB+jMCTPtfFhFuTNTw=;
 b=CqUKEgfscmnPCJ81Q1xigWM37+7y7hOouTzd0NzATQ+vVt5kwQuENeQQmUNigDAt/n
 oxsfexzvBV0fE9RYPzOK2wAumGfLRxCclDAz/mmyvIKu6fVefewv0/xt4ooxBI52SkWS
 Gk4IOLpvvzVG0ag0ChBZQqcO7zlwWrUrcLT+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776373749; x=1776978549;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lpXJaoOet4salwBKU+Xsei1yUHB+jMCTPtfFhFuTNTw=;
 b=K2jr8FcMS5+wKZZZbUbeO70omaURND8MirzR9erLL6pAvKrncLTlqhtZqFZSgc/y8N
 1aNNYBcrtGDB9fyRCAoTOYdPHZDQoxQnMR4086EjA35VLvOpZUH8hHptdUssVdUjnjLv
 PwDZCSbLRv2qTaVzb70EM3HhtnQfKOiixN+Ei1BIdudGohuJ5/WmAtS/AyEq8d3RA3xp
 TiY5bzDUEtVSjxKAn0E04FTGn9lIsM8WdabzqilhJQMVsXY2SSQmVqTQwPtFe2AfOPUD
 51rXIqP7c8IUp/jsf3r/BVUvH/RfXq6fsJMCYMn1NREbGtjmo8OlRuosFXBncJEtd8mp
 Y/Ng==
X-Forwarded-Encrypted: i=1;
 AFNElJ+IwnGKxxJLZUmD9F18vlS78bKhFPjy1ADV9xekmCYBm5/Dbv9HS6fKw4QDJLgJGXVWjd1bZJ4=@lists.denx.de
X-Gm-Message-State: AOJu0Yx4Z1RWmhdi+i+hAcSeArkPYQqMAXaBaFysVQt2YaJuz4jPbGPX
 QqwUU/xUQlkMpXrb0SDpm9uYpX4FwSMn15XY20WIM2o34NLxZLv1mujsYT49mVQO5OUqTR4xkNB
 AWEuYZfpLRQe1E8e/xvNcaLWPLXf6iNE3O5sUgEcE
X-Gm-Gg: AeBDievZ04QrDTKaEVrRIbjg3RE5ABb9WznVKQvnOql2DE2UmzupA+sBUzEcpnw1PTD
 QY4PF+wO+2af/mIaIyuuLoLfDnBAmv/n1XgrwNAGDjKlPJOPmmzEt+Zar9c9sSFYmLcJ7IohBcf
 j8Wv3nRYruVnlWsDHgsKi6oHWvm7190B1CIZBgH99cVPKlCfiB6SA5ceV6YunZgxlMGSMz7+1R9
 SwwMvpccz+kIntiWYxLvGHG8RlW/Kvwwu0S1updhoJZ3yGrjPyPLpJz3Uic2uPG2VGXQXlew4tI
 gsmuQUIoByiRrwYg8OE4
X-Received: by 2002:a17:902:9001:b0:2b4:5893:3f3c with SMTP id
 d9443c01a7336-2b5f9ef4c3fmr214385ad.13.1776373749036; Thu, 16 Apr 2026
 14:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260416084535.1490476-1-ghidoliemanuele@gmail.com>
 <20260416084535.1490476-3-ghidoliemanuele@gmail.com>
In-Reply-To: <20260416084535.1490476-3-ghidoliemanuele@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Apr 2026 09:08:54 +1200
X-Gm-Features: AQROBzC8TVxfFHc_OFWuoCBIBbBxoaTtnt9ixTakRwyPwWRkXeoleZWsQ-UmiMc
Message-ID: <CAFLszTi_YHJY2drp9iMT9-cSghZGjQbJ5jKTVq4HxY06J51KKw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] board: toradex: add Toradex Verdin iMX95
To: ghidoliemanuele@gmail.com
Cc: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, Peng Fan <peng.fan@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
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

Hi Emanuele,

On 2026-04-16T08:45:22, Emanuele Ghidoli <ghidoliemanuele@gmail.com> wrote:
> board: toradex: add Toradex Verdin iMX95
>
> Add support for the Toradex Verdin iMX95.
>
> Link: https://www.toradex.com/computer-on-modules/verdin-arm-family/nxp-imx95
> Link: https://www.toradex.com/products/carrier-board/verdin-development-board-kit
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> Co-developed-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> Co-developed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
>
> arch/arm/dts/imx95-verdin-dev.dtsi             |  239 +++++
>  arch/arm/dts/imx95-verdin-wifi-dev-u-boot.dtsi |  112 +++
>  arch/arm/dts/imx95-verdin-wifi-dev.dts         |   21 +
>  arch/arm/dts/imx95-verdin-wifi.dtsi            |   50 +
>  arch/arm/dts/imx95-verdin.dtsi                 | 1172 ++++++++++++++++++++++++
>  arch/arm/mach-imx/imx9/Kconfig                 |    5 +
>  board/toradex/verdin-imx95/Kconfig             |   36 +
>  board/toradex/verdin-imx95/MAINTAINERS         |   13 +
>  board/toradex/verdin-imx95/Makefile            |    8 +
>  board/toradex/verdin-imx95/spl.c               |   75 ++
>  board/toradex/verdin-imx95/verdin-imx95.c      |   79 ++
>  board/toradex/verdin-imx95/verdin-imx95.env    |   20 +
>  configs/verdin-imx95_defconfig                 |  183 ++++
>  doc/board/toradex/index.rst                    |    1 +
>  doc/board/toradex/verdin-imx95.rst             |  171 ++++
>  include/configs/verdin-imx95.h                 |   27 +
>  16 files changed, 2212 insertions(+)

> diff --git a/include/configs/verdin-imx95.h b/include/configs/verdin-imx95.h
> @@ -0,0 +1,27 @@
> +/* For 32GB modules: 2GB from 0x80000000..0xffffffff, 30GB above.
> + * Actual size is determited at runtime.

determined

> diff --git a/board/toradex/verdin-imx95/verdin-imx95.c b/board/toradex/verdin-imx95/verdin-imx95.c
> @@ -0,0 +1,79 @@
> +const struct ram_alias_check ram_alias_check[] = {
> +     { (void *)(PHYS_SDRAM + SZ_8G), (void *)(PHYS_SDRAM), SZ_16G },
> +     { (void *)(PHYS_SDRAM + SZ_4G), (void *)(PHYS_SDRAM), SZ_8G },
> +     { (void *)(PHYS_SDRAM + SZ_2G), (void *)(PHYS_SDRAM), SZ_4G },
> +     { (void *)(PHYS_SDRAM + SZ_1G), (void *)(PHYS_SDRAM), SZ_2G },
> +     { NULL }
> +};

How about ram_alias_checks[] to avoid confusion with the type. Also,
can it be static?

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
