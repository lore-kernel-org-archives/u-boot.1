Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC16C4706F
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 07:58:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2969F87933;
	Thu,  4 Jan 2024 08:58:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="WjHkc//S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CECD187937; Thu,  4 Jan 2024 08:58:43 +0100 (CET)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [217.70.183.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E79F8775F
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 08:58:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 42225FF80A;
 Thu,  4 Jan 2024 07:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1704355121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7tDgF8jmLlYnxlNyI3TgVBeZTXRFDyykxfhy3VnRuqc=;
 b=WjHkc//SMCn9WSqtxGYRZEWtGnibX5AGg6J5U2qcFSDINWfx1hGmp6q8+7nOrL9VqZQBlI
 3P9bKP4usCn5p/pu34lVn1nqKcPI0Vhr4ZYBUW3gHW55natIxMAjFgj+wE6WGGee3JVL0N
 fa6Qgh2pM6NeJjbsc8VaiLjWvJ4zf1+KzpO+gmYlH4t6pmwswo6QazEjHD4dTl3lzVGjbZ
 FLdKjgjv71ASWY2DG/E3KQVVI0m55hKHum7MdnLoiLIaIYyHQwF53iY2pXZ8/N38cih49e
 x/24R4u+6d0hapbAM2sGRhHZOY9zp3THYJMVOblYLJyba70l73XJj9RBGCdv0Q==
Date: Thu, 4 Jan 2024 08:58:39 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, Srinivas Kandagatla
 <srinivas.kandagatla@linaro.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michael Walle
 <michael@walle.cc>, linux-mtd@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, u-boot@lists.denx.de, =?UTF-8?B?UmFmYcWC?=
 =?UTF-8?B?IE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V3 1/6] dt-bindings: nvmem: layouts: add U-Boot
 environment variables layout
Message-ID: <20240104085839.5624c354@xps-13>
In-Reply-To: <20240104001129.GA2045237-robh@kernel.org>
References: <20231221173421.13737-1-zajec5@gmail.com>
 <20240104001129.GA2045237-robh@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
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

Hello,

robh@kernel.org wrote on Wed, 3 Jan 2024 17:11:29 -0700:

> On Thu, Dec 21, 2023 at 06:34:16PM +0100, Rafa=C5=82 Mi=C5=82ecki wrote:
> > From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> >=20
> > U-Boot env data is a way of storing firmware variables. It's a format
> > that can be used of top of various storage devices. Its binding should
> > be an NVMEM layout instead of a standalone device.
> >=20
> > This patch adds layout binding which allows using it on top of MTD NVMEM
> > device as well as any other. At the same time it deprecates the old
> > combined binding.
>=20
> I don't understand the issue. From a DT perspective, there isn't. A=20
> partition is not a device, but is describing the layout of storage=20
> already.

Actually I think what Rafa=C5=82 wants to do goes in the right direction but
I also understand from a binding perspective it may be a little
confusing, even more if we consider "NVMEM" a Linux specific concept.

There is today a "u-boot env" NVMEM *device* description which
almost sits at the same level as eg. an eeprom device. We cannot
compare "an eeprom device" and "a u-boot environment" of course. But
that's truly what is currently described.

* Current situation

	Flash device -> U-Boot env layout -> NVMEM cells

* Improved situation

	Any storage device -> NVMEM -> U-Boot env layout -> NVMEM cells

The latter is of course the most relevant description as we expect
storage devices to expose a storage-agnostic interface (NVMEM in
this case) which can then be parsed (by NVMEM layouts) in a storage
agnostic way.

In the current case, the current U-Boot env binding tells people to
declare the env layout on top of a flash device (only). The current
description also expects a partition node which is typical to flash
devices. Whereas what we should have described in the first place is a
layout that applies on any kind of NVMEM device.

Bonus point: We've been working the last couple years on clarifying
bindings, especially with mtd partitions (with the partitions{}
container) and NVMEM layouts (with the nvmem-layout{} container).
The switch proposed in this patch makes use of the latter, of course.

Thanks,
Miqu=C3=A8l
