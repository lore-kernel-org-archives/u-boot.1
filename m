Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7316AE7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 12:12:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1B968912E;
	Mon,  9 Dec 2024 13:12:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GY5c+KGk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ED2C892E6; Mon,  9 Dec 2024 13:12:32 +0100 (CET)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF15489083
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 13:12:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2ff976ab0edso42238831fa.1
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 04:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733746349; x=1734351149; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XRec3QLoR7QCkmLHhWSEMXvZS4fFJijNQ+Xco6MQUoc=;
 b=GY5c+KGkOKR6KY3hRc3VIxVSZfT7oiEqO+9Qa20HSmXw1uqvX1lR2NEp9Z6QqmE8bB
 juh9i7ZstBbUHkW9Gyuq5H2MDPhLRK9Zofjs/26dKVtcq4cdtvMFpR7BN/2wTioPTIAf
 2K50Fu6EYtXnKhI7fKEpetRyu+DN6810h9oZ607JWO1+l0vzy9EM9Qct1fHiTuqT9nSI
 BO1gWymSrjOaWAwRElaq+egrdfFTquxSWAkx/O6w/7WBYTqBfqXSkin0+UtAX3cXpaqw
 nKS28hLxUXFrgEq0sa8TvKoJgYlnk3+MY6Cgg+1Wd5th8ei+IpJNTDLJUfBRthO9T2WG
 Cswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733746349; x=1734351149;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XRec3QLoR7QCkmLHhWSEMXvZS4fFJijNQ+Xco6MQUoc=;
 b=BqT+6lmM7TmS8Y6Vv1Rs61PSjm+oTWL0Ri7pJQvKH4agDPhaFz+qRdPKuVxtn3U7Qt
 Ve8wUJaNeyFfCD8pI0AA/Opsm+n/bfUORbZuxEEVqIHcEtFgqdzW2iOQ/Kto/W4yApBp
 Ei0O7TrgGtU4y3A+WIeziT0yu2lysopHwyC84umcmADkGs8mSUWdow7+RvHL4vKLR9nt
 YeG9gYmM5E4Q1vorSYeDnTKrqDhjQxNJy4jmrAcGXXTwtsu/7P4FHo4ik59i5nmqcywr
 EKrR7ya0NT/tyhY99aao2mC7Uo9KCQVhe5maPlaZGfg8MQCFJXlbdUuXB4FyxzJcvYMm
 kiHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhPT8D+2eBSkgE9vjD8HIgrEYfr0w8vhPDDAuW3LjDeXwHjyXCNo21AQYxsMQsxKXAYcc90jE=@lists.denx.de
X-Gm-Message-State: AOJu0YxTFV6Qad1E3bHbNXZYdm6ol880/qmyuBQS3MYpgLFxindW/Mnl
 28kTGo5NLu09evHb5zDq8KabrkELFajduMPNi11SVJa1XdLdhNGnNLAsqcZ3Z87hWImvBqouFdG
 o1pm+vMVbhk2UvAI59hj5u9FwxJ0q3bjE
X-Gm-Gg: ASbGncsoE4SmWyMNGL7QTP1D4EqPD++U3JjV1YAbC1Bs2xebsELWkpNdpAGxW/ppwnm
 UONlanWzS/RXze656VzRJDCiQFZzaCevebnD4UJI/EULJOoMCnMDYMfgS9MN2als=
X-Google-Smtp-Source: AGHT+IGnregATjbvaHWQY/hb0dtzCzqAWftnnk8W9wQUpcfieuH9mbmPTMmzci8trCXTbsevdR94lGG2sCDmB7zYTYo=
X-Received: by 2002:a2e:7805:0:b0:300:3307:389d with SMTP id
 38308e7fff4ca-30033073bd1mr41566441fa.19.1733746348938; Mon, 09 Dec 2024
 04:12:28 -0800 (PST)
MIME-Version: 1.0
References: <20241205-ge-mainline-display-support-v2-0-4683bb4388dc@bootlin.com>
In-Reply-To: <20241205-ge-mainline-display-support-v2-0-4683bb4388dc@bootlin.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 9 Dec 2024 09:12:17 -0300
Message-ID: <CAOMZO5B=4eoMxxFKieUgXVWMpJOad-V-o+NmG3JhAMFptP4DgQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] Add imx8mp video support
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Anatolij Gustschin <agust@denx.de>, u-boot@lists.denx.de,
 Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>
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

Hi Miquel,

On Thu, Dec 5, 2024 at 10:54=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> In order to display a boot picture or an error message, the i.MX8MP
> display pipeline must be enabled. The SoC has support for various
> interfaces (LVDS, HDMI, DSI). The one supported in this series is the
> standard 4-lane LVDS output. The minimal setup is thus composed of:
> * An LCD InterFace (LCDIF) with an AXI/APB interface, generating a pixel
>   stream
> * One LVDS Display Bridge (LDB), also named pixel mapper, which receives
>   the pixel stream and route it to one or two (possibly combined) LVDS
>   displays.
> * All necessary clocks and power controls coming from the MEDIAMIX
>   control block.

There are errors in CI when this series is applied.

Please take a look at the sandbox test failures:

https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/23735

Also, please make sure that v3 passes Azure CI tests.
