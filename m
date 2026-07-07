Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F817C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 00:02:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9914784844;
	Tue,  7 Jul 2026 02:02:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jF0Ah+0q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2B2D84852; Tue,  7 Jul 2026 02:02:14 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1D1E801A9
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 02:02:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-48611ccd5aeso1790957b6e.2
 for <u-boot@lists.denx.de>; Mon, 06 Jul 2026 17:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783382530; x=1783987330; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QesBLnRsX8mjAMCThlGSGbdnCZQF4RwsxZiDg70itKw=;
 b=jF0Ah+0qdeoE1yyj4crKBG2apdAZWLvS7RmLIV3h7lR1Kj5LPQcmlgyJcSFESK8Yee
 YM71U0dJ3YncYozilUsPzsV8n/2/Al965WfREPk0XK4CWoZuTGiCsEBtzRC8xWYlNgjZ
 Nuo3gYZ6hYwpOGUh+ZFHM/tgZ5C8c3TdD4UZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783382530; x=1783987330;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QesBLnRsX8mjAMCThlGSGbdnCZQF4RwsxZiDg70itKw=;
 b=P9aHHLoxR8HduAvOVF8K3L6CPKdTb4imcu8mEX/BarvThLN2fOYQlDUCH4jmrz5zp2
 9dqBKH15Fyt2N2Dw6U6zq+aG0+StPIsEBlOSjn4Vz0jIn4Y2/99cDpKtpRUzXwe353w4
 vcMbDu5pDjMR8I4tVyeuv4/xV8XglKULkUGMaluXYDZG0mQPzTN6rHccNJRG8RdRNj54
 VowSgu+zeJ5luHp8xSuXevAuRs+nVlgSqT+RQEE69Zu3q2lYkjuFkKCmdLSs0x20dIxm
 TsN6UKa5xcMf9QOtCDk65VTWrJMnAFHZmjgLJPPrre9Mqr9dAA1NOYzaAxe2w31lKo/B
 ihJw==
X-Gm-Message-State: AOJu0Ywm50x32N2eNKYEpiE1wSpsVKq8TskxnpkYFDriIE7F9c/sSBsx
 XR84Re81Jh8xpC+MOU/IOBfMeG4c8DeqyhZ45+P9E/PkucLZLSSVr4K7kBBaxIVjROGySgV/mZV
 dghFnOW0=
X-Gm-Gg: AfdE7clUOuXkQeSXUjFZZ5KHxC/F1BBSra7zFzy7vp1I2Eo7u5zEFte6P2UWt7kdxpH
 gtU5m0N4sosZir1DfuFLN7bpVSBhjrjuuEcjZXTuXu/NiEPyWrnZ1ZZsuZYnQPRjdFyTWXuLCdr
 7Z4nlOoqkOl9mJZEF+puYZpkIXnPFgguGBlBPvB6r+maBH7pfkLcmrzlSDBXIQX5+K01CCz/b9n
 odr+Mc1U7EBr9WyiLXVyh59HMbHinDO99GSyfPbfKJnhVcnMgE2mpl+bgSOOu/6BKYMnVKARqVC
 Yzo80Cc0Bnfjn8Yzk5jnFUQTfxEdROuq4Nf1e6mlUp1TDZ+aeVr/CQ+mzkMnn2JFouESRS6EVae
 sy50g5pqGzvjHOCPQ+YTqmPSS9MIa9gOAeliER9pcVxIq2ptNSVU3nBY7cXfXI7vETpL9zEA/Kq
 YqlTmfw0PULNkv+NXvGJ51m0xetWnckAAhigv24JiIJArNlL62wfmXC4qdHqK2V0Dn2SbrauQtN
 bFxzoMJJsKyF9bw6Ps4Vj1VYDMpay9s5n0yUg==
X-Received: by 2002:a05:6808:199e:b0:486:4bd0:9a1c with SMTP id
 5614622812f47-49fdf20c0e7mr2469199b6e.43.1783382530322; 
 Mon, 06 Jul 2026 17:02:10 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-497d1853afbsm10108839b6e.8.2026.07.06.17.02.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 17:02:09 -0700 (PDT)
Date: Mon, 6 Jul 2026 18:02:07 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2026.07 released
Message-ID: <20260707000207.GZ749385@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JQPVFx1xeq0uOK6D"
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


--JQPVFx1xeq0uOK6D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

So it's release day and I have tagged and pushed things out and I will
pull in the next branch shortly.

The big things to talk about right now are infrastructure updates. For
the mailing lists, as I've mentioned before we have a test instance
setup of moving mailman 2 over to lists.u-boot-project.org and are
working on coordination of a final migration. This will mean turning off
the lists on lists.denx.de, moving the data over, importing it, and then
bringing lists.u-boot-project.org live. I will follow up when we have
more details on when exactly this will be done. The next thing is gitlab
on source.denx.de. We have a new gitlab instance up and being tested
now, and I'll be reaching out to custodians to get them migrated over in
the next day or two, and then we can put the old instance up in
read-only mode shortly afterwards. For this part of the migration, I
expect us to be able to complete that this month.

As I've said throughout this cycle, after this release we'll be dropping
support for building host tools under MSYS on Windows. Users are
encouraged to instead make use of WSL to fill in this gap. If that's
just not feasible, we're happy for someone to volunteer and resolve the
problems we're having moving forward[1].

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
July 7th, 2025. 9am (GMT -06:00)

To join by phone:
https://meet.google.com/tel/yyx-dsaj-iwr?pin=3D7760044274127&hs=3D1

In terms of a rough changelog for the whole release:
- We have synced with the v7.0-dts tag for upstream device trees /
  bindings.
- As is always the case, most platforms / SoCs have received some
  updates.
- Fixes in our UEFI, SMBIOS, MMC, DFU, USB, networking, UFS, pytest,
  I2C, UBI, NVMe, virtio, hush shell commands, squashfs, environment,
  documentation and FWU update subsystems.
- Global cleanup of "gd" inclusion in code.
- The legacy LED API has been removed (thanks again all!)
- Updates to our binman tooling
- Removed patman, it is now its own external project.

I'll be releasing v2026.10-rc1 on Monday, July 27th 2026.

Thanks all!

[1]: https://lore.kernel.org/u-boot/ae_KfGqNrsWZ1rfQ@daedalus/

--=20
Tom

--JQPVFx1xeq0uOK6D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakxB/gAKCRAr4qD1Cr/k
CjjGAQCf4BSf/Se0a8Zf+nIdc5Pvwo8z3ph3sDaaO8BOm//izgEA61s0CzevNRQc
6nwTtWhicWNwxULywQjG5u4fYKavcAY=
=sZfF
-----END PGP SIGNATURE-----

--JQPVFx1xeq0uOK6D--
