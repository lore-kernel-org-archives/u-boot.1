Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A294C3DA45
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 13:40:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 015A4881B8;
	Thu, 11 Jul 2024 15:40:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C34FD881B8; Thu, 11 Jul 2024 15:40:49 +0200 (CEST)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0CC188263
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 15:40:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=michael@walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4340:4ee9:4685:ff:fe12:5967])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.3ffe.de (Postfix) with ESMTPSA id 8CC381E7C;
 Thu, 11 Jul 2024 15:40:47 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Jul 2024 15:40:47 +0200
Message-Id: <D2MR3PWR6RGY.1OTMOYJLMSNYR@kernel.org>
Cc: <u-boot@lists.denx.de>
From: "Michael Walle" <mwalle@kernel.org>
To: "Michael Walle" <mwalle@kernel.org>, "Jagan Teki"
 <jagan@amarulasolutions.com>, "Andre Przywara" <andre.przywara@arm.com>,
 "Tom Rini" <trini@konsulko.com>
Subject: Re: [PATCH] sunxi: SPL SPI: add support for the V3s SoC
X-Mailer: aerc 0.16.0
References: <20240513234319.1966434-1-mwalle@kernel.org>
In-Reply-To: <20240513234319.1966434-1-mwalle@kernel.org>
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

On Tue May 14, 2024 at 1:43 AM CEST, Michael Walle wrote:
> The V3s is identical regarding register layout, clocks and resets to
> the sun6i variants. Therefore, we can just add the MACH_SUN8I_V3S to
> the sun6i compatible ones.
>
> SPI boot was tested on a custom board with a Gigadevice GD25Q64 8MiB
> SPI flash.

Also here.. any news?

-michael
