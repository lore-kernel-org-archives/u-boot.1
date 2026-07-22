Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 680B7C44536
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 22:04:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F4164409F8;
	Wed, 22 Jul 2026 22:04:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P92HXm0QF3lE; Wed, 22 Jul 2026 22:04:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 248CF409EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784757856;
	bh=HGMEbt3kuWQZ3V8ET8rryt5T8LWK87n/6TSsNYegKnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vI0xJDvwu0w5EpCIc0LonBI1q3slls793uOqecIgXu4i8LFyHTru6lOtU76VaS8QC
	 LVqrm0+sG5ueMABhJdIhEb5pxZRdxVQ9p67CEdGGWAXvvUoUeoW2qCxBvqL2gb4kvj
	 B1mtiFd6qkenpiVxRGiZcmpQzSEz/uRJNDoUlPg4wyk/THYSObJzjSW72Z4SJw3R0y
	 +vKAZSuZFT3HTqbduNkZVl8az7csxLFiw1YZ/47GyR/AtdnmxCXThOC2tNVIME59+a
	 d619RVL/FDrSHjHvVENzRNKSPBiNlJnHiuGXjndHC+kZaYE9XM99bJKkbIwlJViKbt
	 FwpJhxw0sGSDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 248CF409EB;
	Wed, 22 Jul 2026 22:04:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3D6EAEB
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 22:04:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2E9E280C59
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 22:04:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jJ4_BNuCkYXh for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 22:04:13 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org EC04E80C67
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EC04E80C67
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EC04E80C67
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 22:04:12 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BEA68494B; Thu, 23 Jul 2026 00:04:11 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CF9E8404D
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 00:04:07 +0200 (CEST)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-44ae14b4fd6so4602062fac.2
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 15:04:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784757846; x=1785362646;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HGMEbt3kuWQZ3V8ET8rryt5T8LWK87n/6TSsNYegKnE=;
 b=aKFhyjinCYIZ8wVI9gWyi28ikXFfh2L/ugg1kIEhcvW7Zi0+79v9dndJCscTdK1BrZ
 0KUIuh2lU+QA5MG5xFki3ielhBQ0YXZPhfKfIZ8hPYflq2hWHRKD9xh4WqBekCVkH8La
 ebqj+4mld8VVbcRFgYQAAUNIFsQ/kD99mawnuRGcLT9dMX1dFvyfXqBJXO2SKrFKCLql
 QgP+lqtVMVfvAn2hhc3FqfV1daZBG4Vej+//dAojCUEnnw/WD5APOrtZpGlH7lqwowc+
 tJz7LzuAUFZcSFlssbO5RNeTOqAAitH4r+duxaavzJhufCNCJ8VUtNnhBaGaUs0QWHXb
 Liwg==
X-Forwarded-Encrypted: i=1;
 AHgh+RriwjshqQLUQI6v3GB135Wy3wOkUiWUrsucjql9eTuLi1AVL7SUzd2OvAxt+Z8kaKNLMc5n3go=@lists.denx.de
X-Gm-Message-State: AOJu0YyXG6tK/w+5Tso6tElWEl0THjFHU7CJ6UGUSlPglXCDlMeOEkIC
 2oF+gWIWiz3JoFiOCQ7Dgc9ayUrKrG3x+dmXoRTUZx0pVowCUgAittVJq1O6bTMRo1g=
X-Gm-Gg: AR+sD13PGLJhxDrMwsKRIUQbKauFkUzJSm5plv6rXK6BYRXQf82YRgCbN1uaSBJqqVX
 tRAosNkAtUTE+PBbBQRKhsMAzhFxTO7tlCULkLqBzOEyhU5r48PJE4P8QUQpKc6CvKuxXQjpSRL
 lziW710lMrPRqAdRgOi7o2CbLYs9E42lk3FK+hq2Vz6wd+s0AcbZSpFqpa/S2SHx1D0uaYin+Ji
 K5cY9mfkRzuXpuwBsq9z9GMEcLav6CRw1WiP5vchWnDGzDF3jawypiLgwiYkQ0yZGeVLBiKyRz5
 ZwKN74enyIBqDxE7Ev1dCJLqfQugxQXKqcTV8gmfWVGEY0bixT/w1hi63jQLQ+LUkCFWyhmGo7F
 oKIeWkhMhlOM7VrqZcmUybElHAfc4FQbEYzneyu/FzPfFZgGseOEq7dtVaQzHAXt1S7hTjpKB5h
 70HZ/KDuIrHQrIcoHorgusPktMralLLQeVkogaNipIwQc48JIM36HyYcqH72JpK2qohv99QxGH6
 cgM7B+QbWEsXUPdeN5WPRjfoc8=
X-Received: by 2002:a05:6808:4fd3:b0:4ab:2638:7abb with SMTP id
 5614622812f47-4ab3548ed12mr343588b6e.30.1784757846047; 
 Wed, 22 Jul 2026 15:04:06 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ab0e9aefbbsm1874957b6e.9.2026.07.22.15.04.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 15:04:05 -0700 (PDT)
Date: Wed, 22 Jul 2026 16:04:02 -0600
From: Tom Rini <trini@konsulko.com>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de,
 u-boot-board-maintainers@lists.denx.de, u-boot-custodians@lists.denx.de
Subject: Re: [ANN] Mailing list migration to lists.u-boot-project.org
Message-ID: <20260722220402.GA749385@bill-the-cat>
References: <20260715173119.GL749385@bill-the-cat>
 <87ldb5sen1.fsf@bloch.sibelius.xs4all.nl>
 <20260720222158.GL749385@bill-the-cat>
 <alpine.DEB.2.21.2607210525010.64835@angie.orcam.me.uk>
 <20260721135414.GR749385@bill-the-cat>
 <alpine.DEB.2.21.2607211504130.14485@angie.orcam.me.uk>
 <20260722220120.GZ749385@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="s2McDjnua/V3goR1"
Content-Disposition: inline
In-Reply-To: <20260722220120.GZ749385@bill-the-cat>
X-Clacks-Overhead: GNU Terry Pratchett
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784757846; x=1785362646; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HGMEbt3kuWQZ3V8ET8rryt5T8LWK87n/6TSsNYegKnE=;
 b=I2F5raewXjCU7Jng7v137n+LhhV9iJMWuBaUD1CZOWE2lHYeLaY/euuJ8OKt4PeoFO
 bD375hBBHUO39sRODiYGXvz23ar0c3Ct+WLqyl38uc/t5X5GVREZLoOUCb3dFjY9/sFM
 +CFW+No/aGQxm3zPnBsW+T/EVdz26uNcW+Bwc=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=I2F5raew
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=trini@konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="I2F5raew";
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--s2McDjnua/V3goR1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 04:01:20PM -0600, Tom Rini wrote:
> On Tue, Jul 21, 2026 at 03:29:23PM +0100, Maciej W. Rozycki wrote:
> > On Tue, 21 Jul 2026, Tom Rini wrote:
> >=20
> > > >  That's going to break patch submissions, isn't it?
> > >=20
> > > Looks like it's working:
> > > https://patchwork.ozlabs.org/project/uboot/patch/20260721063050.18756=
-1-dinesh.maniyam@altera.com/
> >=20
> >  It breaks for `git am' though, such as for picking up patches directly=
=20
> > from the mailing list via the MUA (hmm, why hasn't this particular patc=
h=20
> > arrive here?).  There are other issues with the rewrite, such as the=20
> > inability to sort messages by authors in the mailbox, but the former is=
=20
> > possibly the most painful.
> >=20
> > > Not my favorite that it's going to have "... via U-Boot" in patchwork
> > > only. And we already have "... via B4 Relay" in others. We aren't the
> > > only project OSU OSL is hosting mailman for, so I'd assume this is a
> > > solved problem.
> >=20
> >  Yep, GNU toolchain lists I'm on that are used for patch distribution=
=20
> > (such as <binutils@sourceware,org>, <gcc-patches@gcc.gnu.org>, but not=
=20
> > <gcc-help@gcc.gnu.org>) simply disabled such rewriting, after numerous=
=20
> > discussions (not sure what OSU OSL is though).
> >=20
> >  Up to you to decide, I just wanted to share my concern.
>=20
> So, thank you both, Maciej and Mark for bringing this up. I relayed this
> back to OSU OSL again and it was indeed really a misconfiguration on the
> migration and not a policy that we had to keep. It's now been fixed.

=2E.. in the case of domains (most of them, but *not* xs4all.nl) which
don't enforce DMARC but instead either aren't strict (most) or are
quarantine (kernel.org for example).

--=20
Tom

--s2McDjnua/V3goR1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCamE+UgAKCRAr4qD1Cr/k
CpbCAQDF/qRnjIUBH4N56on87l4UE08TW7Uze0ORjSy6QLvKJgEA6/pl5nTw+h0E
5u968073qkHmkO4qLPaO+qamvpBhVwc=
=paln
-----END PGP SIGNATURE-----

--s2McDjnua/V3goR1--
