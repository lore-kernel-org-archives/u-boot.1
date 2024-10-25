Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6656FD116EE
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 05:23:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C69D188F47;
	Fri, 25 Oct 2024 07:23:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Fq2bd2bN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DA0788E65; Fri, 25 Oct 2024 07:23:13 +0200 (CEST)
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com
 [IPv6:2607:f8b0:4864:20::e2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0115B88FFD
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 07:23:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-4a5c4d8ee99so551377137.1
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 22:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729833788; x=1730438588; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Vu31gTrRRJRdyyjcK9N/lMOcK5gdO/gcwkmjzlM3CSU=;
 b=Fq2bd2bNrYmxhco64ydLZVIUE7iyNlvORAGO0pF4L5sl9CAP4/GGNjKIIS6uG3civv
 tZ1HjMioaWrapnrDwAymhf1NdEuJFH0+QpJLu8XzwDwdKOvS4GvwCYyq9LQ2z7Zd/rFl
 2ZvE2krPlBs4Bm2k2oh5ezffmIs7Vh9hWnIqLnz/G/5m4/P56iSRRClwFiemRc9pUFSY
 1fnFae6/HPFCLMU9wW2MA6jXq8yiIpjZlvQcvftAxtLJetDrTCiP2PQI+vWmpb9ndHF1
 CgbBxULGzNtbrDyNDgfJtknyKCJsyHoWYmzqiyBWrUDzoAsVSVjt1srI+LL90QVAUTfZ
 fjyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729833788; x=1730438588;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vu31gTrRRJRdyyjcK9N/lMOcK5gdO/gcwkmjzlM3CSU=;
 b=MVk1PkFeIKm5NcSUTLUv9/fouf+714IFJzJm+zKwX0cNsFxX1XfcEDPgmdesIM3PQh
 EBugGpIXwcQ3dmgRUGzk7ws8Cct4XRvaH/azRVOc34lhSj60p72WF2SUIyhkZdjrpQpE
 10e5P1rX34OuZvAL1HLPvQSm6FtUHX/ua3a/PYNFmieEjuAeZZubDkE1dfkEPaKGqNzH
 AvAv3+1qoST3YztOLnXkJHkHU6c5SPhfLP4OHiHpiit6S3LUgYNCrti/0+cF3891Is7I
 5siXmZ3f0vrLqFA8+Q2GRI6pT4kskW8RPuN7l+dDsQbEOLUzhuwHJsM8iGvB73Pdk87j
 pkOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWw6K4J6ZqnzTpATQbKgpYa2ofLdwZTiCItlkhelgyOAYXAWAObGJAqjbmWJpxtC2YZh5wjKy0=@lists.denx.de
X-Gm-Message-State: AOJu0YyLTmnWumvvf19ptmZzYKms10OG4OQgauyuZDkJcOXpGE5Rd+tv
 2CC59pJg5bjcY1EUYJ+7jLp6eM1QGmDULiO+YUNejga7gFRRZtw1uJzIlfmzjBnXoePc6N9zw54
 UW1lqe88fzJ7V/WTh0XGOyP2NPQ1A419oypj7QA==
X-Google-Smtp-Source: AGHT+IH8G1iE6hAQuTxwBx1sL9GFVZfLzLzJnc13+mYFILAETdZrzb76sZIwzJO0cW5UJaesNLi5AJVV+ZC01X8MALE=
X-Received: by 2002:a05:6102:c07:b0:4a5:b29f:34f with SMTP id
 ada2fe7eead31-4a751cb4ae9mr11365532137.26.1729833787853; Thu, 24 Oct 2024
 22:23:07 -0700 (PDT)
MIME-Version: 1.0
References: <20241024152448.102-1-paul.barker.ct@bp.renesas.com>
 <20241024152448.102-15-paul.barker.ct@bp.renesas.com>
In-Reply-To: <20241024152448.102-15-paul.barker.ct@bp.renesas.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 25 Oct 2024 10:52:56 +0530
Message-ID: <CAFA6WYMfwqWA-pb-9Q5Pn_jyoBQ4dt+-WeNEE3Vpmxx28pJ9vQ@mail.gmail.com>
Subject: Re: [PATCH 14/14] arm64: dts: renesas: rzg2l: Set Ethernet PVDD to
 1.8V
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

On Thu, 24 Oct 2024 at 20:56, Paul Barker <paul.barker.ct@bp.renesas.com> wrote:
>
> On the RZ/G2L & RZ/V2L SMARC SOMs, the RGMII interface between the SoC
> and the Ethernet PHY operates at 1.8V.
>
> The power supply for this interface may be correctly configured in
> u-boot, but the kernel should not be relying on this. Now that the
> RZ/G2L pinctrl driver supports configuring the Ethernet power supply
> voltage, we can simply specify the desired voltage in the device tree.
>
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Link: https://lore.kernel.org/20240625200316.4282-8-paul.barker.ct@bp.renesas.com
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> [ upstream commit: 96a3f525708120379013d9d3265663c07ceb38d5 ]
>
> (cherry picked from commit c535103b52a1edf50309dcbd1948d56520e84a1e)
> ---
>  .../src/arm64/renesas/rzg2l-smarc-som.dtsi     | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>

Acked-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/dts/upstream/src/arm64/renesas/rzg2l-smarc-som.dtsi b/dts/upstream/src/arm64/renesas/rzg2l-smarc-som.dtsi
> index 2b5e037ea9fa..83f5642d0d35 100644
> --- a/dts/upstream/src/arm64/renesas/rzg2l-smarc-som.dtsi
> +++ b/dts/upstream/src/arm64/renesas/rzg2l-smarc-som.dtsi
> @@ -182,6 +182,7 @@
>         eth0_pins: eth0 {
>                 txc {
>                         pinmux = <RZG2L_PORT_PINMUX(20, 0, 1)>; /* ET0_TXC */
> +                       power-source = <1800>;
>                         output-enable;
>                 };
>
> @@ -199,14 +200,19 @@
>                                  <RZG2L_PORT_PINMUX(25, 0, 1)>, /* ET0_RXD0 */
>                                  <RZG2L_PORT_PINMUX(25, 1, 1)>, /* ET0_RXD1 */
>                                  <RZG2L_PORT_PINMUX(26, 0, 1)>, /* ET0_RXD2 */
> -                                <RZG2L_PORT_PINMUX(26, 1, 1)>, /* ET0_RXD3 */
> -                                <RZG2L_PORT_PINMUX(1, 0, 1)>;  /* IRQ2 */
> +                                <RZG2L_PORT_PINMUX(26, 1, 1)>; /* ET0_RXD3 */
> +                       power-source = <1800>;
> +               };
> +
> +               irq {
> +                       pinmux = <RZG2L_PORT_PINMUX(1, 0, 1)>;  /* IRQ2 */
>                 };
>         };
>
>         eth1_pins: eth1 {
>                 txc {
>                         pinmux = <RZG2L_PORT_PINMUX(29, 0, 1)>; /* ET1_TXC */
> +                       power-source = <1800>;
>                         output-enable;
>                 };
>
> @@ -224,8 +230,12 @@
>                                  <RZG2L_PORT_PINMUX(34, 1, 1)>, /* ET1_RXD0 */
>                                  <RZG2L_PORT_PINMUX(35, 0, 1)>, /* ET1_RXD1 */
>                                  <RZG2L_PORT_PINMUX(35, 1, 1)>, /* ET1_RXD2 */
> -                                <RZG2L_PORT_PINMUX(36, 0, 1)>, /* ET1_RXD3 */
> -                                <RZG2L_PORT_PINMUX(1, 1, 1)>;  /* IRQ3 */
> +                                <RZG2L_PORT_PINMUX(36, 0, 1)>; /* ET1_RXD3 */
> +                       power-source = <1800>;
> +               };
> +
> +               irq {
> +                       pinmux = <RZG2L_PORT_PINMUX(1, 1, 1)>;  /* IRQ3 */
>                 };
>         };
>
> --
> 2.43.0
>
