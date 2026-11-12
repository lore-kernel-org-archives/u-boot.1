Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5E9606CE7D
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 14:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZBqUrfBq;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=qMdfxuBi
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7269640D08;
	Thu, 12 Nov 2026 14:31:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7kHIxMgFo0RS; Thu, 12 Nov 2026 14:31:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 903A340A35
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794493902;
	b=ooygyi0X94DRU9ytfE/00FrmW58SBrGpkT8FFmbM17F1gOVN78zT5D0YwqrZXaK0qgYE
	 OCOO3cjA28zCLo0722YxJJ4jov2rQhmy8KHrHCX4pek+6EiblyBjdY+NYqs08AnPiHQbe
	 ppgjj5zM8vzfuDWDRdz1xmfhL8PPj2cKSJwwX3Km7Y+cLyLp77AvuYEKjAhbGchjyD228
	 /62W5eqr+Gl/LGakxKz/ypOsS68ndg+/bCdYNaetKawnKsCP1NOybHts71AKbVjgKCQFA
	 srHCL8GPHattDu2CqY3ll9LTMPlWpGA8SH8IsdTXkux0omBprRXt5htmLkdXiOWu2Qw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794493902;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0Pdf0q6uh24bfQWtKTgKEZ6GvZ+AP9fJotcB9AB88jE=;
	b=Sgxr0bAXCUa/InaBtE//LGQvF+P20N2saUUHjjXueoPua4TRiiXSboobM2kSGN4klsnq
	 s2z/bDBlTGEC+UadgaZCbAXwf6P/N05CgVRcaG6WDdt+hdU51U/Olone3nFCUp0kgI5Xu
	 gIOojYDfketlitYI3TrwbVgwDxcaxudFnuJZ1iXzQZWC49BWL9Pib/63xxyOBhWmWWCXz
	 BpA19+EFlCftH/faN+iesGgLI9T6HfM6q80eoX1IQIA5ELZOHXnVY1N/eIm5lZiJB7XoU
	 uvZMD86i2Y+EO/t/+asoCPdyorbCcWPl6PyMLVdnB5rmVxShbEzhXZqZdoVaR7Pq4IQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794493902;
	bh=0Pdf0q6uh24bfQWtKTgKEZ6GvZ+AP9fJotcB9AB88jE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZBqUrfBqgzN5Qw3ySmLlHN0QA6vV6dPxDDP06+Cb5disC72VtvBF5uHyGx2e/+Pyu
	 wOXYBVgPd8VgRHRLgAyUFu0gICqkhGOg3SGnxuJU54PvZTbWB/VjTp8EAnqNyMDaCG
	 UzEEUNaqFo9K1oIa5v03waZ2Y6DFrYNcw5GCbaaxWnL7+W3XcBtmaW5gfu1kJiPxz5
	 si8GfH3zZvLLpgPVPAhTM9G6DRdxLgSjDJuqf0inUd2EGiLlBK2PmrBo1PHK4P5Og3
	 qnv4cc63SFC1lX43v7Hgu3Ul/l9PzORwo96tZFsZrKuw6AFrBw+6xdV58SHL8FJ6a4
	 Q4B6mhtpF/Cew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 903A340A35;
	Thu, 12 Nov 2026 14:31:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E6CF2235
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 14:31:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D8679400B0
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 14:31:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JqBxxGFBoIU3 for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 14:31:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C8019401E2
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::9"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::9;
 helo=mail-oo2-x09.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=qMdfxuBi
Received: from mail-oo2-x09.google.com (mail-oo2-x09.google.com
 [IPv6:2607:f8b0:4864:31::9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C8019401E2
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 14:31:38 +0000 (UTC)
Received: by mail-oo2-x09.google.com with SMTP id
 006d021491bc7-717028b412bso1636599eaf.1
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 06:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794493898; x=1795098698;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0Pdf0q6uh24bfQWtKTgKEZ6GvZ+AP9fJotcB9AB88jE=;
 b=qMdfxuBiAlIRsr9BFKwk1XMQeA77ep1XGlw8bMgFsJstsXyMabTOYzXCYuSIBAjxe8
 PUnqL7rg49eAcfN+pHHn/66eCS0wPhlFPsEywYSASmDT0CMBgrPMJr1jd1SiN2wS6/+f
 NUQ1h107faPYb5D120hfWWUubXIPNO50dnndk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794493898; x=1795098698;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0Pdf0q6uh24bfQWtKTgKEZ6GvZ+AP9fJotcB9AB88jE=;
 b=T7hMShBCWnlcc+V05POejNZlL5tu9GdGyFB0Lq87D+UBcS3CDhmznvUuLy21tVbw0z
 zlCwwRLbu6s+g1Nw1pOfumjjWJWIr9UdkmXb1tonomsTn0T9MojFBlCvlAKKkwPe7oJY
 Xb7dM1kjBO6BAIJ5JLeyVyLQ9lqvFbMJUttWVZMgw32z16tXvalucH/9jWLIk7gwJv7W
 zYkftSnj2rVTjjce+Rrl9PIVanwjSuu05Y5+Z6KR773hJ7uMRjcgPy3DMShZ+WYs3vLC
 vNd3JfeFXRruRl9t1+bbO9rQmnCdt4vuZ4OwuYwqeHieVYAFGO9c/wYdtYWHUymBHteq
 UYpg==
X-Forwarded-Encrypted: i=1;
 AL+hErF/x1CDxLi/63MJXMTedsABQvV8f+VaWberRHtF0kLYdwnCp6dDSWHwJ9X1YV1IkttM1eUiUog=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8ej17MaGGygtNTG+1V/evexbypaU5wSFByinuqW/s35JnDiTqU
 STzfLeHGciKcmSzRUgO4ZDNnjzz0btm0VWv3UmXEKJ86EgfUoW05CohCar8eWJzEX1D9mSTZBJf
 /kWSmWfC42nYmcuQ=
X-Gm-Gg: AYBFou2aTMLPq4rerr3psprmdLXqwCEueTBXD9OkwLlfsve4qNjXokMfFvZFkZZsV8K
 3ELlhDUP0dtSN3sY+MYCVTbJ5123asWZ7ST4xXvi9spyXRHPoqn7OhrqYfOwfQJgved357ZPw0W
 Afvf4xP12gRL4XT3nwHxtsPYgcKKhwSiR2VyIvh+6CIR/EaLHYFJBwsoAdeIcS9lU2IefiKHYPb
 ODBy2icXvHRbuXpc6yRu+PbeW/LQzf+rt99OSC6XGXr2pSppR4TPqEsUcCJP5LXTRkWmaPyfy+8
 kA5kiXS9C5RXyDzxfL6F3XbeoqR/qFaCk5EuwlK5PelK2bsbc3636C5hGJ1+2jFuGsu0hHABnwU
 JMUsT9c1GBHNeEDxlz1PdrzmjMALFIHBOyxaYi/Dg2eitEvqnJy2QSWonYB2Mg5QzTI5IPkwXr8
 hv6uG0np95aDZtYEuHCL+WdFv+BpOUKz1avk3fnewdc6Pdxqz7EOGoDERM8/HnZIL/b/008LbVr
 TaCt3gmWbLWMGBSwElieHb1AsOT5xp0mt3wYrE0Lu97IMRfM6Adn0gp9k1dYz1XQmZY3tUwLcwK
 /kSuyNUYMRn7UqCFoDZaJeykh6MWHmpr2t4fm0+rpBB07txA5GjLX0F1fJKyPWPbo2QHooZjzmD
 +iMBZjQwtkpONPeg/YGyn7qHG61XV/txcJF2zf5wFa9TW/OzDCG4bLolGN/i231L1FJRJdDrcaY
 wkuEdj+EnR5boQECYQRYCvhkOaYW2xNB0=
X-Received: by 2002:a05:6820:338d:10b0:719:150a:4369 with SMTP id
 006d021491bc7-71917927ca0mr2718381eaf.50.1794493897748; 
 Thu, 12 Nov 2026 06:31:37 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-71ab0ee4441sm40874eaf.11.2026.11.12.06.31.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 06:31:37 -0800 (PST)
Date: Thu, 12 Nov 2026 08:31:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 1/1] Update maintainers and get_maintainer.ignore
Message-ID: <20261112143135.GC554944@bill-the-cat>
References: <20261112115842.39126-1-pbrobinson@gmail.com>
 <20261112115842.39126-2-pbrobinson@gmail.com>
 <06aa5a02-0f60-476a-abab-aa3de9ad6019@cherry.de>
 <20261112141428.GB554944@bill-the-cat>
 <45f6a190-79ca-4eae-9291-8522307780ba@cherry.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6O5JHcvImXpq5m8f"
Content-Disposition: inline
In-Reply-To: <45f6a190-79ca-4eae-9291-8522307780ba@cherry.de>
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--6O5JHcvImXpq5m8f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 03:22:55PM +0100, Quentin Schulz wrote:
>=20
>=20
> On 11/12/26 3:14 PM, Tom Rini wrote:
> > On Thu, Nov 12, 2026 at 02:59:35PM +0100, Quentin Schulz wrote:
> > > Hi Peter,
> > >=20
> > > On 11/12/26 12:58 PM, Peter Robinson wrote:
> > > > With the departure of Simon update the MAINTAINERS file
> > > > to reflect the current situation of various subsystems.
> > > >=20
> > >=20
> > > Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> > >=20
> > > I see we're updating patman MAINTAINERS entry to Orphan... weren't we
> > > supposed to remove it recently? I see it's been moved to Simon's tree
> > > (https://github.com/deinde-dev/patman) so I guess the "find it a new =
home"
> > > part has been done already. Is there anything missing maybe or can we=
 start
> > > cleaning things up?
> >=20
> > It looks like the MAINTAINER entry was missed, and yes, should be
> > dropped in a follow-up.
> >=20
>=20
> I see we kept a few files because of buildman it seems? At least that's
> what's claimed by 91b94aff149d ("patman: Remove the patch-management code=
").
> So maybe there's still more to do.

Somewhere, but not high on the list of things to sort out, would be
seeing what git libraries for python have evolved in the last decade and
if we should just migrate to something else instead, yeah.

--=20
Tom

--6O5JHcvImXpq5m8f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavXNwwAKCRAr4qD1Cr/k
CthZAP4gBiehgUS+l1r+XVNppcB194PYERRgmwNYt24e2Hbg3AD8CmexPMsWwM9n
ODwPczD9NbsMwYxozLNLHvFARXponAg=
=mGP2
-----END PGP SIGNATURE-----

--6O5JHcvImXpq5m8f--
