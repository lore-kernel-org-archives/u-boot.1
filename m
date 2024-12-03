Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF75EE74AD0
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 20:07:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3790889048;
	Tue,  3 Dec 2024 21:07:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MJiYm2DM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DB0088FB5; Tue,  3 Dec 2024 21:07:56 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E7B489048
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 21:07:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-4668486dec2so43161961cf.3
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 12:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733256472; x=1733861272; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zdeEAOA2/kLmten608SBYSi0TPunIPS9muAPh2LTnEw=;
 b=MJiYm2DM6WQIMIN/5kcwrBlGob0DaaMdBGLuM88jZ0ZOWmF34aPVgj48vrcZzwNldk
 4PzRAtF0avNmMv2etZ3yj1w/nn4/GbczOXyEA/eCZnzZhrn4g7yErAx5BhOuD9liLqkQ
 2SoQSMNKKPL43XMsYhRnT3CXYpykVLHotP5W0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733256472; x=1733861272;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zdeEAOA2/kLmten608SBYSi0TPunIPS9muAPh2LTnEw=;
 b=vfirL1dAD2P6+PWXUK7KZHkf/eWlxNu7pexiMKsilm6ReejtP3IcVSAjCJLXcPy7/P
 A5q4fZ0gfX/HcNkh8+ppIfwxd7LqHuP9+OMhoAxf/OjE3V2FjzCTPys7q2kG5z4BS9gP
 FGdnHZmhN73HQOPkbzpkdVfc6fiYKVPYKj9KCIV6+bq2VKPCbn3I5LPjndrfLbZ2TIFW
 1KW97GMs+8sunxzcJjdEswNcAwAmuuPRktx00yj2pROm5Of+5V4V/zNBY26o0/DcXRqv
 GtRupiYzS5cxD56MlQc3UqGrS0mxnzHvzVEYfuDGiYJqQXBoiDzPquvmeAzE2S4yBdRl
 aaYA==
X-Gm-Message-State: AOJu0YxZE09CHQ3zJsOzh5o5E8XeF2cJNZwvO2vYrZFHBbVY+xzRY4bl
 +QOEsqsApke9MIpHl1xyszf4A+R8HZR/3ieeomVa/nuuFPiZeBQlSIUMb7Q++BU=
X-Gm-Gg: ASbGnctgUlVsBKcv5vJOSSUmga3xzlLsBvErA8l8L+JBAGq002CONBAP/bStltHT74o
 gUgy3Agubyl8UkVwNym6mHpKhl6ZjeXsVYc4nEEMxi7fvGb8zuWRiATmxmzX2zRrgKBFmAibEqg
 z0Ep03cVxawo0nZw3cjxUa6+FrwyXoGgw7h6wowSg8eT6fQG/szfiklsfL7BEZNUg0Ye5bDHuX5
 c/GOnO103/UMRdrDRl6OXapLMgkgjzMgdY1bRdZy8iD1Pahkw==
X-Google-Smtp-Source: AGHT+IED7/ChaE63IYD6HkP+hyqhnBhRekhnDtdk4p7hsjiqc1RjA6zfsf8EWfrXjf0E4+/6+3rRMQ==
X-Received: by 2002:ac8:574d:0:b0:466:9bc4:578 with SMTP id
 d75a77b69052e-4670c0bec64mr48173951cf.22.1733256471884; 
 Tue, 03 Dec 2024 12:07:51 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-466c421dbe1sm65702191cf.54.2024.12.03.12.07.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 12:07:50 -0800 (PST)
Date: Tue, 3 Dec 2024 14:07:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Marek Vasut <marex@denx.de>, Paul Barker <paul.barker.ct@bp.renesas.com>,
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 mason1920 <mason1920@use.startmail.com>
Subject: Re: [PATCH 5/8] fdt: Allow the devicetree to come from a bloblist
Message-ID: <20241203200746.GA2457179@bill-the-cat>
References: <20241201144240.1664398-1-sjg@chromium.org>
 <20241201144240.1664398-6-sjg@chromium.org>
 <20241201164810.GT3600562@bill-the-cat>
 <CAFLszTiLxRdLZb3mykH6L5DLQwL2N+-TiKAzH+aDtGpWa4O46g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="H/0CG6Y62L2wu7ny"
Content-Disposition: inline
In-Reply-To: <CAFLszTiLxRdLZb3mykH6L5DLQwL2N+-TiKAzH+aDtGpWa4O46g@mail.gmail.com>
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


--H/0CG6Y62L2wu7ny
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 03, 2024 at 12:45:12PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sun, 1 Dec 2024 at 09:48, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Dec 01, 2024 at 07:42:33AM -0700, Simon Glass wrote:
> > > Standard passage provides for a bloblist to be passed from one firmwa=
re
> > > phase to the next. That can be used to pass the devicetree along as w=
ell.
> > > Add an option to support this.
> > >
> > > Tests for this will be added as part of the Universal Payload work.
> > >
> > > Note: This is the correct way to deal with bloblist, since it allows
> > > boards to choose whether they want to use the devicetree from there, =
or
> > > not.
> > >
> > > Link: https://patchwork.ozlabs.org/project/uboot/patch/20231226094625=
=2E221671-1-sjg@chromium.org/
> > > Link: https://patchwork.ozlabs.org/project/uboot/patch/20231228133654=
=2E2356023-1-sjg@chromium.org/
> > > Link: https://patchwork.ozlabs.org/project/uboot/patch/20231228194725=
=2E2482268-1-sjg@chromium.org/
> > > Link: https://patchwork.ozlabs.org/project/uboot/patch/20240104014919=
=2E413568-1-sjg@chromium.org/
> > > Link: https://patchwork.ozlabs.org/project/uboot/patch/20230921015730=
=2E1511373-31-sjg@chromium.org/
> > > Link: https://patchwork.ozlabs.org/project/uboot/patch/20230830180524=
=2E315916-31-sjg@chromium.org/
> >
> > You should
> > %s#https://patchwork.ozlabs.org/project/uboot/patch#https://lore.kernel=
=2Eorg/u-boot
> > all of these Links, aside from shorter, it's on much more broadly
> > distributed infrastructure. And this is a general comment as well.
> >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > >  common/bloblist.c                  |  1 +
> > >  doc/develop/devicetree/control.rst |  3 ++
> > >  dts/Kconfig                        |  8 ++++++
> > >  include/fdtdec.h                   |  3 +-
> > >  lib/fdtdec.c                       | 44 ++++++++++++++++++++++------=
--
> > >  5 files changed, 46 insertions(+), 13 deletions(-)
> >
> > The rest of this, I need to think on.
>=20
> It sounds like you have thought about this, and come to the conclusion
> that the reverts are not going in. So, for simplicity I'll leave this
> patch as is and make a note to use 'lore' in future. I wonder if there
> is an easy way to convert between lore and patchwork?

Both lore (always) and patchwork (for a while, maybe a year or more
now?) use the message-id in the URL, at the end even.

--=20
Tom

--H/0CG6Y62L2wu7ny
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdPZQ4ACgkQFHw5/5Y0
tywT9gv8CeSVVzzHuynxeH/HSQkuyJmzCxcLS9ZLW+Y36lEVeCKnB/MuApI+gYAP
8YE0ncXStJOT0QkF2hVWKk7hE1vBswn3GaC9AVE+nLwKF4eToPFxLhKj7Q9VIez3
GxWoplFBWL3+AD+tU3Ma5kS0P55XQHSQmHb53WDM8gP3/rUpqJb4iMrbqBMXApP+
WBNlNNFGuR0QTC9vmW+rZKXTfOSr7t6WDBVOPAzS/1463YwmXT6OKSHfmeQK6bZ5
3tggjtNMHxHy+Qy/SUECWA/qyaPr0LnUvwTgRe9WSoAFh66Jf3a0/y7i0oCYlfoe
sSlQ3eiNvSF3LnTdTkM788Y/9lSrhk3PkNmQgHn+LoMhQ2aObuFxvznYI16EKU6X
4VAO3xI1or/jCkETiAVVQ6POLywidHEVmUdi464Ju0qbgJ3YKPKp3xEpSn80a5kZ
EScOVojapT/R3KTqyQQ8RVRVKDPIPTqlfweoNrs0fLAVuszAFLEoJ2FkzIkQzYIo
yFJpRk7b
=LuZs
-----END PGP SIGNATURE-----

--H/0CG6Y62L2wu7ny--
