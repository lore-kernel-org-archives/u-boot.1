Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 012F2E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 15:27:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A7AD80241;
	Wed, 18 Dec 2024 16:27:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GEY7Z5Qg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EA3780269; Wed, 18 Dec 2024 16:27:16 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DB838022B
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 16:27:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7b6e5c74cb7so515051385a.2
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 07:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734535633; x=1735140433; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=480H06WZGMyWLXZlrpA3I3aCM/LTduT797PttCsZmlQ=;
 b=GEY7Z5QgGqxJ+XO3OQbBi6BMW2S+Z5Z2wOhOhXjTj0gBDDwpoK4kM28MH1lhruJAVN
 HtKBQ9FG9Qerfy2lmXmM9qV+zjK+XMMhWXa05VQHxU+J5H9Q1SmScDDtZDpFpulxCTOl
 geuHm25sBGzdXKDRSvwVMa26jLfk6VfQQXres=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734535633; x=1735140433;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=480H06WZGMyWLXZlrpA3I3aCM/LTduT797PttCsZmlQ=;
 b=WcbSDXLHve3G2KjjcGtQV+kQNpRz/B7jdIXHuGSCDAfJB+HgBd0jTIbBSk/G/zYMEh
 BoEHhs1Kw33VFV1fVMNnnY5SUCC4nC04mq5OfRShV2tTKyWTjxXGGsedPfkHx81DAEB/
 ezeUPYmEHIOT4yVVnThnvJURjHgX98c9yDhqFcl9cAwN436vKeYuMB4FMgwfVV/7LcPv
 2IVmTcG558WhP4yuwXD2MdzupTqMzWXTlQQrRjLMFLgm6s3d7SRE9dRhd3B6GIcon+LR
 cj/KxKEw4kfJjE5fsX2xImCj0AkTH+F1/U0uC/PRnkfjCJqrEZEcGUOcAVq3pxLc14xR
 ysMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxIhgVLn90laxV3KFQ2eHul0QUy2v5PkwJKhbhdaTYrrr1HMbu4Ryzu2AspeDDvBAaGWfFBGs=@lists.denx.de
X-Gm-Message-State: AOJu0Yw75et4Sb099O6ssxvqiTms8q6YkT06dJVeVZ2XBve7C/WRXTfV
 r6RFxwnIu1TTL0bSDVRSpv36+2hTmtNg2mIzPeNqEs0pijhFj7H3jWwVrwi5K7s=
X-Gm-Gg: ASbGncs9WlJNu+xel0cgCFYrKYXBqQHh0bFmZ4V/x8P8cu86VsUv6xduHi9JcHX6P75
 T/Xy8yReLNMxABbdNz2xwQv6NJ5NY+o9k9/HC5RyXYj0ZszGUjOufW7qOwiLgqzF7xSMAtoY+Jt
 u2poPhmDjM66lqi2w7Pmaz9IxcDOrCp3j6SP2NdIsCB3iCYQoYwHmViZvzo5UFUkJFebpC69WtD
 Mfxz9asrRey/ckkhdDqayrmBiewEZiZPxeRlHn6dxbmBhG1Yksux2Bq
X-Google-Smtp-Source: AGHT+IF5y0JOIjudBcW0fgySqc96/jDDX8FgQz7IL5hLP7R9nVLbBxwsoud78ioD614g6WaGg+6UhA==
X-Received: by 2002:a05:622a:345:b0:466:8616:2553 with SMTP id
 d75a77b69052e-46908eb4b4cmr48431091cf.48.1734535633150; 
 Wed, 18 Dec 2024 07:27:13 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467b2ecf137sm51291221cf.86.2024.12.18.07.27.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 07:27:12 -0800 (PST)
Date: Wed, 18 Dec 2024 09:27:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Vitor Soares <vitor.soares@toradex.com>,
 Paul Geurts <paul.geurts@prodrive-technologies.com>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Subject: Re: [PATCH] imx: Fix usable memory ranges for imx8m SOCs
Message-ID: <20241218152708.GB1505244@bill-the-cat>
References: <20241218090007.692815-1-ilias.apalodimas@linaro.org>
 <93a5b107-63c7-4d44-a0f4-f4079935f8e8@kontron.de>
 <CAC_iWjJxi9mkaAbR6DFHCZ13FNSnkWKSkFLZa_PLpvDOuZq9bw@mail.gmail.com>
 <20241218143440.GA1505244@bill-the-cat>
 <CAC_iWj+Tdayh_YNkMA1xvfG0MujXPwvyUdaL209RH2Ch93ShdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="T/FP+5aQRaH+8RnS"
Content-Disposition: inline
In-Reply-To: <CAC_iWj+Tdayh_YNkMA1xvfG0MujXPwvyUdaL209RH2Ch93ShdA@mail.gmail.com>
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


--T/FP+5aQRaH+8RnS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 04:50:09PM +0200, Ilias Apalodimas wrote:
> Hi Tom,
>=20
> On Wed, 18 Dec 2024 at 16:34, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Dec 18, 2024 at 11:24:45AM +0200, Ilias Apalodimas wrote:
> > > Thanks Frieder
> > >
> > > On Wed, 18 Dec 2024 at 11:17, Frieder Schrempf
> > > <frieder.schrempf@kontron.de> wrote:
> > > >
> > > > On 18.12.24 10:00 AM, Ilias Apalodimas wrote:
> > > > > commit e27bddff4b97 ("imx8m: Restrict usable memory to space belo=
w 4G boundary")
> > > > > tried to adjust the usable memory limits on a 4GB boundary.
> > > >
> > > > I would be nice to also mention 74f88b72219e ("ARM: imx: imx8m: Fix
> > > > board_get_usable_ram_top()") which actually introduces the value of
> > > > 0xFFFF_FFFF. I guess it would even qualify for another Fixes tag.
> > >
> > > Ah thanks, Tom can you amend it or want me to send a v2?
> >
> > patchwork / b4 will pickup a Fixes tag, but if you want to
> > further-reword things instead do a v2 please.
>=20
> Great, I am fine with the current commit message unless someone has a
> better idea.

Fixes: 74f88b72219e ("ARM: imx: imx8m: Fix board_get_usable_ram_top()")

--=20
Tom

--T/FP+5aQRaH+8RnS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdi6cQACgkQFHw5/5Y0
tyyF1gwAhhhIvihc4B14acqw8o+owPH08AlK/RBwfzL3QxzCiilfJDdReOc9T8eh
Fd2gzwEWaeTfFBmN0bCfYjNoVLZztrcSFSRW6EHr5qD/TMGqdjOhzX0XySXIO+Dc
zOdZBJQOnFf0j/YY0EitPezR44dpmmUyRyLwMLM9d6gMazb/DbLOp/BU8eqaY3Ee
P4a93DGE1v5HWH++q3Pr3zd4A3YmcBypoZbDFWxZQeqRQagqB4TTkMt3VC2TnM95
IUuvntLlmqH4oEZ6FQt+RP+zKe6wIgvS/u9K+6EuU9tN2ZPXTx49g4eP//iMRrsp
9eG3BKRu8bkxQd2G7JnWUiGDRuTFLJGLua0ZyLZTlq/OBMReuewQ9NQZsUe7JHe1
D8pTeiQAsChCufezwvrSJER+Wy7xhqM6s6b+SIS+fw0DhrfG3QFCQ7bPUoe+VTOH
eLzqVtWGOk7unwMbcvKBT+Hax34HCnAwCKLlZBV1VFhvIWZB5+bYv0lTVzpCWwJ8
QMS7qjoQ
=K0zO
-----END PGP SIGNATURE-----

--T/FP+5aQRaH+8RnS--
