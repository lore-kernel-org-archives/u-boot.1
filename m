Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56320CD8CA4
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 19:54:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1FF4838BB;
	Mon,  8 Jun 2026 21:54:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="egr28L4C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F9E583EEF; Mon,  8 Jun 2026 21:54:18 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9406847C3
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 21:54:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-43d26679a6aso3286053fac.2
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 12:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780948452; x=1781553252; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=72/hfuJ4G7oJ7YHiIYYl11MdTwNk8rNkRSyvmx1VIF8=;
 b=egr28L4C1KJJKPyQ/Zi6MYFYCQQdSJPMkAYEjNmP1h7M2Xb2yBwBLRizR1gK+Y7daI
 ow1zH4eubGmMb9dz1HDUsXkKPAZQRN1dDyaqCgomaeRQo4WNs4aoDWv2XxnhfnB80dYj
 ierAELgCqBgLhm2t8NLm7oKVb9DF0VqetrBwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780948452; x=1781553252;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=72/hfuJ4G7oJ7YHiIYYl11MdTwNk8rNkRSyvmx1VIF8=;
 b=EJ2WfSll8hvnFFlFLoJIFDUN1qzBfdEY78R689kUk4ZnYsClR/+vO1gqxQRi3tCDyM
 BGAk67YyMN/y9MNFnVGorybBOQqeuq4yCSf33SpA9o/lscuqpC8tUKSHEdFAKSRVHnQn
 HISAAhDqOZe4O2SY4JRuQrP1IyEHXxyLuerihC8rmUsXBb4HL/YMXxRiN9FyVW4W4ip6
 P8PdNyJFlqkX3yarQYXOOTLmTwQa0dRJCk1fkcupFr0dgIz2Q9v+xxM1FA8hqQRexXdB
 ZfxEWXMYoTlBwSFaNAbh4PZpeV+vDSkUL7oGMLefKSo/B0hrcHKkOtLQaZ1SyRSl3Qbb
 jcCg==
X-Gm-Message-State: AOJu0YzZbtCvhL2d9ietRvAvL2Raz4VyafWVUZR55BDqZ288r9TVy/je
 QOZUBVU5P0WYL4uesEIJ04PcRvH8nz+fJsqdSJ3zvDqnwDNJP71mSgy/xvV7iO7qoCrR5IAxOaH
 rSR7TuF0=
X-Gm-Gg: Acq92OHJb56oXGWcoAAjz0ntQgK3an2Ble7DMSkVq+D0IKuY+x9jdZIFzi5dUxuJuMP
 A7hacP16b3OYiLgmlMSVBRMPwkWfF2BADj+3E0mDiEgQ2LVjo1W8F5MiAEJI7bugIp6FAl20InA
 qdY/zTkt1wwEXsBTBqt0zKLj26TbzueqAvDCD3VBnBlT0SjiSaEeWOGKEmc5vAVPX2/uFpslDkX
 FxGeIWJvagubmy2fAhjVXyQ77aV2WxmLyI2GxPGTdC33ZdHTIz64ebjnfc6epZCPkela6oOt6L1
 I87tyQXw9/x8CN7SsoTKDMgGgQg/nKJgwB6cWz3ChRMhtP52hgKg16tiGpBO7blMtKQQwvNaDw/
 5BjFRNYZ9O7MYiFS/UiHktIM/fsDb+Uuc5awVQVbB/F8YgnwmS8VqgQkpNnOqp4qBjgCOZGOVGJ
 2L50uJFgasIjt/pA+P0K5zXaOeHBkIiZQ+SvIb4viAEMLlkQaDpxJEp6Lqquom6kC3J1rTiOjtU
 a4nZWCUSzx/W23rke1tiOzVJwhtCgZG1Vka18wzJhObupMTOfkBcd3CVwsSbg==
X-Received: by 2002:a05:6871:3418:b0:43d:22a7:3e47 with SMTP id
 586e51a60fabf-4413d868388mr9157930fac.28.1780948452494; 
 Mon, 08 Jun 2026 12:54:12 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-440d84c0ce2sm16923828fac.16.2026.06.08.12.54.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 12:54:12 -0700 (PDT)
Date: Mon, 8 Jun 2026 13:54:10 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2026.07-rc4 released
Message-ID: <20260608195410.GR382693@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="b+u2zUyXk9mumWxP"
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


--b+u2zUyXk9mumWxP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

So it's release day and I have tagged and pushed things out.

Continuing with what I said in the -rc2 announcement, I've updated all
in-tree references to use u-boot-project.org. We're working with OSU OSL
on infrastructure migration and once the next part is ready to move,
we'll talk about a schedule for that.

The delta between -rc3 and -rc4 is very small and looks good to me.
If there are fixes people know to be outstanding and haven't been
applied yet, please reach out and let me know.

To repeat what I said in rc2 (and will keep repeating) is that it might
really be time to retire support for running our tools on Windows under
MSYS, rather than something like WSL. The move to support more modern
OpenSSL versions has hit a lack of support problem in MSYS[2].

We're continuing with a community meeting following the release and the
calendar link is
https://calendar.google.com/calendar/event?action=3DTEMPLATE&tmeid=3DMHYzYz=
Q1dWh2bnRjcm80czVmcDczYmhsNThfMjAyNjAxMjdUMTUwMDAwWiA4OWJlN2I4MTMxMzZiZWMwN=
mE4M2RlNGRhNTk3NDVmMGFiZDExYzFiODM2MDYxYWUwNmMxYzdkYmNkMThkZjQxQGc&tmsrc=3D=
89be7b813136bec06a83de4da59745f0abd11c1b836061ae06c1c7dbcd18df41%40group.ca=
lendar.google.com&scp=3DALL
and once again this is the same time as the previous meeting. The
meeting details itself are:
https://meet.google.com/yyx-dsaj-iwr
June 9th, 2025. 9am (GMT -06:00)

To join by phone:
https://meet.google.com/tel/yyx-dsaj-iwr?pin=3D7760044274127&hs=3D1

In terms of a rough changelog:
- Platform fixes for STM32, Raspberry Pi, Renesas R-Car and NXP i.MX
- Fixes in our USB, networking, and NVMe subsystems.

I continue to plan to have one more rc in two weeks and the final
release will be 06 July 2026.

Thanks all!

[1]: https://lore.kernel.org/u-boot/20260511174116.GJ1858239@bill-the-cat/
[2]: https://lore.kernel.org/u-boot/ae_KfGqNrsWZ1rfQ@daedalus/

--=20
Tom

--b+u2zUyXk9mumWxP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaicd4QAKCRAr4qD1Cr/k
CmEuAP9Kp09OYz66DUlDW/vy7WwMMAelDwnWze00nvEag5BnkQD8CoesnIqBz22Z
J4MJxwS00giHPQ1ShGNvkb+yFGjRUwU=
=wJj9
-----END PGP SIGNATURE-----

--b+u2zUyXk9mumWxP--
