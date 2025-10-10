Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9B2CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 12:33:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 227378419E;
	Fri, 10 Oct 2025 14:33:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="i2fBOqoT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8E37841B8; Fri, 10 Oct 2025 14:33:52 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFB0A8410C
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 14:33:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 1A4274E40FDA;
 Fri, 10 Oct 2025 12:33:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id CA6D660667;
 Fri, 10 Oct 2025 12:33:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CAD39102F2216; 
 Fri, 10 Oct 2025 14:33:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1760099627; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=EXJ/A9ldGOygIrsH2Pji/cn6LySeJLxMlTwylDqMZ3c=;
 b=i2fBOqoTyn+jidEQFiOq/o5DtPniw/yxt/u9YXrqnJAj7q9BEzS/Zh0f+jq5gbzfRCKyFN
 R9XcXav/N4y0NS8QOVTx1iG2PheweGff2MR+3+Qf1gTRb9fz7PYk/YNAOI6FitTxZFEdzr
 4Xpj5DhEd8fyEKl31WUUyBRclulMf6vt3bpLqI/W6kP55iB8bnIFobr152zN/MxNZNvImJ
 q+Xx166J8j3PnWO89nR50/JQf8ojhAUu9FBaV7CB5iTKQn7iIT8IYvSRI5kxwqoNlthc9Y
 zep1hXa2iyEJliS8crdCbaAZtBoK6+iOgG4/2/SNqdBoQECuVa1PiVglXGlyTA==
Date: Fri, 10 Oct 2025 14:33:37 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Hans de Goede
 <hdegoede@redhat.com>, Mario Six <mario.six@gdsys.cc>, Stefano Babic
 <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot
 Team" <uboot-imx@nxp.com>, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 02/18] boot: Move extension board support from cmd/
 to boot/
Message-ID: <20251010143326.4d4994f1@kmaincent-XPS-13-7390>
In-Reply-To: <CAFLszTiM+HwkeT5Fi_fQchqpLxyHZ+-_Ykqs4b4OCBWWyvW30Q@mail.gmail.com>
References: <20251009-feature_sysboot_extension_board-v2-0-e09b39e54de5@bootlin.com>
 <20251009-feature_sysboot_extension_board-v2-2-e09b39e54de5@bootlin.com>
 <CAFLszTiM+HwkeT5Fi_fQchqpLxyHZ+-_Ykqs4b4OCBWWyvW30Q@mail.gmail.com>
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

On Fri, 10 Oct 2025 12:13:05 +0100
Simon Glass <sjg@chromium.org> wrote:

> Hi Kory,
>=20
> On Thu, 9 Oct 2025 at 15:50, Kory Maincent (TI.com)
> <kory.maincent@bootlin.com> wrote:
> >
> > Relocate extension board support from cmd/ to boot/ directory in
> > preparation for converting the extension framework to use UCLASS.
> > Also improve code style by applying reverse Christmas tree ordering.
> >
> > Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
> > ---
> >  MAINTAINERS               |  1 +
> >  boot/Kconfig              |  3 ++
> >  boot/Makefile             |  1 +
> >  boot/extension.c          | 97
> > ++++++++++++++++++++++++++++++++++++++++++++++ cmd/Kconfig             =
  |
> > 3 -- cmd/extension_board.c     | 99
> > ++--------------------------------------------- include/extension_board=
.h |
> > 16 ++++++++ 7 files changed, 122 insertions(+), 98 deletions(-) =20
>=20
> Reviewed-by: Simon Glass <sjg@chromium.org>
>=20
> I didn't know the name for this, but I like this style too. Just in
> time for Christmas!

Ahah I usually write it xmas tree but it seems my brain has written it
differently.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
