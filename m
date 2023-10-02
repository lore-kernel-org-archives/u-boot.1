Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C05E784BC
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 15:01:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A98A387161;
	Mon,  2 Oct 2023 17:01:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="nywRrKzy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41D4286DFD; Mon,  2 Oct 2023 17:01:41 +0200 (CEST)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
 [217.70.183.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD14387161
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 17:01:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E037EE0004;
 Mon,  2 Oct 2023 15:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1696258898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M7mKXaT02uhPcGvd4JSPzX214M9A9By/6DvX2C9ROO8=;
 b=nywRrKzyn/8QcsDS3YBcGm3jGZH2GDiHYp9b2ihCy+3M/xvWHoMD6WuJNeBNrFRp5S7zzv
 qL0Q8Of0KdQPNWdWcSI9yI9166yFHZNe2gGVjYnpcWNNjdMKyPq9Ci9k28WZd5VNGxLS96
 Uqsi8Ma+ym9GAneMC1YVUJA375A2FowVDrhezkQj1PLubz8eOoOS6T6/cdlvrDcsbIH3+4
 zOuFawgLipUQc7lwZ94YxBofebZzDpUWCKUk19zu0XtFaHPdUx0Is/sCAemJcbRMds+K7l
 eKujIjOrTj8iWSzFZaahh7zP1kuOO42t+CG1/0WjNunmDcJygwoSEs4Lbj5sMg==
Date: Mon, 2 Oct 2023 17:01:37 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: Marek Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
Subject: Re: [PATCH RESEND v2 2/2] usb: udc: Try to clarify an error message
Message-ID: <20231002170137.353cd4ef@xps-13>
In-Reply-To: <CAC928Ha_dkjjjfdQdFMiU34UQgfoNbP9zavPDtboADWZrBYD8w@mail.gmail.com>
References: <20231002134621.94786-1-miquel.raynal@bootlin.com>
 <20231002134621.94786-2-miquel.raynal@bootlin.com>
 <CAC928Ha_dkjjjfdQdFMiU34UQgfoNbP9zavPDtboADWZrBYD8w@mail.gmail.com>
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

Hi Massimo,

massimo.pegorer+oss@gmail.com wrote on Mon, 2 Oct 2023 16:37:10 +0200:

> Hi Miquel,
>=20
> Il giorno lun 2 ott 2023 alle ore 15:46 Miquel Raynal
> <miquel.raynal@bootlin.com> ha scritto:
> >
> > At some point when trying to use USB gadgets, two situations may arise =
=20
>=20
> [...cut...]
>=20
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> > While doing this I really wanted to add "much more" error comments but I
> > faced another reality: often the messages are there but use
> > pr_err/log_err which is actually silenced by default with LOGLEVEL=3D3,=
 so
> > I consider this unnecessary, as decreasing the loglevel will make these
> > messages appear. I would have expected errors to be displayed, but I
> > understand it makes the binaries even bigger. =20
>=20
> This is how it works for pr_err but not for log_err: if you are not
> using CONFIG_LOG, all log_xxx with level less than or equal to INFO
> are in the binary. On the other hand, if you have CONFIG_LOG=3Dy,
> log_xxx are left out based on LOG_MAX_LEVEL value, while pr_xxx are
> left out based on both LOGLEVEL and LOG_MAX_LEVEL too (due to the fact
> that pr_xxx relies on log_xxx). This is quite confusing IMO. I'm
> working on a proposal for a simpler and clearer unified way to log in
> U-Boot.

Very interesting (and, as you said, way too confusing). I did not even
notice the difference, thanks for the explanation. Indeed, it would be
nice to simplify this a bit.

Thanks,
Miqu=C3=A8l
