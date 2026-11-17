Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158EF606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 16:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BgyRNLg2;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Z623j246
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4004D408D1;
	Tue, 17 Nov 2026 16:23:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1VKdcasvAuQD; Tue, 17 Nov 2026 16:23:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 74D55408F3
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794932637;
	b=JjWtITkr49caCVMHoep3Ah2HrPdZu3bOxFxWORcTet5nFvxCOSp73Wq8sG47L0nfEo1O
	 gZMo2sUNE3Od3YzATtsuEno6QetrY4eb/h/O/naWaN2A9NeJsphRJxNHto8XX0PEVCFhv
	 LuGOHHSECOit6s6fAR0kIUmGpBQUwnbjKcQvMG0WQTOWOsjgv+JIbc5ROg+ra3YPXndmS
	 +FCe5YgcEBDe3P0mY3Z3wQmv2vW/ZYFBBZwuxjPZzwk/Hv5W2OAy5uSiztrp4AlcDleFs
	 OEKgJEKLh+oWFRIm5rSwuBr8lm64kuQ2xhTu+cKo83nFwfjNiC6+Q+wc903PRkbi2jg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794932637;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=EK33SQo8rVw6rhR+0KzxFOep0eYfbQcnA1EXn+9063E=;
	b=NB5X40Lwnh4sF2w4LvAt6fhwQey9w/OKFYTEUSpcRYdtfs8uqB+vj3A/LrnR6KYQ/hGf
	 wb3L6d4NtVr03xrCrUiZBTKtJPShoPGwleTAD5awjEUpUiZM7xc8HC2R2le74jfp1ukVv
	 PGvxLSk8BeuOoNVqiYPgB8rKbvExoVOl4mLKzjxT1UtQAZnE5rXcr6oWoWkgn129eWujJ
	 yCCJyPlzbbI28MBgbATRU/C6loAKFGTmHCrqcLG9zfXXPRQ9Dr8cw/3Dw9IDotdl3owWo
	 UZuUeciSHcmDU4Di55Nx12jI6MlHMYs+GOTbrKj/U/hqd9Np20ew5xfiXb0oL9OIZIQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794932637;
	bh=EK33SQo8rVw6rhR+0KzxFOep0eYfbQcnA1EXn+9063E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BgyRNLg2YU1RZ0XBrYePu2Of2kkUJIElUo4ZWpHV7qrWmFmV0moHgLOAqaQNvuI0Z
	 BTo2tV9Hbrq15UM/pHItNkXFE0Qd6AzBpJPxeRNJigX1ty2at/X/by3R/6t9odfSOV
	 28TGIMstvyZGJHYR7A9UAU9vqQ/Clp5RfcoPz9Y+6eRWlvr6cjaYfpqY8bCCpKckY0
	 LFkL7dThv/de/nNyJAALOMqkpOhZccGu6cZMz5UvIpEDkrEesUsoGJszUHn5hsUPWz
	 NSlZEUGFwFcBoW8YAAa8HHTaQOjOq/chFxR8KtneT/ZyImWWTwokcS7fYJh9fLIcVZ
	 C9cRBsAqgzG+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 74D55408F3;
	Tue, 17 Nov 2026 16:23:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 914981E7
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 16:23:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 832A040387
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 16:23:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o9_yCagJYpue for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 16:23:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C14AF4037F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c31"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c31; helo=mail-oo1-xc31.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Z623j246
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C14AF4037F
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 16:23:54 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-71ad1db7e31so735474eaf.1
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 08:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794932633; x=1795537433;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EK33SQo8rVw6rhR+0KzxFOep0eYfbQcnA1EXn+9063E=;
 b=Z623j246xtEznaesUE/LWsskb5pg+VUOFcfw4JLC7AY7XGK56uk74Xol5s14N+By9U
 DbsBu1U2tpZ8KFrheCGQch/PbmE/a+qEhrKkUFAfO6U45CCjBDOmDkjG5nVxlVZYOPHM
 PkUhsfNeELBe5rqSuOfdXYSBS/g+xoLsxnGa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794932633; x=1795537433;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EK33SQo8rVw6rhR+0KzxFOep0eYfbQcnA1EXn+9063E=;
 b=nD/HCQRCzUftOUY/7xCzeqOZt+ZllChYfdJZE7D7ZcC4nLw+cJAEU8XeTrIVBrWN/6
 un/cIEaXBofVlDvF14cyRmjwBFuQ+cRLJpXW9loPvD1Opzeu23Vtmtiw2T3qg4wytaVz
 zU7k1MmHTpf8ogM3tdbG0BTW6vEf4nVMConjPbXfNrZeCKcZnjIKLkmZX6A1JzgQTyTZ
 km/PwuQxiZxZKCm6p2/HBsUWoD1wXaCUJFNXFvhBZyLWHN2/Enc9rmpwITmNcsQwfPFp
 WFhAvcfjQH4v+Hzqxaia3PbGriWbUwm+f+lciZt7ZZPwisV5QAp6MMrhO+K6nwWu+qzX
 oUiA==
X-Gm-Message-State: APuU4Z85NtDdiWpvAaqhiFi1s9uBNOoN6KfLPrfOf1QFRYqVOGZk/NjG
 mGQ/1BjFzxtYyDgFRfyRbSPWYwftRPi3gOQkwEy3wIESuKUrFGMohHutwrlFIl05i1s=
X-Gm-Gg: AYBFou3m8iaWKjJ/RhO+S3OQgN2e6Q6W2bfRSJgaeJQ9ywv7wdy6eahlhOS9GnRw4U2
 zsCjHmZHtwOsbtZzPRa8g0JdDLsaTe2Y1t5UcActblsiJ83Jy7K1UhSmAUNQvK+moRAz+iiLpDk
 QBxXpyZq5HxNrDKQjzHhCt13BGFsi5jM/nettpaRsFQMSmnUoMhSlUvkY8NfdhZuhMxemyG5Wh9
 f0lUHkCsL9KJRfeN+iw+wRV0nhhfRIICvTTqMEQkaAVqmiiQM1nxcD+sOZWnME0AgyiuZz3vzuX
 Tmz10VXMw4XsQMmGUEFqy8Pbb1q9agzBHu9umwCYBnkieS9gDO9uAtXHVjE+46b9rqO7M58Cc4A
 XRJsyohIwQkj0HzhZBb/dc/FGwauSxp+vsVJYkGxjtDx+GOnHagGQAogQXdqYFyYBA4L/HByJfu
 CWc+wk9GyK0RJnpgsIwDho6G7+BOOGuBGlNnZX7gC3NrRYbHqfAapPKIH8s80DYRocO5mrZzyFR
 UG4VAgQiO2AhztmX98BpOIbnKCRv77oowWzjKGF7yAQeiBqgdDt2BGtiBG90bHGytSldS2rtejf
 iOED8OmDJRutx8dSsrj67jrjMbYaYwjhv6o3YP7TfhDAey3LYReyfuwEhOAxi036gc7HXrz7/E3
 XED05m7NEh/4PubOXf3w+aaQ10dHGG1JZ08l6tC5dfKwX8bxH7UjlArHC3agZ7al3VIYJQlTZjR
 lmdoGJCefZ+fuzFAW6cOOU+iRcztxFAPgw1c7RRdCxk67GOm5KVDzR
X-Received: by 2002:a05:6820:1b17:b0:6d3:abd1:9b87 with SMTP id
 006d021491bc7-71b02993b2amr2198545eaf.45.1794932633332; 
 Tue, 17 Nov 2026 08:23:53 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-862a0c3eae5sm10558278a34.14.2026.11.17.08.23.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 08:23:51 -0800 (PST)
Date: Tue, 17 Nov 2026 10:23:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] disable VBE by default
Message-ID: <20261117162348.GS554944@bill-the-cat>
References: <20261111093212.3390778-1-pbrobinson@gmail.com>
 <20261113145107.GA1199710@bill-the-cat>
 <CALeDE9ONicupsLsf69DKA9vgi-a=xyr5CKYZMc7Bg86Z5Kyj8g@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VLOtkFrYZZsO4Ywh"
Content-Disposition: inline
In-Reply-To: <CALeDE9ONicupsLsf69DKA9vgi-a=xyr5CKYZMc7Bg86Z5Kyj8g@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--VLOtkFrYZZsO4Ywh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 04:08:07PM +0000, Peter Robinson wrote:
> On Fri, 13 Nov 2026 at 14:51, Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Wed, Nov 11, 2026 at 09:32:09AM +0000, Peter Robinson wrote:
> >
> > > The VBE protocol needs explicit device support and as
> > > such isn't particularly useful by itself without that,
> > > it also adds size and the potential of an attack vector
> > > so devices that wish to use this protocol should
> > > explicitly opt in to it like all other large features
> > > in U-Boot.
> > >
> > > Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> > > ---
> > >  boot/Kconfig | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/boot/Kconfig b/boot/Kconfig
> > > index 8fcdc36c931..556e868a5f4 100644
> > > --- a/boot/Kconfig
> > > +++ b/boot/Kconfig
> > > @@ -720,7 +720,6 @@ config BOOTMETH_QFW
> > >  config BOOTMETH_VBE
> > >       bool "Bootdev support for Verified Boot for Embedded"
> > >       depends on FIT
> > > -     default y
> >
>=20
> What you mention below looks like two different things:
>=20
>=20
> > This needs to be default y if SANDBOX so CI still passes, due to all the
> > tests.
>=20
>=20
> The above makes sense.
>=20
>=20
> > I'd say we need to update the tests except for all the numbering
> > issues that's likely to uncover and that we'll be dropping VBE as the
> > follow-up step.
>=20
>=20
> Due you mean this as a follow up? Do you have a link to what you're
> referring to?

Sorry for being confusing. A number of the sandbox image tests rely on
finding say mmc10.img or mmc11.img, and I worry that if we pull the VBE
tests out, mmc10.img will become mmc9.img or mmc8.img and a cascade of
failures. So better to deal with that all at once.

--=20
Tom

--VLOtkFrYZZsO4Ywh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavx/kQAKCRAr4qD1Cr/k
CowTAP9yKPgQUhSC9YvH5ck/QZEvmTjxdQU75tC+Qm4Qws1TjAEAgM3s/p97JMjw
cTu4Tp5F+Vp3KE6tBa0Bm2DsLf905QE=
=4lCH
-----END PGP SIGNATURE-----

--VLOtkFrYZZsO4Ywh--
