Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33950C3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 14:43:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF5CB829E4;
	Mon,  5 May 2025 16:43:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gTKZmiSe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FE81829A1; Mon,  5 May 2025 16:43:26 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92A7A82977
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 16:43:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2da73155e91so983109fac.0
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 07:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746456202; x=1747061002; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FTAVDjF0JTL2+QF+Sf89UlETLSbTUMe3VWgcX2yUX+k=;
 b=gTKZmiSesJ8FIxdKc0NdlFM9Bj7hDXEmCI02xLMXXL3Gxvb9Ze84nMWRH+1J7G61NK
 I3cG3N3ddpxpWI2alSQHHATvVJMTda9BK2Js/ai6P6HZZbNXS+0HpXmP5n7kXPz+5Mml
 VyuxNAj8PeXf0GLP6KBkWleLXAIHjPii81yXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746456202; x=1747061002;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FTAVDjF0JTL2+QF+Sf89UlETLSbTUMe3VWgcX2yUX+k=;
 b=SJCf8AeqWdIiQyy07dRDA+NWiBryU4RJlVxyGApl4BXZ7uLuyAOxZ/AmQTYeaOZziv
 tPcoFrIrYQfvLuSJSqYKzksC5U7RdWPg5XvNQNUeGS9rLsswU3Ru2rIN/nOfKTXJK053
 wiJquQ8qEF7ANP3M2fhwU09wMekGXzk5x++9jW9Ov0YaFjuGQ4f+FYkPVnufuF+vIyDS
 uFNVFtKm1vjfzBB8pcNDvI/evqnKSsNj0vIwdEH1qspaTCVACZjcw5/SrwsfBOxJprzb
 xPZxJQxYtEX3arMFO31ddCBoxpt6MchpftFPBE8k2nnqwnDMrblvCSRzBX4xqTkUKXgR
 w+0w==
X-Gm-Message-State: AOJu0YxQ2li6B8FXM+yTTmYpQ5YDJ2YBPzkZ0HKDvsQmJsrYDu4Lk+lX
 yjFvugNckaV6wXx1g8e2yNPZSSJ8aG9bcXekyaqDSgzr9x31azVeZUy2L3orJpw=
X-Gm-Gg: ASbGnctX0bOqwfw5aqtjq306mzBSHUbDrwuIFHy6h7UWq8h+dRa35Rn3AVSJQxMF1zf
 8SS5T38iWZ3fiLh8OO9lawBsiDQvTgUm9s1UIXaXLJEYz4pHGg31+jbAEcBjzvgmXLB96H3dMjT
 1DJRvtQHbqw6x9HnmJMbodZNnR4roZ4KKm2pthHBm85tMx7+72usQsfFUxY5pFlLnDcqZB87Ydh
 Cp2ri88RYwkVWgKwDtZLjfJalrGi2FXrdNODf5J0d7HrX/DzJjMT3ajqVvKtc1WiSru+nCccov5
 yzTrIcXygNp/b+ypl3BXtTVU7ycN7refJki2sDWkuqln8b3ynmZicuAdRe1rOKYLChI2UMrAAEz
 Z5w==
X-Google-Smtp-Source: AGHT+IHtHN08r8SsUVzuTzEcSmn+BL+lF2ofA8lear57aZ6cNRHVt/e1U1nYMdKHslJ9dSYluyNPQA==
X-Received: by 2002:a05:6871:338b:b0:29e:67cd:1a8f with SMTP id
 586e51a60fabf-2dae864266emr3975287fac.37.1746456202287; 
 Mon, 05 May 2025 07:43:22 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2daa0ed89aasm1960231fac.17.2025.05.05.07.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 07:43:21 -0700 (PDT)
Date: Mon, 5 May 2025 08:43:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Oliver Graute <oliver.graute@kococonnector.com>
Subject: Re: [PATCH v2 02/22] congatec: Include env.h to permit reading the
 environment
Message-ID: <20250505144319.GA5430@bill-the-cat>
References: <CAFLszTirfZExTrcmNWZrjbaz0Av5VCCq6q1iLwoxCdG2KrmDVA@mail.gmail.com>
 <20250501153316.GH1261075@bill-the-cat>
 <CAFLszThcmQYqXO8rqiYKS-1TdyXcTbfTuaOTa3W8vWMTzKn-YQ@mail.gmail.com>
 <20250502140649.GQ1261075@bill-the-cat>
 <CAFLszTjqhnJNvzRUx5UD0ibSOnu+fFUCJa8CUDrTYy7vw1cjyw@mail.gmail.com>
 <20250502150429.GV1261075@bill-the-cat>
 <CAFLszTgKn9pbDs365Vztj+-gpcu=PUx5W2dRzpSS=qLdgD6nhw@mail.gmail.com>
 <20250503163035.GC1261075@bill-the-cat>
 <20250503163704.GD1261075@bill-the-cat>
 <CAFLszTiQ+TOTEa_qV1S4WBGYzPT0=AuF2-4_oDfZgZZjbjM5Ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PDg7tNUf/1yNyLu2"
Content-Disposition: inline
In-Reply-To: <CAFLszTiQ+TOTEa_qV1S4WBGYzPT0=AuF2-4_oDfZgZZjbjM5Ag@mail.gmail.com>
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


--PDg7tNUf/1yNyLu2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 03, 2025 at 03:27:50PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 3 May 2025 at 10:37, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, May 03, 2025 at 10:30:35AM -0600, Tom Rini wrote:
> > > On Fri, May 02, 2025 at 08:10:30PM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Fri, 2 May 2025 at 09:04, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Fri, May 02, 2025 at 08:52:37AM -0600, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Fri, 2 May 2025 at 08:06, Tom Rini <trini@konsulko.com> wrot=
e:
> > > > > > >
> > > > > > > On Fri, May 02, 2025 at 07:11:56AM -0600, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Thu, 1 May 2025 at 09:33, Tom Rini <trini@konsulko.com> =
wrote:
> > > > > > > > >
> > > > > > > > > On Thu, May 01, 2025 at 09:04:45AM -0600, Simon Glass wro=
te:
> > > > > > > > > > Hi Tom,
> > > > > > > > > >
> > > > > > > > > > On Thu, 1 May 2025 at 08:06, Tom Rini <trini@konsulko.c=
om> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Wed, Apr 30, 2025 at 07:04:27PM -0600, Simon Glass=
 wrote:
> > > > > > > > > > > > This file reads from the environment but does not i=
nclude the correct
> > > > > > > > > > > > header. Update it.
> > > > > > > > > > > >
> > > > > > > > > > > > Drop the unnecessary config.h while we are here.
> > > > > > > > > > >
> > > > > > > > > > > Are you sure about that? It was explicitly added in c=
ommit
> > > > > > > > > > > ab61cc7d98f6 ("board: congatec: Remove <common.h> and=
 add needed
> > > > > > > > > > > includes") probably because of CFG_SYS_... usage.
> > > > > > > > > >
> > > > > > > > > > Well I assumed it wouldn't build if it had it, but perh=
aps that is
> > > > > > > > > > incorrect? I understood that CFG_ things had to be valu=
es and you
> > > > > > > > > > couldn't #idef them?
> > > > > > > > >
> > > > > > > > > The cases where in that series I added config.h were for =
good reason,
> > > > > > > > > either failure to build or tricky size change reasons. Al=
l were
> > > > > > > > > intentional. An audit-and-remove of config.h would be it'=
s own series as
> > > > > > > > > yes, there's perhaps not the need now as whatever complex=
 chain was
> > > > > > > > > unwound.
> > > > > > > >
> > > > > > > > Oh dear, OK. I'll respin the series.
> > > > > > > >
> > > > > > > > Hmm but I see you have sent a series that does some similar=
 tweak[1].
> > > > > > > > What was the goal there?
> > > > > > >
> > > > > > > I fixed your problem. Please don't bother re-spinning this se=
ries, it's
> > > > > > > not clear what problems it's solving correctly.
> > > > > >
> > > > > > OK thanks. The problem was trying to include net.h in include/e=
fi.h:
> > > > > >
> > > > > > https://patchwork.ozlabs.org/project/uboot/cover/20250501010456=
=2E3930701-1-sjg@chromium.org/
> > > > >
> > > > > Adding headers to headers needs extra care (so that we don't end =
up with
> > > > > massive implicit include chains).
> > > > >
> > > > > > So long as that works, we're fine. Having said that, even if it=
 were a
> > > > > > problem, we could always refactor things to put the Ethernet de=
cls in
> > > > > > a separate header.
> > > > >
> > > > > Yes, if there's some problem down the line then some refactoring =
is
> > > > > likely the thing to look at, not adding more headers to C files (=
the
> > > > > right path is to unwind the header chain and fix C files, your se=
ries
> > > > > doesn't remove env.h from any header).
> > > >
> > > > I hope we haven't got confused here.
> > > >
> > > > My series removed env.h from being *transitively* included. I had to
> > > > add it to C files due to that.
> > >
> > > Yes, which may or may not be helpful. A transitive include in a C file
> > > is not terrible, otherwise many files will have 20+ includes. A
> > > transitive include in header file, which in turn pulls in another whi=
ch
> > > pulls in another, is a problem. And the header should be unwound and C
> > > files then fixed.
> > >
> > > > Your series doesn't help with including net.h in efi.h - you can try
> > > > that and see that it still fails.
> > >
> > > Perhaps I took it out too quickly then, I'd have sworn I build sandbox
> > > with that change added.
> >
> > Yeah, I guess I removed it too quick and missed fixing
> > drivers/usb/gadget/epautoconf.c still, along with whatever the right
> > answer is for unwinding the exfat oddity. Likely seeing what the pain is
> > over using the normal byteswap headers instead.
>=20
> OK, are you thinking of taking a look at that? Or do you think it
> would be better to change exfat to use the linux/byteorder stuff
> (which I somewhat prefer)?

Yes, I would like to hear Marek's thoughts on changing exfat to use the
normal byteswap functions.

--=20
Tom

--PDg7tNUf/1yNyLu2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgYzn8ACgkQFHw5/5Y0
tyw7qQv/RwmEWGfd2+GpeGPlVZhnhu4PtlfsDiULOxjLIKxdrOyAi7IkCSQnzryx
zXO9RtLKhoWmhRW4Sd3y7o3TEoNUWKmCGKBI+Lgfgd+AEiuhHJdEhbpZMEy62nbx
lAMFWXzx+Dupi5qF0mTSxNhVEorGXIM9xRnxxMqg6cVmibJIPOsrvm9XWmzgRlSz
KDn0T/xVh4WFllWfa4DHVAGDFwQWg1xYj1iHkGcfsA3Y0i8o06eCcHDqHKSKDrDX
nK54OrJf2KVUVvHywOHd7+kCLEjgKnnuekFtVslfRa0mOu+XKCVJfo+kbA/7V/D7
papBYNsl3yucwU3/HfBD7dZ2KkewPErXj1o787owc2W5ND7D33kfRclcnDfSugKY
6rSBPn/qoBPUkpErSsb89dhTOC+9PamMucQTY90i8gECvCWDH2XeDsHGJmGIETNI
3yLDrtC//x7VTxZ/OKjW5qGf7MPNbSjFVCw0qA+Je5qhUme7uac2378+7uJzmYRx
j7Il8Zr1
=PVMG
-----END PGP SIGNATURE-----

--PDg7tNUf/1yNyLu2--
