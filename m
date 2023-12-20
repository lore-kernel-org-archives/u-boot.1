Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 481B1C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 07:27:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BED68870B7;
	Wed, 20 Dec 2023 08:27:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="hB0lZsR6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C88BE8755B; Wed, 20 Dec 2023 08:27:41 +0100 (CET)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [217.70.183.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29B788700D
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 08:27:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D75A2FF803;
 Wed, 20 Dec 2023 07:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1703057258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jbbso/rgR9y8n9297RvIV+sw+BGrsloKuu4p5wYQO8U=;
 b=hB0lZsR61TYKM10x74jyfOy+y5SCHQcGukvQOGQPgiuahRFZGd1suchlA+vbYiQ+Q2FpDt
 VpSB961mr4K9f0Igroc2u1n5r46fVBNrUAhFHr0KgS1AV0noZwCdHBeFPTUA9pDlo3/LY4
 Via/zwOJ3hxigJjAVaaS239v9SwiXEvOzQgqLe/umC4kZSEQn89hNUS5YoInC6b70QP2LT
 wXwHjzXMfpi7BVMS+W/ur2yTzJHEc5ysWFWn2vpgVeL7fb31ByuVwTFE7Pal8RHMcAM0Tj
 ctMslWbq5RoUnjar0AHqsMIALmMgH7rducCnhhjh7veXU2i2oHM9ngqko8rMQg==
Date: Wed, 20 Dec 2023 08:27:36 +0100
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
Subject: Re: [PATCH V2 5/5] nvmem: layouts: add U-Boot env layout
Message-ID: <20231220082736.246e947c@xps-13>
In-Reply-To: <20231219174025.15228-5-zajec5@gmail.com>
References: <20231219174025.15228-1-zajec5@gmail.com>
 <20231219174025.15228-5-zajec5@gmail.com>
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

zajec5@gmail.com wrote on Tue, 19 Dec 2023 18:40:25 +0100:

> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> This patch moves all generic (NVMEM devices independent) code from NVMEM

Nit: In general we avoid starting with "This patch does..." and instead
use the imperative form, like: "Move all generic code..."

> device driver to NVMEM layout driver. Then it adds a simple NVMEM layout

					Then add...

> code on top of it.
>=20
> Thanks to proper layout it's possible to support U-Boot env data stored
> on any kind of NVMEM device.
>=20
> For backward compatibility with old DT bindings we need to keep old
> NVMEM device driver functional. To avoid code duplication a parsing
> function is exported and reused in it.
>=20
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> ---
> V2: Support new compatibles & use device_get_match_data() helper
>=20
> IMPORTANT:
> This is based on top of the:
> [PATCH v6.8 1/2] nvmem: layouts: refactor .add_cells() callback arguments

Thanks for the move. Looks good to me:

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
