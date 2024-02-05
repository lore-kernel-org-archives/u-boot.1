Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC51C4828D
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 20:20:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34BA887AEC;
	Mon,  5 Feb 2024 21:20:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks-com.20230601.gappssmtp.com header.i=@gateworks-com.20230601.gappssmtp.com header.b="fzHA8NAA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B94C87AEC; Mon,  5 Feb 2024 21:20:03 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A26F87A80
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 21:20:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a29c4bbb2f4so584309566b.1
 for <u-boot@lists.denx.de>; Mon, 05 Feb 2024 12:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks-com.20230601.gappssmtp.com; s=20230601; t=1707164399; x=1707769199;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CG9IurWwlKsf+Zc8lhBvw1AtUp/mWdva8MciR1+LVAE=;
 b=fzHA8NAAkodoiHKhx7YyM1BFwhhfQW2z9P1/RCpqNq6rJf2W3nOzEcd0UMbN3bmCB3
 67jqQ3puEXggWKquorXe7FI6CCcJ8MTw4eLFfQOXV48BA4o8WZgOedf/h5gxug1xcHOH
 6Yats195znLbIisHPpTcZin7o3V9KE71H42v4+TGs0zJRhpoNdNsWSYFxQ+BU8mkKWg2
 5DOc2WnUZiix1esg1Cho37QdYAIHzLMLW7n0Az/P8JCwYS6cz93i7CgQCUj0kRvdMLNn
 wm9lZI5ASH+OyOPAO2Bd3lmJ6wY+M7nQ6IY6Y3ME8Puj4aWmOlJZnWN4Pd0N4RaHcmTR
 89mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707164399; x=1707769199;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CG9IurWwlKsf+Zc8lhBvw1AtUp/mWdva8MciR1+LVAE=;
 b=Q9oD9TlNq9DApMNZLc54du95qf73w9HSvxE4TW1LCqZS2N0MaxARwju14A11qLbGSA
 8QWT2Zj0+53KOCCcY05gV0nptw1uF+7mQ+VT0ZyyJH7iftUEJi4fEhaxmeZdUs1cAEHO
 ZVvkIxMMtfFl+tuucWUDYkViok8lBuL9UXNmLmh0h1Vz1aw8WHSXPJ3WjCpiMLKDKcOG
 SS5J7huuRsjHWWpY1W1ipJk2MD27vwdUOZMMVIz2s6NuC4lvQ2l0cTL/tIuptiJ5+KuM
 Yls1PYVfL73GnpB1xM0K47+ECaT/dwmmFL/8DvqhiKppMy/t7OqDZ6AZp89syo2i4HBm
 pv/A==
X-Gm-Message-State: AOJu0YyNy4AdMYNP8sxlZTzYHRgDEqGIlcNn/vPIKtVgwTHiP9r062F6
 FGX7ufsTnKq8r9apHSJ8Lp8gQI+2f9oEAjGJkFyLijUkU5WvqeDoaXNoY3NS1Qq2lLZOTCdvZ1v
 wmpPMLkq7QaFNiaIlnCrLONZkmW7k/xPex0UL0g==
X-Google-Smtp-Source: AGHT+IGfpiVMkb8Ruz2JEmV6e1z+8VSgNEBnJ7IVRVLVjw3y5520BQfFGjCoAT634F128JcjPycv09p600fivOkKZ4s=
X-Received: by 2002:a17:906:2ac7:b0:a37:9b79:9c27 with SMTP id
 m7-20020a1709062ac700b00a379b799c27mr38853eje.37.1707164399516; Mon, 05 Feb
 2024 12:19:59 -0800 (PST)
MIME-Version: 1.0
References: <20240205190858.3076363-1-tharvey@gateworks.com>
 <CAOMZO5CmMDhHKndFbbKsR8e82ShXnSz95yE2nPXqQog_2CpE_Q@mail.gmail.com>
In-Reply-To: <CAOMZO5CmMDhHKndFbbKsR8e82ShXnSz95yE2nPXqQog_2CpE_Q@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Mon, 5 Feb 2024 12:19:47 -0800
Message-ID: <CAJ+vNU2XHZBzabTpR=4WG8pQgbdQ5HcOMG1pueAEo0zBfZ7X-A@mail.gmail.com>
Subject: Re: [PATCH 0/5] update venice dts
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
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

On Mon, Feb 5, 2024 at 11:22=E2=80=AFAM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi Tim,
>
> On Mon, Feb 5, 2024 at 4:09=E2=80=AFPM Tim Harvey <tharvey@gateworks.com>=
 wrote:
> >
> > This series brings some recent upstream Linux dt updates into U-Boot fo=
r
> > the Gateworks Venice family.
>
> Please specify what "some recent upstream Linux dt" means.
>
> Is it 6.8-rc, linux-next, or Shawn's tree?
>
> Can't you instead sync the imx8mm-venice DTs in U-Boot with this kernel t=
ree?
>
> > Tim Harvey (5):
> >   arm: dts: imx8mm-venice-gw7901: add digital I/O direction control GPI=
O's
> >   arm: dts: imx8mm-venice-gw7901: add TPM device
> >   arm: dts: imx8mm-venice-gw71xx: fix USB OTG VBUS
> >   arm: dts: imx8mm-venice-gw71xx: add TPM device
> >   arm: dts: imx8mp-venice-gw71xx: add TPM device
> >
> >  .../dts/imx8mm-venice-gw71xx-0x-u-boot.dtsi   |  7 ++++
> >  arch/arm/dts/imx8mm-venice-gw71xx.dtsi        | 40 +++++++++----------
> >  arch/arm/dts/imx8mm-venice-gw7901-u-boot.dtsi | 14 +++++++
>
> Why is u-boot.dtsi being touched? Please add a justification.
>
> >  arch/arm/dts/imx8mm-venice-gw7901.dts         | 14 ++++++-
> >  .../dts/imx8mp-venice-gw71xx-2x-u-boot.dtsi   |  9 +++++
>
> Same here.

Fabio,

Ok, makes sense - drop this series. I will send a single patch instead
with more detail if needed in the commit log.

Best regards,

Tim
