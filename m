Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C99CCA0FED
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 14:24:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C59A3830B4;
	Tue,  9 Sep 2025 16:24:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="QyxYo8PJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C41983106; Tue,  9 Sep 2025 16:24:16 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 881978309E
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 16:24:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id F0B284E40B80;
 Tue,  9 Sep 2025 14:24:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B381560630;
 Tue,  9 Sep 2025 14:24:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1E3A2102F27F2; 
 Tue,  9 Sep 2025 16:23:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1757427852; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=ewt/yY0ZyiuvXblpLqzV7Rio8+U+CT1bGbPekSUzz2w=;
 b=QyxYo8PJ5lnmesTCjachBAyXzh/4Qpu6gSZbXU0sMqsd/P6wF14HXC8lXiF4rYDRfxHTNJ
 FQIndDqd1cw9RCAeNoXMTIaKRcTWQH0zcQIpF65VtQmMiGpbltZgK+y83gJqtDf2cv7oJ2
 ZhNYMsYwo41mVBcaII7sqtji3qEuzblMcXnyDtci4t+xLKNZXun9jQ/ab2DecC1Bkvmqna
 3wDQG61BxD4e3Qf19fH2Y5rHiphnzlp61/V0OHsIpGh+CXxJojyL72XhPOPlHU94KcIWsK
 gTYpGDZbGaIHwKBf+8KH3l3m38a+61PYK7u1qW4i5S0IxmAi4Fd1f5983LPPAQ==
Date: Tue, 9 Sep 2025 16:23:56 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Maarten Brock <Maarten.Brock@sttls.nl>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "jerome.forissier@linaro.org" <jerome.forissier@linaro.org>,
 "sjg@chromium.org" <sjg@chromium.org>, "trini@konsulko.com"
 <trini@konsulko.com>
Subject: Re: [PATCH 1/1] board: ti: am335x: Do not call disabled PMIC functions
Message-ID: <20250909162356.6ff75133@kmaincent-XPS-13-7390>
In-Reply-To: <DB6PR05MB45516C241486780C8D198FCD830FA@DB6PR05MB4551.eurprd05.prod.outlook.com>
References: <DB6PR05MB4551D31271569EC04E8EC60F830CA@DB6PR05MB4551.eurprd05.prod.outlook.com>
 <20250908184342.7ec9500b@kmaincent-XPS-13-7390>
 <DB6PR05MB45516C241486780C8D198FCD830FA@DB6PR05MB4551.eurprd05.prod.outlook.com>
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

On Tue, 9 Sep 2025 12:45:10 +0000
Maarten Brock <Maarten.Brock@sttls.nl> wrote:

> > From: Kory Maincent <kory.maincent@bootlin.com>
> >=20
> > On Mon, 8 Sep 2025 16:05:04 +0000
> > Maarten Brock <Maarten.Brock@sttls.nl> wrote:
> >  =20
> > > When PMIC drivers are disabled their functions should not be called.
> > >
> > > Signed-off-by: Maarten Brock <maarten.brock@sttls.nl> =20
> >=20
> > There is already board check with board_is_bone or board_is_beaglebonex
> > call. Is it not sufficient? Why would we disable the PMIC support if we=
 are
> > using one of these boards? =20
>=20
> Why would you keep the PMIC support if you are NOT using one of those boa=
rds?
> Note that those checks are at runtime, not at compile time.
>=20
> > Maybe the only relevant return would be in scale_vcores_generic, as it
> > matches the case where the board is not known. =20
>=20
> When a board is using a certain PMIC it should be possible to deselect all
> other PMICs that are not present. There is no point in keeping unused code
> in the binary. Isn't that the whole idea of the configuration?
> The current situation gives a build failure when the unused PMIC is
> deselected.
>=20
> This file board/ti/am335x/board.c gives the impression to be useable for =
all
> AM335X based boards, including those yet unknown. What if a board does not
> need any PMIC configuration, because the default strapped config is enoug=
h,
> does one still need to drag those drivers along?
>=20
> Or to turn things around: if configuration is not to be used to create the
> smallest possible executable image, then why not incorporate all PMIC dri=
vers
> by default? All those config options could then be removed to simplify th=
ings
> a lot.

Indeed, I hadn't understood that you would face a build error as the PMIC
functions are not defined if we disable PMIC configs.

I think the first issue is the design of this board.c file, but, well it is
U-boot typical design.=20
And scale_vcores_generic() is not a generic function at all ...

Ok, your change are legit after all.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
