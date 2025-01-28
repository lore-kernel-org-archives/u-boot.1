Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F03FDC02188
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 02:21:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2986081875;
	Tue, 28 Jan 2025 03:21:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EUZAQ0ge";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C918A81951; Tue, 28 Jan 2025 03:21:48 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5470C81870
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 03:21:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-4678664e22fso45330821cf.2
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 18:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738030905; x=1738635705; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QT4DDXTa4kdEFNCeQ61jUg8pXp9q/lYDvMy1VxTvOQ4=;
 b=EUZAQ0geDJbdE1SDCoimbNilYqf1VqR6GWA9DYCAVrlJJK/6F+V4n+xanjL3+XF85f
 P/wlB1Un8OHRoLneaMdF/gHDIwLXEagPrv32a690ek7TwQ1xCIUEFQhSJp5uM1ifdRUl
 ziIv1zgXlDX0YGfyPq8Mgm3C5s7p7FVDhn79I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738030905; x=1738635705;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QT4DDXTa4kdEFNCeQ61jUg8pXp9q/lYDvMy1VxTvOQ4=;
 b=HzXBpbOrD8p34KwTiQLOG5cOE5SwbqEoXw2QfbU1/fvXaNwefoUf7LOph4jb2wDmc/
 MNqLdV2SPqQxiFc/xjLgeUVIWg5VZsJLjezPLRz+94vEV1lOahdm3GA6DFBf50iIRPRm
 rxGA2cBamOW8lhbk3Sc56bgrd05cOO2e0cSBBMOyziH/fDNW3P8+lDrV48AhpxyW4DyM
 OdBIIwd/25y5FT+lg0Y1S7jdZxHWP1m34Fkgn7wzgqDRGWLyLxpeHPj1p+rbKrFcSiL9
 CXlte0S2crwmDLD7ATdTUr+wE+0+xMW4HDDbs1HGUN9rWHNnOsWJ78/dU5Dmg6rFVdbC
 wmBg==
X-Gm-Message-State: AOJu0Yzc+Na7paL/9qxX3qqThgUBzqf3KpZ6yGMI3n8jSPfMGoc/n209
 ltiRrTz0SrVvf9OFWz5o2V5520g2i80lzA9lULllocZS+FJRMMz0O4bH1Pd04TWHnIQBP1th3cW
 M
X-Gm-Gg: ASbGncsNJL8StRK2vR4T7rADeMzxI8IzRN7MtOnqnTJ3yJ4JJi1WXBZZOAiex4cYQ+t
 mm7dRD8Goxdr2O9pcCl9ZJS4seLkLwIXPbuucI3Zivm0jm3ruoyJH16q8G4rbvkyL18NlFUkXAB
 CGqEL1wkAJ5mxsMZ34q1AnfsZn+snTPqf/xL9IsPFfixokVChDIo+RFeRMD8xezcG7w+Gew4ATq
 Y7aODWWslI+rQ6BjGH/4yRYMKO66+UuzXtgMaT96pMwtgii3Ith0+IzDsFb6n4YTPCXtRaNPwd5
 t0goJiA9AHQvSOg=
X-Google-Smtp-Source: AGHT+IGvzXui71sur6sxrVDY98V4t9mqKScQs5iLqMqx4t7WghkRmhQMSGL83OBHfCP4vwBdtb3tXg==
X-Received: by 2002:a05:622a:181e:b0:46c:a0dc:efb1 with SMTP id
 d75a77b69052e-46e12b683ebmr651246581cf.34.1738030905108; 
 Mon, 27 Jan 2025 18:21:45 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e66b85f1esm45407271cf.78.2025.01.27.18.21.43
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 18:21:44 -0800 (PST)
Date: Mon, 27 Jan 2025 20:21:41 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: [ANN] U-Boot v2025.04-rc1 released
Message-ID: <20250128022141.GI1233568@bill-the-cat>
References: <20250127224021.GH1233568@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="V+w9CD7s+gxB2GYK"
Content-Disposition: inline
In-Reply-To: <20250127224021.GH1233568@bill-the-cat>
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


--V+w9CD7s+gxB2GYK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 04:40:21PM -0600, Tom Rini wrote:

> Hey all,
>=20
> It's release day and so here's v2025.04-rc1. For a -rc1, I think we're
> in fine enough shape. The next window won't open until after -rc2 so if
> you have some outstanding patches that you think should be merged to
> mainline for v2025.04 please speak up (or for custodians, send a pull
> request).
>=20
> As I mentioned elsewhere, I've scheduled a video call tomorrow at 9am
> -0600 and the calendar link is:
> https://calendar.google.com/calendar/event?action=3DTEMPLATE&tmeid=3DN280=
N2tlcXE3aDVtbjlicnNkcm82YnA1bDAgODliZTdiODEzMTM2YmVjMDZhODNkZTRkYTU5NzQ1ZjB=
hYmQxMWMxYjgzNjA2MWFlMDZjMWM3ZGJjZDE4ZGY0MUBn&tmsrc=3D89be7b813136bec06a83d=
e4da59745f0abd11c1b836061ae06c1c7dbcd18df41%40group.calendar.google.com
> and I also send the meeting invite via Google to the mailing list. I
> plan to do these regularly, post release and depending on reception the
> time can be adjusted or perhaps duplicate meetings held.
>=20
> In terms of a changelog,=20
> git log --merges v2025.01..v2025.04-rc1
> As always, more details in pull requests (or the tags referenced by
> them) will result in more details here.
>=20
> I continue to plan to do an rc release every two weeks and the final
> release will be 07 April 2025.

I ran coverity scan, but I'm not sending the report as it's a new
version and so found 134 "new" issues including in code that wasn't
changed. If you have access already I would encourage you to look at the
areas of code you have an interest in for any new defects.

--=20
Tom

--V+w9CD7s+gxB2GYK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeYPzIACgkQFHw5/5Y0
tyypbwv5AQTuyxSCJ8Amq4tBOPl+ypovkZKiEBSsrZ6CFfNWc5verdMMMCM8Emma
7p6J92PTRwnRcmxBlj7fXclhMYsO10wmGQ3Pgv5kaZKvCO0hCXxb6T+xjGgNVIfS
jEvghlfy3A+Kc0VJ3NMF3/v7BnyFpOJEObCUmbAPTCE6/9HOA8adZY103IiCTTsq
MAPnw5IeJrrnPAYSTYLXjCIwn4G5kbgqTiwVwRhEae+y0xn4KhbgkOEf1bmQSSgl
mL4F5Ybq18gN9QiH9UW3Xj9w4y+wvRUy08pw1rR/tToxTcyuX4ob0SXNasC9VsB3
YAXGpSfylSZNExyWIF2jUcg5dfqD9Zmzbc6hewIBwAxV+TR+w1ZsKGhh7rRnqHo0
KvcBL47SFHzFCdkVSltKBniZhbSiImQu25XrOVD10JVVyh1JvtMUzzjvVNDd7x3t
sqzjKG4gizklPdMYbwaJLFYPYwMmZqkzQW92LxFcull8vcfQqO7E/2QAxur9LK4c
gIIn8MGS
=rQfZ
-----END PGP SIGNATURE-----

--V+w9CD7s+gxB2GYK--
