Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96642CCD1BB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 16:05:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC61480422;
	Wed, 22 Oct 2025 18:05:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="zDyFqFPp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E05F83303; Wed, 22 Oct 2025 18:05:05 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB7528003E
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 18:05:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 3E3861A15D7;
 Wed, 22 Oct 2025 16:05:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 00145606DC;
 Wed, 22 Oct 2025 16:05:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DA5C3102F2447; 
 Wed, 22 Oct 2025 18:04:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1761149100; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=kjZLu/3TBPnuHmcootR0AXTERvs6OD8mvflJOeyMTbI=;
 b=zDyFqFPpjANRtZg2lP4VQaZ+GRlcB5YPJa5DQVzcagNxdfxreffM5Bglv7fStFQGh684XI
 YnxjK+iUxv4+uTESjOOwaftezPe+KiSUbGLuRpjtGjCCugmT/Pf7GWgUinu0F30PfnAXj3
 UxdAaUHwftfn+lWlTsjwj7H19rpFjGTeIQ7pQdmvG7yWxBd8qiHpuE3vfYHfU1Hod5xmeb
 umnUt4pIcWH5KJGTDUPMqT0uwBfOj6cpQPQ9Q8gZVUzy8gc61uo1p6pWyM7Jg14Vocv9wu
 HchAxZClsNUVIPRKT5DgwwZAPHfaqoOBvEu1ori0uemr5EhMHRVTdSAMOLttLQ==
Date: Wed, 22 Oct 2025 18:04:51 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Bajjuri Praneeth <praneeth@ti.com>,
 thomas.petazzoni@bootlin.com, Tom Rini <trini@konsulko.com>, Simon Glass
 <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Jerome
 Forissier <jerome.forissier@linaro.org>
Subject: Re: [PATCH] doc: pytest: Complete dependencies list with missing
 packages
Message-ID: <20251022180451.1e91cee4@kmaincent-XPS-13-7390>
In-Reply-To: <87bjlzarlt.fsf@kernel.org>
References: <20251022132055.816662-1-kory.maincent@bootlin.com>
 <87bjlzarlt.fsf@kernel.org>
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

On Wed, 22 Oct 2025 17:22:38 +0200
Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:

> Hi Kory,
>=20
> Thank you for the patch.
>=20
> On Wed, Oct 22, 2025 at 15:20, Kory Maincent <kory.maincent@bootlin.com>
> wrote:
>=20
> > From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
> >
> > Add missing dependencies to the pytest usage documentation and correct
> > the device tree compiler package name from 'dtc' to 'device-tree-compil=
er'.
> >
> > This ensures users have the complete list of dependencies needed to run
> > the pytest test suite without errors.
> >
> > Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
> > ---
> >  doc/develop/pytest/usage.rst | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/doc/develop/pytest/usage.rst b/doc/develop/pytest/usage.rst
> > index 779b2dbe24b..454877837ca 100644
> > --- a/doc/develop/pytest/usage.rst
> > +++ b/doc/develop/pytest/usage.rst
> > @@ -39,7 +39,7 @@ will be required. The following is an incomplete list=
: =20
>=20
> If the list is now complete (as per your commit message), should we
> update this sentence as well to remove "incomplete" ?

Indeed I think we can. Do you want a v2 with this update?=20

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
