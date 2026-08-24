Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97205C5DF9C
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 17:13:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5F0A780E72;
	Mon, 24 Aug 2026 17:13:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D617d3RbkJMF; Mon, 24 Aug 2026 17:13:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787591588;
	bh=vxDO0hKBK7ryPDhG/g9U5j60AidRH20xc8V/aTkNPj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qYWwapceXqISro5XKXx8CuY/zRWr9Vk6GNr6sxJKBuWz4sypqtE+n6HDVFZDe2gy0
	 ufHJMnDFGJPYfT1+D1o8rEExAzqTasWrQ3OlXWj5Fi4Zx8aO0ldwQ2ETjZI1SnGnAW
	 tGmvacMGZOBNoWcQv5ajZUvLUcuJTri5QPmv0qGOIifuqEpFamJnzhrA5WGdgY8WiN
	 1Ecgw7kLoU+Ke+9uoVly8eIN2T9x5CVHsRvfWaEMnC+S4t4y303F5OcqUaPivYRgfq
	 MJqnVBxaM2vgzOhTvetdPW64VHaAE3ZlNRE+9V3MvMZsytxZIcNhWOyvS7IKBjlRLL
	 XWFRQpXVS5uwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2E2D780E08;
	Mon, 24 Aug 2026 17:13:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1CCAC41A
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 17:13:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0E8A56064C
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 17:13:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dci5SCnC9b1i for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 17:13:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::32; helo=mail-oa1-x32.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=FKjbs56O
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 479CD6062C
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 17:13:05 +0000 (UTC)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-43b7e186a0cso1510235fac.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 10:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787591585; x=1788196385;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vxDO0hKBK7ryPDhG/g9U5j60AidRH20xc8V/aTkNPj0=;
 b=FKjbs56OzZwjBG7duUUIfUqxvg19wztVHP/IxuY0oRU9uM2yeH0Fltz66Na6Uw8Z3X
 7/9BKIvw+PpahnbyvN88RjV3zORrZhXL2Mx28vOqXkw5U/JygIurG035onvZ1+p+Ru4L
 0x21GlKT9BdOyUquAKC+Ts+5igjOgRCAQF92A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787591585; x=1788196385;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vxDO0hKBK7ryPDhG/g9U5j60AidRH20xc8V/aTkNPj0=;
 b=HLImzRQXDe0IPkb5/qA4yaJER6gyLHOytu8amjueRqyR6v97X2SZt1ZQjnejVSeads
 yChhcam9QuYqqoOwjXndmPiSPPtj1oxjvVFUyRcHmYchF0s5eVcHaoJBDKGWcDpnjRmw
 bruNjCdEU3Brkl2kDh5Y63rrMKOYQ7XmSYMem96QcaZuEYDmevcxrlGxI3WRbZV5ztKZ
 wt0VupHtNP1Kpawp/bk5Faf2u/pAvtfhaRHMNNnafyLsvFeDjNwUgMRUyd7fRjjgpma2
 wgWBF1zhu+dKRAtVO6CDJ7EK4DFLiqzBuerbOtsH0dStOSURuDfB6fg7b+772XRcWJTE
 3hEg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqFWLeJx2vI0mEmfM8j/OIJ9R/vT1A3Q9ZvK/IQdhUQN7pUhEkdEYdIcO6ivuk7b4CXkt//JxA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mihDuxOBkZN9qVr/mYcNbhMU+AZrI9QaCWWJ0jraeYPoc4oAgI
 /NCam/D6VXzbJiS5YiB0e4Fs9A96kmpwQZY+xg/lds0DadZi7xEzUV5dzrfgG7fy3Hs=
X-Gm-Gg: AR+sD12yhtAdVI2EBYLXmVpAfWjT1yHm6csaTpfS2/q8EOapl0KF5pGWLySmbDz2D6n
 NOWCBu16sSKaWN7pc1IDZNMpTDSVKAaKmzFg3olmMm4Aub4shdsT/RRxSFWhEc14zXhvtCmo4YY
 cC507Re2l3O1YkVUlsQU48GZsnDxObibEKrYHPxBqyW2lX248q5VRxKy3W01Jk58YJkspGNDk9E
 iIcxK1rpQNbwgHosragsfrn0k3F2+w/IVykz+3flzrhvtiNQjuZ4cj0tN8EDn/IoYhWD+1hJn7y
 FAoO0hX2izDqkJF0iAFNsVO9CvtPXUZIq7b7eBEz/poCq9YtMqiEwcSNjgVQ6sN902z5P1tEkEC
 mvIamTpiLcKySfySwdy/GuGhkjW10jN3d+qzTYKAv7mbH8uOB61Hum17g7lvYz936es/TrlKg7i
 ghGITqGcR/PQvkFzNDJr9fX5+Y6qEwF5SVRb6pCYyD42OJSXa7YgQJn0Jfe1Hnzoa1oqxeVcZIU
 odLeBiR24PHDkIdjS1YeOYAQO0+er2oChqmSJ9Z+KGBCUK4P94LfnVylN1qMgoEeJK7Ubb5YL4t
 uwajZ0RwcQ==
X-Received: by 2002:a05:6871:3841:b0:456:9b53:c6b5 with SMTP id
 586e51a60fabf-4637fd7f2a0mr18300669fac.13.1787591584649; 
 Mon, 24 Aug 2026 10:13:04 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-463834af092sm5941870fac.10.2026.08.24.10.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 10:13:03 -0700 (PDT)
Date: Mon, 24 Aug 2026 11:13:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 David Lechner <dlechner@baylibre.com>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Mikhail Kshevetskiy via U-Boot <u-boot@lists.u-boot-project.org>
Subject: Re: [PATCH] pinctrl: airoha: sync with linux-7.3 driver
Message-ID: <20260824171301.GK523975@bill-the-cat>
References: <20260809232726.2436904-1-mikhail.kshevetskiy@iopsys.eu>
 <178749706837.206448.895471974507405553.b4-ty@konsulko.com>
 <14ed312c-ff15-4d66-9074-35769a65be42@iopsys.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JVnmLNHdCdwTLBHh"
Content-Disposition: inline
In-Reply-To: <14ed312c-ff15-4d66-9074-35769a65be42@iopsys.eu>
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


--JVnmLNHdCdwTLBHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 07:15:01PM +0300, Mikhail Kshevetskiy wrote:

> IMHO, it will be better merge this to master branch.
> This is mostly bugfixes of existing code.

My thought process here was that if it wasn't "fixes" enough to get in
to 7.2 (which wasn't out yet at the time), it's fine for us to wait a
little bit too.

>=20
> On 8/23/26 17:57, Tom Rini wrote:
> > On Mon, 10 Aug 2026 02:27:26 +0300, Mikhail Kshevetskiy via U-Boot wrot=
e:
> >
> >> The code was synced with linux-pinctrl/for-next (future linux-7.3) bra=
nch.
> >>
> >>
> > Applied to u-boot/next, thanks!
> >
> > [1/1] pinctrl: airoha: sync with linux-7.3 driver
> >       commit: 2d379a529c257606946831a6dac1c37de6a3f8c0

--=20
Tom

--JVnmLNHdCdwTLBHh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaox7mQAKCRAr4qD1Cr/k
CrZSAQD9uKa5usj8jvJ+pgBu4Yfa0kWAuvwxV01XXXf6cup3cwEAq4P9XjpllQUo
i/G8HWJV73MUM5bnheCI3znmqsq+ZwA=
=yqHk
-----END PGP SIGNATURE-----

--JVnmLNHdCdwTLBHh--
