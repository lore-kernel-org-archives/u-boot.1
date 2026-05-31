Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A31CD6E57
	for <u-boot@archiver.kernel.org>; Sun, 31 May 2026 22:55:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3077839DF;
	Mon,  1 Jun 2026 00:55:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="fIWRM60f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB6B783EF9; Mon,  1 Jun 2026 00:55:28 +0200 (CEST)
Received: from mail-106116.protonmail.ch (mail-106116.protonmail.ch
 [79.135.106.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E29E838D7
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 00:55:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1780268124; x=1780527324;
 bh=xJOXicCane0ICd8wDAyJiMvWFtLvC2xP4RV7wHzRP0A=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=fIWRM60fmqMDfH1S/owqhGv76oYAEIc+q97zTxIdDPJE/f8h0hnlRaTecJi7u3iFa
 PqCAHv4A7Mny7wbQhGrYwROj8hNUbknFGmo7hH4G10XwczcF4sC4VR6n0azHMAK/HW
 WmL844xvVR+sbJK8B75Fp3IROsfzZu7+PPsuttpM7oz7QkiEx0NMO8z+N87nJ9rTFs
 m8ODou2fpDtCykQfJ6cWlirrTJ61d6aowPJkDB5vB98zFNk+Vrn1LcC6lJ2aWp+uwU
 y9oy2ehuD5PlrNn0j6goql6lVKqVRpmJJId85MDTD9rWfI4uHrT6e/RkbP9/YA2b1p
 f4DO+8CMP2EHg==
Date: Sun, 31 May 2026 22:55:19 +0000
To: Marek Vasut <marek.vasut@mailbox.org>
From: Sam Day <me@samcday.com>
Cc: u-boot@lists.denx.de, Nishanth Menon <nm@ti.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] usb: gadget: fastboot: avoid stale IN dequeue
Message-ID: <yRfZvho0XzQ_6hzUJBFDPN7XN7k1eiIwbrqX5DoxELAJryntUnmmSBywdbrLIzKyOVjatkJi28J9Tn1KSkKyW0NRYHdUUr6RSaZdBL93eSc=@samcday.com>
In-Reply-To: <c7b7d0fc-bbf3-4c2a-832c-eb8eae70e3b5@mailbox.org>
References: <20260531-dwc3-fastboot-fix-v1-1-1e4fbfd476e8@samcday.com>
 <c7b7d0fc-bbf3-4c2a-832c-eb8eae70e3b5@mailbox.org>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 3a8f071c3cee79d39b4b86e99becd8d7ae8c0c70
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hello Marek,

On Monday, 1 June 2026 at 7:43 AM, Marek Vasut <marek.vasut@mailbox.org> wr=
ote:

> On 5/31/26 9:01 AM, Sam Day wrote:
> > This usb_ep_dequeue line was originally added as a fix specifically for
> > MUSB UDCs.
> >
> > On dwc3, it causes an error like this to be logged:
> >
> > ```
> > dwc3-generic-peripheral usb@a600000: request 000000016e0862
> > c0 was not queued to ep1in-bulk
> > ```
> >
> > The trouble is, this causes an infinite loop in `fastboot oem console`.
> > Every time it flushes out a response with a chunk of the console, it
> > triggers another instance of this error, which means another response
> > must be written, which generates the error, and so on.
> >
> > I'm not sure if the MUSB gadget code still needs this workaround, so to
> > be safe I opted not to remove it, but guard it with
> > CONFIG_USB_MUSB_GADGET instead.
> >
> > Signed-off-by: Sam Day <me@samcday.com>
> > ---
> >   drivers/usb/gadget/f_fastboot.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/gadget/f_fastboot.c b/drivers/usb/gadget/f_fas=
tboot.c
> > index 8df0e3f331d..fb7e47401ca 100644
> > --- a/drivers/usb/gadget/f_fastboot.c
> > +++ b/drivers/usb/gadget/f_fastboot.c
> > @@ -406,7 +406,8 @@ static int fastboot_tx_write(const char *buffer, un=
signed int buffer_size)
> >   =09memcpy(in_req->buf, buffer, buffer_size);
> >   =09in_req->length =3D buffer_size;
> >
> > -=09usb_ep_dequeue(fastboot_func->in_ep, in_req);
> > +=09if (IS_ENABLED(CONFIG_USB_MUSB_GADGET))
> > +=09=09usb_ep_dequeue(fastboot_func->in_ep, in_req);
> This won't work on systems that have multiple disparate USB controllers.

I think I follow you, but could you please expand on this a little so I'm
not guessing as to what you mean?

My understanding is you're saying this won't work if one builds with two
different UDC drivers enabled, one being MUSB.

That's true, and in that case fastboot might continue to cause issues. As I
noted in the original patch, I have no idea if MUSB still needs this workar=
ound
introduced 10+ years ago, I don't have any MUSB hardware to test on.

Or are you suggesting that introducing this gating on Kconfig symbol is bro=
ken?

>=20
> Why was the workaround added in the first place ?
>=20
It was introduced by bc9071c9f318, which specifically spoke about MUSB issu=
es.

-Sam

