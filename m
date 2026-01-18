Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA925CA5FE1
	for <u-boot@archiver.kernel.org>; Sun, 18 Jan 2026 01:45:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 720BD82BF2;
	Sun, 18 Jan 2026 02:45:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fWIFmTy8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 228848389A; Sun, 18 Jan 2026 02:45:19 +0100 (CET)
Received: from mail-yx1-xb132.google.com (mail-yx1-xb132.google.com
 [IPv6:2607:f8b0:4864:20::b132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10F4C80FA1
 for <u-boot@lists.denx.de>; Sun, 18 Jan 2026 02:45:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-64472121ad5so2262901d50.0
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 17:45:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768700716; cv=none;
 d=google.com; s=arc-20240605;
 b=Zgj00S8ML0y+eOWIW2DbGp+IgQcimquWz9GvP/xW2aDZddvVjQLB2ZGXYunkcAEYRP
 fVAHPTqEqjlALCTMkDC1KTvTwl28gv8HqnvuIWk36pWC6l4fJlm74pcc7YivZo10NIhZ
 0m9iLWGKKFV3OI1JHDMu4y8lRuLLEFbnXA9sU9j6pVxmGCFwaIzvyzkXWEb9N1PNCitm
 gID5aSDEDZtoUDHslTEXRgQLHfFzXWM28mqCbS2BttBTI96hF6aA8mKbsUv4fg/uajxV
 xsm98Q1xvii71HPWLcodBbI5BEpr2T7S1XJIMKasY8NJ+U9NST12ffGTZIZYKE7pyjHd
 SOpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2pelthtvoBQKvuRut0TPudCa8w7ikQn0K8BRMOcI6yA=;
 fh=XyK5oAUZtaoI/kUx013O6uGvOFEOU4DdLgLx7XeObGM=;
 b=JF33TSMRQR0alaB6ePwj337zXYFV7Ji+2HttnFpgirbPH5A2bhK5n06EHN7CByZSoE
 3Ydqb644e8Z3I4G71Wp49zkckD/QAVxSLng6AsP9t9ioxRNp7C+5XqIfnJHcL91mGyDI
 pkT5axeVKKsH4FJZScuBrwB4FjDarL4BmpG7dHgMfdsLNzLgTfCPzCgK4dtnAAQNpzPG
 OL1dXHwfYE0yKXOw4+krhdNNMlSAISGAkuddIJMKE/NW4NQlA9yY0FI7rWqySS3lVTSm
 kQmQ4+5gXzJGn+m8R+AM5pHm5C/OrlDM69hvOC4aU3mfSetaicJfi8Vv3uQogJS0jno6
 6AEQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768700716; x=1769305516; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2pelthtvoBQKvuRut0TPudCa8w7ikQn0K8BRMOcI6yA=;
 b=fWIFmTy8KLJJJmrEN6KfnkoNx8oKNhwQr7hcdv2QRaK24E2B8oSjn3Ob3Mkw8pvmQa
 Lgql0gHfd7+WD3a+MnM0f3ppP8fcPTS9dNjeoKU5QV5q9aeXtW3e5gvCDXV33eQ5boOB
 si1nQOkAsGHZG8rqItDTUld/qGdq3fYwWlT5iSdYUqLxzQzIZW6YiWhfjPBVpN23hiPv
 LyWAljMiFBraYuDBpAQiBXu6RtwKKqXXbjbqv5+vZM3mMO9485a8ebZI+/X0akzarBqO
 JXBoxr2tWa2dkNDj8ktZh4UqgCJzGwD2yKBwbzBf51kT9VTRQTGAZhe6N03E7I+xJZwD
 3VzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768700716; x=1769305516;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2pelthtvoBQKvuRut0TPudCa8w7ikQn0K8BRMOcI6yA=;
 b=i1shLTFfKZTyd9fecNj4lJxegl121RHAjwXVzldKoytQipX1CT+IJOQAeMG3oWyrWM
 pRz+463ehCphkXLeuiuS43DvpJ0mdt9c87hhKAU0YbNwo91VyYZcmW/2VXJ+QiEal7qb
 xdyQ8lXMXy0ggpiF/FUktMj8lxuzK5Y+VVm4Cri2NWBQygCwCqrtpXQ60BPnBryzqciP
 QjpHTx2qTrHVRsipMRrKh4xQTYtZU9wq6LU4fo3FQNpzUA7eQ+dmGNiuS4MOQKZ6oGTJ
 rMZWythVsMD5PzuaHC9xGke2pxCwsCH0scObx4gZYor1GcP2viQZ2QKnjmM6M9h+sadS
 AXVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/iDAIgI77mpNMY4KTFHYfjXqphOjz7GGAgjY3glI1nDU2mzdjuRYJueNd0zzgMpgvnkAjia8=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4t0FDwAvDy4yb2CDtRRe0bcYOC8CBkGpC8P9GJ1ISoZIsrAzT
 5fsqMhxT0NADa++cEpTtSUwBN4udhSElwC5D/Ncv6LUBhUzIrEsj1CS4f8wL4VeP6+I0HM9Aax6
 fLff6eLdSlNDDazGtXLdsx16myDBQEg8=
X-Gm-Gg: AY/fxX7jJt6jlEcz+X4w3AsNrpmqvUfE8ixLEBCGvt77xTlKRXvwEoXVcjGkM/gXTMm
 Fqbxm5n3bu4XnfGr9ln+ao4OlRDXP/QPC0+t68ZbgNJ7bQP6WkYSf+5/XlrZjM7rjCG9Fqt6gXm
 eMfCTWjdYMD5H/NtlNzFMfhxxkBf8fCP8As7u/hcNS9HIkxdlsGzR92fGNwxW18LwR1E4/dbaHG
 aVZoYNm0B3xd2VeNluTvUIQh81PTt5RQrdjkMWVWoTydNoE4JA1IvHsdIQZh/L/+8xvopySDOz1
 tYQ0oQ5K
X-Received: by 2002:a53:c051:0:20b0:63e:1e08:daa8 with SMTP id
 956f58d0204a3-649164d2c21mr4637713d50.62.1768700715693; Sat, 17 Jan 2026
 17:45:15 -0800 (PST)
MIME-Version: 1.0
References: <20260103-imx93_frdm_tcpc_fix-v1-1-d7ef892697eb@valla.it>
In-Reply-To: <20260103-imx93_frdm_tcpc_fix-v1-1-d7ef892697eb@valla.it>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 17 Jan 2026 22:45:02 -0300
X-Gm-Features: AZwV_QibccHPzuLkkCJrCb55J9QJl4UoE1Re5_tD1tJM01D6__l549DO-65kLzc
Message-ID: <CAOMZO5AFzKjDkw6bx-Wjx=jc+9QYbg3_pcpJuZ+OLQU+DxPHdw@mail.gmail.com>
Subject: Re: [PATCH] imx93_frdm: clear and mask TCPC interrupts
To: Francesco Valla <francesco@valla.it>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 Joseph Guo <qijian.guo@nxp.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Fabian Pflug <f.pflug@pengutronix.de>
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

On Sat, Jan 3, 2026 at 6:22=E2=80=AFPM Francesco Valla <francesco@valla.it>=
 wrote:
>
> One of the two on-board PTN5110 TCPC USB Power Delivery controller on
> the i.MX93 FRDM board shares its interrupt line whith the PCAL6524 power
> controller (GPIO3-27). Since the PTN5110 starts after POR with the
> interrupts enabled, this can lead to an interrupt storm on OS startup if
> only the driver for the PCAL6524 is loaded, because none is servicing
> (and clearing) the interrupt requests from the PTN5110.
>
> Maks and clear all interrupts as part uring board initialization; they
> can be re-enabled later by a proper OS driver if required.
>
> Co-developed-by: Joseph Guo <qijian.guo@nxp.com>
> Signed-off-by: Francesco Valla <francesco@valla.it>

Applied, thanks.
