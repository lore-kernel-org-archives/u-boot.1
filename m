Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE4B0CAC5B9
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 08:17:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B9B983045;
	Tue, 30 Sep 2025 10:17:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="R0lznwep";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B4788341C; Tue, 30 Sep 2025 10:17:12 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9111E828A2
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 10:17:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 0C0344E40E4F;
 Tue, 30 Sep 2025 08:17:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D4F0D606E4;
 Tue, 30 Sep 2025 08:17:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 46D1B102F176F; 
 Tue, 30 Sep 2025 10:16:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1759220228; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=VnYS36EZv1J+QEb60PCk+tsRuaeFe9/jiU5uW3UhX14=;
 b=R0lznwep0TsovGVoVj5Fzt8rKGAU7gcVa2/MuODU0+zUcttTrXn2GpRD0OPAL6v10+TAxB
 kXOxdYttZUZ6GZxyKYYMfQ8T6WcUBRZ7g3nMceN+mGZIdGJxZDNfKG2gbd9oGeKIJ5f8mh
 BBX25+u8n8HNUXxej1Ub5AARuuEVO0/XK6E0I8OLHk/YnP2dvf0PNWUWBiA6oT00g6e9at
 rXcFUQPF+cFE0wX7ufy9/WEQQ8a7PPEob8PW6JrkrFAd9U1WuaAR/ejgD/9+GNzNCHgXqY
 b6/wRfA7yeeTwIaWPhmtQWUSAuvNEwvh0LtrOi+y9VWmkujU3LL250AI5PA+cA==
Date: Tue, 30 Sep 2025 10:16:56 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 <thomas.petazzoni@bootlin.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] Revert "board: st: stm32mp1: Clean env_get_location()"
Message-ID: <20250930101656.28f4bcd0@kmaincent-XPS-13-7390>
In-Reply-To: <fd32f45e-a3c9-4170-8886-5a31dda0e4c9@foss.st.com>
References: <20250917141736.59732-1-kory.maincent@bootlin.com>
 <55d0805b-dcb2-4277-a4da-f4c26b48a2dd@foss.st.com>
 <20250929170912.3bee3f9d@kmaincent-XPS-13-7390>
 <fd32f45e-a3c9-4170-8886-5a31dda0e4c9@foss.st.com>
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

On Tue, 30 Sep 2025 09:45:08 +0200
Patrice CHOTARD <patrice.chotard@foss.st.com> wrote:

> On 9/29/25 17:09, Kory Maincent wrote:
> > On Thu, 18 Sep 2025 16:16:35 +0200
> > Patrice CHOTARD <patrice.chotard@foss.st.com> wrote:
> >  =20
> >> On 9/17/25 16:17, Kory Maincent wrote: =20
>  [...] =20
> >  =20
> >> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com> =20
> >=20
> > Hello,
> >=20
> > Any news from the maintainers? Is there a reason for not being merge?
> >=20
> > Regards, =20
>=20
> Hi Kory
>=20
> I expect to send a pull request before end of this week for master branch
> including your patch.

Oh ok. Thanks for this update.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
