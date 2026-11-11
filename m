Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5BF606A332
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 15:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QRMfPTAD;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Xm3W5f/t
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8CC3F605FA;
	Wed, 11 Nov 2026 15:02:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kZZ77K5gfo9K; Wed, 11 Nov 2026 15:02:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E8F19606DE
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794409377;
	b=okq2cViaUSlIPttL1ZrtRE19DJD4XdzrZ2e/XqEx2oc5kLeCbOlXmLbpZKU7c3ai5/6k
	 w4qbtznr5zpco1Ra14eeA83zvRShbmQLlxMyUr/EZLS2ARC/QR0aiQIQ9r216892xx/E1
	 Z8aLW5BoP1mg+x+BOUTzEkhbWoyLGUSDEdXRbVJR2LSNjrOj3XDivPPVEFe0VeQArGNwM
	 ZQBaU6zA+pLmap672Bm4f1aVz8UPS+oacllnvUjyvyPWFbeSGKgB24483CAo6T/9aMcpo
	 qEIMW37agWCZTCvN6421yZgu0RjmYzqmWPnUe2a86DASL2BvmM6oU6KuozIebB4A0iQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794409377;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jdcfBaHIlPO40U3kJDvzr5JUeJAo2hvC47my6DZd1s8=;
	b=Ri10UonVp6ON3qUnpK2hjZwlIxYZqrQX1QhRt9JmZgP01nKGOzAFMTLzCqdEePfI9MXl
	 ZuclOh2SC1uQwSh9NKPz7KijHf2O8foifg8VsVgMl1YCTtuxytFdYuurJr2ApSAYXK60i
	 4YPbSP4w+D3FeHqGoJEcYA1rlot66QxnQVLOFfLHSR/8LmGtMEtpU4eCXbMrDIO4JW4oM
	 chbmdz5KEMI8uXwO6r5o0uFtG8IMsFU1FxFgGEBsqTfwehDuH2+GFNuecEDtH0NeEHfaL
	 7dMV7NXthXREPLJASRk7meoq/8R3H/vSjuaZay2i/IE6JyueI3mBDr+bKFfzC6JBM0A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794409377;
	bh=jdcfBaHIlPO40U3kJDvzr5JUeJAo2hvC47my6DZd1s8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QRMfPTADyXedHsgc50D5oZM1tQ5gVAUpc0NaLi5ckcgmEq+e4r4FYo5wRE53UIG5R
	 yFj7OO0HyDt6pbk6h1Fconge5W1jiabSiCmHcO2WnMoPxZjmBe1tUqdnno95WpGm0V
	 ZUs6H0TSMRF3VQ9SWcqmeI+OZO15R9NUiOMKmp8UYwOPS9OE37pGR5E+ZDo1l/W9j9
	 KkCc/nKWfD1CZi1v/AAXIbjOxkZk8K5GbMF6LhC5dLuEsDP9trcgGY5uKuWRt8iqeb
	 YKBZ/rTc3nC7BCTUJepRXTMXHSHwExogij7CDDJKr/ZshD2GS8zpLbxl/DLOunvSkn
	 DNOyG3jmHOy6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E8F19606DE;
	Wed, 11 Nov 2026 15:02:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 18BE7335
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 15:02:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 01D40403B4
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 15:02:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VW2kNAN7yWev for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 15:02:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3DC4A403A8
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Xm3W5f/t
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3DC4A403A8
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 15:02:53 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-84621d8c7aaso1503557a34.2
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 07:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794409373; x=1795014173;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jdcfBaHIlPO40U3kJDvzr5JUeJAo2hvC47my6DZd1s8=;
 b=Xm3W5f/tLPQ+7sB8vxqOf+y12DKMcHjZaqnsUsHEVZEeNjp0aca5d/M2kM+qv0jjaG
 y0EoV/4A25P51dHMN2r/Nz5UOGmS/2inEhKD/6nuaGmhnEFYdAHzQDNKDBIiqZbgNZ2W
 EiHAWhfPyprvv31CzO77C1UPLLMxSU32OsyDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794409373; x=1795014173;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jdcfBaHIlPO40U3kJDvzr5JUeJAo2hvC47my6DZd1s8=;
 b=ltlsryPVCKZrm229J2YoqMx7auGL9eH+AMzCyO6V79fx2rEggFiv5FzVlejc5+etcD
 5u02aSbeVt5APc3drowR1J91p4Qdl1NkkBPvdm5sh2rZDAtjVvawOPM5+fEISGEg45Js
 niIBURk0PTkycN0RFMiueKn85CyD4pmiqAMM8gd2gJqpJe+8bvr7RzX2BVWZmKRgT8ZU
 XxtlEfHglQdbgBbcnoOc6uWw7/byAklcdv45BtOZ81H2mTUzC2pBMzOhljreJyREvMiq
 l3FBfm9x58AvRr/saL1+AdNIuftVyV8Rfg0zkviamNOTkKGFhf82tXRLrzg02GDzG6Zy
 HfFg==
X-Forwarded-Encrypted: i=1;
 AL+hErF0QaPx8XZEkgg+LjJxP5LEz/9I2AyZza8cDR3HnY7M+k6Y7p+cJ/bvg1sZricITg9f2iUcSCo=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/wFpGuXqHnEgVQ23XgKOKhAHKiQmM9z8xXOzMBd9gL1g4U5T/x
 4S9rZhBuoeaunMhrM9aXsw3S124NzUSbv8Hqi1MgGXj/HPZaX0Ciy4DsRJC8Nq+ILIQ=
X-Gm-Gg: AYBFou2H8DX2ZeTNumG4vvIiVgeY/kXbon3DF0OrpqnKcCSSaVtReJB/yTcJi1vqUpk
 H5RGCnBxD1TfSofF3OUBasimLtjbLrtlyvuG4ufHYNSTl94pWG7qR3VgRyb3mQiJukvAUrXxaME
 d3DXhUzaZq8SSEaeZEyTuzrXS8vfbBgkLF2JuUiPVzXiTUC9NByWu9z9OlkMPf2Z+d7t7xN5Va9
 esjqaZ/L6IU16uEKEoVervkxv3EAi55qcYdeYSdY5kiQPMZFwC58ZBirtw9xyMvXA2wZJHHT0Ai
 VNJCmlkRrbiIbs1UjfE50cFd+TH7P3+upheJA0WvayNBjT7re9k83SLKz3F7zn4songoMds+9Uo
 v35mQFvtQ02TVRbbC9lWkL10aOXjhX2qcnhZSCrDJ1qECYf2RcughB0ufCqKbQ7gsWalluCW1aI
 81bP1u/ww3B58MMFtx9xfWezx88s54H7RCppt/Z4k+o6gj2Egd9rcaWB4GCz+uUXm89YdgB07Cg
 Qt0TbO5QJHej3Lq6Nk6MJJoF0OzkQ1bi0MlYIXXeJZyXxLQYRcZrVFb0URD00s4KC9lnjDWfoVh
 PQhhbTtirVSlNjx7D4KFpyRc6PnT+mvb2qyzDOciXJIXW8U4VV22UkCIbc04RNMGsr1yVouCLSL
 ThTqq5A77KFk5bXKgkafgEl6P0ypfIBVs5oQuEh9iWdvJUnyHPeGmBzqTubPUd7c0Nd6+tHjQaj
 hGwY7QIZF8WRvk9c3tBICuxHoGlHfDOtM=
X-Received: by 2002:a05:6808:c1b0:b0:568:3866:d1b5 with SMTP id
 5614622812f47-56b97c19540mr1916871b6e.46.1794409372618; 
 Wed, 11 Nov 2026 07:02:52 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-5690504e7dasm5030517b6e.5.2026.11.11.07.02.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 07:02:51 -0800 (PST)
Date: Wed, 11 Nov 2026 09:02:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Yao Zi <me@ziyao.cc>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 31/35] dts: support applying DT overlays to the
 control DT with OF_UPSTREAM
Message-ID: <20261111150248.GC255403@bill-the-cat>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
 <20261107143241.2236511-32-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TrzCKxnL4NbXUY3k"
Content-Disposition: inline
In-Reply-To: <20261107143241.2236511-32-dario.binacchi@amarulasolutions.com>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--TrzCKxnL4NbXUY3k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 07, 2026 at 03:32:21PM +0100, Dario Binacchi wrote:

> Extend to OF_UPSTREAM the support for building the control DT by
> applying DT overlays to a base DT, so far available for the DTs in
> arch/$(ARCH)/dts only. The upstream DT overlays to apply are listed in
> CONFIG_OF_UPSTREAM_CONTROL_DT_OVERLAYS.
>=20
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>=20

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--TrzCKxnL4NbXUY3k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavSDlQAKCRAr4qD1Cr/k
CnK/AP4p0YhZNmzp+n5rUxHF6N/yE/mQmTZp2AEdqU5tJOPQ+QD+Pyacx1SOjV/M
ET1/mWFaHskZEXeqH7dHarWmn9lHVg4=
=Cke+
-----END PGP SIGNATURE-----

--TrzCKxnL4NbXUY3k--
