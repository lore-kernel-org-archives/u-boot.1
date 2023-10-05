Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128A6E92716
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 15:54:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7504386BA4;
	Thu,  5 Oct 2023 17:54:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="mP52AVoy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA8D186BA4; Thu,  5 Oct 2023 17:54:47 +0200 (CEST)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D46F186B58
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 17:54:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 191452000A;
 Thu,  5 Oct 2023 15:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1696521284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YiMaH6dSgja5LQes7JfC21C6shxIN3Mp41ogr4YvqVA=;
 b=mP52AVoyWCUmo28uKxYTkF5tYNQIx9SWGzRESxbB/LF6WWb+ZRamGD7gqCKFUDSriVzs6V
 rURf+Zupzs7/C0BVSyOaMvUO8HG2Ate3gU5VGu6xNXDrkhUsl/lMIvBlPok3d2+GTqy4Yw
 zl1vNVfHpwC1WSWQCu7TzV0o4vTAxmsxfVNm4Tumd9Gr1+sVZbMEQ1/WCPRKAMgraMa2OO
 e40JMt6/IhAOya0mPYalMer4GPkIsEk2QwnDbUC89bvjD0jIyZ9XowKpXLgbmYVdpMurFs
 CmQ+WeuqWHztDKZmqOLuVuyplWhi4dGItmMSmBqJ6FTU4B/Mdrn8p+gyYtDHAA==
Date: Thu, 5 Oct 2023 17:54:43 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Marek Vasut <marex@denx.de>
Cc: Lukasz Majewski <lukma@denx.de>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
Subject: Re: [PATCH RESEND v2 1/2] cmd: bind: Try to improve the (un)bind help
Message-ID: <20231005175443.7d042e8b@xps-13>
In-Reply-To: <b812e5e2-aa29-4802-99cc-72f2e83595de@denx.de>
References: <20231002134621.94786-1-miquel.raynal@bootlin.com>
 <b812e5e2-aa29-4802-99cc-72f2e83595de@denx.de>
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

Hi Marek,

marex@denx.de wrote on Thu, 5 Oct 2023 15:01:51 +0200:

> On 10/2/23 15:46, Miquel Raynal wrote:
> > While it may sound totally obvious for the regular U-Boot developer to
> > get the parameters of the bind/unbind commands from the output of 'dm
> > tree', it did not felt straightforward to me until I was explicitly
> > told to look there. And even when I knew the command, I did not make a
> > direct link between the arguments of this command and the columns
> > returned by 'dm tree'.
> >=20
> > Several of us lost a lot of time because of that, I would like to kindly
> > help other users by slightly improving this textual line. Unfortunately,
> > because of how this string is used (like within the 'help' command) I
> > cannot detail much more, but at least the pointer is there.
> >=20
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> > Resend: no change.
> >=20
> > Changes in v2:
> > * Moved the details in the long text section as suggested by Heinrich.
> > * Rephrased the help text as well, not fully following Heinrich
> >    suggestion, but taking inspiration from it.
> > ---
> >   cmd/bind.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >=20
> > diff --git a/cmd/bind.c b/cmd/bind.c
> > index 4d1b7885e60..be0d4d2a711 100644
> > --- a/cmd/bind.c
> > +++ b/cmd/bind.c
> > @@ -246,6 +246,8 @@ U_BOOT_CMD(
> >   	"Bind a device to a driver",
> >   	"<node path> <driver>\n"
> >   	"bind <class> <index> <driver>\n"
> > +	"Use 'dm tree' to list all devices registered in the driver model,\n"
> > +	"their path, class, index and current driver.\n"
> >   ); =20
> >   >   U_BOOT_CMD( =20
> > @@ -254,4 +256,6 @@ U_BOOT_CMD(
> >   	"<node path>\n"
> >   	"unbind <class> <index>\n"
> >   	"unbind <class> <index> <driver>\n"
> > +	"Use 'dm tree' to list all devices registered in the driver model,\n"
> > +	"their path, class, index and current driver.\n" =20
>=20
> 'dm tree' depends on CMD_DM , you might need some if (IS_ENABLED()) here.

Well, no, and that's my point actually. People need to know that this
command exist and should be used for this purpose. If you only tell
them "use 'dm tree'" conditionally, you loose part of the audience:
people not aware of this command or its usefulness.

Thanks,
Miqu=C3=A8l
