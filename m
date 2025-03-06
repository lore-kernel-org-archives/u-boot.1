Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0F9C282DE
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 15:57:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69771810DC;
	Thu,  6 Mar 2025 16:57:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hrPRgQQs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C4F4811C1; Thu,  6 Mar 2025 16:57:41 +0100 (CET)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7C0380F4C
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 16:57:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-3061513d353so8772731fa.2
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 07:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741276658; x=1741881458; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RbED/NFFW08nmWsZfvBpBs9SS4T7Y4UZtpgoM6hXjKs=;
 b=hrPRgQQs9525SzTOlEmQK6d19jdLaFdze7k1nx6WapJVQyLP028JFSS1q2730qodrh
 u2exyN9Oq5nP9TGU83vroM3jQe0/MI3Al5nvQQu1Q6g16jlx26eVcmB1zy7ncA/M2+4A
 uNunGmBnukn75PmagVbEZSh+VbBgVkSGlMR576msPMfJz6fpfkvdxj1SEzVI9qAskxCz
 3CwOylcUQn+1nPEhxHuku5Gh1EqXEZIXcR123b6Moxo8IDXFrlwwu06KRZ16De5gC6bf
 CZk5q/4PWQE5rvUnGp1VC6ixlDc+NoT3njnYwIIDi1DjT/08jigLkaaXcFM16mJsM3tp
 IotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276658; x=1741881458;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RbED/NFFW08nmWsZfvBpBs9SS4T7Y4UZtpgoM6hXjKs=;
 b=uKZUFyJnsAkpnC85g85KhZFSFPewnc4p+7jonKiAN0qERevoV2jtefriD03Mj5v0aD
 XmzuGpb5cm2hCUaZs9rz4MiLGsKiy0fkoRfOS08jnP1rkJrMJWI246YdGjHHmuuKRgp3
 e/QAIHsfCmUr/J0mstFL7n6uJT/5zzJEDTKQy4baqIpnWWKw4aCydBQ46wuQ1Qhim2Iv
 A5ep3VbaYH6BGTRF5xuGp4lXBXzRUZb07FMTPzfZEpW8AMR/uyegYuNuHkmuPx1BztNp
 xBYaPJvvUy4qlkQGMcPpqBKyHzz9716/LUqpluYeUxLPzJwRYp8Cqu+X+oeUfw2kMu0r
 dw7g==
X-Gm-Message-State: AOJu0Yxyj09lxkZAFW1BaAJ5uJ6MvMJYDTfuCL6TkD+MZmDGHMDRxujd
 gAgNqPUC2OmHFYubpKnyG1RCb9VSb5w3MyOROrBow4S2dJS3oHAxtsyZ6TOTRlxEQYvJ63Bj+Be
 8q+EisHmWKlnkOQb6nwUCtOHqoQo=
X-Gm-Gg: ASbGncv7TI6UnQ66T7+ow1or6e8m+eY0KfTWca5aFwhAeQlLkCH63XLLvSSnI4dmS5V
 72gHadk4pu0ifhiuIr4NOFcP59QNhlfvaKiTz9/B9t7ACj/2ZCYxXdyTT0R3Pv0YyAkfanZK27N
 q/uBYNhLPAsBYYvB/5zmawVyhh4BxVFoXQ57I2MbV3Eqp9VnxsGagk0+oP
X-Google-Smtp-Source: AGHT+IFAFPf26HBjqQC0uobeUCuv5C03eK1YRPXcCAdiEiXB0RYJE0LmCSp4lIw3n6OgI2d/iUYIYQddWeBCL1KdIuA=
X-Received: by 2002:a05:651c:544:b0:30b:c83e:720f with SMTP id
 38308e7fff4ca-30bd7a1e060mr27660601fa.7.1741276658048; Thu, 06 Mar 2025
 07:57:38 -0800 (PST)
MIME-Version: 1.0
References: <20250302165249.267992-1-aford173@gmail.com>
 <20250302165249.267992-2-aford173@gmail.com>
In-Reply-To: <20250302165249.267992-2-aford173@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 6 Mar 2025 12:57:26 -0300
X-Gm-Features: AQ5f1Jq5mMv_W3Mo8tghyImSrhGlKn-FjT67RuPwtOFVP-7f1sSi6ZbmKk36pFc
Message-ID: <CAOMZO5Ay+Msrj7tMBm8noLKHe5iPAN4=nOgX9tu7wKbWjeSPNA@mail.gmail.com>
Subject: Re: [PATCH 01/10] clk: imx6q: Properly handle imx6qp ESPI clk_sels
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Emil Kronborg <emil.kronborg@protonmail.com>, 
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Tim Harvey <tharvey@gateworks.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peter Robinson <pbrobinson@gmail.com>
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

On Sun, Mar 2, 2025 at 1:53=E2=80=AFPM Adam Ford <aford173@gmail.com> wrote=
:
>
> The ECSPI clock has the ability to select between pll3_60m and
> osc on the imx6qp, where it's fixed on other variants.  Fix this
> by adding using a helper function to determine SoC variant and
> register the clock accordingly.

s/ESPI/ECSPI in the Subject.

> +       if (clk_on_imx6qp()) {
> +               clk_dm(IMX6QDL_CLK_ECSPI_SEL,
> +                      imx_clk_mux("ecspi_sel", base + 0x38, 18, 1, ecspi=
_sels,
> +                                  ARRAY_SIZE(ecspi_sels)));
> +       }

No need for { }.

> +
>         clk_dm(IMX6QDL_CLK_USDHC1_PODF,
>                imx_clk_divider("usdhc1_podf", "usdhc1_sel",
>                                base + 0x24, 11, 3));
> @@ -91,9 +103,13 @@ static int imx6q_clk_probe(struct udevice *dev)
>                imx_clk_divider("usdhc4_podf", "usdhc4_sel",
>                                base + 0x24, 22, 3));
>
> -       clk_dm(IMX6QDL_CLK_ECSPI_ROOT,
> -              imx_clk_divider("ecspi_root", "pll3_60m", base + 0x38, 19,=
 6));
> -
> +       if (clk_on_imx6qp()) {
> +               clk_dm(IMX6QDL_CLK_ECSPI_ROOT,
> +                      imx_clk_divider("ecspi_root", "ecspi_sel", base + =
0x38, 19, 6));
> +       } else {
> +               clk_dm(IMX6QDL_CLK_ECSPI_ROOT,
> +                      imx_clk_divider("ecspi_root", "pll3_60m", base + 0=
x38, 19, 6));
> +       }

Same here.
