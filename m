Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE8DC28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 16:17:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 857D5807B1;
	Sat, 15 Mar 2025 17:17:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wsj+wSk4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEE96807B1; Sat, 15 Mar 2025 17:17:04 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80AA780756
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 17:17:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-543e4bbcd86so3343668e87.1
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 09:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742055422; x=1742660222; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oLdQl3/EE53OWGQXG6XcKot3E1Td7EKiLxQtDjZ3f0g=;
 b=Wsj+wSk49w+3tvDs69rlL+abUGe4F2Z7u/p9T5BpsVWDFp2MspZahzB6ng/GJ43PFV
 HoWMrewsPNpUnN8lrCo8xkjuYde12RCgsKm+x4o9TsIABs3er52D1nEtk5wKyU7YAJEN
 kEujLUWPANChYaxrUV6sr1YKaqAzaPlincGgpRY05Q4F6Z3wF6vIO7BAXJ7BVpcKrdiJ
 Kzlayv/KBmmwfK+XsVvYkvUcRcbmXavLobUSoFCbn2T5HhWOdYUaV4IhqhfyPtpB1Ucy
 hM7HqJ+YZAFlPnPdLjJs39BwNH7qFQuD/vwWWGZbaBNB/8o+gGxvr+uOH1mpvbYFfl30
 a7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742055422; x=1742660222;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oLdQl3/EE53OWGQXG6XcKot3E1Td7EKiLxQtDjZ3f0g=;
 b=tb6rJhkwbQrQ9y39bivaDPd7ANB2ktUlbcgkBftouz4lqZGCIqEeLRFKo0SKMEsH18
 Udy97H/wR2WebFNKmvhps0KdUYUfluwAv5qwcRi5xhm/kntBo0cNKhUVW9/gOaUXey6h
 hbMWhGGD6Ke6mpKvQHbGXYN91ejxUQQ46CcMzEDo2Sze34Y+kzdgmQAoxW+fJUO7162i
 hLpXj4mr1ddkXaxSLb4erfvU8clku4QOw8yACulFVdWr4OuYRax+J4S14OYQzbGKKUXI
 Df3lsgEwXiV7ERRVx1G78AQsnGip1xLv2P/fX8VetsNrqZ5vfQ/nFwPDZXQKP14VpKJr
 AVRQ==
X-Gm-Message-State: AOJu0YwKBncVlW2r/ECecAHznDMxsJ1m1GhlR2C24gjcd3J6klKzNziw
 X8UdpFY2JLDvW3oDct6aANJRByuFXTYlHQIUV8KL59ofOUej1nag9Jlc3XU7iFg1pLn4D6CbmzC
 dpp0eRdxMpW0BnEx5wbyWbzTc270=
X-Gm-Gg: ASbGnctQsE5xM/zb+t4XIeO3tjCxR/32jK74Hyv70jaXiJkgEoYdccqpT6Y6qlHKjhi
 dumLnCBm4gvXI5BeyLF/F970Ddu5SQGFEFcqddb7rklFGPH+8IpUawfdomV3VF5J6ZB5UEy0EqY
 w3meSdQJErCtLVsbptIQYc9g/dfbmCzcwDvFEzEQ/VajJdNIyORS6VpJ6laLZyE3HX4sfH
X-Google-Smtp-Source: AGHT+IGlissAUkeYDGPnRFF28SXdAxtRSjd8JeSp0GC8G57yFig2VfxY3oS/CdkuN47d3LjTe9RxasPBinGzEweG03c=
X-Received: by 2002:a05:6512:3f05:b0:53e:3a7c:c0b5 with SMTP id
 2adb3069b0e04-549c38f1ddbmr2444645e87.10.1742055421480; Sat, 15 Mar 2025
 09:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250312003041.110023-1-aford173@gmail.com>
 <CAOMZO5DRn08Q58PeHqi=1V8ZRv6B1+L_CB0NA=arQ2u6XUyi8Q@mail.gmail.com>
 <CAHCN7x+grtVs1JDvfth+7VdT1Xm=_GSBsr0PD1XQSPxpRBZcfw@mail.gmail.com>
In-Reply-To: <CAHCN7x+grtVs1JDvfth+7VdT1Xm=_GSBsr0PD1XQSPxpRBZcfw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 15 Mar 2025 13:16:50 -0300
X-Gm-Features: AQ5f1JqfyaVQSCNVwOT_705HiN-74A2k5JEyBI5shhjG4d6NZh8tSum4N-cC0UE
Message-ID: <CAOMZO5B0MgkAoBww0pPVnv4TAyqRmGJSn6hBwivgc2ZtpF+fyQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] clk: imx: Use Clock frameworkt to register UART
 clocks
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Emil Kronborg <emil.kronborg@protonmail.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
 Tim Harvey <tharvey@gateworks.com>, Peter Robinson <pbrobinson@gmail.com>
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

Hi Adam,

On Sat, Mar 15, 2025 at 12:37=E2=80=AFPM Adam Ford <aford173@gmail.com> wro=
te:

> I ran the config that failed on my V3, and it passes that build test,
> but I don't want to waste your time if it fails on others I don't know
> about.  Can you point me to documentation on how to test this across
> multiple boards/platforms before I resubmit it?

Please check doc/develop/ci_testing.rst

"The second way is to use GitHub.  This requires a GitHub account
and to fork the repository at https://github.com/u-boot/u-boot and to then
submit a pull request as this will trigger an Azure pipeline run.  Clicking=
 on
your pull request on the list at https://github.com/u-boot/u-boot/pulls and
then the "Checks" tab will show the results."
