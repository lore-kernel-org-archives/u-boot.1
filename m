Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BF8CFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 13:28:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97F2B8452B;
	Fri, 28 Nov 2025 14:28:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Kt3Nydlt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8D3984560; Fri, 28 Nov 2025 14:28:40 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF9F784513
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 14:28:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5942bac322dso2037559e87.0
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 05:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764336517; x=1764941317; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+VY9k/eckZS7gx0NHrONEeujRU0hPxVIqzjMpNWXo0Y=;
 b=Kt3Nydlt6Vcf5Sg3ySXKKECyyCDBv185f6bIA6awOAp1z+55Z+SceI2kKsza4jqhNX
 VVL39s8VBc6OzY535ZRItzYBqWxYHxdbbTEHdzPNzUy1A/9y0HXctM1MSw04avzceIH2
 X5UE6kiu7r03SdXQLVcEtmy/E5zrduWSotYQZd+C1hdk4n+RdPAnE69BF7lbMlIucTeu
 49Ihg4giJz2GGmYuHWubV2R8IoKi0upRVADScI82ivUgp1XJeT/qcPODDtbD1GJQiWRC
 0dZOJeCGsyMIcVdvQOqw6+uaj//FOqvSlfHj29etnloPN/E9RpRZTT66JPkgRZdS+ca2
 NINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764336517; x=1764941317;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+VY9k/eckZS7gx0NHrONEeujRU0hPxVIqzjMpNWXo0Y=;
 b=Qbt6UOhZ/Ek/6rXBd1X6kLcbFYBL5LE3NENT57V+wCIoIJ0AHuOpg817hwTAIBVVh2
 Ba3FMvVgo0Fd1xDsYcUFmXeAgi8FTjf+ILutJHV9L57XDIq+u2s8sTkRttahyPjAhfOs
 H1P/2fY7JZVAo0fSLrWmRZHqnSGJuHIcHNuy2zYrdZNx92Ye+KRHM0dn/5SNWYjx8Pqo
 G8haoeNR5EiXNVNRrIVHbA6MbeB7hRWbICafbRj1/h3SqlhwUuQy3R2/0/ukayGgsQWX
 1B+VKr4WgRQZFKlvNdAiJ2BHMia/LOj99FxU17GBxHzpfC3VGYU8499c+rillJxwLlnV
 zOuQ==
X-Gm-Message-State: AOJu0Yw8wY5NUWB71LR3OkebA8XNx0CFJ4B4TbQu4Kr23anQMkk5T2R1
 cRuhEZymgs2lTBY8nrRTyJgwr2gBh2f9DKPstmw0C8J6fcjhnFwl6uX3RbVfgtOxwP7ogL55bnF
 /Vbh3BakGHp5lrr7ij6ou1Ifsl5+l1wo=
X-Gm-Gg: ASbGncsT1Qqeoq0CllsSNyJUCriazaywlZIVOvc9IK0S0k6HnqVn5vq9a7qTesQJw/Q
 qnm5/yfeJANfUhLvXRklMmmhAdWFtuaksfxV1QEHePjkBoKtBQOo7UE6AH00oCbuqnAQLc88rl1
 Whd0LP67UOcMGotR4IuixbcX9crzbYv71zDZWFRR/lL2LxXx62qFmTiHwnQmv/01y7QrXFcJ1nP
 9OSC3Uie3k+KLeODCsfK2Oj1X3JjrNCDguPyt1LfGosapdyaCsmXk9wiLGjvvYRhS/8/b6UhMWn
 +zM7A8gkeLPCIhtqREg3X//Z0A==
X-Google-Smtp-Source: AGHT+IFh8tl/HAsnLDd038IXqs1Lp5lBXUg0uvBSUmmfUtfcx4JCLi4k/fXHLFfQHMU1L89vwfrlaie17bg0lfGkWLE=
X-Received: by 2002:a05:6512:a92:b0:594:27c6:a03 with SMTP id
 2adb3069b0e04-596a3ea7b89mr9960377e87.13.1764336516749; Fri, 28 Nov 2025
 05:28:36 -0800 (PST)
MIME-Version: 1.0
References: <20251128-usb2-v1-0-25ec5ac127ff@nxp.com>
 <20251128-usb2-v1-4-25ec5ac127ff@nxp.com>
In-Reply-To: <20251128-usb2-v1-4-25ec5ac127ff@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 28 Nov 2025 10:28:25 -0300
X-Gm-Features: AWmQ_ble3zYCxItoejPHFcGhhvUNo3AA1Cz9jW3Xw5G-SG4tEiH60TZ8l9k9htw
Message-ID: <CAOMZO5DCUyYNeC_GFsy_9fVK-CrCoC2O+Lqzu+L7cJDCPck1tA@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] imx8ulp: dst: Enable USB controller at 0x29920000
 in host mode
To: alice.guo@oss.nxp.com
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Marek Vasut <marex@denx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Ye Li <ye.li@nxp.com>, Tim Harvey <tharvey@gateworks.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Stefano Babic <sbabic@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Lukasz Majewski <lukma@denx.de>, 
 Simon Glass <sjg@chromium.org>, David Zang <davidzangcs@gmail.com>,
 Alice Guo <alice.guo@nxp.com>
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

Hi Alice,

On Fri, Nov 28, 2025 at 10:18=E2=80=AFAM <alice.guo@oss.nxp.com> wrote:

> +&usbotg2 {
> +       compatible =3D "fsl,imx8ulp-usb", "fsl,imx7ulp-usb", "fsl,imx27-u=
sb";
> +};

In imx8ulp.dtsi from Linux:

usbotg2: usb@29920000 {
compatible =3D "fsl,imx8ulp-usb", "fsl,imx7ulp-usb", "fsl,imx6ul-usb";

Why is U-Boot using a different compatible?

Also, what is the plan to switch imx8ulp-evk to OF_UPSTREAM?

Please explain in the commit log why you are touching U-Boot
devicetrees instead of using OF_UPSTREAM.
