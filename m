Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A7AC3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 15:47:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF19D887D3;
	Thu,  8 Aug 2024 17:47:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="puKP+epd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDEDC887D3; Thu,  8 Aug 2024 17:47:07 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91A0088B77
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 17:47:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7093472356dso598128a34.0
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 08:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723132022; x=1723736822; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uIY6Bmj3rBpcJcp1RoLcksIu6ZKf/si6ed0glqIMXfE=;
 b=puKP+epdz/0kShJ/bdrpwDpm/rFKQ8/2PE1mSHlHQZSQqMEbElj42F2GYlIVoFnLDb
 ZUgiLxL6MSXkic+VHT44GpgDBn9U78po2l1nEkBWlr4K5KKQz3gMLyep0Yq7JVbhBsmh
 2+FOYNC7qBrdnFeXKVawG6ZCejgsreSvgZpzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723132022; x=1723736822;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uIY6Bmj3rBpcJcp1RoLcksIu6ZKf/si6ed0glqIMXfE=;
 b=SmHEWpCLE5I5Zg+tzjgA1xFX3WLAsk/o/FjLiV0ITS3r0OipLnITJipna5YP2Yt8d4
 4ftRF3iiu/fxymnAclY+UiICqAnzr5x7PpqM0SmDJvMK8o33A4bJ/qhF6lHMj0neiZwi
 6cqRkLWOGRM7aVrw6lhmpJ6QMUhvd1lzizvA98XUH9alSM/dOjcXNa3O2tY530Wc95Nx
 pHhCQdHzMjdfPx+IasAgyAlXYWGih+OjW0yXOb7nDeK4qeZejgzvQSokkKDlh9/GBSWi
 eT8Vzg2YJW4ydAcOtmBOxW+n3ysZLB6Y/PIPwqLl+LN0cWz6GnwmbRPJq3ANi4LcjJ7S
 JDwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCOWeKYAlNFQahIh2LgyPc8UG5BV+uc/eQhqNgrtgn8Ok3NrlXuW9qctwsMGh/qBV9kIyJmOD2BA/6OkG+idxyR0gXDQ==
X-Gm-Message-State: AOJu0YzCVL2DGkmYkegK/hSvoamrecLo354AZBlqtHaYleZJt1Fejzcv
 1Y2BrUBqr3mmb4uq6B41z0wcvJIMDtmyOeBhijU0BqM1xY2bFifKqdr7fwYul1s=
X-Google-Smtp-Source: AGHT+IH0kPdJc4ebNtxuxaRkm30mlYM/2BydKKuOLuh9q97noi2yxpF9yww9Xm6Bvnm435AdTra1oA==
X-Received: by 2002:a05:6830:f8d:b0:709:419f:2ae7 with SMTP id
 46e09a7af769-70b4fcb159bmr1957145a34.29.1723132022030; 
 Thu, 08 Aug 2024 08:47:02 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-236.totalplay.net.
 [187.191.8.236]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70a3a750dfcsm5516802a34.52.2024.08.08.08.47.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 08:47:01 -0700 (PDT)
Date: Thu, 8 Aug 2024 09:46:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Prasad Kummari <prasad.kummari@amd.com>, u-boot@lists.denx.de,
 git@amd.com, venkatesh.abbarapu@amd.com, git@xilinx.com,
 jagan@amarulasolutions.com, n-francis@ti.com, d-gole@ti.com,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] cmd: sf: prevent overwriting the reserved memory
Message-ID: <20240808154658.GN1626301@bill-the-cat>
References: <20240806120659.686073-1-prasad.kummari@amd.com>
 <20240807211221.GK1626301@bill-the-cat>
 <e62e3c69-e9c4-4a0a-bf65-c21082ce7e27@amd.com>
 <CADg8p95DQvRAXdon_Hx+mYst-u9HTfprQ=6jwgSQThWX=GDSZg@mail.gmail.com>
 <6e5c61cc-5d90-4d2d-bcb2-d854bdb0db1f@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CUnY8/mBh83eyuEb"
Content-Disposition: inline
In-Reply-To: <6e5c61cc-5d90-4d2d-bcb2-d854bdb0db1f@amd.com>
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


--CUnY8/mBh83eyuEb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2024 at 01:18:44PM +0200, Michal Simek wrote:
>=20
>=20
> On 8/8/24 08:22, Sughosh Ganu wrote:
> > On Thu, 8 Aug 2024 at 11:05, Michal Simek <michal.simek@amd.com> wrote:
> > >=20
> > >=20
> > >=20
> > > On 8/7/24 23:12, Tom Rini wrote:
> > > > On Tue, Aug 06, 2024 at 05:37:00PM +0530, Prasad Kummari wrote:
> > > >=20
> > > > > Added LMB API to prevent SF command from overwriting reserved
> > > > > memory areas. The current SPI code does not use LMB APIs for
> > > > > loading data into memory addresses. To resolve this, LMB APIs
> > > > > were added to check the load address of an SF command and ensure =
it
> > > > > does not overwrite reserved memory addresses. Similar checks are
> > > > > used in TFTP, serial load, and boot code to prevent overwriting
> > > > > reserved memory.
> > > > >=20
> > > > > Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
> > > >=20
> > > > This is a much more generic issue that should be looked in to with =
the
> > > > LMB rewrite that Sughosh is working on.
> > >=20
> > > yes. And is it going to be the part of his series?
> > > I expect that if he accepts this will be done on the top of it and th=
ere is
> > > likely no reason to wait.
> >=20
> > This change would be needed, but in a different form. The patch, since
> > based on the current master branch, is assuming a local lmb memory
> > map. My series is doing away with that, and so we will no longer have
> > the lmb_init_and_reserve() API, for example. I would suggest that the
> > patch be put out either on top of my patches, or ideally, once the lmb
> > patches get merged.
>=20
> I care that we can't overwrite reserved memory by any of load commands.
> Better to be fixed earlier rather than later but up to Tom to decide.
> From my perspective this is incorrect behavior which is fixing issue and
> likely this can go to 2024.10 version.
> Your LMB series is likely going to target 2025.01.

So, from my point of view, this is a longstanding issue that I get why
people are concerned, but I think it's missing a bigger point. For
network loads, OK, no one needs physical access to do something
malicious, so yes, it's important we check there every time. For
filesystem loads? There's far far too many production devices using SD
cards, so yes, a malicious actor needs physical access, but not much.
For flash (SPI or NAND), at that point why doesn't the malicious actor
just use "mw" instead? The device is in their position if they're able
to hook up probes/etc.

So my current thought process is that yes, fixing SPI and NAND and all
of the other forms of reading (outside of "cp") need to be fixed, as a
follow-up series to what Sughosh is doing. And then reminding people
that CMD_MEMORY is dangerous and perhaps think about splitting mw/etc
out from "cmp/base/loop" so that CMD_MEMORY can be disabled for boards
that want a more secure feel.

I'm open to being convinced I'm wrong and this is a serious problem to
address now, not later, however.

--=20
Tom

--CUnY8/mBh83eyuEb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAma06GsACgkQFHw5/5Y0
tyzsKAv8CzXbBozbqx7wx2W8XJS5ZGe5J7y6Pdkh565Pelqp8IWhvjMO6ej/GrNw
CyCpph3X4CntWH30IX5dMbnrCHrbQudF0eVyGhBq6KYkSayt6QDyZuHZwfJfq6tN
UZ6gUH8tgpHP8GoHa0MT52f+wteXB9ktxvijN7A5GnW5pfQVk5DSwiAOyu+8IA8O
Qb9pjTYExwbfekmca0ZUHrqzc2eDlLvI6ECrdt6ZgVH58mPLO/laI+lXJ+s/3RjJ
Kyr4GSC7ziZZtjqyL43x1rKpUedPLeRN7k4eGNRjHS36hwV62XOqLcjAQc9fDFmc
/qsm8NX6Uc3kixbkQwwDeKOcY+oidZNUGxady6a4BoENehLsLH+f02zy3rzyxyjm
ynkFDUZcrMoS68PzCqBZfux+51Y+Xc0ufeHwBI2gLWy1hwRhDQZe5/lvCbQ5GlQ4
y306O97xxI8uW4qAkcKpRnD9bEZtzIeR/x/XVReS9r0mamhB1KILLCmPsc/LzFbp
fwPfFL4Z
=Z9vE
-----END PGP SIGNATURE-----

--CUnY8/mBh83eyuEb--
