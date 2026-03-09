Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C61D8FCA17E
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 19:52:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 172AC83A8C;
	Mon,  9 Mar 2026 20:52:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UDnB03n0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7310483F6D; Mon,  9 Mar 2026 20:52:49 +0100 (CET)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9B1C83A8C
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 20:52:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-67bb5e4d06eso416505eaf.1
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 12:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773085965; x=1773690765; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q1eh9aL0bB6AlON4iZ60d9w0xToODj0otb5stdvFLHM=;
 b=UDnB03n0NkGuUv2UPLAEGeho0xTYUzwSa88OaEClLACzLrCAqs9hT6PAF/wwoiCc64
 joM5V81T0xMpTS96h0hhuSlFlqqVIewaU45diIdrmXPFskWCQxS6wpeQE9/9/cZjM5xr
 ODY9fSW+RjPy8w/nITyrDMq6ZX6ScgphyPDCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773085965; x=1773690765;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q1eh9aL0bB6AlON4iZ60d9w0xToODj0otb5stdvFLHM=;
 b=pcHRXCQwTf1YqmwNkmzIm53LdI7M8AHrZQtMp5CayCLyrP6oUuExgTv6e4f5WicIGM
 yWFWQOnCX8uIA7zXbj0/DMMkklyZaIzm0dyEnKYdwxwJFQL1Tz5C9X/Zjj9m1zO5pIdG
 h3XHZLsM+6OxrcP0NY4IsNmG2Zkf/4GZJ8LQmHppqBtuwvjTp5qjbmFGxCxEIGSJf/HY
 IWIt1qH3HaqeHQezrB0A3mcEjqhmY/8kPHwEHXl1T70wHXUe12DKYuvbvJXz8Eb35ZhN
 kilyKjTsBE5bHf80wMzUHfFwbe6j6Yp+kIbW1Tzrc0z6qGNPH4E/61M341wp1U2Ikuyp
 /JEw==
X-Gm-Message-State: AOJu0YwdS/mKLYq5AYQoM7tmsrMqxEIx6N46P5qGi9uX7aeV9W8/Kh69
 BC8t1modBodndpJUSX8DKfEYZJmKSaatbrztZ2fwAhNR9OKe6dDJtYZ5zxI4ZHYgpYxuapzGO9h
 tXX+m
X-Gm-Gg: ATEYQzwP+jxLz8RbdJ24GeORtpq4q6lRE5zb9MU2KXmkrXafAYN23Dvh02Hl0j45jdA
 7fuukai0IOavDOeUUBy305of/h5fwpuH7ObDz5P97eKv74b5tnQFdXHL6OLOfOTxEmNw/5uK4vb
 HM1VKMJ3a9o5qqHa83lEPNp7pvJT30Glr1M1YEN+Q+z/gc/XQPmAWPhXJ9Bayo6MjgM5LSmYET3
 Ejh17rUPc9TAE547wwkvSBvTicBKiIUwohjX9G4fsHxFypyCWhcyyv82oR/ghE8xpcTVyAtvNbQ
 Su7iD/FQZIdDAIhMh6FOhjjEtO34VdB+dCPzcaO7UR/7XnyeRp7cPu9qHIaa375r6ERh/s63SP7
 FtnCvqdvTDajGUl5hfW14TDevwLZiMfzBmdRgvJpuZr9Yrsu3D3dxQa3e0cusiAftAKp/iSGNlX
 Hu3gjkDg4Ok8dFe74L6cjU+/aD8Kl2Wlxis8WGHo1uW3bJ5PuJ6y6SBfAY5r51wtJRYgBrKbuyW
 1TA3dYS5gztkEZfT5cyQjo+aX8A9dydNqKussHdBsSBs+GQULYIaK1h
X-Received: by 2002:a05:6820:2214:b0:67b:baae:3333 with SMTP id
 006d021491bc7-67bbaae4cb5mr891521eaf.47.1773085965442; 
 Mon, 09 Mar 2026 12:52:45 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67bb230e0f1sm2874552eaf.13.2026.03.09.12.52.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 12:52:44 -0700 (PDT)
Date: Mon, 9 Mar 2026 13:52:42 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2026.04-rc4 released
Message-ID: <20260309195242.GE1388590@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="M4LPtwOKQcsB6FR1"
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


--M4LPtwOKQcsB6FR1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

So it's release day and I have tagged and pushed things out. This is a
reasonable delta from -rc3 I think. I believe right now there's no open
regressions that I'm aware of. If I'm wrong, please speak up now so we
can get them resolved.

We're continuing with a community meeting following the release and the
calendar link is
https://calendar.google.com/calendar/event?action=3DTEMPLATE&tmeid=3DMHYzYz=
Q1dWh2bnRjcm80czVmcDczYmhsNThfMjAyNjAxMjdUMTUwMDAwWiA4OWJlN2I4MTMxMzZiZWMwN=
mE4M2RlNGRhNTk3NDVmMGFiZDExYzFiODM2MDYxYWUwNmMxYzdkYmNkMThkZjQxQGc&tmsrc=3D=
89be7b813136bec06a83de4da59745f0abd11c1b836061ae06c1c7dbcd18df41%40group.ca=
lendar.google.com&scp=3DALL
and once again this is the same time as the previous meeting. The
meeting details itself are:
https://meet.google.com/icv-nvmv-dbf
February 24th, 2025. 9am (GMT -06:00)

To join by phone:
https://tel.meet/icv-nvmv-dbf?pin=3D5493171900556

In terms of a rough changelog:
- Platform updates for Samsung, STM32, TI K3
- Subsystem updates for EFI Loader, UFS

We have one more rc after this and then the final release will be 06
April 2026.

Thanks all!

--=20
Tom

--M4LPtwOKQcsB6FR1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaa8lCgAKCRAr4qD1Cr/k
CsFPAQDwjA8Diagpr0AxnvM6klzzDglmlmygu3KJ3HuaBllPOgEAsu9vzLYa7LbR
y8eaQ846tQebN9zCfzyjsBHFj6zFywE=
=bt/x
-----END PGP SIGNATURE-----

--M4LPtwOKQcsB6FR1--
