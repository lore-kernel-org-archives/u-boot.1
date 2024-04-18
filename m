Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99043C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 22:43:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B94708869F;
	Fri, 19 Apr 2024 00:43:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F1DC8869C; Fri, 19 Apr 2024 00:43:06 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 7C2A888695
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 00:43:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C86882F;
 Thu, 18 Apr 2024 15:43:31 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A0763F738;
 Thu, 18 Apr 2024 15:43:03 -0700 (PDT)
Date: Thu, 18 Apr 2024 23:42:53 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: =?UTF-8?B?6Lev6L6J?= <luhux76@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] drivers: pinctrl-sunxi: add suniv spi1 function
Message-ID: <20240418234253.3cf07c9a@minigeek.lan>
In-Reply-To: <CAGNyvehMbDenbnZdSbV9m5LkEkqE_dix0+XZQwJU_qDAcfJZXw@mail.gmail.com>
References: <CAGNyvehMbDenbnZdSbV9m5LkEkqE_dix0+XZQwJU_qDAcfJZXw@mail.gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Fri, 9 Jun 2023 13:37:16 +0000
=E8=B7=AF=E8=BE=89 <luhux76@gmail.com> wrote:

Hi,

> From 570b40e19de75511d9ce066e1a28333ada04baf2 Mon Sep 17 00:00:00 2001
> From: Lu Hui <luhux76@gmail.com>
> Date: Mon, 29 May 2023 22:26:25 +0800
> Subject: [PATCH] drivers: pinctrl-sunxi: add suniv spi1 function

There should be a commit message, explaining *why* this is needed.
So which device on which board do you use in U-Boot that requires SPI1?

Also you need a "Signed-off-by:" line with your real name and email
address.

Cheers,
Andre

> ---
>  drivers/pinctrl/sunxi/pinctrl-sunxi.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> index e510218090..c448e40ab0 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> @@ -240,6 +240,7 @@ static const struct sunxi_pinctrl_function
> suniv_f1c100s_pinctrl_functions[] =3D {
>      { "mmc0",    2 },    /* PF0-PF5 */
>      { "mmc1",    3 },    /* PC0-PC2 */
>      { "spi0",    2 },    /* PC0-PC3 */
> +    { "spi1",    6 },    /* PA0-PA3 */
>  #if IS_ENABLED(CONFIG_UART0_PORT_F)
>      { "uart0",    3 },    /* PF2-PF4 */
>  #else

