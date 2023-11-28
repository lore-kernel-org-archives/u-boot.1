Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB04C4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 21:18:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 655F58778C;
	Tue, 28 Nov 2023 22:18:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OZYQoMIC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11FE987791; Tue, 28 Nov 2023 22:18:20 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 732C887776
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 22:18:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5cc3dd21b0cso59110837b3.3
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 13:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701206296; x=1701811096; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rOpcZC4FRGletzCq4LXLUpzTfDs/YLBkBmKfaWaVDYo=;
 b=OZYQoMIC7STa1NNJyE1hLjmk7dWLB271tjtzGq2EqMdGCYNGkwmQ0mnLTgn0sJqnLa
 HYiXsUUygj8UhMvj2L+FnEjY6/CK/ANkuBxhYsJVxVfLK7rX1FICku7bqrOtwIm0/EQB
 gT0wjZAGxWsMvZWCNZUUs2XMzOdfj2AHLVfbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701206296; x=1701811096;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rOpcZC4FRGletzCq4LXLUpzTfDs/YLBkBmKfaWaVDYo=;
 b=FEtgMxLhbykLOLUCdM6sXBNOpK7dkV0c5UCNTW3GVBEMeOngS/FckwnJEwhBumtHbr
 nYtojdY8xde0sjQgeq4Tq+Jeg50hSA2VhUZ23V+00RzjWDA14KUaoINTU24loBXBq7Ff
 kruPqZbV0spObeDH6DG3Jw3SotJ/GYeWc4l7Jhe8qKpzQAoEzkuSJd2exciat7XJuQMJ
 fPL//WRx8AaPSqsXVPyl2pObAIelRQKOfol0c1pD86ySn/85o8qxxFnwELtv0V3Y+B3D
 kXNq0TZYfrt9xNpYFwXYOi1eBDkJMO1+DiVQqerCi8fK7BKgCVC4JBkNNuUDR42VMFZU
 fGLw==
X-Gm-Message-State: AOJu0YwQZiZK0MVJ1R8Lh52zzsdJ+Dv2RWkY9S/p4wqUCfFGpKE/EGLu
 QtJIq38LAV8iTubXl/bxXrzHLg==
X-Google-Smtp-Source: AGHT+IGNXTKqr56reRkyTwHt6BbkmFBNlbUlieZGjlqU2tZxqi1yiu2tuyP+0cX6JBreNtmLF4txOA==
X-Received: by 2002:a05:690c:250b:b0:5d1:e9d5:baa8 with SMTP id
 dt11-20020a05690c250b00b005d1e9d5baa8mr1884378ywb.32.1701206296228; 
 Tue, 28 Nov 2023 13:18:16 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4f9d-49d7-ae37-6b11.res6.spectrum.com.
 [2603:6081:7b00:6400:4f9d:49d7:ae37:6b11])
 by smtp.gmail.com with ESMTPSA id
 w204-20020a817bd5000000b005c98f9d2444sm4126632ywc.3.2023.11.28.13.18.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Nov 2023 13:18:15 -0800 (PST)
Date: Tue, 28 Nov 2023 16:18:13 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Bin Meng <bmeng.cn@gmail.com>, Eddie James <eajames@linux.ibm.com>,
 Ivan Mikhaylov <fr0st61te@gmail.com>
Subject: Re: [PATCH v3 31/32] bootstd: Introduce programmatic boot
Message-ID: <20231128211813.GC2513409@bill-the-cat>
References: <20231118210547.577026-1-sjg@chromium.org>
 <20231118210547.577026-32-sjg@chromium.org>
 <20231128182117.GA2513409@bill-the-cat>
 <CAPnjgZ3xjAoupUJznP1Qs0vuyK+n3X2kz2VXbgBT7KLcLcxNAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5nd/4s7F0Z3GTloR"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ3xjAoupUJznP1Qs0vuyK+n3X2kz2VXbgBT7KLcLcxNAA@mail.gmail.com>
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


--5nd/4s7F0Z3GTloR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 03:14:30PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
>=20
> On Tue, Nov 28, 2023, 12:21 Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Sat, Nov 18, 2023 at 02:05:19PM -0700, Simon Glass wrote:
> >
> > > At present bootstd requires CONFIG_CMDLINE to operate. Add a new
> > > 'programmatic' boot which can be used when no command line is availab=
le.
> > > For now it does almost nothing, since most bootmeths require the
> > > command line.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > Overall, this seems fine. The only ask I have really is, can we think
> > about how to handle both this case and the case handled by
> > cmd/bootmenu.c in a common fashion? To me, one is "show a menu of boot
> > options, based on env variables" and one is "show a menu of boot
> > options, based on C code" and the "show a menu of boot options" should
> > have a lot in common.
>=20
> I had not thought about providing a menu with prog boot.

I guess I missed how there wasn't a menu with this series and conflated
that with one of your other series.

> Could we drop this patch from the series for now and apply the others? I
> would like to finish and send the follow-on

I didn't see any other feedback so yes, I'll be applying this soon'ish.

--=20
Tom

--5nd/4s7F0Z3GTloR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVmWRIACgkQFHw5/5Y0
tyx4jgv+IgL9jCfiu/MkavOsv9uqdR+0mFBF4PedJHzhGO/bbPaM9UvKuFJV8GVk
MOdFMlFaDjts/Agc9MTEF1WfChMKGgwp16uJQC+2WlGwdjMkzzh7Eqis17Bx9ovO
XXvcflscFIf2SAo+HKpSGdBvBksgswN14t0/Xy2g/Q8xCq/5BGoNAkTPVnG7cPfn
98iKhpY6ceqFUDMTDLYWMH5qwb9LY74Y5U5IZIkbfm5ZhmC34uFa5wQwxkBlBQVh
Po0zlejYEacwaPfyxFQmSr0QBXDE/CwxOn8k4ei9lEuZt2ehq++5Q71tLI8GFe42
Rjyq+0Gvv5mD0N0Sb5Ex/KeIe4qwlWOm8NLl1ZXKQWjpjJuBdpx+7gjRG7UWavWp
uTzXyCQlNCUDbFitEAUmRsfNTHWD6SyuBOCgqzAcx2qKc9/USm4BLT6yc9BiRHrd
xwQdJ1sO4mAflmwciTasC2l9DdemRMcUcWMIpTQ+H4yUk9JPvOrtlZEO0TNUQkCp
mjckYpEh
=XPR6
-----END PGP SIGNATURE-----

--5nd/4s7F0Z3GTloR--
