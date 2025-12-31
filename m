Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7343DEE645A
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 17:18:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0628840ED;
	Wed, 31 Dec 2025 18:18:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fCwfdcaw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F23F840EE; Wed, 31 Dec 2025 18:18:11 +0100 (CET)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62D14840E6
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 18:18:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x343.google.com with SMTP id
 46e09a7af769-7cdd651c884so3761579a34.1
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 09:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767201487; x=1767806287; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1BQOBK0OB7M0Mao5UdYOk2FPO7wmNkReAOPYfAqKZbM=;
 b=fCwfdcawkdRBCU2a7LnticqkaBo5AfeNtCC8sHEmR2rinVJ9ORrf5DwhONhxGdt+3K
 MwdWmvAln1fEy5bD2morSt3xzm4OGbvdU49l1ASl9GzVRFgN2TH/OuJvk8h0bcuIq8MH
 ZmqpbuRl0ksGT7oXtropMyBjX45slyQcnznb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767201487; x=1767806287;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1BQOBK0OB7M0Mao5UdYOk2FPO7wmNkReAOPYfAqKZbM=;
 b=jWyUvRzmU1lQ6smVlTybkvGxoYbNnQGaZ1j62RfD47zwB2ODJSBx3FJgRwNkUMVo8f
 rcwZT82rGZ6vofp20bbgjcWIEl+qI92e9xqd3gLxaw2vhXYhrLxZ2dO3v77Xz8s9dGWQ
 LZ1HaaftLOdrs1EI/L8ZkeYchLfJsIT9ADPbIKw9K8mOZyjPs6xYEyUEviUmRTCaIVLE
 J2aWbDLF05wzYxyVPkIbpv5bHex9We2WBy2N5RVc0n+ETssK6VNw/bk8aoZgnrLvPF75
 W9JRfyVueKWCDzKm+O5nYs4KhnEYYPAe1wB+KZ+s2fCBuZPXioMSJrnZFYJpwTp4+7WI
 UBqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwksvrBTIBENLRRQ5eS2QbKNXVtNJ7Qj3BlfRmnMUEeFDnzn56uCwX+sUgckZXMma3fOmB8zU=@lists.denx.de
X-Gm-Message-State: AOJu0YyuL1aBvumqBTzU9Oj+3np3lF8VteWwQ9/XJQgDJiVZNOprkRtK
 pyK6hkfqUR7IrqwhFf+eEVpMddaZjo9evsYN4FeCxnjebNbT+A1sCUJLzgmLPlHB9B8=
X-Gm-Gg: AY/fxX7/QIV04HdbEgq0bLaQTVHTnRmss8UgGTrOXPlN/6JN0J+G83SswyoD0++qJzj
 uqUWwdXfFuZBeu6Z03Yf3BX5Ag0OiTI35dLL0i87Y69x0JBGT2EWy0H9QDX9qNueWCQoPQU67Z5
 TNHNea1Fwhbn7eJivgZSwpMU5k8b8J72WP82HzzAS+aff4IUe0FaCyu8PtYkrW9YZi2qJNMQ0KP
 AKRm6PqFZFqjdawJmxZPO5DOEsF+8CvcWxGeXPMbh0Zfo9PAZzMF5jzDsXTayWua+qRFKu0dVAo
 DSvWKk6+gi3Ha48uOqvDzFPIn/rHgSldAnBOKG+MUnvkqLraw8hPGQtnR7SM6exXQQrEJN1t6xl
 TtCwiR0rS6z3IICMoz7gFCfGtGs+d7UgDaoNp9ZIgYWdqjWiCmigdwwD1uPAfdiIKtSLFzc24pM
 Hr8M0/uINCIoGJj71dKHX+aW04VvGgLemszxthwXloCOXTrkvLR9N913sIObG0jn2/IbY8QNZmL
 1fMgyYNM9eAuQlVoi7s89PCV08ehAooh3CpW4c=
X-Google-Smtp-Source: AGHT+IHkFeAqi0kq0qZOXxE0Ruqq/Qq7g5EDTla6sd2FfvYzxZv0/MxuU6Dr6iZxvqxoaDtLgULBzw==
X-Received: by 2002:a05:6830:44a2:b0:7ca:d139:387c with SMTP id
 46e09a7af769-7cc65d71dbcmr24649396a34.5.1767201487017; 
 Wed, 31 Dec 2025 09:18:07 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc667ebea3sm24767464a34.22.2025.12.31.09.18.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Dec 2025 09:18:06 -0800 (PST)
Date: Wed, 31 Dec 2025 11:18:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/3] test: env: Add test for environment storage in
 SPI NOR
Message-ID: <20251231171804.GD710860@bill-the-cat>
References: <20251223143130.16266-1-marek.vasut+renesas@mailbox.org>
 <c31bd8b3-2604-4193-abba-6815845e8967@gmx.de>
 <bb3d1ff2-4cc1-48da-a47f-3aef44277791@mailbox.org>
 <20251223233205.GG847766@bill-the-cat>
 <56df64f1-f3f8-4fb8-b85b-e1b1e30f5f49@mailbox.org>
 <20251231161120.GB710860@bill-the-cat>
 <364a3396-8c37-49af-b4da-01ab5dfc5c16@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Pasfik5NysC8eGPr"
Content-Disposition: inline
In-Reply-To: <364a3396-8c37-49af-b4da-01ab5dfc5c16@mailbox.org>
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


--Pasfik5NysC8eGPr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 05:50:31PM +0100, Marek Vasut wrote:
> On 12/31/25 5:11 PM, Tom Rini wrote:
> > On Wed, Dec 31, 2025 at 05:07:31PM +0100, Marek Vasut wrote:
> > > On 12/24/25 12:32 AM, Tom Rini wrote:
> > > > On Tue, Dec 23, 2025 at 07:55:45PM +0100, Marek Vasut wrote:
> > > > > On 12/23/25 6:32 PM, Heinrich Schuchardt wrote:
> > > > > > On 12/23/25 15:31, Marek Vasut wrote:
> > > > > > > Add test for environment stored in SPI NOR. The test works in=
 a very
> > > > > > > similar way to the current test for environment stored in ext=
4 FS,
> > > > > > > except it generates spi.bin file backing the SPI NOR.
> > > > > > >=20
> > > > > > > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > > > > > > ---
> > > > > > > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > > > > > > Cc: Jerome Forissier <jerome.forissier@linaro.org>
> > > > > > > Cc: Simon Glass <sjg@chromium.org>
> > > > > > > Cc: Tom Rini <trini@konsulko.com>
> > > > > > > Cc: u-boot@lists.denx.de
> > > > > > > ---
> > > > > > > V2: No change
> > > > > > > ---
> > > > > > >   =A0 test/py/tests/test_env.py | 99 ++++++++++++++++++++++++=
+++++++++++++++
> > > > > > >   =A0 1 file changed, 99 insertions(+)
> > > > > > >=20
> > > > > > > diff --git a/test/py/tests/test_env.py b/test/py/tests/test_e=
nv.py
> > > > > > > index 383e26c03b0..48e31f19b3c 100644
> > > > > > > --- a/test/py/tests/test_env.py
> > > > > > > +++ b/test/py/tests/test_env.py
> > > > > > > @@ -457,6 +457,26 @@ def mk_env_ext4(state_test_env):
> > > > > > >   =A0=A0=A0=A0=A0 utils.run_and_log(c, ['cp',=A0 '-f', persis=
tent, fs_img])
> > > > > > >   =A0=A0=A0=A0=A0 return fs_img
> > > > > > > +def mk_env_spi_flash(state_test_env):
> > > > > >=20
> > > > > > Thank you for adding the test.
> > > > > >=20
> > > > > > Unfortunately pylint doesn't like your code. Please have a look.
> > > > >=20
> > > > > Is this something we run in CI ? If so, CI builds did pass.
> > > > >=20
> > > > > If not, how do I trigger this ?
> > > >=20
> > > > We only run pylint_err not pylint in CI. The "make pylint" target h=
as
> > > > been unused for so long that the baseline itself is out of date. I =
don't
> > > > object to trying to improve our python code to match standard pract=
ices
> > > > better, but this isn't the place to start adding complaints.
> > > >=20
> > > > All that said, a newline before a new function is just a normal good
> > > > practice and so at least the quoted here example should be fixed, j=
ust
> > > > like if it was in C :)
> > > There is a newline before the function, the code is incorrectly quote=
d in
> > > this discussion, see e.g. patchwork for the actual content of this pa=
tch:
> > >=20
> > > https://patchwork.ozlabs.org/project/uboot/patch/20251223143130.16266=
-1-marek.vasut+renesas@mailbox.org/
> > >=20
> > > So, what exactly should be fixed in this patch ?
> >=20
> > Thanks for explaining. The only problem I have now is you didn't give a
> > cover letter explaining the feature and so I need to come up with
> > something when merging the series as a merge commit. I can do that, it's
> > just easier when I don't have to.
> 2/3 basically describes why this series is needed, and implements the act=
ual
> functionality. I can send a V3 with no changes and cover letter if still
> needed.

I'll just paraphrase things from 2/3 and note this extends tests. But
for future reference, please do cover letters. It both makes my life
easier (b4 shazam -SM, re-read, commit, begin tests) and helps make sure
I don't mis-characterize something.

--=20
Tom

--Pasfik5NysC8eGPr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaVVayAAKCRAr4qD1Cr/k
CpU2AQDHNzKHyEMGklhy/Ge418amRDbGdxNmQDWIHMyZjN5y6wD/a5XFNaGaYQWL
ALYnAYEcC+b5utmHogdPyx6BxoQL2gI=
=EYpc
-----END PGP SIGNATURE-----

--Pasfik5NysC8eGPr--
