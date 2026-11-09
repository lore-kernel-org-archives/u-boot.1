Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DFF606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 19:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=asfQ1obq;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Ff8VUo7e
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 794EA405D9;
	Mon,  9 Nov 2026 19:44:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YLW39p5nf5qs; Mon,  9 Nov 2026 19:44:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D20004065D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794253492;
	b=jHwqWFchGdR3QUHZXInOt6sdYqO9ET5x4PSFW/s6vbYY+vblbcbkjQqdkYQOdwo03xsG
	 zeGoUjR22OIRhGXb1xsqYCyWTKCLXNNIverL0maoXufP0t277if8UjCDiaI6n4qUZqi17
	 n7t3L8KoCV5oX+VEb55tUwDW9x/IwJeyq9JxsnFnfp7qsU5P9qRRjwGdGfm1xk8HAM5g+
	 /V1NYRpmnjtHBpzImuPSj/0JtuLWfI9oQdds6IsxwUqzEMCrd2gMc9rRy8fKdNkj1tVon
	 FTZiFVCeJLTuxSPH+8dD6iEQeBvq4ugHkNojd7jRsUyv7wgp4kPImx5H3GyvDycl23g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794253492;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=7V0A8C96Uc3ahxclbmJOGx6i+uS/lywvyKHaGH0aExM=;
	b=T3OQI+ekksJESD7uSzWPDfCf+JFRlZ+CAvBwrjKm6AfHTa7j3AD/gkCcbAJHwQnLYwlZ
	 L4+c+1DJs1t5XxQKezdSNDnLnSyU/IUZ5r+rHJfmbi4MG4BBP7/BJO2YYMGfZ5w3sgZX2
	 GsvYjemGlqy8b3p9jEln+tF4K43ShQdaJLGz+GE5s3lWd32/uVYuotsc0pz+nGRm2750R
	 fZL3qHJB27jB+Z5a6egz3S9jpcM5quFbHN7kODrZyyHecpbW1WR9C9bbifY3PUepkUtj3
	 P8dfQdDEZLApsQS6Ki4k7+YTUBORgmhQ89NOrrHHKjnyiaXCCGcVfuR1dmcApm1K+8A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794253492;
	bh=7V0A8C96Uc3ahxclbmJOGx6i+uS/lywvyKHaGH0aExM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=asfQ1obq2DJL54sPDce/SmjXw0A9gz3ywQFZSc2MioJY0bqGNu9KUlmt+7tlCM73F
	 2KhHqSyJds0k+wS8ymuvoOE1wpPeKYs6339lnxYJR3KEr+PjZhoRX0E0S9Wxobg1sV
	 tSxUm4FUFbM9r1LmEP0Apz2Xd0qj/mugo86MDyNxDSlTf6q+VBkeUPdEVwLdDFQq4W
	 X2JFBwHx47FDhq7eSw07rTg+3IbdCgOMlSWcOSXnQlhHB/H1hsOfqRoCPlQbTEdadE
	 XLWSLv0DSbmsnSyhHlPeW/tgFIHabEOGMtc6PW4Q9lW6YEEMmTVJqPaTsX4Z5dF0GV
	 hH2jEKa15otiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D20004065D;
	Mon,  9 Nov 2026 19:44:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EEF5A335
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 19:44:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D4929402C8
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 19:44:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eegvzMA1QGJ2 for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 19:44:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 17D21400CC
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2a; helo=mail-oa1-x2a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Ff8VUo7e
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 17D21400CC
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 19:44:49 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-451a49abd8aso1260246fac.3
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 11:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794253489; x=1794858289;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7V0A8C96Uc3ahxclbmJOGx6i+uS/lywvyKHaGH0aExM=;
 b=Ff8VUo7eNEbEMkhCly4N1sfLp/AusgRxaOXcqfm5Xq3+K2oOZX1S+a54a3uk0pZdyx
 idVWPGAyzcrvIUr4oF6iFPmBZ/gCabNu+MVRS3V/T9GZbUL6a4GpkHv/4AEMWySLwFvT
 GUhPCO+pPWIpNvev1uKK01YFF0uVS+LXRsSt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794253489; x=1794858289;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7V0A8C96Uc3ahxclbmJOGx6i+uS/lywvyKHaGH0aExM=;
 b=yF7lR32lVuxbwMGpQXQXS5ZfY7XQaR4KtD2ywET5kRZIHiMClXdlUC/J0PkAARMVko
 8NCBIIzxIsrwWcrZBXTdVrvo0s8+dJYl2c8mRDQQouhS4OiHfdsXPR8vCj1frHNWmWj2
 61jAu/dBP+2YhWxnWWGT2uEKYY9zr8ZaNFIHL58nXb3mhE6Vx1RninA/ae0HrGjjxwpY
 CA+icsiLbxxnLmOS4v10iWKYkGTFrLZ5r5rpCVMcYvfj9xp8q6iK0Emk6oX2XMI4Eewu
 7SHKF+bHcQpvEDpaZA8M83zf8d+xIV6gfj7V32UTJsKl010D1BPtcsxOln5770VoNOBe
 7fvg==
X-Gm-Message-State: APuU4Z9ovGYnmx9T1eb+gCzXzfqhY7oL2DMCtzrCeZT1Eoq4Qf2mTRRl
 5lH4OM6xAT4+rOaBZ2snehAGhSO4XAgeLOhiffcFyNYL1CXsiyORpNyieb9DZKu92MA=
X-Gm-Gg: AYBFou3CGUromnT0mHqla+gPK4264ALhOhK2Woph80GXrBIdgGuIMZcPNRlMpiwQTPG
 H+/0jYZR6EXyZsZ1HR8+LOgnrAl56wyznuEUFQGi/HixZKpE2EUih5S5D2ns7uPxnobfBwenlWo
 2rBO8ja4XAQIbeOleIjTVEZ2hzp9qcRK7e+KASqR6149wayXFiGFwWQuwUVT9aHI60hCSYW7Xr0
 ny1MizIvTOc6FdoPcqPhjf8OmU6tJhnh7jWS6OblQurhITkTRM+8oTJPJ6f8rAWywOyZeDZLruJ
 j2Tcwcey4PzLdomjWNhOi+Buj2lVTC24rf6IeLVSPTzzmH1Jul+GdmHnKb2UfxYtlMZX3Iq28dr
 THJgfRoeld7osaWNri6IXcjSi06GS7yBWEcdtqYTn/vlaDrhn7BtVseprMslknzJhdCatY8NGeH
 ZaI9/GIHkLuNWKV3R/ZklMI3154IkfAVkTcq+OePIHvlgduTy1KXvoCaHxo8NmJeQ8sHOMzXAKU
 +5mgyXMGB0stA9YVXEdiIQxFfIzz3MIIMPWpFFLJ0G6cigLVl8cP7lfsDXaotJO0bSQEsQNaMnC
 nWwYzW02gmIuLGy0txN6NVb2hPWls57pWV1QpnfdnVX0x8PMnrLbYDPbq+mtdeDLKVvL5+3SKDy
 di7Hpk4Cf/gJqVduw2R31IzqYvxUXPQzQv+vFPmVf7dY+afxOfW/BHrlo0jg4HW+3Vu63oy7Yfz
 AZqDlY+AxR7sEuJQfrzcg+v8AuMVeTYg==
X-Received: by 2002:a05:6871:73a5:b0:4a2:4e0c:593c with SMTP id
 586e51a60fabf-4ae22668d4cmr106762fac.33.1794253488608; 
 Mon, 09 Nov 2026 11:44:48 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4ae2302d8a0sm49893fac.12.2026.11.09.11.44.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 11:44:48 -0800 (PST)
Date: Mon, 9 Nov 2026 13:44:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Ana Bobillo <anabobillo3@gmail.com>
Cc: u-boot@lists.u-boot-project.org,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Jonas =?iso-8859-1?Q?Schw=F6bel?= <jonasschwoebel@yahoo.de>
Subject: Re: [PATCH 06/11] video: sunxi: de2: Tell the display the frame
 buffer size
Message-ID: <20261109194445.GX3741582@bill-the-cat>
References: <2399d63c-ddd0-44b0-bb81-d5d9d2a8a8b4@gmail.com>
 <5e2ceb08-8dbd-48e7-acf6-ec30f5ccef0c@gmail.com>
 <20261109182108.GS3741582@bill-the-cat>
 <CAJnxHshjw219nNuA5S6PuC1L=3Wmo+6MyFzcGjvbkjv_K99GRg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="N0utrG1f5OT3ag6T"
Content-Disposition: inline
In-Reply-To: <CAJnxHshjw219nNuA5S6PuC1L=3Wmo+6MyFzcGjvbkjv_K99GRg@mail.gmail.com>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--N0utrG1f5OT3ag6T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 09, 2026 at 11:28:48AM -0800, Ana Bobillo wrote:
> Hi Tom,
>=20
> On Mon, 9 Nov 2026 at 18:21, Tom Rini <trini@konsulko.com> wrote:
> > Here and elsewhere, fixes isn't appropriate for populating newly added
> > fields.
>=20
> OK, I will drop the Fixes: tags from 5/11 and 6/11 in v2 (7/11 has
> none), and from 3/11 as said there. I would keep them on 8/11 to 11/11,
> as those change only the driver itself, with no new field: the sunxi
> DE1 and Tegra HDMI drivers check their own frame buffer limits, and the
> Rockchip eDP and Tegra124 DP drivers limit the lane count to four. Does
> that sound right to you?

I'd have to double check, but yes. And it's some general feedback for
all of your current series too, so please go and check those as well.

> I will wait a few days for comments on the rest of the series before
> sending v2.

Sounds good, thanks.

--=20
Tom

--N0utrG1f5OT3ag6T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavIiqgAKCRAr4qD1Cr/k
CgU4AQCp6EbYuH+7PRQkAELc9MeHg5KHZx5E4CQTYKHEepbfwgEAiBTzeVrrRW+/
+hPK9/77NSszyAFOYN/NeFaYppFGPQs=
=oYzz
-----END PGP SIGNATURE-----

--N0utrG1f5OT3ag6T--
