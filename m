Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C346DC4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 18:37:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0350F87E82;
	Fri, 12 Apr 2024 20:37:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UWmoTK0y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C615487ED9; Fri, 12 Apr 2024 20:37:22 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 646C487C75
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 20:37:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-789f00aba19so60228485a.0
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 11:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712947039; x=1713551839; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dpLtXkD6Akw0rRGGH7LXr338LjU5pfpzuxNcHLtO4Rg=;
 b=UWmoTK0yjntiQaVlJRoFfYiBjmneEILhJaoBvISAUfGRpGQD9V3Cp3aaCiHvHu5cLZ
 eDJxN8XDnu95g1jTfnOR4JiFSzMrb5Orbfw9WxePWDo/l3kOvvUfOzqq3JBucTliKtDu
 fabwZwnTWgkz0P9rufbyHPpaM8n/JK+M5cKoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712947039; x=1713551839;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dpLtXkD6Akw0rRGGH7LXr338LjU5pfpzuxNcHLtO4Rg=;
 b=BWBn4qOJHLA/9+OgFmirePk97eXd1HtaUpTD5oXIQaqzhu73/4vYuVct8TWFJ/Few8
 KQ/vR+74aPp1N0OO9/YpgwBclHMBim79uFD7AkTEqcgnCj5NfnbtPaqv+mIm8CkktZOs
 mGwQ0mQAaYOw2YW1UBdfTEhk/0kB453ulz9M1qMzjFltjdsS8nS6law364Oq70sSeYpQ
 9aQBb4qM0ypbXkoBQu0If6fpgn7SnbfZSrFgWaV4XBR77FULu3kmR7BfDSnePS/57MjX
 qpKKEjsUfp22cH8yeoqb9acnDLdAMCVFRzm0avYe+pt3C6lXsC0fCWL2nhSVpze6rmbg
 a4YQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlfmcx5pCFKppMuXo9o3q2w6+9hLxijK6n+JdjW8n4XbZ5WpB6KARGarHYLy5o44m16i/9L+JjPgOSmZmAdRU6NAbYLg==
X-Gm-Message-State: AOJu0Yz8PxO8LCrhM0hwp3CHcIRKIWeZFERpmKb5xn7FBMVzJCgHsP+M
 i6MD1t9Am6RNXjktuycYDyqxxYxcr3ahmdPkMDQQO9oPbGgpDEyxHe4jE7K1pfQ=
X-Google-Smtp-Source: AGHT+IF4+09w3MRreZiR6QFlK7drCaXDg1lMVmhTPOlVAelqk45clM0VXW/smp7n7ZjMo5GXV2ikaA==
X-Received: by 2002:a05:620a:1022:b0:78d:6574:8230 with SMTP id
 a2-20020a05620a102200b0078d65748230mr3569127qkk.56.1712947039194; 
 Fri, 12 Apr 2024 11:37:19 -0700 (PDT)
Received: from bill-the-cat ([2806:102e:18:245e:b648:93e1:5c61:68a3])
 by smtp.gmail.com with ESMTPSA id
 qp13-20020a05620a388d00b0078ec3c4452dsm2344803qkn.9.2024.04.12.11.37.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 11:37:18 -0700 (PDT)
Date: Fri, 12 Apr 2024 12:37:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: Janne Grunau <j@jannau.net>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Joe Hershberger <joe.hershberger@ni.com>, u-boot@lists.denx.de,
 asahi@lists.linux.dev, Neal Gompa <neal@gompa.dev>
Subject: Re: [PATCH v4 0/6] USB keyboard improvements for asahi / desktop
 systems
Message-ID: <20240412183715.GN2493117@bill-the-cat>
References: <20240404-asahi-keyboards-v4-0-2266033feaff@jannau.net>
 <356b892a-a681-4ae0-a6c8-ed1b4b5a8717@denx.de>
 <ZhBLfQfxB_UEwvyY@robin>
 <5467f380-de35-4776-8c32-90b8e08aeda7@denx.de>
 <ZhGq0U_pkrYMe4S1@robin>
 <5ed4e6d2-edc7-461d-8183-e91d7b994aa5@denx.de>
 <ZhOg81sBEDLgCSIa@robin>
 <83e48e51-f88d-49d4-bcf9-340e229fdf76@denx.de>
 <d65ea7c0-cb89-4cb9-8378-11839a6ee63e@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="a84fH7bpEQysGXgq"
Content-Disposition: inline
In-Reply-To: <d65ea7c0-cb89-4cb9-8378-11839a6ee63e@denx.de>
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


--a84fH7bpEQysGXgq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 08:26:18PM +0200, Marek Vasut wrote:
> On 4/12/24 2:53 PM, Marek Vasut wrote:
>=20
> Hi,
>=20
> > > Seems to work here with a broken imx8 config from the CI. Is it ok to
> > > rely on dead code elimination? Apparently it is, build with KCFLAGS=
=3D-O0
> > > has already several other missing symbols.
> > >=20
> > > See attached fixup
> >=20
> > Thanks, squashed, let's see how CI likes this.
>=20
> I think we are getting closer, but still ...
>=20
> Pipeline #20308 has failed!
>=20
> Project: USB U-Boot Custodian Tree (
> https://source.denx.de/u-boot/custodians/u-boot-usb )
> Branch: master (
> https://source.denx.de/u-boot/custodians/u-boot-usb/-/commits/master )
>=20
> Commit: 63f6a449 ( https://source.denx.de/u-boot/custodians/u-boot-usb/-/=
commit/63f6a449bffe46beca89580d3efa48e5d041025c
> )
> Commit Message: usb: kbd: Add probe quirk for Apple and Keychro...
> Commit Author: Janne Grunau
> Committed by: Marek Vasut ( https://source.denx.de/marex )
>=20
>=20
> Pipeline #20308 (
> https://source.denx.de/u-boot/custodians/u-boot-usb/-/pipelines/20308 )
> triggered by Marek Vasut ( https://source.denx.de/marex )
> had 1 failed job.
>=20
> Job #815411 (
> https://source.denx.de/u-boot/custodians/u-boot-usb/-/jobs/815411/raw )
>=20
> Stage: world build
> Name: build all 64bit ARM platforms

That looks like the machine doing the build failed, I've kicked the
retry button.

--=20
Tom

--a84fH7bpEQysGXgq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYZf1gACgkQFHw5/5Y0
tyy+EAwAlfzwSPW9gGqIWOidlmlK3bbiFmZgyMFkYJ/pv3DmO+hZnNKik8K9W//u
p74BHLwZ5dpzpItjXgHYid3OZlQLH1TPnNOg4+d47Rkaj2A4/pZYlXgx0jp1CLuJ
LU05GWouCVh/m4HmZ6Db3VtmqTOCxKz/DKAAR/auAgScAw/6/U22TNJlT2bH00Iv
9xnex5y4LJbBgLkOJjSaI06+5WkwfFM+h0wANHzUv7vl8sUhj73Dfvhyzrfdw/Ap
6PY+nxm97IqohtJQUgwNO0/HXUvQEcrmGuiHVSVgyvazpLJh/sMfjD1CI9Yr877S
GhV02jbJ+2G/fyoyUXZa26ka+PnF1gWnN1fhVb+WkAEgkCS5thCHfDqKC13GNfTI
cQDAt+MNAO572nabYdl3OXTpAmeMVTkkOaL8JO33L5XsptZNYx97QlyBRViVoEhl
IdMqHrSx/pb1Pu+TUlO8BldJXp6ykVPQfOSBRna9+YLDyRti+E+KFwMWKM1L1BTx
ebTsuieH
=rTPy
-----END PGP SIGNATURE-----

--a84fH7bpEQysGXgq--
