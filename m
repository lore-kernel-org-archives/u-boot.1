Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B2DC369DC
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 16:11:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04F0C8214A;
	Mon, 28 Apr 2025 18:11:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RN7tPzjx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDE8282155; Mon, 28 Apr 2025 18:11:13 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8C4C8211F
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 18:11:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-30dd5a93b49so45453361fa.0
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 09:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745856671; x=1746461471; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uo0Dxakwb5cxoazCvKN/+GfuTQRd+7T/7VHMgjFm8Uw=;
 b=RN7tPzjxq+RssxDo/3KxpXAVdQZuYrfMtKPcnmJKQIPKvfRSUmAaLpyED+XuL+pBIt
 iIpSlHndv2DUuwDDKUL+aX8yyIWzDNFfYIgnDYuDO74w6PxX0y5oboBUwLjNlRqJwyLL
 Rr/CYsbbIz00mC3ZsFhhGILj19JU48Nxnf/vN9hs6YRKZ7TS+9gkhD+HTgrFY/iCG+UU
 fXtjudsCED0eZhygsgsQMHSyqNaE5kk0Lv7f+VSnsXTgNptNNc1BK+XDyeBeA0y4YMmy
 4BaGDYHJOrJhR4mV/3XsOYdYsp0+YoD7icLK1CYLJYPTMvUkuKsXOPvr7memLAN/6MJ1
 qaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745856671; x=1746461471;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uo0Dxakwb5cxoazCvKN/+GfuTQRd+7T/7VHMgjFm8Uw=;
 b=YS7Xrgc0vUoN2NXH4pUHdLSfZeo1oO0zvpsC7EJa4a3naUvjc9QpaLKX/NobyNDCrZ
 BJcBChw2rvO1kg1OzZbgQWtS09rP91hED/rujRwkd8+8xGpUkpcCdvF0We/w8E4Meqga
 vrrTXLXZk4Mlma9oNr6a1AneLtmAlvR1HfZW22mjxG7n4lG7CP/nFUE7Ty+qV7+yxYbl
 vjxvcJSdFBjPfRKT0OS+hRVnkuJh7VYavFm6neLwe9HeRF98JkJiC1Z5UgkJ+DHOUAmQ
 S0s2+l3Q3pydbQntcLBRxA+zegtAwqDw4R/hR0jxGUS7ZxeGuLitxUdC2NkhQ4HWOpYE
 LolQ==
X-Gm-Message-State: AOJu0YxQ9yOq3nXTmF/lZ6MiIg80hR7MR+SdM6rbpwcDGtBMLbOTXxJt
 DQdtmUjgMLvWx8CkTqnz+yHlhCI9ozbwm4NIbTSi/W2PrvrIBGY1GI6GN1bQ+TIOWuG0gYwGyAw
 eS3hrDJiVjUEb7fO8mH5SD1lAiPI=
X-Gm-Gg: ASbGncuc6TaZ/V4fwaTA5Y/3RU0obvfmj4XXXbABERs23OKf0VsWCFT9QJE+Ks9xorp
 QrYCn5FNr4VaPiwUO5uAPx7CDUoHQIbMwhvJkLreZB7O6sx+ygAYdoixxc3G7Zu4YVEIFtBYCVp
 QAPCVVS7iYAOH56+DKYniU0S+Ukw+KeWaV6pvxDpacIG696J13JOzakif7bAiH4Cl+
X-Google-Smtp-Source: AGHT+IE+sRoHXSd1OxR24zKGk+3NdrCRCM67QuZETshiOkFZfns/8clJ4yJPfeQuAoSgdUGKJOXXrTDYZekqkqkT1xE=
X-Received: by 2002:a05:651c:3134:b0:30c:3099:13d0 with SMTP id
 38308e7fff4ca-319dc41dd0fmr34316791fa.21.1745856670773; Mon, 28 Apr 2025
 09:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250427154002.146276-1-marex@denx.de>
In-Reply-To: <20250427154002.146276-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 28 Apr 2025 13:10:59 -0300
X-Gm-Features: ATxdqUE6H52l7p1EHnpd2WTd_n7uzvyo1pqx3m7ljozWWLHyXSm8EQLMwOBIX9s
Message-ID: <CAOMZO5B70rvt-BUo0riMQBoQ26BfnSUniYxhZpWtGWpgfE1how@mail.gmail.com>
Subject: Re: [PATCH] clk: imx: Pass CCM udevice into clk_register_composite()
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Adam Ford <aford173@gmail.com>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, Peng Fan <peng.fan@nxp.com>, 
 Sean Anderson <seanga2@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 Tom Rini <trini@konsulko.com>
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

On Sun, Apr 27, 2025 at 12:40=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Pass the clock controller udevice into clk_register_composite(),
> so it can be passed further to any registered composite clocks
> and used for look up of parent clock referenced in DT "clocks"
> and "clock-names" properties by phandle and name pair.
>
> Use the clock controller udevice in imx8m_clk_mux_set_parent()
> to perform accurate look up of parent clock referenced in the
> CCM driver by name. If the clock name that is being looked up
> matches one of the names listed in the clock controller DT node
> "clock-names" array property, then the offset of the name is
> looked up in the "clocks" DT property and the phandle at that
> offset is resolved to the parent clock udevice. The test to
> determine whether a particular driver instance registered with
> clock uclass matches the parent clock is done by comparing the
> OF nodes of the clock registered with clock uclass and parent
> clock resolved from the phandle.
>
> Example:
>
> drivers/clk/imx/clk-imx8mm.c:
> static const char * const imx8mm_a53_sels[] =3D {"osc_24m", "arm_pll_out"=
, ...
>                                       _____________|
> arch/arm/dts/imx8mm.dtsi:            |
> clk: clock-controller@30380000 {     v
>         clock-names =3D "osc_32k", "osc_24m", ...
>                                    |
>                                    v
>         clocks =3D <&osc_32k>, <&osc_24m>, ...
> };          _______________________|
> ...        |
> / {        v
>         osc_24m: clock-osc-24m {
>                 compatible =3D "fixed-clock";
> ...
> };
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied, thanks.
