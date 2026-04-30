Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9ABBCD13D3
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 18:41:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C281803C6;
	Thu, 30 Apr 2026 20:41:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="D61gN9VI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1866D803C6; Thu, 30 Apr 2026 20:41:10 +0200 (CEST)
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B429B80086
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 20:41:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x243.google.com with SMTP id
 5614622812f47-479d68a90a7so730828b6e.2
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 11:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777574465; x=1778179265; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9PoDW+2CckPp1Oek2XJ285D2jrBzgrvns82+CbQPfHY=;
 b=D61gN9VIt8NyAw8W1N2JfVhmdSxkGe8MimrlvWOVavXxVti43rD41I9N/NCNZxsj6c
 OiHwbWhdjmDMtnrBzIc2HixtS7JHkYEdscTZNtVHY5S28fn2WSJFzj0vmwrwXu+fpX2y
 4z9xiv+36OUYGf9ahqpF214yvAb7XBzU51Q/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777574465; x=1778179265;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9PoDW+2CckPp1Oek2XJ285D2jrBzgrvns82+CbQPfHY=;
 b=akPLGA/1b0/+LxBkJN3yJvRSA8vVKvCswYLDFyJGEgnQ+iI3iIwZT358FRZeIPpb/Q
 +y7HgRbhFKQw0/c7h591fm+KPoJHoNfNb116nd1ky1Jep/WAYrHpEtmSHGlYYHApkea4
 OLBtrgluWrAh6IyCPt/xaRbvFf8yh/15nopBkX7Q4IqwdAhtbqnyVntTPauA+ceToXme
 E7Lpof15PaXCK/MawGX8LT5pViRrKzCk8NfJ27LYgPDTTRjDJG9QAPUaWq0/nrJ7D4DO
 wfLJt7boTouDBLA4OKrozAgMXjXepoZBfwfn9a4A9oJsMVqzD9//ZIiw3rUg/xqbBHTQ
 6FiQ==
X-Gm-Message-State: AOJu0YysdaCguh9M1/lEQ5teFAfP7IyxlK/6ynHXxqYbE4TyAn1ybhPl
 7C105OwjBdfbS48bRm3HJTQnyxG1nc/J+a3qnBb34GvxMhbFGOV+bL+hgm3s6bJMcNXzMoxJXBO
 QnC0ql82v6fIZezQ=
X-Gm-Gg: AeBDietXNHl6BhJzGEX3iNwzFrTUi6ehaQeOHiIpCO7XARuInXl20DTn2u8hJIv/5fX
 QCz2oJL3Rvx6fARcrDUZNVp3m6m9DEWb5VJJ8TppgZZASYmW4sbShN7bsTucVK2cbHKH5h4w/VT
 as6L2F/rTjI7mTL5Xq+kLOQVAKzNgUWftG+LyuT95wy6TKmQf2gpcVZUwA8IVeU6BHi7vTLJj2/
 TrXf9pFYNBYhxlaidLmRZS+MY2XOJCg3Tc5CLNBjQRlBjS7/DYOMsEVKNV9T3n5yMHfXYiSZtRg
 vftFWin0gzU5md4wBk9Cxtpi9UjBdIQmBFClgIb4rg67yiKp9zdyYDLvG3XF1dQuF3YQESMwraC
 AXBNPCoFsjrofyfYB7IgFV+ghYBiSbbnX9j55bPZhzWxpr0ZtMX1mgmQe/4tpT7wVdjqZLS6hsa
 PooUmHh/qaxtc8pF9/jL+9CDYnGZJ+8nG2Z5sFdQQUAAOlz/NB1PfnO8TquDnD2kNJsYVHM2u1P
 K3YqeVDWDwDp1V2vcmq73v0yGFKcMG9e+U4P/tvBEVyZ2voqbkSqihW2cLwcQ==
X-Received: by 2002:a05:6808:6d8a:b0:479:ded7:477 with SMTP id
 5614622812f47-47c5fd6b3cbmr2246931b6e.40.1777574465402; 
 Thu, 30 Apr 2026 11:41:05 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c43e6aec9sm3194627b6e.2.2026.04.30.11.41.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 11:41:04 -0700 (PDT)
Date: Thu, 30 Apr 2026 12:41:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
Subject: Re: [ANN] U-Boot v2026.07-rc1 released
Message-ID: <20260430184102.GB1614990@bill-the-cat>
References: <20260427230522.GP41863@bill-the-cat>
 <82e09819-f796-46cc-8911-a3231d5f9d54@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dBWV1HWWvmaukn/D"
Content-Disposition: inline
In-Reply-To: <82e09819-f796-46cc-8911-a3231d5f9d54@linaro.org>
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


--dBWV1HWWvmaukn/D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 09:25:16AM +0100, Andrew Goodbody wrote:
> On 28/04/2026 00:05, Tom Rini wrote:
> > We're continuing with a community meeting following the release and the
> > calendar link is
> > https://calendar.google.com/calendar/event?action=3DTEMPLATE&tmeid=3DMH=
YzYzQ1dWh2bnRjcm80czVmcDczYmhsNThfMjAyNjAxMjdUMTUwMDAwWiA4OWJlN2I4MTMxMzZiZ=
WMwNmE4M2RlNGRhNTk3NDVmMGFiZDExYzFiODM2MDYxYWUwNmMxYzdkYmNkMThkZjQxQGc&tmsr=
c=3D89be7b813136bec06a83de4da59745f0abd11c1b836061ae06c1c7dbcd18df41%40grou=
p.calendar.google.com&scp=3DALL
> > and once again this is the same time as the previous meeting. The
> > meeting details itself are:
> > https://meet.google.com/yyx-dsaj-iwr
> > April 28th, 2025. 9am (GMT -06:00)
> >=20
> > To join by phone:
> > https://meet.google.com/tel/yyx-dsaj-iwr?pin=3D7760044274127&hs=3D1
> The calendar link ended on 20th April 2026 and refers to a different Goog=
le
> Meet so probably needs updating. I predict some level of confusion over
> which meeting link to use.

I swear Google calendaring used to be better. I checked that link when I
made the announcement but missed that it had ended (despite being the
one for that meeting).

--=20
Tom

--dBWV1HWWvmaukn/D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCafOiOwAKCRAr4qD1Cr/k
CuU9AP9Zxnc7OypzT8FYJ3wXL6efoveSkPm8jw5CPhvjpY8jrAEAnK+APuWp/j6H
HFu8amuN0SFGRr4Xmug5hQB0av4P7wk=
=OK4Z
-----END PGP SIGNATURE-----

--dBWV1HWWvmaukn/D--
