Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 025BBC36018
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 23:53:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6185881F4D;
	Thu,  3 Apr 2025 01:53:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qo4kp2JW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13626810E8; Thu,  3 Apr 2025 01:53:47 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A54FC8035B
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 01:53:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2c1c9b7bd9aso160329fac.0
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 16:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743638023; x=1744242823; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cQxPBDETowQMNHVcUax8qN3HP9CQj544TEhclZoXSe0=;
 b=qo4kp2JW1Um64PqIDDk790RZY2wENly6OQBFtcMHNrrpe9QwvY2w8QD4Rv4Rvreed6
 QKTzuPLaqBiJJpREqZr9nB4dperD7wLmXQucqP22m/DRc0+HM6KZsEYZhwUTw45cmCCJ
 KKktxAW08QgEgCjoG+iFVirURFC+q8WVzW+SM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743638023; x=1744242823;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cQxPBDETowQMNHVcUax8qN3HP9CQj544TEhclZoXSe0=;
 b=GcP2a211zEI0rNoyZP7/BTwZjvA7nkTjsPN7oLyn1fgHaU1iWCD74EUpwrgZe3QwUH
 EstmlRXS/Y8Aqv5YSu8wl6pqMoecukwWBfdgJPAu5xd1k6fJraE3xTpOe7FqlAXpIpBZ
 zEBtjYMij7DK7yLxYn2bHq9jL4x3+NyjuR4brGiyx3rTI4l+CXAIN8S1tAOxKEzzV+bW
 iF/LOkMVA1fdA89ryXKRv4r7JRftJequbTkZFZzyXyxXzIOThRElQvGO4u+QXfVimdiQ
 XXZP4Lxy41ZYANdPPYjeyBmR8untXvKSluKgeYA54qO5wKfTwU1ru1eZ9O59DEkRNSBR
 yfsg==
X-Gm-Message-State: AOJu0YzCv09E1amHmp2kcy8gOOE60L95c6V3GmMccpH9PduY0PsApoCB
 R1snNbaOsT/xErisWsYk6vVAcMv22J1DB6vzCiaiCDgzeYMOmhYDRIGCKFckAc6i2SjHdtk8pCP
 c
X-Gm-Gg: ASbGnctakwRsDJW4EH7dkILc70fbeI3S5zLaEI+3xH6rWYDPnMGAMWTOgg5Q6SbmecU
 ttYM3ciZ3SlwNW0wnRXjNYdebZ4dj+c58eng4U1M65F8a1OFYVjeBDsGmdoc+CDFffgvl2ilbRG
 jZ8/WyxNZhaiR78U+PmxZGD3wA4w1bN7ZhFvvfmXhpB5zHEzK29OpR6F11vzsNO7cQIQ2upypcZ
 QZiCoAcsA28slUmQ7H7GXwSDhR2ZnRVHksTrlydNKwIPdhR5fPdM5bwuuBT3/9UBQi0E4lfGMOM
 zoiwSs+G9qfRecWWGkwgfbUK0lriMkaAvqbjC41hFO6ch8vW0cRHOVpqUx8drvZ+DMr82ULdEjf
 JBFdfdA==
X-Google-Smtp-Source: AGHT+IHPP4Yoju8lwonSnyQjP8lBbyyJrqhaTu9vriEl8biq6pDxjEA/W/+gdfCRtnv13e1ksK0KJg==
X-Received: by 2002:a05:6870:9e45:b0:29e:2bbd:51ba with SMTP id
 586e51a60fabf-2cbcf515fcamr11787043fac.9.1743638023311; 
 Wed, 02 Apr 2025 16:53:43 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2cc845469c1sm31993fac.8.2025.04.02.16.53.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 16:53:42 -0700 (PDT)
Date: Wed, 2 Apr 2025 17:53:40 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: Re: [ANN] U-Boot v2025.04-rc5 released
Message-ID: <20250402235340.GF5495@bill-the-cat>
References: <20250325020130.GF93000@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sIjy5s/AvnnKCwK6"
Content-Disposition: inline
In-Reply-To: <20250325020130.GF93000@bill-the-cat>
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


--sIjy5s/AvnnKCwK6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 08:01:30PM -0600, Tom Rini wrote:

> Hey all,
>=20
> So it's release day and I have tagged and pushed things out. This will
> be merged to -next shortly.
>=20
> One thing to note is that just today a bug was reported due to a missing
> 'fallthrough;' line and in turn we need to fix that in a number of
> places and ensure it doesn't return. This will happen between now and
> the release as I think it's clear enough.
>=20
> While we have been having regular meetings after an -rc release, I have
> assorted personal appointments this week and need to reschedule for next
> week instead.

The community meeting was Tuesday, sorry for the delay, and what follows
are my notes from it.

- I gave the general status of the -rc5 release and noted the "DHCP
  bootdev hunt" regression that was reported and would be handled for
  the release.
  - Ilias noted that capsule update + mbedTLS doesn't work, but it was
    unclear what exactly the root cause was. However, that capsule tests
    aren't running in CI is another part of the problem, and we need to
    get those running again. I noted that we also need to get some of
    the pytest changes that modify how / which filesystem images we make
    (along with exFAT support) need to get merged before we touch some
    of that code more.
- I also noted that given a recent thread from a dts/upstream change, we
  need to be clear that it's expected to call git send-email with
  --suppress-cc=3Dall for those patches as to not spam the kernel people.
- I mentioned we now have social media accounts, asked if Jesse T would
  do the Instagram account that we now have as they're active there. I also
  noted that we have an account on X, and that both Instagram and X are
  linked from the website. Jesse noted that these exist because they
  asked about the broken links on IRC and so Simon made accounts. We
  discussed if maybe it would be best to just remove these accounts, or
  to have someone actively use them. After asking Simon for some
  feedback on this as he owns the website, we agreed to drop the X link
  and work with Jesse for access to the Instagram account. Karen noted
  SFC is on Mastodon and that works for SFC.
- Andre brought up series to fix missing "fallthrough" issues. The first
  part is now posted and reviewed, and wondered if the next part (as CI
  now gets farther and fails more) should be done in the same way. I
  said yes, especially since this next batch will have more
  platform-specific issues that need to be reviewed by the appropriate
  custodian.
- Ilias brought up the MMU patch series again. It turns out that a bunch
  of platforms have copy/pasted seemingly some wrong code around MMU
  setup and so we need to do something about fixing that up. It's an
  invalid, reserved but currently non-problematic flag. Adding a print
  warning may get people to address them. Will have a warning patch for
  -rc1.
- Ilias wants to get more tests running, including capsule updates.
  Everyone agrees in general with running more tests.
  - Specifically, Ilias wants to get more TPM tests written and running,
    but doesn't think extending sandbox TPM is the effort when we have a
    specification-validated TPM we can use in QEMU and that validation
    is extremely important. As a long term goal, he would like to move
    to having the ACS (architecture compliance suite) tests run, when
    possible. But it's extremely slow (8 hours was mentioned) and not
    quite ready from ARM either. I noted we can do things on a tag only,
    and this test would be a good candidate. For the TPM side, Simon
    disagrees about it not being worth the effort for sandbox, but won't
    NAK, He noted that the Chromebook Coral TPM tests don't work. Ilias
    agreed to work with him off-call on these problems as a challenge is
    that the CR50 in Chromebooks is not a 100% specification valid TPMv2
    device. Andre noted TF-A has added TPM support to Pi, and Ilias
    clarified it's something about an event log and is a bit different,
    but does give some measurement. Ilias wants more TPM tests to be
    able to verify some of these new potential security features that
    are coming, ie bigger eventlog.
- Jesse asked about setting some GD flags and how to set them, and is
  arch_cpu_init/etc where it's best done today but, but sometimes they
  need to set some earlier than that. Would it be better to do this via
  Kconfig or no? I noted that we have added more hooks as needed. Would
  arch_cpu_init be ok? I said yes. Jesse will post a patch.

--=20
Tom

--sIjy5s/AvnnKCwK6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmftzf8ACgkQFHw5/5Y0
tyxVSQv/bGFckbNqHRWZKOHuyjkwtRGhqEQ9t5PLfcCt1HDTpsZS17xj3WjKpm2M
AQPJWDjdycMZ2t5DMoc8foOCFJxQHdX4oCqdSADabkiSjemj59EdlV8idvFhp4QC
F5nT/y/lPcNENESimIRsUItqOCOwxi55Azi8CRQyOt9I54FNC2ZVdQvnegP8aDcY
Ez331pfMYB4sKp6dmUFekYPEvL2ojkCcuncWzTwD6yfmAAIgqMXggyL8fZSN9qgQ
BfaOh/XFKWLVzT9PnqMTubtXl0kmCxOL6ohfUtyxVMCt6fi2EDNYj/HmnwF7yFP7
utHF4BmfuML4dHQ/GhT+hEjIywiVlg2itescYFyChtQEFWP1sQalXIuntCeeaeWk
/wuPf2Ntn4uBcsp13t5hB6TP+Eqa6NgPCwOUqqbA1do706O1AJiKdbtbcqJgYgOD
KQjY2SyrF8jodctSSovhrc/yigGGaMVyv6ogO4agSKmFhYlxR3oYGV7dugDfsVys
UrYAaXM4
=Jp/n
-----END PGP SIGNATURE-----

--sIjy5s/AvnnKCwK6--
