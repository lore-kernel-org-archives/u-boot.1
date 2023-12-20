Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79DD4C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 07:19:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD5B3870B7;
	Wed, 20 Dec 2023 08:19:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="hiMCouBw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8081D871C3; Wed, 20 Dec 2023 08:19:29 +0100 (CET)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net
 [217.70.183.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A24B08700D
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 08:19:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AB40D240003;
 Wed, 20 Dec 2023 07:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1703056767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y6fzl6vcO4Hv/XujG9Dw3Folx8t279iaf7fTJn0KvN8=;
 b=hiMCouBwpjTDotM2nWPy4MfCqL59dT0H4ebnMP4Wh99CZIvg5xa8mCUGrn/d5LI6eRQAIX
 ir/6d8YLTlLQAFv2T6USU0WnkFWRkEDY7oE/2dpeXvueyhjIEsdJcPXYojokq4jnNvcu/B
 GE0jb4PceNrrxwakYSszdrR/RvF0kV6Qg7FqnEj3M3IHlafqoOBioPjMw5a146+AN5AWHS
 cKz7pFHemYRdjEWo7+fq3vBWL1ix+wLsy6PoNf422Md0FbUyzavzb3+/DL6js4YHt866XY
 6L/s3Ts5bSFWE7/Dpt4voAPef9a7pFYa3nnsnyJrxoBhGkS1A2j04qHBg2DyAA==
Date: Wed, 20 Dec 2023 08:19:24 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michael Walle
 <michael@walle.cc>, linux-mtd@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, u-boot@lists.denx.de, =?UTF-8?B?UmFmYcWC?=
 =?UTF-8?B?IE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V2 4/5] nvmem: u-boot-env: improve coding style
Message-ID: <20231220081924.39b96ec4@xps-13>
In-Reply-To: <20231219174025.15228-4-zajec5@gmail.com>
References: <20231219174025.15228-1-zajec5@gmail.com>
 <20231219174025.15228-4-zajec5@gmail.com>
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

Hi Rafa=C5=82,

zajec5@gmail.com wrote on Tue, 19 Dec 2023 18:40:24 +0100:

> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> 1. Prefer kzalloc() over kcalloc()
>    See memory-allocation.rst which says: "to be on the safe side it's
>    best to use routines that set memory to zero, like kzalloc()"
> 2. Drop dev_err() for u_boot_env_add_cells() fail
>    It can fail only on -ENOMEM. We don't want to print error then.
> 3. Add extra "crc32_addr" variable
>    It makes code reading header's crc32 easier to understand / review.
>=20
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>

Looks much nicer :)

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
