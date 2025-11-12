Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3BAECCFA1A
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 14:50:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19F0D839D6;
	Wed, 12 Nov 2025 15:50:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="z0YtdWEn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E28A83CA4; Wed, 12 Nov 2025 15:50:43 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 468F983966
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 15:50:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id C0C264E41667;
 Wed, 12 Nov 2025 14:50:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 96BF36070B;
 Wed, 12 Nov 2025 14:50:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A5D37102F187F; Wed, 12 Nov 2025 15:50:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1762959040; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=k/nEKo3ki6IEUXi4Imigqr70cJelAJMFiSfevmoDQtA=;
 b=z0YtdWEnea44ANlHNO2u2J25WqU+sSyfbUmbi8O+7VDRP0efd4lkMR8PVhYOHphdtMUHRh
 2Eef4YE+Qe7rtLaQ3eFIoqjlEQ0JzPaVsl9VKKmF3Eb/qvxjvdy1B7Ila43cTYN3+dyNlP
 iucEqefqyTRMSsA2wDsyKKC8YCKoH2sZEhQu6LX1Hf6uq9ywZZd5gT9W2x1g33Vm77DeS2
 A2Syb5xB6z5A0WQcA0Z6PYoIEhOqmCWYNly+IHmYcJ0WCGiZYPsdf2nxj4RDFsFJDlFa3N
 Ov0ft4O1+2nHC6jx3b5wJv6S/t2YXmYpimWWfLXTcwM1qFk6mthXRobTWAtFJw==
Date: Wed, 12 Nov 2025 15:50:36 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Bajjuri Praneeth <praneeth@ti.com>,
 thomas.petazzoni@bootlin.com, Tom Rini <trini@konsulko.com>, Simon Glass
 <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>, Jerome
 Forissier <jerome.forissier@linaro.org>
Subject: Re: [PATCH] cmd: extension: Fix possible null pointer dereference
Message-ID: <20251112155036.501b7d0c@kmaincent-XPS-13-7390>
In-Reply-To: <896ae93d-0b37-4a6e-b244-fcee50b496f7@cherry.de>
References: <20251112130742.97473-1-kory.maincent@bootlin.com>
 <896ae93d-0b37-4a6e-b244-fcee50b496f7@cherry.de>
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

On Wed, 12 Nov 2025 15:12:34 +0100
Quentin Schulz <quentin.schulz@cherry.de> wrote:

> Hi K=C3=B6ry,
>=20
> On 11/12/25 2:07 PM, Kory Maincent wrote:
> > From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
> >=20
> > Add a null check for extension_list before calling alist_get_ptr() to
> > prevent a potential null pointer dereference. If extension_get_list()
> > returns NULL, alist_get_ptr() would attempt to dereference it, leading
> > to undefined behavior.
> >=20
> > The fix ensures both extension_list and its first element are checked
> > before proceeding with the list operation.
> >=20
> > Closes: https://lists.denx.de/pipermail/u-boot/2025-November/602892.html
> > Fixes: 2d12958ee71b ("boot: Remove legacy extension board support")
> > Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
> > ---
> >   cmd/extension_board.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/cmd/extension_board.c b/cmd/extension_board.c
> > index 86e4795ba8a..1b92be82611 100644
> > --- a/cmd/extension_board.c
> > +++ b/cmd/extension_board.c
> > @@ -99,7 +99,7 @@ static int do_extension_list(struct cmd_tbl *cmdtp, i=
nt
> > flag, int i =3D 0;
> >  =20
> >   	extension_list =3D extension_get_list();
> > -	if (!alist_get_ptr(extension_list, 0)) {
> > +	if (!extension_list || !alist_get_ptr(extension_list, 0)) { =20
>=20
> Is it possible that one runs extension scan which returns no supported=20
> extension (alist_empty(), the default state before calling the scan()=20
> ops for the extension uclass driver)?

Yes, we can have no extension plugged, therefore the scan won't find any
extension. i.e. empty list.
=20
> In which case, we should only check whether extension_list is NULL and=20
> not whether there's at least one extension?

extension_list being NULL mean that there is no support for board specific
extension driver. Maybe we could have another error message for that case.
"Extension not supported"
=20
> Or at least have a different error code between "scan wasn't run" and=20
> "scan returned no extension", if that is a distinction we can make?

We could plug or unplug an extension. So it could change over time.
I wrote it similarly to mmc rescan command.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
