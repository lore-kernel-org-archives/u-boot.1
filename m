Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B316C282C5
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 12:32:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E918810ED;
	Mon,  3 Mar 2025 13:32:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IGJQMifs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CE87811B3; Mon,  3 Mar 2025 13:31:59 +0100 (CET)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E7C4809A5
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 13:31:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-30baa27b209so15624731fa.0
 for <u-boot@lists.denx.de>; Mon, 03 Mar 2025 04:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741005109; x=1741609909; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B0XzmltPv6k1177bVSVTiZrIcq6nkdXyTMrdQOm21SI=;
 b=IGJQMifs5PIwU7huP/FR7MexPGyBUv5l0CjrDx+3wQ6L/axohFV1B6HvIvOSedZlh3
 XCpTdC5jRnJrrBzvmNg8p11gfv9vhKsOE20kohBb2+vV7yEVxo82G6xHfSidvUXJLJXe
 90PzysLvh/u8T0QIIIvW+jF/B3rXtq7JWWQYVXKFVwGC8XwE+3etZ7Fi9R5mM6fsIFZF
 g2sWs6r5NCCJPZGEuPiG4nt6V36ZgeomPbNB2sg8kmk75P5j939WMbhxCHz9oPqSdqDz
 co/CJJDwh2S8+38V4bLPsoFFWYYFJBSLwsOKxvfv7m8j6F6yAywWfFAuo+5ja1CKPbPh
 8uJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741005109; x=1741609909;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B0XzmltPv6k1177bVSVTiZrIcq6nkdXyTMrdQOm21SI=;
 b=fNClA8bnn756vboKXm9WvsOeDvGkK5brGl6QBmzcfS7db0Dg/GTALQ9pUc1Cz1utDw
 F5MXxcTrvvUf39bEu6CAPfQIAIgxdEvtjZ2RuSC4BOvaY5lo/HaXHN81oxaGQlOmLKQE
 +fbQ4MVu+kY6lalEg29Xlv0Z2+IMKDrWLvD3X2tSi6iGck+UCddEvQOtTu5W42cVMN8A
 D/leEHl0Wlq6Aq2wFjby/hArHKa8LujYKmc+pbmIxUdtAIa3nlz4WJvACK10AOC6X1Y5
 G26/+CIhEKpXBe/3q9geowV6kP6GDNQ4RpdUEKpWu5gtbzumRv/eKlalwJJO4ZVY8KHJ
 CcRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmEy2MsDPfvyH3hQy+DBB00bSi70GHXFR0RtcnU9WNE7QweEFrjtRZq8fBndEpf5OLi0hVG8o=@lists.denx.de
X-Gm-Message-State: AOJu0Yymcza6PZvwfzi0ApWYfrYlkv9QPgKUtwNWyS5EpYyd6g/guHSH
 0pcc3pEUooaYB+g33kWjNMQYz6dkKWzIcBKy/HJuUGHEppRaDQlY8P//MKQBUwe95MI/sJ6YzKA
 KnyyG3y3grIcxVGjfO6euX1EHTbc=
X-Gm-Gg: ASbGncvsnWEZlBCUgBlvWFDIfg6fAM8TQ8EBEUkAykS8DmmhCVBPK6PTLuhN5dwgia4
 gY6cGi1Jyrhn3sVmISmL0DznCzA7cESw1SSkvUmJwLaUIXuvv4yJbEQk3F2Z1TH0CODC7TcoRMs
 JyAVDoMKHZUxiCb9xO3WLQGu6VWP7k5PfQphA4gCYzblYQaEVn+sxQiS9cLA==
X-Google-Smtp-Source: AGHT+IFM+VH75CFdvMZOQ0JahmKKIzYV2YN2YCPdXCOMQ5yNTImz8aiNxbA4tONvPcge6cZlgV0L/PmPbturee24Y0Q=
X-Received: by 2002:a2e:a99a:0:b0:30b:a98f:9cb2 with SMTP id
 38308e7fff4ca-30ba98fa3b4mr24350551fa.19.1741005108732; Mon, 03 Mar 2025
 04:31:48 -0800 (PST)
MIME-Version: 1.0
References: <20250129-ge-mainline-display-support-v4-0-a43b3657ed7c@bootlin.com>
In-Reply-To: <20250129-ge-mainline-display-support-v4-0-a43b3657ed7c@bootlin.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 3 Mar 2025 09:31:37 -0300
X-Gm-Features: AQ5f1JqGGgXq-rhWzHaqdQRj-R2T-1r8NtuVh72AJSTUdLQ0g12_DXeJW9YcgKE
Message-ID: <CAOMZO5BGBv_hM30W+_J8AS_X3fqj6MXy8DYDhoyROdC89=k7aQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] Add imx8mp video support
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Peng Fan <peng.fan@nxp.com>, 
 Mario Six <mario.six@gdsys.cc>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 u-boot@lists.denx.de, Ian Ray <ian.ray@gehealthcare.com>, 
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

On Wed, Jan 29, 2025 at 7:22=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
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

I am seeing the following CI error in sandbox_spl test.py with this
series applied:

https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1045491

Please take a look.
