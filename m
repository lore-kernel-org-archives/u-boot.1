Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90A0CD4F4A
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 17:30:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 148B383EF9;
	Mon, 18 May 2026 19:30:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F5HHx52b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A51F584119; Mon, 18 May 2026 19:30:09 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3297783AA9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 19:30:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7dcd17e19b6so1383363a34.1
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 10:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779125406; x=1779730206; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UBZGL+wdKIODP1h6W7B8YQdYc65GeTvm8EYxEDUsrpk=;
 b=F5HHx52bHmv7qJg1221rPGZklc6lZ+5lPrFSqmtcYV17FXBCCRToVkkkN94h+cZrO/
 8fQnpBLtVBlURNksF/2HA7A6fTC88mTstW9klN0VR6iAk3pmoXWXNY7w9YYzxEq4TDzC
 JnhjYIrRJ48oLvWlA518fsVBMXmRb3PCRRyZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779125406; x=1779730206;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UBZGL+wdKIODP1h6W7B8YQdYc65GeTvm8EYxEDUsrpk=;
 b=fsyp0wXLNXBB26RURTWNwHEdxXTuGT4bdkkbigg+fKzewzpyBjb0KaG8oQ7rqDP8NG
 byS7BSMJzPILR9N1UJ/IYdrUf/aD4l6Pni830Bia2iMowzoYCiMpXuSLZKr5l7d843St
 JWL7lJoP5uJ40cweb817zm2dAu7xA+ohOOaQMf8w4obTOIK5Im72oB8Vr282QR5gsoeT
 fZO8WsR/b215636QWDILE6aTbNudsOHF4chrV7CmwuSjZ1xXf4XYenJ4cyM8zDUmD528
 BDYBMmbpZUDPcqIEZ48AYtyGPLvLjUfKiEiSjUKKJ4UkQZY3/OioGexSiYMLgr6IsBxy
 rBrw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ZLxg/OwxewQCBbDol6FKxfmTNIxUD64XBCePpqYDM8VkJ9rp/E4OLFPNIu8UljicrMkLu9ag=@lists.denx.de
X-Gm-Message-State: AOJu0YxIFrC0l3qzPzexIbdFJP8pVVSdBj6eH2862t8qrG+f/eoW0FRG
 pldTcoavmNI3yQROWQdP8XOt70xx0Vrwt//8anTJncsWUOeXtezjgldeQyAKPdIjaG0=
X-Gm-Gg: Acq92OGgoTlIf8SgVlT8ggIn2rAbU4Zs7zNlSmmmGDFg5D2OiPcF8kgzc22o53tZ6HM
 9epb/rw3sLgzlEqeg6dbEy5tImdWAk3YDDjAZtCWNrcnWm40OGIMhTuPFRRYv/1xnrkuk8C/fR0
 w9pnTQeoZFRfdDqKeSl42fUWkj/rJiL8noCqiMgdhrnaprIl/w54UEjQn4/SiMZDKunLjeMO6uN
 9DkUw7p7l0qPFj0f28Boae+QTQg26KEod8Z+CpU5Au8EAdtd11IipKmfm/VajTDGQbJXO4Bu/KJ
 dOIwr8CVv1daZypQ22fPFi+NHef1phAODoLEsY1d1OzMt4VFW7ZIse6RMRV/MivlD8yVbNcMr/j
 bhjfZDaR+z2QfFbCdWlxHNPpUr8065sVSNVC8lUWtXkT0pF+4ie/J6Krc5+Q9xZiy5pc2soEp3E
 OWin+jRyNfYPRoCLIuEZmhAlZxbYu2C5ZwrBFGb3WgVb5DLPTEgPaFvrGZFa8mxqg4Zq6LVsfrS
 E/Qi5kbg8W3I50MM1PKVHuCpBKXmoiLh78MmFA/11kIAWujwuE=
X-Received: by 2002:a05:6830:6f48:b0:7dc:d7e8:cb37 with SMTP id
 46e09a7af769-7e4fa0657a5mr12873343a34.21.1779125405644; 
 Mon, 18 May 2026 10:30:05 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b8203a3sm7971368a34.11.2026.05.18.10.30.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 10:30:05 -0700 (PDT)
Date: Mon, 18 May 2026 11:30:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: nm@ti.com, Wadim Egorov <w.egorov@phytec.de>,
 ilias.apalodimas@linaro.org, marek.vasut+renesas@mailbox.org,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, upstream@lists.phytec.de
Subject: Re: [PATCH] Makefile: binman: Search board directory before srctree
Message-ID: <20260518173002.GS1858239@bill-the-cat>
References: <20260515054327.1033466-1-w.egorov@phytec.de>
 <20260515145400.GB1858239@bill-the-cat>
 <CAFLszTid-e+NWrFxoorfrUT23_mztUZP8FRbmT9FJ55M8A+FXA@mail.gmail.com>
 <20260515160256.GF1858239@bill-the-cat>
 <CAFLszThfUMe=67xwzbv6TvugH3iCOO=-EoYk6oUshKru-wpDQw@mail.gmail.com>
 <20260515182441.GI1858239@bill-the-cat>
 <CAFLszTjHaqck4gVDSiBw0M9V3yZLzUa8+EjaW94G9JcO=-Ny8Q@mail.gmail.com>
 <20260515184434.GJ1858239@bill-the-cat>
 <CAFLszTj616BX3ppdVLeR1mcRnXLJ41uUpQkC7gY0NOSn2ffkbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MDDuWk/1F/xYHICN"
Content-Disposition: inline
In-Reply-To: <CAFLszTj616BX3ppdVLeR1mcRnXLJ41uUpQkC7gY0NOSn2ffkbw@mail.gmail.com>
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


--MDDuWk/1F/xYHICN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 17, 2026 at 04:52:10PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 15 May 2026 at 12:44, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, May 15, 2026 at 12:32:30PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 15 May 2026 at 12:24, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, May 15, 2026 at 12:13:50PM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Fri, 15 May 2026 at 10:03, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Fri, May 15, 2026 at 09:35:10AM -0600, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Fri, 15 May 2026 at 08:54, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Fri, May 15, 2026 at 07:43:27AM +0200, Wadim Egorov wrot=
e:
> > > > > > > >
> > > > > > > > > A file like rm-cfg.yaml accidentally left in the source t=
ree root
> > > > > > > > > shadows the board-specific copy. binman builds the wrong =
YAML, the
> > > > > > > > > resulting rm-cfg.bin may match a different SoC, and we en=
d up with
> > > > > > > > > the following error:
> > > > > > > > >
> > > > > > > > >   k3_system_controller sysctrler: k3_sysctrler_start:
> > > > > > > > >       Boot Notification response failed. ret =3D -110
> > > > > > > > >
> > > > > > > > > Move the board directory ahead of the srctree root so tha=
t the
> > > > > > > > > most-specific match wins.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> > > > > > > > > ---
> > > > > > > > >  Makefile | 2 +-
> > > > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > > >
> > > > > > > > > diff --git a/Makefile b/Makefile
> > > > > > > > > index 552328f9f2c..1ec29dfe0be 100644
> > > > > > > > > --- a/Makefile
> > > > > > > > > +++ b/Makefile
> > > > > > > > > @@ -1682,7 +1682,7 @@ cmd_binman =3D $(srctree)/tools/bin=
man/binman $(if $(BINMAN_DEBUG),-D) \
> > > > > > > > >               build -u -d $(binman_dtb) -O . -m \
> > > > > > > > >               --allow-missing --fake-ext-blobs \
> > > > > > > > >               $(if $(BINMAN_ALLOW_MISSING),--ignore-missi=
ng) \
> > > > > > > > > -             -I . -I $(srctree) -I $(srctree)/board/$(BO=
ARDDIR) \
> > > > > > > > > +             -I . -I $(srctree)/board/$(BOARDDIR) -I $(s=
rctree) \
> > > > > > > > >               $(foreach f,$(of_list_dirs),-I $(f)) -a of-=
list=3D$(of_list) \
> > > > > > > > >               $(foreach f,$(BINMAN_INDIRS),-I $(f)) \
> > > > > > > > >               -a atf-bl1-path=3D${BL1} \
> > > > > > > >
> > > > > > > > Why do we need to look in $(srctree) itself?
> > > > > > >
> > > > > > > See for example:
> > > > > > >
> > > > > > > arch/arm/dts/k3-j721e-binman.dtsi:308:  private-key =3D
> > > > > > > "arch/arm/mach-k3/keys/custMpk.pem";
> > > > > >
> > > > > > That's not great, I'm sorry I missed it at the time. I wonder h=
ow easy
> > > > > > replacing that key is with a non-dummy key. Hopefully it's done=
 in a way
> > > > > > that doesn't encourage checking private keys in to repositories=
=2E.
> > > > >
> > > > > Typically we would use an environment var passed in from the Make=
file,
> > > > > as we do with BL31, TEE, TI_DM, etc.
> > > > >
> > > > > >
> > > > > > > Also, people sometimes put files in the source tree, e.g. BL3=
1 images,
> > > > > > > in the hope that they will be found.
> > > > > >
> > > > > > That's also a bad practice and what BINMAN_INDIRS is for.
> > > > >
> > > > > Yes, but that came quite a bit later with the bintool stuff (2021=
).
> > > > >
> > > > > Anyway, with a bit of work I believe we could drop the source dir.
> > > > > Would you like to look at it, or should I?
> > > >
> > > > Well, the first step would be getting some more feedback on how peo=
ple
> > > > override some of these files for example. Even more environment fil=
es
> > > > seems like a bad idea and I'm not sure what BINMAN_INDIRS can't cov=
er
> > > > today.
> > >
> > > Assuming you mean 'environment variables', we do need the actual
> > > filename, not just the directory. We could have default filenames for
> > > each entry type, I suppose. Some do already.
> >
> > Yes, I think moving that way is the right direction. I was going to use
> > -scp-path=3D$(SCP) as an example of something to move away from, but it
> > looks like that's already being done in a way BINMAN_INDIRS should
> > handle.
>=20
> Yes, the idea is that '-a scp-path=3D$(SCP)' tells the scp entry-type
> the filename to use. I'm pretty sure we could update the tests to set
> that entry-arg, so we don't need the source dir in the path.

But we shouldn't need anything at all if BINMAN_INDIRS is set to include
that path. We currently just have "scp.bin" in the dts file. Adding
-scp-path was a solution that made sense at the time, but as we've
needed to deal with more blobs, we added a generic solution, and now
just need to deprecate and remove the original per-blob solution.

> But in any case this patch is correct for now.

Agreed.

--=20
Tom

--MDDuWk/1F/xYHICN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagtMlwAKCRAr4qD1Cr/k
CotAAQC1vyjYx0xYIHFQ8gOki+3xEMVK6Q8EvLKU8w9DDLSPewEA3rkWX6KKOM4C
ov07TzLTuzsrkuvvrPMb0O4NxBBnAQU=
=7wZQ
-----END PGP SIGNATURE-----

--MDDuWk/1F/xYHICN--
