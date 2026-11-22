Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DB4606A320
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CBpTBf4x;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=YKqndoLF
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF88380D5A;
	Sun, 22 Nov 2026 16:17:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8TKiZoqxaSVE; Sun, 22 Nov 2026 16:17:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4607880D5B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795364251;
	b=gcDfku8oDTTZqEacBIV2o8N23n/7YkPx2VBn/iFE4YDkXk1DkjCdssATxsd9+12uKeEH
	 VgT6mDPbnsT9EgIJ4Ip0nT+0YaPvXpA8QWZJObAUi7f0C5rda5VQ41fpmg3qJBqBwWm7H
	 bQ9yq/vNtbIZfNSlAPAFiS5H4oFEPAGpkcOCf32yrsE7nQ3DwVyX8EivIQvnIvnCziXuN
	 RygQsrVWkGss6ludSwdgGFAU/2vRueKSHx3U2+BFGRibXe5aZbqjwTQw2j0+qz2+xvv6W
	 vvYPSvY4EhEfNxJYAolVNG4iRnm2+678er5MNS9MjL6gnan3ef2aMGsepH00DBx+xdQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795364251;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=fDVFhR0B9dL/LRXbc7BwK5pxOZAG6nhj9M5CJJ28wak=;
	b=HURJJOuvwy7fzNf0797KC12J3OOdS7iVUcxOFDt5+2Bffh4nC3lF+jYiMOJZqm3CYzum
	 7sjMaUY7ti7nhupdkXcPPIUiZ9R6bH711ZRPEicrbg0uHX+om93atgn+13Oar9b/oCZK6
	 2RfnnQ5JLaeEkqSGl6qrM6Q7Sw5254w+5L+X6OHzHsgrb/wrAz6Qoez5iFh1Fgc/oCSZn
	 SZuQa+yDDgWFcjRs1PxNdzVZeMjMSlKH0ielUAVEe1TQZcRufi6H8JBZaqqb/+oKSEQf4
	 sxvByg8eV92YzU8r8q7zJc0T/4scyZ9peOa2q7/AcnjCjClhWL9y008vuHD9YgGV88Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795364251;
	bh=fDVFhR0B9dL/LRXbc7BwK5pxOZAG6nhj9M5CJJ28wak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CBpTBf4x1aa44FY+E/NwZbLMEg0ipQAbTxpdrAJvOIaapnLOgczFwkPGrv8tpf2rn
	 PiNwtShDS2ThU9WTseIC513PPWHatIHxpN06/rqt0tkuCq4zls78xsqQ5ZZp2FDK0n
	 Xh1MmYu7Xq5nlfJZBImjcu4V6rGIVF9rTVrlkisfu2H1uSyf3mYQ4MdUiBfqE1YPT7
	 6Q/GjTVcxYBFJBcTJsHqR6QvKpdDpLQKfse8GyVo3O2XaU9w/41DajEyc5hOBkpK5r
	 TPcVJC8JK7xA0k9CD1D6w0MYBClnoaFNSxVrZtRXWleBSRpkL52yjKfPWliyDFA7oC
	 uYAR+GL3+txBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4607880D5B;
	Sun, 22 Nov 2026 16:17:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id F27E122B
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 16:17:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E48C9400BC
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 16:17:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5cHnIEOMzzkE for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 16:17:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1DD81400B3
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c29"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c29; helo=mail-oo1-xc29.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=YKqndoLF
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1DD81400B3
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 16:17:28 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-702fd86d674so1676794eaf.2
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 08:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795364248; x=1795969048;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fDVFhR0B9dL/LRXbc7BwK5pxOZAG6nhj9M5CJJ28wak=;
 b=YKqndoLFVA6MUKMfwtnLFwhE7t+AFLJGKcGY9+KA8vO5QAwYfi+cJVU1UkKxu7fEHM
 Hbjphoqgx6xkYPJgwruq/FAU12MQkr8+0taDejaG1J2bJXOYamqZvPRxs/CMaXYRVoCa
 WucVryJBzuX3K0sBMN+ujKhLzxRsADZYG/fKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795364248; x=1795969048;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fDVFhR0B9dL/LRXbc7BwK5pxOZAG6nhj9M5CJJ28wak=;
 b=pvdl3p8WfEJRaNEoHwxs/Kv0xrSogNx8Rmglx9cn0DldW+ll8HTb9R/NEuw+ua/atv
 jAX0enEy0hEKVT/OxVGM2IxkRRvfwf8+b7INA/9VpCPUGrArtAZQgG619ESBKlKBmDAP
 jHlIDo8DnoQtfxh8TQGbN09W6zJGPUHLMf39ZxpnSMHVNvTxMGMgZ/PLF8KBWrwStM5D
 q0i26guleQfAtV5HSYwBgSs95kju4y8hLLWtKtnfYjlZhw8OaZZ3omkHz9mQ4sLVw6Kd
 8Xv9fYAxPc3r0YFU3CLd2fiutFBjXHnW47K5oaMm0ADYPhgL7eRkak6yaAmzHNhl5roC
 fEoA==
X-Gm-Message-State: APuU4Z+DI0+bF9RF40jcUhLMUw0mb2m0mF8YbI8QvuaZkDC5s3DXgHYv
 TlrkvxCXFq/HF7HTSZyp7bvn5qmH9eNJ+4Xz0zgfOrLMOV20edK3ajT+QNFIUO7/H+oO0mC8ktF
 lI05aURbnsg==
X-Gm-Gg: AZFdTZd5ozhQUWp3ckd2Ei7O5rG7TDR8oaMOAB3ucmDSKlV6AHBuy43aQ961eS6ngQU
 Otlgl9/aP+Ir1L7XBlEAtflpYWDhIfP0Agsfkvu8Owug6pLE+u96B03DMYrByS9K1OQ/FnpNEYA
 /FMrqsOmhhVRduWkgL1gqmb8Vh7CqLWo6hJQGTWBnN2xbf2hFeg/etCfG6h0gQdsJ3ukK3zt8T1
 Z3QFcDLRPfIyVduBtUOe6zJt7fvDBLVvy4In4yOrGovlkSyo+04kHzFQg96ifMe4jwy9X5SI23i
 BPbk/ZMlYdAJupoYx2syNfJHWVuJyKrOChN7HVMLdxgl1x/CO3ffQLMlutGdwINLNi9+nqoSdFf
 021QJavWCl9boCuC7CzL6gwoWEnBrxOxOdOiLVYFE+Kr4/jFJfyviAH2RVHLwO1kNGVKiBDn5WJ
 lLmIlJel5O15wuOP0PgddB7DkgNiEoVCD81e+Rrrkb7+E/NdOEWN8Ai4N6xygoW4jj1E99159pz
 pRAvTqtoE72IJubLoftRvGeLcBOJszMsDzBCAnulYISz/h1gAlfmVIwFcl41PRTOTjsjqFCtf0S
 w72PLh/tcP4Aw8lpT3cunxEE8Z9/UoRNtH9Bv3rlZJx9qkfIKz/jyw1K9hjZwnGZsXJRrfO3lce
 KcU9aODIbjsXhI9pyRkAqQoyHKgpZN7Is5nNj2eqjS0vZKkjE2KKYRMWF0z169fmRRkcVJtq4wl
 qRbThIF1tgw6ZrwAGvqoYIvQ4MiCMDH+s=
X-Received: by 2002:a05:6820:c0c2:10b0:6e1:b850:8c33 with SMTP id
 006d021491bc7-71b396065d6mr5010263eaf.67.1795364247800; 
 Sun, 22 Nov 2026 08:17:27 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-863168dd6e7sm7474640a34.12.2026.11.22.08.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 08:17:27 -0800 (PST)
Date: Sun, 22 Nov 2026 10:17:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] Makefile: Move PLATFORM_LIBS outside the the
 whole-archive region
Message-ID: <20261122161725.GL3176972@bill-the-cat>
References: <20261121092137.2797011-1-pbrobinson@gmail.com>
 <20261121195816.GI3176972@bill-the-cat>
 <CALeDE9O7jbQ_2hPC4BP9P9EJzeHmjAeQqjKf6miuVTHYiL8jRg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iIEgh9SCdW8ih2KL"
Content-Disposition: inline
In-Reply-To: <CALeDE9O7jbQ_2hPC4BP9P9EJzeHmjAeQqjKf6miuVTHYiL8jRg@mail.gmail.com>
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


--iIEgh9SCdW8ih2KL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 22, 2026 at 10:55:54AM +0000, Peter Robinson wrote:
> On Sat, 21 Nov 2026 at 19:58, Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Sat, Nov 21, 2026 at 09:21:33AM +0000, Peter Robinson wrote:
> >
> > > The LTO link passes $(PLATFORM_LIBS) (-lgcc) inside the --whole-archi=
ve
> > > region, forcing every libgcc.a member to be linked. On AArch64 this p=
ulls
> > > in members needing libc symbols U-Boot lacks (__getauxval, abort,
> > stderr),
> > > so the link fails, e.g. on p3450-0000. Place $(PLATFORM_LIBS) after
> > > --no-whole-archive, as the non-LTO link already does.
> > >
> > > Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> > > ---
> > >  Makefile | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/Makefile b/Makefile
> > > index 840d02aa6ca..4323d5ec701 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -2103,8 +2103,8 @@ quiet_cmd_u-boot__ ?=3D LTO     $@
> > >               -Wl,--whole-archive
> >      \
> > >                       $(u-boot-main)
> >       \
> > >                       $(u-boot-keep-syms-lto)
> >      \
> > > -                     $(PLATFORM_LIBS)
> >       \
> > >               -Wl,--no-whole-archive
> >       \
> > > +             $(PLATFORM_LIBS)
> >       \
> > >               -Wl,-Map,u-boot.map;
> >       \
> > >               $(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@,
> > true)
> > >  else
> >
> > Is this still an issue on the next branch after Josef Schlehofer's
> > series? I'm wondering if the --gc-sections change there fixes this too,
> > or not. Thanks.
>=20
>=20
> Yes, it's still a problem on  p3450-0000_defconfig and this patch still
> fixes it on next.

OK, thanks.

--=20
Tom

--iIEgh9SCdW8ih2KL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCawMVkQAKCRAr4qD1Cr/k
Cm7AAQDfuXKWOVyAUvPbgMH4qT6ubeoqdfeBvwFMvVXVL6YgUgEAykJuw+Z5Udtl
PsWCdCoakwev1femL/huETMBvUFL3AY=
=IVww
-----END PGP SIGNATURE-----

--iIEgh9SCdW8ih2KL--
