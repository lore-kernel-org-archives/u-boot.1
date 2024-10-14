Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBFCD1813A
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 19:08:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E906788FBD;
	Mon, 14 Oct 2024 21:08:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Tqar5g7u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7DC98903B; Mon, 14 Oct 2024 21:08:37 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA0ED88FBD
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 21:08:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-539f4d8ef66so1834768e87.1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 12:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728932915; x=1729537715; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ml39H/V8iV1Q6yY88N1EJ7Ivhu5FPYYVLsvKg7YIyCk=;
 b=Tqar5g7uNLsCo0qtyWAAiXsG+pUv/z+jxTtwMrbBzLTmfx8/9uIp1Ur5l5HKT7ivgC
 FjVljBQvBfzmNFZqvg7mtsHzslP5gF1tdoTmEV0sACar+eOszvDUP3qTwfkpw/rX9uRi
 /PNdUQyJk/BFjmxy9+hgNidoHpVWqjyVd0/0M8TxkWU5/hIuPtF0o3+xMHzmLvX9DKSV
 lXxjirF4zSTWhOjRAHFTHYr7eojABRVtJnhQSg3L7v1kT+A+FZU5B+5sBmZYzROheUvY
 hh40D/vRTDxdCo4fgHBqRk8AeK1lwm4ebweluA0dz7fvvKcUMOOWZL4A3zo7p2ngGen0
 VWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728932915; x=1729537715;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ml39H/V8iV1Q6yY88N1EJ7Ivhu5FPYYVLsvKg7YIyCk=;
 b=Dr+Q124zVbIFxyoT4jyXkGw4T0SQchwuDu/K5KgaMXGqipzIYK5HudFQJyYSRyBbtY
 072PClOOZtEsoWVXiCL6Ej9cxDfZnS89Pykb4YFR08NK5wIkND7GAbkqbwlsOjBwOAfq
 jsNB96hpP/vtKyf9PKlHOh5STra0F05sl4XvE2AtX+OCIfi8VmtrJVjn98dGAEU2uskg
 t2a+0+CCa3jxShr9qh76F674NPbjGqCA5KDDsgzKfatW2Hxy4AhPEQjpiK+LtaZbsJGy
 HxE1+dV8DuruOrkWtCOqCd97duxiAR3qb0W6ol+wZcOrdn2w/pm9e0IA02bj6jMiHGLt
 5upg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVncscPyj3dUKpP46e8CqXGAexe8SaMAVNjY5jWo4pomtepEWEZki6duc8c7KFsxK1MhXWWxSM=@lists.denx.de
X-Gm-Message-State: AOJu0YyO4YN9Te6moiUWZeWB279SN1jLRKcGFx/KWRqOIvHs1/gwPYq+
 yDxdmFxPCxl986etF6ET+Nvh1qW2k4y1LE5mW/w8IdSnt8g6TPtSiuc4W+y0WO3g2tjt6CPrL0O
 ZGE50+zJperKcylHEZ9+0xGbVRCs=
X-Google-Smtp-Source: AGHT+IFLAB0SObZj2Jj/EOzAtR2Mo5E9z70PKms6cdsM++A+TwU09cF+bFMi8AAxew/ARyLFxW55pC/GBHY1uTRnCsc=
X-Received: by 2002:a05:6512:230b:b0:52c:d753:2829 with SMTP id
 2adb3069b0e04-539da3c6c1emr6140993e87.19.1728932914698; Mon, 14 Oct 2024
 12:08:34 -0700 (PDT)
MIME-Version: 1.0
References: <20241004001118.322531-1-marex@denx.de>
 <CAFLszTiMNeU__kzyRR-3qKPUUKaXEqaypf8YYQgxL83E-2gt3g@mail.gmail.com>
In-Reply-To: <CAFLszTiMNeU__kzyRR-3qKPUUKaXEqaypf8YYQgxL83E-2gt3g@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 14 Oct 2024 16:08:23 -0300
Message-ID: <CAOMZO5Cp3TUdMFYfBSm-k49mS_xaOtvpGwqoQH+eCjC5eCfpbw@mail.gmail.com>
Subject: Re: [PATCH v2] dts: Deduplicate dtbs target
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@linaro.org>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jonas Karlman <jonas@kwiboo.se>, Lothar Rubusch <l.rubusch@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Stefano Babic <sbabic@denx.de>,
 u-boot@dh-electronics.com
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

Hi Tom,

On Mon, Oct 7, 2024 at 12:23=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> On Thu, 3 Oct 2024 at 18:11, Marek Vasut <marex@denx.de> wrote:
> >
> > The dtbs: target is almost identical in all architecture Makefiles.
> > All architecture Makefiles include scripts/Makefile.dts . Deduplicate
> > the dtbs: target into scripts/Makefile.dts . No functional change.
> >
> > Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> > Signed-off-by: Marek Vasut <marex@denx.de>

> Reviewed-by: Simon Glass <sjg@chromium.org>

I have some patches in my queue that depend on this one.

Could you apply it if you are happy with it?

Thanks
