Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F349C3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 16:07:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA688883BB;
	Fri, 19 Jul 2024 18:07:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FbiXezVW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3D0E8852E; Fri, 19 Jul 2024 18:07:06 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E06DC8826E
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 18:07:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2ee9bca8652so3677941fa.3
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 09:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721405224; x=1722010024; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/0fy+bLy6OvbjkRrkwTBJOxTQA00Gdh6HLU2X62Frug=;
 b=FbiXezVW5cqEZh6VWkOSYYX63fNQHRYuxYKp0aI9KqbIN1PuNMTHAfgKQNXT5JXHLd
 kxzcUBlf/PBbG2gz3zssJApyK7e6MbD5n3mlKSufT3YBa0UEdkGlJUv3ncMEfVRAUs6n
 OUurMTG0TJqS8aifWzQU+yRoPQgwq5Cx90XdhDACo7H2g8/dUrzxEqqRBGUIVKKeVKUR
 xqDFopkXCiuTUFpUF27XalDe0KNpCjfZt8chJc/dWtu+8++8TlE8uN/fhzGic9MwPfdO
 sYbj0o7bByG6NOFowe7JGvltG/ny7yaZoM4AR7El4Xj6lRyJsNvUkXOV/XXMDV9v+qGo
 CXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721405224; x=1722010024;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/0fy+bLy6OvbjkRrkwTBJOxTQA00Gdh6HLU2X62Frug=;
 b=gPJZYOjp1598Tgd3zdthtWVI3stqK/m83UpHDPOL8PC52XmxSUn6M6C1GRfShqeGyt
 oXxekCOO8FJDGIaQrpDpb0+IZlMXOi/os7+4N9nCa4Q8n1KLPIBCSx1zh8LE5mzNp9jc
 6JWH1/UJw0fpg1Isx5/2Pmo0syB0BF8TIMpUfNQjka1PQ3R5GEHhU4pXyIC4eBbGVtGC
 mRLJFpDLgvegC4XI/OYnBDFC+oTN470hZpK9pBculF4sYhOuZZ9km4wJDxNbYfCfgzNy
 9THGLV2ZJx8bm5u9iV5DpZUln4VfwEoCXqe9Yz8y6jpAk8OwMOkUK6oK1+s+oEBULM+7
 zoCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW615Iof8607yUFSZcRBNjFmPWuUMimX3siDsvQ3BKTayqJ1yJn6f8HS0Xvmlmr7gH78Z+dHp1gCQQd8JWpvs0DUas6KQ==
X-Gm-Message-State: AOJu0YzXugR3/ny/fMPWF1YF5RKwuHWBOhUGl/Dl4kyWXJSe1iW7ofes
 JdLdygHRBpTYL41wTL65++2sLTT06SQiupw8Onnun6ijPtB+MukEET7xqJX+xVJY8zv9PB+ycsJ
 mionFPl6FAYB3Wv2aurnsK86Ko0Q=
X-Google-Smtp-Source: AGHT+IFgzcNMn0hy88gLH8nhY9MQDyuq+cXQ52waLXuYxjaYyTBrufkruPaLAdJK0oL0EhQpZ1D5GLGT9rUoD3iQ7rA=
X-Received: by 2002:a2e:1f12:0:b0:2ee:83f7:8b36 with SMTP id
 38308e7fff4ca-2ef16789ae6mr796481fa.2.1721405223920; Fri, 19 Jul 2024
 09:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240718165454.904763-1-festevam@gmail.com>
 <abf7f940-1bfb-4e5f-937b-135a580034b3@armadeus.com>
 <CAOMZO5D4FFvK=L+GwdfpLAyGBV2d2t-9d3GGTAuXYU0jt3kfjg@mail.gmail.com>
 <e1645877-d5b8-44f5-b185-5427b28fa2e7@armadeus.com>
In-Reply-To: <e1645877-d5b8-44f5-b185-5427b28fa2e7@armadeus.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 19 Jul 2024 13:06:51 -0300
Message-ID: <CAOMZO5DRwa86mRLdxGaCyBMUkUPuc25HQt-nUOThzOHSxWZLpg@mail.gmail.com>
Subject: Re: [PATCH] imx93-u-boot: Describe the CPU clocks in the devicetree
To: =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>
Cc: peng.fan@nxp.com, uboot-imx@nxp.com, m.othacehe@gmail.com, 
 u-boot@lists.denx.de
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

Hi S=C3=A9bastien,

On Fri, Jul 19, 2024 at 12:47=E2=80=AFPM S=C3=A9bastien Szymanski
<sebastien.szymanski@armadeus.com> wrote:

> I did look at imx8mm.dtsi but the clock IMX8MM_CLK_ARM is not defined in
> U-Boot and in Linux it's defined as:
>
> hws[IMX8MM_CLK_ARM] =3D imx_clk_hw_cpu("arm", "arm_a53_core",
>                                       hws[IMX8MM_CLK_A53_CORE]->clk,
>                                      hws[IMX8MM_CLK_A53_CORE]->clk,
>                                       hws[IMX8MM_ARM_PLL_OUT]->clk,
>                                      hws[IMX8MM_CLK_A53_DIV]->clk);
>
> So in Linux for the i.MX93, the clocks property in the device tree has
> to be IMX93_CLK_A55_CORE:
>
> clks[IMX93_CLK_A55_CORE] =3D imx_clk_hw_cpu("a55_core", "a55_sel",
>                                         clks[IMX93_CLK_A55_SEL]->clk,
>                                         clks[IMX93_CLK_A55_SEL]->clk,
>                                         clks[IMX93_CLK_ARM_PLL]->clk,
>                                         clks[IMX93_CLK_A55_GATE]->clk);
>
> ?

Yes, that's correct. I will use IMX93_CLK_A55_CORE when upstreaming it.

At some point, we should align these clock names between Linux and U-Boot.

For now, as I am touching arch/arm/dts/imx93-u-boot.dtsi this is OK
for U-Boot purposes.

Thanks
