Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC1ACEBF97
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 15:25:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75FD483B95;
	Tue, 18 Nov 2025 16:25:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Co8NSxw5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E097F83D5D; Tue, 18 Nov 2025 16:25:39 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 735F383AEF
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 16:25:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id C68B7C1267E;
 Tue, 18 Nov 2025 15:25:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id CCB1B606FE;
 Tue, 18 Nov 2025 15:25:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CE0A110371E1E; Tue, 18 Nov 2025 16:25:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1763479535; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=gF0HgVRJiaD4J+02wLZ1KrghDR94D9jGYpsGotOCQGE=;
 b=Co8NSxw5DCMlOnW9DJpETj/jYE9ElNfNqCrT5SMjovSgKnL3Xu3RgTnxbdH9hwdsClwzGl
 zNYkesfiqyNo3t/Pguall7d93EX2CSS/Qztil4iVjuJlhmWKv39na6/dwwe9WisKUt+FHr
 icDYWbublGoHdwtoPErW+m/3JZF4/uh9Zf+oUpMzyH5nyMfP8F1Ge3eR8py9Yqjgf+iOus
 Wl+zBuKmCg6QPGGgfCtKivpRIsxGvoTG02h6gn950sklGRYQycpnrrJzIWj0uspaW/hvVV
 5n9wz9scUF8kRldmnO5pN1Od2KouW3Ja3GCpzgTlwToD6Ja61zyOo4ia0enpTQ==
Date: Tue, 18 Nov 2025 16:25:21 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Markus Schneider-Pargmann" <msp@baylibre.com>
Cc: "Maarten Brock" <Maarten.Brock@sttls.nl>, <u-boot@lists.denx.de>, "Tom
 Rini" <trini@konsulko.com>, "Rasmus Villemoes" <ravi@prevas.dk>, "Rayagonda
 Kokatanur" <rayagonda.kokatanur@broadcom.com>, "Tien Fong Chee"
 <tien.fong.chee@altera.com>, "Alif Zakuan Yuslaimi"
 <alif.zakuan.yuslaimi@altera.com>, "Casey Connolly"
 <casey.connolly@linaro.org>, "Tingting Meng" <tingting.meng@altera.com>,
 "Peng Fan" <peng.fan@nxp.com>, "Quentin Schulz" <quentin.schulz@cherry.de>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>, Duje =?UTF-8?B?TWloYW5v?=
 =?UTF-8?B?dmnEhw==?= <duje@dujemihanovic.xyz>, "Liya Huang"
 <1425075683@qq.com>, "Marek Vasut" <marek.vasut+renesas@mailbox.org>,
 "Romain Gantois" <romain.gantois@bootlin.com>, "Simon Glass"
 <sjg@chromium.org>, "Jaehoon Chung" <jh80.chung@samsung.com>, "Miquel
 Raynal" <miquel.raynal@bootlin.com>, "Marek Vasut" <marex@denx.de>,
 "Mattijs Korpershoek" <mkorpershoek@kernel.org>, "Andrew Goodbody"
 <andrew.goodbody@linaro.org>, "Anatolij Gustschin"
 <ag.dev.uboot@gmail.com>, "Sukrut Bellary" <sbellary@baylibre.com>
Subject: Re: [PATCH 02/15] arm: dts: am335x-evm: Add backlight to the panel
Message-ID: <20251118162521.1adb8a7c@kmaincent-XPS-13-7390>
In-Reply-To: <DEBWSSW3JNPJ.1YYA39OACM9HN@baylibre.com>
References: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
 <20251118-topic-am33-evm-oftree-v2026-01-v1-2-91ce13c661e2@baylibre.com>
 <20251118151444.0634411b@kmaincent-XPS-13-7390>
 <DEBWSSW3JNPJ.1YYA39OACM9HN@baylibre.com>
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

On Tue, 18 Nov 2025 16:01:00 +0100
"Markus Schneider-Pargmann" <msp@baylibre.com> wrote:

> Hi Kory,
>=20
> On Tue Nov 18, 2025 at 3:14 PM CET, Kory Maincent wrote:
> > On Tue, 18 Nov 2025 11:40:22 +0100
> > "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com> wrote:
> > =20
> >> Add backlight phandle reference to panel node. Without this reference,
> >> the display driver cannot control backlight, leaving the panel dark. =
=20
> >
> > What is the point of modifying this devicetree as it will be replaced b=
y the
> > Linux upstream devicetree at the last patch of your series? =20
>=20
> My idea was to first fix the current setup to have something to compare
> with before changing the full devicetree. I think it is useful to have
> this for reference in the history. This also makes bisecting work
> across the upstream devicetree changes without loss of functionality.

Ok, legit.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
