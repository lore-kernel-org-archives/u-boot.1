Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64D6CD13CF
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 08:18:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2797288A27;
	Mon,  2 Sep 2024 10:18:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="eVnU8iLT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6091F88A34; Mon,  2 Sep 2024 10:18:03 +0200 (CEST)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [217.70.183.201])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3764E88A27
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 10:18:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 829101BF203;
 Mon,  2 Sep 2024 08:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1725265080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SAJnhvUJ8fBGfNVkyqXS/4/W6svsth01Xi023A/f16A=;
 b=eVnU8iLTtHoalY4yJn3fTD4fw7plYhs42SYy0FkFaBjxO0ohmefs0wjCYGWSFUGhaYx4Jm
 o44WFVX+/ahLv/orOf6YETodBObb82FE5SiVTBYnD0yp5T3nTsyTW56UUIn+6qs9Di1jYa
 vSGpnOWgdUoSE2MMg1jM/SGrc/VD43jzuMAmziuTwbWlxpjlJqNdXNv1kUgd1OjIkKS3sG
 aggvmSn3tcuKzfSim9xGyoHtohRoP/c1pplsHaFvBv1esr6FpUdS5eQpakQKAMmEhRjcxY
 X0oE1bBWwlP5wmGpQh+nZP6PaIlfyt2e8tO55UQQ+S3d975t0jnXBoE+impxyA==
Date: Mon, 2 Sep 2024 10:17:59 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Dan Carpenter
 <dan.carpenter@linaro.org>, Anatolij Gustschin <agust@denx.de>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] video: Add parentheses around VNBYTES() macro
Message-ID: <20240902101759.3c4a3c64@xps-13>
In-Reply-To: <20230919151456.GL305624@bill-the-cat>
References: <1628fc37-2c9f-493d-82c2-9bf225f2645a@moroto.mountain>
 <20230809013930.GR3630934@bill-the-cat>
 <CAPnjgZ3cooZZGKryY5UwBpd7O2kL5W1z++QxQf-Z304eaKvzUg@mail.gmail.com>
 <20230919151456.GL305624@bill-the-cat>
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

Hello,

trini@konsulko.com wrote on Tue, 19 Sep 2023 11:14:56 -0400:

> On Mon, Sep 18, 2023 at 07:04:41PM -0600, Simon Glass wrote:
> > Hi Tom, Dan,
> >=20
> > On Tue, 8 Aug 2023 at 19:39, Tom Rini <trini@konsulko.com> wrote: =20
> > >
> > > On Wed, Jul 26, 2023 at 09:54:08AM +0300, Dan Carpenter wrote:
> > > =20
> > > > The VNBYTES() macro needs to have parentheses to prevent some (harm=
less)
> > > > macro expansion bugs.  The VNBYTES() macro is used like this:
> > > >
> > > >       VID_TO_PIXEL(x) * VNBYTES(vid_priv->bpix)
> > > >
> > > > The * operation is done before the / operation.  It still ends up w=
ith
> > > > the same results, but it's not ideal.
> > > >
> > > > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > > Reviewed-by: Simon Glass <sjg@chromium.org> =20
> > >
> > > In that this seems correct:
> > >
> > > Applied to u-boot/next, thanks!
> > >
> > > But I want to note that with gcc-13.1 (and binutils 2.40) or more
> > > specifically the kernel.org arm/aarch64/etc toolchains, this causes t=
he
> > > generated code to change:
> > >    aarch64: (for 1/1 boards) all +8.0 text +8.0
> > >             bananapi-m5    : all +8 text +8
> > >                u-boot: add: 0/0, grow: 1/0 bytes: 8/0 (8)
> > >                  function                                   old     n=
ew   delta
> > >                  video_post_probe                           248     2=
56      +8
> > >
> > > So I don't know that this was a harmless bug. =20
> >=20
> > Hmm I should have read the comment directly above...
> >=20
> > "Note we omit the outer brackets to allow multiplication by fractional =
pixels."
> >=20
> > Having said that, it doesn't seem to matter getting (if indeed we do)
> > a less accurate result. =20
>=20
> But we should fix the comment then, or decide no, this is intentional.

One year has passed and I just stumbled upon this incoherency. It would
be nice to clarify the comment or otherwise to revert Dan's patch if
judged irrelevant in the end.

Thanks!
Miqu=C3=A8l
