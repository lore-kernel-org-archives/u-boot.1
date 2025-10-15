Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA74CCD18E
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 14:23:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 589528313B;
	Wed, 15 Oct 2025 16:23:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="UKHzKUZg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27DF68323A; Wed, 15 Oct 2025 16:23:26 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA2C5800D7
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 16:23:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 499021A13D4
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 14:23:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 20CC4606F9;
 Wed, 15 Oct 2025 14:23:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3DA0F102F22BC; 
 Wed, 15 Oct 2025 16:23:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1760538202; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=CbDufg7LrzEu/FO4OL51/ZkAAaQcVAw0Cyv5feoqvw8=;
 b=UKHzKUZgcYj1LlgZXO78xLvXz8tcJYJyf/ycJkvt+1Uifx2I7XugBYvc8YYX9lbRM/mjmc
 NlMsrXjWteCd99f7Wf7kLLZoLPnNgVz49yXNQgVoarzF2qLsWE0uOPJcaL9dRv0kczcTjg
 Q/B9FNAficQAzFkcniuzvAsyTSeqat0YWgyuC2Jn1AOUjiJ7lYii7OWsz+iNsX0/HiqX+4
 fEClfIcol6oQgqte6yRsmhYV7SM9sWThBZ14t5lFrdqidJx1prZ3b8SAqDMhbNlsBJctxc
 4P8qZRYunFkW4lF4SNyzVLmcGXuAKPy+5ZzPOfr1TRMXkk7X9z1N390PM8eJkg==
Date: Wed, 15 Oct 2025 16:23:17 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 thomas.petazzoni@bootlin.com
Subject: Re: [PATCH] test: Do not build expo and cedit test if no SDL
Message-ID: <20251015162317.00b38674@kmaincent-XPS-13-7390>
In-Reply-To: <20251015141535.GO6113@bill-the-cat>
References: <20251006164506.380308-1-kory.maincent@bootlin.com>
 <CAFLszTg+2-xRo1N3zzqY3BEUUqM989xifttbar_+mOE_X12PYg@mail.gmail.com>
 <20251006214436.GE298503@bill-the-cat>
 <20251015152538.7fccb0f6@kmaincent-XPS-13-7390>
 <20251015141535.GO6113@bill-the-cat>
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

On Wed, 15 Oct 2025 08:15:35 -0600
Tom Rini <trini@konsulko.com> wrote:

> On Wed, Oct 15, 2025 at 03:25:38PM +0200, Kory Maincent wrote:
> > Hello Tom,
> >=20
> > On Mon, 6 Oct 2025 15:44:36 -0600
> > Tom Rini <trini@konsulko.com> wrote:
> >  =20
> > > On Mon, Oct 06, 2025 at 02:38:10PM -0600, Simon Glass wrote: =20
> > > > Hi Kory,
> > > >=20
> > > > On Mon, 6 Oct 2025 at 10:45, Kory Maincent <kory.maincent@bootlin.c=
om>
> > > > wrote:   =20
> > > > >
> > > > > expo and cedit tests depend on the host having the SDL library.
> > > > > Build these tests only if VIDEO_SANDBOX_SDL config is enabled.
> > > > >
> > > > > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > > > > ---
> > > > >  test/boot/Makefile | 2 ++
> > > > >  1 file changed, 2 insertions(+)   =20
> > > >=20
> > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > >=20
> > > > We should be careful that a future CI change doesn't cause these te=
sts
> > > > to stop running.   =20
> > >=20
> > > Given how HOST_HAS_SDL is defined, CI will be fine. =20
> >=20
> > What is the status on this fix? I see that it is still not merged. Is t=
here
> > a reason for this? =20
>=20
> It's on my list to pick up very soon. The general window for applying
> patches is about 2 weeks to allow time for feedback.

Oh ok. Didn't know about that. I am used to the Linux merge process. Sorry =
for
the noise!

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
