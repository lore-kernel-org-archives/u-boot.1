Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46CB8C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 14:14:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B87308409B;
	Fri, 11 Apr 2025 16:14:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TohfXe8X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 140818409C; Fri, 11 Apr 2025 16:14:53 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FD2284085
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 16:14:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-30db3f3c907so19673641fa.1
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 07:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744380889; x=1744985689; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t1G3vol3TPvlKew6cobRnuzvhHcGCgb3XsxQLM53ROk=;
 b=TohfXe8XDO0Q00gpRsscnud3iUThnBGrvAFKZ9EvM/23uDpb0Lw7RyOdMsniLMbz3o
 bjBNHbAieEzFOT9dyRqn8DMRGrqwkqkm4viN+sVAPO9jsJkE09W1F4Oagn8G2ktCckg3
 GjJKDDZEpnpGUe/Zb3Biwwdl8JdD257u2JwuFd07/7OWGpDzMxBu+/D+rk8M4PfctS/6
 Bebobdpdcbo1Jr8zl0HwP85sQJdxjKHrq2eklb86OtG44WyCJhIHRb0wpjaCqD/n5UQt
 YYU/3hSZQS1243x11Ry/Vi6USepq8fA9q1ESVcryHdaWmqa+0tZc1SHiglv8RPFsB8yc
 YsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744380889; x=1744985689;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t1G3vol3TPvlKew6cobRnuzvhHcGCgb3XsxQLM53ROk=;
 b=TzPIGkIT41/EONw1xMHEZHChDMveE4FxEgeRAO6mcHRpbfW3lUFY1k2cGO7cTX0qdZ
 6LwkbsODPQ1p4X5HlO2ZgAw+Ehar2n4lWhRnKZA44201hGEwA+yuA7hn3k4RQRtFBeFJ
 Dhb6DhaiLAbOsDixJhBsOqLagccUE8leQU83YsmzbXYBjIr7cBB11DIsVA09o4pcoFEP
 zov9HTuMcR3jUrYc+ggr+ZnLaG4HYiwaIbfxl9vCy16NvfctzKq9wcSVKFsTrLs6KA92
 XRusaWMNQrjhNDVFyucTMOTRaIjYxeWAwQ4YU2f06ud4FXH3o9dHBNNhj8te6CNvj4iW
 5cNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvewkh4mXCjoIm7TW+1yiO99uRefJR0NuHqkmwkF2Fwm2l/6xULoxSfwzBXUC+R4isdnjJwVM=@lists.denx.de
X-Gm-Message-State: AOJu0YwNHB2IEdQaHaXJeswY/4yavVTjz5J4JzZU7erRc7QN8sBUmphs
 NT5PhjDCG5HQZCFkGYXAIa0AJP+9IxQUckzNd1S2Y5wz1iq/Gpd1VsDN3iyvjnzaT+Cb0URNo+P
 1q3X42NF470Q/JjVd9RHeBD16pAM=
X-Gm-Gg: ASbGncssf+OvYQkULdX7oSkcv+OudrCrrO7Dq3yYZQR0Jn/O+zWiPWUQXtMA3KYKq0t
 t/J104EPoMLrdIpcpyKAdGjjdc2mco0XAf+t+a+m8N1PLzVbw47W4+/252B0OF2QTMmcx6lGeKq
 h86nbR2Ssk8HNo12lwKe/LOi4mCvVD67GyeBKPqSF6kl3X/BEYGLHT+A==
X-Google-Smtp-Source: AGHT+IEWd6JH7oS4P6RmdQlKK0O+x2aQMgc+kJuUiRl9Ak1QzhJfXn2Jf0clg5brvF7p1YsL8OmzV2Tjh8ask70Dwjo=
X-Received: by 2002:a05:651c:312d:b0:30b:c569:4689 with SMTP id
 38308e7fff4ca-31049a80220mr11185411fa.27.1744380889186; Fri, 11 Apr 2025
 07:14:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250407130436.223645-1-ivitro@gmail.com>
 <20250407130436.223645-4-ivitro@gmail.com>
In-Reply-To: <20250407130436.223645-4-ivitro@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 11 Apr 2025 11:14:36 -0300
X-Gm-Features: ATxdqUGhTjLPOUOqs2NUlcF8e4KU3iR1sTrOXMuLDzl312G2ZSzsXkJTuHrYXJg
Message-ID: <CAOMZO5D57DT5dAguEmH7sfCMm6mXv8pfo2fm=UFQpbTf9UHT-Q@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] board: toradex: add Toradex SMARC iMX8MP
To: Vitor Soares <ivitro@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, 
 Vitor Soares <vitor.soares@toradex.com>, u-boot@lists.denx.de
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

On Mon, Apr 7, 2025 at 10:04=E2=80=AFAM Vitor Soares <ivitro@gmail.com> wro=
te:

> +Output::
> +
> +U-Boot SPL 2025.04-rc5-00023-g34c31be81211 (Apr 04 2025 - 15:36:23 +0100=
)

CI reported an error because of the lack of indentation.

I fixed it and applied the series; thanks.
