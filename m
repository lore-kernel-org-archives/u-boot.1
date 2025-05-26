Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD3E5C5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 22:03:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55BCF82F66;
	Tue, 27 May 2025 00:03:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="g44lwDir";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B29A582DB7; Tue, 27 May 2025 00:03:17 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4852782E2D
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 00:03:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-609e7f3caf3so1298315eaf.1
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 15:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748296994; x=1748901794; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tdZS25hA4P8EhzZHJPzS7eOTLpIE17ePeHFL3/Q9/Q0=;
 b=g44lwDirG3pUVekgQrHur9XBpI8HDKdhHPmErHzMEQNCm3ZdBQy+CHFTcXrRCjb9K3
 gh8GXbXVJEtbYL+DeI/KNQMefuqst73/HjuDHMzyvr+Og8WUwapEq8GuDhUb4/G4Ey3R
 MrgGmrFNI1EO5AlO3AsnsMyyDqkrA++fjSPOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748296994; x=1748901794;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tdZS25hA4P8EhzZHJPzS7eOTLpIE17ePeHFL3/Q9/Q0=;
 b=ez/XQeMkx/FsiiLLz3Fq9tiNqSsUwJ9JTZNNErJHmKDsUMA/Zn2rsBBo+65GJJUHdC
 kv41m9STyBKk6pEv7ood7iqYOINLZB2NoAUMSfGRGxDtdQjf6S5XvfsnRGIAS5dH1zwX
 cmXG5D+8TbuEtsFK3FimzZ0Qzl5qG/gD5TAG14t1tGdK6oLuBLvUqqjDBlNH8l8WrjEm
 uJAWnq3LFVlVW1msDiZain646YhjuIE2rMmAomHYCFJLDBCEDF/cO+iuMCSshhl41SIh
 WZIoAzfToFf+nPiMtGRsGNAePVM3FFbN+JU8U8nDuX2Vt0nNQ0VNHVUELK+ir9cpTSlB
 TnYg==
X-Gm-Message-State: AOJu0YyOy3iSoT+IhDic3dbQXYo+aojGUf08RGT2CfPF3TH140Rbo5yP
 jrODGsfdQi713yWMdcZgyciRDpVL1SMQAPBZkhXco/vif7vUiDR2QamTZWQbPuc9V8yk8E4eLnE
 B+ylXR2s=
X-Gm-Gg: ASbGnctTZi9D6bU/iAu/GnCWqPwYq62dusM81J1N7+/1c74E3EW+oL766VH+Y188FES
 QSGN+Id2uw2rOVsyYSf3CunRne8N5Fiu0YemtlOpMmzM7ryWmDWiO8gilTnIDFwOlD6wy61fKGi
 zIS6OqF0syixZQEG4se8rR6mjuXffLsMHl1q9K9C0ppuQ1+3orjVu06ys1xwnkW0XqHhLjuVk5s
 2Il+mYPds6vQbR1pWH4y5f1V/3S7SpurAzRgKjPcHzDRRo2Jypw8VYr8Q2v2pY9QS7O4tLKWYm8
 yDE2DhuWqfjBGoBVjvbtMP8ZpCStIRw0F/8g/Cdd7Z+I1XIb8r/8OtEjgfDRECJSco3+NgUXrhl
 ruyXQJNu3Bq8J
X-Google-Smtp-Source: AGHT+IEZjhxc0gl09Wdx1z3yQlxViP03SeGKautvr1JRIgxv0c/IacCTpBG//+ZTNblXelLLZ2ePDg==
X-Received: by 2002:a05:6820:2612:b0:60b:cbde:bd14 with SMTP id
 006d021491bc7-60bcbdee3dcmr96933eaf.8.1748296993895; 
 Mon, 26 May 2025 15:03:13 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60b7f26375esm2451634eaf.40.2025.05.26.15.03.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 15:03:13 -0700 (PDT)
Date: Mon, 26 May 2025 16:03:11 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2025.07-rc3 released
Message-ID: <20250526220311.GF100073@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Nc7WifZCeLDhBirG"
Content-Disposition: inline
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


--Nc7WifZCeLDhBirG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

So it's release day and I have tagged and pushed things out. I will be
updating the next branch shortly. There's still a few things that need
to come in for the release, as fixes, but otherwise I think the next
branch is where most changes should end up.

We're continuing with a community meeting following the release and is
the same time as the previous meeting. The meeting details itself are:
https://meet.google.com/btj-wgcg-euw
May 27th, 2025. 9am (GMT -06:00)

To join by phone:
https://meet.google.com/tel/btj-wgcg-euw?pin=3D1307528552322&hs=3D1

In terms of a changelog,=20
git log --merges v2025.07-rc2..v2025.07-rc3
As always, more details in pull requests (or the tags referenced by
them) will result in more details here.

I continue to plan to do an rc release every two weeks and the final
release will be 07 July 2025.

Thanks all!

--=20
Tom

--Nc7WifZCeLDhBirG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg05R8ACgkQFHw5/5Y0
tyw1lAwAgBiiTJ2U/oWZKVpCkAqKYi9U5tCZbgndvulAGal3UQsvc2bAhHWPfXpM
T+NGIcFD0pLILi6tbT/hgWLaRGnQJ1rYJXh3/2kBba51z6FotUbYnp+OD50xrSRg
3DXUDW9HunL05skLI43DWTRaTRVDR0J13gCgOLhCrdI/9Kxpf2MOszfa4ZiqNSrG
TsRfVTwGi0aLkQlz2K25OIj4LtizDUjpyRrtE/2zBoSZfJbiqoM12cxb4vdngT10
bUkYCMO273AqNWx7/hB60AgREknbGBYtI7iNeeC9RY1HaTJan0J9qMLvLULjzRvl
bHDXZw5ixrMq8/g52+U8sUDtMlVHOJYXcJxbbL6opGYH7HOs03HCRRjnCh8gHGVj
DWBWUVjPX6aFt0gtgmOTeCh3/ZIlMOyCB9XDXMH9oy2+c6xHuBFcSKzDtU44fKuh
vjVl2B6IMFA966KSAKftWKUx6Pylrt0HY8azbA9EuhpNV3N0roqQJQPXrotTq1wc
NzgU+p6n
=Jhgs
-----END PGP SIGNATURE-----

--Nc7WifZCeLDhBirG--
