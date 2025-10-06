Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6AC5CAC5B8
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 15:54:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 306E483DEE;
	Mon,  6 Oct 2025 17:54:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="0jcmpPSt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C07C83DF3; Mon,  6 Oct 2025 17:54:17 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A8B483DEA
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 17:54:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id D740DC085D0;
 Mon,  6 Oct 2025 15:53:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 0B655606F2;
 Mon,  6 Oct 2025 15:54:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 39F52102F1D91; 
 Mon,  6 Oct 2025 17:54:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1759766053; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=gWJZOZ1YAaAf1Ek5Ke9yfg71DfYc2w9iMUckSwlI6YE=;
 b=0jcmpPStBU8QE/b2WxuUv5BVZJaRL8FYw/cE+b/4cnn0KnhN74h1omlor3OBpz2sxCZBH+
 QAL6neIEzQq1mjJk6AppdtdB2R4RqoH8aKxYGnGPdTsetdyeHvcR/iGyUTpXtfsp5KI4HT
 z2zWqwz+YJ0tcYv/Dib6VbSnOoBebKzjqHePbQHVoL8J4tu9cIGvt6a6eCY75IWOl6j5vl
 FAkq3OlQaW+++HkKQsnvOVDwPGHt2zORB4WAEb1Nj2O1/co5PRy8NNrktp34l1jy4kTi7V
 XR/twjghvHU9ldpGi1uqwxy8Y42MoN+HTz3t1X586WW4upPJXQjnEOyxw5ZLyw==
Date: Mon, 6 Oct 2025 17:54:08 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Alison Chaiken <alison@she-devel.com>
Subject: Re: [PATCH] test: Update logic for video test
Message-ID: <20251006175408.27ba321d@kmaincent-XPS-13-7390>
In-Reply-To: <20251006153328.GA6303@bill-the-cat>
References: <20250818165406.3194425-1-trini@konsulko.com>
 <20251006171335.7b40302c@kmaincent-XPS-13-7390>
 <20251006172224.0a8d1919@kmaincent-XPS-13-7390>
 <20251006153328.GA6303@bill-the-cat>
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

On Mon, 6 Oct 2025 09:33:28 -0600
Tom Rini <trini@konsulko.com> wrote:

> On Mon, Oct 06, 2025 at 05:22:24PM +0200, Kory Maincent wrote:
> > On Mon, 6 Oct 2025 17:13:35 +0200
> > Kory Maincent <kory.maincent@bootlin.com> wrote:
> >  =20
> > > On Mon, 18 Aug 2025 10:54:06 -0600
> > > Tom Rini <trini@konsulko.com> wrote:
> > >  =20
>  [...] =20
> > >=20
> > > This broke the build of sandbox_defconfig: =20
> >=20
> > It seems CONFIG_SANDBOX_SDL=3Dy is missing in every sandbox defconfig, =
and it
> > is required to have CONFIG_VIDEO_SANDBOX_SDL enabled. =20
>=20
> How we detect SDL is kind of odd and could be improved. I suspect that
> VIDEO_SANDBOX_SDL needs to 'depends on SANDBOX_SDL' as part of the
> solution too.

Oh indeed didn't know it was a dynamic check.=20

So the issue is not SANDBOX_SDL missing but rather not compile expo and ced=
it
boot tests if SDL is not available:

diff --git a/test/boot/Makefile b/test/boot/Makefile
index 00223b44fe0..89538d4f0a6 100644
--- a/test/boot/Makefile
+++ b/test/boot/Makefile
@@ -6,9 +6,11 @@ ifdef CONFIG_UT_BOOTSTD
 obj-$(CONFIG_BOOTSTD) +=3D bootdev.o bootstd_common.o bootflow.o bootmeth.o
 obj-$(CONFIG_FIT) +=3D image.o
=20
+ifdef CONFIG_VIDEO_SANDBOX_SDL
 obj-$(CONFIG_EXPO) +=3D expo.o
 obj-$(CONFIG_CEDIT) +=3D cedit.o
 endif
+endif
=20

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
