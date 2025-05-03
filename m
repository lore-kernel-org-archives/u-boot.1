Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE9EC369C2
	for <u-boot@archiver.kernel.org>; Sat,  3 May 2025 16:30:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE3B38210A;
	Sat,  3 May 2025 18:30:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F9nwDqMm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 018238214A; Sat,  3 May 2025 18:30:43 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E55F81FAB
 for <u-boot@lists.denx.de>; Sat,  3 May 2025 18:30:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-72c40235c34so884164a34.3
 for <u-boot@lists.denx.de>; Sat, 03 May 2025 09:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746289839; x=1746894639; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=t+ZNXglZwc9qJQqNN4+ZL0Wac+zizvzBMT5q5S9yxM4=;
 b=F9nwDqMmgU7vNyPEtod0G84iPTuVXx13ZZYft2shUrwx5SsVqT4kpkaItE/rzfNtT+
 QQkgu5406gZVIpa7KtFRr3E75GCDpsYCwhVcyEbG73w2hBQqEufdl304iyxchiCWYb7K
 YjvdsYA3nBasUFUcqLmpzbBi9X6L0FyB7uBBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746289839; x=1746894639;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t+ZNXglZwc9qJQqNN4+ZL0Wac+zizvzBMT5q5S9yxM4=;
 b=FzEdpZlZG/R12YDLHnMUu07fUsaGgpceXRNvoXvwgc2Sjuxv/tyKQUdSi5eZe+nP2h
 v8gi+jW9mmhVFWVM9QFzSoEPNfKscbllhl1WCdX7sCVs7p5RM4J3kFqcc5UO639XfJUa
 fEOQWEtWMnyLv0bUgzvbzVHWDEpGP4TbflWdgFVP24A0HFnKV5eR6+6JoHUKqWldyS79
 XqYR2vf//cOeEMEMA0+dDyIUpMHAmT6Lb+rKm2hKhER8LbUgYnFf3iCsj1k6qXOCx/5B
 RbQwRN0oXueJnUKUbVyvt6o3/GI0uLLBXXplSu61F4JrP3rCHv/mHQY7SJgRlUsT+1Cp
 5aew==
X-Gm-Message-State: AOJu0YxfeHf1GwE9Wv2/Pvww95HGzrQHAwWqTQQZFK4NdRTgOSs+3ISn
 f+FFsSdge+9rpEVFAR5na3pDuc3HaXklSpng3KZrpV3w64nzm9Ll4nad/TwGFEU=
X-Gm-Gg: ASbGnctz4iECe/YhXu3XNM2dy8Jq+F5wgvnJ0hmR5neRrq/QfPHUY0fR2IQ8iJmSr4G
 quXXFHmnEnX1fcxdzJUoR9Pn+G4o/1f+kQJtgDPhsSVReE1Rr4IB46vIaNU6Om6cYAif087d4Uw
 i6x51wBYkPBHMcA+Nl9m+GpN5RzpZir3VPaBYzumgdsyvbASmXvrPC2w4RM/BHkXwMxd0SOsLcX
 IPZjnssLByU7zl7hmtno8gbTm+A1ww0+StijjYLl0Onpdhiq65sA4yKjhLF7l2xNpRM+EBLWjUt
 yZszwo6QuImrM/+z5JRmOlVRMo8sr8He7770XpX/AjMJCL4tAAXR7B4VTe8HArwHNArmP9pMQ2h
 tPw==
X-Google-Smtp-Source: AGHT+IHsgIMrcAnNTn5PVEbPkQng3riR0NaCLNadDRt63may/il86M6PCVR3p0xGGDV+qogn/bDdTg==
X-Received: by 2002:a05:6830:661b:b0:731:d1e5:7c5d with SMTP id
 46e09a7af769-731ead8e484mr920056a34.9.1746289838800; 
 Sat, 03 May 2025 09:30:38 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-731d350943bsm893191a34.61.2025.05.03.09.30.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 09:30:37 -0700 (PDT)
Date: Sat, 3 May 2025 10:30:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Oliver Graute <oliver.graute@kococonnector.com>
Subject: Re: [PATCH v2 02/22] congatec: Include env.h to permit reading the
 environment
Message-ID: <20250503163035.GC1261075@bill-the-cat>
References: <20250501010456.3930701-1-sjg@chromium.org>
 <20250501010456.3930701-3-sjg@chromium.org>
 <20250501140617.GD1261075@bill-the-cat>
 <CAFLszTirfZExTrcmNWZrjbaz0Av5VCCq6q1iLwoxCdG2KrmDVA@mail.gmail.com>
 <20250501153316.GH1261075@bill-the-cat>
 <CAFLszThcmQYqXO8rqiYKS-1TdyXcTbfTuaOTa3W8vWMTzKn-YQ@mail.gmail.com>
 <20250502140649.GQ1261075@bill-the-cat>
 <CAFLszTjqhnJNvzRUx5UD0ibSOnu+fFUCJa8CUDrTYy7vw1cjyw@mail.gmail.com>
 <20250502150429.GV1261075@bill-the-cat>
 <CAFLszTgKn9pbDs365Vztj+-gpcu=PUx5W2dRzpSS=qLdgD6nhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nb2dOLxzE97V/nwN"
Content-Disposition: inline
In-Reply-To: <CAFLszTgKn9pbDs365Vztj+-gpcu=PUx5W2dRzpSS=qLdgD6nhw@mail.gmail.com>
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


--nb2dOLxzE97V/nwN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 02, 2025 at 08:10:30PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 2 May 2025 at 09:04, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, May 02, 2025 at 08:52:37AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 2 May 2025 at 08:06, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, May 02, 2025 at 07:11:56AM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Thu, 1 May 2025 at 09:33, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Thu, May 01, 2025 at 09:04:45AM -0600, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Thu, 1 May 2025 at 08:06, Tom Rini <trini@konsulko.com> wr=
ote:
> > > > > > > >
> > > > > > > > On Wed, Apr 30, 2025 at 07:04:27PM -0600, Simon Glass wrote:
> > > > > > > > > This file reads from the environment but does not include=
 the correct
> > > > > > > > > header. Update it.
> > > > > > > > >
> > > > > > > > > Drop the unnecessary config.h while we are here.
> > > > > > > >
> > > > > > > > Are you sure about that? It was explicitly added in commit
> > > > > > > > ab61cc7d98f6 ("board: congatec: Remove <common.h> and add n=
eeded
> > > > > > > > includes") probably because of CFG_SYS_... usage.
> > > > > > >
> > > > > > > Well I assumed it wouldn't build if it had it, but perhaps th=
at is
> > > > > > > incorrect? I understood that CFG_ things had to be values and=
 you
> > > > > > > couldn't #idef them?
> > > > > >
> > > > > > The cases where in that series I added config.h were for good r=
eason,
> > > > > > either failure to build or tricky size change reasons. All were
> > > > > > intentional. An audit-and-remove of config.h would be it's own =
series as
> > > > > > yes, there's perhaps not the need now as whatever complex chain=
 was
> > > > > > unwound.
> > > > >
> > > > > Oh dear, OK. I'll respin the series.
> > > > >
> > > > > Hmm but I see you have sent a series that does some similar tweak=
[1].
> > > > > What was the goal there?
> > > >
> > > > I fixed your problem. Please don't bother re-spinning this series, =
it's
> > > > not clear what problems it's solving correctly.
> > >
> > > OK thanks. The problem was trying to include net.h in include/efi.h:
> > >
> > > https://patchwork.ozlabs.org/project/uboot/cover/20250501010456.39307=
01-1-sjg@chromium.org/
> >
> > Adding headers to headers needs extra care (so that we don't end up with
> > massive implicit include chains).
> >
> > > So long as that works, we're fine. Having said that, even if it were a
> > > problem, we could always refactor things to put the Ethernet decls in
> > > a separate header.
> >
> > Yes, if there's some problem down the line then some refactoring is
> > likely the thing to look at, not adding more headers to C files (the
> > right path is to unwind the header chain and fix C files, your series
> > doesn't remove env.h from any header).
>=20
> I hope we haven't got confused here.
>=20
> My series removed env.h from being *transitively* included. I had to
> add it to C files due to that.

Yes, which may or may not be helpful. A transitive include in a C file
is not terrible, otherwise many files will have 20+ includes. A
transitive include in header file, which in turn pulls in another which
pulls in another, is a problem. And the header should be unwound and C
files then fixed.

> Your series doesn't help with including net.h in efi.h - you can try
> that and see that it still fails.

Perhaps I took it out too quickly then, I'd have sworn I build sandbox
with that change added.

> But as I said, we can move the decls into a separate file.

Yes, that might be the right answer, depending on the problem. I'm not
sure adding more headers to headers is good in general.

--=20
Tom

--nb2dOLxzE97V/nwN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgWRKAACgkQFHw5/5Y0
tyxJWgv7BjRmdLMtq2tYzarIvvc7N4X0qDPRC1XtMaOAYBuIJmawpSAHXWvyZyd+
SHpDVK+QbE79pgiEuFexsWw1TrwtPda4idfEiTtyC0OBadUOCGc7xeH/qfkIQSDK
alQbmL8eZZ6rNdf9AUyZXH7kUu+WNpkjiun8e5pLsCOp72xyNcYUUBP6gmvEjqQg
IbMDsVlaXgzfw3lb9ACZ6R5pHaDylYyB+nL8V4jjNrU0LRF/3mcHH9QdtHVWBw6o
x0YT2mOjYAW1nItGOMJP9DE3Ib8QN4+LwEi0E/Jl82IXTmah9tjZ0Eeovlu5Az9G
pzu5X9AYo9qFr2HDy+5m6b6wHoysyG9YVni42ggnlFpB8r5cEp3pp10Wplp2RGq6
9Za4l1jwPowhwYpIqqrQ8I14uI1aE4NoICOkPCwMkEryrCTJmX2aEWJcmH994R09
xuBzIjJ0uGOAEhriJuFjw16LCRA+8CyrawE0m3iK39G5fHvf5Z96SlY1I3kk6zRt
YpX5wYn/
=7rMm
-----END PGP SIGNATURE-----

--nb2dOLxzE97V/nwN--
