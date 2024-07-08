Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E68C3271E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 06:32:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C202E87EBD;
	Mon,  8 Jul 2024 08:32:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="fzG1gRqm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 928F3884DC; Mon,  8 Jul 2024 08:32:12 +0200 (CEST)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::221])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA63E83333
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 08:32:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C2FCA240002;
 Mon,  8 Jul 2024 06:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1720420329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zswb2gaNk97IllrUQU0TFGiZRh24Vb8Y3fvPz5plUKU=;
 b=fzG1gRqmIDEWc3fYATYksDzGI8ZrqUI/CfhwYuLiIopj8ghqO3wCtDZ8/imikhLkjXIKPs
 W1ITFue87n7DHbcqz3vN/DgUebRyjMCbCjUuacSWTzUa9tycPA51XtiNbr8mG9b1IMwBrr
 jACBN/4ZB8B8ft3woQFQGgpODB+DvdCeeAo2x/4SwoG+0WzTT9eafTX7J6NWCdPlUZSjew
 McPfkYaTTzZnY7HfxW97VqLGF8T88JivBP2KWitplNheLfKK3+QUu+3Evs76sq+/8i790u
 Ua3TZXSml0RTF20SvzP8zDvUccqmeJVPu6bHLiP7xCZGkFo6DxFC3N08HOnXQg==
Date: Mon, 8 Jul 2024 08:32:08 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 u-boot@lists.denx.de, linux-kernel@vger.kernel.org, =?UTF-8?B?UmFmYcWC?=
 =?UTF-8?B?IE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH] dt-bindings: nvmem: convert U-Boot env to a layout
Message-ID: <20240708083208.322f4418@xps-13>
In-Reply-To: <20240705225821.13196-1-zajec5@gmail.com>
References: <20240705225821.13196-1-zajec5@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
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

Hi Rafa=C5=82,

zajec5@gmail.com wrote on Sat,  6 Jul 2024 00:58:21 +0200:

> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> U-Boot environment variables can be stored in various data sources. MTD
> is just one of available options. Refactor DT binding into a layout so
> it can be used with UBI volumes and other NVMEM devices.
>=20
> Link: https://lore.kernel.org/all/20231221173421.13737-1-zajec5@gmail.com/
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> ---
> I'm sending this PATCH without Linux changes to see if this is the
> right approach - for developers and (DT) maintainers to review it first.
>=20
> My previous attempt (see above Link) turned out in refusal so I'm just
> trying to save some time in case this one goes wrong as well.
>=20
> Hopefully the included example (which I really think we should add)
> explains well how I think this binding should be used with layouts.
>=20
> If I get some positive feedback I'll work on V2 with actual Linux
> changes.
>=20

I am still in favor of this change. I know from a binding perspective
it might be questionable; but from an OS perspective it makes total
sense to deprecated the old U-Boot env "device" driver in favor of this.

Thanks,
Miqu=C3=A8l
