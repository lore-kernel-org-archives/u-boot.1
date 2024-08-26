Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F1C7C5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 15:47:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0971688A5F;
	Mon, 26 Aug 2024 17:47:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="dQg6Kf57";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C31588A53; Mon, 26 Aug 2024 17:47:28 +0200 (CEST)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [217.70.183.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FBFC88A5F
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 17:47:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4B5EC20005;
 Mon, 26 Aug 2024 15:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1724687245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wj6XFiEyz0MvZyNMnVK430PLvJLAqeAvqPOrVho9jo4=;
 b=dQg6Kf57+3OnvOm4HYtjiwyid2qvgc6u2Dk90YYHKWI76Er37eoyQq1RAt6fhvKt7pSysf
 1iShLv4EJ9RZnzIFlVDVD2TCPwtJOJfim8Jz6piT+6suL1G+dvdCXtStBW7EVJHcUkGXK1
 4Iz9Ums/gSEkIKPsw4by0iE+2WmdJMRE0OV5Ay7SNLTXI6ktJQWafkWDWoSqHE0niNK4/K
 yehslsOv73A7wvIc2gzfu5KFPsMC04kMRybF0abmsd2n+U7aSD6sSoq7jaNhWTv9GHHS8T
 KRC2S7fpRh0PODOBJ+iUZS4J9mdPbhxGh2ttO2UHvMAw/xELiGoqatJHE0ckSg==
Date: Mon, 26 Aug 2024 17:47:24 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Linus Walleij <linus.walleij@linaro.org>, Lukasz
 Majewski <lukma@denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>,
 Zixun LI <admin@hifiphile.com>
Subject: Re: [PATCH 1/6] usb: gadget: Inline usb_add_gadget_udc_release
Message-ID: <20240826174724.16f0eda8@xps-13>
In-Reply-To: <20240826143851.8020-1-marek.vasut+renesas@mailbox.org>
References: <20240826143851.8020-1-marek.vasut+renesas@mailbox.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
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

Hi Marek,

marek.vasut+renesas@mailbox.org wrote on Mon, 26 Aug 2024 16:38:36
+0200:

> The release parameter of usb_add_gadget_udc_release() is never used.
> The function is never called from anywhere except from a wrapper in
> udc-core.c . Inline the function into the wrapper.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Zixun LI <admin@hifiphile.com>

LGTM, thanks for the cleanup! Just a minor comment, I would really
appreciate a very succinct cover letter with your overall goal. Would
also be easier for the maintainers to pick-up the tags, like this one.

For the series:

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks!
Miqu=C3=A8l
