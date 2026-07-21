Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64FA7C44532
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 13:54:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 02B4380759;
	Tue, 21 Jul 2026 13:54:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sn73NRI-0quQ; Tue, 21 Jul 2026 13:54:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 29C4C80841
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784642066;
	bh=8+j3dM0A+F4U2MxzxBUobYE45l2L0I+fFiOJo4kOVfE=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Z3BHtNvF2IIatoypqZyd+6N/xuKmREhJLA0oW4CD28sc2bLWuhV/QDdR7XOAcRdLv
	 hI+flQfvRExN6pslcb81jHeRxPrwX+v9Jv9/AeS6hNVHowWa+HLYTF1zovBOPN5Jry
	 4oAtt/ifIKNlbAUCQSvxdnrBPw4Aukq7MKrbUWXxWe8lIwLmQ+b+rGTd3/I62Jeg/H
	 NJK7XKojS+ClkrILrYPWmP31ehpgip0s/qknOrZHPKNwjcxQBDleCrEoCAnzuTmbOl
	 JkKHc8cMnN/r4/37VFD0t3xFUoApCGkAFwlpkNx3Ur8HP7D7dMf99C6alIIsl/l+1r
	 Qe+YvCftjWymw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 29C4C80841;
	Tue, 21 Jul 2026 13:54:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C2CB0109F
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 13:54:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B469F80759
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 13:54:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tTqYgCCa4Ina for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 13:54:23 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7E23780841
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7E23780841
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7E23780841
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 13:54:23 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0131A848BA; Tue, 21 Jul 2026 15:54:22 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E8CA803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 15:54:18 +0200 (CEST)
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-6a31b9a492aso7194408eaf.1
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 06:54:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784642057; x=1785246857;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8+j3dM0A+F4U2MxzxBUobYE45l2L0I+fFiOJo4kOVfE=;
 b=r3+xFp+XKY02OifYmuG6odiRgc1JUtcMPicXAvWcw+eYBp8gwZrxo+XMM4d6ZcBpRI
 3Mi7bIrEXFyd5+ZWMO4zlN1CyHiGylcSv9uWXecrtMFBzFBQze/K2mb1+5M7461UTD68
 5MUqxDUrzt/X2oTj1WezwCiFLrpXPzVIdgfC40Hqe1hUo6ZYh12YdWF4HWVDk7ViWRqY
 +9cx4H2L9N6YY8pWgVQ3gw+GqM4LwHq7CoBM+kWvjJ72qkRUBJ5Ddqzz5mDE+ypsmmtb
 SyjIMh2l0HIgmzh5465nKcfop2Ov9PL/ZIqhccexZ89M7l6o3d/dORh8xXGMAQzW6VRL
 vexg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpmZj2Nnu01pduci818jCSIOe8riadx3BsfuUwkXnw0kKpEgqntfKOp2RsQr3dK9lxx+yr6tmI=@lists.denx.de
X-Gm-Message-State: AOJu0Yx8PjEhohkGsePJoQrU1duyUB4NBnToiGvNT80ARU+QJBZjGroT
 SW4psAo6M9ap4k1z3BR/eoKXLJqrDXp8VjMlAM/5FxQQAd5AWy/Ertj272Vto/CK1rQ=
X-Gm-Gg: AfdE7cleSM4VC+p7sm/Y3+k3v3qMxHJh4gDv8bbgFrB5Gg+gIhGgG0jMy+xNHwoUXsQ
 kcKOpVvAQPhdr2yhik6eL+ForZOrk2ci5iqhv2Fuij8vrkOn0qYyFZn4tN4X5qUef8xt4PANUff
 jB6OAUjqZrMOwlfQETtCnib3FgW+mOVz9viY2h8+yFxWMWpDOV5qQw1m8N0LnANUbnDWSLLYFvB
 oNPn2AKRoewHExTKhFGzcELhCUPUaMVB56d6narqAo96IkuechrscQZiS0B23gfqcAZ+W+kUTUS
 TU4VSBGx1r9bIxMV8M3CsMmb3IyiwjLxT9RQaLT34e7da/ZNBzG3le9VT7dW6PwXuA+Er/M1IWH
 kuUMmwfZwV/c5Ix+W/GofoJ6hHs2tuo0eXPT+TPrj5Q42PalosfbB6fQMi/LRIJswuHqlPiosay
 rD/VLok2M9bT6oIgzvPpzCuhfscodPNwWDBNzm3ZtwuV88l/IW8I7bPvP4DRCgUhHkU5JoaNYa5
 93kCeSEYQKljCAaJ6IaIw86lc8=
X-Received: by 2002:a05:6820:1350:b0:6a3:7a0c:77e2 with SMTP id
 006d021491bc7-6a536a860aemr9328074eaf.65.1784642056847; 
 Tue, 21 Jul 2026 06:54:16 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4568e141e9esm10631599fac.5.2026.07.21.06.54.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 06:54:16 -0700 (PDT)
Date: Tue, 21 Jul 2026 07:54:14 -0600
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de,
 u-boot-board-maintainers@lists.denx.de, u-boot-custodians@lists.denx.de
Subject: Re: [ANN] Mailing list migration to lists.u-boot-project.org
Message-ID: <20260721135414.GR749385@bill-the-cat>
References: <20260715173119.GL749385@bill-the-cat>
 <87ldb5sen1.fsf@bloch.sibelius.xs4all.nl>
 <20260720222158.GL749385@bill-the-cat>
 <alpine.DEB.2.21.2607210525010.64835@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/JMq9Ak510i+vdRM"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2607210525010.64835@angie.orcam.me.uk>
X-Clacks-Overhead: GNU Terry Pratchett
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784642057; x=1785246857; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8+j3dM0A+F4U2MxzxBUobYE45l2L0I+fFiOJo4kOVfE=;
 b=tMqAeDQWKoqdDPxocRJSrlShbswvWRMoX2IMl9RL60urNW3ygLUllUFNbBFawWmhL3
 YoG5DlkGHfqxNFlJ8rv0c4JMWopq0lQNLbEw3M0lLZ2oKQzbfWD+9L0MQERgZijwGmGM
 WAWTT/q4JMTzRKAmUFMEBXzvrRilRIk4MAN94=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=tMqAeDQW
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=trini@konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tMqAeDQW";
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Tom Rini via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Tom Rini <trini@konsulko.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--/JMq9Ak510i+vdRM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 05:27:41AM +0100, Maciej W. Rozycki wrote:
> On Mon, 20 Jul 2026, Tom Rini via U-Boot wrote:
>=20
> > > Sadly it seems that the new list is (mis)configured to rewrite the
> > > From: header to something like:
> > >=20
> > >   "John Doe via U-Boot <u-boot@lists.u-boot-project.org>"
> > >=20
> > > Does it have to be that way?
> >=20
> > So the answer is kinda. Whereas back on DENX we never "munged" emails
> > this is also why we likely often had big piles of unsubscribed due to
> > bounces (which was due to rejection from being incorrectly set as spam)
> > on the big providers. So now mailman is configured to munge the headers
> > *only* from senders which have a enforcing DMARC policy set, which
> > xs4all.nl has. And because we're on shared resources our lists not
> > following the DMARC rules would mess up all of the other lists.
>=20
>  That's going to break patch submissions, isn't it?

Looks like it's working:
https://patchwork.ozlabs.org/project/uboot/patch/20260721063050.18756-1-din=
esh.maniyam@altera.com/

Not my favorite that it's going to have "... via U-Boot" in patchwork
only. And we already have "... via B4 Relay" in others. We aren't the
only project OSU OSL is hosting mailman for, so I'd assume this is a
solved problem.

--=20
Tom

--/JMq9Ak510i+vdRM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCal96AgAKCRAr4qD1Cr/k
CheqAQDc22I81P9VhWn7DNTBYqsbFk9oJZ/F5GbwVuMvz61/XgEA4UwsP0mhAzY9
KtzA9tfKs0es9YeLjFa/8r8LUEizkg8=
=xWb3
-----END PGP SIGNATURE-----

--/JMq9Ak510i+vdRM--
