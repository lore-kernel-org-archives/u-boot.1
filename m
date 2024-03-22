Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED150C54E71
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 13:47:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D15CF87FFF;
	Fri, 22 Mar 2024 14:47:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BHhJgag1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DF5788113; Fri, 22 Mar 2024 14:47:34 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3797287FA3
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 14:47:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-29d51cdde7eso541878a91.0
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 06:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711115251; x=1711720051; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pb+DGrlKQMSKIYiMR/vArmicOBxSt40aKN8+BnwhdkU=;
 b=BHhJgag1sIPbpnMnqIlw0KrROdHbj2WA2AUdI4dE5A6uHX89CzPnl7LNrdhC87b+W2
 nsvcpIdFUzja+6czLj+q/q8JFKALiFstqEZUMpOwy3BkLrg7lhfYyMpu9m1rs0zqi/qg
 elkSqdC9OYpLfP8a80Om8yFyTo0K3i25V9FJVSp8Tguz4WkLKMlvRV1M8tt0op9/95HA
 lqbI34ybLE3l8AHU1DWEPghleCrvSy8Z9pXhxa0SOcA0rsTKVvAvXn8l3hVv3IP1noFC
 xhjW+uWnofKUfBYOmoOI3rwtjqN9S1VVCEezehX/ZpOmthgyrvrfXqkb+Ib/HhE0RcuN
 rWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711115251; x=1711720051;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pb+DGrlKQMSKIYiMR/vArmicOBxSt40aKN8+BnwhdkU=;
 b=K5UZHKAhSf2azRvEUsoNU/9E2oq/9yNMXGa0GFDU0iAX28lkvslmp5lK3BP9Dfr7gX
 t4znSMc6R1pip3uUvMWwVGVspUXQHNs40gPgU64WsU7QjqX5Thsj4exCjBUKwaQIyduZ
 WYMWY4acusX1p5ULIim+lcArJ6DhMU58oy4OTu8sFGBkm4Axvtuf83V7915pb02sZ3S7
 mg3zeou+Z+fkwLjrRNBi6+B8Fs4hsvgNWCjHrvalbHekDZMcZdd5hYdSzhgxvR1Eeyuf
 2gCTFx504AnLW9q+Add48aw2KAwE+My/239ANUwSgt0wJQmaifenInPGo4FWmumq7G0b
 vCxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhPwXm2asVrVKEqErlkDiytaGues4uOCVheFdWR8S6AM0/x5GhWg5hdMSqU2xTHCR5DSjhQzq7Aob7n0MOcODWR3bifw==
X-Gm-Message-State: AOJu0YzfMw0vgJiCjV8n/yYbjnX6bbPHijHRXFDuIkmmrWOKEBHeLkM+
 7dSCwlEi5DELHQ6nPK8F7zkUEk8vKlamXcyjO9tQmVM8pg1/Z4GaH748UjGzUnrSSXMKY2DQcF0
 zmfjGsBWuHS+cOuKlqxm+TOizR6Y=
X-Google-Smtp-Source: AGHT+IGv6gSYmb5jGPy6RcLr+xTHLvD4yiE/Cl20JpwDQS5PGLDqg94rKIIEnnrdAYaTN9bl6UKDH1E/7xEOL/UKPGs=
X-Received: by 2002:a17:90a:ac10:b0:29c:7697:d2dc with SMTP id
 o16-20020a17090aac1000b0029c7697d2dcmr1722459pjq.4.1711115245935; Fri, 22 Mar
 2024 06:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240322114315.2720727-1-lukma@denx.de>
In-Reply-To: <20240322114315.2720727-1-lukma@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 22 Mar 2024 10:47:13 -0300
Message-ID: <CAOMZO5Cgjy6huSfX_gpd+UQB-xZN6vKJv-=sLE1QL38jCgUUeg@mail.gmail.com>
Subject: Re: [PATCH 00/12] arm: xea: Provide support for different XEA board
 HW versions
To: Lukasz Majewski <lukma@denx.de>
Cc: Stefano Babic <sbabic@denx.de>, u-boot@lists.denx.de, 
 Anatolij Gustschin <agust@denx.de>,
 Christian Hewitt <christianshewitt@gmail.com>, 
 FUKAUMI Naoki <naoki@radxa.com>, Hai Pham <hai.pham.ud@renesas.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marex@denx.de>, 
 Mathieu Othacehe <othacehe@gnu.org>, Michal Simek <michal.simek@amd.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tianling Shen <cnsztl@gmail.com>, Tom Rini <trini@konsulko.com>
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

Hi Lukasz,

On Fri, Mar 22, 2024 at 8:43=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wro=
te:

>  arch/arm/dts/Makefile                         |  3 +-
>  arch/arm/dts/imx28-xea-1-u-boot.dtsi          | 11 ++++
>  arch/arm/dts/imx28-xea-1.dts                  |  8 +++
>  arch/arm/dts/imx28-xea-2-u-boot.dtsi          | 11 ++++
>  arch/arm/dts/imx28-xea-2.dts                  |  8 +++
>  arch/arm/dts/imx28-xea-u-boot.dtsi            |  1 -
>  .../arm/dts/{imx28-xea.dts =3D> imx28-xea.dtsi} |  0

This rename deviates from the upstream devicetree name.

Ideally, we should convert to OF_UPSTREAM available in U-Boot next.

>  board/liebherr/xea/spl_xea.c                  | 21 +++---
>  board/liebherr/xea/xea.c                      | 65 +++++++++++++++++++
>  board/liebherr/xea/xea.env                    |  4 +-
>  configs/imx28_xea_defconfig                   |  5 +-
>  configs/imx28_xea_sb_defconfig                |  5 +-
>  12 files changed, 128 insertions(+), 14 deletions(-)
>  create mode 100644 arch/arm/dts/imx28-xea-1-u-boot.dtsi

>  create mode 100644 arch/arm/dts/imx28-xea-1.dts
>  create mode 100644 arch/arm/dts/imx28-xea-2-u-boot.dtsi
>  create mode 100644 arch/arm/dts/imx28-xea-2.dts
>  rename arch/arm/dts/{imx28-xea.dts =3D> imx28-xea.dtsi} (100%)

You should upstream imx28-xea-1.dts and imx28-xea-2.dts first.
