Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1B0606A331
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 14:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jr2aDOPy;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=YRqIJjzY
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF702409AE;
	Thu, 12 Nov 2026 14:14:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9f4eqJl6HX2p; Thu, 12 Nov 2026 14:14:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1E973409B6
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794492876;
	b=Aarazt6DJmxKTYkmXyB816kc4OWaHbDeZMgQUuiT0WlW2h1yZmP/IlDRppJRN+qTIJuo
	 AzL4233zJxgDZ8Z9Zo23svAJ8cDMT/hGxaHQQnYJ/xpVwFOP6mmpgqz7gTTAJ0/jNvzD8
	 30AeJwkSf8REGCtxxAaYeP15svOpBWhPWix59SLD+pSe/TuU7MNPP4GxqGFtXQh/ODSZj
	 zYtt+Axp7idOKFmBoWQ19jmLkCi1wHNp3vejF8sK4XpbBX9u8WX1eKqiRNo7icjQ4TsHw
	 nMQeyRfzb72H8FoHc6WtPEuSk98VnrgiiI+vPWvPfMc07zsu/2VGQdcPPIQhHeXk19A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794492876;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=T3O+tTQUygAPWLh40Q4zgsYv2mrk42x4EBhXDJbe+6w=;
	b=YoQvJOjafOMy+euw6tR4q4ZB2roCNrTiwSs+QJ68a/PXou4ovrEukvRZkxhGXJlBQzH0
	 maU6vbQVug3LHflJQ1Cogy1BbL1UgxXXCuR7GEcycriSipJ06N4mIw99k1ygMiBhb6Lr2
	 euokMPsBkKhB/bMysmGp255FoLxrD8llaBa/ZLpwApplLj5DwYVBLwjKZtsBCc2H1eoex
	 jMt0bH7WZAe9/RuPGMPTi8MO5Gu3yv7HKFIO61J0BEqcjDdjpbINvLLFwd0wfMACSJMlT
	 WX2pMpRNiMuIW/m9k1OEnpU/YhSqOSW6d1U98wICuvcNbVjDZrBZWmtcujcbbx9RD5A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794492876;
	bh=T3O+tTQUygAPWLh40Q4zgsYv2mrk42x4EBhXDJbe+6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jr2aDOPyf/fVbJY1oEh/GtVMTWihgG10cEG8SW3Thbxjhdiw+fYzIpANRIIbhyGYi
	 TT7ewWxRu47XE16gBf+tXZIH2uQt3cdM/7V3xz9Pk4CFERhDK7EEYbbiGAaAXQPS/v
	 3iPq8aO5uZH18V7f4HVYguyWVdK4xS16FOMNLE5UF2UQ3z2xp9lKnw7zvUjuwF+lAJ
	 cfOeG+ppIQuJJCSWmJzbXABNuGQfHDdsLg+mSB7dl3X/Axk31kuxIuKzdl7ltNil3u
	 2fC17EAahIL4KzugT2M2mqgFrEsuVgM2hzFb2y07cSNlwLNAVONHZJts9H/y5zap82
	 swWz/nVlQrrgg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1E973409B6;
	Thu, 12 Nov 2026 14:14:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 759E42FE
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 14:14:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5B13C813D8
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 14:14:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QQWMpUdcmWGj for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 14:14:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 742908123F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::3"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::3;
 helo=mail-oo2-x03.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=YRqIJjzY
Received: from mail-oo2-x03.google.com (mail-oo2-x03.google.com
 [IPv6:2607:f8b0:4864:31::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 742908123F
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 14:14:31 +0000 (UTC)
Received: by mail-oo2-x03.google.com with SMTP id
 46e09a7af769-8459f7bc7c0so1984041a34.1
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 06:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794492871; x=1795097671;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=T3O+tTQUygAPWLh40Q4zgsYv2mrk42x4EBhXDJbe+6w=;
 b=YRqIJjzYQ1ldc+PuZJHtEjqmtXmlU4DttfVONIb3uOmLWYYZ8XzKa5TV41d6GlNAGV
 UBDstXBn3wfPWH7gF8YiyHRhGmMpiQ7ElaOKEhh3yUzKXB4ZSeMRLcCJCjxh6owvo/+g
 9CJtXwz3TGtnZ724nVppYZsVsWr5yTCG6kLhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794492871; x=1795097671;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T3O+tTQUygAPWLh40Q4zgsYv2mrk42x4EBhXDJbe+6w=;
 b=eL32FnjVay6LPrxjbRihYKriiXAGbIkHDDXPyuNKSnJ2R4Jp4jYA0iNdNBDrAsygIR
 xurjDnHvCQW8N/Z/TI+SCe/Uc6K/ZXREB9yzDug2YvQdow/jr9rfgFnHbq0qzCCXPBxx
 qbzgF66eNQIksM3UD/zbsemgBJL6Ja/B3aR6DUk8WLucb9p1qNSFvObKkH4oHrUnbEW7
 O/xEE6UlTcy81qpS+DbxUlqcYKKXzXzO746P7OpvQaYpBjArEfJl5fkn9QRaUj66BosX
 7qW8hAEKxRUFUlkk4HNBwb7xH67flYOerLwtw5KSI4QJWnc93KoxDBQxuPEi1N1MYWMF
 H1YA==
X-Forwarded-Encrypted: i=1;
 AL+hErHInJRvSKLu6oymrPE2fcuxcVEninyXarVVI5Eg0HcsuZbE2GhWg8a+/oe899l4slfmABkpmfg=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z83eHMMRRlqBc53H8yvjdVROGy002CFR5tnQvvnPN/SCy19qp+i
 kgJzje5FDr/qNqeh3BGRWhDFZeoDNFpd7uEBkdHQyk5wGq7CUEOHyb3wpX+54bd2JF8=
X-Gm-Gg: AYBFou0iYhk2zfXk2tzGAujm2LukmER5L6YJMdbn/rb8RJBFp4Ldz5o1+5Y4LfCGHNq
 3c5mtY6fu0Lz9lYOo4mxpPa4st2Nl10cyKkDBEq+2BJqI9p97HtHJyCB0vexf+Qls2fFwJFJHJN
 Ayo1ZoXbR7lmDchj3D9A6m5F8fZl01o0Qiu7GtHa1TgIsjIFTpSTQqhW3APEC+kS0IlWkC06zx7
 dLmiuGP/u++M5bjCoWZyhzMey8J6ILlo4ECKRoht8rGEdBSTuz9vfEc28Hf7lakgPSbcGoHnB/N
 Nb+YjMOrEjm8YGZlpBwdIy8yLCWbmcYJ2uv80T2osl7rmNhoMsyRKckI5bt2tG42oMioQqxvsoj
 tcQYLhkIPk3azc+xoSL7sGDw8nc2h0piM4Ut6opNwov0/xIImy7DvUYEc9pCnAKPfI+qPd8dcAZ
 jvLBZB0uEA9YAWvFSHS0orOvFI2y0/zYBBJPkChz8IHNJdYk5cAdj9Bq6KJsVt3uuPI9bQf3eA4
 mMGodt1wfiiJ2QRmryiD/N/SFpHPVLP0KkkLnly2Zpt4IwdiZT6qjA41GnWQ6252EjBMgHlabgi
 7pD/FcdbBi+Kd8saeHzPxkTaJamyCMyXkbdd0A4WXCEiLfIgkTsf+qTIL+9RbNsCrZd30s6iQSz
 VfdO2V252V1hTxmKuyEPhYjqRmIx7HWW0kzUh3t0Lro8zoIoFPcZfzLvhWLTQ8FZjKeQW08G2Bg
 cLfPIdVl58z+3MD6TcsM9571iRcu3syHM=
X-Received: by 2002:a05:6830:438c:b0:821:c01c:2ec3 with SMTP id
 46e09a7af769-860f2393707mr5759071a34.0.1794492870760; 
 Thu, 12 Nov 2026 06:14:30 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-86286b901afsm12715a34.7.2026.11.12.06.14.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 06:14:30 -0800 (PST)
Date: Thu, 12 Nov 2026 08:14:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 1/1] Update maintainers and get_maintainer.ignore
Message-ID: <20261112141428.GB554944@bill-the-cat>
References: <20261112115842.39126-1-pbrobinson@gmail.com>
 <20261112115842.39126-2-pbrobinson@gmail.com>
 <06aa5a02-0f60-476a-abab-aa3de9ad6019@cherry.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uetEhXRPnxc9dnsD"
Content-Disposition: inline
In-Reply-To: <06aa5a02-0f60-476a-abab-aa3de9ad6019@cherry.de>
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
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--uetEhXRPnxc9dnsD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 02:59:35PM +0100, Quentin Schulz wrote:
> Hi Peter,
>=20
> On 11/12/26 12:58 PM, Peter Robinson wrote:
> > With the departure of Simon update the MAINTAINERS file
> > to reflect the current situation of various subsystems.
> >=20
>=20
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> I see we're updating patman MAINTAINERS entry to Orphan... weren't we
> supposed to remove it recently? I see it's been moved to Simon's tree
> (https://github.com/deinde-dev/patman) so I guess the "find it a new home"
> part has been done already. Is there anything missing maybe or can we sta=
rt
> cleaning things up?

It looks like the MAINTAINER entry was missed, and yes, should be
dropped in a follow-up.

--=20
Tom

--uetEhXRPnxc9dnsD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavXJwAAKCRAr4qD1Cr/k
Cg4aAP9VpbS7q5O8uIpLkpGyOIYbA+9xpfEfVrIAMKMCj8i7UQEAkrdbIwEPgAye
p4OqAJYh/sFOgbPDZ/RJyb/gQem4xAM=
=R3Hx
-----END PGP SIGNATURE-----

--uetEhXRPnxc9dnsD--
