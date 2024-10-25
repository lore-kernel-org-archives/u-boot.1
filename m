Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49895D116EF
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 05:23:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C4CD88FBF;
	Fri, 25 Oct 2024 07:22:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XAtt4IBT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 128B988E65; Fri, 25 Oct 2024 07:22:58 +0200 (CEST)
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com
 [IPv6:2607:f8b0:4864:20::e34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F49388FBF
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 07:22:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-4a5b15cedd6so593895137.2
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 22:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729833771; x=1730438571; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o8e1wPw5s2UmCJiNoqEMHdlbnuB3uI9J7zWAe1L5+g8=;
 b=XAtt4IBTRMTqywEEZPDxhRC6YCGBrctDBBTHvOcglNkx+nQODXVL39WPBt7jUj8plX
 EaxfADBg35ZnUS/JGQ2eU69LUE6FcAma7g8beQbyRSNeTIeblGvb2BgZPGWlsyB9agoq
 k8HPuu0zhiH9UqaOjBBbO9E+4L/Rk9MZsJ5A1uG+xvdmTbwnROJDDrfT+J0vR/6fRtzS
 ixflHVYfP0PUaW1J/cf0R8CDCs3QYGr+3nsFvq/zEwh8GOW4YF9OJANAcqzG3VXvhQkX
 V0XyOTCp2LsrhRrYg0SlR9tKnReczupMe3tT56b2L4Xl1lXCaemX/gpLxAjeJjQ46XYk
 n/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729833771; x=1730438571;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o8e1wPw5s2UmCJiNoqEMHdlbnuB3uI9J7zWAe1L5+g8=;
 b=w6+p3pJUTiYiQ54ag4cw/SjAsdmJIEThL7+7yP32ua0inbRSjN4o3MhgRRa4AZsQug
 30MjMS6FtjxvqA7dNQeFw8x4Y5MEgFNV1pcXsfE1JrlcSGyZOeP+yj4z6K3RZs59BwoH
 vLBBSy7MaK8q0OM/nCD20wj2soxiGoMZMFWWw2/roqTN4tmEFSQzpfyDHvcd1jJuam83
 3CbA09iWnS9/L13HRAfsiGEr5wHXQ0W33PfTJi3DjzzkNIVBc3vC+//4i20631c3tUhC
 MeAbIfe95c6v5dKLe3YazDdFSaGAruRLx4VyHXR/YRwP/7xqOlh79F46dvsZxp+mNa/W
 MhTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxlTTlSypcMYqJTaYJRVAC/OJgA5FoEd3Q2MXN0m3GjWXs3o/CAS7WvXr0tOlzLbH0RzPKhxY=@lists.denx.de
X-Gm-Message-State: AOJu0YzR/Nyzf42/F7heGD10FT+M9p+53Ue26fEnZZeDQRGzxDZSOeB3
 rTMPgJZiGiwlxZBC9KvGGfqJMLyt1tQnfNsJ3enFh8bDVZev5inL/k7hUjvmZQe+vJwFAFObtgP
 WawvOUrR1YA8FkRAA8iWNLUMmoYWGwwCWF9K5Lg==
X-Google-Smtp-Source: AGHT+IGhgTa7UnFWerjEdvbTqNaq0kcKKCF8svC6NOVupqA/V36SSxrcJ8pCdD7FKVYRqpPMwJD8wHwlizkbfZLELHY=
X-Received: by 2002:a05:6102:a4e:b0:4a4:90bc:17b4 with SMTP id
 ada2fe7eead31-4a751cd2febmr10479735137.29.1729833771038; Thu, 24 Oct 2024
 22:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <20241024152448.102-1-paul.barker.ct@bp.renesas.com>
 <20241024152448.102-14-paul.barker.ct@bp.renesas.com>
In-Reply-To: <20241024152448.102-14-paul.barker.ct@bp.renesas.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 25 Oct 2024 10:52:39 +0530
Message-ID: <CAFA6WYN34o+HKXuG89TmcpTV7_Qi1kz6C=qE3dTJUKg2kUhiWg@mail.gmail.com>
Subject: Re: [PATCH 13/14] arm64: dts: renesas: rzg2l: Enable Ethernet TXC
 output
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>,
 u-boot@lists.denx.de, Geert Uytterhoeven <geert+renesas@glider.be>,
 Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 24 Oct 2024 at 20:55, Paul Barker <paul.barker.ct@bp.renesas.com> wrote:
>
> Configure ET0_TXC and ET1_TXC as outputs on the Renesas RZ/[GV]2L SMARC
> SoMs, as per RGMII specification.
>
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Link: https://lore.kernel.org/20240625200316.4282-5-paul.barker.ct@bp.renesas.com
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> [ upstream commit: 41c934da488d3a5a79148ead3b5c5eecac1b1d5d ]
>
> (cherry picked from commit 11cbf7bc3124f3d5267ea6aef8e4ba6d6b4f589e)
> ---
>  .../src/arm64/renesas/rzg2l-smarc-som.dtsi    | 76 +++++++++++--------
>  1 file changed, 44 insertions(+), 32 deletions(-)
>

Acked-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/dts/upstream/src/arm64/renesas/rzg2l-smarc-som.dtsi b/dts/upstream/src/arm64/renesas/rzg2l-smarc-som.dtsi
> index 4409c47239b9..2b5e037ea9fa 100644
> --- a/dts/upstream/src/arm64/renesas/rzg2l-smarc-som.dtsi
> +++ b/dts/upstream/src/arm64/renesas/rzg2l-smarc-som.dtsi
> @@ -180,41 +180,53 @@
>         };
>
>         eth0_pins: eth0 {
> -               pinmux = <RZG2L_PORT_PINMUX(28, 1, 1)>, /* ET0_LINKSTA */
> -                        <RZG2L_PORT_PINMUX(27, 1, 1)>, /* ET0_MDC */
> -                        <RZG2L_PORT_PINMUX(28, 0, 1)>, /* ET0_MDIO */
> -                        <RZG2L_PORT_PINMUX(20, 0, 1)>, /* ET0_TXC */
> -                        <RZG2L_PORT_PINMUX(20, 1, 1)>, /* ET0_TX_CTL */
> -                        <RZG2L_PORT_PINMUX(20, 2, 1)>, /* ET0_TXD0 */
> -                        <RZG2L_PORT_PINMUX(21, 0, 1)>, /* ET0_TXD1 */
> -                        <RZG2L_PORT_PINMUX(21, 1, 1)>, /* ET0_TXD2 */
> -                        <RZG2L_PORT_PINMUX(22, 0, 1)>, /* ET0_TXD3 */
> -                        <RZG2L_PORT_PINMUX(24, 0, 1)>, /* ET0_RXC */
> -                        <RZG2L_PORT_PINMUX(24, 1, 1)>, /* ET0_RX_CTL */
> -                        <RZG2L_PORT_PINMUX(25, 0, 1)>, /* ET0_RXD0 */
> -                        <RZG2L_PORT_PINMUX(25, 1, 1)>, /* ET0_RXD1 */
> -                        <RZG2L_PORT_PINMUX(26, 0, 1)>, /* ET0_RXD2 */
> -                        <RZG2L_PORT_PINMUX(26, 1, 1)>, /* ET0_RXD3 */
> -                        <RZG2L_PORT_PINMUX(1, 0, 1)>;  /* IRQ2 */
> +               txc {
> +                       pinmux = <RZG2L_PORT_PINMUX(20, 0, 1)>; /* ET0_TXC */
> +                       output-enable;
> +               };
> +
> +               mux {
> +                       pinmux = <RZG2L_PORT_PINMUX(28, 1, 1)>, /* ET0_LINKSTA */
> +                                <RZG2L_PORT_PINMUX(27, 1, 1)>, /* ET0_MDC */
> +                                <RZG2L_PORT_PINMUX(28, 0, 1)>, /* ET0_MDIO */
> +                                <RZG2L_PORT_PINMUX(20, 1, 1)>, /* ET0_TX_CTL */
> +                                <RZG2L_PORT_PINMUX(20, 2, 1)>, /* ET0_TXD0 */
> +                                <RZG2L_PORT_PINMUX(21, 0, 1)>, /* ET0_TXD1 */
> +                                <RZG2L_PORT_PINMUX(21, 1, 1)>, /* ET0_TXD2 */
> +                                <RZG2L_PORT_PINMUX(22, 0, 1)>, /* ET0_TXD3 */
> +                                <RZG2L_PORT_PINMUX(24, 0, 1)>, /* ET0_RXC */
> +                                <RZG2L_PORT_PINMUX(24, 1, 1)>, /* ET0_RX_CTL */
> +                                <RZG2L_PORT_PINMUX(25, 0, 1)>, /* ET0_RXD0 */
> +                                <RZG2L_PORT_PINMUX(25, 1, 1)>, /* ET0_RXD1 */
> +                                <RZG2L_PORT_PINMUX(26, 0, 1)>, /* ET0_RXD2 */
> +                                <RZG2L_PORT_PINMUX(26, 1, 1)>, /* ET0_RXD3 */
> +                                <RZG2L_PORT_PINMUX(1, 0, 1)>;  /* IRQ2 */
> +               };
>         };
>
>         eth1_pins: eth1 {
> -               pinmux = <RZG2L_PORT_PINMUX(37, 2, 1)>, /* ET1_LINKSTA */
> -                        <RZG2L_PORT_PINMUX(37, 0, 1)>, /* ET1_MDC */
> -                        <RZG2L_PORT_PINMUX(37, 1, 1)>, /* ET1_MDIO */
> -                        <RZG2L_PORT_PINMUX(29, 0, 1)>, /* ET1_TXC */
> -                        <RZG2L_PORT_PINMUX(29, 1, 1)>, /* ET1_TX_CTL */
> -                        <RZG2L_PORT_PINMUX(30, 0, 1)>, /* ET1_TXD0 */
> -                        <RZG2L_PORT_PINMUX(30, 1, 1)>, /* ET1_TXD1 */
> -                        <RZG2L_PORT_PINMUX(31, 0, 1)>, /* ET1_TXD2 */
> -                        <RZG2L_PORT_PINMUX(31, 1, 1)>, /* ET1_TXD3 */
> -                        <RZG2L_PORT_PINMUX(33, 1, 1)>, /* ET1_RXC */
> -                        <RZG2L_PORT_PINMUX(34, 0, 1)>, /* ET1_RX_CTL */
> -                        <RZG2L_PORT_PINMUX(34, 1, 1)>, /* ET1_RXD0 */
> -                        <RZG2L_PORT_PINMUX(35, 0, 1)>, /* ET1_RXD1 */
> -                        <RZG2L_PORT_PINMUX(35, 1, 1)>, /* ET1_RXD2 */
> -                        <RZG2L_PORT_PINMUX(36, 0, 1)>, /* ET1_RXD3 */
> -                        <RZG2L_PORT_PINMUX(1, 1, 1)>;  /* IRQ3 */
> +               txc {
> +                       pinmux = <RZG2L_PORT_PINMUX(29, 0, 1)>; /* ET1_TXC */
> +                       output-enable;
> +               };
> +
> +               mux {
> +                       pinmux = <RZG2L_PORT_PINMUX(37, 2, 1)>, /* ET1_LINKSTA */
> +                                <RZG2L_PORT_PINMUX(37, 0, 1)>, /* ET1_MDC */
> +                                <RZG2L_PORT_PINMUX(37, 1, 1)>, /* ET1_MDIO */
> +                                <RZG2L_PORT_PINMUX(29, 1, 1)>, /* ET1_TX_CTL */
> +                                <RZG2L_PORT_PINMUX(30, 0, 1)>, /* ET1_TXD0 */
> +                                <RZG2L_PORT_PINMUX(30, 1, 1)>, /* ET1_TXD1 */
> +                                <RZG2L_PORT_PINMUX(31, 0, 1)>, /* ET1_TXD2 */
> +                                <RZG2L_PORT_PINMUX(31, 1, 1)>, /* ET1_TXD3 */
> +                                <RZG2L_PORT_PINMUX(33, 1, 1)>, /* ET1_RXC */
> +                                <RZG2L_PORT_PINMUX(34, 0, 1)>, /* ET1_RX_CTL */
> +                                <RZG2L_PORT_PINMUX(34, 1, 1)>, /* ET1_RXD0 */
> +                                <RZG2L_PORT_PINMUX(35, 0, 1)>, /* ET1_RXD1 */
> +                                <RZG2L_PORT_PINMUX(35, 1, 1)>, /* ET1_RXD2 */
> +                                <RZG2L_PORT_PINMUX(36, 0, 1)>, /* ET1_RXD3 */
> +                                <RZG2L_PORT_PINMUX(1, 1, 1)>;  /* IRQ3 */
> +               };
>         };
>
>         gpio-sd0-pwr-en-hog {
> --
> 2.43.0
>
