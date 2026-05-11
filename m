Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C09CD37BE
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 22:06:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0FD484671;
	Tue, 12 May 2026 00:06:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tlqtxF9U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A88184664; Tue, 12 May 2026 00:06:04 +0200 (CEST)
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A793E845E3
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 00:05:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x243.google.com with SMTP id
 5614622812f47-479d68a9063so1796406b6e.0
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 15:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778537158; x=1779141958; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/eX6j+6NzaqPB2Z6DRH8LSiVDwc6Oosp68JMMpcuoQQ=;
 b=tlqtxF9UKDsQN1Ba4inS4gGq7Ct5wDPiixAqqNSgCz+yNyq/nUEbcM+KUNqNf6jiF4
 IuNi58BZNU0UD0c0swLsFXc05zK5GgMCf48ciUU66Bw4mQv1IUn9Ct61FQImLEcy8zbl
 JVoM6pf0TSX2r57kOv4YTsLl1E0gg4Xx/h10M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778537158; x=1779141958;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/eX6j+6NzaqPB2Z6DRH8LSiVDwc6Oosp68JMMpcuoQQ=;
 b=lF/iuFh2bFYl+Y1827CvttLinVQSjoD4lSp2jMQ7XibcD9cUEzlsh/OqtFpW0ApvZp
 AbMOxy7iihQ4mzZsKabdUJT1andobef4nN0CtmwwbFqKLjnX8ZSg+cjI/nFxUJ0Dgxnu
 SJmTD865yZ0l8abXY8QW6Wy8fO/xdCXhCOAjCUIhCFZ0SHChI1JxLgCrBfY1fu2YVGzQ
 yP4N1U6lHpfwbUW/uSPOVxxqbt9bBiNNVukwNVVvxVxipujNe6dlTsh/b1RJpHfIQf67
 qTVn/W9dFn1ZqtwLAAefIhrP1UM3r5jn8hE0QPF+S8/D8vHFWDbLLadGnSxm0fPr432Y
 s0pQ==
X-Gm-Message-State: AOJu0YzT7jApgE0EuSy+zVSsPtOUYVMSMZWkavhsYjVLArMOf418815t
 sgkZDJKlv3FMXjGGFtUppNVs9mXvZVv1FvmRwVZmbHZ2wJglZZwMC8IriR3+LLqowEQcRQ58qSW
 OXfbOnYxZ3M+XIuo=
X-Gm-Gg: Acq92OGFbSN+SAx2evGpIcEfUaxRudyd5Q92NELJeh9mneflcCAwyX6rfHWloESUT2/
 KgS91OJlFL3I2fUdObRh4VJBjW0YQewJ6BcGrwTQ50c8sd8ugtVDd5rs7cuk4U5DYSUB3baVz0f
 SXAtL/Qh/UexWjEEkCOVwURhFNuTKcSDRFyapAq4FzmjlnMKa9pIel/1ziW+tTprBy805cH2zFq
 ImkUjzwkwhA7SvLGAuLZd5zHzKryz0oXz6bggbV9YstBs1VbioDRLbe9t4T5nq5j3xSUkgD+/K/
 QbrGt55eI4OGuinsfreWa4cKa8TOT1Cd8z/v2KTKTm/m/w0VLzQPzNPrhZpIJq57AuHL1XCckIA
 o42dxeM46x0WtRtokKODbbT6p/ZaTOrQBLb5icXjj9HdVyTB1tMA5Nw8mo78MVRJcSGqC4wBfV7
 X1LwkM1Bjap11m+YG6yOVp2LP0eWsApN+87HiwZlypXoAG0uuvyANcaUu16QMRB49vmJMwBdXkf
 DUKvh9y4slbbvE9erRs8IBrd5kgWA13poIc3emTmRVFhqRn5cc=
X-Received: by 2002:a05:6808:171a:b0:479:e96e:65aa with SMTP id
 5614622812f47-4824aaf0d7emr6282791b6e.42.1778537158220; 
 Mon, 11 May 2026 15:05:58 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c76935904sm20897432b6e.11.2026.05.11.15.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 15:05:57 -0700 (PDT)
Date: Mon, 11 May 2026 16:05:55 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2026.07-rc2 released
Message-ID: <20260511220555.GM1858239@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MqhZuXTj/p3lNbMF"
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


--MqhZuXTj/p3lNbMF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

So it's release day and I have tagged and pushed things out.

As I mentioned earlier today[1], I would like to again thank DENX (and
the Denk family) for supporting the project for so long, and we're
starting the process of moving our infrastructure to the OSU OSL lab and
the u-boot-project.org domain.

The delta between -rc1 and -rc2 looks OK to me, and I do still think
there's a few outstanding PRs to come in and a few things I should pick
up as well. But, the next branch is now open and so bigger changes
should target that and I will be applying a few things there shortly.

To repeat what I said in rc2 (and will keep repeatint) is that it might
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
May 12th, 2025. 9am (GMT -06:00)

To join by phone:
https://meet.google.com/tel/yyx-dsaj-iwr?pin=3D7760044274127&hs=3D1

In terms of a rough changelog:
- Platform fixes for Atmel, MediaTek, STM32, m68k, Renesas,
  QorIQ/Layerscape, MIPS and TI K3
- Fixes in our USB, UEFI, Documentation, and networking subsystems.
- Updates to our binman tooling

I continue to plan to do an rc release every two weeks and the final
release will be 06 July 2026.

Thanks all!

[1]: https://lore.kernel.org/u-boot/20260511174116.GJ1858239@bill-the-cat/
[2]: https://lore.kernel.org/u-boot/ae_KfGqNrsWZ1rfQ@daedalus/

--=20
Tom

--MqhZuXTj/p3lNbMF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagJSwgAKCRAr4qD1Cr/k
CmdbAP43osFPOiSFw8V1NlU6jYrwkjcZKGaVrOXiVp2Vz80IBgEAnIphGKA7VAu2
HGfk/4ElI5miaaFVDvNGETpiNxf2AA4=
=AFi/
-----END PGP SIGNATURE-----

--MqhZuXTj/p3lNbMF--
