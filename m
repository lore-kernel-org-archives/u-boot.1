Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27F6C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 14:27:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AFBE871DA;
	Thu,  9 Nov 2023 15:27:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gerhold.net header.i=@gerhold.net header.b="V2h9b+VM";
	dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="HvjJBe3h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3986C871DA; Thu,  9 Nov 2023 15:27:15 +0100 (CET)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [81.169.146.165])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 461B28719B
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 15:27:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=stephan@gerhold.net
ARC-Seal: i=1; a=rsa-sha256; t=1699540032; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=tLFnugzpV1Nz4ux4f8NDZFBgXOuS5tjFI/EtH82jJeBYYsgHNKDyNOg+AhxLVlUAyM
 oPy9oAwpmDwNuWpxXVh8ENSWBsxEz/MMjdFyUEF4GVuAAGCw6oJ0bQuSV/vuwBYzNmBy
 WEwB7wkyjP3Y1qBwqXmOjAj7UJzFKrweXV5expjcGmZiRMbk3cZ6OqvBMsXz3sj5Himo
 lBhsth/ZK+JOyXjgGOeHGKjDwzSbYaNlSUhBe9E/FuPh+rdv8Q5xu8hUQOwxO1zolZzo
 LuHRYL+OQI3tTfYDWdpyD4kT6q+NyvNdzlu5l1evEA0wnMo+q1Q6lfpeqXGdLm4kInXE
 zQRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1699540032;
 s=strato-dkim-0002; d=strato.com;
 h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=XBYKkhm1B8n4QYIK02vpqbBuxz8NmLFMo/8Z/3dRV+c=;
 b=sPaJCXVNyIaCG1/0XjV+8sHRbAURr1hiJd8tnlKx4KWhfGh3FInH0TSOVzZq3r7nlF
 CWR9hoc2gGOSCM65RwTXCXbqp2XK5mjPLQqTpFp7/9+IbGEJiHZcqx7ACDDmklj87wqR
 5WzsEg3H4lepCZfRbdy0ur7ApPfEnWCYKwQYAx/o7qy5fFqxwkbgLoDlWK0RRZwhmI8R
 TScwoSaX4IW4BGH3OEBIQ9uozOMD9Uv9HbfyzRr8RfhUHTvByobjv35bTgPjwcQ3GPSC
 pMKsNVibANNnrNq5fzL3y19UmkLjyb0oT0Skmg/WPlNsHf9Us/BFFhGbQMGQcJBInzyF
 kzrQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1699540032;
 s=strato-dkim-0002; d=gerhold.net;
 h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=XBYKkhm1B8n4QYIK02vpqbBuxz8NmLFMo/8Z/3dRV+c=;
 b=V2h9b+VMVb5aOM4x796xOyv0XWccyBCfvCICuE/oES7ZtCrvlNPLr+35E32FMAo/hC
 RUUsy0uUkTW7o4ddlVAj41yb05CxDVVke9bVrRHN83tIge9RtJ9vFnp65d2A5OYer2Pn
 V+xJBhoxkI8lDetbKItUcEzy3Qm5JroxXZTuxYaqVPWXyJTgNLDRSFWSodNwIwZspGTt
 PRhrkBj2aBbxwyYfu7lNhdrAW0T5SPoXNxkd7U5eZmNP4UgQL/gX+SM/5NNACWpk2boZ
 zXfIQi5Q+VacorzezqdvRf27TY8WvtLsxN2/9/+cJUwB9KtIYCbrchy+6MuXm7nKQBzr
 Od4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1699540032;
 s=strato-dkim-0003; d=gerhold.net;
 h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=XBYKkhm1B8n4QYIK02vpqbBuxz8NmLFMo/8Z/3dRV+c=;
 b=HvjJBe3h7HbMsR5eQKzds1aM4HhAQEk81hq09Xqs/LoM8+PfrF57UU1OJ0vGfxVwA+
 0qjMzWzNyIYEDaOJQ6Ag==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8paF1A=="
Received: from gerhold.net by smtp.strato.de (RZmta 49.9.1 SBL|AUTH)
 with ESMTPSA id Lbb8e2zA9ERCioi
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Thu, 9 Nov 2023 15:27:12 +0100 (CET)
Date: Thu, 9 Nov 2023 15:27:06 +0100
From: Stephan Gerhold <stephan@gerhold.net>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Ramon Fried <rfried.dev@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/5] gpio: qcom_pmic: rework pwrkey driver into a
 button driver
Message-ID: <ZUzsOvrcwpetH0WU@gerhold.net>
References: <20231108-b4-qcom-dt-compat-v2-0-713233c72948@linaro.org>
 <20231108-b4-qcom-dt-compat-v2-2-713233c72948@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108-b4-qcom-dt-compat-v2-2-713233c72948@linaro.org>
Content-Transfer-Encoding: 7bit
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

On Wed, Nov 08, 2023 at 04:20:54PM +0000, Caleb Connolly wrote:
> The power and resin keys were implemented as GPIOs here, but their only
> use would be as buttons. Avoid the additional layer of introspection and
> rework this driver into a button driver.
> 
> While we're here, replace the "qcom,pm8998-pwrkey" compatible with
> "qcom,pm8941-pwrkey" to match upstream (Linux).
> 
> The dragonboard410c and 820c boards are adjusted to benefit from this
> change too, simplify their custom board init code.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  MAINTAINERS                                      |   1 +
>  arch/arm/dts/dragonboard410c-uboot.dtsi          |  14 +-
>  arch/arm/dts/dragonboard410c.dts                 |  22 ++-
>  arch/arm/dts/dragonboard820c-uboot.dtsi          |  15 +--
>  arch/arm/dts/dragonboard820c.dts                 |  23 +++-
>  arch/arm/dts/dragonboard845c-uboot.dtsi          |  11 --
>  arch/arm/dts/dragonboard845c.dts                 |   4 +
>  arch/arm/dts/sdm845.dtsi                         |  23 +++-
>  arch/arm/dts/starqltechn.dts                     |  20 +--
>  arch/arm/mach-snapdragon/Kconfig                 |   3 +
>  arch/arm/mach-snapdragon/init_sdm845.c           |  45 ++-----
>  board/qualcomm/dragonboard410c/dragonboard410c.c |  31 ++---
>  board/qualcomm/dragonboard820c/dragonboard820c.c |  29 ++--
>  drivers/button/Kconfig                           |   9 ++
>  drivers/button/Makefile                          |   1 +
>  drivers/button/button-qcom-pmic.c                | 165 +++++++++++++++++++++++
>  drivers/gpio/Kconfig                             |   3 +-
>  drivers/gpio/qcom_pmic_gpio.c                    | 104 --------------
>  18 files changed, 275 insertions(+), 248 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f6d63c8ab563..8cd102eaa070 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -572,6 +572,7 @@ M:	Neil Armstrong <neil.armstrong@linaro.org>
>  R:	Sumit Garg <sumit.garg@linaro.org>
>  S:	Maintained
>  F:	arch/arm/mach-snapdragon/
> +F:	drivers/button/button-qcom-pmic.c
>  F:	drivers/clk/qcom/
>  F:	drivers/gpio/msm_gpio.c
>  F:	drivers/mmc/msm_sdhci.c
> diff --git a/arch/arm/dts/dragonboard410c-uboot.dtsi b/arch/arm/dts/dragonboard410c-uboot.dtsi
> index 3b0bd0ed0a1b..39b03a30702c 100644
> --- a/arch/arm/dts/dragonboard410c-uboot.dtsi
> +++ b/arch/arm/dts/dragonboard410c-uboot.dtsi
> @@ -5,6 +5,9 @@
>   * (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
>   */
>  
> +#include <dt-bindings/input/linux-event-codes.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +

You can drop this again now I guess?

>  / {
>  
>  	smem {
> @@ -42,14 +45,3 @@
>  		gpios = <&pm8916_gpios 3 0>;
>  	};
>  };
> -
> -
> -&pm8916_pon {
> -	key_vol_down {
> -		gpios = <&pm8916_pon 1 0>;
> -	};
> -
> -	key_power {
> -		gpios = <&pm8916_pon 0 0>;
> -	};
> -};
> [...]
> diff --git a/arch/arm/dts/dragonboard820c-uboot.dtsi b/arch/arm/dts/dragonboard820c-uboot.dtsi
> index 457728a43ecb..693c0e5efcc4 100644
> --- a/arch/arm/dts/dragonboard820c-uboot.dtsi
> +++ b/arch/arm/dts/dragonboard820c-uboot.dtsi
> @@ -5,6 +5,9 @@
>   * (C) Copyright 2017 Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
>   */
>  
> +#include <dt-bindings/input/linux-event-codes.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +

Same here.

Thanks,
Stephan
