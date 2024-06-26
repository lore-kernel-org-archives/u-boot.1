Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DDFDC27C4F
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 15:01:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D19F883D9;
	Wed, 26 Jun 2024 17:01:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="M9jTdyLW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6548D88495; Wed, 26 Jun 2024 17:01:20 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CBF3880AD
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 17:01:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5c226165667so329187eaf.2
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 08:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719414077; x=1720018877; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9rTyDl0cyu4YBNU70HYEX1lPVB2WsdCvZrfOE6mKd1I=;
 b=M9jTdyLW7L1PfV3fdp5hjeEkDye80slEy6ZbaCyxBaZIGmjniO8iA9U5lsJMPE8P6j
 Y78576TQljJbCEyM0+BaRqlNP567QPmblgvaDiy43RFKgmRwFUmIsghn+51nLYE3y5B4
 7SPtYRVJAI+PQzCQvDw5V6fG+aDeZ2hHhXnLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719414077; x=1720018877;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9rTyDl0cyu4YBNU70HYEX1lPVB2WsdCvZrfOE6mKd1I=;
 b=fUG91d8e6+S9LMnRhX7LIIPN5odQ6WcAVrlbD07IIMx4yYHr/pEhQR7Aj3udPOCouA
 zKvFk9EoR1K7MrKHt/FMTsf+mQYdYFajJIAZYj5vmIkIYak6Lq3rjaawEnkdmemOSYlC
 d26KGJ5pHhgB44e+aoFyhegoLGFKOnt/zreBhSqPVio/ptLuYEsBfMsCKibJcOOBd1no
 q2fTtBQLsDtazLJF5rXRe8wxIkOLmZSXlhq9OH0TYk/HSdUpHVyrRPxZ5ntu4cpYE+aV
 ZNw9gCPYO54ZS0ZmHbpEqReItUlHL5DgmrRSKRjHX4T6v7NwGKQHPHOHdbIHxxLCK5IV
 7aLA==
X-Gm-Message-State: AOJu0Ywbrabkee2zlW/u9yZ8KGOgRm2IvWaS6okbS9wwMdTemfeOcmcn
 zjkfv79I8LNEzOJAATn6w9xkOhmhrMHz2dVkYcakQDNoSVR9iTkzyxM68fx5pF3Wr0k48o45jcc
 cTCZK+Q==
X-Google-Smtp-Source: AGHT+IEe+AQqGFhfjsu92JGplsdULArEayvXjU+5+1DYELysIMmB5UsL0dXzERblzKBKOy+BGvEmZw==
X-Received: by 2002:a4a:7643:0:b0:5c2:1df2:2737 with SMTP id
 006d021491bc7-5c21df2288dmr4110559eaf.3.1719414076749; 
 Wed, 26 Jun 2024 08:01:16 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5c1d55ce4adsm2131896eaf.16.2024.06.26.08.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 08:01:16 -0700 (PDT)
Date: Wed, 26 Jun 2024 09:01:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Michal Simek <michal.simek@amd.com>,
 "u-boot-custodians@lists.denx.de" <u-boot-custodians@lists.denx.de>,
 "u-boot-board-maintainers@lists.denx.de"
 <u-boot-board-maintainers@lists.denx.de>
Subject: Re: [ANN] U-Boot v2024.07-rc5 released
Message-ID: <20240626150113.GX38804@bill-the-cat>
References: <20240624193035.GK38804@bill-the-cat>
 <e396268c-e106-4bb8-a40d-e0582e556c6b@cs-soprasteria.com>
 <20240625151929.GS38804@bill-the-cat>
 <7b87013a-23b6-419f-a163-2e9f4c44b200@csgroup.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="e4J+l/DawbRFsuh3"
Content-Disposition: inline
In-Reply-To: <7b87013a-23b6-419f-a163-2e9f4c44b200@csgroup.eu>
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


--e4J+l/DawbRFsuh3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 09:20:54PM +0200, Christophe Leroy wrote:
>=20
>=20
> Le 25/06/2024 =E0 17:19, Tom Rini a =E9crit=A0:
> > On Tue, Jun 25, 2024 at 03:12:38PM +0000, LEROY Christophe wrote:
> > > Hi All,
> > >=20
> > > Le 24/06/2024 =E0 21:30, Tom Rini a =E9crit=A0:
> > > > Hey all,
> > > >=20
> > > > Well, once again I need to check my calender reminders since, whoop=
s,
> > > > I'm a week late. That said, looking at the list of changes in this
> > > > slightly elongated period, I think it's OK. At this point we're a w=
eek
> > > > out from the release, so it's time for clear and obvious regression
> > > > fixes. Ideally ones introduced this release cycle so there's less
> > > > chances of unintended side-effects.
> > > >=20
> > > > In terms of a changelog,
> > > > git log --merges v2024.07-rc4..v2024.07-rc5
> > > > contains what I've pulled but as always, better PR messages and tags
> > > > will provide better results here.
> > > >=20
> > > > With that, the final release is planned for Monday, July 1st, 2024.
> > > > Thanks all!
> > > >=20
> > >=20
> > > For your information, I have started testing v2024.07 on my powerpc
> > > boards in operational condition and I have a major problem : U-boot
> > > doesn't get the Linux kernel started before the watchdog fires. I have
> > > to disable watchdog to get it running.
> > >=20
> > > This problem doesn't occur with v2024.04.
> > >=20
> > > I bisected it to commit 340fdf1303dc ("zlib: Port fix for CVE-2016-98=
41
> > > to U-Boot") and I also confirm that v2024.07-rc5 works well with that
> > > commit reverted on top of it.
> > >=20
> > > Any idea of what is going wrong with that commit ?
> >=20
> > Are you able to check the zlib performance before/after that commit?
> >=20
>=20
> Indeed there's a huge difference.
>=20
> Before : 12298074 timebase ticks to decompress kernel
> After :  17145906 ticks, that is 40% more time.
>=20
> But behind that, we also need to understand why the watchdog is not kept
> alive during that time.

That is odd, I would have expected it to have been kept alive.

--=20
Tom

--e4J+l/DawbRFsuh3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ8LR0ACgkQFHw5/5Y0
tyw7Agv+MykY/wqd7I6LutgbprgI8QG26jcJ44xdcdlTKMWmd5Dw0fVeIhUuRl8V
6dkB4IOk15HMD0EoxLTFtuxrkh7USLvab65fHNAKIp61+FV+kKwAzR3iA6cB79Qw
23cFmagXQCwrqdKNt6yNdaD7Zx/eyaJ5v/YbZYx+EyoYBg6Cs8QYqOr8xEPiEqUs
5kE5GGOqGIY4FY6GO/IPr/lVWUlHE5JKBrXmtcXc/lxjmtx9g8gxsNWZsjJtfFsl
ozE1E3WjzdtEh1ikMJb2/RMA29hVqj4BQRsMW0o1oxbW2ylV+uhkR8F2LgQcURCo
jA7+hNcJMki/FkZ+hxu4WsVkmnqcMCEWufOMV/6YWRpAYVcdMp8G/cpJ6+oKY0qQ
Tyho6Hs1Wz7PSuJrEp2kFSyUwZzjdTwK2YKce1SKpoIeFu1CWFeumOguAEnqVodo
X+xv3aePZqqLvX1aC+/nXE6K8fDqa+xX8/8wgyAHqZo1t8VYQLhAtt9dlp0EPU7W
5vsfkHr4
=Kgcb
-----END PGP SIGNATURE-----

--e4J+l/DawbRFsuh3--
