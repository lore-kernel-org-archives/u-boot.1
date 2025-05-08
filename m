Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09695C3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 13:03:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E92B82153;
	Thu,  8 May 2025 15:03:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XfgqxiCZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4B4A82162; Thu,  8 May 2025 15:03:17 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D3E68212F
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 15:03:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-326b9930730so5128961fa.0
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 06:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746709394; x=1747314194; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eKCxdPjC+V8alINHfeEn11ONLU+VA0V+gXzXXBsWv4U=;
 b=XfgqxiCZ5/CWJ4f9+QK+qn6mXLGx9s9qP+D0+hWLgZwlU6H4PHTeDteKBwp3nev8Hk
 IpXH5PSvQ9HmnkkzcHealljwRxIOWzuGKCJOxRGVB0FKy/klBZ2W8/y3uMRL4/b1kpZm
 CLsExLpqETff9zFcMaBaLoQmgFgF3MAUY2a9AzruwLdRwK3rLo8Qiu8+UfmOlb1t0Fq4
 IS8Xf4mRV4nJzHdWwpBhqxboGFvjtVw8IO7Ru2seGNS7vNZNmJFakatBThLTGC+HXyzO
 fRDvisvuuwQCKx3gQX9rqIFgPsUdMETvGPu241LbKtV+VIz6VDJfjHtqnM1wWkS0tiGf
 wM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746709394; x=1747314194;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eKCxdPjC+V8alINHfeEn11ONLU+VA0V+gXzXXBsWv4U=;
 b=vTBPaGBsEcUXQ5eguVRnH6DxUmVmDCXb8Kv1UGLejApnBBbJ8MOrRvZIUg2d2Us17L
 Av2uH/AAgjudBUM73jc131AaTVp/dWbvyRU3S2+cx/bhmoal06thb9kvZrC+bXKYoBtq
 /I8cD2bMV8keO0gUzI7nUH/9wyv6M422FL/AbeLaoe1rQVmApEYtaR10L2+vREoVAk/n
 GMXppF7dcXe9d75M8kTSYuodEkpffry/KIzju43YOLEiAATZ/agXzBFwJI39bGwa0CaY
 PQghQzOztcjxchz4v0WEFEs9BZwUgVL/Vp0KoR9ycWtCLm4iwnU7fTItRbxW20GrIsV9
 nvog==
X-Gm-Message-State: AOJu0YzvWnGR25NE1dEFseBEHRNNfoeMaMD+4a4A6eyx7YsEeGN1ERVu
 hlPce3lo6nr8dz7RGL/cHf3jqSasbETZLsJVYq9rdtTyEZoBr7FUVbs9N2dXUcAMbp7MwnTzrBE
 SOs894ZxjQf8k9R9CfrRFsiTX3xB+rDUf
X-Gm-Gg: ASbGncte6njHqJmQjJlapBR3nIpJ9dgCMKo6n7m3fLLWU7SVpJtt3mG9iaEUh5FIp1h
 3dcjiEiBI1Wm3UYxPRxi+K0aMPPYIgsowPSURNRxweUldyyJvaGD21wk3ZeLcU08wxqZ6N2jh45
 7pA7Li63XMMrqn9is9HmbQITnw40HOTdyUZjD6ujzahbxPgO88+Hv7nfmZlsg9k356
X-Google-Smtp-Source: AGHT+IFQYOs75n8w0qkaBkQTs69nLVJ3/0vd72rq7tm/6FZwAeyFO7hgzYegd6Lt1N3/GysVzYdveHVd9Yzg+HpTq+o=
X-Received: by 2002:a05:651c:1476:b0:30d:6a15:6a69 with SMTP id
 38308e7fff4ca-326ad19bde1mr29374641fa.20.1746709394216; Thu, 08 May 2025
 06:03:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250505213733.4114398-1-tharvey@gateworks.com>
In-Reply-To: <20250505213733.4114398-1-tharvey@gateworks.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 8 May 2025 10:03:02 -0300
X-Gm-Features: ATxdqUHkyk8qJ45geoM_PZ5c2HWRwGNF0wzR_83cDjU5XNNl40o-djvmGm8Oji0
Message-ID: <CAOMZO5CFOe=LQTPMhh1Uy2Fr6ha3cCKGcfAT5=MFbdQA6+iZYw@mail.gmail.com>
Subject: Re: [PATCH] imx95_evk: enable PCI early
To: Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
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

Hi Tim,

On Mon, May 5, 2025 at 6:37=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> w=
rote:
>
> Enable PCI early as the NETC device is an PCI ECAM device.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

This path looks good, but I don't see it at
https://lore.kernel.org/u-boot/ nor in patchwork.
