Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CBD0CDB474
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 17:51:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FCB1874BD;
	Fri, 20 Oct 2023 19:51:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cxKhvDRX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B091874B8; Fri, 20 Oct 2023 19:51:05 +0200 (CEST)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A288874BD
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 19:51:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-d857c8a1d50so1076784276.3
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 10:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697824262; x=1698429062; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MU4k8hg5daAPX8j758+IqIZlNDXAxegQo1iLKkw4BBc=;
 b=cxKhvDRXgrid27KlBhGMo18D/YhdZxwbaQJeMg54MO0OaPN2woTFPhfaIIEcK86XsT
 TI0Xt7nRQonNXX43Irnl81/d970+nREopjTtK2Dz4uz0qeMgcjgvOuaRXLC2x3N3iv5v
 okit+V9PMQjSFAyZUtbuPcQdXabmfXc5pU89I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697824262; x=1698429062;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MU4k8hg5daAPX8j758+IqIZlNDXAxegQo1iLKkw4BBc=;
 b=d9f3+7DILVTA3pnSxV1ILE/bs//00oiNIasdMaDdedXbzDGwY49T9oI9McS4i/iI6d
 T8kO06JxsXekSoQ8ZccFYI/l+0nHly46fBixgIvpBfsAG6PNa5UhdlSu98lXeUfvSUUK
 LKXMR1cyhdMslYG9S8EBB/Ik3zckLPeno8eIoddb3X3sf1LtnbYlnK0sfzrWAhE/zldi
 Jb7TkUCuwGhxgRmX27eAXrowXOUw7m3QQ0YQffrLv93uBns7jXX/hCwXS2n9lrFm2+wM
 t1pi08uM3blAFwA5plNW0wHG2PL+8IgUl3toc5bGGyIgZGyihLqChv1Sl7Oi00XYQWZI
 1bwg==
X-Gm-Message-State: AOJu0YxLd5Ds4/NM3QAQn4eNTyQrlCI75fTfzqmQA6/Rljg7OcxpdcWP
 4Sgzmzk1+ALHRoDwnfEPgTkFBkqZFGQScNvwXFRrEA==
X-Google-Smtp-Source: AGHT+IE4ErDGZIc4+1POnLNxBjdw0DXA/ysCicjpAryWXrYcXAd0VFKjOgsntX2g5oFc8WJAWI2cnA==
X-Received: by 2002:a05:6902:1243:b0:d9c:aa4e:47e9 with SMTP id
 t3-20020a056902124300b00d9caa4e47e9mr3175414ybu.8.1697824262110; 
 Fri, 20 Oct 2023 10:51:02 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 b136-20020a25348e000000b00d89679f6d22sm700859yba.64.2023.10.20.10.50.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 10:50:25 -0700 (PDT)
Date: Fri, 20 Oct 2023 13:50:10 -0400
From: Tom Rini <trini@konsulko.com>
To: Philip Richard Oberfichtner <pro@denx.de>
Cc: u-boot@lists.denx.de
Subject: Re: [RFC] CTAGS prototypes
Message-ID: <20231020175010.GO3119521@bill-the-cat>
References: <20231020104606.23305-2-pro@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qVhkccjAy0usq5Di"
Content-Disposition: inline
In-Reply-To: <20231020104606.23305-2-pro@denx.de>
X-Clacks-Overhead: GNU Terry Pratchett
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


--qVhkccjAy0usq5Di
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 12:46:07PM +0200, Philip Richard Oberfichtner wrote:

> Hi,
>=20
> is there a specific reason why the ctags make target is compiled without
> using '--kinds-c=3D+p'? Maybe it would make sense to (optionally) include
> that in the Makefile?
>=20
> I personally find it useful to jump to the header where a function is
> declared to view the documentary comment. Or am I missing another option
> to quickly get there?

To answer the first half of this, it's whatever the last person to use
ctags related things was.  Perhaps looking at and syncing that part of
the kernel tree would be helpful?

--=20
Tom

--qVhkccjAy0usq5Di
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUyvc8ACgkQFHw5/5Y0
tywgqAv/cZywino9M+6udOSs6iKS3IHPGWO1haUMP8vKtFvLyd+v3qCybHXBY1i9
b0ux7n1xwFKfLZ3J3L4kTv+B3Y6keBXtV5noC/kylj/6sLcNT5NMv990i6XXRWud
3K+8O80yeGGf4TqwKeq+jMQ+MPZMlUhMwzaDQjtZwSYPp6oW9bt9k+CQNgwbkasg
M4iwujc31wNFJyhmAwDJLB7de282w+5icxq9VXAIpW7S2TtwclwGoHj218pO/YEs
kZGjBvIiDxaV3caK0JYyDfc0td76UvWBRkUsDdnNvqg4hmSWYAfOuKiKJ6hgurZG
0mYDMmZDTJJAQIoeiF0ChC3S6V0a+72vucAiuA3cOBbtNGGg6ZtGmuLedfAGlMfE
LAtNaKCflDomvqm4C4wPs0PnEojl5ud+6Oyg66laAk0CkT1+VQFP4it4BpQlAVbT
ryuYQFrxMbvIifi4v3dEhuLk7eK3TOxsK7b5rVzD6dbmwsfdRkoP/jRrZmzPguOB
NCd4M/LJ
=J0R3
-----END PGP SIGNATURE-----

--qVhkccjAy0usq5Di--
