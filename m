Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C29C282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 13:56:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5237B817A5;
	Mon, 10 Mar 2025 14:56:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SqPt4Uh/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D5B181703; Mon, 10 Mar 2025 14:56:12 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEAB88141D
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 14:56:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2239c066347so71328245ad.2
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 06:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741614968; x=1742219768; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fR4wVsXBbZy67PyzcfdNjd8NEXrFo/+XoYrLmnoVLv0=;
 b=SqPt4Uh/AusvDJyph9i1tbTzekJb+bPpar9pr1w1u7umZ9irjTKBQW+07xmlQLv+P3
 bkF39u4g/Ra3HIogBrMPkq9QgGt321VlRftqdBn5U6K/SGLP5ZWgS7zMhg6Q6wxRCNtB
 ZH0wfE7CqtyOzPD4YGjTN0UYg2iF14MBrC9sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741614968; x=1742219768;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fR4wVsXBbZy67PyzcfdNjd8NEXrFo/+XoYrLmnoVLv0=;
 b=tAFqO7S/T8PL0A59qVv63c4Mn5fJ9LXfXG4IXjLu0gE+o6P/lXNhyUYIqoN6XJDvfs
 CznPt7tFhjp4nXiIbsrYBbitX/nb4Zyh2MVXg5LfikT57xGKlJiLEewhdswWg2pIo1vh
 tEJWOyolU0lifZ/fFftljc4pZc075IXr29nysNBfu9eSp2/EZq3rP1QTHXQ8q1M8+Iu+
 zDn7oIGy8CXYndyzlBBfPWVuN1C/tVVOsR8F0qvZ4rTBfQS6YLPX4jpLA6A5jDVud3cx
 wADcpaG1ZSZVUA7Re+H7rIe4l+Aupxjm/18c80kZ6W+J3M+N/4QEXDnQQNjeHXTXLbR1
 nfnA==
X-Gm-Message-State: AOJu0YxmwAKVko/5wjPMD5Q1jrtvfTXdQl99bCExfD7YOCNSAsUyfpZR
 JkOkx/H+Fwsrd7v6Dq9J1CGsf4dRmJnMlyih/4fDZvRuSdH3alnAYEiZ/ng3UDQ=
X-Gm-Gg: ASbGncsVBf52vfbcg6Tz2nSjYe48D7pvMWdbrm807T+aretBQIbZQsiz7jhFUtBCG+i
 ODhxpbuPZ1p7oDbzOFwvVPTEhDlAMlaIkeD0/DTxZrWI5Uqa2BexR+deYMx3rQX3Nj/FLLfD/F6
 SRjoU0Jifp2UiR+piXdz3bMDMdhbFSNxGe5Retpb84t5JbxkBU46HjMw3jwVw45gwzs3AJbY/EI
 2FVFsbqz/ugAZ2PEpl77nGh4ecrPJTfCnTbtjPw8+1czl9X90rsj8X5vZNnDQPi40K4nmyE3Cbg
 7SWLEDnat7hSwWlGBO1WeFAyB0r6g5KzkXScFPRDmdN58705IhRWn/+h
X-Google-Smtp-Source: AGHT+IHvXtutvYt+RyYLVrGUv+nwEQp6Is3LaeFC8cbH/9WggRuLiMhBgluxtqr5mE/N0qtQItEHzA==
X-Received: by 2002:a17:902:ce0a:b0:21f:4b01:b978 with SMTP id
 d9443c01a7336-22428c055ecmr221269675ad.36.1741614968346; 
 Mon, 10 Mar 2025 06:56:08 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-224109ddbe7sm77457315ad.32.2025.03.10.06.56.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 06:56:07 -0700 (PDT)
Date: Mon, 10 Mar 2025 07:56:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com
Subject: Re: [PATCH] cmd: version: Get information about GCC and LD back
Message-ID: <20250310135605.GX2640854@bill-the-cat>
References: <59827eccb8a90957e3d4f09059e43cc7fe6c92dc.1741255948.git.michal.simek@amd.com>
 <20250306140250.GX2640854@bill-the-cat>
 <41f1ec1b-2c36-4ab1-9e99-77459deff366@amd.com>
 <fb24a61e-0fb5-4430-b5e1-1c2b25ca8159@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="94P1odRfMaUbLAQg"
Content-Disposition: inline
In-Reply-To: <fb24a61e-0fb5-4430-b5e1-1c2b25ca8159@amd.com>
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


--94P1odRfMaUbLAQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 08:49:32AM +0100, Michal Simek wrote:
>=20
>=20
> On 3/6/25 15:12, Michal Simek wrote:
> >=20
> >=20
> > On 3/6/25 15:02, Tom Rini wrote:
> > > On Thu, Mar 06, 2025 at 11:12:30AM +0100, Michal Simek wrote:
> > > > U-Boot version command is no longer showing information about GCC a=
nd LD.
> > > > The reason is that version.h has been removed that's why CC_VERSION=
_STRING
> > > > and LD_VERSION_STRING are not pass.
> > > > Values are generated to generated/version_autogenerated.h which is =
sourced
> > > > in version.h.
> > > >=20
> > > > Fixes: 54ecce2cbf90 ("version: Separate our version string from
> > > > the version command")
> > > > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > > > ---
> > > >=20
> > > > Tom: Not sure if this has been done on purpose or not but this issu=
e has
> > > > been reported by our regression team.
> > >=20
> > > It wasn't on purpose, no. Did you put this through CI / confirm
> > > sandbox_nocmdline still builds?
> >=20
> > Nope I did not.
>=20
> CI is not reporting any issue.
>=20
> https://source.denx.de/u-boot/custodians/u-boot-microblaze/-/pipelines/25=
029

Thanks!

--=20
Tom

--94P1odRfMaUbLAQg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfO73UACgkQFHw5/5Y0
tyy0Twv/XiUzMwG57s1qPTRKh+BVzzAW6d49k2lXA2VmWX/YN2xEuNuPV5nUGQW+
TY5as5Ib3A9Hp/jJ4w5PTAJpLiiTZnmaq/zujxgkz8jaAh9B+NwkYJRxj6H6ojTT
idXBewgcPPXgV9VUeL0LWxbdUSLBwcQNaa5N+ALBgN++XFdCpozMlyH0StZNDTTq
XlaUp+nl56PvAbwnkLdSrHotTL38sjheTQEGkb7BG/7aX2PTDWuQP1F27tQIeVJp
ahwaUO8QO/WWWhgtHyGPDozpLCh2PUCC/IXv57j6FM9j+WGwk2ePTPqHA8wKDfHF
bcl+gJ0hvq7B4PGomq+Q7cFTIIQHJ97A35ZTcSCiWL/2HAzvxxYkRggkgs0V5xbD
23SFAXV07u+8qG5TWug7CcRsi3ZfZGwcS0mCQl/Ks5F38BIRzdgslsMKlyW4j3xB
mysUUqn43i4a0QuAdQQ4gp2ia2xlBIHA6ua6r7glWSXmzLCs9XYIYQ8MC0BMrCHX
rl7DXPU9
=hvaU
-----END PGP SIGNATURE-----

--94P1odRfMaUbLAQg--
