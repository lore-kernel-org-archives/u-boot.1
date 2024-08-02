Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 157F5C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 20:16:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5982988BF3;
	Fri,  2 Aug 2024 22:16:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="La0BvSEz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D94488C01; Fri,  2 Aug 2024 22:16:43 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFA0388BE4
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 22:16:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-2681941eae0so3291587fac.0
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 13:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722629799; x=1723234599; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DQUiB6/e5ned0KJgGH1UtG52K+6IFCiPDs3meckUn8o=;
 b=La0BvSEzaBFgOBX/6aJQHCHjQauKsxb8t5SozdpVIs7VtRYZiF3QwUB+a9VUvZsSoq
 7sOoDD8CSE6eYUJdMTic9gYQBtffYjytNs7w/KpuWdhukiNulTkMPiS5spqxRcr3z/gy
 UhY7aPvOuvG2nQAm5vfYHt0ZtezCijCzrwCME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722629799; x=1723234599;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DQUiB6/e5ned0KJgGH1UtG52K+6IFCiPDs3meckUn8o=;
 b=NGqSLEyze0KfnsmW4sIZNuApYPzr9KQDtuOL9XS8OvMsbuNyO7flfrALoX/uEDGsNZ
 3jh0Zac0v9bd3a6Ay0rPwWdqVwany+gPipP+D48CM4zz7AL/17EvrSYNV3b2wNKPxMWD
 fWZglXBYQ9Kt0kYfYLCz4tvveApb97wf15G4TXQgsbDWivZcEaVTxtvK5Dc37PvB7MMY
 YUEnX7cwu+VWJ3aqVDjYfy2e5TsIqfU08YbY7/GRKgZP99cC8wQHnziDvTsk2vpaVEQJ
 nyY9H429Is4Icud8UJigXIwndyUKKSKHNShBse6pYitYBzedAu+RUUhQCQjngp17WAq0
 qeBg==
X-Gm-Message-State: AOJu0YyxEzqZdWLGPET+WQPoeUup0d3EFAN4hZkxFbaOBT1ZS2xM7OMF
 pkgVCoXYd4wurQG5e9bVJKa36ohGI8xjEewlmTvrmNed2CrBDRADAMAwD3c3/A0=
X-Google-Smtp-Source: AGHT+IHH+nqBY+nDFn2EwqSYfkUbDrnftMnXD/R4nvOweP+B/cTTd1UUUEQ1LtzQa2ZlP/Z/+a1txQ==
X-Received: by 2002:a05:6870:15d5:b0:263:3b45:b7dd with SMTP id
 586e51a60fabf-26891a7f2eemr5312793fac.1.1722629799367; 
 Fri, 02 Aug 2024 13:16:39 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2689a434171sm526221fac.31.2024.08.02.13.16.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 13:16:38 -0700 (PDT)
Date: Fri, 2 Aug 2024 14:16:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>
Subject: Re: [PATCH v5 00/20] Introduce the lwIP network stack
Message-ID: <20240802201635.GQ3794063@bill-the-cat>
References: <cover.1721910373.git.jerome.forissier@linaro.org>
 <20240725172220.GA989285@bill-the-cat>
 <20240725223401.GD989285@bill-the-cat>
 <ebc992d6-93e8-4e7e-99dc-834cc981f5a3@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GfLHi8HFIuOMHKnW"
Content-Disposition: inline
In-Reply-To: <ebc992d6-93e8-4e7e-99dc-834cc981f5a3@linaro.org>
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


--GfLHi8HFIuOMHKnW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 01, 2024 at 04:40:03PM +0200, Jerome Forissier wrote:
>=20
>=20
> On 7/26/24 00:34, Tom Rini wrote:
> > On Thu, Jul 25, 2024 at 11:22:20AM -0600, Tom Rini wrote:
> >> On Thu, Jul 25, 2024 at 02:57:21PM +0200, Jerome Forissier wrote:
> >>
> >>> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lw=
ip
> >>> library for the network stack" [1]. The goal is to introduce the lwIP=
 TCP/IP
> >>> stack [2] [3] as an alternative to the current implementation in net/,
> >>> selectable with Kconfig, and ultimately keep only lwIP if possible. S=
ome
> >>> reasons for doing so are:
> >>> - Make the support of HTTPS in the wget command easier. Javier T. and
> >>> Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to do
> >>> so. With that it becomes possible to fetch and launch a distro instal=
ler
> >>> such as Debian etc. using a secure, authenticated connection directly
> >>> from the U-Boot shell. Several use cases:
> >>>   * Authentication: prevent MITM attack (third party replacing the
> >>> binary with a different one)
> >>>   * Confidentiality: prevent third parties from grabbing a copy of the
> >>> image as it is being downloaded
> >>>   * Allow connection to servers that do not support plain HTTP anymore
> >>> (this is becoming more and more common on the Internet these days)
> >>> - Possibly benefit from additional features implemented in lwIP
> >>> - Less code to maintain in U-Boot
> >>>
> >>> Prior to applying this series, the lwIP stack needs to be added as a
> >>> Git subtree with the following command:
> >>>
> >>>  $  git subtree add --squash --prefix lib/lwip/lwip https://git.savan=
nah.gnu.org/git/lwip.git STABLE-2_2_0_RELEASE
> >>
> >> This is better than v4, and on the hardware platforms I could build and
> >> boot on (which was most of mine except the am62x_beagleplay), the tests
> >> ran and completed, including the tftp+boot a Linux kernel.
> >>
> >> The bad news is CI blows up, a lot:
> >> https://source.denx.de/u-boot/u-boot/-/pipelines/21764
> >> And:
> >> https://dev.azure.com/u-boot/a1096300-2999-4ec4-a21a-4c22075e3771/_api=
s/build/builds/9014/logs/106
> >> which is another Kconfig dependency problem. I don't _think_ I
> >> introduced that, but since this wasn't against top of tree, I had to
> >> apply the cmd/Kconfig patch manually.
> >>
> >> I have my world build running still and may have more comments based on
> >> that.
> >=20
> > First, with NET_LWIP being default rather than NET, there's a lot of
> > other Kconfig dependency issues. Unfortunately I don't see an easy tool
> > for making sure this is all clean aside from a shell loop like:
> > for C in `(cd configs;ls)`;do make -s $C;done
>=20
> I have run this loop successfully with the upcoming v6 version. Some
> configs do print some warnings but there is no error.

Oh. Right. So, to make the rest of the problems show up, switch the
default stack to NET_LWIP and then we see other issues.

--=20
Tom

--GfLHi8HFIuOMHKnW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmatPp8ACgkQFHw5/5Y0
tyywMwv8C9trAYxhOXgGOWkk1PRLp5lOi9GlUqKW43Xm9oK4X1LgYT0E8NH5Zpmi
JxzbF9BW3lpk1J107V3jIuqknCJRujf9zOgbMCw9pkw1d7xtEDo2oDy2khbMY7he
//diNxM/95Uq4Dc32Lr2HuTmFSzQWJTiZO5N85Y/jWjCrP60WCflxj3C8RdUKBrj
mk0ARr+9arEH0I8bF1n4qXvsFvrwiRwSxF1ZGhNBdddJNPB058+sdK7wxxg19qyG
Yid52Vlq4U1ttpnw7a/+7sfzSp1PSH/9KDMHZnAjQRXuPNXtzWRYItNd4YdLyE7n
b8AkR0PYrEtCxT7L84VeDx87a1YhhRgzoWe4mVU0OSnwD2hvFElTgfnOvfw5YtWh
ftBnthMf5jnCyIGp5jus/6TMGJSn+9jcAtU7ex//F2aiysGY4CppAV0/VhhIaZrA
L1nRBGBvVdEOVlfDmapqZD5FJi9KFqa6yTFGoGTLnJaEE+Iv4AZUr3kyxi8uro7J
ZaIiDZrw
=Xv4m
-----END PGP SIGNATURE-----

--GfLHi8HFIuOMHKnW--
