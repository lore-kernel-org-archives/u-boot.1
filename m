Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCEB9CEDD93
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 14:34:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69EB583E19;
	Tue, 18 Nov 2025 15:34:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Z+ZEXwp6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A212183E20; Tue, 18 Nov 2025 15:34:55 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFB9D83D07
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 15:34:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 4E8ADC12677;
 Tue, 18 Nov 2025 14:34:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7013C606FE;
 Tue, 18 Nov 2025 14:34:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DD964103713A9; Tue, 18 Nov 2025 15:34:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1763476491; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Qlyw7HV7XtbOlotTy4pcf1SYiFDKxnBZk3dHTInyCQY=;
 b=Z+ZEXwp6XMYgHN5WcIDonOPHXUYoUelxdHW4odvjqeVXFoamK6GKLTDXeCtAQutU8pFoj+
 fiLf4/kInAZ5SvixQMIt074Vy3XVyGg/CExWFNJBLj/fxFHU2P4tvZUw3ZdnNDSots7YTt
 rOe4U8cmJujwmqQmd3mRw7cAmc8nkKJiYnLXAeMItDCytd0dVhMwieJguc0D3uhvDbNdoW
 6qf0ED6BuGfdpT/LEH0zS0Ru5z10kUyg8Nvfo/8YCYiIHXbC9n8KGaPnOcjPsL32wwStq6
 DEXaaWj3vctmRS/ZMqtYYr5YPz9ZSNRg5WO5QMuvChaUxsH0GxXGNDnQS721VQ==
Date: Tue, 18 Nov 2025 15:34:43 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Cc: Maarten Brock <Maarten.Brock@sttls.nl>, u-boot@lists.denx.de, Tom Rini
 <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, Rayagonda
 Kokatanur <rayagonda.kokatanur@broadcom.com>, Tien Fong Chee
 <tien.fong.chee@altera.com>, Alif Zakuan Yuslaimi
 <alif.zakuan.yuslaimi@altera.com>, Casey Connolly
 <casey.connolly@linaro.org>, Tingting Meng <tingting.meng@altera.com>, Peng
 Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Duje =?UTF-8?B?TWloYW5vdmnEhw==?=
 <duje@dujemihanovic.xyz>, Liya Huang <1425075683@qq.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Romain Gantois
 <romain.gantois@bootlin.com>, Simon Glass <sjg@chromium.org>, Jaehoon Chung
 <jh80.chung@samsung.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Marek
 Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Anatolij Gustschin
 <ag.dev.uboot@gmail.com>, Sukrut Bellary <sbellary@baylibre.com>
Subject: Re: [PATCH 05/15] simple-pm-bus: Make clocks optional
Message-ID: <20251118153443.0a7436a5@kmaincent-XPS-13-7390>
In-Reply-To: <20251118-topic-am33-evm-oftree-v2026-01-v1-5-91ce13c661e2@baylibre.com>
References: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
 <20251118-topic-am33-evm-oftree-v2026-01-v1-5-91ce13c661e2@baylibre.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
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

On Tue, 18 Nov 2025 11:40:25 +0100
"Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com> wrote:

> simple-pm-bus binding requires either power-domains or clocks, not both.
> Allow clk_get_bulk() to return -ENOENT.
>=20
> When no clocks are present, bulk->count is set to 0, which works
> correctly with clk_enable_bulk() and other clk functions used in this
> driver.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
