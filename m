Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C92BFCCFA05
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 12:34:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A80983B85;
	Thu,  6 Nov 2025 13:34:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=pschenker.ch header.i=@pschenker.ch header.b="njLTQoJB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEC7B83B86; Thu,  6 Nov 2025 13:34:16 +0100 (CET)
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::8fa9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75D5183B81
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 13:34:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dev@pschenker.ch
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4d2M7p11drz32P;
 Thu,  6 Nov 2025 13:34:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pschenker.ch;
 s=20220412; t=1762432453;
 bh=FTlxLSK8hFA88mkPvwR1R/pbxinBVX/b/FCap4tjXdQ=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=njLTQoJB8LwoiUljRxv5UThXwliJnDyo1dW4WR7RZh8/y/8hY+72VbGKnPDXtwlOH
 kjlkMA60oiQKCUQ2OC11j7dD7juRvR7CfFKa9SoaTwJgEsOeFR6xI0/AmxqMOf950l
 z/hRZC3GpfN6BniCPY0hkheENst0JJW/zSJB9Rzk=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4d2M7n44JQzBbG; Thu,  6 Nov 2025 13:34:13 +0100 (CET)
Message-ID: <3fbc597ddb07590d36498ca7993df524c002e450.camel@pschenker.ch>
Subject: Re: [PATCH v1 4/6] mach-k3: security: Propagate verified image addr
From: Philippe Schenker <dev@pschenker.ch>
To: Andrew Davis <afd@ti.com>, u-boot@lists.denx.de
Cc: stefan@embear.ch, Tom Rini <trini@konsulko.com>
Date: Thu, 06 Nov 2025 13:33:35 +0100
In-Reply-To: <f499c3ea-72ce-4698-91d2-b10aa8c438bf@ti.com>
References: <20251023094631.16742-1-dev@pschenker.ch>
 <20251023094631.16742-5-dev@pschenker.ch>
 <f499c3ea-72ce-4698-91d2-b10aa8c438bf@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
MIME-Version: 1.0
X-Infomaniak-Routing: alpha
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



On Thu, 2025-10-23 at 09:24 -0500, Andrew Davis wrote:
> On 10/23/25 4:46 AM, Philippe Schenker wrote:
> > From: Philippe Schenker <philippe.schenker@impulsing.ch>
> >=20
> > The ti_secure_image_check() function may relocate the image during
> > authentication, updating image_addr to point to the verified
> > location.
> > The caller was not updated with this new address, causing it to
> > reference the original unverified location.
> >=20
> > Update p_image with the verified image address after authentication
> > to ensure subsequent operations use the correct location.
> >=20
> > Signed-off-by: Philippe Schenker <philippe.schenker@impulsing.ch>
> > ---
>=20
> Seems reasonable,
>=20
> Acked-by: Andrew Davis <afd@ti.com>
>=20
> BTW, did you actually run into an issue with having a binary moved
> by the authentication, or was this found some other way? Normally
> binaries don't move (but they can, so this is still valid).

Thanks for your acked-by's! Sorry forgot to answer and just now saw it
again. Yes I ran into an issue where I have a signed elf file. The step
of loading the elf file was failing because the pointer still pointing
to the signature.

Philippe

>=20
> >=20
> > =C2=A0 arch/arm/mach-k3/security.c | 2 ++
> > =C2=A0 1 file changed, 2 insertions(+)
> >=20
> > diff --git a/arch/arm/mach-k3/security.c b/arch/arm/mach-
> > k3/security.c
> > index 3468a370a455..9255505a7944 100644
> > --- a/arch/arm/mach-k3/security.c
> > +++ b/arch/arm/mach-k3/security.c
> > @@ -119,6 +119,8 @@ void ti_secure_image_post_process(void
> > **p_image, size_t *p_size)
> > =C2=A0=C2=A0 */
> > =C2=A0=C2=A0 *p_size =3D image_size;
> > =C2=A0=20
> > + *p_image =3D (void *)image_addr;
> > +
> > =C2=A0=C2=A0 /*
> > =C2=A0=C2=A0 * Output notification of successful authentication to re-a=
ssure
> > the
> > =C2=A0=C2=A0 * user that the secure code is being processed as expected=
.
> > However
