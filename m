Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E393CC3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 06:58:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C16268875C;
	Tue, 16 Jul 2024 08:58:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AB6C88865; Tue, 16 Jul 2024 08:58:18 +0200 (CEST)
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32F118875B
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 08:58:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=michael@walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4340:4ee9:4685:ff:fe12:5967])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.3ffe.de (Postfix) with ESMTPSA id A7EA85334;
 Tue, 16 Jul 2024 08:58:14 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jul 2024 08:58:14 +0200
Message-Id: <D2QRO88MEAKU.2AJR76UULNW16@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Andre Przywara" <andre.przywara@arm.com>
Subject: Re: [PATCH 1/2] spi: sunxi: drop max_hz handling
Cc: "Jagan Teki" <jagan@amarulasolutions.com>, "Tom Rini"
 <trini@konsulko.com>, "Simon Glass" <sjg@chromium.org>,
 <u-boot@lists.denx.de>
X-Mailer: aerc 0.16.0
References: <20240712171457.3104804-1-mwalle@kernel.org>
 <20240712171457.3104804-2-mwalle@kernel.org>
 <20240716010541.745a6c09@minigeek.lan>
In-Reply-To: <20240716010541.745a6c09@minigeek.lan>
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

> > The driver is trying to read the "spi-max-frequency" property of the
> > *controller* driver node. There is no such property. The
> > "spi-max-frequency" property belongs to the SPI devices on the bus.
>
> Ah, indeed, good catch! Many thanks for sending this!
> =20
> > Right now, the driver will always fall back to the default value of 1MH=
z
> > and thus flash reads are very slow with just about 215kb/s.
>
> That's even slower, right? I guess around 125 KB/s?

Yes of course :) 1Mhz/8 at most. I was fooled by the "sf update"
command which will skip the same sectors and then the overall speed
will be faster.

> > In fact, the SPI uclass will already take care of everything and we jus=
t
> > have to clamp the frequency to the values the driver/hardware supports.
> > Thus, drop the whole max_hz handling.
>
> Looks good to me, I verified this by timing the read, this patch indeed=
=20
> significantly increases the performance. Also changing the limit in the
> DT gets reflected in the driver and in the read speed. Also verified
> that the values read from the SPI flash are the same in all cases.
>
> > Signed-off-by: Michael Walle <mwalle@kernel.org>
>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> Tested-by: Andre Przywara <andre.przywara@arm.com>
>
> I will make this part of the first 2024.10 PR.

This means just 1/2 or both? Because there was no Rb on the second
patch.

-michael
