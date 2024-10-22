Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D51D0E6FC
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 11:21:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C57D88E02;
	Tue, 22 Oct 2024 13:21:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RnP0ez35";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F9CE88F50; Tue, 22 Oct 2024 13:21:18 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 255A788E02
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 13:21:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-539fe76e802so6302542e87.1
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 04:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729596075; x=1730200875; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b4BjXDxATIRde17/9qD5mRcya7/su/lgJAmC5xjTciA=;
 b=RnP0ez35MW2+5MnDn8tNCV0lc4Sr9ejA0tXCE+/CG59CApAw6ptyeQlIGZJCvVPnIf
 ktNILUJdb+Q+XK3K7VFILe6oBsZOlz1ULY4NkNoGPJ5h91sGzHJo0GWLvc6sDf8ET3TG
 iSeOYk5xlyeaZTa/tVJ2AdFulujDsV/l0EUvL2p5DJ+CPHuLddvcEIYRaqvetYqPNjXx
 GeePYAtfl27WOF0oC+t42Ns0hroN/uG+2PXqxEvk6BbWup2HJGg3LEOo1iWS1Ec9o82A
 H4EHBoCKcqjMiw8JK67Wq9hB1L4w69VMghBzPBjcTrPXm9BvWtjyx/Rs09sAGop5FUYM
 XsHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729596075; x=1730200875;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b4BjXDxATIRde17/9qD5mRcya7/su/lgJAmC5xjTciA=;
 b=aogcIWqRZWzuwuyHq7JVYLLIZFNxDpcrr7vMODeJXxAXfawnNIzPPJ8maGZPvVMLBA
 0F+FejixWf202r6O9WvJaEWCBqWQOljfM3Vi5KaXiZDeg4AQpoQC59DTwU3bRtzW+dkW
 bmOqpfHkmMxdke+x47zL8r+OyCiz4iniR2vRoKJ1kV9fwBDUPpOfcgI7xAA0nTcltD+u
 efNkVgR97+ZtNQQqrbxXoRJzxUl9scMinxXQfrX3CqzD3VdqEmHITau5KRhxFgynYer6
 Oq64tU+ha9tN4xWjjjDFOwtXfK1L2MyaUxzCXRXooNekvy2BjjWOocTajWn7ZUyaNnNC
 BMHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdosgMSZAbKMsi1rALiOUgE6/YoaK4xsw9wR19SC9yuGIXH/zv8meomIsOIRH4z1TUFL7Nf+M=@lists.denx.de
X-Gm-Message-State: AOJu0YzfGm59JgHSkg8L/7r3fLpNjdeWTHAbRh1H8HTYQymx8cpyvP+q
 SHWqg7aQujdcENM5LWO3ins5JwFY9BMkg9mQ7sRlL9Azci2L5DpbBYciCf4YJqnweNx7bs0A+QN
 ybIfJaBJ+PFYIh9X5e4w5UxGgnUA=
X-Google-Smtp-Source: AGHT+IH5Aled/SAvkQ/Z84c7UKeGZR8vfLCiWRCzWHNQEgmR57IFJxxQcNp7FMnB1+Tq1hI5aQBTixlR2w3zYXVQj6c=
X-Received: by 2002:a05:6512:3a93:b0:530:e323:b1d0 with SMTP id
 2adb3069b0e04-53a1544272cmr6526788e87.9.1729596075069; Tue, 22 Oct 2024
 04:21:15 -0700 (PDT)
MIME-Version: 1.0
References: <20241013174120.1872-1-egyszeregy@freemail.hu>
 <PAXPR04MB845929FE951FCEC327F9F54788442@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <CAOMZO5DBDDYr+9K8rq56L-=5EGWDNXY514rz5zoqPdXOQ2x=jw@mail.gmail.com>
 <93d2989d-7d55-40a3-a44b-ef64e1feb511@freemail.hu>
In-Reply-To: <93d2989d-7d55-40a3-a44b-ef64e1feb511@freemail.hu>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 22 Oct 2024 08:21:03 -0300
Message-ID: <CAOMZO5Bvkqj6uYpSU=JsWd_t7yfvHAqhs9J08fGiEa1nfCX3Hw@mail.gmail.com>
Subject: Re: [PATCH] imx9: Improve boot device auto-selection
To: =?UTF-8?Q?Sz=C5=91ke_Benjamin?= <egyszeregy@freemail.hu>
Cc: Peng Fan <peng.fan@nxp.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "sbabic@denx.de" <sbabic@denx.de>
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

On Wed, Oct 16, 2024 at 4:42=E2=80=AFPM Sz=C5=91ke Benjamin <egyszeregy@fre=
email.hu> wrote:

> You can use only one of config from CONFIG_ENV_IS_IN_MMC=3Dy and
> CONFIG_ENV_IS_NOWHERE=3Dy in U-boot config in same time.

imx93_11x11_evk_defconfig selects both CONFIG_ENV_IS_IN_MMC=3Dy and
CONFIG_ENV_IS_NOWHERE=3Dy.

> If you like to use CONFIG_ENV_IS_NOWHERE=3Dy, these codes in the patched =
source
> files will be not part of the build, and the autodetection of the boot mo=
de will
> never work. At the moment it works only if you use CONFIG_ENV_IS_IN_MMC=
=3Dy in
> U-boot config but it should work also in case of use CONFIG_ENV_IS_NOWHER=
E=3Dy
> option also.

But like I said imx93_11x11_evk_defconfig selects both
CONFIG_ENV_IS_IN_MMC=3Dy and CONFIG_ENV_IS_NOWHERE=3Dy.

I am still confused by your patch.

I would like to get a feedback from Peng Fan.
