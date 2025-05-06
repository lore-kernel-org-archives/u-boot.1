Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5914EC3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 13:32:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8980682162;
	Tue,  6 May 2025 15:32:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MUFiObkd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28B72828F8; Tue,  6 May 2025 15:32:43 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA6F9820F6
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 15:32:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-72b82c8230aso1577375a34.2
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 06:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746538359; x=1747143159; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pUU4pmOjkp4vn0sH1seXC6F/N9T6N8t0OpLtnQCsJFc=;
 b=MUFiObkdxzP2JAiE+FvBuZO7e3hAqg6fSXf5wfr+TvMJ9ADcGIyGLQ1UTDTO/jmnc5
 30ywI6/RNjPxg5626lJFBSvYItne88/Ig4bXO/2OYDuLYnjBNfkyKCJM5qikPANP47wI
 ww/J2BFCE25dvXPoY5Y4xlJBIvRqpTRwLCYaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746538359; x=1747143159;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pUU4pmOjkp4vn0sH1seXC6F/N9T6N8t0OpLtnQCsJFc=;
 b=IRFMKX2ORy3l7PsvxLklqAh0xqi4G5Qi8lCz7yunp1Ojfz7SZaT2C7dhzr742W74cr
 v1YMnzoiOqpCS6accMSqzQki3OJTGwvY8gT+Ygs/F22rMlIPHsdM0rS7OMUQdPgNfYQK
 MF6D7BCe4hQBf8LvnaYsORMc4rQtFO1IHXhkUkD16j7nPb+h6K3EbgkvsnoXUIfwRPjj
 1/mV3nEWqh+IJOsrBEJh6WZgoln/DS75bQGae5hPH0Py8/QJj3+1Lb+c8I5AoJZmsegg
 xuDRggkxVph6SzujJ+yYDiMdfL0LxNtEJe9SoBeIeE8MtYbGMKzJ5zsv4fLBduinLwIm
 0mSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8VguZoYbDBPCUTDIoLKFgartsIDcQXr0aFcGVCDEZqNh73GaC1TpGILlrcC/U8UPY8HrEu1Y=@lists.denx.de
X-Gm-Message-State: AOJu0Yw7a9IumGqRupn13xLkHg/sDxC6WwLo7CnPFiiaNe5ElHGTmti5
 S19ZOZCO6YTNNGXA6DBxQuyC3h/9TxP9PP4ziKbIt+y/3YGG2VgBOduBnexwp9U=
X-Gm-Gg: ASbGncvNbfvhHQ+pLGatU3ku8KQE67N1t7YvLr+7DkuWOgtjr25oa+btT4d4j3groF4
 Ug86Aa78D1nOIvBt7OSoJa49AGi1fW+0cyQcUDDv5Q5AZzmwWL5Y/O8ZU3hvFhYGlTpVIYgJqAl
 dc0fUJFIzTaO2yzn1f33rjyYa9+5Nb/rnKOY4kNdQxBmprfpKGJ1LDw8yvz92vfwizytBMbf1FL
 VFG8wes+JbVriG2/tQ9sq4qVPJd3V5iBfT8FoCFWgATDjeg1czr/9+kdOgWpWR+wHsRmE7bO897
 tNddq7vC8w2bWGJl3A1rTczJl8QrdE6m2QrdURPxP5vgEN6cCzKU/SPZ49wAow6TScOKJdiUqp3
 d0A==
X-Google-Smtp-Source: AGHT+IFfkkdQfYkZyw3XO8EM4PT9mcZ4C0IA2V6lKKFXQ6bq4khjH9esuA8Mcs//l5cDR7tgM3ZX0A==
X-Received: by 2002:a05:6830:2817:b0:72c:320b:f827 with SMTP id
 46e09a7af769-73206db38a0mr1802635a34.6.1746538359546; 
 Tue, 06 May 2025 06:32:39 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-731e35063f7sm1537635a34.29.2025.05.06.06.32.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 06:32:38 -0700 (PDT)
Date: Tue, 6 May 2025 07:32:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: neil.armstrong@linaro.org, caleb.connolly@linaro.org,
 sumit.garg@kernel.org, joe.hershberger@ni.com, michal.simek@amd.com,
 marek.vasut+renesas@mailbox.org, cniedermaier@dh-electronics.com,
 xypron.glpk@gmx.de, sjg@chromium.org, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/3] Enable env in UFS
Message-ID: <20250506133236.GU5430@bill-the-cat>
References: <20250401080015.1470999-1-quic_varada@quicinc.com>
 <20250401141022.GD5495@bill-the-cat>
 <7a5ac5c2-5bb7-45d2-838b-63fa07766c4f@linaro.org>
 <20250506072956.otki522irhggugxp@hu-varada-blr.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/AO+tq7y9C8gf5Xe"
Content-Disposition: inline
In-Reply-To: <20250506072956.otki522irhggugxp@hu-varada-blr.qualcomm.com>
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


--/AO+tq7y9C8gf5Xe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 06, 2025 at 12:59:56PM +0530, Varadarajan Narayanan wrote:
> On Tue, Apr 01, 2025 at 04:37:40PM +0200, neil.armstrong@linaro.org wrote:
> > On 01/04/2025 16:10, Tom Rini wrote:
> > > On Tue, Apr 01, 2025 at 01:30:12PM +0530, Varadarajan Narayanan wrote:
> > >
> > > > The qcs9100 based Ride platforms have UFS as their primary storage.
> > > > Hence add support to U-Boot env framework to be able to save and
> > > > retrieve the environment from UFS. The environment will be
> > > > saved/retrieved from the partition specified in the config option
> > > > CONFIG_SYS_UFS_ENV_PART.
> > > >
> > > > Also add an API to convert partition name string to block device
> > > > descriptor for UFS. This API will be used to get the block device
> > > > descriptor for the partition specified in CONFIG_SYS_UFS_ENV_PART.
> > >
> > > In general, I'm glad to see this, thanks! In specifics, Marek is tryi=
ng
> > > to bring more consistency to some of the env symbol names and so I kn=
ow
> > > CONFIG_SYS_UFS_ENV_PART is patterned on CONFIG_SYS_MMC_ENV_PART but l=
ets
> > > use CONFIG_ENV_UFS_PART instead which I think follows where Marek is
> > > going.
> > >
> > > Also, this seems to be a generic ENV_IS_IN_SCSI implementation and it=
's
> > > just that UFS is accessed via "SCSI"? Perhaps we should name things a
> > > bit more generically, and it should already support various AHCI SATA
> > > devices out of the box?
> >
> > I agree we should use scsi to access ufs, we do not need a specific
> > ufs backend anywhere.
>=20
> Reviewers,
>=20
> Thanks for the feedback. Have posted v2 addressing the concerns.
> Please take a look.
>=20
> > > However all of that said, do we want to be encouraging environment to=
 be
> > > stored directly in blocks like this rather than a filesystem on UFS?
>=20
> Enabling CONFIG_ENV_IS_IN_FAT and configuring CONFIG_ENV_FAT_xxx options
> appropriately works for these platforms. However, the current build
> system doesn't generate a FS image for default env settings. Hence,
> going with direct block storage instead of FS storage. Hope that is ok.

In the case of first boot where the env isn't found, it will use the
default built-in and create it upon "saveenv". This is the normal flow,
so I don't follow you here, sorry.

--=20
Tom

--/AO+tq7y9C8gf5Xe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgaD3AACgkQFHw5/5Y0
tyy7fAv+JRxOb8yRUBfY4+lTSTP7u6ppQNhvE2+cIE1X54VTEz0LRbSOIuvXImx4
QBt2nCssV5K8r3zbDsmBR2elIX/r9h0ASOTljqvszHCrdELCqIkIcc/7raCjJrcV
nSp9lb9UfhRLfm9MZhr7hUzxjkF58FCK0/or4mkZFAYNkv1J0lNYO6INZ1sULYls
NqjzVk9D7MLFRT1BpDDmOyEEFNBcwsOoMrB5Ww4kQF8cNspTu4XnGsgDADWsdKIp
l7WhD0BoTXnyx2XaSahJbdRfN6P2RIDMW6Ft+9t1yc6tODFOpgK+JdDRJwzduCyJ
ml3rX5UlTEFW9/7LGt7Rwcqlu3L/TCEwI6cNFMMq74SCkBaiISYfrdUQp2QFCSmb
Fs3khI8KJr6n/p01zM56n0z1+I8CvqzkH2oVBQZANhnuaRk8FPBPS0xnz6vq1byf
SiNhwozC7W51wn0pdG1r2AbmQ6NIDrt3v98iaUeHnShITaCsHaFm0QvcPRWbBMvz
P++JtnGA
=8Sw1
-----END PGP SIGNATURE-----

--/AO+tq7y9C8gf5Xe--
