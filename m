Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14371C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 14:03:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98E2187E0D;
	Mon, 18 Dec 2023 15:03:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="KStf55k3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4247E87DF7; Mon, 18 Dec 2023 15:03:16 +0100 (CET)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 560FD87E21
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 15:03:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 26EE2FF805;
 Mon, 18 Dec 2023 14:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1702908194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yOdu4nC8A547RSrmQaxjTwDGTHM+CV5BhhKgD0gmeTo=;
 b=KStf55k35pwB3Kf+9oYro7aVUbzOX88GtQSkvx2+3d9QuT5CPmNp8cPZb1hhaQXobbp/PW
 NbpyQvc9Nkj1P4yR2b4Trd3QGZIp2QMThiPUbyTC2uelXRCPGxvdwSxiRJxg9W2n2BqA3e
 D3hP3YUq4441ekhB49ki7NFpLhseKqfgvY7CCEqtK0GPcWnq1mmReLN2l0P+m8n3rpC9u/
 rO7Imna95yvuffMOoXMNVYBqTT8QBhWT5xIyQhPrWBYl004cL/IJXfpz/UzrIsjT1ynOx4
 6Wq8r6ad9OmdumDTjyYSeJ1ksOfy/SllnGI2Fp4RZb6ab2+/Yp7YJcbO4ZCpvw==
Date: Mon, 18 Dec 2023 15:03:12 +0100
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
Subject: Re: [PATCH 2/4] nvmem: core: add nvmem_dev_size() helper
Message-ID: <20231218150312.01bc1472@xps-13>
In-Reply-To: <20231218133722.16150-2-zajec5@gmail.com>
References: <20231218133722.16150-1-zajec5@gmail.com>
 <20231218133722.16150-2-zajec5@gmail.com>
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

zajec5@gmail.com wrote on Mon, 18 Dec 2023 14:37:20 +0100:

> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> This is required by layouts that need to read whole NVMEM content. It's
> especially useful for NVMEM devices without hardcoded layout (like
> U-Boot environment data block).

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

>=20
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>

Thanks,
Miqu=C3=A8l
