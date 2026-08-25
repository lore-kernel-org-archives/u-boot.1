Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33DEDC61DBE
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 13:48:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DD45480CB2;
	Tue, 25 Aug 2026 13:48:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oq3VtqUw7BnJ; Tue, 25 Aug 2026 13:48:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787665695;
	bh=bGaUIYC63b8ec1sjBHp1O1hT8j+iu2eOgvEKJiMTQSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ODOufTA38ybTm2CJWeozeWV/7uE8wiKBQmFcFLX/U3nitukufkRn0VcrzeSdwP+mr
	 9NKMYrTw2gtZCFqjcZFnFNUkQ/gjLIYXmgqJZNS1DQrpfxsJfgoS/vKG/uY2mwI3sI
	 ylWkE3uLfTUNMOh1A4vBCawebCOSl60KAp7sVVzjtE+9q910sfUgZjQCOn5O4hv+6B
	 1TgLKssz1QMis8fm/dhiKp4olD4Qn1t3Y/g6klj9Eo7VEtsuTy4BBa3f9tYouN3tNg
	 qw+tjy8b0YlAUCdzWejB1rfvZeVVtYpA7L6X4MEohp4tTLvUy8u/N+RXvz1BYyRj9i
	 JgFDnvrJnI1GA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 55F2A80CA2;
	Tue, 25 Aug 2026 13:48:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 83C8729B
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 13:48:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7277A40501
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 13:48:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id su54twsZPpqa for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 13:48:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1134; helo=mail-yw1-x1134.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=lMThril1
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9004C404A8
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 13:48:12 +0000 (UTC)
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-81ea0b7d137so42932097b3.2
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 06:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787665691; x=1788270491;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bGaUIYC63b8ec1sjBHp1O1hT8j+iu2eOgvEKJiMTQSY=;
 b=lMThril1hOW5eOl5yBAtiM9l2sSldNfh7vu/S/fka+IPdEUke1PoG9i+J6Mk9oqhnF
 iCVHjA26ExYXqBAKSeDGdwMXqTxmJAPyl6EDR/5eEn3svD05HlVDQ52GIVGcU+D505RF
 /4kMBkXytQsYts0tlXsARtG9vcgktY0OYmhpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787665691; x=1788270491;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bGaUIYC63b8ec1sjBHp1O1hT8j+iu2eOgvEKJiMTQSY=;
 b=n/WSJhdqRl3dUIEIfr2pH4oK60TLMFcWyMatlDRpLRpc1sb0kZ79aKZ6fy/kIGR3hI
 nynJdhYy+gJ5vhlI3289eEnUxbhWvmipU9Zv3hy5rr0p7p65JXGZEBKCz/rkiEMnUWza
 BKYhngGvGUPqxe8CsSRcsLDZqgwyNMWXuadi1hCam+V5hbxdE+UiuPTB8MF29CaoA6V2
 hNwIuZ7EvhlIVWWfHZMUYcJcnC1G+rzy8ObzhduajDdvzMi0LlDIvkKVJbPlWA8wT6G8
 wsrmRsQGW6aab3Z4oRzKGRVSFuoGoA1RBTnmVGHP76N074c2ao1fC/zin2EPWXOG7Psc
 5VWQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpX8vKJ5HiSavL4GVOZpNCaqEst9BcHpXWqWwywHHGdimQlvhEHmGB6cVnO7FkNSlXLZPSTRpA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kb3hFs0kx7xFnjjsn/7cjHpt713BX21m5/Wz8PPnj7DkzeUlt6
 0GShS1FBE0GjUZwPaTj4FpO1X1BdoF5jcA19M4N49ClQ4Wu0wkTSXYmpk9UumZzzAsA=
X-Gm-Gg: AR+sD13ZdB33ZGM6aDBfU56Pwy774mXlvl9+P1kJgjyEx4pXsmYUr2fVgQHI5g7IInn
 RYsk9fqwzFFa06rxTChFOF1qkySKdFGNxCKlDPdIR8B+Pft4ob3qOexgSg1btJGeEo3m0ugzHyP
 tpI9pOMezfPYuDhVetai0tgjIQJHK5hVtZRHJYGMoR/TnZ2WwqVZwC3kI+QYqWM43nK4dlPQDhr
 PEBqxCjZdGsLyAMsgucQqUDiKngmm7mKyNvOIrVwpM/Hc7ggPC17vxlFa3fePb/OSKzqaQVGDkt
 Rssk1v2jgH5ZQhlb/bYtdF4U/GoUAXneyuqKOLoFvUji0a8MmlgItwaPPtPYQWQdRIjjLU4/QMh
 1wCDULmklK7vbznYpmPrnrHxO/yiqecR0e4xQV6+XdhSEYsAFuJmvU4p2w5ACLNpCHyvkDid0KL
 6l4DFbjvhUgdS/kRXyWppQ2KvvEbS3ZEzGWb62a+fsBneFuRbXQ/L+T5GGCCzNg/gwFmQj19xvs
 zXM81MXnz5qd2aorWVx/9AjbKErDgNzGuTuw93ptBHK3rat4KcPN91zlQLu3lc1eHrtrC17XH46
 8R8lHJAxOQ==
X-Received: by 2002:a05:690c:6004:b0:822:854d:4563 with SMTP id
 00721157ae682-84c9682009cmr111136687b3.8.1787665690979; 
 Tue, 25 Aug 2026 06:48:10 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-84ca5e19ae8sm49688867b3.15.2026.08.25.06.48.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 06:48:10 -0700 (PDT)
Date: Tue, 25 Aug 2026 07:48:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Suraj Kakade <suraj.hanumantkakade@amd.com>,
 u-boot@lists.u-boot-project.org, git@amd.com,
 padmarao.begari@amd.com, Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Simon Glass <sjg@chromium.org>, Jonathan Humphreys <j-humphreys@ti.com>
Subject: Re: [PATCH RFC] scripts: pass dtc cpp flags via a GCC response file
Message-ID: <20260825134807.GR523975@bill-the-cat>
References: <20260824044729.708287-1-suraj.hanumantkakade@amd.com>
 <20260824150937.GD523975@bill-the-cat>
 <2c9ac202-68a7-4017-a8f9-91e9b3579166@amd.com>
 <20260824165125.GI523975@bill-the-cat>
 <a3b4bb78-8a3b-4c88-8bca-a32518e5ec48@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7Ay6OAuUf2dKhtdo"
Content-Disposition: inline
In-Reply-To: <a3b4bb78-8a3b-4c88-8bca-a32518e5ec48@amd.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--7Ay6OAuUf2dKhtdo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 07:53:10AM +0200, Michal Simek wrote:
>=20
>=20
> On 8/24/26 18:51, Tom Rini wrote:
> > On Mon, Aug 24, 2026 at 05:29:37PM +0200, Michal Simek wrote:
> > >=20
> > >=20
> > > On 8/24/26 17:09, Tom Rini wrote:
> > > > On Mon, Aug 24, 2026 at 10:17:18AM +0530, Suraj Kakade wrote:
> > > >=20
> > > > > cmd_dtc inlines dtc_cpp_flags (including every upstream dtsi -I
> > > > > path) in the HOSTCC command. With a long $(srctree) that command =
is
> > > > > too large for /bin/sh -c and Make fails with "Argument list too
> > > > > long" while building a .dtb.
> > > > >=20
> > > > > Write the flags to a per-target .dtc.flags.tmp file and pass @fil=
e to
> > > > > HOSTCC/CPP so the shell command stays short.
> > > > >=20
> > > > > This change requires GNU Make >=3D 4.0, since $(file ...) is not
> > > > > supported by Make 3.x.
> > > > >=20
> > > > > Fixes: d31ff219a833 ("Makefile.lib: find capsule ESL dtsi file wi=
th CONFIG_OF_UPSTREAM")
> > > > > Fixes: 1e7883f6325a ("dtbo: Fix dtbo generation rules")
> > > > > Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>
> > > >=20
> > > > The linux kernel, and so Kbuild, says that 4.0 is the minimum versi=
on of
> > > > GNU make required, so that is true for us as well, so this is fine.
> > > >=20
> > > > Reviewed-by: Tom Rini <trini@konsulko.com>
> > > >=20
> > >=20
> > > We should likely fix this too.
> > >=20
> > >    94 # If the user is running make -s (silent mode), suppress echoin=
g of
> > >    95 # commands
> > >    96 ifneq ($(filter 4.%,$(MAKE_VERSION)),)  # make-4
> > >    97 ifneq ($(filter %s ,$(firstword x$(MAKEFLAGS))),)
> > >    98   quiet=3Dsilent_
> > >    99 endif
> > >   100 else                                    # make-3.8x
> > >   101 ifneq ($(filter s% -s%,$(MAKEFLAGS)),)
> > >   102   quiet=3Dsilent_
> > >   103 endif
> > >   104 endif
> >=20
> > I think this means we should pull commit
> > 5f99665ee8f4335f334a5292b6d5b41a577fc2c0 from the kernel in, to fully
> > switch to 4.0 as minimum.
> >=20
>=20
> something like this?
>=20
> M
>=20
> diff --git a/Makefile b/Makefile
> index 16e3e4dfe5e4..e0ab39200c1b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -93,15 +93,9 @@ endif
>=20
>  # If the user is running make -s (silent mode), suppress echoing of
>  # commands
> -ifneq ($(filter 4.%,$(MAKE_VERSION)),) # make-4
> -ifneq ($(filter %s ,$(firstword x$(MAKEFLAGS))),)
> +ifneq ($(findstring s,$(firstword -$(MAKEFLAGS))),)
>    quiet=3Dsilent_
>  endif
> -else                                   # make-3.8x
> -ifneq ($(filter s% -s%,$(MAKEFLAGS)),)
> -  quiet=3Dsilent_
> -endif
> -endif
>=20
>  export quiet Q KBUILD_VERBOSE
>=20
> @@ -166,14 +160,6 @@ ifneq ($(abs_srctree),$(abs_objtree))
>  MAKEFLAGS +=3D --include-dir=3D$(abs_srctree)
>  endif
>=20
> -ifneq ($(filter 3.%,$(MAKE_VERSION)),)
> -# 'MAKEFLAGS +=3D -rR' does not immediately become effective for GNU Mak=
e 3.x
> -# We need to invoke sub-make to avoid implicit rules in the top Makefile.
> -need-sub-make :=3D 1
> -# Cancel implicit rules for this Makefile.
> -$(this-makefile): ;
> -endif
> -
>  export abs_srctree abs_objtree
>  export sub_make_done :=3D 1

And also the version check part (which we didn't add the initial part of
yet either, which checks for 3.8). Thanks!

--=20
Tom

--7Ay6OAuUf2dKhtdo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCao2dEwAKCRAr4qD1Cr/k
CnPBAQDvGCiWG1ViPKIfsX67V1OIe/QWxkQiQjo3miNYd37FjAEA0wUq4aDnvyKa
S0lCdEBVjEy1d+ch2fA6PR9V9odZVQY=
=OVtM
-----END PGP SIGNATURE-----

--7Ay6OAuUf2dKhtdo--
