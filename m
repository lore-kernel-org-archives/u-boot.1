Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CFAC3DA45
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 13:40:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D44D87D43;
	Thu, 11 Jul 2024 15:40:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AF4284374; Thu, 11 Jul 2024 15:40:26 +0200 (CEST)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4C198827D
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 15:40:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=michael@walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4340:4ee9:4685:ff:fe12:5967])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.3ffe.de (Postfix) with ESMTPSA id DC8731E7C;
 Thu, 11 Jul 2024 15:40:22 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Jul 2024 15:40:22 +0200
Message-Id: <D2MR3EIN7UJN.2BQPXGK8KHB7T@kernel.org>
Subject: Re: [PATCH 0/2] sunxi: v3s: add network support
Cc: "Samuel Holland" <samuel@sholland.org>, <u-boot@lists.denx.de>
From: "Michael Walle" <mwalle@kernel.org>
To: "Michael Walle" <mwalle@kernel.org>, "Jagan Teki"
 <jagan@amarulasolutions.com>, "Andre Przywara" <andre.przywara@arm.com>,
 "Lukasz Majewski" <lukma@denx.de>, "Sean Anderson" <seanga2@gmail.com>,
 "Tom Rini" <trini@konsulko.com>, "Joe Hershberger"
 <joe.hershberger@ni.com>, "Ramon Fried" <rfried.dev@gmail.com>
X-Mailer: aerc 0.16.0
References: <20240513205609.1872861-1-mwalle@kernel.org>
In-Reply-To: <20240513205609.1872861-1-mwalle@kernel.org>
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

Hi,

On Mon May 13, 2024 at 10:56 PM CEST, Michael Walle wrote:
> Add network support for the V3s which only supports the internal
> PHY. Adding support was straight forward. The emac driver just needs
> the compatible string and some platform data and the clock driver
> needs to know the bits for the clock gating as well as the reset
> bits.
>
> This was tested on a custom board.

Any news here?

-michael

>
> Michael Walle (2):
>   clk: sunxi: add EMAC and EPHY clocks and resets for the V3s SoC
>   net: sun8i_emac: add support for the V3s
>
>  drivers/clk/sunxi/clk_v3s.c | 6 ++++++
>  drivers/net/sun8i_emac.c    | 7 +++++++
>  2 files changed, 13 insertions(+)

