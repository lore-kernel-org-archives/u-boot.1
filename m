Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC54606A31D
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 17:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pZf3wZbc;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Iq+s9D/W
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 05A6F810E3;
	Wed, 21 Oct 2026 17:40:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wgo4yApwTj_E; Wed, 21 Oct 2026 17:40:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D1E9381027
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792604419;
	b=LimRnm6wrxa9b2a1jjz9/x6QPBxdzO2XX8LWsWUanWpkGn8SYkIpMVdVpfMabhXh3Z97
	 6NdAUZ9nFZGRdP+E9Rp3BERpvoAAPloZsQ9m4guXw6hjiILJUJqbqybEVJqnPI4sX6uWz
	 0+1AS8vTa2hhSS4PYiudRxJ9oOiqWDQBB3f1ig072aWcGQnk2XArYI/pMky4iq587re4a
	 2zTLEP3L5Ox6iJioxAEWX1cPuwIKQrm1CLBb0xClDA4Zso9tDCGX93R4PBRZzyLP42+rf
	 UemnBr7mnAqmlnpBjfif1bzTU8+k3hRIuDdWF2pYOyRnkKCUK4v9kg8XRDun45yQpjg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792604419;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=zta+qWUYBYoy40jz5sAqDcTvTE16SibKeoZYgJEBEOI=;
	b=nBSZD8IhMTqIGw07SodTgJGiMBA7LA36ls104VZXD81/BGqX2PlvXBtotn75l3vVx/dH
	 tdtHqRC0p6xcLnplnDqFz1fEzZDGM8IKcLk+s4XyYi+IQ43CyFI73ZhiXNcgdOSwoqdNN
	 vCMHziW13OInk065RV8anqhwZmCbP86CjgFssmyMNbyLQzk6EnfM5pv0CjomODQPNN2XM
	 s0vqzUWXXhpYp1AnW3nPjLwQQQJ45rUSbiuePLMPgZtYuHTJT3teMnBe1r9Wdq2KK0vss
	 St00pFN2AtnFVIaZPvge2kzMTg+WX0OP5Z4ZFXOpdiGAf94HorXAS147itQQBI/3V2A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792604419;
	bh=zta+qWUYBYoy40jz5sAqDcTvTE16SibKeoZYgJEBEOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pZf3wZbcWj9BvzyBWKnACIIBPhpg4gQxm4RCtN6TbB77FKaCSF+PlMxc9i7/gks/W
	 HQjgKikL/ASgJDU6tY08b6GwqXrWDtYp1nMZa5slay8oSUC2WPsUYqWTCG38eUyJNw
	 RO7ll5j5WETpzzSDvAGyhhp+G9PaL/sdl5pYHo+7ffuBKS8adZeAqiz+5sh/33xaSd
	 EhOQf8dxZ++g0gnWY4eCHx0VLJARBN6Ih0LXJBE4qNiSgzPmJ8G1nY4raOboBuySWO
	 UNdAuImDxZCLLfELGyRGwHbsDnLfUw0p2p3Hlpz9jPKmBMuMnzrXtlcDSHOZIBMide
	 vhxfD2h2XoTOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D1E9381027;
	Wed, 21 Oct 2026 17:40:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0A8BA235
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 17:40:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E3BB64039F
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 17:40:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sOJHZ4KRjQSz for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 17:40:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org CF0AF4016D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::1"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792604417;
 b=XCIwsQSoZmKMi5nmKTGxAc3Y3GQLkN8bwPXVPVOn2AtT0LjlP7yZ4UoVi6ftnNiJE7/u
 9O2jGc+7JvAeLdjHTq9XsTkVFSPq1tieXn1BZ/8Pops4gqfUI6Yo74YRoFaDjE7S0jia3
 +wUiKX12nMXumdslR2lQzqAYz3yEptRUgN+EJZ/EebH/1DUwEVkNcxOYfGmAovc4uL+P4
 GZTZEXj6oX1oeusowdpecusHezK6STxRIVN/WzNtTZBDaA/qC6PjxGP9iu8BHbhl1JlQw
 mH7B48lTBygue1ZYqLy6nY8BeGWFtKsKnYOcuJGVxEs5oY8vfP/ivDCxg148Bc9KAVg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792604417;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=zta+qWUYBYoy40jz5sAqDcTvTE16SibKeoZYgJEBEOI=;
 b=BaE192fkgO+bceJ7eWZnsFutYRy4yDQ0fY33YsyCtfFj5O6NGm9zvNhkFyTc8cuME4J9
 JN+RorfvNE+csmDXxtiY0wqH2zjQKZBest2SxK3k4IFPt871kAyVNVgb/Vynq4scCH+OX
 Yb6qVu8wvExdpzmlMfgXgRYYgxpG94Q/LbyTBttXd9n7HNJSEjfcgYtwXKE5c1+lRNuHa
 lFRkk6640h+ZfGxgMX1S3OZyhTeHfrr2tg+sGYmqHujteblX/cyUpvtAQLQqQ43S7mmqC
 DaWMXuUJk2ZV43qXRp1kce1Dl3eL1Tui0nO5wQxXeHuViAQ7qPWNjWZAnvgKYqgrFaw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="Iq+s9D/W"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::1"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::1;
 helo=mail-oa2-x01.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Iq+s9D/W
Received: from mail-oa2-x01.google.com (mail-oa2-x01.google.com
 [IPv6:2607:f8b0:4864:30::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CF0AF4016D
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 17:40:16 +0000 (UTC)
Received: by mail-oa2-x01.google.com with SMTP id
 586e51a60fabf-4511f6a63edso109999fac.1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792604415; x=1793209215;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zta+qWUYBYoy40jz5sAqDcTvTE16SibKeoZYgJEBEOI=;
 b=Iq+s9D/WQsG+u391vLonOs7R2jkC9JXh9nzlmSZjn5Q+nXBrPKVu2MsyjsxmZmk1ty
 m2Nm5C/2zWkUO3/bmg6qjEPucDk+5aKJBIokn37Q1s8C2HT3rMa3eMwSFkLqhBMfKLha
 i/VROixqrbUAwVP0K1/CZsxmHxIp9I/HuQ4JU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792604415; x=1793209215;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zta+qWUYBYoy40jz5sAqDcTvTE16SibKeoZYgJEBEOI=;
 b=ZEYnUaHLmKQdxliiNYQ0moKJcnO6ibk9Xcs6BjiZ/f81nTwLZqUvFWZGH63moEQ9ZR
 eTtNgVzNM/5JVE9p4awjzUSC6e6BE1/0206DLm2L4hx065StTPS5l0eyjT6CNDr16Jka
 aTiV6nuqIkuK8Ly3CH4lny58M/hVRvts/pAILwslW43hLZuHFx9DLvJI2JmB/JHlpmS6
 63d8rFxz7sfpOW+8NPQe77cRjyS83jCPT7oH9VaROBL9sEo70jLMpUkl15jC7M5mckHE
 VqWwKlTfldaWOoumMWfYfeX8lXPR5QZgKFvkMrOjMC2FmHSYaUdAhN/cNd/mXsA+rlpL
 USvw==
X-Gm-Message-State: AFq9FYJDMrMbNUOfbmqnKZUavbzPSb3uScOjhAud1B88BUwtsAeixKrM
 nv+0rwtKLlNmY53UXkxdT75gJCqoAxK4FkuBKjZuayloPG/lY93Z4q4F4UsXNjVIYB4=
X-Gm-Gg: AYBFou39ttiCtEOy6+IM0X+YibPYloz1DKS+CarxUEJTQDE4RR5qydXe6EXofdsrVKU
 6sK1U/Xn57E9KD7G/LM22cvjkg/0cgy9hIJlwJGehzd15Mdne4JafYBUvRsPmmLCvV6Dz3nGo6B
 F3/qCOubLLwhPtYu1f7tFr2UQ3nim0s3W+8R+AS/ujyrc2xmJcYdYzmnyb67Z2CrASCi8uR/NyJ
 Xe95Pr2Np9QPM0hBLFrAFeaGym9iBjKZHSkWJUKRtThy4ixuXiSbqVpIUA93bvNq8T3orLZh8zZ
 H/df6hPL8ro+wroWNyrxw8sl1trZg4tkvD3jdScckIKyAndUPsb+TeLoG8q4oIACV6rXgrPj0Kn
 k5kfBmn/Y+5Y1PX7jtRpiF/sLb6zATevzSaZhU96kJka1/a3Xek7eXRx9N8IDbP0jdUVHyC5ldZ
 8ZxpPuqUffqDYUU8KOSYTc179dt0ykcfPgt0o5SLnUlg+Mxtb3J11Ei1Y3+VarXRsbk/ZIbm5aP
 kRN5NJ0KrVS93LntlGUYLsNHl4luJqnPZ/RTTMcEb9ACIWirUerVbtn+AIxrpz26O/MYVKIzEfZ
 Y6Sh95CajwlokOCYSzFx8jnWxDGxXjR7YiEFYmZHRSl1yXhdxm0ERJej6oKO5ALrJN/ha5+zhGf
 e
X-Received: by 2002:a05:6871:3686:b0:49e:4de:13e3 with SMTP id
 586e51a60fabf-4a7dc147338mr1489685fac.20.1792604415155; 
 Wed, 21 Oct 2026 10:40:15 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a7d5ebc240sm2447388fac.2.2026.10.21.10.40.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 10:40:14 -0700 (PDT)
Date: Wed, 21 Oct 2026 11:40:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Subject: Re: [PATCH v9 0/8] arm: snapdragon: Add snagboot support for
 Lemans-EVK
Message-ID: <20261021174012.GB3275858@bill-the-cat>
References: <20261021-snagboot-v9-0-18ce3e431320@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="E5k3qhxLraONlpB8"
Content-Disposition: inline
In-Reply-To: <20261021-snagboot-v9-0-18ce3e431320@oss.qualcomm.com>
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
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--E5k3qhxLraONlpB8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 09:48:19PM +0530, Balaji Selvanathan wrote:

> This series adds support for running U-Boot in snagboot mode on
> Qualcomm Snapdragon platforms, targeting the Lemans-EVK board.
>=20
> Snagboot is an open-source, scriptable flashing framework that provides
> an alternative to the proprietary Firehose protocol for device
> provisioning. Like the traditional EDL+Firehose flow, Snagboot uses the
> Qualcomm boot ROM EDL mode and Sahara protocol to download
> and execute bootloaders. However, instead of using the proprietary
> Firehose programmer, Snagboot loads U-Boot into DDR and uses the
> standard fastboot protocol for device flashing.

You're implying that snagboot is qualcomm-specific and it's very much
not.

> The framework consists of three modular components: snagrecover
> (downloads XBL/QCLib to initialize DDR and load U-Boot into RAM),
> snagflash (communicates with U-Boot over USB using fastboot to flash
> system images), and snagfactory (orchestrates parallel factory
> flashing tasks).
>=20
> In the snagboot execution flow, ROM code in EDL mode loads
> snagrecover, which downloads XBL to internal memory. XBL executes
> and initializes DDR, then snagrecover downloads U-Boot into DDR and
> transfers control to it. At this point, XBL has left the MMU enabled
> with its own page tables and has not initialized PSCI firmware or
> populated the Command DB. U-Boot must handle this non-standard boot
> environment to enter fastboot mode for device flashing.

These two paragraphs, and the introduction, should be condensed and
concise and point to the snagboot docs and also the docs being added in
this patch.

> Support for Qualcomm Lemans-EVK SOC in Snagboot is available in
> https://github.com/bootlin/snagboot

I looked a little, and I didn't see it, but I guess I just missed it?

--=20
Tom

--E5k3qhxLraONlpB8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatj4+wAKCRAr4qD1Cr/k
Ct/CAQCUF9Nvzulg1e4P0s3v/SC8+kDm40uuPSv0F0YpEhyjPwD/eR891Fkaxnvr
bR3zYgnDnibAMNCPicPQq7cG6IUCkgA=
=r5+W
-----END PGP SIGNATURE-----

--E5k3qhxLraONlpB8--
